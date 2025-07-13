# Creating Custom Themes for Siru

While Siru includes a comprehensive default theme, you can create custom themes for specialized needs.

## Theme Structure

Create a theme directory:

```
themes/
└── mytheme/
    ├── layouts/
    │   ├── baseof.liquid    # Base template
    │   ├── index.liquid     # Homepage
    │   └── single.liquid    # Post/page template
    └── static/
        ├── css/
        ├── js/
        └── images/
```

## Required Layout Files

### baseof.liquid (Base Template)
```liquid
<!DOCTYPE html>
<html lang="{{ site.language_code }}">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{{ page.title }} - {{ site.title }}</title>
  <link rel="stylesheet" href="/assets/style.css">
</head>
<body>
  <header>
    <h1><a href="/">{{ site.title }}</a></h1>
    {% if site.params.bio %}
      <p>{{ site.params.bio }}</p>
    {% endif %}
  </header>
  
  <main>
    {{ content }}
  </main>
  
  <footer>
    <p>&copy; {{ "now" | date: "%Y" }} {{ site.title }}</p>
  </footer>
</body>
</html>
```

### index.liquid (Homepage)
```liquid
---
layout: baseof
---

<section class="posts">
  {% for post in site.posts %}
    <article>
      <h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
      <time>{{ post.date | date: "%B %d, %Y" }}</time>
      {% if post.summary %}
        <p>{{ post.summary }}</p>
      {% endif %}
    </article>
  {% endfor %}
</section>
```

### single.liquid (Post/Page Template)
```liquid
---
layout: baseof
---

<article>
  <header>
    <h1>{{ page.title }}</h1>
    <time>{{ page.date | date: "%B %d, %Y" }}</time>
  </header>
  
  <div class="content">
    {{ content }}
  </div>
  
  {% if page.tags %}
    <footer>
      <p>Tags: 
        {% for tag in page.tags %}
          <span class="tag">{{ tag }}</span>
        {% endfor %}
      </p>
    </footer>
  {% endif %}
</article>
```

## Available Template Variables

### Site Variables
- `site.title` - Site title
- `site.base_url` - Base URL
- `site.language_code` - Language code
- `site.posts` - Array of all posts
- `site.params.*` - Custom parameters from config.toml

### Page Variables
- `page.title` - Page/post title
- `page.date` - Publication date
- `page.content` - Rendered content
- `page.url` - Page URL
- `page.tags` - Array of tags
- `page.summary` - Page summary
- `page.draft` - Draft status

## Using the Theme

1. **Set theme in config.toml:**
   ```toml
   theme = "mytheme"
   ```

2. **Test the theme:**
   ```bash
   siru serve
   ```

3. **Build with theme:**
   ```bash
   siru build
   ```

## Best Practices

- **Responsive Design**: Use mobile-first CSS
- **Semantic HTML**: Use proper HTML5 elements
- **Accessibility**: Include ARIA labels and alt text
- **Performance**: Minimize CSS/JS, optimize images
- **Liquid Filters**: Use `| date`, `| strip`, `| truncate` for formatting

## Advanced Features

For inspiration, see the default theme's implementation at `themes/default/` which includes:
- CSS custom properties for theming
- JavaScript for dynamic theme switching
- Social media integration
- Responsive navigation
- SEO optimization
