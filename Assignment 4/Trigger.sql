#Diseña un trigger llamado limitar_cantidad_por_cliente que imponga un límite dinámico en la cantidad total de unidades permitidas en un pedido. El límite dependerá del historial de compras del cliente:
#
#    Si el cliente tiene menos de 10 pedidos, el límite será fijo: 200 unidades por pedido.
#    Si el cliente tiene 10 o más pedidos, el límite será el doble de la media de unidades por pedido de ese cliente.
#
#El trigger debe ejecutarse antes de insertar una nueva línea de pedido en la tabla LineasPedido. Si la cantidad total de unidades del pedido supera el límite calculado para el cliente, se debe lanzar un error con un mensaje adecuado.
#
#Inserte los datos que considere adecuados para probar que el trigger se comporta adecuadamente.

DROP TRIGGER IF EXISTS limitar_cantidad_por_cliente;

DELIMITER //

CREATE TRIGGER limitar_cantidad_por_cliente BEFORE INSERT ON lineaspedido

FOR EACH ROW
BEGIN
	DECLARE pedidosRealizados INT;
	DECLARE nuevoLimite INT;
	DECLARE unidadesPedidasPedidoActual INT;
	
    #Nota: Se pueden utilizar variables en los where
	SELECT COUNT(DISTINCT pedidos.id) INTO pedidosRealizados
	FROM pedidos
	WHERE pedidos.clienteId IN(
		SELECT pedidos.clienteId
		FROM pedidos
		WHERE pedidos.id = NEW.pedidoId
	);
	
	SELECT AVG(lineaspedido.unidades) INTO nuevoLimite
	FROM lineaspedido
	JOIN pedidos ON lineaspedido.pedidoId = pedidos.id
	WHERE pedidos.clienteId IN(
		SELECT pedidos.clienteId
		FROM pedidos
		WHERE pedidos.id = NEW.pedidoId
	);
	
	SELECT SUM(lineaspedido.unidades) INTO unidadesPedidasPedidoActual
	FROM lineaspedido
	WHERE lineaspedido.pedidoId = NEW.pedidoId;
	
	IF pedidosRealizados < 10 AND unidadesPedidasPedidoActual + NEW.unidades > 200 THEN
	SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'No se pueden pedir tantas unidades';
   END IF;
   
   IF pedidosRealizados >= 10 AND unidadesPedidasPedidoActual + NEW.unidades > nuevoLimite THEN
	SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'No se pueden pedir tantas unidades';
      
   END IF;
   
END //

DELIMITER ;