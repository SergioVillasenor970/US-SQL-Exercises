DROP DATABASE IF EXISTS Videojuegos;
CREATE DATABASE Videojuegos ;
USE Videojuegos;

DROP TABLE if EXISTS  Progresos;
DROP TABLE if EXISTS  Jugadores;
DROP TABLE if EXISTS  Videojuegos;


CREATE TABLE Videojuegos(
	videojuegoId INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	nombre VARCHAR(80) NOT NULL,
	fechaLanzamiento DATE,
	logros INT,
	estado ENUM('Lanzado', 'Beta', 'Acceso anticipado'),
	precioLanzamiento DOUBLE
);

CREATE TABLE Jugadores(
	jugadorId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nickname VARCHAR(60) NOT NULL
);

INSERT INTO Videojuegos(nombre, fechaLanzamiento,logros, estado,precioLanzamiento) VALUES ('The Legend of Zelda: Breath of the Wild', '2017-03-03', 76, 'Lanzado', 69.99);
INSERT INTO Videojuegos(nombre, fechaLanzamiento,logros, estado,precioLanzamiento) VALUES ('The Legend of Zelda: Tears of the Kingdom', '2023-05-12', 139, 'Lanzado', 79.99);
INSERT INTO Videojuegos(nombre, fechaLanzamiento,logros, estado,precioLanzamiento) VALUES ('Maniac Mansion', '1987-01-01', 1, 'Lanzado', 49.98);
INSERT INTO Videojuegos(nombre, fechaLanzamiento,logros, estado,precioLanzamiento) VALUES ('Horizon: Zero Dawn', '2017-02-28', 31, 'Lanzado', 79.99);
INSERT INTO Videojuegos(nombre, fechaLanzamiento,logros, estado,precioLanzamiento) VALUES ('Super Metroid', '1994-04-28', 1, 'Lanzado', 69.99);
INSERT INTO Videojuegos(nombre, fechaLanzamiento,logros, estado,precioLanzamiento) VALUES ('Final Fantasy IX', '2001-02-16', 9, 'Lanzado', 69.99);
INSERT INTO Videojuegos(nombre, fechaLanzamiento,logros, estado,precioLanzamiento) VALUES ('Pokemon Rojo', '1999-11-01', 151, 'Lanzado', 49.98);
INSERT INTO Videojuegos(nombre, fechaLanzamiento,logros, estado,precioLanzamiento) VALUES ('Pokemon Amarillo', '2000-06-16', 155, 'Lanzado', 49.98);
INSERT INTO Videojuegos(nombre, fechaLanzamiento,logros, estado,precioLanzamiento) VALUES ('Pokemon Beige Clarito', '2023-12-15', 3, 'Beta', 2000000);


INSERT INTO Jugadores(nickname) VALUES ('Currito92');
INSERT INTO Jugadores(nickname) VALUES ('MariTrini67');
INSERT INTO Jugadores(nickname) VALUES ('IISSI_USER');
INSERT INTO Jugadores(nickname) VALUES ('Samus');
INSERT INTO Jugadores(nickname) VALUES ('Aran');