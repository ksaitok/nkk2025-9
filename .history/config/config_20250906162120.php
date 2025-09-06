<?php
// Main configuration file for Nikkei Kaitai website

// Database configuration
define('DB_HOST', 'localhost');
define('DB_NAME', 'nikkei_kaitai');
define('DB_USER', 'root');
define('DB_PASS', '');

// Site configuration
define('SITE_NAME', 'Nikkei Kaitai Co., Ltd.');
define('SITE_URL', 'https://nikkei-kaitai.com');
define('ADMIN_EMAIL', 'momose2201@yahoo.co.jp');

// Language configuration
define('DEFAULT_LANGUAGE', 'ja');
define('SUPPORTED_LANGUAGES', ['ja', 'en', 'pt']);

// Security configuration
define('SESSION_TIMEOUT', 3600); // 1 hour
define('CSRF_TOKEN_NAME', 'csrf_token');
define('MAX_LOGIN_ATTEMPTS', 5);
define('LOCKOUT_TIME', 900); // 15 minutes

// File upload configuration
define('MAX_FILE_SIZE', 5 * 1024 * 1024); // 5MB
define('ALLOWED_IMAGE_TYPES', ['jpg', 'jpeg', 'png', 'gif', 'webp']);
define('ALLOWED_DOCUMENT_TYPES', ['pdf', 'doc', 'docx']);

// Paths
define('UPLOAD_PATH', __DIR__ . '/../uploads/');
define('IMAGE_PATH', UPLOAD_PATH . 'images/');
define('DOCUMENT_PATH', UPLOAD_PATH . 'documents/');

// Error reporting (set to false in production)
define('DEBUG_MODE', true);

if (DEBUG_MODE) {
    error_reporting(E_ALL);
    ini_set('display_errors', 1);
} else {
    error_reporting(0);
    ini_set('display_errors', 0);
}

// Start session if not already started
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Set default timezone
date_default_timezone_set('Asia/Tokyo');

// Helper functions
function sanitizeInput($data) {
    return htmlspecialchars(strip_tags(trim($data)), ENT_QUOTES, 'UTF-8');
}

function validateEmail($email) {
    return filter_var($email, FILTER_VALIDATE_EMAIL);
}

function generateCSRFToken() {
    if (!isset($_SESSION[CSRF_TOKEN_NAME])) {
        $_SESSION[CSRF_TOKEN_NAME] = bin2hex(random_bytes(32));
    }
    return $_SESSION[CSRF_TOKEN_NAME];
}

function verifyCSRFToken($token) {
    return isset($_SESSION[CSRF_TOKEN_NAME]) && hash_equals($_SESSION[CSRF_TOKEN_NAME], $token);
}

function getCurrentLanguage() {
    // Check URL parameter first
    if (isset($_GET['lang']) && in_array($_GET['lang'], SUPPORTED_LANGUAGES)) {
        $_SESSION['language'] = $_GET['lang'];
        return $_GET['lang'];
    }
    
    // Check session
    if (isset($_SESSION['language']) && in_array($_SESSION['language'], SUPPORTED_LANGUAGES)) {
        return $_SESSION['language'];
    }
    
    // Check browser language
