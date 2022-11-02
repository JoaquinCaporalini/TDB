USE `jcaporalini_Inmobiliaria`;

-- A --
SELECT DISTINCT `nombre`, `apellido`
FROM `PoseeInmueble`, `Persona`
WHERE `codigo_propietario` = `codigo`;

-- B --
SELECT `codigo`
FROM  `Inmueble`
WHERE 600000 < `precio` AND `precio` < 700000;

-- C --
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
SELECT `nombre_zona`,COUNT(`codigo`), AVG(`precio`)
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

-- G --
SELECT F.mes,COUNT(*)
FROM (SELECT MONTH(`fecha_hora`) mes, `codigo_inmueble`  FROM `Visitas` WHERE YEAR(`fecha_hora`) = YEAR(NOW())) F
GROUP BY F.mes;


-- (SELECT COUNT(DISTINCT `nombre_zona`) FROM `Zona` WHERE `nombre_poblacion` = 'Santa Fe');