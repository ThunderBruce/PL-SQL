CREATE DEFINER=`root`@`localhost` FUNCTION `funciones_2`(dep int (2)) RETURNS int(11)
begin
declare v_existe int;
declare v_sumasal int (11);
set v_existe=funciones_1(dep);
IF v_existe=0 then 
	return -1;
ELSE
	set v_sumasal=(select sum(salario) from empleados where numde=dep);
    return v_sumasal;
END IF;
END