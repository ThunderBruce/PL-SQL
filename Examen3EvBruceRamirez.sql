--EJERCICIO 1

CREATE OR REPLACE TYPE TITULO AS OBJECT
(TITULO_ORIGINAL VARCHAR2(100),
TITULO_TRADUCIDO VARCHAR2(100)); 

CREATE OR REPLACE TYPE ACTOR AS OBJECT
(NOMBRE VARCHAR2(50),
NACIONALIDAD VARCHAR2(50),
ANIO_NAC INTEGER(10)); 

--EJERCICIO 2
CREATE TYPE actoresArray IS VARRAY(10) OF ACTOR;

--EJERCICIO 3
CREATE OR REPLACE TYPE DATOSPELICULA AS OBJECT
(NOMBRE TITULO,
DIRECTOR VARCHAR2(50),
PROTAGONISTAS actoresArray); 

--EJERCICIO 4
CREATE TABLE MISPELICULAS (
CLAVE NUMBER(3)	PRIMARY KEY,
DATOS DATOSPELICULA);

create sequence claves_pelis

--BLOQUE PL/SQL 

DECLARE
CLAVE NUMBER(3);
BEGIN
for i in 1..4
LOOP
CLAVE:=claves_pelis.nextVal;
if i=1 THEN
	INSERT INTO MISPELICULAS VALUES (CLAVE, DATOSPELICULA(TITULO('Red Sparrow','Gorrion Rojo'),'Javier',actoresArray(ACTOR('Jennifer Lawrence','USA',1984),ACTOR('Joel Edgertom','USA',1974))));
END IF;
if i=2 THEN
	INSERT INTO MISPELICULAS VALUES (CLAVE, DATOSPELICULA(TITULO('A quiet place','Un lugar tranquilo'),'Javier',actoresArray(ACTOR('Emily Blunt','USA',1980),ACTOR('John Krasinski','UK',1977),ACTOR('Millicent Simmons','USA',1964))));
END IF;
if i=3 THEN
	INSERT INTO MISPELICULAS VALUES (CLAVE, DATOSPELICULA(TITULO('Avengers: Infinity war','Vengadores: Infinity war'),'Javier',actoresArray(ACTOR('Rober Downey','USA',1966),ACTOR('Chris Hemsworth','UK',1985),ACTOR('Scarlett Johanson','AUS',1981))));
END IF;
if i=4 THEN
	INSERT INTO MISPELICULAS VALUES(CLAVE, DATOSPELICULA(TITULO('12 strongs','12 valientes'),'Javier',actoresArray(ACTOR('Chris Hemsworth','UK',1985),ACTOR('Michael Sannon','GER',1980),ACTOR('Navid Negahban','AUS',1981),ACTOR('Michael Peña','MEX',1982))));
END IF;
END LOOP;
END;

-- EJERCICIO 5

SELECT c.datos.nombre.titulo_original, t.nombre, t.nacionalidad, t.anio_nac from mispeliculas c, TABLE (c.datos.protagonistas) t;
--EJERCICIO 6

CREATE OR REPLACE TYPE SALAS_CINE AS OBJECT
(IDSALA NUMBER(2),
NOMBRESALA VARCHAR2(50),
NUMBUTACAS NUMBER(4));

CREATE TABLE SALAS_CINE_TABLA of SALAS_CINE

INSERT INTO SALAS_CINE_TABLA VALUES (1,'Cines Callao', 80);
INSERT INTO SALAS_CINE_TABLA VALUES (2,'Cines Isla Azul',75);
INSERT INTO SALAS_CINE_TABLA VALUES (3,'Cines Idea',90);

--EJERCICIO 7
ALTER TABLE MISPELICULAS ADD(SALA REF SALAS_CINE);

--EJERCICIO 8
UPDATE MISPELICULAS f set sala=(select ref(e) from salas_cine_tabla e where e.idsala=1) where f.datos.nombre.titulo_original='Red Sparrow';
UPDATE MISPELICULAS f set sala=(select ref(e) from salas_cine_tabla e where e.idsala=2) where f.datos.nombre.titulo_original='A quiet place';
UPDATE MISPELICULAS f set sala=(select ref(e) from salas_cine_tabla e where e.idsala=2) where f.datos.nombre.titulo_original='Avengers: Infinity war';
UPDATE MISPELICULAS f set sala=(select ref(e) from salas_cine_tabla e where e.idsala=3) where f.datos.nombre.titulo_original='12 strongs';

--EJERCICIO 9

ALTER TYPE DATOSPELICULA
ADD MAP MEMBER FUNCTION ORDENAR RETURN NUMBER CASCADE;

CREATE OR REPLACE TYPE BODY DATOSPELICULA AS	
MAP MEMBER FUNCTION ORDENAR RETURN NUMBER IS
	cantidad NUMBER;
BEGIN
cantidad := SELECT COUNT(c.datos.protagonistas) from mispeliculas c where c.datos.nombre.titulo_original = self.datos.nombre.titulo_original;
RETURN cantidad;
END ORDENAR;
END;
/
--Otra posibilidad

ALTER TYPE DATOSPELICULA
ADD MAP MEMBER FUNCTION ORDENAR RETURN NUMBER CASCADE;

CREATE OR REPLACE TYPE BODY DATOSPELICULA AS
MAP MEMBER FUNCTION ORDENAR RETURN NUMBER IS
cantidad NUMBER;
BEGIN
cantidad := self.actoresArray.COUNT;
return cantidad;
END ORDENAR;
END;
/

select b.datos.nombre.titulo_original from mispeliculas b order by b.datos.protagonistas desc;
--EJERCICIO 10

ALTER TYPE DATOSPELICULA
ADD
MEMBER PROCEDURE addactor (newactor VARCHAR2, newnacionalidad varchar2, newannonac int) cascade;

ALTER TYPE DATOSPELICULA
ADD MAP MEMBER FUNCTION ORDENAR RETURN NUMBER CASCADE;

CREATE OR REPLACE TYPE BODY DATOSPELICULA AS	
MAP MEMBER FUNCTION ORDENAR RETURN NUMBER IS
	cantidad NUMBER;
BEGIN
cantidad := SELECT COUNT(c.datos.protagonistas) from mispeliculas c where c.datos.nombre.titulo_original = self.datos.nombre.titulo_original;
RETURN cantidad;
END ORDENAR;

MEMBER PROCEDURE addactor(newactor, newnacionalidad, newannonac) IS
BEGIN
v_array actoresArray;
SELECT INTO 
END;
