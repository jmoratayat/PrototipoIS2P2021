CREATE DATABASE  IF NOT EXISTS `parcialpeliculassolo1.0Seguridad` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `parcialpeliculassolo1.0Seguridad`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mydb
-- ------------------------------------------------------
-- Server version	5.5.5-10.1.34-MariaDB

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

#Base de datos Seguridad-----------------------------------------------------------------------------------
create table if not exists LOGIN(
	pk_id_login 						int(10) auto_increment,
    usuario_login 						varchar(45),
    contraseña_login 					varchar(45),
    nombreCompleto_login				varchar(100),
    estado_login						int(2),
    primary key(pk_id_login)
);
create table if not exists MODULO(
	pk_id_modulo 						int(10)auto_increment,
    nombre_modulo 						varchar(30)not null,
    descripcion_modulo 					varchar(50)not null,
    estado_modulo 						int(1)not null,
    primary key(pk_id_modulo),
    key(pk_id_modulo)
);
create table if not exists APLICACION(
	pk_id_aplicacion 					int(10)auto_increment,
    fk_id_modulo 						int(10)not null,
    nombre_aplicacion 					varchar(40)not null,
    descripcion_aplicacion 				varchar(45)not null,
    estado_aplicacion 					int(1)not null,
    primary key(pk_id_aplicacion),
    key(pk_id_aplicacion)
);
alter table APLICACION add constraint fk_aplicacion_modulo foreign key(fk_id_modulo) references MODULO(pk_id_modulo);

create table if not exists PERFIL(
	pk_id_perfil						int(10)auto_increment,
    nombre_perfil						varchar(50),
    descripcion_perfil					varchar(100),
    estado_perfil						int(2),
    primary key(pk_id_perfil)
);
create table if not exists PERMISO(
	pk_id_permiso						int(10)auto_increment,
    insertar_permiso					boolean,
    modificar_permiso					boolean,
    eliminar_permiso					boolean,
    consultar_permiso					boolean,
    imprimir_permiso					boolean,
    primary key(pk_id_permiso)
);
create table if not exists APLICACION_PERFIL(
	pk_id_aplicacion_perfil				int(10)auto_increment,
    fk_idaplicacion_aplicacion_perfil	int(10),
    fk_idperfil_aplicacion_perfil		int(10),
    fk_idpermiso_aplicacion_perfil		int(10),
    primary key(pk_id_aplicacion_perfil)
);
alter table APLICACION_PERFIL add constraint fk_aplicacionperfil_aplicacion foreign key (fk_idaplicacion_aplicacion_perfil) references APLICACION(pk_id_aplicacion)on delete restrict on update cascade;
alter table APLICACION_PERFIL add constraint fk_aplicacionperfil_perfil foreign key (fk_idperfil_aplicacion_perfil) references PERFIL(pk_id_perfil)on delete restrict on update cascade;
alter table APLICACION_PERFIL add constraint fk_aplicacionperfil_permiso foreign key (fk_idpermiso_aplicacion_perfil) references PERMISO (pk_id_permiso)on delete restrict on update cascade;

create table if not exists PERFIL_USUARIO(
	pk_id_perfil_usuario				int(10) not null auto_increment,
    fk_idusuario_perfil_usuario			int(10),
    fk_idperfil_perfil_usuario			int(10),
    primary key(pk_id_perfil_usuario)
);
alter table PERFIL_USUARIO add constraint fk_perfil_usuario_login foreign key(fk_idusuario_perfil_usuario) references LOGIN(pk_id_login) on delete restrict on update cascade;
alter table PERFIL_USUARIO add constraint fk_perfil_usuario_perfil foreign key (fk_idperfil_perfil_usuario) references PERFIL(pk_id_perfil) on delete restrict on update cascade;

