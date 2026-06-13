/* CLAVES FORANEAS (FK) */

ALTER TABLE AsignacionMeta ADD CONSTRAINT AsignacionMeta_ComisionVenta_FK FOREIGN KEY (ComisionVenta_idComisionVenta) REFERENCES ComisionVenta (idComisionVenta);
ALTER TABLE AsignacionMeta ADD CONSTRAINT AsignacionMeta_Empleado_FK FOREIGN KEY (Empleado_id) REFERENCES Empleado(id);
ALTER TABLE AsignacionMeta ADD CONSTRAINT AsignacionMeta_MetaMensual_FK FOREIGN KEY (MetaMensual_idMetaMensual) REFERENCES MetaMensual (idMetaMensual);

ALTER TABLE AutorDiseño ADD CONSTRAINT AutorDiseño_Diseño_FK FOREIGN KEY (Diseño_idDiseño) REFERENCES Diseño (idDiseño);
ALTER TABLE AutorDiseño ADD CONSTRAINT AutorDiseño_Empleado_FK FOREIGN KEY (Empleado_id) REFERENCES Empleado (id);
ALTER TABLE AutorDiseño ADD CONSTRAINT AutorDiseño_ObjetivoGlobal_FK FOREIGN KEY (ObjetivoGlobal_idObjetivoGlobal) REFERENCES ObjetivoGlobal (idObjetivoGlobal);
ALTER TABLE AutorDiseño ADD CONSTRAINT AutorDiseño_Regalia_FK FOREIGN KEY (Regalia_idRegalia) REFERENCES Regalia (idRegalia);

ALTER TABLE Caja ADD CONSTRAINT Caja_Stock_FK FOREIGN KEY (Stock_idStock, Stock_TipoUbicacionStock_idTipoUbicacionStock, Stock_UnidadProducida_idUnidadProducidad) REFERENCES Stock (idStock, TipoUbicacionStock_idTipoUbicacionStock, UnidadProducida_idUnidadProducidad);
ALTER TABLE Caja ADD CONSTRAINT Caja_TipoCaja_FK FOREIGN KEY ( TipoCaja_idTipoCaja) REFERENCES TipoCaja (idTipoCaja);

ALTER TABLE CarritoCompra ADD CONSTRAINT CarritoCompra_ClienteNatural_FK FOREIGN KEY (ClienteNatural_idClienteNatural) REFERENCES ClienteNatural (idClienteNatural);
ALTER TABLE CarritoCompra ADD CONSTRAINT CarritoCompra_Compra_FK FOREIGN KEY (Compra_idCompra) REFERENCES Compra(idCompra);

ALTER TABLE ClienteNatural ADD CONSTRAINT ClienteNatural_MonitorActividadSopechosa_FK FOREIGN KEY (MonitorActividadSopechosa_idMonitorActividadSopechosa) REFERENCES MonitorActividadSopechosa (idMonitorActividadSopechosa);

ALTER TABLE ComisionVenta ADD CONSTRAINT ComisionVenta_OrdenCompra_FK FOREIGN KEY (OrdenCompra_idOrdenCompra) REFERENCES OrdenCompra (idOrdenCompra);

ALTER TABLE Compra ADD CONSTRAINT Compra_ClienteNatural_FK FOREIGN KEY (ClienteNatural_idClienteNatural) REFERENCES ClienteNatural (idClienteNatural);
ALTER TABLE Compra ADD CONSTRAINT Compra_TipoUbicacionStock_FK FOREIGN KEY (TipoUbicacionStock_idTipoUbicacionStock) REFERENCES TipoUbicacionStock (idTipoUbicacionStock);

ALTER TABLE CompraDescuento ADD CONSTRAINT CompraDescuento_Compra_FK FOREIGN KEY (Compra_idCompra) REFERENCES Compra (idCompra);
ALTER TABLE CompraDescuento ADD CONSTRAINT CompraDescuento_Descuento_FK FOREIGN KEY (Descuento_idDescuento) REFERENCES Descuento (idDescuento);

ALTER TABLE Conciliacion ADD CONSTRAINT Conciliacion_OrdenCompra_FK FOREIGN KEY (OrdenCompra_idOrdenCompra) REFERENCES OrdenCompra (idOrdenCompra);
ALTER TABLE Conciliacion ADD CONSTRAINT Conciliacion_PagoJuridico_FK FOREIGN KEY (PagoJuridico_idPago, PagoJuridico_MetodoPago_idMetodoPago) REFERENCES PagoJuridico (idPago, MetodoPago_idMetodoPago);

