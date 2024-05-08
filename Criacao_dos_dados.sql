CREATE DATABASE brasil_covid_dw;
GO
USE brasil_covid_dw;
GO


CREATE TABLE Dimensao_Tempo (
    Data_ID INT IDENTITY(1,1) PRIMARY KEY,
    Data DATE,
    Semana_Epidemiologica INT
);
GO

CREATE TABLE Dimensao_Localidade (
    Localidade_ID INT IDENTITY(1,1) PRIMARY KEY,
    Cidade VARCHAR(255),
    Codigo_IBGE_Cidade INT
);
GO

CREATE TABLE Dimensao_Populacao (
    Populacao_ID INT IDENTITY(1,1) PRIMARY KEY,
    Populacao_Estimada INT,
    Populacao_Estimada_2019 INT
);
GO

CREATE TABLE Dimensao_Estado (
    Estado_ID INT IDENTITY(1,1) PRIMARY KEY,
    Estado CHAR(2)
);
GO

CREATE TABLE Fato_Covid (
    Tempo_ID INT,
    Localidade_ID INT,
    Populacao_ID INT,
    Estado_ID INT,
    Casos_Confirmados INT,
    Mortes INT,
    Casos_Confirmados_Por_100k FLOAT,
    Novos_Casos_Confirmados INT,
    Novas_Mortes INT,
    CONSTRAINT PK_Fato_Covid PRIMARY KEY (Tempo_ID, Localidade_ID, Populacao_ID, Estado_ID),
    CONSTRAINT FK_Tempo FOREIGN KEY (Tempo_ID) REFERENCES Dimensao_Tempo(Data_ID),
    CONSTRAINT FK_Localidade FOREIGN KEY (Localidade_ID) REFERENCES Dimensao_Localidade(Localidade_ID),
    CONSTRAINT FK_Populacao FOREIGN KEY (Populacao_ID) REFERENCES Dimensao_Populacao(Populacao_ID),
    CONSTRAINT FK_Estado FOREIGN KEY (Estado_ID) REFERENCES Dimensao_Estado(Estado_ID)
);
GO

INSERT INTO Dimensao_Tempo (Data, Semana_Epidemiologica)
SELECT DISTINCT [date], [epidemiological_week]
FROM [OLTP].[dbo].[covid];
GO

INSERT INTO Dimensao_Localidade (Cidade, Codigo_IBGE_Cidade)
SELECT DISTINCT [city], ISNULL([city_ibge_code], 0) -- Usando 0 como valor padrão para códigos faltantes
FROM [OLTP].[dbo].[covid];
GO

INSERT INTO Dimensao_Populacao (Populacao_Estimada, Populacao_Estimada_2019)
SELECT DISTINCT ISNULL([estimated_population], 0), ISNULL([estimated_population_2019], 0)
FROM [OLTP].[dbo].[covid];
GO

INSERT INTO Dimensao_Estado (Estado)
SELECT DISTINCT [state]
FROM [OLTP].[dbo].[covid];
GO

INSERT INTO Fato_Covid (Tempo_ID, Localidade_ID, Populacao_ID, Estado_ID, Casos_Confirmados, Mortes, Casos_Confirmados_Por_100k, Novos_Casos_Confirmados, Novas_Mortes)
SELECT 
    t.Data_ID, 
    l.Localidade_ID,
    p.Populacao_ID,
    e.Estado_ID,
    ISNULL(c.[last_available_confirmed], 0),
    ISNULL(c.[last_available_deaths], 0),
    ISNULL(c.[last_available_confirmed_per_100k_inhabitants], 0.0),
    ISNULL(c.[new_confirmed], 0),
    ISNULL(c.[new_deaths], 0)
FROM [OLTP].[dbo].[covid] c
JOIN Dimensao_Tempo t ON t.Data = c.[date]
JOIN Dimensao_Localidade l ON l.Codigo_IBGE_Cidade = c.city_ibge_code
JOIN Dimensao_Populacao p ON p.Populacao_Estimada = c.estimated_population AND p.Populacao_Estimada_2019 = c.estimated_population_2019
JOIN Dimensao_Estado e ON e.Estado = c.state;
GO

