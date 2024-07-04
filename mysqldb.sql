-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: mysqldb
-- ------------------------------------------------------
-- Server version	8.0.35

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

--
-- Table structure for table `account_account`
--

DROP TABLE IF EXISTS `account_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_account` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone_number` varchar(50) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `last_login` datetime(6) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_superadmin` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_account`
--

LOCK TABLES `account_account` WRITE;
/*!40000 ALTER TABLE `account_account` DISABLE KEYS */;
INSERT INTO `account_account` VALUES (1,'pbkdf2_sha256$720000$QJeOoQIrrm9qgkvMPR7JLx$Ww2UBAzfHcJFUSjzZrYkNgcyKyY9kCvVIgvFLS5QP2s=','Shop Almahdi','Service','Shop Almhadi Service','shopalmahdiservice@gmail.com','782235087','2024-04-30 13:16:38.375666','2024-05-01 11:00:03.635937',1,1,1,1),(12,'pbkdf2_sha256$720000$ConeIKpDVuyyHe6bld2dKQ$abB3TtiiPWcBjG5qkdUPMde7qBU8sjWAi1yGyn30KoM=','','','Sadibou','senxibaar220@gmail.com','','2024-05-01 12:13:28.014654','2024-05-01 12:13:28.014654',0,0,0,0);
/*!40000 ALTER TABLE `account_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_userprofile`
--

DROP TABLE IF EXISTS `account_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account_userprofile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `adress_line_1` varchar(100) NOT NULL,
  `adress_line_2` varchar(100) NOT NULL,
  `profile_picture` varchar(100) NOT NULL,
  `city` varchar(20) NOT NULL,
  `state` varchar(20) NOT NULL,
  `country` varchar(20) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `account_userprofile_user_id_5afa3c7a_fk_account_account_id` FOREIGN KEY (`user_id`) REFERENCES `account_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_userprofile`
--

