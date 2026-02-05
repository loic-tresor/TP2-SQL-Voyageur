-- ==========================================================
-- RÉPONSES AU TP VOYAGEUR (Basé sur ton schéma)
-- ==========================================================

-- 1. Tous les voyageurs
SELECT * FROM Voyageur;

-- 2. Nom et région de Corse
SELECT nom, region FROM Voyageur WHERE region = 'Corse';

-- 3. Logements dans les Alpes
SELECT * FROM Logement WHERE lieu = 'Alpes';

-- 4. Nom et type (Capacité > 30)
SELECT nom, type FROM Logement WHERE capacite > 30;

-- 5. Type Hôtel ou Gîte
SELECT * FROM Logement WHERE type IN ('Hôtel', 'Gîte');

-- 11. Les 2 logements avec la plus grande capacité
SELECT * FROM Logement ORDER BY capacite DESC LIMIT 2;

-- 16. Jointure Voyageur et Logement
SELECT V.nom, V.prenom, L.nom AS nom_logement
FROM Voyageur V
JOIN Sejour S ON V.idVoyageur = S.idVoyageur
JOIN Logement L ON S.codeLogement = L.code;

-- 19. Type et lieu visités par Nicolas Bouvier
SELECT L.type, L.lieu 
FROM Logement L
JOIN Sejour S ON L.code = S.codeLogement
JOIN Voyageur V ON S.idVoyageur = V.idVoyageur
WHERE V.nom = 'Bouvier' AND V.prenom = 'Nicolas';

-- 25. Voyageurs n'ayant effectué aucun séjour (LEFT JOIN)
SELECT V.* FROM Voyageur V
LEFT JOIN Sejour S ON V.idVoyageur = S.idVoyageur
WHERE S.idSejour IS NULL;

-- 43. Compter séjours en Corse
SELECT COUNT(*) 
FROM Sejour S
JOIN Logement L ON S.codeLogement = L.code
WHERE L.lieu = 'Corse';

-- 52. Temps total passé (fin - debut)
SELECT V.nom, SUM(S.fin - S.debut) AS total_jours
FROM Voyageur V
JOIN Sejour S ON V.idVoyageur = S.idVoyageur
GROUP BY V.idVoyageur, V.nom;