-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ecommerce_wk
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ecommerce_wk
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ecommerce_wk` DEFAULT CHARACTER SET utf8 ;
USE `ecommerce_wk` ;

-- -----------------------------------------------------
-- Table `ecommerce_wk`.`table1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_wk`.`table1` (
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce_wk`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_wk`.`cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(20) NULL,
  `cpf` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce_wk`.`departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_wk`.`departamento` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  `descricao` TEXT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce_wk`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_wk`.`endereco` (
  `num_seq` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(10) NOT NULL,
  `logradouro` VARCHAR(100) NOT NULL,
  `numero` INT NULL,
  `complemento` VARCHAR(20) NULL,
  `bairro` VARCHAR(30) NULL,
  `cidade` VARCHAR(50) NULL,
  `cep` VARCHAR(2) NULL,
  `` VARCHAR(45) NULL,
  `cliente_id` INT NOT NULL,
  PRIMARY KEY (`num_seq`),
  INDEX `fk_endereco_cliente_idx` (`cliente_id` ASC) VISIBLE,
  UNIQUE INDEX `num_seq_UNIQUE` (`num_seq` ASC) VISIBLE,
  CONSTRAINT `fk_endereco_cliente`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `ecommerce_wk`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce_wk`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_wk`.`produto` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NULL,
  `descricao` TEXT NULL,
  `preco` DOUBLE NULL,
  `estoque` INT NULL,
  `link_foto` VARCHAR(255) NULL,
  `produtocol` VARCHAR(45) NULL,
  `departamento_codigo` INT NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE,
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE,
  INDEX `fk_produto_departamento1_idx` (`departamento_codigo` ASC) VISIBLE,
  CONSTRAINT `fk_produto_departamento1`
    FOREIGN KEY (`departamento_codigo`)
    REFERENCES `ecommerce_wk`.`departamento` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce_wk`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_wk`.`pedido` (
  `numero` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(2) NULL,
  `data_pedido` DATE NULL,
  `valor_bruto` DOUBLE NULL,
  `desconto` DOUBLE NULL DEFAULT Default / 0,
  `valor_liquido` DOUBLE NULL,
  `cliente_id` INT NOT NULL,
  PRIMARY KEY (`numero`),
  UNIQUE INDEX `numero_UNIQUE` (`numero` ASC) VISIBLE,
  INDEX `fk_pedido_cliente1_idx` (`cliente_id` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `ecommerce_wk`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ecommerce_wk`.`item_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_wk`.`item_pedido` (
  `num_sequencial` VARCHAR(45) NOT NULL,
  `quantidade` INT NULL,
  `valor_unitario` DOUBLE NULL,
  `preco_final` DOUBLE NULL,
  `produto_codigo` INT NOT NULL,
  `pedido_numero` INT NOT NULL,
  PRIMARY KEY (`num_sequencial`),
  INDEX `fk_produto_has_pedido_pedido1_idx` (`pedido_numero` ASC) VISIBLE,
  INDEX `fk_produto_has_pedido_produto1_idx` (`produto_codigo` ASC) VISIBLE,
  UNIQUE INDEX `num_sequencial_UNIQUE` (`num_sequencial` ASC) VISIBLE,
  CONSTRAINT `fk_produto_has_pedido_produto1`
    FOREIGN KEY (`produto_codigo`)
    REFERENCES `ecommerce_wk`.`produto` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_has_pedido_pedido1`
    FOREIGN KEY (`pedido_numero`)
    REFERENCES `ecommerce_wk`.`pedido` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
