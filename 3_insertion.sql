-- 1. JOUEURS
INSERT INTO JOUEUR (id_joueur, pseudo, email, mot_de_passe, date_inscription, id_joueur_parrain) VALUES
(1, 'ScreaM', 'scream@esport.com', 'hash_pass1', '2025-01-10', NULL),
(2, 'ZywOo', 'zywoo@esport.com', 'hash_pass2', '2025-01-15', 1),
(3, 'Niko', 'niko@esport.com', 'hash_pass3', '2025-02-01', 1),
(4, 'Caps', 'caps@esport.com', 'hash_pass4', '2025-02-20', NULL),
(5, 'Boaster', 'boaster@esport.com', 'hash_pass5', '2025-03-05', 2);

-- 2. EQUIPES
INSERT INTO EQUIPE (id_equipe, nom_equipe, date_creation, id_joueur) VALUES
(1, 'KCorp', '2022-01-01', 1),
(2, 'Vitality', '2018-03-12', 2),
(3, 'G2 Esports', '2015-11-15', 3),
(4, 'Fnatic', '2011-03-14', 5);

-- 3. APPARTENIR (Joueurs dans les équipes)
INSERT INTO APPARTENIR (id_joueur, id_equipe) VALUES
(1, 1), (2, 2), (3, 3), (4, 3), (5, 4);

-- 4. TOURNOIS
INSERT INTO TOURNOI (id_tournoi, nom_tournoi, jeu, cash_prize, date_debut, date_fin) VALUES
(1, 'VCT EMEA Masters', 'Valorant', 50000.00, '2026-05-10', '2026-05-20'),
(2, 'Blast Premier Spring', 'CS2', 100000.00, '2026-06-01', '2026-06-10'),
(3, 'LEC Summer Split', 'League of Legends', 80000.00, '2026-07-05', '2026-07-25');

-- 5. SERVEURS & ARBITRES
INSERT INTO SERVEUR (id_serveur, nom_serveur, adresse_ip, region) VALUES
(1, 'EU-West-01', '192.168.1.10', 'Europe West'),
(2, 'EU-Central-02', '192.168.2.20', 'Europe Central');

INSERT INTO ARBITRE (id_arbitre, nom_arbitre, prenom_arbitre, niveau_certification) VALUES
(1, 'Dupont', 'Jean', 'Senior'),
(2, 'Smith', 'Alex', 'Expert');

-- 6. MATCHS
INSERT INTO MATCH_E (id_match, date_heure, statut_match, score_equipe_a, score_equipe_b, id_tournoi, id_equipe_a, id_equipe_b, id_serveur, id_arbitre) VALUES
(1, '2026-05-12 18:00:00', 'Terminé', 2, 1, 1, 1, 2, 1, 1),
(2, '2026-05-14 20:00:00', 'Terminé', 0, 2, 1, 3, 4, 1, 2),
(3, '2026-06-03 16:00:00', 'Terminé', 2, 0, 2, 2, 3, 2, 1);

-- 7. MANCHES
INSERT INTO MANCHE (id_match, numero_manche, nom_map, duree_seconde, id_equipe_gagnante) VALUES
(1, 1, 'Bind', 2150, 1),
(1, 2, 'Haven', 1980, 2),
(1, 3, 'Ascent', 2400, 1),
(2, 1, 'Lotus', 1850, 4),
(2, 2, 'Sunset', 1790, 4);

-- 8. SPONSORS, PARTICIPER & SPONSORISER
INSERT INTO SPONSOR (id_sponsor, nom_sponsor, email_sponsor) VALUES
(1, 'Red Bull', 'contact@redbull.com'),
(2, 'Logitech', 'sponsorship@logitech.com');

INSERT INTO PARTICIPER (id_equipe, id_tournoi) VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (2, 2), (3, 2);

INSERT INTO SPONSORISER (id_sponsor, id_tournoi) VALUES
(1, 1), (2, 1), (2, 2);