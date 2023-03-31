-- Consultas queries ML - Parte I
-- Vamos a practicar sobre consultas SELECT, enfocándonos en SELECT,
-- WHERE, operadores de condición como AND, OR, BETWEEN, LIKE, IN, entre
-- otros.

-- Tips:
-- - Cada enunciado se corresponde con una consulta SELECT.
-- - Recordá ir guardando las consultas SQL.

-- Consignas

-- Categorías y productos
-- 1. Queremos tener un listado de todas las categorías.

select * from categorias;

-- 2. Cómo las categorías no tienen imágenes, solamente interesa obtener un
-- listado de CategoriaNombre y Descripcion.

select CategoriaNombre, Descripcion from categorias;

-- 3. Obtener un listado de los productos.

select * from productos;

-- 4. ¿Existen productos discontinuados? (Discontinuado = 1).

select * from productos
where Discontinuado = 1;

-- 5. Para el viernes hay que reunirse con el Proveedor 8. ¿Qué productos son
-- los que nos provee?

select ProveedorID, ProductoNombre from productos
where ProveedorID = 8;

-- 6. Queremos conocer todos los productos cuyo precio unitario se encuentre
-- entre 10 y 22.

select * from productos
where PrecioUnitario between 10 and 22;

-- 7. Se define que un producto hay que solicitarlo al proveedor si sus unidades
-- en stock son menores al Nivel de Reorden. ¿Hay productos por solicitar?

select * from productos
where UnidadesStock < NivelReorden;


-- 8. Se quiere conocer todos los productos del listado anterior, pero que
-- unidades pedidas sea igual a cero.
select * from productos
where UnidadesStock < NivelReorden and UnidadesPedidas = 0;

-- Clientes
-- 9. Obtener un listado de todos los clientes con Contacto, Compania, Título,
-- País. Ordenar el listado por País.

select Contacto, Compania, Titulo, pais from clientes
order by pais;

-- 10. Queremos conocer a todos los clientes que tengan un título “Owner”.

select * from clientes
where titulo = 'Owner';

-- 11. El operador telefónico que atendió a un cliente no recuerda su nombre.
-- Solo sabe que comienza con “C”. ¿Lo ayudamos a obtener un listado con
-- todos los contactos que inician con la letra “C”?

select * from clientes
where contacto like 'C%';

-- Facturas
-- 12. Obtener un listado de todas las facturas, ordenado por fecha de factura
-- ascendente.

select * from facturas
order by FechaFactura asc;

-- 13. Ahora se requiere un listado de las facturas con el país de envío “USA” y
-- que su correo (EnvioVia) sea distinto de 3.

select * from facturas 
where PaisEnvio = 'USA' and EnvioVia != 3;

-- 14. ¿El cliente 'GOURL' realizó algún pedido?

select * from facturas
where ClienteID = 'GOURL';

-- 15. Se quiere visualizar todas las facturas de los empleados 2, 3, 5, 8 y 9.

select * from facturas
where EmpleadoID in (2, 3, 5,  8, 9);

-- Consultas queries ML - Parte II
-- En esta segunda parte vamos a intensificar la práctica de consultas
-- SELECT, añadiendo ALIAS, LIMIT y OFFSET.

-- Productos
-- 6. Obtener el listado de todos los productos ordenados
-- descendentemente por precio unitario.

select * from productos
order by PrecioUnitario desc;

-- 17. Obtener el listado de top 5 de productos cuyo precio unitario es
-- el más caro.

select ProductoID, ProductoNombre, PrecioUnitario  from productos
order by PrecioUnitario desc
limit 5
offset 0;

-- 18. Obtener un top 10 de los productos con más unidades en stock.

select ProductoID, ProductoNombre, UnidadesStock from productos
order by UnidadesStock desc
limit 10
offset 0;

-- FacturaDetalle
-- 19. Obtener un listado de FacturaID, Producto, Cantidad.

select FacturaID, ProductoID, Cantidad from facturadetalle;

-- 20. Ordenar el listado anterior por cantidad descendentemente.

select FacturaID, ProductoID, Cantidad from facturadetalle
order by Cantidad desc;

-- 21. Filtrar el listado solo para aquellos productos donde la cantidad
-- se encuentre entre 50 y 100.

select * from facturadetalle
where cantidad between 50 and 100;

-- 22. En otro listado nuevo, obtener un listado con los siguientes
-- nombres de columnas: NroFactura (FacturaID), Producto
-- (ProductoID), Total (PrecioUnitario*Cantidad).

