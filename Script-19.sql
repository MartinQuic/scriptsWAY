
select date_add(fechaInicio,  interval 61 day)as nueva_Fecha,
fechaInicio,
c.*
from credito c 
-- update credito set fechaInicio= fechaInicio - interval 61 DAY  -- dato inicial= 2026-04-13 12:23:08.000
where creditoId =456558;


select * from creditoCuota cc where cc.creditoId =238521;



select * from estadoArticuloBodegaSerie eabs where serie in ('*LHJJJKLA4VB505763*')

select * from preCargaSerie pcs where serie in ('*LHJJJKLA4VB505763*')

SELECT * FROM estadoArticuloBodegaSerieHistorico where serie in ('*LHJJJKLA4VB505763*')

select * from ventaAbonoAcordado vaa where vaa.montoAbono ='10005.00';

select * from pago p where monto='10005.00'


select * from cliente c where c.nombres = 'martin alexander'

select * from proveedor p where nit like '%-%'

select p.nit , p.nombre , cp.clasificacionId, c.nombre  
from clasificacionProveedor cp , proveedor p, clasificacion c
where cp.proveedorId =p.proveedorId 
and c.clasificacionId =cp.clasificacionId 
and cp.clasificacionId =3
and nit is null;

select * from clasificacion c 







select 
d.fechaCreacion,
d.dteId, 
v.ventaId, 
d.estadoExternoId as EstadoExt, 
ee.descripcion ,
d.codigoExterno as CodExt,
v.total ,
d.payloadSAT, 
d.responseSAT,
d.estructuraDTE, 
d.esAutoconsumo as AutoCons, 
d.esRegalo as Reg, 
d.esRecargoVehiculo as RecVeh 
from dte d
inner join dteVenta dv
on dv.dteId = d.dteId
inner join venta v
on dv.ventaId = v.ventaId
inner join estadoExterno ee 
on ee.estadoExternoId =d.estadoExternoId 
where dv.ventaId  in ( 359673,359674);







select * from usuario where `user` = 'pruebas.proyectos';





select 
cb.cuentaBancariaId,
cb.noCuenta ,
cb.bancoId,
b.nombre,
b.organizacionId,
cb.codigoExterno 
from cuentaBancaria cb , banco  b
where cb.bancoid= b.bancoId
-- and cb.codigoExterno  in ('37','38','39')
and b.organizacionId=2
-- order by b.organizacionId 



Select 
a.sku, 
a.nombre,
a.categoriaArticuloId ,
a.clasificacionArticuloId, 
a.tipoPrecioId   , 
a.costo, 
a.precioContado , 
a.precio, 
ca.nombre 
from articulo a , categoriaArticulo ca  
where a.categoriaArticuloId = ca.categoriaArticuloId  
and sku='25557' limit 100;


select
calh.creditoAbonoLibreHistoricoId  as 'Id Solicitud',
calh.creditoId  as 'idCredito',
calh.fechaCreacion as 'Fecha solicitud',
calh.fechaAprobacion as 'Fecha Atencion',
TIMESTAMPDIFF(HOUR, calh.fechaCreacion, calh.fechaAprobacion) as 'Tiempo de espera (hrs)',
CASE calh.aprobado
	WHEN '1' THEN 'Aprobado'
	WHEN '2' THEN 'Rechazado'
ELSE 'Pendiente'
END as 'Tipo',
REGEXP_REPLACE(calh.comentario, '[^a-zA-Z0-9áéíóúÁÉÍÓÚñÑ ]', '') as 'Comentario de atencion',
u2.codigoEmpleado as 'Cod solicitante',
CONCAT(u2.nombres, ' ',u2.apellidos)  as 'Usuario solicitante',
u.codigoEmpleado as 'Cod atencion',
CONCAT(u.nombres, ' ',u.apellidos)  as 'Usuario atencion'
from creditoAbonoLibreHistorico calh
left join usuario u on calh.usuarioAprobadorId = u.usuarioId
left join usuario u2 on calh.usuarioSolicitanteId = u2.usuarioId
where u2.codigoEmpleado not in (0001,'prue001',4075)
and not calh.aprobado=2
order by calh.creditoAbonoLibreHistoricoId  asc ;
 













-- VALIDACIÓN DE USO DE MÓDULO DE INGRESO DE FACTURAS PARA COMPRAS DE FORMA COLECTIVA
select year(fechaRegistro) anio
      ,month(fechaRegistro) mes      
      ,u.user usuario
	   ,sum(case when coalesce(cf.compraFacturaTipoImportacionId,0) = 1 then 1 else 0 end) simple
      ,sum(case when coalesce(cf.compraFacturaTipoImportacionId,0) = 2 then 1 else 0 end) compleja
      , sum(case when coalesce(cf.compraFacturaTipoImportacionId,0) not in (1,2) then 1 else 0 end) manual
      ,round(sum(case when coalesce(cf.compraFacturaTipoImportacionId,0) not in (1,2) then 1 else 0 end)/count(1),2) "porcentaje uso Manual"
      ,count(1) cantidad
  from compraFactura cf
