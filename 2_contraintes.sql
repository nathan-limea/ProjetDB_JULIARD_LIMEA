USE e_sport;

-- Contrainte 1 : Vérifier que la date de fin d'un tournoi est postérieure ou égale à sa date de début
ALTER TABLE Tournoi 
ADD CONSTRAINT ck_tournoi_dates CHECK (date_fin >= date_debut);

-- Contrainte 2 : S'assurer que le score de l'équipe 1 ne peut pas être négatif
ALTER TABLE Match_Esport 
ADD CONSTRAINT ck_score_equipe1 CHECK (score_equipe1 >= 0);

-- Contrainte 3 : S'assurer que le score de l'équipe 2 ne peut pas être négatif
ALTER TABLE Match_Esport 
ADD CONSTRAINT ck_score_equipe2 CHECK (score_equipe2 >= 0);