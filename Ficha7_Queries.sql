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
/* SUBSTITUIR POR QUERY SQL */

/* ALINEA O */
/* SUBSTITUIR POR QUERY SQL */

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
/* SUBSTITUIR POR QUERY SQL */

/* ALINEA D */
/* SUBSTITUIR POR QUERY SQL */

/* ALINEA E */
/* SUBSTITUIR POR QUERY SQL */

/* ALINEA F */
/* SUBSTITUIR POR QUERY SQL */

/* ALINEA G */
/* SUBSTITUIR POR QUERY SQL */