inner join usuario u
    on u.usuarioId = cf.usuarioCreacionId
where cf.fechaRegistro > '2026-05-01'
and u.`user` not in ("jose.felipe", "martin.quic")
group by year(fechaRegistro),month(fechaRegistro), usuario
order by mes,"porcentaje uso Manual" desc;








-- VALIDAR CUÁL ES EL PORCENTAJE DE USO MANUAL POR INDIVIDUO 
select year(fechaRegistro) anio
      ,month(fechaRegistro) mes      
      ,u.user usuario
	   ,sum(case when coalesce(cf.compraFacturaTipoImportacionId,0) = 1 then 1 else 0 end) simple
      ,sum(case when coalesce(cf.compraFacturaTipoImportacionId,0) = 2 then 1 else 0 end) compleja
      , sum(case when coalesce(cf.compraFacturaTipoImportacionId,0) not in (1,2) then 1 else 0 end) manual
      ,round(sum(case when coalesce(cf.compraFacturaTipoImportacionId,0) not in (1,2) then 1 else 0 end)/count(1),2) porcentajeCompleja
      ,count(1) cantidad
  from compraFactura cf
inner join usuario u
    on u.usuarioId = cf.usuarioCreacionId
where cf.fechaRegistro > '2026-05-01'
and u.`user`  in ("ashlin.somarriba")
-- group by year(fechaRegistro),month(fechaRegistro), usuario
order by mes,porcentajeCompleja desc ;









-- VALIDAR TIPOS DE INGRESO POR FACTURAS INDIVIDUALES O COLECTIVOS
select year(fechaRegistro) anio
      ,cf.fechaRegistro      
      ,u.user usuario
      ,cf.nitEmisor 
      ,cf.razonSocial,
      case
		when cf.compraFacturaTipoImportacionId  in (1,2) then "Módulo Nuevo" else "Ingreso Manual"
		End as Tipo_Ingreso
		,cf.compraId 
  from compraFactura cf
inner join usuario u
    on u.usuarioId = cf.usuarioCreacionId
where cf.fechaRegistro > '2026-01-01'
 -- and u.`user` in ("diego.quiñonez")
 and cf.serie  in ('F4C6E914'
)
--  and cf.compraFacturaTipoImportacionId is null
-- group by year(fechaRegistro),month(fechaRegistro), usuario
order by cf.fechaRegistro  desc ;



select 
rp.reciboPagoId , 
rp.razonSocial, 
rp.total, 
e.nombre, 
rp.comentarioAnulacion, 
rp.fechaCreacion , 
rp.fechaAnulacion     
from reciboPago rp, estado e
where rp.estadoId = e.estadoId  
and rp.fechaCreacion >= '2026-05-04' 
and total = 400 
and rp.receptorId ='1633885121801';


-- FACTURAS DTERECIBIDO
SELECT 
serie,
numeroDte,
dr.autorizacion, 
total,
dr.fechaEmision ,
fechacertificacion,
dr.nitEmisor ,
dr.nombreComercial ,
dr.*
FROM dteRecibido dr
WHERE dr.organizacionId = 1
AND dr.origen = 0
-- and dr.numeroDte in ('3414443397',964512305,3913763933)
-- and dr.nitEmisor='321052'
 and dr.serie='60c1080e'
order by dr.fechaEmision desc
-- LIMIT 10
;


select * from moneda m 

select * from creditoProntoPagoSolicitud cpps -- tabla cruda de solic. sencillas

select * from creditoAbonoLibreHistorico calh 
 
 

-- COMPROBAR LA DIFERENCIA DE DÍAS ENTRE FECHAS REGISTRADAS.
SELECT CASE
         WHEN cf.compraFacturaTipoImportacionId = 1
           THEN 'Nuevo Método'
         ELSE 'Mét_Viejo'
       END AS Método,
       u.user,
       cf.fechaCreacion, 
       cf.serie,
       cf.dte,
       cf.fechaEmision AS FEmision_Compra_impor,
       dr.fechaEmision AS FEmision_DTERecibido,
       dr.fechaCertificacion,
       datediff(cf.fechaEmision, dr.fechaEmision) as 'Diferencia de Días'
FROM compraFactura cf,
     dteRecibido dr, usuario u
WHERE cf.serie = dr.serie
  AND cf.dte = dr.numeroDte
  and u.usuarioID= cf.usuarioCreacionId 
   -- and cf.fechaCreacion >'2026-05-28'