LOCK TABLES `account_userprofile` WRITE;
/*!40000 ALTER TABLE `account_userprofile` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_honeypot_loginattempt`
--

DROP TABLE IF EXISTS `admin_honeypot_loginattempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_honeypot_loginattempt` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `ip_address` char(39) DEFAULT NULL,
  `session_key` varchar(50) DEFAULT NULL,
  `user_agent` longtext,
  `timestamp` datetime(6) NOT NULL,
  `path` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_honeypot_loginattempt`
--

LOCK TABLES `admin_honeypot_loginattempt` WRITE;
/*!40000 ALTER TABLE `admin_honeypot_loginattempt` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_honeypot_loginattempt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add category',6,'add_category'),(22,'Can change category',6,'change_category'),(23,'Can delete category',6,'delete_category'),(24,'Can view category',6,'view_category'),(25,'Can add account',7,'add_account'),(26,'Can change account',7,'change_account'),(27,'Can delete account',7,'delete_account'),(28,'Can view account',7,'view_account'),(29,'Can add user profile',8,'add_userprofile'),(30,'Can change user profile',8,'change_userprofile'),(31,'Can delete user profile',8,'delete_userprofile'),(32,'Can view user profile',8,'view_userprofile'),(33,'Can add product',9,'add_product'),(34,'Can change product',9,'change_product'),(35,'Can delete product',9,'delete_product'),(36,'Can view product',9,'view_product'),(37,'Can add productgallery',10,'add_productgallery'),(38,'Can change productgallery',10,'change_productgallery'),(39,'Can delete productgallery',10,'delete_productgallery'),(40,'Can view productgallery',10,'view_productgallery'),(41,'Can add review rating',11,'add_reviewrating'),(42,'Can change review rating',11,'change_reviewrating'),(43,'Can delete review rating',11,'delete_reviewrating'),(44,'Can view review rating',11,'view_reviewrating'),(45,'Can add variation',12,'add_variation'),(46,'Can change variation',12,'change_variation'),(47,'Can delete variation',12,'delete_variation'),(48,'Can view variation',12,'view_variation'),(49,'Can add cart',13,'add_cart'),(50,'Can change cart',13,'change_cart'),(51,'Can delete cart',13,'delete_cart'),(52,'Can view cart',13,'view_cart'),(53,'Can add cart item',14,'add_cartitem'),(54,'Can change cart item',14,'change_cartitem'),(55,'Can delete cart item',14,'delete_cartitem'),(56,'Can view cart item',14,'view_cartitem'),(57,'Can add order',15,'add_order'),(58,'Can change order',15,'change_order'),(59,'Can delete order',15,'delete_order'),(60,'Can view order',15,'view_order'),(61,'Can add payment',16,'add_payment'),(62,'Can change payment',16,'change_payment'),(63,'Can delete payment',16,'delete_payment'),(64,'Can view payment',16,'view_payment'),(65,'Can add order product',17,'add_orderproduct'),(66,'Can change order product',17,'change_orderproduct'),(67,'Can delete order product',17,'delete_orderproduct'),(68,'Can view order product',17,'view_orderproduct'),(69,'Can add login attempt',18,'add_loginattempt'),(70,'Can change login attempt',18,'change_loginattempt'),(71,'Can delete login attempt',18,'delete_loginattempt'),(72,'Can view login attempt',18,'view_loginattempt'),(73,'Can add Token',19,'add_token'),(74,'Can change Token',19,'change_token'),(75,'Can delete Token',19,'delete_token'),(76,'Can view Token',19,'view_token'),(77,'Can add token',20,'add_tokenproxy'),(78,'Can change token',20,'change_tokenproxy'),(79,'Can delete token',20,'delete_tokenproxy'),(80,'Can view token',20,'view_tokenproxy');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_account_account_id` FOREIGN KEY (`user_id`) REFERENCES `account_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
INSERT INTO `authtoken_token` VALUES ('18b2403ce00157c92231388dd9540321f33dac9e','2024-05-01 12:13:28.229645',12);
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cart_id` varchar(100) NOT NULL,
  `date_added` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts_cartitem`
--

DROP TABLE IF EXISTS `carts_cartitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carts_cartitem` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `cart_id` bigint DEFAULT NULL,
  `product_id` bigint NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carts_cartitem_cart_id_9cb0a756_fk_Cart_id` (`cart_id`),
  KEY `carts_cartitem_product_id_acd010e4_fk_store_product_id` (`product_id`),
  KEY `carts_cartitem_user_id_4d21e0d9_fk_account_account_id` (`user_id`),
  CONSTRAINT `carts_cartitem_cart_id_9cb0a756_fk_Cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`),
  CONSTRAINT `carts_cartitem_product_id_acd010e4_fk_store_product_id` FOREIGN KEY (`product_id`) REFERENCES `store_product` (`id`),
  CONSTRAINT `carts_cartitem_user_id_4d21e0d9_fk_account_account_id` FOREIGN KEY (`user_id`) REFERENCES `account_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts_cartitem`
--

LOCK TABLES `carts_cartitem` WRITE;
/*!40000 ALTER TABLE `carts_cartitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `carts_cartitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts_cartitem_variations`
--

DROP TABLE IF EXISTS `carts_cartitem_variations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carts_cartitem_variations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cartitem_id` bigint NOT NULL,
  `variation_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `carts_cartitem_variations_cartitem_id_variation_id_5f8efaf5_uniq` (`cartitem_id`,`variation_id`),
  KEY `carts_cartitem_varia_variation_id_ef9f9ee3_fk_store_var` (`variation_id`),
  CONSTRAINT `carts_cartitem_varia_cartitem_id_8be23372_fk_carts_car` FOREIGN KEY (`cartitem_id`) REFERENCES `carts_cartitem` (`id`),
  CONSTRAINT `carts_cartitem_varia_variation_id_ef9f9ee3_fk_store_var` FOREIGN KEY (`variation_id`) REFERENCES `store_variation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts_cartitem_variations`
--

LOCK TABLES `carts_cartitem_variations` WRITE;
/*!40000 ALTER TABLE `carts_cartitem_variations` DISABLE KEYS */;
/*!40000 ALTER TABLE `carts_cartitem_variations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_category`
--

DROP TABLE IF EXISTS `category_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `cat_image` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_name` (`category_name`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_category`
--

LOCK TABLES `category_category` WRITE;
/*!40000 ALTER TABLE `category_category` DISABLE KEYS */;
INSERT INTO `category_category` VALUES (1,'Shoes Class','shoes-class','Shoes Class','photos/categories/Capture1.png'),(2,'Talon','talon','Talon','photos/categories/Captured2.png'),(3,'Ceinture','ceinture','Ceinture','photos/categories/Capturec1.jpg'),(4,'T shert','t-shert','T shert','photos/categories/Capturet1.jpg'),(5,'Shoes Basquet','shoes-basquet','Shoes Basquet','photos/categories/adidas1.jpg'),(6,'Sandale cuir','sandale-cuir','Sandale cuir','photos/categories/ArtisanatS1.jpg'),(7,'Montre','montre','Montre','photos/categories/WATCH1.jpg'),(8,'Chemise','chemise','Chemise','photos/categories/Capture_ch.png'),(9,'Casquete','casquete','Casquete','photos/categories/Moderne_P.png'),(10,'Lacoste','lacoste','Lacoste','photos/categories/Lacoste.jpg'),(11,'Sac','sac','Sac','photos/categories/SasEnfant.jpg'),(12,'Super cent','super-cent','Super cent','photos/categories/kisspngjeanss.jpg');
/*!40000 ALTER TABLE `category_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_account_account_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_account_account_id` FOREIGN KEY (`user_id`) REFERENCES `account_account` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-04-30 13:33:08.556716','1','shopalmahdiservice@gmail.com',2,'[{\"changed\": {\"fields\": [\"Email address\", \"Phone number\"]}}]',7,1),(2,'2024-04-30 17:56:44.394054','6','senxibaar220@gmail.com',3,'',7,1),(3,'2024-04-30 17:56:44.630708','5','cheikhdioufO35@gmail.com',3,'',7,1),(4,'2024-04-30 17:56:45.086222','4','cheikhdiouf35@gmail.com',3,'',7,1),(5,'2024-04-30 17:56:45.460302','3','exemple1@gmail.com',3,'',7,1),(6,'2024-04-30 17:56:46.005081','2','exemple@gmail.com',3,'',7,1),(7,'2024-05-01 11:01:24.904477','8','cheikhdiouf035@gmail.com',3,'',7,1),(8,'2024-05-01 11:01:25.114475','7','senxibaar220@gmail.com',3,'',7,1),(9,'2024-05-01 11:32:41.679388','10','senxibaar220@gmail.com',3,'',7,1),(10,'2024-05-01 11:32:41.799389','9','cheikhdiouf035@gmail.com',3,'',7,1),(11,'2024-05-01 12:13:05.320822','11','senxibaar220@gmail.com',3,'',7,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (7,'account','account'),(8,'account','userprofile'),(1,'admin','logentry'),(18,'admin_honeypot','loginattempt'),(3,'auth','group'),(2,'auth','permission'),(19,'authtoken','token'),(20,'authtoken','tokenproxy'),(13,'carts','cart'),(14,'carts','cartitem'),(6,'category','category'),(4,'contenttypes','contenttype'),(15,'orders','order'),(17,'orders','orderproduct'),(16,'orders','payment'),(5,'sessions','session'),(9,'store','product'),(10,'store','productgallery'),(11,'store','reviewrating'),(12,'store','variation');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'account','0001_initial','2024-04-30 12:19:47.917447'),(2,'contenttypes','0001_initial','2024-04-30 12:19:49.284238'),(3,'admin','0001_initial','2024-04-30 12:19:53.143748'),(4,'admin','0002_logentry_remove_auto_add','2024-04-30 12:19:53.238036'),(5,'admin','0003_logentry_add_action_flag_choices','2024-04-30 12:19:53.316575'),(6,'admin_honeypot','0001_initial','2024-04-30 12:19:54.257826'),(7,'admin_honeypot','0002_auto_20160208_0854','2024-04-30 12:19:55.733368'),(8,'admin_honeypot','0003_alter_loginattempt_id','2024-04-30 12:19:56.897886'),(9,'contenttypes','0002_remove_content_type_name','2024-04-30 12:19:58.770734'),(10,'auth','0001_initial','2024-04-30 12:20:09.468444'),(11,'auth','0002_alter_permission_name_max_length','2024-04-30 12:20:11.413427'),(12,'auth','0003_alter_user_email_max_length','2024-04-30 12:20:11.507610'),(13,'auth','0004_alter_user_username_opts','2024-04-30 12:20:11.617330'),(14,'auth','0005_alter_user_last_login_null','2024-04-30 12:20:11.727459'),(15,'auth','0006_require_contenttypes_0002','2024-04-30 12:20:11.853146'),(16,'auth','0007_alter_validators_add_error_messages','2024-04-30 12:20:11.947735'),(17,'auth','0008_alter_user_username_max_length','2024-04-30 12:20:12.309185'),(18,'auth','0009_alter_user_last_name_max_length','2024-04-30 12:20:12.435018'),(19,'auth','0010_alter_group_name_max_length','2024-04-30 12:20:12.670826'),(20,'auth','0011_update_proxy_permissions','2024-04-30 12:20:12.749408'),(21,'auth','0012_alter_user_first_name_max_length','2024-04-30 12:20:12.889636'),(22,'category','0001_initial','2024-04-30 12:20:14.238993'),(23,'store','0001_initial','2024-04-30 12:20:29.182103'),(24,'carts','0001_initial','2024-04-30 12:20:45.039882'),(25,'orders','0001_initial','2024-04-30 12:21:10.575639'),(26,'sessions','0001_initial','2024-04-30 12:21:12.067427'),(27,'authtoken','0001_initial','2024-04-30 14:24:38.048148'),(28,'authtoken','0002_auto_20160226_1747','2024-04-30 14:24:38.346786'),(29,'authtoken','0003_tokenproxy','2024-04-30 14:24:38.692431');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('d3udckxaqk42dn6dht3upu7h34yztqwf','e30:1s2Cu0:CBmzyj512AmswIxow5xOygmbv8Pxpe6UAbX7Ue2E-sM','2024-05-15 16:33:52.960584');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_order`
--

DROP TABLE IF EXISTS `orders_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_number` int DEFAULT NULL,
  `first_name` varchar(70) NOT NULL,
  `last_name` varchar(70) DEFAULT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(70) NOT NULL,
  `address_line_1` varchar(70) NOT NULL,
  `address_line_2` varchar(70) NOT NULL,
  `country` varchar(70) NOT NULL,
  `state` varchar(70) NOT NULL,
  `city` varchar(70) NOT NULL,
  `order_note` varchar(200) NOT NULL,
  `order_total` double NOT NULL,
  `tax` double NOT NULL,
  `status` varchar(20) NOT NULL,
  `ip` varchar(30) NOT NULL,
  `is_ordered` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `payment_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_order_payment_id_46928ccc_fk_orders_payment_id` (`payment_id`),
  KEY `orders_order_user_id_e9b59eb1_fk_account_account_id` (`user_id`),
  CONSTRAINT `orders_order_payment_id_46928ccc_fk_orders_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `orders_payment` (`id`),
  CONSTRAINT `orders_order_user_id_e9b59eb1_fk_account_account_id` FOREIGN KEY (`user_id`) REFERENCES `account_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_order`
--

LOCK TABLES `orders_order` WRITE;
/*!40000 ALTER TABLE `orders_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_orderproduct`
--

DROP TABLE IF EXISTS `orders_orderproduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_orderproduct` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `product_price` double NOT NULL,
  `ordered` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `payment_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_orderproduct_order_id_5022a3e2_fk_orders_order_id` (`order_id`),
  KEY `orders_orderproduct_product_id_4d6ac024_fk_store_product_id` (`product_id`),
  KEY `orders_orderproduct_user_id_1e7a7ab7_fk_account_account_id` (`user_id`),
  KEY `orders_orderproduct_payment_id_492ed997_fk_orders_payment_id` (`payment_id`),
  CONSTRAINT `orders_orderproduct_order_id_5022a3e2_fk_orders_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders_order` (`id`),
  CONSTRAINT `orders_orderproduct_payment_id_492ed997_fk_orders_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `orders_payment` (`id`),
  CONSTRAINT `orders_orderproduct_product_id_4d6ac024_fk_store_product_id` FOREIGN KEY (`product_id`) REFERENCES `store_product` (`id`),
  CONSTRAINT `orders_orderproduct_user_id_1e7a7ab7_fk_account_account_id` FOREIGN KEY (`user_id`) REFERENCES `account_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_orderproduct`
--

LOCK TABLES `orders_orderproduct` WRITE;
/*!40000 ALTER TABLE `orders_orderproduct` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_orderproduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_orderproduct_variations`
--

DROP TABLE IF EXISTS `orders_orderproduct_variations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_orderproduct_variations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `orderproduct_id` bigint NOT NULL,
  `variation_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_orderproduct_vari_orderproduct_id_variatio_8c028ee7_uniq` (`orderproduct_id`,`variation_id`),
  KEY `orders_orderproduct__variation_id_5dfd0e51_fk_store_var` (`variation_id`),
  CONSTRAINT `orders_orderproduct__orderproduct_id_0f116a3b_fk_orders_or` FOREIGN KEY (`orderproduct_id`) REFERENCES `orders_orderproduct` (`id`),
  CONSTRAINT `orders_orderproduct__variation_id_5dfd0e51_fk_store_var` FOREIGN KEY (`variation_id`) REFERENCES `store_variation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_orderproduct_variations`
--

LOCK TABLES `orders_orderproduct_variations` WRITE;
/*!40000 ALTER TABLE `orders_orderproduct_variations` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_orderproduct_variations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_payment`
--

DROP TABLE IF EXISTS `orders_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_payment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `payment_id` varchar(100) NOT NULL,
  `payment_method` varchar(100) NOT NULL,
  `amount_paid` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_payment_user_id_cfa9f321_fk_account_account_id` (`user_id`),
  CONSTRAINT `orders_payment_user_id_cfa9f321_fk_account_account_id` FOREIGN KEY (`user_id`) REFERENCES `account_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_payment`
--

LOCK TABLES `orders_payment` WRITE;
/*!40000 ALTER TABLE `orders_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_product`
--

DROP TABLE IF EXISTS `store_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `product_name` varchar(200) NOT NULL,
  `slug` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `price` int NOT NULL,
  `images` varchar(100) NOT NULL,
  `stock` int NOT NULL,
  `is_available` tinyint(1) NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `modified_date` date NOT NULL,
  `category_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_name` (`product_name`),
  UNIQUE KEY `slug` (`slug`),
  KEY `store_product_category_id_574bae65_fk_category_category_id` (`category_id`),
  CONSTRAINT `store_product_category_id_574bae65_fk_category_category_id` FOREIGN KEY (`category_id`) REFERENCES `category_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_product`
--

LOCK TABLES `store_product` WRITE;
/*!40000 ALTER TABLE `store_product` DISABLE KEYS */;
INSERT INTO `store_product` VALUES (1,'Choes de sport','choes-de-sport','Chemise pour homme - Coupe classique Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. chemise',5000,'photo/produts/chaussures2.jpg',99,1,'2023-12-18 19:25:01.960862','2024-01-13',5),(2,'Chaussure haute de gamme','chaussure-haute-de-gamme','Chemise pour homme Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. chemise',25000,'photo/produts/Capture3.png',95,1,'2023-12-18 19:26:07.329740','2024-01-13',1),(3,'Chaussures pour un mariage','chaussures-pour-un-mariage','Chaussures pour un mariage Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Shoes Class',5000,'photo/produts/chaussures_hommes.jpg',97,1,'2023-12-18 19:27:20.545454','2024-01-13',1),(4,'chaussures hommes haut de gamme','chaussures-hommes-haut-de-gamme','chaussures hommes haut de gamme Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Shoes class',25000,'photo/produts/Capture_class.png',100,1,'2023-12-18 19:29:13.116728','2024-01-13',1),(5,'Chaussure de running Marine','chaussure-de-running-marine','Chaussure de running Marine Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Shoes Basquet',12000,'photo/produts/Chaussure_de_running.jpg',100,1,'2023-12-18 19:30:51.130267','2024-01-13',5),(6,'BOOTS SANTONI CARTER','boots-santoni-carter','BOOTS SANTONI CARTER Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Shoes Class',30000,'photo/produts/santonileather.jpg',91,1,'2023-12-18 19:32:29.630822','2024-01-23',1),(7,'Chaussures adidas','chaussures-adidas','Chaussures adidas Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Shoes Basquet',13000,'photo/produts/ChaussuresMarine.jpg',100,1,'2023-12-18 19:36:38.711954','2024-01-13',5),(8,'Sandales cuir homme artisanales','sandales-cuir-homme-artisanales','Sandales cuir homme artisanales Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Sandale cuir',100,'photo/produts/Artisanat_Maroc.jpg',100,1,'2023-12-18 19:37:55.099588','2024-01-13',6),(9,'Mode homme sandale en cuir','mode-homme-sandale-en-cuir','Mode homme sandale en cuir Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Sandale cuir',100,'photo/produts/ArtisanatS1.jpg',100,1,'2023-12-18 19:39:29.041544','2024-01-13',6),(10,'sandales coups de c?ur','sandales-coups-de-cur','sandales coups de c?ur Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Sandale cuir',11000,'photo/produts/BONNEGUEULE.jpg',100,1,'2023-12-18 19:41:09.004276','2024-01-13',6),(11,'sandales en cuir Zeus','sandales-en-cuir-zeus','sandales en cuir Zeus Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Sandale cuir',11000,'photo/produts/Des_sandales_en.jpg',100,1,'2023-12-18 19:42:44.715564','2024-01-13',6),(12,'sandales cuir bio','sandales-cuir-bio','sandales cuir bio Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Sandale cuir',12000,'photo/produts/Les_5_sandales.jpg',100,1,'2023-12-18 19:43:57.622675','2024-01-13',6),(13,'sandale Artisanat Maroc','sandale-artisanat-maroc','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Sandale cuir',10000,'photo/produts/Mode_homme_sandale_en.jpg',100,1,'2023-12-18 19:49:22.411067','2024-01-13',6),(14,'Sandales grises Chaussures Compensées','sandales-grises-chaussures-compensees','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Talon',12000,'photo/produts/Captured2.png',100,1,'2023-12-18 19:51:09.774534','2024-01-13',2),(15,'Sandales grises Chaussures','sandales-grises-chaussures','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Talon',13000,'photo/produts/22.png',100,1,'2023-12-18 19:52:14.880484','2024-01-13',2),(16,'Sandales Cuir N°902  Doré','sandales-cuir-n902-dore','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Talon',10000,'photo/produts/Chaussure_Compensées_Femme.jpg',80,1,'2023-12-18 19:53:38.566295','2024-01-13',2),(17,'Femme Sandales Cuir en Noir','femme-sandales-en-cuir-en-dore','Femme Sandales en Cuir en Doré Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Talon',12000,'photo/produts/Fin_Sandales.jpg',80,1,'2023-12-18 19:54:27.706139','2024-01-13',2),(18,'Sandales & Nu-pieds','sandales-nu-pieds','Sandales & Nu-pieds Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Talon',10000,'photo/produts/images.jpg',100,1,'2023-12-18 19:56:01.800128','2024-01-13',2),(19,'Sandales talon argentin','sandales-talon-noir','Sandales talon noir Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Talon',100,'photo/produts/26.png',100,1,'2023-12-18 19:56:58.011630','2024-01-13',2),(20,'sandale casadei-femme','sandale-casadei-femme','sandale casadei-femme Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Talon',12000,'photo/produts/MARINA_RINALDI.jpg',100,1,'2023-12-18 19:57:59.638992','2024-01-13',2),(21,'Sac titangamingbackpackg','sac-titangamingbackpackg','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Sac',13000,'photo/produts/SACc1.jpg',100,1,'2023-12-18 20:00:08.862712','2024-01-13',11),(22,'sac-vintage-gris','sac-vintage-gris','sac-vintage-gris Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Sac',18000,'photo/produts/PourFemme_SacGrande.jpg',100,1,'2023-12-18 20:02:25.712109','2024-01-13',11),(23,'Sac de voyage','sac-de-voyage','Sac de voyage Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Sac',17000,'photo/produts/Sac_de_voyage.jpg',99,1,'2023-12-18 20:04:03.426027','2024-01-13',11),(24,'Sac À Do Femme','sac-a-do-femme','Sac À Do Femme Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Sac',16500,'photo/produts/sacvintagegris.jpg',100,1,'2023-12-18 20:06:13.938966','2024-01-13',11),(25,'sac-a-dos','sac-a-dos','sac-a-dos Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Sac',15000,'photo/produts/SasEnfant.jpg',100,1,'2023-12-18 20:15:21.065534','2024-01-13',11),(26,'Sac-a-dos-enfant','sac-a-dos-enfant','Sac-a-dos-enfant Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Sac',16000,'photo/produts/Captureecran_sac.png',100,1,'2023-12-18 20:16:15.833620','2024-01-13',11),(27,'Sac Ordinateur','sac-ordinateur','Sac-a-dos-enfant Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Sac',15000,'photo/produts/titangamingbackp.png',100,1,'2023-12-18 20:18:10.313225','2024-01-13',11),(28,'Pantalons Simples Homme','pantalons-simples-homme','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. jeans',5000,'photo/produts/Pantalons_Simples.jpg',100,1,'2023-12-18 20:20:31.645421','2024-01-13',12),(29,'jean homme Super cent','jean-homme-super-cent','Pantalon jean homme Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Super cent',4000,'photo/produts/Capturepantlon.png',100,1,'2023-12-18 20:22:47.307124','2024-01-13',12),(30,'Pantalon Casse Super 100 Homme','pantalon-casse-super-100-homme','Pantalon Casse Super 100 Homme  Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. super-cent',4500,'photo/produts/Generic_Pantalons.jpg',100,1,'2023-12-18 20:23:47.812946','2024-01-13',12),(31,'WATCH APPL E-shop S9','watch-wear-e-shop','WATCH WEAR E-shop Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. WATCH WEAR E-shop  montre',15000,'photo/produts/Buy_Apple_Watch.jpg',100,1,'2023-12-18 20:25:12.952241','2024-01-13',7),(32,'HUAWEI Watch 3 GT','huawei-watch-3-gt','Watch - Apple Store Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Watch - Apple Store Montre',25000,'photo/produts/Capture_montre.png',100,1,'2023-12-19 11:03:16.219728','2024-01-13',7),(33,'PERPETUAL STAINLESS STEEL','perpetual-stainless-steel','PERPETUAL STAINLESS STEEL Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen montre',20000,'photo/produts/Capture_d_montre.png',100,1,'2023-12-19 11:04:58.929771','2024-01-15',7),(34,'Circle Smart Watch','circle-smart-watch','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Circle Smart Watch Montre',20000,'photo/produts/Capturmontre.png',100,1,'2023-12-19 11:07:14.109992','2024-01-15',7),(35,'Buy HUAWEI WATCH GT 3','buy-huawei-watch-gt-3','Buy HUAWEI WATCH GT 3 Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Montre',15000,'photo/produts/Capture2023montre.png',80,1,'2023-12-19 11:08:52.118360','2024-01-15',7),(36,'Apple Watch Series 9','apple-watch-series-9','Apple Watch Series 9 Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book  Apple Watch Series 9 Montre',15000,'photo/produts/e0ef9c.jpg',97,1,'2023-12-19 11:10:03.292898','2024-01-23',7),(37,'Watch - Apple','watch-apple','Apple Watch Series 9 Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book  Apple Watch Series 9 Montre',25000,'photo/produts/WATCH1.jpg',100,1,'2023-12-19 11:11:47.073484','2024-01-15',7),(38,'Apple Watch Ultra 2','apple-watch-ultra-2','Apple Watch Series 9 Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book  Apple Watch Series 9 Montre',35000,'photo/produts/watchcard.jpg',48,1,'2023-12-19 11:13:09.459603','2024-01-15',7),(39,'Lacoste','lacoste','lacoste-noir-et-blanc Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book lacoste noir et blanc',3000,'photo/produts/captureL1.jpg',80,1,'2023-12-19 11:16:57.672095','2024-01-15',7),(40,'LACOSTE  Bleu marine','lacoste-bleu-marine','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book LACOSTE T-shirt Bleu marine',3000,'photo/produts/Capture_chemise_bleu.png',50,1,'2023-12-19 11:18:21.612998','2024-01-15',10),(41,'Lacoste Polo','lacoste-polo','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book  Lacoste Polo KM',5000,'photo/produts/Capture_lacoste_bleu_bleu.png',100,1,'2023-12-19 11:19:31.898628','2023-12-19',10),(42,'Lacoste Navy Cotton','lacoste-navy-cotton','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Lacoste Navy Cotton',3500,'photo/produts/Lacoste.jpg',60,1,'2023-12-19 11:20:40.216575','2024-01-15',10),(43,'Lacoste Blanc','lacoste-blanc','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Lacoste Blanc',4000,'photo/produts/LacosteBlanc.jpg',100,1,'2023-12-19 11:24:59.377736','2024-01-15',10),(44,'Chemises Solid Manches','chemises-solid-manches','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Chemises Solid Manches',4000,'photo/produts/captureC1.jpg',100,1,'2023-12-19 11:26:26.369559','2024-01-15',10),(45,'Lacoste Cotton','lacoste-cotton','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Lacoste Solid Manches',4000,'photo/produts/CaptureL2_fGciOXW.jpg',100,1,'2023-12-19 11:31:09.373227','2024-01-15',10),(46,'LACOSTE  Bleu','lacoste-bleu','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Lacoste Solid Manches',4000,'photo/produts/LACOSTEmarine.jpg',50,1,'2023-12-19 11:32:32.490423','2024-01-15',10),(47,'lacoste vert olive','lacoste-vert-olive','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Lacoste Solid Manches',5000,'photo/produts/LacostePolo.jpg',80,1,'2023-12-19 11:34:12.333848','2024-01-16',10),(48,'Chemise Homme blue','chemise-homme-blue','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Chemise Homme blue',5000,'photo/produts/Capturech.png',97,1,'2023-12-19 11:36:13.319966','2024-01-23',8),(49,'Chemise Homme pret à port','chemise-homme-pret-a-port','Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Chemise Homme rouge',3500,'photo/produts/Captureplus.png',100,1,'2023-12-19 11:43:01.381331','2024-01-16',8),(50,'Chemise Homme','chemise-homme','Chemise Homme Chemise Homme noir Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Chemise Homme noir',4000,'photo/produts/Chemisesimple.png',76,1,'2023-12-19 11:44:34.000630','2024-01-16',8),(51,'Chemise classe','chemise-classe','Chemise classe Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Chemise classe',4500,'photo/produts/CaptureC3.jpg',100,1,'2023-12-19 11:46:16.472091','2024-01-16',8),(52,'Chemise classe homme','chemise-classe-homme','Chemise classe homme Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book chemise',4500,'photo/produts/CaptureC4.png',100,1,'2023-12-19 11:49:25.882821','2024-01-16',8),(53,'Ceinture sans trou cuir','ceinture-sans-trou-cuir','Ceinture sans trou cuir Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen bookboucle automatique à crémaillère 3.5 cm Homme (Taille 46115 cm, J07 Bleu )  Amazon.fr Mode Ceinture sans trou cuir',4500,'photo/produts/Capturec1_0b3b1sW.jpg',85,1,'2023-12-19 11:51:13.294420','2024-01-16',3),(54,'Ceinture  Homme Kezel','ceinture-femme-kezel','Ceinture  Homme Kezel Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Ceinture  Homme Kezel',4000,'photo/produts/CeintureHomme.png',100,1,'2023-12-19 11:55:44.365206','2024-01-16',3),(55,'Ceinture Élastique Femme','ceinture-elastique-femme','Ceinture Élastique Femme Ceinture Élastique Extensible Jupe Robe Décor Ceinture Fine Taille Noire Cinch Belt  Ne Manquez Pas Ces Bonnes Affaires  Temu Belgium Ceinture Élastique Femme',3500,'photo/produts/CaptureCin1.jpg',100,1,'2023-12-19 11:57:50.283556','2024-01-16',3),(56,'Ceinture Femme','ceinture-femme','Ceinture Élastique Femme Ceinture Élastique Extensible Jupe Robe Décor Ceinture Fine Taille Noire Cinch Belt  Ne Manquez Pas Ces Bonnes Affaires  Temu Belgium Ceinture Élastique Femme',3500,'photo/produts/CaptureCin2.jpg',95,1,'2023-12-19 11:59:50.805922','2024-01-16',3),(57,'Ceinture  Femme style','ceinture-femme-style','Ceinture Élastique Femme Ceinture Élastique Extensible Jupe Robe Décor Ceinture Fine Taille Noire Cinch Belt  Ne Manquez Pas Ces Bonnes Affaires  Temu Belgium Ceinture Élastique Femme',4500,'photo/produts/capturecin3.jpeg',87,1,'2023-12-19 12:02:16.650395','2024-01-17',3),(58,'Ceinture Belter Belt','ceinture-belter-belt','Belter Belt Belter Belt Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book ceinture Belter Belt15',4000,'photo/produts/Capturecin4.jpg',90,1,'2023-12-19 12:04:40.318470','2024-01-17',3),(59,'Ceinture Caporale','ceinture-kezel','ceinture Belter Belt Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book ceinture Belter Belt15',4000,'photo/produts/Modern.png',100,1,'2023-12-19 12:06:06.260439','2024-01-17',3),(60,'Casquette Parasol Chapeau','casquette-parasol-chapeau','Casquette Parasol Chapeau Casquette Parasol Chapeau Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Casquette Parasol Chapeau',20000,'photo/produts/CaptureCa1.png',100,1,'2023-12-19 12:08:00.137820','2024-01-17',9),(61,'casquet Floral fleur','casquet-floral-fleur','casquet Floral fleur casquet Floral fleur Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book casquet Floral fleur',3000,'photo/produts/Capturefleur.png',100,1,'2023-12-19 12:11:44.317139','2024-01-17',3),(62,'Casquette basebal','casquette-basebal','Casquette basebal Casquette basebal Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Casquette basebal',3500,'photo/produts/CaptureCa2.png',100,1,'2023-12-19 12:15:46.623334','2024-01-17',9),(63,'Casquette aigle','casquette-aigle','Casquette basebal Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Casquette basebal',4000,'photo/produts/casquetteaigle.jpg',100,1,'2023-12-19 12:17:21.746894','2024-01-17',9),(64,'Casquette star','casquette-star','Casquette star Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book Casquette basebal',4000,'photo/produts/Moderne.png',100,1,'2023-12-19 12:19:00.898178','2024-01-17',9);
/*!40000 ALTER TABLE `store_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_productgallery`
--

DROP TABLE IF EXISTS `store_productgallery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_productgallery` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `store_productgallery_product_id_f2821a49_fk_store_product_id` (`product_id`) USING BTREE,
  CONSTRAINT `store_productgallery_product_id_f2821a49_fk_store_product_id` FOREIGN KEY (`product_id`) REFERENCES `store_product` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=254 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_productgallery`
--

LOCK TABLES `store_productgallery` WRITE;
/*!40000 ALTER TABLE `store_productgallery` DISABLE KEYS */;
INSERT INTO `store_productgallery` VALUES (2,'store/products/Class.jpg',6),(3,'store/products/class2.jpg',6),(4,'store/products/class3.jpg',6),(5,'store/products/1.jpg',1),(6,'store/products/2.jpg',1),(8,'store/products/5.jpg',1),(9,'store/products/6.jpg',1),(11,'store/products/1.png',2),(12,'store/products/2.png',2),(13,'store/products/3.png',2),(14,'store/products/4.png',2),(15,'store/products/1_QzB2U7U.jpg',3),(16,'store/products/2_gOrKAxZ.jpg',3),(17,'store/products/3.jpg',3),(18,'store/products/4_YzE8Kqa.jpg',3),(19,'store/products/1_NdaDXws.jpg',4),(20,'store/products/2_rrIsgbI.jpg',4),(21,'store/products/3_9TaeCVL.jpg',4),(22,'store/products/4_SrMFqhj.jpg',4),(23,'store/products/5_HW4yshl.jpg',4),(24,'store/products/1_4N2JjXf.png',5),(25,'store/products/2_nOt6Ak0.png',5),(26,'store/products/3_jsLdwzX.png',5),(27,'store/products/4_VjJKW4c.png',5),(28,'store/products/1_C0ki7p1.png',7),(29,'store/products/2_6bzFYEw.png',7),(30,'store/products/3_d2rrTLJ.png',7),(31,'store/products/4_162N7FE.png',7),(32,'store/products/1_kSBH50W.png',8),(33,'store/products/2_NTSg3oZ.png',8),(34,'store/products/3_U6LpSVo.png',8),(35,'store/products/1_727pTLG.png',9),(36,'store/products/2_KVYHlrw.png',9),(37,'store/products/4_OlEPfzh.jpg',9),(38,'store/products/1_uZVU3Gg.png',10),(39,'store/products/3_uA9EJHH.png',10),(40,'store/products/1_NUStBKd.jpg',11),(41,'store/products/2_V1r1hnw.jpg',11),(42,'store/products/3_GBCaEju.jpg',11),(43,'store/products/4_y6kiJSI.jpg',11),(44,'store/products/11.jpg',12),(45,'store/products/12.png',12),(46,'store/products/13.png',12),(47,'store/products/14.png',12),(48,'store/products/15.png',13),(49,'store/products/16.png',13),(50,'store/products/17.png',14),(51,'store/products/18.png',14),(52,'store/products/19.png',14),(53,'store/products/20.png',14),(54,'store/products/21.png',15),(55,'store/products/22.png',15),(56,'store/products/23.png',15),(57,'store/products/24.png',15),(58,'store/products/25.png',19),(59,'store/products/27.png',19),(60,'store/products/28.png',19),(61,'store/products/29.jpg',16),(62,'store/products/30.jpg',16),(63,'store/products/31.jpg',16),(64,'store/products/32.jpg',16),(65,'store/products/33.jpg',17),(66,'store/products/34.jpg',17),(67,'store/products/35.jpg',17),(68,'store/products/36.jpg',17),(69,'store/products/37.jpg',18),(70,'store/products/38.jpg',18),(71,'store/products/39.jpg',18),(72,'store/products/40.jpg',18),(73,'store/products/41.jpg',20),(74,'store/products/42.jpg',20),(75,'store/products/43.jpg',20),(76,'store/products/44.jpg',20),(77,'store/products/45.png',21),(78,'store/products/46.png',21),(79,'store/products/47.png',21),(80,'store/products/48.png',21),(81,'store/products/49.png',22),(82,'store/products/50.png',22),(83,'store/products/51.png',22),(84,'store/products/52.png',22),(85,'store/products/53.png',23),(86,'store/products/54.png',23),(87,'store/products/55.png',23),(88,'store/products/56.png',23),(89,'store/products/57.png',23),(90,'store/products/58.png',24),(91,'store/products/59.png',24),(92,'store/products/60.png',24),(93,'store/products/61.png',24),(94,'store/products/62.png',24),(95,'store/products/62.jpg',25),(96,'store/products/63.jpg',25),(97,'store/products/64.jpg',25),(98,'store/products/65.jpg',25),(99,'store/products/66.png',26),(100,'store/products/67.png',26),(101,'store/products/68.png',26),(102,'store/products/69.png',26),(103,'store/products/70.png',26),(104,'store/products/71.jpg',27),(105,'store/products/72.jpg',27),(106,'store/products/73.jpg',27),(107,'store/products/74.jpg',27),(108,'store/products/75.jpg',28),(109,'store/products/76.jpg',28),(110,'store/products/77.jpg',28),(111,'store/products/78.jpg',28),(112,'store/products/79.jpg',29),(113,'store/products/80.jpg',29),(114,'store/products/81.jpg',29),(115,'store/products/82.jpg',29),(116,'store/products/83.png',30),(117,'store/products/84.png',30),(118,'store/products/85.png',30),(119,'store/products/86.png',30),(120,'store/products/87.png',31),(121,'store/products/88.png',31),(122,'store/products/89.png',31),(123,'store/products/90.png',31),(124,'store/products/91.png',32),(125,'store/products/92.png',32),(126,'store/products/93.png',32),(127,'store/products/94.jpg',33),(128,'store/products/95.png',33),(129,'store/products/95.jpg',33),(130,'store/products/97.png',33),(131,'store/products/98.png',34),(132,'store/products/99.png',34),(133,'store/products/100.png',34),(135,'store/products/102.png',34),(136,'store/products/103.jpg',35),(137,'store/products/104.jpg',35),(138,'store/products/105.jpg',35),(139,'store/products/106.jpeg',36),(140,'store/products/107.jpeg',36),(142,'store/products/108.jpeg',36),(143,'store/products/109.png',37),(144,'store/products/110.png',37),(145,'store/products/111.png',37),(146,'store/products/112.png',37),(147,'store/products/113.jpg',38),(148,'store/products/114.jpg',38),(149,'store/products/115.jpg',38),(150,'store/products/116.jpg',39),(151,'store/products/117.png',39),(152,'store/products/119.png',39),(153,'store/products/120.png',39),(154,'store/products/121.png',40),(155,'store/products/122.png',40),(156,'store/products/123.png',40),(157,'store/products/125.png',40),(158,'store/products/126.jpg',42),(159,'store/products/127.jpg',42),(160,'store/products/128.jpg',42),(161,'store/products/131.jpg',43),(162,'store/products/132.jpg',43),(163,'store/products/133.jpg',43),(164,'store/products/134.png',43),(165,'store/products/135.png',44),(166,'store/products/139.png',44),(167,'store/products/137.png',44),(168,'store/products/138.png',44),(169,'store/products/138_at423Hf.png',45),(170,'store/products/139_fFjmVfQ.png',45),(171,'store/products/140.png',45),(172,'store/products/141.jpg',46),(173,'store/products/142.png',46),(174,'store/products/143.png',46),(175,'store/products/146.png',47),(176,'store/products/143.jpg',47),(177,'store/products/144.jpg',47),(178,'store/products/145.jpg',47),(179,'store/products/147.png',48),(180,'store/products/148.png',48),(181,'store/products/149.png',48),(182,'store/products/150.jpg',49),(183,'store/products/157.jpg',49),(184,'store/products/152.jpg',49),(185,'store/products/156.jpg',49),(186,'store/products/158.png',50),(188,'store/products/160.png',50),(189,'store/products/159.png',50),(190,'store/products/161.png',50),(191,'store/products/162.png',51),(192,'store/products/163.png',51),(193,'store/products/164.png',51),(194,'store/products/165.png',51),(195,'store/products/167.png',52),(196,'store/products/166.png',52),(197,'store/products/168.png',52),(198,'store/products/169.png',52),(199,'store/products/162.jpg',53),(200,'store/products/163.jpg',53),(201,'store/products/164.jpg',53),(202,'store/products/165.jpg',53),(203,'store/products/166_UCRAv5l.png',54),(204,'store/products/167_UUjVbTL.png',54),(205,'store/products/168_afGUAyu.png',54),(206,'store/products/169_hO1aytS.png',54),(207,'store/products/170.png',54),(208,'store/products/171.png',55),(209,'store/products/172.png',55),(210,'store/products/173.png',55),(211,'store/products/174.png',55),(212,'store/products/175.png',55),(214,'store/products/178.png',56),(215,'store/products/179.png',56),(216,'store/products/180.png',56),(217,'store/products/181.png',56),(218,'store/products/182.png',57),(219,'store/products/183.png',57),(220,'store/products/184.png',57),(221,'store/products/185.png',57),(222,'store/products/187.jpg',58),(223,'store/products/188.jpg',58),(224,'store/products/189.jpg',58),(225,'store/products/190.jpg',58),(226,'store/products/191.jpg',58),(227,'store/products/192.png',59),(228,'store/products/193.png',59),(229,'store/products/194.png',59),(230,'store/products/195.png',59),(231,'store/products/196.png',60),(232,'store/products/197.png',60),(233,'store/products/199.png',60),(234,'store/products/200.png',60),(235,'store/products/201.png',61),(236,'store/products/202.png',61),(237,'store/products/203.png',61),(238,'store/products/204.png',61),(239,'store/products/206.jpg',62),(240,'store/products/209.png',62),(241,'store/products/208.png',62),(242,'store/products/CaptureCa2.png',62),(243,'store/products/211.png',63),(244,'store/products/212.png',63),(245,'store/products/213.png',63),(246,'store/products/214.png',63),(250,'store/products/220.jpg',64),(251,'store/products/221.jpg',64),(252,'store/products/222.jpg',64),(253,'store/products/223.jpg',64);
/*!40000 ALTER TABLE `store_productgallery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_reviewrating`
--

DROP TABLE IF EXISTS `store_reviewrating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_reviewrating` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `subject` varchar(100) NOT NULL,
  `review` longtext NOT NULL,
  `rating` double NOT NULL,
  `ip` varchar(20) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `product_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `store_reviewrating_product_id_2e1974d6_fk_store_product_id` (`product_id`),
  KEY `store_reviewrating_user_id_da0ed849_fk_account_account_id` (`user_id`),
  CONSTRAINT `store_reviewrating_product_id_2e1974d6_fk_store_product_id` FOREIGN KEY (`product_id`) REFERENCES `store_product` (`id`),
  CONSTRAINT `store_reviewrating_user_id_da0ed849_fk_account_account_id` FOREIGN KEY (`user_id`) REFERENCES `account_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_reviewrating`
--

LOCK TABLES `store_reviewrating` WRITE;
/*!40000 ALTER TABLE `store_reviewrating` DISABLE KEYS */;
/*!40000 ALTER TABLE `store_reviewrating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_variation`
--

DROP TABLE IF EXISTS `store_variation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_variation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `variation_category` varchar(100) NOT NULL,
  `variation_value` varchar(100) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `store_variation_product_id_e4f08cbc_fk_store_product_id` (`product_id`),
  CONSTRAINT `store_variation_product_id_e4f08cbc_fk_store_product_id` FOREIGN KEY (`product_id`) REFERENCES `store_product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=569 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_variation`
--

LOCK TABLES `store_variation` WRITE;
/*!40000 ALTER TABLE `store_variation` DISABLE KEYS */;
INSERT INTO `store_variation` VALUES (1,'color','black',1,'2023-12-19 12:21:14.527816',1),(2,'color','white',1,'2023-12-19 12:21:38.800832',1),(3,'color','gray',1,'2023-12-19 12:21:56.731811',1),(4,'color','gold',1,'2023-12-19 12:22:09.639451',1),(5,'color','red',1,'2023-12-19 12:22:51.959400',1),(6,'size','M',1,'2023-12-19 12:23:04.102726',1),(7,'size','L',1,'2023-12-19 12:23:21.554267',1),(8,'color','XL',1,'2023-12-19 12:24:30.957999',1),(9,'size','XXL',1,'2023-12-19 12:25:12.667275',1),(10,'color','black',1,'2023-12-19 12:25:27.020119',2),(11,'color','white',1,'2023-12-19 12:25:47.483042',2),(12,'color','gray',1,'2023-12-19 12:26:45.315330',2),(13,'color','gold',1,'2023-12-19 12:27:34.370061',2),(14,'color','red',1,'2023-12-19 12:27:47.213896',2),(15,'size','M',1,'2023-12-19 12:28:12.844850',2),(16,'size','L',1,'2023-12-19 12:28:27.388953',2),(17,'size','XL',1,'2023-12-19 12:28:39.633783',2),(18,'size','XXL',1,'2023-12-19 12:28:50.560472',2),(19,'color','black',1,'2023-12-19 12:29:13.551093',3),(20,'color','white',1,'2023-12-19 12:29:23.610597',3),(21,'color','gray',1,'2023-12-19 12:29:35.158251',3),(22,'color','gold',1,'2023-12-19 12:29:45.918925',3),(23,'color','red',1,'2023-12-19 12:30:00.694942',3),(24,'size','M',1,'2023-12-19 12:30:23.372075',3),(25,'size','L',1,'2023-12-19 12:30:39.253777',3),(26,'size','XL',1,'2023-12-19 12:30:47.766300',3),(27,'size','XXL',1,'2023-12-19 12:30:57.551496',3),(28,'color','black',1,'2023-12-19 12:31:09.377868',4),(29,'color','white',1,'2023-12-19 12:31:22.554267',4),(30,'color','gray',1,'2023-12-19 12:31:33.278149',4),(31,'color','gold',1,'2023-12-19 12:31:50.988593',4),(32,'size','M',1,'2023-12-19 12:32:01.360458',4),(33,'size','L',1,'2023-12-19 12:32:13.514875',4),(34,'size','XL',1,'2023-12-19 12:32:24.707226',4),(35,'size','XXL',1,'2023-12-19 12:32:41.209509',4),(36,'color','black',1,'2023-12-19 12:32:51.519407',5),(37,'color','white',1,'2023-12-19 12:33:01.374193',5),(38,'color','gray',1,'2023-12-19 12:33:25.858956',5),(39,'color','gold',1,'2023-12-19 12:33:36.807257',5),(40,'color','red',1,'2023-12-19 12:33:45.373010',5),(41,'size','M',1,'2023-12-19 12:33:57.683994',5),(42,'size','L',1,'2023-12-19 12:34:07.752112',5),(43,'size','XL',1,'2023-12-19 12:34:24.874636',5),(44,'size','XXL',1,'2023-12-19 12:34:35.727565',5),(45,'color','black',1,'2023-12-19 12:34:55.116969',6),(46,'color','white',1,'2023-12-19 12:35:31.758832',6),(47,'color','gray',1,'2023-12-19 12:36:12.536180',6),(48,'color','gold',1,'2023-12-19 12:36:28.004010',6),(49,'color','red',1,'2023-12-19 12:36:37.910639',6),(50,'size','M',1,'2023-12-19 12:36:51.480240',6),(51,'size','L',1,'2023-12-19 12:37:02.888210',6),(52,'size','XL',1,'2023-12-19 12:37:13.986008',6),(53,'size','XXL',1,'2023-12-19 12:37:25.499436',6),(54,'color','black',1,'2023-12-19 12:37:46.272019',7),(55,'color','white',1,'2023-12-19 12:38:48.693348',7),(56,'color','gray',1,'2023-12-19 12:39:01.075851',7),(57,'color','gold',1,'2023-12-19 12:39:13.445830',7),(58,'color','red',1,'2023-12-19 12:40:09.337544',7),(59,'size','M',1,'2023-12-19 12:40:19.405170',7),(60,'size','L',1,'2023-12-19 12:40:30.052450',7),(61,'size','XL',1,'2023-12-19 12:40:42.283427',7),(62,'size','XXL',1,'2023-12-19 12:40:51.241208',7),(63,'color','black',1,'2023-12-19 12:41:05.924363',8),(64,'color','white',1,'2023-12-19 12:41:21.366561',8),(65,'color','gray',1,'2023-12-19 12:41:34.009805',8),(66,'color','gold',1,'2023-12-19 12:41:51.119821',8),(67,'color','red',1,'2023-12-19 12:42:13.023179',8),(68,'size','M',1,'2023-12-19 12:42:24.653643',8),(69,'size','L',1,'2023-12-19 12:42:45.065341',8),(70,'size','XL',1,'2023-12-19 12:42:55.890100',8),(71,'size','XXL',1,'2023-12-19 12:43:45.695405',8),(72,'color','black',1,'2023-12-19 12:44:07.090309',9),(73,'color','white',1,'2023-12-19 12:44:32.032578',9),(74,'color','gray',1,'2023-12-19 12:44:46.132637',9),(75,'color','gold',1,'2023-12-19 12:45:04.042099',9),(76,'color','red',1,'2023-12-19 12:45:28.821575',9),(77,'size','M',1,'2023-12-19 12:45:48.785077',9),(78,'size','L',1,'2023-12-19 12:47:04.001115',9),(79,'size','XL',1,'2023-12-19 12:47:22.361549',9),(80,'size','XXL',1,'2023-12-19 12:47:33.675449',9),(81,'color','black',1,'2023-12-19 12:47:58.682847',10),(82,'color','white',1,'2023-12-19 12:48:11.346560',10),(83,'color','gray',1,'2023-12-19 12:48:35.587082',10),(84,'color','gold',1,'2023-12-19 12:48:53.611957',10),(85,'color','red',1,'2023-12-19 12:49:17.676689',10),(86,'size','M',1,'2023-12-19 12:49:30.218854',10),(87,'size','L',1,'2023-12-19 12:49:46.390972',10),(88,'size','XL',1,'2023-12-19 12:50:09.166891',10),(89,'size','XXL',1,'2023-12-19 12:50:22.109903',10),(90,'color','black',1,'2023-12-19 12:50:33.345108',11),(91,'color','white',1,'2023-12-19 12:50:41.506305',11),(92,'color','gray',1,'2023-12-19 12:51:00.800594',11),(93,'color','gold',1,'2023-12-19 12:51:23.196650',11),(94,'size','M',1,'2023-12-19 12:51:39.501099',11),(95,'size','L',1,'2023-12-19 12:51:55.042121',11),(96,'size','XL',1,'2023-12-19 12:52:17.863178',11),(97,'size','XXL',1,'2023-12-19 12:52:32.455804',11),(98,'color','black',1,'2023-12-19 12:53:31.589508',12),(99,'color','white',1,'2023-12-19 12:53:42.722119',12),(100,'color','gray',1,'2023-12-19 12:53:58.339355',12),(101,'color','gold',1,'2023-12-19 12:54:31.075345',12),(102,'color','red',1,'2023-12-19 12:54:45.076202',12),(103,'size','M',1,'2023-12-19 12:55:03.565983',12),(104,'size','L',1,'2023-12-19 12:55:19.932073',12),(105,'size','XL',1,'2023-12-19 12:55:44.511064',12),(106,'size','XXL',1,'2023-12-19 12:55:58.527719',12),(107,'color','black',1,'2023-12-19 12:56:23.503649',13),(108,'color','white',1,'2023-12-19 12:56:35.678236',13),(109,'color','gray',1,'2023-12-19 12:56:51.663345',13),(110,'color','gold',1,'2023-12-19 12:57:13.371625',13),(111,'color','red',1,'2023-12-19 12:57:32.552904',13),(112,'size','M',1,'2023-12-19 12:57:47.597263',13),(113,'size','L',1,'2023-12-19 12:57:57.026221',13),(114,'size','XL',1,'2023-12-19 12:58:19.114381',13),(115,'size','XXL',1,'2023-12-19 12:58:33.621785',13),(116,'color','black',1,'2023-12-19 12:59:12.707112',14),(117,'color','white',1,'2023-12-19 12:59:26.010115',14),(118,'color','gray',1,'2023-12-19 12:59:39.153621',14),(119,'color','gold',1,'2023-12-19 12:59:52.532117',14),(120,'color','red',1,'2023-12-19 13:00:07.626899',14),(121,'size','M',1,'2023-12-19 13:00:20.739894',14),(122,'size','L',1,'2023-12-19 13:00:31.737632',14),(123,'size','XL',1,'2023-12-19 13:00:50.617035',14),(124,'size','XXL',1,'2023-12-19 13:01:03.483533',14),(125,'color','black',1,'2023-12-19 13:01:16.796706',15),(126,'color','white',1,'2023-12-19 13:01:32.369966',15),(127,'color','gray',1,'2023-12-19 13:01:49.079911',15),(128,'color','gold',1,'2023-12-19 13:02:01.992949',15),(129,'color','red',1,'2023-12-19 13:02:20.192096',15),(130,'size','M',1,'2023-12-19 13:02:57.748367',15),(131,'size','L',1,'2023-12-19 13:03:07.829811',15),(132,'size','XL',1,'2023-12-19 13:03:21.441222',15),(133,'size','XXL',1,'2023-12-19 13:03:37.423902',15),(134,'color','black',1,'2023-12-19 13:04:14.814047',16),(135,'color','white',1,'2023-12-19 13:04:27.122661',16),(136,'color','gray',1,'2023-12-19 13:04:37.807416',16),(137,'color','red',1,'2023-12-19 13:04:56.998609',16),(138,'size','M',1,'2023-12-19 13:05:18.380343',16),(139,'size','L',1,'2023-12-19 13:05:33.614318',16),(140,'size','XL',1,'2023-12-19 13:05:53.187130',16),(141,'size','XXL',1,'2023-12-19 13:06:10.125424',16),(142,'color','black',1,'2023-12-19 13:06:32.166677',17),(143,'color','white',1,'2023-12-19 13:06:42.293171',17),(144,'color','gray',1,'2023-12-19 13:08:13.988814',17),(145,'color','gold',1,'2023-12-19 13:08:37.957166',17),(146,'color','red',1,'2023-12-19 13:08:57.741194',17),(147,'size','M',1,'2023-12-19 13:09:45.353019',17),(148,'size','L',1,'2023-12-19 13:09:56.228269',17),(149,'size','XL',1,'2023-12-19 13:10:07.603098',17),(150,'size','XXL',1,'2023-12-19 13:10:22.497695',17),(151,'color','black',1,'2023-12-19 13:11:04.600705',18),(152,'color','white',1,'2023-12-19 13:11:34.526767',18),(153,'color','gray',1,'2023-12-19 13:11:50.737609',18),(154,'color','gold',1,'2023-12-19 13:12:01.550790',18),(155,'color','red',1,'2023-12-19 13:12:15.431581',18),(156,'size','M',1,'2023-12-19 13:12:28.552072',18),(157,'size','L',1,'2023-12-19 13:13:18.129994',18),(158,'size','XL',1,'2023-12-19 13:13:31.281291',18),(159,'size','XXL',1,'2023-12-19 13:13:43.145535',18),(160,'color','black',1,'2023-12-19 13:14:09.423320',19),(161,'color','white',1,'2023-12-19 13:14:28.380592',19),(162,'color','gray',1,'2023-12-19 13:14:47.562747',19),(163,'color','gold',1,'2023-12-19 13:15:02.607188',19),(164,'color','red',1,'2023-12-19 13:15:14.643313',19),(165,'size','M',1,'2023-12-19 13:15:29.315442',19),(166,'size','L',1,'2023-12-19 13:15:43.892174',19),(167,'size','XL',1,'2023-12-19 13:15:54.628861',19),(168,'size','XXL',1,'2023-12-19 13:16:10.488900',19),(169,'color','black',1,'2023-12-19 13:16:29.002090',20),(170,'color','white',1,'2023-12-19 13:16:42.737452',20),(171,'color','gray',1,'2023-12-19 13:16:55.836779',20),(172,'color','gold',1,'2023-12-19 13:17:12.688437',20),(173,'color','red',1,'2023-12-19 13:17:31.468461',20),(174,'size','M',1,'2023-12-19 13:17:48.230207',20),(175,'size','L',1,'2023-12-19 13:18:01.733593',20),(176,'size','XL',1,'2023-12-19 13:18:13.965845',20),(177,'size','XXL',1,'2023-12-19 13:18:28.387677',20),(178,'color','black',1,'2023-12-19 13:18:48.439173',21),(179,'color','white',1,'2023-12-19 13:19:00.553339',21),(180,'color','gray',1,'2023-12-19 13:19:20.838987',21),(181,'color','gold',1,'2023-12-19 13:19:38.942517',21),(182,'color','red',1,'2023-12-19 13:19:53.151725',21),(183,'size','V 20L',1,'2023-12-19 13:24:38.083188',21),(184,'size','V 40L',1,'2023-12-19 13:25:41.091543',21),(185,'size','V 60L',1,'2023-12-19 13:25:57.089738',21),(186,'size','V 80L',1,'2023-12-19 13:26:17.883943',21),(187,'color','black',1,'2023-12-19 13:21:25.362692',22),(188,'color','white',1,'2023-12-19 13:27:42.228567',22),(189,'color','gray',1,'2023-12-19 13:21:47.134577',22),(190,'color','gold',1,'2023-12-19 13:22:27.943311',22),(191,'color','red',1,'2023-12-19 13:22:56.418528',22),(192,'size','V 20L',1,'2023-12-19 13:23:17.273024',22),(193,'size','V 40L',1,'2023-12-19 13:23:30.639896',22),(194,'size','V 60L',1,'2023-12-19 13:23:43.406967',22),(195,'size','V 80L',1,'2023-12-19 13:24:00.736640',22),(196,'color','black',1,'2023-12-19 13:28:28.850667',23),(197,'color','white',1,'2023-12-19 13:28:44.687023',23),(198,'color','gray',1,'2023-12-19 13:29:17.590225',23),(199,'color','gold',1,'2023-12-19 13:30:10.901487',23),(200,'color','red',1,'2023-12-19 13:30:34.062349',23),(201,'size','V 20L',1,'2023-12-19 13:31:04.933093',23),(202,'size','V 40L',1,'2023-12-19 13:31:17.972766',23),(203,'size','V 60L',1,'2023-12-19 13:31:37.889163',23),(204,'size','V 80L',1,'2023-12-19 13:31:48.217599',23),(205,'color','black',1,'2023-12-19 13:32:29.924459',24),(206,'color','white',1,'2023-12-19 13:32:41.635236',24),(207,'color','gray',1,'2023-12-19 13:32:54.097929',24),(208,'color','gold',1,'2023-12-19 13:33:21.886759',24),(209,'color','red',1,'2023-12-19 13:34:02.143928',24),(210,'size','V 20L',1,'2023-12-19 13:34:30.900744',24),(211,'size','V 40L',1,'2023-12-19 13:34:44.365409',24),(212,'size','V 60L',1,'2023-12-19 13:34:56.263509',24),(213,'size','V 80L',1,'2023-12-19 13:35:15.427930',24),(214,'color','black',1,'2023-12-19 13:35:46.927160',25),(215,'color','white',1,'2023-12-19 13:36:06.500127',25),(216,'color','gray',1,'2023-12-19 13:36:24.360810',25),(217,'color','gold',1,'2023-12-19 13:36:42.882990',25),(218,'color','red',1,'2023-12-19 13:37:00.046272',25),(219,'size','V 20L',1,'2023-12-19 13:37:17.910919',25),(220,'size','V 40L',1,'2023-12-19 13:37:32.922051',25),(221,'size','V 60L',1,'2023-12-19 13:38:19.814014',25),(222,'size','V 80L',1,'2023-12-19 13:38:30.801308',25),(223,'color','black',1,'2023-12-19 13:38:41.892155',26),(224,'color','white',1,'2023-12-19 13:38:53.853717',26),(225,'color','gray',1,'2023-12-19 13:39:04.516022',26),(226,'color','gold',1,'2023-12-19 13:39:27.237594',26),(227,'color','red',1,'2023-12-19 13:39:48.432961',26),(228,'size','V 20L',1,'2023-12-19 13:40:05.033896',26),(229,'size','V 40L',1,'2023-12-19 13:40:16.533678',26),(230,'size','V 60L',1,'2023-12-19 13:40:37.185219',26),(231,'size','V 80L',1,'2023-12-19 13:41:01.654431',26),(232,'color','black',1,'2023-12-19 13:41:21.750803',27),(233,'color','white',1,'2023-12-19 13:42:32.814398',27),(234,'color','gray',1,'2023-12-19 13:42:58.648468',27),(235,'color','gold',1,'2023-12-19 13:44:10.572673',27),(236,'color','red',1,'2023-12-19 13:44:31.577112',27),(237,'size','V 20L',1,'2023-12-19 13:44:41.138426',27),(238,'size','V 40L',1,'2023-12-19 13:45:07.481058',27),(239,'size','V 60L',1,'2023-12-19 13:45:38.147453',27),(240,'size','V 80L',1,'2023-12-19 13:45:52.281725',27),(241,'color','black',1,'2023-12-19 13:46:16.685620',28),(242,'color','black',1,'2023-12-19 13:46:56.262497',28),(243,'color','white',1,'2023-12-19 13:47:06.088795',28),(244,'color','gray',1,'2023-12-19 13:47:16.036899',28),(245,'color','gold',1,'2023-12-19 13:47:34.301523',28),(246,'color','red',1,'2023-12-19 13:47:48.234534',28),(247,'size','M',1,'2023-12-19 13:48:12.892391',28),(248,'size','L',1,'2023-12-19 13:48:25.168819',28),(249,'size','XL',1,'2023-12-19 13:48:37.501107',28),(250,'size','XXL',1,'2023-12-19 13:48:50.281756',28),(251,'color','black',1,'2023-12-19 13:49:12.124955',29),(252,'color','white',1,'2023-12-19 13:49:21.569690',29),(253,'color','gray',1,'2023-12-19 13:49:31.658042',29),(254,'color','gold',1,'2023-12-19 13:50:24.794879',29),(255,'color','red',1,'2023-12-19 13:50:49.039943',29),(256,'size','M',1,'2023-12-19 13:50:58.963897',29),(257,'size','L',1,'2023-12-19 13:51:08.407928',29),(258,'size','XL',1,'2023-12-19 13:51:24.344734',29),(259,'size','XXL',1,'2023-12-19 13:51:41.040839',29),(260,'color','black',1,'2023-12-19 13:52:51.429408',30),(261,'color','white',1,'2023-12-19 13:53:18.410352',30),(262,'color','gray',1,'2023-12-19 13:53:28.300901',30),(263,'color','gold',1,'2023-12-19 13:53:43.567490',30),(264,'color','red',1,'2023-12-19 13:53:54.212487',30),(265,'size','M',1,'2023-12-19 13:54:03.833563',30),(266,'size','L',1,'2023-12-19 13:54:17.263585',30),(267,'size','XL',1,'2023-12-19 13:54:30.654872',30),(268,'size','XXL',1,'2023-12-19 13:54:52.427534',30),(269,'color','black',1,'2023-12-19 13:55:22.714044',31),(270,'color','white',1,'2023-12-19 13:55:32.655362',31),(271,'color','gray',1,'2023-12-19 13:55:43.157943',31),(272,'color','gold',1,'2023-12-19 13:55:59.731140',31),(273,'color','red',1,'2023-12-19 13:56:13.983022',31),(274,'size','M',1,'2023-12-19 13:56:33.816156',31),(275,'size','L',1,'2023-12-19 13:57:07.313234',31),(276,'size','XL',1,'2023-12-19 13:57:36.057460',31),(277,'size','XXL',1,'2023-12-19 13:57:45.403709',31),(278,'color','black',1,'2023-12-19 13:58:22.914553',32),(279,'color','white',1,'2023-12-19 13:58:33.850665',32),(280,'color','gray',1,'2023-12-19 13:59:12.646667',32),(281,'color','gold',1,'2023-12-19 13:59:32.214378',32),(282,'color','red',1,'2023-12-19 13:59:49.676888',32),(283,'size','M',1,'2023-12-19 14:00:08.083075',32),(284,'size','L',1,'2023-12-19 14:00:27.743316',32),(285,'size','XL',1,'2023-12-19 14:00:38.836546',32),(286,'size','XXL',1,'2023-12-19 14:00:47.928053',32),(287,'color','black',1,'2023-12-19 14:01:06.872278',33),(288,'color','white',1,'2023-12-19 14:01:23.015838',33),(289,'color','gray',1,'2023-12-19 14:01:33.310890',33),(290,'color','gold',1,'2023-12-19 14:01:47.459597',33),(291,'color','red',1,'2023-12-19 14:02:07.901503',33),(292,'size','M',1,'2023-12-19 14:02:17.962263',33),(293,'size','L',1,'2023-12-19 14:02:27.617789',33),(294,'size','XL',1,'2023-12-19 14:02:40.308829',33),(295,'size','XXL',1,'2023-12-19 14:02:49.525039',33),(296,'color','black',1,'2023-12-19 14:03:07.721400',34),(297,'color','white',1,'2023-12-19 14:03:23.261266',34),(298,'color','gray',1,'2023-12-19 14:03:35.700428',34),(299,'color','gold',1,'2023-12-19 14:03:52.680159',34),(300,'color','red',1,'2023-12-19 14:04:06.692329',34),(301,'size','M',1,'2023-12-19 14:04:18.514053',34),(302,'size','L',1,'2023-12-19 14:04:32.134278',34),(303,'size','XL',1,'2023-12-19 14:04:44.965799',34),(304,'size','XXL',1,'2023-12-19 14:04:59.327126',34),(305,'color','black',1,'2023-12-19 14:05:15.429029',35),(306,'color','white',1,'2023-12-19 14:06:31.203381',35),(307,'color','gray',1,'2023-12-19 14:06:54.431940',35),(308,'color','gold',1,'2023-12-19 14:07:15.556963',35),(309,'color','red',1,'2023-12-19 14:07:37.939805',35),(310,'size','M',1,'2023-12-19 14:07:50.618515',35),(311,'size','L',1,'2023-12-19 14:08:05.629615',35),(312,'size','XL',1,'2023-12-19 14:08:37.468535',35),(313,'size','XXL',1,'2023-12-19 14:08:49.493989',35),(314,'color','black',1,'2023-12-19 14:09:10.298664',36),(315,'color','white',1,'2023-12-19 14:10:48.360115',36),(316,'color','gray',1,'2023-12-19 14:11:28.249711',36),(317,'color','gold',1,'2023-12-19 14:11:42.119082',36),(318,'size','M',1,'2023-12-19 14:11:57.336097',36),(319,'size','L',1,'2023-12-19 14:12:16.110491',36),(320,'size','XL',1,'2023-12-19 14:12:26.112336',36),(321,'size','XXL',1,'2023-12-19 14:12:35.822135',36),(322,'color','black',1,'2023-12-19 14:12:54.823275',37),(323,'color','white',1,'2023-12-19 14:13:12.613461',37),(324,'color','gray',1,'2023-12-19 14:13:25.116094',37),(325,'color','gold',1,'2023-12-19 14:13:37.078053',37),(326,'color','red',1,'2023-12-19 14:13:58.415390',37),(327,'size','M',1,'2023-12-19 14:14:09.419491',37),(328,'size','L',1,'2023-12-19 14:14:35.663410',37),(329,'size','XL',1,'2023-12-19 14:14:46.256337',37),(330,'size','XXL',1,'2023-12-19 14:14:57.522147',37),(331,'color','black',1,'2023-12-19 14:15:12.050681',38),(332,'color','white',1,'2023-12-19 14:15:25.265534',38),(333,'size','gray',1,'2023-12-19 14:15:39.677551',38),(334,'color','gold',1,'2023-12-19 14:15:57.376090',38),(335,'color','red',1,'2023-12-19 14:16:17.983823',38),(336,'size','M',1,'2023-12-19 14:16:30.860312',38),(337,'size','L',1,'2023-12-19 14:16:45.407678',38),(338,'size','XL',1,'2023-12-19 14:16:56.319961',38),(339,'size','XXL',1,'2023-12-19 14:17:18.598916',38),(340,'color','black',1,'2023-12-19 14:17:33.162350',39),(341,'color','white',1,'2023-12-19 14:17:43.757423',39),(342,'color','gray',1,'2023-12-19 14:17:58.523885',39),(343,'color','gold',1,'2023-12-19 14:18:29.744399',39),(344,'color','red',1,'2023-12-19 14:18:38.897840',39),(345,'size','M',1,'2023-12-19 14:19:03.529559',39),(346,'size','L',1,'2023-12-19 14:19:20.078250',39),(347,'size','XL',1,'2023-12-19 14:19:32.732345',39),(348,'size','XXL',1,'2023-12-19 14:19:42.393551',39),(349,'color','black',1,'2023-12-19 14:19:52.357945',40),(350,'color','white',1,'2023-12-19 14:20:02.206862',40),(351,'color','gray',1,'2023-12-19 14:20:14.451784',40),(352,'color','gold',1,'2023-12-19 14:20:32.598912',40),(353,'color','red',1,'2023-12-19 14:20:46.185288',40),(354,'size','M',1,'2023-12-19 14:22:05.111734',40),(355,'size','L',1,'2023-12-19 14:22:20.267816',40),(356,'size','XL',1,'2023-12-19 14:25:13.413623',40),(357,'size','XXL',1,'2023-12-19 14:25:34.848426',40),(358,'color','black',1,'2023-12-19 14:28:10.791632',41),(359,'color','white',1,'2023-12-19 14:28:22.590609',41),(360,'color','gray',1,'2023-12-19 14:28:54.003157',41),(361,'color','gold',1,'2023-12-19 14:29:14.361584',41),(362,'color','red',1,'2023-12-19 14:29:26.990051',41),(363,'size','M',1,'2023-12-19 14:29:37.242052',41),(364,'size','L',1,'2023-12-19 14:29:54.237166',41),(365,'size','XL',1,'2023-12-19 14:30:08.952676',41),(366,'size','XXL',1,'2023-12-19 14:30:20.650837',41),(367,'color','black',1,'2023-12-19 14:30:31.708351',42),(368,'color','white',1,'2023-12-19 14:30:45.915592',42),(369,'color','gray',1,'2023-12-19 14:31:24.765787',42),(370,'color','red',1,'2023-12-19 14:31:39.335889',42),(371,'size','M',1,'2023-12-19 14:31:52.632534',42),(372,'size','L',1,'2023-12-19 14:32:06.953741',42),(373,'size','XL',1,'2023-12-19 14:32:23.617289',42),(374,'size','XXL',1,'2023-12-19 14:32:45.222362',42),(375,'color','black',1,'2023-12-19 14:33:03.302158',43),(376,'color','white',1,'2023-12-19 14:33:13.808205',43),(377,'color','gray',1,'2023-12-19 14:33:25.926651',43),(378,'color','gold',1,'2023-12-19 14:33:45.092931',43),(379,'color','red',1,'2023-12-19 14:34:02.759316',43),(380,'size','M',1,'2023-12-19 14:34:23.164749',43),(381,'size','L',1,'2023-12-19 14:34:34.013323',43),(382,'size','XL',1,'2023-12-19 14:34:53.712941',43),(383,'size','XXL',1,'2023-12-19 14:35:07.609930',43),(384,'color','black',1,'2023-12-19 14:35:29.674540',44),(385,'color','white',1,'2023-12-19 14:35:50.093109',44),(386,'color','gray',1,'2023-12-19 14:36:11.570517',44),(387,'color','gold',1,'2023-12-19 14:36:31.236073',44),(388,'color','red',1,'2023-12-19 14:36:43.531008',44),(389,'size','M',1,'2023-12-19 14:36:59.881484',44),(390,'size','L',1,'2023-12-19 14:37:12.056618',44),(391,'size','XL',1,'2023-12-19 14:37:31.153589',44),(392,'size','XXL',1,'2023-12-19 14:37:44.014338',44),(393,'color','black',1,'2023-12-19 14:38:53.601576',45),(394,'color','white',1,'2023-12-19 14:39:09.801299',45),(395,'color','gray',1,'2023-12-19 14:39:25.020922',45),(396,'color','red',1,'2023-12-19 14:39:36.569451',45),(397,'size','M',1,'2023-12-19 14:40:11.549777',45),(398,'size','L',1,'2023-12-19 14:40:29.085771',45),(399,'size','XL',1,'2023-12-19 14:40:42.282846',45),(400,'size','XXL',1,'2023-12-19 14:40:57.099556',45),(401,'color','black',1,'2023-12-19 14:41:40.559826',46),(402,'color','white',1,'2023-12-19 14:41:50.466627',46),(403,'color','gray',1,'2023-12-19 14:48:31.298556',46),(404,'color','gold',1,'2023-12-19 14:48:46.516204',46),(405,'color','red',1,'2023-12-19 14:49:15.111638',46),(406,'size','M',1,'2023-12-19 15:33:31.079635',46),(407,'size','L',1,'2023-12-19 15:22:13.560489',46),(408,'size','XL',1,'2023-12-19 15:22:32.011991',46),(409,'size','XXL',1,'2023-12-19 15:22:43.837030',46),(410,'color','black',1,'2023-12-19 15:23:21.071421',47),(411,'color','white',1,'2023-12-19 15:23:31.872624',47),(412,'color','gray',1,'2023-12-19 15:23:45.740544',47),(413,'color','gold',1,'2023-12-19 15:24:17.079341',47),(414,'color','red',1,'2023-12-19 15:24:34.749331',47),(415,'size','M',1,'2023-12-19 15:24:46.758047',47),(416,'size','L',1,'2023-12-19 15:24:57.192557',47),(417,'size','XL',1,'2023-12-19 15:25:09.947093',47),(418,'size','XXL',1,'2023-12-19 15:25:24.165378',47),(419,'color','black',1,'2023-12-19 15:25:47.346329',48),(420,'color','white',1,'2023-12-19 15:26:06.616506',48),(421,'color','gray',1,'2023-12-19 15:26:17.481363',48),(422,'color','gold',1,'2023-12-19 15:26:36.469334',48),(423,'color','red',1,'2023-12-19 15:27:24.475485',48),(424,'size','M',1,'2023-12-19 15:27:38.221048',48),(425,'size','L',1,'2023-12-19 15:27:59.582830',48),(426,'size','XL',1,'2023-12-19 15:28:13.793296',48),(427,'size','XXL',1,'2023-12-19 15:28:24.446178',48),(428,'color','black',1,'2023-12-19 15:28:43.804665',49),(429,'color','white',1,'2023-12-19 15:28:58.349389',49),(430,'color','gray',1,'2023-12-19 15:29:11.314108',49),(431,'color','gold',1,'2023-12-19 15:34:01.939432',49),(432,'color','red',1,'2023-12-19 15:30:00.543952',49),(433,'size','M',1,'2023-12-19 15:30:16.794698',49),(434,'size','L',1,'2023-12-19 15:30:30.442313',49),(435,'size','XL',1,'2023-12-19 15:30:54.245088',49),(436,'size','XXL',1,'2023-12-19 15:31:07.737623',49),(437,'color','black',1,'2023-12-19 15:32:59.448075',50),(438,'color','white',1,'2023-12-19 15:41:37.098275',50),(439,'color','gray',1,'2023-12-19 15:42:30.468638',50),(440,'color','gold',1,'2023-12-19 15:42:50.312971',50),(441,'color','red',1,'2023-12-19 15:43:10.091704',50),(442,'size','M',1,'2023-12-19 15:43:44.366011',50),(443,'size','L',1,'2023-12-19 15:44:08.816313',50),(444,'size','XL',1,'2023-12-19 15:44:24.301787',50),(445,'size','XXL',1,'2023-12-19 15:44:36.402910',50),(446,'color','black',1,'2023-12-19 15:44:50.236418',51),(447,'color','white',1,'2023-12-19 15:45:26.968941',51),(448,'color','gray',1,'2023-12-19 15:45:41.234608',51),(449,'color','gold',1,'2023-12-19 15:45:53.463966',51),(450,'color','red',1,'2023-12-19 15:46:07.895754',51),(451,'size','M',1,'2023-12-19 17:14:10.282368',51),(452,'size','L',1,'2023-12-19 15:47:28.991578',51),(453,'size','XL',1,'2023-12-19 15:47:39.397922',51),(454,'size','XXL',1,'2023-12-19 15:48:14.610912',51),(455,'color','black',1,'2023-12-19 15:50:31.958648',52),(456,'color','white',1,'2023-12-19 15:50:44.572993',52),(457,'color','gray',1,'2023-12-19 15:51:11.998188',52),(458,'color','gold',1,'2023-12-19 15:51:26.830951',52),(459,'color','red',1,'2023-12-19 15:52:03.196807',52),(460,'size','M',1,'2023-12-19 15:52:13.106575',52),(461,'size','L',1,'2023-12-19 15:52:25.692312',52),(462,'size','XL',1,'2023-12-19 15:52:47.157248',52),(463,'size','XXL',1,'2023-12-19 15:52:59.183838',52),(464,'color','black',1,'2023-12-19 15:53:18.090267',53),(465,'color','white',1,'2023-12-19 15:53:32.584588',53),(466,'color','gray',1,'2023-12-19 15:53:44.942148',53),(467,'color','gold',1,'2023-12-19 15:54:04.966113',53),(468,'color','red',1,'2023-12-19 15:54:27.966679',53),(469,'size','M',1,'2023-12-19 15:55:32.466791',53),(470,'size','L',1,'2023-12-19 15:55:44.791871',53),(471,'size','XL',1,'2023-12-19 15:56:00.077916',53),(472,'size','XXL',1,'2023-12-19 15:56:44.837077',53),(473,'color','black',1,'2023-12-19 15:57:12.120037',54),(474,'color','white',1,'2023-12-19 15:57:25.335621',54),(475,'color','gray',1,'2023-12-19 16:06:11.494538',54),(476,'color','gold',1,'2023-12-19 16:06:49.255935',54),(477,'color','red',1,'2023-12-19 16:47:32.014974',54),(478,'size','M',1,'2023-12-19 16:47:58.913515',54),(479,'size','L',1,'2023-12-19 16:48:16.358213',54),(480,'size','XL',1,'2023-12-19 16:48:38.537171',54),(481,'size','XXL',1,'2023-12-19 16:48:56.134681',54),(482,'color','black',1,'2023-12-19 16:49:21.322798',55),(483,'color','white',1,'2023-12-19 16:50:07.023558',55),(484,'color','gray',1,'2023-12-19 16:50:19.701600',55),(485,'color','gold',1,'2023-12-19 16:50:47.090803',55),(486,'color','red',1,'2023-12-19 16:51:01.752860',55),(487,'size','M',1,'2023-12-19 16:52:29.053538',55),(488,'size','L',1,'2023-12-19 16:52:42.353513',55),(489,'size','XL',1,'2023-12-19 16:52:56.963698',55),(490,'size','XXL',1,'2023-12-19 16:53:15.638599',55),(491,'color','black',1,'2023-12-19 16:54:07.312555',56),(492,'color','white',1,'2023-12-19 16:54:30.906963',56),(493,'color','gray',1,'2023-12-19 16:55:05.946779',56),(494,'color','gold',1,'2023-12-19 16:56:03.954034',56),(495,'color','red',1,'2023-12-19 16:57:16.135175',56),(496,'size','M',1,'2023-12-19 16:57:55.361825',56),(497,'size','L',1,'2023-12-19 16:59:09.755911',56),(498,'color','XL',1,'2023-12-19 17:00:01.219640',56),(499,'size','XXL',1,'2023-12-19 17:00:29.366702',56),(500,'color','black',1,'2023-12-19 17:02:23.071143',57),(501,'color','white',1,'2023-12-19 17:02:40.280683',57),(502,'color','gray',1,'2023-12-19 17:03:40.762849',57),(503,'color','gold',1,'2023-12-19 17:03:55.639805',57),(504,'color','red',1,'2023-12-19 17:04:15.299034',57),(505,'size','M',1,'2023-12-19 17:04:27.900426',57),(506,'size','L',1,'2023-12-19 17:09:06.340459',57),(507,'size','XL',1,'2023-12-19 17:09:27.206060',57),(508,'size','XXL',1,'2023-12-19 17:09:50.488266',57),(509,'color','black',1,'2023-12-19 17:10:08.647015',58),(510,'color','white',1,'2023-12-19 17:10:43.880030',58),(511,'color','gray',1,'2023-12-19 17:12:24.674812',58),(512,'color','gold',1,'2023-12-19 17:13:02.045859',58),(513,'size','M',1,'2023-12-19 17:15:09.777677',58),(514,'size','L',1,'2023-12-19 17:15:29.167907',58),(515,'size','XL',1,'2023-12-19 17:15:53.291471',58),(516,'color','XXL',1,'2023-12-19 17:16:30.042225',58),(517,'color','black',1,'2023-12-19 17:16:55.106051',59),(518,'color','white',1,'2023-12-19 17:17:29.694096',59),(519,'color','gray',1,'2023-12-19 17:17:43.096107',59),(520,'color','gold',1,'2023-12-19 17:18:00.803860',59),(521,'color','red',1,'2023-12-19 17:18:17.750409',59),(522,'size','M',1,'2023-12-19 17:18:35.167004',59),(523,'size','L',1,'2023-12-19 17:18:46.544731',59),(524,'size','XL',1,'2023-12-19 17:19:05.437798',59),(525,'size','XXL',1,'2023-12-19 17:19:18.319848',59),(526,'color','black',1,'2023-12-19 17:48:27.884353',60),(527,'color','white',1,'2023-12-19 17:48:58.451884',60),(528,'color','gray',1,'2023-12-19 17:49:20.643263',60),(529,'color','gold',1,'2023-12-19 17:49:49.863316',60),(530,'color','red',1,'2023-12-19 17:50:11.815320',60),(531,'size','M',1,'2023-12-19 17:50:29.441117',60),(532,'size','L',1,'2023-12-19 17:50:49.078206',60),(533,'size','XL',1,'2023-12-19 17:51:06.084326',60),(534,'size','XXL',1,'2023-12-19 17:51:24.114035',60),(535,'color','black',1,'2023-12-19 17:51:50.223974',61),(536,'color','white',1,'2023-12-19 17:52:09.562574',61),(537,'color','gray',1,'2023-12-19 17:52:25.705954',61),(538,'color','gold',1,'2023-12-19 17:52:48.970650',61),(539,'size','M',1,'2023-12-19 17:53:00.531389',61),(540,'size','L',1,'2023-12-19 17:53:15.392693',61),(541,'size','XL',1,'2023-12-19 17:53:40.870118',61),(542,'size','XXL',1,'2023-12-19 17:53:55.086417',61),(543,'color','black',1,'2023-12-19 17:54:17.505182',62),(544,'color','white',1,'2023-12-19 17:55:04.337534',62),(545,'color','gray',1,'2023-12-19 17:55:19.957470',62),(546,'color','gold',1,'2023-12-19 17:55:35.194744',62),(547,'size','M',1,'2023-12-19 17:56:00.385049',62),(548,'size','L',1,'2023-12-19 17:56:31.413243',62),(549,'size','XL',1,'2023-12-19 17:56:52.004284',62),(550,'size','XXL',1,'2023-12-19 17:57:22.435041',62),(551,'color','black',1,'2023-12-19 17:57:57.077748',63),(552,'color','white',1,'2023-12-19 17:58:11.381627',63),(553,'color','gray',1,'2023-12-19 17:58:40.785691',63),(554,'color','gold',1,'2023-12-19 17:58:57.682985',63),(555,'color','red',1,'2023-12-19 17:59:12.742398',63),(556,'size','M',1,'2023-12-19 17:59:31.977260',63),(557,'color','L',1,'2023-12-19 18:00:06.024403',63),(558,'size','XL',1,'2023-12-19 18:00:23.680565',63),(559,'size','XXL',1,'2023-12-19 18:01:02.658715',63),(560,'color','black',1,'2023-12-19 18:01:27.301050',64),(561,'color','white',1,'2023-12-19 18:01:41.710735',64),(562,'color','gray',1,'2023-12-19 18:02:05.050398',64),(563,'color','gold',1,'2023-12-19 18:02:19.758895',64),(564,'color','red',1,'2023-12-19 18:02:39.447810',64),(565,'size','M',1,'2023-12-19 18:02:52.456200',64),(566,'size','L',1,'2023-12-19 18:03:31.570115',64),(567,'size','XL',1,'2023-12-19 18:03:57.067235',64),(568,'size','XXL',1,'2023-12-19 18:04:32.518572',64);
/*!40000 ALTER TABLE `store_variation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-01 17:40:00
