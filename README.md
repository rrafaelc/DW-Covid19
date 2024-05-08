# Relatório Técnico: Desenvolvimento de Data Warehouse para Análise de Dados COVID-19 no Brasil
## Introdução
Este relatório documenta o processo de desenvolvimento de um Data Warehouse (DW) para analisar e visualizar dados relacionados à pandemia de COVID-19 no Brasil. O DW foi construído utilizando o Microsoft SQL Server para a camada de armazenamento e o Power BI para visualização dos dados.

## Objetivo
O objetivo deste projeto foi criar uma solução que permitisse a análise dos casos de COVID-19 no Brasil, focando nas cidades com maior número de casos. A solução deveria proporcionar uma visão detalhada e atualizada da situação da pandemia no país, permitindo aos usuários explorar e compreender os dados de forma eficaz.

## Fonte de Dados
A fonte de dados utilizada foi um arquivo CSV contendo informações sobre casos de COVID-19 no Brasil, incluindo dados por cidade, estado, número de casos confirmados, número de casos por cada 100k habitantes (importante para uma avalição equitativa), óbitos, entre outros. Este arquivo foi obtido através do site Brasil.io e contém dados atualizados até 2022.

## Desenvolvimento da Solução
O desenvolvimento da solução foi dividido em várias etapas:

**ETL (Extract, Transform, Load):**
Os dados do arquivo CSV foram extraídos e importados para o SQL Server.
Durante o processo de transformação, os dados foram limpos, normalizados e modelados, em uma tabela chamada "covid".

**Modelagem do Data Warehouse:**
O modelo de dados foi projetado seguindo a abordagem do Star Schema, com uma tabela de fatos e quatro tabelas de dimensões.
A tabela de fatos inclui métricas como número de casos confirmados, óbitos, etc, enquanto as tabelas de dimensões representam informações sobre tempo, cidade, estado, entre outros.

**Criação de Visualizações no Power BI:**
Utilizamos o Power BI para mostrar graficamente os dados gerados da tabela fato, podendo ser visto quais foram as principais cidades e quantidade de casos, divididos, respectivamente, no gráfico, no eixo x e y.

**Resultados e Conclusões**
A solução desenvolvida permitiu uma análise detalhada dos dados de COVID-19 no Brasil.

#Conclusão
O desenvolvimento deste Data Warehouse proporcionou uma ferramenta poderosa para análise e monitoramento dos casos de COVID-19 no Brasil. A solução não apenas fornece informações atualizadas sobre a situação da pandemia, mas também permite a identificação de padrões e tendências que podem auxiliar na tomada de decisões e no planejamento de medidas de saúde pública.

