CREATE DATABASE  IF NOT EXISTS `ciis` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ciis`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ciis
-- ------------------------------------------------------
-- Server version	9.6.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ 'c2cf9f2e-1262-11f1-9940-2c58b9d7ace8:1-1148';

--
-- Table structure for table `aliado`
--

DROP TABLE IF EXISTS `aliado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aliado` (
  `id_aliado` int NOT NULL AUTO_INCREMENT,
  `nombre_aliado` varchar(50) NOT NULL,
  `tipo_aliado` varchar(20) NOT NULL,
  PRIMARY KEY (`id_aliado`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aliado`
--

LOCK TABLES `aliado` WRITE;
/*!40000 ALTER TABLE `aliado` DISABLE KEYS */;
INSERT INTO `aliado` VALUES (2,'Bachillerato Tehuacan','Institucion'),(3,'Primaria Xicotepec','Escuela'),(4,'Secundaria Amozoc','OSC'),(5,'Centro de Salud Tepeaca','Area interna'),(6,'Casa de Cultura Santa Clara Ocoyucan','Empresa'),(7,'OSC Desarrollo Izucar de Matamoros','Gobierno'),(8,'Parroquia San Martin Texmelucan','Institucion'),(9,'Comite Comunitario Acatzingo','Escuela'),(10,'Universidad Area Puebla','OSC'),(11,'Empresa Social San Pedro Cholula','Area interna'),(12,'Colectivo Juvenil Tehuacan','Empresa'),(13,'Biblioteca Xicotepec','Gobierno'),(14,'Clinica Amozoc','Institucion'),(15,'Centro Comunitario Tepeaca','Escuela'),(16,'Fundacion Santa Clara Ocoyucan','OSC'),(17,'DIF Municipal Izucar de Matamoros','Area interna'),(18,'Instituto San Martin Texmelucan','Empresa'),(19,'Cooperativa Acatzingo','Gobierno'),(20,'Preparatoria Puebla','Institucion'),(21,'Ayuntamiento San Pedro Cholula','Escuela'),(22,'Bachillerato Tehuacan','OSC'),(23,'Primaria Xicotepec','Area interna'),(24,'Secundaria Amozoc','Empresa'),(25,'Centro de Salud Tepeaca','Gobierno'),(26,'Casa de Cultura Santa Clara Ocoyucan','Institucion'),(27,'OSC Desarrollo Izucar de Matamoros','Escuela'),(28,'Parroquia San Martin Texmelucan','OSC'),(29,'Comite Comunitario Acatzingo','Area interna'),(30,'Universidad Area Puebla','Empresa'),(31,'Empresa Social San Pedro Cholula','Gobierno'),(32,'Colectivo Juvenil Tehuacan','Institucion'),(33,'Biblioteca Xicotepec','Escuela'),(34,'Clinica Amozoc','OSC'),(35,'Centro Comunitario Tepeaca','Area interna'),(36,'Fundacion Santa Clara Ocoyucan','Empresa'),(37,'DIF Municipal Izucar de Matamoros','Gobierno'),(38,'Instituto San Martin Texmelucan','Institucion'),(39,'Cooperativa Acatzingo','Escuela'),(40,'Preparatoria Puebla','OSC'),(41,'Ayuntamiento San Pedro Cholula','Area interna'),(42,'Bachillerato Tehuacan','Empresa'),(43,'Primaria Xicotepec','Gobierno'),(44,'Secundaria Amozoc','Institucion'),(45,'Centro de Salud Tepeaca','Escuela'),(46,'Casa de Cultura Santa Clara Ocoyucan','OSC'),(47,'OSC Desarrollo Izucar de Matamoros','Area interna'),(48,'Parroquia San Martin Texmelucan','Empresa'),(49,'Comite Comunitario Acatzingo','Gobierno'),(50,'Universidad Area Puebla','Institucion'),(51,'Empresa Social San Pedro Cholula','Escuela'),(52,'Colectivo Juvenil Tehuacan','OSC'),(53,'Biblioteca Xicotepec','Area interna');
/*!40000 ALTER TABLE `aliado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apoyar`
--

DROP TABLE IF EXISTS `apoyar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apoyar` (
  `id_aliado` int NOT NULL,
  `id_proyecto` int NOT NULL,
  PRIMARY KEY (`id_aliado`,`id_proyecto`),
  KEY `id_prroyect_fk` (`id_proyecto`),
  CONSTRAINT `id_aliado_fk` FOREIGN KEY (`id_aliado`) REFERENCES `aliado` (`id_aliado`),
  CONSTRAINT `id_prroyect_fk` FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apoyar`
--

LOCK TABLES `apoyar` WRITE;
/*!40000 ALTER TABLE `apoyar` DISABLE KEYS */;
INSERT INTO `apoyar` VALUES (11,2),(24,2),(16,3),(21,4),(42,4),(26,5),(7,6),(31,6),(36,7),(25,8),(41,8),(46,9),(43,10),(51,10),(3,11),(8,12),(13,13),(31,13),(18,14),(23,15),(49,15),(28,16),(14,17),(33,17),(38,18),(32,19),(43,19),(48,20),(50,21),(53,21),(5,22),(10,23),(15,23),(15,24),(38,24),(20,25),(3,26),(25,26),(30,27),(21,28),(35,28),(40,29),(39,30),(45,30),(50,31),(2,32),(4,32),(7,33),(12,34),(22,34),(17,35),(45,35),(22,36),(10,37),(27,37),(32,38),(28,39),(37,39),(42,40),(46,41),(47,41),(52,42),(4,43),(11,43),(9,44),(14,45),(29,45),(19,46),(52,46),(24,47),(17,48),(29,48),(34,49),(35,50),(39,50),(44,51),(49,52),(53,52),(6,54),(18,54),(11,55),(16,56),(36,56),(21,57);
/*!40000 ALTER TABLE `apoyar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comunidad`
--

DROP TABLE IF EXISTS `comunidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comunidad` (
  `id_comunidad` int NOT NULL AUTO_INCREMENT,
  `nombre_comunidad` varchar(50) NOT NULL,
  `municipio` varchar(50) NOT NULL,
  PRIMARY KEY (`id_comunidad`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comunidad`
--

LOCK TABLES `comunidad` WRITE;
/*!40000 ALTER TABLE `comunidad` DISABLE KEYS */;
INSERT INTO `comunidad` VALUES (2,'San Miguel','Atlixco'),(3,'La Esperanza','Xicotepec'),(4,'El Mirador','Zacatlan'),(5,'Los Pinos','Santa Clara Ocoyucan'),(6,'Santa Maria','Huejotzingo'),(7,'San Jose','Acatzingo'),(8,'El Carmen','San Andres Cholula'),(9,'La Libertad','Tehuacan'),(10,'San Rafael','Huauchinango'),(11,'San Antonio','Tepeaca'),(12,'Guadalupe','Tecamachalco'),(13,'La Trinidad','San Martin Texmelucan'),(14,'Santa Cruz','Tlatlauquitepec'),(15,'San Pedro','San Pedro Cholula'),(16,'Las Flores','Cuetzalan del Progreso'),(17,'El Rosario','Amozoc'),(18,'Buena Vista','Chignahuapan'),(19,'San Isidro','Izucar de Matamoros'),(20,'La Reforma','Teziutlan'),(21,'San Juan','Puebla'),(22,'San Andres','Atlixco'),(23,'La Paz','Xicotepec'),(24,'San Gabriel','Zacatlan'),(25,'El Progreso','Santa Clara Ocoyucan'),(26,'Nueva Vida','Huejotzingo'),(27,'La Union','Acatzingo'),(28,'Benito Juarez','San Andres Cholula'),(29,'Emiliano Zapata','Tehuacan'),(30,'San Francisco','Huauchinango'),(31,'La Cumbre','Tepeaca'),(32,'San Mateo','Tecamachalco'),(33,'Santa Lucia','San Martin Texmelucan'),(34,'San Nicolas','Tlatlauquitepec'),(35,'La Loma','San Pedro Cholula'),(36,'El Paraiso','Cuetzalan del Progreso'),(37,'San Martin','Amozoc'),(38,'Tierra Nueva','Chignahuapan'),(39,'Los Angeles','Izucar de Matamoros'),(40,'San Luis','Teziutlan'),(41,'El Encanto','Puebla'),(42,'La Palma','Atlixco'),(43,'San Pablo','Xicotepec'),(44,'El Molino','Zacatlan'),(45,'San Marcos','Santa Clara Ocoyucan'),(46,'San Felipe','Huejotzingo'),(47,'La Aurora','Acatzingo'),(48,'El Bosque','San Andres Cholula'),(49,'Santa Rosa','Tehuacan'),(50,'San Diego','Huauchinango'),(51,'La Magdalena','Tepeaca'),(52,'San Lucas','Tecamachalco'),(53,'San Baltazar','San Martin Texmelucan'),(54,'San Jeronimo','Tlatlauquitepec'),(55,'Santo Tomas','San Pedro Cholula'),(56,'El Refugio','Cuetzalan del Progreso'),(57,'San Cristobal','Amozoc'),(58,'La Providencia','Chignahuapan'),(59,'San Miguelito','Izucar de Matamoros');
/*!40000 ALTER TABLE `comunidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estudiante`
--

DROP TABLE IF EXISTS `estudiante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estudiante` (
  `matricula` varchar(10) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `gen_ingreso` int NOT NULL,
  `estatus` varchar(20) NOT NULL,
  `correo` varchar(50) NOT NULL,
  `id_programa` int NOT NULL,
  `id_coordinador` int NOT NULL,
  `frecuencia_sesion` varchar(20) NOT NULL,
  PRIMARY KEY (`matricula`),
  KEY `fk_programa` (`id_programa`),
  KEY `fk_coordinador` (`id_coordinador`),
  CONSTRAINT `fk_coordinador` FOREIGN KEY (`id_coordinador`) REFERENCES `persona_acompañamiento` (`id_persona_acom`),
  CONSTRAINT `fk_programa` FOREIGN KEY (`id_programa`) REFERENCES `programa` (`id_programa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudiante`
--

LOCK TABLES `estudiante` WRITE;
/*!40000 ALTER TABLE `estudiante` DISABLE KEYS */;
INSERT INTO `estudiante` VALUES ('A0001','Ana Hernandez Sanchez',2021,'Egresado','ana.hernandez0001@upaep.mx',1,3,'Semanal'),('A0002','Maria Perez Morales',2022,'Egresado','maria.perez0002@upaep.mx',1,5,'Quincenal'),('A0003','Jose Ramirez Aguilar',2023,'Activo','jose.ramirez0003@upaep.mx',2,2,'Mensual'),('A0004','Luis Flores Navarro',2024,'Activo','luis.flores0004@upaep.mx',2,3,'Semanal'),('A0005','Carlos Morales Benitez',2025,'Activo','carlos.morales0005@upaep.mx',3,4,'Quincenal'),('A0006','Daniela Castillo Garcia',2026,'Activo','daniela.castillo0006@upaep.mx',4,5,'Mensual'),('A0007','Sofia Rojas Sanchez',2021,'Egresado','sofia.rojas0007@upaep.mx',5,6,'Semanal'),('A0008','Regina Mendez Morales',2022,'Egresado','regina.mendez0008@upaep.mx',6,1,'Quincenal'),('A0009','Paola Silva Aguilar',2023,'Activo','paola.silva0009@upaep.mx',7,1,'Mensual'),('A0010','Jorge Navarro Navarro',2024,'Activo','jorge.navarro0010@upaep.mx',1,2,'Semanal'),('A0011','Emiliano Dominguez Benitez',2025,'Baja','emiliano.dominguez0011@upaep.mx',1,3,'Quincenal'),('A0012','Isabel Luna Garcia',2026,'Activo','isabel.luna0012@upaep.mx',2,5,'Mensual'),('A0013','Ines Cortes Sanchez',2021,'Egresado','ines.cortes0013@upaep.mx',2,5,'Semanal'),('A0014','Valeria Velasco Morales',2022,'Egresado','valeria.velasco0014@upaep.mx',3,6,'Quincenal'),('A0015','Camila Garcia Aguilar',2023,'Activo','camila.garcia0015@upaep.mx',4,1,'Mensual'),('A0016','Fernando Hernandez Navarro',2024,'Activo','fernando.hernandez0016@upaep.mx',5,1,'Semanal'),('A0017','Diego Perez Benitez',2025,'Activo','diego.perez0017@upaep.mx',6,2,'Quincenal'),('A0018','Laura Ramirez Garcia',2026,'Activo','laura.ramirez0018@upaep.mx',7,3,'Mensual'),('A0019','Andrea Flores Sanchez',2021,'Egresado','andrea.flores0019@upaep.mx',1,4,'Semanal'),('A0020','Miguel Morales Morales',2022,'Baja','miguel.morales0020@upaep.mx',1,5,'Quincenal'),('A0021','Hector Castillo Aguilar',2023,'Egresado','hector.castillo0021@upaep.mx',2,6,'Mensual'),('A0022','Claudia Rojas Navarro',2024,'Baja','claudia.rojas0022@upaep.mx',2,1,'Semanal'),('A0023','Mariana Mendez Benitez',2025,'Activo','mariana.mendez0023@upaep.mx',3,1,'Quincenal'),('A0024','Andres Silva Garcia',2026,'Activo','andres.silva0024@upaep.mx',4,2,'Mensual'),('A0025','Sara Navarro Sanchez',2021,'Baja','sara.navarro0025@upaep.mx',5,3,'Semanal'),('A0026','Rafael Dominguez Morales',2022,'Egresado','rafael.dominguez0026@upaep.mx',6,4,'Quincenal'),('A0027','Lucia Luna Aguilar',2023,'Activo','lucia.luna0027@upaep.mx',7,5,'Mensual'),('A0028','Pablo Cortes Navarro',2024,'Activo','pablo.cortes0028@upaep.mx',1,6,'Semanal'),('A0029','Elena Velasco Benitez',2025,'Activo','elena.velasco0029@upaep.mx',1,1,'Quincenal'),('A0030','Ricardo Garcia Garcia',2026,'Activo','ricardo.garcia0030@upaep.mx',2,1,'Mensual'),('A0031','Natalia Hernandez Sanchez',2021,'Egresado','natalia.hernandez0031@upaep.mx',2,2,'Semanal'),('A0032','Mauricio Perez Morales',2022,'Egresado','mauricio.perez0032@upaep.mx',3,3,'Quincenal'),('A0033','Renata Ramirez Aguilar',2023,'Activo','renata.ramirez0033@upaep.mx',4,4,'Mensual'),('A0034','Adrian Flores Navarro',2024,'Activo','adrian.flores0034@upaep.mx',5,5,'Semanal'),('A0035','Patricia Morales Benitez',2025,'Activo','patricia.morales0035@upaep.mx',6,6,'Quincenal'),('A0036','David Castillo Garcia',2026,'Activo','david.castillo0036@upaep.mx',7,1,'Mensual'),('A0037','Gabriela Rojas Sanchez',2021,'Egresado','gabriela.rojas0037@upaep.mx',1,1,'Semanal'),('A0038','Rodrigo Mendez Morales',2022,'Egresado','rodrigo.mendez0038@upaep.mx',1,2,'Quincenal'),('A0039','Fernanda Silva Aguilar',2023,'Activo','fernanda.silva0039@upaep.mx',2,3,'Mensual'),('A0040','Ivanna Navarro Navarro',2024,'Activo','ivanna.navarro0040@upaep.mx',2,4,'Semanal'),('A0041','Ana Dominguez Benitez',2025,'Activo','ana.dominguez0041@upaep.mx',3,5,'Quincenal'),('A0042','Maria Luna Garcia',2026,'Activo','maria.luna0042@upaep.mx',4,6,'Mensual'),('A0043','Jose Cortes Sanchez',2021,'Egresado','jose.cortes0043@upaep.mx',5,1,'Semanal'),('A0044','Luis Velasco Morales',2022,'Egresado','luis.velasco0044@upaep.mx',6,1,'Quincenal'),('A0045','Carlos Garcia Aguilar',2023,'Activo','carlos.garcia0045@upaep.mx',7,2,'Mensual'),('A0046','Daniela Hernandez Navarro',2024,'Activo','daniela.hernandez0046@upaep.mx',1,3,'Semanal'),('A0047','Sofia Perez Benitez',2025,'Activo','sofia.perez0047@upaep.mx',1,4,'Quincenal'),('A0048','Regina Ramirez Garcia',2026,'Activo','regina.ramirez0048@upaep.mx',2,5,'Mensual'),('A0049','Paola Flores Sanchez',2021,'Egresado','paola.flores0049@upaep.mx',2,6,'Semanal'),('A0050','Jorge Morales Morales',2022,'Baja','jorge.morales0050@upaep.mx',3,1,'Quincenal'),('A0051','Emiliano Castillo Aguilar',2023,'Activo','emiliano.castillo0051@upaep.mx',4,1,'Mensual'),('A0052','Isabel Rojas Navarro',2024,'Activo','isabel.rojas0052@upaep.mx',5,2,'Semanal'),('A0053','Ines Mendez Benitez',2025,'Activo','ines.mendez0053@upaep.mx',6,3,'Quincenal'),('A0054','Valeria Silva Garcia',2026,'Activo','valeria.silva0054@upaep.mx',7,4,'Mensual'),('A0055','Camila Navarro Sanchez',2021,'Baja','camila.navarro0055@upaep.mx',1,5,'Semanal'),('A0056','Fernando Dominguez Morales',2022,'Egresado','fernando.dominguez0056@upaep.mx',1,6,'Quincenal'),('A0057','Diego Luna Aguilar',2023,'Activo','diego.luna0057@upaep.mx',2,1,'Mensual'),('A0058','Laura Cortes Navarro',2024,'Activo','laura.cortes0058@upaep.mx',2,1,'Semanal'),('A0059','Andrea Velasco Benitez',2025,'Activo','andrea.velasco0059@upaep.mx',3,2,'Quincenal'),('A0060','Miguel Garcia Garcia',2026,'Activo','miguel.garcia0060@upaep.mx',4,3,'Mensual'),('A0061','Hector Hernandez Sanchez',2021,'Egresado','hector.hernandez0061@upaep.mx',5,4,'Semanal'),('A0062','Claudia Perez Morales',2022,'Egresado','claudia.perez0062@upaep.mx',6,5,'Quincenal'),('A0063','Mariana Ramirez Aguilar',2023,'Egresado','mariana.ramirez0063@upaep.mx',7,6,'Mensual'),('A0064','Andres Flores Navarro',2024,'Activo','andres.flores0064@upaep.mx',1,1,'Semanal'),('A0065','Sara Morales Benitez',2025,'Activo','sara.morales0065@upaep.mx',1,1,'Quincenal'),('A0066','Rafael Castillo Garcia',2026,'Baja','rafael.castillo0066@upaep.mx',2,2,'Mensual'),('A0067','Lucia Rojas Sanchez',2021,'Egresado','lucia.rojas0067@upaep.mx',2,3,'Semanal'),('A0068','Pablo Mendez Morales',2022,'Egresado','pablo.mendez0068@upaep.mx',3,4,'Quincenal'),('A0069','Elena Silva Aguilar',2023,'Activo','elena.silva0069@upaep.mx',4,5,'Mensual'),('A0070','Ricardo Navarro Navarro',2024,'Activo','ricardo.navarro0070@upaep.mx',5,6,'Semanal'),('A0071','Natalia Dominguez Benitez',2025,'Activo','natalia.dominguez0071@upaep.mx',6,1,'Quincenal'),('A0072','Mauricio Luna Garcia',2026,'Activo','mauricio.luna0072@upaep.mx',7,1,'Mensual'),('A0073','Renata Cortes Sanchez',2021,'Egresado','renata.cortes0073@upaep.mx',1,2,'Semanal'),('A0074','Adrian Velasco Morales',2022,'Egresado','adrian.velasco0074@upaep.mx',1,3,'Quincenal'),('A0075','Patricia Garcia Aguilar',2023,'Activo','patricia.garcia0075@upaep.mx',2,4,'Mensual'),('A0076','David Hernandez Navarro',2024,'Activo','david.hernandez0076@upaep.mx',2,5,'Semanal'),('A0077','Gabriela Perez Benitez',2025,'Baja','gabriela.perez0077@upaep.mx',3,6,'Quincenal'),('A0078','Rodrigo Ramirez Garcia',2026,'Activo','rodrigo.ramirez0078@upaep.mx',4,1,'Mensual'),('A0079','Fernanda Flores Sanchez',2021,'Egresado','fernanda.flores0079@upaep.mx',5,1,'Semanal'),('A0080','Ivanna Morales Morales',2022,'Baja','ivanna.morales0080@upaep.mx',6,2,'Quincenal'),('A0081','Ana Castillo Aguilar',2023,'Activo','ana.castillo0081@upaep.mx',7,3,'Mensual'),('A0082','Maria Rojas Navarro',2024,'Activo','maria.rojas0082@upaep.mx',1,4,'Semanal'),('A0083','Jose Mendez Benitez',2025,'Activo','jose.mendez0083@upaep.mx',1,5,'Quincenal'),('A0084','Luis Silva Garcia',2026,'Activo','luis.silva0084@upaep.mx',2,6,'Mensual'),('A0085','Carlos Navarro Sanchez',2021,'Baja','carlos.navarro0085@upaep.mx',2,1,'Semanal'),('A0086','Daniela Dominguez Morales',2022,'Egresado','daniela.dominguez0086@upaep.mx',3,1,'Quincenal'),('A0087','Sofia Luna Aguilar',2023,'Activo','sofia.luna0087@upaep.mx',4,2,'Mensual'),('A0088','Regina Cortes Navarro',2024,'Baja','regina.cortes0088@upaep.mx',5,3,'Semanal'),('A0089','Paola Velasco Benitez',2025,'Activo','paola.velasco0089@upaep.mx',6,4,'Quincenal'),('A0090','Jorge Garcia Garcia',2026,'Activo','jorge.garcia0090@upaep.mx',7,5,'Mensual'),('A0091','Emiliano Hernandez Sanchez',2021,'Egresado','emiliano.hernandez0091@upaep.mx',1,6,'Semanal'),('A0092','Isabel Perez Morales',2022,'Egresado','isabel.perez0092@upaep.mx',1,1,'Quincenal'),('A0093','Ines Ramirez Aguilar',2023,'Activo','ines.ramirez0093@upaep.mx',2,1,'Mensual'),('A0094','Valeria Flores Navarro',2024,'Activo','valeria.flores0094@upaep.mx',2,2,'Semanal'),('A0095','Camila Morales Benitez',2025,'Activo','camila.morales0095@upaep.mx',3,3,'Quincenal'),('A0096','Fernando Castillo Garcia',2026,'Activo','fernando.castillo0096@upaep.mx',4,4,'Mensual'),('A0097','Diego Rojas Sanchez',2021,'Egresado','diego.rojas0097@upaep.mx',5,5,'Semanal'),('A0098','Laura Mendez Morales',2022,'Egresado','laura.mendez0098@upaep.mx',6,6,'Quincenal'),('A0099','Andrea Silva Aguilar',2023,'Activo','andrea.silva0099@upaep.mx',7,1,'Mensual'),('A0100','Miguel Navarro Navarro',2024,'Activo','miguel.navarro0100@upaep.mx',1,1,'Semanal'),('A0101','Hector Dominguez Benitez',2025,'Activo','hector.dominguez0101@upaep.mx',1,2,'Quincenal'),('A0102','Claudia Luna Garcia',2026,'Activo','claudia.luna0102@upaep.mx',2,3,'Mensual'),('A0103','Mariana Cortes Sanchez',2021,'Egresado','mariana.cortes0103@upaep.mx',2,4,'Semanal'),('A0104','Andres Velasco Morales',2022,'Egresado','andres.velasco0104@upaep.mx',3,5,'Quincenal'),('A0105','Sara Garcia Aguilar',2023,'Egresado','sara.garcia0105@upaep.mx',4,6,'Mensual'),('A0106','Rafael Hernandez Navarro',2024,'Activo','rafael.hernandez0106@upaep.mx',5,1,'Semanal'),('A0107','Lucia Perez Benitez',2025,'Activo','lucia.perez0107@upaep.mx',6,1,'Quincenal'),('A0108','Pablo Ramirez Garcia',2026,'Activo','pablo.ramirez0108@upaep.mx',7,2,'Mensual'),('A0109','Elena Flores Sanchez',2021,'Egresado','elena.flores0109@upaep.mx',1,3,'Semanal'),('A0110','Ricardo Morales Morales',2022,'Baja','ricardo.morales0110@upaep.mx',1,4,'Quincenal'),('A0111','Natalia Castillo Aguilar',2023,'Activo','natalia.castillo0111@upaep.mx',2,5,'Mensual'),('A0112','Mauricio Rojas Navarro',2024,'Activo','mauricio.rojas0112@upaep.mx',2,6,'Semanal'),('A0113','Renata Mendez Benitez',2025,'Activo','renata.mendez0113@upaep.mx',3,1,'Quincenal'),('A0114','Adrian Silva Garcia',2026,'Activo','adrian.silva0114@upaep.mx',4,1,'Mensual'),('A0115','Patricia Navarro Sanchez',2021,'Baja','patricia.navarro0115@upaep.mx',5,2,'Semanal'),('A0116','David Dominguez Morales',2022,'Egresado','david.dominguez0116@upaep.mx',6,3,'Quincenal'),('A0117','Gabriela Luna Aguilar',2023,'Activo','gabriela.luna0117@upaep.mx',7,4,'Mensual'),('A0118','Rodrigo Cortes Navarro',2024,'Activo','rodrigo.cortes0118@upaep.mx',1,5,'Semanal'),('A0119','Fernanda Velasco Benitez',2025,'Activo','fernanda.velasco0119@upaep.mx',1,6,'Quincenal'),('A0120','Ivanna Garcia Garcia',2026,'Activo','ivanna.garcia0120@upaep.mx',2,1,'Mensual'),('A0121','Ana Hernandez Sanchez',2021,'Egresado','ana.hernandez0121@upaep.mx',2,1,'Semanal'),('A0122','Maria Perez Morales',2022,'Egresado','maria.perez0122@upaep.mx',3,2,'Quincenal'),('A0123','Jose Ramirez Aguilar',2023,'Activo','jose.ramirez0123@upaep.mx',4,3,'Mensual'),('A0124','Luis Flores Navarro',2024,'Activo','luis.flores0124@upaep.mx',5,4,'Semanal'),('A0125','Carlos Morales Benitez',2025,'Activo','carlos.morales0125@upaep.mx',6,5,'Quincenal'),('A0126','Daniela Castillo Garcia',2026,'Activo','daniela.castillo0126@upaep.mx',7,6,'Mensual'),('A0127','Sofia Rojas Sanchez',2021,'Egresado','sofia.rojas0127@upaep.mx',1,1,'Semanal'),('A0128','Regina Mendez Morales',2022,'Egresado','regina.mendez0128@upaep.mx',1,1,'Quincenal'),('A0129','Paola Silva Aguilar',2023,'Activo','paola.silva0129@upaep.mx',2,2,'Mensual'),('A0130','Jorge Navarro Navarro',2024,'Activo','jorge.navarro0130@upaep.mx',2,3,'Semanal'),('A0131','Emiliano Dominguez Benitez',2025,'Activo','emiliano.dominguez0131@upaep.mx',3,4,'Quincenal'),('A0132','Isabel Luna Garcia',2026,'Baja','isabel.luna0132@upaep.mx',4,5,'Mensual'),('A0133','Ines Cortes Sanchez',2021,'Egresado','ines.cortes0133@upaep.mx',5,6,'Semanal'),('A0134','Valeria Velasco Morales',2022,'Egresado','valeria.velasco0134@upaep.mx',6,1,'Quincenal'),('A0135','Camila Garcia Aguilar',2023,'Activo','camila.garcia0135@upaep.mx',7,1,'Mensual'),('A0136','Fernando Hernandez Navarro',2024,'Activo','fernando.hernandez0136@upaep.mx',1,2,'Semanal'),('A0137','Diego Perez Benitez',2025,'Activo','diego.perez0137@upaep.mx',1,3,'Quincenal'),('A0138','Laura Ramirez Garcia',2026,'Activo','laura.ramirez0138@upaep.mx',2,4,'Mensual'),('A0139','Andrea Flores Sanchez',2021,'Egresado','andrea.flores0139@upaep.mx',2,5,'Semanal'),('A0140','Miguel Morales Morales',2022,'Baja','miguel.morales0140@upaep.mx',3,6,'Quincenal'),('A0141','Hector Castillo Aguilar',2023,'Activo','hector.castillo0141@upaep.mx',4,1,'Mensual'),('A0142','Claudia Rojas Navarro',2024,'Activo','claudia.rojas0142@upaep.mx',5,1,'Semanal'),('A0143','Mariana Mendez Benitez',2025,'Baja','mariana.mendez0143@upaep.mx',6,2,'Quincenal'),('A0144','Andres Silva Garcia',2026,'Activo','andres.silva0144@upaep.mx',7,3,'Mensual'),('A0145','Sara Navarro Sanchez',2021,'Baja','sara.navarro0145@upaep.mx',1,4,'Semanal'),('A0146','Rafael Dominguez Morales',2022,'Egresado','rafael.dominguez0146@upaep.mx',1,5,'Quincenal'),('A0147','Lucia Luna Aguilar',2023,'Egresado','lucia.luna0147@upaep.mx',2,6,'Mensual'),('A0148','Pablo Cortes Navarro',2024,'Activo','pablo.cortes0148@upaep.mx',2,1,'Semanal'),('A0149','Elena Velasco Benitez',2025,'Activo','elena.velasco0149@upaep.mx',3,1,'Quincenal'),('A0150','Ricardo Garcia Garcia',2026,'Activo','ricardo.garcia0150@upaep.mx',4,2,'Mensual'),('A0151','Natalia Hernandez Sanchez',2021,'Egresado','natalia.hernandez0151@upaep.mx',5,3,'Semanal'),('A0152','Mauricio Perez Morales',2022,'Egresado','mauricio.perez0152@upaep.mx',6,4,'Quincenal'),('A0153','Renata Ramirez Aguilar',2023,'Activo','renata.ramirez0153@upaep.mx',7,5,'Mensual'),('A0154','Adrian Flores Navarro',2024,'Baja','adrian.flores0154@upaep.mx',1,6,'Semanal'),('A0155','Patricia Morales Benitez',2025,'Activo','patricia.morales0155@upaep.mx',1,1,'Quincenal'),('A0156','David Castillo Garcia',2026,'Activo','david.castillo0156@upaep.mx',2,1,'Mensual'),('A0157','Gabriela Rojas Sanchez',2021,'Egresado','gabriela.rojas0157@upaep.mx',2,2,'Semanal'),('A0158','Rodrigo Mendez Morales',2022,'Egresado','rodrigo.mendez0158@upaep.mx',3,3,'Quincenal'),('A0159','Fernanda Silva Aguilar',2023,'Activo','fernanda.silva0159@upaep.mx',4,4,'Mensual'),('A0160','Ivanna Navarro Navarro',2024,'Activo','ivanna.navarro0160@upaep.mx',5,5,'Semanal'),('A0161','Ana Dominguez Benitez',2025,'Activo','ana.dominguez0161@upaep.mx',6,6,'Quincenal'),('A0162','Maria Luna Garcia',2026,'Activo','maria.luna0162@upaep.mx',7,1,'Mensual'),('A0163','Jose Cortes Sanchez',2021,'Egresado','jose.cortes0163@upaep.mx',1,1,'Semanal'),('A0164','Luis Velasco Morales',2022,'Egresado','luis.velasco0164@upaep.mx',1,2,'Quincenal'),('A0165','Carlos Garcia Aguilar',2023,'Activo','carlos.garcia0165@upaep.mx',2,3,'Mensual'),('A0166','Daniela Hernandez Navarro',2024,'Activo','daniela.hernandez0166@upaep.mx',2,4,'Semanal'),('A0167','Sofia Perez Benitez',2025,'Activo','sofia.perez0167@upaep.mx',3,5,'Quincenal'),('A0168','Regina Ramirez Garcia',2026,'Activo','regina.ramirez0168@upaep.mx',4,6,'Mensual'),('A0169','Paola Flores Sanchez',2021,'Egresado','paola.flores0169@upaep.mx',5,1,'Semanal'),('A0170','Jorge Morales Morales',2022,'Baja','jorge.morales0170@upaep.mx',6,1,'Quincenal'),('A0171','Emiliano Castillo Aguilar',2023,'Activo','emiliano.castillo0171@upaep.mx',7,2,'Mensual'),('A0172','Isabel Rojas Navarro',2024,'Activo','isabel.rojas0172@upaep.mx',1,3,'Semanal'),('A0173','Ines Mendez Benitez',2025,'Activo','ines.mendez0173@upaep.mx',1,4,'Quincenal'),('A0174','Valeria Silva Garcia',2026,'Activo','valeria.silva0174@upaep.mx',2,5,'Mensual'),('A0175','Camila Navarro Sanchez',2021,'Baja','camila.navarro0175@upaep.mx',2,6,'Semanal'),('A0176','Fernando Dominguez Morales',2022,'Egresado','fernando.dominguez0176@upaep.mx',3,1,'Quincenal'),('A0177','Diego Luna Aguilar',2023,'Activo','diego.luna0177@upaep.mx',4,1,'Mensual'),('A0178','Laura Cortes Navarro',2024,'Activo','laura.cortes0178@upaep.mx',5,2,'Semanal'),('A0179','Andrea Velasco Benitez',2025,'Activo','andrea.velasco0179@upaep.mx',6,3,'Quincenal'),('A0180','Miguel Garcia Garcia',2026,'Activo','miguel.garcia0180@upaep.mx',7,4,'Mensual'),('A0181','Hector Hernandez Sanchez',2021,'Egresado','hector.hernandez0181@upaep.mx',1,5,'Semanal'),('A0182','Claudia Perez Morales',2022,'Egresado','claudia.perez0182@upaep.mx',1,6,'Quincenal'),('A0183','Mariana Ramirez Aguilar',2023,'Activo','mariana.ramirez0183@upaep.mx',2,1,'Mensual'),('A0184','Andres Flores Navarro',2024,'Activo','andres.flores0184@upaep.mx',2,1,'Semanal'),('A0185','Sara Morales Benitez',2025,'Activo','sara.morales0185@upaep.mx',3,2,'Quincenal'),('A0186','Rafael Castillo Garcia',2026,'Activo','rafael.castillo0186@upaep.mx',4,3,'Mensual'),('A0187','Lucia Rojas Sanchez',2021,'Egresado','lucia.rojas0187@upaep.mx',5,4,'Semanal'),('A0188','Pablo Mendez Morales',2022,'Egresado','pablo.mendez0188@upaep.mx',6,5,'Quincenal'),('A0189','Elena Silva Aguilar',2023,'Egresado','elena.silva0189@upaep.mx',7,6,'Mensual'),('A0190','Ricardo Navarro Navarro',2024,'Activo','ricardo.navarro0190@upaep.mx',1,1,'Semanal'),('A0191','Natalia Dominguez Benitez',2025,'Activo','natalia.dominguez0191@upaep.mx',1,1,'Quincenal'),('A0192','Mauricio Luna Garcia',2026,'Activo','mauricio.luna0192@upaep.mx',2,2,'Mensual'),('A0193','Renata Cortes Sanchez',2021,'Egresado','renata.cortes0193@upaep.mx',2,3,'Semanal'),('A0194','Adrian Velasco Morales',2022,'Egresado','adrian.velasco0194@upaep.mx',3,4,'Quincenal'),('A0195','Patricia Garcia Aguilar',2023,'Activo','patricia.garcia0195@upaep.mx',4,5,'Mensual'),('A0196','David Hernandez Navarro',2024,'Activo','david.hernandez0196@upaep.mx',5,6,'Semanal'),('A0197','Gabriela Perez Benitez',2025,'Activo','gabriela.perez0197@upaep.mx',6,1,'Quincenal'),('A0198','Rodrigo Ramirez Garcia',2026,'Baja','rodrigo.ramirez0198@upaep.mx',7,1,'Mensual'),('A0199','Fernanda Flores Sanchez',2021,'Egresado','fernanda.flores0199@upaep.mx',1,2,'Semanal'),('A0200','Ivanna Morales Morales',2022,'Baja','ivanna.morales0200@upaep.mx',1,3,'Quincenal'),('A0201','Ana Castillo Aguilar',2023,'Activo','ana.castillo0201@upaep.mx',2,4,'Mensual'),('A0202','Maria Rojas Navarro',2024,'Activo','maria.rojas0202@upaep.mx',2,5,'Semanal'),('A0203','Jose Mendez Benitez',2025,'Activo','jose.mendez0203@upaep.mx',3,6,'Quincenal'),('A0204','Luis Silva Garcia',2026,'Activo','luis.silva0204@upaep.mx',4,1,'Mensual'),('A0205','Carlos Navarro Sanchez',2021,'Baja','carlos.navarro0205@upaep.mx',5,1,'Semanal'),('A0206','Daniela Dominguez Morales',2022,'Egresado','daniela.dominguez0206@upaep.mx',6,2,'Quincenal'),('A0207','Sofia Luna Aguilar',2023,'Activo','sofia.luna0207@upaep.mx',7,3,'Mensual'),('A0208','Regina Cortes Navarro',2024,'Activo','regina.cortes0208@upaep.mx',1,4,'Semanal'),('A0209','Paola Velasco Benitez',2025,'Baja','paola.velasco0209@upaep.mx',1,5,'Quincenal'),('A0210','Jorge Garcia Garcia',2026,'Activo','jorge.garcia0210@upaep.mx',2,6,'Mensual'),('A0211','Emiliano Hernandez Sanchez',2021,'Egresado','emiliano.hernandez0211@upaep.mx',2,1,'Semanal'),('A0212','Isabel Perez Morales',2022,'Egresado','isabel.perez0212@upaep.mx',3,1,'Quincenal'),('A0213','Ines Ramirez Aguilar',2023,'Activo','ines.ramirez0213@upaep.mx',4,2,'Mensual'),('A0214','Valeria Flores Navarro',2024,'Activo','valeria.flores0214@upaep.mx',5,3,'Semanal'),('A0215','Camila Morales Benitez',2025,'Activo','camila.morales0215@upaep.mx',6,4,'Quincenal'),('A0216','Fernando Castillo Garcia',2026,'Activo','fernando.castillo0216@upaep.mx',7,5,'Mensual'),('A0217','Diego Rojas Sanchez',2021,'Egresado','diego.rojas0217@upaep.mx',1,6,'Semanal'),('A0218','Laura Mendez Morales',2022,'Egresado','laura.mendez0218@upaep.mx',1,1,'Quincenal'),('A0219','Andrea Silva Aguilar',2023,'Activo','andrea.silva0219@upaep.mx',2,1,'Mensual'),('A0220','Miguel Navarro Navarro',2024,'Baja','miguel.navarro0220@upaep.mx',2,2,'Semanal'),('A0221','Hector Dominguez Benitez',2025,'Activo','hector.dominguez0221@upaep.mx',3,3,'Quincenal'),('A0222','Claudia Luna Garcia',2026,'Activo','claudia.luna0222@upaep.mx',4,4,'Mensual'),('A0223','Mariana Cortes Sanchez',2021,'Egresado','mariana.cortes0223@upaep.mx',5,5,'Semanal'),('A0224','Andres Velasco Morales',2022,'Egresado','andres.velasco0224@upaep.mx',6,6,'Quincenal'),('A0225','Sara Garcia Aguilar',2023,'Activo','sara.garcia0225@upaep.mx',7,1,'Mensual'),('A0226','Rafael Hernandez Navarro',2024,'Activo','rafael.hernandez0226@upaep.mx',1,1,'Semanal'),('A0227','Lucia Perez Benitez',2025,'Activo','lucia.perez0227@upaep.mx',1,2,'Quincenal'),('A0228','Pablo Ramirez Garcia',2026,'Activo','pablo.ramirez0228@upaep.mx',2,3,'Mensual'),('A0229','Elena Flores Sanchez',2021,'Egresado','elena.flores0229@upaep.mx',2,4,'Semanal'),('A0230','Ricardo Morales Morales',2022,'Baja','ricardo.morales0230@upaep.mx',3,5,'Quincenal'),('A0231','Natalia Castillo Aguilar',2023,'Egresado','natalia.castillo0231@upaep.mx',4,6,'Mensual'),('A0232','Mauricio Rojas Navarro',2024,'Activo','mauricio.rojas0232@upaep.mx',5,1,'Semanal'),('A0233','Renata Mendez Benitez',2025,'Activo','renata.mendez0233@upaep.mx',6,1,'Quincenal'),('A0234','Adrian Silva Garcia',2026,'Activo','adrian.silva0234@upaep.mx',7,2,'Mensual'),('A0235','Patricia Navarro Sanchez',2021,'Baja','patricia.navarro0235@upaep.mx',1,3,'Semanal'),('A0236','David Dominguez Morales',2022,'Egresado','david.dominguez0236@upaep.mx',1,4,'Quincenal'),('A0237','Gabriela Luna Aguilar',2023,'Activo','gabriela.luna0237@upaep.mx',2,5,'Mensual'),('A0238','Rodrigo Cortes Navarro',2024,'Activo','rodrigo.cortes0238@upaep.mx',2,6,'Semanal'),('A0239','Fernanda Velasco Benitez',2025,'Activo','fernanda.velasco0239@upaep.mx',3,1,'Quincenal'),('A0240','Ivanna Garcia Garcia',2026,'Activo','ivanna.garcia0240@upaep.mx',4,1,'Mensual'),('A0241','Ana Hernandez Sanchez',2021,'Egresado','ana.hernandez0241@upaep.mx',5,2,'Semanal'),('A0242','Maria Perez Morales',2022,'Egresado','maria.perez0242@upaep.mx',6,3,'Quincenal'),('A0243','Jose Ramirez Aguilar',2023,'Activo','jose.ramirez0243@upaep.mx',7,4,'Mensual'),('A0244','Luis Flores Navarro',2024,'Activo','luis.flores0244@upaep.mx',1,5,'Semanal'),('A0245','Carlos Morales Benitez',2025,'Activo','carlos.morales0245@upaep.mx',1,6,'Quincenal'),('A0246','Daniela Castillo Garcia',2026,'Activo','daniela.castillo0246@upaep.mx',2,1,'Mensual'),('A0247','Sofia Rojas Sanchez',2021,'Egresado','sofia.rojas0247@upaep.mx',2,1,'Semanal'),('A0248','Regina Mendez Morales',2022,'Egresado','regina.mendez0248@upaep.mx',3,2,'Quincenal'),('A0249','Paola Silva Aguilar',2023,'Activo','paola.silva0249@upaep.mx',4,3,'Mensual'),('A0250','Jorge Navarro Navarro',2024,'Activo','jorge.navarro0250@upaep.mx',5,4,'Semanal'),('A0251','Emiliano Dominguez Benitez',2025,'Activo','emiliano.dominguez0251@upaep.mx',6,5,'Quincenal'),('A0252','Isabel Luna Garcia',2026,'Activo','isabel.luna0252@upaep.mx',7,6,'Mensual'),('A0253','Ines Cortes Sanchez',2021,'Egresado','ines.cortes0253@upaep.mx',1,1,'Semanal'),('A0254','Valeria Velasco Morales',2022,'Egresado','valeria.velasco0254@upaep.mx',1,1,'Quincenal'),('A0255','Camila Garcia Aguilar',2023,'Activo','camila.garcia0255@upaep.mx',2,2,'Mensual'),('A0256','Fernando Hernandez Navarro',2024,'Activo','fernando.hernandez0256@upaep.mx',2,3,'Semanal'),('A0257','Diego Perez Benitez',2025,'Activo','diego.perez0257@upaep.mx',3,4,'Quincenal'),('A0258','Laura Ramirez Garcia',2026,'Activo','laura.ramirez0258@upaep.mx',4,5,'Mensual'),('A0259','Andrea Flores Sanchez',2021,'Egresado','andrea.flores0259@upaep.mx',5,6,'Semanal'),('A0260','Miguel Morales Morales',2022,'Baja','miguel.morales0260@upaep.mx',6,1,'Quincenal'),('A0261','Hector Castillo Aguilar',2023,'Activo','hector.castillo0261@upaep.mx',7,1,'Mensual'),('A0262','Claudia Rojas Navarro',2024,'Activo','claudia.rojas0262@upaep.mx',1,2,'Semanal'),('A0263','Mariana Mendez Benitez',2025,'Activo','mariana.mendez0263@upaep.mx',1,3,'Quincenal'),('A0264','Andres Silva Garcia',2026,'Baja','andres.silva0264@upaep.mx',2,4,'Mensual'),('A0265','Sara Navarro Sanchez',2021,'Baja','sara.navarro0265@upaep.mx',2,5,'Semanal'),('A0266','Rafael Dominguez Morales',2022,'Egresado','rafael.dominguez0266@upaep.mx',3,6,'Quincenal'),('A0267','Lucia Luna Aguilar',2023,'Activo','lucia.luna0267@upaep.mx',4,1,'Mensual'),('A0268','Pablo Cortes Navarro',2024,'Activo','pablo.cortes0268@upaep.mx',5,1,'Semanal'),('A0269','Elena Velasco Benitez',2025,'Activo','elena.velasco0269@upaep.mx',6,2,'Quincenal'),('A0270','Ricardo Garcia Garcia',2026,'Activo','ricardo.garcia0270@upaep.mx',7,3,'Mensual'),('A0271','Natalia Hernandez Sanchez',2021,'Egresado','natalia.hernandez0271@upaep.mx',1,4,'Semanal'),('A0272','Mauricio Perez Morales',2022,'Egresado','mauricio.perez0272@upaep.mx',1,5,'Quincenal'),('A0273','Renata Ramirez Aguilar',2023,'Egresado','renata.ramirez0273@upaep.mx',2,6,'Mensual'),('A0274','Adrian Flores Navarro',2024,'Activo','adrian.flores0274@upaep.mx',2,1,'Semanal'),('A0275','Patricia Morales Benitez',2025,'Baja','patricia.morales0275@upaep.mx',3,1,'Quincenal'),('A0276','David Castillo Garcia',2026,'Activo','david.castillo0276@upaep.mx',4,2,'Mensual'),('A0277','Gabriela Rojas Sanchez',2021,'Egresado','gabriela.rojas0277@upaep.mx',5,3,'Semanal'),('A0278','Rodrigo Mendez Morales',2022,'Egresado','rodrigo.mendez0278@upaep.mx',6,4,'Quincenal'),('A0279','Fernanda Silva Aguilar',2023,'Activo','fernanda.silva0279@upaep.mx',7,5,'Mensual'),('A0280','Ivanna Navarro Navarro',2024,'Activo','ivanna.navarro0280@upaep.mx',1,6,'Semanal'),('A0281','Ana Dominguez Benitez',2025,'Activo','ana.dominguez0281@upaep.mx',1,1,'Quincenal'),('A0282','Maria Luna Garcia',2026,'Activo','maria.luna0282@upaep.mx',2,1,'Mensual'),('A0283','Jose Cortes Sanchez',2021,'Egresado','jose.cortes0283@upaep.mx',2,2,'Semanal'),('A0284','Luis Velasco Morales',2022,'Egresado','luis.velasco0284@upaep.mx',3,3,'Quincenal'),('A0285','Carlos Garcia Aguilar',2023,'Activo','carlos.garcia0285@upaep.mx',4,4,'Mensual'),('A0286','Daniela Hernandez Navarro',2024,'Baja','daniela.hernandez0286@upaep.mx',5,5,'Semanal'),('A0287','Sofia Perez Benitez',2025,'Activo','sofia.perez0287@upaep.mx',6,6,'Quincenal'),('A0288','Regina Ramirez Garcia',2026,'Activo','regina.ramirez0288@upaep.mx',7,1,'Mensual'),('A0289','Paola Flores Sanchez',2021,'Egresado','paola.flores0289@upaep.mx',1,1,'Semanal'),('A0290','Jorge Morales Morales',2022,'Baja','jorge.morales0290@upaep.mx',1,2,'Quincenal'),('A0291','Emiliano Castillo Aguilar',2023,'Activo','emiliano.castillo0291@upaep.mx',2,3,'Mensual'),('A0292','Isabel Rojas Navarro',2024,'Activo','isabel.rojas0292@upaep.mx',2,4,'Semanal'),('A0293','Ines Mendez Benitez',2025,'Activo','ines.mendez0293@upaep.mx',3,5,'Quincenal'),('A0294','Valeria Silva Garcia',2026,'Activo','valeria.silva0294@upaep.mx',4,6,'Mensual'),('A0295','Camila Navarro Sanchez',2021,'Baja','camila.navarro0295@upaep.mx',5,1,'Semanal'),('A0296','Fernando Dominguez Morales',2022,'Egresado','fernando.dominguez0296@upaep.mx',6,1,'Quincenal'),('A0297','Diego Luna Aguilar',2023,'Activo','diego.luna0297@upaep.mx',7,2,'Mensual'),('A0298','Laura Cortes Navarro',2024,'Activo','laura.cortes0298@upaep.mx',1,3,'Semanal'),('A0299','Andrea Velasco Benitez',2025,'Activo','andrea.velasco0299@upaep.mx',1,4,'Quincenal'),('A0300','Miguel Garcia Garcia',2026,'Activo','miguel.garcia0300@upaep.mx',2,5,'Mensual'),('A0301','Hector Hernandez Sanchez',2021,'Egresado','hector.hernandez0301@upaep.mx',2,6,'Semanal'),('A0302','Claudia Perez Morales',2022,'Egresado','claudia.perez0302@upaep.mx',3,1,'Quincenal'),('A0303','Mariana Ramirez Aguilar',2023,'Activo','mariana.ramirez0303@upaep.mx',4,1,'Mensual'),('A0304','Andres Flores Navarro',2024,'Activo','andres.flores0304@upaep.mx',5,2,'Semanal'),('A0305','Sara Morales Benitez',2025,'Activo','sara.morales0305@upaep.mx',6,3,'Quincenal'),('A0306','Rafael Castillo Garcia',2026,'Activo','rafael.castillo0306@upaep.mx',7,4,'Mensual'),('A0307','Lucia Rojas Sanchez',2021,'Egresado','lucia.rojas0307@upaep.mx',1,5,'Semanal'),('A0308','Pablo Mendez Morales',2022,'Egresado','pablo.mendez0308@upaep.mx',1,6,'Quincenal'),('A0309','Elena Silva Aguilar',2023,'Activo','elena.silva0309@upaep.mx',2,1,'Mensual'),('A0310','Ricardo Navarro Navarro',2024,'Activo','ricardo.navarro0310@upaep.mx',2,1,'Semanal'),('A0311','Natalia Dominguez Benitez',2025,'Activo','natalia.dominguez0311@upaep.mx',3,2,'Quincenal'),('A0312','Mauricio Luna Garcia',2026,'Activo','mauricio.luna0312@upaep.mx',4,3,'Mensual'),('A0313','Renata Cortes Sanchez',2021,'Egresado','renata.cortes0313@upaep.mx',5,4,'Semanal'),('A0314','Adrian Velasco Morales',2022,'Egresado','adrian.velasco0314@upaep.mx',6,5,'Quincenal'),('A0315','Patricia Garcia Aguilar',2023,'Egresado','patricia.garcia0315@upaep.mx',7,6,'Mensual'),('A0316','David Hernandez Navarro',2024,'Activo','david.hernandez0316@upaep.mx',1,1,'Semanal'),('A0317','Gabriela Perez Benitez',2025,'Activo','gabriela.perez0317@upaep.mx',1,1,'Quincenal'),('A0318','Rodrigo Ramirez Garcia',2026,'Activo','rodrigo.ramirez0318@upaep.mx',2,2,'Mensual'),('A0319','Fernanda Flores Sanchez',2021,'Egresado','fernanda.flores0319@upaep.mx',2,3,'Semanal'),('A0320','Ivanna Morales Morales',2022,'Baja','ivanna.morales0320@upaep.mx',3,4,'Quincenal'),('A0321','Ana Castillo Aguilar',2023,'Activo','ana.castillo0321@upaep.mx',4,5,'Mensual'),('A0322','Maria Rojas Navarro',2024,'Activo','maria.rojas0322@upaep.mx',5,6,'Semanal'),('A0323','Jose Mendez Benitez',2025,'Activo','jose.mendez0323@upaep.mx',6,1,'Quincenal'),('A0324','Luis Silva Garcia',2026,'Activo','luis.silva0324@upaep.mx',7,1,'Mensual'),('A0325','Carlos Navarro Sanchez',2021,'Baja','carlos.navarro0325@upaep.mx',1,2,'Semanal'),('A0326','Daniela Dominguez Morales',2022,'Egresado','daniela.dominguez0326@upaep.mx',1,3,'Quincenal'),('A0327','Sofia Luna Aguilar',2023,'Activo','sofia.luna0327@upaep.mx',2,4,'Mensual'),('A0328','Regina Cortes Navarro',2024,'Activo','regina.cortes0328@upaep.mx',2,5,'Semanal'),('A0329','Paola Velasco Benitez',2025,'Activo','paola.velasco0329@upaep.mx',3,6,'Quincenal'),('A0330','Jorge Garcia Garcia',2026,'Baja','jorge.garcia0330@upaep.mx',4,1,'Mensual'),('A0331','Emiliano Hernandez Sanchez',2021,'Egresado','emiliano.hernandez0331@upaep.mx',5,1,'Semanal'),('A0332','Isabel Perez Morales',2022,'Egresado','isabel.perez0332@upaep.mx',6,2,'Quincenal'),('A0333','Ines Ramirez Aguilar',2023,'Activo','ines.ramirez0333@upaep.mx',7,3,'Mensual'),('A0334','Valeria Flores Navarro',2024,'Activo','valeria.flores0334@upaep.mx',1,4,'Semanal'),('A0335','Camila Morales Benitez',2025,'Activo','camila.morales0335@upaep.mx',1,5,'Quincenal'),('A0336','Fernando Castillo Garcia',2026,'Activo','fernando.castillo0336@upaep.mx',2,6,'Mensual'),('A0337','Diego Rojas Sanchez',2021,'Egresado','diego.rojas0337@upaep.mx',2,1,'Semanal'),('A0338','Laura Mendez Morales',2022,'Egresado','laura.mendez0338@upaep.mx',3,1,'Quincenal'),('A0339','Andrea Silva Aguilar',2023,'Activo','andrea.silva0339@upaep.mx',4,2,'Mensual'),('A0340','Miguel Navarro Navarro',2024,'Activo','miguel.navarro0340@upaep.mx',5,3,'Semanal'),('A0341','Hector Dominguez Benitez',2025,'Baja','hector.dominguez0341@upaep.mx',6,4,'Quincenal'),('A0342','Claudia Luna Garcia',2026,'Activo','claudia.luna0342@upaep.mx',7,5,'Mensual'),('A0343','Mariana Cortes Sanchez',2021,'Egresado','mariana.cortes0343@upaep.mx',1,6,'Semanal'),('A0344','Andres Velasco Morales',2022,'Egresado','andres.velasco0344@upaep.mx',1,1,'Quincenal'),('A0345','Sara Garcia Aguilar',2023,'Activo','sara.garcia0345@upaep.mx',2,1,'Mensual'),('A0346','Rafael Hernandez Navarro',2024,'Activo','rafael.hernandez0346@upaep.mx',2,2,'Semanal'),('A0347','Lucia Perez Benitez',2025,'Activo','lucia.perez0347@upaep.mx',3,3,'Quincenal'),('A0348','Pablo Ramirez Garcia',2026,'Activo','pablo.ramirez0348@upaep.mx',4,4,'Mensual'),('A0349','Elena Flores Sanchez',2021,'Egresado','elena.flores0349@upaep.mx',5,5,'Semanal'),('A0350','Ricardo Morales Morales',2022,'Baja','ricardo.morales0350@upaep.mx',6,6,'Quincenal'),('A0351','Natalia Castillo Aguilar',2023,'Activo','natalia.castillo0351@upaep.mx',7,1,'Mensual'),('A0352','Mauricio Rojas Navarro',2024,'Baja','mauricio.rojas0352@upaep.mx',1,1,'Semanal'),('A0353','Renata Mendez Benitez',2025,'Activo','renata.mendez0353@upaep.mx',1,2,'Quincenal'),('A0354','Adrian Silva Garcia',2026,'Activo','adrian.silva0354@upaep.mx',2,3,'Mensual'),('A0355','Patricia Navarro Sanchez',2021,'Baja','patricia.navarro0355@upaep.mx',2,4,'Semanal'),('A0356','David Dominguez Morales',2022,'Egresado','david.dominguez0356@upaep.mx',3,5,'Quincenal'),('A0357','Gabriela Luna Aguilar',2023,'Egresado','gabriela.luna0357@upaep.mx',4,6,'Mensual'),('A0358','Rodrigo Cortes Navarro',2024,'Activo','rodrigo.cortes0358@upaep.mx',5,1,'Semanal'),('A0359','Fernanda Velasco Benitez',2025,'Activo','fernanda.velasco0359@upaep.mx',6,1,'Quincenal'),('A0360','Ivanna Garcia Garcia',2026,'Activo','ivanna.garcia0360@upaep.mx',7,2,'Mensual'),('A0361','Ana Hernandez Sanchez',2021,'Egresado','ana.hernandez0361@upaep.mx',1,3,'Semanal'),('A0362','Maria Perez Morales',2022,'Egresado','maria.perez0362@upaep.mx',1,4,'Quincenal'),('A0363','Jose Ramirez Aguilar',2023,'Activo','jose.ramirez0363@upaep.mx',2,5,'Mensual'),('A0364','Luis Flores Navarro',2024,'Activo','luis.flores0364@upaep.mx',2,6,'Semanal'),('A0365','Carlos Morales Benitez',2025,'Activo','carlos.morales0365@upaep.mx',3,1,'Quincenal'),('A0366','Daniela Castillo Garcia',2026,'Activo','daniela.castillo0366@upaep.mx',4,1,'Mensual'),('A0367','Sofia Rojas Sanchez',2021,'Egresado','sofia.rojas0367@upaep.mx',5,2,'Semanal'),('A0368','Regina Mendez Morales',2022,'Egresado','regina.mendez0368@upaep.mx',6,3,'Quincenal'),('A0369','Paola Silva Aguilar',2023,'Activo','paola.silva0369@upaep.mx',7,4,'Mensual'),('A0370','Jorge Navarro Navarro',2024,'Activo','jorge.navarro0370@upaep.mx',1,5,'Semanal'),('A0371','Emiliano Dominguez Benitez',2025,'Activo','emiliano.dominguez0371@upaep.mx',1,6,'Quincenal'),('A0372','Isabel Luna Garcia',2026,'Activo','isabel.luna0372@upaep.mx',2,1,'Mensual'),('A0373','Ines Cortes Sanchez',2021,'Egresado','ines.cortes0373@upaep.mx',2,1,'Semanal'),('A0374','Valeria Velasco Morales',2022,'Egresado','valeria.velasco0374@upaep.mx',3,2,'Quincenal');
/*!40000 ALTER TABLE `estudiante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `estudiante_resumen`
--

DROP TABLE IF EXISTS `estudiante_resumen`;
/*!50001 DROP VIEW IF EXISTS `estudiante_resumen`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `estudiante_resumen` AS SELECT 
 1 AS `matricula`,
 1 AS `estudiante`,
 1 AS `estatus`,
 1 AS `programa`,
 1 AS `nombre_proyecto`,
 1 AS `proyectos`,
 1 AS `mentorias`,
 1 AS `estado`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `implementar`
--

DROP TABLE IF EXISTS `implementar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `implementar` (
  `id_proyecto` int NOT NULL,
  `id_comunidad` int NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `cantidad_beneficiarios` int NOT NULL,
  PRIMARY KEY (`id_proyecto`,`id_comunidad`),
  KEY `fk_comunidad` (`id_comunidad`),
  CONSTRAINT `fk_comunidad` FOREIGN KEY (`id_comunidad`) REFERENCES `comunidad` (`id_comunidad`),
  CONSTRAINT `fk_proyecto` FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `implementar`
--

LOCK TABLES `implementar` WRITE;
/*!40000 ALTER TABLE `implementar` DISABLE KEYS */;
INSERT INTO `implementar` VALUES (2,9,'2025-02-01',NULL,67),(3,39,'2025-10-01','2026-02-13',123),(4,10,'2025-06-01','2025-09-04',59),(5,40,'2025-02-01','2025-09-04',115),(6,11,'2025-10-01','2026-03-25',51),(7,19,'2024-12-01',NULL,98),(7,41,'2025-06-01','2025-10-14',107),(8,12,'2025-02-01','2025-05-07',43),(8,49,'2024-08-01','2025-03-09',34),(9,20,'2024-04-01','2024-09-28',90),(10,50,'2024-12-01','2025-04-20',26),(11,21,'2024-08-01',NULL,82),(12,51,'2024-04-01','2024-11-07',138),(13,22,'2024-12-01','2025-05-30',74),(14,30,'2025-02-01','2025-05-17',121),(14,52,'2024-08-01','2024-12-19',130),(15,23,'2024-04-01','2024-07-10',66),(16,31,'2025-06-01',NULL,113),(17,2,'2025-02-01','2025-06-26',49),(18,32,'2025-10-01','2026-01-14',105),(19,3,'2025-06-01','2026-01-12',41),(19,56,'2024-07-15','2025-04-02',142),(20,33,'2025-02-01','2025-08-05',97),(20,59,'2025-08-15','2026-05-12',25),(21,3,'2023-09-15',NULL,38),(21,4,'2025-10-01','2026-02-23',33),(21,41,'2024-04-01','2024-07-20',24),(22,6,'2024-10-15','2025-07-30',51),(22,12,'2024-12-01','2025-07-19',80),(22,34,'2025-06-01','2025-09-14',89),(23,9,'2025-11-15',NULL,64),(23,42,'2024-08-01','2025-02-07',136),(24,12,'2023-12-15','2024-10-16',77),(24,13,'2024-04-01','2024-08-29',72),(25,15,'2024-01-15',NULL,90),(25,43,'2024-12-01','2025-03-21',128),(26,14,'2024-08-01','2025-03-19',64),(26,18,'2025-02-15','2026-01-05',103),(27,21,'2023-03-15','2023-10-14',116),(27,44,'2024-04-01','2024-10-08',120),(28,15,'2024-12-01',NULL,56),(28,24,'2024-04-15','2024-11-23',129),(28,52,'2025-06-01','2025-09-24',47),(29,23,'2025-02-01','2025-09-24',103),(29,27,'2025-05-15',NULL,142),(29,45,'2024-08-01','2024-11-19',112),(30,30,'2023-06-15','2024-02-10',25),(30,53,'2025-10-01','2026-04-14',39),(31,24,'2025-06-01','2025-11-03',95),(32,54,'2025-02-01','2025-05-27',31),(33,25,'2025-10-01','2026-05-24',87),(34,55,'2025-06-01',NULL,23),(35,4,'2024-08-01','2024-11-29',70),(35,26,'2025-02-01','2025-07-06',79),(36,34,'2024-04-01','2024-11-27',126),(36,56,'2025-10-01','2026-01-24',135),(37,5,'2024-12-01','2025-06-19',62),(38,35,'2024-08-01',NULL,118),(39,6,'2024-04-01','2024-07-30',54),(40,36,'2024-12-01','2025-07-29',110),(41,7,'2024-08-01','2025-02-17',46),(42,15,'2025-10-01','2026-02-03',93),(42,37,'2024-04-01','2024-09-08',102),(43,8,'2024-12-01','2025-03-31',38),(43,10,'2024-07-15',NULL,64),(43,45,'2025-06-01','2026-02-01',29),(44,13,'2025-08-15','2026-04-18',77),(44,16,'2025-02-01','2025-08-25',85),(45,16,'2023-09-15',NULL,90),(45,46,'2025-10-01','2026-03-15',21),(46,17,'2025-06-01','2025-10-04',77),(46,19,'2024-10-15','2025-07-06',103),(47,22,'2025-11-15',NULL,116),(47,47,'2025-02-01','2025-10-04',133),(48,18,'2025-10-01','2026-04-24',69),(48,25,'2023-12-15','2024-09-22',129),(49,28,'2024-01-15','2024-11-01',142),(49,48,'2025-06-01',NULL,125),(50,19,'2025-02-01','2025-06-06',61),(50,31,'2025-02-15','2025-12-12',25),(50,56,'2024-08-01','2024-10-30',52),(51,27,'2024-04-01','2024-10-28',108),(51,34,'2023-03-15',NULL,38),(52,37,'2024-04-15','2025-02-27',51),(52,57,'2024-12-01','2025-05-20',44),(53,28,'2024-08-01','2024-12-09',100),(53,40,'2025-05-15',NULL,64),(54,43,'2023-06-15','2024-01-17',77),(54,58,'2024-04-01','2024-06-30',36),(55,29,'2024-12-01','2025-06-29',92),(55,46,'2024-07-15',NULL,90),(56,49,'2025-08-15','2026-04-06',103),(56,59,'2024-08-01','2025-01-18',28),(57,8,'2025-10-01',NULL,75),(57,30,'2024-04-01','2024-08-09',84),(57,52,'2023-09-15','2024-05-15',116);
/*!40000 ALTER TABLE `implementar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mentor`
--

DROP TABLE IF EXISTS `mentor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mentor` (
  `id_mentor` int NOT NULL AUTO_INCREMENT,
  `nombre_mentor` varchar(50) NOT NULL,
  `id_tema` int NOT NULL,
  PRIMARY KEY (`id_mentor`),
  KEY `fk_mentor_tema` (`id_tema`),
  CONSTRAINT `fk_mentor_tema` FOREIGN KEY (`id_tema`) REFERENCES `tema_mentoria` (`id_tema`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mentor`
--

LOCK TABLES `mentor` WRITE;
/*!40000 ALTER TABLE `mentor` DISABLE KEYS */;
INSERT INTO `mentor` VALUES (1,'Laura Mendez Salazar',1),(2,'Andres Castillo Rivera',2),(3,'Mariana Ortega Velasco',3),(4,'Jorge Herrera Dominguez',4),(5,'Sofia Ramirez Aguilar',5),(6,'Diego Fernandez Luna',6),(7,'Claudia Torres Benitez',7),(8,'Hector Morales Pineda',8);
/*!40000 ALTER TABLE `mentor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mentoria`
--

DROP TABLE IF EXISTS `mentoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mentoria` (
  `fecha_mentoria` date NOT NULL,
  `matricula` varchar(10) NOT NULL,
  `id_proyecto` int NOT NULL,
  `id_mentor` int NOT NULL,
  PRIMARY KEY (`fecha_mentoria`,`matricula`,`id_mentor`),
  KEY `fk_mentoria_estudiante` (`matricula`) /*!80000 INVISIBLE */,
  KEY `fk_mentoria_proyecto` (`id_proyecto`),
  KEY `fk_mentoria_mentor_idx` (`id_mentor`),
  CONSTRAINT `fk_mentoria_estudiante` FOREIGN KEY (`matricula`) REFERENCES `estudiante` (`matricula`) ON UPDATE CASCADE,
  CONSTRAINT `fk_mentoria_mentor` FOREIGN KEY (`id_mentor`) REFERENCES `mentor` (`id_mentor`),
  CONSTRAINT `fk_mentoria_proyecto` FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mentoria`
--

LOCK TABLES `mentoria` WRITE;
/*!40000 ALTER TABLE `mentoria` DISABLE KEYS */;
INSERT INTO `mentoria` VALUES ('2025-01-10','A0002',2,6),('2025-01-16','A0251',2,3),('2025-01-22','A0032',2,4),('2025-02-02','A0122',2,6),('2025-02-03','A0062',2,6),('2025-02-05','A0251',2,8),('2025-02-07','A0062',2,1),('2025-02-08','A0032',2,7),('2025-02-11','A0251',2,3),('2025-02-15','A0182',2,1),('2026-05-07','A0002',2,2),('2026-05-07','A0122',2,2),('2026-05-19','A0062',2,2),('2026-05-19','A0182',2,2),('2026-08-04','A0251',2,2),('2026-11-01','A0092',2,2),('2026-11-01','A0212',2,2),('2026-11-01','A0308',2,2),('2026-11-13','A0032',2,2),('2026-11-13','A0152',2,2),('2024-02-06','A0093',3,3),('2024-02-06','A0213',3,3),('2024-02-18','A0033',3,3),('2024-02-18','A0153',3,3),('2024-08-12','A0003',3,3),('2024-08-12','A0123',3,3),('2024-08-24','A0063',3,3),('2024-08-24','A0183',3,3),('2025-01-09','A0153',3,8),('2025-01-20','A0093',3,7),('2025-01-28','A0033',3,3),('2025-01-28','A0093',3,7),('2025-01-30','A0274',3,8),('2025-02-12','A0274',3,3),('2025-02-15','A0063',3,4),('2025-05-23','A0274',3,3),('2024-02-18','A0297',4,4),('2025-01-06','A0064',4,5),('2025-01-09','A0214',4,7),('2025-01-11','A0214',4,1),('2025-01-12','A0184',4,7),('2025-01-13','A0094',4,2),('2025-01-14','A0297',4,4),('2025-01-19','A0004',4,5),('2025-01-27','A0154',4,7),('2025-02-01','A0297',4,2),('2025-02-07','A0034',4,2),('2025-02-14','A0184',4,5),('2025-02-18','A0124',4,1),('2025-05-11','A0094',4,4),('2025-05-11','A0214',4,4),('2025-05-23','A0034',4,4),('2025-05-23','A0154',4,4),('2025-11-05','A0064',4,4),('2025-11-05','A0184',4,4),('2025-11-17','A0004',4,4),('2025-11-17','A0124',4,4),('2025-01-04','A0155',5,7),('2025-01-18','A0065',5,1),('2025-01-24','A0185',5,5),('2025-02-02','A0095',5,7),('2025-02-07','A0005',5,5),('2026-02-10','A0065',5,5),('2026-02-10','A0185',5,5),('2026-02-22','A0005',5,5),('2026-02-22','A0125',5,5),('2026-08-04','A0035',5,5),('2026-08-04','A0155',5,5),('2026-08-16','A0095',5,5),('2026-08-16','A0215',5,5),('2026-08-16','A0263',5,5),('2024-05-03','A0006',6,6),('2024-05-03','A0126',6,6),('2024-05-15','A0066',6,6),('2024-05-15','A0186',6,6),('2024-11-09','A0036',6,6),('2024-11-09','A0156',6,6),('2024-11-21','A0096',6,6),('2024-11-21','A0216',6,6),('2025-01-03','A0126',6,8),('2025-01-18','A0036',6,2),('2025-02-05','A0286',6,3),('2025-02-10','A0126',6,3),('2025-02-17','A0096',6,4),('2025-05-11','A0286',6,6),('2024-02-06','A0309',7,7),('2024-11-09','A0252',7,7),('2025-01-08','A0252',7,7),('2025-01-10','A0007',7,7),('2025-01-10','A0187',7,3),('2025-01-12','A0252',7,1),('2025-01-16','A0127',7,3),('2025-01-16','A0127',7,4),('2025-01-16','A0127',7,5),('2025-01-30','A0217',7,8),('2025-02-01','A0007',7,4),('2025-02-02','A0097',7,7),('2025-02-02','A0187',7,5),('2025-02-02','A0217',7,7),('2025-02-07','A0309',7,6),('2025-02-14','A0037',7,7),('2025-02-14','A0157',7,7),('2025-08-08','A0007',7,7),('2025-08-08','A0127',7,7),('2025-08-20','A0067',7,7),('2025-08-20','A0187',7,7),('2025-01-03','A0038',8,8),('2025-01-05','A0128',8,7),('2025-01-10','A0158',8,4),('2025-01-14','A0038',8,5),('2025-01-20','A0158',8,1),('2025-01-25','A0275',8,3),('2025-02-04','A0218',8,3),('2025-02-10','A0188',8,6),('2025-02-14','A0068',8,3),('2026-05-07','A0098',8,8),('2026-05-07','A0218',8,8),('2026-05-19','A0038',8,8),('2026-05-19','A0158',8,8),('2026-08-04','A0275',8,8),('2026-11-01','A0068',8,8),('2026-11-01','A0188',8,8),('2026-11-13','A0008',8,8),('2026-11-13','A0128',8,8),('2024-02-06','A0069',9,1),('2024-02-06','A0189',9,1),('2024-02-18','A0009',9,1),('2024-02-18','A0129',9,1),('2024-03-10','A0009',9,1),('2024-03-10','A0009',9,2),('2024-04-10','A0009',9,2),('2024-04-10','A0009',9,3),('2024-05-10','A0009',9,3),('2024-05-10','A0009',9,4),('2024-08-12','A0099',9,1),('2024-08-12','A0219',9,1),('2024-08-24','A0039',9,1),('2024-08-24','A0159',9,1),('2025-01-03','A0159',9,1),('2025-01-07','A0099',9,5),('2025-01-14','A0129',9,3),('2025-01-19','A0219',9,8),('2025-01-29','A0069',9,5),('2025-02-02','A0241',9,1),('2025-02-08','A0159',9,6),('2025-02-11','A0039',9,5),('2025-02-12','A0189',9,8),('2025-05-23','A0298',9,1),('2024-11-21','A0264',10,2),('2025-01-07','A0040',10,7),('2025-01-07','A0160',10,7),('2025-01-18','A0220',10,5),('2025-01-24','A0040',10,6),('2025-01-25','A0264',10,3),('2025-01-29','A0190',10,7),('2025-02-09','A0100',10,8),('2025-02-14','A0160',10,1),('2025-02-16','A0264',10,6),('2025-02-18','A0220',10,7),('2025-05-11','A0070',10,2),('2025-05-11','A0190',10,2),('2025-05-23','A0010',10,2),('2025-05-23','A0130',10,2),('2025-06-10','A0010',10,3),('2025-07-10','A0010',10,4),('2025-08-10','A0010',10,5),('2025-11-05','A0040',10,2),('2025-11-05','A0160',10,2),('2025-11-17','A0100',10,2),('2025-11-17','A0220',10,2),('2025-02-02','A0131',11,6),('2025-02-03','A0221',11,3),('2025-02-05','A0011',11,2),('2025-02-13','A0287',11,1),('2026-02-10','A0041',11,3),('2026-02-10','A0161',11,3),('2026-02-22','A0101',11,3),('2026-02-22','A0221',11,3),('2026-08-04','A0011',11,3),('2026-08-04','A0131',11,3),('2026-08-16','A0071',11,3),('2026-08-16','A0191',11,3),('2026-08-16','A0287',11,3),('2024-05-03','A0102',12,4),('2024-05-03','A0222',12,4),('2024-05-15','A0042',12,4),('2024-05-15','A0162',12,4),('2024-11-09','A0012',12,4),('2024-11-09','A0132',12,4),('2024-11-21','A0072',12,4),('2024-11-21','A0192',12,4),('2024-12-10','A0012',12,5),('2025-01-05','A0102',12,6),('2025-01-09','A0132',12,6),('2025-01-10','A0012',12,6),('2025-01-16','A0253',12,2),('2025-01-31','A0132',12,5),('2025-02-03','A0192',12,5),('2025-02-03','A0253',12,5),('2025-02-10','A0012',12,7),('2025-02-14','A0253',12,4),('2025-05-11','A0310',12,4),('2024-11-09','A0276',13,5),('2025-01-07','A0013',13,8),('2025-01-07','A0163',13,1),('2025-01-09','A0043',13,5),('2025-01-11','A0103',13,5),('2025-01-17','A0013',13,8),('2025-01-31','A0013',13,7),('2025-02-02','A0073',13,5),('2025-02-02','A0193',13,5),('2025-02-10','A0133',13,5),('2025-02-14','A0013',13,5),('2025-02-14','A0133',13,5),('2025-02-18','A0163',13,7),('2025-08-08','A0103',13,5),('2025-08-08','A0223',13,5),('2025-08-20','A0043',13,5),('2025-08-20','A0163',13,5),('2025-01-02','A0134',14,1),('2025-01-06','A0164',14,6),('2025-01-11','A0104',14,1),('2025-01-20','A0299',14,7),('2025-02-05','A0299',14,7),('2025-02-09','A0224',14,4),('2025-02-09','A0299',14,6),('2025-02-10','A0044',14,5),('2025-02-15','A0044',14,3),('2025-02-15','A0104',14,7),('2026-05-07','A0074',14,6),('2026-05-07','A0194',14,6),('2026-05-07','A0242',14,6),('2026-05-19','A0014',14,6),('2026-05-19','A0134',14,6),('2026-08-04','A0299',14,6),('2026-11-01','A0044',14,6),('2026-11-01','A0164',14,6),('2026-11-13','A0104',14,6),('2026-11-13','A0224',14,6),('2024-02-06','A0045',15,7),('2024-02-06','A0165',15,7),('2024-02-18','A0105',15,7),('2024-02-18','A0225',15,7),('2024-08-12','A0075',15,7),('2024-08-12','A0195',15,7),('2024-08-24','A0015',15,7),('2024-08-24','A0135',15,7),('2024-09-10','A0015',15,1),('2024-10-10','A0015',15,2),('2024-11-10','A0015',15,3),('2025-01-06','A0225',15,2),('2025-01-12','A0265',15,8),('2025-01-18','A0045',15,1),('2025-01-22','A0195',15,5),('2025-01-22','A0265',15,1),('2025-01-31','A0135',15,4),('2025-02-02','A0265',15,7),('2025-02-11','A0015',15,6),('2025-02-12','A0015',15,7),('2025-02-17','A0165',15,5),('2025-02-19','A0015',15,1),('2024-11-21','A0288',16,8),('2025-01-05','A0196',16,1),('2025-01-09','A0226',16,6),('2025-01-13','A0106',16,8),('2025-01-14','A0196',16,5),('2025-01-21','A0016',16,6),('2025-01-23','A0166',16,4),('2025-01-30','A0136',16,7),('2025-01-30','A0196',16,5),('2025-01-31','A0076',16,4),('2025-02-10','A0076',16,8),('2025-02-16','A0166',16,3),('2025-05-11','A0046',16,8),('2025-05-11','A0166',16,8),('2025-05-23','A0106',16,8),('2025-05-23','A0226',16,8),('2025-11-05','A0016',16,8),('2025-11-05','A0136',16,8),('2025-11-17','A0076',16,8),('2025-11-17','A0196',16,8),('2025-01-09','A0254',17,5),('2025-01-10','A0137',17,7),('2025-01-14','A0017',17,8),('2025-01-16','A0107',17,2),('2025-01-20','A0017',17,7),('2025-01-22','A0107',17,1),('2025-02-10','A0047',17,6),('2025-02-12','A0017',17,5),('2025-02-19','A0107',17,8),('2026-02-10','A0017',17,1),('2026-02-10','A0137',17,1),('2026-02-22','A0077',17,1),('2026-02-22','A0197',17,1),('2026-05-19','A0254',17,1),('2026-08-04','A0107',17,1),('2026-08-04','A0227',17,1),('2026-08-16','A0047',17,1),('2026-08-16','A0167',17,1),('2026-08-16','A0311',17,1),('2024-05-03','A0078',18,2),('2024-05-03','A0198',18,2),('2024-05-15','A0018',18,2),('2024-05-15','A0138',18,2),('2024-11-09','A0108',18,2),('2024-11-09','A0228',18,2),('2024-11-21','A0048',18,2),('2024-11-21','A0168',18,2),('2025-01-04','A0078',18,8),('2025-01-26','A0228',18,3),('2025-01-29','A0138',18,1),('2025-02-02','A0138',18,2),('2025-02-07','A0108',18,4),('2025-02-12','A0168',18,5),('2025-02-14','A0277',18,2),('2025-02-15','A0078',18,7),('2025-02-20','A0018',18,5),('2024-08-12','A0243',19,3),('2024-11-09','A0300',19,3),('2025-02-02','A0243',19,5),('2025-01-04','A0266',20,3),('2025-01-19','A0266',20,3),('2026-05-07','A0266',20,4),('2025-01-16','A0289',21,2),('2025-02-02','A0289',21,5),('2024-08-24','A0255',22,6),('2024-11-21','A0312',22,6),('2025-01-08','A0255',22,6),('2025-01-17','A0255',22,7),('2025-02-07','A0255',22,1),('2025-02-07','A0278',23,1),('2025-02-19','A0278',23,2),('2026-05-19','A0278',23,7),('2025-01-04','A0244',24,6),('2025-02-14','A0301',24,8),('2025-11-17','A0244',24,8),('2024-08-12','A0267',25,1),('2025-02-08','A0267',25,5),('2025-02-18','A0267',25,1),('2026-05-07','A0290',26,2),('2025-01-13','A0313',27,2),('2025-01-29','A0256',27,6),('2025-02-02','A0313',27,3),('2025-02-08','A0313',27,2),('2025-11-05','A0256',27,3),('2024-08-24','A0279',28,4),('2025-01-02','A0245',29,1),('2025-01-04','A0302',29,7),('2025-01-08','A0245',29,6),('2025-02-05','A0245',29,7),('2026-02-22','A0245',29,5),('2026-05-19','A0302',29,5),('2025-11-17','A0268',30,6),('2024-08-12','A0291',31,7),('2025-01-03','A0049',31,6),('2025-01-08','A0079',31,6),('2025-01-10','A0291',31,3),('2025-01-20','A0229',31,6),('2025-01-30','A0019',31,8),('2025-01-30','A0199',31,1),('2025-01-31','A0199',31,4),('2025-02-01','A0079',31,7),('2025-02-02','A0049',31,7),('2025-02-02','A0169',31,7),('2025-02-04','A0019',31,8),('2025-02-09','A0049',31,5),('2025-02-13','A0229',31,8),('2025-02-14','A0109',31,7),('2025-02-14','A0229',31,7),('2025-02-19','A0049',31,4),('2025-08-08','A0079',31,7),('2025-08-08','A0199',31,7),('2025-08-20','A0019',31,7),('2025-08-20','A0139',31,7),('2025-01-13','A0140',32,7),('2025-01-26','A0020',32,8),('2025-02-02','A0050',32,2),('2025-02-05','A0170',32,1),('2025-02-08','A0020',32,6),('2025-02-11','A0257',32,6),('2025-02-11','A0314',32,7),('2025-02-16','A0140',32,7),('2025-02-19','A0230',32,3),('2026-02-10','A0257',32,8),('2026-05-07','A0050',32,8),('2026-05-07','A0170',32,8),('2026-05-07','A0314',32,8),('2026-05-19','A0110',32,8),('2026-05-19','A0230',32,8),('2026-11-01','A0020',32,8),('2026-11-01','A0140',32,8),('2026-11-13','A0080',32,8),('2026-11-13','A0200',32,8),('2024-02-06','A0021',33,1),('2024-02-06','A0141',33,1),('2024-02-18','A0081',33,1),('2024-02-18','A0201',33,1),('2024-08-12','A0051',33,1),('2024-08-12','A0171',33,1),('2024-08-24','A0111',33,1),('2024-08-24','A0231',33,1),('2025-01-03','A0231',33,6),('2025-01-09','A0051',33,3),('2025-01-16','A0231',33,3),('2025-02-12','A0111',33,7),('2025-02-17','A0051',33,1),('2025-02-17','A0111',33,4),('2025-02-19','A0201',33,4),('2025-11-05','A0280',33,1),('2024-05-03','A0246',34,2),('2024-08-24','A0303',34,2),('2025-01-03','A0172',34,4),('2025-01-06','A0112',34,7),('2025-01-13','A0246',34,8),('2025-01-15','A0082',34,3),('2025-01-17','A0232',34,4),('2025-01-19','A0303',34,6),('2025-01-21','A0246',34,8),('2025-01-30','A0052',34,5),('2025-02-02','A0172',34,1),('2025-02-12','A0052',34,6),('2025-02-15','A0303',34,7),('2025-02-16','A0052',34,1),('2025-02-16','A0052',34,2),('2025-02-18','A0082',34,6),('2025-05-11','A0022',34,2),('2025-05-11','A0142',34,2),('2025-05-23','A0082',34,2),('2025-05-23','A0202',34,2),('2025-11-05','A0112',34,2),('2025-11-05','A0232',34,2),('2025-11-17','A0052',34,2),('2025-11-17','A0172',34,2),('2025-01-03','A0173',35,5),('2025-01-06','A0053',35,2),('2025-01-06','A0083',35,3),('2025-01-08','A0143',35,6),('2025-01-23','A0143',35,5),('2025-01-31','A0083',35,1),('2025-02-03','A0269',35,7),('2025-02-05','A0173',35,2),('2025-02-13','A0203',35,4),('2025-02-18','A0053',35,5),('2025-02-20','A0203',35,6),('2026-02-10','A0113',35,3),('2026-02-10','A0233',35,3),('2026-02-22','A0053',35,3),('2026-02-22','A0173',35,3),('2026-02-22','A0269',35,3),('2026-08-04','A0083',35,3),('2026-08-04','A0203',35,3),('2026-08-16','A0023',35,3),('2026-08-16','A0143',35,3),('2024-05-03','A0054',36,4),('2024-05-03','A0174',36,4),('2024-05-15','A0114',36,4),('2024-05-15','A0234',36,4),('2024-11-09','A0084',36,4),('2024-11-09','A0204',36,4),('2024-11-21','A0024',36,4),('2024-11-21','A0144',36,4),('2025-01-03','A0054',36,7),('2025-01-11','A0054',36,7),('2025-01-14','A0114',36,6),('2025-01-20','A0084',36,2),('2025-01-22','A0144',36,1),('2025-01-29','A0234',36,5),('2025-02-06','A0292',36,2),('2025-11-17','A0292',36,4),('2024-05-15','A0258',37,5),('2024-08-12','A0315',37,5),('2025-01-03','A0235',37,3),('2025-01-04','A0258',37,4),('2025-01-06','A0145',37,2),('2025-01-12','A0205',37,6),('2025-01-24','A0115',37,8),('2025-01-24','A0145',37,6),('2025-02-01','A0115',37,1),('2025-02-02','A0025',37,5),('2025-02-02','A0145',37,5),('2025-02-05','A0085',37,6),('2025-02-05','A0115',37,5),('2025-02-08','A0025',37,2),('2025-02-10','A0085',37,1),('2025-02-14','A0085',37,5),('2025-02-14','A0205',37,5),('2025-02-19','A0115',37,3),('2025-02-20','A0175',37,2),('2025-08-08','A0055',37,5),('2025-08-08','A0175',37,5),('2025-08-20','A0115',37,5),('2025-08-20','A0235',37,5),('2025-01-06','A0236',38,1),('2025-01-09','A0236',38,8),('2025-01-12','A0056',38,6),('2025-01-12','A0281',38,5),('2025-01-16','A0206',38,6),('2025-01-19','A0236',38,8),('2025-02-04','A0206',38,5),('2025-02-11','A0056',38,6),('2025-02-17','A0116',38,2),('2025-02-20','A0056',38,3),('2025-02-20','A0146',38,8),('2025-02-20','A0176',38,2),('2026-02-10','A0281',38,6),('2026-05-07','A0026',38,6),('2026-05-07','A0146',38,6),('2026-05-19','A0086',38,6),('2026-05-19','A0206',38,6),('2026-11-01','A0116',38,6),('2026-11-01','A0236',38,6),('2026-11-13','A0056',38,6),('2026-11-13','A0176',38,6),('2024-02-06','A0117',39,7),('2024-02-06','A0237',39,7),('2024-02-18','A0057',39,7),('2024-02-18','A0177',39,7),('2024-08-12','A0027',39,7),('2024-08-12','A0147',39,7),('2024-08-24','A0087',39,7),('2024-08-24','A0207',39,7),('2025-01-15','A0247',39,4),('2025-01-19','A0087',39,2),('2025-01-20','A0247',39,8),('2025-01-24','A0237',39,4),('2025-02-03','A0057',39,4),('2025-02-11','A0057',39,5),('2025-02-11','A0177',39,6),('2025-08-08','A0247',39,7),('2025-11-05','A0304',39,7),('2024-05-03','A0270',40,8),('2025-01-07','A0238',40,5),('2025-01-08','A0238',40,1),('2025-01-10','A0270',40,6),('2025-01-19','A0088',40,8),('2025-01-21','A0088',40,2),('2025-01-28','A0208',40,7),('2025-02-18','A0178',40,5),('2025-02-18','A0208',40,7),('2025-05-11','A0118',40,8),('2025-05-11','A0238',40,8),('2025-05-23','A0058',40,8),('2025-05-23','A0178',40,8),('2025-11-05','A0088',40,8),('2025-11-05','A0208',40,8),('2025-11-17','A0028',40,8),('2025-11-17','A0148',40,8),('2025-01-02','A0209',41,2),('2025-01-24','A0179',41,4),('2025-01-26','A0059',41,5),('2025-02-09','A0293',41,3),('2025-02-16','A0029',41,1),('2025-02-16','A0179',41,2),('2026-02-10','A0089',41,1),('2026-02-10','A0209',41,1),('2026-02-22','A0029',41,1),('2026-02-22','A0149',41,1),('2026-02-22','A0293',41,1),('2026-08-04','A0059',41,1),('2026-08-04','A0179',41,1),('2026-08-16','A0119',41,1),('2026-08-16','A0239',41,1),('2024-05-03','A0030',42,2),('2024-05-03','A0150',42,2),('2024-05-15','A0090',42,2),('2024-05-15','A0210',42,2),('2024-11-09','A0060',42,2),('2024-11-09','A0180',42,2),('2024-11-21','A0120',42,2),('2024-11-21','A0240',42,2),('2025-01-02','A0030',42,3),('2025-01-09','A0030',42,8),('2025-01-13','A0060',42,4),('2025-01-13','A0150',42,5),('2025-01-21','A0180',42,8),('2025-02-02','A0090',42,1),('2025-02-04','A0060',42,3),('2025-02-05','A0030',42,3),('2025-02-08','A0150',42,8),('2025-02-09','A0210',42,4),('2025-02-11','A0316',42,4),('2025-08-20','A0259',42,2),('2025-11-17','A0316',42,2),('2024-05-15','A0282',43,3),('2025-02-20','A0282',43,4),('2025-01-02','A0305',44,8),('2025-01-14','A0248',44,3),('2025-01-31','A0305',44,3),('2026-02-10','A0305',44,4),('2026-11-13','A0248',44,4),('2025-01-11','A0271',45,4),('2025-02-15','A0271',45,5),('2025-08-08','A0271',45,5),('2024-05-03','A0294',46,6),('2025-02-03','A0294',46,5),('2025-02-01','A0260',47,7),('2026-11-01','A0260',47,7),('2025-01-10','A0283',48,5),('2025-01-14','A0283',48,3),('2025-01-15','A0283',48,4),('2025-01-31','A0283',48,2),('2025-02-11','A0283',48,3),('2025-08-20','A0283',48,8),('2024-02-18','A0249',49,1),('2024-05-15','A0306',49,1),('2025-01-31','A0272',50,2),('2026-11-13','A0272',50,2),('2025-08-08','A0295',51,3),('2024-02-06','A0261',52,4),('2025-01-07','A0261',52,4),('2025-01-19','A0284',53,7),('2026-11-01','A0284',53,5),('2025-01-02','A0307',54,3),('2025-01-17','A0307',54,1),('2025-02-05','A0250',54,4),('2025-05-23','A0250',54,6),('2025-08-20','A0307',54,6),('2024-02-18','A0273',55,7),('2025-01-11','A0273',55,8),('2025-02-04','A0273',55,1),('2026-11-13','A0296',56,8),('2025-05-11','A0262',57,1);
/*!40000 ALTER TABLE `mentoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `mentorias_tomadas`
--

