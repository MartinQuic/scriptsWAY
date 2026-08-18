/*1*/ Select * from cliente c WHERE c.nit  IN ("82090785","103583041");

/*2*/ Select estadoId, creditoid, ventaid from credito c WHERE plazo >= 6 and creditoTotal >= 1000 and saldoTotalPendiente >= 1 and estadoId=88 limit 1 ;   /*group by estadoId order by fechaInicio ASC*/

/*3*/ Select * from carneEPSS ce;

/*4*/ Select * from puntoVenta pv;

/*5*/ select * from beneficiarioEPSS be;

Select * from credito c WHERE plazo >= 6 and creditoTotal >= 1000 and saldoTotalPendiente >= 1  order by fechaInicio ASC

SHOW CREATE TABLE cliente
 
select * from tipoCliente tc 

select 
cr.ventaID,
cr.creditoID,
cr.estadoid as Estado,
case
	when be.clienteId = be.beneficiarioID then "1" else "2"
end as ROL_NEW,
ce.carne as CERTIFICADO_NEW,
cl.nombres as NOMBRE_NEW,
cl.apellidos as APELLIDOS_NEW,
CASE 
	WHEN cl.fechaNacimiento IS NOT NULL THEN TIMESTAMPDIFF(YEAR, cl.fechaNacimiento, CURDATE()) 
	ELSE 25 
END as EDAD_NEW,
cl.generoId as SEXO_NEW,
DATE_FORMAT(fechaNacimiento, '%d/%m/%Y') AS FNAC_NEW,
cl.cui as IDEN_NEW,
cl.nit as NIT_NEW,
cl.estadoCivilId as CIVI_NEW,
be.direccionPrincipal as DIRE_NEW,
cl.celular as TELE_NEW,
be.parentescoId as PARE_NEW,
CONCAT(250,LPAD(pv.comercialId,3,0)) as AGEN_NEW,
CASE
    WHEN be.fechaCreacion < DATE_FORMAT(CURDATE(), '%Y-%m-01') THEN DATE_FORMAT(CURDATE(), '01/%m/%Y')
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
1 AS FMES_NEW
from cliente as cl
inner join credito as cr ON 
cl.clienteId = cr.clienteId 
inner join carneEPSS ce ON 
ce.clienteId = cr.clienteId 
inner join puntoVenta pv on
pv.puntoVentaId = ce.puntoVentaId 
inner join beneficiarioEPSS be on
be.beneficiarioId = ce.clienteId 
/*WHERE  cl.nit  IN ("82090785","112829864") */
#where ce.clienteID=751
WHERE cr.plazo >= 6 and cr.creditoTotal >= 1000  and cr.estadoid in(0, 603, 600) and not pv.puntoVentaId=256     #and cr.creditoid=17045







select * from cliente where nit = 77806522,
select * from credito where clienteID=3715



select* from credito c where clienteId=751





SELECT * FROM credito WHERE saldoTotalPendiente =1630






select * from cliente c where clienteID in (1501, 2963)

select * from credito c where clienteID in (1501,2963) 

select * from credito c where creditoID in (242, 243)



-- *****************************************************

select* from carneEPSS ce where carne=202500031;

select * from beneficiarioEPSS be where carneid=31;

select * from cliente where cui =2774154971216;

Select * from credito where creditoid=121436;

select * from credito where clienteId =15037;

select clienteId, creditoId, count(clienteID)  from credito
group by clienteId 
 having count(creditoId)>2
order by count(creditoId);


select be.beneficiarioEPSSId , carneID, count(be.carneId), be.clienteId  
from beneficiarioEPSS be 
where clienteid=169859
group by be.carneId 
having count(be.carneID)>1;




Select * from estado e 


select codigoExterno, creditoId  from credito where codigoExterno is not null ;

select trasladoId ,codigoExterno,   t.estadoId, e.nombre    from traslado t inner join estado e on t.estadoId  = e.estadoId   where codigoExterno is not null order by trasladoid DESC limit 500;





select al.usuarioId, al.fechaRegistro   from articuloLog al   where articuloid = '26442';


































