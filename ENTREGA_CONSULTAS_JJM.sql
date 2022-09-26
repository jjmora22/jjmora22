-- UNA SOLA CONSULTA 

select B.MODELO, C.MARCA, D.grupo_empresarial, A.FECHA_COMPRA, A.MATRICULA, F.COLOR, A.KILOMETRAJE, g.COMPANNIA_ASEGURADORA, A.NUMERO_POLIZA
from entrega_jjm_sql.AUTO A, ENTREGA_JJM_SQL.modelo_auto B, ENTREGA_JJM_SQL.LISTA_MARCAS C, entrega_jjm_sql.grupo_empresarial D, entrega_jjm_sql.grupo_empresarial_anio E, entrega_jjm_sql.CATALOGO_COLOR F, entrega_jjm_sql.DATOS_POLIZA G, entrega_jjm_sql.anio H 
where a.codigo_modelo = b.codigo_modelo and b.codigo_marca = c.codigo_marca and c.codigo_marca = e.codigo_marca and a.anio_fabricacion = H.anio_fabricacion and H.anio_fabricacion = e.anio_fabricacion and e.id_grupo_empresarial = d.id_grupo_empresarial and a.numero_poliza = g.numero_poliza and a.codigo_color = f.codigo_color



