CREATE DATABASE e_sport;
USE e_sport;

-- 1. Table Jeu
CREATE TABLE Jeu (
    id_jeu INT NOT NULL AUTO_INCREMENT,
    nom_jeu VARCHAR(100) NOT NULL,
    editeur VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_jeu)
);

-- 2. Table Equipe
CREATE TABLE Equipe (
    id_equipe INT NOT NULL AUTO_INCREMENT,
    nom_equipe VARCHAR(100) NOT NULL,
    date_creation DATE,
    PRIMARY KEY (id_equipe)
);

-- 3. Table Joueur
CREATE TABLE Joueur (
    id_joueur INT NOT NULL AUTO_INCREMENT,
    pseudo VARCHAR(50) NOT NULL,
    prenom VARCHAR(50),
    nom VARCHAR(50),
    id_equipe INT,
    PRIMARY KEY (id_joueur),
    FOREIGN KEY (id_equipe) REFERENCES Equipe(id_equipe) ON DELETE SET NULL
);

-- 4. Table Tournoi
CREATE TABLE Tournoi (
    id_tournoi INT NOT NULL AUTO_INCREMENT,
    nom_tournoi VARCHAR(150) NOT NULL,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    id_jeu INT NOT NULL,
    PRIMARY KEY (id_tournoi),
    FOREIGN KEY (id_jeu) REFERENCES Jeu(id_jeu) ON DELETE CASCADE
);

-- 5. Table Match_Esport
CREATE TABLE Match_Esport (
    id_match INT NOT NULL AUTO_INCREMENT,
    date_match DATETIME NOT NULL,
    id_tournoi INT NOT NULL,
    id_equipe1 INT NOT NULL,
    id_equipe2 INT NOT NULL,
    score_equipe1 INT DEFAULT 0,
    score_equipe2 INT DEFAULT 0,
    PRIMARY KEY (id_match),
    FOREIGN KEY (id_tournoi) REFERENCES Tournoi(id_tournoi) ON DELETE CASCADE,
    FOREIGN KEY (id_equipe1) REFERENCES Equipe(id_equipe) ON DELETE CASCADE,
    FOREIGN KEY (id_equipe2) REFERENCES Equipe(id_equipe) ON DELETE CASCADE
);
