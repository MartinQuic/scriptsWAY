
SELECT 
    dr.numeroDte,
    dr.serie,
    dr.total AS Total_Factura,
    SUM((dri.cantidad * dri.precioUnitario)- COALESCE(dri.descuento,0 ) )
    	+ dr.impuestoPetroleo +dr.impuestoTasaMunicipal
    	+ dr.impuestoBomberos +dr.impuestoTrimbrePrensa 
    	+ dr.impuestoTurismoHospedaje     AS Total_Detalle,
    dr.total - (SUM((dri.cantidad * dri.precioUnitario) -COALESCE(dri.descuento,0 ))
    	+ dr.impuestoPetroleo+ dr.impuestoTasaMunicipal
    	+ dr.impuestoBomberos+ dr.impuestoTrimbrePrensa 
    	+ dr.impuestoTurismoHospedaje  )    AS Diferencia,
    dr.nitEmisor,
    dr.nombreEmisor
FROM dteRecibidoItem dri
INNER JOIN dteRecibido dr 
    ON dr.dteRecibidoId = dri.dteRecibidoId
where /*dr.nitEmisor ='4121899'
    and*/  dr.fechaEmision > '2026-07-01'
     and dr.origen =0
    -- and dr.nitEmisor='12691402'
    -- and dr.serie ='0AC6B91F'
    -- and dr.serie in('F4C6E914','8199BA2C','20D50E2A','DD18E656','B42E2E94','DDEEFC40','78CD455F','2A36AFCB','F10C44C7')
GROUP BY 
    dr.numeroDte,
    dr.serie,
    dr.total
 HAVING dr.total <> SUM((dri.cantidad * dri.precioUnitario)+ (dr.impuestoPetroleo + dr.impuestoTasaMunicipal ) -dri.descuento ) 
order by Diferencia desc;

-- 90.16  impuesto turismo hospedaje no se muestra en factura.
-- 7192.976000000000


select 
dr.dteRecibidoId,
dri.dteRecibidoItemId, 
dr.origen,
dr.total,
dri.cantidad ,
dri.precioUnitario,
sum(dri.cantidad * dri.precioUnitario ) as Precio,
dr.impuestoPetroleo ,
dr.impuestoTasaMunicipal,
dri.descuento,
dr.impuestoBomberos,
dr.jsonDTE ,
dr.*,
dri.*
from simply.dteRecibido dr , simply.dteRecibidoItem dri 
where dr.dteRecibidoId =dri.dteRecibidoId 
and dr.serie='F10C44C7'
-- and dr.numeroDte='654983277';



select * from dteRecibidoItem dr
WHERE dr.dteRecibidoId  = '1669603'


select * from historialSIB hs where clienteid=8771;

select * from tipoIve ti ;




select * from dteRecibido do 
where do.dteRecibidoId in 
		(select dri.dteRecibidoId   from dteRecibidoItem dri 
		where dri.descripcion like '%chasis%' 
		 )
 And do.nitEmisor='1198416' 	





select 
dr.dteRecibidoId ,
dr.nitEmisor,
dr.nombreEmisor ,
dr.total,
dri.precioUnitario,
sum(dri.precioUnitario * dri.cantidad +(dr.impuestoPetroleo -dri.descuento  ) )
from simply.dteRecibido dr , simply.dteRecibidoItem dri 
where dr.dteRecibidoId =dri.dteRecibidoId 
and dr.serie='8B292286'
-- and dr.numeroDte='1000164761';








select  dr.* from dteRecibido dr
where  dr.serie='B908E4BC'
and dr.numeroDte='1002719296';



SELECT 
*
FROM dteRecibido dr
WHERE dr.numeroDte = '1429946424'
AND dr.serie = 'DD18E656'




-- PARA VALIDACION DE INTEGRACIONES
select 
d.fechaCreacion,
d.dteId, 
v.ventaId, 
d.estadoExternoId as EstadoExt, 
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
where d.estadoExternoId =1 -- dv.ventaId  = 1076736
and d.fechaCreacion> '2026-08-01' ;





select 
p.pagoId,
p.reciboPagoId, 
p.monto ,
rp.razonSocial
from pago p , reciboPago rp
where rp.reciboPagoId = p.reciboPagoId 
and p.recibopagoid in (2040046 ,2040047)
-- and rp.ventaId  =359127
;

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
where dv.ventaId  in (359976,359977,359987); -- 

-- PARA VALIDACION DE INTEGRACIONES







