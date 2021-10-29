CREATE DEFINER=`root`@`localhost` PROCEDURE `repaso_procedimientos`()
BEGIN
DECLARE v_idprod int;
DECLARE v_cantidad int;
DECLARE v_salir int default 0;
DECLARE c_cursor CURSOR FOR SELECT IdProducto,UnidadesEnPedido FROM productos;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_salir=1;
OPEN c_cursor;
bucle: LOOP
	FETCH c_cursor into v_idprod,v_cantidad;
	IF v_salir=1 THEN
		LEAVE bucle;
	END IF;
	SELECT (SUM(Cantidad)) into v_cantidad
	FROM detalles_pedido WHERE IdProducto=v_idprod
	GROUP BY IdProducto;
	UPDATE productos SET UnidadesEnPedido=v_cantidad WHERE IdProducto=v_idprod;
END LOOP;
CLOSE c_cursor;
END