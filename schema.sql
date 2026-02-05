 
-- Table Voyageur
CREATE TABLE IF NOT EXISTS Voyageur (
idVoyageur INTEGER PRIMARY KEY,
   nom TEXT NOT NULL,
   prenom TEXT NOT NULL,
   ville TEXT,
   region TEXT
);
 
-- Table Logement
CREATE TABLE IF NOT EXISTS Logement (
   code TEXT PRIMARY KEY,
   nom TEXT NOT NULL,
   capacite INTEGER,
   type TEXT,
   lieu TEXT
);
 
-- Table Sejour
CREATE TABLE IF NOT EXISTS Sejour (
   idSejour INTEGER PRIMARY KEY,
   idVoyageur INTEGER NOT NULL,
   codeLogement TEXT NOT NULL,
   debut INTEGER,
   fin INTEGER,
   FOREIGN KEY (idVoyageur) REFERENCES Voyageur(idVoyageur),
   FOREIGN KEY (codeLogement) REFERENCES Logement(code)
);
 
-- Table Activite
CREATE TABLE IF NOT EXISTS Activite (
   codeLogement TEXT NOT NULL,
   codeActivite TEXT NOT NULL,
   description TEXT,
   PRIMARY KEY (codeLogement, codeActivite),
   FOREIGN KEY (codeLogement) REFERENCES Logement(code)
);
 
-- Insertion des données
 
-- Voyageurs
INSERT INTO Voyageur VALUES (10, 'Fogg',
'Phileas', 'Ajaccio', 'Corse');
INSERT INTO Voyageur VALUES (20,
'Bouvier', 'Nicolas', 'Aurillac', 'Auvergne');
INSERT INTO Voyageur VALUES (30,
'David-Néel', 'Alexandra', 'Lhassa', 'Tibet');
INSERT INTO Voyageur VALUES (40,
'Stevenson', 'Robert Louis', 'Vannes', 'Bretagne');
 
-- Logements
INSERT INTO Logement VALUES ('ca',
'Causses', 45, 'Auberge', 'Cévennes');
INSERT INTO Logement VALUES ('ge',
'Génépi', 134, 'Hôtel', 'Alpes');
INSERT INTO Logement VALUES ('pi', 'U
Pinzutu', 10, 'Gîte', 'Corse');
INSERT INTO Logement VALUES ('ta',
'Tabriz', 34, 'Hôtel', 'Bretagne');
 
-- Séjours
INSERT INTO Sejour VALUES (1, 10, 'pi',
20, 20);
INSERT INTO Sejour VALUES (2, 20, 'ta',
21, 22);
INSERT INTO Sejour VALUES (3, 30, 'ge', 2,
3);
INSERT INTO Sejour VALUES (4, 20, 'pi',
19, 23);
INSERT INTO Sejour VALUES (5, 20, 'ge',
22, 24);
INSERT INTO Sejour VALUES (6, 10, 'pi',
10, 12);
INSERT INTO Sejour VALUES (7, 30, 'ca',
13, 18);
 
-- Activités
INSERT INTO Activite VALUES ('ca',
'Randonnée', 'Sorties d’une journée en groupe');
INSERT INTO Activite VALUES ('ge',
'Piscine', 'Nage loisir non encadrée');
INSERT INTO Activite VALUES ('ge', 'Ski',
'Sur piste uniquement');
INSERT INTO Activite VALUES ('pi',
'Plongée', 'Baptêmes et préparation des brevets');
INSERT INTO Activite VALUES ('pi',
'Voile', 'Pratique du dériveur et du catamaran'); . 