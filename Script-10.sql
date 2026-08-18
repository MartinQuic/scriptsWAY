
 



SELECT
*
FROM
Log_Web_Service_Produccion.v_logs vl
WHERE
MATCH(vl.request) AGAINST('203859')
-- AND MATCH(vl.response ) AGAINST('340544')1
order by
id_evento_log desc
limit 100;


select 
trasladoId ,
codigoExterno,   
t.estadoId, 
e.nombre    
from traslado t 
inner join estado e on 
t.estadoId  = e.estadoId   
where codigoExterno is not null 
order by trasladoid DESC 
limit 500;




select * from simply.grupoUsuarioParticipante gup  where usuarioId= 264

select * from grupoUsuario gu where nombre like '%confirm%'




