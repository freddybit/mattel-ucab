/* =================================================================
   CATÁLOGOS PRINCIPALES - MATTEL UCAB
   10 registros por tabla
   ================================================================= */

-- Ambiente
INSERT INTO Ambiente (idAmbiente, nombre, descripcion) VALUES
(1, 'Urbano', 'Ambientación urbana con elementos de ciudad'),
(2, 'Playa', 'Ambientación playera con arena y mar'),
(3, 'Bosque', 'Ambientación forestal con árboles y fauna'),
(4, 'Espacial', 'Ambientación espacial con estrellas y naves'),
(5, 'Deportivo', 'Ambientación deportiva con implementos atléticos'),
(6, 'Medieval', 'Ambientación de castillos y caballeros'),
(7, 'Cyberpunk', 'Ambientación futurista con neón y tecnología'),
(8, 'Fantasía', 'Ambientación mágica con criaturas fantásticas'),
(9, 'Industrial', 'Ambientación fabril con maquinaria'),
(10, 'Acuático', 'Ambientación submarina con arrecifes');

-- ClasificacionExclusividad
INSERT INTO ClasificacionExclusividad (idClasificacionExclusividad, nombre, descripcion) VALUES
(1, 'Edición Limitada', 'Producción limitada a 5000 unidades'),
(2, 'Edición Regular', 'Producción estándar sin restricciones'),
(3, 'Ultra Exclusiva', 'Menos de 500 unidades producidas'),
(4, 'Edición Especial', 'Lanzamiento por evento especial'),
(5, 'Edición Collector', 'Exclusiva para coleccionistas'),
(6, 'Edición Aniversario', 'Celebración de aniversario'),
(7, 'Edición Regional', 'Exclusiva para una región'),
(8, 'Edición Digital', 'Versión digital NFT'),
(9, 'Edición Prototipo', 'Prototipo de serie limitada'),
(10, 'Edición Personalizada', 'Diseño personalizado por encargo');

-- ClasificacionHistorica
INSERT INTO ClasificacionHistorica (idClasificacionHistorica, nombre, descripcion) VALUES
(1, 'Clásico', 'Diseño basado en personajes históricos de Mattel'),
(2, 'Moderno', 'Diseño contemporáneo con tendencias actuales'),
(3, 'Vintage', 'Diseño retro inspirado en décadas pasadas'),
(4, 'Futurista', 'Diseño con proyección a futuro'),
(5, 'Conmemorativo', 'Diseño para conmemorar un evento'),
(6, 'Art Deco', 'Estilo art déco de los años 20'),
(7, 'Steampunk', 'Estilo victoriano con tecnología steam'),
(8, 'Minimalista', 'Diseño minimalista y funcional'),
(9, 'Barroco', 'Estilo barroco ornamentado'),
(10, 'Étnico', 'Diseño inspirado en culturas ancestrales');

-- Color
INSERT INTO Color (idColor, codigoHexadecimal, nombre) VALUES
(1, '#FF0000', 'Rojo'),
(2, '#0000FF', 'Azul'),
(3, '#00FF00', 'Verde'),
(4, '#FFFF00', 'Amarillo'),
(5, '#FFC0CB', 'Rosa'),
(6, '#800080', 'Morado'),
(7, '#FFA500', 'Naranja'),
(8, '#000000', 'Negro'),
(9, '#FFFFFF', 'Blanco'),
(10, '#808080', 'Gris');

-- CondicionFisica
INSERT INTO condicionFisica (idCondicionFisica, nombre, descripcion) VALUES
(1, 'Nuevo', 'Producto en estado original sin uso'),
(2, 'Usado - Bueno', 'Producto usado en buenas condiciones'),
(3, 'Usado - Regular', 'Producto usado con desgaste visible'),
(4, 'Usado - Malo', 'Producto usado con daños estéticos'),
(5, 'Restaurado', 'Producto restaurado a condiciones originales'),
(6, 'Incompleto', 'Producto al que le faltan piezas'),
(7, 'Sellado', 'Producto en empaque original sellado'),
(8, 'Exhibición', 'Producto usado en exhibición'),
(9, 'Prototipo', 'Prototipo de fabricación'),
(10, 'Personalizado', 'Producto modificado artesanalmente');

