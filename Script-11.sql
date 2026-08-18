
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
 