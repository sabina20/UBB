CREATE DATABASE Biblioteca
GO
USE Biblioteca
GO

CREATE TABLE Librarie(id_librarie INT PRIMARY KEY IDENTITY,
nume VARCHAR(100),
adresa VARCHAR(100))

CREATE TABLE Domeniu(id_domeniu INT PRIMARY KEY IDENTITY,
descriere VARCHAR(100))

CREATE TABLE Autor(id_autor INT PRIMARY KEY IDENTITY,
nume VARCHAR(100))

CREATE TABLE Carte(id_carte INT PRIMARY KEY IDENTITY,
titlu VARCHAR(100),
id_domeniu INT FOREIGN KEY REFERENCES Domeniu(id_domeniu),
)

CREATE TABLE CarteLibrarie(id_carte INT FOREIGN KEY REFERENCES Carte(id_carte),
id_librarie INT FOREIGN KEY REFERENCES Librarie(id_librarie),
data_cumparare DATE,
CONSTRAINT pk_CarteLibrarie PRIMARY KEY (id_carte, id_librarie))

CREATE TABLE CarteAutor(id_carte INT FOREIGN KEY REFERENCES Carte(id_carte),
id_autor INT FOREIGN KEY REFERENCES Autor(id_autor),
CONSTRAINT pk_CarteAutor PRIMARY KEY (id_carte, id_autor))

------INSERARI------------

INSERT INTO Domeniu(descriere) VALUES ('romatism'), ('drama'), ('roman politist'), ('poezie'), ('cultural'), ('psihologie')
SELECT * FROM Domeniu

INSERT INTO Librarie(nume, adresa) VALUES ('Hera', 'Mihai Eminescu 5'), ('Libris', 'Bucuresti 155'), ('Luceafarul', 'Liviu Rebreanu 2'),
('Magna', 'Mihai Viteazu 23A')
SELECT * FROM Librarie

INSERT INTO Autor(nume) VALUES ('Mihai Eminescu'), ('Nicholas Sparks'), ('Agatha Christie'), ('Daniel Siegel'), ('Marin Sorescu')
SELECT * FROM Autor

INSERT INTO Carte(titlu, id_domeniu) VALUES ('Luceafarul',4), ('Mindsight', 6), ('Midnight thoughts', 1), ('Iona' , 2), ('10 negrii mititei', 3), ('The notebook', 1)
SELECT * FROM Carte

INSERT INTO CarteLibrarie(id_carte, id_librarie, data_cumparare) VALUES (1, 2, '2022-09-13'), (1, 3, '2022-05-07'), (3, 2, '2021-12-02'),
(4, 4, '2022-01-01'), (4, 1, '2023-01-03')
SELECT * FROM CarteLibrarie

INSERT INTO CarteAutor(id_carte, id_autor) VALUES (1, 1), (2, 4), (3, 2), (3, 5), (4, 5), (5, 3), (6, 2)
SELECT * FROM CarteAutor

--procedura care primeste un nume de autor si o carte si asociaza autorul cartii; daca autorul nu exista il adauga mai intai la autori; daca
--asocierea existe deja se afiseaza un mesaj
GO

