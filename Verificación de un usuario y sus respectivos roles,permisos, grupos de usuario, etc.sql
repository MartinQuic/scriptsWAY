select * from grupoUsuario gu where grupousuarioid in ('1113');


select * from grupoUsuarioRol gur where gur.rolId in (79,99);

select * from rol r where r.nombre ='auxiliar de archivo'


select * from rolUsuario ru where usuarioid=4929;

select * from rolUsuario ru where usuarioid=3952;

select 
u.`user` 
,u.usuarioId 
,u.codigoEmpleado 
,ru.rolId 
,r.nombre
,gur.grupoUsuarioId 
,gu.nombre 
,gu.descripcion 
from usuario u, rolUsuario ru, rol r  , grupoUsuarioRol gur, grupoUsuario gu
where u.usuarioId=ru.usuarioId  -- usuario con rolUsuario
and r.rolId=ru.rolId  --  Rol con Rolusuario
and gur.rolId= ru.rolId 
and gu.grupoUsuarioId =gur.grupoUsuarioId
and u.usuarioId =3952;


select * 
from rol where rolId in (57,17,1)

select * from grupoUsuarioParticipante gup 



select * from grupoUsuario gu where gu.nombre like '%soporte%'

select * from grupoUsuarioRol gur where gur.grupoUsuarioId  in (2719,2720);

select * from vw_grupousuarioparticipante vg where vg.usuarioId in (3952,4929,4928);

show create view vw_grupousuarioparticipante  





