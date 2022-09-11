-- Generamos el SCHEMA ENTREGA_JJM_SQL

create schema ENTREGA_JJM_SQL authorization acmgxqpp;


-- Iniciamos por CREAR las TABLAS del DIAGRAMA ER


-- CREO TABLA AUTO
create table ENTREGA_JJM_SQL.AUTO(
 	CODIGO_VERSION INTEGER not null,
 	CODIGO_MODELO INTEGER not null,
 	CODIGO_COLOR VARCHAR(50) not null,
 	NUMERO_POLIZA varchar(50) not null,
 	ANIO_FABRICACION integer not null,
 	MATRICULA varchar(12) not null UNIQUE,
 	FECHA_COMPRA date not null, -- Format is YYYY-MM-DD
 	KILOMETRAJE integer not null,
 	FRAME_NUMBER varchar(100) not null UNIQUE
 	
 );


alter table ENTREGA_JJM_SQL.AUTO -- DATOS QUE UNICOS AL AUTO EN INVENTARIO
	add constraint AUTO_PK 
	primary key(MATRICULA);



--- CREO TABLA ANIO
create table ENTREGA_JJM_SQL.ANIO(
	ANIO_FABRICACION integer unique
);

alter table ENTREGA_JJM_SQL.ANIO
	add constraint ANIO_PK
	primary key (ANIO_FABRICACION); 
	
alter table ENTREGA_JJM_SQL.AUTO 
	add constraint AUTO_ANIO_FABRICACION_FK
	foreign key (ANIO_FABRICACION) references ANIO(ANIO_FABRICACION);
	
	

-- CREO TABLA MODELO AUTO 
create table ENTREGA_JJM_SQL.MODELO_AUTO(
	CODIGO_MODELO serial not null unique,
	CODIGO_MARCA INTEGER not null,
	MODELO varchar(100)
	
);

alter table ENTREGA_JJM_SQL.MODELO_AUTO
	add constraint MODELO_AUTO_PK
	primary key(CODIGO_MODELO, CODIGO_MARCA);


alter table ENTREGA_JJM_SQL.auto 
	add constraint AUTO_FK4
	foreign KEY(CODIGO_MODELO) 
	references MODELO_AUTO(CODIGO_MODELO);



----- CREO TABLA LISTA_MARCAS
create table ENTREGA_JJM_SQL.LISTA_MARCAS(
	codigo_marca serial unique,
	marca varchar(50)
	
);

alter table ENTREGA_JJM_SQL.LISTA_MARCAS -- GENERO LISTA DE MARCAS
	add constraint MARCA_PK
	primary key (CODIGO_MARCA);

alter table ENTREGA_JJM_SQL.MODELO_AUTO -- RELACIONO MODELO CON MARCA
	add constraint MODELO_AUTO_FK 
	foreign key (CODIGO_MARCA) references LISTA_MARCAS(CODIGO_MARCA);



-- CREO TABLA VERSIONES AUTO, PARA GENERAR LAS VERSIONES DISPONIBLES POR AÑO
create table ENTREGA_JJM_SQL.VERSIONES_AUTO(
	CODIGO_VERSION SERIAL unique,
	CODIGO_MODELO INTEGER, 
	VERSION_MODELO VARCHAR(100)
	
);	


alter table ENTREGA_JJM_SQL.AUTO
	add constraint AUTO_FK1 
	foreign key(CODIGO_VERSION) 
	references VERSIONES_AUTO(CODIGO_VERSION);
	

alter table ENTREGA_JJM_SQL.VERSIONES_AUTO
	add constraint VERSIONES_AUTO_FK
	foreign key (CODIGO_MODELO) 
	references MODELO_AUTO(CODIGO_MODELO);
	


--- CREO TABLA DE DATOS DE LA PÓLIZA DE SEGUROS
create table ENTREGA_JJM_SQL.DATOS_POLIZA(
	 NUMERO_POLIZA varchar(50) not null unique,
	 COMPANNIA_ASEGURADORA varchar(50) not NULL,
	 TIPO_SEGURO varchar(50) NULL,
	 COBERTURA varchar(500) not NULL,
	 FECHA_PAGO_POLIZA date not NULL, -- IMPORTANTE PARA DETERMINAR PERIODOS SIN COBERTURA DE SEGURO Y GENERAR ALARMAS
	 VENCIMIENTO_POLIZA date not null,
	 MONTO_PAGADO real null,
	 CODIGO_MONEDA VARCHAR(3) null
	 
);

alter table ENTREGA_JJM_SQL.DATOS_POLIZA
	add constraint DATOS_POLIZA_PK
	primary key (numero_poliza);



-- CREO TABLA TIPO DE MONEDA, PARA VALIDAR TIPO DE MONEDA USADO
create table ENTREGA_JJM_SQL.TIPO_MONEDA(
	CODIGO_MONEDA varchar(3) unique,
	MONEDA varchar (100)
);


