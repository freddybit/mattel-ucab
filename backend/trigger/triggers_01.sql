-- ==============================================================================
-- 1. DROP (Limpieza en cascada)
-- ==============================================================================
DROP TRIGGER IF EXISTS trg_auditar_rol_usuario ON Usuario;
DROP FUNCTION IF EXISTS fn_validar_rol_con_permisos();
DROP PROCEDURE IF EXISTS sp_inicializar_matriz_seguridad();

-- ==============================================================================
-- 5. LÓGICA DE NEGOCIO (Stored Procedures y Triggers en PL/pgSQL)
-- ==============================================================================
CREATE OR REPLACE FUNCTION fn_validar_rol_con_permisos()
RETURNS TRIGGER AS $$
DECLARE
    v_cantidad_permisos INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_cantidad_permisos
    FROM RolPermiso
    WHERE Rol_idRol = NEW.Rol_idRol;

    IF v_cantidad_permisos = 0 THEN
        RAISE EXCEPTION 'Seguridad BD: El Rol asignado al usuario % no tiene permisos configurados.', NEW.nombreUsuario;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_auditar_rol_usuario
BEFORE INSERT OR UPDATE ON Usuario
FOR EACH ROW
EXECUTE FUNCTION fn_validar_rol_con_permisos();

CREATE OR REPLACE PROCEDURE sp_inicializar_matriz_seguridad()
LANGUAGE plpgsql
AS $$
DECLARE
    v_idRol_Admin NUMERIC;
    v_idRol_Ingeniero NUMERIC;
    v_idRol_Analista NUMERIC;
    v_idPerm_Consultar NUMERIC;
    v_idPerm_Modificar NUMERIC;
    v_idPerm_Crear NUMERIC;
    v_idPerm_Borrar NUMERIC;
BEGIN
    -- 1. Insertar Permisos llamando explícitamente a su secuencia
    INSERT INTO Permiso (idPermiso, nombre) VALUES (nextval('Permiso_SEQ'), 'CONSULTAR') RETURNING idPermiso INTO v_idPerm_Consultar;
    INSERT INTO Permiso (idPermiso, nombre) VALUES (nextval('Permiso_SEQ'), 'MODIFICAR') RETURNING idPermiso INTO v_idPerm_Modificar;
    INSERT INTO Permiso (idPermiso, nombre) VALUES (nextval('Permiso_SEQ'), 'CREAR') RETURNING idPermiso INTO v_idPerm_Crear;
    INSERT INTO Permiso (idPermiso, nombre) VALUES (nextval('Permiso_SEQ'), 'BORRAR') RETURNING idPermiso INTO v_idPerm_Borrar;

    -- 2. Insertar Roles llamando a su secuencia
    INSERT INTO Rol (idRol, nombre, descripcion) VALUES (nextval('Rol_SEQ'), 'Administrador', 'Acceso total al sistema Dream Legacy') RETURNING idRol INTO v_idRol_Admin;
    INSERT INTO Rol (idRol, nombre, descripcion) VALUES (nextval('Rol_SEQ'), 'Ingeniero I+D', 'Gestión de diseños y moldes') RETURNING idRol INTO v_idRol_Ingeniero;
    INSERT INTO Rol (idRol, nombre, descripcion) VALUES (nextval('Rol_SEQ'), 'Analista Mercado', 'Solo lectura de reportes') RETURNING idRol INTO v_idRol_Analista;

    -- 3. Conectar Rol con Permisos (Inyectando la secuencia de la tabla pivote)

    -- Administrador: 1, 2, 3, 4
    INSERT INTO RolPermiso (idRolPermiso, Rol_idRol, Permisos_idPermiso) VALUES
    (nextval('RolPermiso_SEQ'), v_idRol_Admin, v_idPerm_Consultar),
    (nextval('RolPermiso_SEQ'), v_idRol_Admin, v_idPerm_Modificar),
    (nextval('RolPermiso_SEQ'), v_idRol_Admin, v_idPerm_Crear),
    (nextval('RolPermiso_SEQ'), v_idRol_Admin, v_idPerm_Borrar);

    -- Ingeniero: 1, 2, 3
    INSERT INTO RolPermiso (idRolPermiso, Rol_idRol, Permisos_idPermiso) VALUES
    (nextval('RolPermiso_SEQ'), v_idRol_Ingeniero, v_idPerm_Consultar),
    (nextval('RolPermiso_SEQ'), v_idRol_Ingeniero, v_idPerm_Modificar),
    (nextval('RolPermiso_SEQ'), v_idRol_Ingeniero, v_idPerm_Crear);

    -- Analista: 1
    INSERT INTO RolPermiso (idRolPermiso, Rol_idRol, Permisos_idPermiso) VALUES
    (nextval('RolPermiso_SEQ'), v_idRol_Analista, v_idPerm_Consultar);

    COMMIT;
END;
$$;

-- ==============================================================================
-- 6. EJECUCIÓN DEL SEEDING
-- ==============================================================================
CALL sp_inicializar_matriz_seguridad();

-- Simulación de carga de Empleado (sin proveer ID, usa la secuencia)
INSERT INTO Empleado (
        idEmpleado,
        cedula,
        pNombre,
        sNombre,
        pApellido,
        sApellido,
        fechaNacimiento,
        direccion,
        Lugar_idLugar
    ) VALUES (
        nextval('Empleado_SEQ'),
        30123456,               -- cedula NOT NULL
        'Freddy',               -- pNombre NOT NULL
        NULL,                   -- sNombre (Permite nulos en tu DDL)
        'Ingeniero',            -- pApellido NOT NULL
        NULL,                   -- sApellido (Permite nulos)
        '2002-06-04',           -- fechaNacimiento NOT NULL
        'UCAB Montalban',       -- direccion NOT NULL
        56               -- Lugar_idLugar NOT NULL
    );

-- Los INSERTS desde Mockaroo deben venir SIN la columna idUsuario
INSERT INTO Usuario (
    idUsuario,
    nombreUsuario,
    correoElectronico,
    contraseña,
    estado,
    fechaRegistro,
    Empleado_idEmpleado,
    Rol_idRol
)
VALUES
(
    nextval('Usuario_SEQ'),
    'admin_freddy',
    'freddy@mattelucab.com',
    'hashed_pass_123',
    'ACTIVO',
    CURRENT_DATE,
    (SELECT idEmpleado FROM Empleado WHERE pNombre = 'Freddy' LIMIT 1),
    (SELECT idRol FROM Rol WHERE nombre = 'Administrador' LIMIT 1)
),
(
    nextval('Usuario_SEQ'),
    'ingeniero_01',
    'id@mattelucab.com',
    'hashed_pass_456',
    'ACTIVO',
    CURRENT_DATE,
    (SELECT idEmpleado FROM Empleado WHERE pNombre = 'Freddy' LIMIT 1),
    (SELECT idRol FROM Rol WHERE nombre = 'Ingeniero I+D' LIMIT 1)
);