DROP TABLE IF EXISTS `mentorias_tomadas`;
/*!50001 DROP VIEW IF EXISTS `mentorias_tomadas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `mentorias_tomadas` AS SELECT 
 1 AS `id_mentor`,
 1 AS `nombre_mentor`,
 1 AS `tema_mentoria`,
 1 AS `alumno`,
 1 AS `total_mentorias_por_alumno`,
 1 AS `fecha_inicio`,
 1 AS `fecha_fin`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `participar`
--

DROP TABLE IF EXISTS `participar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `participar` (
  `matricula` varchar(10) NOT NULL,
  `id_proyecto` int NOT NULL,
  `rol` varchar(20) NOT NULL,
  PRIMARY KEY (`matricula`,`id_proyecto`),
  KEY `proyecto_fk` (`id_proyecto`),
  CONSTRAINT `matricula_fk` FOREIGN KEY (`matricula`) REFERENCES `estudiante` (`matricula`),
  CONSTRAINT `proyecto_fk` FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participar`
--

LOCK TABLES `participar` WRITE;
/*!40000 ALTER TABLE `participar` DISABLE KEYS */;
INSERT INTO `participar` VALUES ('A0002',2,'Becario'),('A0003',3,'Coordinador'),('A0004',4,'Voluntario'),('A0005',5,'Apoyo'),('A0006',6,'Integrante'),('A0007',7,'Becario'),('A0008',8,'Coordinador'),('A0009',9,'Voluntario'),('A0010',10,'Apoyo'),('A0011',11,'Integrante'),('A0012',12,'Becario'),('A0013',13,'Coordinador'),('A0014',14,'Voluntario'),('A0015',15,'Apoyo'),('A0016',16,'Integrante'),('A0017',17,'Becario'),('A0018',18,'Coordinador'),('A0019',31,'Voluntario'),('A0020',32,'Apoyo'),('A0021',33,'Integrante'),('A0022',34,'Becario'),('A0023',35,'Coordinador'),('A0024',36,'Voluntario'),('A0025',37,'Apoyo'),('A0026',38,'Integrante'),('A0027',39,'Becario'),('A0028',40,'Coordinador'),('A0029',41,'Voluntario'),('A0030',42,'Apoyo'),('A0032',2,'Becario'),('A0033',3,'Coordinador'),('A0034',4,'Voluntario'),('A0035',5,'Apoyo'),('A0036',6,'Integrante'),('A0037',7,'Becario'),('A0038',8,'Coordinador'),('A0039',9,'Voluntario'),('A0040',10,'Apoyo'),('A0041',11,'Integrante'),('A0042',12,'Becario'),('A0043',13,'Coordinador'),('A0044',14,'Voluntario'),('A0045',15,'Apoyo'),('A0046',16,'Integrante'),('A0047',17,'Becario'),('A0048',18,'Coordinador'),('A0049',31,'Voluntario'),('A0050',32,'Apoyo'),('A0051',33,'Integrante'),('A0052',34,'Becario'),('A0053',35,'Coordinador'),('A0054',36,'Voluntario'),('A0055',37,'Apoyo'),('A0056',38,'Integrante'),('A0057',39,'Becario'),('A0058',40,'Coordinador'),('A0059',41,'Voluntario'),('A0060',42,'Apoyo'),('A0062',2,'Becario'),('A0063',3,'Coordinador'),('A0064',4,'Voluntario'),('A0065',5,'Apoyo'),('A0066',6,'Integrante'),('A0067',7,'Becario'),('A0068',8,'Coordinador'),('A0069',9,'Voluntario'),('A0070',10,'Apoyo'),('A0071',11,'Integrante'),('A0072',12,'Becario'),('A0073',13,'Coordinador'),('A0074',14,'Voluntario'),('A0075',15,'Apoyo'),('A0076',16,'Integrante'),('A0077',17,'Becario'),('A0078',18,'Coordinador'),('A0079',31,'Voluntario'),('A0080',32,'Apoyo'),('A0081',33,'Integrante'),('A0082',34,'Becario'),('A0083',35,'Coordinador'),('A0084',36,'Voluntario'),('A0085',37,'Apoyo'),('A0086',38,'Integrante'),('A0087',39,'Becario'),('A0088',40,'Coordinador'),('A0089',41,'Voluntario'),('A0090',42,'Apoyo'),('A0092',2,'Becario'),('A0093',3,'Coordinador'),('A0094',4,'Voluntario'),('A0095',5,'Apoyo'),('A0096',6,'Integrante'),('A0097',7,'Becario'),('A0098',8,'Coordinador'),('A0099',9,'Voluntario'),('A0100',10,'Apoyo'),('A0101',11,'Integrante'),('A0102',12,'Becario'),('A0103',13,'Coordinador'),('A0104',14,'Voluntario'),('A0105',15,'Apoyo'),('A0106',16,'Integrante'),('A0107',17,'Becario'),('A0108',18,'Coordinador'),('A0109',31,'Voluntario'),('A0110',32,'Apoyo'),('A0111',33,'Integrante'),('A0112',34,'Becario'),('A0113',35,'Coordinador'),('A0114',36,'Voluntario'),('A0115',37,'Apoyo'),('A0116',38,'Integrante'),('A0117',39,'Becario'),('A0118',40,'Coordinador'),('A0119',41,'Voluntario'),('A0120',42,'Apoyo'),('A0122',2,'Becario'),('A0123',3,'Coordinador'),('A0124',4,'Voluntario'),('A0125',5,'Apoyo'),('A0126',6,'Integrante'),('A0127',7,'Becario'),('A0128',8,'Coordinador'),('A0129',9,'Voluntario'),('A0130',10,'Apoyo'),('A0131',11,'Integrante'),('A0132',12,'Becario'),('A0133',13,'Coordinador'),('A0134',14,'Voluntario'),('A0135',15,'Apoyo'),('A0136',16,'Integrante'),('A0137',17,'Becario'),('A0138',18,'Coordinador'),('A0139',31,'Voluntario'),('A0140',32,'Apoyo'),('A0141',33,'Integrante'),('A0142',34,'Becario'),('A0143',35,'Coordinador'),('A0144',36,'Voluntario'),('A0145',37,'Apoyo'),('A0146',38,'Integrante'),('A0147',39,'Becario'),('A0148',40,'Coordinador'),('A0149',41,'Voluntario'),('A0150',42,'Apoyo'),('A0152',2,'Becario'),('A0153',3,'Coordinador'),('A0154',4,'Voluntario'),('A0155',5,'Apoyo'),('A0156',6,'Integrante'),('A0157',7,'Becario'),('A0158',8,'Coordinador'),('A0159',9,'Voluntario'),('A0160',10,'Apoyo'),('A0161',11,'Integrante'),('A0162',12,'Becario'),('A0163',13,'Coordinador'),('A0164',14,'Voluntario'),('A0165',15,'Apoyo'),('A0166',16,'Integrante'),('A0167',17,'Becario'),('A0168',18,'Coordinador'),('A0169',31,'Voluntario'),('A0170',32,'Apoyo'),('A0171',33,'Integrante'),('A0172',34,'Becario'),('A0173',35,'Coordinador'),('A0174',36,'Voluntario'),('A0175',37,'Apoyo'),('A0176',38,'Integrante'),('A0177',39,'Becario'),('A0178',40,'Coordinador'),('A0179',41,'Voluntario'),('A0180',42,'Apoyo'),('A0182',2,'Becario'),('A0183',3,'Coordinador'),('A0184',4,'Voluntario'),('A0185',5,'Apoyo'),('A0186',6,'Integrante'),('A0187',7,'Becario'),('A0188',8,'Coordinador'),('A0189',9,'Voluntario'),('A0190',10,'Apoyo'),('A0191',11,'Integrante'),('A0192',12,'Becario'),('A0193',13,'Coordinador'),('A0194',14,'Voluntario'),('A0195',15,'Apoyo'),('A0196',16,'Integrante'),('A0197',17,'Becario'),('A0198',18,'Coordinador'),('A0199',31,'Voluntario'),('A0200',32,'Apoyo'),('A0201',33,'Integrante'),('A0202',34,'Becario'),('A0203',35,'Coordinador'),('A0204',36,'Voluntario'),('A0205',37,'Apoyo'),('A0206',38,'Integrante'),('A0207',39,'Becario'),('A0208',40,'Coordinador'),('A0209',41,'Voluntario'),('A0210',42,'Apoyo'),('A0212',2,'Becario'),('A0213',3,'Coordinador'),('A0214',4,'Voluntario'),('A0215',5,'Apoyo'),('A0216',6,'Integrante'),('A0217',7,'Becario'),('A0218',8,'Coordinador'),('A0219',9,'Voluntario'),('A0220',10,'Apoyo'),('A0221',11,'Integrante'),('A0222',12,'Becario'),('A0223',13,'Coordinador'),('A0224',14,'Voluntario'),('A0225',15,'Apoyo'),('A0226',16,'Integrante'),('A0227',17,'Becario'),('A0228',18,'Coordinador'),('A0229',31,'Voluntario'),('A0230',32,'Apoyo'),('A0231',33,'Integrante'),('A0232',34,'Becario'),('A0233',35,'Coordinador'),('A0234',36,'Voluntario'),('A0235',37,'Apoyo'),('A0236',38,'Integrante'),('A0237',39,'Becario'),('A0238',40,'Coordinador'),('A0239',41,'Voluntario'),('A0240',42,'Apoyo'),('A0241',9,'Integrante'),('A0242',14,'Becario'),('A0243',19,'Coordinador'),('A0244',24,'Voluntario'),('A0245',29,'Apoyo'),('A0246',34,'Integrante'),('A0247',39,'Becario'),('A0248',44,'Coordinador'),('A0249',49,'Voluntario'),('A0250',54,'Apoyo'),('A0251',2,'Integrante'),('A0252',7,'Becario'),('A0253',12,'Coordinador'),('A0254',17,'Voluntario'),('A0255',22,'Apoyo'),('A0256',27,'Integrante'),('A0257',32,'Becario'),('A0258',37,'Coordinador'),('A0259',42,'Voluntario'),('A0260',47,'Apoyo'),('A0261',52,'Integrante'),('A0262',57,'Becario'),('A0263',5,'Coordinador'),('A0264',10,'Voluntario'),('A0265',15,'Apoyo'),('A0266',20,'Integrante'),('A0267',25,'Becario'),('A0268',30,'Coordinador'),('A0269',35,'Voluntario'),('A0270',40,'Apoyo'),('A0271',45,'Integrante'),('A0272',50,'Becario'),('A0273',55,'Coordinador'),('A0274',3,'Voluntario'),('A0275',8,'Apoyo'),('A0276',13,'Integrante'),('A0277',18,'Becario'),('A0278',23,'Coordinador'),('A0279',28,'Voluntario'),('A0280',33,'Apoyo'),('A0281',38,'Integrante'),('A0282',43,'Becario'),('A0283',48,'Coordinador'),('A0284',53,'Voluntario'),('A0286',6,'Integrante'),('A0287',11,'Becario'),('A0288',16,'Coordinador'),('A0289',21,'Voluntario'),('A0290',26,'Apoyo'),('A0291',31,'Integrante'),('A0292',36,'Becario'),('A0293',41,'Coordinador'),('A0294',46,'Voluntario'),('A0295',51,'Apoyo'),('A0296',56,'Integrante'),('A0297',4,'Becario'),('A0298',9,'Coordinador'),('A0299',14,'Voluntario'),('A0300',19,'Apoyo'),('A0301',24,'Integrante'),('A0302',29,'Becario'),('A0303',34,'Coordinador'),('A0304',39,'Voluntario'),('A0305',44,'Apoyo'),('A0306',49,'Integrante'),('A0307',54,'Becario'),('A0308',2,'Coordinador'),('A0309',7,'Voluntario'),('A0310',12,'Apoyo'),('A0311',17,'Integrante'),('A0312',22,'Becario'),('A0313',27,'Coordinador'),('A0314',32,'Voluntario'),('A0315',37,'Apoyo'),('A0316',42,'Integrante');
/*!40000 ALTER TABLE `participar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persona_acompañamiento`
--

DROP TABLE IF EXISTS `persona_acompañamiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `persona_acompañamiento` (
  `id_persona_acom` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `tipo_persona` varchar(20) NOT NULL,
  `area` varchar(20) NOT NULL,
  `puesto` varchar(20) NOT NULL,
  PRIMARY KEY (`id_persona_acom`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona_acompañamiento`
--

LOCK TABLES `persona_acompañamiento` WRITE;
/*!40000 ALTER TABLE `persona_acompañamiento` DISABLE KEYS */;
INSERT INTO `persona_acompañamiento` VALUES (1,'Gabriela Ruiz Cortes','Interno','CIIS','Coordinadora'),(2,'Rado Perez Rastovic','Interno','CIIS','Director'),(3,'Isabel Hernandez Martinez','Interno','BL-UAF','Coordinadora'),(4,'Ines Morales Vargas','Interno','UAF','Seguimiento'),(5,'Emiliano Torres Sanchez','Interno','BL','Analista'),(6,'Istak Salas Hernandez','Interno','CIIS','Gestor');
/*!40000 ALTER TABLE `persona_acompañamiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programa`
--

DROP TABLE IF EXISTS `programa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `programa` (
  `id_programa` int NOT NULL AUTO_INCREMENT,
  `nombre_programa` varchar(50) NOT NULL,
  PRIMARY KEY (`id_programa`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programa`
--

LOCK TABLES `programa` WRITE;
/*!40000 ALTER TABLE `programa` DISABLE KEYS */;
INSERT INTO `programa` VALUES (1,'BL-UAF'),(2,'UAF'),(3,'BL'),(4,'Beca Liderazgo'),(5,'Voluntaria'),(6,'Voluntario'),(7,'Voluntarios'),(8,'Sin programa');
/*!40000 ALTER TABLE `programa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proyecto`
--

DROP TABLE IF EXISTS `proyecto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proyecto` (
  `id_proyecto` int NOT NULL AUTO_INCREMENT,
  `nombre_proyecto` varchar(50) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `ods` varchar(10) NOT NULL,
  `saps_clasificacion` varchar(50) NOT NULL,
  PRIMARY KEY (`id_proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proyecto`
--

LOCK TABLES `proyecto` WRITE;
/*!40000 ALTER TABLE `proyecto` DISABLE KEYS */;
INSERT INTO `proyecto` VALUES (2,'Educando desde el Corazon','Atencion comunitaria y aprendizaje social','ODS 3','Bioetica y ciencias de la vida'),(3,'Be a New Cycle','Vinculacion territorial con estudiantes','ODS 8','Trabajo y competitividad sostenible'),(4,'Porque Informar','Seguimiento educativo con impacto social','ODS 4','Acompanamiento academico integral'),(5,'Aprende a Amarte','Fortalecimiento de redes comunitarias','ODS 11','Competitividad social comunitaria'),(6,'CREDU','Proyecto social con aliados locales','ODS 17','Gestion de impacto social'),(7,'Latimos Juntas','Promocion de salud y bienestar','ODS 3','Salud comunitaria y bienestar'),(8,'Une tu Corazon','Innovacion educativa para comunidades','ODS 9','Innovacion educativa comunitaria'),(9,'Ziandalu Salud Mental','Formacion y habilidades para jovenes','ODS 4','Desarrollo humano y social'),(10,'Recuerdame Adulto Mayor','Atencion comunitaria y aprendizaje social','ODS 3','Bioetica y ciencias de la vida'),(11,'H2OW Agua Segura','Vinculacion territorial con estudiantes','ODS 8','Trabajo y competitividad sostenible'),(12,'Por Uno Mas Educacion','Seguimiento educativo con impacto social','ODS 4','Acompanamiento academico integral'),(13,'Seres Lideres Rurales','Fortalecimiento de redes comunitarias','ODS 11','Competitividad social comunitaria'),(14,'Salud Preventiva','Proyecto social con aliados locales','ODS 17','Gestion de impacto social'),(15,'Fuerza del Corazon','Promocion de salud y bienestar','ODS 3','Salud comunitaria y bienestar'),(16,'Heroes con Identidad','Innovacion educativa para comunidades','ODS 9','Innovacion educativa comunitaria'),(17,'IZEL Cultura Viva','Formacion y habilidades para jovenes','ODS 4','Desarrollo humano y social'),(18,'Latimos Juntos','Atencion comunitaria y aprendizaje social','ODS 3','Bioetica y ciencias de la vida'),(19,'Oportunidades Laborales','Vinculacion territorial con estudiantes','ODS 8','Trabajo y competitividad sostenible'),(20,'Diabetes en Comunidad','Seguimiento educativo con impacto social','ODS 4','Acompanamiento academico integral'),(21,'Raices Productivas','Fortalecimiento de redes comunitarias','ODS 11','Competitividad social comunitaria'),(22,'Huertos Familiares','Proyecto social con aliados locales','ODS 17','Gestion de impacto social'),(23,'Puentes Digitales','Promocion de salud y bienestar','ODS 3','Salud comunitaria y bienestar'),(24,'Aula Movil','Innovacion educativa para comunidades','ODS 9','Innovacion educativa comunitaria'),(25,'Emprende Joven','Formacion y habilidades para jovenes','ODS 4','Desarrollo humano y social'),(26,'Vive Sin Violencia','Atencion comunitaria y aprendizaje social','ODS 3','Bioetica y ciencias de la vida'),(27,'Comunidad Lectora','Vinculacion territorial con estudiantes','ODS 8','Trabajo y competitividad sostenible'),(28,'Mujeres que Lideran','Seguimiento educativo con impacto social','ODS 4','Acompanamiento academico integral'),(29,'Eco Escuela','Fortalecimiento de redes comunitarias','ODS 11','Competitividad social comunitaria'),(30,'Nutricion Digna','Proyecto social con aliados locales','ODS 17','Gestion de impacto social'),(31,'Red de Tutorias','Promocion de salud y bienestar','ODS 3','Salud comunitaria y bienestar'),(32,'Oficios con Futuro','Innovacion educativa para comunidades','ODS 9','Innovacion educativa comunitaria'),(33,'Bienestar Emocional','Formacion y habilidades para jovenes','ODS 4','Desarrollo humano y social'),(34,'Jovenes en Accion','Atencion comunitaria y aprendizaje social','ODS 3','Bioetica y ciencias de la vida'),(35,'Cultura de Paz','Vinculacion territorial con estudiantes','ODS 8','Trabajo y competitividad sostenible'),(36,'Manos al Agua','Seguimiento educativo con impacto social','ODS 4','Acompanamiento academico integral'),(37,'Semillas de Cambio','Fortalecimiento de redes comunitarias','ODS 11','Competitividad social comunitaria'),(38,'Conexion Rural','Proyecto social con aliados locales','ODS 17','Gestion de impacto social'),(39,'Salud para Todos','Promocion de salud y bienestar','ODS 3','Salud comunitaria y bienestar'),(40,'Aprendo Contigo','Innovacion educativa para comunidades','ODS 9','Innovacion educativa comunitaria'),(41,'Familias Fuertes','Formacion y habilidades para jovenes','ODS 4','Desarrollo humano y social'),(42,'Territorio Sustentable','Atencion comunitaria y aprendizaje social','ODS 3','Bioetica y ciencias de la vida'),(43,'Impulso Escolar','Vinculacion territorial con estudiantes','ODS 8','Trabajo y competitividad sostenible'),(44,'Arte para la Paz','Seguimiento educativo con impacto social','ODS 4','Acompanamiento academico integral'),(45,'Acompanamiento Integral','Fortalecimiento de redes comunitarias','ODS 11','Competitividad social comunitaria'),(46,'Innovacion Social Local','Proyecto social con aliados locales','ODS 17','Gestion de impacto social'),(47,'Comunidad Activa','Promocion de salud y bienestar','ODS 3','Salud comunitaria y bienestar'),(48,'Mentoria para el Futuro','Innovacion educativa para comunidades','ODS 9','Innovacion educativa comunitaria'),(49,'Escuela Verde','Formacion y habilidades para jovenes','ODS 4','Desarrollo humano y social'),(50,'Voces Comunitarias','Atencion comunitaria y aprendizaje social','ODS 3','Bioetica y ciencias de la vida'),(51,'Ruta de Empleo','Vinculacion territorial con estudiantes','ODS 8','Trabajo y competitividad sostenible'),(52,'Cuidado del Agua','Seguimiento educativo con impacto social','ODS 4','Acompanamiento academico integral'),(53,'Prevencion y Salud','Fortalecimiento de redes comunitarias','ODS 11','Competitividad social comunitaria'),(54,'Talento Universitario','Proyecto social con aliados locales','ODS 17','Gestion de impacto social'),(55,'Puente Comunitario','Promocion de salud y bienestar','ODS 3','Salud comunitaria y bienestar'),(56,'Liderazgo Social','Innovacion educativa para comunidades','ODS 9','Innovacion educativa comunitaria'),(57,'Red de Beneficiarios','Formacion y habilidades para jovenes','ODS 4','Desarrollo humano y social');
/*!40000 ALTER TABLE `proyecto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `proyectos_implementaciones`
--

DROP TABLE IF EXISTS `proyectos_implementaciones`;
/*!50001 DROP VIEW IF EXISTS `proyectos_implementaciones`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `proyectos_implementaciones` AS SELECT 
 1 AS `Id Proyecto`,
 1 AS `Nombre`,
 1 AS `Comunidad`,
 1 AS `Fecha Inicio`,
 1 AS `Fecha Fin`,
 1 AS `Beneficiarios`,
 1 AS `estado`,
 1 AS `Duracion`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `proyectos_operativos`
--

DROP TABLE IF EXISTS `proyectos_operativos`;
/*!50001 DROP VIEW IF EXISTS `proyectos_operativos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `proyectos_operativos` AS SELECT 
 1 AS `Proyecto`,
 1 AS `Comunidad`,
 1 AS `Municipio`,
 1 AS `Fecha_Inicio`,
 1 AS `Fecha_Fin`,
 1 AS `Beneficiarios`,
 1 AS `Estudiantes_Participantes`,
 1 AS `Aliados_Vinculados`,
 1 AS `Estudiantes_Con_Mentoria`,
 1 AS `Mentorias_Registradas`,
 1 AS `Ultima_Mentoria`,
 1 AS `Estatus_Proyecto`,
 1 AS `Prioridad_Seguimiento`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `seguimiento_estudiante_proyecto`
--

DROP TABLE IF EXISTS `seguimiento_estudiante_proyecto`;
/*!50001 DROP VIEW IF EXISTS `seguimiento_estudiante_proyecto`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `seguimiento_estudiante_proyecto` AS SELECT 
 1 AS `id_proyecto`,
 1 AS `matricula`,
 1 AS `estatus_alumno`,
 1 AS `nombre_programa`,
 1 AS `rol`,
 1 AS `total_aliados`,
 1 AS `total_mentorias`,
 1 AS `ultima_mentoria`,
 1 AS `clasificacion_seguimiento`,
 1 AS `diagnostico_operativo`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `tema_mentoria`
--

DROP TABLE IF EXISTS `tema_mentoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tema_mentoria` (
  `id_tema` int NOT NULL AUTO_INCREMENT,
  `tema_mentoria` varchar(50) NOT NULL,
  PRIMARY KEY (`id_tema`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tema_mentoria`
--

LOCK TABLES `tema_mentoria` WRITE;
/*!40000 ALTER TABLE `tema_mentoria` DISABLE KEYS */;
INSERT INTO `tema_mentoria` VALUES (1,'Desarrollo humano y social'),(2,'Bioetica y ciencias de la vida'),(3,'Trabajo y competitividad sostenible'),(4,'Acompanamiento academico integral'),(5,'Competitividad social y desarrollo comunitario'),(6,'Gestion de proyectos de impacto social'),(7,'Salud comunitaria y bienestar'),(8,'Innovacion educativa para comunidades');
/*!40000 ALTER TABLE `tema_mentoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_mentorias_operativas`
--

DROP TABLE IF EXISTS `vw_mentorias_operativas`;
/*!50001 DROP VIEW IF EXISTS `vw_mentorias_operativas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_mentorias_operativas` AS SELECT 
 1 AS `id_mentor`,
 1 AS `nombre_mentor`,
 1 AS `tema_mentoria`,
 1 AS `total_mentorias`,
 1 AS `estudiantes_atendidos`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_proyectos_operativos`
--

DROP TABLE IF EXISTS `vw_proyectos_operativos`;
/*!50001 DROP VIEW IF EXISTS `vw_proyectos_operativos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_proyectos_operativos` AS SELECT 
 1 AS `Proyecto`,
 1 AS `Comunidades_Atendidas`,
 1 AS `Total_Beneficiarios`,
 1 AS `Estudiantes_Participantes`,
 1 AS `Aliados_Vinculados`,
 1 AS `Total_Mentorias`,
 1 AS `Ultima_Implementacion`,
 1 AS `Estatus_Proyecto`,
 1 AS `Prioridad_Seguimiento`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_territorio_impacto`
--

DROP TABLE IF EXISTS `vw_territorio_impacto`;
/*!50001 DROP VIEW IF EXISTS `vw_territorio_impacto`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_territorio_impacto` AS SELECT 
 1 AS `municipio`,
 1 AS `comunidades_atendidas`,
 1 AS `total_proyectos`,
 1 AS `total_beneficiarios`,
 1 AS `total_aliados`,
 1 AS `promedio_beneficiarios_por_proyecto`,
 1 AS `beneficiarios_por_comunidad`,
 1 AS `proyectos_por_comunidad`,
 1 AS `fecha_inicio`,
 1 AS `fecha_fin`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'ciis'
--

--
-- Dumping routines for database 'ciis'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_carga_coordi` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_carga_coordi`(in p_matricula varchar(20), in p_id_coordinador int)
begin
    if (select count(*) from estudiante where matricula = p_matricula) = 0 then
        select "el estudiante no existe" as mensaje_error;
    elseif (select count(*) from persona_acompañamiento where id_persona_acom = p_id_coordinador) = 0 then
        select "el coordinador no existe" as mensaje_error;
    else
        update estudiante 
        set id_coordinador = p_id_coordinador 
        where matricula = p_matricula;

        select 
            pac.nombre as coordinador,
            pac.area, 
            count(e.matricula) as alumnos_a_cargo
        from persona_acompañamiento as pac
        left join estudiante as e on pac.id_persona_acom = e.id_coordinador
        where pac.id_persona_acom = p_id_coordinador
        group by pac.id_persona_acom, pac.nombre, pac.area;
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_comparar_proyectos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_comparar_proyectos`(
  IN p_anio1 INT,
  IN p_anio2 INT
)
BEGIN
  SELECT
    t.municipio AS Municipio,
    t.proyectos_anio_1 AS Proyectos_Anio_1,
    t.proyectos_anio_2 AS Proyectos_Anio_2,
    CASE STRCMP(
      LPAD(CAST(t.proyectos_anio_2 AS CHAR), 10, '0'),
      LPAD(CAST(t.proyectos_anio_1 AS CHAR), 10, '0')
    )
      WHEN 1 THEN 'Aumentó'
      WHEN 0 THEN 'Se mantuvo'
      WHEN -1 THEN 'Disminuyó'
    END AS Comportamiento_Proyectos,
    t.beneficiarios_anio_1 AS Beneficiarios_Anio_1,
    t.beneficiarios_anio_2 AS Beneficiarios_Anio_2,
    CASE STRCMP(
      LPAD(CAST(t.beneficiarios_anio_2 AS CHAR), 10, '0'),
      LPAD(CAST(t.beneficiarios_anio_1 AS CHAR), 10, '0')
    )
      WHEN 1 THEN 'Aumentó'
      WHEN 0 THEN 'Se mantuvo'
      WHEN -1 THEN 'Disminuyó'
    END AS Comportamiento_Beneficiarios
  FROM (
    SELECT
      c.municipio,
      COUNT(
        DISTINCT CASE
          WHEN YEAR(i.fecha_inicio) = p_anio1 THEN i.id_proyecto
        END
      ) AS proyectos_anio_1,
      COUNT(
        DISTINCT CASE
          WHEN YEAR(i.fecha_inicio) = p_anio2 THEN i.id_proyecto
        END
      ) AS proyectos_anio_2,
      SUM(
        CASE
          WHEN YEAR(i.fecha_inicio) = p_anio1
            THEN i.cantidad_beneficiarios
          ELSE 0
        END
      ) AS beneficiarios_anio_1,
      SUM(
        CASE
          WHEN YEAR(i.fecha_inicio) = p_anio2
            THEN i.cantidad_beneficiarios
          ELSE 0
        END
      ) AS beneficiarios_anio_2
    FROM implementar AS i
    JOIN comunidad AS c
      ON i.id_comunidad = c.id_comunidad
    WHERE YEAR(i.fecha_inicio) IN (p_anio1, p_anio2)
    GROUP BY c.municipio
  ) AS t
  ORDER BY Municipio;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_consultar_proyectos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consultar_proyectos`(
    IN estatus CHAR(20)
)
BEGIN
    SELECT *
    FROM proyectos_implementaciones
    WHERE estatus = estado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_consulta_mentorias_anio_mes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consulta_mentorias_anio_mes`(
  IN p_id_mentor INT,
  IN p_anio INT
)
BEGIN
  SELECT
    m.nombre_mentor AS Mentor,
    tm.tema_mentoria AS Tema_Mentoria,
    CASE MONTH(me.fecha_mentoria)
      WHEN 1 THEN 'Enero'
      WHEN 2 THEN 'Febrero'
      WHEN 3 THEN 'Marzo'
      WHEN 4 THEN 'Abril'
      WHEN 5 THEN 'Mayo'
      WHEN 6 THEN 'Junio'
      WHEN 7 THEN 'Julio'
      WHEN 8 THEN 'Agosto'
      WHEN 9 THEN 'Septiembre'
      WHEN 10 THEN 'Octubre'
      WHEN 11 THEN 'Noviembre'
      WHEN 12 THEN 'Diciembre'
    END AS Mes,
    COUNT(*) AS Total_Mentorias,
    COUNT(DISTINCT me.matricula) AS Estudiantes_Atendidos,
    MIN(me.fecha_mentoria) AS Primera_Mentoria,
    MAX(me.fecha_mentoria) AS Ultima_Mentoria,
    GROUP_CONCAT(
      DISTINCT me.matricula
      ORDER BY me.matricula
      SEPARATOR ', '
    ) AS Matriculas_Atendidas
  FROM mentor AS m
  JOIN tema_mentoria AS tm
    ON m.id_tema = tm.id_tema
  JOIN mentoria AS me
    ON m.id_mentor = me.id_mentor
  WHERE m.id_mentor = p_id_mentor
    AND YEAR(me.fecha_mentoria) = p_anio
  GROUP BY
    m.nombre_mentor,
    tm.tema_mentoria,
    MONTH(me.fecha_mentoria),
    CASE MONTH(me.fecha_mentoria)
      WHEN 1 THEN 'Enero'
      WHEN 2 THEN 'Febrero'
      WHEN 3 THEN 'Marzo'
      WHEN 4 THEN 'Abril'
      WHEN 5 THEN 'Mayo'
      WHEN 6 THEN 'Junio'
      WHEN 7 THEN 'Julio'
      WHEN 8 THEN 'Agosto'
      WHEN 9 THEN 'Septiembre'
      WHEN 10 THEN 'Octubre'
      WHEN 11 THEN 'Noviembre'
      WHEN 12 THEN 'Diciembre'
    END
  ORDER BY
    MONTH(me.fecha_mentoria);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_consulta_proyecto_coordinador` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consulta_proyecto_coordinador`(
IN p_id_coordinador INT
)
BEGIN
DECLARE v_coordinador INT;

  SELECT COUNT(*) INTO v_coordinador
  FROM `persona_acompañamiento`
  WHERE id_persona_acom = p_id_coordinador;

  IF v_coordinador = 0 THEN
    SELECT 'Error: el coordinador no existe' AS mensaje;

  ELSE
    SELECT
      pa.nombre AS Coordinador,
      p.nombre_proyecto AS Proyecto,
      COUNT(DISTINCT c.id_comunidad) AS Comunidades_Atendidas,
      COUNT(DISTINCT e.matricula) AS Estudiantes_Coordinados,
      SUM(i.cantidad_beneficiarios) AS Total_Beneficiarios,
      CASE
        WHEN MAX(CASE WHEN i.fecha_fin IS NULL THEN 1 ELSE 0 END) = 1
          THEN 'Activo'
        ELSE 'Finalizado'
      END AS Estatus_Proyecto,
      GROUP_CONCAT(
        DISTINCT CONCAT_WS(', ', c.nombre_comunidad, c.municipio)
        ORDER BY c.municipio, c.nombre_comunidad
        SEPARATOR '; '
      ) AS Lugares_Atendidos
    FROM `persona_acompañamiento` AS pa
    JOIN estudiante AS e
      ON pa.id_persona_acom = e.id_coordinador
    JOIN participar AS par
      ON e.matricula = par.matricula
    JOIN proyecto AS p
      ON par.id_proyecto = p.id_proyecto
    JOIN implementar AS i
      ON p.id_proyecto = i.id_proyecto
    JOIN comunidad AS c
      ON i.id_comunidad = c.id_comunidad
    WHERE pa.id_persona_acom = p_id_coordinador
    GROUP BY
      pa.nombre,
      p.id_proyecto,
      p.nombre_proyecto
    ORDER BY
      Estatus_Proyecto,
      Proyecto;
  END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_consulta_proyecto_mentor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consulta_proyecto_mentor`(
  IN p_id_mentor INT
)
BEGIN
  SELECT
    m.nombre_mentor AS Mentor,
    tm.tema_mentoria AS Tema_Mentoria,
    p.nombre_proyecto AS Proyecto,
    COUNT(*) AS Total_Mentorias,
    COUNT(DISTINCT me.matricula) AS Estudiantes_Atendidos,
    MIN(me.fecha_mentoria) AS Primera_Mentoria,
    MAX(me.fecha_mentoria) AS Ultima_Mentoria,
    GROUP_CONCAT(
      DISTINCT CONCAT_WS(', ', c.nombre_comunidad, c.municipio)
      ORDER BY c.municipio, c.nombre_comunidad
      SEPARATOR '; '
    ) AS Lugares_Proyecto
  FROM mentor AS m
  JOIN tema_mentoria AS tm
    ON m.id_tema = tm.id_tema
  JOIN mentoria AS me
    ON m.id_mentor = me.id_mentor
  JOIN proyecto AS p
    ON me.id_proyecto = p.id_proyecto
  JOIN implementar AS i
    ON p.id_proyecto = i.id_proyecto
  JOIN comunidad AS c
    ON i.id_comunidad = c.id_comunidad
  WHERE m.id_mentor = p_id_mentor
  GROUP BY
    m.nombre_mentor,
    tm.tema_mentoria,
    p.id_proyecto,
    p.nombre_proyecto
  ORDER BY
    Total_Mentorias DESC,
    Proyecto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_aliado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_aliado`(
    IN p_nombre_aliado VARCHAR(50),
    IN p_tipo_aliado VARCHAR(20)
)
BEGIN
DECLARE v_aliado INT;

SELECT COUNT(*) INTO v_aliado
FROM aliado
WHERE nombre_aliado = p_nombre_aliado;

IF v_aliado > 0 THEN
SELECT 'Error: el aliado ya existe' AS mensaje;

ELSE
INSERT INTO aliado (nombre_aliado, tipo_aliado)
VALUES (p_nombre_aliado, p_tipo_aliado);

SELECT *
FROM aliado
ORDER BY id_aliado DESC
LIMIT 1;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_apoyar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_apoyar`(
    IN p_id_aliado INT,
    IN p_id_proyecto INT
)
BEGIN
DECLARE v_aliado INT;
DECLARE v_proyecto INT;

SELECT COUNT(*) INTO v_aliado
FROM aliado
WHERE id_aliado = p_id_aliado;

SELECT COUNT(*) INTO v_proyecto
FROM proyecto
WHERE id_proyecto = p_id_proyecto;

SET @apo = (
SELECT COUNT(*)
FROM apoyar
WHERE id_aliado = p_id_aliado
AND id_proyecto = p_id_proyecto
);

IF v_aliado = 0 THEN
SELECT 'Error: el aliado no existe' AS mensaje;

ELSEIF v_proyecto = 0 THEN
SELECT 'Error: el proyecto no existe' AS mensaje;

ELSEIF @apo > 0 THEN
SELECT 'Error: la relacion aliado-proyecto ya existe' AS mensaje;

ELSE
INSERT INTO apoyar (id_aliado, id_proyecto)
VALUES (p_id_aliado, p_id_proyecto);

SELECT *
FROM apoyar
WHERE id_aliado = p_id_aliado
AND id_proyecto = p_id_proyecto;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_comunidad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_comunidad`(
    IN p_nombre_comunidad VARCHAR(50),
    IN p_municipio VARCHAR(50)
)
BEGIN
DECLARE v_comunidad INT;

SELECT COUNT(*) INTO v_comunidad
FROM comunidad
WHERE nombre_comunidad = p_nombre_comunidad
AND municipio = p_municipio;

IF v_comunidad > 0 THEN
SELECT 'Error: la comunidad ya existe en ese municipio' AS mensaje;

ELSE
INSERT INTO comunidad (nombre_comunidad, municipio)
VALUES (p_nombre_comunidad, p_municipio);

SELECT *
FROM comunidad
ORDER BY id_comunidad DESC
LIMIT 1;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_estudiante` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_estudiante`(
IN p_matricula VARCHAR(10),
IN p_nombre VARCHAR(50),
IN p_gen_ingreso INT,
IN p_estatus VARCHAR(20),
IN p_correo VARCHAR(50),
IN p_id_programa INT,
IN p_id_coordinador INT,
IN p_frecuencia_sesion VARCHAR(20)
)
BEGIN
DECLARE v_programa INT;
DECLARE v_coordinador INT;
DECLARE v_matricula_valida INT;
SELECT COUNT(*) INTO v_programa
FROM programa
WHERE id_programa = p_id_programa;SELECT COUNT(*) INTO v_coordinador
FROM `persona_acompañamiento`
WHERE id_persona_acom = p_id_coordinador;
SET v_matricula_valida = (
SELECT IF(p_matricula REGEXP '^A[0-9]{1,9}$', 1, 0)
);
IF v_matricula_valida = 0 THEN
SELECT 'Error: la matricula debe iniciar con A y tener hasta 9 numeros' AS mensaje;
ELSEIF v_programa = 0 THEN
SELECT 'Error: el programa no existe' AS mensaje;
ELSEIF v_coordinador = 0 THEN
SELECT 'Error: el coordinador no existe' AS mensaje;
ELSE
INSERT INTO estudiante (
matricula,
nombre,
gen_ingreso,
estatus,
correo,
id_programa,
id_coordinador,
frecuencia_sesion
)
VALUES (
p_matricula,
p_nombre,
p_gen_ingreso,
p_estatus,
p_correo,
p_id_programa,
p_id_coordinador,
p_frecuencia_sesion
);
SELECT *
FROM estudiante
WHERE matricula = p_matricula;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_implementar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_implementar`(
    IN p_id_proyecto INT,
    IN p_id_comunidad INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE,
    IN p_cantidad_beneficiarios INT
)
BEGIN
    DECLARE v_proyecto INT;
    DECLARE v_comunidad INT;

    SELECT COUNT(*) INTO v_proyecto
    FROM proyecto
    WHERE id_proyecto = p_id_proyecto;

    SELECT COUNT(*) INTO v_comunidad
    FROM comunidad
    WHERE id_comunidad = p_id_comunidad;

    IF v_proyecto = 0 THEN
        SELECT 'Error: el proyecto no existe' AS mensaje;

    ELSEIF v_comunidad = 0 THEN
        SELECT 'Error: la comunidad no existe' AS mensaje;

    ELSE
        INSERT INTO implementar (
            id_proyecto,
            id_comunidad,
            fecha_inicio,
            fecha_fin,
            cantidad_beneficiarios
        )
        VALUES (
            p_id_proyecto,
            p_id_comunidad,
            p_fecha_inicio,
            p_fecha_fin,
            p_cantidad_beneficiarios
        );

        SELECT *
        FROM implementar
        WHERE id_proyecto = p_id_proyecto
          AND id_comunidad = p_id_comunidad;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_mentor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_mentor`(
    IN p_nombre_mentor VARCHAR(50),
    IN p_id_tema INT
)
BEGIN
    DECLARE v_tema INT;

    SELECT COUNT(*) INTO v_tema
    FROM tema_mentoria
    WHERE id_tema = p_id_tema;

    IF v_tema = 0 THEN
        SELECT 'Error: el tema de mentoria no existe' AS mensaje;

    ELSE
        INSERT INTO mentor (nombre_mentor, id_tema)
        VALUES (p_nombre_mentor, p_id_tema);

        SELECT *
        FROM mentor
        ORDER BY id_mentor DESC
        LIMIT 1;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_mentoria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_mentoria`(
IN p_matricula VARCHAR(10),
IN p_id_proyecto INT,
IN p_id_mentor INT
)
BEGIN
DECLARE v_estudiante INT;
DECLARE v_proyecto INT;
DECLARE v_mentor INT;

SELECT COUNT(*) INTO v_estudiante
FROM estudiante
WHERE matricula = p_matricula;

SELECT COUNT(*) INTO v_proyecto
FROM proyecto
WHERE id_proyecto = p_id_proyecto;

SELECT COUNT(*) INTO v_mentor
FROM mentor
WHERE id_mentor = p_id_mentor;

IF v_estudiante = 0 THEN
SELECT 'Error: el estudiante no existe' AS mensaje;

ELSEIF v_proyecto = 0 THEN
SELECT 'Error: el proyecto no existe' AS mensaje;

ELSEIF v_mentor = 0 THEN
SELECT 'Error: el mentor no existe' AS mensaje;

ELSE
INSERT INTO mentoria (
fecha_mentoria,
matricula,
id_proyecto,
id_mentor
)
VALUES (
CURDATE(),
p_matricula,
p_id_proyecto,
p_id_mentor
);

SELECT *
FROM mentoria
WHERE fecha_mentoria = CURDATE()
AND matricula = p_matricula
AND id_proyecto = p_id_proyecto
AND id_mentor = p_id_mentor;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_participar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_participar`(
    IN p_matricula VARCHAR(10),
    IN p_id_proyecto INT,
    IN p_rol VARCHAR(20)
)
BEGIN
    DECLARE v_estudiante INT;
    DECLARE v_proyecto INT;

    SELECT COUNT(*) INTO v_estudiante
    FROM estudiante
    WHERE matricula = p_matricula;

    SELECT COUNT(*) INTO v_proyecto
    FROM proyecto
    WHERE id_proyecto = p_id_proyecto;

    IF v_estudiante = 0 THEN
        SELECT 'Error: el estudiante no existe' AS mensaje;

    ELSEIF v_proyecto = 0 THEN
        SELECT 'Error: el proyecto no existe' AS mensaje;

    ELSE
        INSERT INTO participar (matricula, id_proyecto, rol)
        VALUES (p_matricula, p_id_proyecto, p_rol);

        SELECT *
        FROM participar
        WHERE matricula = p_matricula
          AND id_proyecto = p_id_proyecto;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_persona_acompanamiento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_persona_acompanamiento`(
    IN p_nombre VARCHAR(50),
    IN p_tipo_persona VARCHAR(20),
    IN p_area VARCHAR(20),
    IN p_puesto VARCHAR(20)
)
BEGIN
    INSERT INTO `persona_acompañamiento` (nombre, tipo_persona, area, puesto)
    VALUES (p_nombre, p_tipo_persona, p_area, p_puesto);

    SELECT *
    FROM `persona_acompañamiento`
    ORDER BY id_persona_acom DESC
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_programa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_programa`(
    IN p_nombre_programa VARCHAR(50)
)
BEGIN
DECLARE v_programa INT;

SELECT COUNT(*) INTO v_programa
FROM programa
WHERE nombre_programa = p_nombre_programa;

IF v_programa > 0 THEN
SELECT 'Error: el programa ya existe' AS mensaje;

ELSE
INSERT INTO programa (nombre_programa)
VALUES (p_nombre_programa);

SELECT *
FROM programa
ORDER BY id_programa DESC
LIMIT 1;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_proyecto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_proyecto`(
    IN p_nombre_proyecto VARCHAR(50),
    IN p_descripcion VARCHAR(50),
    IN p_ods VARCHAR(10),
    IN p_saps_clasificacion VARCHAR(50),
    IN p_n_integrantes_activos INT
)
BEGIN
DECLARE v_proyecto INT;

SELECT COUNT(*) INTO v_proyecto
FROM proyecto
WHERE nombre_proyecto = p_nombre_proyecto;

IF v_proyecto > 0 THEN
SELECT 'Error: el proyecto ya existe' AS mensaje;

ELSE
INSERT INTO proyecto (
nombre_proyecto,
descripcion,
ods,
saps_clasificacion,
n_integrantes_activos
)
VALUES (
p_nombre_proyecto,
p_descripcion,
p_ods,
p_saps_clasificacion,
p_n_integrantes_activos
);

SELECT *
FROM proyecto
ORDER BY id_proyecto DESC
LIMIT 1;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insert_tema_mentoria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_tema_mentoria`(
    IN p_tema_mentoria VARCHAR(50)
)
BEGIN
DECLARE v_tema INT;

SELECT COUNT(*) INTO v_tema
FROM tema_mentoria
WHERE tema_mentoria = p_tema_mentoria;

IF v_tema > 0 THEN
SELECT 'Error: el tema de mentoria ya existe' AS mensaje;

ELSE
INSERT INTO tema_mentoria (tema_mentoria)
VALUES (p_tema_mentoria);

SELECT *
FROM tema_mentoria
ORDER BY id_tema DESC
LIMIT 1;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_participaciones_estudiantiles` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_participaciones_estudiantiles`(in p_fecha_inicio date, in p_fecha_fin date)
begin
    select
        p.id_proyecto,
        p.nombre_proyecto,
        count(distinct e.matricula) as estudiantes_activos,
        m.id_mentor as "Mentor de proyecto"
    from proyecto as p join participar as par on p.id_proyecto = par.id_proyecto
		join estudiante as e on par.matricula = e.matricula
			join mentoria as ment on ment.matricula=e.matricula
				join mentor as m on m.id_mentor=ment.id_mentor
					join implementar as i on p.id_proyecto = i.id_proyecto 
					where e.estatus = 'activo' and i.fecha_inicio between p_fecha_inicio and p_fecha_fin
    group by p.id_proyecto, p.nombre_proyecto, m.id_mentor
    order by estudiantes_activos desc;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_proyectos_detalle_anio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_proyectos_detalle_anio`(
  IN p_anio INT
)
BEGIN
  SELECT
    YEAR(i.fecha_inicio) AS Anio,
    p.id_proyecto,
    p.nombre_proyecto AS Proyecto,
    c.municipio AS Municipio,
    IF(
      MONTH(i.fecha_inicio) BETWEEN 1 AND 6,
      '1er Periodo',
      '2do Periodo'
    ) AS Periodo,
    SUM(i.cantidad_beneficiarios) AS Total_Beneficiarios,
    CASE
      WHEN MAX(CASE WHEN i.fecha_fin IS NULL THEN 1 ELSE 0 END) = 1
        THEN 'Activo'
      ELSE 'Finalizado'
    END AS Estatus_Proyecto
  FROM implementar AS i
  JOIN comunidad AS c
    ON i.id_comunidad = c.id_comunidad
  JOIN proyecto AS p
    ON i.id_proyecto = p.id_proyecto
  WHERE YEAR(i.fecha_inicio) = p_anio
  GROUP BY
    YEAR(i.fecha_inicio),
    p.id_proyecto,
    p.nombre_proyecto,
    c.municipio,
    IF(
      MONTH(i.fecha_inicio) BETWEEN 1 AND 6,
      '1er Periodo',
      '2do Periodo'
    )
  ORDER BY
    Estatus_Proyecto,
    c.municipio,
    p.nombre_proyecto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reporte_acompanamiento_estudiante` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reporte_acompanamiento_estudiante`(
  IN p_matricula VARCHAR(20)
)
BEGIN
  SELECT
    e.matricula,
    e.nombre AS estudiante,
    pac.nombre AS persona_acompanamiento,
    pac.area,
    pac.puesto
  FROM estudiante AS e
  JOIN persona_acompañamiento AS pac
    ON e.id_coordinador = pac.id_persona_acom
  WHERE e.matricula = p_matricula;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reporte_aliados_periodo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reporte_aliados_periodo`(
  IN p_fecha_inicio DATE,
  IN p_fecha_fin DATE,
  IN p_min_proyectos INT
)
BEGIN
  SELECT
    a.id_aliado,
    a.nombre_aliado,
    a.tipo_aliado,
    COUNT(DISTINCT ap.id_proyecto) AS proyectos_apoyados
  FROM aliado AS a
  JOIN apoyar AS ap
    USING (id_aliado)
  JOIN implementar AS i
    ON ap.id_proyecto = i.id_proyecto
  WHERE i.fecha_inicio BETWEEN p_fecha_inicio AND p_fecha_fin
  GROUP BY
    a.id_aliado,
    a.nombre_aliado,
    a.tipo_aliado
  HAVING COUNT(DISTINCT ap.id_proyecto) > p_min_proyectos
  ORDER BY proyectos_apoyados DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reporte_diversidad_impacto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reporte_diversidad_impacto`()
begin
    /* Concepto Gral: Este reporte analiza el nivel de intervencion multidisciplinaria 
       en cada comunidad, contando cuantos programas academicos distintos estan 
       incidiendo en ellas para clasificar el tipo de impacto social generado. */
    
    select 
        com.nombre_comunidad as comunidad,
        count(distinct p.id_programa) as variedad_de_programas,
        case 
            when count(distinct p.id_programa) >= 3 then 'impacto multidisciplinario'
            when count(distinct p.id_programa) between 1 and 2 then 'enfoque especializado'
            else 'sin presencia'
        end as tipo_de_impacto
    from comunidad as com
    left join implementar as i on com.id_comunidad = i.id_comunidad
    left join proyecto as pro on i.id_proyecto = pro.id_proyecto
    left join programa as p on pro.id_programa = p.id_programa
    group by com.nombre_comunidad;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reporte_estudiantes_prioridad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reporte_estudiantes_prioridad`(in p_id_coordinador int)
begin
    select e.matricula, e.nombre as estudiante, pac.nombre as coordinador,
        case  
            when (select count(*) from participar where matricula = e.matricula) = 0 
            then 'nunca ha participado'
            else 'sin proyecto vigente'
        end as situacion_primordial
    from estudiante as e join persona_acompañamiento as pac   on e.id_coordinador = pac.id_persona_acom
    where e.estatus = 'activo'
    and e.id_coordinador = p_id_coordinador
    and e.matricula not in (
        select par.matricula  
        from participar as par
        join implementar as i on par.id_proyecto = i.id_proyecto
        where i.fecha_fin is null
    )
    order by situacion_primordial desc;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reporte_estudiantes_sin_proyecto_activo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reporte_estudiantes_sin_proyecto_activo`()