-- Courier
INSERT INTO Courier (idCourier, nombre) VALUES
(1, 'Zoom'),
(2, 'MRW'),
(3, 'DHL'),
(4, 'Tealca'),
(5, 'Domestic Express'),
(6, 'FedEx'),
(7, 'UPS'),
(8, 'Envíos Ya'),
(9, 'Logística Total'),
(10, 'Transporte Rápido');

-- EstadoOrden
INSERT INTO EstadoOrden (idEstadoOrden, nombre, descripcion) VALUES
(1, 'Pendiente', 'Orden registrada pendiente de procesar'),
(2, 'En Proceso', 'Orden siendo preparada'),
(3, 'Despachada', 'Orden enviada al cliente'),
(4, 'Entregada', 'Orden recibida por el cliente'),
(5, 'Cancelada', 'Orden cancelada'),
(6, 'Reembolsada', 'Orden reembolsada al cliente'),
(7, 'En Espera', 'Orden en espera de stock'),
(8, 'Devuelta', 'Orden devuelta por el cliente'),
(9, 'Completada', 'Orden completada exitosamente'),
(10, 'Parcial', 'Orden despachada parcialmente');

-- Horario
INSERT INTO Horario (idHorario, dia, horaInicio, horaFin) VALUES
(1, 'Lunes', '08:00'::TIME, '12:00'::TIME),
(2, 'Lunes', '13:00'::TIME, '17:00'::TIME),
(3, 'Martes', '08:00'::TIME, '12:00'::TIME),
(4, 'Martes', '13:00'::TIME, '17:00'::TIME),
(5, 'Miércoles', '08:00'::TIME, '12:00'::TIME),
(6, 'Miércoles', '13:00'::TIME, '17:00'::TIME),
(7, 'Jueves', '08:00'::TIME, '12:00'::TIME),
(8, 'Jueves', '13:00'::TIME, '17:00'::TIME),
(9, 'Viernes', '08:00'::TIME, '12:00'::TIME),
(10, 'Viernes', '13:00'::TIME, '17:00'::TIME);

-- Material
INSERT INTO Material (idMaterial, nombre, descripcion) VALUES
(1, 'Plástico ABS', 'Plástico resistente para piezas estructurales'),
(2, 'PVC', 'Cloruro de polivinilo flexible'),
(3, 'Poliéster', 'Fibra sintética para ropa'),
(4, 'Algodón', 'Fibra natural para textiles'),
(5, 'Metal', 'Aleación metálica para accesorios'),
(6, 'Caucho', 'Material elástico para ruedas y soportes'),
(7, 'Vidrio', 'Vidrio templado para accesorios'),
(8, 'Madera', 'Madera procesada para empaques'),
(9, 'Cartón', 'Cartón reciclado para empaques'),
(10, 'Resina', 'Resina epóxica para detalles finos');

-- MetodoPago
INSERT INTO MetodoPago (idMetodoPago, numero, moneda) VALUES
(1, NULL, 1),
(2, NULL, 1),
(3, NULL, 2),
(4, NULL, 1),
(5, NULL, 2),
(6, NULL, 1),
(7, NULL, 1),
(8, NULL, 2),
(9, NULL, 1),
(10, NULL, 2);

-- MoldeRostro
INSERT INTO MoldeRostro (idMoldeRostro, nombre, descripcion, añoPatente) VALUES
(1, 'Super Heroe', 'Molde facial de superhéroe clásico', '2000-01-01'::DATE),
(2, 'Princesa', 'Molde facial de princesa con rasgos finos', '2001-06-15'::DATE),
(3, 'Aventurero', 'Molde facial aventurero con expresión seria', '2003-03-20'::DATE),
(4, 'Cómico', 'Molde facial con expresión graciosa', '2005-11-10'::DATE),
(5, 'Realista', 'Molde facial hiperrealista', '2010-09-05'::DATE),
(6, 'Infantil', 'Molde facial infantil con rasgos suaves', '2012-04-12'::DATE),
(7, 'Villano', 'Molde facial de villano con ceño fruncido', '2014-07-22'::DATE),
(8, 'Robot', 'Molde facial robótico con líneas marcadas', '2016-01-30'::DATE),
(9, 'Fantástico', 'Molde facial de criatura fantástica', '2018-03-15'::DATE),
(10, 'Alienígena', 'Molde facial extraterrestre', '2020-09-01'::DATE);

