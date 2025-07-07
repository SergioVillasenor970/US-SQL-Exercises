# Creación de tablas básicas:

**Paso 1:**
Elminación de las tablas que vamos a crear se hace para que no se intente crear tablas que ya existen, primero se eliminan:

```SQL
DROP TABLE IF EXISTS  Videojuegos;
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

---
**Declaración de claves foraneas**

Utilizaremos de ejemplo la base de datos de la tienda online.

```SQL
CREATE TABLE Empleados (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuarioId INT NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (usuarioId) REFERENCES Usuarios(id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);
```

