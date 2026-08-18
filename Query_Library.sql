-- VER EL ROL ID Y SU RESPECTIVO NOMBRE
Select 
	r.rolId ,
	nombre,
	descripcion, 
	alias,
	r.estadoId 
from rol r 
Where not estadoid=2
and nombre='auxiliar de archivo';



-- VER LOS PERMISOS DE CIERTO ROL o CUANTOS ROLES TIENEN CIERTO PERMISO
select
rp.permisoID,
p.nombre as Nombre_Permiso ,
r.rolid,
r.nombre as Nombre_Rol
from rolPermiso rp, rol r, permiso p
where rp.rolId = r.rolId
and p.permisoId =rp.permisoId
-- and rp.permisoId=126
And r.nombre in ('Auxiliar de archivo','Analista Créditos (Supervisor)'  ) -- BÚSQUEDA POR NOMBRE DE ROL
-- and p.nombre IN ('Modificar el detalle de venta','Modificación total de la descripción del detalle de venta')   -- BÚSQUEDA POR EL NOMBRE DEL PERMISO
-- and p.nombre like ('%modif%')
-- and rp.permisoId in (125,138)
order by Nombre_Rol ASC
;




-- VER QUE PERSONAS ESTÁN ASIGNADAS A UN ROL
select  
r.nombre, 
r.rolId  , 
u.codigoempleado, 
u.`user`,
concat(u.nombres , ' ', u.apellidos  ) as Nombre_Completo,
Case 
	when u.organizacionId = 1 then "WAY/EPA" else "EKIPA" 
end as Empresa,
u.organizacionId 
from usuario u, rolUsuario ru , rol r
where u.usuarioid= ru.usuarioid 
and ru.rolid = r.rolid 
 and u.estadoid=1
and u.organizacionId =1
-- and r.rolid in (99)
-- and r.nombre = 'Vendedor (Agencia Simply)'
and  r.nombre in ('Auxiliar de archivo')
GROUP  by codigoempleado ; -- 105 y 23


-- VER LAS PERSONAS QUE ESTÁN EN CIERTO GRUPO DE USUARIOS (en este caso me sirvió para sacar a todos los que no correspondían al grupo de aprobadores de recogidos.)
select 
gu.nombre , 
u.codigoEmpleado , 
u.nombres , 
u.apellidos  
from grupoUsuarioParticipante gup , grupoUsuario gu, usuario u
where gu.grupoUsuarioId =gup.grupoUsuarioId 
and gup.usuarioId =u.usuarioId 
-- and gu.nombre like "%aprobadores - entregas Voluntarias (recogidos)%"
and u.codigoEmpleado in ('6035','5967')
and not u.codigoEmpleado in ('1093','4904', '0847','3798','2895','0001','3931','5335','5215','n01');  -- Códigos de empleados de técnicos y el de dámaris es 1093


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




-- VER QUE ROL/ROLES TIENE UN USUARIO
SELECT 
u.codigoEmpleado,
u.user,
concat( u. nombres ,' ',  u.apellidos) ,
u.estadoID,
r.rolId,
r.nombre,
p.nombre 
from usuario u, rolUsuario ru , rol r, rolPermiso rp, permiso p
where u.usuarioID = ru.usuarioId 
and ru.rolId = r.rolId
and r.rolId = rp.rolId 
and rp.permisoId = p.permisoId 
-- and u.codigoEmpleado =4075
-- group by r.nombre
and p.nombre= "Venta"
;




-- VER CUANTAS PERSONAS TIENEN CIERTA CAJA
select 
vus.codigoEmpleado , 
NOMBRES, 
APELLIDOS, 
ROL, 
ESTADO, 
BODEGA, 
CAJAPUNTOVENTA 
from vw_usuariosSimply vus 
where vus.tienda like "%cabri%" 
and vus.cajaPuntoVenta like "%cabri%"




-- VER LA SERIE Y CUÁNTAS VECES SE HA UTILIZADO
select serie, count(serie) 
from vw_series vs 
group by serie 
having count(serie)>1;






-- PARA SABER QUÉ USUARIOS ESTÁN EN CIERTO GRUPO DE USUARIOS
select 
u.user,
gu.nombre,
u.nombres,
u.apellidos,
r.nombre 
from grupoUsuarioParticipante gup, usuario u, grupoUsuario gu, rol r, rolUsuario ru 
where gup.grupoUsuarioId  = gu.grupoUsuarioId   
and u.usuarioId = gup.usuarioId 
and r.rolId = ru.rolId 
and ru.usuarioId = u.usuarioId
and gu.nombre like "%aprobadores - entregas Voluntarias (recogidos)%"
 and not u.user ='priscila.quino'
;



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
-- and dr.nitEmisor='1529315'   -- > Nit de Diveco
 and dr.serie='379afc82'
order by dr.fechaEmision desc
-- LIMIT 10
;





-- Desasociar una Factura de una Contraseña
CALL sp_desasociar_factura_contraseña(20326); -- (Comprafacturaid)
 




