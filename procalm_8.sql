CREATE DEFINER=`root`@`localhost` PROCEDURE `procalm_8`()
BEGIN
DECLARE v_id_cuenta INT;
DECLARE v_saldo INT;
DECLARE v_operacion CHAR(1);
DECLARE v_insert INT DEFAULT 0;
DECLARE v_salir INT DEFAULT 0;

DECLARE c_cursor CURSOR FOR SELECT id_cuenta, tipo_op, nuevo_saldo FROM acciones;

DECLARE CONTINUE HANDLER FOR 1062 SET v_insert = 1;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_salir = 1;

OPEN c_cursor;

bucle: LOOP
	FETCH c_cursor INTO v_id_cuenta, v_operacion, v_saldo;
    IF v_salir = 1 THEN
		LEAVE bucle;
	END IF;
    IF v_operacion = 'I' OR v_operacion = 'U' THEN
		
        INSERT INTO saldos VALUES(v_id_cuenta, v_saldo);
        
        IF v_insert = 1 AND v_operacion = "U" THEN
			
            UPDATE saldos SET saldo_cuenta = v_saldo WHERE id_cuenta = v_id_cuenta;
            
		ELSEIF v_insert = 1 AND v_operacion = "I" THEN
        
		   UPDATE acciones SET incidentes = "UPDATE en lugar de INSERT " WHERE id_cuenta = v_id_cuenta;
           UPDATE saldos SET saldo_cuenta = v_saldo WHERE id_cuenta = v_id_cuenta;
            
		ELSEIF v_insert = 0 AND v_operacion = "U" THEN
			
           UPDATE saldos SET saldo_cuenta = v_saldo WHERE id_cuenta = v_id_cuenta;
		   UPDATE acciones SET incidentes = "INSERT en lugar de UPDATE" WHERE id_cuenta = v_id_cuenta;
            
        END IF;
	
    ELSE
		UPDATE acciones SET incidentes = "Operacion invalida" WHERE id_cuenta = v_id_cuenta;
    
    END IF;
    SET v_insert = 0;
END LOOP;

CLOSE c_cursor;

END