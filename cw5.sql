--1 cw tworzenie bazy
CREATE DATABASE FIRMA2

--2 cw tworzenie schematy
CREATE SCHEMA ksiegowosc

--3 cw tworzenie tabeli
CREATE TABLE ksiegowosc.pracownicy
( 
	id_pracownika integer PRIMARY KEY ,
    imie varchar(40) NOT NULL,
    nazwisko varchar(40) NOT NULL,
    adres  varchar(80) NOT NULL,
    telefon varchar(15),
)

	
CREATE TABLE ksiegowosc.godziny
(
    id_godziny integer  PRIMARY KEY ,
    data date NOT NULL,
    liczba_godzin integer NOT NULL,
    id_pracownika integer,
)

CREATE TABLE ksiegowosc.pensja
(
    id_pensji integer PRIMARY KEY,
    stanowisko varchar(40)NOT NULL,
    kwota money NOT NULL,
)

CREATE TABLE ksiegowosc.premia
(
    id_premii varchar(5) PRIMARY KEY,
    rodzaj varchar(40),
    kwota money NOT NULL,
)

CREATE TABLE ksiegowosc.wynagrodzenia
(
	id_wynagrodzenia integer  PRIMARY KEY,
	data DATE NOT NULL,
	id_pracownika integer,
	id_godziny integer,
	id_pensji integer,
	id_premii varchar(5),

)
execute sp_addextendedproperty @name=N'KOMENTARZ',@value=N'Dane pracowników',
@level0type = N'SCHEMA',@level0name =N'ksiegowosc',@level1type = N'TABLE', @level1name = N'pracownicy'

execute sp_addextendedproperty @name=N'KOMENTARZ',@value=N'Przepracowane godziny pracowników',
@level0type = N'SCHEMA',@level0name =N'ksiegowosc',@level1type = N'TABLE', @level1name = N'godziny'

execute sp_addextendedproperty @name=N'KOMENTARZ',@value=N'Wynagrodzenia dla pracownikow',
@level0type = N'SCHEMA',@level0name =N'ksiegowosc',@level1type = N'TABLE', @level1name = N'pensja'

execute sp_addextendedproperty @name=N'KOMENTARZ',@value=N'Premia dla pracownikow',
@level0type = N'SCHEMA',@level0name =N'ksiegowosc',@level1type = N'TABLE', @level1name = N'premia'

execute sp_addextendedproperty @name=N'KOMENTARZ',@value=N'Tabela ³¹cz¹ca tabele pracowników z tabel¹ pensji i premi',
@level0type = N'SCHEMA',@level0name =N'ksiegowosc',@level1type = N'TABLE', @level1name = N'wynagrodzenia'

SELECT * FROM sys.extended_properties;

ALTER TABLE ksiegowosc.godziny ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenia ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenia ADD FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny);
ALTER TABLE ksiegowosc.wynagrodzenia ADD FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensja(id_pensji);
ALTER TABLE ksiegowosc.wynagrodzenia ADD FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premia(id_premii);


--4 cw wype³nianie tabeli

INSERT INTO ksiegowosc.pracownicy VALUES (1, 'Szymon','Nowak','os.Urocze 21/69, 31-871 Kraków ','605134854');
INSERT INTO ksiegowosc.pracownicy VALUES (2, 'Adrian','Kowalski','os.S³oneczne 12/31, 31-921 Kraków ',null);
INSERT INTO ksiegowosc.pracownicy VALUES (3, 'Anna','Wójcik','os.Zielone 15/1, 31-911 Kraków ',null);
INSERT INTO ksiegowosc.pracownicy VALUES (4, 'Julia','Knap','os.Sportowe 2/45, 31-922 Kraków ','504430312');
INSERT INTO ksiegowosc.pracownicy VALUES (5, 'Grzegorz','Piotrowski','os.Wandy 6/11, 31-913 Kraków ','631457643');
INSERT INTO ksiegowosc.pracownicy VALUES (6, 'Aleksandra','Karaœ','os.Szkolne 22/42, 31-912 Kraków ','773228853');
INSERT INTO ksiegowosc.pracownicy VALUES (7, 'Wojciech','Skrzyñski','os.Na Skarpie 12/23, 31-981 Kraków ',null);
INSERT INTO ksiegowosc.pracownicy VALUES (8, 'Marian','W¹troba','ul. Bulwarowa 17/19, 31-849 Kraków ','888534212');
INSERT INTO ksiegowosc.pracownicy VALUES (9, 'Monika','Bañka','os.Górali 9/9, 31-927 Kraków ','655423367');
INSERT INTO ksiegowosc.pracownicy VALUES (10, 'Jakub','Kubañczyk','os.Krakowiaków 2/52, 31-877 Kraków ','554223556');

