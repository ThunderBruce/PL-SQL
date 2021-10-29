CREATE DEFINER=`root`@`localhost` PROCEDURE `procalm_3`(in p_cod_emp integer)
BEGIN
	DECLARE V_SALARIO INT;
	declare V_NOMBRE VARCHAR(10);
	DECLARE V_CAT VARCHAR(1);
	SELECT numem into V_NOMBRE
	FROM empleados
	where p_cod_emp=numem;
	SELECT salario into V_SALARIO
	FROM empleados
	where p_cod_emp=numem;
	if V_SALARIO>=400 then
	SET V_CAT='A';
	elseif 400 >V_SALARIO AND V_SALARIO>= 300 THEN
	SET V_CAT='B';
	ELSE 
	SET V_CAT='C';
	END IF;
	INSERT INTO CAT_EMP VALUES(p_cod_emp,V_NOMBRE,V_CAT);
END