select FacturaID, ProductoID, (PrecioUnitario*Cantidad) as Total from facturadetalle;

-- ¡Extras!

-- ¿Te sobró tiempo? ¿Querés seguir practicando?
-- Te dejamos unos ejercicios extras a partir de la misma base:

-- 23. Obtener un listado de todos los clientes que viven en “Brazil" o “Mexico”,
-- o que tengan un título que empiece con “Sales”.

select * from clientes
where Pais in('Brazil', 'Mexico') and titulo like 'Sales%';

-- 24. Obtener un listado de todos los clientes que pertenecen a una compañía
-- que empiece con la letra "A".

select * from clientes
where Compania like 'A%';

-- 25. Obtener un listado con los datos: Ciudad, Contacto y renombrarlo
-- como Apellido y Nombre, Titulo y renombrarlo como Puesto, de todos
-- los clientes que sean de la ciudad "Madrid".

select Ciudad, Contacto AS 'Apellido y Nombre', Titulo 'Puesto', ciudad from clientes
where ciudad = 'Madrid';

-- 26. Obtener un listado de todas las facturas con ID entre 10000 y 10500

select * from facturas
where FacturaID between 10000 and 10500;

-- 27. Obtener un listado de todas las facturas con ID entre 10000 y 10500 o de
-- los clientes con ID que empiecen con la letra “B”.

select * from facturas
where FacturaID between 10000 and 10500 or ClienteID like 'B%';

-- 28. ¿Existen facturas que la ciudad de envío sea “Vancouver” o que
-- utilicen el correo 3?

select * from facturas
where CiudadEnvio = 'Vancouver' or EnvioVia = 3;

-- 29. ¿Cuál es el ID de empleado de “Buchanan”?

select EmpleadoID, Apellido from empleados
where Apellido = 'Buchanan';

-- 30. ¿Existen facturas con EmpleadoID del empleado del ejercicio anterior?
-- (No relacionar, sino verificar que existan facturas)

select * from facturas
where EmpleadoID = 5;


/*--------------------------------------------------------------------------------------------------------------------------------------*/


-- Consultas
-- Alias, limit y offset
-- 31. Mostrar el título de todas las series y usar alias para que tanto el nombre de la
-- tabla como el campo estén en español.

select title AS 'Título' from series;

-- 32. Traer el título de las películas con el rating mayor a 3, con más de 1 premio y con
-- fecha de lanzamiento entre el año 1988 al 2009. Ordenar los resultados por
-- rating.

select * from movies
where rating > 3 and awards > 1 and release_date between '1998-01-01' and '2009-12-31'
order by rating;

-- 33. Traer el top 3 a partir del registro 10 de la consulta anterior.

select * from movies
where rating > 3 and awards > 1 and release_date between '1998-01-01' and '2009-12-31'
order by rating desc
limit 3
offset 0;

-- 34. ¿Cuáles son los 3 peores episodios teniendo en cuenta su rating?

select * from movies
order by rating
limit 3
offset 0;

-- 35. Obtener el listado de todos los actores. Quitar las columnas de fechas y película
-- favorita, además traducir los nombres de las columnas.

select id AS ID, first_name Nombre, last_name Apellido, rating Calificacion from actors;


/*--------------------------------------------------------------------------------------------------------------------------------------*/

-- Spotify

-- Realizar los siguientes informes:

-- 36. Listar las canciones que poseen la letra “z” en su título.

select * from cancion
where titulo like '%z%';

-- 37. Listar las canciones que poseen como segundo carácter la letra “a” y como último, la letra “s”.

select * from cancion
where titulo like '_a%s';

-- 38. Mostrar la playlist que tiene más canciones, renombrando las columnas poniendo mayúsculas en la primera letra, 
-- los tildes correspondientes y agregar los espacios entre palabras.

select idPlaylist as 'ID Playlist', idusuario 'ID Usuario', titulo 'Título', cantcanciones 'Cantidad Canciones', idestado 'ID Estado', Fechacreacion 'Fecha Creación', Fechaeliminada 'Fecha Eliminada' from playlist
order by cantcanciones desc
limit 1
offset 0;

-- 39. En otro momento se obtuvo un listado con los 5 usuarios más jóvenes, obtener un listado de los 10 siguientes.

select * from usuario
order by fecha_nac asc
limit 10
offset 5;

-- 40. Listar las 5 canciones con más reproducciones, ordenadas descendentemente.

