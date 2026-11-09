CREATE DATABASE e_sport;
USE e_sport;

-- 1. Table JOUEUR
CREATE TABLE JOUEUR (
    id_joueur INT NOT NULL AUTO_INCREMENT,
    pseudo VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    mot_de_passe VARCHAR(255) NOT NULL,
    date_inscription DATE NOT NULL,
    id_joueur_parrain INT,
    PRIMARY KEY (id_joueur),
    FOREIGN KEY (id_joueur_parrain) REFERENCES JOUEUR(id_joueur) ON DELETE SET NULL
);

-- 2. Table EQUIPE
CREATE TABLE EQUIPE (
    id_equipe INT NOT NULL AUTO_INCREMENT,
    nom_equipe VARCHAR(100) NOT NULL,
    date_creation DATE,
    id_joueur INT, -- Capitaine / Référent
    PRIMARY KEY (id_equipe),
    FOREIGN KEY (id_joueur) REFERENCES JOUEUR(id_joueur) ON DELETE SET NULL
);

-- 3. Table TOURNOI
CREATE TABLE TOURNOI (
    id_tournoi INT NOT NULL AUTO_INCREMENT,
    nom_tournoi VARCHAR(150) NOT NULL,
    jeu VARCHAR(100) NOT NULL,
    cash_prize DECIMAL(10,2) DEFAULT 0.00,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    PRIMARY KEY (id_tournoi)
);

-- 4. Table SERVEUR
CREATE TABLE SERVEUR (
    id_serveur INT NOT NULL AUTO_INCREMENT,
    nom_serveur VARCHAR(100) NOT NULL,
    adresse_ip VARCHAR(45) NOT NULL,
    region VARCHAR(50),
    PRIMARY KEY (id_serveur)
);

-- 5. Table ARBITRE
CREATE TABLE ARBITRE (
    id_arbitre INT NOT NULL AUTO_INCREMENT,
    nom_arbitre VARCHAR(50) NOT NULL,
    prenom_arbitre VARCHAR(50) NOT NULL,
    niveau_certification VARCHAR(50),
    PRIMARY KEY (id_arbitre)
);

-- 6. Table SPONSOR
CREATE TABLE SPONSOR (
    id_sponsor INT NOT NULL AUTO_INCREMENT,
    nom_sponsor VARCHAR(100) NOT NULL,
    email_sponsor VARCHAR(100),
    PRIMARY KEY (id_sponsor)
);

-- 7. Table MATCH_E 
CREATE TABLE MATCH_E (
    id_match INT NOT NULL AUTO_INCREMENT,
    date_heure DATETIME NOT NULL,
    statut_match VARCHAR(50) DEFAULT 'Planifié',
    score_equipe_a INT DEFAULT 0,
    score_equipe_b INT DEFAULT 0,
    id_tournoi INT NOT NULL,
    id_equipe_a INT NOT NULL,
    id_equipe_b INT NOT NULL,
    id_serveur INT NOT NULL,
    id_arbitre INT NOT NULL,
    PRIMARY KEY (id_match),
    FOREIGN KEY (id_tournoi) REFERENCES TOURNOI(id_tournoi) ON DELETE CASCADE,
    FOREIGN KEY (id_equipe_a) REFERENCES EQUIPE(id_equipe) ON DELETE CASCADE,
    FOREIGN KEY (id_equipe_b) REFERENCES EQUIPE(id_equipe) ON DELETE CASCADE,
    FOREIGN KEY (id_serveur) REFERENCES SERVEUR(id_serveur) ON DELETE RESTRICT,
    FOREIGN KEY (id_arbitre) REFERENCES ARBITRE(id_arbitre) ON DELETE RESTRICT
);

-- 8. Table MANCHE (Clé primaire composée + GAGNER)
CREATE TABLE MANCHE (
    id_match INT NOT NULL,
    numero_manche INT NOT NULL,
    nom_map VARCHAR(100),
    duree_seconde INT,
    id_equipe_gagnante INT,
    PRIMARY KEY (id_match, numero_manche),
    FOREIGN KEY (id_match) REFERENCES MATCH_E(id_match) ON DELETE CASCADE,
    FOREIGN KEY (id_equipe_gagnante) REFERENCES EQUIPE(id_equipe) ON DELETE SET NULL
);

-- 9. Table APPARTENIR 
CREATE TABLE APPARTENIR (
    id_joueur INT NOT NULL,
    id_equipe INT NOT NULL,
    PRIMARY KEY (id_joueur, id_equipe),
    FOREIGN KEY (id_joueur) REFERENCES JOUEUR(id_joueur) ON DELETE CASCADE,
    FOREIGN KEY (id_equipe) REFERENCES EQUIPE(id_equipe) ON DELETE CASCADE
);

-- 10. Table PARTICIPER 
CREATE TABLE PARTICIPER (
    id_equipe INT NOT NULL,
    id_tournoi INT NOT NULL,
    PRIMARY KEY (id_equipe, id_tournoi),
    FOREIGN KEY (id_equipe) REFERENCES EQUIPE(id_equipe) ON DELETE CASCADE,
    FOREIGN KEY (id_tournoi) REFERENCES TOURNOI(id_tournoi) ON DELETE CASCADE
);

-- 11. Table SPONSORISER 
CREATE TABLE SPONSORISER (
    id_sponsor INT NOT NULL,
    id_tournoi INT NOT NULL,
    PRIMARY KEY (id_sponsor, id_tournoi),
    FOREIGN KEY (id_sponsor) REFERENCES SPONSOR(id_sponsor) ON DELETE CASCADE,
    FOREIGN KEY (id_tournoi) REFERENCES TOURNOI(id_tournoi) ON DELETE CASCADE
);