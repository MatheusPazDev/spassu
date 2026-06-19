CREATE SCHEMA IF NOT EXISTS spassu_desafio;
USE spassu_desafio;

-- ========================================================================== --
-- PARTE 1 - MODELO FISICO                                                    --
-- ========================================================================== --

DROP TABLE IF EXISTS TB_ITEM_PEDIDO;
DROP TABLE IF EXISTS TB_PEDIDO;
DROP TABLE IF EXISTS TB_STATUS_PEDIDO;
DROP TABLE IF EXISTS TB_PRODUTO;
DROP TABLE IF EXISTS TB_CATEGORIA;
DROP TABLE IF EXISTS TB_ENDERECO_CLIENTE;
DROP TABLE IF EXISTS TB_CLIENTE;
DROP TABLE IF EXISTS TB_RECURSO_ACAO_PROCESSO;
DROP TABLE IF EXISTS TB_USUARIO;
--
DROP VIEW IF EXISTS vw_verifica_pedido_total;
--
DROP PROCEDURE IF EXISTS sp_relatorio_vendas_periodo;
DROP PROCEDURE IF EXISTS sp_consulta_pedidos_status_valor;

-- =====================================
-- TB_CLIENTE
-- =====================================
CREATE TABLE TB_CLIENTE (
    CO_CLIENTE INT AUTO_INCREMENT COMMENT 'PK da tabela',
    NO_CLIENTE VARCHAR(150) NOT NULL COMMENT 'Nome completo',
    NU_CPF CHAR(11) NOT NULL COMMENT 'CPF do cliente',
    DS_EMAIL VARCHAR(150) NOT NULL COMMENT 'Endereço de e-mail do cliente',
    DT_NASCIMENTO DATE NOT NULL COMMENT 'Data de nascimento do cliente',

    CONSTRAINT PK_TB_CLIENTE PRIMARY KEY (CO_CLIENTE)
) COMMENT = 'Armazena os dados cadastrais dos clientes';


-- =====================================
-- TB_ENDERECO_CLIENTE
-- =====================================
CREATE TABLE TB_ENDERECO_CLIENTE (
    CO_ENDERECO_CLIENTE INT AUTO_INCREMENT COMMENT 'PK da tabela',
    CO_CLIENTE INT NOT NULL COMMENT 'FK para a tabela TB_CLIENTE',
    DS_LOGRADOURO VARCHAR(150) NOT NULL COMMENT 'Rua, avenida ou logradouro',
    NU_ENDERECO VARCHAR(20) NOT NULL COMMENT 'Número do endereço',
    DS_COMPLEMENTO VARCHAR(100) COMMENT 'Complemento do endereço',
    NO_BAIRRO VARCHAR(100) NOT NULL COMMENT 'Nome do bairro',
    NO_CIDADE VARCHAR(100) NOT NULL COMMENT 'Nome da cidade',
    SG_UF CHAR(2) NOT NULL COMMENT 'Sigla da UF',
    NU_CEP CHAR(8) NOT NULL COMMENT 'CEP do endereço',
    ST_PRINCIPAL CHAR(1) NOT NULL DEFAULT 'N' COMMENT 'Indica se o endereço é o principal (S ou N)',

    CONSTRAINT PK_TB_ENDERECO_CLIENTE PRIMARY KEY (CO_ENDERECO_CLIENTE),
    CONSTRAINT FK_ENDERECO_CLIENTE_CLIENTE
        FOREIGN KEY (CO_CLIENTE)
        REFERENCES TB_CLIENTE (CO_CLIENTE)
        ON UPDATE RESTRICT -- CASCADE | NO ACTION | SET NULL
        ON DELETE RESTRICT,
    CONSTRAINT CK_ENDERECO_PRINCIPAL CHECK (ST_PRINCIPAL IN ('S', 'N'))
) COMMENT = 'Armazena os endereços vinculados aos clientes';


