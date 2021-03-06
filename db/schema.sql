-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'users'
-- 
-- ---
-- DROP DATABASE IF EXISTS `black_ocean`;
-- CREATE DATABASE IF NOT EXISTS black_ocean;

-- USE black_ocean;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `users`;
    
CREATE TABLE `users` (
  `id` INTEGER AUTO_INCREMENT,
  `chefID` INTEGER NULL DEFAULT NULL,
  `name` VARCHAR(64) NULL DEFAULT NULL,
  `bio` VARCHAR(256) NULL DEFAULT NULL,
  `avgRating` FLOAT NULL DEFAULT NULL,
  `md5` VARCHAR(64) NULL DEFAULT NULL,
  `email` VARCHAR(64) NULL DEFAULT NULL,
  `password` VARCHAR(256) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'chefs'
-- 
-- ---

DROP TABLE IF EXISTS `chefs`;
    
CREATE TABLE `chefs` (
  `id` INTEGER AUTO_INCREMENT,
  `name` VARCHAR(32) NULL DEFAULT NULL,
  `bio` VARCHAR(256) NULL DEFAULT NULL,
  `image` VARCHAR(256) NULL DEFAULT NULL,
  `avgRating` FLOAT NULL DEFAULT NULL,
  `id_userID` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'tokens'
-- 
-- ---

DROP TABLE IF EXISTS `tokens`;

CREATE TABLE `tokens` (
  `id` INTEGER AUTO_INCREMENT,
  `token` VARCHAR(1000) NULL DEFAULT NULL,
  `id_userID` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'events'
-- 
-- ---

DROP TABLE IF EXISTS `events`;
    
CREATE TABLE `events` (
  `id` INTEGER AUTO_INCREMENT,
  `name` VARCHAR(32) NULL DEFAULT NULL,
  `time` DATETIME NULL DEFAULT NULL,
  `location` VARCHAR(64) NULL DEFAULT NULL,
  `text` VARCHAR(256) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'dishes'
-- 
-- ---

DROP TABLE IF EXISTS `dishes`;
    
CREATE TABLE `dishes` (
  `id` INTEGER AUTO_INCREMENT,
  `name` VARCHAR(32) NULL DEFAULT NULL,
  `text` VARCHAR(256) NULL DEFAULT NULL,
  `image` VARCHAR(256) NULL DEFAULT NULL,
  `price` FLOAT NULL DEFAULT NULL,
  `id_chefID` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'reviews'
-- 
-- ---

DROP TABLE IF EXISTS `reviews`;
    
CREATE TABLE `reviews` (
  `id` INTEGER AUTO_INCREMENT,
  `id_chefID` INTEGER NULL DEFAULT NULL,
  `id_userID` INTEGER NULL DEFAULT NULL,
  `text` VARCHAR(256) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'locations'
-- 
-- ---

DROP TABLE IF EXISTS `locations`;
    
CREATE TABLE `locations` (
  `id` INTEGER AUTO_INCREMENT,
  `city` VARCHAR(64) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'cuisines'
-- 
-- ---

DROP TABLE IF EXISTS `cuisines`;
    
CREATE TABLE `cuisines` (
  `id` INTEGER AUTO_INCREMENT,
  `cuisine` VARCHAR(32) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'restrictions'
-- 
-- ---

DROP TABLE IF EXISTS `restrictions`;
    
CREATE TABLE `restrictions` (
  `id` INTEGER AUTO_INCREMENT,
  `restriction` VARCHAR(32) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'users_events'
-- 
-- ---

DROP TABLE IF EXISTS `users_events`;
    
CREATE TABLE `users_events` (
  `id` INTEGER AUTO_INCREMENT,
  `id_users` INTEGER NULL DEFAULT NULL,
  `id_events` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'chefs_events'
-- 
-- ---

DROP TABLE IF EXISTS `chefs_events`;
    
CREATE TABLE `chefs_events` (
  `id` INTEGER AUTO_INCREMENT,
  `id_chefID` INTEGER NULL DEFAULT NULL,
  `id_events` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'chefs_locations'
-- 
-- ---

DROP TABLE IF EXISTS `chefs_locations`;
    
CREATE TABLE `chefs_locations` (
  `id` INTEGER AUTO_INCREMENT,
  `id_chefID` INTEGER NULL DEFAULT NULL,
  `id_locationID` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'chefs_cuisines'
-- 
-- ---

DROP TABLE IF EXISTS `chefs_cuisines`;
    
CREATE TABLE `chefs_cuisines` (
  `id` INTEGER AUTO_INCREMENT,
  `id_chefID` INTEGER NULL DEFAULT NULL,
  `id_cuisineID` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'chefs_restrictions'
-- 
-- ---

DROP TABLE IF EXISTS `chefs_restrictions`;
    
CREATE TABLE `chefs_restrictions` (
  `id` INTEGER AUTO_INCREMENT,
  `id_chefID` INTEGER NULL DEFAULT NULL,
  `id_restrictionID` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'events_dishes'
-- 
-- ---

DROP TABLE IF EXISTS `events_dishes`;
    
CREATE TABLE `events_dishes` (
  `id` INTEGER AUTO_INCREMENT,
  `id_eventID` INTEGER NULL DEFAULT NULL,
  `id_dishID` INTEGER NULL DEFAULT NULL,
  `quantities` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'dishes_cuisines'
-- 
-- ---

DROP TABLE IF EXISTS `dishes_cuisines`;
    
CREATE TABLE `dishes_cuisines` (
  `id` INTEGER AUTO_INCREMENT,
  `id_dishID` INTEGER NULL DEFAULT NULL,
  `id_cuisineID` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Table 'dishes_restrictions'
-- 
-- ---

DROP TABLE IF EXISTS `dishes_restrictions`;
    
CREATE TABLE `dishes_restrictions` (
  `id` INTEGER AUTO_INCREMENT,
  `id_dishID` INTEGER NULL DEFAULT NULL,
  `id_restrictionID` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `users` ADD FOREIGN KEY (chefID) REFERENCES `chefs` (`id`) ON DELETE CASCADE;
ALTER TABLE `chefs` ADD FOREIGN KEY (id_userID) REFERENCES `users` (`id`) ON DELETE CASCADE;
ALTER TABLE `reviews` ADD FOREIGN KEY (id_chefID) REFERENCES `chefs` (`id`);
ALTER TABLE `reviews` ADD FOREIGN KEY (id_userID) REFERENCES `users` (`id`);
ALTER TABLE `dishes` ADD FOREIGN KEY (id_chefID) REFERENCES `chefs` (`id`);
ALTER TABLE `tokens` ADD FOREIGN KEY (id_userID) REFERENCES `users` (`id`);

ALTER TABLE `users_events` ADD FOREIGN KEY (id_users) REFERENCES `users` (`id`);
ALTER TABLE `users_events` ADD FOREIGN KEY (id_events) REFERENCES `events` (`id`);
ALTER TABLE `events_dishes` ADD FOREIGN KEY (id_dishID) REFERENCES `dishes` (`id`);
ALTER TABLE `events_dishes` ADD FOREIGN KEY (id_eventID) REFERENCES `events` (`id`);
ALTER TABLE `chefs_locations` ADD FOREIGN KEY (id_chefID) REFERENCES `chefs` (`id`);
ALTER TABLE `chefs_locations` ADD FOREIGN KEY (id_locationID) REFERENCES `locations` (`id`);
ALTER TABLE `chefs_cuisines` ADD FOREIGN KEY (id_chefID) REFERENCES `chefs` (`id`);
ALTER TABLE `chefs_cuisines` ADD FOREIGN KEY (id_cuisineID) REFERENCES `cuisines` (`id`);
ALTER TABLE `chefs_restrictions` ADD FOREIGN KEY (id_chefID) REFERENCES `chefs` (`id`);
ALTER TABLE `chefs_restrictions` ADD FOREIGN KEY (id_restrictionID) REFERENCES `restrictions` (`id`);
ALTER TABLE `chefs_events` ADD FOREIGN KEY (id_chefID) REFERENCES `chefs` (`id`);
ALTER TABLE `chefs_events` ADD FOREIGN KEY (id_events) REFERENCES `events` (`id`);
ALTER TABLE `dishes_cuisines` ADD FOREIGN KEY (id_dishID) REFERENCES `dishes` (`id`);
ALTER TABLE `dishes_cuisines` ADD FOREIGN KEY (id_cuisineID) REFERENCES `cuisines` (`id`);
ALTER TABLE `dishes_restrictions` ADD FOREIGN KEY (id_dishID) REFERENCES `dishes` (`id`);
ALTER TABLE `dishes_restrictions` ADD FOREIGN KEY (id_restrictionID) REFERENCES `restrictions` (`id`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `users` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `reviews` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `events` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `dishes` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `users_events` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `chefs_locations` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `locations` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `chefs_events` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `chefs` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- INITIAL Data
-- ---

-- INSERT INTO `users` (`id`,`chefID`,`name`,`bio`,`avgRating`,`image`,`createdAt`) VALUES
-- ('','','','','','','');
-- INSERT INTO `reviews` (`id`,`id_chefID`,`id_userID`,`text`,`createdAt`) VALUES
-- ('','','','','');
-- INSERT INTO `events` (`id`,`name`,`time`,`location`,`text`,`createdAt`) VALUES
-- ('','','','','','');
-- INSERT INTO `dishes` (`id`,`id_chefID`,`image`,`price`,`restrictions`,`cuisine`,`createdAt`) VALUES
-- ('','','','','','','');
-- INSERT INTO `users_events` (`id`,`id_users`,`id_events`,`createdAt`) VALUES
-- ('','','','');
-- INSERT INTO `chefs_locations` (`id`,`id_users`,`id_locations`,`createdAt`) VALUES
-- ('','','','');
INSERT INTO `locations` (`city`) VALUES
('San Francisco, CA, USA'), ('Los Angeles, CA, USA'), ('New York City, NY, USA'), ('Chicago, IL, USA');
INSERT INTO `cuisines` (`cuisine`) VALUES
('French'), ('Italian'), ('American'), ('Mexican'), ('Chinese'), ('Japanese'), ('Korean');
INSERT INTO `restrictions` (`restriction`) VALUES
('Eggs'), ('Dairy'), ('Peanuts'), ('Tree Nuts'), ('Seafood'), ('Shellfish'), ('Wheat'), ('Soy'), ('Gluten'), ('Vegetarian'), ('Vegan'), ('Halal'), ('Kosher');
-- INSERT INTO `chefs_events` (`id`,`id_chefID`,`id_events`,`createdAt`) VALUES
-- ('','','','');
-- INSERT INTO `chefs` (`id`,`avgRating`,`bio`,`image`,`id_users`,`createdAt`) VALUES
-- ('','','','','','');

SET FOREIGN_KEY_CHECKS = 1;