alter table ENTREGA_JJM_SQL.TIPO_MONEDA
	add constraint TIPO_MONEDA_PK
	primary key (CODIGO_MONEDA);

alter table ENTREGA_JJM_SQL.datos_poliza 
	add constraint DATOS_POLIZA_FK 
	foreign key (CODIGO_MONEDA) references TIPO_MONEDA(CODIGO_MONEDA);
	

alter table ENTREGA_JJM_SQL.AUTO
	add constraint AUTO_FK2 foreign key(NUMERO_POLIZA)
	references DATOS_POLIZA(NUMERO_POLIZA);
	
	


--- CREO TABLA ITV PARA LLEVAR EL CONTROL DE LAS REVISIONES ITV
create table ENTREGA_JJM_SQL.ITV(  -- control de revisiones ITV
	ITV_SERIAL serial, 
	MATRICULA varchar(12) not null,
	FECHA_ULTIMA_VERIFICACION date not null, 
	FECHA_PROXIMA_VERIFICACION date not null, 
	MONTO_PAGO_ULTIMA_VERIFICACION REAL not null, 
	CODIGO_MONEDA VARCHAR(3)
	
	
);

alter table ENTREGA_JJM_SQL.itv -- GENERO las PK de ITV
	add constraint ITV_PK
	primary key (ITV_SERIAL, MATRICULA);
	
alter table ENTREGA_JJM_SQL.itv 
	add constraint ITV_FK1 foreign key (MATRICULA) 
	references AUTO(MATRICULA);

alter table ENTREGA_JJM_SQL.itv 
	add constraint ITV_FK2 foreign key (CODIGO_MONEDA)
	references TIPO_MONEDA(CODIGO_MONEDA);
	


--- CREO TABLA DE SERVICIOS DE MANTENIMIENTO DEL AUTO 
create table ENTREGA_JJM_SQL.SERVICIOS_AUTO(  -- control DE SERVICIOS DE MANTENIMIENTO AL AUTO
	Numero_Servicio serial unique,
	MATRICULA varchar(12) not null,
	CODIGO_VERSION integer not null, 
	KMS_ULTIMO_SERVICIO integer not null,
	FECHA_ULTIMO_SERVICIO date not null,
	MONTO_PAGO_ULTIMO_SERVICIO real null,
	CODIGO_MONEDA VARCHAR(3),
	KMS_PROXIMO_SERVICIO integer null, 
	FECHA_PROXIMO_SERVICIO date null
	
);


alter table ENTREGA_JJM_SQL.servicios_auto
	add constraint SERVICIOS_AUTO_PK 
	primary key(NUMERO_SERVICIO, MATRICULA, CODIGO_VERSION);
	
alter table ENTREGA_JJM_SQL.SERVICIOS_AUTO 
	add constraint SERVICIOS_AUTO_FK1 
	foreign key(MATRICULA) 
	references AUTO(MATRICULA);
	
alter table ENTREGA_JJM_SQL.SERVICIOS_AUTO
	add constraint SERVICIOS_AUTO_FK2 
	foreign key(CODIGO_VERSION) 
	references VERSIONES_AUTO(CODIGO_VERSION);

alter table ENTREGA_JJM_SQL.servicios_auto 
	add constraint SERVICIOS_AUTO_FK3 
	foreign key(CODIGO_MONEDA) 
	references TIPO_MONEDA(CODIGO_MONEDA);
	


--- CREO TABLA CATALOGO DE COLORES TOTAL, QUE ALIMENTA A COLOR AUTO. DE MOMENTO SE CONECTA AUTO AQUÍ, PARA FACILITAR LAS COSAS
create table ENTREGA_JJM_SQL.CATALOGO_COLOR(  -- CATALOGO TOTAL DE COLORES
	CODIGO_COLOR varchar(50) not null unique,
	COLOR varchar(100) not null
);


alter table ENTREGA_JJM_SQL.catalogo_color 
	add constraint CATALOGO_COLOR_PK 
	primary key(CODIGO_COLOR);

alter table ENTREGA_JJM_SQL.auto 
	add constraint AUTO_FK5 -- ESTOY CONECTANDO DIRECTO LOS COLORES AL AUTO, AUNQUE DEJO LISTO PARA VALIDAR OPCIONES POR AÑO
	foreign KEY(CODIGO_COLOR) 
	references CATALOGO_COLOR(CODIGO_COLOR);


	
create table ENTREGA_JJM_SQL.ESPECIFICOS_ANIO( --- datos específicos de las garantías del modelo según situación en cada año
	ANIO_FABRICACION integer not null,
	CODIGO_MARCA INTEGER not null,
	CODIGO_GARANTIA INTEGER not null
	
);

