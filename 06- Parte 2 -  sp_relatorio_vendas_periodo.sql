USE spassu_desafio;

DROP PROCEDURE IF EXISTS sp_relatorio_vendas_periodo;

DELIMITER //
CREATE PROCEDURE sp_relatorio_vendas_periodo 
(
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
END//
DELIMITER ;