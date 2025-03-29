/*Querys analíticas*/

/* 10 operadoras com maiores despesas em "EVENTOS/ SINISTROS CONHECIDOS OU
AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR" no último trimestre?
*/
SELECT
    o.registro_ans,
    o.razao_social,
    o.nome_fantasia,
    SUM(dc.vl_saldo_final) AS total_despesas
FROM
    demonstrativos_contabeis dc
JOIN operadoras o ON o.registro_ans = dc.reg_ans
WHERE
    dc.descricao LIKE '%SINISTROS CONHECIDOS OU AVISADOS%MEDICO HOSPITALAR%'
    AND dc.data BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY
    o.registro_ans, o.razao_social, o.nome_fantasia
ORDER BY
    total_despesas DESC
LIMIT 10;


/*10 operadoras com maiores despesas nessa categoria no último ano?*/
SELECT
    o.registro_ans,
    o.razao_social,
    o.nome_fantasia,
    SUM(dc.vl_saldo_final) AS total_despesas
FROM
    demonstrativos_contabeis dc
JOIN operadoras o ON o.registro_ans = dc.reg_ans
WHERE
    dc.descricao LIKE '%SINISTROS CONHECIDOS OU AVISADOS%MEDICO HOSPITALAR%'
    AND dc.data BETWEEN '2023-01-01' AND '2024-03-31'
GROUP BY
    o.registro_ans, o.razao_social, o.nome_fantasia
ORDER BY
    total_despesas DESC
LIMIT 10;














