CREATE DATABASE PDV;
DROP DATABASE PDV;
USE PDV;
USE [master];

IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [AspNetRoles] (
    [Id] nvarchar(450) NOT NULL,
    [Name] nvarchar(256) NULL,
    [NormalizedName] nvarchar(256) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoles] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [AspNetUsers] (
    [Id] nvarchar(450) NOT NULL,
    [Nombre] nvarchar(max) NOT NULL,
    [UserName] nvarchar(256) NULL,
    [NormalizedUserName] nvarchar(256) NULL,
    [Email] nvarchar(256) NULL,
    [NormalizedEmail] nvarchar(256) NULL,
    [EmailConfirmed] bit NOT NULL,
    [PasswordHash] nvarchar(max) NULL,
    [SecurityStamp] nvarchar(max) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    [PhoneNumber] nvarchar(max) NULL,
    [PhoneNumberConfirmed] bit NOT NULL,
    [TwoFactorEnabled] bit NOT NULL,
    [LockoutEnd] datetimeoffset NULL,
    [LockoutEnabled] bit NOT NULL,
    [AccessFailedCount] int NOT NULL,
    CONSTRAINT [PK_AspNetUsers] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Categorias] (
    [Id] int NOT NULL IDENTITY,
    [Nombre] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Categorias] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Clientes] (
    [Id] int NOT NULL IDENTITY,
    [Nombre] nvarchar(max) NOT NULL,
    [Direccion] nvarchar(max) NOT NULL,
    [Telefono] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Clientes] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Mesas] (
    [Id] int NOT NULL IDENTITY,
    [Estado] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Mesas] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Reportes] (
    [Id] int NOT NULL IDENTITY,
    [FechaInicio] datetime2 NOT NULL,
    [FechaFin] datetime2 NOT NULL,
    CONSTRAINT [PK_Reportes] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [AspNetRoleClaims] (
    [Id] int NOT NULL IDENTITY,
    [RoleId] nvarchar(450) NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserClaims] (
    [Id] int NOT NULL IDENTITY,
    [UserId] nvarchar(450) NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserLogins] (
    [LoginProvider] nvarchar(450) NOT NULL,
    [ProviderKey] nvarchar(450) NOT NULL,
    [ProviderDisplayName] nvarchar(max) NULL,
    [UserId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey]),
    CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [AspNetUserRoles] (
    [UserId] nvarchar(450) NOT NULL,
    [RoleId] nvarchar(450) NOT NULL,
    [UsuarioId] nvarchar(450) NULL,
    CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId]),
    CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UsuarioId] FOREIGN KEY ([UsuarioId]) REFERENCES [AspNetUsers] ([Id])
);
GO

CREATE TABLE [AspNetUserTokens] (
    [UserId] nvarchar(450) NOT NULL,
    [LoginProvider] nvarchar(450) NOT NULL,
    [Name] nvarchar(450) NOT NULL,
    [Value] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
    CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [Productos] (
    [Id] int NOT NULL IDENTITY,
    [Codigo] nvarchar(max) NOT NULL,
    [Nombre] nvarchar(max) NOT NULL,
    [Precio] decimal(18,2) NOT NULL,
    [CategoriaId] int NOT NULL,
    CONSTRAINT [PK_Productos] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Productos_Categorias_CategoriaId] FOREIGN KEY ([CategoriaId]) REFERENCES [Categorias] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [Facturas] (
    [Id] int NOT NULL IDENTITY,
    [Fecha] datetime2 NOT NULL,
    [Total] decimal(18,2) NOT NULL,
    [MesaId] int NULL,
    CONSTRAINT [PK_Facturas] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Facturas_Mesas_MesaId] FOREIGN KEY ([MesaId]) REFERENCES [Mesas] ([Id])
);
GO

CREATE TABLE [Inventarios] (
    [Id] int NOT NULL IDENTITY,
    [ProductoId] int NOT NULL,
    [Cantidad] int NOT NULL,
    CONSTRAINT [PK_Inventarios] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Inventarios_Productos_ProductoId] FOREIGN KEY ([ProductoId]) REFERENCES [Productos] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [Ventas] (
    [Id] int NOT NULL IDENTITY,
    [ClienteId] int NOT NULL,
    [UsuarioId] nvarchar(450) NOT NULL,
    [Total] decimal(18,2) NOT NULL,
    [MetodoPago] nvarchar(max) NOT NULL,
    [Fecha] datetime2 NOT NULL,
    [FacturaId] int NOT NULL,
    [MesaId] int NULL,
    CONSTRAINT [PK_Ventas] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Ventas_AspNetUsers_UsuarioId] FOREIGN KEY ([UsuarioId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Ventas_Clientes_ClienteId] FOREIGN KEY ([ClienteId]) REFERENCES [Clientes] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Ventas_Facturas_FacturaId] FOREIGN KEY ([FacturaId]) REFERENCES [Facturas] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Ventas_Mesas_MesaId] FOREIGN KEY ([MesaId]) REFERENCES [Mesas] ([Id])
);
GO

