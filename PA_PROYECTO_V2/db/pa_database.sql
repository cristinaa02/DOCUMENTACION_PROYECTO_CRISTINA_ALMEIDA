/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.14-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: PATRIMONIUM_ALMEIDAE
-- ------------------------------------------------------
-- Server version	10.11.14-MariaDB-0+deb12u2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ACCESO`
--

DROP TABLE IF EXISTS `ACCESO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ACCESO` (
  `ID_ACCESO` int(11) NOT NULL AUTO_INCREMENT,
  `FECHA_HORA` datetime DEFAULT NULL,
  `TIPO` varchar(50) DEFAULT NULL,
  `ZONA` varchar(100) DEFAULT NULL,
  `ID_EMPLEADO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_ACCESO`),
  KEY `FK_ACCESO_EMPLEADO` (`ID_EMPLEADO`),
  CONSTRAINT `FK_ACCESO_EMPLEADO` FOREIGN KEY (`ID_EMPLEADO`) REFERENCES `EMPLEADO` (`ID_EMPLEADO`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACCESO`
--

LOCK TABLES `ACCESO` WRITE;
/*!40000 ALTER TABLE `ACCESO` DISABLE KEYS */;
/*!40000 ALTER TABLE `ACCESO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENTE`
--

DROP TABLE IF EXISTS `CLIENTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENTE` (
  `ID_CLIENTE` int(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(100) DEFAULT NULL,
  `APELLIDOS` varchar(100) DEFAULT NULL,
  `TIPO` varchar(20) DEFAULT NULL,
  `TELF` varchar(20) DEFAULT NULL,
  `EMAIL` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`ID_CLIENTE`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENTE`
--

LOCK TABLES `CLIENTE` WRITE;
/*!40000 ALTER TABLE `CLIENTE` DISABLE KEYS */;
INSERT INTO `CLIENTE` VALUES
(1,'John','Smith','Adulto','600123001','john.smith@gmail.com'),
(2,'Emily','Brown','Adulto','600123002','emily.brown@yahoo.com'),
(3,'Luis','García','Adulto','600123003','luis.garcia@gmail.com'),
(4,'Marta','Pérez','Infantil','600123004','marta.perez@hotmail.com'),
(5,'Yuki','Tanaka','Escolar','600123005','yuki.tanaka@gmail.com'),
(6,'Li','Wei','Escolar','600123006','li.wei@yahoo.com'),
(7,'Sofia','Lopez','Adulto','600123007','sofia.lopez@gmail.com'),
(8,'Carlos','Martinez','Adulto','600123008','carlos.martinez@hotmail.com'),
(9,'Anna','Schmidt','Jubilado','600123009','anna.schmidt@gmail.com'),
(10,'David','Johnson','Adulto','600123010','david.johnson@yahoo.com'),
(11,'Hiro','Nakamura','Escolar','600123011','hiro.nakamura@gmail.com'),
(12,'Emma','Wilson','Infantil','600123012','emma.wilson@hotmail.com'),
(13,'Miguel','Santos','Adulto','600123013','miguel.santos@gmail.com'),
(14,'Isabella','Rossi','Adulto','600123014','isabella.rossi@yahoo.com'),
(15,'Pierre','Dupont','Adulto','600123015','pierre.dupont@gmail.com'),
(16,'Fatima','Alvarez','Adulto','600123016','fatima.alvarez@hotmail.com'),
(17,'Kai','Chen','Escolar','600123017','kai.chen@gmail.com'),
(18,'Olivia','Taylor','Infantil','600123018','olivia.taylor@yahoo.com'),
(19,'Hannah','Lee','Jubilado','600123019','hannah.lee@gmail.com'),
(20,'Miguel','Rodriguez','Adulto','600123020','miguel.rodriguez@hotmail.com');
/*!40000 ALTER TABLE `CLIENTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DEPARTAMENTO`
--

DROP TABLE IF EXISTS `DEPARTAMENTO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `DEPARTAMENTO` (
  `ID_DEPART` int(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(100) NOT NULL,
  `DESCRIPCION` text DEFAULT NULL,
  PRIMARY KEY (`ID_DEPART`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DEPARTAMENTO`
--

LOCK TABLES `DEPARTAMENTO` WRITE;
/*!40000 ALTER TABLE `DEPARTAMENTO` DISABLE KEYS */;
INSERT INTO `DEPARTAMENTO` VALUES
(1,'Conservacion_Restauracion','Departamento de Conservación y Restauración'),
(2,'Direccion','Departamento de Dirección'),
(3,'Gestion Cultural','Departamento de Gestión Cultural'),
(4,'Seguridad','Departamento de Seguridad'),
(5,'Administracion_Finanzas','Departamento de Administración y Finanzas'),
(6,'Informatica','Departamento de Informática'),
(7,'Marketing','Departamento de Marketing');
/*!40000 ALTER TABLE `DEPARTAMENTO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EMPLEADO`
--

DROP TABLE IF EXISTS `EMPLEADO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `EMPLEADO` (
  `ID_EMPLEADO` int(11) NOT NULL AUTO_INCREMENT,
  `DNI` varchar(15) NOT NULL,
  `NOMBRE` varchar(100) NOT NULL,
  `APELLIDOS` varchar(150) DEFAULT NULL,
  `TELF` varchar(20) DEFAULT NULL,
  `EMAIL` varchar(150) DEFAULT NULL,
  `CARGO` varchar(100) DEFAULT NULL,
  `FECHA_CONTRAT` date DEFAULT NULL,
  `ID_DEPART` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_EMPLEADO`),
  UNIQUE KEY `DNI` (`DNI`),
  KEY `FK_EMPLEADO_DEPARTAMENTO` (`ID_DEPART`),
  CONSTRAINT `FK_EMPLEADO_DEPARTAMENTO` FOREIGN KEY (`ID_DEPART`) REFERENCES `DEPARTAMENTO` (`ID_DEPART`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EMPLEADO`
--

LOCK TABLES `EMPLEADO` WRITE;
/*!40000 ALTER TABLE `EMPLEADO` DISABLE KEYS */;
INSERT INTO `EMPLEADO` VALUES
(1,'87451236A','Ana','Solis','600123987','ana.solis@example.com','Empleado','2025-01-01',1),
(2,'41236785B','Carlos','Ruiz','600234876','carlos.ruiz@example.com','Responsable','2025-01-01',1),
(3,'96325874C','Elena','Gomez','600345765','elena.gomez@example.com','Empleado','2025-01-01',1),
(4,'74125896D','Francisco','Lopez','600456654','francisco.lopez@example.com','Empleado','2025-01-01',1),
(5,'85236974E','Laura','Martin','600567543','laura.martin@example.com','Empleado','2025-01-01',1),
(6,'96314785F','Miguel','Angel','600678432','miguel.angel@example.com','Empleado','2025-01-01',1),
(7,'74136925G','Sofia','Vargas','600789321','sofia.vargas@example.com','Empleado','2025-01-01',1),
(8,'85247136H','Ricardo','Bravo','600890210','ricardo.bravo@example.com','Empleado','2025-01-01',1),
(9,'96325841I','Javier','Nunez','600901109','javier.nunez@example.com','Empleado','2025-01-01',1),
(10,'74185296J','Marta','Diaz','600012998','marta.diaz@example.com','Empleado','2025-01-01',1),
(11,'85296374K','Roberto','Vega','600112887','roberto.vega@example.com','Empleado','2025-01-01',1),
(12,'96374185L','Natalia','Castro','600212776','natalia.castro@example.com','Empleado','2025-01-01',1),
(13,'12345678M','Alfonso','Castro','601000111','alfonso.castro@example.com','Director General','2025-01-01',2),
(14,'23456789N','Ines','Robles','601000222','ines.robles@example.com','Directivo','2025-01-01',2),
(15,'34567890O','Fernando','Sanz','601000333','fernando.sanz@example.com','Directivo','2025-01-01',2),
(16,'45678901P','Gloria','Flores','601000444','gloria.flores@example.com','Directivo','2025-01-01',2),
(17,'56789012Q','Pablo','Romero','602111000','pablo.romero@example.com','Responsable','2025-01-01',3),
(18,'67890123R','Veronica','Conde','602111111','veronica.conde@example.com','Empleado','2025-01-01',3),
(19,'78901234S','Diego','Herrera','602111222','diego.herrera@example.com','Empleado','2025-01-01',3),
(20,'89012345T','Lucia','Vidal','602111333','lucia.vidal@example.com','Empleado','2025-01-01',3),
(21,'90123456U','Oscar','Cano','602111444','oscar.cano@example.com','Empleado','2025-01-01',3),
(22,'01234567V','Patricia','Pena','602111555','patricia.pena@example.com','Empleado','2025-01-01',3),
(23,'11234567W','Jesus','Rivas','602111666','jesus.rivas@example.com','Empleado','2025-01-01',3),
(24,'21234567X','Eva','Soria','602111777','eva.soria@example.com','Empleado','2025-01-01',3),
(25,'31234567Y','Juan','Ortiz','603222000','juan.ortiz@example.com','Responsable','2025-01-01',4),
(26,'41234567Z','Manuel','Moya','603222111','manuel.moya@example.com','Empleado','2025-01-01',4),
(27,'51234568A','Silvia','Prieto','603222222','silvia.prieto@example.com','Empleado','2025-01-01',4),
(28,'61234568B','David','Huelva','603222333','david.huelva@example.com','Empleado','2025-01-01',4),
(29,'71234568C','Berta','Nieto','603222444','berta.nieto@example.com','Empleado','2025-01-01',4),
(30,'81234568D','Sergio','Ramos','603222555','sergio.ramos@example.com','Empleado','2025-01-01',4),
(31,'91234568E','Teresa','Cruz','603222666','teresa.cruz@example.com','Empleado','2025-01-01',4),
(32,'01234568F','Raquel','Perez','604333000','raquel.perez@example.com','Responsable','2025-01-01',5),
(33,'11234568G','Alberto','Ruiz','604333111','alberto.ruiz@example.com','Empleado','2025-01-01',5),
(34,'21234568H','Cristina','Ferrer','604333222','cristina.ferrer@example.com','Empleado','2025-01-01',5),
(35,'31234568I','Mario','Lopez','604333333','mario.lopez@example.com','Empleado','2025-01-01',5),
(36,'41234568J','Elena','Vidal','604333444','elena.vidal@example.com','Empleado','2025-01-01',5),
(37,'51234568K','Jaime','Salas','604333555','jaime.salas@example.com','Empleado','2025-01-01',5),
(38,'61234568L','Virginia','Soto','604333666','virginia.soto@example.com','Empleado','2025-01-01',5),
(39,'71234568M','Hector','Conde','604333777','hector.conde@example.com','Empleado','2025-01-01',5),
(40,'81234568N','Isabel','Diaz','604333888','isabel.diaz@example.com','Empleado','2025-01-01',5),
(41,'91234568O','Luis','Garcia','604333999','luis.garcia@example.com','Empleado','2025-01-01',5),
(42,'01234568P','Antonio','Torres','605444000','antonio.torres@example.com','Responsable','2025-01-01',6),
(43,'11234568Q','Beatriz','Saez','605444111','beatriz.saez@example.com','Empleado','2025-01-01',6),
(44,'21234568R','Ricardo','Vera','605444222','ricardo.vera@example.com','Empleado','2025-01-01',6),
(45,'31234568S','Claudia','Rios','605444333','claudia.rios@example.com','Empleado','2025-01-01',6),
(46,'41234568T','Javier','Pena','606555000','javier.pena@example.com','Responsable','2025-01-01',7),
(47,'51234568U','Alicia','Cruz','606555111','alicia.cruz@example.com','Empleado','2025-01-01',7),
(48,'61234568V','Raul','Soto','606555222','raul.soto@example.com','Empleado','2025-01-01',7),
(49,'71234568W','Silvia','Leon','606555333','silvia.leon@example.com','Empleado','2025-01-01',7);
/*!40000 ALTER TABLE `EMPLEADO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ENTRADA`
--

DROP TABLE IF EXISTS `ENTRADA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ENTRADA` (
  `ID_ENTRADA` int(11) NOT NULL AUTO_INCREMENT,
  `FECHA_RESERVA` date NOT NULL,
  `PRECIO_FINAL` decimal(8,2) NOT NULL,
  `TIPO` enum('Adulto','Infantil','Escolar','Jubilado') NOT NULL DEFAULT 'Adulto',
  `ESTADO` enum('Activa','Cancelada','No utilizada') NOT NULL DEFAULT 'No utilizada',
  `ID_CLIENTE` int(11) DEFAULT NULL,
  `ID_EVENTO` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_ENTRADA`),
  KEY `FK_ENTRADA_CLIENTE` (`ID_CLIENTE`),
  KEY `FK_ENTRADA_EVENTO` (`ID_EVENTO`),
  CONSTRAINT `FK_ENTRADA_CLIENTE` FOREIGN KEY (`ID_CLIENTE`) REFERENCES `CLIENTE` (`ID_CLIENTE`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ENTRADA_EVENTO` FOREIGN KEY (`ID_EVENTO`) REFERENCES `EVENTO` (`ID_EVENTO`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ENTRADA`
--

LOCK TABLES `ENTRADA` WRITE;
/*!40000 ALTER TABLE `ENTRADA` DISABLE KEYS */;
INSERT INTO `ENTRADA` VALUES
(1,'2025-12-01',20.00,'Adulto','Activa',1,1),
(2,'2025-12-02',20.00,'Adulto','Activa',2,1),
(3,'2025-12-03',20.00,'Jubilado','Activa',3,1),
(4,'2025-12-04',20.00,'Adulto','No utilizada',4,1),
(5,'2025-12-05',25.00,'Adulto','Activa',5,2),
(6,'2025-12-06',25.00,'Escolar','Activa',6,2),
(7,'2025-12-07',25.00,'Infantil','Cancelada',7,2),
(8,'2025-12-08',25.00,'Adulto','Activa',8,2),
(9,'2025-12-09',10.00,'Escolar','Activa',9,3),
(10,'2025-12-10',10.00,'Infantil','Activa',10,3),
(11,'2025-12-11',10.00,'Adulto','No utilizada',11,3),
(12,'2025-12-12',10.00,'Escolar','Activa',12,3),
(13,'2025-12-13',20.00,'Adulto','Activa',13,1),
(14,'2025-12-14',20.00,'Infantil','Activa',14,1),
(15,'2025-12-15',20.00,'Adulto','Activa',15,1),
(16,'2025-12-16',25.00,'Adulto','Activa',16,2),
(17,'2025-12-17',25.00,'Adulto','No utilizada',17,2),
(18,'2025-12-18',10.00,'Infantil','Activa',18,3),
(19,'2025-12-19',10.00,'Escolar','Activa',19,3),
(20,'2025-12-20',20.00,'Adulto','Cancelada',20,1),
(21,'2025-12-23',50.00,'Adulto','No utilizada',1,1);
/*!40000 ALTER TABLE `ENTRADA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EVENTO`
--

DROP TABLE IF EXISTS `EVENTO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `EVENTO` (
  `ID_EVENTO` int(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(150) DEFAULT NULL,
  `DESCRIPCION` text DEFAULT NULL,
  `PRECIO` decimal(8,2) DEFAULT NULL,
  `PLAZAS` int(11) DEFAULT NULL,
  `FECHA_INICIO` date DEFAULT NULL,
  `FECHA_FIN` date DEFAULT NULL,
  `ID_DEPART` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_EVENTO`),
  KEY `FK_EVENTO_DEPARTAMENTO` (`ID_DEPART`),
  CONSTRAINT `FK_EVENTO_DEPARTAMENTO` FOREIGN KEY (`ID_DEPART`) REFERENCES `DEPARTAMENTO` (`ID_DEPART`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EVENTO`
--

LOCK TABLES `EVENTO` WRITE;
/*!40000 ALTER TABLE `EVENTO` DISABLE KEYS */;
INSERT INTO `EVENTO` VALUES
(1,'Tour Histórico Almeida Manor','Recorrido por la mansión de 3 pisos y 45 habitaciones, historia de la familia Almeida',20.00,50,'2025-12-01','2025-12-31',3),
(2,'Colección Privada de Arte Almeida','Exposición de obras de arte coleccionadas y restauradas por la familia Almeida',25.00,40,'2025-12-05','2025-12-20',1),
(3,'Pequeños Historiadores: Taller en la Mansión','Taller educativo para niños y familias sobre la historia y arquitectura de la mansión',10.00,30,'2025-12-10','2025-12-15',3);
/*!40000 ALTER TABLE `EVENTO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FINANZAS`
--

DROP TABLE IF EXISTS `FINANZAS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `FINANZAS` (
  `ID_FINANZA` int(11) NOT NULL AUTO_INCREMENT,
  `TIPO` varchar(50) DEFAULT NULL,
  `IMPORTE` decimal(10,2) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  `METODO_PAGO` varchar(50) DEFAULT NULL,
  `CONCEPTO` varchar(150) DEFAULT NULL,
  `ID_DEPART` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_FINANZA`),
  KEY `FK_FINANZAS_DEPARTAMENTO` (`ID_DEPART`),
  CONSTRAINT `FK_FINANZAS_DEPARTAMENTO` FOREIGN KEY (`ID_DEPART`) REFERENCES `DEPARTAMENTO` (`ID_DEPART`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FINANZAS`
--

LOCK TABLES `FINANZAS` WRITE;
/*!40000 ALTER TABLE `FINANZAS` DISABLE KEYS */;
/*!40000 ALTER TABLE `FINANZAS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `INVENTARIO_DEPT`
--

DROP TABLE IF EXISTS `INVENTARIO_DEPT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `INVENTARIO_DEPT` (
  `ID_ITEM_DEPT` int(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(150) DEFAULT NULL,
  `DESCRIPCION` text DEFAULT NULL,
  `TIPO` varchar(50) DEFAULT NULL,
  `UBICACION` varchar(100) DEFAULT NULL,
  `FECHA_ADQUISICION` date DEFAULT NULL,
  `ID_DEPART` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_ITEM_DEPT`),
  KEY `FK_INV_DEPT_DEPARTAMENTO` (`ID_DEPART`),
  CONSTRAINT `FK_INV_DEPT_DEPARTAMENTO` FOREIGN KEY (`ID_DEPART`) REFERENCES `DEPARTAMENTO` (`ID_DEPART`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `INVENTARIO_DEPT`
--

LOCK TABLES `INVENTARIO_DEPT` WRITE;
/*!40000 ALTER TABLE `INVENTARIO_DEPT` DISABLE KEYS */;
/*!40000 ALTER TABLE `INVENTARIO_DEPT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `INVENTARIO_MUSEO`
--

DROP TABLE IF EXISTS `INVENTARIO_MUSEO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `INVENTARIO_MUSEO` (
  `ID_ITEM` int(11) NOT NULL AUTO_INCREMENT,
  `NOMBRE` varchar(150) DEFAULT NULL,
  `DESCRIPCION` text DEFAULT NULL,
  `TIPO` varchar(50) DEFAULT NULL,
  `UBICACION` varchar(100) DEFAULT NULL,
  `ESTADO` varchar(50) DEFAULT NULL,
  `FECHA_REGISTRO` date DEFAULT NULL,
  `ID_DEPART` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_ITEM`),
  KEY `FK_INV_MUSEO_DEPARTAMENTO` (`ID_DEPART`),
  CONSTRAINT `FK_INV_MUSEO_DEPARTAMENTO` FOREIGN KEY (`ID_DEPART`) REFERENCES `DEPARTAMENTO` (`ID_DEPART`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `INVENTARIO_MUSEO`
--

LOCK TABLES `INVENTARIO_MUSEO` WRITE;
/*!40000 ALTER TABLE `INVENTARIO_MUSEO` DISABLE KEYS */;
/*!40000 ALTER TABLE `INVENTARIO_MUSEO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TRABAJO_CONSERVACION`
--

DROP TABLE IF EXISTS `TRABAJO_CONSERVACION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `TRABAJO_CONSERVACION` (
  `ID_TRABAJO` int(11) NOT NULL AUTO_INCREMENT,
  `DESCRIPCION` text DEFAULT NULL,
  `EMPRESA_EXTERNA` varchar(150) DEFAULT NULL,
  `COSTE` decimal(10,2) DEFAULT NULL,
  `FECHA_INICIO` date DEFAULT NULL,
  `FECHA_FIN` date DEFAULT NULL,
  `ID_ITEM` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_TRABAJO`),
  KEY `FK_TRABAJO_ITEM` (`ID_ITEM`),
  CONSTRAINT `FK_TRABAJO_ITEM` FOREIGN KEY (`ID_ITEM`) REFERENCES `INVENTARIO_MUSEO` (`ID_ITEM`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TRABAJO_CONSERVACION`
--

LOCK TABLES `TRABAJO_CONSERVACION` WRITE;
/*!40000 ALTER TABLE `TRABAJO_CONSERVACION` DISABLE KEYS */;
/*!40000 ALTER TABLE `TRABAJO_CONSERVACION` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-24 16:27:01
