SELECT * FROM ksiegowosc.pracownicy

--a)
ALTER TABLE ksiegowosc.pracownicy ALTER COLUMN telefon VARCHAR(17)
UPDATE ksiegowosc.pracownicy SET telefon =  SUBSTRING(telefon,6,9)
UPDATE ksiegowosc.pracownicy SET telefon =  '(+48) ' + telefon

--b)
UPDATE ksiegowosc.pracownicy SET telefon =  SUBSTRING(telefon,1,9) + '-' + SUBSTRING(telefon,9,3) + '-' + SUBSTRING(telefon,12,3)

--c)

SELECT UPPER(imie) AS IMIE,   UPPER(nazwisko) 
FROM ksiegowosc.pracownicy
WHERE LEN(nazwisko) = (
	SELECT MAX(LEN(nazwisko))
	FROM ksiegowosc.pracownicy)

--d)
ALTER TABLE ksiegowosc.pensja ALTER COLUMN kwota VARCHAR(20);
SELECT HASHBYTES('MD5', pracownicy.imie) AS imiê, HASHBYTES('MD5', pracownicy.nazwisko) AS nazwisko, HASHBYTES('MD5', pensja.kwota) AS pensja
FROM ksiegowosc.pracownicy INNER JOIN (ksiegowosc.pensja INNER JOIN ksiegowosc.wynagrodzenia ON pensja.ID_pensji = wynagrodzenia.ID_pensji) ON pracownicy.ID_pracownika = wynagrodzenia.ID_pracownika;

--f)

SELECT pracownicy.imie, pracownicy.nazwisko,  premia.kwota as premia,pensja.kwota as pensja
from ksiegowosc.pracownicy
LEFT JOIN (ksiegowosc.pensja
LEFT JOIN (ksiegowosc.premia
LEFT JOIN ksiegowosc.wynagrodzenia
ON premia.id_premii = wynagrodzenia.id_premii)
ON pensja.id_pensji = wynagrodzenia.id_pensji)
ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika

SELECT pracownicy.imie, pracownicy.nazwisko,  premia.kwota as premia,pensja.kwota as pensja
from ksiegowosc.pracownicy
FULL JOIN (ksiegowosc.pensja
JOIN (ksiegowosc.premia
FULL JOIN ksiegowosc.wynagrodzenia
ON premia.id_premii = wynagrodzenia.id_premii)
ON pensja.id_pensji = wynagrodzenia.id_pensji)
ON pracownicy.id_pracownika = wynagrodzenia.id_pracownika

SELECT *
from ksiegowosc.wynagrodzenia

--g)

ALTER TABLE ksiegowosc.godziny ADD nadgodziny_kwota Money
SELECT * FROM ksiegowosc.godziny
UPDATE ksiegowosc.godziny SET nadgodziny_kwota = (liczba_godzin-160)*20 where liczba_godzin > 160


SELECT 'Pracownik ' + pracownicy.imie + ' ' + pracownicy.nazwisko + 
' w dniu ' + CONCAT(wynagrodzenia.data,' ') +
' otrzyma³ pensjê ca³kowit¹ na kwotê ' +  CAST(pensja.kwota + (CASE when wynagrodzenia.id_premii is not null then premia.kwota else 0 end) + (CASE when nadgodziny_kwota is not null then nadgodziny_kwota else 0 end)  as varchar) +
' z³ , gdzie wynagrodzenie zasadnicze wynosi³o: '+ CAST(pensja.kwota as varchar) + 
' z³, premia: ' + CAST(CASE when wynagrodzenia.id_premii is not null then premia.kwota else 0 end as varchar) + 
' z³, nadgodziny '  + CAST(CASE when nadgodziny_kwota is not null then nadgodziny_kwota else 0 end as varchar) + ' z³'
FROM ksiegowosc.pracownicy
FULL JOIN (ksiegowosc.pensja
FULL JOIN (ksiegowosc.godziny
 JOIN (ksiegowosc.premia
FULL JOIN ksiegowosc.wynagrodzenia
ON premia.ID_premii = wynagrodzenia.ID_premii)
ON godziny.id_godziny = wynagrodzenia.id_godziny)
ON pensja.ID_pensji = wynagrodzenia.ID_pensji)
ON pracownicy.ID_pracownika = wynagrodzenia.ID_pracownika


SELECT 
CASE when nadgodziny_kwota is not null then nadgodziny_kwota else 0 end
From ksiegowosc.godziny