CREATE TABLE [Pagos] (
    [Id] int NOT NULL IDENTITY,
    [VentaId] int NOT NULL,
    [Monto] decimal(18,2) NOT NULL,
    [Fecha] datetime2 NOT NULL,
    CONSTRAINT [PK_Pagos] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Pagos_Ventas_VentaId] FOREIGN KEY ([VentaId]) REFERENCES [Ventas] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [VentaProductos] (
    [VentaId] int NOT NULL,
    [ProductoId] int NOT NULL,
    [Cantidad] int NOT NULL,
    CONSTRAINT [PK_VentaProductos] PRIMARY KEY ([VentaId], [ProductoId]),
    CONSTRAINT [FK_VentaProductos_Productos_ProductoId] FOREIGN KEY ([ProductoId]) REFERENCES [Productos] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_VentaProductos_Ventas_VentaId] FOREIGN KEY ([VentaId]) REFERENCES [Ventas] ([Id]) ON DELETE CASCADE
);
GO

CREATE INDEX [IX_AspNetRoleClaims_RoleId] ON [AspNetRoleClaims] ([RoleId]);
GO

CREATE UNIQUE INDEX [RoleNameIndex] ON [AspNetRoles] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL;
GO

CREATE INDEX [IX_AspNetUserClaims_UserId] ON [AspNetUserClaims] ([UserId]);
GO

CREATE INDEX [IX_AspNetUserLogins_UserId] ON [AspNetUserLogins] ([UserId]);
GO

CREATE INDEX [IX_AspNetUserRoles_RoleId] ON [AspNetUserRoles] ([RoleId]);
GO

CREATE INDEX [IX_AspNetUserRoles_UsuarioId] ON [AspNetUserRoles] ([UsuarioId]);
GO

CREATE INDEX [EmailIndex] ON [AspNetUsers] ([NormalizedEmail]);
GO

CREATE UNIQUE INDEX [UserNameIndex] ON [AspNetUsers] ([NormalizedUserName]) WHERE [NormalizedUserName] IS NOT NULL;
GO

CREATE INDEX [IX_Facturas_MesaId] ON [Facturas] ([MesaId]);
GO

CREATE INDEX [IX_Inventarios_ProductoId] ON [Inventarios] ([ProductoId]);
GO

CREATE INDEX [IX_Pagos_VentaId] ON [Pagos] ([VentaId]);
GO

CREATE INDEX [IX_Productos_CategoriaId] ON [Productos] ([CategoriaId]);
GO

CREATE INDEX [IX_VentaProductos_ProductoId] ON [VentaProductos] ([ProductoId]);
GO

CREATE INDEX [IX_Ventas_ClienteId] ON [Ventas] ([ClienteId]);
GO

CREATE INDEX [IX_Ventas_FacturaId] ON [Ventas] ([FacturaId]);
GO

CREATE INDEX [IX_Ventas_MesaId] ON [Ventas] ([MesaId]);
GO

