-- 1) Nombre de publication par institution

SELECT Institution.nom AS institution, COUNT(*) AS nombre_publications
FROM Affiliation
JOIN Institution ON Affiliation.etablissement = Institution.idInstitution
JOIN AuteurFiliation ON Affiliation.idAfiliation = AuteurFiliation.idAfiliation
JOIN AuteurArticle ON AuteurFiliation.idAuteur = AuteurArticle.idAuteur
GROUP BY Institution.nom;

-- 2) Nombre de publication par auteur

SELECT Auteur.nom AS auteur, COUNT(*) AS nombre_publications
FROM Auteur
JOIN AuteurFiliation ON Auteur.idAuteur = AuteurFiliation.idAuteur
JOIN AuteurArticle ON AuteurFiliation.idAuteur = AuteurArticle.idAuteur
GROUP BY Auteur.nom;

-- 3) Nombre d'auteur par affiliation

SELECT Affiliation.idAfiliation, COUNT(AuteurFiliation.idAuteur) AS nombre_auteurs
FROM Affiliation
LEFT JOIN AuteurFiliation ON Affiliation.idAfiliation = AuteurFiliation.idAfiliation
GROUP BY Affiliation.idAfiliation;

-- par etablissement et pays

-- SELECT Institution.nom AS etablissement, Pays.nom AS pays, COUNT(AuteurFiliation.idAuteur) AS nombre_auteurs
-- FROM AuteurFiliation
-- JOIN Affiliation ON AuteurFiliation.idAfiliation = Affiliation.idAfiliation
-- JOIN Institution ON Affiliation.etablissement = Institution.idInstitution
-- JOIN Pays ON Affiliation.pays = Pays.idPays
-- GROUP BY Institution.nom, Pays.nom;


-- 4) L'auteur ayant publié le plus grand nombre d'article au USA

SELECT Auteur.nom AS auteur, COUNT(AuteurArticle.idArticle) AS nombre_articles
FROM Auteur
JOIN AuteurFiliation ON Auteur.idAuteur = AuteurFiliation.idAuteur
JOIN Affiliation ON AuteurFiliation.idAfiliation = Affiliation.idAfiliation
JOIN Pays ON Affiliation.pays = Pays.idPays
JOIN AuteurArticle ON Auteur.idAuteur = AuteurArticle.idAuteur
WHERE Pays.nom = ' USA'
GROUP BY Auteur.idAuteur
ORDER BY nombre_articles DESC
LIMIT 1;


-- 5) Etablissement ayant le plus d'article publié

SELECT Institution.nom AS etablissement, COUNT(AuteurArticle.idArticle) AS nombre_articles
FROM Institution
JOIN Affiliation ON Institution.idInstitution = Affiliation.etablissement
JOIN AuteurFiliation ON Affiliation.idAfiliation = AuteurFiliation.idAfiliation
JOIN AuteurArticle ON AuteurFiliation.idAuteur = AuteurArticle.idAuteur
GROUP BY Institution.idInstitution
ORDER BY nombre_articles DESC
LIMIT 1;

-- 6) Le nombre d'article publié par année

SELECT annee, COUNT(idArticle) AS nombre_articles
FROM Article
GROUP BY annee
ORDER BY annee;

-- 7) L'article ayant la plus grande collaboration d'acteurs

SELECT Article.titre AS titre_article, COUNT(Auteur.idAuteur) AS nombre_auteurs
FROM Article
JOIN AuteurArticle ON Article.idArticle = AuteurArticle.idArticle
JOIN Auteur ON AuteurArticle.idAuteur = Auteur.idAuteur
GROUP BY Article.idArticle
ORDER BY nombre_auteurs DESC
LIMIT 1;


-- 8) L'auteur, son établissement, sa ville son pays, ayant publié le plus grand nombre d'article, ainsi que son nombre d'article publié

SELECT Auteur.nom AS auteur, Institution.nom AS etablissement, Pays.nom AS pays, COUNT(AuteurArticle.idArticle) AS nombre_articles
FROM Auteur
JOIN AuteurFiliation ON Auteur.idAuteur = AuteurFiliation.idAuteur
JOIN Affiliation ON AuteurFiliation.idAfiliation = Affiliation.idAfiliation
JOIN Institution ON Affiliation.etablissement = Institution.idInstitution
JOIN Pays ON Affiliation.pays = Pays.idPays
JOIN AuteurArticle ON Auteur.idAuteur = AuteurArticle.idAuteur
GROUP BY Auteur.idAuteur, Institution.idInstitution, Pays.idPays
ORDER BY nombre_articles DESC
LIMIT 1;