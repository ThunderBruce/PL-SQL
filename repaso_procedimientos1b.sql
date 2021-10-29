CREATE DEFINER=`root`@`localhost` TRIGGER `repaso_procedimientos1b` BEFORE INSERT ON `detalles_pedido` FOR EACH ROW
BEGIN
DECLARE v_idprod, v_pedido, v_existencia int;
DECLARE v_ultimafila, v_valido INT DEFAULT 0;
DECLARE v_mensajeError VARCHAR (200);
DECLARE ERR_IDENTIFICADOR_NO_VALIDO CONDITION FOR SQLSTATE '45000';
DECLARE c_cursor CURSOR FOR SELECT IdProducto, UnidadesEnPedido, UnidadesEnExistencia FROM Productos;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_ultimafila=1;
OPEN c_cursor;
bucle: LOOP
	FETCH c_cursor into v_idprod, v_pedido, v_existencia;
	IF v_ultimafila=1 THEN
		LEAVE bucle;
	END IF;
	IF v_idprod=NEW.IdProducto THEN
		IF v_existencia>NEW.Cantidad THEN
			UPDATE PRODUCTOS SET UnidadesEnExistencia=(v_existencia-NEW.Cantidad), UnidadesEnPedido=(v_pedido+NEW.Cantidad) WHERE IdProducto=v_idprod;
		ELSE
			SET v_valido=1;
		END IF;
	END IF;
END LOOP;
CLOSE c_cursor;
SET v_mensajeError=(SELECT(CONCAT('No se ha podido dar de alta el pedido: ',NEW.IdPedido,' con el producto: ',NEW.IdProducto,'porque supera a la cantidad en existencia')));
IF v_valido=1 THEN 
	SIGNAL ERR_IDENTIFICADOR_NO_VALIDO -- raise an error
	SET MESSAGE_TEXT=v_mensajeError;
END IF;
END