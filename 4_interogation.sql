USE e_sport;

-- =================================================================
-- 1. PROJECTIONS, SÉlections, TRIS, IN, BETWEEN (5 requêtes minimum)
-- =================================================================

-- Requête 1.1 : Liste des jeux édités par 'Riot Games' (Sélection et projection)
-- Données recherchées : Nom et éditeur des jeux Riot Games.
SELECT nom_jeu, editeur 
FROM Jeu 
WHERE editeur = 'Riot Games';

-- Requête 1.2 : Tournois débutant entre le 1er mars et le 31 mai 2026 (BETWEEN)
-- Données recherchées : Tournois du printemps.
SELECT nom_tournoi, date_debut, date_fin 
FROM Tournoi 
WHERE date_debut BETWEEN '2026-03-01' AND '2026-05-31';

-- Requête 1.3 : Joueurs dont le pseudo commence par 'C' ou 'Z' (Masque / LIKE)
-- Données recherchées : Pseudos ciblés.
SELECT pseudo, prenom, nom 
FROM Joueur 
WHERE pseudo LIKE 'C%' OR pseudo LIKE 'Z%';

-- Requête 1.4 : Équipes créées parmi une liste de dates précises (IN)
-- Données recherchées : Équipes ciblées par date de création.
SELECT nom_equipe, date_creation 
FROM Equipe 
WHERE date_creation IN ('2020-03-12', '2013-08-05', '2000-01-01');

-- Requête 1.5 : Liste triée de tous les joueurs par ordre alphabétique de pseudo (ORDER BY)
-- Données recherchées : Annuaire des joueurs trié.
SELECT DISTINCT pseudo, prenom, nom 
FROM Joueur 
ORDER BY pseudo ASC;


-- =================================================================
-- 2. FONCTIONS D'AGRÉGATION, GROUP BY, HAVING (5 requêtes minimum)
-- =================================================================

-- Requête 2.1 : Nombre total de joueurs enregistrés dans la base (COUNT)
-- Données recherchées : Effectif total.
SELECT COUNT(*) AS total_joueurs 
FROM Joueur;

-- Requête 2.2 : Nombre de joueurs par équipe (GROUP BY)
-- Données recherchées : Répartition des effectifs par équipe.
SELECT id_equipe, COUNT(*) AS nb_joueurs 
FROM Joueur 
WHERE id_equipe IS NOT NULL 
GROUP BY id_equipe;

-- Requête 2.3 : Équipes ayant plus de 2 joueurs enregistrés (GROUP BY + HAVING)
-- Données recherchées : Équipes les plus denses.
SELECT id_equipe, COUNT(*) AS nb_joueurs 
FROM Joueur 
GROUP BY id_equipe 
HAVING COUNT(*) > 2;

-- Requête 2.4 : Score maximum inscrit par une équipe 1 (MAX)
-- Données recherchées : Plus grand score offensif initial.
SELECT MAX(score_equipe1) AS max_score_eq1 
FROM Match_Esport;

-- Requête 2.5 : Moyenne des scores de l'équipe 1 par tournoi (GROUP BY + AVG)
-- Données recherchées : Performance moyenne par tournoi.
SELECT id_tournoi, AVG(score_equipe1) AS moyenne_score_eq1 
FROM Match_Esport 
GROUP BY id_tournoi;


-- =================================================================
-- 3. JOINTURES (INTERNES, EXTERNES, SIMPLES, MULTIPLES) (5 requêtes minimum)
-- =================================================================

-- Requête 3.1 : Jointure simple / interne entre Joueur et Equipe
-- Données recherchées : Nom du joueur et nom de son équipe.
SELECT j.pseudo, e.nom_equipe 
FROM Joueur j
JOIN Equipe e ON j.id_equipe = e.id_equipe;

-- Requête 3.2 : Jointure externe (LEFT JOIN) pour inclure tous les joueurs même sans équipe
-- Données recherchées : Liste de tous les joueurs et leur équipe éventuelle.
SELECT j.pseudo, e.nom_equipe 
FROM Joueur j
LEFT JOIN Equipe e ON j.id_equipe = e.id_equipe;

-- Requête 3.3 : Jointure entre Tournoi et Jeu
-- Données recherchées : Nom du tournoi et nom du jeu associé.
SELECT t.nom_tournoi, j.nom_jeu 
FROM Tournoi t
JOIN Jeu j ON t.id_jeu = j.id_jeu;

-- Requête 3.4 : Jointure multiple (Match_Esport avec Tournoi et Jeu)
-- Données recherchées : Date du match, nom du tournoi et jeu concerné.
SELECT m.date_match, t.nom_tournoi, j.nom_jeu 
FROM Match_Esport m
JOIN Tournoi t ON m.id_tournoi = t.id_tournoi
JOIN Jeu j ON t.id_jeu = j.id_jeu;

-- Requête 3.5 : Jointure multiple complète d'un match (Match avec les noms des deux équipes)
-- Données recherchées : Affichage des duels d'équipes pour chaque match.
SELECT m.id_match, e1.nom_equipe AS equipe_1, m.score_equipe1, m.score_equipe2, e2.nom_equipe AS equipe_2 
FROM Match_Esport m
JOIN Equipe e1 ON m.id_equipe1 = e1.id_equipe
JOIN Equipe e2 ON m.id_equipe2 = e2.id_equipe;


-- =================================================================
-- 4. REQUÊTES IMBRIQUÉES (IN, NOT IN, EXISTS, ANY, ALL) (5 requêtes minimum)
-- =================================================================

-- Requête 4.1 : Joueurs appartenant à une équipe créée après 2015 (IN)
-- Données recherchées : Pseudos des joueurs d'équipes récentes.
SELECT pseudo 
FROM Joueur 
WHERE id_equipe IN (
    SELECT id_equipe 
    FROM Equipe 
    WHERE date_creation > '2015-01-01'
);

-- Requête 4.2 : Jeux qui n'ont aucun tournoi associé (NOT IN)
-- Données recherchées : Jeux non utilisés en compétition.
SELECT nom_jeu 
FROM Jeu 
WHERE id_jeu NOT IN (
    SELECT id_jeu 
    FROM Tournoi
);

-- Requête 4.3 : Équipes qui ont au moins un joueur (EXISTS)
-- Données recherchées : Équipes actives avec effectif.
SELECT nom_equipe 
FROM Equipe e 
WHERE EXISTS (
    SELECT * 
    FROM Joueur j 
    WHERE j.id_equipe = e.id_equipe
);

-- Requête 4.4 : Matchs dont le score de l'équipe 1 est supérieur à TOUS les scores de l'équipe 1 du tournoi 2 (ALL)
-- Données recherchées : Matchs à très forte domination de l'équipe 1.
SELECT id_match, score_equipe1 
FROM Match_Esport 
WHERE score_equipe1 > ALL (
    SELECT score_equipe1 
    FROM Match_Esport 
    WHERE id_tournoi = 2
);

-- Requête 4.5 : Matchs dont le score de l'équipe 2 est supérieur à AU MOINS un score du tournoi 1 (ANY)
-- Données recherchées : Matchs de haut niveau comparatifs.
SELECT id_match, score_equipe2 
FROM Match_Esport 
WHERE score_equipe2 > ANY (
    SELECT score_equipe2 
    FROM Match_Esport 
    WHERE id_tournoi = 1
);