-- ObjetivoGlobal
INSERT INTO ObjetivoGlobal (idObjetivoGlobal, volumenVentas, porcentajeRegalia) VALUES
(1, 1000000, 5),
(2, 5000000, 8),
(3, 10000000, 12),
(4, 15000000, 15),
(5, 20000000, 18),
(6, 30000000, 20),
(7, 50000000, 25),
(8, 75000000, 30),
(9, 100000000, 35),
(10, 200000000, 40);

-- Permisos
INSERT INTO Permisos (idPermiso, nombre) VALUES
(1, 'CREAR_USUARIO'),
(2, 'MODIFICAR_USUARIO'),
(3, 'ELIMINAR_USUARIO'),
(4, 'CREAR_PRODUCTO'),
(5, 'MODIFICAR_PRODUCTO'),
(6, 'ELIMINAR_PRODUCTO'),
(7, 'VER_VENTAS'),
(8, 'MODIFICAR_PRECIOS'),
(9, 'GESTIONAR_INVENTARIO'),
(10, 'ADMINISTRAR_SUBASTAS');

-- Profesion
INSERT INTO Profesion (idProfesion, nombre, descripcion) VALUES
(1, 'Diseñador Industrial', 'Diseño de productos industriales'),
(2, 'Ingeniero de Materiales', 'Especialista en materiales'),
(3, 'Diseñador Gráfico', 'Diseño gráfico y branding'),
(4, 'Modelador 3D', 'Modelado tridimensional digital'),
(5, 'Escultor', 'Escultura tradicional y digital'),
(6, 'Ingeniero de Producción', 'Optimización de procesos productivos'),
(7, 'Diseñador Textil', 'Diseño de vestuario para figuras'),
(8, 'Pintor', 'Pintura y acabados artísticos'),
(9, 'Diseñador de Empaques', 'Diseño de packaging'),
(10, 'Arquitecto', 'Diseño de ambientes');

-- PuestoTrabajo
INSERT INTO PuestoTrabajo (id, nombre, descripcion) VALUES
(1, 'Gerente de Producción', 'Supervisa la producción general'),
(2, 'Diseñador Senior', 'Diseña nuevas líneas de productos'),
(3, 'Supervisor de Calidad', 'Control de calidad de productos'),
(4, 'Analista de Ventas', 'Análisis de datos de ventas'),
(5, 'Coordinador de Logística', 'Coordina envíos y almacenes'),
(6, 'Community Manager', 'Redes sociales y comunidad'),
(7, 'Desarrollador de Producto', 'Investigación y desarrollo'),
(8, 'Asistente de Diseño', 'Apoyo al equipo de diseño'),
(9, 'Diseñador Junior', 'Diseño asistido bajo supervisión'),
(10, 'Director Creativo', 'Dirección del equipo creativo');

-- Regalia
INSERT INTO Regalia (idRegalia, monto, fechaHora) VALUES
(1, 5000, '2025-01-15'::DATE),
(2, 12000, '2025-03-20'::DATE),
(3, 8000, '2025-06-10'::DATE),
(4, 15000, '2025-07-01'::DATE),
(5, 2000, '2025-08-15'::DATE),
(6, 18000, '2025-09-05'::DATE),
(7, 7000, '2025-10-10'::DATE),
(8, 25000, '2025-11-01'::DATE),
(9, 10000, '2025-12-01'::DATE),
(10, 30000, '2025-12-15'::DATE);

-- Restriccion
INSERT INTO Restriccion (idRestriccion, nombre, descripcion) VALUES
(1, 'No apto para menores de 3 años', 'Contiene piezas pequeñas'),
(2, 'No exponer al sol', 'Los colores pueden decolorarse'),
(3, 'Mantener en lugar seco', 'No apto para ambientes húmedos'),
(4, 'No sumergir en agua', 'Componentes electrónicos sensibles'),
(5, 'Uso supervisado', 'Recomendado con supervisión adulta'),
(6, 'Alejado del fuego', 'Material inflamable'),
(7, 'No forzar articulaciones', 'Puede romperse'),
(8, 'Limpieza con paño seco', 'No usar productos químicos'),
(9, 'Mantener etiqueta', 'Identificación del producto'),
(10, 'Reciclaje obligatorio', 'Empaque reciclable');