create table ENTREGA_JJM_SQL.CATALOGO_GARANTIAS(
	CODIGO_GARANTIA SERIAL unique, -- ETIQUETA PARA MEJORAR DESEMPEÑO
	TIEMPO_GARANTIA INTEGER not null, -- TIEMPO QUE LA GARANTIA ES VÁLIDA EN MESES
	KMS_SERVICIO integer not null,-- SERVIRÁ PARA EL control DE la frecuencia de servicios, cambia según el grupo y el año
	TIEMPO_SERVICIO varchar(100) null-- Igualmente, sirve para el control de la frecuencia de servicios, esta vez por tiempo
);

alter table ENTREGA_JJM_SQL.especificos_anio 
	add constraint ESPECIFICOS_ANIO_PK 
	primary key(ANIO_FABRICACION, CODIGO_MARCA, CODIGO_GARANTIA);

alter table ENTREGA_JJM_SQL.CATALOGO_GARANTIAS
	add constraint CATALOGO_GARANTIAS_PK
	primary KEY(CODIGO_GARANTIA);

alter table ENTREGA_JJM_SQL.ESPECIFICOS_ANIO
	add constraint ESPECIFICOS_ANIO_FK1
	foreign key (ANIO_FABRICACION) 
	references ANIO(ANIO_FABRICACION);

alter table ENTREGA_JJM_SQL.ESPECIFICOS_ANIO
	add constraint ESPECIFICOS_ANIO_FK2
	foreign key (CODIGO_MARCA) 
	references LISTA_MARCAS(CODIGO_MARCA);

alter table ENTREGA_JJM_SQL.ESPECIFICOS_ANIO
	add constraint ESPECIFICOS_ANIO_FK3
	foreign key (CODIGO_GARANTIA) 
	references CATALOGO_GARANTIAS(CODIGO_GARANTIA);



create table ENTREGA_JJM_SQL.GRUPO_EMPRESARIAL_ANIO(
	ID_GRUPO_EMPRESARIAL INTEGER not NULL, -- ETIQUETA PARA MEJORAR DESEMPEÑO
	ANIO_FABRICACION INTEGER not null, -- TIEMPO QUE LA GARANTIA ES VÁLIDA EN MESES
	CODIGO_MARCA integer not null

);

create table ENTREGA_JJM_SQL.GRUPO_EMPRESARIAL(
	ID_GRUPO_EMPRESARIAL SERIAL unique,
	GRUPO_EMPRESARIAL VARCHAR(100)

);

alter table ENTREGA_JJM_SQL.GRUPO_EMPRESARIAL
	add constraint GRUPO_EMPRESARIAL_PK
	primary KEY(ID_GRUPO_EMPRESARIAL);

alter table ENTREGA_JJM_SQL.GRUPO_EMPRESARIAL_ANIO
	add constraint GRUPO_EMPRESARIAL_ANIO_PK 
	primary key(ID_GRUPO_EMPRESARIAL, ANIO_FABRICACION, CODIGO_MARCA);

alter table ENTREGA_JJM_SQL.GRUPO_EMPRESARIAL_ANIO
	add constraint GRUPO_EMPRESARIAL_ANIO_FK1
	foreign key (ID_GRUPO_EMPRESARIAL) 
	references GRUPO_EMPRESARIAL(ID_GRUPO_EMPRESARIAL);

alter table ENTREGA_JJM_SQL.GRUPO_EMPRESARIAL_ANIO
	add constraint GRUPO_EMPRESARIAL_ANIO_FK2
	foreign key (ANIO_FABRICACION) 
	references ANIO(ANIO_FABRICACION);

alter table ENTREGA_JJM_SQL.GRUPO_EMPRESARIAL_ANIO
	add constraint GRUPO_EMPRESARIAL_ANIO_FK3
	foreign key (CODIGO_MARCA) 
	references LISTA_MARCAS(CODIGO_MARCA);


	
-- INICIO CARGA DE DATOS

-- GENERO EL CATÁLOGO DE INFORMACIÓN DE LOS AUTOS (CATALOGO COLOR, MODELO)

-- INICIO POR EL CATÁLOGO DE COLOR

insert into ENTREGA_JJM_SQL.CATALOGO_COLOR (CODIGO_COLOR, COLOR) 
values ('VR-678/B LDX', 'BASALTO GREY');

insert into ENTREGA_JJM_SQL.CATALOGO_COLOR (CODIGO_COLOR, COLOR) 
values ('RXN/601', 'BLACK');

insert into ENTREGA_JJM_SQL.catalogo_color (CODIGO_COLOR, COLOR) 
values ('V4-214/B LWC', 'BLANCO PASTELLO');

insert into ENTREGA_JJM_SQL.catalogo_color (CODIGO_COLOR, COLOR)
values ('NBZ', 'BLUE NIGHT MET');

insert into ENTREGA_JJM_SQL.catalogo_color (CODIGO_COLOR, COLOR)
values ('414', 'ROSSO ALPHA (KIT)');