CREATE OR ALTER PROCEDURE AsociereCarteAutor
@nume VARCHAR(100),
@titlu VARCHAR(100)
AS
BEGIN
	IF (EXISTS (SELECT * FROM Autor WHERE nume = @nume))
	BEGIN
		IF(EXISTS (SELECT * FROM CarteAutor CA, Carte C, Autor A WHERE C.titlu = @titlu AND C.id_carte = CA.id_carte AND A.nume = @nume AND A.id_autor = CA.id_autor))
			PRINT 'Exista deja asocierea intre autorul si cartea introduse'
		ELSE
		BEGIN
			DECLARE @id_carte INT
			SET @id_carte = (SELECT id_carte FROM Carte WHERE titlu = @titlu)
			DECLARE @id_autor INT
			SET @id_autor = (SELECT id_autor FROM Autor WHERE nume = @nume)
			INSERT INTO CarteAutor(id_carte, id_autor) VALUES (@id_carte, @id_autor)
			PRINT 'Asocierea dintre autorul ' + @nume + ' si cartea ' + @titlu + ' a fost adaugata cu succes!'
		END
	END
	ELSE
	BEGIN
		INSERT INTO Autor(nume) VALUES (@nume)
		PRINT 'Autorul cu numele ' + @nume + ' a fost adaugat cu succes in baza de date!'
		DECLARE @id_carte2 INT
		SET @id_carte2 = (SELECT id_carte FROM Carte WHERE titlu = @titlu)
		DECLARE @id_autor2 INT
		SET @id_autor2 = (SELECT id_autor FROM Autor WHERE nume = @nume)
		INSERT INTO CarteAutor(id_carte, id_autor) VALUES (@id_carte2, @id_autor2)
		PRINT 'Asocierea dintre autorul ' + @nume + ' si cartea ' + @titlu + ' a fost adaugata cu succes!'
	END
END
GO

EXEC AsociereCarteAutor 'Veronica Micle', 'Luceafarul'
EXEC AsociereCarteAutor 'Nicholas Sparks', '10 negrii mititei'
EXEC AsociereCarteAutor 'Sandra Brown', 'The notebook'
SELECT * FROM CarteAutor
SELECT * FROM Autor
SELECT * FROM Carte


--View care afiseaza numarul cartilor cumparate dupa anul 2010 din fiecare librarie; se exclud librariile in care numarul cartilor cumparate a fost < 5;
--datele se vor afisa in ordinea invers alfabetica a numelor librariilor
GO

SELECT * FROM CarteLibrarie

INSERT INTO CarteLibrarie(id_carte, id_librarie, data_cumparare) VALUES (1, 4, '2022-09-13'), (2, 3, '2022-05-07'), (2, 2, '2021-12-02'),
(4, 2, '2022-01-01'), (5, 2, '2023-01-03'), (2, 4, '2012-08-07'), (3, 4, '2019-10-20'), (5, 4, '2020-04-08')


SELECT * FROM Librarie
SELECT * FROM Carte
SELECT * FROM CarteLibrarie

GO
CREATE OR ALTER VIEW NrVanzariView AS
	SELECT TOP 1000 L.Nume, COUNT(CL.data_cumparare) AS Numar_Carti FROM Librarie L, CarteLibrarie CL WHERE YEAR(CL.data_cumparare) > 2010 AND CL.id_librarie = L.id_librarie
	GROUP BY L.Nume
	HAVING COUNT(CL.data_cumparare) >= 5
	ORDER BY L.nume DESC
GO

--functie care afiseaza o lista a cartilor ce au fost scrise de un numar de autori, ordonate dupa tipul cartii; coloane: Libraria, Adresa, Titlul, NrAutori

CREATE OR ALTER FUNCTION CartiNrAutori (@nr_autori INT)
RETURNS TABLE AS
	RETURN (SELECT TOP 1000 L.nume, L.adresa, C.titlu, D.descriere, COUNT(CA.id_autor) AS NrAutori FROM Carte C 
	INNER JOIN Domeniu D ON C.id_domeniu = D.id_domeniu
	INNER JOIN CarteLibrarie CL ON CL.id_carte = C.id_carte
	INNER JOIN CarteAutor CA ON CA.id_carte = C.id_carte
	INNER JOIN Librarie L ON CL.id_librarie = L.id_librarie
	GROUP BY L.nume, L.adresa, C.titlu, D.descriere 
	HAVING COUNT(CA.id_autor) = @nr_autori
	ORDER BY D.descriere)
GO

SELECT * FROM CartiNrAutori(1) 

SELECT DISTINCT * FROM Carte,Carte