-- Rol
INSERT INTO Rol (idRol, nombre, descripcion, contraseña) VALUES
(1, 'Administrador', 'Acceso total al sistema', 'admin123'),
(2, 'Empleado', 'Acceso a funciones operativas', 'empleado123'),
(3, 'Cliente', 'Acceso básico para clientes', 'cliente123'),
(4, 'Supervisor', 'Acceso de supervisión', 'supervisor123'),
(5, 'Gerente', 'Acceso gerencial', 'gerente123'),
(6, 'Soporte', 'Acceso a soporte técnico', 'soporte123'),
(7, 'Auditor', 'Acceso de auditoría', 'auditor123'),
(8, 'Vendedor', 'Acceso a módulo de ventas', 'vendedor123'),
(9, 'Logística', 'Acceso a módulo de envíos', 'logistica123'),
(10, 'Invitado', 'Acceso restringido de solo lectura', 'invitado123');

-- TipoCaja
INSERT INTO TipoCaja (idTipoCaja, nombre) VALUES
(1, 'Caja Individual'),
(2, 'Caja Display'),
(3, 'Caja Master'),
(4, 'Caja Regalo'),
(5, 'Caja Coleccionista'),
(6, 'Caja Económica'),
(7, 'Caja Premium'),
(8, 'Caja Expositiva'),
(9, 'Caja de Transporte'),
(10, 'Caja Metálica');

-- TipoCuerpo
INSERT INTO TipoCuerpo (idTipoCuerpo, nombre, descripcion) VALUES
(1, 'Articulado', 'Cuerpo con articulaciones móviles'),
(2, 'Fijo', 'Cuerpo estático sin movimiento'),
(3, 'Básico', 'Cuerpo simple con movilidad limitada'),
(4, 'Deluxe', 'Cuerpo premium con alta articulación'),
(5, 'Super Articulado', 'Máxima articulación con 30 puntos'),
(6, 'Blando', 'Cuerpo de material suave para bebés'),
(7, 'Electrónico', 'Cuerpo con luces y sonidos'),
(8, 'Miniatura', 'Cuerpo a escala reducida'),
(9, 'Gigante', 'Cuerpo de tamaño grande'),
(10, 'Transformable', 'Cuerpo que cambia de forma');

-- TipoDiseño
INSERT INTO TipoDiseño (idTipoDiseño, nombre) VALUES
(1, 'Superhéroe'),
(2, 'Princesa'),
(3, 'Aventura'),
(4, 'Ciencia Ficción'),
(5, 'Deportivo'),
(6, 'Fantasía'),
(7, 'Histórico'),
(8, 'Animal'),
(9, 'Música'),
(10, 'Profesiones');

-- TipoPieza
INSERT INTO TipoPieza (idTipoPieza, nombre) VALUES
(1, 'Cabeza'),
(2, 'Torso'),
(3, 'Brazo'),
(4, 'Pierna'),
(5, 'Accesorio'),
(6, 'Mano'),
(7, 'Pie'),
(8, 'Cuello'),
(9, 'Cadera'),
(10, 'Articulación');

-- TonoPiel
INSERT INTO TonoPiel (idTonoPiel, nombre, escalaFitzpatrick, valorClaridad, luminosidad) VALUES
(1, 'Porcelana', '2020-01-01'::DATE, 'Muy clara', 1),
(2, 'Claro', '2020-01-01'::DATE, 'Clara', 2),
(3, 'Medio', '2020-01-01'::DATE, 'Media', 3),
(4, 'Moreno', '2020-01-01'::DATE, 'Oscura', 4),
(5, 'Oscuro', '2020-01-01'::DATE, 'Muy oscura', 5),
(6, 'Ébano', '2020-01-01'::DATE, 'Negra', 6),
(7, 'Canela', '2020-01-01'::DATE, 'Canela', 7),
(8, 'Miel', '2020-01-01'::DATE, 'Dorada', 8),
(9, 'Olivo', '2020-01-01'::DATE, 'Verde oliva', 9),
(10, 'Alabastro', '2020-01-01'::DATE, 'Albina', 10);

