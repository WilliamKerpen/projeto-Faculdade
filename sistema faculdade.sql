/* excluir bando antes de comecar */
drop database db_projeto_faculdade;

/* Criacao da base de dados */
CREATE DATABASE db_projeto_faculdade;

/* Ativar a tabela */
USE db_projeto_faculdade;

/* Criacao das tabelas dentro do banco de dados */

CREATE TABLE tbl_curso(
    id_curso INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nome_curso VARCHAR(100) NOT NULL,
    carga_horaria INT, 
    coordenador VARCHAR(50)
);

CREATE TABLE tbl_disciplina(
    id_disciplina INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nome_disciplina VARCHAR(50) NOT NULL, 
    carga_horaria_disciplina INT NOT NULL
);

CREATE TABLE tbl_professor( 
    id_professor INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nome_professor VARCHAR(80) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    titulacao VARCHAR(40)    
);

CREATE TABLE tbl_curso_disciplina_professor(
    id_tbl_curso_disciplina_professor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fk_id_curso INT NOT NULL,
    FOREIGN KEY (fk_id_curso) REFERENCES tbl_curso(id_curso),
    fk_id_disciplina INT NOT NULL,
    FOREIGN KEY (fk_id_disciplina) REFERENCES tbl_disciplina(id_disciplina),
    fk_id_professor INT NOT NULL,
    FOREIGN KEY (fk_id_professor) REFERENCES tbl_professor(id_professor)
);

CREATE TABLE tbl_turma(
    id_turma INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    ano_semestre VARCHAR(15),
    fk_id_curso INT NOT NULL,
    FOREIGN KEY (fk_id_curso) REFERENCES tbl_curso(id_curso)
);

CREATE TABLE tbl_aluno(
    id_aluno INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nome_aluno VARCHAR(100) NOT NULL,
    cpf VARCHAR(18) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(15),
    data_de_nascimento DATE NOT NULL,
    fk_id_turma int not null ,
    FOREIGN KEY (fk_id_turma) REFERENCES tbl_turma(id_turma)
);


CREATE TABLE tbl_endereco_aluno(
    id_endereco_aluno INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    logradouro VARCHAR(45),
    bairro VARCHAR(45),
    cep VARCHAR(10),
    cidade VARCHAR(45),
    estado VARCHAR(45),
    pais VARCHAR(45),
    fk_id_aluno INT NOT NULL,
    FOREIGN KEY (fk_id_aluno) REFERENCES tbl_aluno(id_aluno)
);

CREATE TABLE tbl_frequencia(
    id_frequencia INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fk_id_aluno INT NOT NULL,
    FOREIGN KEY (fk_id_aluno) REFERENCES tbl_aluno(id_aluno),
    data_aula DATE, 
    presenca BOOLEAN,
    fk_id_curso_disciplina_professor INT NOT NULL,
    FOREIGN KEY (fk_id_curso_disciplina_professor) REFERENCES tbl_curso_disciplina_professor(id_tbl_curso_disciplina_professor)   
);

CREATE TABLE tbl_notas(
    id_tbl_notas INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fk_id_aluno INT NOT NULL,
    FOREIGN KEY (fk_id_aluno) REFERENCES tbl_aluno(id_aluno),
    nota1 DECIMAL(5,2),
    nota2 DECIMAL(5,2),
    trabalho DECIMAL(5,2),
    substitutiva DECIMAL(5,2),
    fk_id_curso_disciplina_professor INT NOT NULL,
    FOREIGN KEY (fk_id_curso_disciplina_professor) REFERENCES tbl_curso_disciplina_professor(id_tbl_curso_disciplina_professor)
);

CREATE TABLE tbl_status_pagamento(
    id_status_pagamento INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	status_boleto  VARCHAR(15) NOT NULL
);

CREATE TABLE tbl_pagamento(
    id_pagamento INT  AUTO_INCREMENT PRIMARY KEY NOT NULL,
    vencimento DATE NOT NULL,
    data_pagamento DATE,
    fk_id_status_pagamento INT NOT NULL, 
    FOREIGN KEY (fk_id_status_pagamento) REFERENCES tbl_status_pagamento (id_status_pagamento),  
    fk_id_aluno INT NOT NULL,
    FOREIGN KEY (fk_id_aluno) REFERENCES tbl_aluno(id_aluno)
);

