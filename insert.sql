/* =================================================================
   ARCHIVO DML: ENTRADA GEOGRÁFICA COMPLETA (PAÍS -> ESTADOS -> 5 MUNICIPIOS -> 5 PARROQUIAS)
   ================================================================= */

-- 1. EL PADRE: PAÍS (ID: 1)
INSERT INTO Lugar (idLugar, nombre, tipo, codigoPostal, Lugar_idLugar)
VALUES (1, 'Venezuela', 'País', 0, NULL);

-- 2. LOS HIJOS: LOS 24 ESTADOS (IDs: 2 al 25 - Todos apuntan al País ID: 1)
INSERT INTO Lugar (idLugar, nombre, tipo, codigoPostal, Lugar_idLugar) VALUES
(2, 'Amazonas', 'Estado', 7101, 1),
(3, 'Anzoátegui', 'Estado', 6001, 1),
(4, 'Apure', 'Estado', 7001, 1),
(5, 'Aragua', 'Estado', 2101, 1),
(6, 'Barinas', 'Estado', 5201, 1),
(7, 'Bolívar', 'Estado', 8001, 1),
(8, 'Carabobo', 'Estado', 2001, 1),
(9, 'Cojedes', 'Estado', 2201, 1),
(10, 'Delta Amacuro', 'Estado', 6401, 1),
(11, 'Falcón', 'Estado', 4101, 1),
(12, 'Guárico', 'Estado', 2301, 1),
(13, 'Lara', 'Estado', 3001, 1),
(14, 'Mérida', 'Estado', 5101, 1),
(15, 'Miranda', 'Estado', 1200, 1),
(16, 'Monagas', 'Estado', 6201, 1),
(17, 'Nueva Esparta', 'Estado', 6301, 1),
(18, 'Portuguesa', 'Estado', 3301, 1),
(19, 'Sucre', 'Estado', 6101, 1),
(20, 'Táchira', 'Estado', 5001, 1),
(21, 'Trujillo', 'Estado', 3101, 1),
(22, 'La Guaira', 'Estado', 1160, 1),
(23, 'Yaracuy', 'Estado', 3201, 1),
(24, 'Zulia', 'Estado', 4001, 1),
(25, 'Distrito Capital', 'Estado', 1000, 1);


-- 3. LOS NIETOS: MUNICIPIOS (IDs en rango 100+ para mantener orden limpio)
-- Se definen exactamente 5 municipios por cada estado seleccionado para pruebas rigurosas
INSERT INTO Lugar (idLugar, nombre, tipo, codigoPostal, Lugar_idLugar) VALUES
-- Municipios de Miranda (Estado ID: 15)
(100, 'Chacao', 'Municipio', 1060, 15),
(101, 'Baruta', 'Municipio', 1080, 15),
(102, 'Sucre', 'Municipio', 1070, 15),
(103, 'El Hatillo', 'Municipio', 1081, 15),
(104, 'Plaza', 'Municipio', 1211, 15),

-- Municipios de Zulia (Estado ID: 24)
(105, 'Maracaibo', 'Municipio', 4001, 24),
(106, 'San Francisco', 'Municipio', 4004, 24),
(107, 'Cabimas', 'Municipio', 4013, 24),
(108, 'Lagunillas', 'Municipio', 4019, 24),
(109, 'Mara', 'Municipio', 4005, 24),

-- Municipios de Carabobo (Estado ID: 8)
(110, 'Valencia', 'Municipio', 2001, 8),
(111, 'Puerto Cabello', 'Municipio', 2050, 8),
(112, 'Naguanagua', 'Municipio', 2005, 8),
(113, 'San Diego', 'Municipio', 2006, 8),
(114, 'Guacara', 'Municipio', 2015, 8);


-- 4. LOS BISNIETOS: PARROQUIAS (IDs en rango 1000+ para evitar colisiones)
-- Cada municipio de arriba recibe exactamente 5 parroquias/sectores para cumplir el 5x5
INSERT INTO Lugar (idLugar, nombre, tipo, codigoPostal, Lugar_idLugar) VALUES
-- Parroquias de Chacao (Municipio ID: 100)
(1000, 'Chacao Centro', 'Parroquia', 1060, 100),
(1001, 'Altamira', 'Parroquia', 1062, 100),
(1002, 'Los Palos Grandes', 'Parroquia', 1060, 100),
(1003, 'El Rosal', 'Parroquia', 1060, 100),
(1004, 'La Castellana', 'Parroquia', 1060, 100),

-- Parroquias de Baruta (Municipio ID: 101)
(1005, 'El Cafetal', 'Parroquia', 1061, 101),
(1006, 'Las Minas de Baruta', 'Parroquia', 1080, 101),
(1007, 'Nuestra Señora del Rosario', 'Parroquia', 1080, 101),
(1008, 'Caurimare', 'Parroquia', 1061, 101),
(1009, 'Prados del Este', 'Parroquia', 1080, 101),

-- Parroquias de Sucre (Municipio ID: 102)
(1010, 'Petare', 'Parroquia', 1070, 102),
(1011, 'Leoncio Martínez', 'Parroquia', 1071, 102),
(1012, 'Mariche', 'Parroquia', 1073, 102),
(1013, 'Caucagüita', 'Parroquia', 1075, 102),
(1014, 'La Dolorita', 'Parroquia', 1076, 102),

-- Parroquias de El Hatillo (Municipio ID: 103)
(1015, 'El Hatillo Centro', 'Parroquia', 1081, 103),
(1016, 'La Unión', 'Parroquia', 1081, 103),
(1017, 'Los Naranjos', 'Parroquia', 1081, 103),
(1018, 'Oripoto', 'Parroquia', 1081, 103),
(1019, 'El Volcán', 'Parroquia', 1081, 103),

-- Parroquias de Plaza (Municipio ID: 104)
(1020, 'Guarenas', 'Parroquia', 1211, 104),
(1021, 'Vicente Emilio Sojo', 'Parroquia', 1211, 104),
(1022, 'Nueva Casarapa', 'Parroquia', 1212, 104),
(1023, 'Oropeza Castillo', 'Parroquia', 1211, 104),
(1024, 'Las Clavellinas', 'Parroquia', 1211, 104),

-- Parroquias de Maracaibo (Municipio ID: 105)
(1025, 'Olegario Villalobos', 'Parroquia', 4001, 105),
(1026, 'Juana de Ávila', 'Parroquia', 4002, 105),
(1027, 'Coquivacoa', 'Parroquia', 4001, 105),
(1028, 'Chiquinquirá', 'Parroquia', 4003, 105),
(1029, 'Cacique Mara', 'Parroquia', 4001, 105);