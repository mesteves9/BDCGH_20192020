/* RESOLUCAO DA FICHA 7 */

/* QUESTAO 1 */
/* ALINEA K */
SELECT nome AS nome_medico, idade(data_nascimento) AS idade_medico FROM Clinica.MEDICO AS med, Clinica.ESPECIALIDADE AS esp
WHERE esp.designacao='Clinica Geral' AND med.especialidade=esp.id_especialidade
AND (SELECT COUNT(*) FROM Clinica.CONSULTA AS con
WHERE date_format(data_hora,'%Y-%m')='2016-01' AND med.id_medico=con.id_medico)=0;

/* ALINEA L */
SELECT nome AS nome_paciente, idade(data_nascimento) AS idade_paciente FROM Clinica.PACIENTE AS pac
WHERE ((SELECT COUNT(DISTINCT id_medico) FROM Clinica.CONSULTA AS con
WHERE con.id_paciente=pac.id_paciente) = (SELECT COUNT(*) FROM Clinica.MEDICO));

/* ALINEA N */
SELECT nome AS nome_medico FROM Clinica.MEDICO AS med
WHERE (SELECT COUNT(*) FROM Clinica.CONSULTA AS con, Clinica.PACIENTE AS pac, Clinica.CODIGO_POSTAL AS cp
WHERE localidade='BRAGA' AND med.id_medico=con.id_medico AND con.id_paciente=pac.id_paciente
AND pac.codigo_postal=cp.codigo_postal)=0;

/* ALINEA O */
SELECT nome AS nome_paciente, idade(data_nascimento) AS idade_paciente FROM Clinica.PACIENTE AS pac
WHERE (SELECT COUNT(*) FROM Clinica.CONSULTA AS con, Clinica.MEDICO AS med, Clinica.ESPECIALIDADE AS esp
WHERE esp.designacao='Clinica Geral' AND pac.id_paciente=con.id_paciente AND con.id_medico=med.id_medico AND med.especialidade=esp.id_especialidade)>0
AND (SELECT COUNT(*) FROM Clinica.CONSULTA AS con, Clinica.MEDICO AS med, Clinica.ESPECIALIDADE AS esp
WHERE esp.designacao!='Clinica Geral' AND pac.id_paciente=con.id_paciente AND con.id_medico=med.id_medico AND med.especialidade=esp.id_especialidade)=0;

/* QUESTAO 2 */
/* ALINEA A */
SELECT AVG(idade(data_nascimento)) AS media_idades_medicos FROM Clinica.MEDICO
WHERE idade(data_inicio_servico)>15;

/* ALINEA B */
/* RETORNA OS VALORES NULL (RESOLUCAO CORRETA) */
SELECT esp.designacao AS nome_especialidade, (SELECT AVG(idade(med.data_inicio_servico)) FROM Clinica.MEDICO AS med
WHERE med.especialidade=esp.id_especialidade) AS media_anos_servico_medicos
FROM Clinica.ESPECIALIDADE AS esp
ORDER BY esp.designacao ASC; #por ordem alfabética ascendente (de A a Z)
/* NAO RETORNA OS VALORES NULL (RESOLUCAO INCORRETA NESTE CASO ESPECIFICO) */
SELECT esp.designacao AS nome_especialidade, AVG(idade(med.data_inicio_servico)) AS media_anos_servico_medicos FROM Clinica.MEDICO AS med, Clinica.ESPECIALIDADE AS esp
WHERE med.especialidade=esp.id_especialidade
GROUP BY esp.designacao
ORDER BY esp.designacao ASC; #por ordem alfabética ascendente (de A a Z)

/* ALINEA C */
SELECT med.nome AS nome_medico, (SELECT COUNT(*) FROM Clinica.CONSULTA AS con
WHERE med.id_medico=con.id_medico) AS numero_consultas_medico
FROM Clinica.MEDICO AS med
ORDER BY med.nome ASC; #por ordem alfabética ascendente (de A a Z)

/* ALINEA D */
SELECT med.nome AS nome_medico, (SELECT SUM(con.preco) FROM Clinica.CONSULTA AS con WHERE date_format(con.data_hora,'%Y')=2016
AND med.id_medico=con.id_medico) AS total_valor_faturado_2016
FROM Clinica.MEDICO AS med
ORDER BY med.nome; #por ordem alfabética ascendente (de A a Z)

/* ALINEA E */
SELECT esp.designacao AS nome_especialidade, (SELECT COUNT(*) FROM Clinica.MEDICO AS med
WHERE esp.id_especialidade=med.especialidade) AS numero_medicos_especialidade
FROM Clinica.ESPECIALIDADE AS esp
ORDER BY esp.designacao; #por ordem alfabética ascendente (de A a Z)

/* ALINEA F */
SELECT esp.designacao AS nome_especialidade, MIN(con.preco) AS valor_min_faturado, MAX(con.preco) AS valor_max_faturado, AVG(con.preco) AS valor_medio_faturado
FROM Clinica.ESPECIALIDADE AS esp, Clinica.CONSULTA AS con, Clinica.MEDICO AS med
WHERE esp.id_especialidade=med.especialidade AND con.id_medico=med.id_medico
GROUP BY esp.designacao
HAVING COUNT(DISTINCT con.id_medico)<2;

/* ALINEA G */
SELECT med.nome AS nome_medico, AVG(con.preco) AS valor_medio_faturado_consulta_2016 FROM Clinica.MEDICO AS med, Clinica.CONSULTA AS con
WHERE date_format(con.data_hora,'%Y')=2016 AND med.id_medico=con.id_medico
GROUP BY med.nome
HAVING AVG(con.preco)>(SELECT AVG(preco) FROM Clinica.CONSULTA
WHERE date_format(data_hora,'%Y')=2016);
