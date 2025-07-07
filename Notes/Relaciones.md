Conceptos basicos:
-
**Claves primarias**
Campo con un valor único capaz de representar la tupla

**Claves foraneas**
Campos relacionales entre tablas

---
SubQuerys
-
Basicamente suponiendo que tenemos dos tablas conectadas, podemos seleccionar datos de una con la información que obtengamos de otra tabla.

*En este ejemplo utilizaremos las tablas del laboratiorio 4*

Aquí extraemos los productos digitales sin necesidad de saber que id de `tipoProducto` es la que representa los tipos digitales

```SQL
SELECT nombre FROM productos WHERE tipoProductoId = (
	SELECT id FROM tiposproducto WHERE nombre = "Digitales");
```

*Nótese que utilizamos dos tablas*

---
JOIN
-
Utilizado para unir tablas, en nuestro caso se utiliza bastante, simplemente hace falta asociar las claves foraneas, por defecto se va añadiendo por la "Derecha".
Si se quiere hacer a la inversa se hace un `LEFT JOIN`

En este ejemplo asociamos las tablas de pedidos con la de ususarios para extraer la dirección de cada usuario:

```SQL
SELECT pedidos.direccionEntrega, usuarios.nombre FROM pedidos JOIN usuarios ON usuarios.id = pedidos.clienteId
```

Atención a la palabra **ON** que se encarga de asociar las claves.

**Tipos de JOIN**
Existen 4 tipos de JOIN, se utilizan en base a que queremos dejar en la tabla.

- `LEFT JOIN` - Por defecto
![8c55e8533c61731ce582975b6f6f9e24.png](../_resources/8c55e8533c61731ce582975b6f6f9e24.png)
- `RIGHT JOIN`
![fcf33547ea66e05f48d07ba7c0043b03.png](../_resources/fcf33547ea66e05f48d07ba7c0043b03.png)
- `INNER JOIN`
![e033eabb65ecaba448823945826e63e0.png](../_resources/e033eabb65ecaba448823945826e63e0.png)
- `FULL JOIN`
![f34be1a292ef8134dc9a5a1d2d88a7cf.png](../_resources/f34be1a292ef8134dc9a5a1d2d88a7cf.png)

  SI la tabla que tiene prioridad no tiene nada en el otro lado se llena con NULL