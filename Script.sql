select * from simply.estado e -- where nombre like('%cliente%')



select * from simply.estadoArticuloBodegaSerie eabs where serie in ('*LC6PCJGE7T0002924*')

select b.nombre, pcs.serie   from simply.preCargaSerie pcs, bodega b
where pcs.bodegaId =b.bodegaId 


SELECT * FROM estadoArticuloBodegaSerieHistorico where serie in ('*LC6PCJGE7T0002924*')



select  g.codigoExterno  ,g.* from gasto g where gastoId =69246;

-- json de gastos verlo en la bd intermedio que es el api


select * from reciboPago rp where esAnticipada=1 -- 1 es si, 0 es no

select * from metodoPago mp 


select * from creditoCuota cc 

select  
vdvnc.sku , 
vdvnc.aporteProveedor, 
vdvnc.aporteMaxProveedor  ,
vdvnc.ofertaAporteMax ,  
vdvnc.* 
from vw_detalleVenta_notaCredito vdvnc 
where ventaid=265281;




select * from pago p  limit 100   -- where p.pagoId =142235
;

select * from vw_pago vp limit 100;





Select * from venta where ventaid in ('755516','757037');

Select * from ventaAnticipo va where ventaid=755516;

select * from cliente c where c.razonSocial ='maria monterroso';

select * from anticipo a where anticipoid=8857;


select date_add(fechaInicio,  interval 61 day)as nueva_Fecha,
fechaInicio,
c.*
from credito c 
-- update credito set fechaInicio= fechaInicio - interval 61 DAY  -- dato inicial= 2026-04-13 12:23:08.000
where creditoId =238521;

select * from creditoProntoPagoSolicitud cpps where cpps.creditoId =223061;

select * from creditoCuota cc where cc.creditoId =238521;




select * from ventaOferta vo  limit 100 -- where vo.ofertaId =13446;

select * from oferta o where ofertaid in ('13446','13448','13449','13450','13451','13452','13453','13454','13687') limit 100


select * from vw_detalleVenta vdv where vdv.sku  in ('42175','27824')  and vdv.codigoPuntoVenta ='E04' and vdv.fechaCreacion >'2026-04-01';

select * from detalleventa


select * from dteRecibido dr where dr.autorizacion ='02368A70-EFD7-4F0B-91CC-3FE8086191A0' 


select * from compraFactura where estadoExternoId is not null



-- PARA VALIDACIONES DE INTEGRACIONES

select d.dteId, v.ventaId, d.estadoExternoId, d.codigoExterno, d.payloadSAT, d.responseSAT, d.esAutoconsumo, d.esRegalo, d.esRecargoVehiculo from dte d
inner join dteVenta dv
on dv.dteId = d.dteId
inner join venta v
on dv.ventaId = v.ventaId
where dv.ventaId  = 358982;

-- PARA VALIDACIONES DE INTEGRACIONES






