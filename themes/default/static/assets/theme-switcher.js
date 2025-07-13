/**
 * Siru Theme Switcher
 * Provides runtime theme and font switching functionality
 */

class SiruThemeSwitcher {
  constructor() {
    this.themes = [
      'catppuccin-mocha',
      'catppuccin-latte', 
      'catppuccin-macchiato',
      'catppuccin-frappe',
      'nord',
      'dracula',
      'tokyonight'
    ];
    
    this.fonts = [
      'inter',
      'helvetica',
      'open-sans',
      'roboto',
      'lato',
      'georgia',
      'merriweather',
      'playfair',
      'crimson',
      'source-code'
    ];
    
    this.init();
  }
  
  init() {
    // Load saved preferences
    this.loadPreferences();
    
    // Create theme switcher UI if enabled
    if (this.shouldShowSwitcher()) {
      this.createSwitcherUI();
    }
  }
  
  loadPreferences() {
    const savedTheme = localStorage.getItem('siru-theme');
    const savedFont = localStorage.getItem('siru-font');
    
    if (savedTheme && this.themes.includes(savedTheme)) {
      this.setTheme(savedTheme);
    }
    
    if (savedFont && this.fonts.includes(savedFont)) {
      this.setFont(savedFont);
    }
  }
  
  setTheme(theme) {
    if (!this.themes.includes(theme)) {
      console.warn(`Invalid theme: ${theme}`);
      return;
    }
    
    document.documentElement.setAttribute('data-theme', theme);
    localStorage.setItem('siru-theme', theme);
    
    // Dispatch custom event
    document.dispatchEvent(new CustomEvent('siru:theme-changed', {
      detail: { theme }
    }));
  }
  
  setFont(font) {
    if (!this.fonts.includes(font)) {
      console.warn(`Invalid font: ${font}`);
      return;
    }
    
    document.documentElement.setAttribute('data-font', font);
    localStorage.setItem('siru-font', font);
    
    // Dispatch custom event
    document.dispatchEvent(new CustomEvent('siru:font-changed', {
      detail: { font }
    }));
  }
  
  getCurrentTheme() {
    return document.documentElement.getAttribute('data-theme') || 'catppuccin-mocha';
  }
  
  getCurrentFont() {
    return document.documentElement.getAttribute('data-font') || 'inter';
  }
  
  shouldShowSwitcher() {
    // Check if theme switcher is enabled via config or URL parameter
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.has('theme-switcher') || 
           document.documentElement.hasAttribute('data-theme-switcher');
  }
  
  createSwitcherUI() {
    const switcher = document.createElement('div');
    switcher.className = 'siru-theme-switcher';
    switcher.innerHTML = `
      <button class="theme-switcher-toggle" aria-label="Toggle theme switcher">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
          <path d="M12 2a10 10 0 1 0 10 10A10 10 0 0 0 12 2zm0 18a8 8 0 1 1 8-8 8 8 0 0 1-8 8zm-1-13h2v6h-2zm0 8h2v2h-2z"/>
        </svg>
      </button>
      <div class="theme-switcher-panel">
        <div class="switcher-section">
          <h3>Color Scheme</h3>
          <div class="theme-options">
            ${this.themes.map(theme => `
              <button class="theme-option" data-theme="${theme}" title="${this.getThemeDisplayName(theme)}">
                <span class="theme-preview" data-theme="${theme}"></span>
                <span class="theme-name">${this.getThemeDisplayName(theme)}</span>
              </button>
            `).join('')}
          </div>
        </div>
        <div class="switcher-section">
          <h3>Font</h3>
          <div class="font-options">
            ${this.fonts.map(font => `
              <button class="font-option" data-font="${font}" title="${this.getFontDisplayName(font)}">
                <span class="font-preview" data-font="${font}">Aa</span>
                <span class="font-name">${this.getFontDisplayName(font)}</span>
              </button>
            `).join('')}
          </div>
        </div>
      </div>
    `;
    
    // Add to page
    document.body.appendChild(switcher);
    
    // Add event listeners
    this.attachSwitcherEvents(switcher);
    
    // Add styles
    this.addSwitcherStyles();
  }
  
  attachSwitcherEvents(switcher) {
    const toggle = switcher.querySelector('.theme-switcher-toggle');
    const panel = switcher.querySelector('.theme-switcher-panel');
    
    toggle.addEventListener('click', () => {
      panel.classList.toggle('active');
    });
    
    // Theme selection
    switcher.querySelectorAll('.theme-option').forEach(button => {
      button.addEventListener('click', (e) => {
        const theme = e.currentTarget.dataset.theme;
        this.setTheme(theme);
        this.updateSwitcherUI();
      });
    });
    
    // Font selection
    switcher.querySelectorAll('.font-option').forEach(button => {
      button.addEventListener('click', (e) => {
        const font = e.currentTarget.dataset.font;
        this.setFont(font);
        this.updateSwitcherUI();
      });
    });
    
    // Close on outside click
    document.addEventListener('click', (e) => {
      if (!switcher.contains(e.target)) {
        panel.classList.remove('active');
      }
    });
  }
  
