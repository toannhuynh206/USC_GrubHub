DROP SCHEMA IF EXISTS test;

CREATE SCHEMA `test`;

CREATE TABLE `test`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));
  
CREATE TABLE `test`.`Restaurant` (
  `restaurant_id` VARCHAR(45) NOT NULL,
  `restaurant_name` VARCHAR(45) NULL DEFAULT NULL,
  `details_id` INT NOT NULL,
  `rating_id` INT NOT NULL,
  PRIMARY KEY (`restaurant_id`));
  
CREATE TABLE `test`.`Category` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NOT NULL,
  `restaurant_id` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`category_id`));
  
CREATE TABLE `test`.`Rating_details` (
  `rating_id` INT NOT NULL AUTO_INCREMENT,
  `review_count` INT NOT NULL,
  `rating` DECIMAL(5,1) NOT NULL,
  PRIMARY KEY (`rating_id`));
  
CREATE TABLE `test`.`Restaurant_details` (
  `details_id` INT NOT NULL AUTO_INCREMENT,
  `image_url` VARCHAR(400) NOT NULL,
  `address` VARCHAR(2000) NOT NULL,
  `phone_no` VARCHAR(45) NOT NULL,
  `estimated_price` VARCHAR(45) NULL DEFAULT NULL,
  `yelp_url` VARCHAR(2000) NOT NULL,
  PRIMARY KEY (`details_id`));
  










