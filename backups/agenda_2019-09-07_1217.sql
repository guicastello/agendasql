-- MySQL dump 10.16  Distrib 10.1.41-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: agenda
-- ------------------------------------------------------
-- Server version	10.1.41-MariaDB-0ubuntu0.18.04.1

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
-- Table structure for table `calendario`
--

DROP TABLE IF EXISTS `calendario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendario` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `hora_ini` time DEFAULT NULL,
  `hora_fin` time DEFAULT NULL,
  `todo_dia` tinyint(1) DEFAULT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calendario`
--

LOCK TABLES `calendario` WRITE;
/*!40000 ALTER TABLE `calendario` DISABLE KEYS */;
INSERT INTO `calendario` VALUES (1,'2019-08-25','21:00:00','23:05:00',0,'Agregue el modulo de tareas y modifique los tipos de campos. Borre datos viejos'),(2,'2019-08-25','23:00:00','23:10:00',0,'Correccion de formato de fechas en agendasql.sh para adaptarse a los tipos de campos modificados.'),(3,'1906-04-16','00:00:00','00:00:00',1,'Nacio el Abu Joe'),(4,'1912-09-21','00:00:00','00:00:00',0,'Nacio la Abu Vera'),(5,'1937-08-22','00:00:00','00:00:00',0,'Nacio Mami'),(6,'1938-04-24','00:00:00','00:00:00',0,'Nacio Papi'),(7,'1940-07-29','00:00:00','00:00:00',0,'Nacio Jorge'),(8,'1957-03-27','00:00:00','00:00:00',0,'Nacio Lili Hisas'),(9,'1967-12-16','00:00:00','00:00:00',0,'Naci yo'),(10,'1970-09-10','00:00:00','00:00:00',0,'Nacio Gise'),(11,'1971-03-27','00:00:00','00:00:00',0,'Nacio Vicky'),(12,'1975-09-15','00:00:00','00:00:00',0,'Nacio Vero');
/*!40000 ALTER TABLE `calendario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tareas`
--

DROP TABLE IF EXISTS `tareas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tareas` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(64) DEFAULT NULL,
  `prioridad` int(1) DEFAULT NULL,
  `fecha_ini` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `hora_ini` time DEFAULT NULL,
  `hora_fin` time DEFAULT NULL,
  `completada` tinyint(1) DEFAULT NULL,
  `Notas` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tareas`
--

LOCK TABLES `tareas` WRITE;
/*!40000 ALTER TABLE `tareas` DISABLE KEYS */;
INSERT INTO `tareas` VALUES (1,'Activar Tarjeta Mastercard',0,'2019-09-02','2019-09-05','00:00:00','00:00:00',1,'Llamar por telefono y activar la Tarjeta.'),(2,'Llamar a Silvia Barrios',0,'2019-09-17','2019-09-24','00:00:00','00:00:00',0,'mandar un email a Silvia.'),(3,'Retirar las Tarjetas Visas',1,'2019-09-09','2019-09-16','00:00:00','00:00:00',0,'Pasar por la sucursal ICBC de Norcenter');
/*!40000 ALTER TABLE `tareas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-07 12:17:29
