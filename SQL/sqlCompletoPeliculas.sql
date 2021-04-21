-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema parcialpeliculassolo1.0seguridad
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema parcialpeliculassolo1.0seguridad
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `parcialpeliculassolo1.0seguridad` DEFAULT CHARACTER SET utf8 ;
USE `parcialpeliculassolo1.0seguridad` ;

-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`modulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`modulo` (
  `pk_id_modulo` INT NOT NULL AUTO_INCREMENT,
  `nombre_modulo` VARCHAR(30) NOT NULL,
  `descripcion_modulo` VARCHAR(50) NOT NULL,
  `estado_modulo` INT NOT NULL,
  PRIMARY KEY (`pk_id_modulo`),
  INDEX `pk_id_modulo` (`pk_id_modulo` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`aplicacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`aplicacion` (
  `pk_id_aplicacion` INT NOT NULL AUTO_INCREMENT,
  `fk_id_modulo` INT NOT NULL,
  `nombre_aplicacion` VARCHAR(40) NOT NULL,
  `descripcion_aplicacion` VARCHAR(45) NOT NULL,
  `estado_aplicacion` INT NOT NULL,
  PRIMARY KEY (`pk_id_aplicacion`),
  INDEX `pk_id_aplicacion` (`pk_id_aplicacion` ASC) VISIBLE,
  INDEX `fk_aplicacion_modulo` (`fk_id_modulo` ASC) VISIBLE,
  CONSTRAINT `fk_aplicacion_modulo`
    FOREIGN KEY (`fk_id_modulo`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`modulo` (`pk_id_modulo`))
ENGINE = InnoDB
AUTO_INCREMENT = 313
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`perfil` (
  `pk_id_perfil` INT NOT NULL AUTO_INCREMENT,
  `nombre_perfil` VARCHAR(50) NULL DEFAULT NULL,
  `descripcion_perfil` VARCHAR(100) NULL DEFAULT NULL,
  `estado_perfil` INT NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id_perfil`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`permiso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`permiso` (
  `pk_id_permiso` INT NOT NULL AUTO_INCREMENT,
  `insertar_permiso` TINYINT(1) NULL DEFAULT NULL,
  `modificar_permiso` TINYINT(1) NULL DEFAULT NULL,
  `eliminar_permiso` TINYINT(1) NULL DEFAULT NULL,
  `consultar_permiso` TINYINT(1) NULL DEFAULT NULL,
  `imprimir_permiso` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id_permiso`))
ENGINE = InnoDB
AUTO_INCREMENT = 37
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`aplicacion_perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`aplicacion_perfil` (
  `pk_id_aplicacion_perfil` INT NOT NULL AUTO_INCREMENT,
  `fk_idaplicacion_aplicacion_perfil` INT NULL DEFAULT NULL,
  `fk_idperfil_aplicacion_perfil` INT NULL DEFAULT NULL,
  `fk_idpermiso_aplicacion_perfil` INT NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id_aplicacion_perfil`),
  INDEX `fk_aplicacionperfil_aplicacion` (`fk_idaplicacion_aplicacion_perfil` ASC) VISIBLE,
  INDEX `fk_aplicacionperfil_perfil` (`fk_idperfil_aplicacion_perfil` ASC) VISIBLE,
  INDEX `fk_aplicacionperfil_permiso` (`fk_idpermiso_aplicacion_perfil` ASC) VISIBLE,
  CONSTRAINT `fk_aplicacionperfil_aplicacion`
    FOREIGN KEY (`fk_idaplicacion_aplicacion_perfil`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`aplicacion` (`pk_id_aplicacion`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_aplicacionperfil_perfil`
    FOREIGN KEY (`fk_idperfil_aplicacion_perfil`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`perfil` (`pk_id_perfil`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_aplicacionperfil_permiso`
    FOREIGN KEY (`fk_idpermiso_aplicacion_perfil`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`permiso` (`pk_id_permiso`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`login` (
  `pk_id_login` INT NOT NULL AUTO_INCREMENT,
  `usuario_login` VARCHAR(45) NULL DEFAULT NULL,
  `contraseña_login` VARCHAR(45) NULL DEFAULT NULL,
  `nombreCompleto_login` VARCHAR(100) NULL DEFAULT NULL,
  `estado_login` INT NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id_login`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`aplicacion_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`aplicacion_usuario` (
  `pk_id_aplicacion_usuario` INT NOT NULL AUTO_INCREMENT,
  `fk_idlogin_aplicacion_usuario` INT NULL DEFAULT NULL,
  `fk_idaplicacion_aplicacion_usuario` INT NULL DEFAULT NULL,
  `fk_idpermiso_aplicacion_usuario` INT NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id_aplicacion_usuario`),
  INDEX `fk_aplicacionusuario_login` (`fk_idlogin_aplicacion_usuario` ASC) VISIBLE,
  INDEX `fk_aplicacionusuario_aplicacion` (`fk_idaplicacion_aplicacion_usuario` ASC) VISIBLE,
  INDEX `fk_aplicacionusuario_permiso` (`fk_idpermiso_aplicacion_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_aplicacionusuario_aplicacion`
    FOREIGN KEY (`fk_idaplicacion_aplicacion_usuario`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`aplicacion` (`pk_id_aplicacion`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_aplicacionusuario_login`
    FOREIGN KEY (`fk_idlogin_aplicacion_usuario`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`login` (`pk_id_login`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_aplicacionusuario_permiso`
    FOREIGN KEY (`fk_idpermiso_aplicacion_usuario`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`permiso` (`pk_id_permiso`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`autor` (
  `pkidautor` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `estado` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`pkidautor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`bitacora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`bitacora` (
  `pk_id_bitacora` INT NOT NULL AUTO_INCREMENT,
  `fk_idusuario_bitacora` INT NULL DEFAULT NULL,
  `fk_idaplicacion_bitacora` INT NULL DEFAULT NULL,
  `fechahora_bitacora` VARCHAR(50) NULL DEFAULT NULL,
  `direccionhost_bitacora` VARCHAR(20) NULL DEFAULT NULL,
  `nombrehost_bitacora` VARCHAR(20) NULL DEFAULT NULL,
  `accion_bitacora` VARCHAR(250) NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id_bitacora`),
  INDEX `fk_login_bitacora` (`fk_idusuario_bitacora` ASC) VISIBLE,
  INDEX `fk_aplicacion_bitacora` (`fk_idaplicacion_bitacora` ASC) VISIBLE,
  CONSTRAINT `fk_aplicacion_bitacora`
    FOREIGN KEY (`fk_idaplicacion_bitacora`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`aplicacion` (`pk_id_aplicacion`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_login_bitacora`
    FOREIGN KEY (`fk_idusuario_bitacora`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`login` (`pk_id_login`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 38
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`categoria` (
  `pkidcategoria` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `estado` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`pkidcategoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`membresia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`membresia` (
  `pkidmembresia` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `fecha_emision` VARCHAR(45) NULL DEFAULT NULL,
  `fecha_caducidad` VARCHAR(45) NULL DEFAULT NULL,
  `estado` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`pkidmembresia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`cliente` (
  `pkidcliente` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  `telefono` VARCHAR(45) NULL DEFAULT NULL,
  `estado` TINYINT NULL DEFAULT NULL,
  `fkidmembresia` INT NULL DEFAULT NULL,
  `fecha_nacimiento` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`pkidcliente`),
  INDEX `fk_cliente_membresia1_idx` (`fkidmembresia` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_membresia1`
    FOREIGN KEY (`fkidmembresia`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`membresia` (`pkidmembresia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`detalle_bitacora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`detalle_bitacora` (
  `pk_id_detalle_bitacora` INT NOT NULL AUTO_INCREMENT,
  `fk_idbitacora_detalle_bitacora` INT NULL DEFAULT NULL,
  `querryantigua_detalle_bitacora` VARCHAR(50) NULL DEFAULT NULL,
  `querrynueva_detalle_bitacora` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id_detalle_bitacora`),
  INDEX `fk_bitacora_detallebitacora` (`fk_idbitacora_detalle_bitacora` ASC) VISIBLE,
  CONSTRAINT `fk_bitacora_detallebitacora`
    FOREIGN KEY (`fk_idbitacora_detalle_bitacora`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`bitacora` (`pk_id_bitacora`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`perfil_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`perfil_usuario` (
  `pk_id_perfil_usuario` INT NOT NULL AUTO_INCREMENT,
  `fk_idusuario_perfil_usuario` INT NULL DEFAULT NULL,
  `fk_idperfil_perfil_usuario` INT NULL DEFAULT NULL,
  PRIMARY KEY (`pk_id_perfil_usuario`),
  INDEX `fk_perfil_usuario_login` (`fk_idusuario_perfil_usuario` ASC) VISIBLE,
  INDEX `fk_perfil_usuario_perfil` (`fk_idperfil_perfil_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_perfil_usuario_login`
    FOREIGN KEY (`fk_idusuario_perfil_usuario`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`login` (`pk_id_login`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_perfil_usuario_perfil`
    FOREIGN KEY (`fk_idperfil_perfil_usuario`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`perfil` (`pk_id_perfil`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`proveedor` (
  `pkidproveedor` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  `telefono` VARCHAR(45) NULL DEFAULT NULL,
  `estado` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`pkidproveedor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`tipo_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`tipo_producto` (
  `pkidtipoproducto` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `estado` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`pkidtipoproducto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`productos` (
  `pkidproducto` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `precio` DOUBLE NULL DEFAULT NULL,
  `fkidcategoria` INT NULL DEFAULT NULL,
  `estado` TINYINT NULL DEFAULT NULL,
  `fkidtipoproducto` INT NULL DEFAULT NULL,
  `fkidautor` INT NULL DEFAULT NULL,
  `fkidproveedor` INT NULL DEFAULT NULL,
  PRIMARY KEY (`pkidproducto`),
  INDEX `fk_productos_tipo_producto_idx` (`fkidtipoproducto` ASC) VISIBLE,
  INDEX `fk_productos_autor1_idx` (`fkidautor` ASC) VISIBLE,
  INDEX `fk_productos_categoria1_idx` (`fkidcategoria` ASC) VISIBLE,
  INDEX `fk_productos_proveedor1_idx` (`fkidproveedor` ASC) VISIBLE,
  CONSTRAINT `fk_productos_autor1`
    FOREIGN KEY (`fkidautor`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`autor` (`pkidautor`),
  CONSTRAINT `fk_productos_categoria1`
    FOREIGN KEY (`fkidcategoria`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`categoria` (`pkidcategoria`),
  CONSTRAINT `fk_productos_proveedor1`
    FOREIGN KEY (`fkidproveedor`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`proveedor` (`pkidproveedor`),
  CONSTRAINT `fk_productos_tipo_producto`
    FOREIGN KEY (`fkidtipoproducto`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`tipo_producto` (`pkidtipoproducto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`sucursal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`sucursal` (
  `pkidsucursal` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `direccion` VARCHAR(45) NULL DEFAULT NULL,
  `telefono` VARCHAR(45) NULL DEFAULT NULL,
  `estado` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`pkidsucursal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`renta_encabezado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`renta_encabezado` (
  `pkidrentaencabezado` INT NOT NULL,
  `pkidmembresia` INT NULL DEFAULT NULL,
  `fecha_alquiler` VARCHAR(45) NULL DEFAULT NULL,
  `fecha_entrega` VARCHAR(45) NULL DEFAULT NULL,
  `fkidscucursal` INT NULL DEFAULT NULL,
  `total` DOUBLE NULL DEFAULT NULL,
  `Estado` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`pkidrentaencabezado`),
  INDEX `fk_renta_membresia1_idx` (`pkidmembresia` ASC) VISIBLE,
  INDEX `fk_renta_sucursal1_idx` (`fkidscucursal` ASC) VISIBLE,
  CONSTRAINT `fk_renta_membresia1`
    FOREIGN KEY (`pkidmembresia`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`membresia` (`pkidmembresia`),
  CONSTRAINT `fk_renta_sucursal1`
    FOREIGN KEY (`fkidscucursal`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`sucursal` (`pkidsucursal`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`renta_detalle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`renta_detalle` (
  `pkcodlinea` INT NOT NULL AUTO_INCREMENT,
  `fkidrentaencabezado` INT NOT NULL,
  `fkidproducto` INT NULL DEFAULT NULL,
  `subtotal` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`pkcodlinea`, `fkidrentaencabezado`),
  INDEX `fk_renta_detalle_renta_encabezado1_idx` (`fkidrentaencabezado` ASC) VISIBLE,
  INDEX `fk_renta_detalle_productos1_idx` (`fkidproducto` ASC) VISIBLE,
  CONSTRAINT `fk_renta_detalle_productos1`
    FOREIGN KEY (`fkidproducto`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`productos` (`pkidproducto`),
  CONSTRAINT `fk_renta_detalle_renta_encabezado1`
    FOREIGN KEY (`fkidrentaencabezado`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`renta_encabezado` (`pkidrentaencabezado`))
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`reporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`reporte` (
  `pk_id_reporte` INT NOT NULL AUTO_INCREMENT,
  `nombre_reporte` VARCHAR(40) NOT NULL,
  `ruta_reporte` VARCHAR(100) NOT NULL,
  `estado_reporte` INT NOT NULL,
  PRIMARY KEY (`pk_id_reporte`),
  INDEX `pk_id_reporte` (`pk_id_reporte` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`reporte_aplicativo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`reporte_aplicativo` (
  `fk_id_reporte` INT NOT NULL,
  `fk_id_aplicacion` INT NOT NULL,
  `fk_id_modulo` INT NOT NULL,
  `estado_reporte_aplicativo` INT NOT NULL,
  PRIMARY KEY (`fk_id_reporte`, `fk_id_aplicacion`, `fk_id_modulo`),
  INDEX `fk_id_reporte` (`fk_id_reporte` ASC, `fk_id_aplicacion` ASC, `fk_id_modulo` ASC) VISIBLE,
  INDEX `fk_reporte_aplicativo_modulo` (`fk_id_modulo` ASC) VISIBLE,
  INDEX `fk_report_aplicativo` (`fk_id_aplicacion` ASC) VISIBLE,
  CONSTRAINT `fk_report_aplicativo`
    FOREIGN KEY (`fk_id_aplicacion`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`aplicacion` (`pk_id_aplicacion`),
  CONSTRAINT `fk_reporte_aplicativo_modulo`
    FOREIGN KEY (`fk_id_modulo`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`modulo` (`pk_id_modulo`),
  CONSTRAINT `fk_reporte_aplicativo_reporte`
    FOREIGN KEY (`fk_id_reporte`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`reporte` (`pk_id_reporte`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `parcialpeliculassolo1.0seguridad`.`reporte_modulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `parcialpeliculassolo1.0seguridad`.`reporte_modulo` (
  `fk_id_reporte` INT NOT NULL,
  `fk_id_modulo` INT NOT NULL,
  `estado_reporte_modulo` INT NOT NULL,
  PRIMARY KEY (`fk_id_reporte`, `fk_id_modulo`),
  INDEX `fk_id_reporte` (`fk_id_reporte` ASC, `fk_id_modulo` ASC) VISIBLE,
  INDEX `fk_reporte_de_modulo_reportes` (`fk_id_modulo` ASC) VISIBLE,
  CONSTRAINT `fk_reporte_de_modulo`
    FOREIGN KEY (`fk_id_reporte`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`reporte` (`pk_id_reporte`),
  CONSTRAINT `fk_reporte_de_modulo_reportes`
    FOREIGN KEY (`fk_id_modulo`)
    REFERENCES `parcialpeliculassolo1.0seguridad`.`modulo` (`pk_id_modulo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
