
/*
select 
cr.ventaID,
cr.creditoID,
cr.estadoid as Estado,
case
	when be.clienteId = be.beneficiarioID then "1" else "2"
end as 						ROL_NEW,
ce.carne as 				CERTIFICADO_NEW,
cl.nombres as 				NOMBRE_NEW,
cl.apellidos as 			APELLIDOS_NEW,
CASE 
	WHEN cl.fechaNacimiento IS NOT NULL THEN TIMESTAMPDIFF(YEAR, cl.fechaNacimiento, CURDATE()) 
	ELSE 25 
END as 						EDAD_NEW,
cl.generoId as 				SEXO_NEW,
DATE_FORMAT(fechaNacimiento, '%d/%m/%Y') AS FNAC_NEW,
cl.cui as 					IDEN_NEW,
cl.nit as 					NIT_NEW,
cl.estadoCivilId as 		CIVI_NEW,
be.direccionPrincipal as 	DIRE_NEW,
cl.celular as 				TELE_NEW,
be.parentescoId as 			PARE_NEW,
CONCAT(250,LPAD(pv.comercialId,3,0)) as AGEN_NEW,
CASE
    WHEN be.fechaCreacion < DATE_FORMAT(CURDATE(), '%Y-%m-01') THEN DATE_FORMAT(CURDATE(), '01/%m/%Y')
    ELSE DATE_FORMAT(be.fechaCreacion, '%d/%m/%Y')
END AS 						FAFI_NEW,
2 as 						TPAG_NEW,
0 AS 						TCUE_NEW,
0 AS 						NCUE_NEW,
32 AS 						VEND_NEW,
0 AS 						REGI_NEW,
0 AS 						OFIC_NEW,
"AGENCIAS WAY, S.A." AS 	AFAC_NEW,
0 AS 						TCLI_NEW,
1 AS 						FMES_NEW
from cliente as cl
inner join credito as cr ON 
cl.clienteId = cr.clienteId 
inner join carneEPSS ce ON 
ce.clienteId = cr.clienteId 
inner join puntoVenta pv on
pv.puntoVentaId = ce.puntoVentaId 
inner join beneficiarioEPSS be on
be.beneficiarioId = ce.clienteId 
WHERE  cl.nit  IN ("82090785","112829864") 
#where ce.clienteID=751
WHERE cr.plazo >= 6 and cr.creditoTotal >= 1000  and cr.estadoid in(0, 603, 600) and not pv.puntoVentaId=256
*/




select 
ce.creditoId,
cc.estadoId ,
e.nombre,
cc.clienteID,
CASE 
	When   count(cc.clienteID)>1 Then "M" else "A"
END as TIP_NEW,
case
	when be.clienteId = be.beneficiarioID then "1" else "2"
end as 						ROL_NEW,
188 as 						PLAN_NEW,
ce.carne as 				CERTIFICADO_NEW,
cl.nombres as 				NOMBRE_NEW,
cl.apellidos as 			APELLIDOS_NEW,
CASE 
	WHEN cl.fechaNacimiento IS NOT NULL THEN TIMESTAMPDIFF(YEAR, cl.fechaNacimiento, CURDATE()) 
	ELSE 25 
END as 						EDAD_NEW,
cl.generoId as 				SEXO_NEW,
DATE_FORMAT(fechaNacimiento, '%d/%m/%Y') AS FNAC_NEW,
cl.cui as 					IDEN_NEW,
cl.nit as 					NIT_NEW,
cl.estadoCivilId as 		CIVI_NEW,
be.direccionPrincipal as 	DIRE_NEW,
cl.celular as 				TELE_NEW,
be.parentescoId as 			PARE_NEW,
CONCAT(250,LPAD(pv.comercialId,3,0)) as AGEN_NEW,
CASE
    WHEN be.fechaCreacion < DATE_FORMAT(CURDATE(), '%Y-%m-01') THEN DATE_FORMAT(CURDATE(), '01/%m/%Y')
    ELSE DATE_FORMAT(be.fechaCreacion, '%d/%m/%Y')
