select * from bodega b where b.comercialId ="EB4";

select 
b.comercialID,  
b.nombre, 
b.direccion, 
e.nombre   
from bodega b 
inner join estado e on
e.estadoID = b.estadoId 
where b.nombre like "%taller%"

select * from estado e 


Select * from vw_inventario vi where vi.codigoBodega in ("E17", "Eb4","EB6" )

Select * from vw_inventario vi where vi.codigoBodega in ("E17");
Select * from vw_inventario vi where vi.codigoBodega in ("Eb4");
Select * from vw_inventario vi where vi.codigoBodega in ("EB6")

Select vi.codigoBodega,  count(vi.codigoBodega ) from vw_inventario vi where vi.codigoBodega in ("E17", "Eb4","EB6" ) group by codigoBodega

Select vi.codigoBodega,  count(vi.codigoBodega ) from vw_inventario vi where vi.codigoBodega in ("E17" ) group by codigoBodega;
Select vi.codigoBodega,  count(vi.codigoBodega ) from vw_inventario vi where vi.codigoBodega in ("Eb4") group by codigoBodega;
Select vi.codigoBodega,  count(vi.codigoBodega ) from vw_inventario vi where vi.codigoBodega in ("EB6") group by codigoBodega;