USE Cofetarie
GO

CREATE OR ALTER FUNCTION dbo.TestIngredient(@cantitate INT, @pret FLOAT, @expirare DATE)
RETURNS INT
AS
BEGIN
	IF @cantitate < 0 RETURN 0
	IF @pret < 0 RETURN 0
	IF @expirare < GETDATE() RETURN 0
	RETURN 1
END
GO

CREATE OR ALTER PROCEDURE CRUD_Ingredient
@denumire varchar(30),
@cantitate int,
@pret float,
@expirare date,
@noOfRows int
AS
BEGIN
--validation
IF dbo.TestIngredient(@cantitate, @pret, @expirare)=1
BEGIN
	--CREATE = INSERT
	DECLARE @n int=1
	WHILE @n <= @noOfRows
	BEGIN
		INSERT INTO Ingredient(Denumire, Cantitate, Pret, Expirare) VALUES (@denumire, @cantitate, @pret, @expirare)
		SET @n = @n+1
	END

	--READ = SELECT
	SELECT * FROM Ingredient

	--UPDATE
	UPDATE Ingredient SET Cantitate = 100 WHERE Denumire = 'Iaurt'

	--DELETE
	DELETE FROM Ingredient WHERE Denumire = 'Ingr'

	PRINT 'Done CRUD operations for table Ingredient'
END
ELSE PRINT 'Validation for Ingredient failed'
END

GO

CREATE OR ALTER FUNCTION dbo.TestReteta(@timp INT)
RETURNS INT
AS
BEGIN
	IF @timp > 300 RETURN 0
	RETURN 1
END
GO


CREATE OR ALTER PROCEDURE CRUD_Reteta
@titlu varchar(30),
@timp int,
@modPreparare varchar(30),
@noOfRows int
AS
BEGIN
IF dbo.TestReteta(@timp) = 1
BEGIN
	--CREATE = INSERT
	DECLARE @n int=1
	WHILE @n <= @noOfRows
	BEGIN
		INSERT INTO Reteta(Titlu, Timp, ModPreparare) VALUES (@titlu, @timp, @modPreparare)
		SET @n = @n+1
	END

	--READ = SELECT
	SELECT * FROM Reteta

	--UPDATE
	UPDATE Reteta SET Timp = 100 WHERE ModPreparare = 'coacere' AND Titlu LIKE 'S%'

	--DELETE
	DELETE FROM Reteta WHERE Timp = 150

	PRINT 'Done CRUD operations for table Reteta'
END
ELSE PRINT 'Validation for Reteta failed'
END
GO

CREATE OR ALTER FUNCTION dbo.TestRetetaIngredient(@idR INT, @idI INT)
RETURNS INT
AS
BEGIN
	IF NOT EXISTS (SELECT * FROM Reteta WHERE ID_Reteta=@idR) RETURN 0
	IF NOT EXISTS (SELECT * FROM Ingredient WHERE ID_Ingredient=@idI) RETURN 0
	RETURN 1
END
GO

CREATE OR ALTER PROCEDURE CRUD_RetetaIngredient
@idR INT,
@idI INT,
@noOfRows INT
AS
BEGIN
IF dbo.TestRetetaIngredient(@idR, @idI)=1
BEGIN
	--CREATE = INSERT
	DECLARE @n int=1
	WHILE @n <= @noOfRows
	BEGIN
		INSERT INTO RetetaIngredient(ID_Reteta, ID_Ingredient) VALUES (@idR, @idI)
		SET @n = @n+1
	END

	--READ = SELECT
	SELECT * FROM RetetaIngredient

	--UPDATE
	UPDATE RetetaIngredient SET ID_Test = 100 WHERE ID_Reteta > 7

	--DELETE
	DELETE FROM RetetaIngredient WHERE ID_Reteta > 7

	PRINT 'Done CRUD operations for table RetetaIngredient'
END
ELSE PRINT 'Validation for RetetaIngredient failed'
END
GO

--EXEC CRUD
EXEC CRUD_Reteta 'Reteta', 130, 'fierbere', 20
EXEC CRUD_Ingredient 'Ingredient', 7, 5.5, '2022-12-30', 20
EXEC CRUD_RetetaIngredient 200, 105, 1

SELECT * FROM Reteta
SELECT * FROM Ingredient
SELECT * FROM RetetaIngredient

GO 

--VIEWS
CREATE OR ALTER VIEW ViewTimpReteta
AS
	SELECT Timp FROM Reteta WHERE Timp < 110
GO

SELECT * FROM ViewTimpReteta

GO

CREATE OR ALTER VIEW ViewIngredientPret
AS
	SELECT I.Pret FROM Ingredient I
	WHERE I.Pret > 10
GO

SELECT * FROM ViewIngredientPret

GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name='N_idx_Timp')
	DROP INDEX N_idx_Timp ON Reteta
GO
CREATE NONCLUSTERED INDEX N_idx_Timp ON Reteta(Timp);
GO

IF EXISTS (SELECT name FROM sys.indexes WHERE name='N_idx_Pret')
	DROP INDEX N_idx_Pret ON Ingredient
GO
CREATE NONCLUSTERED INDEX N_idx_Pret ON Ingredient(Pret);
GO
