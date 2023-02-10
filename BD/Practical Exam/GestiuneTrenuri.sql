CREATE DATABASE Gara
GO
USE Gara
GO

CREATE TABLE Tip(id_tip INT PRIMARY KEY IDENTITY,
descriere VARCHAR(100))

CREATE TABLE Tren(id_tren INT PRIMARY KEY IDENTITY,
nume VARCHAR(100),
id_tip INT FOREIGN KEY REFERENCES Tip(id_tip))

CREATE TABLE Statie(id_statie INT PRIMARY KEY IDENTITY,
nume VARCHAR(100))

CREATE TABLE Ruta(id_ruta INT PRIMARY KEY IDENTITY,
nume VARCHAR(100),
id_tren INT FOREIGN KEY REFERENCES Tren(id_tren))

CREATE TABLE StatieRuta(id_statie INT FOREIGN KEY REFERENCES Statie(id_statie),
id_ruta INT FOREIGN KEY REFERENCES Ruta(id_ruta),
ora_plecarii TIME,
ora_sosirii TIME,
CONSTRAINT pk_StatieRuta PRIMARY KEY (id_statie, id_ruta))


----------------------INSERARI----------------

INSERT INTO Tip(descriere) VALUES ('marfar'), ('de calatori'), ('de jucarie'), ('de epoca')

SELECT * FROM Tip

INSERT INTO Tren(nume, id_tip) VALUES ('Thomas', 3), ('Prometheus', 2), ('Emily', 3), ('Dan', 1), ('Apollo', 4)

SELECT * FROM Tren

INSERT INTO Ruta(nume, id_tren) VALUES ('Cluj-Dej', 1), ('Constanta-Timisoara', 2), ('Bucuresti-Tg Jiu', 3), ('Expozitie 1', 5), ('Expozitie 2', 5)

SELECT * FROM Ruta

INSERT INTO Statie(nume) VALUES ('Cluj'), ('Condtanta'), ('Timisoara'), ('Bucuresti'), ('Tg Jiu'), ('Iasi'), ('Chisinau'), ('Oradea')

SELECT * FROM Statie

SELECT R.id_ruta, S.id_statie FROM Ruta R INNER JOIN Statie S ON (R.nume LIKE '%' + S.nume + '%')

INSERT INTO StatieRuta(id_ruta, id_statie,  ora_sosirii, ora_plecarii) VALUES
(1, 1, '5:10:00', '5:40:00'), (1, 2, '6:10:00', '6:40:00'), (2, 3, '7:10:00', '7:40:00'),
    (3, 4, '8:10:00', '8:40:00'), (3, 5, '9:10:00', '9:40:00'), (3, 6, '10:10:00', '10:40:00')

SELECT * FROM StatieRuta

-- Creați o procedură stocată care primește o rută, o stație, ora sosirii, ora plecării și adaugă noua stație rutei. Dacă stația există deja, se actualizează ora sosirii și ora plecării.
GO

CREATE OR ALTER PROCEDURE update_StatieRuta
@ruta VARCHAR(100),
@statie VARCHAR(100),
@ora_sosirii TIME,
@ora_plecarii TIME
AS
BEGIN
	DECLARE @id_ruta INT = 0;
	SELECT TOP 1 @id_ruta=id_ruta FROM Ruta WHERE nume=@ruta;
	
	DECLARE @id_statie INT=0;
	SELECT TOP 1 @id_statie=id_statie FROM Statie WHERE nume=@statie;

	IF (EXISTS (SELECT * FROM StatieRuta WHERE id_ruta = @id_ruta AND id_statie = @id_statie))
		UPDATE StatieRuta SET ora_sosirii = @ora_sosirii, ora_plecarii = @ora_plecarii
		WHERE id_ruta = @id_ruta AND id_statie =@id_statie;
	ELSE
		INSERT INTO StatieRuta(id_ruta, id_statie, ora_sosirii, ora_plecarii) VALUES
		(@id_ruta, @id_statie, @ora_sosirii, @ora_plecarii);

END
GO

SELECT S.nume AS statie, R.nume AS ruta, SR.ora_plecarii, SR.ora_sosirii
FROM StatieRuta SR
INNER JOIN Statie S ON SR.id_statie = S.id_statie
INNER JOIN Ruta R ON SR.id_ruta = R.id_ruta;

EXEC update_StatieRuta 'Cluj-Dej', 'Cluj', '10:20:00','10:15:00';

--Creați un view care afișează numele rutelor care conțin toate stațiile.
GO

CREATE OR ALTER VIEW rute_toate_statiile AS
	SELECT R.nume FROM Ruta R INNER JOIN StatieRuta SR ON R.id_ruta=SR.id_ruta
	GROUP BY R.id_ruta, R.nume
	HAVING COUNT(*)=(SELECT COUNT(*) FROM Statie)
GO

SELECT * FROM rute_toate_statiile

--Creați o funcție care afișează toate stațiile care au mai mult de un tren la un anumit moment din zi

GO

CREATE OR ALTER FUNCTION statii_multe_trenuri()
RETURNS TABLE AS
	RETURN SELECT DISTINCT S.id_statie, S.nume
	FROM Statie S INNER JOIN StatieRuta SR1 ON SR1.id_statie = S.id_statie
	INNER JOIN StatieRuta SR2 ON SR1.id_statie = SR2.id_statie AND SR1.id_ruta != SR2.id_ruta
	WHERE (SR1.ora_plecarii BETWEEN SR2.ora_sosirii AND SR2.ora_plecarii) OR
	(SR1.ora_sosirii BETWEEN SR2.ora_sosirii AND SR2.ora_plecarii);
GO

SELECT * FROM statii_multe_trenuri()