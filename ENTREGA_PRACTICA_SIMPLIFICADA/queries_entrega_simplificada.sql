-- nombre modelo, marca y grupo de coches del inventario de keepcoding 

select b.modelo, c.marca, d.grupo
from nueva_entrega_simplificada.auto a, nueva_entrega_simplificada.modelo b, nueva_entrega_simplificada.marca c, nueva_entrega_simplificada.grupo d
where a.codigo_modelo = b.codigo_modelo and b.codigo_marca = c.codigo_marca and c.id_grupo = d.id_grupo; 


-- fecha de compra (agrego columnas de modelo, marca y grupo, para leerlo mejor)

select b.modelo, c.marca, a.matricula, a.fecha_compra 
from nueva_entrega_simplificada.auto a, nueva_entrega_simplificada.modelo b, nueva_entrega_simplificada.marca c
where a.codigo_modelo = b.codigo_modelo and b.codigo_marca = c.codigo_marca; 

-- matrícula (igualmente, con las columnas modelo, marca y grupo, para leerlo mejor)

select b.modelo, c.marca, a.matricula 
from nueva_entrega_simplificada.auto a, nueva_entrega_simplificada.modelo b, nueva_entrega_simplificada.marca c
where a.codigo_modelo = b.codigo_modelo and b.codigo_marca = c.codigo_marca;


-- Nombre del color del coche
select b.modelo, c.marca, a.matricula,  d.color 
from nueva_entrega_simplificada.auto a, nueva_entrega_simplificada.modelo b, nueva_entrega_simplificada.marca c, nueva_entrega_simplificada.colores d
where a.codigo_modelo = b.codigo_modelo and b.codigo_marca = c.codigo_marca and a.codigo_color = d.codigo_color;

-- total kilómetros --> Primero la relación y luego el total 
select b.modelo, c.marca, a.matricula,  a.kilometros
from nueva_entrega_simplificada.auto a, nueva_entrega_simplificada.modelo b, nueva_entrega_simplificada.marca c
where a.codigo_modelo = b.codigo_modelo and b.codigo_marca = c.codigo_marca;

-- ahora el total de la sumatoria de los kilómetros de todos los coches
select sum(kilometros) as "suma de kilómetros" from nueva_entrega_simplificada.auto;

-- ahora el nombre de las empresas en la que está asegurado cada coche
select b.modelo, c.marca, a.matricula,  d.compannia_seguros 
from nueva_entrega_simplificada.auto a, nueva_entrega_simplificada.modelo b, nueva_entrega_simplificada.marca c, nueva_entrega_simplificada.seguro d
where a.codigo_modelo = b.codigo_modelo and b.codigo_marca = c.codigo_marca and a.numero_poliza = d.numero_poliza;

-- y ahora agrego el numero de poliza (dejo el nombre de la compañía para facilitar lectura --quito marca para dar más visibilidad)
select b.modelo, a.matricula,  d.numero_poliza 
from nueva_entrega_simplificada.auto a, nueva_entrega_simplificada.modelo b, nueva_entrega_simplificada.seguro d
where a.codigo_modelo = b.codigo_modelo and a.numero_poliza = d.numero_poliza;