END AS 						FAFI_NEW,
2 as 						TPAG_NEW,
0 AS 						TCUE_NEW,
0 AS 						NCUE_NEW,
32 AS 						VEND_NEW,
0 AS 						REGI_NEW,
0 AS 						OFIC_NEW,
"AGENCIAS WAY, S.A." AS 	AFAC_NEW,
0 AS 						TCLI_NEW,
1 AS 						FMES_NEW
FROM cliente as cl
inner join beneficiarioEPSS as be on
be.beneficiarioId = cl.clienteId 
inner join carneEPSS ce ON 
ce.clienteid = be.clienteid
inner join puntoVenta pv on
pv.puntoVentaId = ce.puntoVentaId     #(30 resultados)
inner join credito cc  on
cl.clienteId = cc.clienteId   #and cc.creditoId=ce.creditoid
inner join estado e on
e.estadoId = cc.estadoId 
where NOT cc.estadoId in (7,38, 605,601) and not pv.puntoVentaId=256  #and ce.creditoid= 64832 
Group by cc.clienteId


# VERIFICAR CREDITOS ID
# 33546

select * from carneEPSS ce where not puntoventaid =256;
select * from beneficiarioEPSS be where clienteid=73491

#show create table beneficiarioEPSS;
#show create table carneEPSS;

Select * from estado

select * from credito where clienteId  = 56741

select * from creditoMora cm where clienteId  = 56741

select * from creditoCuota cc where cc.clienteid = 56741 and creditoid=64832

select * from carneEPSS ce where clienteid= 56741



select * from credito WHERE creditoId = 33546;

SELECT * FROM cliente WHERE CLIENTEID=18986;

Select * from vw_pago vp where ventaId=73491;
select clienteid, nombres,  from cliente 
where nombres like "%fatima gabriela%";
select * from beneficiarioEPSS;
select * from carneEPSS where clienteid=73491;


select  from credito


select 
*,
ce.carne,
c.clienteid,
be.beneficiarioid,
c.nombres,
c.apellidos
from beneficiarioEPSS be 
inner join cliente c on
be.beneficiarioId = c.clienteid
inner join carneEPSS ce on
ce.carneId = be.carneId 
where ce.creditoId  = 64832


******************************************************************************************************************************************************************************************************************************************************

-- Esta es la primera parte, en teoría ya está, solo falta el primer campo. Muestra solo los 1 Activos
# CONSULTA-1

select 
cr.clienteID,
cr.creditoId ,
cr.creditoTotal + cr.enganche as Venta_Total,
cr.estadoId,
e.nombre,
CASE 
	When   count(cr.clienteID)>1 Then "M" else "A"
END as TIP_NEW,
1 as ROL_NEW,
ce.carne as CERTIFICADO_NEW,
188 as PLAN_NEW,
cl.nombres as NOMBRE_NEW,
cl.apellidos as APELLIDOS_NEW,
CASE 
	WHEN cl.fechaNacimiento IS NOT NULL THEN TIMESTAMPDIFF(YEAR, cl.fechaNacimiento, CURDATE()) 
	ELSE 25 
END as 						EDAD_NEW,
cl.generoId as 				SEXO_NEW,
DATE_FORMAT(fechaNacimiento, '%d/%m/%Y') AS FNAC_NEW,
case
when
cl.cui is null then "N/A" else cl.cui end
as 							IDEN_NEW,
case
when cl.nit is null then "C/F" else cl.nit end
as 					NIT_NEW,	
cl.estadoCivilId as 		CIVI_NEW,
be.direccionPrincipal as 	DIRE_NEW,
cl.celular as 				TELE_NEW,
0 as			 			PARE_NEW,
CONCAT(250,LPAD(pv.comercialId,3,0)) as AGEN_NEW,
CASE
    WHEN be.fechaCreacion < DATE_FORMAT(CURDATE(), '%Y-%m-01') THEN DATE_FORMAT(CURDATE(), '01/%m/%Y')
    ELSE DATE_FORMAT(be.fechaCreacion, '%d/%m/%Y')   	
