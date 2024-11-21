CREATE DATABASE Regate;
USE Regate;

CREATE TABLE sponsor(
idSponsor INT PRIMARY KEY NOT NULL,
nome VARCHAR(255),
importo FLOAT,
idBarca INT
#FOREIGN KEY (idBarca) REFERENCES barche(idBarca)
);

CREATE TABLE ruoli(
idBarca INT,
idRegata INT,
matricola INT,
ruolo varchar(255),
primary key(idBarca, idRegata, matricola)
#FOREIGN KEY (idBarca) REFERENCES partecipa(idBarca),
#FOREIGN KEY (idRegata) REFERENCES partecipa(idRegata),
#FOREIGN KEY (matricola) REFERENCES Equipaggio(matricola)
);

CREATE TABLE barche(
idBarca int primary key not null,
nome varchar(255),
modello varchar(255),
nazionalita varchar(255),
lunghezza float,
stazza float,
skipper varchar(255)
);

CREATE TABLE equipaggio(
matricola int primary key not null,
idBarca int,
nominativo varchar(255),
dataNascita date,
nazionalita varchar(255)
#foreign key (idBarca) references barche(idBarca)
);

CREATE TABLE regate(
idRegata int primary key not null,
luogo varchar(255),
dataRegata date,
lungBolina float,
lungPoppa float
);

create table partecipa(
idBarca int,
idRegata int,
punteggio int,
primary key(idBarca, idRegata)
#foreign key (idBarca) references Barche(idBarca),
#foreign key (idRegata) references Regate(idRegata)
);

INSERT INTO barche(idBarca, nome, modello, nazionalita, lunghezza, stazza, skipper)
VALUES
(1, 'nome1', 'modello1', 'nazionalita1', 1.49, 92, 'skipper1'),
(2, 'nome2', 'modello2', 'nazionalita2', 1.04, 84, 'skipper2'),
(3, 'nome3', 'modello3', 'nazionalita3', 0.84, 47, 'skipper3'),
(4, 'Mercante di Venezia', 'modello4', 'nazionalita4', 1.48, 17, 'skipper4');

INSERT INTO regate(idRegata, luogo, dataRegata, lungBolina, lungPoppa)
VALUES
(1, 'San Francisco', '2019-11-20', 1.45, 0.83),
(2, 'Bergen', '2018-09-19', 1.12, 1.93),
(3, 'Valencia', '2019-03-11', 1.35, 1.97),
(4, 'Dover', '2008-02-20', 1.47, 1.00);

INSERT INTO partecipa (idBarca, idRegata, punteggio)
VALUES
(1, 1, 10),
(1, 3, 7),
(2, 2, 5),
(3, 1, 3),
(4, 4, 7);

INSERT INTO sponsor(idSponsor, nome, importo, idBarca) 
VALUES 
(1, 'nome1', 25, 1),
(2, 'nome3', 19, 2),
(3, 'nome4', 18, 2),
(4, 'nome5', 21, 3),
(5, 'nome7', 14, 4),
(6, 'nome8', 25, 4);

INSERT INTO equipaggio(matricola, idBarca, nominativo, dataNascita, nazionalita)
VALUES 
(1, 4, 'nominativo1', '2001-09-19', 'Italia'),
(2, 4, 'nominativo2', '2004-11-28', 'Italia'),
(3, 4, 'nominativo3', '1967-11-20', 'Italia'),
(4, 1, 'nominativo1', '2001-09-19', 'nazionalita1'),
(5, 1, 'nominativo2', '2004-11-28', 'nazionalita2'),
(6, 2, 'nominativo3', '1967-11-20', 'nazionalita3');

INSERT INTO ruoli(idBarca, idRegata, matricola, ruolo)
VALUES 
(4, 4, 1, 'prodiere'),
(4, 4, 2, 'sewer'),
(4, 4, 3, 'pitman'),
(1, 3, 4, 'albero'),
(1, 3, 5, 'grinder'),
(2, 2, 6, 'trimmer');