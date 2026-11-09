--DDL
CREATE DATABASE Locadora
GO
USE Locadora
GO
CREATE TABLE Filme
(
id					INT				IDENTITY(1001,1)		NOT NULL,
titulo				VARCHAR(40)								NOT NULL,
ano					INT				CHECK(ano <= 2021)		NULL,

PRIMARY KEY(id)
)
CREATE TABLE Cliente
(
num_cadastro		INT				IDENTITY(5501,1)		NOT NULL,
nome				VARCHAR(70)								NOT NULL,
logradouro			VARCHAR(150)							NOT NULL,
num					INT				CHECK(num > 0)			NOT NULL,
cep					CHAR(8)			CHECK(LEN(cep) = 8)		NULL,

PRIMARY KEY(num_cadastro)
)
CREATE TABLE Estrela
(
id					INT				IDENTITY(9901,1)	NOT NULL,
nome				VARCHAR(50)							NOT NULL,

PRIMARY KEY(id)
)

GO

CREATE TABLE Filme_Estrela
(
Filmeid				INT									NOT NULL,
Estrelaid			INT									NOT NULL,

PRIMARY KEY(Filmeid, Estrelaid),
FOREIGN KEY(Filmeid) REFERENCES Filme(id),
FOREIGN KEY(Estrelaid) REFERENCES Estrela(id)
)

CREATE TABLE DVD
(
num					INT			IDENTITY(10001,1)						NOT NULL,
data_fabricacao		DATE		CHECK(data_fabricacao < GETDATE())		NOT NULL,
Filmeid				INT													NOT NULL,

PRIMARY KEY(num),
FOREIGN KEY(Filmeid) REFERENCES Filme(id)
)

GO

CREATE TABLE Locacao
(
DVDnum					INT									NOT NULL,
Clientenum_cadastro		INT									NOT NULL,
data_locacao			DATE			DEFAULT(GETDATE())	NOT NULL,
data_devolucao			DATE								NOT NULL,
valor					DECIMAL(7,2)						NOT NULL,

PRIMARY KEY(DVDnum, Clientenum_cadastro, data_locacao),
FOREIGN KEY(DVDnum) REFERENCES DVD(num),
FOREIGN KEY(Clientenum_cadastro) REFERENCES Cliente(num_cadastro),
CONSTRAINT chk_datadev_dataloc CHECK(data_devolucao > data_locacao),
CONSTRAINT chk_valor_positivo CHECK(valor > 0)
)

GO
ALTER TABLE Estrela
ADD nome_real VARCHAR(50)

ALTER TABLE Filme
ALTER COLUMN titulo VARCHAR(80)

GO

--DML
INSERT INTO Filme (titulo, ano) VALUES
('Whiplash', 2015),
('Birdman', 2015),
('Interestelar', 2014),
('A Culpa é das estrelas', 2014),
('Alexandre e o Dia Terrível, Horrível, Espantoso e Horroroso', 2014),
('Sing', 2016)

INSERT INTO Estrela (nome, nome_real) VALUES
('Michael Keaton','Michael John Douglas'),
('Emma Stone','Emily Jean Stone'),
('Miles Teller',NULL),
('Steve Carell','Steven John Carell'),
('Jennifer Garner','Jennifer Anner Garner')

INSERT INTO Filme_Estrela (Filmeid, Estrelaid) VALUES
(1002, 9901),
(1002, 9902),
(1001, 9903),
(1005, 9904),
(1005, 9905)

INSERT INTO DVD (data_fabricacao, Filmeid) VALUES
('2020-12-02', 1001),
('2019-10-18', 1002),
('2020-04-03', 1003),
('2020-12-02', 1001),
('2019-10-18', 1004),
('2020-04-03', 1002),
('2020-12-02', 1005),
('2019-10-18', 1002),
('2020-04-03', 1003)

INSERT INTO Cliente (nome, logradouro, num, cep) VALUES
('Matilde Luz','Rua Síria', 150, '03086040'),
('Carlos Carreiro','Rua Bartolomeu Aires', 1250, '04419110'),
('Daniel Ramalho','Rua Itajutiba', 169, NULL),
('Roberta Bento','Rua Jayme Von Rosenburg', 36, NULL),
('Rosa Cerqueira','Rua Arnaldo Simões Pinto', 235, '02917110')

INSERT INTO Locacao(DVDnum, Clientenum_cadastro, data_locacao, data_devolucao, valor) VALUES 
(10001, 5502, '2021-02-18', '2021-02-21', 3.50),
(10009, 5502, '2021-02-18', '2021-02-21', 3.50),
(10002, 5503, '2021-02-18', '2021-02-19', 3.50),
(10002, 5505, '2021-02-20', '2021-02-23', 3.00),
(10004, 5505, '2021-02-20', '2021-02-23', 3.00),
(10005, 5505, '2021-02-20', '2021-02-23', 3.00),
(10001, 5501, '2021-02-24', '2021-02-26', 3.50),
(10008, 5501, '2021-02-24', '2021-02-26', 3.50)

GO

UPDATE Cliente
SET cep = '08411150'
WHERE num_cadastro = 5503

UPDATE Cliente
SET cep = '02918190'
WHERE num_cadastro = 5504

UPDATE Locacao
SET valor = 3.25
WHERE data_locacao = '2021-02-18' AND Clientenum_cadastro = 5502

UPDATE Locacao
SET valor = 3.10
WHERE data_locacao = '2021-02-24' AND Clientenum_cadastro = 5501

UPDATE DVD
SET data_fabricacao = '2019-07-14'
WHERE num = 10005

UPDATE Estrela
SET nome_real = 'Miles Alexander Teller'
WHERE nome = 'Miles Teller'

DELETE Filme
WHERE titulo = 'Sing'

--SELECTS
SELECT titulo FROM Filme
WHERE ano = 2014

SELECT id, ano FROM Filme
WHERE titulo = 'Birdman'

SELECT id, ano FROM Filme
WHERE titulo LIKE '%plash'

SELECT * FROM Estrela
WHERE nome LIKE 'Steve%'

SELECT Filmeid, CONVERT(CHAR(10), data_fabricacao, 103) AS fab FROM DVD
WHERE data_fabricacao > '2020-01-01'

SELECT DVDnum, data_locacao, data_devolucao, valor, CAST(valor + 2 AS DECIMAL(7,2)) AS valor_com_multa FROM Locacao
WHERE Clientenum_cadastro = 5505

SELECT logradouro, num, cep FROM Cliente
WHERE nome = 'Matilde Luz'

SELECT nome_real FROM Estrela
WHERE nome = 'Michael Keaton'

SELECT num_cadastro, nome, logradouro+ ', ' +CAST(num AS VARCHAR(10))+ ' - ' + cep AS end_comp FROM Cliente
WHERE num_cadastro >= 5503