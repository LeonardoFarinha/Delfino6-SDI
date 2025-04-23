-- Teste como bibliotecário
-- Inserir autor
INSERT INTO autores (nome, nacionalidade, data_nascimento) VALUES ('Machado de Assis', 'Brasileiro', '1839-06-21');

-- Inserir livro
INSERT INTO livros (titulo, ano_publicacao, isbn, autor_id) VALUES ('Dom Casmurro', 1899, '1234567890123', 1);

-- Inserir empréstimo
INSERT INTO emprestimos (livro_id, usuario_id, data_emprestimo, data_devolucao, status) VALUES (1, 1, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY), 'ativo');

-- Atualização
UPDATE emprestimos SET status = 'atrasado' WHERE id = 1;
UPDATE livros SET disponivel = FALSE WHERE id = 1;

--Exclusão
DELETE FROM livros WHERE id = 1;

--Seleção
SELECT * FROM livros WHERE disponivel = TRUE;
SELECT * FROM emprestimos WHERE usuario_id = 2;

--Inserção
INSERT INTO reservas (livro_id, usuario_id, data_reserva, data_expiracao) VALUES (1, 2, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 3 DAY));

--Atualização
UPDATE livros SET titulo = 'Novo Título' WHERE id = 1;

--Exclusão
DELETE FROM emprestimos WHERE id = 1;
