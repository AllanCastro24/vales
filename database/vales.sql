-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-11-2022 a las 23:02:51
-- Versión del servidor: 10.4.22-MariaDB
-- Versión de PHP: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `vales`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `id_distribuidor` int(11) NOT NULL,
  `nombre_cliente` varchar(255) NOT NULL,
  `apellido_p` varchar(255) NOT NULL,
  `apellido_m` varchar(255) NOT NULL,
  `limite_credito` varchar(255) NOT NULL,
  `bloqueado_cliente` enum('S','N') NOT NULL,
  `folio_tarjeta` varchar(20) NOT NULL,
  `estado_cliente` enum('A','B') NOT NULL,
  `fecha_alta_cliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cobradores`
--

CREATE TABLE `cobradores` (
  `id_cobrador` int(11) NOT NULL,
  `nombe_cobrador` varchar(255) NOT NULL,
  `apellidos_cobrador` varchar(255) NOT NULL,
  `direccion_cobrador` varchar(255) NOT NULL,
  `id_pais` int(11) NOT NULL,
  `id_entidad` int(11) NOT NULL,
  `numero_celular` varchar(255) NOT NULL,
  `correo_cobrador` varchar(255) DEFAULT NULL,
  `estado` enum('A','B') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cobranzas`
--

CREATE TABLE `cobranzas` (
  `id_cobranza` int(11) NOT NULL,
  `id_distribuidor` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_vale` int(11) NOT NULL,
  `detalle_cobranza` varchar(255) NOT NULL,
  `monto` varchar(255) NOT NULL,
  `pago_a_tiempo` enum('Y','N') NOT NULL,
  `fecha_cobranza` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `distribuidores`
--

CREATE TABLE `distribuidores` (
  `id_distribuidor` int(11) NOT NULL,
  `nombre_distribuidor` varchar(255) NOT NULL,
  `apellidos_distribuidor` varchar(255) NOT NULL,
  `direccion_distribuidor` varchar(255) NOT NULL,
  `id_pais` int(11) NOT NULL,
  `id_entidad` int(11) NOT NULL,
  `id_sector` int(11) NOT NULL,
  `numero_telefono` int(10) DEFAULT NULL,
  `numero_celular` int(10) DEFAULT NULL,
  `correo_distribuidor` varchar(255) NOT NULL,
  `id_vale` int(11) NOT NULL,
  `vale_efectivo_distribuidor` enum('S','N') NOT NULL,
  `id_grupo` int(11) NOT NULL,
  `observacion_distribuidor` varchar(255) DEFAULT NULL,
  `numero_pagare` int(11) NOT NULL,
  `cuenta_cont` int(20) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `limite_credito_vales` varchar(255) NOT NULL,
  `limite_credito_celulares` varchar(255) NOT NULL,
  `rechazar_vales_vigentes` enum('S','N') NOT NULL,
  `id_cobrador` int(11) NOT NULL,
  `bloquear_distribuidor` enum('S','N') NOT NULL,
  `estado` enum('A','B') NOT NULL,
  `fecha_alta_distribuidor` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entidades`
--

CREATE TABLE `entidades` (
  `id_entidad` int(11) NOT NULL,
  `id_pais` int(11) NOT NULL,
  `descripcion_entidad` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupos`
--

CREATE TABLE `grupos` (
  `id_grupo` int(11) NOT NULL,
  `descripcion_grupo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paises`
--

CREATE TABLE `paises` (
  `id_pais` int(11) NOT NULL,
  `descripcion_pais` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sectores`
--

CREATE TABLE `sectores` (
  `id_sector` int(11) NOT NULL,
  `descripcion_sector` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vales`
--

CREATE TABLE `vales` (
  `id_vale` int(11) NOT NULL,
  `tipo_vale` enum('E','L','P') NOT NULL,
  `id_distribuidor` int(11) NOT NULL,
  `monto_vale` varchar(255) DEFAULT NULL,
  `fecha_limite` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`),
  ADD KEY `fk_distribuidor` (`id_distribuidor`);

--
-- Indices de la tabla `cobradores`
--
ALTER TABLE `cobradores`
  ADD PRIMARY KEY (`id_cobrador`),
  ADD KEY `fk_paises_cob` (`id_pais`),
  ADD KEY `fk_entidades_cob` (`id_entidad`);

--
-- Indices de la tabla `cobranzas`
--
ALTER TABLE `cobranzas`
  ADD PRIMARY KEY (`id_cobranza`),
  ADD KEY `fk_cliente_cobranza` (`id_cliente`),
  ADD KEY `fk_distribuidores_cobranza` (`id_distribuidor`),
  ADD KEY `fk_vales_distribuidor_cobranza` (`id_vale`);

--
-- Indices de la tabla `distribuidores`
--
ALTER TABLE `distribuidores`
  ADD PRIMARY KEY (`id_distribuidor`),
  ADD KEY `fk_sectores` (`id_sector`),
  ADD KEY `fk_entidades` (`id_entidad`),
  ADD KEY `fk_pais` (`id_pais`),
  ADD KEY `fk_grupos` (`id_grupo`),
  ADD KEY `fk_cobradores` (`id_cobrador`),
  ADD KEY `fk_vales` (`id_vale`);

--
-- Indices de la tabla `entidades`
--
ALTER TABLE `entidades`
  ADD PRIMARY KEY (`id_entidad`),
  ADD KEY `fk_paises` (`id_pais`);

--
-- Indices de la tabla `grupos`
--
ALTER TABLE `grupos`
  ADD PRIMARY KEY (`id_grupo`);

--
-- Indices de la tabla `paises`
--
ALTER TABLE `paises`
  ADD PRIMARY KEY (`id_pais`);

--
-- Indices de la tabla `sectores`
--
ALTER TABLE `sectores`
  ADD PRIMARY KEY (`id_sector`);

--
-- Indices de la tabla `vales`
--
ALTER TABLE `vales`
  ADD PRIMARY KEY (`id_vale`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cobradores`
--
ALTER TABLE `cobradores`
  MODIFY `id_cobrador` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cobranzas`
--
ALTER TABLE `cobranzas`
  MODIFY `id_cobranza` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `distribuidores`
--
ALTER TABLE `distribuidores`
  MODIFY `id_distribuidor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `entidades`
--
ALTER TABLE `entidades`
  MODIFY `id_entidad` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `grupos`
--
ALTER TABLE `grupos`
  MODIFY `id_grupo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `paises`
--
ALTER TABLE `paises`
  MODIFY `id_pais` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sectores`
--
ALTER TABLE `sectores`
  MODIFY `id_sector` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `vales`
--
ALTER TABLE `vales`
  MODIFY `id_vale` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `fk_distribuidor` FOREIGN KEY (`id_distribuidor`) REFERENCES `distribuidores` (`id_distribuidor`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `cobradores`
--
ALTER TABLE `cobradores`
  ADD CONSTRAINT `fk_entidades_cob` FOREIGN KEY (`id_entidad`) REFERENCES `entidades` (`id_entidad`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_paises_cob` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_pais`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `cobranzas`
--
ALTER TABLE `cobranzas`
  ADD CONSTRAINT `fk_cliente_cobranza` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_distribuidores_cobranza` FOREIGN KEY (`id_distribuidor`) REFERENCES `distribuidores` (`id_distribuidor`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_vales_distribuidor_cobranza` FOREIGN KEY (`id_vale`) REFERENCES `vales` (`id_vale`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `distribuidores`
--
ALTER TABLE `distribuidores`
  ADD CONSTRAINT `fk_cobradores` FOREIGN KEY (`id_cobrador`) REFERENCES `cobradores` (`id_cobrador`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_entidades` FOREIGN KEY (`id_entidad`) REFERENCES `entidades` (`id_entidad`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_grupos` FOREIGN KEY (`id_grupo`) REFERENCES `grupos` (`id_grupo`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pais` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_pais`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sectores` FOREIGN KEY (`id_sector`) REFERENCES `sectores` (`id_sector`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_vales` FOREIGN KEY (`id_vale`) REFERENCES `vales` (`id_vale`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `entidades`
--
ALTER TABLE `entidades`
  ADD CONSTRAINT `fk_paises` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_pais`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
