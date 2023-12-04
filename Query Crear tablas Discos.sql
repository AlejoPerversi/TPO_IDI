create database tpParte2

use tpParte2

-- Discos

-- Generos
create table generos (
    codgenero int,
    descripcion varchar(255),
	constraint pk_generos primary key (codgenero)
);

-- Artistas
create table artistas (
    codartista int,
    nombre varchar(255),
	constraint pk_artistas primary key (codartista)
);

-- Albumes
create table albumes (
    codalbum int,
    titulo varchar(255),
    fecha date,
    codartista int,
    codgenero int,
	constraint pk_albumes primary key (codalbum),
    constraint fk_albumes_artistas foreign key (codartista) references artistas(codartista),
    constraint fk_albumes_generos foreign key (codgenero) references generos(codgenero)
);

-- Temas
create table temas (
    codtema int,
    titulo varchar(255),
    orden int,
    duracion time,
    codalbum int,
	constraint pk_temas primary key (codtema),
    constraint fk_temas_albumes foreign key (codalbum) references albumes(codalbum)
);

-- Pedidos y Facturas

-- Clientes
create table clientes (
    codcliente int,
    nombre varchar(255),
    saldo decimal(10, 2),
	constraint pk_clientes primary key (codcliente)
);

-- Pedidos
create table pedidos (
    nropedido int,
    fecha date,
    codcliente int,
    fechaentrega date,
    lugarentrega varchar(255),
	constraint pk_pedidos primary key (nropedido),
    constraint fk_pedidos_clientes foreign key (codcliente) references clientes(codcliente)
);

-- Productos
create table productos (
    codproducto int,
    descripcion varchar(255),
    stock int,
    puntoreposicion int,
    precio decimal(10, 2),
	constraint pk_productos primary key (codproducto)
);

-- ItemsPedido
create table itemsPedido (
    codproducto int,
    nropedido int,
    cantidad int,
    constraint pk_itemsPedido primary key (codproducto, nropedido),
    constraint fk_itemsPedido_productos foreign key (codproducto) references productos(codproducto),
    constraint fk_itemsPedido_pedidos foreign key (nropedido) references pedidos(nropedido)
);

-- Facturas
create table facturas (
    nrofactura int,
    fecha date,
    codcliente int,
    codpedido int,
    bruto decimal(10, 2),
    iva decimal(10, 2),
    iibb decimal(10, 2),
    final decimal(10, 2),
	constraint pk_facturas primary key (nrofactura),
    constraint fk_facturas_clientes foreign key (codcliente) references clientes(codcliente),
    constraint fk_facturas_pedidos foreign key (codpedido) references pedidos(nropedido)
);

-- ItemsFactura
create table itemsfactura (
    codproducto int,
    nrofactura int,
    cantidad int,
    precio decimal(10, 2),
    descuento decimal(10, 2),
    constraint pk_itemsFactura primary key (codproducto, nrofactura),
    constraint fk_itemsfacturas_productos foreign key (codproducto) references productos(codproducto),
    constraint fk_itemsfacturas_facturas foreign key (nrofactura) references facturas(nrofactura)
);

-- Composiciones
create table composiciones (
    codproducto int,
    codproductocomponente int,
    cantidad int,
    constraint pk_composiciones primary key (codproducto, codproductocomponente),
    constraint fk_composiciones_productos foreign key (codproducto) references productos(codproducto),
    constraint fk2_composiciones_productos foreign key (codproductocomponente) references productos(codproducto) --REVISAR
);




-- Discos

-- Insertar datos en Generos
insert into generos (codgenero, descripcion) values
    (1, 'Rock'),
    (2, 'Pop'),
    (3, 'Electrónica'),
    (4, 'Jazz'),
	(5, 'Funk rock')

-- Insertar datos en Artistas
insert into artistas (codartista, nombre) values
    (1, 'Queen'),
    (2, 'Michael Jackson'),
    (3, 'Daft Punk'),
    (4, 'Miles Davis'),
	(5, 'Red Hot Chili Peppers')

-- Insertar datos en Albumes
insert into albumes (codalbum, titulo, fecha, codartista, codgenero) values
    (1, 'A Night at the Opera', convert(date, '21/11/75', 3), 1, 1),
    (2, 'Thriller', convert(date, '30/11/82', 3), 2, 2),
    (3, 'Random Access Memories', convert(date, '17/05/13', 3), 3, 3),
    (4, 'Kind of Blue', convert(date, '17/08/59', 3), 4, 4),
	(5, 'Blood Sugar Sex Magik', convert(date,'12/02/91', 3), 5, 5);

