CREATE DATABASE GestiuneVanzari
GO
USE GestiuneVanzari
GO

CREATE TABLE Client
(Id_Client INT PRIMARY KEY IDENTITY,
Denumire VARCHAR(100),
Cod_Fiscal INT NOT NULL)

CREATE TABLE AgentVanzari
(Id_Agent INT PRIMARY KEY IDENTITY,
Nume VARCHAR(100),
Prenume VARCHAR(100))

CREATE TABLE Factura
(Nr_Factura INT PRIMARY KEY IDENTITY,
Data_Emitere DATE,
Id_Client INT FOREIGN KEY REFERENCES Client(Id_client),
Id_Agent INT FOREIGN KEY REFERENCES AgentVanzari (Id_Agent))

CREATE TABLE Produs
(Id_Produs INT PRIMARY KEY IDENTITY,
Denumire VARCHAR(100),
Unitate_Masura VARCHAR(100))

CREATE TABLE FacturaProdus
(Nr_Factura INT FOREIGN KEY REFERENCES Factura(Nr_Factura),
Id_Produs INT FOREIGN KEY REFERENCES Produs(Id_Produs),
Numar_Ordine INT,
Pret INT,
Cantitate INT,
CONSTRAINT pk_FacturaProdus PRIMARY KEY(Nr_Factura, Id_Produs))


-------INSERARI--------

INSERT INTO Client(Denumire, Cod_Fiscal) VALUES ('Anomir SRL', 100),
('SC SPORTLIFE', 101), ('DAFMA SRL', 102), ('SC Tetras', 103),
('MisterPrint SRL', 104)

SELECT * FROM Client

INSERT INTO AgentVanzari(Nume, Prenume) VALUES ('Man', 'Andrei'), ('Gorea' , 'Loredana'),
('Luca', 'Matei'), ('Pop', 'Alexandru'), ('Moldovan', 'Marius')

SELECT * FROM AgentVanzari

INSERT INTO Factura(Data_Emitere, Id_Client, Id_Agent)
VALUES ('2022-01-01', 1, 1), ('2021-10-11', 1, 4), ('2022-05-10', 2, 5),
('2020-12-12', 3, 4), ('2021-09-20', 3, 3), ('2022-07-22', 5, 1)

SELECT * FROM Factura

INSERT INTO Produs(Denumire, Unitate_Masura) VALUES
('lemn', 'metru cub'), ('scaun', 'bucata'), ('mancare caini' , 'kilogram'),
('lumanare', 'bucata'), ('tapet', 'metru patrat'), ('ata', 'metru'), ('rama foto', 'bucata'),
('banda led', 'metru')

SELECT * FROM Produs

SELECT F.Nr_Factura, P.Id_Produs FROM Factura F
CROSS JOIN Produs P

INSERT INTO FacturaProdus(Nr_Factura, Id_Produs, Numar_Ordine, Pret, Cantitate) VALUES
(1, 2, 1, 600, 70), (2, 3, 1, 100, 100), (3, 4, 1, 50, 260), (4, 5, 1, 1000, 800),
(5, 7, 1, 18, 500)


SELECT * FROM FacturaProdus

---procedura stocata care primeste o factura, un produs, nr de ordine, pretul, cantitatea si adauga
-- noul produs facturii. daca produsul exista deja se adauga un rand nou cu cantitatea negativata
GO
CREATE OR ALTER PROCEDURE adauga_factura_produs
@nr_factura INT,
@id_produs INT,
@nr_ordine INT,
@pret INT,
@cantitate INT
AS
BEGIN
	IF (EXISTS (SELECT * FROM FacturaProdus WHERE Nr_Factura = @nr_factura AND Id_Produs = @id_produs
	AND Numar_Ordine = @nr_ordine AND Cantitate = @cantitate AND Pret = @pret))
		UPDATE FacturaProdus SET Cantitate = @cantitate - 1 WHERE Nr_Factura = @nr_factura AND Id_Produs = @id_produs
	AND Numar_Ordine = @nr_ordine AND Cantitate = @cantitate AND Pret = @pret
		
	ELSE
		INSERT INTO FacturaProdus(Nr_Factura, Id_Produs, Numar_Ordine, Pret, Cantitate) VALUES
		(@nr_factura, @id_produs, @nr_ordine, @pret, @cantitate)
END
GO

EXEC adauga_factura_produs 1, 2, 1, 600, 70
EXEC adauga_factura_produs 2, 2, 2, 400, 80

--creati un view care afiseaza lista facturilor ce contin produsul Shaorma si a caror
--valoare > 300 lei. lista va afisa pentru fiecare facrura denumirea clientului, nr facturii,
-- data emiterii si valoarea totala a facturii

INSERT INTO Produs(Denumire, Unitate_Masura) VALUES ('Shaorma', 'gram')
INSERT INTO FacturaProdus(Nr_Factura, Id_Produs, Numar_Ordine, Pret, Cantitate) VALUES
(3, 9, 2, 70, 100), (5, 9, 2, 36, 2), (2, 9, 3, 100, 5)

GO
CREATE OR ALTER VIEW facturi_view
AS
	SELECT C.Denumire, FP.Nr_Factura, F.Data_Emitere, SUM(FP.Pret*FP.Cantitate) AS Valoare FROM FacturaProdus FP
	INNER JOIN Produs P ON P.Denumire = 'Shaorma' AND P.Id_Produs = FP.Id_Produs
	INNER JOIN Factura F ON FP.Nr_Factura = F.Nr_Factura
	INNER JOIN Client C ON C.Id_Client = F.Id_Client
	GROUP BY C.Denumire, FP.Nr_Factura, F.Data_Emitere
	HAVING SUM(FP.Pret*FP.Cantitate) >300
GO

--creati o functie care afiseaza valoarea totala a facturilor, grupate pe lunile
--anuluo si pe agentii de vanzare pentru un anumit an, ordonate crescator
-- in ordinea lunilor si a numelor agentilor
GO

CREATE OR ALTER FUNCTION facturi_grupate(@an INT)
RETURNS TABLE AS
	RETURN (SELECT TOP 100 MONTH(F.Data_Emitere) AS Luna, AV.Nume, AV.Prenume, SUM(FP.Pret*FP.Cantitate) AS ValoareTotala FROM Factura F
	INNER JOIN AgentVanzari AV ON AV.Id_Agent = F.Id_Agent
	INNER JOIN FacturaProdus FP ON FP.Nr_Factura = F.Nr_Factura
	WHERE YEAR(F.Data_Emitere) = @an
	GROUP BY MONTH(F.Data_Emitere), AV.Nume, AV.Prenume
	ORDER BY MONTH(F.Data_Emitere), AV.Nume ASC )
GO

SELECT * FROM facturi_grupate(2022)