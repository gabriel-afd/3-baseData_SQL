/*Importanto CSV*/
USE db_intuitive_care;

/*Inserindo dados na tabela operadoras*/
LOAD DATA LOCAL INFILE 'F:/IntuitiveCare-MySQL/Relatorio de operadoras ativas/Relatorio_cadop.csv' INTO TABLE operadoras 
CHARACTER SET utf8
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from operadoras;

/*Inserindo dados na tabela demonstrativos_contabeis*/
LOAD DATA LOCAL INFILE 'F:/IntuitiveCare-MySQL/2024/4T2024.csv' INTO TABLE demonstrativos_contabeis 
CHARACTER SET utf8
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@data, @reg_ans, @cd_conta, @descricao, @saldo_ini, @saldo_fin)
SET
  data = STR_TO_DATE(@data, '%Y-%m-%d'),
  reg_ans = NULLIF(@reg_ans, ''),
  cd_conta_contabil = NULLIF(@cd_conta, ''),
  descricao = NULLIF(@descricao, ''),
  vl_saldo_inicial = NULLIF(@saldo_ini, ''),
  vl_saldo_final = NULLIF(@saldo_fin, '');

select * from demonstrativos_contabeis where year(data) = 2023;
select * from demonstrativos_contabeis where year(data) = 2024;

delete from demonstrativos_contabeis;







