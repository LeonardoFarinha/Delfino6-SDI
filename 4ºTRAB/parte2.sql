-- Criação de usuários

CREATE USER 'bibliotecario'@'localhost' IDENTIFIED BY 'admin123';
CREATE USER 'membro'@'localhost' IDENTIFIED BY 'usuario123';
CREATE USER 'gestor'@'localhost' IDENTIFIED BY 'gestor123';

-- Criação de rules
-- Role de Bibliotecário
CREATE ROLE 'role_bibliotecario';
GRANT SELECT, INSERT, UPDATE, DELETE ON biblioteca.livros TO 'role_bibliotecario';
GRANT SELECT, INSERT, UPDATE, DELETE ON biblioteca.autores TO 'role_bibliotecario';
GRANT SELECT, INSERT, UPDATE, DELETE ON biblioteca.emprestimos TO 'role_bibliotecario';
GRANT SELECT, INSERT, UPDATE, DELETE ON biblioteca.reservas TO 'role_bibliotecario';
GRANT SELECT, INSERT, UPDATE, DELETE ON biblioteca.multas TO 'role_bibliotecario';

-- Role de Membro
CREATE ROLE 'role_membro';
GRANT SELECT ON biblioteca.livros TO 'role_membro';
GRANT SELECT ON biblioteca.emprestimos TO 'role_membro';
GRANT INSERT ON biblioteca.reservas TO 'role_membro';
GRANT SELECT ON biblioteca.multas TO 'role_membro';

-- Role de Gestor
CREATE ROLE 'role_gestor';
GRANT ALL PRIVILEGES ON biblioteca.* TO 'role_gestor';

-- Atribuicoes de roles
GRANT 'role_bibliotecario' TO 'bibliotecario'@'localhost';
GRANT 'role_membro' TO 'membro'@'localhost';
GRANT 'role_gestor' TO 'gestor'@'localhost';

-- Ativar roles por padrão (opcional)
SET DEFAULT ROLE ALL TO 'bibliotecario'@'localhost';
SET DEFAULT ROLE ALL TO 'membro'@'localhost';
SET DEFAULT ROLE ALL TO 'gestor'@'localhost';
