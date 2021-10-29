CREATE DEFINER=`root`@`localhost` PROCEDURE `ejercicio1`()
BEGIN
DECLARE v_apellido varchar(8);
DECLARE v_departamento int(2);
DECLARE v_oficio VARCHAR(10);
DECLARE v_salario FLOAT(6,2);
DECLARE v_director int(4);
DECLARE v_empno INT(4);
DECLARE v_fecha_alta, v_fecha_actual date;
DECLARE v_salir INT DEFAULT 0;
DECLARE v_trienio, v_comp_resp, v_total, v_diff_fecha, v_dinero, v_dinerojefe, v_comision, v_tiempo, v_tiempod INT;
DECLARE c_cursor CURSOR FOR SELECT emp_no,apellido,oficio,salario,director,fecha_alta,dep_no
								FROM EMPLEADOS;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_salir=1;
OPEN c_cursor;
bucle : LOOP
	FETCH c_cursor into v_empno, v_apellido,v_oficio,v_salario,v_director,v_fecha_alta,v_departamento;
	IF v_salir=1 THEN 
		leave bucle;
	END IF;
	set v_comision=0000.00;
	set v_fecha_actual='2018-03-13';
	set v_tiempo=(SELECT DATEDIFF(v_fecha_actual,v_fecha_alta));
	set v_tiempod=1095;
	set v_trienio=(SELECT TRUNCATE(v_tiempo,v_tiempod));
	set v_dinero=v_trienio*50;
	if v_oficio='EMPLEADO' OR 'VENDEDOR' OR 'ANALISTA' THEN
		set v_comp_resp=NULL;
	ELSE
		set v_comp_resp=(SELECT COUNT(director) from empleados where director=v_empno); 
		set v_dinerojefe=v_comp_resp*100;
	END IF;
	SET v_total=v_dinero+v_dinerojefe;
	INSERT INTO T_liquidacion VALUES (v_apellido,v_departamento,v_oficio,v_salario,v_dinero,v_dinerojefe,v_comision,v_total);
END LOOP;
CLOSE c_cursor;
END