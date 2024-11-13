CREATE DATABASE oficina;
USE oficina;

CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(20),
    endereco VARCHAR(255)
);

CREATE TABLE Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    modelo VARCHAR(50),
    placa VARCHAR(10),
    ano INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Servico (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    nome_servico VARCHAR(100),
    descricao TEXT,
    preco DECIMAL(10, 2)
);

CREATE TABLE Orcamento (
    id_orcamento INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT,
    id_servico INT,
    data_orcamento DATE,
    valor DECIMAL(10, 2),
    status ENUM('Aprovado', 'Em Andamento', 'Finalizado'),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    FOREIGN KEY (id_servico) REFERENCES Servico(id_servico)
);

CREATE TABLE Pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_orcamento INT,
    metodo_pagamento ENUM('Dinheiro', 'Cartão', 'Transferência'),
    valor DECIMAL(10, 2),
    data_pagamento DATE,
    FOREIGN KEY (id_orcamento) REFERENCES Orcamento(id_orcamento)
);

CREATE TABLE Funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome_funcionario VARCHAR(100),
    cargo VARCHAR(50),
    salario DECIMAL(10, 2)
);

INSERT INTO Cliente (nome_cliente, email, telefone, endereco)
VALUES ('Janderson Diniz', 'jandiniz90@gmail.com', '987654321', 'Rua B, 45');

INSERT INTO Veiculo (id_cliente, modelo, placa, ano)
VALUES (1, 'Fusca', 'ABC1234', 1980);

SELECT c.nome_cliente, COUNT(o.id_orcamento) AS total_servicos
FROM Cliente c
LEFT JOIN Veiculo v ON c.id_cliente = v.id_cliente
LEFT JOIN Orcamento o ON v.id_veiculo = o.id_veiculo
GROUP BY c.id_cliente;

SELECT s.nome_servico, s.preco
FROM Servico s
ORDER BY s.preco DESC;

SELECT v.modelo, COUNT(o.id_orcamento) AS orcamentos_aprovados
FROM Veiculo v
JOIN Orcamento o ON v.id_veiculo = o.id_veiculo
WHERE o.status = 'Aprovado'
GROUP BY v.id_veiculo;

SELECT f.nome_funcionario, f.salario
FROM Funcionario f
ORDER BY f.salario DESC;

SELECT p.metodo_pagamento, SUM(p.valor) AS total_pago
FROM Pagamento p
GROUP BY p.metodo_pagamento
HAVING total_pago > 1000;

