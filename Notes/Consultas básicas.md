# Consultas básicas

**SELECT**

Se utliza para extraer columnas de una tabla

```SQL
USE videojuegos;

SELECT nombre FROM videojuegos;
```

Aquí solo extraemos los nombres de todos los juegos  
<ins>*OJO*</ins> Notese que al ser la primera consulta utilizamos la keyword `USE` para definir la tabla que vamos a utilizar

```SQL
SELECT nombre, fechalanzamiento FROM videojuegos;
```
Podemos extraer varios campos con un solo select
* * *

**LIMIT**

Extraemos solo los primeros X valores extraidos

```SQL
SELECT nombre FROM videojuegos LIMIT 5;
```

En este caso por ejemplo extraemos los primeros 5 nombres

* * *

**WHERE**

Un condicional para solo extraer los valores que cumplan una condición

```SQL
SELECT nombre FROM videojuegos WHERE estado = "Beta";
```

Extraemos solo los nombres de los juegos cuyo estado es "Beta"
*Nota:* Al poner "Beta" lo ponemos entre comillas porque es una cadena de caracteres a diferencia de las keywords o de los nombres de los campos

También se pueden evaluar varias condiciones e incluso negarlas

```SQL
SELECT nombre FROM videojuegos WHERE estado != "Beta" AND precioLanzamiento >= 60;
```

Otra manera de expresar negación (Ambos hacen lo mismo):
```SQL
SELECT nombre FROM videojuegos WHERE NOT estado = "Beta" AND precioLanzamiento >= 60;
```

También pueden encapsularse los condicionales:
```SQL
SELECT nombre FROM videojuegos WHERE NOT estado = "Beta" OR (precioLanzamiento >= 60 AND precioLanzamiento <= 70);
```
---
**Encapsulación de WHERE**

Se pueden preparar subtablas que tengan información y elegir solo de esas tablas lo que entra en otras.

Por ejemplo:

```SQL
SELECT productos.id , productos.nombre
FROM productos
WHERE productos.id NOT IN (
  SELECT lineaspedido.productoId
  FROM lineasPedido
  JOIN pedidos ON lineaspedido.pedidoId = pedidos.id
  JOIN clientes ON pedidos.clienteId = clientes.id
  WHERE TIMESTAMPDIFF(YEAR, clientes.fechaNacimiento, CURDATE()) < 18
);
```

*Nótese* que dentro del IN hay un select y un where como antes

---
**HAVING**
Se utiliza para usar el *WHERE* con funciones agregadas

```SQL
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5;
```

También se puede utilizar para comparar dos tablas.
Poniendo un ejemplo más complejo de los laboratorios:

```SQL
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
```

Aquí comparamos dos tablas que hemos creado nosotros mismos.

---
**LIKE**
En caso de que queramos encontrar valores que contengan ciertos elementos.

En este ejemplo vamos a encontrar nombres de juegos que empiecen por THE

```SQL
SELECT * FROM videojuegos WHERE nombre LIKE "The%";
```

*Nota:* El símbolo % significa cualquier caracter, esto también puede devolver los juegos que empiecen por THEY por ejemplo.

Si quieres definir un solo caracter indefinido se usa `_`

```SQL
SELECT * FROM videojuegos WHERE nombre LIKE "Final fantasy __";
```

---
**ORDER BY**
Ordena la tabla en base a la columna que especifiquemos, normalmente ordena de menor a mayor

```SQL
SELECT * FROM videojuegos ORDER BY precioLanzamiento;
```

En caso de que queramos ordenar en sentido inverso solamente tenemos que establecer la keyword `DESC` después del nombre de la columna, por ejemplo:

```SQL
SELECT * FROM videojuegos ORDER BY precioLanzamiento  DESC;
```

Si dos precios de lanzamiento son identicos entonces se elegirá un valor arbitrario para ordenar uno por delante del otro, si queremos evitar esto pondremos varias columnas que ordenar, si el primer valor es identico se valorará el segundo y así relativamente:

```SQL
SELECT * FROM videojuegos ORDER BY precioLanzamiento  DESC, logros DESC;
```

Esta segunda fila se separa con una *coma* y también puede darse un orden ascendente o descendente.

---
**Funciones Agregadas**

Basicamente funciones mátematicas/calculo

Las principales son:
- COUNT - Cuenta el numero de elementos
- AVG - Hace la media de elementos
- MIN - Devuelve el minimo valor
- MAX - Devuelve el máximo valor
- SUM - Suma los elementos

Se aplican sobre las columnas, por ejemplo:
```SQL
SELECT AVG(precioLanzamiento) FROM videojuegos;
```

Encuentra el precio promedio de todos los videojuegos.

Evidentemente aquí también se pueden filtrar resultados:

```SQL
SELECT AVG(precioLanzamiento) FROM videojuegos WHERE logros > 10;
```

---
**DISTINCT**
Cuenta todos los elementos que tengan el mismo valor como el mismo, por ejemplo si queremos saber cuantos tipos de estados existen en la tabla utilizaríamos:

```SQL
SELECT COUNT(DISTINCT estado) FROM videojuegos;
```

---
**AS**

Simplemente para dar un nombre personalizado a la presentación:

```SQL
SELECT AVG(precioLanzamiento) AS "NombrePersonalizado" FROM videojuegos;
```

---
**GROUP BY**

Hace que las funciones agregadas se separen por grupos, por ejemplo si queremos saber la media de notas por alumno, en vez de la media de notas generales de todos los alumnos.

Número de productos pedidos por cada pedido:

```SQL
SELECT pedidoId,COUNT(unidades) FROM lineaspedido GROUP BY pedidoId;
```

---
**Operaciones con tiempo**

Para extraer la edad de un cliente con una fecha de nacimiento dada:

```SQL
WHERE TIMESTAMPDIFF(YEAR, Clientes.fechaNacimiento, pedidos.fechaRealizacion) >= 18;
```

Ese sería el filtro para comprobar que solo se valoran los clientes que tienen más de 18 años de edad a la hora de realizar el pedido.