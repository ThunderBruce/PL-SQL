CREATE DEFINER=`root`@`localhost` PROCEDURE `informe_contry`(IN cod_pais char(3))
BEGIN
DECLARE v_error_code char(3);
DECLARE v_oficial enum('T','F');
DECLARE v_oficial2 VARCHAR(20);
DECLARE v_language VARCHAR(30);
DECLARE v_percentage float(4,1);
DECLARE v_existe INT DEFAULT 0;
DECLARE  v_ultima_fila INT DEFAULT 0;
DECLARE  v_ultima INT DEFAULT 0;
DECLARE c_lenguaje CURSOR FOR
	SELECT Language, IsOfficial,Percentage
		FROM countrylanguage WHERE CountryCode=cod_pais;
DECLARE c_pais CURSOR FOR
	SELECT Code
		FROM country;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_ultima_fila=1;
OPEN c_pais;
	bucle_code:LOOP
		FETCH c_pais INTO v_error_code;
		IF v_error_code=cod_pais THEN
			SET v_existe=1;
		END IF;
		IF v_ultima_fila=1 THEN
			LEAVE bucle_code;
		END IF;
	END LOOP bucle_code;
CLOSE c_pais;
SET v_ultima_fila=0;
IF v_existe=1 THEN
	SELECT ('***********************************************');
	SELECT ('****************Informe Resumen****************');
	SELECT ('***********************************************');
	SELECT ('');
	SELECT CONCAT('Pais: ',Name) FROM country WHERE Code=cod_pais;
	SELECT CONCAT('Capital: ',Name) FROM city WHERE ID =(SELECT Capital FROM country WHERE Code=cod_pais);
	SELECT ('');
	SELECT('************** 10 Principales ciudades ******************');
	SELECT ('');
	SELECT  CONCAT(RPAD(" Ciudad", 34, " "), "Población");						
	SELECT CONCAT(RPAD("*", 29, "*"), "     ", "**********"); 
	SELECT CONCAT(RPAD(Name, 34, " "), Population) FROM city WHERE CountryCode=cod_pais ORDER BY Population DESC LIMIT 10; 
    SELECT ('');
	SELECT ('*********** Idiomas Oficiales y No Oficiales ***************');
    SELECT ('');
	SELECT CONCAT(RPAD("Idioma", 34, " "),	"% Pobl.");						
	SELECT CONCAT(RPAD("*", 29, "*"), "     ", "**********"); 
	OPEN c_lenguaje;
		bucle_lenguaje:LOOP
			FETCH c_lenguaje INTO v_language,v_oficial,v_percentage;
			IF v_ultima_fila=1 THEN
				LEAVE bucle_lenguaje;
			END IF;
			IF v_oficial='T' THEN
				SET v_oficial2="(Oficial)";
			ELSE
				SET v_oficial2="(No Oficial)";
			END IF;
			SELECT CONCAT(RPAD(CONCAT(v_language, v_oficial2), 34, " "),	v_percentage);
		END LOOP bucle_lenguaje;
	CLOSE c_lenguaje;
ELSE
	SELECT ('***********************************************');
	SELECT ('****************Informe Resumen****************');
	SELECT ('***********************************************');
	SELECT ('');
	SELECT ('El codigo de ese pais no esta en la base de datos');
END IF;
END