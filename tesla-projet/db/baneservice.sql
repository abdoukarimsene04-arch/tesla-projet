-- Création de la base
CREATE DATABASE IF NOT EXISTS baneservice
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE baneservice;
-- Table : users (utilisateurs administratifs)
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(100) NOT NULL UNIQUE,
  email VARCHAR(150) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role ENUM('admin','editor') DEFAULT 'editor',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Table : produits
CREATE TABLE IF NOT EXISTS produits (
  id INT AUTO_INCREMENT PRIMARY KEY,
  sku VARCHAR(50) UNIQUE,
  titre VARCHAR(255) NOT NULL,
  slug VARCHAR(255) NOT NULL UNIQUE,
  description TEXT,
  prix DECIMAL(10,2) DEFAULT 0.00,
  stock INT DEFAULT 0,
  image VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;
-- Table : services
CREATE TABLE IF NOT EXISTS services (
  id INT AUTO_INCREMENT PRIMARY KEY,
  titre VARCHAR(255) NOT NULL,
  slug VARCHAR(255) NOT NULL UNIQUE,
  description TEXT,
  prix DECIMAL(10,2) DEFAULT 0.00,
  duree VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;
-- Table : contacts (issues du formulaire Contact)
CREATE TABLE IF NOT EXISTS contacts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(150),
  email VARCHAR(150),
  telephone VARCHAR(50),
  message TEXT,
  source ENUM('site','tel','autre') DEFAULT 'site',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;
-- Table : commandes
CREATE TABLE IF NOT EXISTS commandes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  client_id INT,
  total DECIMAL(10,2) DEFAULT 0.00,
  statut ENUM('pending','paid','cancelled') DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (client_id) REFERENCES contacts(id) ON DELETE SET NULL
) ENGINE=InnoDB;
-- Table pivot : commande_produit
CREATE TABLE IF NOT EXISTS commande_produit (
  commande_id INT NOT NULL,
  produit_id INT NOT NULL,
  quantite INT DEFAULT 1,
  prix_unit DECIMAL(10,2) DEFAULT 0.00,
  PRIMARY KEY (commande_id, produit_id),
  FOREIGN KEY (commande_id) REFERENCES commandes(id) ON DELETE CASCADE,
  FOREIGN KEY (produit_id) REFERENCES produits(id) ON DELETE CASCADE
) ENGINE=InnoDB;
-- Index supplémentaires
CREATE INDEX idx_produits_slug ON produits(slug);
CREATE INDEX idx_services_slug ON services(slug);

