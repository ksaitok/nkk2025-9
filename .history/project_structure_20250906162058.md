# Nikkei-Kaitai.com Website Renovation Project Structure

## Current Site Analysis
- **Platform**: Jimdo CMS
- **Language**: Japanese (ja-JP)
- **Business**: Demolition company in Shonan/Yokohama area
- **Key Pages**: Home, Estimation Process, Fire Damage, Contractor Selection, Construction Sites, Company Info, Blog, Contact
- **Services**: RC structures, Wooden structures, Steel structures, Interior demolition, Tree cutting, Fire-damaged houses

## New Project Structure

```
nikkei-kaitai-renovation/
├── assets/
│   ├── css/
│   │   ├── main.css
│   │   ├── responsive.css
│   │   ├── admin.css
│   │   └── languages.css
│   ├── js/
│   │   ├── main.js
│   │   ├── language-switcher.js
│   │   ├── admin.js
│   │   └── gallery.js
│   ├── images/
│   │   ├── logo/
│   │   ├── gallery/
│   │   ├── demolition-history/
│   │   └── backgrounds/
│   └── fonts/
├── languages/
│   ├── en.json (English)
│   ├── ja.json (Japanese)
│   └── pt.json (Portuguese)
├── includes/
│   ├── header.php
│   ├── footer.php
│   ├── navigation.php
│   └── language-switcher.php
├── admin/
│   ├── login.php
│   ├── dashboard.php
│   ├── content-manager.php
│   ├── gallery-manager.php
│   ├── logout.php
│   └── assets/
├── pages/
│   ├── home.php
│   ├── services.php
│   ├── demolition-history.php
│   ├── company.php
│   ├── contact.php
│   └── blog.php
├── config/
│   ├── database.php
│   ├── config.php
│   └── .htaccess
├── api/
│   ├── language.php
│   ├── gallery.php
│   └── content.php
├── uploads/
│   ├── demolition-photos/
│   └── documents/
├── index.php
├── .htaccess
└── README.md
```

## Key Features to Implement

### 1. Multi-language Support
- JSON-based translation system
- Language switcher in accordion menu
- URL-based language detection (/?lang=ja, /?lang=en, /?lang=pt)

### 2. Responsive Design
- Mobile-first approach
- Bootstrap 5 or custom CSS Grid
- Touch-friendly navigation

### 3. Admin Panel
- Secure login system
- Content management for all languages
- Photo gallery management for demolition history
- File upload system

### 4. Demolition History Gallery
- Photo upload/management system
- Categorization by project type
- Before/after comparisons
- Project details and descriptions

### 5. Content Management
- Editable text content for all pages
- Image management
- SEO optimization
- Contact form management

## Technology Stack
- **Frontend**: HTML5, CSS3, JavaScript (ES6+)
- **Backend**: PHP 8+
- **Database**: MySQL/MariaDB
- **Security**: Prepared statements, CSRF protection, Input validation
