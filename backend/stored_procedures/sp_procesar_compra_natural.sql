CREATE OR REPLACE PROCEDURE sp_procesar_compra_natural(
    p_id_cliente               NUMERIC,
    p_id_unidad_producida      NUMERIC,
    p_precio_unitario          NUMERIC,
    p_id_metodo_pago           NUMERIC,
    p_columna_metodo_pago      VARCHAR,
    p_id_descuento             NUMERIC DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_compra                NUMERIC;
    v_id_detalle_compra_natural NUMERIC;
    v_id_pago_natural          NUMERIC;
    v_numero_compra            NUMERIC;
    v_subtotal                 NUMERIC;
    v_total_pagar              NUMERIC;
    v_tabla_metodo_pago        VARCHAR;
    v_exists                   NUMERIC;
BEGIN
    -- Validar columna de metodo de pago
    v_tabla_metodo_pago := CASE p_columna_metodo_pago
        WHEN 'Cheque_id'   THEN 'ChequeCorporativo'
        WHEN 'Cripto_id'   THEN 'CriptoActivo'
        WHEN 'Efectivo_id' THEN 'Efectivo'
        WHEN 'PayPal_id'   THEN 'PayPal'
        WHEN 'Swift_id'    THEN 'Swift'
        WHEN 'TarjCred_id' THEN 'TarjetaCredito'
        WHEN 'TarjDeb_id'  THEN 'TarjetaDebito'
    END;

    IF v_tabla_metodo_pago IS NULL THEN
        RAISE EXCEPTION 'Columna de metodo de pago invalida: %', p_columna_metodo_pago;
    END IF;

    -- Validar que el metodo de pago exista en su tabla
    EXECUTE format('SELECT 1 FROM %I WHERE idMetodoPago = $1', v_tabla_metodo_pago)
        INTO v_exists USING p_id_metodo_pago;

    IF v_exists IS NULL THEN
        RAISE EXCEPTION 'El metodo de pago % no existe en %', p_id_metodo_pago, v_tabla_metodo_pago;
    END IF;

    -- Generar IDs usando las secuencias del esquema
    v_id_compra := NEXTVAL('Compra_SEQ');
    v_id_detalle_compra_natural := NEXTVAL('DetalleCompraNatural_SEQ');
    v_id_pago_natural := NEXTVAL('PagoNatural_SEQ');

    v_numero_compra := v_id_compra;
    v_subtotal      := p_precio_unitario;
    v_total_pagar   := p_precio_unitario;

    -- Insertar en Compra
    INSERT INTO Compra (idCompra, fechaHora, numeroCompra, totalPagar, subTotal,
                        ClienteNatural_idClienteNatural,
                        TipoUbicacionStock_idTipoUbicacionStock)
    VALUES (v_id_compra, CURRENT_DATE, v_numero_compra, v_total_pagar, v_subtotal,
            p_id_cliente, 1);

    -- Insertar en DetalleCompraNatural
    INSERT INTO DetalleCompraNatural (idDetalleCompraNatural, precioUnitario,
                                      UnidadProducida_idUnidadProducidad,
                                      Compra_idCompra)
    VALUES (v_id_detalle_compra_natural, p_precio_unitario,
            p_id_unidad_producida, v_id_compra);

    -- Insertar en PagoNatural con columna dinamica
    EXECUTE format(
        'INSERT INTO PagoNatural (idPagoNatural, Compra_idCompra, %I)
         VALUES ($1, $2, $3)',
        p_columna_metodo_pago
    ) USING v_id_pago_natural, v_id_compra, p_id_metodo_pago;

    -- Insertar en CompraDescuento si aplica
    IF p_id_descuento IS NOT NULL THEN
        INSERT INTO CompraDescuento (idCompraDescuento, monto,
                                     Compra_idCompra, Descuento_idDescuento)
        VALUES (NEXTVAL('CompraDescuento_SEQ'), 0,
                v_id_compra, p_id_descuento);
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error en sp_procesar_compra_natural (%): %',
                      SQLSTATE, SQLERRM;
        RAISE;
END;
$$;
