create database noticias

create table usuarios (
    id_usuario int,
    nombre nvarchar(100),
    alias nvarchar(50),
    contraseña nvarchar(50),
    activo bit default 1,
    correo_electronico nvarchar(255)
	constraint pk_usuarios primary key(id_usuario)
);

create table categorias (
    id_categoria int,
    nombre nvarchar(50),
    descripcion nvarchar(255)
	constraint pk_categorias primary key(id_categoria)
);

create table noticias (
    id_noticia int constraint pk_noticias primary key,
    titulo nvarchar(255),
    id_categoria int,
    id_autor int,
    fecha date,
    ubicacion_noticia nvarchar(255),
    constraint fk_noticias_categorias foreign key (id_categoria) references categorias(id_categoria),
    constraint fk_noticias_usuarios foreign key (id_autor) references usuarios(id_usuario)
);

create table comentarios (
    id_comentario int constraint pk_comentarios primary key,
    noticia int,
    texto nvarchar(max),
    id_usuario int,
    fecha date,
    constraint fk_comentarios_noticias foreign key (noticia) references noticias(id_noticia),
    constraint fk_comentarios_usuarios foreign key (id_usuario) references usuarios(id_usuario)
);

create table privilegios (
    id_usuario int,
    privilegio nvarchar(50) check (privilegio = 'Responsable' or privilegio = 'Crear noticia'),
    id_categoria int,
    constraint pk_privilegios primary key (id_usuario, id_categoria),
    constraint fk_privilegios_usuarios foreign key (id_usuario) references usuarios(id_usuario),
    constraint fk_privilegios_categorias foreign key (id_categoria) references categorias(id_categoria)
);

create table votaciones (
    id_votacion int,
    id_noticia int,
    fecha_inicio date,
    fecha_fin date,
    pregunta nvarchar(max),
    respuesta1 nvarchar(max),
    respuesta2 nvarchar(max),
    respuesta3 nvarchar(max),
    votos_opcion1 int,
    votos_opcion2 int,
    votos_opcion3 int,
	constraint pk_votaciones primary key(id_votacion),
    constraint fk_votaciones_noticias foreign key (id_noticia) references noticias(id_noticia)
);

--INSERTS

-- Inserciones en la tabla usuarios
insert into usuarios (id_usuario, nombre, alias, contraseña, activo, correo_electronico)
values 
(1, 'Juan Pérez', 'juancito', 'clave123', 1, 'juan.perez@example.com'),
(2, 'María López', 'marialo', 'password456', 1, 'maria.lopez@example.com'),
(3, 'Carlos Sánchez', 'carlitos', 'secreto789', 1, 'carlos.sanchez@example.com'),
(4, 'Ana Martínez', 'anita', 'contraseña321', 1, 'ana.martinez@example.com'),
(5, 'Luis Rodríguez', 'luisito', 'clave567', 1, 'luis.rodriguez@example.com');

-- Inserciones en la tabla categorias
insert into categorias (id_categoria, nombre, descripcion)
values 
(1, 'Política', 'Noticias relacionadas con la política'),
(2, 'Deportes', 'Noticias deportivas y eventos relacionados'),
(3, 'Ciencia', 'Avances científicos y descubrimientos'),
(4, 'Entretenimiento', 'Noticias de la industria del entretenimiento'),
(5, 'Tecnología', 'Novedades tecnológicas y lanzamientos');

-- Inserciones en la tabla noticias
insert into noticias (id_noticia, titulo, id_categoria, id_autor, fecha, ubicacion_noticia)
values 
(1, 'Avances en la política internacional', 1, 1, '2023-01-15', '/noticias/politica1'),
(2, 'Partido emocionante en el campeonato', 2, 2, '2023-02-20', '/noticias/deportes1'),
(3, 'Nuevo descubrimiento en la medicina', 3, 3, '2023-03-10', '/noticias/ciencia1'),
(4, 'Estreno de la película del año', 4, 4, '2023-04-05', '/noticias/entretenimiento1'),
(5, 'Lanzamiento del último smartphone', 5, 5, '2023-05-30', '/noticias/tecnologia1');

-- Inserciones en la tabla comentarios
insert into comentarios (id_comentario, noticia, texto, id_usuario, fecha)
values 
(1, 1, 'Muy interesante la noticia', 2, '2023-01-16'),
(2, 2, 'Increíble el partido, no me lo esperaba', 3, '2023-02-21'),
(3, 3, 'Esperemos que este descubrimiento beneficie a todos', 4, '2023-03-11'),
(4, 4, '¡No puedo esperar para verla!', 5, '2023-04-06'),
(5, 5, '¿Alguien ya tiene el nuevo smartphone?', 1, '2023-06-01');

-- Inserciones en la tabla privilegios
insert into privilegios (id_usuario, privilegio, id_categoria)
values 
(1, 'Responsable', 1),
(2, 'Crear noticia', 2),
(3, 'Responsable', 3),
(4, 'Crear noticia', 4),
(5, 'Responsable', 5);

