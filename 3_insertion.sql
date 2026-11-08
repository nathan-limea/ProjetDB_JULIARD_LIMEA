USE e_sport;

-- ==========================================
-- 1. Remplissage des tables sans clés étrangères
-- ==========================================

-- Insertion des Jeux (5 lignes)
INSERT INTO Jeu VALUES (1, 'League of Legends', 'Riot Games');
INSERT INTO Jeu VALUES (2, 'Counter-Strike 2', 'Valve');
INSERT INTO Jeu VALUES (3, 'Valorant', 'Riot Games');
INSERT INTO Jeu VALUES (4, 'Rocket League', 'Psyonix');
INSERT INTO Jeu VALUES (5, 'Dota 2', 'Valve');

-- Insertion des Équipes (5 lignes)
INSERT INTO Equipe VALUES (1, 'Karmine Corp', '2020-03-12');
INSERT INTO Equipe VALUES (2, 'Vitality', '2013-08-05');
INSERT INTO Equipe VALUES (3, 'G2 Esports', '2014-02-24');
INSERT INTO Equipe VALUES (4, 'Fnatic', '2004-07-23');
INSERT INTO Equipe VALUES (5, 'Liquid', '2000-01-01');


-- ==========================================
-- 2. Remplissage des tables avec clés étrangères
-- ==========================================

-- Insertion des Joueurs (15 lignes aux profils mixtes et variés)
INSERT INTO Joueur VALUES (1, 'Cabochard', 'Lucas', 'Simon-Meslet', 1);
INSERT INTO Joueur VALUES (2, 'Saken', 'Lucas', 'Fayard', 1);
INSERT INTO Joueur VALUES (3, 'Vetheo', 'Vincent', 'Berthier', 2);
INSERT INTO Joueur VALUES (4, 'ZywOo', 'Mathieu', 'Herbaut', 2);
INSERT INTO Joueur VALUES (5, 'Caps', 'Rasmus', 'Winther', 3);
INSERT INTO Joueur VALUES (6, 'Jojopyun', 'Joseph', 'Pyun', 3);
INSERT INTO Joueur VALUES (7, 'Rekkles', 'Martin', 'Larsson', 4);
INSERT INTO Joueur VALUES (8, 'Humanoid', 'Marek', 'Brázda', 4);
INSERT INTO Joueur VALUES (9, 'Nisha', 'Michał', 'Jankowski', 5);
INSERT INTO Joueur VALUES (10, 'Boxi', 'Samuel', 'Pahlsson', 5);
INSERT INTO Joueur VALUES (11, 'Meiy', 'Mei', 'Tachibana', 3);
INSERT INTO Joueur VALUES (12, 'Aspas', 'Erick', 'Santos', 2);
INSERT INTO Joueur VALUES (13, 'Chovy', 'Jeong', 'Ji-hoon', 1);
INSERT INTO Joueur VALUES (14, 'Faker', 'Lee', 'Sang-hyeok', 4);
INSERT INTO Joueur VALUES (15, 'Scarlett', 'Sasha', 'Hostyn', 5);

-- Insertion des Tournois (5 lignes)
INSERT INTO Tournoi VALUES (1, 'KC Spring Showcase', '2026-02-01', '2026-02-15', 1);
INSERT INTO Tournoi VALUES (2, 'Major Copenhagen', '2026-03-10', '2026-03-25', 2);
INSERT INTO Tournoi VALUES (3, 'Valorant Masters Paris', '2026-04-01', '2026-04-12', 3);
INSERT INTO Tournoi VALUES (4, 'RLCS Major Lyon', '2026-05-05', '2026-05-10', 4);
INSERT INTO Tournoi VALUES (5, 'The International 2026', '2026-08-15', '2026-08-30', 5);

-- Insertion des Matchs (10 lignes)
INSERT INTO Match_Esport VALUES (1, '2026-02-02 18:00:00', 1, 1, 2, 2, 1);
INSERT INTO Match_Esport VALUES (2, '2026-02-05 20:00:00', 1, 3, 4, 0, 2);
INSERT INTO Match_Esport VALUES (3, '2026-03-11 15:00:00', 2, 2, 5, 2, 0);
INSERT INTO Match_Esport VALUES (4, '2026-03-14 17:30:00', 2, 3, 1, 1, 2);
INSERT INTO Match_Esport VALUES (5, '2026-04-02 19:00:00', 3, 1, 4, 3, 2);
INSERT INTO Match_Esport VALUES (6, '2026-04-06 21:00:00', 3, 5, 2, 0, 3);
INSERT INTO Match_Esport VALUES (7, '2026-05-06 14:00:00', 4, 3, 5, 4, 1);
INSERT INTO Match_Esport VALUES (8, '2026-05-08 18:30:00', 4, 1, 2, 2, 3);
INSERT INTO Match_Esport VALUES (9, '2026-08-16 16:00:00', 5, 4, 5, 2, 1);
INSERT INTO Match_Esport VALUES (10, '2026-08-20 19:00:00', 5, 1, 3, 1, 2);