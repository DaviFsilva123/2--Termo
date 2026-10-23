-- ============================================================
-- AULA 09 - ATIVIDADE PRÁTICA DE DQL
-- Nome: Davi Ferreira da Silva
-- Turma: 2Devis Data: 09/10/26
-- Base: smartcoffee_dql
-- ============================================================

USE smartcoffe_dml_davi;

-- PARTE A - AQUECIMENTO

-- 1. Liste todos os clientes cadastrados.
SELECT nome 
FROM cliente;

-- 2. Exiba apenas nome, cidade e e-mail dos clientes.
SELECT nome, cidade, email 
FROM cliente;

-- 3. Liste os nomes das cidades sem repetir valores.
SELECT DISTINCT cidade
FROM cliente;

-- 4. Liste todos os produtos em ordem crescente de preço.
SELECT nome, preco FROM produto 
ORDER BY preco ASC;

-- 5. Mostre apenas os 5 produtos mais caros.
SELECT nome, preco 
FROM produto
ORDER BY nome
LIMIT 5 OFFSET 0;

-- PARTE B - FILTROS

-- 6. Liste os produtos com preço entre R$ 8,00 e R$ 15,00.
SELECT nome, preco FROM produto
WHERE preco >= 8.00 AND preco <= 15.00;

-- 7. Liste os clientes das cidades Limeira ou Americana.
SELECT nome, cidade FROM cliente
WHERE cidade IN ('limeira', 'NYC');

-- 8. Localize os produtos cujo nome contém a palavra “Café”.

SELECT nome FROM produto
WHERE nome LIKE 'Café%';
-- 9. Liste os clientes que não informaram telefone.
SELECT nome, telefone FROM cliente 
WHERE telefone IS NULL;

-- 10. Mostre os pedidos FINALIZADOS com valor acima de R$ 20,00,
--     do maior para o menor valor.
SELECT id_pedido, valor_total
FROM pedido
WHERE status_pedido = 'FINALIZADO' and valor_total > 10.00;

-- PARTE C - CÁLCULOS E AGRUPAMENTOS

-- 11. Informe quantos produtos estão cadastrados.
SELECT count(*) AS total_produtos
FROM produto;


-- 12. Mostre menor preço, maior preço e preço médio dos produtos.
SELECT MIN(preco) AS menor_preco, MAX(preco) AS maior_preco, AVG(preco) AS preco_medio
FROM produto;

-- 13. Informe quantos clientes existem em cada cidade.
SELECT cidade, COUNT(*) AS total_clientes
FROM cliente
GROUP BY cidade;

-- 14. Mostre somente as cidades que possuem dois ou mais clientes.
SELECT cidade, COUNT(*) AS total_clientes
FROM cliente
GROUP BY cidade
HAVING COUNT(*) >= 2;

-- 15. Calcule o faturamento total considerando apenas pedidos FINALIZADOS.
SELECT SUM(valor_total) AS faturamento_total
FROM pedido
WHERE status_pedido = 'FINALIZADO';


-- Parte D — Relacionamentos Intermediário

-- 16. Liste cada pedido exibindo: id do pedido, data, nome do cliente, status e valor total.
SELECT id_pedido, data_pedido, nome, status_pedido, valor_total
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id_cliente;

-- 17. Liste cada produto acompanhado do nome de sua categoria.
select p.nome AS produto, c.nome AS categoria
from produto p
JOIN categoria c ON p.id_categoria = c.id_categoria;

-- 18. Gere um relatório dos itens vendidos exibindo: pedido, produto, quantidade, preço
-- unitário e subtotal.
SELECT ip.id_pedido, p.nome AS produto, ip.quantidade, ip.preco_unitario, (ip.quantidade * ip.preco_unitario) AS subtotal
FROM item_pedido ip
JOIN produto p ON ip.id_produto = p.id_produto;

-- 19. Mostre todos os clientes, inclusive aqueles que nunca fizeram pedidos.
SELECT c.nome AS cliente, p.id_pedido
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente;

-- 20. Liste apenas os clientes que nunca fizeram pedidos.
SELECT c.nome AS cliente
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL;

-- Parte E — Desafio Gerencial Avançado

-- 21. Informe quantos pedidos FINALIZADOS cada cliente realizou e quanto cada cliente
-- gastou. Ordene do maior gasto para o menor.
SELECT c.nome AS cliente, COUNT(p.id_pedido) AS total_pedidos, SUM(p.valor_total) AS total_gasto

-- 22. Mostre a quantidade de produtos e o preço médio de cada categoria.

-- 23. Descubra quais produtos possuem preço superior ao preço médio de todos os produtos.

-- 24. Classifique os produtos como “Econômico”, “Intermediário” ou “Premium”, utilizando
-- faixas de preço definidas por você.

-- 25. Crie uma consulta autoral que responda a uma pergunta útil para a gestão da
-- SmartCoffee. Escreva primeiro a pergunta de negócio e depois a consulta SQL.