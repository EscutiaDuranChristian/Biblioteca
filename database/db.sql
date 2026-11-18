create database biblioteca;
use biblioteca;

-- Personal que usa el sistema (login y roles)
create table bibliotecarios (
    id_bibliotecario int primary key auto_increment,
    nombre_completo varchar(100) not null,
    usuario varchar(50) not null unique,
    password_hash varchar(255) not null,
    rol enum('administrador','operador','consulta') not null,
    estado enum('activo','inactivo') not null default 'activo'
);

-- Lectores que piden prestado
create table alumnos (
    id_alumno int primary key auto_increment,
    nombre_completo varchar(100) not null,
    matricula varchar(30) not null unique,
    estado enum('activo','suspendido') not null default 'activo'
);

-- Datos bibliograficos de la obra
create table libros (
    id_libro int primary key auto_increment,
    titulo varchar(200) not null,
    autor varchar(100) not null,
    categoria varchar(60) not null
);

-- Copia fisica con etiqueta de codigo de barras
create table ejemplares (
    id_ejemplar int primary key auto_increment,
    codigo_barras varchar(50) not null unique,
    id_libro int not null,
    estado enum('disponible','prestado') not null default 'disponible',
    foreign key (id_libro) references libros(id_libro)
);

-- Un prestamo = un ejemplar prestado a un alumno
create table prestamos (
    id_prestamo int primary key auto_increment,
    id_alumno int not null,
    id_ejemplar int not null,
    id_bibliotecario int not null,
    fecha_prestamo datetime not null default current_timestamp,
    fecha_limite date not null,
    fecha_devolucion datetime,
    foreign key (id_alumno) references alumnos(id_alumno),
    foreign key (id_ejemplar) references ejemplares(id_ejemplar),
    foreign key (id_bibliotecario) references bibliotecarios(id_bibliotecario)
);

-- Llenada por los triggers de auditoria
create table auditoria (
    id_auditoria int primary key auto_increment,
    tabla varchar(64) not null,
    operacion varchar(10) not null,
    fecha_hora datetime not null default current_timestamp,
    usuario varchar(100) not null,
    datos_anteriores text,
    datos_nuevos text
);
