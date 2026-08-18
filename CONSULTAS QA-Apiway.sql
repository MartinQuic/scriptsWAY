-- Consulta de ambiente de pruebas QA
select
el.id_evento_log as "ID de log",
el.fecha_registro_evento_log as "Fecha",
el.request_evento_log as "Request",
el.response_evento_log as "Response",
mw.nombre_metodo_ws as "Nombre de metodo",
ws.nombre_ws as "Web Service",
eel.nombre_estado_evento_log as "Estado"
from 
Log_Web_Service.Evento_Log el, 
Log_Web_Service.Metodo_WS mw,
Log_Web_Service.WS ws,
Log_Web_Service.Estado_Evento_Log eel 
where 
el.id_metodo_ws = mw.id_metodo_ws 
and el.id_ws = ws.id_ws
and el.id_estado_evento_log = eel.id_estado_evento_log 
-- and el.request_evento_log like '%359674%'
 and el.id_metodo_ws =98
-- and mw.nombre_metodo_ws  like '%generar Compra%'
order by el.id_evento_log  desc
limit 100;



select * from Log_Web_Service.Evento_Log el 
where el.request_evento_log like '%359927%' 
order by el.fecha_registro_evento_log desc
limit 100

SELECT mw.* FROM Log_Web_Service.Metodo_WS AS mw
 WHERE nombre_metodo_ws like '%anular_saldo%'

select
	*
from
	Log_Web_Service.v_logs vl
where
	vl.request like '%ws94%'
order by
	vl.id_evento_log desc
limit 200;
 