ALTER TABLE CurriculumVitae ADD CONSTRAINT CurriculumVitae_Diseño_FK FOREIGN KEY (Diseño_idDiseño) REFERENCES Diseño (idDiseño);
ALTER TABLE CurriculumVitae ADD CONSTRAINT CurriculumVitae_Profesion_FK FOREIGN KEY (Profesion_idProfesion) REFERENCES Profesion (idProfesion);

ALTER TABLE DespachoNatural ADD CONSTRAINT DespachoNatural_Compra_FK FOREIGN KEY (Compra_idCompra) REFERENCES Compra (idCompra);
ALTER TABLE DespachoNatural ADD CONSTRAINT DespachoNatural_Courier_FK FOREIGN KEY (Courier_idCourier) REFERENCES Courier (idCourier);

ALTER TABLE DetalleCarrito ADD CONSTRAINT DetalleCarrito_CarritoCompra_FK FOREIGN KEY (CarritoCompra_idCarrito) REFERENCES CarritoCompra (idCarrito);

ALTER TABLE DetalleCompraJuridico ADD CONSTRAINT DetalleCompraJuridico_BackOrder_FK FOREIGN KEY (BackOrder_idBackOrder) REFERENCES BackOrder (idBackOrder);
ALTER TABLE DetalleCompraJuridico ADD CONSTRAINT DetalleCompraJuridico_Caja_FK FOREIGN KEY (Caja_idCaja) REFERENCES Caja (idCaja);
ALTER TABLE DetalleCompraJuridico ADD CONSTRAINT DetalleCompraJuridico_Departamento_FK FOREIGN KEY (Departamento_idDepartamento) REFERENCES Departamento (idDepartamento);
ALTER TABLE DetalleCompraJuridico ADD CONSTRAINT DetalleCompraJuridico_OrdenCompra_FK FOREIGN KEY (OrdenCompra_idOrdenCompra) REFERENCES OrdenCompra (idOrdenCompra);

ALTER TABLE DetalleCompraNatural ADD CONSTRAINT DetalleCompraNatural_Compra_FK FOREIGN KEY (Compra_idCompra) REFERENCES Compra (idCompra);
ALTER TABLE DetalleCompraNatural ADD CONSTRAINT DetalleCompraNatural_UnidadProducida_FK FOREIGN KEY (UnidadProducida_idUnidadProducidad) REFERENCES UnidadProducida (idUnidadProducidad);

ALTER TABLE DetalleDevolucionJuridica ADD CONSTRAINT DetalleDevolucionJuridica_Caja_FK FOREIGN KEY (Caja_idCaja) REFERENCES Caja (idCaja);
ALTER TABLE DetalleDevolucionJuridica ADD CONSTRAINT DetalleDevolucionJuridica_DevolucionJuridica_FK FOREIGN KEY (DevolucionJuridica_idDevolucionJuridica) REFERENCES DevolucionJuridica (idDevolucionJuridica);

ALTER TABLE DetalleDevolucionNatural ADD CONSTRAINT DetalleDevolucionNatural_DevolucionNatural_FK FOREIGN KEY (DevolucionNatural_idDevolucionNatural) REFERENCES DevolucionNatural (idDevolucionNatural);
ALTER TABLE DetalleDevolucionNatural ADD CONSTRAINT DetalleDevolucionNatural_UnidadProducida_FK FOREIGN KEY (UnidadProducida_idUnidadProducidad) REFERENCES UnidadProducida (idUnidadProducidad);

ALTER TABLE DevolucionJuridica ADD CONSTRAINT DevolucionJuridica_OrdenCompra_FK FOREIGN KEY (OrdenCompra_idOrdenCompra) REFERENCES OrdenCompra (idOrdenCompra);

ALTER TABLE DevolucionNatural ADD CONSTRAINT DevolucionNatural_Compra_FK FOREIGN KEY (Compra_idCompra) REFERENCES Compra (idCompra);

