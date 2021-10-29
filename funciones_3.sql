CREATE DEFINER=`root`@`localhost` FUNCTION `funciones_3`(res int (11)) RETURNS int(7)
BEGIN 
DECLARE v_precio int(3);
DECLARE v_reserva int (11);
DECLARE v_fecha_entrada date;
DECLARE v_fecha_salida date;
DECLARE v_salir int default 0;
DECLARE diasTrans INT (3);
DECLARE precioFinal int (7);
DECLARE v_existe int;
						
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_salir=1;
SET v_existe=funciones_3a(res);
IF v_existe=0 THEN
	RETURN -1;
ELSE
	SET v_reserva=(select reserva from reservas where reserva=res);
	SET v_fecha_entrada=(select entrada from reservas where reserva=res);
	SET v_fecha_salida=(select salida from reservas where reserva=res);
	SET v_precio=(select p.precio_dia from reservas r 
						join apartamentos a on r.apartamento=a.apartamento
						join precios p on a.grupo_precio=p.grupo 
						where reserva=res);
	SET diasTrans=(select datediff(v_fecha_salida,v_fecha_entrada)+1);
	SET precioFinal=diasTrans*v_precio;
	RETURN precioFinal;
END IF;
END