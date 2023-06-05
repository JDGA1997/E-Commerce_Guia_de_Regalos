--
-- Base de datos: `E-Commerce`


CREATE DATABASE E-Commerce


USE E-Commerce


-- --------------------------------------------------------


--
-- Estructura de tabla para la tabla `categoria`
--


CREATE TABLE `categoria` (
  `categoriaID` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------


--
-- Estructura de tabla para la tabla `producto`
--


CREATE TABLE `producto` (
  `productoID` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `precio` decimal(10,0) NOT NULL,
  `stock` int(11) NOT NULL,
  `imagen` longblob NOT NULL,
  `estaEnPromo` tinyint(1) NOT NULL,
  `categoriaID` int(11) NOT NULL,
  `vendedorID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------


--
-- Estructura de tabla para la tabla `provincia`
--


CREATE TABLE `provincia` (
  `provinciaID` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------


--
-- Estructura de tabla para la tabla `rol`
--


CREATE TABLE `rol` (
  `rolID` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------


--
-- Estructura de tabla para la tabla `usuario`
--


CREATE TABLE `usuario` (
  `usuarioID` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `email` varchar(250) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `contraseña` varchar(100) NOT NULL,
  `fechaNacimiento` date NOT NULL,
  `dni` int(11) NOT NULL,
  `telefono` int(11) DEFAULT NULL,
  `provinciaID` int(11) NOT NULL,
  `rolID` int(11) NOT NULL,
  `categoriaID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------


--
-- Estructura de tabla para la tabla `ventas`
--


CREATE TABLE `ventas` (
  `ventaID` int(11) NOT NULL,
  `tipo_comprobante` varchar(50) NOT NULL,
  `num_comprobante` varchar(50) NOT NULL,
  `fecha` date NOT NULL,
  `estado` varchar(50) NOT NULL,
  `usuarioID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalleventas`
--


CREATE TABLE `detalleventas` (
  `detalle_ventaID` int(30) NOT NULL,
  `cantidad` int NOT NULL,
  `precio` decimal NOT NULL,
  `productoID` int(11) NOT NULL,
  `ventaID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- --------------------------------------------------------


--
-- Estructura de tabla para la tabla `vendedor`
--


CREATE TABLE `vendedor` (
  `vendedorID` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefono` int(11) DEFAULT NULL,
  `url` varchar(250) NOT NULL,
  `cuit` int(11) NOT NULL,
  `provinciaID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Índices para tablas volcadas
--


--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`categoriaID`);


--
-- Indices de la tabla `prodporsolicitud`
--
ALTER TABLE `prodporsolicitud`
  ADD KEY `productoID` (`productoID`),
  ADD KEY `solicitudID` (`solicitudID`);


--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`productoID`),
  ADD KEY `categoriaID` (`categoriaID`),
  ADD KEY `vendedorID` (`vendedorID`);


--
-- Indices de la tabla `provincia`
--
ALTER TABLE `provincia`
  ADD PRIMARY KEY (`provinciaID`);


--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`rolID`);


--
-- Indices de la tabla `solicitudregalo`
--
ALTER TABLE `solicitudregalo`
  ADD PRIMARY KEY (`solicitudID`),
  ADD KEY `vendedorID` (`vendedorID`);


--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`usuarioID`),
  ADD KEY `provinciaID` (`provinciaID`),
  ADD KEY `rolID` (`rolID`),
  ADD KEY `categoriaID` (`categoriaID`);


--
-- Indices de la tabla `vendedor`
--
ALTER TABLE `vendedor`
  ADD PRIMARY KEY (`vendedorID`),
  ADD KEY `provinciaID` (`provinciaID`);


--
-- AUTO_INCREMENT de las tablas volcadas
--


--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `categoriaID` int(11) NOT NULL AUTO_INCREMENT;


--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `productoID` int(11) NOT NULL AUTO_INCREMENT;


--
-- AUTO_INCREMENT de la tabla `provincia`
--
ALTER TABLE `provincia`
  MODIFY `provinciaID` int(11) NOT NULL AUTO_INCREMENT;


--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `rolID` int(11) NOT NULL AUTO_INCREMENT;


--
-- AUTO_INCREMENT de la tabla `solicitudregalo`
--
ALTER TABLE `solicitudregalo`
  MODIFY `solicitudID` int(11) NOT NULL AUTO_INCREMENT;


--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `usuarioID` int(11) NOT NULL AUTO_INCREMENT;


--
-- Restricciones para tablas volcadas
--


--
-- Filtros para la tabla `prodporsolicitud`
--
ALTER TABLE `prodporsolicitud`
  ADD CONSTRAINT `prodporsolicitud_ibfk_1` FOREIGN KEY (`productoID`) REFERENCES `producto` (`productoID`),
  ADD CONSTRAINT `prodporsolicitud_ibfk_2` FOREIGN KEY (`solicitudID`) REFERENCES `solicitudregalo` (`solicitudID`);


--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`categoriaID`) REFERENCES `categoria` (`categoriaID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`vendedorID`) REFERENCES `vendedor` (`vendedorID`) ON DELETE CASCADE ON UPDATE CASCADE;


--
-- Filtros para la tabla `solicitudregalo`
--
ALTER TABLE `solicitudregalo`
  ADD CONSTRAINT `solicitudregalo_ibfk_1` FOREIGN KEY (`vendedorID`) REFERENCES `vendedor` (`vendedorID`) ON DELETE CASCADE;


--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`provinciaID`) REFERENCES `provincia` (`provinciaID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`rolID`) REFERENCES `rol` (`rolID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usuario_ibfk_3` FOREIGN KEY (`categoriaID`) REFERENCES `categoria` (`categoriaID`) ON DELETE CASCADE ON UPDATE CASCADE;


--
-- Filtros para la tabla `vendedor`
--
ALTER TABLE `vendedor`
  ADD CONSTRAINT `vendedor_ibfk_1` FOREIGN KEY (`provinciaID`) REFERENCES `provincia` (`provinciaID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;