/*********INSERIR DADOS*********/
/* cursos */
INSERT INTO tbl_curso (nome_curso, carga_horaria, coordenador) VALUES
	('Engenharia Civil', 4000, 'Dr. João Pereira'),
	('Administração', 3000, 'Mestre Carla Ferreira'),
	('Direito', 4500, 'Dr. Antonio Braga'),
	('Medicina', 7200, 'Prof. Ricardo Mendes'),
	('Psicologia', 3600, 'Dra. Leticia Moura'),
	('Arquitetura', 4200, 'Mestre Eduardo Ramos'),
	('Biomedicina', 3200, 'Prof. Julia Lima'),
	('Engenharia de Software', 4000, 'Dr. Fernando Costa'),
	('Publicidade e Propaganda', 2800, 'Mestre Beatriz Sousa'),
	('Educação Física', 3000, 'Prof. Adriana Barros');

/* disciplinas */
INSERT INTO tbl_disciplina (nome_disciplina, carga_horaria_disciplina) VALUES
	('Matemática 1', 60),
	('ADM 1', 60),
	('ADM 2', 60),
	('Logica', 60),
	('Matematica Financeira', 60),
	('Marketing 1', 60),
	('Python', 60),
	('HTML', 60),
	('Programação', 80),
	('Banco de Dados', 80);

/* professores */
INSERT INTO tbl_professor (nome_professor, telefone, email, titulacao) VALUES
	('Dr. João Pereira', '11987654321', 'joao@email.com', 'Doutor'),
	('Mestre Carla Ferreira', '11976543210', 'carla@email.com', 'Mestre'),
	('Dr. Antonio Braga', '11965432109', 'antonio@email.com', 'Doutor'),
	('Prof. Ricardo Mendes', '11954321098', 'ricardo@email.com', 'Especialista'),
	('Dra. Leticia Moura', '11943210987', 'leticia@email.com', 'Doutor'),
	('Mestre Eduardo Ramos', '11932109876', 'eduardo@email.com', 'Mestre'),
	('Prof. Julia Lima', '11921098765', 'julia@email.com', 'Especialista'),
	('Dr. Fernando Costa', '11910987654', 'fernando@email.com', 'Doutor'),
	('Mestre Beatriz Sousa', '11909876543', 'beatriz@email.com', 'Mestre'),
	('Prof. Adriana Barros', '11908765432', 'adriana@email.com', 'Especialista');
    
    /* turma */
    
     /*select * from tbl_curso;*/
INSERT INTO tbl_turma (ano_semestre,fk_id_curso) VALUES
	('2024-1',1),
    ('2024-1',2),
    ('2024-1',3),
	('2024-2',1),
    ('2024-2',2);


/* curso_disciplina_professor*/
insert into	tbl_curso_disciplina_professor (fk_id_curso, fk_id_disciplina, fk_id_professor) Values
	( 1,1,1),
    ( 1,2,2),
    ( 1,3,3),
    ( 1,4,4),
    (2,5,5),
    (2,6,6),
    (2,7,7),
    (3,8,8),
    (3,9,9),
    (3,10,10),
    (3,5,4);

/* alunos */
INSERT INTO tbl_aluno (nome_aluno, cpf, email, telefone, data_de_nascimento, fk_id_turma) VALUES
	('Carlos Silva', '123.456.789-00', 'carlos@email.com', '11987654321', '2000-05-10', 1),
	('Mariana Souza', '234.567.890-11', 'mariana@email.com', '11976543210', '2001-08-22',  1),
	('José Santos', '345.678.901-22', 'jose@email.com', '11965432109', '1999-12-15', 2),
	('Ana Lima', '456.789.012-33', 'ana@email.com', '11954321098', '2002-03-30',  2),
	('Paulo Mendes', '567.890.123-44', 'paulo@email.com', '11943210987', '1998-07-08',  3),
	('Fernanda Rocha', '678.901.234-55', 'fernanda@email.com', '11932109876', '2000-01-25',  3),
	('Lucas Almeida', '789.012.345-66', 'lucas@email.com', '11921098765', '2001-09-14',  4),
	('Patricia Gomes', '890.123.456-77', 'patricia@email.com', '11910987654', '1999-06-05',  4),
	('Ricardo Torres', '901.234.567-88', 'ricardo@email.com', '11909876543', '1997-04-19',  5),
	('Juliana Martins', '012.345.678-99', 'juliana@email.com', '11908765432', '2003-11-11', 5);
    
 select * from tbl_aluno;