ALTER TABLE Diseño ADD CONSTRAINT Diseño_ClasificacionExclusividad_FK FOREIGN KEY (ClasificacionExclusividad_idClasificacionExclusividad) REFERENCES ClasificacionExclusividad (idClasificacionExclusividad);
ALTER TABLE Diseño ADD CONSTRAINT Diseño_ClasificacionHistorica_FK FOREIGN KEY (ClasificacionHistorica_idClasificacionHistorica) REFERENCES ClasificacionHistorica (idClasificacionHistorica);
ALTER TABLE Diseño ADD CONSTRAINT Diseño_Diseño_FK FOREIGN KEY (Diseño_idDiseño) REFERENCES Diseño (idDiseño);
ALTER TABLE Diseño ADD CONSTRAINT Diseño_MoldeRostro_FK FOREIGN KEY (MoldeRostro_idMoldeRostro) REFERENCES MoldeRostro (idMoldeRostro);
ALTER TABLE Diseño ADD CONSTRAINT Diseño_TipoDiseño_FK FOREIGN KEY (TipoDiseño_idTipoDiseño) REFERENCES TipoDiseño (idTipoDiseño);
ALTER TABLE Diseño ADD CONSTRAINT Diseño_TonoPiel_FK FOREIGN KEY (TonoPiel_idTonoPiel) REFERENCES TonoPiel (idTonoPiel);

ALTER TABLE DiseñoAmbiente ADD CONSTRAINT DiseñoAmbiente_Ambiente_FK FOREIGN KEY (Ambiente_idAmbiente) REFERENCES Ambiente (idAmbiente);
ALTER TABLE DiseñoAmbiente ADD CONSTRAINT DiseñoAmbiente_Diseño_FK FOREIGN KEY (Diseño_idDiseño) REFERENCES Diseño (idDiseño);

ALTER TABLE Empleado ADD CONSTRAINT Empleado_Lugar_FK FOREIGN KEY (Lugar_idLugar) REFERENCES Lugar (idLugar);

ALTER TABLE HistoricoEmpleado ADD CONSTRAINT HistoricoEmpleado_Departamento_FK FOREIGN KEY (Departamento_idDepartamento) REFERENCES Departamento (idDepartamento);
ALTER TABLE HistoricoEmpleado ADD CONSTRAINT HistoricoEmpleado_Empleado_FK FOREIGN KEY (Empleado_id) REFERENCES Empleado (id);
ALTER TABLE HistoricoEmpleado ADD CONSTRAINT HistoricoEmpleado_PuestoTrabajo_FK FOREIGN KEY (PuestoTrabajo_id) REFERENCES PuestoTrabajo (id);
ALTER TABLE HistoricoEmpleado ADD CONSTRAINT HistoricoEmpleado_TipoUbicacionStock_FK FOREIGN KEY (TipoUbicacionStock_idTipoUbicacionStock) REFERENCES TipoUbicacionStock (idTipoUbicacionStock);

ALTER TABLE HistoricoEstado ADD CONSTRAINT HistoricoEstado_Compra_FK FOREIGN KEY (Compra_idCompra) REFERENCES Compra (idCompra);
ALTER TABLE HistoricoEstado ADD CONSTRAINT HistoricoEstado_EstadoOrden_FK FOREIGN KEY (EstadoOrden_idEstadoOrden)REFERENCES EstadoOrden (idEstadoOrden);
ALTER TABLE HistoricoEstado ADD CONSTRAINT HistoricoEstado_OrdenCompra_FK FOREIGN KEY (OrdenCompra_idOrdenCompra) REFERENCES OrdenCompra (idOrdenCompra);

ALTER TABLE HistoricoRoles ADD CONSTRAINT HistoricoRoles_ClienteNatural_FK FOREIGN KEY (ClienteNatural_idClienteNatural) REFERENCES ClienteNatural (idClienteNatural);
ALTER TABLE HistoricoRoles ADD CONSTRAINT HistoricoRoles_Empleado_FK FOREIGN KEY (Empleado_id) REFERENCES Empleado (id);
ALTER TABLE HistoricoRoles ADD CONSTRAINT HistoricoRoles_Rol_FK FOREIGN KEY (Rol_idRol) REFERENCES Rol (idRol);
ALTER TABLE HistoricoRoles ADD CONSTRAINT HistoricoRoles_Usuario_FK FOREIGN KEY (Usuario_idUsuario) REFERENCES Usuario (idUsuario);