BEGIN
  SELECT
    e.matricula,
    e.nombre AS Estudiante,
    pr.nombre_programa AS Programa,
    pac.nombre AS Coordinador,
    COUNT(DISTINCT par.id_proyecto) AS Proyectos_Historicos,
    IFNULL(MAX(me.fecha_mentoria), 'Sin mentoría') AS Ultima_Mentoria,
    CASE
      WHEN COUNT(DISTINCT par.id_proyecto) = 0
        THEN 'Sin historial de proyecto'
      ELSE 'Sin proyecto activo'
    END AS Situacion
  FROM estudiante AS e
  JOIN programa AS pr
    ON e.id_programa = pr.id_programa
  JOIN `persona_acompañamiento` AS pac
    ON e.id_coordinador = pac.id_persona_acom
  LEFT JOIN participar AS par
    ON e.matricula = par.matricula
  LEFT JOIN mentoria AS me
    ON e.matricula = me.matricula
  WHERE e.estatus = 'Activo'
    AND NOT EXISTS (
      SELECT 1
      FROM participar AS par_activo
      JOIN implementar AS i_activo
        ON par_activo.id_proyecto = i_activo.id_proyecto
      WHERE par_activo.matricula = e.matricula
        AND i_activo.fecha_fin IS NULL
    )
  GROUP BY
    e.matricula,
    e.nombre,
    pr.nombre_programa,
    pac.nombre
  ORDER BY
    Situacion,
    pac.nombre,
    pr.nombre_programa,
    e.nombre;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reporte_impacto_comunidad_especifica` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reporte_impacto_comunidad_especifica`(IN p_id_comunidad INT)
