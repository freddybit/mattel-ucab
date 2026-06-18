
-- ==============================================================================
-- 1. DEPARTAMENTO (15 áreas clave de Mattel)
-- ==============================================================================
INSERT INTO Departamento (idDepartamento, nombre, direccion) VALUES
(1, 'Investigación y Desarrollo (I+D)', 'Torre Creativa, Piso 10'),
(2, 'Escultura y Modelado 3D', 'Torre Creativa, Piso 9'),
(3, 'Ingeniería de Materiales', 'Laboratorio Central, Ala Norte'),
(4, 'Matricería y Moldes', 'Planta de Manufactura, Sector A'),
(5, 'Inyección de Plásticos', 'Planta de Manufactura, Sector B'),
(6, 'Ensamblaje y Articulación', 'Planta de Manufactura, Sector C'),
(7, 'Enraizado y Estilismo de Cabello', 'Planta de Manufactura, Sector D'),
(8, 'Pintura Facial y Acabados', 'Planta de Manufactura, Sector E'),
(9, 'Confección Textil y Vestuario', 'Taller de Costura Principal'),
(10, 'Control de Calidad (QA)', 'Laboratorio Central, Ala Sur'),
(11, 'Empaquetado y Blíster', 'Centro de Distribución, Zona 1'),
(12, 'Logística y Despachos B2B', 'Centro de Distribución, Zona 2'),
(13, 'Marketing y Mercado B2C', 'Torre Corporativa, Piso 15'),
(14, 'Gestión de Subastas y Coleccionistas', 'Torre Corporativa, Piso 16'),
(15, 'Talento Humano y Nómina', 'Torre Corporativa, Piso 2');

-- ==============================================================================
-- 2. PUESTO DE TRABAJO (15 roles operativos)
-- ==============================================================================
INSERT INTO PuestoTrabajo (id, nombre, descripcion) VALUES
(1, 'Director de Diseño PLM', 'Lidera la conceptualización de nuevas líneas de Barbie.'),
(2, 'Escultor Digital Senior', 'Crea modelos 3D y aprueba mallas para mecanizado.'),
(3, 'Ingeniero Químico de Polímeros', 'Formula las mezclas de PVC, ABS y colorantes.'),
(4, 'Técnico Tornero CNC', 'Fabrica los moldes de acero inoxidable para inyección.'),
(5, 'Operador de Inyectora', 'Maneja la maquinaria pesada de inyección de plástico.'),
(6, 'Técnico de Enraizado', 'Opera las máquinas de costura capilar en las cabezas.'),
(7, 'Artista de Tampografía', 'Aplica la pintura de ojos, labios y cejas con precisión.'),
(8, 'Ensamblador de Línea', 'Une torsos, extremidades y articulaciones de presión.'),
(9, 'Costurera a Escala', 'Cose la indumentaria miniatura (1/6) de las muñecas.'),
(10, 'Inspector de Estrés ASTM', 'Aplica pruebas de fuerza y toxicidad a los prototipos.'),
(11, 'Empacador de Línea Final', 'Coloca el producto en su blíster e inserta manuales.'),
(12, 'Coordinador de Flota Logística', 'Supervisa despachos a retailers (Target, Walmart).'),
(13, 'Analista de Mercado Secundario', 'Fija precios base para el módulo de subastas BFC.'),
(14, 'Especialista en Reclutamiento', 'Contrata personal de planta e ingenieros.'),
(15, 'Analista de Sistemas (IT)', 'Mantiene activo el sistema Dream Legacy y la BD.');

-- ==============================================================================
-- 3. PROFESIÓN (15 perfiles académicos)
-- ==============================================================================
INSERT INTO Profesion (idProfesion, nombre, descripcion) VALUES
(1, 'Diseñador Industrial', 'Especialista en ergonomía y diseño de productos de consumo.'),
(2, 'Ingeniero Industrial', 'Experto en optimización de líneas de producción y tiempos.'),
(3, 'Ingeniero de Materiales', 'Conocimientos avanzados en termoplásticos y resinas.'),
(4, 'Artista Plástico / Escultor', 'Habilidad manual y digital para anatomía a escala.'),
(5, 'Técnico Mecánico', 'Mantenimiento preventivo y correctivo de maquinaria pesada.'),
(6, 'Técnico Superior en Logística', 'Manejo de inventarios, Kardex y rutas de distribución.'),
(7, 'Diseñador de Modas', 'Creación de patrones y selección de textiles.'),
(8, 'Ingeniero Químico', 'Formulación de pinturas no tóxicas y tintes capilares.'),
(9, 'Licenciado en Mercadeo', 'Estrategias de penetración y comportamiento del consumidor.'),
(10, 'Licenciado en Administración', 'Manejo de presupuestos operativos y costos de producción.'),
(11, 'Psicólogo Industrial', 'Evaluación de clima laboral y pruebas psicotécnicas.'),
(12, 'Médico Ocupacional', 'Salud en planta y prevención de riesgos laborales.'),
(13, 'Ingeniero en Computación', 'Desarrollador Full Stack (Angular/C#) e infraestructura.'),
(14, 'Abogado Corporativo', 'Gestión de patentes de moldes y derechos de autor.'),
(15, 'Operario Integral Certificado', 'Personal capacitado en múltiples estaciones de ensamblaje.');

