-- ============================================================
-- AULA 08 - ATIVIDADE PRÁTICA DE DML
-- Nome: Davi Ferreira da Silva
-- Turma: 2Devis Data: 02/10/2026
-- Base: smartcoffee_dml
-- ============================================================


USE smartcoffe_dml_davi;


-- IMPORTANTE:
-- Para toda questão de UPDATE ou DELETE, escreva primeiro um SELECT
-- com o mesmo WHERE para validar os registros afetados.

-- PARTE A - INSERT

-- IMPORTANTE:
-- Para toda questão de UPDATE ou DELETE, escreva primeiro um SELECT
-- com o mesmo WHERE para validar os registros afetados.

-- PARTE A - INSERT

-- 1. Cadastre dois novos clientes com dados diferentes.
INSERT INTO cliente (nome, email, telefone, cidade, ativo) VALUES: 
('Chico Miguel', 'chico.miguel@email.com', 19999999999, 'NYC', TRUE),
('Kiabim rodrigues', 'kiabo.rodrigues@email.com', 19999999999, 'Boston', TRUE);

SELECT * FROM cliente;

-- 2. Cadastre a categoria 'Especiais da Casa'.
INSERT INTO categoria (nome) VALUES
('Especiais da casa');

SELECT * FROM categoria;

-- 3. Localize o id da categoria criada e cadastre três produtos nela.
SET @id_categoria = (SELECT id_categoria FROM categoria WHERE nome = 'Especiais da casa' LIMIT 1);

INSERT INTO produto (nome, preco, id_categoria) VALUES
('Café Especial', 12.50, @id_categoria),
('Torta de Maçã', 15.00, @id_categoria),
('Suco Natural', 8.00, @id_categoria);

-- 4. Cadastre um terceiro cliente sem telefone.
INSERT INTO cliente (nome, email, telefone, cidade, ativo) VALUES
('Maria Silva', 'maria.silva@email.com', NULL, 'São Paulo', TRUE);

-- 5. Crie um novo pedido para um dos clientes cadastrados.
INSERT INTO pedido (id_cliente, data_pedido, valor_total, status_pedido) VALUES
(1, NOW(), 0.00, 'PENDENTE');

-- 6. Use LAST_INSERT_ID() para guardar o id do pedido em @pedido_atividade
--    e insira pelo menos dois itens nesse pedido.
SET @pedido_atividade = LAST_INSERT_ID();

INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_uniatario) VALUES
(@pedido_atividade, 1, 2, 12.50),
(@pedido_atividade, 2, 1, 15.00);


-- PARTE B - UPDATE

-- 7. Corrija o telefone de um dos clientes criados.

-- SELECT de validação:
SELECT * FROM cliente WHERE id_cliente = 1;

-- UPDATE:
UPDATE cliente 
SET telefone = 19888888888 
WHERE id_cliente = 1;

-- SELECT final:
SELECT * FROM cliente WHERE id_cliente = 1;


-- 8. Altere cidade e telefone de outro cliente em um único UPDATE.
-- SELECT de validação:
SELECT * FROM cliente WHERE id_cliente = 2;

-- UPDATE:
UPDATE cliente 
SET cidade = 'Campinas', 
    telefone = 19988776655 
WHERE id_cliente = 2;

-- SELECT final:
SELECT * FROM cliente WHERE id_cliente = 2;


-- 9. Aumente em 8% o preço dos produtos da categoria 'Especiais da Casa'.
-- SELECT de validação:
SELECT p.* 
FROM produto p
JOIN categoria c ON p.id_categoria = c.id_categoria
WHERE c.nome = 'Especiais da casa';

-- UPDATE:
UPDATE produto p
JOIN categoria c ON p.id_categoria = c.id_categoria
SET p.preco = p.preco * 1.08
WHERE c.nome = 'Especiais da casa';

-- SELECT final:
SELECT p.* 
FROM produto p
JOIN categoria c ON p.id_categoria = c.id_categoria
WHERE c.nome = 'Especiais da casa';


-- 10. Altere o status do pedido criado para 'PREPARANDO'.
-- SELECT de validação:
SELECT * FROM pedido WHERE id_pedido = @pedido_atividade;

-- UPDATE:
UPDATE pedido 
SET status_pedido = 'PREPARANDO' 
WHERE id_pedido = @pedido_atividade;

-- SELECT final:
SELECT * FROM pedido WHERE id_pedido = @pedido_atividade;


-- 11. Atualize valor_total do pedido de acordo com os itens cadastrados.
--     Você pode calcular previamente com SELECT SUM(quantidade * preco_unitario).

-- SELECT de validação (cálculo prévio do total):
SELECT SUM(quantidade * preco_uniatario) AS total_calculado 
FROM item_pedido 
WHERE id_pedido = @pedido_atividade;

-- UPDATE:
UPDATE pedido 
SET valor_total = (
    SELECT SUM(quantidade * preco_uniatario) 
    FROM item_pedido 
    WHERE id_pedido = @pedido_atividade
)
WHERE id_pedido = @pedido_atividade;

-- SELECT final:
SELECT * FROM pedido WHERE id_pedido = @pedido_atividade;


-- 12. Escolha um dos produtos criados e faça uma exclusão lógica (ativo = FALSE).
-- SELECT de validação:
SELECT * FROM produto WHERE id_produto = 1;

-- UPDATE:
UPDATE produto 
SET ativo = FALSE 
WHERE id_produto = 1;

-- SELECT final:
SELECT * FROM produto WHERE id_produto = 1;


-- PARTE C - DELETE

-- 13. Crie um cliente de teste sem pedidos.
--     Depois localize e exclua apenas esse cliente.

-- Criação do cliente de teste:
INSERT INTO cliente (nome, email, telefone, cidade, ativo) VALUES
('Davi Teste', 'teste@email.com', 19000000000, 'Teste City', TRUE);

SET @id_cliente_teste = LAST_INSERT_ID();

-- SELECT de validação:
SELECT * FROM cliente WHERE id_cliente = @id_cliente_teste;

-- DELETE:
DELETE FROM cliente 
WHERE id_cliente = @id_cliente_teste;

-- SELECT final:
SELECT * FROM cliente WHERE id_cliente = @id_cliente_teste;


-- 14. Tente excluir um cliente da base original que possua pedidos.
--     Deixe o DELETE comentado após o teste e descreva o erro abaixo.
-- Resultado observado: O erro que foi exebido foi: Cannot delete or update a parent row: a foreign key constraint fails (`smartcoffe_dml_davi`.`pedido`, CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`)) 
-- esse erro aconteceu porque o cliente que eu tentei deletar possui pedidos cadastrados, e a tabela de pedidos possui uma chave estrangeira (FK) que referencia a tabela de clientes. Portanto, o banco de dados impede a exclusão do cliente para manter a integridade referencial dos dados.


-- delete from cliente where id_cliente = 1;
    

-- 15. Explique em comentário por que a FK bloqueou a exclusão.
-- Resposta:
-- A FK (Foreign Key) bloqueou a exclusão porque existe pois a tabela de clientes e a tabela de pedidos possuem uma dependencia. Quando um cliente possui pedidos associados, o banco de dados impede a exclusão desse cliente para garantir Que mantenha os dados. Isso significa que não é possível remover um registro pai (cliente) enquanto houver registros filhos (pedidos) que dependam dele, evitando assim irregularidades no banco de dados.

-- 16. Crie uma categoria temporária chamada 'Excluir Depois' e remova-a.
INSERT INTO categoria (nome) VALUES ('Excluir Depois');
DELETE FROM categoria WHERE nome = 'Excluir Depois';