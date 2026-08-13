DROP VIEW IF EXISTS vw_relatorio_matriculas CASCADE;
DROP TRIGGER IF EXISTS trg_auditoria_preco_curso ON cursos;
DROP FUNCTION IF EXISTS fn_auditar_preco_curso();
DROP TABLE IF EXISTS matriculas CASCADE;
DROP TABLE IF EXISTS precos CASCADE;
DROP TABLE IF EXISTS cursos CASCADE;
DROP TABLE IF EXISTS alunos CASCADE;

CREATE TABLE alunos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE cursos (
    id SERIAL PRIMARY KEY,
    nome_curso VARCHAR(100) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL
);

CREATE TABLE matriculas (
    id SERIAL PRIMARY KEY,
    aluno_id INT NOT NULL,
    curso_id INT NOT NULL,
    data_matricula DATE NOT NULL,
    CONSTRAINT fk_matricula_aluno FOREIGN KEY (aluno_id) REFERENCES alunos(id) ON DELETE CASCADE,
    CONSTRAINT fk_matricula_curso FOREIGN KEY (curso_id) REFERENCES cursos(id)
);

CREATE TABLE precos (
    id SERIAL PRIMARY KEY,
    curso_id INT NOT NULL,
    valor_antigo DECIMAL(10, 2) NOT NULL,
    valor_novo DECIMAL(10, 2) NOT NULL,
    data_alteracao TIMESTAMP NOT NULL
);

INSERT INTO alunos (nome, email) VALUES
('JOão Paulo', 'jpbransolin@gmail.com'),
('Laura', 'laurabaldanransolin2010@gmail.com'),
('Egberto', 'beto@outlook.com'),
('Sandro', 'workdep@gmail.com'),
('Isis', 'isis@yahoo.com');

INSERT INTO cursos (nome_curso, valor) VALUES
('Curso de Dev Full Stack', 5000.00),
('Curso de SQL e Postgres', 1800.00),
('Curso de HTML, CSS e JS', 2200.00);

INSERT INTO matriculas (aluno_id, curso_id, data_matricula) VALUES
(1, 1, '2026-08-12'), 
(1, 2, '2026-08-12'), 
(2, 2, '2026-08-12'), 
(3, 3, '2026-08-12'), 
(5, 1, '2026-08-12');

-- SELECT 
--     a.nome AS nome_aluno, 
--     c.nome_curso
-- FROM matriculas m
-- JOIN alunos a ON m.aluno_id = a.id
-- JOIN cursos c ON m.curso_id = c.id;




-- SELECT 
--     a.nome AS nome_aluno, 
--     c.nome_curso
-- FROM alunos a
-- LEFT JOIN matriculas m ON a.id = m.aluno_id
-- LEFT JOIN cursos c ON m.curso_id = c.id;



-- CREATE OR REPLACE FUNCTION fn_auditar_preco_curso()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     IF OLD.valor <> NEW.valor THEN
--         INSERT INTO log_precos (curso_id, valor_antigo, valor_novo, data_alteracao)
--         VALUES (NEW.id, OLD.valor, NEW.valor, NOW());
--     END IF;
--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;




-- CREATE TRIGGER trg_auditoria_preco_curso
-- AFTER UPDATE ON cursos
-- FOR EACH ROW
-- EXECUTE PROCEDURE fn_auditar_preco_curso();

-- UPDATE cursos SET valor = 1950.00 WHERE id = 2;

-- SELECT * FROM precos;




-- CREATE VIEW vw_relatorio_matriculas AS
-- SELECT 
    
--     c.nome_curso
-- FROM alunos a
-- LEFT JOIN matriculas m ON a.id = m.aluno_id
-- LEFT JOIN cursos c ON m.curso_id = c.id;

-- SELECT * FROM vw_relatorio_matriculas;