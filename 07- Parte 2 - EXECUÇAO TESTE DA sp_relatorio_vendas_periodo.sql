USE spassu_desafio;

-- 1- Erro de data inicio null
CALL sp_relatorio_vendas_periodo (
    null,
    null,
    null
);

-- 2- Erro de data fim null
CALL sp_relatorio_vendas_periodo (
    '2026-05-01',
    null,
    null
);

-- 3- Erro de intevalo de data
CALL sp_relatorio_vendas_periodo (
    '2026-05-31',
    '2026-05-01',
    null
);

-- 4- Erro Categoria Invalida
CALL sp_relatorio_vendas_periodo (
    '2026-05-01',
    '2026-05-31',
    'Categoria_Que_Não_Existe'
);

-- 5- Execução com Sucesso
CALL sp_relatorio_vendas_periodo (
    '2026-05-09',
    '2026-05-10',
    'informatica'
);

-- 6- Execução com Sucesso -- Se categoria NULL não vai retornar nada, para mostrar tudo descomentar o filtro na SP
CALL sp_relatorio_vendas_periodo (
    '2026-05-09',
    '2026-05-10',
    NULL
);

-- 7- Execução com Sucesso -- Evidenciando a Inconsitencia de deixar o valor total na tabela de pedido.
CALL sp_relatorio_vendas_periodo (
    '2026-05-01',
    '2026-05-01',
    'Eletrônico'
);
SELECT * FROM tb_pedido WHERE CAST(dt_pedido AS DATE) BETWEEN '2026-05-01' AND '2026-05-01' ;