and dte in ( '3332262604',
'2753642908',
'1296453404',
'2020230696',
'2578204208',
'1034964921',
'1848004522',
'3596635139',
'1315521043',
'3378267053',
'2022658040',
'1730626958',
'2590525938',
'43994235',
'1514555148',
'1560759914',
'1113146131',
'4120922561',
'678119192'
)


select 
cf.compraId  , 
cf.fechaEmision ,
cf.fechaRecepcion, 
-- cf.fechaRegistro ,
cf.fechaCreacion,
cf.dte 
from compraFactura cf 
where serie='60263B51';

select  
dr.serie , 
dr.nombreComercial , 
dr.fechaEmision ,
dr.fechaCertificacion  
from dteRecibido dr 
where dr.serie = '60263B51';


select 
cf.compraId  , 
cf.fechaEmision ,
cf.fechaRecepcion, 
-- cf.fechaRegistro ,
cf.fechaCreacion   
from compraFactura cf 
where serie='a4d040f5';

select  
dr.serie , 
dr.nombreComercial , 
dr.fechaEmision ,
dr.fechaCertificacion  
from dteRecibido dr 
where dr.serie = 'a4d040f5';



-- VALIDACIÓN DE USO DE MÓDULO DE INGRESO DE FACTURAS PARA COMPRAS







select * from cliente where tipoNITId =227 and  nit is not  Null order by nit desc ;  -- nit= 'CF' and cui > 0;




select t.nombre , t.jsonPreconfiguracion  from tag t
where t.tagId in (15,347,402,428,454,455,460,465,466,1394,1470,1316,2773,5525)

select * from categoriaArticulo ca  where ca.categoriaArticuloId =5101;





select * from usuario where `user`  in ('jorge.perez','rodman.lopez','carlos.alfaro','roberto.gonzalez','martin.quic')



SELECT 
    dr.numeroDte,
    dr.serie,
    dr.total AS Total_Factura,
    SUM((dri.cantidad * dri.precioUnitario)-dri.descuento )
    	+ dr.impuestoPetroleo +dr.impuestoTasaMunicipal
    	+ dr.impuestoBomberos +dr.impuestoTrimbrePrensa 
    	+ dr.impuestoTurismoHospedaje     AS Total_Detalle,
    dr.total - (SUM((dri.cantidad * dri.precioUnitario) -(dri.descuento ))
    	+ dr.impuestoPetroleo+ dr.impuestoTasaMunicipal
    	+ dr.impuestoBomberos+ dr.impuestoTrimbrePrensa 
    	+ dr.impuestoTurismoHospedaje  )    AS Diferencia,
    dr.nitEmisor,
    dr.nombreEmisor
FROM dteRecibidoItem dri
INNER JOIN dteRecibido dr 
    ON dri.dteRecibidoId = dr.dteRecibidoId
where /*dr.nitEmisor ='4121899'
    and*/  dr.fechaEmision > '2026-01-01'
     and dr.origen =0
    -- and dr.nitEmisor='12691402'
     and dr.serie ='F4C6E914'
    -- and dr.serie in('F4C6E914','8199BA2C','20D50E2A','DD18E656','B42E2E94','DDEEFC40','78CD455F','2A36AFCB','F10C44C7')
GROUP BY 
    dr.numeroDte,
    dr.serie,
    dr.total
-- HAVING dr.total <> SUM((dri.cantidad * dri.precioUnitario)+ (dr.impuestoPetroleo + dr.impuestoTasaMunicipal ) -dri.descuento ) 
order by Diferencia desc;



select 
dr.dteRecibidoId ,
dr.nitEmisor,
dr.nombreEmisor ,
dr.total,
dri.precioUnitario,
sum(dri.precioUnitario * dri.cantidad +(dr.impuestoPetroleo -dri.descuento  ) )
from dteRecibido dr , dteRecibidoItem dri 
where dr.dteRecibidoId =dri.dteRecibidoId 
and dr.serie='3687B366'
and dr.numeroDte='1000164761';




select 
dr.dteRecibidoId,
dri.dteRecibidoItemId, 
dr.origen,
dr.total,
dri.cantidad ,
dri.precioUnitario,
sum(dri.cantidad * dri.precioUnitario ) as Precio,
dr.*,
dri.*
from dteRecibido dr , dteRecibidoItem dri 
where dr.dteRecibidoId =dri.dteRecibidoId 
and dr.serie='4DC098B7'
and dr.numeroDte='2437958030';



select * from dteRecibido dr
where  dr.serie='B908E4BC'
and dr.numeroDte='1002719296';



SELECT 
*
FROM dteRecibido dr
WHERE dr.numeroDte = '1429946424'
AND dr.serie = 'DD18E656'

select sum(dr.precio) from dteRecibidoItem dr
WHERE dr.dteRecibidoId  = '1668150'







