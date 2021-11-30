SHOW DATABASES;
DROP DATABASE IF EXISTS estoque;
CREATE DATABASE estoque;
USE estoque;

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  cpf CHAR(11) NOT NULL UNIQUE,
  name VARCHAR(50) NOT NULL,
  birthDay DATE NOT NULL,
  userType VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(60) NOT NULL,
  isADMIN BOOL NOT NULL
);

INSERT INTO user (NAME,cpf,email,PASSWORD,birthDay,userType,isADMIN) 
VALUE ("admin","11111111111","foo@bar.com","$2b$10$8AXCe3s26kXj6DsU47q4Yu4Z4yzU22WlyOc4/YCI0peM0rv1dpUlu","1999-07-23","Testador",1);

-- DROP TABLE IF EXISTS `users`;
-- SHOW TABLES; -- mostra as tabelas

-- SHOW COLUMNS FROM users; --mostra as colunas