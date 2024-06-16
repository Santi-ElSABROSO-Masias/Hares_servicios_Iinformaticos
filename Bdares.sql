CREATE DATABASE Bdares;
GO

USE Bdares;
GO

-- Crear tabla Usuarios con diferenciación de tipos de usuario
CREATE TABLE Usuarios (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Teléfono NVARCHAR(15),
    Contraseña NVARCHAR(100) NOT NULL,
    TipoUsuario NVARCHAR(20) NOT NULL CHECK (TipoUsuario IN ('Cliente', 'Administrador'))
);

-- Crear tabla Productos con relación recursiva
CREATE TABLE Productos (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Descripción NVARCHAR(500),
    Precio DECIMAL(18, 2) NOT NULL,
    Stock INT NOT NULL,
    ProductoPadreID INT NULL FOREIGN KEY REFERENCES Productos(ID) -- Relación recursiva
);

-- Crear tabla Pedidos referenciando a Usuarios en lugar de Clientes
CREATE TABLE Pedidos (
    ID INT PRIMARY KEY IDENTITY(1,1),
    UsuarioID INT FOREIGN KEY REFERENCES Usuarios(ID), -- Cambio de ClienteID a UsuarioID
    Fecha DATETIME NOT NULL
);

-- Crear tabla DetallesPedido referenciando a Pedidos y Productos
CREATE TABLE DetallesPedido (
    ID INT PRIMARY KEY IDENTITY(1,1),
    PedidoID INT FOREIGN KEY REFERENCES Pedidos(ID),
    ProductoID INT FOREIGN KEY REFERENCES Productos(ID),
    Cantidad INT NOT NULL,
    Precio DECIMAL(18, 2) NOT NULL
);

-- Crear tabla Servicios
CREATE TABLE Servicios (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Descripción NVARCHAR(500) NOT NULL,
    Precio DECIMAL(18, 2) NOT NULL
);

-- Crear tabla ServiciosUsuario referenciando a Usuarios y Servicios
CREATE TABLE ServiciosUsuario (
    ID INT PRIMARY KEY IDENTITY(1,1),
    UsuarioID INT FOREIGN KEY REFERENCES Usuarios(ID), -- Cambio de ClienteID a UsuarioID
    ServicioID INT FOREIGN KEY REFERENCES Servicios(ID),
    Fecha DATETIME NOT NULL,
    DescuentoAplicado BIT NOT NULL
);

-- Crear tabla Descuentos referenciando a Usuarios en lugar de Clientes
CREATE TABLE Descuentos (
    ID INT PRIMARY KEY IDENTITY(1,1),
    UsuarioID INT FOREIGN KEY REFERENCES Usuarios(ID), -- Cambio de ClienteID a UsuarioID
    Porcentaje DECIMAL(5, 2) NOT NULL
);
