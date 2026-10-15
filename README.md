# Mini-Projet BDD : Plateforme e-sport

## Étape 1 : Analyse des besoins

### 1. Prompt RICARDO utilisé

**[R - Rôle]** Agis en tant que Chief Data Officer et Architecte de Bases de Données expert, spécialisé dans le secteur de l'e-sport et des plateformes de compétition en ligne.
**[I - Instructions]** 1. Analyse le contexte métier d'une plateforme d'organisation de tournois e-sport. 2. Formule une liste de règles métier (RM) claires, précises et numérotées. 3. Rédige un dictionnaire de données complet sous forme de tableau Markdown respectant la 3ème Forme Normale (3FN).
**[C - Contexte]** Nous développons la base de données relationnelle d'une plateforme de gestion de tournois e-sport en ligne (jeux type Rocket League, Valorant). La plateforme doit gérer :
- Les joueurs et leur parrainage.
- Les équipes composées de joueurs.
- Les tournois et leurs sponsors.
- Les matchs d'un tournoi.
- Les manches (maps/rounds) jouées au sein d'un match.
- Les serveurs de jeu et les arbitres affectés aux matchs.
**[A - Contraintes Additionnelles]** La modélisation et le dictionnaire de données doivent obligatoirement intégrer les trois éléments avancés suivants :
1. Une association réflexive : un joueur peut parrainer d'autres joueurs.
2. Une entité faible / identification relative : la manche (ou map) dépend obligatoirement d'un match et est identifiée de manière relative par rapport à celui-ci.
3. Une association ternaire (ou n-aire n > 2) : la planification d'un match associe un Match, un Serveur de jeu et un Arbitre.
Veille à ce que tous les attributs soient en 3FN (atomiques, sans dépendance partielle ni transitive).
**[R - Références]** Inspiré des fonctionnalités et structures de données des plateformes e-sport de référence comme Start.gg, Faceit et Battlefy.
**[D - Rendement Désiré]** Fournis une réponse structurée en deux parties : Partie 1 : "Règles Métier" (liste numérotée RM1, RM2, etc.). Partie 2 : "Dictionnaire de Données" (Tableau Markdown avec les colonnes : Entité, Code attribut, Type de donnée, Contraintes / Propriétés).
**[O - Objectifs]** Obtenir l'analyse des besoins nécessaire pour construire un Modèle Conceptuel de Données (MCD) valide et normalisé pour notre mini-projet de base de données.

### 2. Règles Métier (RM)

- **RM1 (Joueur & Parrainage)** : Un joueur est identifié par un identifiant unique. Un joueur peut parrainer plusieurs autres joueurs, mais il ne peut être parrainé que par un seul joueur (association réflexive).
- **RM2 (Équipe & Composition)** : Une équipe possède un nom et est créée par un joueur. Un joueur peut faire partie de plusieurs équipes au fil du temps, et une équipe est composée de plusieurs joueurs.
- **RM3 (Tournoi & Sponsor)** : Un tournoi est sponsorisé par un ou plusieurs sponsors, et un sponsor peut financer plusieurs tournois. L'association conserve le montant du sponsoring.
- **RM4 (Inscription Tournoi)** : Un tournoi accueille plusieurs équipes participantes. Une équipe peut s'inscrire à plusieurs tournois.
- **RM5 (Match & Tournoi)** : Un match appartient à un et un seul tournoi. Un tournoi comprend un ou plusieurs matchs.
- **RM6 (Planification - Ternaire)** : Un match est joué sur un et un seul serveur de jeu et est supervisé par un et un seul arbitre. Un serveur et un arbitre peuvent être affectés à plusieurs matchs à des moments différents.
- **RM7 (Manche - Entité Faible)** : Un match se compose d'une ou plusieurs manches (maps/rounds). Une manche n'a pas d'existence propre : elle est identifiée de manière relative par son numéro au sein du match.

### 3. Dictionnaire de Données (3FN)

| Entité / Association | Code attribut | Type de donnée | Contraintes / Propriétés |
| :--- | :--- | :--- | :--- |
| **JOUEUR** | `id_joueur` | INT | PK, Auto-increment |
| | `pseudo` | VARCHAR(50) | UNIQUE, NOT NULL |
| | `email` | VARCHAR(255) | UNIQUE, NOT NULL |
| | `mot_de_passe` | VARCHAR(255) | NOT NULL |
| | `date_inscription` | DATETIME | NOT NULL |
| **EQUIPE** | `id_equipe` | INT | PK, Auto-increment |
| | `nom_equipe` | VARCHAR(100) | UNIQUE, NOT NULL |
| | `date_creation` | DATE | NOT NULL |
| **APPARTENIR** | `date_rejoint` | DATE | NOT NULL |
| | `date_quitte` | DATE | NULL |
| **TOURNOI** | `id_tournoi` | INT | PK, Auto-increment |
| | `nom_tournoi` | VARCHAR(100) | NOT NULL |
| | `jeu` | VARCHAR(50) | NOT NULL |
| | `cash_prize` | DECIMAL(10,2) | NOT NULL, >= 0 |
| | `date_debut` | DATETIME | NOT NULL |
| | `date_fin` | DATETIME | NOT NULL |
| **SPONSOR** | `id_sponsor` | INT | PK, Auto-increment |
| | `nom_sponsor` | VARCHAR(100) | NOT NULL |
| | `email_sponsor` | VARCHAR(255) | NOT NULL |
| **SPONSORISER** | `montant_sponsoring` | DECIMAL(10,2) | NOT NULL, > 0 |
| **PARTICIPER** | `date_inscription_t` | DATETIME | NOT NULL |
| | `statut_inscription` | VARCHAR(20) | CHECK (Valide, Attente, Refuse) |
| **SERVEUR** | `id_serveur` | INT | PK, Auto-increment |
| | `nom_serveur` | VARCHAR(100) | NOT NULL |
| | `adresse_ip` | VARCHAR(45) | NOT NULL |
| | `region` | VARCHAR(20) | NOT NULL |
| **ARBITRE** | `id_arbitre` | INT | PK, Auto-increment |
| | `nom_arbitre` | VARCHAR(50) | NOT NULL |
| | `prenom_arbitre` | VARCHAR(50) | NOT NULL |
| | `niveau_certification` | VARCHAR(30) | NOT NULL |
| **MATCH** | `id_match` | INT | PK, Auto-increment |
| | `date_heure` | DATETIME | NOT NULL |
| | `statut_match` | VARCHAR(20) | CHECK (Planifie, En cours, Termine, Annule) |
| | `score_equipe_a` | INT | DEFAULT 0 |
| | `score_equipe_b` | INT | DEFAULT 0 |
| **MANCHE** | `numero_manche` | INT | PK (Identification relative) |
| | `nom_map` | VARCHAR(50) | NOT NULL |
| | `duree_seconde` | INT | NOT NULL |

## Étape 2 : Modèle Conceptuel de Données (MCD)
Voir MINIPROJET.loo
