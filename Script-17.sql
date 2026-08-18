/*
-- articulo
-- compra
-- recepcion
-- venta
-- serie 

 select * from preCargaSerie pcs where serie='lc6pcjk69t0002181';
 
  select * 
  -- delete 
  from preCargaSerie  where serie in ('LC6PCJGE7T0028164');
  
  select * from marcaVehiculo mv 
  
select  * 
-- delete
from estadoArticuloBodegaSerie  where serie  ='LC6PCJGE0T0020326'; 
  
 select * from estadoArticuloBodegaSerie eabs where serie= 'lc6pcjk69t0002181';

-- Quiero crear una vista que me permita ver una serie desde donde nazca, ya sea en precarga o factura registrada por compra. y cómo se alimenta cada campo conforme avanza esta serie en cada etapa y módulo.
*/

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
where dv.ventaId  = 852560;

select * from ventaAbonoAcordado vaa  where ventaid=359123;

select * from reciboPago rp where rp.clienteid=104281      --   rp.reciboPagoId =2040034;



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





-- 2012 -> Botón Anular para moratorios no aplica
select * from credito c 
-- update credito set fechaInicio = date_add(fechaInicio, interval 14 day), fechaCreacion = date_add(fechaCreacion, interval 14 day)
where ventaId  in ('359765','359766','359767','359768');    -- ventaId  in ('359765','359766','359767','359768')


select date_sub(fechaInicio, interval 14 day) ,  cc.* from creditoCuota cc 
-- update creditoCuota set fechaInicio = date_sub(fechaInicio, interval 14 day), fechaPago = date_sub(fechaPago, interval 14 day)
where creditoId  in (select creditoId  from credito c where ventaId  in ('359768'));



select date_sub(fechaCreacion, interval 181 day), fechaCreacion from creditoCuota  
where creditoId  in (select creditoId  from credito c where ventaId  in ('359765'));



select date_add(cc.fechaInicio, interval 5 month) ,  cc.* from creditoCuota cc 
-- update creditoCuota set fechaInicio = date_add(fechaInicio, interval 5 month), fechaPago = date_add(fechaPago, interval 5 month)
where creditoId  in (select creditoId  from credito c where ventaId  in ('359766'));

select * from creditoMora cm where cm.creditoId ='446579';
 

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
where dv.ventaId  in ( 359673,359674,'127650T');


select * from dte where dteid=311870;


-- 	VER QUÉ ROL TIENE ACCESO A CIERTO MENÚ Y SUBMENÚS
select 
r.nombre as Nombre_Rol,
m.nombre as Nombre_Menu,
m.ruta,
m.menuId,
m.menuPadre,
m.nivel
from menu m, rolMenu rm, 		-- MENU, CONTIENE EL NOMBRE DEL MENU Y SU RESPECTIVO NIVEL
rol r, rolUsuario ru
where m.menuId = rm.menuId 
and rm.rolId =r.rolId 
and r.rolId = ru.rolId 
and m.nombre like '%deudores%'
# and rm.menuId =316				-- Menu, La ruta y nivel que tiene el menu
-- and m.nivel =2					-- Menu, La ruta y nivel que tiene el menu
group by r.nombre, m.nombre;


 
-- 2012 -> Botón Anular para moratorios no aplica 
 
 






-- FACTURAS DTERECIBIDO
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
-- and dr.numeroDte ='3675341723'
 and dr.nitEmisor='1529315'
 and dr.serie='6C222991'
order by dr.fechaEmision desc
-- LIMIT 10
;


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
where cf.fechaRegistro > '2026-05-01'
 -- and u.`user` in ("diego.quiñonez")
 and cf.serie  in ('6C222991')




select * from cliente where cui= 2076945240801;



select * from usuario where `user`  in ('jorge.perez','rodman.lopez','carlos.alfaro','roberto.gonzalez','martin.quic')


select * from venta where ventaid='360071';

select * from dte where dteId='2053606';


select * from cliente where nit=82090785;

select * from cliente where cui in (2076945240802,2076945240801);


select * from historialSIB 
-- delete from historialSIB
where clienteid=481 and fechaCreacion > '2026-01-01';

select * from tipoIve ti ;



 