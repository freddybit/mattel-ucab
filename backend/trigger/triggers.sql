-- ==============================================================================
-- TRIGGERS, FUNCTIONS Y STORED PROCEDURES unificados - MattelUCAB
-- Autores: Freddy (Seguridad) + Andrea (B2B/B2C, Subastas, Logistica)
--
-- IMPORTANTE: Ejecutar DESPUES de create.sql, alter.sql e insert.sql
-- ==============================================================================

-- ==============================================================================
-- DROP (Limpieza en cascada)
-- ==============================================================================

-- Freddy - Seguridad
DROP TRIGGER IF EXISTS trg_auditar_rol_usuario ON Usuario;
DROP FUNCTION IF EXISTS fn_validar_rol_con_permisos();
DROP PROCEDURE IF EXISTS sp_inicializar_matriz_seguridad();

-- Andrea - B2B/B2C, Subastas, Logistica
DROP TRIGGER IF EXISTS trg_validar_puja_subasta ON Puja;
DROP TRIGGER IF EXISTS trg_validar_limite_credito ON OrdenCompra;
DROP FUNCTION IF EXISTS fn_validar_puja_subasta();
DROP FUNCTION IF EXISTS fn_validar_limite_credito();
DROP PROCEDURE IF EXISTS sp_registrar_conciliacion(NUMERIC, NUMERIC, NUMERIC, NUMERIC);
DROP PROCEDURE IF EXISTS sp_generar_comision_venta(NUMERIC, NUMERIC);
DROP PROCEDURE IF EXISTS sp_cerrar_subasta(NUMERIC);

-- ==============================================================================
-- FREDDY: LOGICA DE SEGURIDAD
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
    INSERT INTO Permiso (idPermiso, nombre) VALUES (nextval('Permiso_SEQ'), 'CONSULTAR') RETURNING idPermiso INTO v_idPerm_Consultar;
    INSERT INTO Permiso (idPermiso, nombre) VALUES (nextval('Permiso_SEQ'), 'MODIFICAR') RETURNING idPermiso INTO v_idPerm_Modificar;
    INSERT INTO Permiso (idPermiso, nombre) VALUES (nextval('Permiso_SEQ'), 'CREAR') RETURNING idPermiso INTO v_idPerm_Crear;
    INSERT INTO Permiso (idPermiso, nombre) VALUES (nextval('Permiso_SEQ'), 'BORRAR') RETURNING idPermiso INTO v_idPerm_Borrar;

    INSERT INTO Rol (idRol, nombre, descripcion) VALUES (nextval('Rol_SEQ'), 'Administrador', 'Acceso total al sistema Dream Legacy') RETURNING idRol INTO v_idRol_Admin;
    INSERT INTO Rol (idRol, nombre, descripcion) VALUES (nextval('Rol_SEQ'), 'Ingeniero I+D', 'Gestion de disenhos y moldes') RETURNING idRol INTO v_idRol_Ingeniero;
    INSERT INTO Rol (idRol, nombre, descripcion) VALUES (nextval('Rol_SEQ'), 'Analista Mercado', 'Solo lectura de reportes') RETURNING idRol INTO v_idRol_Analista;

    INSERT INTO RolPermiso (idRolPermiso, Rol_idRol, Permisos_idPermiso) VALUES
    (nextval('RolPermiso_SEQ'), v_idRol_Admin, v_idPerm_Consultar),
    (nextval('RolPermiso_SEQ'), v_idRol_Admin, v_idPerm_Modificar),
    (nextval('RolPermiso_SEQ'), v_idRol_Admin, v_idPerm_Crear),
    (nextval('RolPermiso_SEQ'), v_idRol_Admin, v_idPerm_Borrar);

    INSERT INTO RolPermiso (idRolPermiso, Rol_idRol, Permisos_idPermiso) VALUES
    (nextval('RolPermiso_SEQ'), v_idRol_Ingeniero, v_idPerm_Consultar),
    (nextval('RolPermiso_SEQ'), v_idRol_Ingeniero, v_idPerm_Modificar),
    (nextval('RolPermiso_SEQ'), v_idRol_Ingeniero, v_idPerm_Crear);

    INSERT INTO RolPermiso (idRolPermiso, Rol_idRol, Permisos_idPermiso) VALUES
    (nextval('RolPermiso_SEQ'), v_idRol_Analista, v_idPerm_Consultar);

    COMMIT;
END;
$$;