-- Insertar datos en Temas
insert into temas (codtema, titulo, orden, duracion, codalbum) values
    (1, 'Bohemian Rhapsody', 1, '00:05:54', 1),
    (2, 'Billie Jean', 1, '00:04:54', 2),
    (3, 'Get Lucky', 1, '00:06:07', 3),
    (4, 'So What', 1, '00:09:22', 4),
	(5, 'Funky Monks', 1, '00:05:23',5),
	(6, 'Blood Sugar Sex Magik', 1, '00:03:26',5);

-- Pedidos y Facturas

-- Insertar datos en Clientes
insert into clientes (codcliente, nombre, saldo) values
    (1, 'Alejo', 1000.00),
    (2, 'Juan', 500.00),
    (3, 'Roberto', 800.00);

-- Insertar datos en Pedidos
insert into pedidos (nropedido, fecha, codcliente, fechaentrega, lugarentrega) values
    (1, convert(date, '15/01/23', 3), 1, convert(date, '20/01/23', 3), 'Dirección1'),
    (2, convert(date, '10/02/23', 3), 2, convert(date, '15/02/23', 3), 'Dirección2'),
    (3, convert(date, '05/03/23', 3), 3, convert(date, '10/03/23', 3), 'Dirección3');


-- Insertar datos en Productos
insert into productos (codproducto, descripcion, stock, puntoreposicion, precio) values
    (1, 'Vinilo Blood Sugar Sex Magik', 50, 10, 25.00),
    (2, 'Vinilo Kind of Blue', 30, 5, 15.00),
    (3, 'Thriller', 20, 8, 30.00);

-- Insertar datos en ItemsPedido
insert into itemspedido (codproducto, nropedido, cantidad) values
	(1, 1, 2),
	(2, 1, 5),
    (3, 2, 3);

-- Insertar datos en Facturas
insert into facturas (nrofactura, fecha, codcliente, codpedido, bruto, iva, iibb, final) values
    (1, convert(date, '20/01/23', 3), 1, 1, 50.00, 50.00 * 1.21, 50.00 * 1.03, 50.00 * 1.21 +50.00 * 1.03),   -- CAMBIAR PRECIO FINAL / MAL
    (2, convert(date, '15/02/23', 3), 2, 2, 125.00, 125.00 * 1.21, 125.00 * 1.03, 125.00 * 1.21 + 125.00 * 1.03),
    (3, convert(date, '10/03/23', 3), 3, 3, 90.00, 90.00 * 1.21, 90.00 * 1.03, 90.00 * 1.21 + 90.00 * 1.03);

-- Insertar datos en ItemsFactura
insert into itemsfactura (codproducto, nrofactura, cantidad, precio, descuento) values
    (1, 1, 2, 50.00, 0.00),
    (2, 1, 5, 125.00, 0.00),
    (3, 2, 3, 90.00, 0.00);

-- Insertar datos en Composiciones
insert into composiciones (codproducto, codproductocomponente, cantidad) values
    (1, 2, 1),
    (1, 3, 1),
    (2, 3, 2),
	(12, 5, 6);



-- Consultas
-- ¿Cuantos temas tienen los álbumes del género rock?
select count(*) as cantidadRock from albumes where codgenero = 1


-- ¿Cuántos artistas distintos hicieron álbumes del género clásico?

insert into generos (codgenero, descripcion) values
    (6, 'Clásico');

insert into artistas (codartista, nombre) values
	(6, 'Beethoveen'),
    (8, 'Fabio Biondi');

insert into albumes (codalbum, titulo, fecha, codartista, codgenero) values
    (7, 'Vivaldi - Concerti con molti strumenti', convert(date, '21/11/40', 3), 8, 6),
	(8, 'Beethoven: The Late String Quartets', convert(date, '21/11/41', 3), 6, 6),
	(9, 'Karajan: Beethoven Symphonies', convert(date, '01/07/09', 3), 6, 6 ),
	(10, 'Ludwig van Beethoven: Symphonien 1-9', convert(date, '04/09/89', 3), 6, 6 );

select count(codartista) as cantidadArtistas from albumes where codgenero = 6


-- ¿Cuáles son los géneros que tienen más de tres álbumes?

select g.codgenero, count(g.codgenero) as cantidad from albumes as a
	inner join generos as g on a.codgenero = g.codgenero
	group by g.codgenero
	having count(g.codgenero) > 3

-- ¿Cuál es el álbum con más temas (considere que puede haber más de uno)?
	
