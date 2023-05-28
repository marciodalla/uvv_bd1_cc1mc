-- Deletar banco de dados existente
drop database uvv;
--1. Verificar se o usuário marcio já está no computador, se estiver, será apagado
drop USER marcio;
--2. Criação do usuário no PostgreSQL
CREATE USER marcio
     WITH CREATEDB
      PASSWORD '123456';
--3. Criação do banco de dados "uvv"
CREATE DATABASE uvv
  OWNER marcio
  TEMPLATE template0
  ENCODING 'UTF8'
  LC_COLLATE 'pt_BR.UTF-8'
  LC_CTYPE 'pt_BR.UTF-8'
  CONNECTION LIMIT -1;
--4. Conexão ao banco de dados e criação do esquema "lojas"
\c uvv;
CREATE SCHEMA lojas AUTHORIZATION marcio;
--5.
ALTER USER marcio SET SEARCH_PATH TO lojas, "$user", public;
--6.
-- Criação da tabela "produtos"
CREATE TABLE lojas.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,

                CONSTRAINT produtos_pk PRIMARY KEY (produto_id)--Constraint da pk
);

-- Comentarios da tabela "produtos"
COMMENT ON COLUMN lojas.produtos.produto_id IS 'produto id em pk, number e nao nulo';
COMMENT ON COLUMN lojas.produtos.nome IS 'nome em varchar e nao nulo';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'preco unitario em number e nulo';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'detalhes em blob e nulo';
COMMENT ON COLUMN lojas.produtos.imagem IS 'imagem em blob e nulo';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'imagem mime type em varchar e nulo';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'imagem arquivo em varchar e nulo';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'imagem charset em varchar e nulo';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'imagem em ultima atualizacao em date e nulo';

-- Criação da tabela "lojas"
CREATE TABLE lojas.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,

                CONSTRAINT lojas_pk PRIMARY KEY (loja_id)--Constraint da pk
);

-- Comentarios da tabela "lojas"
COMMENT ON COLUMN lojas.lojas.loja_id IS 'loja id em pk, number e nao nulo';
COMMENT ON COLUMN lojas.lojas.nome IS 'nome em varchar e nao nulo';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'endereco web em varchar e nulo';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'endereco fisico em varchar em nulo';
COMMENT ON COLUMN lojas.lojas.latitude IS 'latitude em number e nulo';
COMMENT ON COLUMN lojas.lojas.longitude IS 'longitude em number e nulo';
COMMENT ON COLUMN lojas.lojas.logo IS 'logo em blob e nulo';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'logo mime type em varchar e nulo';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'logo arquivo em varchar e nulo';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'logo charset em varchar e nulo';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'logo ultima atualizacao em date e nulo';

-- Criação da tabela "estoques"
CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,

                CONSTRAINT estoques_pk PRIMARY KEY (estoque_id)--Constraint da pk
);

-- Comentarios da tabela "estoques"
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'estoque id em pk, number e nao nulo';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'loja id em number e nao nulo';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'produto id em number e nao nulo';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'quantidade em number e nao nulo';

-- Criação da tabela "clientes"
CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                
                CONSTRAINT clientes_pk PRIMARY KEY (cliente_id)--Constraint da pk
);

-- Comentarios da tabela "clientes"
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'cliente id em pk e nao nulo';
COMMENT ON COLUMN lojas.clientes.email IS 'email em varchar e nao nulo';
COMMENT ON COLUMN lojas.clientes.nome IS 'nome em varchar e nao nulo';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'telefone1 em varchar nulo';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'telefone2 em varchar nulo';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'telefone3 em varchar nulo';

-- Criação da tabela "envios"
CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                --Constraint da pk
                CONSTRAINT envios_pk PRIMARY KEY (envio_id)
);

-- Comentarios da tabela "envios"
COMMENT ON COLUMN lojas.envios.envio_id IS 'envio id em number e nao nulo';
COMMENT ON COLUMN lojas.envios.loja_id IS 'loja id em number, nao nulo e em fk';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'cliente id em number nao nulo e em fk';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'endereco entrega em varchar e nao nulo ';
COMMENT ON COLUMN lojas.envios.status IS 'status em varchar e nao nulo';

-- Criação da tabela "pedidos"
CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                --Constraint da pk
                CONSTRAINT pedidos_pk PRIMARY KEY (pedido_id)
);

-- Comentarios da tabela "pedidos"
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'pedido id em pk, number e nao nulo';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'data e hora em timestamp e nao nulo';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'cliente id em number, em fk e nao nulo';
COMMENT ON COLUMN lojas.pedidos.status IS 'status em varchar, nao nulo e em fk';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'loja id em number, nao nulo e em fk';

-- Criação da tabela "pedidos_itens"
CREATE TABLE lojas.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                --Constraint da pk
                CONSTRAINT pedidos_itens_pk PRIMARY KEY (pedido_id, produto_id)
);

-- Comentarios da tabela "pedidos_itens"
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'pedido_id em number, nao nulo e em pfk';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'produto id em number, nao nulo e em pfk';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'numero da linha em number, nao nulo ';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'preco unitario em number e nao nulo';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'quantidade em number e nao nulo';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'envio id em number, nulo e em fk';


-- Criação das Fk's

ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques 
ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios 
ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques 
ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos 
ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos 
ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios 
ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens 
ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens 
ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Criação das checagem

-- Tabela envios
ALTER TABLE lojas.envios
ADD CONSTRAINT cc_envios_status
CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

-- Tabela pedidos
ALTER TABLE   lojas.pedidos 
ADD CONSTRAINT cc_pedidos_status
CHECK(status IN('CANCELADO','COMPLETO','ABERTO','PAGO','REEMBOLSADO','ENVIADO'));

-- Tabela pedidos_itens
ALTER TABLE lojas.pedidos_itens 
ADD CONSTRAINT cc_pedidos_itens_quantidade
CHECK (quantidade >=0);

ALTER TABLE lojas.pedidos_itens 
ADD CONSTRAINT cc_pedidos_itens_preco_unitario
CHECK (preco_unitario >=0);

-- Tabela lojas
ALTER TABLE lojas.lojas
ADD CONSTRAINT ck_endereco_preenchido
CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL);

-- Tabela produtos
ALTER TABLE lojas.produtos
ADD CONSTRAINT ck_preco_unitario_nao_negativo
CHECK (preco_unitario >= 0);
