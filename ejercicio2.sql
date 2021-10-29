CREATE DEFINER=`root`@`localhost` FUNCTION `ejercicio2`(equi CHAR (3)) RETURNS int(1)
BEGIN
DECLARE v_pg, v_partidos_ganados INT;
DECLARE v_local, v_visitante char(8);
DECLARE v_resloc, v_resvis INT(9);
DECLARE v_equi CHAR(8);
DECLARE v_salir INT DEFAULT 0;
DECLARE c_cursor CURSOR FOR SELECT local, visitante, reslocal, resvisit from partido where local=equi or visitante=equi;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_salir=1;
OPEN c_cursor;
bucle : LOOP
	FETCH c_cursor into v_local, v_visitante, v_resloc, v_resvis;
	IF v_salir=1 THEN
		leave bucle;
	END IF;
	IF v_local=equi AND v_resloc>v_resvis THEN
		set v_partidos_ganados=v_partidos_ganados+1;
	END IF;
	IF v_visitante=equi AND v_resloc<v_resvis THEN
		set v_partidos_ganados=v_partidos_ganados+1;
	END IF;
END LOOP;
CLOSE c_cursor;
set v_pg=(select pg from equipo where nombre=equi);
IF v_partidos_ganados=v_pg THEN
	RETURN 1;
ELSE
	RETURN 0;
END IF;
END