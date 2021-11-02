SHOW DATABASES; -- mostra os bancos de dados criados
DROP DATABASE IF EXISTS estoque; -- apaga um banco de dados
CREATE DATABASE estoque; -- cria um banco de dados
USE estoque;

CREATE TABLE users ( -- cria a tabela
  id INTEGER PRIMARY KEY AUTO_INCREMENT, -- id: inteiro, chave primaria, AUTO_INCREMENT
  name VARCHAR(50) NOT NULL, -- nome: string variável, não nula
  email CHAR(50) NOT NULL, -- cpf: string fixa, unica, não nula
  age INT NOT NULL -- cpf: string fixa, unica, não nula
);

SELECT * FROM users;

-- DROP TABLE IF EXISTS `users`;
-- SHOW TABLES; -- mostra as tabelas

-- SHOW COLUMNS FROM users; --mostra as colunas