select a.titulo, count(t.titulo) as cantidad_temas
from albumes as a
inner join temas as t on a.codalbum = t.codalbum
group by a.titulo
having count(t.titulo) = (select max(cantidad)
                          from (select count(t2.titulo) as cantidad
                                from albumes as a2
                                inner join temas as t2 on a2.codalbum = t2.codalbum
                                group by a2.titulo) as subconsulta);

--  ¿Cuáles son los álbumes que tienen un título que es igual al título de alguno de los temas del mismo?

select a.titulo as nombreAlbum from albumes as a
	inner join temas as t on a.codalbum = t.codalbum
	where a.titulo = t.titulo

-- Determine el nombre de los artistas y de los álbumes de aquellos álbumes del género pop con temas que contengan una letra ñ en el título.

insert into albumes (codalbum, titulo, fecha, codartista, codgenero) values
    (11, 'somos ñoquisPop', convert(date, '21/11/22', 3), 4, 2);

select * from albumes as a
	inner join artistas as art on a.codartista = art.codartista
	where a.titulo like '%ñ%'

-- ¿Cuáles son los clientes con saldo negativo?

insert into clientes (codcliente, nombre, saldo) values
    (4, 'Yani', -20000.00)

select * from clientes 
	where saldo < 0

-- Determine si el bruto de las facturas es igual a la sumatoria de sus ítems. -- CREO QUE ESTA BIEN

select * from facturas as f 
	inner join itemsfactura as i on f.nrofactura = i.nrofactura 

select 
    f.nrofactura,
    f.bruto as bruto_factura,
    sum(coalesce(i.precio * i.cantidad, 0)) as suma_items
from
    facturas as f
join
    itemsfactura as i on f.nrofactura = i.nrofactura
group by
    f.nrofactura, f.bruto
having
    f.bruto = sum(coalesce(i.precio * i.cantidad, 0));

-- Determine cuales facturas tienen menos cantidad de artículos vendidos que los pedidos

insert into pedidos (nropedido, fecha, codcliente, fechaentrega, lugarentrega) values
    (4, convert(date, '15/01/23', 3), 3, convert(date, '20/01/23', 3), 'Dirección1');

insert into itemspedido (codproducto, nropedido, cantidad) values
	(1, 4, 10);

select f.nrofactura from facturas as f 
	inner join itemsfactura as i on f.nrofactura = i.nrofactura
	inner join itemsPedido as ipe on i.codproducto = ipe.codproducto
	where i.cantidad < ipe.cantidad
	

select * from facturas as f 
	inner join itemsfactura as i on f.nrofactura = i.nrofactura

select * from itemsPedido

-- Determine el artículo que esté compuesto por más componentes. NO ENTIENDO


-- ¿Cuáles son los productos que no figuran en ningún pedido?

insert into productos (codproducto, descripcion, stock, puntoreposicion, precio) values
    (5, 'Vinilo Artaud', 20, 10, 175.00);

select codproducto from productos -- posibilidad 1

	except -- diferencia entre 2 tablas

		select codproducto from itemsPedido


select * from productos where codproducto not in (select codproducto from itemsPedido) -- posibilidad 2

-- Determine el cliente con la factura más costosa.

with tabla as (select max(final) as facturaMasCostosa from facturas as f)

select * from facturas as f
	inner join clientes as c on f.codcliente = c.codcliente
	where f.final = (select * from tabla)

-- ¿Cuáles son los artículos cuyo stock es menor al punto de reposición?

insert into productos (codproducto, descripcion, stock, puntoreposicion, precio) values
    (6, 'Vinilo The Dream Canteen', 1, 15, 3000.00);

select * from productos 
	where stock < puntoreposicion

--¿Cuáles son los discos que pertenezcan a géneros que contengan una letra p en la descripción pero que no tengan una letra s?

	select codalbum, titulo, g.descripcion from albumes as a
		inner join generos as g on a.codgenero = g.codgenero
		where descripcion like '%p%' and descripcion not like '%s%'


-- ¿Cuáles son los pedidos que tienen productos con una descripción que contenga más de 60 caracteres en total?

	insert into productos (codproducto, descripcion, stock, puntoreposicion, precio) values
    (12, 'Vinilo Blood Sugar Sex Magik edicion coleccionista incluyendo vinilo doble, posters oficiales y grabaciones adicionales', 2, 1, 10500.00);

	insert into pedidos (nropedido, fecha, codcliente, fechaentrega, lugarentrega) values
    (15, convert(date, '19/05/23', 3), 2, convert(date, '20/05/23', 3), 'Dirección8');

	
	insert into pedidos (nropedido, fecha, codcliente, fechaentrega, lugarentrega) values
    (16, convert(date, '12/05/23', 3), 4, convert(date, '23/05/23', 3), 'Dirección9');

	insert into itemspedido (codproducto, nropedido, cantidad) values
	(12, 15, 1);

	insert into itemspedido (codproducto, nropedido, cantidad) values
	(2, 16, 2);

	select * from pedidos as p
		inner join itemsPedido as i on p.nropedido = i.nropedido
		inner join productos as pro on i.codproducto = pro.codproducto
		where len(pro.descripcion) > 60