-- ==============================================================================
-- ANDREA: LOGICA B2B/B2C, SUBASTAS, LOGISTICA Y FINANZAS
-- ==============================================================================

CREATE OR REPLACE FUNCTION fn_validar_puja_subasta()
RETURNS TRIGGER AS $$
DECLARE
    v_precio_base       NUMERIC;
    v_incremento_minimo NUMERIC;
    v_fecha_inicio      DATE;
    v_fecha_fin         DATE;
    v_monto_maximo      NUMERIC;
BEGIN
    SELECT precioBase, incrementoMinimo, fechaHoraInicio, fechaHoraFin
    INTO v_precio_base, v_incremento_minimo, v_fecha_inicio, v_fecha_fin
    FROM Subasta
    WHERE idSubasta = NEW.Subasta_idSubasta;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Subasta % no existe.', NEW.Subasta_idSubasta;
    END IF;

    IF CURRENT_DATE < v_fecha_inicio OR CURRENT_DATE > v_fecha_fin THEN
        RAISE EXCEPTION 'La subasta % no esta activa en la fecha actual.', NEW.Subasta_idSubasta;
    END IF;

    SELECT COALESCE(MAX(monto), v_precio_base)
    INTO v_monto_maximo
    FROM Puja
    WHERE Subasta_idSubasta = NEW.Subasta_idSubasta;

    IF NEW.monto < v_monto_maximo + v_incremento_minimo THEN
        RAISE EXCEPTION 'Puja invalida: el monto % debe ser al menos % (ultima puja + incremento).',
            NEW.monto, v_monto_maximo + v_incremento_minimo;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_puja_subasta
BEFORE INSERT ON Puja
FOR EACH ROW
EXECUTE FUNCTION fn_validar_puja_subasta();

-- Nota: fn_auditar_estado_orden_b2b eliminada porque
-- HistoricoEstado tiene columnas NOT NULL + CHECK contradictorio
-- que impiden cualquier insercion (ver Oracle DDL)

CREATE OR REPLACE FUNCTION fn_validar_limite_credito()
RETURNS TRIGGER AS $$
DECLARE
    v_limite_credito NUMERIC;
    v_deuda_actual   NUMERIC;
    v_monto_orden    NUMERIC;
BEGIN
    SELECT limiteCredito
    INTO v_limite_credito
    FROM ClienteJuridico
    WHERE idClienteJuridico = NEW.ClienteJuridico_idClienteJuridico;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Cliente juridico % no existe.', NEW.ClienteJuridico_idClienteJuridico;
    END IF;

    SELECT COALESCE(SUM(subTotal + impuestos), 0)
    INTO v_deuda_actual
    FROM OrdenCompra
    WHERE ClienteJuridico_idClienteJuridico = NEW.ClienteJuridico_idClienteJuridico
      AND idOrdenCompra <> COALESCE(NEW.idOrdenCompra, -1);

    v_monto_orden := NEW.subTotal + NEW.impuestos;

    IF v_deuda_actual + v_monto_orden > v_limite_credito THEN
        RAISE EXCEPTION 'Limite de credito excedido para cliente %. Disponible: %, solicitado: %.',
            NEW.ClienteJuridico_idClienteJuridico,
            v_limite_credito - v_deuda_actual,
            v_monto_orden;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_limite_credito
BEFORE INSERT OR UPDATE ON OrdenCompra
FOR EACH ROW
EXECUTE FUNCTION fn_validar_limite_credito();

