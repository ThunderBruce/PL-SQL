CREATE DEFINER=`root`@`localhost` FUNCTION `testfecha`() RETURNS int(11)
BEGIN
declare restafecha int (2);
declare fecha_entrada date;
declare fecha_salida date;
set fecha_entrada=(select entrada from reservas where reserva=199908005);
set fecha_salida=(select salida from reservas where reserva=199908005);
set restafecha=(select datediff(fecha_salida,fecha_entrada)+1);
return restafecha;
END