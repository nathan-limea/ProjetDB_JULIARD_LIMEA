USE e_sport;

-- =================================================================
-- 1. PROJECTIONS, SÉLECTIONS, TRIS, IN, BETWEEN (5 requêtes minimum)
-- =================================================================

-- Requête 1.1 : Liste des tournois du jeu 'Valorant' (Sélection et projection)
-- Données recherchées : Nom et cash prize des tournois Valorant.
SELECT nom_tournoi, cash_prize 
FROM TOURNOI 
WHERE jeu = 'Valorant';

-- Requête 1.2 : Tournois débutant entre le 1er mars et le 31 mai 2026 (BETWEEN)
-- Données recherchées : Tournois du printemps.
SELECT nom_tournoi, date_debut, date_fin 
FROM TOURNOI 
WHERE date_debut BETWEEN '2026-03-01' AND '2026-05-31';

-- Requête 1.3 : Joueurs dont le pseudo commence par 'C' ou 'Z' (Masque / LIKE)
-- Données recherchées : Pseudos et emails ciblés.
SELECT pseudo, email 
FROM JOUEUR 
WHERE pseudo LIKE 'C%' OR pseudo LIKE 'Z%';

-- Requête 1.4 : Équipes créées parmi une liste de dates précises (IN)
-- Données recherchées : Équipes ciblées par date de création.
SELECT nom_equipe, date_creation 
FROM EQUIPE 
WHERE date_creation IN ('2020-03-12', '2018-03-12', '2011-03-14');

-- Requête 1.5 : Liste triée de tous les joueurs par ordre alphabétique de pseudo (ORDER BY)
-- Données recherchées : Annuaire des joueurs trié.
SELECT DISTINCT pseudo, email, date_inscription 
FROM JOUEUR 
ORDER BY pseudo ASC;


-- =================================================================
-- 2. FONCTIONS D'AGRÉGATION, GROUP BY, HAVING (5 requêtes minimum)
-- =================================================================

-- Requête 2.1 : Nombre total de joueurs enregistrés dans la base (COUNT)
-- Données recherchées : Effectif total.
SELECT COUNT(*) AS total_joueurs 
FROM JOUEUR;

-- Requête 2.2 : Nombre de joueurs par équipe via la table d'association APPARTENIR (GROUP BY)
-- Données recherchées : Répartition des effectifs par équipe.
SELECT id_equipe, COUNT(id_joueur) AS nb_joueurs 
FROM APPARTENIR 
GROUP BY id_equipe;

-- Requête 2.3 : Équipes ayant plus de 2 joueurs enregistrés (GROUP BY + HAVING)
-- Données recherchées : Équipes les plus denses.
SELECT id_equipe, COUNT(id_joueur) AS nb_joueurs 
FROM APPARTENIR 
GROUP BY id_equipe 
HAVING COUNT(id_joueur) > 2;

-- Requête 2.4 : Score maximum inscrit par une équipe A (MAX)
-- Données recherchées : Plus grand score offensif initial.
SELECT MAX(score_equipe_a) AS max_score_equipe_a 
FROM MATCH_E;

-- Requête 2.5 : Moyenne des scores de l'équipe A par tournoi (GROUP BY + AVG)
-- Données recherchées : Performance moyenne par tournoi.
SELECT id_tournoi, AVG(score_equipe_a) AS moyenne_score_equipe_a 
FROM MATCH_E
GROUP BY id_tournoi;


-- =================================================================
-- 3. JOINTURES (INTERNES, EXTERNES, SIMPLES, MULTIPLES) (5 requêtes minimum)
-- =================================================================

-- Requête 3.1 : Jointure simple entre JOUEUR, APPARTENIR et EQUIPE
-- Données recherchées : Pseudo du joueur et nom de son équipe.
SELECT j.pseudo, e.nom_equipe 
FROM JOUEUR j
JOIN APPARTENIR a ON j.id_joueur = a.id_joueur
JOIN EQUIPE e ON a.id_equipe = e.id_equipe;

