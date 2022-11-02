CREATE DATABASE IF NOT EXISTS jcaporalini_Bibioteca;

USE jcaporalini_Bibioteca;

DROP TABLE IF EXISTS Escribe;
DROP TABLE IF EXISTS Autor;
DROP TABLE IF EXISTS Libro;

CREATE TABLE Autor (
    id              INT         NOT NULL AUTO_INCREMENT,
    nombre          VARCHAR(20) NOT NULL,     
    apellido        VARCHAR(20) NOT NULL,
    nacionalidad    VARCHAR(20) NOT NULL,
    residencia      VARCHAR(20) NULL,
    PRIMARY KEY (id),
    INDEX (nombre, apellido)
);
DESCRIBE Autor;

CREATE TABLE Libro (
    isbn            VARCHAR(13) NOT NULL,
    titulo          VARCHAR(50) NOT NULL,
    editorial       VARCHAR(20) NOT NULL,
    precio          INT         NULL     DEFAULT NULL,
    PRIMARY KEY (isbn),
    INDEX (titulo)
);
DESCRIBE Libro;

CREATE TABLE Escribe (
    id              INT         NOT NULL,
    isbn            VARCHAR(13) NOT NULL,
    año             YEAR        NOT NULL,
    PRIMARY KEY (id, isbn),
    FOREIGN KEY (id) REFERENCES Autor(id) ON UPDATE CASCADE,
    FOREIGN KEY (isbn) REFERENCES Libro(isbn) ON DELETE CASCADE ON UPDATE CASCADE
);
DESCRIBE Escribe;

INSERT INTO Autor VALUES (DEFAULT, 'Aldous Leonard', 'Huxley', 'Britanico', NULL);
INSERT INTO Autor VALUES (DEFAULT, 'Eduardo Alfredo', 'Sacheri', 'Argentino', 'Buenos Aires');
INSERT INTO Autor VALUES (DEFAULT, 'Ray', 'Bradbury', 'Estadounidense', NULL);

INSERT INTO Autor VALUES (DEFAULT, 'Abelardo', 'Castillo ', 'Argentino', 'Rosario');

INSERT INTO Libro VALUES ('9789871138517', 'Un mundo feliz', 'Debolsillo', '3149');
INSERT INTO Libro VALUES ('9789588948386', 'La noche de la Usina', 'Alfaguara', 4522);
INSERT INTO Libro VALUES ('9789505472123', 'Fahrenheit 451', 'Minotauro', '2800');

INSERT INTO Escribe VALUES (
    (SELECT id FROM Autor WHERE nombre = 'Aldous Leonard' AND apellido = 'Huxley'),
    '9789871138517',
    '1932'
);

INSERT INTO Escribe VALUES (
    (SELECT id FROM Autor WHERE nombre = 'Eduardo Alfredo' AND apellido = 'Sacheri'),
    '9789588948386',
    2016
);

INSERT INTO Escribe VALUES (
    (SELECT id FROM Autor WHERE nombre = 'Ray' AND apellido = 'Bradbury'),
    '9789505472123',
    1932
);

UPDATE Autor
SET residencia = 'Buenos Aires'
WHERE id = (SELECT id FROM Autor WHERE nombre = 'Abelardo' AND apellido = 'Castillo');

UPDATE Libro
SET precio = precio + precio * 0.1
WHERE precio > 200 AND isbn IN (SELECT isbn FROM Autor, Escribe WHERE Autor.id = Escribe.id AND Autor.nacionalidad <> 'Argentino');

UPDATE Libro
SET precio = precio + precio * 0.1
WHERE precio <= 200 AND isbn IN (SELECT isbn FROM Autor, Escribe WHERE Autor.id = Escribe.id AND Autor.nacionalidad <> 'Argentino');

DELETE FROM Libro
WHERE isbn IN (SELECT isbn FROM Escribe WHERE año = 1998);

SELECT isbn
FROM Escribe
GROUP BY isbn
HAVING COUNT(*) = 2;