-- ==============================================================================
-- 4. TURNO y HORARIO (Gestión de tiempo en Planta)
-- ==============================================================================
INSERT INTO Turno (idTurno, porcentajeRecargo, nombre) VALUES
(1, 0, 'Diurno - Administrativo'), (2, 0, 'Diurno - Planta Línea 1'), (3, 0, 'Diurno - Planta Línea 2'),
(4, 15, 'Mixto - Planta Línea 1'), (5, 15, 'Mixto - Planta Línea 2'), (6, 15, 'Mixto - Logística B2B'),
(7, 30, 'Nocturno - Inyección Continua'), (8, 30, 'Nocturno - Mantenimiento'), (9, 30, 'Nocturno - Seguridad'),
(10, 50, 'Fin de Semana - Sábado Mañana'), (11, 50, 'Fin de Semana - Sábado Tarde'), (12, 75, 'Fin de Semana - Domingo'),
(13, 100, 'Feriado - Operación Mínima'), (14, 0, 'Rotativo A (I+D)'), (15, 0, 'Rotativo B (I+D)');

INSERT INTO Horario (idHorario, dia, horaInicio, horaFin) VALUES
(1, 'Lunes', '08:00:00', '17:00:00'), (2, 'Martes', '08:00:00', '17:00:00'), (3, 'Miércoles', '08:00:00', '17:00:00'),
(4, 'Jueves', '08:00:00', '17:00:00'), (5, 'Viernes', '08:00:00', '17:00:00'), (6, 'Lunes', '14:00:00', '22:00:00'),
(7, 'Martes', '14:00:00', '22:00:00'), (8, 'Miércoles', '14:00:00', '22:00:00'), (9, 'Jueves', '14:00:00', '22:00:00'),
(10, 'Viernes', '14:00:00', '22:00:00'), (11, 'Lunes', '22:00:00', '06:00:00'), (12, 'Martes', '22:00:00', '06:00:00'),
(13, 'Miércoles', '22:00:00', '06:00:00'), (14, 'Sábado', '08:00:00', '14:00:00'), (15, 'Domingo', '08:00:00', '14:00:00');

INSERT INTO TurnoHorario (idTurnoHorario, Horario_idHorario, Turno_idTurno) VALUES
(1, 1, 1), (2, 2, 1), (3, 3, 1), (4, 4, 1), (5, 5, 1), -- Diurno Admin (L-V)
(6, 6, 4), (7, 7, 4), (8, 8, 4), (9, 9, 4), (10, 10, 4), -- Mixto Planta (L-V)
(11, 11, 7), (12, 12, 7), (13, 13, 7), (14, 14, 10), (15, 15, 12); -- Nocturno y Fines de semana

-- ==============================================================================
-- 5. FASE Y PRUEBA (Cruzadas con los Diseños que hicimos antes)
-- ==============================================================================
INSERT INTO Fase (idFase, nombreFase, descripcionFase, Diseño_idDiseño) VALUES
(1, 'Conceptualización', 'Creación del moodboard y referencias históricas.', 1),
(2, 'Esculpido Facial', 'Modelado en arcilla o 3D del molde del rostro.', 2),
(3, 'Aprobación de Patrón', 'Selección de telas y colores corporativos.', 3),
(4, 'Prototipo Resina', 'Impresión 3D inicial para validar articulaciones.', 4),
(5, 'Mecanizado de Moldes', 'Corte CNC del acero para la inyectora.', 5),
(6, 'Prueba de Inyección', 'Inyección del primer lote (First Shot) para ajuste.', 6),
(7, 'Enraizado Piloto', 'Prueba de densidad capilar en la cabeza base.', 7),
(8, 'Tampografía Facial', 'Ajuste de los tampones de silicona para los ojos.', 8),
(9, 'Producción Masiva', 'Inicio de la cadena de inyección ininterrumpida.', 9),
(10, 'Ensamblaje Mecánico', 'Unión a presión de extremidades y torsos.', 10),
(11, 'Vestido y Peinado', 'Acabado manual de la muñeca en línea.', 11),
(12, 'Control de Calidad Final', 'Inspección visual antes de sellar el blíster.', 12),
(13, 'Empaquetado', 'Sellado térmico del juguete en caja de cartón/PET.', 13),
(14, 'Paletización', 'Embalaje en cajas maestras para B2B.', 14),
(15, 'Lanzamiento Comercial', 'Liberación del producto al mercado secundario.', 15);

