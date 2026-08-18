
-- ACTIVACION DE BAZAR --
select Ingresar_Almacen_Bazar('Bazar Ambulante Agencia Chahal','837','187BA') as RESULTADO; 
-- 								*(Nombre,				Codigo Odoo,Codigo Cobol)




-- Consulta de ambiente productivo
select
el.id_evento_log as "ID de log",
el.request_evento_log as "Request",
el.response_evento_log as "Response",
el.fecha_registro_evento_log as "Fecha",
mw.nombre_metodo_ws as "Nombre de metodo",
ws.nombre_ws as "Web Service",
eel.nombre_estado_evento_log as "Estado"
from
Log_Web_Service_Produccion.Evento_Log el,
Log_Web_Service_Produccion.Metodo_WS mw,
Log_Web_Service_Produccion.WS ws,
Log_Web_Service_Produccion.Estado_Evento_Log eel
where
el.id_metodo_ws = mw.id_metodo_ws
and el.id_ws = ws.id_ws
and el.id_estado_evento_log = eel.id_estado_evento_log
and el.request_evento_log like "%25210%"
and mw.nombre_metodo_ws like "%Compra%"
order by el.id_evento_log  desc