CREATE OR REPLACE PROCEDURE sp_registrar_conciliacion(
    p_id_orden     NUMERIC,
    p_id_pago      NUMERIC,
    p_monto        NUMERIC,
    OUT p_id_conciliacion NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_monto_pago NUMERIC;
    v_monto_orden NUMERIC;
BEGIN
    SELECT monto INTO v_monto_pago
    FROM PagoJuridico
    WHERE idPago = p_id_pago;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Pago juridico % no existe.', p_id_pago;
    END IF;

    SELECT subTotal + impuestos INTO v_monto_orden
    FROM OrdenCompra
    WHERE idOrdenCompra = p_id_orden;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Orden de compra % no existe.', p_id_orden;
    END IF;

    IF p_monto <= 0 OR p_monto > v_monto_pago THEN
        RAISE EXCEPTION 'Monto a conciliar invalido: %.', p_monto;
    END IF;

    p_id_conciliacion := nextval('Conciliacion_SEQ');

    INSERT INTO Conciliacion (
        idConciliacion, montoAplicado, fechaAplicacion,
        OrdenCompra_idOrdenCompra, PagoJuridico_idPago
    ) VALUES (
        p_id_conciliacion, p_monto, CURRENT_DATE,
        p_id_orden, p_id_pago
    );

END;
$$;

CREATE OR REPLACE PROCEDURE sp_generar_comision_venta(
    p_id_orden           NUMERIC,
    p_porcentaje_comision NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_subtotal NUMERIC;
    v_monto_comision NUMERIC;
BEGIN
    IF p_porcentaje_comision <= 0 OR p_porcentaje_comision > 100 THEN
        RAISE EXCEPTION 'Porcentaje de comision invalido: %.', p_porcentaje_comision;
    END IF;

    SELECT subTotal INTO v_subtotal
    FROM OrdenCompra
    WHERE idOrdenCompra = p_id_orden;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Orden de compra % no existe.', p_id_orden;
    END IF;

    v_monto_comision := ROUND(v_subtotal * p_porcentaje_comision / 100, 2);

    INSERT INTO ComisionVenta (
        idComisionVenta, montoComision, fecha, OrdenCompra_idOrdenCompra
    ) VALUES (
        nextval('ComisionVenta_SEQ'), v_monto_comision, CURRENT_DATE, p_id_orden
    );
END;
$$;

CREATE OR REPLACE PROCEDURE sp_cerrar_subasta(p_id_subasta NUMERIC)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_puja_ganadora NUMERIC;
    v_id_cliente       NUMERIC;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Subasta WHERE idSubasta = p_id_subasta) THEN
        RAISE EXCEPTION 'Subasta % no existe.', p_id_subasta;
    END IF;

    SELECT idPuja, ClienteNatural_idClienteNatural
    INTO v_id_puja_ganadora, v_id_cliente
    FROM Puja
    WHERE Subasta_idSubasta = p_id_subasta
    ORDER BY monto DESC, fechaHora
    LIMIT 1;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'La subasta % no tiene pujas registradas.', p_id_subasta;
    END IF;

    INSERT INTO HistoricoEstatus (
        idHistoricoEstatus, fechaHoraInicio, Estatus_idEstatus, fechaHoraFin,
        Subasta_idSubasta, Puja_idPuja, Puja_idClienteNatural,
        Puja_idSubasta, OrdenVenta_idOrdenVenta, Compra_idCompra
    ) VALUES (
        nextval('HistoricoEstatus_SEQ'), CURRENT_TIMESTAMP, 4, CURRENT_TIMESTAMP,
        p_id_subasta, v_id_puja_ganadora, v_id_cliente,
        p_id_subasta, NULL, NULL
    );
END;
$$;

-- ==============================================================================
-- SEEDING: Matriz de seguridad (Freddy)
-- ==============================================================================
CALL sp_inicializar_matriz_seguridad();

-- ==============================================================================
-- SEEDING: Usuario administrador (Freddy)
-- ==============================================================================
INSERT INTO Empleado (
    idEmpleado, cedula, pNombre, sNombre, pApellido, sApellido,
    fechaNacimiento, direccion, Lugar_idLugar
) VALUES (
    nextval('Empleado_SEQ'), 30123456, 'Freddy', NULL, 'Ingeniero', NULL,
    '2002-06-04', 'UCAB Montalban', 56
);

INSERT INTO Usuario (
    idUsuario, nombreUsuario, correoElectronico, contraseña, estado,
    fechaRegistro, Empleado_idEmpleado, Rol_idRol
) VALUES(
    nextval('Usuario_SEQ'), 'admin_freddy', 'freddy@mattelucab.com',
    'hashed_pass_123', 'ACTIVO', CURRENT_DATE,
    (SELECT idEmpleado FROM Empleado WHERE pNombre = 'Freddy' LIMIT 1),
    (SELECT idRol FROM Rol WHERE nombre = 'Administrador' LIMIT 1)
),
(
    nextval('Usuario_SEQ'), 'ingeniero_01', 'id@mattelucab.com',
    'hashed_pass_456', 'ACTIVO', CURRENT_DATE,
    (SELECT idEmpleado FROM Empleado WHERE pNombre = 'Freddy' LIMIT 1),
    (SELECT idRol FROM Rol WHERE nombre = 'Ingeniero I+D' LIMIT 1)
);
