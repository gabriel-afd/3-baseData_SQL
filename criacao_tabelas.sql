CREATE DATABASE IF NOT EXISTS db_intuitive_care DEFAULT CHARACTER SET utf8;

USE db_intuitive_care;

/*Criação de tabela de operadoras*/
CREATE TABLE operadoras(
	registro_ans INT PRIMARY KEY,
    cnpj VARCHAR(20),
    razao_social VARCHAR(255),
    nome_fantasia VARCHAR(255),
    modalidade VARCHAR(100),
    logradouro VARCHAR(255),
    numero VARCHAR(20),
    complemento VARCHAR(100),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    uf VARCHAR(2),
    cep VARCHAR(10),
    ddd VARCHAR(3),
    telefone VARCHAR(30),
    fax VARCHAR(30),
    endereco_eletronico VARCHAR(255),
    representante VARCHAR(255),
    cargo_representante VARCHAR(100),
    regiao_de_comercializacao INT,
    data_registro_ans DATE
    
);

/*Criação de tabela de demonstrativos contábeis*/
CREATE TABLE demonstrativos_contabeis(
	id INT AUTO_INCREMENT PRIMARY KEY,
	data DATE,
    reg_ans INT,
    cd_conta_contabil VARCHAR(20),
    descricao VARCHAR(255),
    vl_saldo_inicial DECIMAL(18,2),
    vl_saldo_final DECIMAL(18,2),
    CONSTRAINT operadoras_demonstrativos_contabeis_fk FOREIGN KEY (reg_ans) 
		REFERENCES operadoras(registro_ans)
);

select * from operadoras;
select * from demonstrativos_contabeis;