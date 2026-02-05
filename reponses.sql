-- ==========================================================
--              TP2 SQL : RÉPONSES COMPLÈTES 
-- ==========================================================

-- I. SÉLECTIONS SIMPLES
-- 1. Afficher tous les voyageurs 
SELECT * FROM Voyageur;

-- 2. Nom et région des voyageurs vivant en Corse
SELECT nom, region FROM Voyageur WHERE region = 'Corse';

-- 3. Logements situés dans les Alpes
SELECT * FROM Logement WHERE lieu = 'Alpes';

-- 4. Nom et type des logements (capacité > 30)
SELECT nom, type FROM Logement WHERE capacite > 30;

-- 5. Logements de type Hôtel ou Gîte
SELECT * FROM Logement WHERE type IN ('Hôtel', 'Gîte');

-- 6. Voyageurs dont la région n’est pas Bretagne
SELECT * FROM Voyageur WHERE region <> 'Bretagne';

-- 7. Séjours commençant avant le jour 20
SELECT * FROM Sejour WHERE debut < 20;

-- 8. Activités dont la description contient 'dériveur'
SELECT * FROM Activite WHERE description LIKE '%dériveur%';

-- II. TRI ET LIMITATION
-- 9. Voyageurs triés par nom
SELECT * FROM Voyageur ORDER BY nom ASC;

-- 10. Logements triés par capacité décroissante
SELECT * FROM Logement ORDER BY capacite DESC;

-- 11. Les 2 logements avec la plus grande capacité
SELECT * FROM Logement ORDER BY capacite DESC LIMIT 2;

-- III. CONJONCTION, DISJONCTION ET NÉGATION
-- 12. Voyageurs Corse ou Bretagne
SELECT * FROM Voyageur WHERE region = 'Corse' OR region = 'Bretagne';

-- 13. Logements en Corse et de type Gîte
SELECT * FROM Logement WHERE lieu = 'Corse' AND type = 'Gîte';

-- 14. Logements non situés en Alpes
SELECT * FROM Logement WHERE lieu <> 'Alpes';

-- 15. Séjours début > 15 et fin < 23
SELECT * FROM Sejour WHERE debut > 15 AND fin < 23;

-- IV. JOINTURES
-- 16. Nom voyageurs et nom logement
SELECT V.nom, L.nom AS nom_logement 
FROM Voyageur V 
JOIN Sejour S ON V.idVoyageur = S.idVoyageur 
JOIN Logement L ON S.codeLogement = L.code;

-- 17. Voyageurs ayant séjourné en Corse
SELECT DISTINCT V.* FROM Voyageur V 
JOIN Sejour S ON V.idVoyageur = S.idVoyageur 
JOIN Logement L ON S.codeLogement = L.code 
WHERE L.lieu = 'Corse';

-- 18. Voyageurs ayant séjourné dans les Alpes
SELECT DISTINCT V.* FROM Voyageur V 
JOIN Sejour S ON V.idVoyageur = S.idVoyageur 
JOIN Logement L ON S.codeLogement = L.code 
WHERE L.lieu = 'Alpes';

-- 19. Type et lieu des logements visités par Nicolas Bouvier
SELECT L.type, L.lieu FROM Logement L 
JOIN Sejour S ON L.code = S.codeLogement 
JOIN Voyageur V ON S.idVoyageur = V.idVoyageur 
WHERE V.nom = 'Bouvier' AND V.prenom = 'Nicolas';

-- 20. Activités des logements où Phileas Fogg a séjourné
SELECT DISTINCT A.codeActivite, A.description 
FROM Activite A 
JOIN Sejour S ON A.codeLogement = S.codeLogement 
JOIN Voyageur V ON S.idVoyageur = V.idVoyageur 
WHERE V.nom = 'Fogg' AND V.prenom = 'Phileas';