CREATE INDEX [IX_Ventas_UsuarioId] ON [Ventas] ([UsuarioId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230721150653_initial', N'7.0.9');
GO

COMMIT;
GO



-- Insert Categorias
-- Insertar Categorias
INSERT INTO Categorias (Nombre) VALUES ('Entradas');
INSERT INTO Categorias (Nombre) VALUES ('Ensaladas');
INSERT INTO Categorias (Nombre) VALUES ('Sopas');
INSERT INTO Categorias (Nombre) VALUES ('Carnes');
INSERT INTO Categorias (Nombre) VALUES ('Mariscos');
INSERT INTO Categorias (Nombre) VALUES ('Aves');
INSERT INTO Categorias (Nombre) VALUES ('Vegetarianos');
INSERT INTO Categorias (Nombre) VALUES ('Postres');


-- Insert Clientes
INSERT INTO Clientes (Nombre, Direccion, Telefono)
VALUES ('Juan Perez', 'Calle Principal 123', '1234567890'),
       ('Maria Garcia', 'Av. Secundaria 456', '0987654321'),
       ('Carlos Rodriguez', 'Calle Tercera 789', '1122334455'),
       ('Luisa Morales', 'Av. Cuarta 321', '5566778899'),
       ('Fernando Lopez', 'Calle Quinta 654', '2233445566'),
       ('Isabel Torres', 'Av. Sexta 987', '3344556677'),
       ('Ricardo Hernandez', 'Calle Septima 654', '7788991122'),
       ('Carmen Sanchez', 'Av. Octava 321', '9911223344'),
       ('Roberto Gomez', 'Calle Novena 987', '4455667788'),
       ('Lucia Romero', 'Av. Decima 123', '6677889900'),
       ('Pedro Guzman', 'Calle Once 456', '8899001122'),
       ('Ana Castillo', 'Av. Doce 789', '0011223344'),
       ('Miguel Ruiz', 'Calle Trece 321', '1122334455'),
       ('Patricia Pena', 'Av. Catorce 654', '2233445566'),
       ('Sergio Ramos', 'Calle Quince 987', '3344556677'),
       ('Teresa Jimenez', 'Av. Dieciséis 123', '5566778899'),
       ('Antonio Aguirre', 'Calle Diecisiete 456', '7788990011'),
       ('Laura Ortega', 'Av. Dieciocho 789', '9900112233'),
       ('Jose Vargas', 'Calle Diecinueve 321', '4455667788'),
       ('Sofia Peña', 'Av. Veinte 654', '6677889900');


-- Insert Mesas
INSERT INTO Mesas (Estado) VALUES ('Libre');
INSERT INTO Mesas (Estado) VALUES ('Ocupada');

-- Insert Reportes
INSERT INTO Reportes (FechaInicio, FechaFin) VALUES ('2023-07-20 09:00:00', '2023-07-20 18:00:00');

-- Insertar Productos
INSERT INTO Productos (Codigo, Nombre, Precio, CategoriaId) VALUES ('P01', 'Bruschetta', 7.50, 1);
INSERT INTO Productos (Codigo, Nombre, Precio, CategoriaId) VALUES ('P02', 'Queso Frito', 8.00, 1);
INSERT INTO Productos (Codigo, Nombre, Precio, CategoriaId) VALUES ('P03', 'Ensalada Cesar', 10.00, 2);
INSERT INTO Productos (Codigo, Nombre, Precio, CategoriaId) VALUES ('P04', 'Ensalada Griega', 9.00, 2);
INSERT INTO Productos (Codigo, Nombre, Precio, CategoriaId) VALUES ('P05', 'Sopa de Pollo', 8.00, 3);
INSERT INTO Productos (Codigo, Nombre, Precio, CategoriaId) VALUES ('P06', 'Sopa de Tomate', 7.00, 3);
INSERT INTO Productos (Codigo, Nombre, Precio, CategoriaId) VALUES ('P07', 'Filete de Res', 25.00, 4);
INSERT INTO Productos (Codigo, Nombre, Precio, CategoriaId) VALUES ('P08', 'Chuletas de Cerdo', 20.00, 4);
INSERT INTO Productos (Codigo, Nombre, Precio, CategoriaId) VALUES ('P09', 'Camarones al Ajillo', 18.00, 5);
INSERT INTO Productos (Codigo, Nombre, Precio, CategoriaId) VALUES ('P10', 'Pescado a la Veracruzana', 22.00, 5);
INSERT INTO Productos (Codigo, Nombre, Precio, CategoriaId) VALUES ('P11', 'Pollo al Limón', 15.00, 6);
INSERT INTO Productos (Codigo, Nombre, Precio, CategoriaId) VALUES ('P12', 'Pollo a la Parmesana', 16.00, 6);
INSERT INTO Productos (Codigo, Nombre, Precio, CategoriaId) VALUES ('P13', 'Lasagna Vegetariana', 14.00, 7);
INSERT INTO Productos (Codigo, Nombre, Precio, CategoriaId) VALUES ('P14', 'Enchiladas Vegetarianas', 13.00, 7);
INSERT INTO Productos (Codigo, Nombre, Precio, CategoriaId) VALUES ('P15', 'Tiramisu', 7.00, 8);
INSERT INTO Productos (Codigo, Nombre, Precio, CategoriaId) VALUES ('P16', 'Helado', 6.00, 8);
INSERT INTO Productos (Codigo, Nombre, Precio, CategoriaId) VALUES ('P17', 'Tarta de Queso', 8.00, 8);
INSERT INTO Productos (Codigo, Nombre, Precio, CategoriaId) VALUES ('P18', 'Flan', 7.00, 8);
INSERT INTO Productos (Codigo, Nombre, Precio, CategoriaId) VALUES ('P19', 'Brownie de Chocolate', 7.50, 8);
INSERT INTO Productos (Codigo, Nombre, Precio, CategoriaId) VALUES ('P20', 'Pastel de Zanahoria', 8.00, 8);

INSERT INTO Facturas (Fecha, Total, MesaId) VALUES ('2023-07-20 12:00:00', 15.00, 1);

INSERT INTO Inventarios (ProductoId, Cantidad) VALUES (1, 100);
INSERT INTO Inventarios (ProductoId, Cantidad) VALUES (2, 50);
INSERT INTO Inventarios (ProductoId, Cantidad) VALUES (3, 75);
INSERT INTO Inventarios (ProductoId, Cantidad) VALUES (4, 90);
INSERT INTO Inventarios (ProductoId, Cantidad) VALUES (5, 60);
INSERT INTO Inventarios (ProductoId, Cantidad) VALUES (6, 70);
INSERT INTO Inventarios (ProductoId, Cantidad) VALUES (7, 50);
INSERT INTO Inventarios (ProductoId, Cantidad) VALUES (8, 60);
INSERT INTO Inventarios (ProductoId, Cantidad) VALUES (9, 40);
INSERT INTO Inventarios (ProductoId, Cantidad) VALUES (10, 80);
INSERT INTO Inventarios (ProductoId, Cantidad) VALUES (11, 60);
INSERT INTO Inventarios (ProductoId, Cantidad) VALUES (12, 70);
INSERT INTO Inventarios (ProductoId, Cantidad) VALUES (13, 85);
INSERT INTO Inventarios (ProductoId, Cantidad) VALUES (14, 90);
INSERT INTO Inventarios (ProductoId, Cantidad) VALUES (15, 100);
INSERT INTO Inventarios (ProductoId, Cantidad) VALUES (16, 90);
INSERT INTO Inventarios (ProductoId, Cantidad) VALUES (17, 70);
INSERT INTO Inventarios (ProductoId, Cantidad) VALUES (18, 80);
INSERT INTO Inventarios (ProductoId, Cantidad) VALUES (19, 100);
INSERT INTO Inventarios (ProductoId, Cantidad) VALUES (20, 75);

INSERT INTO Ventas (ClienteId, UsuarioId, Total, MetodoPago, Fecha, FacturaId, MesaId) VALUES (1, '5c935c89-ed4b-4688-87be-1c9d8b8f2677', 10.00, 'Efectivo', '2023-07-20 13:00:00', 1, 1);
INSERT INTO Ventas (ClienteId, UsuarioId, Total, MetodoPago, Fecha, FacturaId, MesaId) VALUES (2, '5c935c89-ed4b-4688-87be-1c9d8b8f2677', 20.00, 'Tarjeta de Crédito', '2023-07-20 14:00:00', 1, 2);
INSERT INTO Ventas (ClienteId, UsuarioId, Total, MetodoPago, Fecha, FacturaId, MesaId) VALUES (2, '5c935c89-ed4b-4688-87be-1c9d8b8f2677', 30.00, 'Tarjeta de Débito', '2023-07-20 15:00:00', 1, 2);

INSERT INTO Pagos (VentaId, Monto, Fecha) VALUES (7, 10.00, '2023-07-20 13:00:00');
INSERT INTO Pagos (VentaId, Monto, Fecha) VALUES (8, 20.00, '2023-07-20 14:00:00');
INSERT INTO Pagos (VentaId, Monto, Fecha) VALUES (9, 30.00, '2023-07-20 15:00:00');

INSERT INTO VentaProductos (VentaId, ProductoId, Cantidad) VALUES (7, 1, 1);
INSERT INTO VentaProductos (VentaId, ProductoId, Cantidad) VALUES (7, 3, 1);
INSERT INTO VentaProductos (VentaId, ProductoId, Cantidad) VALUES (8, 2, 4);
INSERT INTO VentaProductos (VentaId, ProductoId, Cantidad) VALUES (9, 2, 2);
INSERT INTO VentaProductos (VentaId, ProductoId, Cantidad) VALUES (9, 3, 2);




SELECT * FROM Clientes;