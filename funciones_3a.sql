CREATE DEFINER=`root`@`localhost` FUNCTION `funciones_3a`(p_res int (11)) RETURNS int(1)
BEGIN 
DECLARE v_res int(11);
DECLARE v_salir, v_ad int default 0;
DECLARE c_cursor CURSOR FOR SELECT reserva from reservas;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_salir=1;
open c_cursor;
	bucle:LOOP
		FETCH c_cursor INTO v_res;
		IF v_salir=1 THEN
			leave bucle;
		END IF;
		
		IF v_res=p_res THEN
			RETURN 1;
		ELSE
			SET v_ad=1;
		END IF;
	END LOOP bucle;
CLOSE c_cursor;
IF v_ad=1 THEN
	return 0;
END IF;
END