select titulo, cantreproduccion from cancion
order by cantreproduccion desc
limit 5
offset 0;

-- 41. Generar un reporte de todos los álbumes ordenados alfabéticamente.

select * from album
order by titulo;

-- 42. Listar todos los álbumes que no tengan imagen, ordenados alfabéticamente.

select * from album
where imagenportada is null
order by titulo;

-- 43. Insertar un usuario nuevo con los siguientes datos (tener en cuenta las relaciones):
-- a) nombreusuario: nuevousuariodespotify@gmail.com
-- b) Nombre y apellido: Elmer Gomez
-- c) password: S4321m
-- d) Fecha de nacimiento: 15/11/1991
-- e) Sexo: Masculino
-- f) Código Postal: B4129ATF
-- g) País: Colombia


insert into usuario (idUsuario, nombreusuario, nyap, fecha_nac, sexo, CP, password, Pais_idPais, idTipoUsuario, FechaPassword)
values (23, 'nuevousuariodespotify@gmail.com', 'Elmer Gomez', '1991/11/15', 'M', 'B4129ATF', 'S4321m', 2, 3, null);

select * from usuario;

-- 44. Eliminar todas las canciones de género “pop”.

select * from generoxcancion;

select * from genero;

delete from generoxcancion 
where idGenero = 20;

-- 45. Editar todos los artistas que no tengan una imagen cargada y cargarles el texto “Imagen faltante” en la columna de imagen.

select * from artista;

SET SQL_SAFE_UPDATEs = 0;

update artista
set imagen = 'Imagen Faltante'
where imagen = 'Charging';


/*--------------------------------------------------------------------------------------------------------------------------------------*/


-- Ejercitación opcional III

-- Consignas (continuación)
-- Vamos a seguir practicando consultas sobre la base de datos movies. Si no
-- descargaste la base de datos, hacé clic acá. Sin más preámbulo, arranquemos con
-- el ejercicio. ¡Buena suerte! 😎👌✨
-- Consultas

-- Funciones de agregación, GROUP BY y HAVING.

-- 46. ¿Cuántas películas hay?

select count(title) AS 'Cantidad de Peliculas'from movies;

-- 47. ¿Cuántas películas tienen entre 3 y 7 premios?

select awards, count(*) AS Peliculas from movies
group by awards
having awards between 3 and 7
order by awards;

-- 48. ¿Cuántas películas tienen entre 3 y 7 premios y un rating mayor a 7?

select rating, awards, count(*) AS Peliculas from movies
group by awards, rating
having awards between 3 and 7 and rating > 7
order by rating;

-- 49. Crear un listado a partir de la tabla de películas, mostrar un reporte de la
-- cantidad de películas por id. de género.

select genre_id, count(*) AS 'Cantidad de Películas por Género' from movies
group by genre_id;

-- 50. De la consulta anterior, listar sólo aquellos géneros que tengan como suma
-- de premios un número mayor a 5.

select * from movies;

select sum(awards), genre_id, count(*) AS 'Cantidad de Películas por Género' from movies
group by awards, genre_id
having sum(awards) > 5;


/*--------------------------------------------------------------------------------------------------------------------------------------*/


-- Consultas queries XL parte I - GROUP BY

-- Vamos a practicar sobre consultas SELECT, enfocándonos en group by, having y distinct.
-- Tips:
-- - Cada enunciado se corresponde con una consulta SELECT.
-- - Recordá ir guardando las consultas. SQL.

-- Consignas
-- Clientes
-- 51) ¿Cuántos clientes existen?

select count(clienteID) AS 'Cantidad Clientes' from clientes;

-- 22) ¿Cuántos clientes hay por ciudad?

select * from clientes;

select ciudad AS Ciudad, count(*) AS 'Cantidad de Clientes por ciudad' from clientes
group by ciudad;

-- Facturas
-- 53) ¿Cuál es el total de transporte?

select round(sum(transporte)) AS 'Total Trasporte' from facturas;

-- 54) ¿Cuál es el total de transporte por EnvioVia (empresa de envío)?

select count(EnvioVia) from facturas;

-- 55) Calcular la cantidad de facturas por cliente. Ordenar descendentemente por
-- cantidad de facturas.

select clienteID, count(*) AS 'Cantidad de Facturas' from facturas
group by clienteID
order by count(*) desc;

-- 56) Obtener el Top 5 de clientes de acuerdo a su cantidad de facturas.

select clienteID, count(*) AS 'Cantidad de Facturas' from facturas
group by clienteID
order by count(*) desc
limit 5
offset 0;

