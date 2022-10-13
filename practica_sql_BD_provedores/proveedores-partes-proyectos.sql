-- source proveedores-partes-proyectos.sql

CREATE DATABASE IF NOT EXISTS jcaporalini_ProveedoresPartesProyectos;

USE jcaporalini_ProveedoresPartesProyectos;

DROP TABLE IF EXISTS SPJ;
DROP TABLE IF EXISTS S;
DROP TABLE IF EXISTS P;
DROP TABLE IF EXISTS J;

-- CREATE TABLE S (
--     id        INT IDENTITY NOT NULL, 
--     s 	      AS ('S' + RIGHT('0000' + CONVERT(VARCHAR, id), 4)),
--     snombre 	VARCHAR(10)	NOT NULL,
--     situacion VARCHAR(30)	NOT NULL,
--     ciudad    VARCHAR(10) NOT NULL,
--     PRIMARY KEY (s)
-- );

-- describe S;
CREATE TABLE S (
    s 	        CHAR(2)     NOT NULL,
    snombre 	VARCHAR(15)	NOT NULL,
    situacion   INT(30),
    ciudad      VARCHAR(10) NOT NULL,
    PRIMARY KEY (s)
);

-- describe P;
CREATE TABLE P (
    p 		    CHAR(2)     NOT NULL,
    pnombre 	VARCHAR(15)	NOT NULL,
    color       VARCHAR(30)	NOT NULL,
    peso        INT         NOT NULL,
    ciudad      VARCHAR(10) NOT NULL,
    PRIMARY KEY (p)
);

-- describe J;
CREATE TABLE J (
    j 		    CHAR(2)     NOT NULL,
    jnombre 	VARCHAR(15)	NOT NULL,
    ciudad      VARCHAR(10) NOT NULL,
    PRIMARY KEY (j)
);

