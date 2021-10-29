CREATE DEFINER=`root`@`localhost` TRIGGER `reservas`.`reservas_BEFORE_INSERT` AFTER INSERT ON `reservas` FOR EACH ROW
BEGIN
DECLARE v_precio int ;
DECLARE v_dias int;
DECLARE v_precioTotal int;
SELECT (DATEDIFF(NEW.SALIDA,NEW.ENTRADA)+1) INTO v_dias FROM reservas where RESERVA=NEW.RESERVA;
SET v_precio=(select p.precio_dia from reservas r 
						join apartamentos a on r.apartamento=a.apartamento
						join precios p on a.grupo_precio=p.grupo 
						where RESERVA=NEW.RESERVA);
SET v_precioTotal=(v_dias*v_precio);
INSERT INTO facturacion VALUES (NEW.RESERVA, v_precioTotal, NULL, "Pendiente de pago");
END