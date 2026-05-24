CREATE TABLE IF NOT EXISTS geral.dim_tempo (

    sk_tempo SERIAL PRIMARY KEY,

    data_completa DATE UNIQUE,

    ano INT,

    mes INT,

    dia INT,

    trimestre INT,

    dia_semana VARCHAR(50)

);