BEGIN
    SELECT 
        com.nombre_comunidad AS comunidad,
        COUNT(DISTINCT prg.id_programa) AS variedad_de_programas
    FROM comunidad AS com
    LEFT JOIN implementar AS i ON com.id_comunidad = i.id_comunidad
		JOIN proyecto AS pro ON i.id_proyecto = pro.id_proyecto
			JOIN participar AS par ON pro.id_proyecto = par.id_proyecto
				JOIN estudiante AS est ON par.matricula = est.matricula
					LEFT JOIN programa AS prg ON est.id_programa = prg.id_programa
    WHERE com.id_comunidad = p_id_comunidad
    GROUP BY com.id_comunidad, com.nombre_comunidad;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reporte_presencia_territorial` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reporte_presencia_territorial`(
  IN p_fecha_inicio DATE,
  IN p_fecha_fin DATE
)
BEGIN
  SELECT
    c.municipio,
    COUNT(DISTINCT i.id_proyecto) AS total_proyectos,
    COUNT(DISTINCT i.id_comunidad) AS total_comunidades,
    GROUP_CONCAT(
      DISTINCT p.nombre_proyecto
      ORDER BY p.nombre_proyecto
      SEPARATOR '; '
    ) AS proyectos
  FROM implementar AS i
  JOIN comunidad AS c
    ON i.id_comunidad = c.id_comunidad
  JOIN proyecto AS p
    ON i.id_proyecto = p.id_proyecto
  WHERE i.fecha_inicio BETWEEN p_fecha_inicio AND p_fecha_fin
  GROUP BY c.municipio
  ORDER BY total_proyectos DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reporte_proyectos_baja_participacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reporte_proyectos_baja_participacion`(
    IN limite_min INT,
    IN limite_max INT,
    IN max_participantes INT
)
BEGIN
    SELECT
        p.id_proyecto,
        p.nombre_proyecto AS Proyecto,
        COUNT(DISTINCT par.matricula) AS Estudiantes_Participantes,
        COUNT(DISTINCT i.id_comunidad) AS Comunidades_Atendidas,
        SUM(i.cantidad_beneficiarios) AS Total_Beneficiarios,
        COUNT(DISTINCT ap.id_aliado) AS Aliados_Vinculados,
        CASE
            WHEN COUNT(DISTINCT par.matricula) = 0 THEN 'Sin estudiantes'
            WHEN COUNT(DISTINCT par.matricula) BETWEEN limite_min AND limite_max
                THEN 'Participacion baja'
            ELSE 'Participacion suficiente'
        END AS Nivel_Participacion
    FROM proyecto AS p
    JOIN implementar AS i
        ON p.id_proyecto = i.id_proyecto
    LEFT JOIN participar AS par
        ON p.id_proyecto = par.id_proyecto
    LEFT JOIN apoyar AS ap
        ON p.id_proyecto = ap.id_proyecto
    WHERE i.fecha_fin IS NULL
    GROUP BY
        p.id_proyecto,
        p.nombre_proyecto
    HAVING COUNT(DISTINCT par.matricula) <= max_participantes
    ORDER BY
        Estudiantes_Participantes,
        Total_Beneficiarios DESC,
        Proyecto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_reporte_resumen_implementaciones` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_reporte_resumen_implementaciones`()
BEGIN
  SELECT
    MAX(cantidad_beneficiarios) AS max_beneficiarios,
    MIN(cantidad_beneficiarios) AS min_beneficiarios,
    SUM(cantidad_beneficiarios) AS total_beneficiarios,
    AVG(cantidad_beneficiarios) AS promedio_beneficiarios,
    COUNT(*) AS total_implementaciones
  FROM implementar;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_resumen_implementaciones` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_resumen_implementaciones`(
    IN p_min_beneficiarios INT
)
BEGIN
    SELECT
        p.id_proyecto AS `Id Proyecto`,
        p.nombre_proyecto AS Nombre,
        MAX(i.cantidad_beneficiarios) AS max_beneficiarios,
        MIN(i.cantidad_beneficiarios) AS min_beneficiarios,
        SUM(i.cantidad_beneficiarios) AS total_beneficiarios,
        ROUND(AVG(i.cantidad_beneficiarios), 0) AS promedio_beneficiarios,
        COUNT(*) AS total_implementaciones
    FROM implementar AS i
    INNER JOIN proyecto AS p
        ON i.id_proyecto = p.id_proyecto
    WHERE i.cantidad_beneficiarios >= p_min_beneficiarios
    GROUP BY
        p.id_proyecto,
        p.nombre_proyecto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `estudiante_resumen`
--

/*!50001 DROP VIEW IF EXISTS `estudiante_resumen`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `estudiante_resumen` AS select `e`.`matricula` AS `matricula`,`e`.`nombre` AS `estudiante`,`e`.`estatus` AS `estatus`,`pro`.`nombre_programa` AS `programa`,`pr`.`nombre_proyecto` AS `nombre_proyecto`,count(distinct `p`.`id_proyecto`) AS `proyectos`,count(distinct `m`.`fecha_mentoria`) AS `mentorias`,(case when (count(distinct `p`.`id_proyecto`) = 0) then 'Sin proyecto' when (count(distinct `m`.`fecha_mentoria`) = 0) then 'Sin mentoria' else 'Con seguimiento' end) AS `estado` from ((((`estudiante` `e` join `programa` `pro` on((`e`.`id_programa` = `pro`.`id_programa`))) left join `participar` `p` on(((`e`.`matricula` = `p`.`matricula`) and (`p`.`id_proyecto` is not null)))) left join `proyecto` `pr` on((`p`.`id_proyecto` = `pr`.`id_proyecto`))) left join `mentoria` `m` on(((`e`.`matricula` = `m`.`matricula`) and (`m`.`fecha_mentoria` is not null)))) group by `e`.`matricula`,`e`.`nombre`,`e`.`estatus`,`pro`.`nombre_programa`,`pr`.`nombre_proyecto` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `mentorias_tomadas`
--

/*!50001 DROP VIEW IF EXISTS `mentorias_tomadas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `mentorias_tomadas` AS select `m`.`id_mentor` AS `id_mentor`,`m`.`nombre_mentor` AS `nombre_mentor`,`tm`.`tema_mentoria` AS `tema_mentoria`,`me`.`matricula` AS `alumno`,count(distinct `me`.`fecha_mentoria`) AS `total_mentorias_por_alumno`,min(`me`.`fecha_mentoria`) AS `fecha_inicio`,max(`me`.`fecha_mentoria`) AS `fecha_fin` from ((`mentor` `m` join `mentoria` `me` on((`m`.`id_mentor` = `me`.`id_mentor`))) join `tema_mentoria` `tm` on((`m`.`id_tema` = `tm`.`id_tema`))) group by `m`.`id_mentor`,`m`.`nombre_mentor`,`tm`.`tema_mentoria`,`me`.`matricula` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `proyectos_implementaciones`
--

