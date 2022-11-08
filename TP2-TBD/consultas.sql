-- Peralta A., Lautaro	P-4970/1
-- Hess, Laureano	H-1139/8
-- Caporalini, Joaquin	C-6871/3

USE `jcaporalini_Inmobiliaria`;

-- A --
SELECT DISTINCT `nombre`, `apellido`
FROM `PoseeInmueble`, `Persona`
WHERE `codigo_propietario` = `codigo`;

-- B --
SELECT `codigo`
FROM  `Inmueble`
WHERE "precio" BETWEEN 600000 AND 700000;

-- C --
-- Sabemos que el codigo de los clientes coincide con el codigo de la persona
-- y que los no clientes no tienen codigo de cliente (valga la redundancia)
-- por lo que para evitar realizar otro producto usamos esta
-- relacion transitiva y colocamos unicamente Persona sin necesidad de usar Cliente también.
SELECT `nombre`
FROM `PrefiereZona`, `Persona`
WHERE `codigo_cliente` = `codigo` AND 
      `nombre_poblacion` = 'Santa Fe' AND 
      `nombre_zona` = 'Norte';

-- D --
SELECT `nombre`
FROM `Persona`, `Vendedor`
WHERE `Persona`.`codigo` = `Vendedor`.`codigo` AND
      `Vendedor`.`codigo` IN (
        SELECT `vendedor`
        FROM `Cliente`, `PrefiereZona`
        WHERE `codigo_cliente` = `Cliente`.`codigo` AND
              `nombre_poblacion` = 'Rosario' AND 
              `nombre_zona` = 'Centro'
);

-- E --
SELECT `nombre_zona`, COUNT(`codigo`), AVG(`precio`)
FROM `Inmueble`
WHERE `nombre_poblacion` = 'Rosario'
GROUP BY `nombre_zona`;

-- F --
SELECT `nombre`
FROM `Persona`
WHERE `codigo` IN (
      SELECT `codigo_cliente`
      FROM `PrefiereZona`
      WHERE `nombre_poblacion` = 'Santa Fe'
);

SELECT nombre
FROM Cliente, PrefiereZona, Persona
WHERE Cliente.codigo = PrefiereZona.codigo_cliente 
	AND PrefiereZona.nombre_poblacion = "Santa Fe"
	AND Persona.codigo = Cliente.codigo
GROUP BY Cliente.codigo
HAVING COUNT(DISTINCT PrefiereZona.nombre_zona) = (SELECT COUNT(*) FROM Zona WHERE nombre_poblacion = "Santa Fe");

-- G --
SELECT F.mes,COUNT(*)
FROM (SELECT MONTH(`fecha_hora`) mes, `codigo_inmueble`  FROM `Visitas` WHERE YEAR(`fecha_hora`) = YEAR(NOW())) F
GROUP BY F.mes;


-- (SELECT COUNT(DISTINCT `nombre_zona`) FROM `Zona` WHERE `nombre_poblacion` = 'Santa Fe');
