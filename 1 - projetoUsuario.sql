CREATE DATABASE projetoUsuario
GO
USE projetoUsuario
GO
CREATE TABLE projects
(
id			INT					IDENTITY(10001,1)			NOT NULL,
name		VARCHAR(45)										NOT NULL,
description	VARCHAR(45)										NULL,
date		DATE				CHECK(date > '2014-09-01')	NOT NULL

PRIMARY KEY (id)
)
CREATE TABLE users
(
id			INT					IDENTITY				NOT NULL,
name		VARCHAR(45)									NOT NULL,
username	VARCHAR(45)									NOT NULL,
password	VARCHAR(45)			DEFAULT('123mudar')		NOT NULL,
email		VARCHAR(45)									NOT NULL

PRIMARY KEY (id)
)
GO

CREATE TABLE users_has_projects
(
users_id	INT										NOT NULL,
projects_id	INT										NOT NULL

PRIMARY KEY (users_id, projects_id)
FOREIGN KEY (users_id) REFERENCES users(id),
FOREIGN KEY (projects_id) REFERENCES projects(id)
)

GO

ALTER TABLE users
ALTER COLUMN username VARCHAR(10)

ALTER TABLE users
ALTER COLUMN password VARCHAR(8)

GO

ALTER TABLE users ADD CONSTRAINT UQ_users_username UNIQUE (username)

GO

--DML

INSERT INTO users (name, username, password, email) VALUES
('Maria', 'Rh_maria', '123mudar', 'maria@empresa.com'),
('Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com'),
('Ana', 'Rh_ana', '123mudar', 'ana@empresa.com'),
('Clara', 'Ti_clara', '123mudar', 'clara@empresa.com'),
('Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com')

INSERT INTO projects (name, description, date) VALUES
('Re-folha','Refatoração das Folhas','2014-09-05'),
('Manutenção PC´s','Manutenção PC´s','2014-09-06'),
('Auditoria',NULL,'2014-09-07')
GO

INSERT INTO users_has_projects (users_id, projects_id) VALUES
(1, 10001),
(5, 10001),
(3, 10003),
(4, 10002),
(2, 10002)

--Alterações (DDL)

UPDATE projects
SET date = '2014-09-12'
WHERE name LIKE 'Manutenção%'

UPDATE users
SET username = 'Rh_cido'
WHERE name = 'Aparecido'

UPDATE users
SET password = '888@*'
WHERE username = 'Rh_maria' AND password = '123mudar'

DELETE users_has_projects
WHERE users_id = 2 AND projects_id = 10002