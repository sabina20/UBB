USE Cofetarie
GO

INSERT INTO Locatie(Adresa) VALUES ('Rodnei 48'), ('Mihai Eminescu 5'), ('Rovinari 102')

INSERT INTO Ingredient(Denumire, Cantitate, Pret, Expirare) VALUES ('Faina', 150, 3.7, '2023-10-08'), ('Zahar', 300, 5.5, '2022-12-01'),
('Alune de padure', 34, 20, '2025-02-16'), ('Bicarbonat de sodiu', 500, 6.2, '2024-08-21'), ('Unt', 30, 15.6, '2022-11-30'),
('Lapte', 80, 8, '2022-11-03'), ('Iaurt', 122, 21.3, '2022-12-27')
INSERT INTO Ingredient(Denumire, Cantitate, Pret) VALUES ('Praf de copt', 230, 0.8), ('Cacao', 304, 12.9), ('Fructe de padure', 76, 24.5),
('Banana', 30, 2), ('Gris', 210, 4.8), ('Frisca', 94, 16), ('Mascarpone', 100, 23.1)

INSERT INTO Proprietar(CNP, Nume, Adresa) VALUES ('1870919448953', 'Ovidiu Man', 'Libertatii 205')

INSERT INTO Angajat(CNP, Nume, Functie, Ore, CNP_Proprietar) VALUES ('5030902174056', 'Alin Pop', 'casier', 8, '1870919448953'),
('2980902047170', 'Anabella Coman', 'casier', 8, '1870919448953'), ('1910910261094', 'Raul-Alexandru Cristea', 'distribuitor', 8, '1870919448953'),
('6020816347012', 'Diana-Maria Rus', 'casier', 8, '1870919448953'), ('2890531029517', 'Marta Lazar', 'casier', 8, '1870919448953'),
('6040725078309', 'Adelina-Denisa Apetean', 'ajutor bucatar', 8, '1870919448953')
INSERT INTO Angajat(CNP, Nume, Functie, Ore, Salariu, CNP_Proprietar) VALUES ('2910211529690', 'Amalia Ion', 'bucatar sef', 10, 2800, '1870919448953'),
('2930407085551', 'Dana Oroian', 'bucatar', 8, 2300, '1870919448953'), ('1880417143779', 'Anamaria Danciu', 'bucatar', 8, 2300, '1870919448953'),
('1941118195572', 'Cristian Pop', 'distribuitor', 8, 2000, '1870919448953')

INSERT INTO Reteta(Titlu, Timp, ModPreparare) VALUES ('Tiramisu', 60, 'racire'), ('Savarina', 90, 'coacere'), ('Banana Bread', 90, 'coacere'),
('Pumpkin Bread', 90, 'coacere'), ('Cheesecake', 120, 'racire'), ('Bounty', 85, 'congelare'), ('Papanasi', 120, 'prajire')

INSERT INTO Client(Nume) VALUES ('Antonio Lipan'), ('Maria Stefan'), ('Alexia Anton'), ('David Zahan'), ('Andra Man'), ('Petru Suciu')

INSERT INTO Recenzie(Nota, Cod_Client) VALUES (9, 1000), (10, 1004), (10, 1005), (6, 1002)

INSERT INTO Factura(Valoare, Cod_Client) VALUES (2100, 1000), (200, 1001), (85, 1002), (1200, 1003), (400, 1004), (25, 1005)

INSERT INTO Produs(Denumire, Expirare, Gramaj, Pret, Alergeni, Cod_Client, CNP_Angajat, ID_Locatie) VALUES ('Tiramisu', '2022-11-01', 200, 16, 'oua, lapte', 1000, '2890531029517', 502),
('Banana Bread', '2022-12-01', 250, 13.5, 'oua, lapte, gluten', 1004, '2890531029517', 500), ('Pumpkin Bread', '2023-01-01', 250, 14, 'oua, lapte, gluten', 1003, '5030902174056', 502),
('Savarina', '2022-12-20', 270, 12, 'oua, lapte, gluten', 1003, '2980902047170', 501)

INSERT INTO ProdusIngredient(ID_Produs, ID_Ingredient) VALUES (400,101), (400,113), (400,112), (401,100), (401,110), (401, 104),
(401, 105), (403, 111), (402, 101), (402, 104), (403, 112)

INSERT INTO RetetaIngredient(ID_Reteta, ID_Ingredient) VALUES (206, 100), (206, 109), (206, 107), (204, 113), (204, 101), (203, 100),
(203, 102), (200,101), (201, 111)

