SELECT
    de.Estado,
    dl.Cidade,
    MIN(dt.Data) AS Data_Inicial,
    MAX(dt.Data) AS Data_Final,
    SUM(fc.Casos_Confirmados) AS Total_Casos_Confirmados,
    SUM(fc.Mortes) AS Total_Mortes,
    ROUND(AVG(fc.Casos_Confirmados_Por_100k), 0) AS Media_Casos_Confirmados_Por_100k
FROM Dimensao_Tempo dt
LEFT JOIN Fato_Covid fc ON dt.Data_ID = fc.Tempo_ID
INNER JOIN Dimensao_Estado de ON de.Estado_ID = fc.Estado_ID
INNER JOIN Dimensao_Localidade dl ON dl.Localidade_ID = fc.Localidade_ID
INNER JOIN Dimensao_Populacao dp ON dp.Populacao_ID = fc.Populacao_ID
WHERE dl.Cidade IS NOT NULL
GROUP BY de.Estado, dl.Cidade
ORDER BY SUM(fc.Casos_Confirmados) DESC;