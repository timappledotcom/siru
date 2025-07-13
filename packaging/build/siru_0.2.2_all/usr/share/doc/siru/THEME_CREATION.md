# Creating Themes for Siru

Creating a new theme for Siru is a straightforward process. Here's a simple guide to help you create your own themes.

## Steps to Create a New Theme

### 1. Theme Directory Structure

Create a directory for your theme inside the `themes` directory:

```
themes/
└── your_theme_name/
    ├── layouts/
    └── static/
```

- **layouts/**: Contains Liquid templating files for the pages.
- **static/**: Contains any static assets like stylesheets or JavaScript files.

### 2. Layout Files

Create layout files for different page types in the `layouts` directory. Typical files include:
- `baseof.liquid`: The base layout wrapping other layouts.
- `index.liquid`: The homepage layout.
- `single.liquid`: A layout for individual posts.

Here's a basic example of `baseof.liquid`:

```
<!DOCTYPE html>
<html lang="{{ site.language_code }}">
<head>
  <meta charset="UTF-8">
  <title>{{ page.title }}</title>
  <link rel="stylesheet" href="/assets/style.css">
</head>
<body>
  <header>
    <h1>{{ site.title }}</h1>
  </header>
  <main>
    {{ content }}
  </main>
  <footer>
    <p>Powered by Siru</p>
  </footer>
</body>
</html>
```

### 3. Static Files

Add any CSS, JavaScript, or images in the `static` directory. They will be copied over to the `public` directory during the build process.

### 4. Applying the Theme

Update your site's `config.toml` to use the new theme:

```toml
theme = "your_theme_name"
```

### 5. Testing the Theme

Run the Siru server to test the theme:

```
siru serve
```

### 6. Iterate and Customize

Customize your theme's design and structure by modifying the layout and static files.


## Conclusion

Creating themes for Siru is flexible and allows you to harness the power of Liquid templates and static files to design your site exactly how you want. Enjoy crafting your unique design!
