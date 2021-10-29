CREATE PROCEDURE `procalm_6b` ()
BEGIN
declare i int default 0;
declare v_nom varchar (5);
declare v_puesto int;
declare v_uf int default 0;
declare c_liga cursor for
select nombre from equipo order by pg desc, dif desc;
open c_liga;
	bucle2: loop
	fetch c_liga into v_nom;
	if v_uf=1 then 
	leave bucle2;
	end if;
	set i=i+1;
	update equipo set puesto = i where nombre=v_nom;
end loop bucle2;
close c_liga;
END
