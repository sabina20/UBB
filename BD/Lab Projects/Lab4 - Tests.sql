USE Cofetarie
GO

--add test to Tests table
CREATE OR ALTER PROCEDURE AddTest @name VARCHAR(30)
AS
BEGIN
	IF EXISTS(SELECT * FROM Tests WHERE Name = @name)
	BEGIN
		PRINT 'Testul exista deja'
		RETURN
	END
	INSERT INTO Tests(Name) VALUES (@name)
END
GO

--add table to Tables table
CREATE OR ALTER PROCEDURE AddTable @tableName VARCHAR(30)
AS
BEGIN
	IF EXISTS(SELECT * FROM Tables WHERE Name = @tableName)
        BEGIN
            PRINT 'Table ' + @tableName + ' already added to test'
            RETURN
        END
    INSERT INTO Tables(Name) VALUES (@tableName)
END
GO

--add view to Views table
CREATE OR ALTER PROCEDURE AddView @viewName VARCHAR(50) 
AS
BEGIN
    IF EXISTS(SELECT * FROM Views WHERE Name = @viewName)
    BEGIN
        PRINT 'View ' + @viewName + ' already added to test'
        RETURN
    END
    INSERT INTO Views(Name) VALUES (@viewName)
end
GO

--add link between Tests and Tables in TetsTables
CREATE OR ALTER PROCEDURE LinkTestTables @tableName VARCHAR(30), @testName VARCHAR(30), @noRows INT, @position INT
AS
BEGIN
	IF @position < 0
		BEGIN
			PRINT 'Position must be greater than 0'
			RETURN
		END
	IF @noRows < 0
		BEGIN
			PRINT 'Number of rows must be greater than 0'
			RETURN
		END

	DECLARE @testId INT
	SET @testId = (SELECT TestID FROM Tests WHERE Name = @testName)

	DECLARE @tableId INT
	SET @tableId = (SELECT TableID FROM Tables WHERE Name = @tableName)

	INSERT INTO TestTables(TestID,TableID,NoOfRows,Position) VALUES (@testId, @tableId, @noRows, @position)
END
GO

--add link between Tests and Viewa in TestViews
CREATE OR ALTER PROCEDURE LinkTestViews @viewName VARCHAR(30), @testName VARCHAR(30)
AS
    BEGIN
        DECLARE @testId INT
        SET @testId = (SELECT TestID FROM Tests WHERE Name = @testName)

		DECLARE @viewId INT
        SET @viewId = (SELECT ViewID FROM Views WHERE Name = @viewName)
        INSERT INTO TestViews(testid, viewid) VALUES (@testId, @viewId)
    END
GO


-------------RUNNING TESTS------------------


