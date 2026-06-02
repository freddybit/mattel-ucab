/* =================================================================
   ARCHIVO DML: INSERCIÓN DE DATOS - PROYECTO MATTELUCAB
   ================================================================= */

/* -----------------------------------------------------------------
   BLOQUE 1: DATOS CATÁLOGO (Fijos y Reales)
   ----------------------------------------------------------------- */

-- 1.1 GEOGRAFÍA DE VENEZUELA (País, Estados y Municipios clave)
INSERT INTO Lugar (idLugar, nombre, tipo, codigoPostal, Lugar_idLugar) VALUES (1, 'Venezuela', 'País', 0, NULL);

-- Estados
INSERT INTO Lugar (idLugar, nombre, tipo, codigoPostal, Lugar_idLugar) VALUES (2, 'Distrito Capital', 'Estado', 1000, 1);
INSERT INTO Lugar (idLugar, nombre, tipo, codigoPostal, Lugar_idLugar) VALUES (3, 'Miranda', 'Estado', 1200, 1);
INSERT INTO Lugar (idLugar, nombre, tipo, codigoPostal, Lugar_idLugar) VALUES (4, 'La Guaira', 'Estado', 1160, 1);
INSERT INTO Lugar (idLugar, nombre, tipo, codigoPostal, Lugar_idLugar) VALUES (11, 'Amazonas', 'Estado', 7101, 1);
INSERT INTO Lugar (idLugar, nombre, tipo, codigoPostal, Lugar_idLugar) VALUES (12, 'Anzoátegui', 'Estado', 6001, 1);
INSERT INTO Lugar (idLugar, nombre, tipo, codigoPostal, Lugar_idLugar) VALUES (14, 'Aragua', 'Estado', 2101, 1);
INSERT INTO Lugar (idLugar, nombre, tipo, codigoPostal, Lugar_idLugar) VALUES (17, 'Carabobo', 'Estado', 2001, 1);
INSERT INTO Lugar (idLugar, nombre, tipo, codigoPostal, Lugar_idLugar) VALUES (31, 'Zulia', 'Estado', 4001, 1);

-- Municipios de Distrito Capital y Miranda
INSERT INTO Lugar (idLugar, nombre, tipo, codigoPostal, Lugar_idLugar) VALUES (5, 'Libertador', 'Municipio', 1010, 2);
INSERT INTO Lugar (idLugar, nombre, tipo, codigoPostal, Lugar_idLugar) VALUES (6, 'Chacao', 'Municipio', 1060, 3);
INSERT INTO Lugar (idLugar, nombre, tipo, codigoPostal, Lugar_idLugar) VALUES (7, 'Baruta', 'Municipio', 1080, 3);
INSERT INTO Lugar (idLugar, nombre, tipo, codigoPostal, Lugar_idLugar) VALUES (8, 'Sucre', 'Municipio', 1070, 3);

-- 1.2 PROFESIONES
INSERT INTO Profesion (idProfesion, nombre, descripcion) VALUES (1, 'Ingeniero en Computación', 'Especialista en desarrollo y bases de datos.');
INSERT INTO Profesion (idProfesion, nombre, descripcion) VALUES (2, 'Especialista en Sublimación', 'Experto en estampado térmico para productos.');
INSERT INTO Profesion (idProfesion, nombre, descripcion) VALUES (3, 'Diseñador UI/UX', 'Encargado de prototipar en Figma.');

-- 1.3 MATERIALES Y COLORES
INSERT INTO Material (idMaterial, nombre, descripcion) VALUES (1, 'Cerámica Premium', 'Material de alta resistencia para tazas.');
INSERT INTO Material (idMaterial, nombre, descripcion) VALUES (2, 'Poliéster 100%', 'Tela de alta durabilidad para camisas.');
INSERT INTO Material (idMaterial, nombre, descripcion) VALUES (3, 'Polímero Térmico', 'Aleación con aislamiento para termos.');

INSERT INTO Color (idColor, codigoHexadecimal, nombre) VALUES (1, '#FF0000', 'Rojo Dinámico');
INSERT INTO Color (idColor, codigoHexadecimal, nombre) VALUES (2, '#0000FF', 'Azul Océano');
INSERT INTO Color (idColor, codigoHexadecimal, nombre) VALUES (3, '#FFFFFF', 'Blanco Base');
INSERT INTO Color (idColor, codigoHexadecimal, nombre) VALUES (4, '#000000', 'Negro Mate');


/* -----------------------------------------------------------------
   BLOQUE 2: DATOS TRANSACCIONALES (Mock Data / Falsos)
   ----------------------------------------------------------------- */

-- 2.1 REGISTRO BASE DE MONITOR DE ACTIVIDAD (Requisito obligatorio para crear Clientes)
INSERT INTO MonitorActividadSopechosa (idMonitorActividadSopechosa, fechaHora) VALUES (1, '2026-05-31');

