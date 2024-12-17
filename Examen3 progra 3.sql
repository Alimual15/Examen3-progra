-- Crear la base de datos
CREATE DATABASE ConstructoraUH;
GO

-- Usar la base de datos
USE ConstructoraUH;
GO

-- Crear la tabla Categorías Laborales
CREATE TABLE CategoriasLaborales (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(20) NOT NULL UNIQUE
);
GO

-- Crear la tabla Proyectos
CREATE TABLE Proyectos (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Codigo VARCHAR(50) NOT NULL UNIQUE,
    Nombre VARCHAR(100) NOT NULL,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NULL
);
GO

-- Crear la tabla Empleados
CREATE TABLE Empleados (
    Id INT PRIMARY KEY IDENTITY(1,1),
    CarnetUnico VARCHAR(50) NOT NULL UNIQUE,
    NombreCompleto VARCHAR(100) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Direccion VARCHAR(255) DEFAULT 'San José',
    Telefono VARCHAR(15) NOT NULL,
    CorreoElectronico VARCHAR(100) NOT NULL UNIQUE, 
	Salario DECIMAL(10, 2) NOT NULL CHECK (Salario >= 250000 AND Salario <= 500000),
    CategoriaLaboralId INT NOT NULL,
    FOREIGN KEY (CategoriaLaboralId) REFERENCES CategoriasLaborales(Id)
);
GO

-- Crear la tabla Asignaciones
CREATE TABLE Asignaciones (
    Id INT PRIMARY KEY IDENTITY(1,1),
    EmpleadoId INT NOT NULL,
    ProyectoId INT NOT NULL,
    FechaAsignacion DATE NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (EmpleadoId) REFERENCES Empleados(Id) ON DELETE CASCADE,
    FOREIGN KEY (ProyectoId) REFERENCES Proyectos(Id) ON DELETE CASCADE
);
GO

-- Insertar datos de ejemplo en la tabla Categorías Laborales
INSERT INTO CategoriasLaborales (Nombre)
VALUES 
('Administrador'),
('Operario'),
('Peón');
GO

-- Insertar datos de ejemplo en la tabla Empleados
INSERT INTO Empleados (CarnetUnico, NombreCompleto, FechaNacimiento, Telefono, CorreoElectronico, Salario, CategoriaLaboralId)
VALUES 
('C001', 'Juan Pérez', '1985-05-15', '8888-1234', 'juan.perez@constructora.com', 300000, 2),
('C002', 'María López', '1990-08-20', '8888-5678', 'maria.lopez@constructora.com', 400000, 1),
('C003', 'Carlos García', '1995-12-30', '8888-9101', 'carlos.garcia@constructora.com', 250000, 3);
GO

-- Insertar datos de ejemplo en la tabla Proyectos
INSERT INTO Proyectos (Codigo, Nombre, FechaInicio, FechaFin)
VALUES 
('P001', 'Construcción Edificio A', '2023-01-01', NULL),
('P002', 'Rehabilitación Parque Central', '2023-02-15', '2023-06-30'),
('P003', 'Construcción Puente B', '2023-03-01', NULL);
GO

-- Insertar datos de ejemplo en la tabla Asignaciones
INSERT INTO Asignaciones (EmpleadoId, ProyectoId, FechaAsignacion)
VALUES 
(1, 1, '2023-01-05'),
(2, 1, '2023-01-10'),
(1, 2, '2023-02-20'),
(3, 2, '2023-03-01'),
(2, 3, '2023-03-15');
GO