INSERT INTO ksiegowosc.godziny VALUES (11, '2020-12-22',160,1);
INSERT INTO ksiegowosc.godziny VALUES (12, '2020-12-21',166,2);
INSERT INTO ksiegowosc.godziny VALUES (13, '2020-12-24',169,3);
INSERT INTO ksiegowosc.godziny VALUES (14, '2020-12-22',154,4);
INSERT INTO ksiegowosc.godziny VALUES (15, '2020-12-21',157,5);
INSERT INTO ksiegowosc.godziny VALUES (16, '2020-12-19',170,6);
INSERT INTO ksiegowosc.godziny VALUES (17, '2020-12-27',180,7);
INSERT INTO ksiegowosc.godziny VALUES (18, '2020-12-23',146,8);
INSERT INTO ksiegowosc.godziny VALUES (19, '2020-12-25',174,9);
INSERT INTO ksiegowosc.godziny VALUES (20, '2020-12-26',161,10);

INSERT INTO ksiegowosc.premia VALUES ('A1', 'Roczna',2000);
INSERT INTO ksiegowosc.premia VALUES ('A2', 'Miesieczna',500);
INSERT INTO ksiegowosc.premia VALUES ('A3', 'Pracownik Miesi¹ca',1000);
INSERT INTO ksiegowosc.premia VALUES ('A4', 'Pracownik Tygodnia',100);
INSERT INTO ksiegowosc.premia VALUES ('A5',null,1500);
INSERT INTO ksiegowosc.premia VALUES ('A6',null,2500);
INSERT INTO ksiegowosc.premia VALUES ('A7', 'Na samochód',30000);
INSERT INTO ksiegowosc.premia VALUES ('A8', 'Na mieszkanie',50000);
INSERT INTO ksiegowosc.premia VALUES ('A9',null,150);
INSERT INTO ksiegowosc.premia VALUES ('A10', 'Pracownik Roku',3000);

INSERT INTO ksiegowosc.pensja VALUES (1, 'Kierownik',12000);
INSERT INTO ksiegowosc.pensja VALUES (2, 'Sekretarka',5000);
INSERT INTO ksiegowosc.pensja VALUES (3, 'Pracownik',4000);
INSERT INTO ksiegowosc.pensja VALUES (4, 'Praktykant',1000);
INSERT INTO ksiegowosc.pensja VALUES (5, 'Dyrektor marketingu',8000);
INSERT INTO ksiegowosc.pensja VALUES (6, 'Ksiêgowy',5000);
INSERT INTO ksiegowosc.pensja VALUES (7, 'Specjalista ds. personalnych',6000);
INSERT INTO ksiegowosc.pensja VALUES (8, 'Operator produkcji',4500);
INSERT INTO ksiegowosc.pensja VALUES (9, 'In¿ynier produkcji ',4500);
INSERT INTO ksiegowosc.pensja VALUES (10, 'Sprz¹taczka',3000);