ALTER TABLE InsumoProduccion ADD CONSTRAINT InsumoProduccion_LoteMateriaPrima_FK FOREIGN KEY (LoteMateriaPrima_idLoteMateriaPrima) REFERENCES LoteMateriaPrima (idLoteMateriaPrima);
ALTER TABLE InsumoProduccion ADD CONSTRAINT InsumoProduccion_LoteProduccion_FK FOREIGN KEY (LoteProduccion_idLote) REFERENCES LoteProduccion (idLote);

ALTER TABLE ListaPrecioMayorista ADD CONSTRAINT ListaPrecioMayorista_ClienteJuridico_FK FOREIGN KEY (ClienteJuridico_idClienteJuridico) REFERENCES ClienteJuridico (idClienteJuridico);
ALTER TABLE ListaPrecioMayorista ADD CONSTRAINT ListaPrecioMayorista_UnidadProducida_FK FOREIGN KEY (UnidadProducida_idUnidadProducidad) REFERENCES UnidadProducida (idUnidadProducidad);

ALTER TABLE LoteMateriaPrima ADD CONSTRAINT LoteMateriaPrima_Material_FK FOREIGN KEY (Material_idMaterial) REFERENCES Material (idMaterial);

ALTER TABLE Lugar ADD CONSTRAINT Lugar_Lugar_FK FOREIGN KEY (Lugar_idLugar) REFERENCES Lugar (idLugar);

ALTER TABLE ManifiestoCarga ADD CONSTRAINT ManifiestoCarga_OrdenCompra_FK FOREIGN KEY (OrdenCompra_idOrdenCompra) REFERENCES OrdenCompra (idOrdenCompra);
ALTER TABLE ManifiestoCarga ADD CONSTRAINT ManifiestoCarga_Transporte_FK FOREIGN KEY (Transporte_idTransporte) REFERENCES Transporte (idTransporte);

ALTER TABLE MaterialDiseño ADD CONSTRAINT MaterialDiseño_Diseño_FK FOREIGN KEY (Diseño_idDiseño) REFERENCES Diseño (idDiseño);
ALTER TABLE MaterialDiseño ADD CONSTRAINT MaterialDiseño_Material_FK FOREIGN KEY (Material_idMaterial)REFERENCES Material (idMaterial);
ALTER TABLE MaterialDiseño ADD CONSTRAINT MaterialDiseño_Pieza_FK FOREIGN KEY (Pieza_idPieza) REFERENCES Pieza (idPieza);

ALTER TABLE Membresia ADD CONSTRAINT Membresia_ClienteNatural_FK FOREIGN KEY (ClienteNatural_idClienteNatural) REFERENCES ClienteNatural (idClienteNatural);

ALTER TABLE ObjetivoGlobalProducto ADD CONSTRAINT ObjetivoGlobalProducto_ObjetivoGlobal_FK FOREIGN KEY (ObjetivoGlobal_idObjetivoGlobal) REFERENCES ObjetivoGlobal (idObjetivoGlobal);
ALTER TABLE ObjetivoGlobalProducto ADD CONSTRAINT ObjetivoGlobalProducto_Producto_FK FOREIGN KEY (Producto_idProducto) REFERENCES Producto (idProducto);

ALTER TABLE OrdenCompra ADD CONSTRAINT OrdenCompra_BackOrder_FK FOREIGN KEY (BackOrder_idBackOrder) REFERENCES BackOrder (idBackOrder);
ALTER TABLE OrdenCompra ADD CONSTRAINT OrdenCompra_ClienteJuridico_FK FOREIGN KEY (ClienteJuridico_idClienteJuridico) REFERENCES ClienteJuridico (idClienteJuridico);

ALTER TABLE OrdenCompraDescuento ADD CONSTRAINT OrdenCompraDescuento_Descuento_FK FOREIGN KEY (Descuento_idDescuento) REFERENCES Descuento (idDescuento);
ALTER TABLE OrdenCompraDescuento ADD CONSTRAINT OrdenCompraDescuento_OrdenCompra_FK FOREIGN KEY (OrdenCompra_idOrdenCompra) REFERENCES OrdenCompra (idOrdenCompra);

ALTER TABLE Pack ADD CONSTRAINT Pack_Producto_FK FOREIGN KEY (Producto_idProducto) REFERENCES Producto (idProducto);
ALTER TABLE Pack ADD CONSTRAINT Pack_Producto_FKv1 FOREIGN KEY (Producto_idProducto1) REFERENCES Producto (idProducto);