-- Transporte
INSERT INTO Transporte (idTransporte, matricula, nombreConductor, apellidoConductor) VALUES
(1, 'ABC123', 'Carlos', 'Mendoza'),
(2, 'DEF456', 'María', 'González'),
(3, 'GHI789', 'José', 'Rodríguez'),
(4, 'JKL012', 'Ana', 'Martínez'),
(5, 'MNO345', 'Pedro', 'Sánchez'),
(6, 'PQR678', 'Luis', 'Torres'),
(7, 'STU901', 'Laura', 'Díaz'),
(8, 'VWX234', 'Andrés', 'Pérez'),
(9, 'YZA567', 'Sofia', 'Ramírez'),
(10, 'BCD890', 'Diego', 'Hernández');

-- Turno
INSERT INTO Turno (idTurno, porcentajeRecargo, nombre, Horario_idHorario) VALUES
(1, 0, 'Matutino', 1),
(2, 10, 'Vespertino', 2),
(3, 25, 'Nocturno', 3),
(4, 0, 'Diurno Completo', 4),
(5, 15, 'Tarde', 5),
(6, 0, 'Mañana', 6),
(7, 20, 'Fin de Semana', 7),
(8, 30, 'Festivo', 8),
(9, 0, 'Media Jornada', 9),
(10, 5, 'Jornada Reducida', 10);

-- Departamento
INSERT INTO Departamento (idDepartamento, nombre, direccion) VALUES
(1, 'Diseño', 'Edificio Creativo, Piso 3'),
(2, 'Producción', 'Planta Principal, Nave 2'),
(3, 'Ventas', 'Oficinas Centrales, Piso 1'),
(4, 'Logística', 'Almacén General, Módulo A'),
(5, 'Control de Calidad', 'Laboratorio, Nave 1'),
(6, 'Marketing', 'Oficinas Centrales, Piso 2'),
(7, 'Recursos Humanos', 'Oficinas Centrales, Piso 4'),
(8, 'Finanzas', 'Oficinas Centrales, Piso 3'),
(9, 'Investigación', 'Laboratorio de Innovación'),
(10, 'Servicio al Cliente', 'Oficinas Centrales, Planta Baja');

-- MetaMensual
INSERT INTO MetaMensual (idMetaMensual, fechaInicio, fechaFin, porcentajeComision) VALUES
(1, '2025-01-01'::DATE, '2025-01-31'::DATE, 5),
(2, '2025-02-01'::DATE, '2025-02-28'::DATE, 5),
(3, '2025-03-01'::DATE, '2025-03-31'::DATE, 5),
(4, '2025-04-01'::DATE, '2025-04-30'::DATE, 5),
(5, '2025-05-01'::DATE, '2025-05-31'::DATE, 8),
(6, '2025-06-01'::DATE, '2025-06-30'::DATE, 8),
(7, '2025-07-01'::DATE, '2025-07-31'::DATE, 10),
(8, '2025-08-01'::DATE, '2025-08-31'::DATE, 10),
(9, '2025-09-01'::DATE, '2025-09-30'::DATE, 12),
(10, '2025-10-01'::DATE, '2025-10-31'::DATE, 12);

-- TipoUbicacionStock (FK → Lugar: usa parroquias de insert.sql)
INSERT INTO TipoUbicacionStock (idTipoUbicacionStock, nombre, direccion, Lugar_idLugar) VALUES
(1, 'Almacén Central Caracas', 'Av. Principal, Zona Industrial', 1497),
(2, 'Almacén Valencia', 'Calle 5, Sector Empresarial', 650),
(3, 'Almacén Maracaibo', 'Av. 15, Zona Franca', 1432),
(4, 'Almacén Barquisimeto', 'Carrera 20, Zona Industrial', 856),
(5, 'Tienda Principal', 'CC Sambil, Nivel 2', 1489),
(6, 'Almacén Puerto La Cruz', 'Zona Industrial Municipal', 760),
(7, 'Almacén San Cristóbal', 'Av. Principal, Zona Comercial', 1120),
(8, 'Almacén Maturín', 'Calle 8, Sector Industrial', 1345),
(9, 'Tienda Valencia', 'CC Metrópolis, Nivel 1', 655),
(10, 'Almacén Maracay', 'Av. Las Industrias', 520);

