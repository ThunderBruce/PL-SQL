CREATE DEFINER=`root`@`localhost` PROCEDURE `test`(p_idcuenta int (2), p_saldocuenta float (7,2))
    MODIFIES SQL DATA
BEGIN
	declare continue handler for 1062
	 select concat('Nº id cuenta ',p_idcuenta,' ya existente') as 'Aviso error';
	insert into saldos values (p_idcuenta,p_saldocuenta);
    
END