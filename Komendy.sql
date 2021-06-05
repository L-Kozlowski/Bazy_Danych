
SELECT Id_pietro,Nazwa_pietro,geoschemat.epoka.Id_epoka ,Nazwa_epoka,geoschemat.okres.Id_okres,Nazwa_okres,geoschemat.era.Id_era,Nazwa_era, geoschemat.eon.Id_eon,Nazwa_eon  INTO geoschemat
FROM  geoschemat.pietro 
INNER JOIN geoschemat.epoka 
INNER JOIN geoschemat.okres 
INNER JOIN geoschemat.era 
INNER JOIN geoschemat.eon
ON geoschemat.era.Id_eon = geoschemat.eon.Id_eon
ON geoschemat.okres.Id_era = geoschemat.era.Id_era
ON geoschemat.epoka.Id_okres = geoschemat.okres.Id_okres
ON geoschemat.pietro.Id_epoka =geoschemat.epoka.Id_epoka
;

SELECT * FROM geoschemat

ALTER TABLE geoschemat ADD PRIMARY KEY (ID_pietro) 

--______________________________________________________________________________________________________Tabela Dziesiec

CREATE TABLE Dziesiec(cyfra integer, bit INT )

INSERT INTO Dziesiec VALUES(0,8)
INSERT INTO Dziesiec VALUES(1,8)
INSERT INTO Dziesiec VALUES(2,8)
INSERT INTO Dziesiec VALUES(3,8)
INSERT INTO Dziesiec VALUES(4,8)
INSERT INTO Dziesiec VALUES(5,8)
INSERT INTO Dziesiec VALUES(6,8)
INSERT INTO Dziesiec VALUES(7,8)
INSERT INTO Dziesiec VALUES(8,8)
INSERT INTO Dziesiec VALUES(9,8)


--______________________________________________________________________________________________________Tabela Milion

CREATE TABLE Milion(liczba int PRIMARY KEY,cyfra int, bit int);
INSERT INTO Milion SELECT a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra
+ 10000*a5.cyfra + 100000*a6.cyfra AS liczba , a1.cyfra AS cyfra, a1.bit AS bit
FROM Dziesiec a1, Dziesiec a2, Dziesiec a3, Dziesiec a4, Dziesiec a5, Dziesiec a6 ;


--______________________________________________________________________________________________________Zapytania

SELECT COUNT(*) FROM Milion INNER JOIN geoschemat ON
( (Milion.liczba%68)=(geoschemat.Id_pietro));

SELECT COUNT(*) FROM Milion 
INNER JOIN geoschemat.pietro 
INNER JOIN geoschemat.epoka 
INNER JOIN geoschemat.okres 
INNER JOIN geoschemat.era 
INNER JOIN geoschemat.eon
ON geoschemat.era.Id_eon = geoschemat.eon.Id_eon
ON geoschemat.okres.Id_era = geoschemat.era.Id_era
ON geoschemat.epoka.Id_okres = geoschemat.okres.Id_okres
ON geoschemat.pietro.Id_epoka =geoschemat.epoka.Id_epoka
ON ((Milion.liczba%68)=geoschemat.pietro.Id_pietro) 
;

SELECT COUNT(*) FROM Milion WHERE Milion.liczba%68=
(SELECT Id_pietro FROM geoschemat WHERE Milion.liczba%68 = (Id_pietro));


SELECT COUNT(*) FROM Milion WHERE (Milion.liczba%68) in (SELECT geoschemat.pietro.Id_pietro 
FROM geoschemat.pietro 
INNER JOIN geoschemat.epoka 
INNER JOIN geoschemat.okres 
INNER JOIN geoschemat.era 
INNER JOIN geoschemat.eon
ON geoschemat.era.Id_eon = geoschemat.eon.Id_eon
ON geoschemat.okres.Id_era = geoschemat.era.Id_era
ON geoschemat.epoka.Id_okres = geoschemat.okres.Id_okres
ON geoschemat.pietro.Id_epoka =geoschemat.epoka.Id_epoka)

