-- 1
SELECT Nome, Barche.idbarca From Barche 
JOIN partecipa on Partecipa.idbarca = Barche.idbarca
JOIN Regate on Partecipa.idregata = regate.idregata
WHERE Luogo = "San Francisco" 
AND barche.IdBarca IN(
	SELECT idbarca
    From partecipa
    JOIN Regate on Partecipa.idregata = regate.idregata 
    where Luogo ="Valencia"
		AND barche.IdBarca NOT IN(
		SELECT idbarca
		From partecipa
		JOIN Regate on Partecipa.idregata = regate.idregata 
		where Luogo ="Bergen"
		)
)
;
-- 2
SELECT Nome, Barche.idbarca , SUM(Punteggio) AS TotalePunti FROM Barche 
JOIN partecipa on Partecipa.idbarca = Barche.idbarca
GROUP BY idbarca 
HAVING SUM(punteggio) = (
	SELECT MAX(TotalePunti)
	FROM( 
		SELECT SUM(Punteggio) AS TotalePunti
		FROM Partecipa
		GROUP BY idbarca 
    ) AS Totali
)	
;
-- 3
SELECT Barche.nome, sum(sponsor.importo)AS ImportoTotaleSponsor FROM Barche
JOIN sponsor on sponsor.idbarca = Barche.idbarca
GROUP BY Barche.idbarca
;

-- 4
SELECT equipaggio.matricola, equipaggio.nominativo, ruoli.ruolo
FROM barche
JOIN equipaggio on equipaggio.idbarca = barche.idbarca
JOIN partecipa on barche.idbarca = partecipa.idbarca
JOIN regate on regate.idregata = partecipa.idregata
JOIN ruoli on equipaggio.matricola = ruoli.matricola
WHERE barche.nome = "mercante di venezia"
AND regate.luogo = "dover"
AND regate.dataregata = "2008-02-20"
GROUP BY equipaggio.matricola
;

-- 5
Select barche.* FROM barche
JOIN equipaggio on equipaggio.idbarca = barche.idbarca
WHERE equipaggio.nazionalita = "Italia"
Having count(Matricola) >= 3
;

-- 6
SELECT Nome, Barche.idbarca , AVG(Punteggio) AS TotalePunti FROM Barche 
JOIN partecipa on Partecipa.idbarca = Barche.idbarca
GROUP BY idbarca 
HAVING AVG(punteggio) >= (
	SELECT AVG(TotalePunti)
	FROM( 
		SELECT (Punteggio) AS TotalePunti
		FROM Partecipa
		GROUP BY idbarca 
    ) AS Totali
)	
;

-- 7 Elenco delle barche che non hanno mai partecipato ad una regata a “Città a scelta” 
SELECT Distinct Nome, Barche.idbarca FROM Barche 
JOIN partecipa on Partecipa.idbarca = Barche.idbarca
WHERE NOT EXISTS (
	SELECT Barche.idbarca
	From Barche
	JOIN regate on regate.idregata = partecipa.idregata
	where luogo = "Bergen"
)
;
-- 8 Elenco delle barche e il rispettivo numero totale di regate a cui hanno partecipato.
-- senza subquery
SELECT Nome, Barche.idbarca, Count(Partecipa.idRegata) AS NumeroTotaleDiRegate FROM Barche 
JOIN partecipa on Partecipa.idbarca = Barche.idbarca
group by Barche.idbarca
;
-- con subquery
SELECT b.Nome, b.idbarca ,  (  SELECT Count(Partecipa.idRegata) 
								FROM barche
								JOIN partecipa on Partecipa.idbarca = Barche.idbarca
								where Barche.idbarca = b.idbarca
								 ) as tot
FROM barche as b
;


-- 9 Elenco degli sponsor che hanno sponsorizzato solamente barche di nazionalità “Nazione a scelta”
SELECT sponsor.nome , Sponsor.Idsponsor
FROM sponsor
JOIN barche on sponsor.idbarca = Barche.idbarca
where exists(
SELECT sponsor.idsponsor
FROM Barche
WHERE Barche.nazionalita = "nazionalita1"
AND barche.idbarca = sponsor.idbarca
)
;

-- 10 Elenco delle barche in cui è presente almeno un membro dell’equipaggio della stessa nazionalità della barca
SELECT Nome, Barche.idbarca
FROM barche
WHERE EXISTS(
SELECT equipaggio.nazionalita
FROM equipaggio
WHERE equipaggio.nazionalita = barche.nazionalita
AND barche.idbarca = equipaggio.idbarca
)
;
-- 11 Elenco delle barche in cui tutto l’equipaggio ha la stessa nazionalità della barca
SELECT Nome, Barche.idbarca
FROM barche
WHERE NOT EXISTS(
SELECT equipaggio.nazionalita
FROM equipaggio
WHERE NOT equipaggio.nazionalita = Barche.nazionalita
AND barche.idbarca = equipaggio.idbarca
)
;
-- 12 Elenco delle barche in cui tutto nessun membro dell’equipaggio ha la stessa nazionalità della barca
SELECT Nome, Barche.idbarca
FROM barche
WHERE NOT EXISTS(
SELECT equipaggio.nazionalita
FROM equipaggio
WHERE equipaggio.nazionalita = barche.nazionalita
AND barche.idbarca = equipaggio.idbarca
GROUP BY barche.idbarca
)
;