-- Ver los request y response (Json)  
select 
	dv.ventaId,
	d.dteId,
	d.payloadSAT ,
	d.responseSAT , 
	d.estructuraDTE , 
	d.responseSATAnulacion  
from dte d , dteVenta dv 
where d.dteId=dv.dteId 
and dv.ventaId  in (743442);



-- Tabla de Uso de Metodos de ingreso de facturas
select u.`user` usuario
      ,count(1) facturasIngresadas
      ,sum(case when compraFacturaTipoImportacionId is null then 1 else 0 end) metodoAntiguo
      ,sum(case when compraFacturaTipoImportacionId = 1 then 1 else 0 end) metodoNuevo
  from compraFactura cf
inner join usuario u
    on u.usuarioId = cf.usuarioCreacionId
where cf.fechaCreacion > '2026-05-01'
group by u.user;


-- EXTRAER DTES QUE CONTENGAN CHASIS
select do.nitEmisor , do.nombreEmisor,do.serie, do.numeroDte, do.autorizacion   ,do.* from dteRecibido do 
where do.dteRecibidoId in 
		(select dri.dteRecibidoId   from dteRecibidoItem dri 
		where dri.descripcion like '%chasis%' 
		 )
 And do.nitEmisor='1198416' 

 
-- PARA VALIDACIONES DE INTEGRACIONES
select 
d.fechaCreacion,
d.dteId, 
v.ventaId, 
d.estadoExternoId as EstadoExt, 
d.codigoExterno as CodExt,
v.total ,
d.payloadSAT, 
d.responseSAT, 
d.esAutoconsumo as AutoCons, 
d.esRegalo as Reg, 
d.esRecargoVehiculo as RecVeh 
from dte d
inner join dteVenta dv
on dv.dteId = d.dteId
inner join venta v
on dv.ventaId = v.ventaId
where dv.ventaId  = 359093;

-- PARA VALIDACIONES DE INTEGRACIONES


-- PARAMETRO GENERAL PARA BLOQUE EN PRONTOPAGO Y ABONO
Select * from 
parametroGeneralOrganizacion pgo 
where pgo.organizacionId =1
and pgo.parametroGeneralId =1136;


-- REPORTE DE PRONTOPAGOS AUTORIZADOS O NO
select
cpps.creditoProntoPagoSolicitudId as 'Id Solicitud',
cpps.creditoId  as 'idCredito',
cpps.fechaCreacion as 'Fecha solicitud',
cpps.fechaAprobacion as 'Fecha Atencion',
TIMESTAMPDIFF(HOUR, cpps.fechaCreacion, cpps.fechaAprobacion) as 'Tiempo de espera (hrs)',
CASE cpps.aprobado
	WHEN '1' THEN 'Aprobado'
	WHEN '2' THEN 'Rechazado'
ELSE 'Pendiente'
END as 'Tipo',
REGEXP_REPLACE(cpps.comentario, '[^a-zA-Z0-9áéíóúÁÉÍÓÚñÑ ]', '') as 'Comentario de atencion',
u2.codigoEmpleado as 'Cod solicitante',
CONCAT(u2.nombres, ' ',u2.apellidos)  as 'Usuario solicitante',
u.codigoEmpleado as 'Cod atencion',
CONCAT(u.nombres, ' ',u.apellidos)  as 'Usuario atencion'
from creditoProntoPagoSolicitud cpps
left join usuario u on cpps.usuarioAprobadorId = u.usuarioId
left join usuario u2 on cpps.usuarioSolicitanteId = u2.usuarioId
where u2.codigoEmpleado not in ('0001','prue001','4075')
and cpps.aprobado=1
-- and cpps.creditoId =179714
order by cpps.creditoProntoPagoSolicitudId asc ;













*******************************************************************************************************************************
*******************************************************************************************************************************
*******************************************************************************************************************************
*******************************************************************************************************************************
-- TABLAS A VERIFICAR EL MONTO EN Q PARA LA PARTE DE ODOO---------------------------------------------------------------------
-- Manejarlo por medio de la ficha del proveedor


/* 1 */select c.total, c.subTotal , c.* from compra c where compraId = 27730; 							
-- 2587.20 actulizado "Encabezado general de compra"

select cc.total, cc.* from compraCotizacion cc where compraId = 27730; 			
-- "Encabezado de compra cotización"

select ccd.precio, ccd.total , ccd.* from compraCotizacionDetalle ccd where compraId = 27730; 		
-- "Detalle de compra"

select cf.monto, cf.* from compraFactura cf where compraId = 27730; 							
-- "Encabezado de factura"

select cfd.monto, cfd.* from compraFacturaDetalle cfd where compraId = 27730; 					
-- "detalle de factura"

select crd.precio, crd.* from compraRecepcionDetalle crd where compraId = 27730; 					
-- "detalle de recepción de compras, tmb hay otra que es para series"

select * from detalleFacturaPassword dfp where compraId = 27730; 					
-- "detalle de contraseña"

select fp.montoTotalPago ,  fp.* from facturaPassword fp where facturaPasswordId = 1; 					
-- "encabezado de contraseña"
 

