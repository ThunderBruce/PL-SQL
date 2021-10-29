CREATE DEFINER=`root`@`localhost` PROCEDURE `procalm_4`(in p_cont integer)
BEGIN
DECLARE v_salario, v_numem float (9,2);
DECLARE v_nomem varchar (40);
DECLARE v_cont INT (2) default 0;
DECLARE c_empleados cursor for 
select salario, numem, nomem
from empleados
order by salario desc;
declare continue handler for not found set v_cont=p_cont;
open c_empleados;
emp_cursor: loop
	fetch c_empleados into v_salario, v_numem, v_nomem;
	if v_cont=p_cont then
		leave emp_cursor;
	end if;
	set v_cont=v_cont+1;
	insert into temp values (v_salario, v_numem,v_nomem,'21-1-09');
end loop;
close c_empleados;
END