-- Nota: La tabla usa tipoPrueba ('Tecnica', 'Psicologica', 'Medica'). Aplican al Diseño y al Empleado.
INSERT INTO Prueba (idPrueba, nombrePrueba, descripcionPrueba, resultado, tipoPrueba, Diseño_idDiseño) VALUES
(1, 'Tensión de Cuello (Norma ASTM)', 'Verifica que la cabeza no se desprenda con 10kg de fuerza.', 'Aprobado', 'Tecnica', 1),
(2, 'Toxicidad de Pintura', 'Prueba química de plomo en labios y ojos.', 'Aprobado', 'Tecnica', 2),
(3, 'Caída Libre (Drop Test)', 'Caída desde 1.5m para asegurar que el ABS no se astilla.', 'Reprobado', 'Tecnica', 3),
(4, 'Combustión de Cabello', 'Prueba térmica sobre el Kanekalon.', 'Aprobado', 'Tecnica', 4),
(5, 'Examen Visual de Operario', 'Prueba oftalmológica para pintores de tampografía.', 'Aprobado', 'Medica', 5),
(6, 'Evaluación de Estrés Térmico', 'Comportamiento del plástico en contenedores a 50°C.', 'Aprobado', 'Tecnica', 6),
(7, 'Prueba Psicométrica de Ensamblaje', 'Test de destreza y concentración bajo presión.', 'Aprobado', 'Psicologica', 7),
(8, 'Audiometría Anual', 'Examen obligatorio para operadores de inyectoras.', 'Aprobado', 'Medica', 8),
(9, 'Resistencia de Articulaciones', '10,000 ciclos de doblez en la línea Made to Move.', 'Aprobado', 'Tecnica', 17),
(10, 'Prueba de Flotabilidad', 'Verificación de sellado en vehículos acuáticos.', 'Reprobado', 'Tecnica', 26),
(11, 'Prueba de Liderazgo', 'Test para aspirantes a Gerentes de Línea.', 'Aprobado', 'Psicologica', 11),
(12, 'Examen Toxicológico', 'Prueba antidoping obligatoria en Planta.', 'Aprobado', 'Medica', 12),
(13, 'Lavado de Textiles', 'Ciclos de lavado para probar decoloración del vestido.', 'Aprobado', 'Tecnica', 13),
(14, 'Manejo de Montacargas', 'Examen práctico de conducción en almacén.', 'Aprobado', 'Tecnica', 14),
(15, 'Prueba de Funcionamiento LED', 'Verificación de circuitos en juguetes electrónicos.', 'Aprobado', 'Tecnica', 31);

-- ==============================================================================
-- 6. TABLAS TRANSACCIONALES (Las que unen a los Empleados con el sistema)
-- Asumimos que existen los Empleados del 1 al 15 gracias a tu importación de Mockaroo
-- ==============================================================================

INSERT INTO CurriculumVitae (idCurriculumVitae, añoDeAsignacion, Profesion_idProfesion, Diseño_idDiseño) VALUES
(1, 2020, 1, 1), (2, 2021, 2, 2), (3, 2022, 3, 3), (4, 2019, 4, 4), (5, 2023, 5, 5),
(6, 2018, 6, 6), (7, 2024, 7, 7), (8, 2020, 8, 8), (9, 2021, 9, 9), (10, 2022, 10, 10),
(11, 2017, 11, 11), (12, 2023, 12, 12), (13, 2024, 13, 13), (14, 2019, 14, 14), (15, 2020, 15, 15);

-- ==============================================================================
-- 1. TURNO EMPLEADO (Fechas estáticas correspondientes a Octubre 2023)
-- ==============================================================================

