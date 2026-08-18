CREATE TABLE `beneficiarioEPSS` (
  `beneficiarioEPSSId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `carneId` bigint(20) unsigned NOT NULL,
  `organizacionId` smallint(5) unsigned NOT NULL,
  `clienteId` bigint(20) unsigned NOT NULL,
  `beneficiarioId` bigint(20) unsigned NOT NULL,
  `parentescoId` smallint(5) unsigned DEFAULT NULL,
  `direccionPrincipal` varchar(4000) DEFAULT NULL,
  `fechaCreacion` datetime NOT NULL,
  `fechaActualizacion` datetime NOT NULL,
  PRIMARY KEY (`beneficiarioEPSSId`),
  KEY `carneId` (`carneId`,`clienteId`,`organizacionId`),
  KEY `beneficiarioId` (`beneficiarioId`,`organizacionId`),
  KEY `parentescoId` (`parentescoId`,`organizacionId`),
  CONSTRAINT `beneficiarioEPSS_ibfk_1` FOREIGN KEY (`carneId`, `clienteId`, `organizacionId`) REFERENCES `carneEPSS` (`carneId`, `clienteId`, `organizacionId`),
  CONSTRAINT `beneficiarioEPSS_ibfk_2` FOREIGN KEY (`beneficiarioId`, `organizacionId`) REFERENCES `cliente` (`clienteId`, `organizacionId`),
  CONSTRAINT `beneficiarioEPSS_ibfk_3` FOREIGN KEY (`parentescoId`, `organizacionId`) REFERENCES `parentesco` (`parentescoId`, `organizacionId`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci

CREATE TABLE `carneEPSS` (
  `carneId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `anio` smallint(5) unsigned NOT NULL,
  `correlativo` int(11) NOT NULL,
  `carne` varchar(20) NOT NULL,
  `organizacionId` smallint(5) unsigned NOT NULL,
  `puntoVentaId` mediumint(8) unsigned NOT NULL,
  `clienteId` bigint(20) unsigned NOT NULL,
  `creditoId` bigint(20) DEFAULT NULL,
  `estadoId` smallint(5) unsigned NOT NULL,
  `usuarioCreadorId` mediumint(8) unsigned NOT NULL,
  `fechaCreacion` datetime NOT NULL,
  `fechaActualizacion` datetime NOT NULL,
  PRIMARY KEY (`carneId`,`clienteId`,`organizacionId`),
  KEY `estadoId` (`estadoId`),
  KEY `creditoId` (`creditoId`,`organizacionId`,`clienteId`),
  KEY `puntoVentaId` (`puntoVentaId`,`organizacionId`),
  CONSTRAINT `carneEPSS_ibfk_1` FOREIGN KEY (`estadoId`) REFERENCES `estado` (`estadoId`),
  CONSTRAINT `carneEPSS_ibfk_2` FOREIGN KEY (`creditoId`, `organizacionId`, `clienteId`) REFERENCES `credito` (`creditoId`, `organizacionId`, `clienteId`),
  CONSTRAINT `carneEPSS_ibfk_3` FOREIGN KEY (`puntoVentaId`, `organizacionId`) REFERENCES `puntoVenta` (`puntoVentaId`, `organizacionId`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci

CREATE TABLE `credito` (
  `creditoId` bigint(20) NOT NULL AUTO_INCREMENT,
  `organizacionId` smallint(5) unsigned NOT NULL,
  `clienteId` bigint(20) unsigned NOT NULL,
  `perfilPrestamoId` int(10) unsigned DEFAULT NULL,
  `ventaId` bigint(20) unsigned DEFAULT NULL,
  `empresaOrganizacionId` smallint(5) unsigned DEFAULT NULL,
  `listaPrecioId` mediumint(8) unsigned DEFAULT NULL,
  `estadoId` smallint(5) unsigned NOT NULL,
  `capital` decimal(24,2) NOT NULL,
  `interesTotal` decimal(24,2) NOT NULL,
  `creditoTotal` decimal(24,2) NOT NULL,
  `porcentajeInteres` decimal(16,10) NOT NULL,
  `porcentajeMora` decimal(16,10) NOT NULL,
  `enganche` decimal(16,10) NOT NULL,
  `valorCuotaPrincipal` decimal(24,2) DEFAULT NULL,
  `valorCuotaUltima` decimal(24,2) DEFAULT NULL,
  `otrosTotal` decimal(24,2) NOT NULL DEFAULT 0.00,
  `plazo` smallint(6) NOT NULL,
  `saldoTotalPendiente` decimal(24,2) DEFAULT NULL,
  `capitalTotalPendiente` decimal(24,2) DEFAULT NULL,
  `fechaInicio` datetime NOT NULL,
  `fechaFin` datetime DEFAULT NULL,
  `fechaCreacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fechaActualizacion` datetime NOT NULL DEFAULT current_timestamp(),
  `puntoVentaId` mediumint(8) unsigned DEFAULT NULL,
  `codigoExterno` varchar(100) DEFAULT NULL,
  `jsonCreditoOriginal` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`jsonCreditoOriginal`)),
  PRIMARY KEY (`creditoId`,`organizacionId`,`clienteId`),
  KEY `perfilPrestamoId` (`perfilPrestamoId`,`organizacionId`),
  KEY `estadoId` (`estadoId`),
  KEY `ventaId` (`ventaId`,`empresaOrganizacionId`,`listaPrecioId`,`organizacionId`),
  KEY `puntoVentaId` (`puntoVentaId`,`organizacionId`),
  KEY `credito_ibfk_2` (`clienteId`,`organizacionId`),
  KEY `idx_credito_ventaId` (`ventaId`),
  KEY `idx_credito_codigoExterno` (`codigoExterno`),
  KEY `idx_credito_puntoVentaId` (`puntoVentaId`),
  CONSTRAINT `credito_ibfk_1` FOREIGN KEY (`perfilPrestamoId`, `organizacionId`) REFERENCES `perfilPrestamo` (`perfilPrestamoId`, `organizacionId`),
  CONSTRAINT `credito_ibfk_2` FOREIGN KEY (`clienteId`, `organizacionId`) REFERENCES `cliente` (`clienteId`, `organizacionId`) ON UPDATE CASCADE,
  CONSTRAINT `credito_ibfk_3` FOREIGN KEY (`estadoId`) REFERENCES `estado` (`estadoId`),
  CONSTRAINT `credito_ibfk_4` FOREIGN KEY (`ventaId`, `empresaOrganizacionId`, `listaPrecioId`, `organizacionId`) REFERENCES `venta` (`ventaId`, `empresaOrganizacionId`, `listaPrecioId`, `organizacionId`),
  CONSTRAINT `credito_ibfk_5` FOREIGN KEY (`puntoVentaId`, `organizacionId`) REFERENCES `puntoVenta` (`puntoVentaId`, `organizacionId`)
) ENGINE=InnoDB AUTO_INCREMENT=80581 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci





