insert into ENTREGA_JJM_SQL.catalogo_color (CODIGO_COLOR, color)
values ('361', 'ROSSO COMPIZONE PEARL');

insert into ENTREGA_JJM_SQL.catalogo_color (CODIGO_COLOR, color)
values ('668', 'JET BLACK II');

insert into ENTREGA_JJM_SQL.catalogo_color (CODIGO_COLOR, color)
values ('850', 'PEPPER (OLD ENGLISH) WHITE');

insert into ENTREGA_JJM_SQL.catalogo_color (CODIGO_COLOR, color)
values ('851', 'CHILI/SOLAR RED');

insert into ENTREGA_JJM_SQL.catalogo_color (CODIGO_COLOR, color)
values ('857', 'NIGHTFIRE RED MET');

insert into ENTREGA_JJM_SQL.catalogo_color (CODIGO_COLOR, color)
values ('871', 'DARK SILVER/TECHNICAL GREY');

insert into ENTREGA_JJM_SQL.catalogo_color (CODIGO_COLOR, color)
values ('895', 'BRITISH RACING GREEN');


-- AHORA GENERO LA LISTA DE MARCAS

insert into ENTREGA_JJM_SQL.LISTA_MARCAS  (MARCA)
values ('ALFA ROMEO');

insert into ENTREGA_JJM_SQL.LISTA_MARCAS  (MARCA)
values ('MINI COOPER');

insert into ENTREGA_JJM_SQL.LISTA_MARCAS  (MARCA)
values ('FORD');

insert into ENTREGA_JJM_SQL.LISTA_MARCAS  (MARCA)
values ('MERCEDES BENZ');

insert into ENTREGA_JJM_SQL.LISTA_MARCAS  (MARCA)
values ('BMW');

insert into ENTREGA_JJM_SQL.LISTA_MARCAS  (MARCA)
values ('CITROEN');

insert into ENTREGA_JJM_SQL.LISTA_MARCAS  (MARCA)
values ('RENAULT');

insert into ENTREGA_JJM_SQL.LISTA_MARCAS  (MARCA)
values ('JEEP');

insert into ENTREGA_JJM_SQL.LISTA_MARCAS  (MARCA)
values ('KIA');

insert into ENTREGA_JJM_SQL.LISTA_MARCAS  (MARCA)
values ('FIAT');

insert into ENTREGA_JJM_SQL.LISTA_MARCAS  (MARCA)
values ('VOLKSWAGEN');

insert into ENTREGA_JJM_SQL.LISTA_MARCAS  (MARCA)
values ('SEAT');



------ ahora ingreso los modelos_auto
insert into ENTREGA_JJM_SQL.MODELO_AUTO(CODIGO_MARCA, MODELO)
values ('1', '4C');

insert into ENTREGA_JJM_SQL.MODELO_AUTO(CODIGO_MARCA, MODELO)
values ('1', 'GIULIA');

insert into ENTREGA_JJM_SQL.MODELO_AUTO(CODIGO_MARCA, MODELO)
values ('1', 'GIULIETTA');

insert into ENTREGA_JJM_SQL.MODELO_AUTO(CODIGO_MARCA, MODELO)
values ('2', 'MINI COOPER');

insert into ENTREGA_JJM_SQL.MODELO_AUTO(CODIGO_MARCA, MODELO)
values ('2', 'MINI COOPER CABRIO');

insert into ENTREGA_JJM_SQL.MODELO_AUTO(CODIGO_MARCA, MODELO)
values ('2', 'MINI COOPER S');

insert into ENTREGA_JJM_SQL.MODELO_AUTO(CODIGO_MARCA, MODELO)
values ('2', 'MINI COOPER SE');

insert into ENTREGA_JJM_SQL.MODELO_AUTO(CODIGO_MARCA, MODELO)
values ('2', 'MINI COOPER JOHN COOPER WORKS');

insert into ENTREGA_JJM_SQL.MODELO_AUTO(CODIGO_MARCA, MODELO)
values ('6', 'C4 CACTUS');

insert into ENTREGA_JJM_SQL.MODELO_AUTO(CODIGO_MARCA, MODELO)
values ('6', 'C4 CACTUS PURETECH');

---- AHORA INGRESO LAS VERSIONES


insert into ENTREGA_JJM_SQL.versiones_auto (CODIGO_MODELO, version_modelo)
values ('1', 'Spider');

insert into ENTREGA_JJM_SQL.VERSIONES_AUTO  (CODIGO_MODELO, version_modelo)
values ('2', '2.0 SS Estrema Q4 Aut. 280 - 4-puertas');

insert into ENTREGA_JJM_SQL.VERSIONES_AUTO  (CODIGO_MODELO, version_modelo)
values ('3', '1.6JTD Sport 120 - 5-puertas - 2020');

