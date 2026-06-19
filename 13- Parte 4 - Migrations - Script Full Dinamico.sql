USE spassu_desafio;

-- SELECT * FROM tb_recurso_acao_processo;
-- ALTER TABLE TB_RECURSO_ACAO_PROCESSO AUTO_INCREMENT = 1;
START TRANSACTION;

    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Declarção das variáveis a serem inseridas
    SET @V_CO_RECURSO_ACAO_PROCESSO = 532; -- NULL para utilizar AUTO_INCREMENT
    SET @V_RECURSO_ACAO_PROCESSO_NOVO = 'Vincular boleto';

    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Inicia as váriaveis de operação.
    SET @CO_USUARIO_SISTEMA = ( SELECT co_usuario
                                FROM tb_usuario
                                -- WHERE no_usuario = 'SISTEMA'
                                -- WHERE no_usuario = 'SISTEMA DSV' -- Mock do usuario para ambiente de DSV
                                -- WHERE no_usuario = 'SISTEMA HMG' -- Mock do usuario para ambiente de HMG
                                WHERE no_usuario = 'SISTEMA PRD' -- Mock do usuario para ambiente de PRD
                                LIMIT 1
                                )
    ;

    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Localiza registro pelo nome
    SET @CO_RECURSO_ACAO_PROCESSO_NOME = (  SELECT co_recurso_acao_processo
                                            FROM tb_recurso_acao_processo
                                            WHERE no_recurso_acao_processo = @V_RECURSO_ACAO_PROCESSO_NOVO
                                            LIMIT 1
                                            )
    ;

    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Localiza registro pela PK informada
    SET @CO_RECURSO_ACAO_PROCESSO_PK = (    SELECT co_recurso_acao_processo
                                            FROM tb_recurso_acao_processo
                                            WHERE co_recurso_acao_processo = @V_CO_RECURSO_ACAO_PROCESSO
                                            LIMIT 1
                                            )
    ;

    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Variáveis de retorno
    SET @CO_RECURSO_ACAO_PROCESSO_REATIVADO = NULL;
    SET @CO_RECURSO_ACAO_PROCESSO_INSERIDO  = NULL;

    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- REATIVA O REGISTRO CASO EXISTA E ESTEJA INATIVO
    UPDATE tb_recurso_acao_processo
       SET st_ativo             = TRUE,
           co_usuario_inclusao  = @CO_USUARIO_SISTEMA,
           dt_inclusao          = NOW()
     WHERE co_recurso_acao_processo = @CO_RECURSO_ACAO_PROCESSO_PK
       AND st_ativo = FALSE;

    -- Guarda o ID reativado
    SET @CO_RECURSO_ACAO_PROCESSO_REATIVADO =
        IF(
            ROW_COUNT() > 0, @CO_RECURSO_ACAO_PROCESSO_PK,
            NULL
        );

    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- INSERT COM PK FIXA
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
    WHERE @V_CO_RECURSO_ACAO_PROCESSO IS NOT NULL
      AND @V_RECURSO_ACAO_PROCESSO_NOVO IS NOT NULL
      AND TRIM(@V_RECURSO_ACAO_PROCESSO_NOVO) <> ''
      AND @CO_USUARIO_SISTEMA IS NOT NULL
      AND @CO_RECURSO_ACAO_PROCESSO_NOME IS NULL
      AND @CO_RECURSO_ACAO_PROCESSO_PK IS NULL;

    -- Guarda PK inserida (cenário PK fixa)
    SET @CO_RECURSO_ACAO_PROCESSO_INSERIDO =
        IF(
            ROW_COUNT() > 0,
            @V_CO_RECURSO_ACAO_PROCESSO,
            NULL
        );

    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- INSERT COM AUTO_INCREMENT
    INSERT INTO tb_recurso_acao_processo
    (
        no_recurso_acao_processo,
        st_ativo,
        dt_inclusao,
        co_usuario_inclusao
    )
    SELECT  @V_RECURSO_ACAO_PROCESSO_NOVO,
            TRUE,
            NOW(),
            @CO_USUARIO_SISTEMA
    WHERE @V_CO_RECURSO_ACAO_PROCESSO IS NULL
      AND @V_RECURSO_ACAO_PROCESSO_NOVO IS NOT NULL
      AND TRIM(@V_RECURSO_ACAO_PROCESSO_NOVO) <> ''
      AND @CO_USUARIO_SISTEMA IS NOT NULL
      AND @CO_RECURSO_ACAO_PROCESSO_NOME IS NULL;

    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Guarda PK inserida (cenário AUTO_INCREMENT)
    SET @CO_RECURSO_ACAO_PROCESSO_INSERIDO =
        IF(
            @CO_RECURSO_ACAO_PROCESSO_INSERIDO IS NULL
            AND ROW_COUNT() > 0,
            LAST_INSERT_ID(),
            @CO_RECURSO_ACAO_PROCESSO_INSERIDO
        );

    -- ------------------------------------------------------------------------------------------------------------------------------------------------------
    -- RESULTADO
    SELECT CAST(CASE
                    WHEN @CO_USUARIO_SISTEMA IS NULL
                        THEN 'ERROR: Não foi possível localizar o usuário SISTEMA.'
                    WHEN @V_CO_RECURSO_ACAO_PROCESSO IS NOT NULL
                     AND @CO_RECURSO_ACAO_PROCESSO_NOME IS NOT NULL
                     AND @CO_RECURSO_ACAO_PROCESSO_NOME <> @V_CO_RECURSO_ACAO_PROCESSO
                        THEN CONCAT('ERROR: O recurso já existe com a PK ', COALESCE(@CO_RECURSO_ACAO_PROCESSO_NOME, ''), ', diferente da PK esperada ', COALESCE(@V_CO_RECURSO_ACAO_PROCESSO, ''))
                    WHEN @CO_RECURSO_ACAO_PROCESSO_PK IS NOT NULL
                     AND @CO_RECURSO_ACAO_PROCESSO_NOME IS NULL
                        THEN CONCAT('ERROR: A PK ', COALESCE(@V_CO_RECURSO_ACAO_PROCESSO, ''), ' já está sendo utilizada por outro registro.')
                    WHEN @CO_RECURSO_ACAO_PROCESSO_INSERIDO IS NOT NULL
                        THEN CONCAT('SUCESSO: Registro inserido: ', COALESCE(@CO_RECURSO_ACAO_PROCESSO_INSERIDO, ''))
                    WHEN @CO_RECURSO_ACAO_PROCESSO_REATIVADO IS NOT NULL
                        THEN CONCAT('SUCESSO: Registro reativado: ', COALESCE(@CO_RECURSO_ACAO_PROCESSO_REATIVADO, ''))
                    WHEN @CO_RECURSO_ACAO_PROCESSO_NOME IS NOT NULL
                        THEN CONCAT('SUCESSO: Registro já existe e está ativo: ', COALESCE(@CO_RECURSO_ACAO_PROCESSO_NOME, ''))
                ELSE 'ERROR DESCONHECIDO'
            END AS CHAR(500)) AS MENSAGEM
    ;

COMMIT;

-- ------------------------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
/*
SELECT
    @V_RECURSO_ACAO_PROCESSO_NOVO,
    @V_CO_RECURSO_ACAO_PROCESSO,
    @CO_USUARIO_SISTEMA,
    @CO_RECURSO_ACAO_PROCESSO_NOME,
    @CO_RECURSO_ACAO_PROCESSO_PK,
    @CO_RECURSO_ACAO_PROCESSO_REATIVADO,
    @CO_RECURSO_ACAO_PROCESSO_INSERIDO;
*/

-- SELECT * FROM tb_recurso_acao_processo;

