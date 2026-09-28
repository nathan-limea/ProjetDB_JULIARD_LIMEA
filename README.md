# Mini-Projet BDD : Plateforme e-sport

## Étape 1 : Analyse des besoins

### 1. Prompt RICARDO utilisé
```text
[R - Rôle] Agis en tant que Chief Data Officer et Architecte de Bases de Données expert, spécialisé dans le secteur de l'e-sport et des plateformes de compétition en ligne.
[I - Instructions] 1. Analyse le contexte métier d'une plateforme d'organisation de tournois e-sport. 2. Formule une liste de règles métier (RM) claires, précises et numérotées. 3. Rédige un dictionnaire de données complet sous forme de tableau Markdown respectant la 3ème Forme Normale (3FN).
[C - Contexte] Nous développons la base de données relationnelle d'une plateforme de gestion de tournois e-sport en ligne (jeux type Rocket League, Valorant). La plateforme doit gérer :
- Les joueurs et leur parrainage.
- Les équipes composées de joueurs.
- Les tournois et leurs sponsors.
- Les matchs d'un tournoi.
- Les manches (maps/rounds) jouées au sein d'un match.
- Les serveurs de jeu et les arbitres affectés aux matchs.
[A - Contraintes Additionnelles] La modélisation et le dictionnaire de données doivent obligatoirement intégrer les trois éléments avancés suivants :
1. Une association réflexive : un joueur peut parrainer d'autres joueurs.
2. Une entité faible / identification relative : la manche (ou map) dépend obligatoirement d'un match et est identifiée de manière relative par rapport à celui-ci.
3. Une association ternaire (ou n-aire n > 2) : la planification d'un match associe un Match, un Serveur de jeu et un Arbitre.
Veille à ce que tous les attributs soient en 3FN (atomiques, sans dépendance partielle ni transitive).
[R - Références] Inspiré des fonctionnalités et structures de données des plateformes e-sport de référence comme Start.gg, Faceit et Battlefy.
[D - Rendement Désiré] Fournis une réponse structurée en deux parties : Partie 1 : "Règles Métier" (liste numérotée RM1, RM2, etc.). Partie 2 : "Dictionnaire de Données" (Tableau Markdown avec les colonnes : Entité, Nom de l'attribut, Code attribut, Type de donnée, Contraintes / Propriétés).
[O - Objectifs] Obtenir l'analyse des besoins nécessaire pour construire un Modèle Conceptuel de Données (MCD) valide et normalisé pour notre mini-projet de base de données.

### 2. Règles Métier (RM)

* **RM1 (Joueur & Parrainage)** : Un joueur est identifié par un identifiant unique. Un joueur peut parrainer plusieurs autres joueurs, mais il ne peut être parrainé que par un seul joueur (association réflexive).
* **RM2 (Équipe & Composition)** : Une équipe possède un nom et est créée par un joueur. Un joueur peut faire partie de plusieurs équipes au fil du temps, et une équipe est composée de plusieurs joueurs.
* **RM3 (Tournoi & Sponsor)** : Un tournoi est sponsorisé par un ou plusieurs sponsors, et un sponsor peut financer plusieurs tournois. L'association conserve le montant du sponsoring.
* **RM4 (Inscription Tournoi)** : Un tournoi accueille plusieurs équipes participantes. Une équipe peut s'inscrire à plusieurs tournois.
* **RM5 (Match & Tournoi)** : Un match appartient à un et un seul tournoi. Un tournoi comprend un ou plusieurs matchs.
* **RM6 (Planification - Ternaire)** : Un match est joué sur un et un seul serveur de jeu et est supervisé par un et un seul arbitre. Un serveur et un arbitre peuvent être affectés à plusieurs matchs à des moments différents.
* **RM7 (Manche - Entité Faible)** : Un match se compose d'une ou plusieurs manches (maps/rounds). Une manche n'a pas d'existence propre : elle est identifiée de manière relative par son numéro au sein du match.

### 3. Dictionnaire de Données (3FN)

| Entité / Association | Nom de l'attribut | Code attribut | Type de donnée | Contraintes / Propriétés |
| :--- | :--- | :--- | :--- | :--- |
| **JOUEUR** | Identifiant joueur | `id_joueur` | INT | PK, Auto-increment |
| | Pseudo | `pseudo` | VARCHAR(50) | UNIQUE, NOT NULL |
| | Adresse email | `email` | VARCHAR(255) | UNIQUE, NOT NULL |
| | Mot de passe (hash) | `mot_de_passe` | VARCHAR(255) | NOT NULL |
| | Date d'inscription | `date_inscription` | DATETIME | NOT NULL |
| | Identifiant parrain | `id_parrain` | INT | FK (JOUEUR.id_joueur), NULL |
| **EQUIPE** | Identifiant équipe | `id_equipe` | INT | PK, Auto-increment |
| | Nom de l'équipe | `nom_equipe` | VARCHAR(100) | UNIQUE, NOT NULL |
| | Date de création | `date_creation_equipe` | DATE | NOT NULL |
| | Identifiant capitaine | `id_capitaine` | INT | FK (JOUEUR.id_joueur), NOT NULL |
| **MEMBRE_EQUIPE** | Identifiant joueur | `id_joueur` | INT | PK, FK (JOUEUR.id_joueur) |
| | Identifiant équipe | `id_equipe` | INT | PK, FK (EQUIPE.id_equipe) |
| | Date d'arrivée | `date_rejoint` | DATE | PK, NOT NULL |
| | Date de départ | `date_quitte` | DATE | NULL |
| **TOURNOI** | Identifiant tournoi | `id_tournoi` | INT | PK, Auto-increment |
| | Nom du tournoi | `nom_tournoi` | VARCHAR(100) | NOT NULL |
| | Jeu concerné | `jeu` | VARCHAR(50) | NOT NULL |
| | Cashprize total | `cashprize` | DECIMAL(10,2) | NOT NULL, >= 0 |
| | Date de début | `date_debut` | DATETIME | NOT NULL |
| | Date de fin | `date_fin` | DATETIME | NOT NULL |
| **SPONSOR** | Identifiant sponsor | `id_sponsor` | INT | PK, Auto-increment |
| | Nom de l'entreprise | `nom_sponsor` | VARCHAR(100) | NOT NULL |
| | Contact principal | `email_contact` | VARCHAR(255) | NOT NULL |
| **SPONSORISER** | Identifiant tournoi | `id_tournoi` | INT | PK, FK (TOURNOI.id_tournoi) |
| | Identifiant sponsor | `id_sponsor` | INT | PK, FK (SPONSOR.id_sponsor) |
| | Dotation financière | `montant_sponsoring` | DECIMAL(10,2) | NOT NULL, > 0 |
| **INSCRIPTION_TOURNOI** | Identifiant tournoi | `id_tournoi` | INT | PK, FK (TOURNOI.id_tournoi) |
| | Identifiant équipe | `id_equipe` | INT | PK, FK (EQUIPE.id_equipe) |
| | Date d'inscription | `date_inscription_t` | DATETIME | NOT NULL |
| | Statut inscription | `statut_inscription` | VARCHAR(20) | CHECK (Valide, Attente, Refuse) |
| **SERVEUR** | Identifiant serveur | `id_serveur` | INT | PK, Auto-increment |
| | Nom / Nom d'hôte | `nom_serveur` | VARCHAR(100) | NOT NULL |
| | Adresse IP | `adresse_ip` | VARCHAR(45) | NOT NULL |
| | Région | `region` | VARCHAR(20) | NOT NULL |
| **ARBITRE** | Identifiant arbitre | `id_arbitre` | INT | PK, Auto-increment |
| | Nom | `nom_arbitre` | VARCHAR(50) | NOT NULL |
| | Prénom | `prenom_arbitre` | VARCHAR(50) | NOT NULL |
| | Certification | `niveau_certification` | VARCHAR(30) | NOT NULL |
| **MATCH** | Identifiant match | `id_match` | INT | PK, Auto-increment |
| | Identifiant tournoi | `id_tournoi` | INT | FK (TOURNOI.id_tournoi), NOT NULL |
| | Identifiant équipe A | `id_equipe_a` | INT | FK (EQUIPE.id_equipe), NOT NULL |
| | Identifiant équipe B | `id_equipe_b` | INT | FK (EQUIPE.id_equipe), NOT NULL |
| | Identifiant serveur | `id_serveur` | INT | FK (SERVEUR.id_serveur), NOT NULL |
| | Identifiant arbitre | `id_arbitre` | INT | FK (ARBITRE.id_arbitre), NOT NULL |
| | Date / Heure prévue | `date_heure_match` | DATETIME | NOT NULL |
| | Statut du match | `statut_match` | VARCHAR(20) | CHECK (Planifie, En cours, Termine, Annule) |
| | Score équipe A | `score_equipe_a` | INT | DEFAULT 0 |
| | Score équipe B | `score_equipe_b` | INT | DEFAULT 0 |
| **MANCHE (Entité faible)** | Identifiant match | `id_match` | INT | PK, FK (MATCH.id_match) |
| | Numéro de manche | `numero_manche` | INT | PK (Identification relative : 1, 2, 3...) |
| | Carte / Map jouée | `nom_map` | VARCHAR(50) | NOT NULL |
| | Durée (secondes) | `duree_secondes` | INT | NOT NULL |
| | Identifiant gagnant | `id_equipe_gagnante` | INT | FK (EQUIPE.id_equipe), NOT NULL |
