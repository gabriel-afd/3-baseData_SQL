
# Projeto IntuitiveCare - Importação de Dados

Este repositório contém instruções para importar arquivos CSV da ANS para um banco de dados MySQL ou PostgreSQL usando comandos nativos de cada sistema.

## Fontes de Dados da ANS

- [Demonstrativos Contábeis Trimestrais](https://dadosabertos.ans.gov.br/FTP/PDA/demonstracoes_contabeis/)
- [Cadastro de Operadoras Ativas](https://dadosabertos.ans.gov.br/FTP/PDA/operadoras_de_plano_de_saude_ativas/)

---

# Como habilitar o uso de `LOAD DATA LOCAL INFILE` no MySQL

Para importar os arquivos CSV para a tabela `demonstrativos_contabeis` com o comando:

```sql
LOAD DATA LOCAL INFILE 'F:/IntuitiveCare-MySQL/2024/4T2024.csv'
INTO TABLE demonstrativos_contabeis
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

Siga as instruções abaixo para garantir que sua instância MySQL permita o uso do `LOCAL INFILE`:

---

### 1. Ativar `local_infile` no servidor

No terminal MySQL ou no Workbench:
```sql
SET GLOBAL local_infile = 1;
```

---

### 2. Permitir que o cliente utilize `LOCAL`

Se estiver usando o Workbench, certifique-se de que a conexão foi criada com a opção `Allow LOAD DATA LOCAL INFILE` habilitada.

Se estiver usando CLI, adicione o parâmetro na conexão:
```bash
mysql -u root -p --local-infile
```

---

### 3. Verificar ou desativar `secure_file_priv` (se necessário)

Execute:
```sql
SHOW VARIABLES LIKE 'secure_file_priv';
```

Se o valor **não for vazio**, o MySQL só permitirá carregar arquivos a partir da pasta exibida. Copie o CSV para essa pasta **ou** edite o arquivo `my.ini` e comente a linha:
```ini
# secure-file-priv = "algum/caminho"
```
Depois, reinicie o serviço MySQL.

---

Pronto! Agora você pode importar seus dados com `LOAD DATA LOCAL INFILE` normalmente.

---

# Como importar dados CSV no PostgreSQL

O PostgreSQL não possui `LOAD DATA`, mas você pode usar o comando `COPY` ou `\COPY`.

### Usando `COPY` (no servidor PostgreSQL)

```sql
COPY demonstrativos_contabeis(data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
FROM 'F:/IntuitiveCare-PostgreSQL/2024/4T2024.csv'
DELIMITER ';'
CSV HEADER;
```

> Obs: O arquivo deve estar acessível pelo servidor PostgreSQL e com permissão de leitura.

### Usando `\COPY` (no terminal psql)

```bash
\COPY demonstrativos_contabeis(data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
FROM 'F:/IntuitiveCare-PostgreSQL/2024/4T2024.csv'
DELIMITER ';'
CSV HEADER;
```

> Obs: O `\COPY` funciona a partir da máquina cliente, ideal para arquivos locais.

---

Pronto! Agora você também consegue importar arquivos CSV no PostgreSQL.