ALTER TABLE PagoJuridico ADD CONSTRAINT PagoJuridico_MetodoPago_FK FOREIGN KEY (MetodoPago_idMetodoPago) REFERENCES MetodoPago (idMetodoPago);

ALTER TABLE PagoNatural ADD CONSTRAINT PagoNatural_Compra_FK FOREIGN KEY (Compra_idCompra) REFERENCES Compra (idCompra);
ALTER TABLE PagoNatural ADD CONSTRAINT PagoNatural_MetodoPago_FK FOREIGN KEY (MetodoPago_idMetodoPago) REFERENCES MetodoPago (idMetodoPago);

--ALTER TABLE PayPal ADD CONSTRAINT PayPal_MetodoPago_FK FOREIGN KEY (idTipoCaja) REFERENCES MetodoPago (idMetodoPago);

ALTER TABLE Pieza ADD CONSTRAINT Pieza_Color_FK FOREIGN KEY (Color_idColor) REFERENCES Color (idColor);

ALTER TABLE PiezaProducto ADD CONSTRAINT Pieza_Producto_Pieza_FK FOREIGN KEY (Pieza_idPieza) REFERENCES Pieza (idPieza);
ALTER TABLE PiezaProducto ADD CONSTRAINT Pieza_Producto_Producto_FK FOREIGN KEY (Producto_idProducto) REFERENCES Producto (idProducto);

ALTER TABLE Pieza ADD CONSTRAINT Pieza_TipoPieza_FK FOREIGN KEY (TipoPieza_idTipoPieza) REFERENCES TipoPieza (idTipoPieza);

ALTER TABLE Producto ADD CONSTRAINT Producto_BackOrder_FK FOREIGN KEY (BackOrder_idBackOrder)REFERENCES BackOrder(idBackOrder);
ALTER TABLE Producto ADD CONSTRAINT Producto_DetalleCarrito_FK FOREIGN KEY (DetalleCarrito_idDetalleCarrito) REFERENCES DetalleCarrito (idDetalleCarrito);
ALTER TABLE Producto ADD CONSTRAINT Producto_Diseño_FK FOREIGN KEY (Diseño_idDiseño) REFERENCES Diseño (idDiseño);
ALTER TABLE Producto ADD CONSTRAINT Producto_LoteProduccion_FK FOREIGN KEY (LoteProduccion_idLote) REFERENCES LoteProduccion (idLote);

ALTER TABLE Puja ADD CONSTRAINT Puja_ClienteNatural_FK FOREIGN KEY (ClienteNatural_idClienteNatural) REFERENCES ClienteNatural (idClienteNatural);
ALTER TABLE Puja ADD CONSTRAINT Puja_Subasta_FK FOREIGN KEY (Subasta_idSubasta)REFERENCES Subasta (idSubasta);

ALTER TABLE RestriccionDiseño ADD CONSTRAINT RestriccionDiseño_Diseño_FK FOREIGN KEY (Diseño_idDiseño)REFERENCES Diseño (idDiseño);
ALTER TABLE RestriccionDiseño ADD CONSTRAINT RestriccionDiseño_Restriccion_FK FOREIGN KEY (Restriccion_idRestriccion) REFERENCES Restriccion (idRestriccion);
ALTER TABLE RestriccionDiseño ADD CONSTRAINT RestriccionDiseño_TipoCuerpo_FK FOREIGN KEY (TipoCuerpo_idTipoCuerpo) REFERENCES TipoCuerpo (idTipoCuerpo);

ALTER TABLE RolPermiso ADD CONSTRAINT RolPermiso_Permisos_FK FOREIGN KEY (Permisos_idPermiso)REFERENCES Permisos(idPermiso);
ALTER TABLE RolPermiso ADD CONSTRAINT RolPermiso_Rol_FK FOREIGN KEY (Rol_idRol) REFERENCES Rol(idRol);

ALTER TABLE Sancion ADD CONSTRAINT Sancion_ClienteNatural_FK FOREIGN KEY (ClienteNatural_idClienteNatural) REFERENCES ClienteNatural (idClienteNatural);

ALTER TABLE Stock ADD CONSTRAINT Stock_TipoUbicacionStock_FK FOREIGN KEY (TipoUbicacionStock_idTipoUbicacionStock) REFERENCES TipoUbicacionStock (idTipoUbicacionStock);
ALTER TABLE Stock ADD CONSTRAINT Stock_UnidadProducida_FK FOREIGN KEY (UnidadProducida_idUnidadProducidad) REFERENCES UnidadProducida (idUnidadProducidad);