CREATE OR ALTER PROCEDURE runTest @name VARCHAR(30)
AS
BEGIN
	DECLARE @testId INT
	SET @testId = (SELECT TestID FROM Tests WHERE Name = @name)

	INSERT INTO TestRuns(Description) VALUES (@name)

	DECLARE @testRunID INT
	SET @testRunID = CONVERT(INT, (SELECT last_value FROM sys.identity_columns WHERE name = 'TestRunID'))

	DECLARE @const INT
	SET @const = 100;

	--needed tables for test
	DECLARE TablesCursor CURSOR SCROLL FOR
		SELECT T.TableID, T.Name, TT.NoOfRows
		FROM TestTables TT
		INNER JOIN Tables T ON T.TableID = TT.TableID
		WHERE TT.TestID = @testId
		ORDER BY TT.Position

	--needed views for test
	DECLARE ViewsCursor CURSOR SCROLL FOR
		SELECT V.ViewID, V.Name
		FROM Views V
		INNER JOIN TestViews TV ON V.ViewID = TV.ViewID
		WHERE TV.TestID = @testId

	DECLARE @startTime DATETIME, @endTime DATETIME,
		@currentStartTime DATETIME, @currentEndTime DATETIME

	SET @startTime = GETDATE()

	--tables tests
	DECLARE @tableName VARCHAR(30), @noRows INT, @tableID INT, @command VARCHAR(200)

	OPEN TablesCursor
	FETCH FIRST FROM TablesCursor INTO @tableID, @tableName, @noRows

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @command = 'DeleteFrom' + @tableName + ' ' + CONVERT(VARCHAR(10), @const)
		EXEC (@command)
		FETCH NEXT FROM TablesCursor INTO @tableID, @tableName, @noRows
	END
	CLOSE TablesCursor
	OPEN TablesCursor
	FETCH LAST FROM TablesCursor INTO @tableID, @tableName, @noRows

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @currentStartTime = GETDATE()
		SET @command = 'InsertInto' + @tableName + ' ' + CONVERT(VARCHAR(10), @const)
		PRINT @noRows

		DECLARE @counter INT
		SET @counter = 1;
		WHILE (@counter <= @noRows)
		BEGIN
			EXEC(@command)
			SET @counter = @counter + 1
		END
		
		SET @currentEndTime = GETDATE()
			print @testRunID
			print @tableID
			print @currentStartTime
			print @currentEndTime
		INSERT INTO TestRunTables(TestRunID, TableID, StartAt, EndAt) VALUES (@testRunID, @tableID, @currentStartTime, @currentEndTime)
		FETCH PRIOR FROM TablesCursor INTO @tableID, @tableName, @noRows
	END
	CLOSE TablesCursor
	DEALLOCATE TablesCursor

	DECLARE @viewID INT, @viewName VARCHAR(30)
	
	OPEN ViewsCursor
	FETCH FROM ViewsCursor INTO @viewID, @viewName
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @currentStartTime = GETDATE()
		SET @command = 'SELECT * FROM ' + @viewName
		EXEC (@command)
		SET @currentEndTime = GETDATE()
		INSERT INTO TestRunViews(TestRunID, ViewID, StartAt, EndAt) VALUES (@testRunID, @viewID, @currentStartTime, @currentEndTime)
		FETCH NEXT FROM ViewsCursor INTO @viewID, @viewName
	END

	SET @endTime = GETDATE()
	CLOSE ViewsCursor
	DEALLOCATE ViewsCursor
	UPDATE TestRuns SET StartAt = @startTime, EndAt = @endTime WHERE TestRunID = @testRunID
END
GO


EXEC AddTable 'Reteta'
EXEC AddTable 'Recenzie'
EXEC AddTable 'RetetaIngredient'

EXEC AddView 'ViewProdusMare'
EXEC AddView 'ViewClientRecenzie'
EXEC AddView 'ViewIngredienteExp'


EXEC AddTest 'Test1'
EXEC AddTest 'Test2'
EXEC AddTest 'Test3'

EXEC LinkTestTables 'Reteta', 'Test1', 300, 1
EXEC LinkTestTables 'Recenzie', 'Test1', 800, 2
EXEC LinkTestTables 'RetetaIngredient', 'Test1', 900, 3

EXEC LinkTestTables 'Reteta', 'Test2', 900, 1
EXEC LinkTestTables 'Recenzie', 'Test2', 800, 2
EXEC LinkTestTables 'RetetaIngredient', 'Test2', 700, 3

EXEC LinkTestTables 'Reteta', 'Test3', 900, 1
EXEC LinkTestTables 'Recenzie', 'Test3', 600, 2
EXEC LinkTestTables 'RetetaIngredient', 'Test3', 500, 3

EXEC LinkTestViews 'ViewProdusMare', 'Test1'
EXEC LinkTestViews 'ViewClientRecenzie', 'Test1'
EXEC LinkTestViews 'ViewIngredienteExp', 'Test1'

EXEC LinkTestViews 'ViewProdusMare', 'Test2'
EXEC LinkTestViews 'ViewClientRecenzie', 'Test2'
EXEC LinkTestViews 'ViewIngredienteExp', 'Test2'

EXEC LinkTestViews 'ViewProdusMare', 'Test3'
EXEC LinkTestViews 'ViewClientRecenzie', 'Test3'
EXEC LinkTestViews 'ViewIngredienteExp', 'Test3'

SELECT * FROM Views
SELECT * FROM Tables

SELECT * FROM TestViews
SELECT * FROM TestTables

SELECT * FROM TestRunTables
SELECT * FROM TestRunViews
SELECT * FROM TestRuns

SELECT * FROM Reteta
SELECT * FROM Recenzie
SELECT * FROM RetetaIngredient


DELETE FROM TestTables
DELETE FROM TestViews

DELETE FROM TestRunTables
DELETE FROM TestRunViews
DELETE FROM TestRuns


EXEC runTest 'Test1'