-- 57) ¿Cuál es el país de envío menos frecuente de acuerdo a la cantidad de facturas?

select PaisEnvio, count(*) AS 'Cantidad de Envio por País' from facturas
group by PaisEnvio
order by count(*) asc
limit 1
offset 0;

-- 58) Se quiere otorgar un bono al empleado con más ventas. ¿Qué ID de empleado
-- realizó más operaciones de ventas?

select EmpleadoID, count(*) AS 'Cantidad de Ventas' from facturas
group by EmpleadoID
order by count(*) desc
limit 1
offset 0;

-- Factura detalle
-- 59) ¿Cuál es el producto que aparece en más líneas de la tabla Factura Detalle?

select ProductoID, count(*) from facturadetalle
group by ProductoID
order by count(*) desc;

-- 60) ¿Cuál es el total facturado? Considerar que el total facturado es la suma de
-- cantidad por precio unitario.

select sum(PrecioUnitario*Cantidad) AS 'Total Facturado' from facturadetalle;

-- 61) ¿Cuál es el total facturado para los productos ID entre 30 y 50?

select ProductoID , sum(PrecioUnitario*Cantidad) AS 'Total Facturado' from facturadetalle
group by ProductoID
having productoID between 30 and 50;

-- 62) ¿Cuál es el precio unitario promedio de cada producto?

select avg(PrecioUnitario) as 'Promedio Precio Unitario' from facturadetalle;

-- 63) ¿Cuál es el precio unitario máximo?

select max(PrecioUnitario) as 'Precio Unitario Máximo' from facturadetalle;


/*--------------------------------------------------------------------------------------------------------------------------------------*/


-- Consultas queries XL parte II - JOIN
-- En esta segunda parte vamos a intensificar la práctica de consultas con JOIN.

-- 64) Generar un listado de todas las facturas del empleado 'Buchanan'.

select facturas.FacturaID, empleados.EmpleadoID, empleados.Apellido  from facturas join empleados on empleados.EmpleadoID = facturas.EmpleadoID
where empleados.Apellido = 'Buchanan';

-- 65) Generar un listado con todos los campos de las facturas del correo 'Speedy
-- Express'.

select * from facturas join correos on correos.CorreoID = facturas.EnvioVia
where correos.Compania = 'Speedy Express'; 

-- 66) Generar un listado de todas las facturas con el nombre y apellido de los
-- empleados.

select facturas.FacturaID, empleados.Nombre, empleados.Apellido from facturas join empleados on empleados.EmpleadoID = facturas.EmpleadoID;

-- 67) Mostrar un listado de las facturas de todos los clientes “Owner” y país de envío
-- “USA”.

select facturas.FacturaID, clientes.Contacto, clientes.Titulo, facturas.PaisEnvio from facturas join clientes on clientes.ClienteID = facturas.ClienteID
where clientes.titulo = 'Owner' and facturas.PaisEnvio = 'USA';

-- 68) Mostrar todos los campos de las facturas del empleado cuyo apellido sea
-- “Leverling” o que incluyan el producto id = “42”.

select facturas.FacturaID, empleados.Apellido, facturadetalle.ProductoID from facturas join empleados on empleados.EmpleadoID = facturas.EmpleadoID join facturadetalle on facturadetalle.FacturaID = facturas.FacturaID
where empleados.Apellido = 'Leverling' or facturadetalle.ProductoID = 42;

-- 69) Mostrar todos los campos de las facturas del empleado cuyo apellido sea
-- “Leverling” y que incluya los producto id = “80” o ”42”.

select facturas.FacturaID, empleados.Apellido, facturadetalle.ProductoID from facturas join empleados on empleados.EmpleadoID = facturas.EmpleadoID join facturadetalle on facturadetalle.FacturaID = facturas.FacturaID
where empleados.Apellido = 'Leverling' and facturadetalle.ProductoID in(80, 42);


-- 70) Generar un listado con los cinco mejores clientes, según sus importes de
-- compras total (PrecioUnitario * Cantidad).

select clientes.Contacto, facturadetalle.PrecioUnitario*facturadetalle.Cantidad AS 'Importe de Compras Total'from clientes join facturas on facturas.ClienteID = clientes.ClienteID join facturadetalle on facturadetalle.FacturaID = facturas.FacturaID;

 
 select clientes.Contacto, sum(facturadetalle.PrecioUnitario*facturadetalle.Cantidad) AS 'Importe de Compras Total'from clientes join facturas on facturas.ClienteID = clientes.ClienteID join facturadetalle on facturadetalle.FacturaID = facturas.FacturaID
 group by clientes.Contacto, 'Importe de Compras Total'
 order by sum(facturadetalle.PrecioUnitario*facturadetalle.Cantidad) desc
 limit 5
 offset 0;

