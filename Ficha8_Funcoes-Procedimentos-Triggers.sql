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
DELIMITER //
CREATE FUNCTION `utilizadoCodigoPostal`(cp VARCHAR(8)) RETURNS BOOLEAN
BEGIN

DECLARE numero_cp_medicos INT(11) DEFAULT 0;
DECLARE numero_cp_pacientes INT(11) DEFAULT 0;

SELECT COUNT(*) INTO numero_cp_medicos FROM Clinica.MEDICO AS med WHERE med.codigo_postal=cp;
SELECT COUNT(*) INTO numero_cp_pacientes FROM Clinica.PACIENTE AS pac WHERE pac.codigo_postal=cp;

IF numero_cp_medicos=0 AND numero_cp_pacientes=0 THEN RETURN FALSE;
ELSE RETURN TRUE;
END IF;

END //
DELIMITER ;
/* EXECUTAR OPERACAO */
DELETE FROM Clinica.CODIGO_POSTAL WHERE NOT utilizadoCodigoPostal(codigo_postal);

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
CREATE TABLE PACIENTE_ACUMULADO_MENSAL (
    id_paciente INT(11) NOT NULL,
    ano INT(11) NOT NULL,
    mes INT(11) NOT NULL,
    total_faturado DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (id_paciente, ano, mes),
    CONSTRAINT fk_paciente2 FOREIGN KEY (id_paciente) REFERENCES Clinica.PACIENTE(id_paciente)
);
/* CARREGAR A TABELA PACIENTE_ACUMULADO_MENSAL COM DADOS DA BD */
INSERT INTO Clinica.PACIENTE_ACUMULADO_MENSAL (id_paciente, ano, mes, total_faturado)
SELECT id_paciente, date_format(data_hora,"%Y"), date_format(data_hora,"%m"), SUM(preco) FROM Clinica.CONSULTA 
GROUP BY id_paciente, date_format(data_hora,"%Y"), date_format(data_hora,"%m")
ORDER BY id_paciente, date_format(data_hora,"%Y"), date_format(data_hora,"%m");
/* MANTER VALORES DA TABELA PACIENTE_ACUMULADO_MENSAL SEMPRE ATUALIZADOS */
DELIMITER //
CREATE PROCEDURE `Atualizar_Paciente_Acumulado_Mensal` (IN id_pac INT(11), IN ano_pac INT(11), IN mes_pac INT(11), IN valor_pac DECIMAL(8,2))
BEGIN

DECLARE existe_linha INT(11) DEFAULT 0;

SELECT COUNT(*) INTO existe_linha FROM Clinica.PACIENTE_ACUMULADO_MENSAL AS pac_am WHERE pac_am.id_paciente=id_pac
AND pac_am.ano=ano_pac AND pac_am.mes=mes_pac;

IF existe_linha=1 THEN 
UPDATE Clinica.PACIENTE_ACUMULADO_MENSAL AS pac_am SET pac_am.total_faturado=pac_am.total_faturado+valor_pac WHERE pac_am.id_paciente=id_pac
AND pac_am.ano=ano_pac AND pac_am.mes=mes_pac;
ELSE
INSERT INTO Clinica.PACIENTE_ACUMULADO_MENSAL (id_paciente, ano, mes, total_faturado) VALUES (id_pac, ano_pac, mes_pac, valor_pac);
END IF;

END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER `CONSULTA_AFTER_INSERT2` AFTER INSERT ON Clinica.CONSULTA FOR EACH ROW
BEGIN
CALL Atualizar_Paciente_Acumulado_Mensal(new.id_paciente, date_format(new.data_hora,"%Y"), date_format(new.data_hora,"%m"), 
new.preco);
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER `CONSULTA_AFTER_UPDATE2` AFTER UPDATE ON Clinica.CONSULTA FOR EACH ROW
BEGIN
CALL Atualizar_Paciente_Acumulado_Mensal(old.id_paciente, date_format(old.data_hora,"%Y"), date_format(old.data_hora,"%m"), 
old.preco*(-1));
CALL Atualizar_Paciente_Acumulado_Mensal(new.id_paciente, date_format(new.data_hora,"%Y"), date_format(new.data_hora,"%m"), 
new.preco);
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER `CONSULTA_AFTER_DELETE2` AFTER DELETE ON Clinica.CONSULTA FOR EACH ROW
BEGIN
CALL Atualizar_Paciente_Acumulado_Mensal(old.id_paciente, date_format(old.data_hora,"%Y"), date_format(old.data_hora,"%m"), 
old.preco*(-1));
END //
DELIMITER ;

/* VISUALIZAR TODOS OS TRIGGERS DA BD */
SHOW TRIGGERS;