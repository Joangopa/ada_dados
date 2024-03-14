USE classicmodels;

-- lembramos que nos comandos DDL modificamos a tabela productlines (
-- nossa atual tabela productlines contem as columnas 
-- productLine varchar(50) e Descriptions varchar(4000) DEFAULT NULL.alter

-- INSERÇÃO DE DADOS EM DIFERENTES TABELAS

insert  into productlines(productLine,Descriptions) values
('Classic Cars', NULL),
('Motorcycles', NULL),
('Planes', NULL);

insert  into products(productCode,productName,productLine,productScale,productVendor,productDescription,quantityInStock,buyPrice,MSRP) values 
('S10_1678','1969 Harley Davidson Ultimate Chopper','Motorcycles','1:10','Min Lin Diecast','This replica features working kickstand, front suspension, gear-shift lever, footbrake lever, drive chain, wheels and steering. All parts are particularly delicate due to their precise scale and require special care and attention.',7933,'48.81','95.70'),
('S10_1949','1952 Alpine Renault 1300','Classic Cars','1:10','Classic Metal Creations','Turnable front wheels; steering function; detailed interior; detailed engine; opening hood; opening trunk; opening doors; and detailed chassis.',7305,'98.58','214.30'),
('S10_2016','1996 Moto Guzzi 1100i','Planes','1:10','Highway 66 Mini Classics','Official Moto Guzzi logos and insignias, saddle bags located on side of motorcycle, detailed engine, working steering, working suspension, two leather seats, luggage rack, dual exhaust pipes, small saddle bag located on handle bars, two-tone paint with chrome accents, superior die-cast detail , rotating wheels , working kick stand, diecast metal with plastic parts and baked enamel finish.',6625,'68.99','118.94')
;

-- ALTERAÇÃO DE VALORES NUMA TUPLA
-- note que o produto 'S10_2016' tem a productLine errada, é uma moto e não um avião

select productCode,productName,productLine from products
where productCode = 'S10_2016'
;
 -- retorna os valores: S10_2016,	1996 Moto Guzzi 1100i,	Planes
 -- vamos modificar o productLine
 
update products
set productLine = 'Motorcycles'
WHERE productCode = 'S10_2016'
;

-- podemos remover um registro usando o comando DELETE 

DELETE FROM products
WHERE productCode = 'S10_2016'
;