INSERT INTO ksiegowosc.wynagrodzenia VALUES (1, '2020-12-27', 1, 11, 1, 'A1');
INSERT INTO ksiegowosc.wynagrodzenia VALUES (2, '2020-12-12', 2, 12 ,2, 'A2');
INSERT INTO ksiegowosc.wynagrodzenia VALUES (3, '2020-12-11', 3, 13, 3, 'A3');
INSERT INTO ksiegowosc.wynagrodzenia VALUES (4, '2020-12-14', 4, 14, 4, 'A4');
INSERT INTO ksiegowosc.wynagrodzenia VALUES (5, '2020-12-28', 5, 15, 5, NULL);
INSERT INTO ksiegowosc.wynagrodzenia VALUES (6, '2020-12-30', 6, 16, 6, 'A6');
INSERT INTO ksiegowosc.wynagrodzenia VALUES (7, '2020-12-2', 7, 17, 7, 'A7');
INSERT INTO ksiegowosc.wynagrodzenia VALUES (8, '2020-12-10', 8, 18, 8, NULL);
INSERT INTO ksiegowosc.wynagrodzenia VALUES (9, '2020-12-23', 9, 19, 9, 'A9');
INSERT INTO ksiegowosc.wynagrodzenia VALUES (10, '2020-12-9', 10, 20, 10, 'A10');

UPDATE ksiegowosc.wynagrodzenia SET id_premii = null where id_wynagrodzenia = 8

--5 cw wyœwietlanie tabeli

SELECT *From ksiegowosc.pracownicy;
SELECT *From ksiegowosc.godziny;
SELECT *From ksiegowosc.pensja;
SELECT *From ksiegowosc.premia;
SELECT *From ksiegowosc.wynagrodzenia;


--6.Napisz zapytanie
--A
SELECT id_pracownika,nazwisko From ksiegowosc.pracownicy;

--B
SELECT pracownicy.id_pracownika,pensja.kwota
From ksiegowosc.pracownicy INNER JOIN ( ksiegowosc.pensja INNER JOIN ksiegowosc.wynagrodzenia ON pensja.id_pensji = wynagrodzenia.id_pensji) ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
WHERE pensja.kwota > 1000

--C

SELECT pracownicy.id_pracownika,pensja.kwota,wynagrodzenia.id_premii
From ksiegowosc.pracownicy INNER JOIN ( ksiegowosc.pensja INNER JOIN ksiegowosc.wynagrodzenia  ON pensja.id_pensji = wynagrodzenia.id_pensji )ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
WHERE wynagrodzenia.id_premii IS NULL AND pensja.kwota > 2000.00

--D

SELECT id_pracownika,imie,nazwisko FROM ksiegowosc.pracownicy WHERE imie LIKE 'J%';

--E

SELECT id_pracownika,imie,nazwisko FROM ksiegowosc.pracownicy WHERE nazwisko LIKE '%n%' AND imie LIKE '%a'; 

--F

SELECT pracownicy.imie, pracownicy.nazwisko,godziny.liczba_godzin
From ksiegowosc.pracownicy INNER JOIN ( ksiegowosc.godziny INNER JOIN ksiegowosc.wynagrodzenia  ON godziny.id_godziny = wynagrodzenia.id_godziny) ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
WHERE godziny.liczba_godzin > 160

--G

SELECT pracownicy.imie, pracownicy.nazwisko,pensja.kwota
From ksiegowosc.pracownicy INNER JOIN ( ksiegowosc.pensja INNER JOIN ksiegowosc.wynagrodzenia  ON pensja.id_pensji = wynagrodzenia.id_pensji) ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
WHERE pensja.kwota >= 1500 AND pensja.kwota <= 3000

--H
UPDATE ksiegowosc.godziny SET liczba_godzin = 190 where id_godziny = 18

SELECT pracownicy.imie, pracownicy.nazwisko, godziny.liczba_godzin
From ksiegowosc.pracownicy INNER JOIN ( ksiegowosc.godziny INNER JOIN ksiegowosc.wynagrodzenia ON godziny.id_godziny = wynagrodzenia.id_godziny) ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
WHERE godziny.liczba_godzin > 160 AND wynagrodzenia.id_premii is null

--I
SELECT pracownicy.imie, pracownicy.nazwisko, pensja.kwota
From ksiegowosc.pracownicy INNER JOIN ( ksiegowosc.pensja INNER JOIN ksiegowosc.wynagrodzenia ON pensja.id_pensji = wynagrodzenia.id_pensji) ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
ORDER BY pensja.kwota

