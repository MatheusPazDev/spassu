USE spassu_desafio;

-- ========================================================================== --
-- PARTE 1 - MODELO FISICO                                                    --
-- ========================================================================== --

-- =====================================
-- LIMPA O BANCO PARA RECEBER A CARGA
-- =====================================
SET FOREIGN_KEY_CHECKS = 0; -- Inativa a verificação de FK para os truncates

TRUNCATE TABLE TB_ITEM_PEDIDO;
TRUNCATE TABLE TB_PEDIDO;
TRUNCATE TABLE TB_STATUS_PEDIDO;
TRUNCATE TABLE TB_PRODUTO;
TRUNCATE TABLE TB_CATEGORIA;
TRUNCATE TABLE TB_ENDERECO_CLIENTE;
TRUNCATE TABLE TB_CLIENTE;
-- 
TRUNCATE TABLE TB_RECURSO_ACAO_PROCESSO;
TRUNCATE TABLE TB_USUARIO;

SET FOREIGN_KEY_CHECKS = 1; -- Ativa a verificação de FK


-- =====================================
-- TB_CLIENTE
-- =====================================
INSERT INTO TB_CLIENTE
(
    NO_CLIENTE,
    NU_CPF,
    DS_EMAIL,
    DT_NASCIMENTO
)
VALUES
('João', '11111111111', 'joao@email.com', '2000-05-10'),
('Maria', '22222222222', 'maria@email.com', '2000-08-15'),
('Pedro', '33333333333', 'pedro@email.com', '2000-03-22'),
('Luana', '44444444444', 'luana@email.com', '2000-11-30'),
('Carlos', '55555555555', 'carlos@email.com', '2000-01-12'),
('Juliana', '66666666666', 'juliana@email.com', '2000-07-18'),
('Fernanda', '77777777777', 'fernanda@email.com', '2000-09-05'),
('Ricardo', '88888888888', 'ricardo@email.com', '2000-12-20'),
('Patricia', '99999999999', 'patricia@email.com', '2000-04-28'),
('Lucas', '10101010101', 'lucas@email.com', '2000-06-14');

-- =====================================
-- TB_ENDERECO_CLIENTE
-- =====================================
INSERT INTO TB_ENDERECO_CLIENTE
(
    CO_CLIENTE,
    DS_LOGRADOURO,
    NU_ENDERECO,
    DS_COMPLEMENTO,
    NO_BAIRRO,
    NO_CIDADE,
    SG_UF,
    NU_CEP,
    ST_PRINCIPAL
)
VALUES
(1,'Rua A','100',NULL,'Centro','São Paulo','SP','1000000','N'),
(1,'Rua A2','101',NULL,'Centro','São Paulo','SP','1000001','S'),
(2,'Rua B','200',NULL,'Centro','São Paulo','SP','1000005','S'),
(3,'Rua C','300',NULL,'Jardim','Campinas','SP','2000000','S'),
(4,'Rua D','400','Apto 12','Centro','Rio de Janeiro','RJ','3000000','S'),
(5,'Rua E','500',NULL,'Centro','Belo Horizonte','MG','40000000','S'),
(6,'Rua F','600',NULL,'Jardim','Curitiba','PR','50000000','S'),
(7,'Rua G','700','Casa','Centro','Porto Alegre','RS','60000000','S'),
(8,'Rua H','800',NULL,'Centro','Salvador','BA','70000000','S'),
(9,'Rua I','900',NULL,'Jardim','Recife','PE','80000000','S'),
(10,'Rua J','1000',NULL,'Centro','Brasília','DF','90000000','S');

-- =====================================
-- TB_CATEGORIA
-- =====================================
INSERT INTO TB_CATEGORIA
(NO_CATEGORIA)
VALUES
('Eletrônico'),
('Informática'),
('Livro'),
('Casa'),
('Esporte');

-- =====================================
-- TB_PRODUTO
-- =====================================
INSERT INTO TB_PRODUTO
(
    CO_CATEGORIA,
    NO_PRODUTO,
    VL_PRECO
)
VALUES
(1,'Fone Bluetooth',150.00),
(1,'Caixa de Som',200.00),
(2,'Mouse USB',60.00),
(2,'Teclado USB',90.00),
(2,'Monitor 24',900.00),
(3,'Livro SQL',80.00),
(3,'Livro Java',100.00),
(4,'Luminária',50.00),
(4,'Cadeira',300.00),
(5,'Bola Futebol',90.00);