  updateSwitcherUI() {
    const currentTheme = this.getCurrentTheme();
    const currentFont = this.getCurrentFont();
    
    // Update active states
    document.querySelectorAll('.theme-option').forEach(button => {
      button.classList.toggle('active', button.dataset.theme === currentTheme);
    });
    
    document.querySelectorAll('.font-option').forEach(button => {
      button.classList.toggle('active', button.dataset.font === currentFont);
    });
  }
  
  getThemeDisplayName(theme) {
    const names = {
      'catppuccin-mocha': 'Catppuccin Mocha',
      'catppuccin-latte': 'Catppuccin Latte',
      'catppuccin-macchiato': 'Catppuccin Macchiato',
      'catppuccin-frappe': 'Catppuccin Frappé',
      'nord': 'Nord',
      'dracula': 'Dracula',
      'tokyonight': 'Tokyo Night'
    };
    return names[theme] || theme;
  }
  
  getFontDisplayName(font) {
    const names = {
      'inter': 'Inter',
      'helvetica': 'Helvetica',
      'open-sans': 'Open Sans',
      'roboto': 'Roboto',
      'lato': 'Lato',
      'georgia': 'Georgia',
      'merriweather': 'Merriweather',
      'playfair': 'Playfair Display',
      'crimson': 'Crimson Text',
      'source-code': 'Source Code Pro'
    };
    return names[font] || font;
  }
  
  addSwitcherStyles() {
    const styles = `
      .siru-theme-switcher {
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 1000;
      }
      
      .theme-switcher-toggle {
        background: var(--color-surface);
        border: 1px solid var(--color-border);
        border-radius: 50%;
        width: 44px;
        height: 44px;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        color: var(--color-text);
        transition: all 0.2s ease;
      }
      
      .theme-switcher-toggle:hover {
        background: var(--color-primary);
        color: var(--color-bg);
      }
      
      .theme-switcher-panel {
        position: absolute;
        top: 100%;
        right: 0;
        margin-top: 8px;
        background: var(--color-surface);
        border: 1px solid var(--color-border);
        border-radius: 8px;
        padding: 16px;
        min-width: 280px;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
        opacity: 0;
        visibility: hidden;
        transform: translateY(-8px);
        transition: all 0.2s ease;
      }
      
      .theme-switcher-panel.active {
        opacity: 1;
        visibility: visible;
        transform: translateY(0);
      }
      
      .switcher-section {
        margin-bottom: 16px;
      }
      
      .switcher-section:last-child {
        margin-bottom: 0;
      }
      
      .switcher-section h3 {
        margin: 0 0 8px 0;
        font-size: 14px;
        color: var(--color-text);
        font-weight: 600;
      }
      
      .theme-options, .font-options {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
        gap: 8px;
      }
      
      .theme-option, .font-option {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 4px;
        padding: 8px;
        background: var(--color-bg);
        border: 1px solid var(--color-border);
        border-radius: 4px;
        cursor: pointer;
        transition: all 0.2s ease;
        font-size: 12px;
      }
      
      .theme-option:hover, .font-option:hover {
        border-color: var(--color-primary);
      }
      
      .theme-option.active, .font-option.active {
        background: var(--color-primary);
        color: var(--color-bg);
      }
      
      .theme-preview {
        width: 20px;
        height: 20px;
        border-radius: 50%;
        border: 1px solid var(--color-border);
      }
      
      .font-preview {
        font-size: 16px;
        font-weight: 500;
        color: var(--color-text);
      }
      
      .theme-name, .font-name {
        color: var(--color-text-secondary);
        font-size: 11px;
        text-align: center;
      }
      
      .theme-option.active .theme-name,
      .font-option.active .font-name {
        color: var(--color-bg);
      }
      
      /* Theme preview colors */
      .theme-preview[data-theme="catppuccin-mocha"] { background: #89b4fa; }
      .theme-preview[data-theme="catppuccin-latte"] { background: #1e66f5; }
      .theme-preview[data-theme="catppuccin-macchiato"] { background: #8aadf4; }
      .theme-preview[data-theme="catppuccin-frappe"] { background: #8caaee; }
      .theme-preview[data-theme="nord"] { background: #5e81ac; }
      .theme-preview[data-theme="dracula"] { background: #bd93f9; }
      .theme-preview[data-theme="tokyonight"] { background: #7aa2f7; }
      
      /* Font previews */
      .font-preview[data-font="inter"] { font-family: var(--font-inter); }
      .font-preview[data-font="helvetica"] { font-family: var(--font-helvetica); }
      .font-preview[data-font="open-sans"] { font-family: var(--font-open-sans); }
      .font-preview[data-font="roboto"] { font-family: var(--font-roboto); }
      .font-preview[data-font="lato"] { font-family: var(--font-lato); }
      .font-preview[data-font="georgia"] { font-family: var(--font-georgia); }
      .font-preview[data-font="merriweather"] { font-family: var(--font-merriweather); }
      .font-preview[data-font="playfair"] { font-family: var(--font-playfair); }
      .font-preview[data-font="crimson"] { font-family: var(--font-crimson); }
      .font-preview[data-font="source-code"] { font-family: var(--font-source-code); }
    `;
    
    const styleSheet = document.createElement('style');
    styleSheet.textContent = styles;
    document.head.appendChild(styleSheet);
  }
}

// Initialize theme switcher when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
  window.siruThemeSwitcher = new SiruThemeSwitcher();
});

// Export for manual initialization
window.SiruThemeSwitcher = SiruThemeSwitcher;
