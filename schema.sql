--CLIENT NOTES APP - DATABASE SCHEME
--AUTHOUR: LUKE RUDDERHAM-COZIER
--PORTFOLIO PROJECT

--RUN: mysql -u root -p < schema.sql

--Create database if it does not exist
CREATE DATABASE IF NOT EXISTS
client_notes_app;
USE client_notes_app;

--Users Table
-- Stoes user accounts with security features
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) UNIQUE NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  email_verified BOOLEAN DEFAULT FALSE,
  verification_token VARCHAR(255) NULL,
  verified_at TIMESTAMP NULL,
  last_login TIMESTAMP NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--Notes Table
-- User's notes with user assignment
CREATE TABLE notes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  content TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

--Password Resets Table
-- Secure password reset tokens
CREATE TABLE password_resets (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  token VARCHAR(255) NOT NULL,
  expires_at DATETIME NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Login Attempts Table
CREATE TABLE login_attempts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  ip_address VARCHAR(45) NOT NULL,
  username VARCHAR(255) NOT NULL,
  attempted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_ip (ip_address),
  INDEX idx_time (attempted_at)
);