-- 71) Generar un listado de facturas, con los campos id, nombre y apellido del cliente,
-- fecha de factura, país de envío, Total, ordenado de manera descendente por
-- fecha de factura y limitado a 10 filas.

select facturas.FacturaID, clientes.Contacto, facturas.FechaFactura, facturas.FechaEnvio, sum(facturadetalle.Cantidad*facturadetalle.PrecioUnitario) AS 'Total'from facturas join clientes on clientes.ClienteID = facturas.ClienteID join facturadetalle on facturadetalle.FacturaID = facturas.FacturaID
group by facturas.FacturaID
order by facturas.FechaFactura desc
limit 10
offset 0;


/*--------------------------------------------------------------------------------------------------------------------------------------*/


-- Consultas movies

-- Join

-- 72. Utilizando la base de datos de movies, queremos conocer, por un lado, los
-- títulos y el nombre del género de todas las series de la base de datos.

select series.title, genres.name from series join genres on genres.id = series.genre_id;

-- 73. Por otro, necesitamos listar los títulos de los episodios junto con el nombre y
-- apellido de los actores que trabajan en cada uno de ellos.

select episodes.title AS Título, actors.first_name Nombre, actors.last_name Apellido from episodes join actor_episode on actor_episode.episode_id = episodes.id join actors on actors.id = actor_episode.actor_id;

-- 74. Para nuestro próximo desafío, necesitamos obtener a todos los actores o
-- actrices (mostrar nombre y apellido) que han trabajado en cualquier película
-- de la saga de La Guerra de las galaxias.

select actors.first_name, actors.last_name, movies.title from movies join actor_movie on actor_movie.actor_id = movies.id join actors on actors.id = actors.id
where movies.title like '%Guerra%';

-- 75. Crear un listado a partir de la tabla de películas, mostrar un reporte de la
-- cantidad de películas por nombre de género.

select genres.name, count(*) AS 'Cantidad Peliculas por Genero' from movies join genres on genres.id = movies.genre_id
group by genres.name;


/*--------------------------------------------------------------------------------------------------------------------------------------*/


-- Consultas SELECT y GROUP BY

-- Realizar los siguientes informes:

-- 76. Listar las canciones cuya duración sea mayor a 2 minutos.

select nombre, left(sum(milisegundos/60000), 3) AS 'Minutos'from canciones
group by nombre
having left(sum(milisegundos/60000), 3) > 2;

-- 77. Listar las canciones cuyo nombre comience con una vocal.

select nombre from canciones
where nombre like 'a%' or nombre like 'e%' or nombre like 'i%' or nombre like 'o%' or nombre like 'u%';

-- 78. Listar las canciones ordenadas por compositor en forma descendente.
-- Luego, por nombre en forma ascendente. Incluir únicamente aquellas
-- canciones que tengan compositor.

select compositor, nombre from canciones
where compositor is not null or compositor = ''
group by compositor, nombre
order by compositor desc;


select compositor, nombre from canciones
where compositor is not null or compositor = ''
group by compositor, nombre
order by nombre desc;

-- 79. a) Listar la cantidad de canciones de cada compositor.

select compositor, count(nombre) AS 'CANT' from canciones
group by compositor;

-- b) Modificar la consulta para incluir únicamente los compositores que
-- tengan más de 10 canciones.

select compositor, count(nombre) AS 'CANT' from canciones
group by compositor
having count(*) > 10;

-- 80. a) Listar el total facturado agrupado por ciudad.

select ciudad_de_facturacion, count(*) AS 'Cantidad de Facturas', sum(total) AS 'Total Facturado'from facturas
group by ciudad_de_facturacion;

-- b) Modificar el listado del punto (a) mostrando únicamente las ciudades
-- de Canadá.

select ciudad_de_facturacion, count(*) AS 'Cantidad de Facturas', sum(total) AS 'Total Facturado'from facturas
where pais_de_facturacion = 'Canada'
group by ciudad_de_facturacion;

-- c) Modificar el listado del punto (a) mostrando únicamente las ciudades
-- con una facturación mayor a 38.