--J

SELECT pracownicy.imie, pracownicy.nazwisko, pensja.kwota, premia.kwota
From ksiegowosc.pracownicy INNER JOIN ( ksiegowosc.pensja INNER JOIN(ksiegowosc.premia INNER JOIN ksiegowosc.wynagrodzenia ON premia.id_premii = wynagrodzenia.id_premii ) ON pensja.id_pensji = wynagrodzenia.id_pensji) ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
ORDER BY pensja.kwota DESC, premia.kwota DESC

--K

SELECT COUNT(pensja.stanowisko),pensja.stanowisko
FROM ksiegowosc.pensja
GROUP BY pensja.stanowisko

--L

UPDATE ksiegowosc.pensja SET stanowisko ='kierownik' where id_pensji = 5

SELECT AVG(pensja.kwota) AS AVG, MIN(pensja.kwota) AS MIN, MAX(pensja.kwota) AS MAX
FROM ksiegowosc.pensja
WHERE pensja.stanowisko LIKE 'kierownik'

--M

SELECT SUM(pensja.kwota) AS SUMA_PENSJI
FROM ksiegowosc.pensja

--N

SELECT  pensja.stanowisko, SUM(pensja.kwota) AS SUMA_PENSJI
FROM ksiegowosc.pensja
GROUP BY pensja.stanowisko

--O

UPDATE ksiegowosc.pensja SET stanowisko ='Sprz¹taczka' where id_pensji = 6

SELECT COUNT(premia.kwota) AS LICZBA_PREMII, pensja.stanowisko
FROM ksiegowosc.pensja INNER JOIN (ksiegowosc.premia INNER JOIN ksiegowosc.wynagrodzenia ON premia.id_premii = wynagrodzenia.id_premii) ON pensja.id_pensji = wynagrodzenia.id_pensji
GROUP BY pensja.stanowisko

--P




--DELETE ksiegowosc.pracownicy FROM ksiegowosc.pracownicy, ksiegowosc.pensja WHERE pensja.kwota <= 1500

--SET FOREIGN_KEY_CHECKS = 0;
--delete pracownicy,pensje,premie,godziny
--from ksiegowosc.pracownicy inner join (ksiegowosc.pensja inner join (ksiegowosc.premia inner join(ksiegowosc.godziny inner join ksiegowosc.wynagrodzenie on godziny.id_godziny = wynagrodzenie.id_godziny)) on pensje.id_pensji = wynagrodzenie.id_pensji)
-- FROM pracownicy inner join (pensje inner join (premie inner join (godziny inner join wynagrodzenie on godziny.id_godziny = wynagrodzenie.id_godziny) pensje.id_pensji = wynagrodzenie.id_pensji))
--WHERE pensje.kwota <1200;
--SET FOREIGN_KEY_CHECKS = 1;

SELECT pracownicy.id_pracownika,pracownicy.imie,pracownicy.nazwisko,pensja.kwota
FROM ksiegowosc.pracownicy INNER JOIN ( ksiegowosc.pensja INNER JOIN ksiegowosc.wynagrodzenia ON pensja.id_pensji = wynagrodzenia.id_pensji) ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika
WHERE pensja.kwota <= 1500

ALTER TABLE ksiegowosc.godziny  
NOCHECK CONSTRAINT FK__godziny__id_prac__2C3393D0;
GO 
ALTER TABLE ksiegowosc.wynagrodzenia  
NOCHECK CONSTRAINT FK__wynagrodz__id_pr__2D27B809;
GO 
DELETE pracownicy FROM ksiegowosc.pracownicy WHERE id_pracownika =3 or id_pracownika = 4



INSERT INTO ksiegowosc.pracownicy VALUES (3, 'Anna','Wójcik','os.Zielone 15/1, 31-911 Kraków ',null);
INSERT INTO ksiegowosc.pracownicy VALUES (4, 'Julia','Knap','os.Sportowe 2/45, 31-922 Kraków ','504430312');