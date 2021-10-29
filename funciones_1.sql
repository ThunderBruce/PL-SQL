CREATE DEFINER=`root`@`localhost` FUNCTION `funciones_1`(p_departamentos int (2)) RETURNS int(1)
BEGIN
DECLARE v_departamentos int (2);
DECLARE v_salir,v_ad int default 0;
declare c_cursor CURSOR FOR 
					SELECT numde from departamentos;
					
declare continue handler for not found set v_salir=1;

open c_cursor;
	bucle :LOOP
	fetch c_cursor into v_departamentos;
		IF v_salir=1 then 
		leave bucle;
		END IF;
		
		IF v_departamentos=p_departamentos then
			return 1;
		ELSE
			SET v_ad=1;
		END IF;
	END LOOP bucle;
close c_cursor;
IF v_ad=1 then
	return 0;
END IF;
END