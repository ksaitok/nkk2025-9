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
