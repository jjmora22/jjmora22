create schema nueva_entrega_simplificada;

-- Inicio generando las tablas

create table nueva_entrega_simplificada.Auto(
matricula varchar(12) not null unique,
numero_poliza varchar(50) not null,
codigo_modelo integer not null,
kilometros integer not null,
fecha_compra date not null,
codigo_color int not null

);

alter table nueva_entrega_simplificada.auto add constraint matricula_unique unique (matricula);

create table nueva_entrega_simplificada.ITV(
itv_serial serial not null,
matricula varchar(12) not null,
fecha_itv date not null

);

create table nueva_entrega_simplificada.modelo(
codigo_modelo serial not null,
modelo varchar(100) not null,
codigo_marca int not null
);


create table nueva_entrega_simplificada.marca(
codigo_marca serial not null,
marca varchar(100) not null,
id_grupo int null

);

create table nueva_entrega_simplificada.grupo(
id_grupo serial,
grupo varchar(100) not null

);

create table nueva_entrega_simplificada.colores(
codigo_color serial, 
color varchar(100)

);

create table nueva_entrega_simplificada.seguro(
numero_poliza varchar(50) not null,
compannia_seguros varchar(100) not null

);

alter table nueva_entrega_simplificada.seguro add constraint poliza_unique unique (numero_poliza);

create table nueva_entrega_simplificada.revisiones(
matricula varchar(12),
revision_serial serial, 
kilometraje_revision integer not null,
importe_revision real null, 
codigo_moneda varchar(3) not null

);

create table nueva_entrega_simplificada.moneda(
codigo_moneda varchar(3),
moneda varchar(100)

);

--- GENERO PKS

alter table nueva_entrega_simplificada.auto 
add constraint auto_pk
primary key (matricula);

alter table nueva_entrega_simplificada.itv 
add constraint itv_pk
primary key(itv_serial);


alter table nueva_entrega_simplificada.modelo
add constraint modelo_pk
primary key(codigo_modelo);

alter table nueva_entrega_simplificada.marca 
add constraint marca_pk
primary key (codigo_marca);

alter table nueva_entrega_simplificada.grupo 
add constraint grupo_pk
primary key (id_grupo);

alter table nueva_entrega_simplificada.colores 
add constraint colores_pk
primary key(codigo_color);

alter table nueva_entrega_simplificada.seguro 
add constraint seguro_pk
primary key(numero_poliza);

alter table nueva_entrega_simplificada.revisiones
add constraint revisiones_pk
primary key(revision_serial);


alter table nueva_entrega_simplificada.moneda 
add constraint moneda_pk
primary key(codigo_moneda);

-- Ahora trabajo las FK

alter table nueva_entrega_simplificada.auto 
add constraint auto_fk1
foreign key (numero_poliza)
references nueva_entrega_simplificada.seguro(numero_poliza);

alter table nueva_entrega_simplificada.auto 
add constraint auto_fk2
foreign key (codigo_modelo)
references nueva_entrega_simplificada.modelo(codigo_modelo);

alter table nueva_entrega_simplificada.auto 
add constraint auto_fk3
foreign key (codigo_color)
references nueva_entrega_simplificada.colores(codigo_color);

alter table nueva_entrega_simplificada.itv
add constraint itv_fk1
foreign key (matricula)
references nueva_entrega_simplificada.auto(matricula);

alter table nueva_entrega_simplificada.modelo 
add constraint modelo_fk1
foreign key (codigo_marca)
references nueva_entrega_simplificada.marca(codigo_marca);

alter table nueva_entrega_simplificada.marca 
add constraint marca_fk1
foreign key (id_grupo)
references nueva_entrega_simplificada.grupo(id_grupo);

alter table nueva_entrega_simplificada.revisiones
add constraint revisiones_fk1
foreign key (matricula)
references nueva_entrega_simplificada.auto(matricula);

alter table nueva_entrega_simplificada.revisiones
add constraint revisiones_fk2
foreign key (codigo_moneda)
references nueva_entrega_simplificada.moneda(codigo_moneda);


--- AHORA CARGO LOS DATOS
INSERT into nueva_entrega_simplificada.moneda (codigo_moneda,moneda) VALUES
	 ('EUR','EURO'),
	 ('GBP','LIBRA ESTERLINA'),
	 ('USD','DÓLARES AMERICANOS'),
	 ('RUB','RUBLOS');
	
INSERT into nueva_entrega_simplificada.colores (color) VALUES
	 ('ROJO'),
	 ('BLANCO'),
	 ('AZUL'),
	 ('VERDE'),
	 ('AMARILLO');

	
INSERT into nueva_entrega_simplificada.grupo (grupo) VALUES
	 ('STELLANTIS'),
	 ('VOLKSWAGEN AG'),
	 ('TOYOTA MOTOR CORPORATION'),
	 ('ALIANZA RENAULT-NISSAN-MITSUBISHI'),
	 ('GENERAL MOTORS'),
	 ('GEELY'),
	 ('GRUPO BMW');

	
INSERT into nueva_entrega_simplificada.marca (marca,id_grupo) VALUES
	 ('VOLKSWAGEN',2),
	 ('CITROEN',1),
	 ('TOYOTA',3),
	 ('MINI',7),
	 ('RENAULT',4);

	
INSERT into nueva_entrega_simplificada.modelo (modelo,codigo_marca) VALUES
	 ('GOLF',1),
	 ('C4',2),
	 ('MINI SPICY',4),
	 ('MEGAN',5),
	 ('PRIUS',3);


INSERT into nueva_entrega_simplificada.seguro (numero_poliza,compannia_seguros) VALUES
	 ('25356HDFR87874','AXA'),
	 ('257MTM','MUTUA'),
	 ('K335435','IGN'),
	 ('AD3333HDF554-34','ADESLAS'),
	 ('3TRISTESTIGRES','MAPFRE');
	
INSERT into nueva_entrega_simplificada.auto (matricula,numero_poliza,codigo_modelo,kilometros,fecha_compra,codigo_color) VALUES
	 ('2000 ABC','3TRISTESTIGRES',1,15764,'2020-07-01',1),
	 ('2001 DEF','AD3333HDF554-34',2,28356,'2020-06-22',1),
	 ('2002 GHI','257MTM',3,35342,'2021-07-12',2),
	 ('2003 JKL','25356HDFR87874',4,21590,'2021-04-08',4),
	 ('2004 MNO','K335435',5,37900,'2022-02-20',1);


INSERT into nueva_entrega_simplificada.revisiones (matricula,kilometraje_revision,importe_revision,codigo_moneda) VALUES
	 ('2000 ABC',10000,250.0,'EUR'),
	 ('2001 DEF',11000,375.0,'RUB'),
	 ('2002 GHI',12000,210.0,'USD'),
	 ('2003 JKL',13000,125.0,'EUR'),
	 ('2004 MNO',14000,250.0,'GBP'),
	 ('2000 ABC',21000,175.0,'EUR'),
	 ('2001 DEF',20000,25.0,'USD');

INSERT into nueva_entrega_simplificada.itv (matricula,fecha_itv) VALUES
	 ('2000 ABC','2021-12-25'),
	 ('2001 DEF','2021-12-25'),
	 ('2002 GHI','2021-12-25'),
	 ('2003 JKL','2021-12-25'),
	 ('2004 MNO','2021-12-25'),
	 ('2000 ABC','2022-08-10');


