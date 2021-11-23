SHOW DATABASES; -- mostra os bancos de dados criados
DROP DATABASE IF EXISTS estoque; -- apaga um banco de dados
CREATE DATABASE estoque; -- cria um banco de dados
USE estoque;

CREATE TABLE usuario ( -- cria a tabela
  id INTEGER PRIMARY KEY AUTO_INCREMENT, -- id: inteiro, chave primaria, AUTO_INCREMENT
  usuario VARCHAR(50) NOT NULL, -- nome: string variável, não nula
  email VARCHAR(50) NOT NULL, -- email: string fixa, unica, não nula
  senha VARCHAR(50) NOT NULL -- senha: string fixa, unica, não nula
);
CREATE TABLE produto(
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(50) NOT NULL, 
  descricao VARCHAR(50),
);

CREATE TABLE lote(

)
INSERT INTO usuario (usuario,email,senha) VALUE ("admin","foo@bar.com","1234" );
INSERT INTO usuario (usuario,email,senha) VALUE ("user1","user1@bar.com","1234" );
INSERT INTO usuario (usuario,email,senha) VALUE ("user2","user2@bar.com","1234" );
INSERT INTO usuario (usuario,email,senha) VALUE ("user3","user3@bar.com","1234" );


SELECT * FROM usuario;

-- DROP TABLE IF EXISTS `users`;
-- SHOW TABLES; -- mostra as tabelas

-- SHOW COLUMNS FROM users; --mostra as colunas