-- describe SPJ;
CREATE TABLE SPJ (
    s           CHAR(2)     NOT NULL,
    p           CHAR(2)     NOT NULL,
    j           CHAR(2)     NOT NULL,
    cant        INT,
    PRIMARY KEY (s, p, j),
    FOREIGN KEY (s) REFERENCES S(s) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (p) REFERENCES P(p) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (j) REFERENCES J(j) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO S VALUES ('S1', 'Salazar', '20', 'Londres');
INSERT INTO S VALUES ('S2', 'Jaimes', '10', 'Paris');
INSERT INTO S VALUES ('S3', 'Bernal', '30', 'Paris');
INSERT INTO S VALUES ('S4', 'Corona', '20', 'Londres');
INSERT INTO S VALUES ('S5', 'Aldana', '30', 'Atenas');

INSERT INTO P VALUES ('P1', 'Tuerca', 'Rojo', '12', 'Londres');
INSERT INTO P VALUES ('P2', 'Perno', 'Verde', '17', 'Paris');
INSERT INTO P VALUES ('P3', 'Burlete', 'Azul', '17', 'Roma');
INSERT INTO P VALUES ('P4', 'Burlete', 'Rojo', '14', 'Londres');
INSERT INTO P VALUES ('P5', 'Leva', 'Azul', '12', 'Paris');
INSERT INTO P VALUES ('P6', 'Engranaje', 'Rojo', '19', 'Londres');

INSERT INTO J VALUES ('J1', 'Clasificador', 'Paris');
INSERT INTO J VALUES ('J2', 'Perforadora', 'Roma');
INSERT INTO J VALUES ('J3', 'Lector', 'Atenas');
INSERT INTO J VALUES ('J4', 'Consola', 'Atenas');
INSERT INTO J VALUES ('J5', 'Compaginador', 'Londres');
INSERT INTO J VALUES ('J6', 'Terminal', 'Oslo');
INSERT INTO J VALUES ('J7', 'Cinta', 'Londres');

INSERT INTO SPJ VALUES ('S1', 'P1', 'J1', '200');
INSERT INTO SPJ VALUES ('S1', 'P1', 'J4', '700');

INSERT INTO SPJ VALUES ('S2', 'P3', 'J1', '400');
INSERT INTO SPJ VALUES ('S2', 'P3', 'J2', '200');
INSERT INTO SPJ VALUES ('S2', 'P3', 'J3', '200');
INSERT INTO SPJ VALUES ('S2', 'P3', 'J4', '500');
INSERT INTO SPJ VALUES ('S2', 'P3', 'J5', '600');
INSERT INTO SPJ VALUES ('S2', 'P3', 'J6', '400');
INSERT INTO SPJ VALUES ('S2', 'P3', 'J7', '800');
INSERT INTO SPJ VALUES ('S2', 'P5', 'J2', '100');

INSERT INTO SPJ VALUES ('S3', 'P3', 'J1', '200');
INSERT INTO SPJ VALUES ('S3', 'P4', 'J2', '500');

INSERT INTO SPJ VALUES ('S4', 'P6', 'J3', '300');
INSERT INTO SPJ VALUES ('S4', 'P6', 'J7', '300');

INSERT INTO SPJ VALUES ('S5', 'P2', 'J2', '200');
INSERT INTO SPJ VALUES ('S5', 'P2', 'J4', '100');
INSERT INTO SPJ VALUES ('S5', 'P5', 'J5', '500');
INSERT INTO SPJ VALUES ('S5', 'P5', 'J7', '100');
INSERT INTO SPJ VALUES ('S5', 'P1', 'J4', '100');
INSERT INTO SPJ VALUES ('S5', 'P3', 'J4', '200');
INSERT INTO SPJ VALUES ('S5', 'P4', 'J4', '800');
INSERT INTO SPJ VALUES ('S5', 'P5', 'J4', '400');
INSERT INTO SPJ VALUES ('S5', 'P6', 'J4', '500');

/* Ejercicio 01 */
SELECT *
FROM J;
/* Ejercicio 02 */
SELECT *
FROM J
WHERE Ciudad = 'Londres';
/* Ejercicio 03 */
/* Ejercicio 04 */
/* Ejercicio 05 */
/* Ejercicio 06 */
/* Ejercicio 07 */
/* Ejercicio 08 */
SELECT s, p, j
FROM S, P, J
WHERE   S.ciudad <> P.ciudad AND 
        P.ciudad <> J.ciudad AND
        J.ciudad <> S.ciudad;
/* Ejercicio 09 */
/* Ejercicio 10 */
/* Ejercicio 11 */
/* Ejercicio 12 */
/* Ejercicio 13 */
/* Ejercicio 14 */
SELECT SPJx.p, SPJy.p
FROM SPJ SPJx, SPJ SPJy
WHERE   SPJx.s = SPJy.s AND
        SPJx.p > SPJy.p;
/* Ejercicio 15 */
/* Ejercicio 16 */
SELECT SUM(cant)
FROM SPJ
WHERE p = 'P1' AND s = 'S1'; 
/* Ejercicio 17 */
SELECT p, j, SUM(cant) FROM SPJ GROUP BY p, j;
/* Ejercicio 18 */
SELECT p
FROM SPJ
GROUP BY p
HAVING AVG(cant) > 320;
/* Ejercicio 19 */
SELECT s, p, j, cant
FROM SPJ
WHERE cant IS NOT NULL;
/* Ejercicio 20 */
SELECT j, jnombre
FROM J
WHERE jnombre LIKE '_o%';
/* Ejercicio 21 */
SELECT jnombre
FROM J
WHERE j IN (SELECT j FROM SPJ WHERE s = 'S1'); 
/* Ejercicio 22 */
SELECT DISTINCT color
FROM P
WHERE p IN (
    SELECT p 
    FROM SPJ, S
    WHERE SPJ.s = S.s AND ciudad = 'Londres'
    );
/* Ejercicio 23 */
SELECT DISTINCT p
FROM SPJ
WHERE j IN (
    SELECT j
    FROM J
    WHERE ciudad = 'Londres'
    );
/* Ejercicio 24 */
SELECT DISTINCT j
FROM J
WHERE j IN (
    SELECT j
    FROM SPJ
    WHERE S = "S1"
);
/* Ejercicio 25 */
SELECT DISTINCT s
FROM SPJ
WHERE p IN (
    SELECT p
    FROM P
    WHERE color = 'Rojo'
    );
/* Ejercicio 26 */
SELECT s
FROM S
WHERE situacion < (SELECT situacion FROM S WHERE s = 'S1');
/* Ejercicio 27 */
SELECT j
FROM J
WHERE ciudad = (
    SELECT MIN(ciudad)
    FROM SPJ, J
    WHERE SPJ.j = J.j
    );
/* Ejercicio 28 */
SELECT DISTINCT p
FROM SPJ
WHERE EXISTS (
    SELECT *
    FROM J
    WHERE SPJ.j = J.j AND ciudad = 'Londres'
);
/* Ejercicio 29 */
SELECT DISTINCT j
FROM J
WHERE EXISTS (
    SELECT *
    FROM SPJ
    WHERE SPJ.j = J.j AND S = 'S1'
);
/* Ejercicio 30 */
SELECT DISTINCT j
FROM SPJ
WHERE EXISTS (
    SELECT *
    FROM P
    WHERE EXISTS(
        SELECT *
        FROM S
        WHERE   S.s <> 'Londres' AND
                P.color <> 'Rojo' AND
                S.s = SPJ.s AND
                P.p = SPJ.p
    )
);
/* Ejercicio 31 */
SELECT DISTINCT j
FROM J
WHERE NOT EXISTS(
    SELECT * 
    FROM SPJ
    WHERE   SPJ.j = J.j AND
            SPJ.s <> 'S1'
);

/* Ejercicio 32 */
(SELECT ciudad FROM P) 
UNION 
(SELECT ciudad FROM J) 
UNION 
(SELECT ciudad FROM S);
/* Ejercicio 33 */
UPDATE P
SET color = 'Gris'
WHERE color = 'Rojo';
/* Ejercicio 34 */
DELETE 
FROM J
WHERE j NOT IN (SELECT DISTINCT j FROM SPJ);
/* Ejercicio 35 */
INSERT INTO S VALUES ('S9', 'Salazar', NULL,'Nueva York');

--SELECT p FROM SPJ, J WHERE SPJ.j = J.j AND ciudad = 'Londres';
-- SELECT ciudad FROM SPJ, J WHERE SPJ.j = J.j


