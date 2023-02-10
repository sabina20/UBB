USE Cofetarie
GO

--modifica tipul unei coloane
CREATE OR ALTER PROCEDURE do_modify_type
AS
BEGIN
	ALTER TABLE Ingredient
	ALTER COLUMN Cantitate smallint
	PRINT 'Campul Cantitate din tabelul Ingredient are tipul smallint'
END
GO

CREATE OR ALTER PROCEDURE undo_modify_type
AS
BEGIN
	ALTER TABLE Ingredient
	ALTER COLUMN Cantitate int
	PRINT 'Campul Cantitate din tabelul Ingredient are tipul int'
END
GO

--adauga/elimina o constrangere de valoare implicita
CREATE OR ALTER PROCEDURE add_constraint
AS
BEGIN
	ALTER TABLE Reteta
	ADD CONSTRAINT df_timp DEFAULT 60 FOR Timp
	PRINT 'Campul Timp din tabelul Reteta are valoarea default 60'
END
GO

CREATE OR ALTER PROCEDURE remove_constraint
AS
BEGIN
	ALTER TABLE Reteta
	DROP CONSTRAINT df_timp
	PRINT 'Campul Timp din tabelul Reteta nu mai are valoarea default 60'
END
GO

--creeaza/sterge un tabel
CREATE OR ALTER PROCEDURE create_table
AS
BEGIN
	CREATE TABLE Masina(NrInmatriculare varchar(10) NOT NULL PRIMARY KEY,
	SoferPrincipal varchar(30),
	Marca varchar(30))
	PRINT 'A fost creat tabelul Masina'
END
GO

CREATE OR ALTER PROCEDURE remove_table
AS
BEGIN
	DROP TABLE Masina
	PRINT 'Tabelul Masina a fost sters'
END
GO

--adauga/sterge un camp
CREATE OR ALTER PROCEDURE add_column
AS
BEGIN
	ALTER TABLE Masina
	ADD Culoare varchar(30)
	PRINT 'Tabelului Masina i-a fost adaugat campul Culoare'
END
GO

CREATE OR ALTER PROCEDURE remove_column
AS
BEGIN
	ALTER TABLE Masina
	DROP COLUMN Culoare
	PRINT 'Tabelului Masina i-a fost sters campul Culoare'
END
GO

--creeaza/sterge o constrangere de tip foreign key
CREATE OR ALTER PROCEDURE add_foreign_key
AS
BEGIN
	ALTER TABLE Masina
	ADD CNP_SoferPrinc varchar(15) NOT NULL
	ALTER TABLE Masina
	ADD CONSTRAINT fk_MasinaAngajat FOREIGN KEY (CNP_SoferPrinc) REFERENCES Angajat(CNP)
	PRINT 'Tabelului Masina i-a fost adaugata cheia straina CNP_SoferPrinc'
END
GO

CREATE OR ALTER PROCEDURE remove_foreign_key
AS
BEGIN
	ALTER TABLE Masina
	DROP CONSTRAINT fk_MasinaAngajat
	PRINT 'Tabelului Masina i-a fost stearsa cheia straina CNP_SoferPrinc'
END
GO


CREATE TABLE VersionHistory (Version INT PRIMARY KEY)
INSERT INTO VersionHistory(Version) VALUES (0)

CREATE TABLE VersionUpdate(DoProcedure varchar(50),
UndoProcedure varchar(50),
CurrentVersion int)
INSERT INTO VersionUpdate(DoProcedure, UndoProcedure, CurrentVersion)
VALUES ('do_modify_type', 'undo_modify_type', 1),
('add_constraint', 'remove_constraint', 2),
('create_table', 'remove_table', 3),
('add_column', 'remove_column', 4),
('add_foreign_key', 'remove_foreign_key', 5)

DROP TABLE VersionUpdate

GO
CREATE OR ALTER PROCEDURE change_version @VersionInput INT
AS
BEGIN
	DECLARE @CurrentVersion INT
	SET @CurrentVersion = (SELECT * FROM VersionHistory)
	PRINT 'Current version is ' + CAST(@CurrentVersion AS varchar(2))

	IF @VersionInput NOT BETWEEN 0 AND 5
		BEGIN
			RAISERROR('Versiunea data ca parametru trenuie sa fie intre 0 si 5!', 11, 1)
			RETURN
		END
	ELSE
	IF @CurrentVersion = @VersionInput
		BEGIN
			PRINT 'Baza de date se afla deja la aceasta versiune'
			RETURN
		END
	ELSE
	IF @CurrentVersion < @VersionInput
		BEGIN
			PRINT 'Versiune curenta < Versiune ceruta'
			WHILE @CurrentVersion < @VersionInput
				BEGIN
					DECLARE @Procedure VARCHAR(50)
					SET @Procedure = (SELECT DoProcedure FROM VersionUpdate V WHERE V.CurrentVersion = @CurrentVersion + 1)
					EXEC(@Procedure)
					PRINT 'Execute ' + @Procedure
					SET @CurrentVersion = @CurrentVersion + 1
				END
		END
	ELSE
	IF @CurrentVersion > @VersionInput
		BEGIN
			PRINT 'Versiune curenta > Versiune ceruta'
			WHILE @CurrentVersion > @VersionInput
				BEGIN
					DECLARE @Procedure2 VARCHAR(50)
					SET @Procedure2 = (SELECT UndoProcedure FROM VersionUpdate V WHERE V.CurrentVersion = @CurrentVersion)
					EXEC(@Procedure2)
					PRINT 'Execute ' + @Procedure2
					SET @CurrentVersion = @CurrentVersion - 1
				END
		END

	UPDATE VersionHistory
	SET Version = @VersionInput
	PRINT 'Versiunea a fost updatata'
END
GO

EXEC change_version 50
SELECT * FROM VersionHistory