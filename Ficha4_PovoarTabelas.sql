/* SAMPLE DO POVOAMENTO DAS TABELAS */

INSERT INTO Ficha3.ALUNO (id_aluno, nome, data_nascimento, n_contribuinte, n_cc, nome_pai, nome_mae, 
nome_encarregado_educacao, rua, codigo_postal, localidade) VALUES (1, 'Mario Goncalves', '1993-01-09', 123456789, 
'123456781ABC', 'Joaquim Alves', 'Maria Duarte', 'Maria Duarte', 'Rua Eng. Pedro Henriques n.º 114, 7.º DTO', 
'4715-011', 'Braga');
/* (...) */

INSERT INTO Ficha3.ALUNO_CONTACTO (id_aluno, tipo, numero) VALUES (1, 'telemovel', 919999999);
INSERT INTO Ficha3.ALUNO_CONTACTO (id_aluno, tipo, numero) VALUES (1, 'telemovel', 929999999);
/* (...) */

INSERT INTO Ficha3.DEPARTAMENTO (id_departamento, designacao) VALUES (1, 'Departamento de Informatica');
/* (...) */

INSERT INTO Ficha3.DOCENTE (id_docente, nome, categoria, departamento) VALUES (1, 'Jose Machado', 'Professor Associado com Agregacao', 
1);
INSERT INTO Ficha3.DOCENTE (id_docente, nome, categoria, departamento) VALUES (2, 'Marisa Esteves', 'Assistente Convidada', 
1);
INSERT INTO Ficha3.DOCENTE (id_docente, nome, categoria, departamento) VALUES (3, 'Antonio dos Santos', 'Professor Catedratico', 
1);
/* (...) */

INSERT INTO Ficha3.CURSO (id_curso, designacao, ciclo_estudos, grau, n_alunos_inscritos, diretor) VALUES (1, 'Mestrado Integrado em Engenharia Biomedica', 
1, 'Mestre', null, 3);
/* (...) */

INSERT INTO Ficha3.ALUNO_CURSO (id_aluno, id_curso, data_inicio, data_fim, n_ucs_realizadas, n_ects, media_atual) VALUES (1, 
1, '2017-09-17', null, null, null, null);
/* (...) */

INSERT INTO Ficha3.UC (id_uc, designacao, escolaridade, ano_letivo, semestre, curso, responsavel) VALUES (1, 'Bases de Dados Clinicas e de Gestao Hospitalar', 
3, 2018, 2, 1, 1);
/* (...) */

INSERT INTO Ficha3.DOCENTE_UC (id_docente, id_uc, tipo, n_horas_semanais) VALUES (1, 1, 'Aulas Teoricas', 2);
INSERT INTO Ficha3.DOCENTE_UC (id_docente, id_uc, tipo, n_horas_semanais) VALUES (2, 1, 'Aulas Teorico-Praticas', 4);
/* (...) */

INSERT INTO Ficha3.ALUNO_UC (id_aluno, id_UC, data_inscricao, data_realizacao, nota_final) VALUES (1, 1, '2018-02-04', 
null, null);
/* (...) */