/*!50001 DROP VIEW IF EXISTS `proyectos_implementaciones`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `proyectos_implementaciones` AS select `p`.`id_proyecto` AS `Id Proyecto`,`p`.`nombre_proyecto` AS `Nombre`,`c`.`nombre_comunidad` AS `Comunidad`,`i`.`fecha_inicio` AS `Fecha Inicio`,`i`.`fecha_fin` AS `Fecha Fin`,`i`.`cantidad_beneficiarios` AS `Beneficiarios`,(case when (`i`.`fecha_fin` is null) then 'Activa' else 'Finalizada' end) AS `estado`,(case when (`i`.`fecha_fin` is not null) then (to_days(`i`.`fecha_fin`) - to_days(`i`.`fecha_inicio`)) else NULL end) AS `Duracion` from ((`proyecto` `p` left join `implementar` `i` on((`p`.`id_proyecto` = `i`.`id_proyecto`))) left join `comunidad` `c` on((`i`.`id_comunidad` = `c`.`id_comunidad`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `proyectos_operativos`
--

/*!50001 DROP VIEW IF EXISTS `proyectos_operativos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `proyectos_operativos` AS select `p`.`nombre_proyecto` AS `Proyecto`,`c`.`nombre_comunidad` AS `Comunidad`,`c`.`municipio` AS `Municipio`,`i`.`fecha_inicio` AS `Fecha_Inicio`,`i`.`fecha_fin` AS `Fecha_Fin`,`i`.`cantidad_beneficiarios` AS `Beneficiarios`,count(distinct `par`.`matricula`) AS `Estudiantes_Participantes`,count(distinct `ap`.`id_aliado`) AS `Aliados_Vinculados`,count(distinct `me`.`matricula`) AS `Estudiantes_Con_Mentoria`,count(distinct concat(`me`.`matricula`,'|',`me`.`id_mentor`,'|',`me`.`fecha_mentoria`)) AS `Mentorias_Registradas`,max(`me`.`fecha_mentoria`) AS `Ultima_Mentoria`,(case when (`i`.`fecha_fin` is null) then 'Activo' else 'Finalizado' end) AS `Estatus_Proyecto`,(case when ((`i`.`fecha_fin` is null) and (count(distinct `par`.`matricula`) <= 2)) then 'Requiere estudiantes' when ((`i`.`fecha_fin` is null) and (count(distinct `ap`.`id_aliado`) = 0)) then 'Requiere aliados' when ((`i`.`fecha_fin` is null) and (count(distinct concat(`me`.`matricula`,'|',`me`.`id_mentor`,'|',`me`.`fecha_mentoria`)) = 0)) then 'Requiere mentorias' when ((`i`.`fecha_fin` is not null) and (`i`.`cantidad_beneficiarios` >= 100) and (count(distinct `ap`.`id_aliado`) > 0)) then 'Reactivacion viable' when ((`i`.`fecha_fin` is not null) and (`i`.`cantidad_beneficiarios` >= 100)) then 'Revisar reactivacion por impacto' else 'Seguimiento normal' end) AS `Prioridad_Seguimiento` from (((((`proyecto` `p` join `implementar` `i` on((`p`.`id_proyecto` = `i`.`id_proyecto`))) join `comunidad` `c` on((`i`.`id_comunidad` = `c`.`id_comunidad`))) left join `participar` `par` on((`p`.`id_proyecto` = `par`.`id_proyecto`))) left join `apoyar` `ap` on((`p`.`id_proyecto` = `ap`.`id_proyecto`))) left join `mentoria` `me` on((`p`.`id_proyecto` = `me`.`id_proyecto`))) group by `p`.`nombre_proyecto`,`c`.`nombre_comunidad`,`c`.`municipio`,`i`.`fecha_inicio`,`i`.`fecha_fin`,`i`.`cantidad_beneficiarios` order by (`i`.`fecha_fin` is not null),`i`.`fecha_inicio` desc,`Proyecto`,`c`.`municipio` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `seguimiento_estudiante_proyecto`
--

/*!50001 DROP VIEW IF EXISTS `seguimiento_estudiante_proyecto`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `seguimiento_estudiante_proyecto` AS select `p`.`id_proyecto` AS `id_proyecto`,`e`.`matricula` AS `matricula`,`e`.`estatus` AS `estatus_alumno`,`pr`.`nombre_programa` AS `nombre_programa`,`par`.`rol` AS `rol`,count(distinct `ap`.`id_aliado`) AS `total_aliados`,count(distinct `me`.`fecha_mentoria`) AS `total_mentorias`,ifnull(max(`me`.`fecha_mentoria`),'Sin mentoria') AS `ultima_mentoria`,(case when (count(distinct `me`.`fecha_mentoria`) = 0) then 'Sin actividad' when (count(distinct `me`.`fecha_mentoria`) >= 4) then 'Alto seguimiento' when (count(distinct `me`.`fecha_mentoria`) >= 2) then 'Seguimiento medio' else 'Bajo seguimiento' end) AS `clasificacion_seguimiento`,(case when (count(distinct `ap`.`id_aliado`) = 0) then 'Requiere aliados' when (count(distinct `me`.`fecha_mentoria`) = 0) then 'Requiere mentoria' when (`e`.`estatus` <> 'Activo') then 'Alumno inactivo' else 'Seguimiento normal' end) AS `diagnostico_operativo` from (((((`proyecto` `p` join `participar` `par` on((`p`.`id_proyecto` = `par`.`id_proyecto`))) join `estudiante` `e` on((`par`.`matricula` = `e`.`matricula`))) join `programa` `pr` on((`e`.`id_programa` = `pr`.`id_programa`))) left join `apoyar` `ap` on((`p`.`id_proyecto` = `ap`.`id_proyecto`))) left join `mentoria` `me` on(((`p`.`id_proyecto` = `me`.`id_proyecto`) and (`e`.`matricula` = `me`.`matricula`)))) group by `p`.`id_proyecto`,`e`.`matricula`,`e`.`estatus`,`pr`.`nombre_programa`,`par`.`rol` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_mentorias_operativas`
--

/*!50001 DROP VIEW IF EXISTS `vw_mentorias_operativas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_mentorias_operativas` AS select `m`.`id_mentor` AS `id_mentor`,`m`.`nombre_mentor` AS `nombre_mentor`,`tm`.`tema_mentoria` AS `tema_mentoria`,count(0) AS `total_mentorias`,count(distinct `me`.`matricula`) AS `estudiantes_atendidos` from ((`mentor` `m` join `tema_mentoria` `tm` on((`m`.`id_tema` = `tm`.`id_tema`))) join `mentoria` `me` on((`m`.`id_mentor` = `me`.`id_mentor`))) group by `m`.`id_mentor`,`m`.`nombre_mentor`,`tm`.`tema_mentoria` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_proyectos_operativos`
--

/*!50001 DROP VIEW IF EXISTS `vw_proyectos_operativos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_proyectos_operativos` AS select `p`.`nombre_proyecto` AS `Proyecto`,ifnull(`imp`.`comunidades_atendidas`,0) AS `Comunidades_Atendidas`,ifnull(`imp`.`total_beneficiarios`,0) AS `Total_Beneficiarios`,ifnull(`part`.`estudiantes_participantes`,0) AS `Estudiantes_Participantes`,ifnull(`ali`.`aliados_vinculados`,0) AS `Aliados_Vinculados`,ifnull(`men`.`total_mentorias`,0) AS `Total_Mentorias`,`imp`.`fecha_inicio_mas_reciente` AS `Ultima_Implementacion`,(case when (`imp`.`proyecto_activo` = 1) then 'Activo' else 'Finalizado' end) AS `Estatus_Proyecto`,(case when ((`imp`.`proyecto_activo` = 0) and (ifnull(`part`.`estudiantes_participantes`,0) >= 3) and (ifnull(`ali`.`aliados_vinculados`,0) >= 1)) then 'Reactivacion viable' when ((`imp`.`proyecto_activo` = 0) and (ifnull(`imp`.`total_beneficiarios`,0) >= 100)) then 'Revisar reactivacion por impacto' when (`imp`.`proyecto_activo` = 0) then 'Cerrado sin prioridad' when ((`imp`.`proyecto_activo` = 1) and (ifnull(`part`.`estudiantes_participantes`,0) <= 2)) then 'Requiere estudiantes' when ((`imp`.`proyecto_activo` = 1) and (ifnull(`ali`.`aliados_vinculados`,0) = 0)) then 'Requiere aliados' when ((`imp`.`proyecto_activo` = 1) and (ifnull(`men`.`total_mentorias`,0) = 0)) then 'Requiere mentoria' else 'Seguimiento normal' end) AS `Prioridad_Seguimiento` from ((((`proyecto` `p` left join (select `implementar`.`id_proyecto` AS `id_proyecto`,count(distinct `implementar`.`id_comunidad`) AS `comunidades_atendidas`,sum(`implementar`.`cantidad_beneficiarios`) AS `total_beneficiarios`,max(`implementar`.`fecha_inicio`) AS `fecha_inicio_mas_reciente`,max((case when (`implementar`.`fecha_fin` is null) then 1 else 0 end)) AS `proyecto_activo` from `implementar` group by `implementar`.`id_proyecto`) `imp` on((`p`.`id_proyecto` = `imp`.`id_proyecto`))) left join (select `participar`.`id_proyecto` AS `id_proyecto`,count(distinct `participar`.`matricula`) AS `estudiantes_participantes` from `participar` group by `participar`.`id_proyecto`) `part` on((`p`.`id_proyecto` = `part`.`id_proyecto`))) left join (select `apoyar`.`id_proyecto` AS `id_proyecto`,count(distinct `apoyar`.`id_aliado`) AS `aliados_vinculados` from `apoyar` group by `apoyar`.`id_proyecto`) `ali` on((`p`.`id_proyecto` = `ali`.`id_proyecto`))) left join (select `mentoria`.`id_proyecto` AS `id_proyecto`,count(0) AS `total_mentorias` from `mentoria` group by `mentoria`.`id_proyecto`) `men` on((`p`.`id_proyecto` = `men`.`id_proyecto`))) where ((`imp`.`id_proyecto` is not null) or (`part`.`id_proyecto` is not null) or (`ali`.`id_proyecto` is not null) or (`men`.`id_proyecto` is not null)) order by (`imp`.`fecha_inicio_mas_reciente` is null),`imp`.`fecha_inicio_mas_reciente` desc,`p`.`nombre_proyecto` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_territorio_impacto`
--

/*!50001 DROP VIEW IF EXISTS `vw_territorio_impacto`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_territorio_impacto` AS select `c`.`municipio` AS `municipio`,count(distinct `c`.`id_comunidad`) AS `comunidades_atendidas`,count(distinct `i`.`id_proyecto`) AS `total_proyectos`,sum(`i`.`cantidad_beneficiarios`) AS `total_beneficiarios`,ifnull(`ali`.`total_aliados`,0) AS `total_aliados`,avg(`i`.`cantidad_beneficiarios`) AS `promedio_beneficiarios_por_proyecto`,(sum(`i`.`cantidad_beneficiarios`) / count(distinct `c`.`id_comunidad`)) AS `beneficiarios_por_comunidad`,(count(distinct `i`.`id_proyecto`) / count(distinct `c`.`id_comunidad`)) AS `proyectos_por_comunidad`,min(`i`.`fecha_inicio`) AS `fecha_inicio`,max(`i`.`fecha_inicio`) AS `fecha_fin` from ((`comunidad` `c` join `implementar` `i` on((`c`.`id_comunidad` = `i`.`id_comunidad`))) left join (select `c2`.`municipio` AS `municipio`,count(distinct `ap`.`id_aliado`) AS `total_aliados` from ((`comunidad` `c2` join `implementar` `i2` on((`c2`.`id_comunidad` = `i2`.`id_comunidad`))) join `apoyar` `ap` on((`i2`.`id_proyecto` = `ap`.`id_proyecto`))) group by `c2`.`municipio`) `ali` on((`c`.`municipio` = `ali`.`municipio`))) group by `c`.`municipio` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-16 17:47:21