-- =====================================
-- TB_STATUS_PEDIDO
-- =====================================
INSERT INTO TB_STATUS_PEDIDO
(NO_STATUS_PEDIDO)
VALUES
('Pendente'),
('Pago'),
('Enviado'),
('Entregue'),
('Cancelado'),
('Concluido');

-- =====================================
-- TB_PEDIDO
-- =====================================
INSERT INTO TB_PEDIDO
(
    CO_CLIENTE,
    CO_ENDERECO_CLIENTE,
    CO_STATUS_PEDIDO,
    DT_PEDIDO,
    VL_TOTAL_PEDIDO
)
VALUES
(1,1,6,'2026-05-01 10:00:00',210.00), -- 150 + 60 + (2 x 700) <Valor incorreto para exemplificar inconsistência>
(1,2,2,'2026-05-02 11:00:00',900.00), -- 900
(3,3,3,'2026-05-03 14:00:00',180.00), -- 2 x 90
(4,4,1,'2026-05-04 16:00:00',300.00), -- 300
(5,5,4,'2026-05-05 09:00:00',150.00), -- 150
(6,6,2,'2026-05-06 15:00:00',170.00), -- 80 + 90
(7,7,6,'2026-05-07 18:00:00',90.00),  -- 90
(8,8,6,'2026-05-08 13:00:00',100.00), -- 100
(9,9,3,'2026-05-09 10:30:00',350.00), -- 50 + 300
(10,10,1,'2026-05-10 17:00:00',1100.00); -- 900 + 200

-- =====================================
-- TB_ITEM_PEDIDO
-- =====================================
INSERT INTO TB_ITEM_PEDIDO
(
    CO_PEDIDO,
    CO_PRODUTO,
    QT_PRODUTO,
    VL_UNITARIO
)
VALUES
(1,1,1,150.00),
(1,3,1,60.00),
(1,5,2,700.00), -- <Removido da TB_PEDIDO para exemplificar inconsistência>

(2,5,1,900.00),

(3,10,2,90.00),

(4,9,1,300.00),

(5,1,1,150.00),

(6,6,1,80.00),
(6,10,1,90.00),

(7,10,1,90.00),

(8,7,1,100.00),

(9,8,1,50.00),
(9,9,1,300.00),

(10,5,1,900.00),
(10,2,1,200.00);

-- ========================================================================== --
-- PARTE 4 - MIGRATIONS                                                       --
-- ========================================================================== --

-- =====================================
-- TB_USUARIO
-- =====================================
INSERT INTO TB_USUARIO
(NO_USUARIO)
VALUES
('SISTEMA'),
('Administrador'),
('Usuario 1'),
('Usuario 2'),
('SISTEMA DSV'), -- Mock do usuario para ambiente de DSV
('Usuario 3'),
('Usuario A'),
('SISTEMA HMG'), -- Mock do usuario para ambiente de HMG
('Usuario B'),
('Usuario C'),
('SISTEMA PRD'); -- Mock do usuario para ambiente de PRD


-- =====================================
-- TB_RECURSO_ACAO_PROCESSO
-- =====================================
INSERT INTO TB_RECURSO_ACAO_PROCESSO
(
    NO_RECURSO_ACAO_PROCESSO,
    ST_ATIVO,
    DT_INCLUSAO,
    CO_USUARIO_INCLUSAO
)
VALUES
('Cadastrar Cliente', TRUE, '2026-01-10 08:00:00', 1),
('Alterar Cliente', TRUE, '2026-01-10 08:05:00', 1),
('Excluir Cliente', TRUE, '2026-01-10 08:10:00', 1),
('Consultar Cliente', TRUE, '2026-01-10 08:15:00', 1)
;

/*
INSERT INTO TB_RECURSO_ACAO_PROCESSO
(   
    CO_RECURSO_ACAO_PROCESSO,
    NO_RECURSO_ACAO_PROCESSO,
    ST_ATIVO,
    DT_INCLUSAO,
    CO_USUARIO_INCLUSAO
)
VALUES
(532, 'Vincular boleto', FALSE, '2026-01-12 10:30:00', 1)
;
*/

