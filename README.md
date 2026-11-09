# Mini-Projet BDD : Plateforme e-sport

## Étape 1 : Analyse des besoins

### 1. Prompt RICARDO utilisé

* **[R - Rôle]** Agis en tant que Chief Data Officer et Architecte de Bases de Données expert, spécialisé dans le secteur de l'e-sport et des plateformes de compétition en ligne.

* **[I - Instructions]** 
  1. Analyse le contexte métier d'une plateforme d'organisation de tournois e-sport. 
  2. Formule une liste de règles métier (RM) claires, précises et numérotées. 
  3. Rédige un dictionnaire de données complet sous forme de tableau Markdown respectant la 3ème Forme Normale (3FN).
     
* **[C - Contexte]** Nous développons la base de données relationnelle d'une plateforme de gestion de tournois e-sport en ligne (jeux type Rocket League, Valorant). La plateforme doit gérer :
  - Les joueurs et leur parrainage.
  - Les équipes composées de joueurs et leurs capitaines.
  - Les tournois et leurs sponsors.
  - Les matchs d'un tournoi opposant deux équipes.
  - Les manches (maps/rounds) jouées au sein d'un match et l'équipe gagnante.
  - Les serveurs de jeu et les arbitres affectés aux matchs.
    
* **[A - Contraintes Additionnelles]** La modélisation et le dictionnaire de données doivent obligatoirement intégrer les trois éléments avancés suivants :
  1. Une association réflexive : un joueur peut parrainer d'autres joueurs (`PARRAINER`).
  2. Une entité faible / identification relative : la manche (`MANCHE`) dépend obligatoirement d'un match et est identifiée de manière relative par rapport à celui-ci (`1,1(R)`).
  3. Une association ternaire (ou n-aire n > 2) : la planification d'un match associe un Match, un Serveur de jeu et un Arbitre (`PLANIFIER`).
  Veille à ce que tous les attributs soient en 3FN (atomiques, sans dépendance partielle ni transitive).

* **[R - Références]** Inspiré des fonctionnalités et structures de données des plateformes e-sport de référence comme Start.gg, Faceit et Battlefy.
* 
* **[D - Rendement Désiré]** Fournis une réponse structurée en deux parties : Partie 1 : "Règles Métier" (liste numérotée RM1, RM2, etc.). Partie 2 : "Dictionnaire de Données" (Tableau Markdown avec les colonnes : Entité / Association, Code attribut, Type de donnée, Contraintes / Propriétés).
  
* **[O - Objectifs]** Obtenir l'analyse des besoins nécessaire pour construire un Modèle Conceptuel de Données (MCD) valide et normalisé pour notre mini-projet de base de données.

---

### 2. Règles Métier (RM)

- **RM1 (Joueur & Parrainage)** : Un joueur est identifié par un identifiant unique (`id_joueur`). Un joueur peut parrainer d'autres joueurs (rôle Parrain) et ne peut être parrainé que par au plus un joueur (rôle Filleul) via l'association réflexive `PARRAINER`.
- **RM2 (Joueur & Équipe - Composition)** : Un joueur peut appartenir à zéro ou plusieurs équipes (`APPARTENIR`). Une équipe est composée d'au moins un joueur (`1,n`).
- **RM3 (Joueur & Équipe - Capitaine)** : Une équipe possède un seul et unique capitaine (`CAPITAINE`). Un joueur peut être le capitaine de zéro ou plusieurs équipes.
- **RM4 (Tournoi & Sponsor)** : Un tournoi peut être sponsorisé par zéro ou plusieurs sponsors (`SPONSORISER`). Un sponsor peut financer un ou plusieurs tournois (`1,n`).
- **RM5 (Inscription Tournoi)** : Un tournoi accueille une ou plusieurs équipes participantes (`PARTICIPER`). Une équipe peut s'inscrire à zéro ou plusieurs tournois (`0,n`).
- **RM6 (Match & Tournoi)** : Un match est organisé au sein d'un et un seul tournoi (`ORGANISER`). Un tournoi peut organiser un ou plusieurs matchs (`1,n`).
- **RM7 (Match & Équipes opposées)** : Un match oppose exactement deux équipes distinctes via les dépendances fonctionnelles `EQUIPE_A` et `EQUIPE_B`. Une équipe peut disputer zéro ou plusieurs matchs en tant qu'équipe A ou équipe B.
- **RM8 (Planification - Ternaire)** : La planification d'un match (`PLANIFIER`) associe exactement un Match (`1,1`), un Serveur de jeu (`0,n`) et un Arbitre (`0,n`). Un serveur et un arbitre peuvent superviser plusieurs matchs.
- **RM9 (Manche - Entité Faible & Victoire)** : Un match se compose d'une ou plusieurs manches (`COMPOSER`). La manche est une entité faible identifiée relativement à son match (`1,1(R)`). Chaque manche est remportée par une seule équipe (`GAGNER`), et une équipe peut gagner zéro ou plusieurs manches.

