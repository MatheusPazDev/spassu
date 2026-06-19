CREATE DATABASE  IF NOT EXISTS `spassu_desafio` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `spassu_desafio`;
-- MySQL dump 10.13  Distrib 9.7.0, for Win64 (x86_64)
--
-- Host: localhost    Database: spassu_desafio
-- ------------------------------------------------------
-- Server version	9.7.0

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

-- SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '7fe4a678-6992-11f1-9606-00090faa0001:1-1410';

--
-- Table structure for table `tb_categoria`
--

DROP TABLE IF EXISTS `tb_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_categoria` (
  `CO_CATEGORIA` int NOT NULL AUTO_INCREMENT COMMENT 'PK da tabela',
  `NO_CATEGORIA` varchar(100) NOT NULL COMMENT 'Nome da categoria',
  PRIMARY KEY (`CO_CATEGORIA`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Armazena as categorias utilizadas para classificação dos produtos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_categoria`
--

LOCK TABLES `tb_categoria` WRITE;
/*!40000 ALTER TABLE `tb_categoria` DISABLE KEYS */;
INSERT INTO `tb_categoria` VALUES (1,'Eletrônico'),(2,'Informática'),(3,'Livro'),(4,'Casa'),(5,'Esporte');
/*!40000 ALTER TABLE `tb_categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_cliente`
--

DROP TABLE IF EXISTS `tb_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_cliente` (
  `CO_CLIENTE` int NOT NULL AUTO_INCREMENT COMMENT 'PK da tabela',
  `NO_CLIENTE` varchar(150) NOT NULL COMMENT 'Nome completo',
  `NU_CPF` char(11) NOT NULL COMMENT 'CPF do cliente',
  `DS_EMAIL` varchar(150) NOT NULL COMMENT 'Endereço de e-mail do cliente',
  `DT_NASCIMENTO` date NOT NULL COMMENT 'Data de nascimento do cliente',
  PRIMARY KEY (`CO_CLIENTE`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Armazena os dados cadastrais dos clientes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_cliente`
--

LOCK TABLES `tb_cliente` WRITE;
/*!40000 ALTER TABLE `tb_cliente` DISABLE KEYS */;
INSERT INTO `tb_cliente` VALUES (1,'João','11111111111','joao@email.com','2000-05-10'),(2,'Maria','22222222222','maria@email.com','2000-08-15'),(3,'Pedro','33333333333','pedro@email.com','2000-03-22'),(4,'Luana','44444444444','luana@email.com','2000-11-30'),(5,'Carlos','55555555555','carlos@email.com','2000-01-12'),(6,'Juliana','66666666666','juliana@email.com','2000-07-18'),(7,'Fernanda','77777777777','fernanda@email.com','2000-09-05'),(8,'Ricardo','88888888888','ricardo@email.com','2000-12-20'),(9,'Patricia','99999999999','patricia@email.com','2000-04-28'),(10,'Lucas','10101010101','lucas@email.com','2000-06-14');
/*!40000 ALTER TABLE `tb_cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_endereco_cliente`
--

DROP TABLE IF EXISTS `tb_endereco_cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_endereco_cliente` (
  `CO_ENDERECO_CLIENTE` int NOT NULL AUTO_INCREMENT COMMENT 'PK da tabela',
  `CO_CLIENTE` int NOT NULL COMMENT 'FK para a tabela TB_CLIENTE',
  `DS_LOGRADOURO` varchar(150) NOT NULL COMMENT 'Rua, avenida ou logradouro',
  `NU_ENDERECO` varchar(20) NOT NULL COMMENT 'Número do endereço',
  `DS_COMPLEMENTO` varchar(100) DEFAULT NULL COMMENT 'Complemento do endereço',
  `NO_BAIRRO` varchar(100) NOT NULL COMMENT 'Nome do bairro',
  `NO_CIDADE` varchar(100) NOT NULL COMMENT 'Nome da cidade',
  `SG_UF` char(2) NOT NULL COMMENT 'Sigla da UF',
  `NU_CEP` char(8) NOT NULL COMMENT 'CEP do endereço',
  `ST_PRINCIPAL` char(1) NOT NULL DEFAULT 'N' COMMENT 'Indica se o endereço é o principal (S ou N)',
  PRIMARY KEY (`CO_ENDERECO_CLIENTE`),
  KEY `FK_ENDERECO_CLIENTE_CLIENTE` (`CO_CLIENTE`),
  CONSTRAINT `FK_ENDERECO_CLIENTE_CLIENTE` FOREIGN KEY (`CO_CLIENTE`) REFERENCES `tb_cliente` (`CO_CLIENTE`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `CK_ENDERECO_PRINCIPAL` CHECK ((`ST_PRINCIPAL` in (_utf8mb4'S',_utf8mb4'N')))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Armazena os endereços vinculados aos clientes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_endereco_cliente`
--

LOCK TABLES `tb_endereco_cliente` WRITE;
/*!40000 ALTER TABLE `tb_endereco_cliente` DISABLE KEYS */;
INSERT INTO `tb_endereco_cliente` VALUES (1,1,'Rua A','100',NULL,'Centro','São Paulo','SP','1000000','N'),(2,1,'Rua A2','101',NULL,'Centro','São Paulo','SP','1000001','S'),(3,2,'Rua B','200',NULL,'Centro','São Paulo','SP','1000005','S'),(4,3,'Rua C','300',NULL,'Jardim','Campinas','SP','2000000','S'),(5,4,'Rua D','400','Apto 12','Centro','Rio de Janeiro','RJ','3000000','S'),(6,5,'Rua E','500',NULL,'Centro','Belo Horizonte','MG','40000000','S'),(7,6,'Rua F','600',NULL,'Jardim','Curitiba','PR','50000000','S'),(8,7,'Rua G','700','Casa','Centro','Porto Alegre','RS','60000000','S'),(9,8,'Rua H','800',NULL,'Centro','Salvador','BA','70000000','S'),(10,9,'Rua I','900',NULL,'Jardim','Recife','PE','80000000','S'),(11,10,'Rua J','1000',NULL,'Centro','Brasília','DF','90000000','S');
/*!40000 ALTER TABLE `tb_endereco_cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_item_pedido`
--

DROP TABLE IF EXISTS `tb_item_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_item_pedido` (
  `CO_ITEM_PEDIDO` int NOT NULL AUTO_INCREMENT COMMENT 'PK da tabela',
  `CO_PEDIDO` int NOT NULL COMMENT 'FK para a tabela TB_PEDIDO',
  `CO_PRODUTO` int NOT NULL COMMENT 'FK para a tabela TB_PRODUTO',
  `QT_PRODUTO` int NOT NULL COMMENT 'Quantidade do produto solicitada no pedido',
  `VL_UNITARIO` decimal(10,2) NOT NULL COMMENT 'Valor unitário do produto no momento da compra',
  PRIMARY KEY (`CO_ITEM_PEDIDO`),
  KEY `FK_ITEM_PEDIDO_PEDIDO` (`CO_PEDIDO`),
  KEY `FK_ITEM_PEDIDO_PRODUTO` (`CO_PRODUTO`),
  CONSTRAINT `FK_ITEM_PEDIDO_PEDIDO` FOREIGN KEY (`CO_PEDIDO`) REFERENCES `tb_pedido` (`CO_PEDIDO`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_ITEM_PEDIDO_PRODUTO` FOREIGN KEY (`CO_PRODUTO`) REFERENCES `tb_produto` (`CO_PRODUTO`) ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Armazena os itens que compõem cada pedido';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_item_pedido`
--

LOCK TABLES `tb_item_pedido` WRITE;
/*!40000 ALTER TABLE `tb_item_pedido` DISABLE KEYS */;
INSERT INTO `tb_item_pedido` VALUES (1,1,1,1,150.00),(2,1,3,1,60.00),(3,1,5,2,700.00),(4,2,5,1,900.00),(5,3,10,2,90.00),(6,4,9,1,300.00),(7,5,1,1,150.00),(8,6,6,1,80.00),(9,6,10,1,90.00),(10,7,10,1,90.00),(11,8,7,1,100.00),(12,9,8,1,50.00),(13,9,9,1,300.00),(14,10,5,1,900.00),(15,10,2,1,200.00);
/*!40000 ALTER TABLE `tb_item_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_pedido`
--

DROP TABLE IF EXISTS `tb_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_pedido` (
  `CO_PEDIDO` int NOT NULL AUTO_INCREMENT COMMENT 'PK da tabela',
  `CO_CLIENTE` int NOT NULL COMMENT 'FK para a tabela TB_CLIENTE',
  `CO_ENDERECO_CLIENTE` int NOT NULL COMMENT 'FK para a tabela TB_ENDERECO_CLIENTE. Endereço da entrega.',
  `CO_STATUS_PEDIDO` int NOT NULL COMMENT 'FK para a tabela TB_STATUS_PEDIDO',
  `DT_PEDIDO` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data e hora de criação do pedido',
  `VL_TOTAL_PEDIDO` decimal(12,2) NOT NULL COMMENT 'Valor total do pedido calculado a partir dos itens',
  PRIMARY KEY (`CO_PEDIDO`),
  KEY `FK_PEDIDO_CLIENTE` (`CO_CLIENTE`),
  KEY `FK_PEDIDO_ENDERECO` (`CO_ENDERECO_CLIENTE`),
  KEY `FK_PEDIDO_STATUS` (`CO_STATUS_PEDIDO`),
  CONSTRAINT `FK_PEDIDO_CLIENTE` FOREIGN KEY (`CO_CLIENTE`) REFERENCES `tb_cliente` (`CO_CLIENTE`) ON UPDATE RESTRICT,
  CONSTRAINT `FK_PEDIDO_ENDERECO` FOREIGN KEY (`CO_ENDERECO_CLIENTE`) REFERENCES `tb_endereco_cliente` (`CO_ENDERECO_CLIENTE`) ON UPDATE RESTRICT,
  CONSTRAINT `FK_PEDIDO_STATUS` FOREIGN KEY (`CO_STATUS_PEDIDO`) REFERENCES `tb_status_pedido` (`CO_STATUS_PEDIDO`) ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Armazena o cabeçalho dos pedidos realizados pelos clientes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_pedido`
--

LOCK TABLES `tb_pedido` WRITE;
/*!40000 ALTER TABLE `tb_pedido` DISABLE KEYS */;
INSERT INTO `tb_pedido` VALUES (1,1,1,6,'2026-05-01 10:00:00',210.00),(2,1,2,2,'2026-05-02 11:00:00',900.00),(3,3,3,3,'2026-05-03 14:00:00',180.00),(4,4,4,1,'2026-05-04 16:00:00',300.00),(5,5,5,4,'2026-05-05 09:00:00',150.00),(6,6,6,2,'2026-05-06 15:00:00',170.00),(7,7,7,6,'2026-05-07 18:00:00',90.00),(8,8,8,6,'2026-05-08 13:00:00',100.00),(9,9,9,3,'2026-05-09 10:30:00',350.00),(10,10,10,1,'2026-05-10 17:00:00',1100.00);
/*!40000 ALTER TABLE `tb_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_produto`
--

DROP TABLE IF EXISTS `tb_produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_produto` (
  `CO_PRODUTO` int NOT NULL AUTO_INCREMENT COMMENT 'PK da tabela',
  `CO_CATEGORIA` int NOT NULL COMMENT 'FK para a tabela TB_CATEGORIA',
  `NO_PRODUTO` varchar(150) NOT NULL COMMENT 'Nome do produto',
  `VL_PRECO` decimal(10,2) NOT NULL COMMENT 'Preço unitário atual',
  PRIMARY KEY (`CO_PRODUTO`),
  KEY `FK_PRODUTO_CATEGORIA` (`CO_CATEGORIA`),
  CONSTRAINT `FK_PRODUTO_CATEGORIA` FOREIGN KEY (`CO_CATEGORIA`) REFERENCES `tb_categoria` (`CO_CATEGORIA`) ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Armazena os produtos disponíveis para venda';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_produto`
--

LOCK TABLES `tb_produto` WRITE;
/*!40000 ALTER TABLE `tb_produto` DISABLE KEYS */;
INSERT INTO `tb_produto` VALUES (1,1,'Fone Bluetooth',150.00),(2,1,'Caixa de Som',200.00),(3,2,'Mouse USB',60.00),(4,2,'Teclado USB',90.00),(5,2,'Monitor 24',900.00),(6,3,'Livro SQL',80.00),(7,3,'Livro Java',100.00),(8,4,'Luminária',50.00),(9,4,'Cadeira',300.00),(10,5,'Bola Futebol',90.00);
/*!40000 ALTER TABLE `tb_produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_recurso_acao_processo`
--

DROP TABLE IF EXISTS `tb_recurso_acao_processo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_recurso_acao_processo` (
  `CO_RECURSO_ACAO_PROCESSO` int NOT NULL AUTO_INCREMENT COMMENT 'PK da tabela',
  `NO_RECURSO_ACAO_PROCESSO` varchar(50) NOT NULL COMMENT 'Nome do recurso acao',
  `ST_ATIVO` tinyint(1) NOT NULL COMMENT 'Flag indicativa se o registro está ativo',
  `DT_INCLUSAO` datetime NOT NULL COMMENT 'Data de criação',
  `CO_USUARIO_INCLUSAO` int NOT NULL COMMENT 'FK para a tabela TB_USUARIO',
  PRIMARY KEY (`CO_RECURSO_ACAO_PROCESSO`),
  UNIQUE KEY `UK_TB_RECURSO_ACAO_PROCESSO_NOME` (`NO_RECURSO_ACAO_PROCESSO`),
  KEY `FK_RECURSO_ACAO_PROCESSO_USUARIO` (`CO_USUARIO_INCLUSAO`),
  CONSTRAINT `FK_RECURSO_ACAO_PROCESSO_USUARIO` FOREIGN KEY (`CO_USUARIO_INCLUSAO`) REFERENCES `tb_usuario` (`CO_USUARIO`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela de domínio contendo os possíveis status dos pedidos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_recurso_acao_processo`
--

LOCK TABLES `tb_recurso_acao_processo` WRITE;
/*!40000 ALTER TABLE `tb_recurso_acao_processo` DISABLE KEYS */;
INSERT INTO `tb_recurso_acao_processo` VALUES (1,'Cadastrar Cliente',1,'2026-01-10 08:00:00',1),(2,'Alterar Cliente',1,'2026-01-10 08:05:00',1),(3,'Excluir Cliente',1,'2026-01-10 08:10:00',1),(4,'Consultar Cliente',1,'2026-01-10 08:15:00',1),(5,'Vincular boleto',1,'2026-06-19 01:21:57',8);
/*!40000 ALTER TABLE `tb_recurso_acao_processo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_status_pedido`
--

DROP TABLE IF EXISTS `tb_status_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_status_pedido` (
  `CO_STATUS_PEDIDO` int NOT NULL AUTO_INCREMENT COMMENT 'PK da tabela',
  `NO_STATUS_PEDIDO` varchar(50) NOT NULL COMMENT 'Status do pedido',
  PRIMARY KEY (`CO_STATUS_PEDIDO`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela de domínio contendo os possíveis status dos pedidos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_status_pedido`
--

LOCK TABLES `tb_status_pedido` WRITE;
/*!40000 ALTER TABLE `tb_status_pedido` DISABLE KEYS */;
INSERT INTO `tb_status_pedido` VALUES (1,'Pendente'),(2,'Pago'),(3,'Enviado'),(4,'Entregue'),(5,'Cancelado'),(6,'Concluido');
/*!40000 ALTER TABLE `tb_status_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_usuario`
--

DROP TABLE IF EXISTS `tb_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_usuario` (
  `CO_USUARIO` int NOT NULL AUTO_INCREMENT COMMENT 'PK da tabela',
  `NO_USUARIO` varchar(50) NOT NULL COMMENT 'Nome do usuário',
  PRIMARY KEY (`CO_USUARIO`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Tabela de domínio contendo os possíveis status dos pedidos';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_usuario`
--

LOCK TABLES `tb_usuario` WRITE;
/*!40000 ALTER TABLE `tb_usuario` DISABLE KEYS */;
INSERT INTO `tb_usuario` VALUES (1,'SISTEMA'),(2,'Administrador'),(3,'Usuario 1'),(4,'Usuario 2'),(5,'SISTEMA DSV'),(6,'Usuario 3'),(7,'Usuario A'),(8,'SISTEMA HMG'),(9,'Usuario B'),(10,'Usuario C'),(11,'SISTEMA PRD');
/*!40000 ALTER TABLE `tb_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_verifica_pedido_total`
--

DROP TABLE IF EXISTS `vw_verifica_pedido_total`;
/*!50001 DROP VIEW IF EXISTS `vw_verifica_pedido_total`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_verifica_pedido_total` AS SELECT 
 1 AS `co_pedido`,
 1 AS `vl_total_pedido`,
 1 AS `vl_total_itens`,
 1 AS `st_conferencia`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'spassu_desafio'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_consulta_pedidos_status_valor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_consulta_pedidos_status_valor`(
    IN valor_minimo DECIMAL(10,2),
    IN status_pedido VARCHAR(50)
)
proc: BEGIN -- Inicia begin de processamento da SP
    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Declaração da variavel de controle
    DECLARE p_co_status_pedido INT;
    SET p_co_status_pedido = (SELECT co_status_pedido FROM tb_status_pedido WHERE NO_STATUS_PEDIDO = status_pedido LIMIT 1);
    -- SELECT p_co_status_pedido_concluido;

    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Validação dos parametros

    -- Valida Valor Minimo obrigatório
    IF valor_minimo IS NULL THEN
        SELECT 'Parâmetro valor_minimo é obrigatório.' AS mensagem_erro;
        LEAVE proc; 
    END IF;
    
    -- Valida Status
    IF status_pedido IS NOT NULL
       AND TRIM(status_pedido) <> ''
       AND p_co_status_pedido IS NULL
    THEN
        SELECT CONCAT('Status não encontrado: ', status_pedido) AS mensagem_erro;
        LEAVE proc;
    END IF;
    

    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Versão 1 - Utlizando Variavel
    /* -- Busca o total pela tabela de Pedido.
    SELECT  -- 'Versão 1 - Busca pelo Total do Pedido' AS origem,
            DATE_FORMAT(ped.dt_pedido, '%d/%m/%Y %h:%i') AS dt_pedido_formatado,
            cli.no_cliente,
            ped.co_pedido,
            ped.vl_total_pedido
    FROM tb_pedido ped
    JOIN tb_cliente cli ON cli.co_cliente = ped.co_cliente
    WHERE ped.co_status_pedido = p_co_status_pedido_concluido
      AND ped.vl_total_pedido > valor_minimo
    ORDER BY ped.dt_pedido DESC;
    */
    

    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Versão 2 - Utlizando a tabela TB_ITEM_PEDIDO
    SELECT  -- 'Versão 2 - Utlizando a tabela TB_ITEM_PEDIDO' as origem,
            DATE_FORMAT(ped.dt_pedido, '%d/%m/%Y %h:%i') AS dt_pedido_formatado,
            cli.no_cliente,
            ped.co_pedido,
            ped.vl_total_pedido,
            SUM(ip.qt_produto * ip.vl_unitario) AS vl_total_pedido_por_item
    FROM tb_pedido ped
    JOIN tb_item_pedido ip on ip.co_pedido = ped.co_pedido
    JOIN tb_cliente cli ON cli.co_cliente = ped.co_cliente
    WHERE (ped.co_status_pedido = p_co_status_pedido OR p_co_status_pedido is null)
    GROUP BY cli.no_cliente,
             ped.co_pedido,
             ped.dt_pedido
    HAVING SUM(ip.qt_produto * ip.vl_unitario) > valor_minimo
    ORDER BY ped.dt_pedido DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_relatorio_vendas_periodo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_relatorio_vendas_periodo`(
    IN data_inicio DATE,
    IN data_fim DATE,
    IN categoria_produto VARCHAR(100)
)
proc: BEGIN -- Inicia begin de processamento da SP
    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Declaração da variavel de controle
    DECLARE p_co_categoria INT;
    SET p_co_categoria = (SELECT co_categoria FROM tb_categoria WHERE no_categoria = categoria_produto LIMIT 1);
    -- SELECT p_co_categoria;

    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Validação dos parametros

    -- Valida Data inicial obrigatória
    IF data_inicio IS NULL THEN
        SELECT 'Parâmetro data_inicio é obrigatório.' AS mensagem_erro;
        LEAVE proc;
    END IF;

    -- Valida Data final obrigatória
    IF data_fim IS NULL THEN
        SELECT 'Parâmetro data_fim é obrigatório.' AS mensagem_erro;
        LEAVE proc;
    END IF;
    
    -- Valida se Intervalo é Válido
    IF data_inicio > data_fim THEN
        SELECT CONCAT('Data inicial (', data_inicio,') não pode ser maior que a data final (', data_fim, ').') AS mensagem_erro;
        LEAVE proc;
    END IF;
    
    -- Valida Categoria
    IF categoria_produto IS NOT NULL
       AND TRIM(categoria_produto) <> ''
       AND p_co_categoria IS NULL
    THEN
        SELECT CONCAT('Categoria não encontrada: ', categoria_produto) AS mensagem_erro;
        LEAVE proc;
    END IF;


    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Total de pedidos. | Soma do valor total dos pedidos. | Média por pedido.

    -- Versão 1 
    -- Busca pelo Total do Pedido
--     SELECT  -- 'Versão 1 - Busca pelo Total do Pedido' AS origem,
--             COUNT(ped.co_pedido) AS total_pedidos,
--             CAST(COALESCE(SUM(ped.vl_total_pedido), 0) as DECIMAL(10,2)) AS valor_total_vendas,
--             CAST(COALESCE(AVG(ped.vl_total_pedido), 0) as DECIMAL(10,2)) AS media_por_pedido
--     FROM tb_pedido ped
--     WHERE CAST(ped.dt_pedido AS DATE) BETWEEN data_inicio AND data_fim
--     /* -- Se o filtro de categoria impactar o Totalizador
--       AND ( p_co_categoria IS NULL
--             OR EXISTS ( SELECT 1
--                         FROM tb_item_pedido ip2
--                         JOIN tb_produto pr ON pr.co_produto = ip2.co_produto
--                         WHERE ip2.co_pedido = ped.co_pedido
--                           AND pr.co_categoria = p_co_categoria
--                         )
--             )
--         */
--     ;


    -- Versão 2 
    -- Busca pelo Somatorio dos Itens do Pedido
    WITH
    pedidos AS
    (
        SELECT  ped.co_pedido,
                SUM(ip.qt_produto * ip.vl_unitario) AS total_pedido
        FROM tb_pedido ped
        JOIN tb_item_pedido ip ON ip.co_pedido = ped.co_pedido
        WHERE CAST(ped.dt_pedido AS DATE) BETWEEN data_inicio AND data_fim
--      /* -- Se o filtro de categoria impactar o Totalizador
--        AND ( p_co_categoria IS NULL
--              OR EXISTS ( SELECT 1
--                          FROM tb_item_pedido ip2
--                          JOIN tb_produto pr ON pr.co_produto = ip2.co_produto
--                          WHERE ip2.co_pedido = ped.co_pedido
--                            AND pr.co_categoria = p_co_categoria
--                          )
--            )
--         */
        GROUP BY ped.co_pedido
    )
    SELECT  -- 'Versão 2 - Busca pelo Somatorio dos Itens do Pedido' AS origem,
            COUNT(co_pedido) AS total_pedidos,
            CAST(COALESCE(SUM(total_pedido), 0) AS DECIMAL(10,2)) AS valor_total_vendas,
            CAST(COALESCE(AVG(total_pedido), 0) AS DECIMAL(10,2)) AS media_por_pedido
    FROM pedidos;



    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Lista de produtos da categoria filtrada e quantidades vendidas no período.
    SELECT  cat.co_categoria, cat.no_categoria,
            pr.co_produto, pr.no_produto,
            SUM(ip.qt_produto) AS quantidade_vendida
    FROM tb_pedido ped
    JOIN tb_item_pedido ip ON ip.co_pedido = ped.co_pedido
    JOIN tb_produto pr on pr.co_produto = ip.co_produto
    JOIN tb_categoria cat on cat.co_categoria = pr.co_Categoria
    WHERE CAST(ped.dt_pedido AS DATE) BETWEEN data_inicio AND data_fim
      AND (pr.co_categoria = p_co_categoria)
      /* -- Se o filtro de categoria Null retornar tudo
      AND (pr.co_categoria = p_co_categoria OR p_co_categoria is null)
      */
    GROUP BY cat.co_categoria, cat.no_categoria,
             pr.co_produto, pr.no_produto
    ;


    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `vw_verifica_pedido_total`
--

/*!50001 DROP VIEW IF EXISTS `vw_verifica_pedido_total`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_verifica_pedido_total` AS select `ped`.`CO_PEDIDO` AS `co_pedido`,`ped`.`VL_TOTAL_PEDIDO` AS `vl_total_pedido`,cast(sum((`ip`.`QT_PRODUTO` * `ip`.`VL_UNITARIO`)) as decimal(10,2)) AS `vl_total_itens`,(case when (`ped`.`VL_TOTAL_PEDIDO` = sum((`ip`.`QT_PRODUTO` * `ip`.`VL_UNITARIO`))) then 'OK' else 'INCONSISTENCIA' end) AS `st_conferencia` from (`tb_pedido` `ped` join `tb_item_pedido` `ip` on((`ip`.`CO_PEDIDO` = `ped`.`CO_PEDIDO`))) group by `ped`.`CO_PEDIDO`,`ped`.`VL_TOTAL_PEDIDO` order by `ped`.`CO_PEDIDO` */;
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

-- Dump completed on 2026-06-19  1:23:11
