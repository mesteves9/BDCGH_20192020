/* RESOLUCAO DA FICHA 6 */

/* ALINEA A */
SELECT nome AS nome_medico FROM Clinica.MEDICO 
WHERE idade(data_inicio_servico)>10;

/* ALINEA B */
SELECT nome AS nome_medico, designacao AS nome_especialidade FROM Clinica.MEDICO AS med, Clinica.ESPECIALIDADE AS esp
WHERE med.especialidade = esp.id_especialidade;
/* EXEMPLO DE OUTRA RESOLUCAO */
SELECT nome AS nome_medico, designacao AS nome_especialidade 
FROM Clinica.MEDICO AS med
INNER JOIN Clinica.ESPECIALIDADE AS esp ON med.especialidade = esp.id_especialidade;

/* ALINEA C */
SELECT nome AS nome_paciente, morada AS morada_paciente FROM Clinica.PACIENTE
WHERE codigo_postal IN (SELECT codigo_postal FROM CODIGO_POSTAL WHERE localidade='BRAGA');

/* ALINEA D */
SELECT nome AS nome_medico FROM Clinica.MEDICO AS med, Clinica.ESPECIALIDADE AS esp
WHERE designacao='Oftalmologia' AND med.especialidade = esp.id_especialidade;

/* ALINEA E */
SELECT nome AS nome_medico, idade(data_nascimento) AS idade_medico FROM Clinica.MEDICO AS med, Clinica.ESPECIALIDADE AS esp
WHERE idade(data_nascimento)>40 AND designacao='Clinica Geral' AND med.especialidade = esp.id_especialidade; 

/* ALINEA F */
SELECT DISTINCT med.nome AS nome_medico FROM Clinica.MEDICO AS med, Clinica.ESPECIALIDADE AS esp, Clinica.CONSULTA AS con, Clinica.PACIENTE AS pac, Clinica.CODIGO_POSTAL AS cp
WHERE esp.designacao='Oftalmologia' AND cp.localidade='BRAGA'
AND med.especialidade = esp.id_especialidade AND med.id_medico=con.id_medico AND con.id_paciente=pac.id_paciente
AND pac.codigo_postal=cp.codigo_postal;
/* EXEMPLO DE OUTRA RESOLUCAO */
SELECT DISTINCT med.nome AS nome_medico FROM Clinica.MEDICO AS med, Clinica.ESPECIALIDADE AS esp, Clinica.CONSULTA AS con, Clinica.PACIENTE AS pac, Clinica.CODIGO_POSTAL AS cp
WHERE esp.designacao='Oftalmologia' AND med.especialidade = esp.id_especialidade 
AND med.id_medico=con.id_medico AND med.id_medico IN (SELECT id_medico FROM Clinica.CONSULTA WHERE con.id_paciente=pac.id_paciente
AND id_paciente IN (SELECT id_paciente FROM Clinica.PACIENTE WHERE pac.codigo_postal=cp.codigo_postal AND codigo_postal IN
(SELECT codigo_postal FROM Clinica.CODIGO_POSTAL WHERE localidade='BRAGA')));

/* ALINEA G */
SELECT DISTINCT med.nome AS nome_medico, idade(med.data_inicio_servico) AS anos_servico_medico FROM Clinica.MEDICO AS med, Clinica.CONSULTA AS con, Clinica.PACIENTE AS pac
WHERE idade(med.data_nascimento)>50 AND med.id_medico=con.id_medico
AND med.id_medico IN (SELECT id_medico FROM Clinica.CONSULTA WHERE HOUR(data_hora)>=12
AND con.id_paciente=pac.id_paciente AND id_paciente IN (SELECT id_paciente FROM Clinica.PACIENTE WHERE idade(data_nascimento)<20));

