call sp_recalcularCredito(81728);




select  r.nombre, r.rolId  , u.codigoempleado, u.`user`, u.estadoid   
from usuario u, rolUsuario ru , rol r
where u.usuarioid= ru.usuarioid 
and ru.rolid = r.rolid 
and r.organizacionId =1
and r.rolid=88
#and u.estadoid=1
order by u.`user` asc; 


select * from compra where po = 704;

select * from detalleVentaOferta dvo where dvo.ventaId =30147;

select * from factura

select* from vw_traslado vt where DESCRIPCION="289317";

show create view vw_traslado