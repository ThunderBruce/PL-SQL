CREATE DEFINER=`root`@`localhost` PROCEDURE `procalm_1`(in pdeptno int)
BEGIN

select * from empleados where numde=pdeptno;

END