/* ALINEA H */
SELECT nome AS nome_paciente, idade(data_nascimento) AS idade_paciente FROM Clinica.PACIENTE
WHERE idade(data_nascimento)>10
AND id_paciente NOT IN (SELECT id_paciente FROM Clinica.CONSULTA AS con, Clinica.MEDICO AS med, Clinica.ESPECIALIDADE AS esp
WHERE esp.designacao='Oftalmologia' AND con.id_medico=med.id_medico AND med.especialidade=esp.id_especialidade);
/* EXEMPLO DE OUTRA RESOLUCAO */
SELECT nome AS nome_paciente, idade(data_nascimento) AS idade_paciente FROM Clinica.PACIENTE AS pac
WHERE idade(data_nascimento)>10 
AND (SELECT COUNT(*) FROM Clinica.CONSULTA con, Clinica.MEDICO AS med, Clinica.ESPECIALIDADE AS esp 
WHERE esp.designacao='Oftalmologia' AND con.id_paciente=pac.id_paciente AND con.id_medico=med.id_medico 
AND med.especialidade=esp.id_especialidade)=0;

/* ALINEA I */
SELECT DISTINCT designacao AS nome_especialidade FROM Clinica.ESPECIALIDADE AS esp, Clinica.MEDICO AS med, Clinica.CONSULTA AS con
WHERE date_format(data_hora,'%Y-%m')='2016-01'
AND esp.id_especialidade=med.especialidade AND med.id_medico=con.id_medico;

/* ALINEA J */
SELECT nome AS nome_medico FROM Clinica.MEDICO 
WHERE idade(data_nascimento)>30 OR idade(data_inicio_servico)<5;

/* ALINEA K */
SELECT DISTINCT nome AS nome_medico, idade(data_nascimento) AS idade_medico FROM Clinica.MEDICO AS med, Clinica.ESPECIALIDADE AS esp, Clinica.CONSULTA AS con
WHERE esp.designacao='Clinica Geral' AND med.especialidade=esp.id_especialidade
AND med.id_medico=con.id_medico AND med.id_medico NOT IN (SELECT id_medico FROM Clinica.CONSULTA WHERE date_format(data_hora,'%Y-%m')='2016-01');

/* ALINEA L */
SELECT nome AS nome_paciente, idade(data_nascimento) AS idade_paciente FROM Clinica.PACIENTE AS pac
WHERE NOT EXISTS (SELECT * FROM Clinica.MEDICO AS med
WHERE NOT EXISTS (SELECT * FROM Clinica.CONSULTA AS con 
WHERE con.id_medico=med.id_medico AND con.id_paciente=pac.id_paciente));

/* ALINEA M */
SELECT esp.designacao AS nome_especialidade FROM Clinica.ESPECIALIDADE AS esp
WHERE (SELECT COUNT(*) FROM Clinica.CONSULTA AS con, Clinica.MEDICO AS med WHERE date_format(con.data_hora,'%Y-%m')='2016-01' AND
esp.id_especialidade=med.especialidade AND med.id_medico=con.id_medico)!=0 AND
(SELECT COUNT(*) FROM Clinica.CONSULTA AS con, Clinica.MEDICO AS med WHERE date_format(con.data_hora,'%Y-%m')='2016-03' AND
esp.id_especialidade=med.especialidade AND med.id_medico=con.id_medico)!=0;

/* ALINEA N */
SELECT nome AS nome_medico FROM Clinica.MEDICO
WHERE id_medico NOT IN (SELECT med.id_medico FROM Clinica.MEDICO AS med, Clinica.CONSULTA AS con, Clinica.PACIENTE AS pac, 
Clinica.CODIGO_POSTAL AS cp WHERE localidade='BRAGA' AND med.id_medico=con.id_medico AND con.id_paciente=pac.id_paciente
AND pac.codigo_postal=cp.codigo_postal);

/* ALINEA O */
SELECT nome AS nome_paciente, idade(data_nascimento) AS idade_paciente FROM Clinica.PACIENTE AS pac
WHERE id_paciente IN (SELECT id_paciente FROM Clinica.CONSULTA AS con, Clinica.MEDICO AS med, Clinica.ESPECIALIDADE AS esp
WHERE esp.designacao='Clinica Geral' AND pac.id_paciente=con.id_paciente AND con.id_medico=med.id_medico AND med.especialidade=esp.id_especialidade)
AND id_paciente NOT IN (SELECT id_paciente FROM Clinica.CONSULTA AS con, Clinica.MEDICO AS med, Clinica.ESPECIALIDADE AS esp
WHERE esp.designacao!='Clinica Geral' AND pac.id_paciente=con.id_paciente AND con.id_medico=med.id_medico AND med.especialidade=esp.id_especialidade);
