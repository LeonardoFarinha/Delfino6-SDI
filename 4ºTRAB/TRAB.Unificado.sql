-- PARTE 1: CRIAÇÃO DO BANCO DE DADOS E TABELAS
DROP DATABASE IF EXISTS biblioteca;
CREATE DATABASE biblioteca;
USE biblioteca;

-- Tabela: Autores

CREATE TABLE autores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    nacionalidade VARCHAR(50),
    data_nascimento DATE
);

-- Tabela: Livros

CREATE TABLE livros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200),
    ano_publicacao YEAR,
    isbn VARCHAR(20) UNIQUE,
    autor_id INT,
    disponivel BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (autor_id) REFERENCES autores(id)
);

-- Tabela: Usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    data_cadastro DATE
);

-- Tabela: Emprestimos
CREATE TABLE emprestimos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    livro_id INT,
    usuario_id INT,
    data_emprestimo DATE,
    data_devolucao DATE,
    status ENUM('ativo', 'concluído', 'atrasado'),
    FOREIGN KEY (livro_id) REFERENCES livros(id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- Tabela: Reservas
CREATE TABLE reservas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    livro_id INT,
    usuario_id INT,
    data_reserva DATE,
    data_expiracao DATE,
    FOREIGN KEY (livro_id) REFERENCES livros(id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- Tabela: Multas
CREATE TABLE multas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    emprestimo_id INT,
    valor DECIMAL(10, 2),
    data_multa DATE,
    FOREIGN KEY (emprestimo_id) REFERENCES emprestimos(id)
);

-- PARTE 2: CRIAÇÃO DE USUÁRIOS E ROLES

-- Criar usuários
CREATE USER 'bibliotecario'@'localhost' IDENTIFIED BY 'admin123';
CREATE USER 'membro'@'localhost' IDENTIFIED BY 'usuario123';
CREATE USER 'gestor'@'localhost' IDENTIFIED BY 'gestor123';

-- Criar roles
CREATE ROLE 'role_bibliotecario';
GRANT SELECT, INSERT, UPDATE, DELETE ON biblioteca.livros TO 'role_bibliotecario';
GRANT SELECT, INSERT, UPDATE, DELETE ON biblioteca.autores TO 'role_bibliotecario';
GRANT SELECT, INSERT, UPDATE, DELETE ON biblioteca.emprestimos TO 'role_bibliotecario';
GRANT SELECT, INSERT, UPDATE, DELETE ON biblioteca.reservas TO 'role_bibliotecario';
GRANT SELECT, INSERT, UPDATE, DELETE ON biblioteca.multas TO 'role_bibliotecario';

CREATE ROLE 'role_membro';
GRANT SELECT ON biblioteca.livros TO 'role_membro';
GRANT SELECT ON biblioteca.emprestimos TO 'role_membro';
GRANT INSERT ON biblioteca.reservas TO 'role_membro';
GRANT SELECT ON biblioteca.multas TO 'role_membro';

CREATE ROLE 'role_gestor';
GRANT ALL PRIVILEGES ON biblioteca.* TO 'role_gestor';

-- Atribuir roles aos usuários
GRANT 'role_bibliotecario' TO 'bibliotecario'@'localhost';
GRANT 'role_membro' TO 'membro'@'localhost';
GRANT 'role_gestor' TO 'gestor'@'localhost';

-- Definir roles padrão
SET DEFAULT ROLE ALL TO 'bibliotecario'@'localhost';
SET DEFAULT ROLE ALL TO 'membro'@'localhost';
SET DEFAULT ROLE ALL TO 'gestor'@'localhost';

-- PARTE 3: OPERAÇÕES DE TESTE (comentadas para executar manualmente)

-- -- Login como 'bibliotecario':
-- INSERT INTO autores (nome, nacionalidade, data_nascimento) VALUES ('Machado de Assis', 'Brasileiro', '1839-06-21');
-- INSERT INTO livros (titulo, ano_publicacao, isbn, autor_id) VALUES ('Dom Casmurro', 1899, '1234567890123', 1);
-- INSERT INTO usuarios (nome, email, data_cadastro) VALUES ('Fulano', 'fulano@email.com', CURDATE());
-- INSERT INTO emprestimos (livro_id, usuario_id, data_emprestimo, data_devolucao, status) VALUES (1, 1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 7 DAY), 'ativo');
-- UPDATE emprestimos SET status = 'atrasado' WHERE id = 1;
-- UPDATE livros SET disponivel = FALSE WHERE id = 1;
-- DELETE FROM livros WHERE id = 1;
-- SELECT * FROM emprestimos WHERE status = 'ativo';
-- SELECT * FROM reservas WHERE data_expiracao >= CURDATE();

-- -- Login como 'membro':
-- SELECT * FROM livros WHERE disponivel = TRUE;
-- SELECT * FROM emprestimos WHERE usuario_id = 2;
-- INSERT INTO reservas (livro_id, usuario_id, data_reserva, data_expiracao) VALUES (1, 2, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 3 DAY));
-- -- Tentativas abaixo devem falhar:
-- -- UPDATE livros SET titulo = 'Novo Título' WHERE id = 1;
-- -- DELETE FROM emprestimos WHERE id = 1;

-- -- Login como 'gestor':
-- SELECT * FROM livros;
-- SELECT * FROM autores;
-- SELECT * FROM emprestimos WHERE status = 'ativo';
-- SELECT MONTH(data_emprestimo) AS mes, COUNT(*) AS total_emprestimos FROM emprestimos GROUP BY MONTH(data_emprestimo);
-- UPDATE multas SET valor = 25.00 WHERE id = 1;
-- DELETE FROM reservas WHERE id = 1;
-- SELECT * FROM multas;
