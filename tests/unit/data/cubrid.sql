/**
 * This is the database schema for testing CUBRID support of Yii DAO and Active Record.
 * The database setup in config.php is required to perform then relevant tests:
 */

DROP TABLE IF EXISTS composite_fk;
DROP TABLE IF EXISTS order_item;
DROP TABLE IF EXISTS item;
DROP TABLE IF EXISTS order;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS profile;
DROP TABLE IF EXISTS null_values;
DROP TABLE IF EXISTS type;
DROP TABLE IF EXISTS constraints;

CREATE TABLE `constraints`
(
  `id` integer not null,
  `field1` varchar(255)
);


CREATE TABLE `profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(128) NOT NULL,
  `name` varchar(128),
  `address` string,
  `status` int (11) DEFAULT 0,
  `profile_id` int(11),
  PRIMARY KEY (`id`)
);

CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_item_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE
);

CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `created_at` int(11) NOT NULL,
  `total` decimal(10,0) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_order_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE CASCADE
);

CREATE TABLE `order_item` (
  `order_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `subtotal` decimal(10,0) NOT NULL,
  PRIMARY KEY (`order_id`,`item_id`),
  CONSTRAINT `FK_order_item_order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_order_item_item_id` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE
);

CREATE TABLE null_values (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `var1` INT NULL,
  `var2` INT NULL,
  `var3` INT DEFAULT NULL,
  `stringcol` VARCHAR (32) DEFAULT NULL,
  PRIMARY KEY (id)
);


CREATE TABLE `type` (
  `int_col` int(11) NOT NULL,
  `int_col2` int(11) DEFAULT '1',
  `char_col` char(100) NOT NULL,
  `char_col2` varchar(100) DEFAULT 'something',
  `char_col3` string,
  `enum_col` enum('a', 'b'),
  `float_col` double NOT NULL,
  `float_col2` double DEFAULT '1.23',
  `blob_col` blob,
  `numeric_col` decimal(5,2) DEFAULT '33.22',
  `time` timestamp NOT NULL DEFAULT '2002-01-01 00:00:00',
  `bool_col` tinyint NOT NULL,
  `bool_col2` tinyint DEFAULT '1'
);

CREATE TABLE `composite_fk` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_composite_fk_order_item` FOREIGN KEY (`order_id`,`item_id`) REFERENCES `order_item` (`order_id`,`item_id`) ON DELETE CASCADE
);

INSERT INTO profile (description) VALUES ('profile customer 1');
INSERT INTO profile (description) VALUES ('profile customer 3');

INSERT INTO customer (email, name, address, status, profile_id) VALUES ('user1@example.com', 'user1', 'address1', 1, 1);
INSERT INTO customer (email, name, address, status) VALUES ('user2@example.com', 'user2', 'address2', 1);
INSERT INTO customer (email, name, address, status, profile_id) VALUES ('user3@example.com', 'user3', 'address3', 2, 2);

INSERT INTO category (name) VALUES ('Books');
INSERT INTO category (name) VALUES ('Movies');

INSERT INTO item (name, category_id) VALUES ('Agile Web Application Development with Yii1.1 and PHP5', 1);
INSERT INTO item (name, category_id) VALUES ('Yii 1.1 Application Development Cookbook', 1);
INSERT INTO item (name, category_id) VALUES ('Ice Age', 2);
INSERT INTO item (name, category_id) VALUES ('Toy Story', 2);
INSERT INTO item (name, category_id) VALUES ('Cars', 2);

INSERT INTO order (customer_id, created_at, total) VALUES (1, 1325282384, 110.0);
INSERT INTO order (customer_id, created_at, total) VALUES (2, 1325334482, 33.0);
INSERT INTO order (customer_id, created_at, total) VALUES (2, 1325502201, 40.0);

INSERT INTO order_item (order_id, item_id, quantity, subtotal) VALUES (1, 1, 1, 30.0);
INSERT INTO order_item (order_id, item_id, quantity, subtotal) VALUES (1, 2, 2, 40.0);
INSERT INTO order_item (order_id, item_id, quantity, subtotal) VALUES (2, 4, 1, 10.0);
INSERT INTO order_item (order_id, item_id, quantity, subtotal) VALUES (2, 5, 1, 15.0);
INSERT INTO order_item (order_id, item_id, quantity, subtotal) VALUES (2, 3, 1, 8.0);
INSERT INTO order_item (order_id, item_id, quantity, subtotal) VALUES (3, 2, 1, 40.0);
