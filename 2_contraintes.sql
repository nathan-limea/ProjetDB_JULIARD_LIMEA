-- Contraintes de validation sur la table TOURNOI
ALTER TABLE TOURNOI 
    ADD CONSTRAINT chk_cash_prize CHECK (cash_prize >= 0),
    ADD CONSTRAINT chk_dates_tournoi CHECK (date_fin >= date_debut);

-- Contraintes de validation sur la table MATCH
ALTER TABLE MATCH_E 
    ADD CONSTRAINT chk_scores_match CHECK (score_equipe_a >= 0 AND score_equipe_b >= 0),
    ADD CONSTRAINT chk_equipes_differentes CHECK (id_equipe_a <> id_equipe_b);

-- Contraintes de validation sur la table MANCHE
ALTER TABLE MANCHE 
    ADD CONSTRAINT chk_duree_manche CHECK (duree_seconde > 0),
    ADD CONSTRAINT chk_numero_manche CHECK (numero_manche > 0);