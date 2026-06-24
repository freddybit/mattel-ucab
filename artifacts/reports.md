# REPORTES

## REPORTE #1

* Comparativa entre la cantidad de variantes de producto generadas a partir de un mismo Face Sculpt y el total de paletas que dichas variantes ocupan actualmente en los Hubs Regionales.

### SQL | POSTGRESQL

```POSTGRESQL

    CREATE OR REPLACE VIEW vw_rpt_face_sculpt_hubs AS
    SELECT 
        l.nombre AS "hubRegional", 
        mr.nombre AS "faceSculpt", 
        COUNT(DISTINCT p.idProducto) AS "variantesAsociadas",
        COUNT(up.idUnidadProducidad) AS "skusUnitarios",
        CEIL(COUNT(up.idUnidadProducidad) / 12.0) AS "cajasMaster",
        CEIL((COUNT(up.idUnidadProducidad) / 12.0) / 40.0) AS "paletasEstimadas"
    FROM 
        MoldeRostro mr JOIN Diseño d ON mr.idMoldeRostro = d.MoldeRostro_idMoldeRostro
        JOIN Producto p ON d.idDiseño = p.Diseño_idDiseño
        JOIN UnidadProducida up ON p.LoteProduccion_idLote = up.LoteProduccion_idLote
        JOIN TipoUbicacionStock tus ON up.idUnidadProducidad = tus.UnidadProducida_idUnidadProducidad
        JOIN Lugar l ON tus.Lugar_idLugar = l.idLugar 
    WHERE tus.nombre = 'Hub Regional'
    GROUP BY l.idLugar, l.nombre, mr.idMoldeRostro, mr.nombre;

```

## REPORTE #2

* Detección de SKUs que comparten más del 80% de su receta (BOM) con otro SKUs.

### SQL | POSTGRESQL

```POSTGRESQL

    CREATE OR REPLACE VIEW vw_rpt_bom_similitud AS
    WITH SkuReceta AS (
        SELECT 
            Producto_idProducto AS sku, 
            array_agg(Pieza_idPieza ORDER BY Pieza_idPieza) AS piezas, 
            COUNT(Pieza_idPieza) AS total_piezas
        FROM PiezaProducto
        GROUP BY Producto_idProducto
    )
    SELECT 
        a.sku AS sku_base,
        b.sku AS sku_comparado,
        a.total_piezas AS piezas_sku_base,
        (SELECT COUNT(*) FROM (SELECT unnest(a.piezas) INTERSECT SELECT unnest(b.piezas)) x) AS piezas_compartidas,
        ROUND(((SELECT COUNT(*) FROM (SELECT unnest(a.piezas) INTERSECT SELECT unnest(b.piezas)) x)::numeric / a.total_piezas::numeric) * 100, 2) AS porcentaje_similitud
    FROM SkuReceta a
    JOIN SkuReceta b ON a.sku < b.sku
    WHERE a.total_piezas > 0 
    AND ROUND(((SELECT COUNT(*) FROM (SELECT unnest(a.piezas) INTERSECT SELECT unnest(b.piezas)) x)::numeric / a.total_piezas::numeric) * 100, 2) > 80;

```

## REPORTE #3

* Identificación de lotes de inventario físico ingresados al sistema cuyos SKUs asociados carezcan de definición completa en su taxonomía base (falta color de ojos, tipo de cuerpo, etc.).

### SQL | POSTGRESQL

```POSTGRESQL

    CREATE OR REPLACE VIEW vw_rpt_taxonomia_incompleta AS
    SELECT 
        lp.idLote AS numero_lote,
        p.idProducto AS sku_afectado,
        d.idDiseño AS genoma_base,
        CASE WHEN d.MoldeRostro_idMoldeRostro IS NULL THEN 'FALTA: Molde Rostro' ELSE 'OK' END AS estatus_rostro,
        CASE WHEN d.TonoPiel_idTonoPiel IS NULL THEN 'FALTA: Tono Piel' ELSE 'OK' END AS estatus_piel
    FROM LoteProduccion lp
    JOIN Producto p ON lp.idLote = p.LoteProduccion_idLote
    JOIN Diseño d ON p.Diseño_idDiseño = d.idDiseño
    WHERE d.MoldeRostro_idMoldeRostro IS NULL 
    OR d.TonoPiel_idTonoPiel IS NULL;

```
