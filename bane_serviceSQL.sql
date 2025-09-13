CREATE DATABASE bane_service;
USE bane_service;

CREATE TABLE Client (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    telephone VARCHAR(20),
    adresse TEXT,
    mot_de_passe VARCHAR(255) NOT NULL
);

CREATE TABLE Abonnement (
    id_abonnement INT AUTO_INCREMENT PRIMARY KEY,
    type_abonnement VARCHAR(100) NOT NULL,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    statut VARCHAR(50) DEFAULT 'actif',
    id_client INT NOT NULL,
    FOREIGN KEY (id_client) REFERENCES Client(id_client)
);

CREATE TABLE Materiel (
    id_materiel INT AUTO_INCREMENT PRIMARY KEY,
    nom_materiel VARCHAR(100) NOT NULL,
    description TEXT,
    prix DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0
);
