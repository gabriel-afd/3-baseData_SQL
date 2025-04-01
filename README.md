
# Projeto IntuitiveCare - Importação de Dados no MySQL

Este repositório contém instruções para importar arquivos CSV da ANS para um banco de dados MySQL ou PostgreSQL usando comandos nativos de cada sistema.

## Fontes de Dados da ANS

- [Demonstrativos Contábeis Trimestrais](https://dadosabertos.ans.gov.br/FTP/PDA/demonstracoes_contabeis/)
- [Cadastro de Operadoras Ativas](https://dadosabertos.ans.gov.br/FTP/PDA/operadoras_de_plano_de_saude_ativas/)

---

# Como importar um arquivo CSV para o MySQL usando LOAD DATA LOCAL INFILE

Este guia mostra como importar um arquivo `.csv` para uma tabela MySQL usando o comando `LOAD DATA LOCAL INFILE` diretamente pelo terminal.

---

## Requisitos
- MySQL instalado (ex: MySQL Server 8.0)
- Caminho para o `mysql.exe` conhecido
- Acesso ao terminal (CMD, PowerShell ou terminal Linux)
- Arquivo CSV com delimitador `;` e campos entre aspas `""

---

## ⚠️ Importante
**Ao informar o caminho do arquivo CSV, use `barra normal (/)` ao invés de `barra invertida (\)`**. 

Errado:
```
C:\Users\usuario\Downloads\arquivo.csv
```

Certo:
```
C:/Users/usuario/Downloads/arquivo.csv
```

---

##  Passos para importar o CSV:

### 1. Abrir o terminal e conectar-se ao MySQL com suporte a arquivos locais:

```bash
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -p --local-infile=1
```

> Obs: Substitua o caminho se o MySQL estiver instalado em outro diretório.

### 2. Selecionar o banco de dados desejado:

```sql
USE db_intuitive_care;
```

### 3. Executar o comando de importação para a tabela `operadoras`:

```sql
LOAD DATA LOCAL INFILE 'C:/Users/gmede/Downloads/Relatorio_cadop.csv'
INTO TABLE operadoras
CHARACTER SET utf8
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

### 4. Executar o comando de importação para a tabela `demonstrativos_contabeis` com tratamento de colunas:

```sql
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
```

---

## Resultado
O(s) arquivo(s) CSV serão importados para as tabelas indicadas, com tratamento de cabeçalho e formatação de dados quando necessário.

Se tiver problemas com permissões ou erros de conexão, verifique se:
- O MySQL está com `local_infile=1` habilitado no servidor (`SET GLOBAL local_infile = 1;`)
- O caminho do arquivo está correto
- O CSV está salvo com codificação UTF-8 (sem BOM)

---