insert into ENTREGA_JJM_SQL.VERSIONES_AUTO  (CODIGO_MODELO, version_modelo)
values ('4', 'Mini 5 puertas Cooper 136CV Gasolina');

insert into ENTREGA_JJM_SQL.VERSIONES_AUTO  (CODIGO_MODELO, version_modelo)
values ('5', 'Mini Cabrio Cooper 136CV Gasolina');

insert into ENTREGA_JJM_SQL.VERSIONES_AUTO  (CODIGO_MODELO, version_modelo)
values ('6', 'Mini Cooper S 5 puertas 178CV Gasolina');

insert into ENTREGA_JJM_SQL.VERSIONES_AUTO  (CODIGO_MODELO, version_modelo)
values ('7', 'Mini Cooper SE 5 puertas 184CV Eléctrico');

insert into ENTREGA_JJM_SQL.VERSIONES_AUTO  (CODIGO_MODELO, version_modelo)
values ('8', 'Mini Cooper JOHN COOPER WORKS 231CV Gasolina');

insert into ENTREGA_JJM_SQL.VERSIONES_AUTO  (CODIGO_MODELO, version_modelo)
values ('9', 'CACTUS 5 PUERTAS GASOLINA 1.2 e-THP con 110 CV');

insert into ENTREGA_JJM_SQL.VERSIONES_AUTO  (CODIGO_MODELO, version_modelo)
values ('10', 'C4 Cactus 1.2 PureTech S&S C-Series 110 - 5-puertas - 2020');

-- INGRESO LOS MODELOS (AÑO DE FABRICACION)

insert into ENTREGA_JJM_SQL.ANIO(ANIO_FABRICACION)
values ('2019');

insert into ENTREGA_JJM_SQL.ANIO(ANIO_FABRICACION)
values ('2020');

insert into ENTREGA_JJM_SQL.ANIO(ANIO_FABRICACION)
values ('2021');

insert into ENTREGA_JJM_SQL.ANIO(ANIO_FABRICACION)
values ('2022');

insert into ENTREGA_JJM_SQL.ANIO(ANIO_FABRICACION)
values ('2023');


-- CARGO EL CATALOGO DE GARANTIAS Y SERVICIOS

insert into ENTREGA_JJM_SQL.CATALOGO_GARANTIAS(TIEMPO_GARANTIA, KMS_SERVICIO, TIEMPO_SERVICIO)
values ('60', '15000', '6 MESES');

insert into ENTREGA_JJM_SQL.CATALOGO_GARANTIAS(TIEMPO_GARANTIA, KMS_SERVICIO, TIEMPO_SERVICIO)
values ('120', '20000', '6 MESES');

insert into ENTREGA_JJM_SQL.CATALOGO_GARANTIAS(TIEMPO_GARANTIA, KMS_SERVICIO, TIEMPO_SERVICIO)
values ('36', '10000', '6 MESES');



--- Catalogo de grupos empresariales

insert into ENTREGA_JJM_SQL.grupo_empresarial(grupo_empresarial)
values ('GRUPO FIAT');

insert into ENTREGA_JJM_SQL.grupo_empresarial(grupo_empresarial)
values ('FIAT CHRYSLER AUTOMOBILES');

insert into ENTREGA_JJM_SQL.grupo_empresarial(grupo_empresarial)
values ('STELLANTIS');

insert into ENTREGA_JJM_SQL.grupo_empresarial(grupo_empresarial)
values ('GRUPO PSA');

insert into ENTREGA_JJM_SQL.grupo_empresarial(grupo_empresarial)
values ('BMW GROUP');

insert into ENTREGA_JJM_SQL.grupo_empresarial(grupo_empresarial)
values ('BRITISH LEYLAND');

insert into ENTREGA_JJM_SQL.grupo_empresarial(grupo_empresarial)
values ('VOLKWAGEN AG');



-- GRUPO_EMPRESARIAL_ANIO - SE INCORPORAN LOS DATOS DE LOS GRUPOS POR AÑOS

insert into ENTREGA_JJM_SQL.grupo_empresarial_anio (Anio_FABRICACION, ID_GRUPO_EMPRESARIAL, CODIGO_MARCA)
values ('2021', '3', '1');

insert into ENTREGA_JJM_SQL.grupo_empresarial_anio (Anio_FABRICACION, ID_GRUPO_EMPRESARIAL, CODIGO_MARCA)
values ('2022', '3', '1');

insert into ENTREGA_JJM_SQL.grupo_empresarial_anio (Anio_FABRICACION, ID_GRUPO_EMPRESARIAL, CODIGO_MARCA)
values ('2023', '3', '1');

insert into ENTREGA_JJM_SQL.grupo_empresarial_anio (Anio_FABRICACION, ID_GRUPO_EMPRESARIAL, CODIGO_MARCA)
values ('2019', '2', '1');

