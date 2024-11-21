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
