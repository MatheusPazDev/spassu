USE spassu_desafio;

DROP PROCEDURE IF EXISTS sp_consulta_pedidos_status_valor;

DELIMITER //
CREATE PROCEDURE sp_consulta_pedidos_status_valor
(
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

END//
DELIMITER ;