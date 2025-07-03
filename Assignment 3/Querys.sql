#Basic Querys:
#1:

SELECT nombre, email FROM usuarios;

#2:

SELECT usuarios.nombre, empleados.salario
FROM empleados
JOIN usuarios ON empleados.usuarioId = usuarios.id;

#3:

SELECT * FROM productos
WHERE productos.precio >= 20.00;

#4:

SELECT usuarios.nombre, direccionEnvio, codigoPostal, fechaNacimiento
FROM clientes
JOIN usuarios ON clientes.usuarioId = usuarios.id;

#Querys with added functions
#1:

SELECT AVG(salario) FROM empleados;

#2:

SELECT tiposproducto.nombre, COUNT(productos.nombre)
FROM productos
JOIN tiposproducto ON productos.tipoProductoId = tiposproducto.id
GROUP BY tipoProductoId;

#3:

SELECT Usuarios.nombre AS cliente, Pedidos.fechaRealizacion 
FROM Pedidos 
JOIN Clientes ON Pedidos.clienteId = Clientes.id 
JOIN Usuarios ON Clientes.usuarioId = Usuarios.id;
#NOTA: Cuidado con las asociaciones directas, hacen falta dos asociaciones porque la tabla pedidos nos da el IdCliente y luego desde Clientes tenemos que sacar el nombre en la tabla usuarios

#4:

SELECT usuarios.nombre, COUNT(DISTINCT productos.id)
FROM lineaspedido
JOIN productos ON lineaspedido.productoId = productos.id
JOIN pedidos ON lineaspedido.pedidoId = pedidos.id
JOIN clientes ON pedidos.clienteId = clientes.id
JOIN usuarios ON clientes.usuarioId = usuarios.id
GROUP BY usuarios.nombre
ORDER BY COUNT(DISTINCT productos.id)
LIMIT 1;

#Querys with filters
#1:

SELECT usuarios.nombre
FROM pedidos
JOIN clientes ON pedidos.clienteId = clientes.id
JOIN usuarios ON clientes.usuarioId = usuarios.id
WHERE TIMESTAMPDIFF(YEAR, Clientes.fechaNacimiento, pedidos.fechaRealizacion) >= 18;

#2:

SELECT pr.id AS producto_id, pr.nombre
FROM Productos pr
WHERE pr.id NOT IN (
  SELECT lp.productoId
  FROM LineasPedido lp
  JOIN Pedidos p ON lp.pedidoId = p.id
  JOIN Clientes c ON p.clienteId = c.id
  WHERE TIMESTAMPDIFF(YEAR, c.fechaNacimiento, CURDATE()) < 18
);

#3:

SELECT pedidos.id, productos.nombre, lineaspedido.unidades
FROM lineaspedido
JOIN pedidos ON lineaspedido.pedidoId = pedidos.id
JOIN productos ON lineaspedido.productoId = productos.id;

#4:

SELECT productos.nombre, productos.precio
FROM productos
WHERE (productos.puedeVenderseAMenores = FALSE);

#5:

SELECT usuarios.id
FROM lineaspedido
JOIN productos ON lineaspedido.productoId = productos.id
JOIN pedidos ON lineaspedido.pedidoId = pedidos.id
JOIN usuarios ON pedidos.clienteId = usuarios.id
HAVING (

SELECT SUM(lineaspedido.unidades)
FROM lineaspedido
JOIN productos ON lineaspedido.productoId = productos.id
JOIN pedidos ON lineaspedido.pedidoId = pedidos.id
JOIN usuarios ON pedidos.clienteId = usuarios.id
WHERE (productos.puedeVenderseAMenores = FALSE)) > (

SELECT SUM(lineaspedido.unidades)
FROM lineaspedido
JOIN productos ON lineaspedido.productoId = productos.id
JOIN pedidos ON lineaspedido.pedidoId = pedidos.id
JOIN usuarios ON pedidos.clienteId = usuarios.id
WHERE (productos.puedeVenderseAMenores = TRUE));