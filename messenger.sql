-- MySQL Script generated by MySQL Workbench
-- Wed Nov 25 08:59:59 2015
-- Model: New Model    Version: 1.0.1
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema messenger
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `messenger` ;

-- -----------------------------------------------------
-- Schema messenger
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `messenger` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
SHOW WARNINGS;
USE `messenger` ;

-- -----------------------------------------------------
-- Table `users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `users` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `phone` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(40) NULL,
  `first_name` VARCHAR(20) NULL,
  `last_name` VARCHAR(20) NULL,
  `middle_name` VARCHAR(20) NULL,
  `verification_code` CHAR(6) NULL,
  `is_active` TINYINT(1) NULL DEFAULT 0,
  `is_reported` TINYINT(1) NULL DEFAULT 0,
  `is_blocked` TINYINT(1) NULL DEFAULT 0,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `phone_UNIQUE` ON `users` (`phone` ASC);

SHOW WARNINGS;
CREATE UNIQUE INDEX `email_UNIQUE` ON `users` (`email` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `contacts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `contacts` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `contacts` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'Sync the contacts to this table',
  `users_id` INT NOT NULL,
  `first_name` VARCHAR(20) NULL,
  `middle_name` VARCHAR(20) NULL,
  `last_name` VARCHAR(20) NULL,
  `phone` VARCHAR(14) NULL,
  `email` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `conversation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `conversation` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `conversation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(40) NULL,
  `creator_id` INT NOT NULL,
  `channel_id` VARCHAR(45) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `participants`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `participants` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `participants` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `conversation_id` INT NOT NULL,
  `users_id` INT NOT NULL,
  `type` ENUM('single', 'group') NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `messages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `messages` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `messages` (
  `id` INT NOT NULL,
  `conversation_id` INT NOT NULL,
  `sender_id` INT NOT NULL,
  `participants_id` INT NOT NULL,
  `message_type` ENUM('text', 'image', 'vedio', 'audio') NULL,
  `message` VARCHAR(255) NULL,
  `attachment_thumb_url` VARCHAR(255) NULL,
  `attachment_url` VARCHAR(255) NULL,
  `created_at` DATETIME NULL,
  `guid` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `reports`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `reports` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `reports` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `users_id` INT NOT NULL,
  `participants_id` INT NOT NULL,
  `report_type` VARCHAR(45) NULL,
  `notes` TEXT NULL,
  `created_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `block_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `block_list` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `block_list` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `users_id` INT NOT NULL,
  `participants_id` INT NOT NULL,
  `created_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `deleted_conversations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `deleted_conversations` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `deleted_conversations` (
  `id` INT NOT NULL,
  `conversation_id` INT NOT NULL,
  `users_id` INT NOT NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `devices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `devices` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `devices` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `users_id` INT NOT NULL,
  `device_id` VARCHAR(120) NULL,
  `type` ENUM('APPLE') NULL,
  `device_token` VARCHAR(120) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `access`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `access` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `access` (
  `id` INT NOT NULL,
  `users_id` INT NOT NULL,
  `token` VARCHAR(60) NULL,
  `created_at` DATETIME NULL,
  `deleted_at` DATETIME NULL,
  `devices_id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `deleted_messages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `deleted_messages` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `deleted_messages` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `messages_id` INT NOT NULL,
  `users_id` INT NOT NULL,
  `deleted_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