select * from compraHistorico ch where compraId =27730;  							
-- "historico de compra -> para ver cambios de precios etc."


select * from compraPedido cp where compraPedidoId = 6; 						
-- "Pedido de agencia"

select * from compraPedidoDetalle cpd where compraPedidoId = 6; 				
-- "Detalle de pedido"


select usuarioActualizacionId, count(usuarioActualizacionId) as Cantidad_Uso, compraFacturaTipoImportacionID from compraFactura 
where compraFacturaTipoImportacionId =1
group by usuarioActualizacionId ; 


select compraFacturaTipoImportacionId, COUNT(compraFacturaTipoImportacionId)  from compraFactura
where fechaRegistro> '2026-02-27'
group by compraFacturaTipoImportacionId;


select * from compraFactura
where fechaRegistro> '2026-02-27'
and serie= '5a054cf1';

select u.`user` usuario
--      ,count(1) facturasIngresadas
--      ,sum(case when compraFacturaTipoImportacionId is null then 1 else 0 end) metodoAntiguo
--      ,sum(case when compraFacturaTipoImportacionId = 1 then 1 else 0 end) metodoNuevo
      ,cf.razonSocial
      ,compraFacturaTipoImportacionId
  from compraFactura cf
inner join usuario u
    on u.usuarioId = cf.usuarioCreacionId
where cf.fechaCreacion > '2026-02-27'
-- group by cf.razonSocial;

select * from compraFacturaTipoImportacion cfti  

select * from tipoCompra tc -- no considerar para el uso de moneda;
select * from tipoCompraPago tcp -- no considerar para el uso de moneda;
-- TABLAS A VERIFICAR EL MONTO EN Q PARA LA PARTE DE ODOO---------------------------------------------------------------------



-- Pruebas TAS 1622 en Prod
select * from venta where ventaId =718536;

Select 
dv.descripcion, 
dv.descripcionPrevia, 
dv.descripcionNueva, 
dv.descripcionOriginal ,  
dv.* 
from detalleVenta dv 
where ventaId=718536;

select dve.descripcion ipcion ,dve.* from detalleVentaExterno dve where ventaid=718536;

select * from vw_detalleVenta_notaCredito_optimizado vdvnco    where ventaid=718536;
 -- Pruebas TAS 1622 en Prod




-- Querys LIFEMILES -> PARA REVISIÓN DE CASOS DONDE LAS ACUMULACIONES NO PROCEDIERON, SE PUEDE VALIDAR SI FUE UN ERROR HUMANO O DE SISTEMA PARA LUEGO COMPLETAR EL REGISTRO
select * from programaLealtadCliente plc   		-- programaLealtadCliente - > información de la afiliación del cliente
where plc.clienteId = 351218
 
select * from transaccionOut to2     			-- transaccionOut to2 -> log de transacciones que dieron error 
where to2.topicoSNSID = 1030

select utilizaProgramaLealtad   from cliente where clienteid= 351218  -- NULL -> no ha tenido  1 ->Activo  2 -> lo tiene apagado, pero sí lo usó en algún momento


-- INSERT del registro cuando no haya pasado normalmente.
select * from programaLealtadTransaccion      	-- programaLealtadTransaccion -> se registra la acumulación/redención de lifemiles a detalle, de lo que se obtiene en el consumo 
where transactionDate = 20260129;

select * from parametroGeneral where parametroGeneralId  ='1132'

select * from parametroGeneralOrganizacion pgo where pgo.parametroGeneralId =1132
-- Querys LIFEMILES -> PARA REVISIÓN DE CASOS DONDE LAS ACUMULACIONES NO PROCEDIERON, SE PUEDE VALIDAR SI FUE UN ERROR HUMANO O DE SISTEMA PARA LUEGO COMPLETAR EL REGISTRO




-- POR COMPRAS MASIVAS VISTO CON MADY

select * from compra c where c.po  in (923);


Select * from compraRecepcion cr where compraid=1366;  

select * from compraCotizacionDetalle ccd where compraid=1366;

select * from compraRecepcionDetalle crd where compraid=1366  -- and crd.compraRecepcionDetalleId =935;  -- 

select * from compraRecepcionDetalleHistorico crdh where compraid=1366;

select * from compraRecepcionDetalleHistoricoSerie crdhs  where compraid=1366;

select * from estadoArticuloBodegaSerie eabs where serie='LC6PCJGE9T0017621'

select * from compraHistorico ch where compraid=1366;

select * from compraRecepcionSerie crs where estadoArticuloBodegaSerieId=1270;



-- tipocompraid 514 --Masiva
-- compraid 1231
-- PO # de OC 806

-- POR COMPRAS MASIVAS VISTO CON MADY

 /*El parámetro por empresa es el siguiente:
  * 1 -> WAY y EPA
  * 2 -> EKIPA
  */


/*
 SELECT *
FROM ventaServicioProveedor WHERE ventaId = 359106
 
SELECT *
FROM transaccionService ts
WHERE ts.serviceId IN ( 15)
 

select * from viewrecargas v 

select * from vw_recargas vr 
 
 */

