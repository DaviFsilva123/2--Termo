-- Active: 1788519229702@@127.0.0.1@3306@biblioteca_som2_davi

-- FASE 1 - DDL
DROP DATABASE biblioteca_som2_davi;
-- EX 1 - CRIAÇÃO DO BANCO DE DADOS
CREATE DATABASE biblioteca_som2_davi;

USE biblioteca_som2_davi;


-- EX 2 - TABELA USUARIO

CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT ,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    ativo BOOLEAN DEFAULT TRUE
);

-- EX 3 - TABELA LIVRO

CREATE TABLE livro(
    id_livro INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(120) NOT NULL,
    isbn CHAR(13) NOT NULL UNIQUE,
    ano_publicacao INT,
    quantidade_disponivel INT DEFAULT 0
);

-- EX 4 - TABELA EMPRESTIMO

CREATE TABLE emprestimo(
    id_emprestimo INT PRIMARY KEY AUTO_INCREMENT,
    data_emprestimo DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_prevista DATE NOT NULL,
    data_devolucao DATE,
    status_emprestimo VARCHAR(20) DEFAULT 'ABERTO' CHECK (status_emprestimo = 'ABERTO'),
    id_usuario INT NOT NULL,
    id_livro INT NOT NULL,
    CONSTRAINT fk_emprestimo_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario),
    CONSTRAINT fk_emprestimo_livro FOREIGN KEY (id_livro) REFERENCES livro (id_livro)
);

DROP TABLE emprestimo;
CREATE TABLE funcionarios(
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    cpf_funcionario VARCHAR(14) NOT NULL UNIQUE,
    telefone_funcionario VARCHAR(15),
    email_funcionario VARCHAR(120) NOT NULL UNIQUE
)

CREATE TABLE estoque(
    id_estoque INT PRIMARY KEY AUTO_INCREMENT,
    quantidade_estoque INT,
    id_livro INT not NULL,
    CONSTRAINT fk_estoque_livro FOREIGN KEY (id_livro) REFERENCES livro (id_livro)
)

-- EX 5 - ALTER TABLE
ALTER TABLE livro add editora varchar(100)

-- FASE 2 DML 

-- EX 6 - INSERT DE USUARIOS

INSERT INTO usuario (id_usuario, nome, email, telefone, ativo) VALUES
(1, "Davi Ferreira", "davi.ferreira@email.com", NULL, TRUE),
(2, "Francisco Magri", "francisco.magri@email.com", 19999991, TRUE),
(3, "Felipe Rodrigues", "Felipe.Rodrigues@email.com", 19999992, TRUE),
(4, "Arthur Medeiros", "Arthur.Medeiros@email.com", 19999993, TRUE)

SELECT * FROM LIVRO;

-- EX 7 - INSERT DE LIVROS
INSERT INTO livro (titulo, autor, isbn, ano_publicacao, quantidade_disponivel) VALUES
("O Reformatório Nickel", "Colson Whitehead", 12345678901, 2020, 3),
("The Vanishing Half ", "Brit Bennett", 123456789012, 2020, 2),
("Harry Potter e a Pedra Filosofal", "J.K. Rowling", 123456789013, 1997, 10),
("Game of Thrones", " George R. R. Martin.", 123456789014, 2010, 20),
("Percy Jackson The Lightning Thief ", "Rick Riordan", 123456789015, 2005, 15),
("Brigerton", " Julia Quinn", 123456789016, 2000, 17)

-- EX 8 - INSERT DE IMPRESTIMOS
INSERT INTO emprestimo (data_emprestimo, data_prevista, data_devolucao, status_emprestimo, id_usuario, id_livro) VALUES
(NOW(), '2020-8-23', '2020-8-25', 'ABERTO', 1, 1 ),
(NOW(), '2020-11-30', '2020-11-30', 'ABERTO', 2, 2 ),
(NOW(), '1997-3-8', '1997-3-10', 'ABERTO', 3, 3 )

SELECT * FROM emprestimo;

INSERT INTO funcionarios(id_funcionario, cpf_funcionario, email_funcionario, telefone_funcionario) VALUES
(1, '123.456.781', 'funcionario1@email.com', 19999999991),
(2, '123.456.782', 'funcionario2@email.com', 19999999992),
(3, '123.456.783', 'funcionario3@email.com', 19999999993)