insert into ENTREGA_JJM_SQL.grupo_empresarial_anio (Anio_FABRICACION, ID_GRUPO_EMPRESARIAL, CODIGO_MARCA)
values ('2020', '2', '1');

insert into ENTREGA_JJM_SQL.grupo_empresarial_anio (Anio_FABRICACION, ID_GRUPO_EMPRESARIAL, CODIGO_MARCA)
values ('2019', '5', '2');

insert into ENTREGA_JJM_SQL.grupo_empresarial_anio (Anio_FABRICACION, ID_GRUPO_EMPRESARIAL, CODIGO_MARCA)
values ('2020', '5', '2');

insert into ENTREGA_JJM_SQL.grupo_empresarial_anio (Anio_FABRICACION, ID_GRUPO_EMPRESARIAL, CODIGO_MARCA)
values ('2021', '5', '2');

insert into ENTREGA_JJM_SQL.grupo_empresarial_anio (Anio_FABRICACION, ID_GRUPO_EMPRESARIAL, CODIGO_MARCA)
values ('2022', '5', '2');

insert into ENTREGA_JJM_SQL.grupo_empresarial_anio (Anio_FABRICACION, ID_GRUPO_EMPRESARIAL, CODIGO_MARCA)
values ('2023', '5', '2');

insert into ENTREGA_JJM_SQL.grupo_empresarial_anio (Anio_FABRICACION, ID_GRUPO_EMPRESARIAL, CODIGO_MARCA)
values ('2019', '4', '6');

insert into ENTREGA_JJM_SQL.grupo_empresarial_anio (Anio_FABRICACION, ID_GRUPO_EMPRESARIAL, CODIGO_MARCA)
values ('2020', '3', '6');

insert into ENTREGA_JJM_SQL.grupo_empresarial_anio (Anio_FABRICACION, ID_GRUPO_EMPRESARIAL, CODIGO_MARCA)
values ('2021', '3', '6');

insert into ENTREGA_JJM_SQL.grupo_empresarial_anio (Anio_FABRICACION, ID_GRUPO_EMPRESARIAL, CODIGO_MARCA)
values ('2022', '3', '2');

insert into ENTREGA_JJM_SQL.grupo_empresarial_anio (Anio_FABRICACION, ID_GRUPO_EMPRESARIAL, CODIGO_MARCA)
values ('2023', '3', '2');


-- SE INSERTAN TIPOS DE MONEDA 

insert into ENTREGA_JJM_SQL.TIPO_MONEDA (CODIGO_MONEDA, MONEDA)
values ('EUR', 'EURO');

insert into ENTREGA_JJM_SQL.TIPO_MONEDA (CODIGO_MONEDA, MONEDA)
values ('DZD', 'DINAR ARGELINO');

insert into ENTREGA_JJM_SQL.TIPO_MONEDA (CODIGO_MONEDA, MONEDA)
values ('AOA', 'KWANZA ANGOLEÑO');

insert into ENTREGA_JJM_SQL.TIPO_MONEDA (CODIGO_MONEDA, MONEDA)
values ('XCD', 'DOLAR DEL CARIBE ORIENTAL');

insert into ENTREGA_JJM_SQL.TIPO_MONEDA (CODIGO_MONEDA, MONEDA)
values ('SAR', 'RIYAL SAUDÍ');

insert into ENTREGA_JJM_SQL.TIPO_MONEDA (CODIGO_MONEDA, MONEDA)
values ('ARS', 'PESO ARGENTINO');

insert into ENTREGA_JJM_SQL.TIPO_MONEDA (CODIGO_MONEDA, MONEDA)
values ('AMD', 'DRAM ARMENIO');

insert into ENTREGA_JJM_SQL.TIPO_MONEDA (CODIGO_MONEDA, MONEDA)
values ('BSD', 'DÓLAR BAHAMEÑO');

insert into ENTREGA_JJM_SQL.TIPO_MONEDA (CODIGO_MONEDA, MONEDA)
values ('BBD', 'DÓLAR DE BARBADOS');

insert into ENTREGA_JJM_SQL.TIPO_MONEDA (CODIGO_MONEDA, MONEDA)
values ('MXN', 'PESO MEXICANO');

insert into ENTREGA_JJM_SQL.TIPO_MONEDA (CODIGO_MONEDA, MONEDA)
values ('USD', 'DÓLAR ESTADOUNIDENSE');

insert into ENTREGA_JJM_SQL.TIPO_MONEDA (CODIGO_MONEDA, MONEDA)
values ('BZD', 'DÓLAR BELICEÑO');

insert into ENTREGA_JJM_SQL.TIPO_MONEDA (CODIGO_MONEDA, MONEDA)
values ('XOF', 'FRANCO CFA DE ÁFRICA OCCIDENTAL');

