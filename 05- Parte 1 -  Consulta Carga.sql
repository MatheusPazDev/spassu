USE spassu_desafio;

SELECT * FROM tb_cliente;
SELECT * FROM tb_endereco_cliente;
SELECT * FROM tb_categoria;
SELECT * FROM tb_produto;
SELECT * FROM tb_status_pedido;
SELECT * FROM tb_pedido;
SELECT * FROM tb_item_pedido;
SELECT * FROM vw_verifica_pedido_total;
--
SELECT * FROM tb_usuario;
SELECT * FROM tb_recurso_acao_processo;

--
-- SELECT * FROM tb_usuario WHERE no_usuario = 'SISTEMA';      -- MOCK para o usuario SISTEMA
-- SELECT * FROM tb_usuario WHERE no_usuario = 'SISTEMA DSV' ; -- MOCK para o usuario SISTEMA em DSV
-- SELECT * FROM tb_usuario WHERE no_usuario = 'SISTEMA HMG';  -- MOCK para o usuario SISTEMA em HMG
-- SELECT * FROM tb_usuario WHERE no_usuario = 'SISTEMA PRD' ; -- MOCK para o usuario SISTEMA em PRD