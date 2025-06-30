# Creación de tablas básicas:

**Paso 1:**
Elminación de las tablas que vamos a crear se hace para que no se intente crear tablas que ya existen, primero se eliminan:

```SQL
DROP TABLE if EXISTS  Videojuegos;
```

**Paso 2:**
Vamos a utilizar la tabla videojuegos para este ejemplo en concreto.
Ahora crearemos la tabla que acabamos de eliminar

```SQL
CREATE TABLE Videojuegos(
	videojuegoId INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	nombre VARCHAR(80) NOT NULL,
	fechaLanzamiento DATE,
	logros INT,
	estado ENUM('Lanzado', 'Beta', 'Acceso anticipado'),
	precioLanzamiento DOUBLE
);
```


---
**Valores a tener en cuenta:**

1. AUTO_INCREMENT -- Hace que el valor aumente a medida que se van creado entradas en la tabla
2. PRIMARY KEY -- Esta columna define por si sola esta tupla de las demás
3. NOT NULL -- El valor no puede ser nulo
4. ENUM -- El tipo es una de muchas cadenas ya definidas
5. CHECK(condicion) -- La tupla solo se introduce en la tabla si la condición se cumple
	Ejemplo de condición: `CHECK (CHAR_LENGTH(contraseña) >= 8)`
	Otro ejemplo: `CHECK (precio >= 0)`
	Ejemplo con varias condiciones: `CHECK (unidades > 0 AND unidades <= 100)`

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

```
SELECT AVG(precioLanzamiento) AS "NombrePersonalizado" FROM videojuegos;
```

---
**GROUP BY**

Hace que las funciones agregadas se separen por grupos, por ejemplo si queremos saber la media de notas por alumno, en vez de la media de notas generales de todos los alumnos.

Número de productos pedidos por cada pedido:

```SQL
SELECT pedidoId,COUNT(unidades) FROM lineaspedido GROUP BY pedidoId;
```