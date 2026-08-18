CREATE TABLE `menu` (
  `menuId` int(10) unsigned NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `ruta` varchar(500) NOT NULL,
  `menuPadre` int(10) unsigned DEFAULT NULL,
  `nivel` tinyint(3) unsigned NOT NULL,
  `icon` varchar(100) NOT NULL,
  `descripcion` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`menuId`),
  KEY `menuPadre` (`menuPadre`),
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`menuPadre`) REFERENCES `menu` (`menuId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci