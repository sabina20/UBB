--crearea bazei de date

CREATE DATABASE LantMagazine
GO
USE LantMagazine
GO

CREATE TABLE Locatii(id_locatie INT PRIMARY KEY IDENTITY,
localitate VARCHAR(100),
strada VARCHAR(100),
numar INT,
cod_postal VARCHAR(100))

CREATE TABLE Clienti(id_client INT PRIMARY KEY IDENTITY,
nume VARCHAR(100),
prenume VARCHAR(100),
gen VARCHAR(100),
data_nasterii DATE)

CREATE TABLE Magazine(id_magazin INT PRIMARY KEY IDENTITY,
denumire VARCHAR(100),
an_deschidere INT,
id_locatie INT FOREIGN KEY REFERENCES Locatii(id_locatie),
)

CREATE TABLE ProduseFavorite(id_produs INT PRIMARY KEY IDENTITY,
denumire VARCHAR(100),
pret INT,
reducere INT,
id_client INT FOREIGN KEY REFERENCES Clienti(id_client),
)

CREATE TABLE MagazinClient(id_magazin INT FOREIGN KEY REFERENCES Magazine(id_magazin),
id_client INT FOREIGN KEY REFERENCES Clienti(id_client),
data_cumparare DATE,
pret_achitat INT,
CONSTRAINT pk_MagazinClien PRIMARY KEY (id_magazin, id_client))

--INSERARI

INSERT INTO Locatii(localitate, strada, numar, cod_postal) VALUES ('Cluj-Napoca', 'Mihai Eminescu', 223, '400460'), ('Targu-Mures', 'Rodnei', 46, '520320'),
('Cluj-Napoca', 'Albac', 5, '400430'), ('Oradea', 'Mihai Viteazu', 100, '511109')
SELECT * FROM Locatii

INSERT INTO Clienti(nume, prenume, gen, data_nasterii) VALUES ('Moldovan', 'Marius', 'masculin', '1974-02-16'), ('Pop', 'Carmina', 'feminin', '1990-10-02'),
('Albert', 'Irina', 'feminin', '1995-07-10'), ('Toma', 'Luca', 'masculin', '2000-11-02'), ('Matei', 'Tudor', 'masculin', '1980-04-12')
SELECT * FROM Clienti

INSERT INTO Magazine(denumire, an_deschidere, id_locatie) VALUES ('MATHLAB', 2010, 1), ('NATMAN', 2021, 1), ('ROTTER TAN', 2018, 1),
('ANOMIR AGRO', 2008, 2), ('MAKEBA', 2022, 2), ('DARINA', 2012, 2), ('AMELY SHOES', 2015, 3), ('AUCHAN', 2010, 3), ('CARREFOUR', 2021, 4)
SELECT * FROM Magazine

INSERT INTO ProduseFavorite(denumire, pret, reducere, id_client) VALUES ('saleuri', 12, 10, 1), ('adaptor auto', 60, 0, 1),
('cana termica', 80, 30, 2), ('lesa', 30, 15, 2), ('kit pictura', 45, 50, 2), ('masca faciala', 5, 0, 2), ('alune de padure', 23, 20, 3),
('costum carnaval', 155, 20, 4), ('kit cusut', 90, 10, 5)
SELECT * FROM ProduseFavorite

INSERT INTO MagazinClient(id_magazin, id_client, data_cumparare, pret_achitat) VALUES (8, 1, '2022-01-01', 160), (1, 2, '2023-01-02', 100),
(5, 2, '2021-09-20', 58), (3, 4, '2022-11-03', 290), (4, 5, '2022-05-16', 560), (7, 5, '2022-08-10', 190)
SELECT * FROM MagazinClient

--procedura stocata

GO

CREATE OR ALTER PROCEDURE AdaugareClientMagazinului
@id_client INT,
@id_magazin INT,
@data_cumparare DATE,
@pret_achitat INT
AS
BEGIN
	IF NOT(EXISTS (SELECT * FROM Clienti WHERE id_client = @id_client))
		PRINT 'Nu exista client cu id-ul dat in baza de date!'
	ELSE
	BEGIN
		IF NOT(EXISTS (SELECT * FROM Magazine WHERE id_magazin = @id_magazin))
			PRINT 'Nu exista magazin cu id-ul dat in baza de date!'
		ELSE
		BEGIN
			IF(EXISTS (SELECT * FROM MagazinClient WHERE id_client = @id_client AND id_magazin = @id_magazin))
			BEGIN
				UPDATE MagazinClient SET data_cumparare = @data_cumparare, pret_achitat = @pret_achitat WHERE id_client = @id_client AND id_magazin = @id_magazin
				PRINT 'Aceasta asociere exista deja, asa ca au fost updatate data si pretul cumparaturilor.'
			END
			ELSE
			BEGIN
				INSERT INTO MagazinClient(id_magazin, id_client, data_cumparare, pret_achitat) VALUES (@id_magazin, @id_client, @data_cumparare, @pret_achitat)
				PRINT 'Informatiile despre cumparaturile clientului introdus au fost adaugate.'
			END
		END
	END
END
GO

SELECT * FROM MagazinClient

EXEC AdaugareClientMagazinului 7, 2, '2022-08-01', 120
EXEC AdaugareClientMagazinului 1, 10, '2022-08-02', 170
EXEC AdaugareClientMagazinului 2, 1, '2023-01-05', 80
EXEC AdaugareClientMagazinului 3, 1, '2022-12-08', 66

--view
GO

CREATE OR ALTER VIEW ClientiFavoriteView AS
	SELECT C.Nume, COUNT(PF.id_produs) AS NumarProduseFavorite FROM Clienti C
	INNER JOIN ProduseFavorite PF ON PF.id_client = C.id_client
	GROUP BY C.nume
	HAVING COUNT(PF.id_produs) <=3
GO

SELECT * FROM ClientiFavoriteView