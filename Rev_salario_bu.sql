CREATE DEFINER=`root`@`localhost` TRIGGER `practica1`.`Rev_salario_bu` BEFORE UPDATE ON `empleados` FOR EACH ROW
BEGIN
DECLARE v_mimensaje varchar (200);
DECLARE v_salario int (11);
DECLARE v_departamento, v_minsal, v_maxsal int (3);
DECLARE v_salir, v_valido INT DEFAULT 0;
DECLARE ERR_IDENTIFICADOR_NO_VALIDO CONDITION FOR SQLSTATE '45000';
DECLARE c_cursor CURSOR FOR SELECT * FROM GUIA_SAL; 
declare continue handler for not found set v_salir=1;
OPEN c_cursor;
	bucle: LOOP
		FETCH c_cursor INTO v_departamento, v_minsal, v_maxsal;
		IF v_salir=1 THEN
			leave bucle;
		END IF;
		IF v_departamento=OLD.numde THEN 
			IF ((NEW.salario>v_minsal || NEW.salario=v_minsal) && (NEW.salario<v_maxsal || NEW.salario=v_maxsal)) THEN 
				SET v_valido=1;
			END IF;
		END IF;
	END LOOP bucle;
CLOSE c_cursor;
SET v_mimensaje=(SELECT(CONCAT('¡Salario ',NEW.salario,'$ esta fuera de rango de DEPARTAMENTO ',NEW.numde,' para el empleado', NEW.nomem)));
IF v_valido=1 THEN
	SIGNAL ERR_IDENTIFICADOR_NO_VALIDO -- raise an error
	SET MESSAGE_TEXT=v_mimensaje;	
END IF;
END