create table if not exists APLICACION_USUARIO(
	pk_id_aplicacion_usuario			int(10) not null auto_increment,
    fk_idlogin_aplicacion_usuario		int(10),
    fk_idaplicacion_aplicacion_usuario	int(10),
    fk_idpermiso_aplicacion_usuario		int(10),
    primary key(pk_id_aplicacion_usuario)
);
alter table APLICACION_USUARIO add constraint fk_aplicacionusuario_login foreign key(fk_idlogin_aplicacion_usuario) references LOGIN(pk_id_login) on delete restrict on update cascade;
alter table APLICACION_USUARIO add constraint fk_aplicacionusuario_aplicacion foreign key (fk_idaplicacion_aplicacion_usuario) references APLICACION(pk_id_aplicacion) on delete restrict on update cascade;
alter table APLICACION_USUARIO add constraint fk_aplicacionusuario_permiso foreign key(fk_idpermiso_aplicacion_usuario) references PERMISO (pk_id_permiso)on delete restrict on update cascade;

create table if not exists BITACORA(
	pk_id_bitacora						int(10)auto_increment, #pk
    fk_idusuario_bitacora				int(10),
    fk_idaplicacion_bitacora			int(10),
    fechahora_bitacora					varchar(50),
    direccionhost_bitacora				varchar(20),
    nombrehost_bitacora					varchar(20),
    accion_bitacora						varchar(250),
    primary key(pk_id_bitacora)
);
CREATE TABLE IF NOT EXISTS DETALLE_BITACORA (
    pk_id_detalle_bitacora 				INT(10)AUTO_INCREMENT,
    fk_idbitacora_detalle_bitacora 		INT(10),
    querryantigua_detalle_bitacora 		VARCHAR(50),
    querrynueva_detalle_bitacora 		VARCHAR(50),
    primary key(pk_id_detalle_bitacora)
);
alter table BITACORA add constraint fk_login_bitacora foreign key (fk_idusuario_bitacora) references LOGIN (pk_id_login) on delete restrict on update cascade;
alter table BITACORA add constraint fk_aplicacion_bitacora foreign key (fk_idaplicacion_bitacora) references APLICACION(pk_id_aplicacion) on delete restrict on update cascade;
alter table DETALLE_BITACORA add constraint fk_bitacora_detallebitacora foreign key(fk_idbitacora_detalle_bitacora) references BITACORA(pk_id_bitacora) on delete restrict on update cascade;

#REPORTEADOR---------------------------------------------------------------------------------------
create table if not exists REPORTE(
	pk_id_reporte 						int(10)not null auto_increment,
    nombre_reporte 						varchar(40)not null,
    ruta_reporte 						varchar(100)not null,
    estado_reporte 						int(1)not null,
    primary key(pk_id_reporte),
    key(pk_id_reporte)
);
create table if not exists REPORTE_MODULO(
	fk_id_reporte 						int(10)not null ,
    fk_id_modulo 						int(10)not null,
    estado_reporte_modulo 				int(1)not null,
    primary key(fk_id_reporte,fk_id_modulo),
    key(fk_id_reporte,fk_id_modulo)
);
alter table REPORTE_MODULO add constraint fk_reporte_de_modulo foreign key(fk_id_reporte) references REPORTE(pk_id_reporte);
alter table REPORTE_MODULO add constraint fk_reporte_de_modulo_reportes foreign key(fk_id_modulo) references MODULO(pk_id_modulo);