-- Requête 3.2 : Jointure externe (LEFT JOIN) pour inclure tous les joueurs même sans équipe
-- Données recherchées : Liste de tous les joueurs et leur équipe éventuelle.
SELECT j.pseudo, e.nom_equipe 
FROM JOUEUR j
LEFT JOIN APPARTENIR a ON j.id_joueur = a.id_joueur
LEFT JOIN EQUIPE e ON a.id_equipe = e.id_equipe;

-- Requête 3.3 : Jointure entre TOURNOI et MATCH_E
-- Données recherchées : Nom du tournoi, date et statut du match.
SELECT t.nom_tournoi, t.jeu, m.id_match, m.date_heure, m.statut_match 
FROM TOURNOI t
JOIN MATCH_E m ON t.id_tournoi = m.id_tournoi;

-- Requête 3.4 : Jointure multiple (MATCH_E avec TOURNOI, SERVEUR et ARBITRE)
-- Données recherchées : Date du match, tournoi, serveur et nom de l'arbitre.
SELECT m.id_match, t.nom_tournoi, s.nom_serveur, CONCAT(a.prenom_arbitre, ' ', a.nom_arbitre) AS arbitre 
FROM MATCH_E m
JOIN TOURNOI t ON m.id_tournoi = t.id_tournoi
JOIN SERVEUR s ON m.id_serveur = s.id_serveur
JOIN ARBITRE a ON m.id_arbitre = a.id_arbitre;

-- Requête 3.5 : Jointure multiple complète d'un match (MATCH_E avec les noms des deux équipes)
-- Données recherchées : Affichage des duels d'équipes et scores pour chaque match.
SELECT m.id_match, eq1.nom_equipe AS equipe_a, m.score_equipe_a, m.score_equipe_b, eq2.nom_equipe AS equipe_b 
FROM MATCH_E m
JOIN EQUIPE eq1 ON m.id_equipe_a = eq1.id_equipe
JOIN EQUIPE eq2 ON m.id_equipe_b = eq2.id_equipe;


-- =================================================================
-- 4. REQUÊTES IMBRIQUÉES (IN, NOT IN, EXISTS, ANY, ALL) (5 requêtes minimum)
-- =================================================================

-- Requête 4.1 : Joueurs appartenant à une équipe créée après 2015 (IN)
-- Données recherchées : Pseudos des joueurs d'équipes récentes.
SELECT pseudo 
FROM JOUEUR 
WHERE id_joueur IN (
    SELECT id_joueur 
    FROM APPARTENIR 
    WHERE id_equipe IN (
        SELECT id_equipe 
        FROM EQUIPE 
        WHERE date_creation > '2015-01-01'
    )
);

-- Requête 4.2 : Tournois pour lesquels aucun match n'a encore été planifié (NOT IN)
-- Données recherchées : Tournois sans matchs enregistrés.
SELECT nom_tournoi, jeu 
FROM TOURNOI 
WHERE id_tournoi NOT IN (
    SELECT DISTINCT id_tournoi 
    FROM MATCH_E
);

-- Requête 4.3 : Équipes qui ont au moins un joueur inscrit dans APPARTENIR (EXISTS)
-- Données recherchées : Équipes actives avec effectif.
SELECT nom_equipe 
FROM EQUIPE e 
WHERE EXISTS (
    SELECT 1 
    FROM APPARTENIR a 
    WHERE a.id_equipe = e.id_equipe
);

-- Requête 4.4 : Matchs dont le score de l'équipe A est supérieur à TOUS les scores de l'équipe A du tournoi 2 (ALL)
-- Données recherchées : Matchs à très forte domination de l'équipe A.
SELECT id_match, score_equipe_a 
FROM MATCH_E
WHERE score_equipe_a > ALL (
    SELECT score_equipe_a 
    FROM MATCH_E
    WHERE id_tournoi = 2
);

-- Requête 4.5 : Matchs dont le score de l'équipe B est supérieur à AU MOINS un score du tournoi 1 (ANY)
-- Données recherchées : Matchs de haut niveau comparatifs.
SELECT id_match, score_equipe_b 
FROM MATCH_E
WHERE score_equipe_b > ANY (
    SELECT score_equipe_b 
    FROM MATCH_E
    WHERE id_tournoi = 1
);