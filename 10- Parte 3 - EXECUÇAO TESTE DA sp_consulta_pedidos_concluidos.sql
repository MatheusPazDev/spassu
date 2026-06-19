USE spassu_desafio;

-- 1- Erro de valor_minimo null
CALL sp_consulta_pedidos_status_valor(null, null);

-- 2- Erro de valor_minimo null
CALL sp_consulta_pedidos_status_valor(10, 'Status_Que_Não_Existe');

-- 3- Execução com Sucesso - Todas as categorias e todos valores
CALL sp_consulta_pedidos_status_valor(0, NULL);

-- 4- Execução com Sucesso - Exemplifica a Inconsitencia de manter o valor_total na TB_PEDIDO
CALL sp_consulta_pedidos_status_valor(1000, 'concluido'); 

-- 5- Execução com Sucesso
CALL sp_consulta_pedidos_status_valor(100, 'pago'); 

-- 6- Execução com Sucesso - Sem retorno 
CALL sp_consulta_pedidos_status_valor(10, 'cancelado'); 