create table if not exists REPORTE_APLICATIVO(
	fk_id_reporte 						int(10)not null,
    fk_id_aplicacion 					int(10)not null,
    fk_id_modulo 						int(10)not null,
    estado_reporte_aplicativo 			int(1)not null,
    primary key(fk_id_reporte,fk_id_aplicacion,fk_id_modulo),
    key(fk_id_reporte,fk_id_aplicacion,fk_id_modulo)
);
alter table REPORTE_APLICATIVO add constraint fk_reporte_aplicativo_reporte foreign key(fk_id_reporte) references REPORTE(pk_id_reporte);
alter table REPORTE_APLICATIVO add constraint fk_reporte_aplicativo_modulo foreign key(fk_id_modulo) references MODULO(pk_id_modulo);
alter table REPORTE_APLICATIVO add constraint fk_report_aplicativo foreign key(fk_id_aplicacion) references APLICACION(pk_id_aplicacion);
#DATOS DE SEGURIDAD----------------------------------------------------------------------------------------
INSERT INTO `login` VALUES (1,'sistema','bi0PL96rbxVRPKJQsLJJAg==','Usuario de prueba',1),
(2,'admin','T+4Ai6O3CR0kJYxCgXy2jA==','Administrador',1),(3,'morataya','5g2jpUc7tYd0Q0iop9+lfA==','Julio Morataya',1);

INSERT INTO `perfil` VALUES (1,'Admin','Administracion del programa',1);

INSERT INTO `modulo` VALUES (1,'Seguridad','Aplicaciones de seguridad',1),(2,'Consultas','Consultas Inteligentes',1),
(3,'Reporteador','Aplicaciones de Reporteador',1),(4,'Inventarios','Sistema de Gestion Inventarios',1),
(5,'Compras','Sistema De Gestion Compras',1),(6,'Ventas','Sistema de Gestion Ventas',1),(7,'Cobros','Sistema De Gestion Cobros',1);

INSERT INTO `aplicacion` VALUES (1,1,'Login','Ventana de Ingreso',1),(2,1,'Mantenimiento Usuario','Mantenimientos de usuario',1),
(3,1,'Mantenimiento Aplicacion','ABC de las Aplicaciones',1),(4,1,'Mantenimiento Perfil','ABC de perfiles',1),
(5,1,'Asignacion de Aplicaciones a Perfil','Asignacion Aplicacion y perfil',1),(6,1,'Asignacaion de Aplicaciones','Asignacion especificas a un usuario',1),
(7,1,'Consulta Aplicacion','Mantenimiento de Aplicaciones',1),(8,1,'Agregar Modulo','Mantenimientos de Modulos',1),
(9,1,'Consultar Perfil','Consultas de perfiles disponibles',1),(10,1,'Permisos','Asignar permisos a perfiles y aplicaciones',1),
(11,1,'Cambio de Contraseña','Cambia las contraseñas',1),(12,1,'Reporte De Bitacora','Reporte de bitacora',1),
(301,4,'Mantenimiento Linea','Mantenimiento de Linea',1),(302,4,'Mantenimineto Marca','Mantenimiento Marca',1),
(303,4,'Mantenimiento Producto','Mantenimiento Producto',1),(304,4,'Mantenimiento Bodegas','Mantenimiento Bodegas',1),
(305,4,'Existencias','Verificar las existencias en bodega',1),(306,4,'Verificar Cita','Proceso para la verifiacacion de Citas',1),
(307,4,'Modificar Cita','Proceso para la modificacion de citas',1),(308,4,'Proceso Verificacion de datos','Para nuevos y renovacion de pasaporte',1),
(309,4,'Proceso Primer pasaporte','Proceso para renovar o nuevo pasaporte',1),(310,4,'Impresion de pasaporte','Impresion de pasaporte',1),
(311,4,'Reporte De Citas','Reporte De Citas',1),(312,4,'Reporte De Pasaportes','Reporte De Pasaportes',1);

INSERT INTO `permiso` VALUES (1,1,1,1,1,1),(2,1,1,1,1,1),(3,1,1,1,0,0),(4,1,1,1,1,1),(5,1,1,1,1,1),(6,1,1,1,1,1),(7,1,1,1,1,1),
(8,1,0,1,1,1),(9,1,1,1,1,1),(10,1,1,1,1,1),(11,1,1,1,1,1),(12,1,1,1,1,1),(13,1,1,1,1,1),(14,1,1,1,1,1),(15,1,1,1,1,1),(16,1,1,1,1,1),
(17,1,1,1,1,1),(18,1,1,1,1,1),(19,1,1,1,1,1),(20,1,1,1,1,1),(21,1,1,1,1,1),(22,1,1,1,1,1),(23,1,1,1,1,1),(24,1,1,1,1,1),(25,1,1,1,1,1),
(26,1,1,1,1,1),(27,1,1,1,1,1),(28,1,1,1,1,1),(29,1,1,1,1,1),(30,1,1,1,1,1),(31,1,1,1,1,1),(32,1,1,1,1,1),(33,1,1,1,1,1),(34,1,1,1,1,1),
(35,1,1,1,1,1),(36,1,1,1,1,1);

