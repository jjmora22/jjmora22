-- Query SQL según solicitado en práctica 

select b.modelo, c.marca, d.grupo, a.fecha_compra, a.matricula, e.color, a.kilometros, f.compannia_seguros, f.numero_poliza
from nueva_entrega_simplificada.auto a, nueva_entrega_simplificada.modelo b, nueva_entrega_simplificada.marca c, nueva_entrega_simplificada.grupo d, nueva_entrega_simplificada.colores e, nueva_entrega_simplificada.seguro f
where a.codigo_modelo = b.codigo_modelo and b.codigo_marca = c.codigo_marca and c.id_grupo = d.id_grupo and a.codigo_color = e.codigo_color and a.numero_poliza = f.numero_poliza; 

