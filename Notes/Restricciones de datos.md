# Restricciones al definir la tabla:

Se utilizan las siguientes keywords que hemos repasado en [Creación de tablas](../IISSI1/Creación%20de%20tablas.md)

1.  NOT NULL -- El valor no puede ser nulo
2.  CHECK(condicion) -- La tupla solo se introduce en la tabla si la condición se cumple  
    Ejemplo de condición: `CHECK (CHAR_LENGTH(contraseña) >= 8)`  
    Otro ejemplo: `CHECK (precio >= 0)`  
    Ejemplo con varias condiciones: `CHECK (unidades > 0 AND unidades <= 100)`

* * *

# Restricciones al introducir datos:

**Utilizamos los triggers:**  
Son trozos de código que se activan cuando ocurren ciertos eventos, podemos establecerlos para que se activen antes de introducir código y detengan la acción con un mensaje añadido si los datos que vamos a añadir no son procesables.

Normalmente se utilian para condiciones más complejas que CHECK

Aquí un ejemplo para hacer que los usuarios no tengan menos de 14 años:

```SQL
DELIMITER //
CREATE TRIGGER cliente_edad_minima BEFORE INSERT ON Clientes
FOR EACH ROW
BEGIN
    IF TIMESTAMPDIFF(YEAR, NEW.fechaNacimiento, CURDATE()) <= 14 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente debe tener más de 14 años.';
    END IF;
END //
DELIMITER ;
```

*Cosas a tener en cuenta sobre este código:*

- Establecemos un elemento delimitador diferente a `;` para designar el principio y final del trigger y poder utilizar el `;` dentro del código.
- Creamos el trigger con un nombre en este caso `cliente_edad_minima` y establecemos que se activará antes de insertar datos en la tabla `Clientes`
- Para cada tupla <ins>de lo que vayamos a insertar</ins> se comprueba lo que se establece entre `BEGIN` y `END`
- En este caso se utiliza `TIMESTAMPDIFF` establecido a años y se comprueba el campo `fechaNacimiento` en comparación a la fecha actual, si es menor que 14 se ejecuta el resto del código
- El estado de la señal indica un error
- El mensaje personalizado indica que error estamos categorizando
- Acabamos el statement si la condición no se cumple
- Cerramos el código del trigger
- Volvemos al mismo delimitador de antes

---
**Otro ejemplo:**

Esta vez necesitamos valorar una situación más compleja, no permitiremos que los usuarios menores de 18 años puedan comprar ciertos productos categorizados para mayores de edad.

```SQL
DELIMITER //
CREATE TRIGGER check_edad_minorista BEFORE INSERT ON LineasPedido
FOR EACH ROW
BEGIN
    DECLARE clienteEdad INT;
    DECLARE ventaPermitida BOOLEAN;

    SELECT TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE()) INTO clienteEdad
    FROM Clientes INNER JOIN Pedidos ON Clientes.id = Pedidos.clienteId
    WHERE Pedidos.id = NEW.pedidoId;

    SELECT puedeVenderseAMenores INTO ventaPermitida
    FROM Productos WHERE id = NEW.productoId;

    IF ventaPermitida = FALSE AND clienteEdad < 18 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente debe tener al menos 18 años para comprar este producto.';
    END IF;
END //
DELIMITER ;
```

*Consideraciones del código:*

- Como antes sea crea el trigger y se determina un nuevo delimiter
- Se declaran dos `variables`
- Se asignan las variables
- Se utilizan las variables para evaluar la condición
- Damos el error si la condición se cumple
- Acabamos el statement si la condición no se cumple
- Cerramos el código del trigger
- Volvemos al mismo delimitador de antes

---
**Anexo:**
Uso de variables

*Declaración de variables:* `DECLARE variable TIPO`
*Asignación de valores a las variables:*  
```SQL
SELECT columna INTO nombreVariable
FROM tabla WHERE condicion
```

Se detallará más adelante al ver las consultas.

Importante: consultar CONSTRAINT
