-- =====================================
-- SCENA - GERENCIADOR DE SHOWS
-- =====================================
-- Script oficial de criação para um banco vazio.
-- Crie antes o usuário scena e o banco conforme o passo 2 de ../readme.md.
-- Importe como postgres, conectado ao banco scena.
-- Este script contém somente a estrutura, sem dados de exemplo.

BEGIN;

-- 1. TABELA DE USUÁRIOS

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    is_admin BOOLEAN NOT NULL DEFAULT FALSE
);

-- 2. TABELA DE SHOWS

CREATE TABLE shows (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    data_show DATE NOT NULL,
    endereco VARCHAR(255) NOT NULL
);

-- 3. TABELA DE BANDAS DOS SHOWS

CREATE TABLE shows_bandas (
    show_id INT NOT NULL,
    nome_banda VARCHAR(255) NOT NULL,

    PRIMARY KEY (show_id, nome_banda),

    FOREIGN KEY (show_id)
        REFERENCES shows(id)
        ON DELETE CASCADE
);

-- 4. PERMISSÕES DO USUÁRIO DA APLICAÇÃO

GRANT USAGE ON SCHEMA public TO scena;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO scena;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO scena;

COMMIT;
