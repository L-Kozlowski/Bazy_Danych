--1 cw tworzenie bazy
CREATE DATABASE firma;
--2 cw tworzenie schematy 
CREATE SCHEMA rozliczenia;

--3 cw tworzenie tabeli
CREATE TABLE rozliczenia.pracownicy
(
    id_pracownika integer PRIMARY KEY ,
    imie varchar(40) NOT NULL,
    nazwisko varchar(40) NOT NULL,
    adres  varchar(80) NOT NULL,
    telefon varchar(15),
)


CREATE TABLE rozliczenia.godziny
(
    id_godziny integer  PRIMARY KEY ,
    data date NOT NULL,
    liczba_godzin integer NOT NULL,
    id_pracownika integer NOT NULL,
)

CREATE TABLE rozliczenia.pensje
(
    id_pensji integer PRIMARY KEY,
    stanowisko varchar(40)NOT NULL,
    kwota money NOT NULL,
    id_premii varchar(5)NOT NULL,
)

CREATE TABLE rozliczenia.premie
(
    id_premii varchar(5) PRIMARY KEY,
    rodzaj varchar(40),
    kwota money NOT NULL,
)

ALTER TABLE rozliczenia.godziny ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);
ALTER TABLE rozliczenia.pensje ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);



--4 cw wype�nianie tabeli

INSERT INTO rozliczenia.pracownicy VALUES (1, 'Szymon','Nowak','os.Urocze 21/69, 31-871 Krak�w ','605134854');
INSERT INTO rozliczenia.pracownicy VALUES (2, 'Adrian','Kowalski','os.S�oneczne 12/31, 31-921 Krak�w ',null);
INSERT INTO rozliczenia.pracownicy VALUES (3, 'Anna','W�jcik','os.Zielone 15/1, 31-911 Krak�w ',null);
INSERT INTO rozliczenia.pracownicy VALUES (4, 'Julia','Knap','os.Sportowe 2/45, 31-922 Krak�w ','504430312');
INSERT INTO rozliczenia.pracownicy VALUES (5, 'Grzegorz','Piotrowski','os.Wandy 6/11, 31-913 Krak�w ','631457643');
INSERT INTO rozliczenia.pracownicy VALUES (6, 'Aleksandra','Kara�','os.Szkolne 22/42, 31-912 Krak�w ','773228853');
INSERT INTO rozliczenia.pracownicy VALUES (7, 'Wojciech','Skrzy�ski','os.Na Skarpie 12/23, 31-981 Krak�w ',null);
INSERT INTO rozliczenia.pracownicy VALUES (8, 'Marian','W�troba','ul. Bulwarowa 17/19, 31-849 Krak�w ','888534212');
INSERT INTO rozliczenia.pracownicy VALUES (9, 'Monika','Ba�ka','os.G�rali 9/9, 31-927 Krak�w ','655423367');
INSERT INTO rozliczenia.pracownicy VALUES (10, 'Jakub','Kuba�czyk','os.Krakowiak�w 2/52, 31-877 Krak�w ','554223556');

INSERT INTO rozliczenia.godziny VALUES (11, '2020-12-22',160,1);
INSERT INTO rozliczenia.godziny VALUES (12, '2020-12-21',166,2);
INSERT INTO rozliczenia.godziny VALUES (13, '2020-12-24',169,3);
INSERT INTO rozliczenia.godziny VALUES (14, '2020-12-22',154,4);
INSERT INTO rozliczenia.godziny VALUES (15, '2020-12-21',157,5);
INSERT INTO rozliczenia.godziny VALUES (16, '2020-12-19',170,6);
INSERT INTO rozliczenia.godziny VALUES (17, '2020-12-27',180,7);
INSERT INTO rozliczenia.godziny VALUES (18, '2020-12-23',146,8);
INSERT INTO rozliczenia.godziny VALUES (19, '2020-12-25',174,9);
INSERT INTO rozliczenia.godziny VALUES (20, '2020-12-26',161,10);

INSERT INTO rozliczenia.premie VALUES ('A1', 'Roczna',2000);
INSERT INTO rozliczenia.premie VALUES ('A2', 'Miesieczna',500);
INSERT INTO rozliczenia.premie VALUES ('A3', 'Pracownik Miesi�ca',1000);
INSERT INTO rozliczenia.premie VALUES ('A4', 'Pracownik Tygodnia',100);
INSERT INTO rozliczenia.premie VALUES ('A5',null,1500);
INSERT INTO rozliczenia.premie VALUES ('A6',null,2500);
INSERT INTO rozliczenia.premie VALUES ('A7', 'Na samoch�d',30000);
INSERT INTO rozliczenia.premie VALUES ('A8', 'Na mieszkanie',50000);
INSERT INTO rozliczenia.premie VALUES ('A9',null,150);
INSERT INTO rozliczenia.premie VALUES ('A10', 'Pracownik Roku',3000);

INSERT INTO rozliczenia.pensje VALUES (1, 'Kierownik',12000,'A1');
INSERT INTO rozliczenia.pensje VALUES (2, 'Sekretarka',5000,'A2');
INSERT INTO rozliczenia.pensje VALUES (3, 'Pracownik',4000,'A3');
INSERT INTO rozliczenia.pensje VALUES (4, 'Praktykant',1000,'A4');
INSERT INTO rozliczenia.pensje VALUES (5, 'Dyrektor marketingu',8000,'A5');
INSERT INTO rozliczenia.pensje VALUES (6, 'Ksi�gowy',5000,'A6');
INSERT INTO rozliczenia.pensje VALUES (7, 'Specjalista ds. personalnych',6000,'A7');
INSERT INTO rozliczenia.pensje VALUES (8, 'Operator produkcji',4500,'A8');
INSERT INTO rozliczenia.pensje VALUES (9, 'In�ynier produkcji ',4500,'A9');
INSERT INTO rozliczenia.pensje VALUES (10, 'Sprz�taczka',3000,'A10');

DELETE FROM rozliczenia.godziny WHERE id_godziny = '20'
--5 cw wy�wietlanie tabeli

SELECT *From rozliczenia.pracownicy;
SELECT *From rozliczenia.godziny;
SELECT *From rozliczenia.pensje;
SELECT *From rozliczenia.premie;

SELECT nazwisko,adres From rozliczenia.pracownicy;

--6.Napisz zapytanie
SELECT DATEPART(MONTH, data) [miesiac], DATEPART(WEEKDAY, data) [dzien tygodnia] FROM rozliczenia.godziny
--7.W tabeli pensjezmie� nazw� 
sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';
ALTER TABLE rozliczenia.pensje ADD kwota_netto MONEY;
UPDATE rozliczenia.pensje set kwota_netto = ROUND (kwota_brutto /1.23, 2);