-- 2.2 CLIENTES NATURALES (10 de prueba)
INSERT INTO ClienteNatural (idClienteNatural, cedula, pNombre, sNombre, pApellido, sApellido, direccion, MonitorActividadSopechosa_idMonitorActividadSopechosa)
VALUES (1, 27123456, 'Valeria', 'Sofia', 'Gomez', 'Perez', 'Av. Francisco de Miranda, Chacao', 1);
INSERT INTO ClienteNatural (idClienteNatural, cedula, pNombre, sNombre, pApellido, sApellido, direccion, MonitorActividadSopechosa_idMonitorActividadSopechosa)
VALUES (2, 28987654, 'Daniel', 'Alejandro', 'Rodriguez', 'Silva', 'Calle Los Mangos, Sabana Grande', 1);
INSERT INTO ClienteNatural (idClienteNatural, cedula, pNombre, sNombre, pApellido, sApellido, direccion, MonitorActividadSopechosa_idMonitorActividadSopechosa)
VALUES (3, 26543210, 'Alejandra', 'Maria', 'Fernandez', 'Lopez', 'Urb. El Rosal, Chacao', 1);
INSERT INTO ClienteNatural (idClienteNatural, cedula, pNombre, sNombre, pApellido, sApellido, direccion, MonitorActividadSopechosa_idMonitorActividadSopechosa)
VALUES (4, 29111222, 'Andres', 'Jesus', 'Martinez', 'Gonzalez', 'La Candelaria, Caracas', 1);
INSERT INTO ClienteNatural (idClienteNatural, cedula, pNombre, sNombre, pApellido, sApellido, direccion, MonitorActividadSopechosa_idMonitorActividadSopechosa)
VALUES (5, 25888999, 'Mariana', 'Victoria', 'Castillo', 'Rojas', 'Las Mercedes, Baruta', 1);
INSERT INTO ClienteNatural (idClienteNatural, cedula, pNombre, sNombre, pApellido, sApellido, direccion, MonitorActividadSopechosa_idMonitorActividadSopechosa)
VALUES (6, 30123123, 'Diego', 'Andres', 'Romero', 'Diaz', 'Los Dos Caminos, Sucre', 1);
INSERT INTO ClienteNatural (idClienteNatural, cedula, pNombre, sNombre, pApellido, sApellido, direccion, MonitorActividadSopechosa_idMonitorActividadSopechosa)
VALUES (7, 24555666, 'Camila', 'Isabella', 'Torres', 'Vargas', 'Av. Urdaneta, Libertador', 1);
INSERT INTO ClienteNatural (idClienteNatural, cedula, pNombre, sNombre, pApellido, sApellido, direccion, MonitorActividadSopechosa_idMonitorActividadSopechosa)
VALUES (8, 27888777, 'Gabriel', 'Enrique', 'Flores', 'Mendoza', 'Altamira, Chacao', 1);
INSERT INTO ClienteNatural (idClienteNatural, cedula, pNombre, sNombre, pApellido, sApellido, direccion, MonitorActividadSopechosa_idMonitorActividadSopechosa)
VALUES (9, 26999000, 'Sofia', 'Valentina', 'Medina', 'Rivas', 'La Florida, Libertador', 1);
INSERT INTO ClienteNatural (idClienteNatural, cedula, pNombre, sNombre, pApellido, sApellido, direccion, MonitorActividadSopechosa_idMonitorActividadSopechosa)
VALUES (10, 28333444, 'Luis', 'Fernando', 'Castro', 'Acosta', 'Macaracuay, Sucre', 1);

-- 2.3 EMPLEADOS DE MATTEL (Tienen asociado el ID del Municipio donde viven)
INSERT INTO Empleado (id, cedula, pNombre, sNombre, pApellido, sApellido, fechaNacimiento, direccion, Lugar_idLugar)
VALUES (1, 15123456, 'Roberto', 'Carlos', 'Jimenez', 'Sosa', '1985-05-14', 'El Marques', 8);
INSERT INTO Empleado (id, cedula, pNombre, sNombre, pApellido, sApellido, fechaNacimiento, direccion, Lugar_idLugar)
VALUES (2, 18987654, 'Carmen', 'Elena', 'Brito', 'Ruiz', '1990-10-21', 'Bello Monte', 7);
INSERT INTO Empleado (id, cedula, pNombre, sNombre, pApellido, sApellido, fechaNacimiento, direccion, Lugar_idLugar)
VALUES (3, 21555444, 'Javier', 'Eduardo', 'Molina', 'Pino', '1995-02-08', 'Montalban', 5);

-- 2.4 USUARIOS DEL SISTEMA (Conectados a los Clientes y Empleados que acabamos de crear)

-- Cuentas de los Clientes Naturales (Empleado_id queda en NULL)
INSERT INTO Usuario (idUsuario, nombreUsuario, correoElectronico, contraseña, estado, fechaRegistro, ClienteNatural_idClienteNatural, Empleado_id)
VALUES (1, 'valesofia', 'valeria.gomez@gmail.com', 'hash12345', 'Activo', '2026-05-31', 1, NULL);
INSERT INTO Usuario (idUsuario, nombreUsuario, correoElectronico, contraseña, estado, fechaRegistro, ClienteNatural_idClienteNatural, Empleado_id)
VALUES (2, 'danrodriguez', 'daniel.rodriguez@hotmail.com', 'hash12345', 'Activo', '2026-05-31', 2, NULL);
INSERT INTO Usuario (idUsuario, nombreUsuario, correoElectronico, contraseña, estado, fechaRegistro, ClienteNatural_idClienteNatural, Empleado_id)
VALUES (3, 'alefer', 'alejandra.fernandez@gmail.com', 'hash12345', 'Activo', '2026-05-31', 3, NULL);

-- Cuentas de los Empleados (ClienteNatural_idClienteNatural queda en NULL)
INSERT INTO Usuario (idUsuario, nombreUsuario, correoElectronico, contraseña, estado, fechaRegistro, ClienteNatural_idClienteNatural, Empleado_id)
VALUES (4, 'admin_roberto', 'rjimenez@mattelucab.com', 'admin_hash_99', 'Activo', '2026-05-31', NULL, 1);
INSERT INTO Usuario (idUsuario, nombreUsuario, correoElectronico, contraseña, estado, fechaRegistro, ClienteNatural_idClienteNatural, Empleado_id)
VALUES (5, 'admin_carmen', 'cbrito@mattelucab.com', 'admin_hash_88', 'Activo', '2026-05-31', NULL, 2);