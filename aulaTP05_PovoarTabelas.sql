/* SAMPLE DO POVOAMENTO DAS TABELAS */

INSERT INTO Exemplo.ESPECIALIDADE (id_especialidade, designacao) VALUES (1, 'Cardiologia');
INSERT INTO Exemplo.ESPECIALIDADE (id_especialidade, designacao) VALUES (2, 'Neurologia');
INSERT INTO Exemplo.ESPECIALIDADE (id_especialidade, designacao) VALUES (3, 'Medicina Geral');
INSERT INTO Exemplo.ESPECIALIDADE (id_especialidade, designacao) VALUES (4, 'Estomatologia');
INSERT INTO Exemplo.ESPECIALIDADE (id_especialidade, designacao) VALUES (5, 'Nefrologia');
/* (...) */

INSERT INTO Exemplo.HOSPITAL (id_hospital, nome) VALUES (1, 'Centro Hospitalar Sao Joao');
INSERT INTO Exemplo.HOSPITAL (id_hospital, nome) VALUES (2, 'Centro Hospitalar do Porto');
/* (...) */

INSERT INTO Exemplo.HOSPITAL_CONTACTO (id_hospital, tipo, numero) VALUES (1, 'telefone', 225512100);
INSERT INTO Exemplo.HOSPITAL_CONTACTO (id_hospital, tipo, numero) VALUES (1, 'fax', 225025766);
INSERT INTO Exemplo.HOSPITAL_CONTACTO (id_hospital, tipo, numero) VALUES (2, 'telefone', 222077500);
INSERT INTO Exemplo.HOSPITAL_CONTACTO (id_hospital, tipo, numero) VALUES (2, 'telefone', 226050200);
/* (...) */

INSERT INTO Exemplo.MEDICO (id_medico, nome, data_nascimento, rua, codigo_postal, localidade, especialidade) VALUES (1, 
'Jose Alves', '1956-07-01', 'Rua Dr. Joaquim Duarte n.º 223, 5.º DTO', '4715-017', 'Braga', 2);
INSERT INTO Exemplo.MEDICO (id_medico, nome, data_nascimento, rua, codigo_postal, localidade, especialidade) VALUES (2, 
'Maria Duarte', '1974-09-14', 'Rua Eng. Marcelo Oliveira n.º 125, 2.º ESQ', '4715-023', 'Braga', 1);
INSERT INTO Exemplo.MEDICO (id_medico, nome, data_nascimento, rua, codigo_postal, localidade, especialidade) VALUES (3, 
'Joaquim Coimbra', '1984-05-09', 'Rua Prof. Beatriz Soares n.º 789, 9.º DTO', '4200-314', 'Porto', 1);
INSERT INTO Exemplo.MEDICO (id_medico, nome, data_nascimento, rua, codigo_postal, localidade, especialidade) VALUES (4, 
'Mario Goncalves', '1943-11-24', 'Rua Eng. Marcelo dos Santos n.º 456, 1.º DTO', '4097-002', 'Porto', 5);
INSERT INTO Exemplo.MEDICO (id_medico, nome, data_nascimento, rua, codigo_postal, localidade, especialidade) VALUES (5, 
'Joana Silva', '1978-07-12', 'Rua Dr. Orlando Soares n.º 120, 3.º ESQ', '4096-012', 'Porto', 4);
INSERT INTO Exemplo.MEDICO (id_medico, nome, data_nascimento, rua, codigo_postal, localidade, especialidade) VALUES (6, 
'Jorge Oliveira', '1989-12-24', 'Rua Eng. Joao Miranda n.º 98, 2.º ESQ', '4715-022', 'Braga', 5);
/* (...) */

INSERT INTO Exemplo.MEDICO_CONTACTO (id_medico, tipo, numero) VALUES (1, 'telemovel', 919999999);
INSERT INTO Exemplo.MEDICO_CONTACTO (id_medico, tipo, numero) VALUES (1, 'telemovel', 929999999);
/* (...) */

INSERT INTO Exemplo.MEDICO_HOSPITAL (id_medico, id_hospital, data_inicio_servico) VALUES (1, 2, '1993-06-02');
INSERT INTO Exemplo.MEDICO_HOSPITAL (id_medico, id_hospital, data_inicio_servico) VALUES (1, 1, '1999-02-17');
INSERT INTO Exemplo.MEDICO_HOSPITAL (id_medico, id_hospital, data_inicio_servico) VALUES (2, 1, '2005-05-23');
INSERT INTO Exemplo.MEDICO_HOSPITAL (id_medico, id_hospital, data_inicio_servico) VALUES (3, 1, '2011-01-09');
INSERT INTO Exemplo.MEDICO_HOSPITAL (id_medico, id_hospital, data_inicio_servico) VALUES (3, 2, '2015-11-22');
INSERT INTO Exemplo.MEDICO_HOSPITAL (id_medico, id_hospital, data_inicio_servico) VALUES (4, 1, '1984-06-08');
INSERT INTO Exemplo.MEDICO_HOSPITAL (id_medico, id_hospital, data_inicio_servico) VALUES (5, 2, '2008-12-28');
/* (...) */