-- Determine el total de todas las facturas de cada cliente del mes de febrero del corriente año.

	select * from pedidos
	select * from itemsPedido
	select * from facturas
	select * from itemsfactura
	select * from productos

	insert into facturas (nrofactura, fecha, codcliente, codpedido, bruto, iva, iibb, final) values
		(4, convert(date, '15/01/23', 3), 3, 4, 30.00 * 3, 30.00 * 1.21 * 3, 30.00 * 1.03 * 3, (30.00 * 1.21 + 30.00 * 1.03) * 3),
		(5, convert(date, '19/05/23', 3), 2, 15, 10500.00, 10500.00 * 1.21, 10500.00 * 1.03, 10500.00 * 1.21 + 10500.00 * 1.03);

	insert into itemsfactura (codproducto, nrofactura, cantidad, precio, descuento) values
		(3, 4, 3, 30.00, 0.00),
		(12, 5, 1, 10500, 0.00);

	select count(nrofactura) as cantidadFacturasFebrero from clientes as c
		inner join facturas as f on c.codcliente = f.codcliente
		where month(fecha) = 02


-- FUNCIONES 
/*
	- Crear una función que reciba la descripción de un género y devuelva el nombre 
	del artista que posee más discos, que el autor con más discos durante la década 
	del 2000 (considera la década como el período 2001 – 2010) 
*/	

		create function obtener_artista_mas_discos_en_decada(@descripcion_genero nvarchar(255)) -- REVISAR
		returns nvarchar(100)
		as
		begin
			declare @artista_mas_discos nvarchar(100);

			-- Obtener el año inicial y final de la década del 2000
			declare @inicio_decada int = 2001;
			declare @fin_decada int = 2010;

			-- Calcular el número máximo de discos por artista durante la década
			with discos_por_artista as (
				select a.codartista, count(al.codalbum) as num_discos
				from
					artistas as a
					inner join albumes as al on a.codartista = al.codartista
					inner join generos as g on al.codgenero = g.codgenero
				where
					g.descripcion = @descripcion_genero
					and year(al.fecha) between @inicio_decada and @fin_decada
				group by
					a.codartista
			)
			-- Seleccionar el artista con más discos durante la década usando MAX()
			select 
				@artista_mas_discos = a.nombre
			from
				artistas a
				inner join discos_por_artista dpa on a.codartista = dpa.codartista
			where
				dpa.num_discos = (select max(num_discos) from discos_por_artista)
			order by
				a.nombre; -- Si hay un empate, ordenar por nombre

			return @artista_mas_discos;
		end;

		declare @ArtistaResultante nvarchar(100);
		set @ArtistaResultante = dbo.Obtener_Artista_Mas_Discos_En_Decada('Clásico');
		print @ArtistaResultante;

/*
	- Crear una funciona que devuelva la lista de temas de acuerdo el nombre de un 
	artista pasado como parámetro. Informe el nombre del tema, la duración, el 
	orden el nombre del álbum donde se encuentra.
*/

		create or alter function temasArtista (@nombreArtista nvarchar(200))
			returns table
				return select t.titulo, t.duracion, t.orden from artistas as a
					inner join albumes as ab on a.codartista = ab.codartista
					inner join temas as t on ab.codalbum = t.codalbum
					where a.nombre = @nombreArtista

		declare @Artista nvarchar(100);
		set @Artista = 'Red Hot Chili Peppers'
		select * from temasArtista(@Artista)


/*
	- Crear una función que determine la cantidad de dinero pagado (facturado a un 
	cliente) de aquellos productos que poseen al menos 4 productos en su 
	composición.
*/
		
		create or alter function dineroFacturadoCuatroProductos()
			returns decimal
		as
		begin
			declare @cantidad int = 0;

			with ProductosComposiciones as
				(select itf.cantidad as cantidadFactura, c.cantidad as cantidadProductosAdicionales, f.final as precioFinal from facturas as f
					inner join itemsfactura as itf on f.nrofactura = itf.nrofactura
					inner join productos as p on itf.codproducto = p.codproducto
					inner join composiciones as c on p.codproducto = c.codproducto
					where c.cantidad >= 4)

			select @cantidad = sum(precioFinal) from ProductosComposiciones -- Su usa select para almacenar lo que devuelve en forma de tabla en una variable de otro tipo distinto
			return @cantidad
		end

		declare @totalFacturadoCuatroProductos decimal;
		set @totalFacturadoCuatroProductos = dbo.dineroFacturadoCuatroProductos()
		print @totalFacturadoCuatroProductos