END AS 						FAFI_NEW,					-- Conversión de Fechas menores al mes actual, ya que EPSS no acepta fechas de meses anteriores
2 as 						TPAG_NEW,
0 AS 						TCUE_NEW,
0 AS 						NCUE_NEW,
32 AS 						VEND_NEW,
0 AS 						REGI_NEW,
0 AS 						OFIC_NEW,
"AGENCIAS WAY, S.A." AS 	AFAC_NEW,
0 AS 						TCLI_NEW,
1 AS 						FMES_NEW
from cliente cl 
inner join credito cr on
cl.clienteid = cr.clienteid
INNER JOIN estado e ON 
e.estadoid = cr.estadoid
INNER JOIN carneEPSS ce on
ce.clienteid = cl.clienteid
inner join beneficiarioEPSS be ON 
be.clienteid = cl.clienteid
inner join puntoVenta pv on
pv.puntoVentaId = ce.puntoVentaId 
where # cl.clienteid = 9437 
 -- cr.estadoId = 600 
cr.creditoTotal>999 									-- Es el monto mínimo (Q1,000.00) para aplicar al beneficio
and cr.plazo > 5         								-- Son las cuotas mínimas para aplicar al beneficio
Group by cr.clienteid

**********************************************************************************************************************************************************************


select 
*,
DATE_ADD(cr.fechainicio, INTERVAL cr.plazo MONTH) AS Finaliza
from cliente cl 
inner join credito cr ON 
cl.clienteId = cr.clienteid
INNER JOIN carneEPSS ce on
ce.clienteid = cl.clienteid
inner join beneficiarioEPSS be ON 
be.clienteid = cl.clienteid
inner join puntoVenta pv on
pv.puntoVentaId = ce.puntoVentaId 
where cl.clienteid =9437 and cr.estadoId = 600 and cr.plazo > 5


Select * from beneficiarioEPSS be 


**********************************************************************************************************************************************************************

# CONSULTA-2 De momento esta es la vista donde indica "A" en el primer campo, además que coloca todos los 1
WITH certificados_filtrados AS (
  SELECT 
	cr.clienteID,
CASE 
	When   count(cr.clienteID)>1 Then "M" else "A"
END as TIP_NEW,
    1 as ROL_NEW,
    ce.carne as CERTIFICADO_NEW,
    188 as PLAN_NEW,
    cl.nombres as NOMBRE_NEW,
    cl.apellidos as APELLIDOS_NEW,
    CASE 
      WHEN cl.fechaNacimiento IS NOT NULL THEN TIMESTAMPDIFF(YEAR, cl.fechaNacimiento, CURDATE()) 
      ELSE 25 
    END as EDAD_NEW,
    cl.generoId as SEXO_NEW,
    DATE_FORMAT(fechaNacimiento, '%d/%m/%Y') AS FNAC_NEW,
    CASE
      WHEN cl.cui IS NULL THEN "N/A" ELSE cl.cui 
    END as IDEN_NEW,
    CASE
      WHEN cl.nit IS NULL THEN "C/F" ELSE cl.nit 
    END as NIT_NEW,	
    cl.estadoCivilId as CIVI_NEW,
    be.direccionPrincipal as DIRE_NEW,
    cl.celular as TELE_NEW,
    0 as PARE_NEW,
    CONCAT(250, LPAD(pv.comercialId, 3, 0)) as AGEN_NEW,
    CASE
      WHEN be.fechaCreacion < DATE_FORMAT(CURDATE(), '%Y-%m-01') 
        THEN DATE_FORMAT(CURDATE(), '01/%m/%Y')
      ELSE DATE_FORMAT(be.fechaCreacion, '%d/%m/%Y')
    END AS FAFI_NEW,
    2 as TPAG_NEW,
    0 AS TCUE_NEW,
    0 AS NCUE_NEW,
    32 AS VEND_NEW,
    0 AS REGI_NEW,
    0 AS OFIC_NEW,
    "AGENCIAS WAY, S.A." AS AFAC_NEW,
    0 AS TCLI_NEW,
    1 AS FMES_NEW,
    ROW_NUMBER() OVER (PARTITION BY ce.carne ORDER BY cr.fechaInicio DESC) AS rn
  FROM cliente cl 
  INNER JOIN credito cr ON cl.clienteid = cr.clienteid
  INNER JOIN estado e ON e.estadoid = cr.estadoid
  INNER JOIN carneEPSS ce ON ce.clienteid = cl.clienteid
  INNER JOIN beneficiarioEPSS be ON be.clienteid = cl.clienteid
  INNER JOIN puntoVenta pv ON pv.puntoVentaId = ce.puntoVentaId
  INNER JOIN creditoCuota cc ON cc.clienteID = ce.clienteId
  WHERE cr.creditoTotal>999
    AND cr.estadoId = 600 
    AND cr.plazo > 5
    group by cr.clienteID
)
SELECT *
FROM certificados_filtrados
WHERE rn = 1;