ALTER TABLE StockClienteNatural ADD CONSTRAINT StockClienteNatural_ClienteNatural_FK FOREIGN KEY (ClienteNatural_idClienteNatural) REFERENCES ClienteNatural (idClienteNatural);
ALTER TABLE StockClienteNatural ADD CONSTRAINT StockClienteNatural_condicionFisica_FK FOREIGN KEY (condicionFisica_idCondicionFisica) REFERENCES condicionFisica (idCondicionFisica);
ALTER TABLE StockClienteNatural ADD CONSTRAINT StockClienteNatural_Subasta_FK FOREIGN KEY (Subasta_idSubasta) REFERENCES Subasta (idSubasta);
ALTER TABLE StockClienteNatural ADD CONSTRAINT StockClienteNatural_UnidadProducida_FK FOREIGN KEY (UnidadProducida_idUnidadProducidad) REFERENCES UnidadProducida (idUnidadProducidad);

ALTER TABLE Subasta ADD CONSTRAINT Subasta_OrdenVenta_FK FOREIGN KEY (OrdenVenta_idOrdenVenta) REFERENCES OrdenVenta (idOrdenVenta);

ALTER TABLE SubEnsamblaje ADD CONSTRAINT SubEnsamblaje_Pieza_FK FOREIGN KEY (Pieza_idPieza) REFERENCES Pieza (idPieza);
ALTER TABLE SubEnsamblaje ADD CONSTRAINT SubEnsamblaje_Pieza_FKv1 FOREIGN KEY (Pieza_idPieza1)REFERENCES Pieza (idPieza);

ALTER TABLE Telefono ADD CONSTRAINT Telefono_ClienteJuridico_FK FOREIGN KEY (ClienteJuridico_idClienteJuridico) REFERENCES ClienteJuridico (idClienteJuridico);
ALTER TABLE Telefono ADD CONSTRAINT Telefono_ClienteNatural_FK FOREIGN KEY (ClienteNatural_idClienteNatural)REFERENCES ClienteNatural (idClienteNatural);

ALTER TABLE TipoRelacion ADD CONSTRAINT TipoRelacion_Diseño_FK FOREIGN KEY (Diseño_idDiseño) REFERENCES Diseño (idDiseño);
ALTER TABLE TipoRelacion ADD CONSTRAINT TipoRelacion_Diseño_FKv1 FOREIGN KEY(Diseño_idDiseño1) REFERENCES Diseño (idDiseño);

ALTER TABLE TipoUbicacionStock ADD CONSTRAINT TipoUbicacionStock_Lugar_FK FOREIGN KEY (Lugar_idLugar) REFERENCES Lugar (idLugar);

ALTER TABLE Turno ADD CONSTRAINT Turno_Horario_FK FOREIGN KEY (Horario_idHorario) REFERENCES Horario (idHorario);

ALTER TABLE TurnoEmpleado ADD CONSTRAINT TurnoEmpleado_Empleado_FK FOREIGN KEY (Empleado_id) REFERENCES Empleado (id);
ALTER TABLE TurnoEmpleado ADD CONSTRAINT TurnoEmpleado_Turno_FK FOREIGN KEY (Turno_idTurno) REFERENCES Turno (idTurno);

ALTER TABLE UnidadProducida ADD CONSTRAINT UnidadProducida_LoteProduccion_FK FOREIGN KEY (LoteProduccion_idLote) REFERENCES LoteProduccion (idLote);
ALTER TABLE UnidadProducida ADD CONSTRAINT UnidadProducida_UnidadProducida_FK FOREIGN KEY (UnidadProducida_idUnidadProducidad) REFERENCES UnidadProducida (idUnidadProducidad);

ALTER TABLE Usuario ADD CONSTRAINT Usuario_ClienteNatural_FK FOREIGN KEY (ClienteNatural_idClienteNatural) REFERENCES ClienteNatural (idClienteNatural);
ALTER TABLE Usuario ADD CONSTRAINT Usuario_Empleado_FK FOREIGN KEY (Empleado_id) REFERENCES Empleado (id);

ALTER TABLE ValoracionMercado ADD CONSTRAINT ValoracionMercado_UnidadProducida_FK FOREIGN KEY (UnidadProducida_idUnidadProducidad) REFERENCES UnidadProducida (idUnidadProducidad);
