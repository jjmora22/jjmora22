-- CONSULTAS SQL PARA SACAR LOS LISTADOS DE COCHES ACTIVOS EN KEEPCODING
-- ELABORADO POR JUAN JOSÉ DE LA MORA (O SEA YO MERITO)

-- INICIAMOS CON NOMBRE MODELO, MARCA Y GRUPO DE COCHES (VOY A PONER ÚNICAMENTE LOS QUE SON DE KEEPCODING)
-- ENTIENDO GRUPO DE COCHES, COMO GRUPO EMPRESARIAL 

select A.CODIGO_MODELO, B.MODELO, C.MARCA
from ENTREGA_JJM_SQL.AUTO A, ENTREGA_JJM_SQL.modelo_auto B, ENTREGA_JJM_SQL.LISTA_MARCAS C
where A.CODIGO_MODELO = B.codigo_modelo and B.CODIGO_MARCA = C.CODIGO_MARCA

-- AGREGAMOS AHORA LA FECHA DE COMPRA (MANTENGO EL INDICATIVO DE LOS AUTOS PARA SABER CUÁL SE COMPRÓ CUANDO, 
-- PODRÍA AGREGAR LA MATRICULA, PERO COMO NO LO SOLICITA, LO DEJO ÚNICAMENTE CON LA DESCRIPCIÓN)
select A.CODIGO_MODELO, B.MODELO, C.MARCA, A.FECHA_COMPRA
from ENTREGA_JJM_SQL.AUTO A, ENTREGA_JJM_SQL.modelo_auto B, ENTREGA_JJM_SQL.LISTA_MARCAS C
where A.CODIGO_MODELO = B.codigo_modelo and B.CODIGO_MARCA = C.CODIGO_MARCA 

-- AHORA SE SOLICITA LA MATRÍCULA, NUEVAMENTE UTILIZO LA MISMA LÓGICA, PONGO LA DESCRIPCIÓN DEL AUTO Y SU MATRÍCULA (SOLO ESTOY
-- PIDIENDO LA LISTA DE LOS AUTOS QUE TIENE KEEPCODING)
select A.CODIGO_MODELO, B.MODELO, C.MARCA, A.MATRICULA
from ENTREGA_JJM_SQL.AUTO A, ENTREGA_JJM_SQL.modelo_auto B, ENTREGA_JJM_SQL.LISTA_MARCAS C
where A.CODIGO_MODELO = B.codigo_modelo and B.CODIGO_MARCA = C.CODIGO_MARCA

-- AHORA SE SOLICITA EL NOMBRE DEL COLOR DEL COCHE
-- TENGO QUE REFERENCIAR AHORA AL CATÁLOGO DE COLORES
-- AGREGO LA INTERSECCIÓN ENTRE AUTO Y CATALOGO DE COLOR
select A.CODIGO_MODELO, B.MODELO, C.MARCA, D.COLOR
from ENTREGA_JJM_SQL.AUTO A, ENTREGA_JJM_SQL.modelo_auto B, ENTREGA_JJM_SQL.LISTA_MARCAS C, entrega_jjm_sql.CATALOGO_COLOR D
where A.CODIGO_MODELO = B.codigo_modelo and B.CODIGO_MARCA = C.CODIGO_MARCA and D.CODIGO_COLOR = A.CODIGO_COLOR

-- TOTAL KILÓMETROS. EN ESTA PREGUNTA, NO ME HA QUEDADO CLARO SI SE SOLICITA EL TOTAL O LA RELACION DE KMS. 
-- ASI QUE HARÉ PRIMERO LA RELACIÓN DE KMS:
select A.CODIGO_MODELO, B.MODELO, C.MARCA, A. KILOMETRAJE
from ENTREGA_JJM_SQL.AUTO A, ENTREGA_JJM_SQL.modelo_auto B, ENTREGA_JJM_SQL.LISTA_MARCAS C
where A.CODIGO_MODELO = B.codigo_modelo and B.CODIGO_MARCA = C.CODIGO_MARCA

-- Y AHORA, GENERO EL TOTAL DE LOS KILÓMETROS DE TODOS LOS AUTOS
select SUM(KILOMETRAJE) from entrega_jjm_sql.auto 

-- AHORA SE ME PIDE LA RELACIÓN DE EMPRESAS QUE HAN ASEGURADO LOS COCHES. LO QUE HAGO ES MUY SIMILAR A LO QUE HICE EN COLOR
-- SOLO QUE REFERENCIANDO A DATOS_POLIZA
select A.CODIGO_MODELO, B.MODELO, C.MARCA, D.COMPANNIA_ASEGURADORA
from ENTREGA_JJM_SQL.AUTO A, ENTREGA_JJM_SQL.modelo_auto B, ENTREGA_JJM_SQL.LISTA_MARCAS C, entrega_jjm_sql.DATOS_POLIZA D
where A.CODIGO_MODELO = B.codigo_modelo and B.CODIGO_MARCA = C.CODIGO_MARCA and D.NUMERO_POLIZA = A.NUMERO_POLIZA

-- AHORA SE SOLICITA LA RELACION DE NUMEROS DE POLIZA DE CADA COCHE. SE REPITE LA ANTERIOR, APUNTANDO AHORA AL NUMERO DE POLIZA
select A.CODIGO_MODELO, B.MODELO, C.MARCA, D.numero_poliza 
from ENTREGA_JJM_SQL.AUTO A, ENTREGA_JJM_SQL.modelo_auto B, ENTREGA_JJM_SQL.LISTA_MARCAS C, entrega_jjm_sql.DATOS_POLIZA D
where A.CODIGO_MODELO = B.codigo_modelo and B.CODIGO_MARCA = C.CODIGO_MARCA and D.NUMERO_POLIZA = A.NUMERO_POLIZA
