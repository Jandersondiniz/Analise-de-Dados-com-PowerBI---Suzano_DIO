CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR(100),
    tipo_cliente ENUM('PF', 'PJ'),  -- PJ ou PF
    cpf_cnpj VARCHAR(20),  -- CPF ou CNPJ, dependendo do tipo_cliente
    email VARCHAR(100),
    telefone VARCHAR(20),
    endereco VARCHAR(255)
);

CREATE TABLE Fornecedor (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    nome_fornecedor VARCHAR(100),
    telefone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE Produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100),
    descricao TEXT,
    preco DECIMAL(10, 2),
    id_fornecedor INT,
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id_fornecedor)
);

CREATE TABLE Pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATETIME,
    status ENUM('Pendente', 'Em Processamento', 'Concluído'),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    metodo_pagamento ENUM('Cartão', 'Boleto', 'Transferência'),
    valor DECIMAL(10, 2),
    data_pagamento DATETIME,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Entrega (
    id_entrega INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    status ENUM('Pendente', 'Enviado', 'Entregue'),
    codigo_rastreio VARCHAR(50),
    data_entrega DATETIME,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)
);


INSERT INTO Cliente (nome_cliente, tipo_cliente, cpf_cnpj, email, telefone, endereco)
VALUES ('Janderson Diniz', 'PF', '123.456.789-00', 'jandiniz90@email.com', '123456789', 'Rua A, 123'),
		('João Silva' , 'PJ', '30.229.453.0001-85', 'joão@email.com', '123456878', 'Rua B, 321');
        
INSERT INTO Produto (nome_produto, descricao, preco, id_fornecedor)
VALUES ('Camiseta', 'Camiseta 100% algodão', 39.90, 1);