select ciudad_de_facturacion, count(*) AS 'Cantidad de Facturas', sum(total) AS 'Total Facturado'from facturas
group by ciudad_de_facturacion
having sum(total) > 38;

-- d) Modificar el listado del punto (a) agrupando la facturación por país, y
-- luego por ciudad.

select pais_de_facturacion, ciudad_de_facturacion,count(*) AS 'Cantidad de Facturas', sum(total) AS 'Total Facturado'from facturas
group by pais_de_facturacion, ciudad_de_facturacion;

-- 81. a) Listar la duración mínima, máxima y promedio de las canciones.

select min(milisegundos/60000) AS 'Minima duración', max(milisegundos/60000) AS 'Máxima duración', avg(milisegundos/60000) AS 'Duración Promedio' from canciones;

-- b) Modificar el punto (a) mostrando la información agrupada por género.

select id_genero, count(*) AS 'Cantidad por género', min(milisegundos/60000) AS 'Minima duración', max(milisegundos/60000) AS 'Máxima duración', avg(milisegundos/60000) AS 'Duración Promedio' from canciones
group by id_genero;



/*--------------------------------------------------------------------------------------------------------------------------------------*/



-- Reportes parte I - Repasamos INNER JOIN
-- 82. Realizar una consulta de la facturación de e-market. Incluir la siguiente información:
-- ● Id de la factura
-- ● fecha de la factura
-- ● nombre de la empresa de correo
-- ● nombre del cliente
-- ● categoría del producto vendido
-- ● nombre del producto
-- ● precio unitario
-- ● cantidad

select facturas.FacturaID, facturas.FechaFactura, correos.Compania, clientes.Contacto, productos.ProductoNombre, facturadetalle.PrecioUnitario, facturadetalle.Cantidad
from clientes join facturas on facturas.ClienteID = clientes.ClienteID 
join correos on correos.CorreoID = facturas.EnvioVia 
join facturadetalle on facturadetalle.FacturaID = facturas.FacturaID 
join productos on productos.ProductoID = facturadetalle.ProductoID;


/*--------------------------------------------------------------------------------------------------------------------------------------*/


-- Reportes parte II - INNER, LEFT Y RIGHT JOIN

-- 83. Listar todas las categorías junto con información de sus productos. Incluir todas
-- las categorías aunque no tengan productos.

select categorias.CategoriaID, categorias.CategoriaNombre, categorias.CategoriaNombre , productos.CategoriaID, productos.CantidadPorUnidad, productos.PrecioUnitario from categorias left join productos on categorias.CategoriaID = productos.CategoriaID;

-- 84. Listar la información de contacto de los clientes que no hayan comprado nunca
-- en emarket.

select clientes.ClienteID, clientes.Contacto, clientes.Telefono, concat(clientes.Direccion,' ,',clientes.ciudad,' ,',clientes.Pais) AS Direccion,  facturas.ClienteID, facturas.FechaFactura
from clientes left join facturas on clientes.ClienteID = facturas.ClienteID
where facturas.ClienteID is null or facturas.ClienteID = '';

-- 85. Realizar un listado de productos. Para cada uno indicar su nombre, categoría, y
-- la información de contacto de su proveedor. Tener en cuenta que puede haber
-- productos para los cuales no se indicó quién es el proveedor.

select productos.ProductoNombre, productos.CategoriaID, productos.ProveedorID, proveedores.ProveedorID, proveedores.Contacto, proveedores.Telefono, proveedores.Fax from productos right join proveedores on productos.ProveedorID = proveedores.ProveedorID;

-- 86. Para cada categoría listar el promedio del precio unitario de sus productos.

select productos.ProductoID, avg(productos.PrecioUnitario) AS 'Promedio precio productos', facturadetalle.ProductoID, avg(facturadetalle.PrecioUnitario) AS 'Promedio total factura' from productos join facturadetalle on facturadetalle.ProductoID = productos.ProductoID
group by productos.ProductoID, facturadetalle.ProductoID;


-- 87. Para cada cliente, indicar la última factura de compra. Incluir a los clientes que
-- nunca hayan comprado en e-market.

select clientes.ClienteID, clientes.Contacto, facturas.ClienteID, max(facturas.FechaFactura) from clientes left join facturas on clientes.ClienteID = facturas.ClienteID
group by clientes.ClienteID;

-- 88. Todas las facturas tienen una empresa de correo asociada (enviovia). Generar un
-- listado con todas las empresas de correo, y la cantidad de facturas
-- correspondientes. Realizar la consulta utilizando RIGHT JOIN.