-- PROCEDIMIENTOS

/*
Crear un procedimiento que reciba el numero de un pedido y el nombre de un 
cliente y facture el pedido realizando las siguientes acciones.
 Verificar que el cliente ingresado exista y coincida con el cliente almacenado 
en el pedido. Si no es correcto enviar un mensaje de error.
 Crear la factura y los ítems de factura.
 Devolver en variables output el número de la factura, el importe bruto y el 
neto-
*/

	create or alter procedure crearFactura ( --AGREGAR OPUTPUTS
		@numeroPedido int,
		@nombreCliente nvarchar(100))
	as
		begin
			if exists(select * from clientes as c
						inner join pedidos as p on c.codcliente = p.codcliente
						where nombre = @nombreCliente
						and nropedido = @numeroPedido ) 
				begin
					
					-- para factura
					declare @numFactura int = 6;

					declare @fecha date = getdate();

					declare @codCliente int;
					select  @codCliente = codcliente from pedidos where nropedido = @numeroPedido;

					declare @bruto decimal;
					select @bruto = cantidad * precio from itemsPedido itp
						inner join productos as p on itp.codproducto = p.codproducto				
						where nropedido = @numeroPedido


					-- para items de factura
					declare @codProducto int;
					select @codProducto = codproducto from itemsPedido 			
						where nropedido = @numeroPedido

					declare @cantidadProducto int;
					select @cantidadProducto = cantidad from itemsPedido 			
						where nropedido = @numeroPedido
							 

					insert into facturas(nrofactura, fecha, codcliente, codpedido, bruto, iva, iibb, final) values 
						(@numFactura, @fecha, @codCliente, @numeroPedido, @bruto, @bruto * 0.21, @bruto * 0.03, @bruto + (@bruto * 0.21) + (@bruto * 0.03));

					insert into itemsfactura(codproducto, nrofactura, cantidad, precio, descuento) values 
						(@codProducto, @numFactura, @cantidadProducto, @bruto / @cantidadProducto, 0.00);

					set @numFactura = @numFactura + 1;
				end
			else 
				print 'Error, el cliente no existe'
		end
	go

	
	select * from productos
	select * from clientes
	select * from facturas
	select * from itemsfactura
	select * from pedidos
	select * from itemsPedido


	declare @numPedido int = 16;
	declare @nombreCliente nvarchar(100) = 'Yani';

	exec crearFactura @numPedido, @nombreCliente

	delete from facturas where nrofactura = 6
	delete from itemsfactura where nrofactura = 6