-- LoteProduccion
INSERT INTO LoteProduccion (idLote, fechaInicio, fechaFin) VALUES
(1, '2025-01-05'::DATE, '2025-01-20'::DATE),
(2, '2025-02-10'::DATE, '2025-02-25'::DATE),
(3, '2025-03-15'::DATE, '2025-03-30'::DATE),
(4, '2025-04-05'::DATE, '2025-04-20'::DATE),
(5, '2025-05-10'::DATE, '2025-05-25'::DATE),
(6, '2025-06-01'::DATE, '2025-06-15'::DATE),
(7, '2025-07-05'::DATE, '2025-07-20'::DATE),
(8, '2025-08-10'::DATE, '2025-08-25'::DATE),
(9, '2025-09-01'::DATE, '2025-09-15'::DATE),
(10, '2025-10-05'::DATE, '2025-10-20'::DATE);

-- LoteMateriaPrima
INSERT INTO LoteMateriaPrima (idLoteMateriaPrima, costoAdquisicion, nombre, descripcion, Material_idMaterial) VALUES
(1, 2500, 'Lote ABS-001', 'Plástico ABS color natural', 1),
(2, 1800, 'Lote PVC-001', 'PVC flexible grado industrial', 2),
(3, 3200, 'Lote POL-001', 'Poliéster textil premium', 3),
(4, 1500, 'Lote ALG-001', 'Algodón orgánico', 4),
(5, 4500, 'Lote MET-001', 'Aleación de zinc', 5),
(6, 2100, 'Lote CAU-001', 'Caucho sintético', 6),
(7, 3800, 'Lote VID-001', 'Vidrio templado', 7),
(8, 1200, 'Lote MAD-001', 'Madera de pino', 8),
(9, 900, 'Lote CAR-001', 'Cartón corrugado', 9),
(10, 5600, 'Lote RES-001', 'Resina epóxica', 10);

-- BackOrder
INSERT INTO BackOrder (idBackOrder, cantidadPendiente, precioOriginalPactado, fechaGeneracion, estatus) VALUES
(1, 0, 150, '2025-01-15'::DATE, 0),
(2, 10, 200, '2025-02-20'::DATE, 1),
(3, 5, 175, '2025-03-10'::DATE, 1),
(4, 0, 300, '2025-04-05'::DATE, 0),
(5, 20, 250, '2025-05-01'::DATE, 1),
(6, 8, 180, '2025-06-10'::DATE, 1),
(7, 0, 220, '2025-07-15'::DATE, 0),
(8, 15, 280, '2025-08-20'::DATE, 1),
(9, 3, 350, '2025-09-05'::DATE, 1),
(10, 0, 400, '2025-10-01'::DATE, 0);

-- Empleado
INSERT INTO Empleado (id, cedula, pNombre, sNombre, pApellido, sApellido, fechaNacimiento, direccion, Lugar_idLugar) VALUES
(1, 12345678, 'Juan', 'Carlos', 'Pérez', 'González', '1985-03-15'::DATE, 'Av. Principal, Res. Los Ángeles', 1497),
(2, 23456789, 'María', 'Elena', 'Rodríguez', 'López', '1990-07-22'::DATE, 'Calle 5, Quinta María', 1489),
(3, 34567890, 'Pedro', 'José', 'Martínez', 'Silva', '1982-11-08'::DATE, 'Av. 3, Edif. Caracas', 1486),
(4, 45678901, 'Ana', 'Isabel', 'García', 'Hernández', '1995-01-30'::DATE, 'Calle 8, Res. Las Flores', 1490),
(5, 56789012, 'Carlos', 'Alberto', 'Sánchez', 'Díaz', '1988-05-12'::DATE, 'Av. Bolívar, Torre A', 1497),
(6, 67890123, 'Laura', 'Beatriz', 'Torres', 'Ramírez', '1992-09-18'::DATE, 'Calle 12, Edif. Miranda', 1489),
(7, 78901234, 'José', 'Luis', 'Ramírez', 'Mendoza', '1980-12-25'::DATE, 'Av. 5, Res. Paraíso', 1482),
(8, 89012345, 'Carmen', 'Victoria', 'Díaz', 'Paredes', '1993-04-14'::DATE, 'Calle 3, Quinta Carmen', 1493),
(9, 90123456, 'Miguel', 'Ángel', 'Fernández', 'Rojas', '1987-08-30'::DATE, 'Av. Libertador, Edif. 5', 1486),
(10, 10123456, 'Patricia', 'del Carmen', 'González', 'Suárez', '1991-06-05'::DATE, 'Calle 7, Res. Los Olivos', 1489);
