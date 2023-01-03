-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: localhost    Database: ljeans
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.21-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `id_distribuidor` int(11) NOT NULL,
  `nombre_cliente` varchar(255) NOT NULL,
  `apellido_p` varchar(255) NOT NULL,
  `apellido_m` varchar(255) NOT NULL,
  `limite_credito` varchar(255) NOT NULL,
  `bloqueado_cliente` enum('S','N') NOT NULL,
  `folio_tarjeta` varchar(20) NOT NULL,
  `estado_cliente` enum('A','B') NOT NULL,
  `fecha_alta_cliente` int(11) NOT NULL,
  PRIMARY KEY (`id_cliente`),
  KEY `fk_distribuidor` (`id_distribuidor`),
  CONSTRAINT `fk_distribuidor` FOREIGN KEY (`id_distribuidor`) REFERENCES `distribuidores` (`id_distribuidor`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cobradores`
--

DROP TABLE IF EXISTS `cobradores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cobradores` (
  `id_cobrador` int(11) NOT NULL AUTO_INCREMENT,
  `nombe_cobrador` varchar(255) NOT NULL,
  `apellidos_cobrador` varchar(255) NOT NULL,
  `direccion_cobrador` varchar(255) NOT NULL,
  `id_pais` int(11) NOT NULL,
  `id_entidad` int(11) NOT NULL,
  `numero_celular` varchar(255) NOT NULL,
  `correo_cobrador` varchar(255) DEFAULT NULL,
  `estado` enum('A','B') NOT NULL,
  PRIMARY KEY (`id_cobrador`),
  KEY `fk_paises_cob` (`id_pais`),
  KEY `fk_entidades_cob` (`id_entidad`),
  CONSTRAINT `fk_entidades_cob` FOREIGN KEY (`id_entidad`) REFERENCES `entidades` (`id_entidad`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_paises_cob` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_pais`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cobradores`
--

LOCK TABLES `cobradores` WRITE;
/*!40000 ALTER TABLE `cobradores` DISABLE KEYS */;
INSERT INTO `cobradores` VALUES (1,'Enrique','Peña','Los pinos residencial',1,1,'6688112233','pnieto@gob.com.mx','A'),(2,'Andres','Lopez Obrador','Los Pinos Nuevo residencial',1,1,'1122334455','amlo@gob.com.mx','A');
/*!40000 ALTER TABLE `cobradores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cobranzas`
--

DROP TABLE IF EXISTS `cobranzas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cobranzas` (
  `id_cobranza` int(11) NOT NULL AUTO_INCREMENT,
  `id_distribuidor` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_vale` int(11) NOT NULL,
  `detalle_cobranza` varchar(255) NOT NULL,
  `monto` varchar(255) NOT NULL,
  `pago_a_tiempo` enum('Y','N') NOT NULL,
  `fecha_cobranza` date NOT NULL,
  PRIMARY KEY (`id_cobranza`),
  KEY `fk_cliente_cobranza` (`id_cliente`),
  KEY `fk_distribuidores_cobranza` (`id_distribuidor`),
  KEY `fk_vales_distribuidor_cobranza` (`id_vale`),
  CONSTRAINT `fk_cliente_cobranza` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_distribuidores_cobranza` FOREIGN KEY (`id_distribuidor`) REFERENCES `distribuidores` (`id_distribuidor`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_vales_distribuidor_cobranza` FOREIGN KEY (`id_vale`) REFERENCES `vales` (`id_vale`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cobranzas`
--

LOCK TABLES `cobranzas` WRITE;
/*!40000 ALTER TABLE `cobranzas` DISABLE KEYS */;
/*!40000 ALTER TABLE `cobranzas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `distribuidores`
--

DROP TABLE IF EXISTS `distribuidores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `distribuidores` (
  `id_distribuidor` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_distribuidor` varchar(255) NOT NULL,
  `apellidos_distribuidor` varchar(255) NOT NULL,
  `direccion_distribuidor` varchar(255) NOT NULL,
  `id_pais` int(11) NOT NULL,
  `id_entidad` int(11) NOT NULL,
  `id_sector` int(11) NOT NULL,
  `numero_telefono` text DEFAULT NULL,
  `numero_celular` text DEFAULT NULL,
  `correo_distribuidor` varchar(255) NOT NULL,
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
  `fecha_alta_distribuidor` date NOT NULL,
  PRIMARY KEY (`id_distribuidor`),
  KEY `fk_sectores` (`id_sector`),
  KEY `fk_entidades` (`id_entidad`),
  KEY `fk_pais` (`id_pais`),
  KEY `fk_grupos` (`id_grupo`),
  KEY `fk_cobradores` (`id_cobrador`),
  CONSTRAINT `fk_cobradores` FOREIGN KEY (`id_cobrador`) REFERENCES `cobradores` (`id_cobrador`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_entidades` FOREIGN KEY (`id_entidad`) REFERENCES `entidades` (`id_entidad`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_grupos` FOREIGN KEY (`id_grupo`) REFERENCES `grupos` (`id_grupo`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_pais` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_pais`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_sectores` FOREIGN KEY (`id_sector`) REFERENCES `sectores` (`id_sector`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `distribuidores`
--

LOCK TABLES `distribuidores` WRITE;
/*!40000 ALTER TABLE `distribuidores` DISABLE KEYS */;
INSERT INTO `distribuidores` VALUES (1,'Pito','Perez','Enrique segoviano #8',1,1,1,'1230303','6681112233','pperaza@gmail.com','S',2,'sin observaciones',1,10001,'1234','1500','8500','N',1,'N','A','2022-12-01'),(2,'Usuario de','Pruebas','Enrique segoviano #8',1,1,1,'1230303','6681112233','pperaza@gmail.com','S',2,'sin observaciones',1,10001,'1234','1500','8500','N',1,'N','A','2022-12-01'),(3,'Mario','Mares','Enrique segoviano #8',1,1,1,'1230303','6681112233','pperaza@gmail.com','S',2,'sin observaciones',1,10001,'1234','1500','8500','N',1,'N','A','2022-12-01'),(4,'Miguel','Hidalgo','Enrique segoviano #8',1,1,1,'1230303','6681112233','pperaza@gmail.com','S',2,'sin observaciones',1,10001,'1234','1500','8500','N',1,'N','A','2022-12-01'),(5,'Paquete','Express','Enrique segoviano #8',1,1,1,'1230303','6681112233','pperaza@gmail.com','S',2,'sin observaciones',1,10001,'1234','1500','8500','N',1,'N','A','2022-12-01'),(6,'Pruebas1','Perez','Enrique segoviano #8',1,1,1,'1230303','6681112233','pperaza@gmail.com','S',2,'sin observaciones',1,10001,'1234','1500','8500','N',1,'N','A','2022-12-01'),(7,'Pruebas2','Perez','Enrique segoviano #8',1,1,1,'1230303','6681112233','pperaza@gmail.com','S',2,'sin observaciones',1,10001,'1234','1500','8500','N',1,'N','A','2022-12-01'),(8,'Pruebas3','Perez','Enrique segoviano #8',1,1,1,'1230303','6681112233','pperaza@gmail.com','S',2,'sin observaciones',1,10001,'1234','1500','8500','N',1,'N','A','2022-12-01'),(9,'Pruebas5','Perez','Enrique segoviano #8',1,1,1,'1230303','6681112233','pperaza@gmail.com','S',2,'sin observaciones',1,10001,'1234','1500','8500','N',1,'N','A','2022-12-01'),(10,'Pruebas4','Perez','Enrique segoviano #8',1,1,1,'1230303','6681112233','pperaza@gmail.com','S',2,'sin observaciones',1,10001,'1234','1500','8500','N',1,'N','A','2022-12-01'),(11,'Pruebas6','Perez','Enrique segoviano #8',1,1,1,'1230303','6681112233','pperaza@gmail.com','S',2,'sin observaciones',1,10001,'1234','1500','8500','N',1,'N','A','2022-12-01'),(12,'Pruebas7','Perez','Enrique segoviano #8',1,1,1,'1230303','6681112233','pperaza@gmail.com','S',2,'sin observaciones',1,10001,'1234','1500','8500','N',1,'N','A','2022-12-01'),(13,'Pruebas8','Perez','Enrique segoviano #8',1,1,1,'1230303','6681112233','pperaza@gmail.com','S',2,'sin observaciones',1,10001,'1234','1500','8500','N',1,'N','A','2022-12-01'),(14,'Pruebas9','Perez','Enrique segoviano #8',1,1,1,'1230303','6681112233','pperaza@gmail.com','S',2,'sin observaciones',1,10001,'1234','1500','8500','N',1,'N','A','2022-12-01'),(15,'Pruebas10','Perez','Enrique segoviano #8',1,1,1,'1230303','6681112233','pperaza@gmail.com','S',2,'sin observaciones',1,10001,'1234','1500','8500','N',1,'N','A','2022-12-01'),(16,'Pruebas11','Perez','Enrique segoviano #8',1,1,1,'1230303','6681112233','pperaza@gmail.com','S',2,'sin observaciones',1,10001,'1234','1500','8500','N',1,'N','A','2022-12-01'),(17,'Pruebas12','Perez','Enrique segoviano #8',1,1,1,'1230303','6681112233','pperaza@gmail.com','S',2,'sin observaciones',1,10001,'1234','1500','8500','N',1,'N','A','2022-12-01');
/*!40000 ALTER TABLE `distribuidores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entidades`
--

DROP TABLE IF EXISTS `entidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entidades` (
  `id_entidad` int(11) NOT NULL AUTO_INCREMENT,
  `id_pais` int(11) NOT NULL,
  `descripcion_entidad` varchar(255) NOT NULL,
  PRIMARY KEY (`id_entidad`),
  KEY `fk_paises` (`id_pais`),
  CONSTRAINT `fk_paises` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_pais`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entidades`
--

LOCK TABLES `entidades` WRITE;
/*!40000 ALTER TABLE `entidades` DISABLE KEYS */;
INSERT INTO `entidades` VALUES (1,1,'Sinaloa');
/*!40000 ALTER TABLE `entidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupos`
--

DROP TABLE IF EXISTS `grupos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupos` (
  `id_grupo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion_grupo` varchar(255) NOT NULL,
  PRIMARY KEY (`id_grupo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupos`
--

LOCK TABLES `grupos` WRITE;
/*!40000 ALTER TABLE `grupos` DISABLE KEYS */;
INSERT INTO `grupos` VALUES (1,'Vendedores'),(2,'Distribuidores'),(3,'Clientes');
/*!40000 ALTER TABLE `grupos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paises`
--

DROP TABLE IF EXISTS `paises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paises` (
  `id_pais` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion_pais` text NOT NULL,
  PRIMARY KEY (`id_pais`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paises`
--

LOCK TABLES `paises` WRITE;
/*!40000 ALTER TABLE `paises` DISABLE KEYS */;
INSERT INTO `paises` VALUES (1,'México');
/*!40000 ALTER TABLE `paises` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sectores`
--

DROP TABLE IF EXISTS `sectores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sectores` (
  `id_sector` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion_sector` varchar(255) NOT NULL,
  PRIMARY KEY (`id_sector`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sectores`
--

LOCK TABLES `sectores` WRITE;
/*!40000 ALTER TABLE `sectores` DISABLE KEYS */;
INSERT INTO `sectores` VALUES (1,'Los Mochis, Centro'),(2,'Los Mochis, Plaza sendero'),(3,'Los Mochis, Plaza fiesta');
/*!40000 ALTER TABLE `sectores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vales`
--

DROP TABLE IF EXISTS `vales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vales` (
  `id_vale` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_vale` enum('E','L','P') NOT NULL,
  `id_distribuidor` int(11) NOT NULL,
  `monto_vale` varchar(255) DEFAULT NULL,
  `fecha_limite` date NOT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY (`id_vale`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vales`
--

LOCK TABLES `vales` WRITE;
/*!40000 ALTER TABLE `vales` DISABLE KEYS */;
INSERT INTO `vales` VALUES (5,'E',3,'500','2022-12-31',4),(7,'L',3,'1500','2022-12-20',8),(19,'L',1,'1500','2022-12-30',3),(21,'E',1,'1500','2022-12-28',5),(22,'E',1,'1500','2022-12-29',4);
/*!40000 ALTER TABLE `vales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'ljeans'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-01-03 14:42:58
