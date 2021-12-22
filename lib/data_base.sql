SHOW DATABASES;
DROP DATABASE IF EXISTS estoque;
CREATE DATABASE estoque;
USE estoque;

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  cpf CHAR(11) NOT NULL UNIQUE,
  name VARCHAR(50) NOT NULL,
  entryDate DATE NOT NULL,
  userType VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(60) NOT NULL,
  isAdmin BOOL NOT NULL
);

CREATE TABLE product (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  productType VARCHAR(50) NOT NULL
);

CREATE TABLE estoque(
	id INTEGER NOT NULL,
	quantity INTEGER NOT NULL,
	CONSTRAINT PRIMARY KEY(id),
	CONSTRAINT fk_product FOREIGN KEY (id) REFERENCES product(id)
);


INSERT INTO user (NAME,cpf,email,PASSWORD,entryDate,userType,isAdmin) 
VALUE ("admin","11111111111","foo@bar.com","$2b$10$8AXCe3s26kXj6DsU47q4Yu4Z4yzU22WlyOc4/YCI0peM0rv1dpUlu","1999-07-23","Testador",1);

SELECT * FROM user;

-- DROP TABLE IF EXISTS `user`;
-- SHOW TABLES; -- mostra as tabelas
-- SHOW COLUMNS FROM users; --mostra as colunas