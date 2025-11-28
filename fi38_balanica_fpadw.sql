/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.13-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: fi38_balanica_fpadw
-- ------------------------------------------------------
-- Server version	10.11.13-MariaDB-0ubuntu0.24.04.1

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
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `fk_order_items_order` (`order_id`),
  KEY `fk_order_items_product` (`product_id`),
  CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_order_items_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES
(1,1,2,1);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `fk_orders_user` (`user_id`),
  CONSTRAINT `fk_orders_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES
(1,3,'2025-11-21 14:05:45');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `short_description` varchar(500) NOT NULL,
  `long_description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES
(1,'Kaffee Premium','Aromatischer Bohnenkaffee','Aromatischer Bohnenkaffee aus nachhaltigem, fair zertifiziertem Anbau. Mit einer milden Note und perfekter Röstung.',9.99,'images/coffee.jpg','2025-11-21 08:57:13','product_1.jpg'),
(2,'Grüner Tee Sencha','Feiner japanischer Grüntee','Hochwertiger Sencha-Grüntee mit leicht süßlichem Aroma und frischem Duft. Ideal für Entspannung und Energie.',4.50,'images/green-tea.jpg','2025-11-21 08:57:13','product_2.jpg'),
(3,'Kakao Classic','Kakaogetränk für jede Tageszeit','Cremiges Kakaogetränk aus hochwertigen Kakaobohnen. Perfekt für kalte Tage oder zum Backen.',3.90,'images/cocoa.jpg','2025-11-21 08:57:13','product_3.jpg'),
(4,'Schwarzer Tee Assam','Starker Schwarztee','Traditioneller Schwarztee aus Assam mit kräftigem Aroma und tief roter Tassenfarbe. Besonders gut zum Frühstück.',5.20,'images/assam.jpg','2025-11-21 08:57:13','product_4.jpg'),
(5,'Kräutertee Mix','Milder Kräutertee','Eine Mischung aus Kamille, Zitronenmelisse und Minze. Wohltuend für Körper und Geist.',3.40,'images/herbal.jpg','2025-11-21 08:57:13','product_5.jpg'),
(6,'Matcha Premium','Japanischer Matcha','Fein vermahlenes Grünteepulver aus Japan, reich an Antioxidantien, ideal für Matcha Latte und Zeremonien.',14.90,'images/matcha.jpg','2025-11-21 08:57:13','product_6.jpg'),
(7,'Ingwer-Zitrone Tee','Scharf und frisch','Eine belebende Teemischung aus Ingwer, Zitronenschale und natürlichem Aroma. Perfekt zur Stärkung des Immunsystems.',4.80,'images/ginger-lemon.jpg','2025-11-21 08:57:13','product_7.jpg'),
(8,'Schokokekse','Knusprige Kekse','Hausgemachte Schokokekse mit dunkler Schokolade und knuspriger Textur. Perfekt zu Kaffee.',2.99,'images/cookies.jpg','2025-11-21 08:57:13','product_8.jpg'),
(9,'Bio Honig','Naturreiner Honig','Biologisch zertifizierter Blütenhonig, kaltgeschleudert, aus regionaler Imkerei. Cremig und aromatisch.',6.99,'images/honey.jpg','2025-11-21 08:57:13','product_9.jpg'),
(10,'Energy Tea Boost','Vitalisierender Energietee','Grüntee mit Guarana und Zitronengras für einen natürlichen Energieboost ohne Zucker.',5.70,'images/energy-tea.jpg','2025-11-21 08:57:13','product_10.jpg');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES
(1,'lorena@test.com','$2b$10$LP.pfZ.uBWFnZ44NV0xbwOgiytYeVftQFLRYSRgkjMNvrkyBH/Jz.','2025-11-21 09:38:33'),
(2,'test@test.com','$2b$10$dSDl4LwuPPv6edFUk12hiuGl/VszrLaEiDvVC6eH2NMMhw75iG1Fi','2025-11-21 10:34:30'),
(3,'test3@test.com','$2b$10$fqz62LCqd3LcoBnuyeXYTuT3I0/5ZNOvUGGYNA3kZa0Fd1L4ELbDK','2025-11-21 10:47:17'),
(4,'test1@test.com','$2b$10$xOJWppV25.T37Yhe0EKu9ey2KURW3lRzyG8hkEBxPha5mWlpoJ4kW','2025-11-21 11:20:42');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-26 13:30:33
