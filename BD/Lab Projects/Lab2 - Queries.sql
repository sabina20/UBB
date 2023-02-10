USE Cofetarie
GO


/*1. Produsele care se gasesc la locatia cu adresa Rovinari 102 si contin zahar
(info din mai mult de 2 tabele, interogare pe tabele aflate in relatie m-n: Produs - Ingredient) */ 
SELECT P.ID_Produs, P.Denumire, L.Adresa FROM Produs P
INNER JOIN Locatie L ON L.Adresa = 'Rovinari 102'
INNER JOIN Ingredient I ON I.Denumire = 'zahar'
INNER JOIN ProdusIngredient PrI ON PrI.ID_Ingredient = I.ID_Ingredient AND PrI.ID_Produs = P.ID_Produs


/*2. Produsele care nu contin gluten si se gasesc la locatia cu adresa Rovinari 102
(interogare care foloseste WHERE)*/
SELECT P.ID_Produs, P.Denumire, P.Alergeni, L.Adresa FROM Produs P, Locatie L
WHERE L.Adresa = 'Rovinari 102' AND P.Alergeni NOT LIKE '%gluten%' AND L.ID_Locatie = P.ID_Locatie


/*3. Produsele cu gramaj mai mare de 180 cu modul de preparare: coacere
(interogare pe tabele aflate in relatie m-n: Produs - Ingredient, Reteta - Ingredient, mai mult de 2 tabele, utilizeaza WHERE*/
SELECT P.Denumire, P.Gramaj FROM Produs P, Reteta R, ProdusIngredient PrI, RetetaIngredient RI
WHERE R.ModPreparare = 'coacere' AND P.ID_Produs = PrI.ID_Produs AND PrI.ID_Ingredient = RI.ID_Ingredient AND R.ID_Reteta = RI.ID_Reteta AND P.Gramaj>180


/*4. Afiseaza denumirea si numarul de ingrediente (daca este mai mic de 4) pentru fiecare produs care nu contine in nume 'Bread'
(foloseste WHERE, foloseste GROUP BY, foloseste HAVING, foloseste mai mult de 2 tabele)*/
SELECT P.Denumire, COUNT(PrI.ID_Ingredient) AS NrIngrediente FROM Produs P, Ingredient I, ProdusIngredient PrI
WHERE PrI.ID_Ingredient = I.ID_Ingredient AND PrI.ID_Produs = P.ID_Produs AND P.Denumire NOT LIKE '%Bread'
GROUP BY P.Denumire
HAVING COUNT(PrI.ID_Ingredient) < 4


/*5. Afiseaza numarul de produse care contin ingrediente ce expira inainte de 2023-01-01 pentru fiecare locatie
(foloseste WHERE, foloseste GROUP BY, foloseste mai mult de 2 tabele*/
SELECT L.Adresa, COUNT(P.ID_Produs) FROM Produs P, Ingredient I, ProdusIngredient PrI, Locatie L
WHERE I.Expirare <= '20230101' AND I.ID_Ingredient = PrI.ID_Ingredient AND PrI.ID_Produs = P.ID_Produs AND P.ID_Locatie = L.ID_Locatie
GROUP BY L.Adresa

/*6. Afiseaza grupurile unice de cod_client si nota recenziei
(foloseste DISTINCT)*/
SELECT DISTINCT Recenzie.Nota, Recenzie.Cod_Client FROM Recenzie
INNER JOIN Client ON Recenzie.Cod_Client = Client.Cod_Client


/*7. Afiseaza listele distincte de alergeni ale produselor cumparate de clienti care au lasat recenzii de la un casier de gen feminin
(foloseste DISTINCT, foloseste WHERE, foloseste mai mult de 2 tabele)*/
SELECT DISTINCT P.Alergeni FROM Produs P, Recenzie R, Angajat A
WHERE R.Cod_Client = P.Cod_Client AND A.CNP = P.CNP_Angajat AND (A.CNP LIKE '2%' OR A.CNP LIKE '6%')

/*8. Afiseaza ID-ul de client si valoarea medie a facturilor pentru fiecare client care a cumparat de la locatia cu adresa Rovinari 102
(foloseste GROUP BY, foloseste mai mult de 2 tabele)*/
SELECT F.Cod_Client, AVG(F.Valoare) AS ValMedie FROM Factura F, Locatie L, Produs P
WHERE L.Adresa = 'Rovinari 102' AND L.ID_Locatie = P.ID_Locatie AND P.Cod_Client = F.Cod_Client
GROUP BY F.Cod_Client

/*9. Afiseaza ID-ul retetei cu numarul de ingrediente pe care le contine
care vor expira inainte de 15.05.2023 daca numarul e mai mic de 5
(foloseste HAVING, foloseste mai mult de 2 tabele)*/
SELECT R.ID_Reteta, R.Timp, COUNT(RI.ID_Ingredient) AS NrIngr FROM Reteta R, RetetaIngredient RI, Ingredient I
WHERE I.Expirare < '20230515' AND I.ID_Ingredient = RI.ID_Ingredient AND RI.ID_Reteta = R.ID_Reteta
GROUP BY R.ID_Reteta, R.Timp
HAVING COUNT(RI.ID_Ingredient) < 5

/*10. Afiseaza valoarea totala a facturilor clientilor care au dat recenzii */
SELECT SUM(F.Valoare) AS SumaTotala FROM Factura F, Recenzie R
WHERE R.Cod_Client = F.Cod_Client