/* enderecos dos alunos */
INSERT INTO tbl_endereco_aluno (logradouro, bairro, cep, cidade, estado, pais, fk_id_aluno) VALUES
	('Rua A', 'Centro', '01010-010', 'São Paulo', 'SP', 'Brasil', 1),
	('Rua B', 'Vila Nova', '02020-020', 'Rio de Janeiro', 'RJ', 'Brasil', 2),
	('Rua C', 'Jardins', '03030-030', 'Belo Horizonte', 'MG', 'Brasil', 3),
	('Rua D', 'Boa Vista', '04040-040', 'Porto Alegre', 'RS', 'Brasil', 4),
	('Rua E', 'Lapa', '05050-050', 'Curitiba', 'PR', 'Brasil', 5),
	('Rua F', 'Copacabana', '06060-060', 'Salvador', 'BA', 'Brasil', 6),
	('Rua G', 'Centro', '07070-070', 'Fortaleza', 'CE', 'Brasil', 7),
	('Rua H', 'Barra', '08080-080', 'Recife', 'PE', 'Brasil', 8),
	('Rua I', 'São Cristóvão', '09090-090', 'Manaus', 'AM', 'Brasil', 9),
	('Rua J', 'Liberdade', '10010-100', 'Brasília', 'DF', 'Brasil', 10);

/*status do pagamento*/
INSERT INTO tbl_status_pagamento (status_boleto)VALUES
	('Pago'),
	('Pendente'),
	('Atrasado');

/*pagamentos*/
INSERT INTO tbl_pagamento (vencimento, data_pagamento, fk_id_status_pagamento, fk_id_aluno) VALUES
	('2024-01-10', '2024-01-10', 1, 1),
    ('2024-02-10', null, 2, 1),
    ('2024-03-10', null, 2, 1),
    ('2024-04-10', null, 2, 1),
    ('2024-05-10', null, 2, 1),
    ('2024-06-10', null, 2, 1),
    ('2024-01-10', null, 3, 2),
    ('2024-02-10', null, 2, 2),
    ('2024-03-10', null, 2, 2),
    ('2024-04-10', null, 2, 2),
    ('2024-05-10', null, 2, 2),
    ('2024-06-10', null, 2, 2),
    ('2024-01-10', '2024-01-10', 1, 3),
	('2024-02-10', null, 2, 3),
    ('2024-03-10', null, 2, 3),
    ('2024-04-10', null, 2, 3),
    ('2024-05-10', null, 2, 3),
    ('2024-06-10', null, 2, 3),
	('2024-01-10', null, 3, 4),
	('2024-02-10', null, 2, 4),
    ('2024-03-10', null, 2, 4),
    ('2024-04-10', null, 2, 4),
    ('2024-05-10', null, 2, 4),
    ('2024-06-10', null, 2, 4),
    ('2024-01-10', null, 3, 5),
	('2024-02-10', null, 2, 5),
    ('2024-03-10', null, 2, 5),
    ('2024-04-10', null, 2, 5),
    ('2024-05-10', null, 2, 5),
    ('2024-06-10', null, 2, 5);
    
  /*Frequencia*/  
insert into tbl_frequencia(fk_id_aluno, data_aula, presenca,fk_id_curso_disciplina_professor) values
	(1, '2024-02-01',true,1),
    (2, '2024-02-01',false,1),
    (3, '2024-02-01',true,2),
    (4, '2024-02-01',true,2),
    (5, '2024-02-01',true,3),
    (6, '2024-02-01',true,3),
    (7, '2024-02-01',true,4),
    (8, '2024-02-01',true,4),
    (9, '2024-02-01',true,5),
    (10, '2024-02-01',true,5),
    (1, '2024-02-02',false,1),
    (2, '2024-02-02',true,1),
    (3, '2024-02-02',true,2),
    (4, '2024-02-02',true,2),
    (5, '2024-02-02',false,3),
    (6, '2024-02-02',true,3),
    (7, '2024-02-02',true,4),
    (8, '2024-02-02',true,4),
    (9, '2024-02-02',true,5),
    (10, '2024-02-02',false,5);
    
 /*Notas*/   