---

### 3. Dictionnaire de Données (3FN)

| Entité / Association | Code attribut | Type de donnée | Contraintes / Propriétés |
| :--- | :--- | :--- | :--- |
| **JOUEUR** | `id_joueur` | INT | PK |
| | `pseudo` | VARCHAR(50) | UNIQUE, NOT NULL |
| | `email` | VARCHAR(255) | UNIQUE, NOT NULL |
| | `mot_de_passe` | VARCHAR(255) | NOT NULL |
| | `date_inscription` | DATE | NOT NULL |
| **EQUIPE** | `id_equipe` | INT | PK |
| | `nom_equipe` | VARCHAR(100) | NOT NULL |
| | `date_creation` | DATE | NOT NULL |
| **TOURNOI** | `id_tournoi` | INT | PK |
| | `nom_tournoi` | VARCHAR(100) | NOT NULL |
| | `jeu` | VARCHAR(50) | NOT NULL |
| | `cash_prize` | DECIMAL(10,2) | NOT NULL, >= 0 |
| | `date_debut` | DATETIME | NOT NULL |
| | `date_fin` | DATETIME | NOT NULL |
| **SPONSOR** | `id_sponsor` | INT | PK |
| | `nom_sponsor` | VARCHAR(100) | NOT NULL |
| | `email_sponsor` | VARCHAR(255) | NOT NULL |
| **SERVEUR** | `id_serveur` | INT | PK |
| | `nom_serveur` | VARCHAR(100) | NOT NULL |
| | `adresse_ip` | VARCHAR(45) | NOT NULL |
| | `region` | VARCHAR(30) | NOT NULL |
| **ARBITRE** | `id_arbitre` | INT | PK |
| | `nom_arbitre` | VARCHAR(50) | NOT NULL |
| | `prenom_arbitre` | VARCHAR(50) | NOT NULL |
| | `niveau_certification` | VARCHAR(30) | NOT NULL |
| **MATCH** | `id_match` | INT | PK |
| | `date_heure` | DATETIME | NOT NULL |
| | `statut_match` | VARCHAR(20) | NOT NULL |
| | `score_equipe_a` | INT | DEFAULT 0 |
| | `score_equipe_b` | INT | DEFAULT 0 |
| **MANCHE** | `numero_manche` | INT | PK (Identification relative) |
| | `nom_map` | VARCHAR(50) | NOT NULL |
| | `duree_seconde` | INT | NOT NULL |

---

## Étape 2 : MCD

![Modèle Conceptuel de Données](./MCD_screenshot.png)

> Le fichier source Looping est disponible dans le dépôt sous le nom [`MCD.loo`](./MCD.loo)

## Étape 3 : MLD et MPD 

### III.A. MLD