-- =====================================
-- TB_CATEGORIA
-- =====================================
CREATE TABLE TB_CATEGORIA (
    CO_CATEGORIA INT AUTO_INCREMENT COMMENT 'PK da tabela',
    NO_CATEGORIA VARCHAR(100) NOT NULL COMMENT 'Nome da categoria',

    CONSTRAINT PK_TB_CATEGORIA PRIMARY KEY (CO_CATEGORIA)
) COMMENT = 'Armazena as categorias utilizadas para classificação dos produtos';


-- =====================================
-- TB_PRODUTO
-- =====================================
CREATE TABLE TB_PRODUTO (
    CO_PRODUTO INT AUTO_INCREMENT COMMENT 'PK da tabela',
    CO_CATEGORIA INT NOT NULL COMMENT 'FK para a tabela TB_CATEGORIA',
    NO_PRODUTO VARCHAR(150) NOT NULL COMMENT 'Nome do produto',
    VL_PRECO DECIMAL(10,2) NOT NULL COMMENT 'Preço unitário atual',

    CONSTRAINT PK_TB_PRODUTO PRIMARY KEY (CO_PRODUTO),
    CONSTRAINT FK_PRODUTO_CATEGORIA
        FOREIGN KEY (CO_CATEGORIA)
        REFERENCES TB_CATEGORIA (CO_CATEGORIA)
        ON UPDATE RESTRICT
) COMMENT = 'Armazena os produtos disponíveis para venda';


-- =====================================
-- TB_STATUS_PEDIDO
-- =====================================
CREATE TABLE TB_STATUS_PEDIDO (
    CO_STATUS_PEDIDO INT AUTO_INCREMENT COMMENT 'PK da tabela',
    NO_STATUS_PEDIDO VARCHAR(50) NOT NULL COMMENT 'Status do pedido',

    CONSTRAINT PK_TB_STATUS_PEDIDO PRIMARY KEY (CO_STATUS_PEDIDO)
) COMMENT = 'Tabela de domínio contendo os possíveis status dos pedidos';


-- =====================================
-- TB_PEDIDO
-- =====================================
CREATE TABLE TB_PEDIDO (
    CO_PEDIDO INT AUTO_INCREMENT COMMENT 'PK da tabela',
    CO_CLIENTE INT NOT NULL COMMENT 'FK para a tabela TB_CLIENTE',
    CO_ENDERECO_CLIENTE INT NOT NULL COMMENT 'FK para a tabela TB_ENDERECO_CLIENTE. Endereço da entrega.',
    CO_STATUS_PEDIDO INT NOT NULL COMMENT 'FK para a tabela TB_STATUS_PEDIDO',
    DT_PEDIDO DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data e hora de criação do pedido',
    VL_TOTAL_PEDIDO DECIMAL(12,2) NOT NULL COMMENT 'Valor total do pedido calculado a partir dos itens',

    CONSTRAINT PK_TB_PEDIDO PRIMARY KEY (CO_PEDIDO),
    CONSTRAINT FK_PEDIDO_CLIENTE
        FOREIGN KEY (CO_CLIENTE)
        REFERENCES TB_CLIENTE (CO_CLIENTE)
        ON UPDATE RESTRICT,
    CONSTRAINT FK_PEDIDO_ENDERECO
        FOREIGN KEY (CO_ENDERECO_CLIENTE)
        REFERENCES TB_ENDERECO_CLIENTE (CO_ENDERECO_CLIENTE)
        ON UPDATE RESTRICT,
    CONSTRAINT FK_PEDIDO_STATUS
        FOREIGN KEY (CO_STATUS_PEDIDO)
        REFERENCES TB_STATUS_PEDIDO (CO_STATUS_PEDIDO)
        ON UPDATE RESTRICT

) COMMENT = 'Armazena o cabeçalho dos pedidos realizados pelos clientes';


