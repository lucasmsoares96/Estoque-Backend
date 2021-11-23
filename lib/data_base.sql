SHOW DATABASES;
DROP DATABASE IF EXISTS estoque;
CREATE DATABASE estoque;
USE estoque;

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  password VARCHAR(50) NOT NULL
);

INSERT INTO user (name,email,password) VALUE ("admin","foo@bar.com","12345678" );
INSERT INTO user (name,email,password) VALUE ("user1","user1@bar.com","12345678" );
INSERT INTO user (name,email,password) VALUE ("user2","user2@bar.com","12345678" );
INSERT INTO user (name,email,password) VALUE ("user3","user3@bar.com","12345678" );


SELECT * FROM user;

-- DROP TABLE IF EXISTS `users`;
-- SHOW TABLES; -- mostra as tabelas

-- SHOW COLUMNS FROM users; --mostra as colunas