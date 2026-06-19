USE spassu_desafio;

-- SELECT * FROM tb_recurso_acao_processo;
-- ALTER TABLE TB_RECURSO_ACAO_PROCESSO AUTO_INCREMENT = 1;
START TRANSACTION;

    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Inicia as váriaveis de operação.
    SET @V_CO_RECURSO_ACAO_PROCESSO   = null;  -- NULL para utilizar AUTO_INCREMENT
    SET @V_RECURSO_ACAO_PROCESSO_NOVO = 'Vincular boleto';

    SET @CO_USUARIO_SISTEMA = ( SELECT co_usuario
                                FROM tb_usuario
                                -- WHERE no_usuario = 'SISTEMA'
                                -- WHERE no_usuario = 'SISTEMA DSV' -- Mock do usuario para ambiente de DSV
                                WHERE no_usuario = 'SISTEMA HMG' -- Mock do usuario para ambiente de HMG
                                -- WHERE no_usuario = 'SISTEMA PRD' -- Mock do usuario para ambiente de PRD
                                LIMIT 1
                                )
    ;

    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- 
    INSERT INTO tb_recurso_acao_processo
    (
        co_recurso_acao_processo,
        no_recurso_acao_processo,
        st_ativo,
        dt_inclusao,
        co_usuario_inclusao
    )
    SELECT  @V_CO_RECURSO_ACAO_PROCESSO,
            @V_RECURSO_ACAO_PROCESSO_NOVO,
            TRUE,
            NOW(),
            @CO_USUARIO_SISTEMA
    WHERE @CO_USUARIO_SISTEMA IS NOT NULL
      AND @V_RECURSO_ACAO_PROCESSO_NOVO IS NOT NULL
      AND TRIM(@V_RECURSO_ACAO_PROCESSO_NOVO) <> ''
      AND NOT EXISTS (  SELECT 1
                        FROM tb_recurso_acao_processo
                        WHERE ( @V_CO_RECURSO_ACAO_PROCESSO IS NOT NULL
                                AND co_recurso_acao_processo = @V_CO_RECURSO_ACAO_PROCESSO)
                           OR no_recurso_acao_processo = @V_RECURSO_ACAO_PROCESSO_NOVO
                        )
    ;

    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- RETORNO
    SELECT CASE WHEN row_count()>0 THEN 'Registro Inserido' ELSE 'Registro Não inserido' END AS MENSAGEM;

COMMIT;

-- SELECT * FROM tb_recurso_acao_processo