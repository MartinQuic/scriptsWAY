

select * from documentosFelComprasExterno dfce


SELECT 
serie,
numeroDte,
dr.autorizacion, 
total,
dr.fechaEmision ,
fechacertificacion,
dr.nitEmisor ,
dr.nombreComercial 
FROM dteRecibido dr
WHERE dr.organizacionId = 1
AND dr.origen = 0
-- AND nombreEmisor LIKE '%ultra%' -- NIT ultra: 4121899
 and dr.nitEmisor ='1529315'
order by dr.fechaEmision asc
-- LIMIT 10




select * from dteRecibido do 
where do.dteRecibidoId in 
		(select dri.dteRecibidoId   from dteRecibidoItem dri 
		where dri.descripcion like '%chasis%' 
		 )
 And do.nitEmisor='1198416' 		
	

select  dr.jsonDTE , dr.* from dteRecibido dr 
where dr.serie='B9955BC3'
and dr.numeroDte =308235309
limit 10
-- oc 15888 de prod, pegarle

-- 55303843	2726643257 usados en prueba de oc 746
-- EF243BAA usado

select * from dteRecibido






select * from parametroGeneral where parametroGeneralId  ='1132'

select * from parametroGeneralOrganizacion pgo where pgo.parametroGeneralId =1132

select * from tipoVentaPago tvp 








Select * from detalleVentaExterno where ventaid=358169;

Select * from ventaRecargoMetodoPago vrmp where vrmp.ventaId =358169;


select * from metodoPago mp where mp.metodoPagoId =305



select * from oferta where ofertaid=833;		-- del miércoles

select * from oferta where ofertaid=835;		-- del jueves



select * from parametroGeneral pg 

select * from parametroGeneral pg ,  parametroGeneralOrganizacion pgo
where pg.nombre like "%oferta%"
and pg.parametroGeneralId = pgo.parametroGeneralId and pg.parametroGeneralId =1132;




select * from usuario where usuarioId=264;



select * from usuario where `user` like '%prueba%'












select * from detalleVentaExterno dve
where dve.ventaId in (358304, 358305);

select * from venta v where v.ventaId  in (358304,358305);

select 
dv.ventaId,
d.dteId,
d.payloadSAT ,
d.responseSAT , 
d.estructuraDTE , 
d.responseSATAnulacion  
from dte d , dteVenta dv 
where d.dteId=dv.dteId 
and dv.ventaId  in (358377,358378,358379,358380,358381,358382,358384,358385,358386,358397 ); -- 358370,358371,358372,358373, 358375 

--  358363, 358375,


select * from empresaOrganizacionTasaCambio eotc where fecha 
order by fecha desc-- like '2026-02-24'


select *from articulo a where a.articuloId =1947;


select 
a.clasificacionArticuloId, 
a.sku , 
a.nombre   
from articulo a 
-- where a.clasificacionArticuloId =5001;

select * from articulo
where sku in ('26349','27642')

select * from articulo


select v.estadoId, v.* from venta v where v.ventaId =358318



select b.fecha, b.user,b.accion, b.descripcion, b.* from bitacora b
where b.entidadId ='64007'
and entidad like "%gasto%"
order by b.fecha DESC 