insert into tbl_notas (fk_id_aluno, nota1, nota2, trabalho,substitutiva, fk_id_curso_disciplina_professor) values
	(1,10,10,10,null,1),
    (2,10,10,9,null,2),
    (3,10,10,10,null,3),
    (4,6,6,5,6,1),
    (5,7,7,7,null,1),
    (6,10,10,10,null,1),
    (7,10,10,10,null,1),
    (8,10,10,10,null,1),
    (9,10,10,10,null,1),
    (10,10,10,10,null,1),
    (1,10,10,10,null,2),
    (2,10,10,9,null,3),
    (3,10,10,10,null,4),
    (4,10,10,10,null,5),
    (5,10,10,10,null,1),
    (6,10,10,10,null,2),
    (7,10,10,10,null,3),
    (8,10,10,10,null,4),
    (9,10,10,10,null,5),
    (10,10,10,10,null,5);
	
   /* Relatórios */

/* Quantidade de Alunos por curso */
SELECT c.nome_curso, COUNT(a.id_aluno) AS total_alunos
FROM tbl_aluno a
JOIN tbl_turma t ON a.id_aluno = t.id_turma
JOIN tbl_curso c ON t.fk_id_curso = c.id_curso
GROUP BY c.nome_curso;

/* Alunos com pagamento pendente */
SELECT a.nome_aluno, p.vencimento
FROM tbl_pagamento p
JOIN tbl_aluno a ON p.fk_id_aluno = a.id_aluno
WHERE p.data_pagamento IS NULL;

-- Alunos aprovados, em DP ou reprovados em determinada disciplina
SELECT a.nome_aluno, d.nome_disciplina,
       (n.nota1 + n.nota2 + n.trabalho + n.substitutiva) / 4 AS media,
       CASE
           WHEN (n.nota1 + n.nota2 + n.trabalho + n.substitutiva) / 4 >= 6 THEN 'Aprovado'
           WHEN (n.nota1 + n.nota2 + n.trabalho + n.substitutiva) / 4 BETWEEN 4 AND 5.9 THEN 'DP'
           ELSE 'Reprovado'
       END AS status
FROM tbl_notas n
JOIN tbl_aluno a ON n.fk_id_aluno = a.id_aluno
JOIN tbl_curso_disciplina_professor cdp ON n.fk_id_curso_disciplina_professor = cdp.id_tbl_curso_disciplina_professor
JOIN tbl_disciplina d ON cdp.fk_id_disciplina = d.id_disciplina;

-- frequencia de um aluno
 SELECT a.nome_aluno, d.nome_disciplina, f.data_aula, f.presenca
FROM tbl_frequencia f
JOIN tbl_aluno a ON f.fk_id_aluno = a.id_aluno
JOIN tbl_curso_disciplina_professor cdp ON f.fk_id_curso_disciplina_professor = cdp.id_tbl_curso_disciplina_professor
JOIN tbl_disciplina d ON cdp.fk_id_disciplina = d.id_disciplina
WHERE a.nome_aluno = 'Carlos Silva'; /* Nome do aluno que deve ser procurado*/

/*Nome dos Alunos matriculados*/
SELECT 
    c.nome_curso, 
    a.nome_aluno
FROM 
    tbl_aluno a
JOIN 
    tbl_turma t ON a.fk_id_turma = t.id_turma
JOIN 
    tbl_curso c ON t.fk_id_curso = c.id_curso
ORDER BY 
    c.nome_curso, a.nome_aluno;
    
/* historicos de notas dos alunos*/
SELECT 
    a.nome_aluno,
    c.nome_curso,
    d.nome_disciplina,
    n.nota1,
    n.nota2,
    n.trabalho,
    n.substitutiva
FROM tbl_aluno a
JOIN tbl_notas n ON a.id_aluno = n.fk_id_aluno
JOIN tbl_curso_disciplina_professor cdp ON n.fk_id_curso_disciplina_professor = cdp.id_tbl_curso_disciplina_professor
JOIN tbl_disciplina d ON cdp.fk_id_disciplina = d.id_disciplina
JOIN tbl_turma t ON a.fk_id_turma = t.id_turma
JOIN tbl_curso c ON t.fk_id_curso = c.id_curso
WHERE a.nome_aluno = 'Carlos Silva'; /*nome do aluno para procurar o historico*/