**********************************************************************************************************************************************************************

Select * from estado

select * from creditoMora cm where cm.clienteId  = 2869

select * from creditoCuota cc where cc.clienteid = 2869

select * from carneEPSS ce where carne= 202500015





Select * from compra WHERE po =20159;

select * from compraFactura cf where serie='CB108214'
limit 100


-- Esta es la primera parte, en teoría ya está, solo falta el primer campo. Muestra solo los 1 Activos
# CONSULTA-1

select 
cr.clienteID,
cr.creditoId ,
cr.creditoTotal ,
cr.estadoId,
e.nombre,
count(cr.clienteID) as Total_creditos,
CASE 
	When   count(cr.clienteID)>1 Then "M" else "A"
END as TIP_NEW,
1 as ROL_NEW,
ce.carne as CERTIFICADO_NEW,
188 as PLAN_NEW,
cl.nombres as NOMBRE_NEW,
cl.apellidos as APELLIDOS_NEW,
CASE 
	WHEN cl.fechaNacimiento IS NOT NULL THEN TIMESTAMPDIFF(YEAR, cl.fechaNacimiento, CURDATE()) 
	ELSE 25 
END as 						EDAD_NEW,
cl.generoId as 				SEXO_NEW,
DATE_FORMAT(fechaNacimiento, '%d/%m/%Y') AS FNAC_NEW,
case
when
cl.cui is null then "N/A" else cl.cui end
as 							IDEN_NEW,
case
when cl.nit is null then "C/F" else cl.nit end
as 					NIT_NEW,	
cl.estadoCivilId as 		CIVI_NEW,
be.direccionPrincipal as 	DIRE_NEW,
cl.celular as 				TELE_NEW,
0 as			 			PARE_NEW,
CONCAT(250,LPAD(pv.comercialId,3,0)) as AGEN_NEW,
CASE
    WHEN be.fechaCreacion < DATE_FORMAT(CURDATE(), '%Y-%m-01') THEN DATE_FORMAT(CURDATE(), '01/%m/%Y')
    ELSE DATE_FORMAT(be.fechaCreacion, '%d/%m/%Y')
END AS 						FAFI_NEW,
2 as 						TPAG_NEW,
0 AS 						TCUE_NEW,
0 AS 						NCUE_NEW,
32 AS 						VEND_NEW,
0 AS 						REGI_NEW,
0 AS 						OFIC_NEW,
"AGENCIAS WAY, S.A." AS 	AFAC_NEW,
0 AS 						TCLI_NEW,
1 AS 						FMES_NEW
from cliente cl 
inner join credito cr on
cl.clienteid = cr.clienteid
INNER JOIN estado e ON 
e.estadoid = cr.estadoid
INNER JOIN carneEPSS ce on
ce.clienteid = cl.clienteid
inner join beneficiarioEPSS be ON 
be.clienteid = cl.clienteid
inner join puntoVenta pv on
pv.puntoVentaId = ce.puntoVentaId 
-- where # cl.clienteid = 9437 
 -- cr.estadoId = 600 
-- cr.creditoTotal>999 					-- Es el monto mínimo para aplicar al beneficio
-- and cr.plazo > 5  					-- Son las cuotas mínimas para aplicar al beneficio
-- cr.creditoId =429930          				
Group by cr.clienteid
;
-- Esta es la primera parte, en teoría ya está, solo falta el primer campo. Muestra solo los 1 Activos
# CONSULTA-1