/*
Crear un procedimiento que reciba el nombre de un cliente y un entero 
correspondiente a un trimestre del año (1: enero a marzo, 2: abril a junio, etc.) 
y realice las siguientes acciones:
 Verifique que el nombre ingresado corresponda a un cliente existente, caso 
contrario emita un mensaje de error.
 Verifique el número de trimestre sea válido y que el cliente tenga facturación 
en ese trimestre, caso contrario emita un mensaje de error.
 Crear una tabla denominada Facturación más el número de cliente más el 
trimestre (por ejemplo, para el cliente cuyo número es el 523 y la facturación 
del 3 trimestre serio Facturacion_523_3”). Si existe eliminarla y volverla a 
crear con la siguiente estructura: 
o Nro. Factura
o Fecha Factura
o nombre Cliente
o Nro. Pedido
o Fecha Pedido
o cantidad de productos en la factura
o cantidad de unidades totales en la factura  -- NO SE QUE ES
o importe bruto
o importe IVA
o importe IIBB
o importe final neto
 Insertar la información en la tabla creada en el punto anterior. 
 Devolver en variables de output la cantidad de registros insertados y el 
importe total del trimestre
*/

	create or alter procedure facturacionCliente (
		@nombreCliente nvarchar(100),
		@trimestre int,
		@registrosInsertados int output,
		@importeTotal int output
		)
	as
		begin
			
			declare @existe bit = 0;

			if exists(select * from clientes where nombre = @nombreCliente) and @trimestre in (1,2,3,4)
				begin
					if @trimestre = 1 and exists(select * from facturas as f
																inner join clientes as c on f.codcliente = c.codcliente
																where c.nombre = @nombreCliente
																and month(f.fecha) in (01,02,03))
						begin
							set @existe = 1;
						end

					if @trimestre = 2 and exists(select * from facturas as f
																inner join clientes as c on f.codcliente = c.codcliente
																where c.nombre = @nombreCliente
																and month(f.fecha) in (04,05,06))

						begin
							set @existe = 1;
						end

					if @trimestre = 3 and exists(select * from facturas as f
																inner join clientes as c on f.codcliente = c.codcliente
																where c.nombre = @nombreCliente
																and month(f.fecha) in (07,08,09))

						begin
							set @existe = 1;
						end

					if @trimestre = 4 and exists(select * from facturas as f
																inner join clientes as c on f.codcliente = c.codcliente
																where c.nombre = @nombreCliente
																and month(f.fecha) in (10,11,12))

						begin
							set @existe = 1;
						end
				end
				
				if @existe = 0 
					print 'El cliente no tiene facturación en este trimestre'

				if @existe = 1 
					begin

						declare @sentencia nvarchar(3000)
						declare @nombre varchar(100)

						declare @codCliente int;
							select  @codCliente = codcliente from clientes where nombre = @nombreCliente;

						select @nombre = 'facturacion_' + cast(@codCliente as nvarchar(100)) + '_' + cast(@trimestre as nvarchar(100))

						if exists (select * from sysobjects where name = @nombre)
							begin
								select @sentencia = 'drop table ' + @nombre
								exec sp_executeSQL @sentencia
							end

						select @sentencia = 'create table ' + @nombre + ' (nroFactura int,' 
							+ 'fechaFactura date, ' 
							+ 'nombreCliente nvarchar(255),'
							+ 'nroPedido int,'
							+ 'fechaPedido date,'
							+ 'cantidadProductos int,'
							+ 'cantidadUnidadesTotales int,' 
							+ 'importeBruto decimal,'
							+ 'importeIVA decimal,'
							+ 'importeIIBB decimal,'
							+ 'importeFinal decimal)'

						exec sp_executeSQL @sentencia

						if @trimestre = 1
						begin
							select @sentencia = 'insert into ' + @nombre +
							' select f.nrofactura, f.fecha as fechaFactura, c.nombre, p.nropedido, p.fecha as fechaPedido, ipe.cantidad, ipe.cantidad, f.bruto, f.iva, f.iibb, f.final ' + 
							'from facturas as f inner join clientes as c on f.codcliente = c.codcliente ' +
							'inner join pedidos as p on c.codcliente = p.codcliente ' + 
							'inner join itemsPedido as ipe on p.nropedido = ipe.nropedido ' + 
							'where c.nombre = ''' + @nombreCliente + ''' and ' + 'month(f.fecha) in (01,02,03)' 
						end

						if @trimestre = 2
						begin
							select @sentencia = 'insert into ' + @nombre +
							' select f.nrofactura, f.fecha as fechaFactura, c.nombre, p.nropedido, p.fecha as fechaPedido, ipe.cantidad, ipe.cantidad, f.bruto, f.iva, f.iibb, f.final ' + 
							'from facturas as f inner join clientes as c on f.codcliente = c.codcliente ' +
							'inner join pedidos as p on c.codcliente = p.codcliente ' + 
							'inner join itemsPedido as ipe on p.nropedido = ipe.nropedido ' + 
							'where c.nombre = ''' + @nombreCliente + ''' and ' + 'month(f.fecha) in (04,05,06)' 
						end

						if @trimestre = 3
						begin
							select @sentencia = 'insert into ' + @nombre +
							' select f.nrofactura, f.fecha as fechaFactura, c.nombre, p.nropedido, p.fecha as fechaPedido, ipe.cantidad, ipe.cantidad, f.bruto, f.iva, f.iibb, f.final ' + 
							'from facturas as f inner join clientes as c on f.codcliente = c.codcliente ' +
							'inner join pedidos as p on c.codcliente = p.codcliente ' + 
							'inner join itemsPedido as ipe on p.nropedido = ipe.nropedido ' + 
							'where c.nombre = ''' + @nombreCliente + ''' and ' + 'month(f.fecha) in (07,08,09)' 
						end

						if @trimestre = 4
						begin
							select @sentencia = 'insert into ' + @nombre +
							' select f.nrofactura, f.fecha as fechaFactura, c.nombre, p.nropedido, p.fecha as fechaPedido, ipe.cantidad, ipe.cantidad, f.bruto, f.iva, f.iibb, f.final ' + 
							'from facturas as f inner join clientes as c on f.codcliente = c.codcliente ' +
							'inner join pedidos as p on c.codcliente = p.codcliente ' + 
							'inner join itemsPedido as ipe on p.nropedido = ipe.nropedido ' + 
							'where c.nombre = ''' + @nombreCliente + ''' and ' + 'month(f.fecha) in (10,11,12)' 
						end

						exec sp_executeSQL @sentencia

						set @registrosInsertados = @@rowcount

						if @trimestre = 1 
							begin 
								select @importeTotal = SUM(f.final) from facturas as f
													inner join clientes as c on f.codcliente = c.codcliente
													where nombre = @nombre and MONTH(f.fecha) in (01,02,03)
							end


						if @trimestre = 2
							begin 
								select @importeTotal = SUM(f.final) from facturas as f
													inner join clientes as c on f.codcliente = c.codcliente
													where nombre = @nombre and MONTH(f.fecha) in (04,05,06)
							end
						

						if @trimestre = 3 
							begin 
								select @importeTotal = SUM(f.final) from facturas as f
													inner join clientes as c on f.codcliente = c.codcliente
													where nombre = @nombre and MONTH(f.fecha) in (07,08,09)
							end
						

						if @trimestre = 4 
							begin 
								select @importeTotal = SUM(f.final) from facturas as f
													inner join clientes as c on f.codcliente = c.codcliente
													where nombre = @nombre and MONTH(f.fecha) in (10,11,12)
							end
						

					end		-- end de if @existe = 1	
					
			else
				print 'Error, cliente no existente o su dato de trimestre no es válido (debe ser entre 1 y 4)'
		
		end
		
	go

	declare @registros int;
	declare @facturadoTrimestre decimal;

	exec facturacionCliente 'Roberto', 1, @registros output, @facturadoTrimestre output

	print @registros
	print @facturadoTrimestre -- VER FACTURADO, NO ANDA

	select * from facturas

	select * from dbo.facturacion_3_1


	drop table dbo.facturacion_3_1

/*
Crear un procedimiento que cree una tabla de referencias cruzadas para los 
productos en un rango de fechas determinado. La estructura seria la siguientes:
	 En cada fila se indicará un producto. 

	 En cada columna el mes y el año (0110 seria enero del 2010), cada uno
	correspondiente al rango de fechas ingresado (si se ingresa el rango de fechas 
	05/02/2015 – 10/01/2016 serian 12 columnas)

	 En la intersección de las filas y las columnas la cantidad total unidades 
	facturadas en las facturas de ese mes y año.

	 Verificar que el rango de fechas sea válido (debe tener al menos un trimestre). 
	Caso contrario enviar un mensaje y finalizar el procedimiento. 

	 Debe existir información para ese trimestre. Caso contrario enviar un mensaje 
	y finalizar el procedimiento. 

	 Devolver en una variable de output la cantidad de registros leídos para hacer 
	la tabla de referencias cruzadas.

	 El nombre de la tabla será RC_ + el rango de fechas (por ejemplo, si puso 
	05/01/2010 y 26/07/2013 el nombre será RC_0110_0713)

*/


create or alter procedure crear_tabla_referencias_cruzadas -- NO ANDA
    @fecha_inicio date,
    @fecha_fin date,
    @registros_leidos int output
as
begin

    -- Verificar que el rango de fechas sea válido
    if @fecha_inicio >= @fecha_fin
    begin
        print 'Error: El rango de fechas no es válido.';
        return;
    end;

    -- Verificar que el rango de fechas tenga al menos un trimestre
    if datediff(month, @fecha_inicio, @fecha_fin) < 3
    begin
        print 'Error: El rango de fechas debe tener al menos un trimestre.';
        return;
    end;

    -- Verificar que exista información para ese trimestre
    if not exists (
        select 1
        from facturas
        where fecha between @fecha_inicio and @fecha_fin
    )
    begin
        print 'Error: No existe información para ese trimestre.';
        return;
    end;

    declare @nombre_tabla nvarchar(50);
    set @nombre_tabla = 'rc_' + format(@fecha_inicio, 'mmyy') + '_' + format(@fecha_fin, 'mmyy');

    declare @sql_crear_tabla nvarchar(max);
    declare @sql_insert_datos nvarchar(max);

    -- Crear la tabla
    set @sql_crear_tabla = '
        create table ' + @nombre_tabla + ' (
            cod_producto int primary key,
            ' + stuff((
                select distinct ', [' + format(fecha, 'mmyy') + '] int'
                from facturas
                where fecha between @fecha_inicio and @fecha_fin
                for xml path('')
            ), 1, 2, '') + '
        );';

    exec sp_executesql @sql_crear_tabla;

    -- Insertar datos en la tabla
    set @sql_insert_datos = '
        insert into ' + @nombre_tabla + '
        select
            cod_producto,
            ' + stuff((
                select ', sum(case when format(fecha, ''mmyy'') = ''' + format(fecha, 'mmyy') + ''' then cantidad else 0 end) as [' + format(fecha, 'mmyy') + ']'
                from facturas
                where fecha between @fecha_inicio and @fecha_fin
                group by format(fecha, 'mmyy')
                order by format(fecha, 'mmyy')
                for xml path('')
            ), 1, 2, '') + '
        from facturas
        where fecha between @fecha_inicio and @fecha_fin
        group by cod_producto;';

    exec sp_executesql @sql_insert_datos;

    -- Obtener la cantidad de registros leídos
    set @registros_leidos = @@rowcount;

    print 'Tabla de referencias cruzadas creada exitosamente: ' + @nombre_tabla;
end;

declare @registros int;
declare @fechaInicio date = cast('2023/01/19' as date);
declare @fechaFin date = cast('2023/03/20' as date);

exec crear_tabla_referencias_cruzadas @fechaInicio, @fechaFin, @registros

print @registros

select * from facturas
select * from pedidos
select * from productos


/*
Crear un procedimiento que realice un listado utilizando 2 cursores para 
resolverlo. El formato del listado es el siguiente:
Artista: XXXXXXXXXXXXXXXXXXXXXXX
Discogafia 
99/99/99 : XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX (fechaAlbum 
y nombreDIsco)
99 – XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 99:99 (nro. –
titulo - duración)
99 – XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 99:99
99 – XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 99:99
*/

create or alter procedure ListarDiscografia
as
begin

    declare @codArtista int;
    declare @nombreArtista nvarchar(255);

    -- Cursor para recorrer los artistas
    declare cursorArtistas cursor for
    select codArtista, nombre from artistas;

    open cursorArtistas;

    fetch next from cursorArtistas into @codArtista, @nombreArtista;

    while @@fetch_status = 0
    begin
        print 'Artista: ' + @nombreArtista;

        -- Cursor para recorrer los álbumes del artista
        declare @codAlbum int;
        declare @fechaAlbum date;
        declare @nombreDisco nvarchar(255);

        declare cursorAlbumes cursor for
        select codAlbum, fecha, titulo from albumes where codArtista = @codArtista;

        open cursorAlbumes;

        fetch next from cursorAlbumes into @codAlbum, @fechaAlbum, @nombreDisco;

        while @@fetch_status = 0
        begin
            print convert(nvarchar, @fechaAlbum, 5) + ' : ' + @nombreDisco;

            -- Cursor para recorrer los temas del álbum
            declare @tituloTema nvarchar(255);
            declare @orden int;
            declare @duracion nvarchar(10);

            declare cursorTemas cursor for
            select titulo, orden, duracion from temas where codAlbum = @codAlbum;

            open cursorTemas;

            fetch next from cursorTemas into @tituloTema, @orden, @duracion;

            while @@fetch_status = 0
            begin
                print right('00' + convert(nvarchar, @orden), 2) + ' - ' + @tituloTema + ' ' + @duracion;

                fetch next from cursorTemas into @tituloTema, @orden, @duracion;
            end

            close cursorTemas;
            deallocate cursorTemas;

            fetch next from cursorAlbumes into @codAlbum, @fechaAlbum, @nombreDisco;
        end

        close cursorAlbumes;
        deallocate cursorAlbumes;

        fetch next from cursorArtistas into @codArtista, @nombreArtista;
    end

    close cursorArtistas;
    deallocate cursorArtistas;
end
go 

exec ListarDiscografia

/*
Crear un procedimiento que realice un listado utilizando de la composición de los 
productos. El formato del listado es el siguiente: 
Producto       Componente			cantidad		precio
XXXXXXXXX		XXXXXXXXX			XXXXXXXX	999
999.99
XXXXXXXXXXXXXXXXXXXXX 999 999.99
XXXXXXXXXXXXXXXXXXXXX 999 999.99
XXXXXXXXXXXXXXXXXXXXX 999 999.99
Total del producto XXXXXXXXXXXXXXXXXXXXXXXX 9999 999.99
XXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXX 999
999.99
XXXXXXXXXXXXXXXXXXXXX 999 999.99
Total del producto XXXXXXXXXXXXXXXXXXXXXXXX 9999 999.99
*/

