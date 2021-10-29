CREATE DEFINER=`root`@`localhost` PROCEDURE `procalm_2`()
BEGIN
	DECLARE v_col1 float (9,2);
	DECLARE v_col2 float (9,2);
	DECLARE v_msg varchar (40);
	DECLARE v_msg2 varchar (40);
	DECLARE v_fecha DATE DEFAULT '21/9/09';
    SET v_col1=1;
	mibucle: LOOP
		SET v_col2=v_col1*100;
		IF v_col1 = 11 THEN
			LEAVE mibucle;
		END IF;
		IF v_col1%2 = 0 THEN
			SET v_msg2= CONCAT(v_col1,' es par');
			INSERT INTO temp (COL1,COL2,MSG,FECHA) VALUES (v_col1,v_col2,v_msg2,v_fecha);
		ELSE
			SET v_msg= CONCAT(v_col1,' es impar');
			INSERT INTO temp (COL1,COL2,MSG,FECHA) VALUES (v_col1,v_col2,v_msg,v_fecha);
		END IF;
        SET v_col1=v_col1+1;
	END LOOP mibucle;
		
END