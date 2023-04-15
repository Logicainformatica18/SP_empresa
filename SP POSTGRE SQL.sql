-- CREANDO LA BASE DE DATOS
CREATE DATABASE PUBLICACIONES;
SET search_path = PUBLICACIONES;
-- CREANDO LAS TABLAS
CREATE TABLE CURSO(
COD_CURSO INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
NOMBRE VARCHAR(50),
DESCRIPCION VARCHAR(50)
);
CREATE TABLE PUBLICACION(
COD_PUBLICACION INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
COD_CURSO INT,
FOREIGN KEY(COD_CURSO) REFERENCES CURSO(COD_CURSO),
TITULO VARCHAR(50),
SEMANA VARCHAR(2),
FECHA DATE
);


CREATE TABLE USUARIO(
    COD_USUARIO INT PRIMARY KEY IDENTITY,
    NOMBRE VARCHAR(50) NOT NULL,
    PASSWORD VARCHAR(100)
);

-- CRUD
-- C INSERT
-- R SELECT
-- U UPDATE
-- D DELETE

-- C INSERT
CREATE FUNCTION Usuario_Insert(
	in nombre_in varchar(50),
	in password_in varchar(100)
	)
	RETURNS void AS $$
     BEGIN
        insert into usuario(nombre,password)
		values
		(nombre_in,password_in);
    END;
$$ LANGUAGE plpgsql;
-- EJECUTAR 
select usuario_insert('anthony','1234');



-- R SELECT


-- U UPDATE
CREATE OR REPLACE FUNCTION usuario_update(
in cod_usuario_in int,
in nombre_in varchar(50),
in password_in varchar(100)
)
RETURNS void as $$
BEGIN
   Update  usuario set
   nombre = nombre_in,
   password = password_in
   WHERE cod_usuario = cod_usuario_in;
END;
$$ LANGUAGE plpgsql;
-- EJECUTAR 
select usuario_update(1,'anthony','casa');

-- D DELETE

CREATE OR REPLACE FUNCTION usuario_delete(
in cod_usuario_in int
)
RETURNS void as $$
BEGIN
   DELETE FROM usuario
        WHERE cod_usuario = cod_usuario_in;
END;
$$ LANGUAGE plpgsql;
-- EJECUTAR SP
select usuario_delete(1)



-- SP USUARIO LOGIN