-- 21. Séjours avec nom voyageur et lieu du logement
SELECT S.*, V.nom, L.lieu FROM Sejour S 
JOIN Voyageur V ON S.idVoyageur = V.idVoyageur 
JOIN Logement L ON S.codeLogement = L.code;

-- 22. Voyageurs avec au moins un séjour et l'ID du séjour
SELECT V.nom, S.idSejour FROM Voyageur V 
JOIN Sejour S ON V.idVoyageur = S.idVoyageur;

-- 23/24. Tous les voyageurs et leurs séjours s’ils existent
SELECT V.nom, S.idSejour FROM Voyageur V 
LEFT JOIN Sejour S ON V.idVoyageur = S.idVoyageur;

-- 25. Voyageurs n'ayant effectué aucun séjour
SELECT V.* FROM Voyageur V 
LEFT JOIN Sejour S ON V.idVoyageur = S.idVoyageur 
WHERE S.idSejour IS NULL;

-- 26. Tous les logements et activités proposées
SELECT L.nom, A.description FROM Logement L 
LEFT JOIN Activite A ON L.code = A.codeLogement;

-- 27. Tous les séjours même si le logement n'existe pas
SELECT S.* FROM Sejour S 
LEFT JOIN Logement L ON S.codeLogement = L.code;

-- 28. Tous les voyageurs et tous les séjours (Full Match)
-- Note : SQLite ne supporte pas FULL OUTER JOIN, on utilise UNION de LEFT et RIGHT si besoin.
SELECT V.nom, S.idSejour FROM Voyageur V LEFT JOIN Sejour S ON V.idVoyageur = S.idVoyageur
UNION
SELECT V.nom, S.idSejour FROM Sejour S LEFT JOIN Voyageur V ON S.idVoyageur = V.idVoyageur;

-- 29. Logements sans activité
SELECT L.* FROM Logement L 
LEFT JOIN Activite A ON L.code = A.codeLogement 
WHERE A.codeActivite IS NULL;

-- 31. Afficher tous les logements et leur codeActivite (même si NULL)
SELECT L.nom AS logement, A.codeActivite
FROM Logement L
LEFT JOIN Activite A ON L.code = A.codeLogement;

-- V. CONDITIONS ET FILTRES
-- 32. Voyageurs (logement capacité > 30)
SELECT DISTINCT V.* FROM Voyageur V 
JOIN Sejour S ON V.idVoyageur = S.idVoyageur 
JOIN Logement L ON S.codeLogement = L.code 
WHERE L.capacite > 30;

-- 34. Voyageurs n'ayant jamais séjourné dans un hôtel
SELECT * FROM Voyageur WHERE idVoyageur NOT IN (
    SELECT idVoyageur FROM Sejour S JOIN Logement L ON S.codeLogement = L.code WHERE L.type = 'Hôtel'
);

-- VI. AGRÉGATS
-- 36. Compter voyageurs
SELECT COUNT(*) FROM Voyageur;

-- 37. Nombre de logements par type
SELECT type, COUNT(*) FROM Logement GROUP BY type;

-- 40. Capacité moyenne
SELECT AVG(capacite) FROM Logement;

-- 43. Combien de séjours en Corse
SELECT COUNT(*) FROM Sejour S JOIN Logement L ON S.codeLogement = L.code WHERE L.lieu = 'Corse';

-- VII. SOUS-REQUÊTES
-- 47. Logements sans activités (NOT IN)
SELECT * FROM Logement WHERE code NOT IN (SELECT codeLogement FROM Activite);

-- VIII. OPÉRATIONS ENSEMBLISTES
-- 49. Régions voyageurs ou lieux logements (UNION)
SELECT region FROM Voyageur UNION SELECT lieu FROM Logement;

-- IX. POUR ALLER PLUS LOIN
-- 52. Temps total passé par voyageur
SELECT V.nom, SUM(S.fin - S.debut) as total_jours 
FROM Voyageur V 
JOIN Sejour S ON V.idVoyageur = S.idVoyageur 
GROUP BY V.idVoyageur;