INSERT INTO estoque(id_estoque, quantidade_estoque, id_livro) VALUES
(1, 50, 1),
(2, 24, 2),
(3, 33, 3),
(4, 150, 4),
(5, 200, 5),
(6, 100, 6)

-- EX 9 - UPDATE

SELECT * FROM usuario

UPDATE usuario
SET telefone = '14114145'
WHERE id_usuario = 2;

-- EX 10 - ATUALIZAÇÃO EM LOTE

SELECT * FROM livro;

UPDATE livro
SET quantidade_disponivel = 1
WHERE ano_publicacao = 2020

-- EX 11 - DELETE E INTEGRIDADE

SELECT * FROM usuario


INSERT INTO usuario(id_usuario, nome, email, telefone, ativo) VALUES
(7, 'Keynan Santos', 'keynan.santos@email.com', 19999997, TRUE);

DELETE FROM usuario
WHERE id_usuario = 7

DELETE FROM usuario
WHERE id_usuario = 1
-- O erro aconteceu porque o usuário 1 possui um empréstimo registrado na tabela emprestimo, e a integridade referencial faz com que um registro não seja excluído se ele estiver sendo pego de outra tabela.

-- FASE 3 - DML

-- EX 12 - SELECT BÁSICO

SELECT  titulo, autor, quantidade_disponivel
FROM livro

-- EX 13 - WHERE + ORDER BY

SELECT quantidade_disponivel
FROM livro
WHERE quantidade_disponivel > 2
ORDER BY quantidade_disponivel ASC

-- EX 14 - LIKE

SELECT titulo
FROM livro
WHERE titulo LIKE 'Percy%';

-- EX 15 - BETWEEN

SELECT titulo, ano_publicacao
FROM livro
WHERE ano_publicacao BETWEEN '2015' AND '2025'

-- EX 16 - FUNÇÕES AGREGADAS

-- (MIN, MAX, AVG)
SELECT ROUND(MIN(quantidade_disponivel),2) AS Quantidade_baixas,
ROUND(MAX(quantidade_disponivel),2) AS Quantidade_alta,
ROUND(AVG(quantidade_disponivel),2) AS Quantidade_baixa
FROM livro
-- (COUNT)
SELECT titulo, COUNT(*) AS quantidade_disponivel
FROM livro
GROUP BY titulo
-- (SUM)
SELECT titulo, SUM(quantidade_disponivel) AS quantidade_disponivel
FROM livro
GROUP BY titulo;

-- EX 17 - INNER JOIN

SELECT e.id_emprestimo, u.nome, l.titulo, e.data_emprestimo, e.status_emprestimo
FROM emprestimo e
INNER JOIN usuario u ON e.id_usuario = u.id_usuario
INNER JOIN livro l ON e.id_livro = l.id_livro


-- EX 18 - JOIN + WHERE

SELECT e.id_emprestimo, u.nome, l.titulo, e.data_emprestimo, e.status_emprestimo
FROM emprestimo e
INNER JOIN usuario u ON e.id_usuario = u.id_usuario
INNER JOIN livro l ON e.id_livro = l.id_livro
WHERE e.status_emprestimo = 'ABERTO'

-- EX 19 - GROUP BY

SELECT u.nome, COUNT(e.id_emprestimo) AS quantidade_emprestimos
FROM emprestimo e
INNER JOIN usuario u ON e.id_usuario = u.id_usuario
GROUP BY u.nome
ORDER BY quantidade_emprestimos DESC

-- EX 20 - LEFT JOIN

SELECT u.nome, COUNT(e.id_emprestimo) AS quantidade_emprestimos
FROM usuario u
LEFT JOIN emprestimo e ON u.id_usuario = e.id_usuario
GROUP BY u.nome

-- FASE 4 - TCL

-- 21. TRANSAÇÃO DE EMPRÉSTIMO

START TRANSACTION;
INSERT INTO emprestimo (data_emprestimo, data_prevista, status_emprestimo, id_usuario, id_livro) VALUES
(NOW(), '2024-07-01', 'ABERTO', 2, 3);
UPDATE livro SET quantidade_disponivel = quantidade_disponivel - 1 
WHERE id_livro = 3

SELECT * FROM emprestimo

SELECT * FROM livro

COMMIT;


-- 22. ROLLBACK

START TRANSACTION;
SELECT * FROM livro 
WHERE id_livro = 3;
SELECT quantidade_disponivel 
FROM livro 
WHERE id_livro = 3;
ROLLBACK;