- JOUEUR (<ins>id_joueur</ins>, pseudo, email, mot_de_passe, date_inscription, #id_joueur_parrain)
- EQUIPE (<ins>id_equipe</ins>, nom_equipe, date_creation, #id_joueur)
- TOURNOI (<ins>id_tournoi</ins>, nom_tournoi, jeu, cash_prize, date_debut, date_fin)
- SERVEUR (<ins>id_serveur</ins>, nom_serveur, adresse_ip, region)
- ARBITRE (<ins>id_arbitre</ins>, nom_arbitre, prenom_arbitre, niveau_certification)
- SPONSOR (<ins>id_sponsor</ins>, nom_sponsor, email_sponsor)
- MATCH (<ins>id_match</ins>, date_heure, statut_match, score_equipe_a, score_equipe_b, #id_tournoi, #id_equipe_a, #id_equipe_b, #id_serveur, #id_arbitre)
- MANCHE (<ins>id_match</ins>, <ins>numero_manche</ins>, nom_map, duree_seconde, #id_equipe_gagnante)
- APPARTENIR (<ins>#id_joueur</ins>, <ins>#id_equipe</ins>)
- PARTICIPER (<ins>#id_equipe</ins>, <ins>#id_tournoi</ins>)
- SPONSORISER (<ins>#id_sponsor</ins>, <ins>#id_tournoi</ins>)


## Étape 5 : interrogation de la BD 

### 1. Scénario d'utilisation

* **Acteur / Rôle** : Analyste Data / Manager Sportif au sein de la structure e-sport.
* **Contexte & Objectif** : Suivre l'efficacité des joueurs, analyser les résultats des matchs par tournoi, identifier les jeux générant le plus de compétitions et ajuster la stratégie de recrutement ainsi que le planning d'entraînement des équipes.
* **Données à extraire** :
  - Liste des tournois programmés sur des périodes données et jeux associés.
  - Statistiques de performance des équipes (scores moyens, scores maximaux par tournoi).
  - Effectifs des joueurs par équipe et historique des confrontations.
  - Identification des jeux inutilisés et des équipes actives sans joueurs affectés.
    

### 2. Fichier de requêtes SQL (`4_interrogation.sql`)

L'ensemble des 20 requêtes SQL couvrant les différentes catégories requises est implémenté et commenté dans le fichier dédié :
 **`4_interrogation.sql`**
 
### 3. Étude des plans d'exécution

Pour illustrer l'optimisation des requêtes par l'algèbre relationnelle, nous avons analysé la recherche de l'identifiant des matchs et des noms de tournois associés pour le jeu `Valorant`.

#### a. Requête SQL analysée:

```
SELECT m.id_match, t.nom_tournoi 
FROM TOURNOI t 
JOIN MATCH_E m ON t.id_tournoi = m.id_tournoi 
WHERE t.jeu = 'Valorant';
```
Opérateurs algébriques utilisés :

- La sélection ($\sigma$) : filtre les lignes de la table TOURNOI vérifiant jeu = 'Valorant'.
- La jointure ($\bowtie$) : associe la table TOURNOI et la table MATCH_E sur la condition t.id_tournoi = m.id_tournoi.
- La projection ($\pi$) : extrait uniquement les attributs id_match et nom_tournoi.

#### b. Comparaison des plans d'exécution

##### Plan A : Jointure globale avant sélection (Non optimisé)

Dans ce plan, le système réalise d'abord la jointure complète entre toutes les lignes de TOURNOI et de MATCH_E, puis filtre le résultat par la sélection.

###### Arbre relationnel (Plan A) : 

<img src="./Arbre_A.png" alt="Arbre relationnel Plan A" width="400"/>

###### Calcul du coût (Plan A) :

Lecture des données sources : 2 lignes (TOURNOI) + 3 lignes (MATCH_E) = 5 lignes lues.

- Jointure ($\bowtie$) : Croisement global des 2 tournois avec les 3 matchs $\rightarrow$ 3 comparaisons de jointure (génère 3 lignes jointes).
- Sélection ($\sigma$) : Évaluation du filtre jeu = 'Valorant' sur les 3 lignes jointes $\rightarrow$ 3 opérations (conserve 2 matchs du tournoi Valorant).
- Projection ($\pi$) : Extraction des 2 colonnes (id_match, nom_tournoi) sur les 2 lignes obtenues $\rightarrow$ 2 opérations.

Coût total (Plan A) = 5 (lectures) + 3 (jointure) + 3 (sélection) + 2 (projection) = 13 opérations

##### Plan B : Poussée de la sélection (Optimisé)

Dans ce plan, la sélection est poussée au plus bas de l'arbre sur la table TOURNOI avant de réaliser la jointure avec MATCH_E.

###### Arbre relationnel (Plan B) : 

<img src="./Arbre_B.png" alt="Arbre relationnel Plan B" width="400"/>

###### Calcul du coût (Plan B) :

Lecture des données sources : 2 lignes (TOURNOI) + 3 lignes (MATCH_ESPORT) = 5 lignes lues.

- Sélection ($\sigma$) en amont sur TOURNOI : Filtrage du jeu 'Valorant' sur les 2 tournois $\rightarrow$ 2 opérations (réduit TOURNOI de 2 à 1 seule ligne).
- Jointure ($\bowtie$) sur données réduites : Jointure entre le seul tournoi Valorant et les 3 matchs $\rightarrow$ 3 comparaisons (trouve directement les 2 matchs correspondants).
- Projection ($\pi$) : Extraction des 2 colonnes sur les 2 lignes obtenues $\rightarrow$ 2 opérations.
  
Coût total (Plan B) = 5 (lectures) + 2 (sélection) + 3 (jointure) + 2 (projection) = 12 opérations

##### (Sur un volume plus vaste comme 5 tournois et 25 matchs, l'écart passe de 85 opérations pour le Plan A à 45 pour le Plan B !)

##### Conclusion sur l'optimisation

Le Plan B est le plan d'exécution optimisé retenu. 
En appliquant l'opérateur de sélection ($\sigma$) au plus près des données sources, on réduit la table Jeu de 5 à 2 lignes avant la jointure. 
Cela diminue le nombre total d'instructions de 42 à 27, évitant au moteur de traiter des données inutiles lors de l'étape de jointure.  