insert into ENTREGA_JJM_SQL.TIPO_MONEDA (CODIGO_MONEDA, MONEDA)
values ('BOB', 'BOLIVIANO');

insert into ENTREGA_JJM_SQL.TIPO_MONEDA (CODIGO_MONEDA, MONEDA)
values ('BAM', 'MARCO BOSNIOHERZEGOVINO');

insert into ENTREGA_JJM_SQL.TIPO_MONEDA (CODIGO_MONEDA, MONEDA)
values ('BWP', 'PULA DE BOTSUANA');

insert into ENTREGA_JJM_SQL.TIPO_MONEDA (CODIGO_MONEDA, MONEDA)
values ('BRL', 'REAL BRASILEÑO');

insert into ENTREGA_JJM_SQL.TIPO_MONEDA (CODIGO_MONEDA, MONEDA)
values ('BGN', 'LEV BULGARIA');

insert into ENTREGA_JJM_SQL.TIPO_MONEDA (CODIGO_MONEDA, MONEDA)
values ('CAD', 'DÓLAR CANADIENSE');

insert into ENTREGA_JJM_SQL.TIPO_MONEDA (CODIGO_MONEDA, MONEDA)
values ('CNY', 'RENMINBI CHINA');

insert into ENTREGA_JJM_SQL.TIPO_MONEDA (CODIGO_MONEDA, MONEDA)
values ('COP', 'PESO COLOMBIANO');

insert into ENTREGA_JJM_SQL.TIPO_MONEDA (CODIGO_MONEDA, MONEDA)
values ('RUB', 'RUBLO RUSO');


-- LAS PÓLIZAS DE LOS AUTOS QUE TIENE KEEPCODING!

INSERT into ENTREGA_JJM_SQL.datos_poliza
(numero_poliza, compannia_aseguradora, tipo_seguro, cobertura, fecha_pago_poliza, vencimiento_poliza, monto_pagado, codigo_moneda)
VALUES('22F573435HDF8', 'AXA', 'TERCEROS BÁSICOS', 'DAÑOS A TERCEROS', '2021-09-30', '2023-09-30', 2500.0, 'EUR');
INSERT into ENTREGA_JJM_SQL.datos_poliza
(numero_poliza, compannia_aseguradora, tipo_seguro, cobertura, fecha_pago_poliza, vencimiento_poliza, monto_pagado, codigo_moneda)
VALUES('22F573436HDF8', 'AXA', 'TERCEROS + LUNAS', 'DAÑOS A TERCEROS Y CRISTALES', '2021-11-27', '2023-11-27', 2900.0, 'EUR');
INSERT into ENTREGA_JJM_SQL.datos_poliza
(numero_poliza, compannia_aseguradora, tipo_seguro, cobertura, fecha_pago_poliza, vencimiento_poliza, monto_pagado, codigo_moneda)
VALUES('22F573439HDF8', 'AXA', 'TERCEROS + LUNAS + INCENDIO + ROBO', 'DAÑOS A TERCEROS, CRISTALES, INCENDIO Y ROBO', '2020-06-27', '2022-06-27', 3120.0, 'EUR');
INSERT into ENTREGA_JJM_SQL.datos_poliza
(numero_poliza, compannia_aseguradora, tipo_seguro, cobertura, fecha_pago_poliza, vencimiento_poliza, monto_pagado, codigo_moneda)
VALUES('MAP076540003934', 'MAPFRE', 'TODO RIESGO CON FRANQUICIA', 'RESP CIVIL, DAÑOS A TERCEROS, INCENDIO, ROBO, HOSPITALIZACION, R. CIVIL', '2022-01-24', '2024-01-24', 2900.0, 'USD');
INSERT into ENTREGA_JJM_SQL.datos_poliza
(numero_poliza, compannia_aseguradora, tipo_seguro, cobertura, fecha_pago_poliza, vencimiento_poliza, monto_pagado, codigo_moneda)
VALUES('MMT0034343421', 'MMT', 'TODO RIESGO', 'EMERGENCIAS, RESP CIVIL, GRUA, TERCEROS, PINCHAZOS', '2022-04-30', '2025-04-30', 40000.0, 'MXN');

-- CON ESTA INFORMACIÓN, YA PUEDO DAR DE ALTA LOS AUTOS
INSERT into ENTREGA_JJM_SQL.auto (codigo_version,numero_poliza,anio_fabricacion,matricula,fecha_compra,kilometraje,frame_number,codigo_modelo,codigo_color) VALUES
	 (2,'22F573435HDF8',2021,'2384JJL','2021-09-30',37825,'EL7H3985AB39489AC879HZIDR342235F',1,'361'),
	 (5,'22F573436HDF8',2020,'1954HHB','2020-05-05',65398,'C4MNFMAD3434351234F234A134',4,'668'),
	 (6,'MAP076540003934',2022,'2342LWZ','2022-03-28',4704,'KJFAPDOI433154514361452G45',5,'851'),
	 (3,'MMT0034343421',2021,'1994LOL','2021-11-12',35390,'KLJF98/45345/342452',2,'414'),
	 (10,'22F573439HDF8',2021,'1996LHZ','2021-06-28',48795,'KDO45354265N&FLKJ45453',9,'VR-678/B LDX');



