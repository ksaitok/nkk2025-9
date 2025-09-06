-- Database schema for Nikkei Kaitai website renovation
-- Create database
CREATE DATABASE IF NOT EXISTS nikkei_kaitai CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE nikkei_kaitai;

-- Users table for admin system
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'editor') DEFAULT 'editor',
    is_active BOOLEAN DEFAULT TRUE,
    last_login DATETIME NULL,
    login_attempts INT DEFAULT 0,
    locked_until DATETIME NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Content translations table
CREATE TABLE content_translations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    page_key VARCHAR(100) NOT NULL,
    element_key VARCHAR(100) NOT NULL,
    language_code VARCHAR(2) NOT NULL,
    content TEXT,
    content_type ENUM('text', 'html', 'json') DEFAULT 'text',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY unique_content (page_key, element_key, language_code)
);

-- Demolition projects/history table
CREATE TABLE demolition_projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    project_name VARCHAR(255) NOT NULL,
    project_type ENUM('rc_structure', 'wooden', 'steel', 'interior', 'tree_cutting', 'fire_damage') NOT NULL,
    location VARCHAR(255),
    completion_date DATE,
    description TEXT,
    is_featured BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
);

-- Project photos table
CREATE TABLE project_photos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    project_id INT NOT NULL,
    photo_path VARCHAR(500) NOT NULL,
    thumbnail_path VARCHAR(500),
    photo_type ENUM('before', 'after', 'during', 'other') DEFAULT 'other',
    caption TEXT,
    sort_order INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES demolition_projects(id) ON DELETE CASCADE
);

-- Contact form submissions
CREATE TABLE contact_submissions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    subject VARCHAR(255),
    message TEXT NOT NULL,
    service_type VARCHAR(50),
    preferred_contact ENUM('email', 'phone') DEFAULT 'email',
    status ENUM('new', 'read', 'replied', 'closed') DEFAULT 'new',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Site settings
CREATE TABLE site_settings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    setting_key VARCHAR(100) UNIQUE NOT NULL,
    setting_value TEXT,
    setting_type ENUM('string', 'int', 'boolean', 'json') DEFAULT 'string',
    description TEXT,
    is_public BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Blog posts
CREATE TABLE blog_posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    excerpt TEXT,
    content TEXT,
    featured_image VARCHAR(500),
    author_id INT,
    status ENUM('draft', 'published', 'archived') DEFAULT 'draft',
    published_at DATETIME NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Blog post translations
CREATE TABLE blog_translations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    blog_post_id INT NOT NULL,
    language_code VARCHAR(2) NOT NULL,
    title VARCHAR(255) NOT NULL,
    excerpt TEXT,
    content TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (blog_post_id) REFERENCES blog_posts(id) ON DELETE CASCADE,
    UNIQUE KEY unique_blog_translation (blog_post_id, language_code)
);

-- Insert default admin user (password: admin123 - change after first login)
INSERT INTO users (username, email, password_hash, role) VALUES 
('admin', 'admin@nikkei-kaitai.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin');

-- Insert default content translations
INSERT INTO content_translations (page_key, element_key, language_code, content, content_type) VALUES
-- Home page translations
('home', 'main_title', 'ja', '湘南・横浜の戸建解体は日系解体工業株式会社へ', 'text'),
('home', 'main_title', 'en', 'House Demolition in Shonan/Yokohama - Nikkei Demolition Co., Ltd.', 'text'),
('home', 'main_title', 'pt', 'Demolição de Casas em Shonan/Yokohama - Nikkei Demolição Ltda.', 'text'),

('home', 'subtitle', 'ja', '戸建の解体なら日系解体へ「安全な施工・安心の価格」どんな構造、立地でも、丁寧な工事をお約束します！', 'text'),
('home', 'subtitle', 'en', 'For house demolition, trust Nikkei Demolition - "Safe construction, reliable prices" We promise careful work for any structure or location!', 'text'),
('home', 'subtitle', 'pt', 'Para demolição de casas, confie na Nikkei Demolição - "Construção segura, preços confiáveis" Prometemos trabalho cuidadoso para qualquer estrutura ou localização!', 'text'),

-- Navigation translations
('nav', 'home', 'ja', 'ホーム', 'text'),
('nav', 'home', 'en', 'Home', 'text'),
('nav', 'home', 'pt', 'Início', 'text'),

('nav', 'services', 'ja', 'サービス', 'text'),
('nav', 'services', 'en', 'Services', 'text'),
('nav', 'services', 'pt', 'Serviços', 'text'),

