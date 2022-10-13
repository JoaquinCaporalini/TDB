/* Ejercicio 1 */

CREATE DATABASE IF NOT EXISTS jcaporalini_RecursosHumanos;

USE jcaporalini_RecursosHumanos;

DROP TABLE IF EXISTS Realiza;
DROP TABLE IF EXISTS Empleado;
DROP TABLE IF EXISTS Curso;

CREATE TABLE Empleado (
    id		INT		NOT NULL	AUTO_INCREMENT,
    nombre 	VARCHAR(20)	NOT NULL,
    apellido 	VARCHAR(30)	NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Curso (
    codigo	CHAR(7)		NOT NULL,
    nombre	VARCHAR(20)	NOT NULL,
    tipo	VARCHAR(10)	NOT NULL	DEFAULT 'interno',
    PRIMARY KEY (codigo)
);

CREATE TABLE Realiza (
    id		INT		NOT NULL,
    codigo	CHAR(7)		NOT NULL,
    PRIMARY KEY (id, codigo),
    FOREIGN KEY (id) REFERENCES Empleado(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (codigo) REFERENCES Curso(codigo) ON DELETE CASCADE ON UPDATE CASCADE
);

/* Ejercicio 2 */

ALTER TABLE Empleado
ADD ingreso DATE,
MODIFY nombre VARCHAR(30) NOT NULL;

/* Ejercicio 3 */

CREATE INDEX apellido_idx ON Empleado(apellido);

/* Ejercicio 4 */

INSERT INTO Empleado (nombre, apellido, id, ingreso) VALUES ('Clara', 'Toledo', DEFAULT, '1998-03-02');
INSERT INTO Empleado VALUES (DEFAULT, 'Roberto', 'Ocampo', '2002-10-07');
INSERT INTO Empleado VALUES (DEFAULT, 'Jose', 'Ruiz', '2007-08-07');
INSERT INTO Empleado VALUES (DEFAULT, 'Ana', 'Moreti', '2020-02-03');


INSERT INTO Curso VALUES ('S-123-1', 'Prevencion COVID', 'interno');
INSERT INTO Curso VALUES ('S-100-3', 'Primeros Auxilios', DEFAULT);
INSERT INTO Curso VALUES ('M-150-2', 'Marketing', 'interno');


INSERT INTO Realiza VALUES ((SELECT id FROM Empleado WHERE nombre = 'Clara' and apellido = 'Toledo'), 'S-123-1');
INSERT INTO Realiza VALUES ((SELECT id FROM Empleado WHERE nombre = 'Clara' and apellido = 'Toledo'), 'S-100-3');
INSERT INTO Realiza VALUES ((SELECT id FROM Empleado WHERE nombre = 'Clara' and apellido = 'Toledo'), 'M-150-2');
INSERT INTO Realiza VALUES ((SELECT id FROM Empleado WHERE nombre = 'Roberto' and apellido = 'Ocampo'), 'S-100-3');
INSERT INTO Realiza VALUES ((SELECT id FROM Empleado WHERE nombre = 'Jose' and apellido = 'Ruiz'), 'S-100-3');
INSERT INTO Realiza VALUES ((SELECT id FROM Empleado WHERE nombre = 'Jose' and apellido = 'Ruiz'), 'S-123-1');
INSERT INTO Realiza VALUES ((SELECT id FROM Empleado WHERE nombre = 'Ana' and apellido = 'Moreti'), 'S-123-1');



/* Ejercicio 5 */

DELETE FROM Empleado
WHERE apellido = 'Ocampo'
AND nombre = 'Roberto';

UPDATE Empleado
SET nombre = 'Ana Emilia'
WHERE nombre = 'Ana'
AND apellido = 'Moreti';


/* Ejercicio 6 */

SELECT nombre, apellido
FROM Empleado
WHERE date_format(ingreso, '%Y') < '2015';

/* Ejercicio 7 */


SELECT Empleado.nombre, apellido
FROM Empleado, Curso, Realiza
WHERE Empleado.id = Realiza.id
AND Realiza.codigo = Curso.codigo
AND Curso.nombre = 'Prevencion COVID';

/* Ejercicio 8 */

SELECT nombre, apellido
FROM Empleado
WHERE id IN (SELECT id
             FROM Realiza
	     GROUP BY id
             HAVING COUNT(*) = (SELECT COUNT(*) FROM Curso));





























































