-- Criação do banco de dados
-- Criação do banco de dados
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
