/* RESOLUCAO DA FICHA 8 */

/* PARA CRIAR AS FUNCOES */
SET GLOBAL log_bin_trust_function_creators = 1;

/* ALINEA A */
/* PROCEDIMENTO */
DELIMITER //
CREATE PROCEDURE `Atualiza_Preco_Referencia_Especialidade` (IN ano INT(11), IN percentagem DECIMAL(4,2))
BEGIN
UPDATE Clinica.ESPECIALIDADE AS esp SET preco=IFNULL((SELECT AVG(con.preco) FROM Clinica.CONSULTA AS con, Clinica.MEDICO AS med
WHERE date_format(con.data_hora,'%Y')=ano AND esp.id_especialidade=med.especialidade AND med.id_medico=con.id_medico), preco)
* (1+(percentagem/100));
END //
DELIMITER ;

/* EXECUTAR PROCEDIMENTO */
CALL Atualiza_Preco_Referencia_Especialidade(2016, 3.75);

/* ALINEA B */
/* FUNCAO */
DELIMITER //
CREATE FUNCTION `temConsultas`(id_med INT(11)) RETURNS BOOLEAN
BEGIN

DECLARE numero_consultas_medico INT(11) DEFAULT 0;

SELECT COUNT(*) INTO numero_consultas_medico FROM Clinica.CONSULTA AS con WHERE con.id_medico=id_med;

IF numero_consultas_medico = 0 THEN RETURN FALSE;
ELSE RETURN TRUE;
END IF;

END //
DELIMITER ;

/* EXECUTAR OPERACAO */
DELETE FROM Clinica.MEDICO WHERE NOT temConsultas(id_medico);

/* ALINEA C */
/* FUNCAO */
/* COMPLETAR */

/* EXECUTAR OPERACAO */
/* COMPLETAR */

/* ALINEA D */
/* ADICIONAR COLUNA TOTAL_FATURADO NA TABELA MEDICO */
ALTER TABLE Clinica.MEDICO ADD total_faturado DECIMAL(10, 2);
/* CARREGAR VALORES DA COLUNA TOTAL_FATURADO COM DADOS DA BD */
UPDATE Clinica.MEDICO AS med SET med.total_faturado = (SELECT SUM(con.preco) FROM Clinica.CONSULTA AS con
WHERE med.id_medico=con.id_medico);
/* MANTER VALORES DA COLUNA TOTAL_FATURADO SEMPRE ATUALIZADOS */
DELIMITER //
CREATE PROCEDURE `Atualizar_Total_Faturado_Medico` (IN id_med INT(11), IN preco_consulta DECIMAL(8,2))
BEGIN
UPDATE Clinica.MEDICO AS med SET total_faturado = total_faturado + preco_consulta WHERE med.id_medico=id_med;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER `CONSULTA_AFTER_INSERT1` AFTER INSERT ON Clinica.CONSULTA FOR EACH ROW
BEGIN
CALL Atualizar_Total_Faturado_Medico(new.id_medico, new.preco);
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER `CONSULTA_AFTER_UPDATE1` AFTER UPDATE ON Clinica.CONSULTA FOR EACH ROW
BEGIN
CALL Atualizar_Total_Faturado_Medico(old.id_medico, old.preco*(-1));
CALL Atualizar_Total_Faturado_Medico(new.id_medico, new.preco);
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER `CONSULTA_AFTER_DELETE1` AFTER DELETE ON Clinica.CONSULTA FOR EACH ROW
BEGIN
CALL Atualizar_Total_Faturado_Medico(old.id_medico, old.preco*(-1));
END //
DELIMITER ;

/* ALINEA E */
/* CRIAR TABELA PACIENTE_ACUMULADO_MENSAL */
/* COMPLETAR */

/* CARREGAR A TABELA PACIENTE_ACUMULADO_MENSAL COM DADOS DA BD */
/* COMPLETAR */

/* MANTER VALORES DA TABELA PACIENTE_ACUMULADO_MENSAL SEMPRE ATUALIZADOS */
/* COMPLETAR */

/* VISUALIZAR TODOS OS TRIGGERS DA BD */
SHOW TRIGGERS;