select
el.id_evento_log as "ID de log",
el.fecha_registro_evento_log as "Fecha",
el.request_evento_log as "Request",
el.response_evento_log as "Response",
mw.nombre_metodo_ws as "Nombre de metodo",
ws.nombre_ws as "Web Service",
eel.nombre_estado_evento_log as "Estado"
from 
Evento_Log el, 
Metodo_WS mw,
WS ws,
Estado_Evento_Log eel 
where 
el.id_metodo_ws = mw.id_metodo_ws 
and el.id_ws = ws.id_ws
and el.id_estado_evento_log = eel.id_estado_evento_log 
 and el.request_evento_log like '%1052398%'
-- and mw.nombre_metodo_ws  like '%generar Compra%'
-- and mw.id_metodo_ws =98 
order by el.id_evento_log  desc
limit 100;



select mw.id_metodo_ws, mw.nombre_metodo_ws,mw.fecha_registro_metodo_ws, emw.nombre_estado_metodo_ws ,w.nombre_ws, w.endpoint_ws   
from Metodo_WS mw , Estado_Metodo_WS emw, WS w 
where mw.id_estado_ws =emw.id_estado_metodo_ws 
and mw.id_ws =w.id_ws 
and mw.nombre_metodo_ws like '%traslado%' -- id_metodo_ws= 3 infile y 16 guatefacturas
 and emw.id_estado_metodo_ws =1;



select * from Evento_Log el 
where  el.id_metodo_ws ='94' 
and id_estado_evento_log= 1
-- and el.response_evento_log like '%id_error":"0"%'
order by el.fecha_registro_evento_log desc
limit 30






**************************************************
select
	*
from
	Log_Web_Service_Produccion.v_logs vl
where
	vl.request like '%89457749%'
order by
	vl.id_evento_log desc
limit 200;
 



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
 
















