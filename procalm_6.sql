CREATE DEFINER=`root`@`localhost` PROCEDURE `procalm_6`()
BEGIN
declare v_pf int (3);
declare v_pc int (3);
declare v_pg int (1) default 0;
declare v_pp int (1) default 0;
declare v_dif int (3);
declare v_uf int default 0;
declare v_rl int (3);
declare v_rv int (3);
declare v_local char (5);
declare v_vis char (5);
declare c_liga cursor for
select local,visitante,reslocal,resvisit 
from partido;
DECLARE CONTINUE handler FOR NOT FOUND SET v_uf=1;
open c_liga;
tercer_bucle: loop
 fetch c_liga into v_local, v_vis, v_rl, v_rv;
 	IF v_uf=1 then
		leave tercer_bucle;
	end if;
	if v_rl>v_rv then
		set v_pg=1;
		UPDATE equipo SET pg=pg+v_pg,pf=pf+v_rl,pc=pc+v_rv where nombre=v_local;
		set v_pp=1;
		UPDATE equipo set pp=pp+v_pp,pc=pc+v_rl,pf=pf+v_rv where nombre=v_vis;
	else
		set v_pp=1;
		UPDATE equipo set pp=pp+v_pp,pc=pc+v_rv,pf=pf+v_rl where nombre=v_local;
		set v_pg=1;
		UPDATE equipo set pg=pg+v_pg,pc=pc+v_rl,pf=pf+v_rv where nombre=v_vis;
        END IF;
	end loop tercer_bucle;
close c_liga;
update equipo set dif=pf-pc;
END