-- =====================================
-- TB_ITEM_PEDIDO
-- =====================================
CREATE TABLE TB_ITEM_PEDIDO (
    CO_ITEM_PEDIDO INT AUTO_INCREMENT COMMENT 'PK da tabela',
    CO_PEDIDO INT NOT NULL COMMENT 'FK para a tabela TB_PEDIDO',
    CO_PRODUTO INT NOT NULL COMMENT 'FK para a tabela TB_PRODUTO',
    QT_PRODUTO INT NOT NULL COMMENT 'Quantidade do produto solicitada no pedido',
    VL_UNITARIO DECIMAL(10,2) NOT NULL COMMENT 'Valor unitário do produto no momento da compra',

    CONSTRAINT PK_TB_ITEM_PEDIDO PRIMARY KEY (CO_ITEM_PEDIDO),
    CONSTRAINT FK_ITEM_PEDIDO_PEDIDO
        FOREIGN KEY (CO_PEDIDO)
        REFERENCES TB_PEDIDO (CO_PEDIDO)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,
    CONSTRAINT FK_ITEM_PEDIDO_PRODUTO
        FOREIGN KEY (CO_PRODUTO)
        REFERENCES TB_PRODUTO (CO_PRODUTO)
        ON UPDATE RESTRICT

) COMMENT = 'Armazena os itens que compõem cada pedido';


-- =====================================
-- VW_VERIFICA_PEDIDO_TOTAL
-- =====================================

CREATE OR REPLACE VIEW vw_verifica_pedido_total AS
SELECT  ped.co_pedido,
        ped.vl_total_pedido,

        CAST(
            SUM(ip.qt_produto * ip.vl_unitario)
            AS DECIMAL(10,2)
        ) AS vl_total_itens,

        CASE
            WHEN ped.vl_total_pedido =
                 SUM(ip.qt_produto * ip.vl_unitario)
            THEN 'OK'
            ELSE 'INCONSISTENCIA'
        END AS st_conferencia
FROM tb_pedido ped
INNER JOIN tb_item_pedido ip ON ip.co_pedido = ped.co_pedido
GROUP BY ped.co_pedido,
         ped.vl_total_pedido
ORDER BY ped.co_pedido;



-- ========================================================================== --
-- PARTE 4 - MIGRATIONS                                                       --
-- ========================================================================== --


-- =====================================
-- TB_USUARIO
-- =====================================
CREATE TABLE TB_USUARIO (
    CO_USUARIO INT AUTO_INCREMENT COMMENT 'PK da tabela',
    NO_USUARIO VARCHAR(50) NOT NULL COMMENT 'Nome do usuário',
    CONSTRAINT PK_TB_USUARIO PRIMARY KEY (CO_USUARIO)
) COMMENT = 'Tabela de domínio contendo os possíveis status dos pedidos';


-- =====================================
-- TB_RECURSO_ACAO_PROCESSO 
-- =====================================
CREATE TABLE TB_RECURSO_ACAO_PROCESSO (
    CO_RECURSO_ACAO_PROCESSO INT AUTO_INCREMENT COMMENT 'PK da tabela',
    NO_RECURSO_ACAO_PROCESSO VARCHAR(50) NOT NULL COMMENT 'Nome do recurso acao',
    ST_ATIVO BOOLEAN NOT NULL COMMENT 'Flag indicativa se o registro está ativo',
    DT_INCLUSAO DATETIME NOT NULL COMMENT 'Data de criação',
    CO_USUARIO_INCLUSAO INT NOT NULL COMMENT 'FK para a tabela TB_USUARIO',

    CONSTRAINT PK_TB_RECURSO_ACAO_PROCESSO PRIMARY KEY (CO_RECURSO_ACAO_PROCESSO),
    CONSTRAINT FK_RECURSO_ACAO_PROCESSO_USUARIO
        FOREIGN KEY (CO_USUARIO_INCLUSAO)
        REFERENCES TB_USUARIO (CO_USUARIO)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,
    CONSTRAINT UK_TB_RECURSO_ACAO_PROCESSO_NOME
        UNIQUE (NO_RECURSO_ACAO_PROCESSO)
) COMMENT = 'Tabela de domínio contendo os possíveis status dos pedidos';
