USE Cofetarie
GO


--help procedures
ALTER TABLE Ingredient
ADD ID_Test INT
GO

CREATE OR ALTER PROCEDURE InsertIntoIngredient @id INT
AS
BEGIN
	DECLARE @counter INT
	SET @counter = 1
	WHILE (@counter <= 1000)
	BEGIN
		INSERT INTO Ingredient(Denumire,Cantitate,Pret,Expirare) VALUES ('Ingredient', 50, 100, '20230101')
		SET @counter = @counter + 1
	END
END
GO

EXEC InsertIntoIngredient 100


--TABLES (Insert + Delete)

--Table with a primary key and no foreign keys: Reteta
ALTER TABLE Reteta 
ADD ID_Test INT
GO

CREATE OR ALTER PROCEDURE InsertIntoReteta @id INT
AS
BEGIN
	DECLARE @number INT
	SET @number = (SELECT FLOOR(RAND()*(1000)))

	DECLARE @titlu VARCHAR(30)
	SET @titlu = 'Reteta' + CONVERT(VARCHAR(5), @number)

	DECLARE @timp INT
	SET @timp = (SELECT FLOOR(RAND()*(200-10)+10))

	DECLARE @mod VARCHAR(30)
	SET @mod = 'ModPreparare' + CONVERT(VARCHAR(5), @number)

	INSERT INTO Reteta(ID_Test, Titlu, Timp, ModPreparare) VALUES (@id,@titlu, @timp, @mod)
END
GO

CREATE OR ALTER PROCEDURE DeleteFromReteta @id INT
AS
BEGIN
	DELETE FROM Reteta WHERE ID_Test = @id
END
GO

--Table with a primary key and one foreign key: Recenzie
ALTER TABLE Recenzie
ADD ID_Test INT
GO

CREATE OR ALTER PROCEDURE InsertIntoRecenzie @id INT
AS
BEGIN
	DECLARE @nota INT
	SET @nota = (SELECT FLOOR(RAND()*(10-1)+1))

	DECLARE @client INT
	SET @client = (SELECT TOP 1 Cod_Client FROM Client ORDER BY  NEWID())

	INSERT INTO Recenzie(ID_Test,Nota, Cod_Client) VALUES (@id,@nota, @client)
END
GO

CREATE OR ALTER PROCEDURE DeleteFromRecenzie @id INT
AS
BEGIN
	DELETE FROM Recenzie WHERE ID_Test = @id
END
GO

--Table with two primary keys: RetetaIngredient
ALTER TABLE RetetaIngredient
ADD ID_Test INT
GO

CREATE OR ALTER PROCEDURE InsertIntoRetetaIngredient @id INT
AS
BEGIN
	DECLARE @id_reteta INT
	SET @id_reteta = (SELECT TOP 1 ID_Reteta FROM Reteta ORDER BY NEWID())

	DECLARE @id_ingredient INT
	SET @id_ingredient = (SELECT TOP 1 ID_Ingredient FROM Ingredient ORDER BY NEWID())

	IF (NOT EXISTS(SELECT * FROM RetetaIngredient WHERE ID_Reteta = @id_reteta AND ID_Ingredient = @id_ingredient))
	BEGIN
		INSERT INTO RetetaIngredient(ID_Test,ID_Reteta, ID_Ingredient) VALUES (@id,@id_reteta, @id_ingredient)
	END
END
GO

CREATE OR ALTER PROCEDURE DeleteFromRetetaIngredient @id INT
AS
BEGIN
	DELETE FROM RetetaIngredient WHERE ID_Test = @id
END
GO

--VIEWS

--View with a SELECT statement operating on one table
--products over 200g
CREATE OR ALTER VIEW ViewProdusMare
AS
	SELECT Denumire, Gramaj FROM Produs WHERE Gramaj>200
GO

SELECT * FROM ViewProdusMare
GO

--View with a SELECT statement operating on at least 2 tables
--name of clients who wrote reviews
CREATE OR ALTER VIEW ViewClientRecenzie
AS
	SELECT C.Nume, R.Nota FROM Client C, Recenzie R WHERE R.Cod_Client = C.Cod_Client
GO

SELECT * FROM ViewClientRecenzie
GO

--View with a SELECT statement that has a GROUP BY clause and operates on at least 2 tables
--number of ingredients who expires before 01.01.2023 for every location
CREATE OR ALTER VIEW ViewIngredienteExp
AS 
	SELECT L.Adresa, COUNT(P.ID_Produs) AS IngredienteExp FROM Produs P, Ingredient I, ProdusIngredient PrI, Locatie L
	WHERE I.Expirare <= '20230101' AND I.ID_Ingredient = PrI.ID_Ingredient AND PrI.ID_Produs = P.ID_Produs AND P.ID_Locatie = L.ID_Locatie
	GROUP BY L.Adresa
GO

SELECT * FROM ViewIngredienteExp
GO