-- Inserciones en la tabla votaciones
insert into votaciones (id_votacion, id_noticia, fecha_inicio, fecha_fin, pregunta, respuesta1, respuesta2, respuesta3, votos_opcion1, votos_opcion2, votos_opcion3)
values 
(1, 1, '2023-01-15', '2023-01-25', '¿Qué opinas de los nuevos acuerdos internacionales?', 'Muy bien', 'Neutral', 'En desacuerdo', 20, 10, 5),
(2, 2, '2023-02-20', '2023-02-28', '¿Cuál fue el mejor momento del partido?', 'Gol espectacular', 'Jugada increíble', 'Resultado sorprendente', 15, 18, 12),
(3, 3, '2023-03-10', '2023-03-20', '¿Cómo afectará este descubrimiento a la medicina?', 'Cambio revolucionario', 'Mejoras graduales', 'No lo sé', 25, 30, 10),
(4, 4, '2023-04-05', '2023-04-15', '¿Qué esperas de la nueva película?', 'Emoción y diversión', 'Historia intrigante', 'No tengo expectativas', 22, 15, 8),
(5, 5, '2023-05-30', '2023-06-10', '¿Has probado el nuevo smartphone?', 'Sí, lo tengo', 'No, pero estoy interesado', 'No, no me gusta', 2,65,5)


--CONSULTAS

-- ¿Cuáles son los privilegios de cada usuario?

	select  u.id_usuario, u.nombre, p.privilegio from usuarios as u
		inner join privilegios as p on u.id_usuario = p.id_usuario
		group by u.id_usuario, u.nombre, p.privilegio

--¿Cuál es el usuario que escribió la noticia más votada? -- MAL


		select sub.id_usuario, u.nombre, sub.cantidadVotos
			from (
				select u.id_usuario, n.id_noticia, v.id_votacion, sum(v.votos_opcion1 + v.votos_opcion2 + v.votos_opcion3) as cantidadVotos
					from usuarios as u
					inner join noticias as n on u.id_usuario = n.id_autor
					inner join votaciones as v on n.id_noticia = v.id_noticia
					group by u.id_usuario, n.id_noticia, v.id_votacion
				) as sub

			inner join usuarios as u on sub.id_usuario = u.id_usuario
			where sub.cantidadVotos = (select max(cantidadVotos) from sub);

		select * from noticias
		select * from votaciones


-- ¿Cuántos votos recibió en total cada noticia?

	select n.id_noticia, n.titulo, sum(v.votos_opcion1 + v.votos_opcion2 + v.votos_opcion3) as cantidadvotos from noticias as n 
		inner join votaciones as v on n.id_noticia = v.id_noticia
		group by n.id_noticia, n.titulo;

--¿Qué usuarios escribieron noticias que pertenezcan al género policiales y que tengan al menos un comentario?

	insert into categorias(id_categoria, nombre, descripcion) values 
		(6, 'Policial', 'Noticias sobre crímenes');

	insert into noticias (id_noticia, titulo, id_categoria, id_autor, fecha, ubicacion_noticia) values 
		(6, 'Parricidio en Vicente López', 6, 1, '2023-04-27', '/noticias/policial');

	insert into comentarios (id_comentario, noticia, texto, id_usuario, fecha) values 
		(6, 6, '¡Que Horror!', 2, '2023-04-29');

	select u.nombre, sub.id_categoria, cantidadComentarios from (
				select n.id_noticia, n.id_autor, n.id_categoria, count(id_comentario) as cantidadComentarios from comentarios as c
				inner join noticias as n on c.noticia = n.id_noticia
				group by n.id_noticia, n.id_autor, n.id_categoria) 
			as sub

		inner join usuarios as u on sub.id_autor = u.id_usuario
		where sub.id_categoria = 6 and cantidadComentarios >= 1
		group by u.nombre, sub.id_categoria ,cantidadComentarios


	insert into noticias (id_noticia, titulo, id_categoria, id_autor, fecha, ubicacion_noticia) values 
		(7, 'Robos y amenazas', 6, 3, '2023-05-27', '/noticias/policial');

	insert into comentarios (id_comentario, noticia, texto, id_usuario, fecha) values 
		(7, 7, '¡Que Horror!', 2, '2023-05-29');

select * from usuarios
select * from noticias
select * from comentarios



select * from noticias

-- FUNCIONES

/*
	
	- Crear una función que devuelva el título de la noticia más votada en un rango de 
	fechas determinado pasado como parámetro.

	- Crear una función que retorne la cantidad de votos en una fecha determinada 
	pasada como parámetro. Indicar la fecha, el título, el nombre de la categoría, la 
	pregunta y la cantidad de votos totales recibidos, las respuestas y sus cantidades 
	de votos.

	- Crear una función de determine quienes son los usuarios que al menos hicieron 
	20 comentarios a noticias de genero economía en los últimos 30 días. Indique el 
	nombre de los usuarios.
	
	*/