INSERT INTO `aplicacion_perfil` VALUES (1,1,1,1),(2,2,1,2),(3,3,1,3),(4,4,1,4),(5,5,1,5),(6,6,1,6),
(7,7,1,7),(8,8,1,8),(9,9,1,9),(10,10,1,10),(11,11,1,11),(12,12,1,12);

INSERT INTO `aplicacion_usuario` VALUES (1,1,1,13),(2,1,2,14),(3,1,3,15),(4,1,4,16),(5,1,5,17),(6,1,6,18),(7,1,7,19),(8,1,8,20),
(9,1,9,21),(10,1,10,22),(11,1,11,23),(12,1,12,24),(13,1,301,25),(14,1,302,26),(15,1,303,27),(16,1,304,28),(17,1,305,29),(18,1,306,30),
(19,1,307,31),(20,1,308,32),(21,1,309,33),(22,1,310,34),(23,1,311,35),(24,1,312,36);

INSERT INTO `perfil_usuario` VALUES (1,1,1),(2,2,1),(3,3,1);
########################## Parcial


--
-- Table structure for table `autor`
--

DROP TABLE IF EXISTS `autor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autor` (
  `pkidautor` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `estado` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`pkidautor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autor`
--

LOCK TABLES `autor` WRITE;
/*!40000 ALTER TABLE `autor` DISABLE KEYS */;
INSERT INTO `autor` VALUES (1,'1',1);
/*!40000 ALTER TABLE `autor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoria` (
  `pkidcategoria` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `estado` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`pkidcategoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'1',1);
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  `pkidcliente` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `estado` tinyint(2) DEFAULT NULL,
  `fkidmembresia` int(11) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  PRIMARY KEY (`pkidcliente`),
  KEY `fk_cliente_membresia1_idx` (`fkidmembresia`),
  CONSTRAINT `fk_cliente_membresia1` FOREIGN KEY (`fkidmembresia`) REFERENCES `membresia` (`pkidmembresia`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `conceptos`
--


--
-- Table structure for table `membresia`
--

DROP TABLE IF EXISTS `membresia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `membresia` (
  `pkidmembresia` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `fecha_emision` date DEFAULT NULL,
  `fecha_caducidad` date DEFAULT NULL,
  `estado` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`pkidmembresia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membresia`
--

LOCK TABLES `membresia` WRITE;
/*!40000 ALTER TABLE `membresia` DISABLE KEYS */;
/*!40000 ALTER TABLE `membresia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productos` (
  `pkidproducto` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `precio` double DEFAULT NULL,
  `fkidcategoria` int(11) DEFAULT NULL,
  `estado` tinyint(2) DEFAULT NULL,
  `fkidtipoproducto` int(11) DEFAULT NULL,
  `fkidautor` int(11) DEFAULT NULL,
  `fkidproveedor` int(11) DEFAULT NULL,
  PRIMARY KEY (`pkidproducto`),
  KEY `fk_productos_tipo_producto_idx` (`fkidtipoproducto`),
  KEY `fk_productos_autor1_idx` (`fkidautor`),
  KEY `fk_productos_categoria1_idx` (`fkidcategoria`),
  KEY `fk_productos_proveedor1_idx` (`fkidproveedor`),
  CONSTRAINT `fk_productos_autor1` FOREIGN KEY (`fkidautor`) REFERENCES `autor` (`pkidautor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_categoria1` FOREIGN KEY (`fkidcategoria`) REFERENCES `categoria` (`pkidcategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_proveedor1` FOREIGN KEY (`fkidproveedor`) REFERENCES `proveedor` (`pkidproveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_tipo_producto` FOREIGN KEY (`fkidtipoproducto`) REFERENCES `tipo_producto` (`pkidtipoproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Arroz',43,1,1,1,1,3);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedor` (
  `pkidproveedor` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `estado` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`pkidproveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (1,'ASD','1','1',1),(2,'FGHJ','1','1',1),(3,'ds','sd','1',1),(5,'45','45','3',1);
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `renta_detalle`
--

DROP TABLE IF EXISTS `renta_detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `renta_detalle` (
  `pkcodlinea` int(11) NOT NULL AUTO_INCREMENT,
  `fkidrentaencabezado` int(11) NOT NULL,
  `fkidproducto` int(11) DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  PRIMARY KEY (`pkcodlinea`,`fkidrentaencabezado`),
  KEY `fk_renta_detalle_renta_encabezado1_idx` (`fkidrentaencabezado`),
  KEY `fk_renta_detalle_productos1_idx` (`fkidproducto`),
  CONSTRAINT `fk_renta_detalle_productos1` FOREIGN KEY (`fkidproducto`) REFERENCES `productos` (`pkidproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_renta_detalle_renta_encabezado1` FOREIGN KEY (`fkidrentaencabezado`) REFERENCES `renta_encabezado` (`pkidrentaencabezado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `renta_detalle`
--

LOCK TABLES `renta_detalle` WRITE;
/*!40000 ALTER TABLE `renta_detalle` DISABLE KEYS */;
/*!40000 ALTER TABLE `renta_detalle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `renta_encabezado`
--

DROP TABLE IF EXISTS `renta_encabezado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `renta_encabezado` (
  `pkidrentaencabezado` int(11) NOT NULL,
  `pkidmembresia` int(11) DEFAULT NULL,
  `fecha_alquiler` date DEFAULT NULL,
  `fecha_entrega` date DEFAULT NULL,
  `fkidscucursal` int(11) DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`pkidrentaencabezado`),
  KEY `fk_renta_membresia1_idx` (`pkidmembresia`),
  KEY `fk_renta_sucursal1_idx` (`fkidscucursal`),
  CONSTRAINT `fk_renta_membresia1` FOREIGN KEY (`pkidmembresia`) REFERENCES `membresia` (`pkidmembresia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_renta_sucursal1` FOREIGN KEY (`fkidscucursal`) REFERENCES `sucursal` (`pkidsucursal`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `renta_encabezado`
--

LOCK TABLES `renta_encabezado` WRITE;
/*!40000 ALTER TABLE `renta_encabezado` DISABLE KEYS */;
/*!40000 ALTER TABLE `renta_encabezado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sucursal`
--

DROP TABLE IF EXISTS `sucursal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sucursal` (
  `pkidsucursal` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `estado` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`pkidsucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sucursal`
--

LOCK TABLES `sucursal` WRITE;
/*!40000 ALTER TABLE `sucursal` DISABLE KEYS */;
INSERT INTO `sucursal` VALUES (1,'ASDF','1','1',1);
/*!40000 ALTER TABLE `sucursal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_producto`
--

DROP TABLE IF EXISTS `tipo_producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_producto` (
  `pkidtipoproducto` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `estado` tinyint(11) DEFAULT NULL,
  PRIMARY KEY (`pkidtipoproducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_producto`
--

LOCK TABLES `tipo_producto` WRITE;
/*!40000 ALTER TABLE `tipo_producto` DISABLE KEYS */;
INSERT INTO `tipo_producto` VALUES (1,'1',1);
/*!40000 ALTER TABLE `tipo_producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'mydb'
--

--
-- Dumping routines for database 'mydb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-17 16:29:19