/*Notas e frequencias por turma*/
SELECT 
    a.nome_aluno, 
    d.nome_disciplina,
    n.nota1, 
    n.nota2, 
    n.trabalho, 
    n.substitutiva,
    COUNT(f.id_frequencia) AS total_aulas,
    SUM(CASE WHEN f.presenca = TRUE THEN 1 ELSE 0 END) AS presencas,
    (SUM(CASE WHEN f.presenca = TRUE THEN 1 ELSE 0 END) * 100 / COUNT(f.id_frequencia)) AS percentual_frequencia
FROM 
    tbl_aluno a
JOIN 
    tbl_turma t ON a.fk_id_turma = t.id_turma
JOIN 
    tbl_notas n ON a.id_aluno = n.fk_id_aluno
JOIN 
    tbl_curso_disciplina_professor cdp ON n.fk_id_curso_disciplina_professor = cdp.id_tbl_curso_disciplina_professor
JOIN 
    tbl_disciplina d ON cdp.fk_id_disciplina = d.id_disciplina
LEFT JOIN 
    tbl_frequencia f ON a.id_aluno = f.fk_id_aluno AND f.fk_id_curso_disciplina_professor = cdp.id_tbl_curso_disciplina_professor
WHERE 
    t.id_turma = 1  /* QUal ID da turma desejada */
GROUP BY 
    a.nome_aluno, d.nome_disciplina, n.nota1, n.nota2, n.trabalho, n.substitutiva
ORDER BY 
    a.nome_aluno, d.nome_disciplina;

/*Inadimplentes*/    
SELECT 
    a.nome_aluno,
    a.cpf,
    c.nome_curso,
    p.vencimento,
    s.status_boleto
FROM tbl_pagamento p
JOIN tbl_aluno a ON p.fk_id_aluno = a.id_aluno
JOIN tbl_status_pagamento s ON p.fk_id_status_pagamento = s.id_status_pagamento
JOIN tbl_turma t ON a.fk_id_turma = t.id_turma
JOIN tbl_curso c ON t.fk_id_curso = c.id_curso
WHERE s.status_boleto IN ('Pendente', 'Atrasado')
ORDER BY a.nome_aluno, p.vencimento;

/* Disciplina por professor */
SELECT 
    p.nome_professor,
    d.nome_disciplina,
    d.carga_horaria_disciplina,
    c.nome_curso
FROM tbl_curso_disciplina_professor cdp
JOIN tbl_professor p ON cdp.fk_id_professor = p.id_professor
JOIN tbl_disciplina d ON cdp.fk_id_disciplina = d.id_disciplina
JOIN tbl_curso c ON cdp.fk_id_curso = c.id_curso
ORDER BY p.nome_professor, d.nome_disciplina;


/*Lista de aprovados*/

SELECT 
    a.nome_aluno,
    d.nome_disciplina,
    c.nome_curso,
    (COALESCE(n.nota1, 0) + COALESCE(n.nota2, 0) + COALESCE(n.trabalho, 0) + COALESCE(n.substitutiva, 0)) / 3 AS media_final,
    CASE 
        WHEN (COALESCE(n.nota1, 0) + COALESCE(n.nota2, 0) + COALESCE(n.trabalho, 0) + COALESCE(n.substitutiva, 0)) / 3 >= 6 THEN 'Aprovado'
        ELSE 'Reprovado'
    END AS status
FROM tbl_aluno a
JOIN tbl_notas n ON a.id_aluno = n.fk_id_aluno
JOIN tbl_curso_disciplina_professor cdp ON n.fk_id_curso_disciplina_professor = cdp.id_tbl_curso_disciplina_professor
JOIN tbl_disciplina d ON cdp.fk_id_disciplina = d.id_disciplina
JOIN tbl_turma t ON a.fk_id_turma = t.id_turma
JOIN tbl_curso c ON t.fk_id_curso = c.id_curso
ORDER BY a.nome_aluno, d.nome_disciplina;

/*lista para cobranca*/
SELECT 
    a.nome_aluno, 
    a.telefone,
    p.vencimento AS data_vencimento
FROM 
    tbl_aluno a
JOIN 
    tbl_pagamento p ON a.id_aluno = p.fk_id_aluno
JOIN 
    tbl_status_pagamento sp ON p.fk_id_status_pagamento = sp.id_status_pagamento
WHERE 
    sp.status_boleto = 'Atrasado'
ORDER BY 
    p.vencimento ASC;