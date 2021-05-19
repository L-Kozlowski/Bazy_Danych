-- zadanie 1
begin 

select FirstName,MiddleName,LastName ,EmailAddress,Rate*2016 as YearsPayment  from 
AdventureWorks2017.HumanResources.EmployeePayHistory 
INNER JOIN AdventureWorks2017.Person.Person
INNER JOIN AdventureWorks2017.Person.EmailAddress
ON Person.BusinessEntityID = EmailAddress.BusinessEntityID
ON EmployeePayHistory.BusinessEntityID = EmailAddress.BusinessEntityID
where Rate*2016 < (Select (SUM(Rate*2016)/COUNT(Rate))from AdventureWorks2017.HumanResources.EmployeePayHistory)
 
end;

-- zadanie 2

CREATE or ALTER FUNCTION  ship_date( @IDOrder  VARCHAR(5))
RETURNS DATETIME
BEGIN
DECLARE @date DATETIME
SELECT @date = ShipDate FROM AdventureWorks2017.Sales.SalesOrderHeader where SalesOrderID = @IDOrder
RETURN @date
END;


DECLARE @id VARCHAR(5) = 43668 
SELECT @id as ID, dbo.ship_date(@id) as Data_Wysylki

-- zadanie 3


CREATE or ALTER PROCEDURE produkt( @NazwaProduktu  VARCHAR(15))
AS
BEGIN
SELECT Name,ProductID,ProductNumber,SafetyStockLevel FROM AdventureWorks2017.Production.Product where Name = @NazwaProduktu
END;

DECLARE @nazwa VARCHAR(15) ='LL Hub'
EXEC produkt @nazwa

-- zadanie 4

CREATE or ALTER FUNCTION  numer_karty( @id_order  VARCHAR(5))
RETURNS VARCHAR(20)
BEGIN
DECLARE @numer_karty VARCHAR(20)

SELECT @numer_karty = CardNumber FROM AdventureWorks2017.Sales.SalesOrderHeader
INNER JOIN AdventureWorks2017.Sales.CreditCard
ON SalesOrderHeader.CreditCardID = CreditCard.CreditCardID
where SalesOrderID = @id_order

RETURN @numer_karty
END


DECLARE @id VARCHAR(5) = 43668 
SELECT @id as ID, dbo.numer_karty(@id) as Numer_karty


-- zadanie 5

-- Utwórz procedurę składowaną, która jako parametry wejściowe przyjmuje dwie liczby, num1
-- i num2, a zwraca wynik ich dzielenia. Ponadto wartość num1 powinna zawsze być większa niż
-- wartość num2. Jeżeli wartość num1 jest mniejsza niż num2, wygeneruj komunikat o błędzie
-- „Niewłaściwie zdefiniowałeś dane wejściowe”.



CREATE or ALTER FUNCTION dzielenie( @num1 FLOAT, @num2 FLOAT)
RETURNS VARCHAR(100)
BEGIN
DECLARE @wynik VARCHAR(100)
IF(@num1 > @num2 )
BEGIN

SET @wynik = @num1/@num2

END ELSE
BEGIN
SELECT @wynik =  'Niewłaściwie zdefiniowałeś dane wejściowe'

END

RETURN  @wynik
END

DECLARE @num1 FLOAT = 12.6,@num2 FLOAT = 21
Select dbo.dzielenie(@num1,@num2) as Dzielenie

-- zadanie 6

--Napisz procedurę, która jako parametr przyjmie NationalIDNumber danej osoby, a zwróci
--stanowisko oraz liczbę dni urlopowych i chorobowych


CREATE or ALTER PROCEDURE dane( @ID  VARCHAR(15))
AS
BEGIN
SELECT NationalIDNumber,JobTitle,ROUND(CAST((VacationHours) as FLOAT)/24, 2) AS VacationDays, ROUND(CAST((SickLeaveHours) as FLOAT)/24, 2) AS SickLeaveDays
FROM AdventureWorks2017.HumanResources.Employee 
WHERE NationalIDNumber = @ID
END;

DECLARE @id_national VARCHAR(15) = 879342154
EXEC dane @id_national

-- zadanie 7
-- Napisz procedurę będącą kalkulatorem walutowym. Wykorzystaj dwie tabele: Sales.Currency
-- oraz Sales.CurrencyRate. Parametrami wejściowymi mają być: kwota, waluty oraz data
-- (CurrencyRateDate). Przyjmij, iż zawsze jedną ze stron jest dolar amerykański (USD).
-- Zaimplementuj kalkulację obustronną, tj:
-- 1400 USD → PLN lub PLN → US

CREATE OR ALTER PROCEDURE kalkulator(@kwota FLOAT, @waluta_z VARCHAR(10), @waluta_na VARCHAR(10), @data DATETIME)
AS
BEGIN
	DECLARE @przelicznik FLOAT = 0;
	DECLARE @kwota_koncowa FLOAT = 0;
	IF @waluta_z = 'USD'
		BEGIN
			SELECT @przelicznik = AverageRate FROM AdventureWorks2017.Sales.CurrencyRate WHERE ToCurrencyCode = @waluta_na AND CurrencyRateDate = @data;
			SET @kwota_koncowa = ROUND((@przelicznik * @kwota),2);
		END;
	ELSE
		BEGIN
			SELECT @przelicznik = AverageRate FROM AdventureWorks2017.Sales.CurrencyRate WHERE ToCurrencyCode = @waluta_z AND CurrencyRateDate = @data;
			SET @kwota_koncowa = ROUND((@kwota/@przelicznik),2);
		END; 

		declare @wyswietl  TABLE (Kwota FLOAT, Waluta_Z VARCHAR(10), Waluta_Na VARCHAR(10) ,Przelicznik FLOAT, Kwota_Koncowa FLOAT )
		INSERT INTO @wyswietl VALUES(@kwota,@waluta_z,@waluta_na,@przelicznik,@kwota_koncowa); 
		SELECT * FROM @wyswietl;
END;

DECLARE @podana_waluta_z VARCHAR(10) = 'GBP';
DECLARE @podana_waluta_na VARCHAR(10) = 'USD';
DECLARE @kwota_do_zamiany FLOAT = 1000;
DECLARE @data_time DATETIME = '2011-05-31 00:00:00.000'
EXEC kalkulator @kwota_do_zamiany, @podana_waluta_z, @podana_waluta_na, @data_time;