-- INSERTO INFORMACIÓN DE SERVICIOS_AUTO
INSERT into ENTREGA_JJM_SQL.servicios_auto (matricula,codigo_version,kms_ultimo_servicio,fecha_ultimo_servicio,monto_pago_ultimo_servicio,codigo_moneda,kms_proximo_servicio,fecha_proximo_servicio) VALUES
	 ('1954HHB',5,10000,'2020-10-17',150.0,'EUR',20000,'2021-04-17'),
	 ('1954HHB',5,20000,'2021-05-25',150.0,'EUR',30000,'2021-11-25'),
	 ('1954HHB',5,30000,'2021-10-03',210.0,'EUR',40000,'2022-04-03'),
	 ('1954HHB',5,40000,'2022-03-30',150.0,'EUR',50000,'2022-09-30'),
	 ('1954HHB',5,50000,'2022-07-30',210.0,'EUR',60000,'2023-01-30'),
	 ('1994LOL',3,15000,'2022-06-02',200.0,'EUR',30000,'2022-06-02'),
	 ('1996LHZ',10,10000,'2021-06-20',150.0,'EUR',25000,'2023-06-20'),
	 ('1996LHZ',10,25000,'2021-09-20',250.0,'EUR',30000,'2023-06-20'),
	 ('1996LHZ',10,30000,'2022-03-20',250.0,'EUR',30000,'2023-06-20'),
	 ('1996LHZ',10,40000,'2022-06-20',150.0,'EUR',40000,'2023-06-20'),
	 ('1996LHZ',10,50000,'2022-08-20',250.0,'EUR',50000,'2023-06-20');
	
-- -- AHORA INCLUYO REVISIONES DE LA ITV
	
	INSERT into ENTREGA_JJM_SQL.itv (matricula,fecha_ultima_verificacion,fecha_proxima_verificacion,monto_pago_ultima_verificacion,codigo_moneda) VALUES
	 ('1996LHZ','2022-11-25','2025-11-25',125.0,'EUR'),
	 ('1954HHB','2022-11-25','2025-11-25',125.0,'EUR'),
	 ('1994LOL','2022-09-17','2025-09-17',125.0,'EUR'),
	 ('2342LWZ','2021-11-25','2023-11-02',130.0,'USD'),
	 ('2384JJL','2021-05-11','2024-05-11',125.0,'EUR');
	 
	
-- AHORA CLASIFICO LAS DISTINTAS GARANTIAS POR AÑO Y POR MARCA
	-- Auto-generated SQL script #202209111910
INSERT into ENTREGA_JJM_SQL.especificos_anio (anio_fabricacion,codigo_marca,codigo_garantia)
	VALUES (2019,1,2);
INSERT into ENTREGA_JJM_SQL.especificos_anio (anio_fabricacion,codigo_marca,codigo_garantia)
	VALUES (2020,1,2);
INSERT into ENTREGA_JJM_SQL.especificos_anio (anio_fabricacion,codigo_marca,codigo_garantia)
	VALUES (2021,1,3);
INSERT into ENTREGA_JJM_SQL.especificos_anio (anio_fabricacion,codigo_marca,codigo_garantia)
	VALUES (2022,1,3);
INSERT into ENTREGA_JJM_SQL.especificos_anio (anio_fabricacion,codigo_marca,codigo_garantia)
	VALUES (2019,2,1);
INSERT into ENTREGA_JJM_SQL.especificos_anio (anio_fabricacion,codigo_marca,codigo_garantia)
	VALUES (2020,2,1);
INSERT into ENTREGA_JJM_SQL.especificos_anio (anio_fabricacion,codigo_marca,codigo_garantia)
	VALUES (2021,2,1);
INSERT into ENTREGA_JJM_SQL.especificos_anio (anio_fabricacion,codigo_marca,codigo_garantia)
	VALUES (2022,2,1);
INSERT into ENTREGA_JJM_SQL.especificos_anio (anio_fabricacion,codigo_marca,codigo_garantia)
	VALUES (2019,6,3);
INSERT into ENTREGA_JJM_SQL.especificos_anio (anio_fabricacion,codigo_marca,codigo_garantia)
	VALUES (2020,6,3);
INSERT into ENTREGA_JJM_SQL.especificos_anio (anio_fabricacion,codigo_marca,codigo_garantia)
	VALUES (2021,6,3);
INSERT into ENTREGA_JJM_SQL.especificos_anio (anio_fabricacion,codigo_marca,codigo_garantia)
	VALUES (2022,6,3);

--
