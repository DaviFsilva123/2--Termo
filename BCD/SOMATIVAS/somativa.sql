-- Active: 1788519229702@@127.0.0.1@3306@biblioteca_som2_davi

-- FASE 1

-- EX 1 - CRIAÇÃO DO BANCO DE DADOS
CREATE DATABASE biblioteca_som2_davi

USE biblioteca_som2_davi


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
    status_emprestimo VARCHAR(20) DEFAULT 'ABERTO' CHECK (status_emprestimo = 'ABRETO'),
    id_usuario INT NOT NULL,
    id_livro INT NOT NULL,
    CONSTRAINT fk_emprestimo_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario),
    CONSTRAINT fk_emprestimo_livro FOREIGN KEY (id_livro) REFERENCES livro (id_livro)
);

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

-- FASE 2

-- EX 6 - INSERT DE USUARIOS
INSERT INTO usuario (id_usuario, nome, email, telefone, ativo) VALUES
(1, "Davi Ferreira", "davi.ferreira@email.com", NULL, TRUE),
(2, "Francisco Magri", "francisco.magri@email.com", 19999991, TRUE),
(3, "Felipe Rodrigues", "Felipe.Rodrigues@email.com", 19999992, TRUE),
(4, "Arthur Medeiros", "Arthur.Medeiros@email.com", 19999993, TRUE)

-- EX 7 - INSERT DE LIVROS
INSERT INTO livro (id_livro, titulo, autor, isbn, ano_publicacao, quantidade_disponivel) VALUES
(1, "O Reformatório Nickel", "Colson Whitehead", 123456789011, 2020, 3),
(2, "The Vanishing Half ", "Brit Bennett", 123456789012, 2020, 2),
(3, "Harry Potter e a Pedra Filosofal", "J.K. Rowling", 123456789013, 1997, 10),
(4, "Game of Thrones", " George R. R. Martin.", 123456789014, 2010, 20),
(5, "Percy Jackson The Lightning Thief ", "Rick Riordan", 123456789015, 2005, 15),
(6, "Brigerton", " Julia Quinn", 123456789016, 2000, 17)

-- EX 8 - INSERT DE IMPRESTIMOS
INSERT INTO emprestimo (id_emprestimo, data_emprestimo, data_prevista, data_devolucao, status_emprestimo, id_usuario, id_livro) VALUES
(1, NOW(), '2020-8-23', NULL, 'ABERTO', 1, 1 ),
(2, NOW(), '2020-11-30', NULL, 'ABERTO', 2, 2 ),
(3, NOW(), '1997-3-8', NULL, 'ABERTO', 3, 3 )

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