INSERT INTO TurnoEmpleado (idTurnoEmpleado, fecha, feriado, Empleado_idEmpleado, Turno_idTurno) VALUES
(1, '2023-10-02', 'N', 1, 1), (2, '2023-10-03', 'N', 2, 2), (3, '2023-10-04', 'N', 3, 3),
(4, '2023-10-05', 'N', 4, 4), (5, '2023-10-06', 'N', 5, 5), (6, '2023-10-09', 'N', 6, 6),
(7, '2023-10-10', 'N', 7, 7), (8, '2023-10-11', 'N', 8, 8), (9, '2023-10-12', 'N', 9, 9),
(10, '2023-10-14', 'Y', 10, 10), (11, '2023-10-15', 'Y', 11, 11), (12, '2023-10-21', 'Y', 12, 12),
(13, '2023-10-22', 'Y', 13, 13), (14, '2023-10-23', 'N', 14, 14), (15, '2023-10-24', 'N', 15, 15);

-- ==============================================================================
-- 2. ASISTENCIA (Concordando con las fechas exactas de sus turnos)
-- ==============================================================================
INSERT INTO Asistencia (idAsistencia, fecha, horaEntrada, horaSalida, Empleado_idEmpleado) VALUES
(1, '2023-10-02', '08:00:00', '17:05:00', 1), (2, '2023-10-03', '07:55:00', '17:00:00', 2),
(3, '2023-10-04', '08:10:00', '17:15:00', 3), (4, '2023-10-05', '13:50:00', '22:00:00', 4),
(5, '2023-10-06', '14:00:00', '22:10:00', 5), (6, '2023-10-09', '14:05:00', '22:00:00', 6),
(7, '2023-10-10', '21:55:00', '06:00:00', 7), (8, '2023-10-11', '22:00:00', '06:05:00', 8),
(9, '2023-10-12', '22:00:00', '06:00:00', 9), (10, '2023-10-14', '08:00:00', '14:00:00', 10),
(11, '2023-10-15', '08:00:00', '14:00:00', 11), (12, '2023-10-21', '08:00:00', '14:00:00', 12),
(13, '2023-10-22', '08:00:00', '12:00:00', 13), (14, '2023-10-23', '08:00:00', '17:00:00', 14),
(15, '2023-10-24', '08:00:00', '17:00:00', 15);

-- ==============================================================================
-- 3. FASE EMPLEADO (Fechas estáticas de proyectos de 2023)
-- ==============================================================================
INSERT INTO FaseEmpleado (idFaseEmpleado, fechaInicio, fechaFin, Empleado_idEmpleado, Fase_idFase) VALUES
(1, '2023-01-10', '2023-02-15', 1, 1), (2, '2023-02-16', '2023-04-20', 2, 2),
(3, '2023-04-21', '2023-05-10', 3, 3), (4, '2023-05-11', '2023-06-30', 4, 4),
(5, '2023-07-01', '2023-08-15', 5, 5), (6, '2023-08-16', '2023-09-01', 6, 6),
(7, '2023-09-02', '2023-09-15', 7, 7), (8, '2023-09-16', '2023-10-05', 8, 8),
(9, '2023-10-06', NULL, 9, 9), (10, '2023-10-10', NULL, 10, 10),
(11, '2023-10-15', NULL, 11, 11), (12, '2023-10-20', NULL, 12, 12),
(13, '2023-10-25', NULL, 13, 13), (14, '2023-11-01', NULL, 14, 14),
(15, '2023-11-05', NULL, 15, 15);

-- ==============================================================================
-- 4. PRUEBA EMPLEADO (Reemplazando los CURRENT_DATE - X por fechas fijas)
-- ==============================================================================
INSERT INTO PruebaEmpleado (idPruebaEmpleado, fechaInicio, fechaFin, Prueba_idPrueba, Empleado_idEmpleado) VALUES
(1, '2023-03-01', '2023-03-02', 5, 1), (2, '2023-03-15', '2023-03-16', 8, 2),
(3, '2023-04-05', '2023-04-06', 12, 3), (4, '2023-05-20', '2023-05-21', 11, 4),
(5, '2023-06-10', '2023-06-11', 7, 5), (6, '2023-07-12', '2023-07-13', 5, 6),
(7, '2023-08-05', '2023-08-06', 8, 7), (8, '2023-09-01', '2023-09-02', 12, 8),
(9, '2023-09-20', '2023-09-21', 11, 9), (10, '2023-10-01', '2023-10-02', 7, 10),
(11, '2023-10-10', '2023-10-11', 5, 11), (12, '2023-10-18', '2023-10-19', 8, 12),
(13, '2023-11-02', '2023-11-03', 12, 13), (14, '2023-11-15', '2023-11-16', 11, 14),
(15, '2023-11-20', '2023-11-21', 7, 15);