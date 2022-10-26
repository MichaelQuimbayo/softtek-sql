CREATE TABLE IF NOT EXISTS `rol`(
`id` INT AUTO_INCREMENT NOT NULL,
`rol` VARCHAR(255) NOT NULL,
`state` BIT(1) NOT NULL,
-- `state` smallint(1),
 -- `deleted` tinyint(1),
 PRIMARY KEY(`id`),
 INDEX `initial_rol_idx`(`rol` ASC)
);



       
CREATE TABLE IF NOT EXISTS `user`(
`id` INT AUTO_INCREMENT NOT NULL,
`name` VARCHAR(255) NOT NULL,
`lastname` VARCHAR(255) NOT NULL,
`email` VARCHAR(255) NOT NULL,
`password` VARCHAR(255) NOT NULL,
`state` BIT(1) NOT NULL,
`created_by` VARCHAR(255) NOT NULL DEFAULT "SYSTEM",
`created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
`updated_at` DATETIME  NULL,
`rol_id` INT NOT NULL,
-- `state` smallint(1),
 -- `deleted` tinyint(1),
 PRIMARY KEY(`id`),
 INDEX `initial_state_idx`(`state` ASC),
 INDEX `initial_email_idx`(`email` ASC),
 CONSTRAINT `rol_id`
 FOREIGN KEY(`rol_id`)
 REFERENCES `rol` (`id`)

);


INSERT INTO rol  (rol, state)
VALUES ('ADMINISTRADOR',1),
       ('VEHICULOS',1),
       ('VENTAS',1),
       ('ASESOR', 1),
       ('BODEGA',1),
       ('NOMINA',1),
       ('LOGISTICA',1);
       
INSERT INTO user  (name, lastname, email, password, state, rol_id )
VALUES ('Michael', 'Quimbayo', 'maicol@hotmail.com', 'f11a9319730f63cc03056457b32a9511', 1, 1 ),
('Jeisson', 'Andrade', 'jeisson@hotmail.com', 'ec3d5a1f2e787f7fdf615759bef3d836', 1, 2 );
 
-- CONSULTA REGISTRO MES OCTUBRE
SELECT * FROM `user` WHERE month (created_at) = 10 AND YEAR(created_at) = 2022;

-- MOSTRA LA CANTIDAD DE USUARIOS POR ROL
SELECT rol.rol AS nombre_rol, COUNT(*) AS cantidad FROM user LEFT JOIN rol ON user.rol_id = rol.id GROUP BY rol.rol;

-- Mostrar el identificador del usuario y concatenar nombre y apellido, esta
lista debe estar organizada de manera alfabética
SELECT CONCAT(id, ' ', name, ' ', lastname) FROM user ORDER BY name ASC;


-- CREAR VISTAS DE USUARIO POR ROL
CREATE VIEW cantidad_usuarios_rol AS SELECT rol.rol AS nombre_rol, COUNT(*) AS cantidad FROM user LEFT JOIN rol ON user.rol_id = rol.id GROUP BY rol.rol;
-- ---------------------------
CREATE VIEW indentidad_nombres_user AS SELECT CONCAT(id, ' ', name, ' ', lastname) FROM user ORDER BY name ASC;
-- ---------------------------
CREATE VIEW registros_mes_osctubre AS SELECT * FROM `user` WHERE month (created_at) = 10 AND YEAR(created_at) = 2022;

-- Genere un procedimiento almacenado que permita insertar nuevos usuarios.
CREATE PROCEDURE crear_usuario (IN name_in VARCHAR(255), IN lastname_in VARCHAR(255), IN email_in VARCHAR(255), IN password_in VARCHAR(255), IN state_in BIT(1), IN rol_id_in INT)
BEGIN
INSERT INTO user  (name, lastname, email, password, state, rol_id )
VALUES (name_in, lastname_in, email_in, password_in, state_in, rol_id_in );
END;

CALL crear_usuario('Juan', 'Quintero', 'juanq@gmail.com', '11a9319730f63cc03056475b32a9511', 1, 2);