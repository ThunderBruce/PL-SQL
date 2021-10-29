CREATE DEFINER=`root`@`localhost` PROCEDURE `procalm_5`()
BEGIN
DECLARE v_id_art char (2);
DECLARE v_INC INT (3);
DECLARE v_ultima_fila INT DEFAULT 0;
DECLARE c_incremento cursor for
SELECT * FROM ART_INC;
DECLARE CONTINUE handler FOR NOT FOUND SET v_ultima_fila=1;
OPEN c_incremento;
segundo_bucle: loop
fetch c_incremento into v_id_art, v_INC;
	IF v_ultima_fila=1 then
		leave segundo_bucle;
	end if;
	UPDATE stock SET cant=cant+((cant*v_INC)/100) WHERE id_art=v_id_art;
end loop;
END