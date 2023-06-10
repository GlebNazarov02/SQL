create database hw1;

use hw1;
CREATE TABLE `hw1`.`mobile_phones` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `model` VARCHAR(45) NOT NULL,
  `manufacturer` VARCHAR(45) NOT NULL,
  `price` DECIMAL NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`id`));
  
-- Заполните БД данными
INSERT INTO `hw1`.`mobile_phones` 
  (`model`, `manufacturer`, `price`, `quantity`) 
VALUES 
('Galaxy S22 Ultra', 'Samsung', 91575, 2),
('Galaxy A03 4/64 Gb', 'Samsung', 7451, 100),
('Galaxy A23 4/64 Gb', 'Samsung', 12395, 50),
('iPhone 11 128 Gb', 'Apple', 37453, 2),
('iPhone 12 64 Gb', 'Apple', 46296, 15),
('iPhone 13 128 Gb', 'Apple', 52544, 72),
('Redmi A1+ 2/32 Gb', 'Xiaomi', 5911, 88);


-- 2. Выведите название, производителя и цену для товаров, количество которых превышает 2
SELECT model, manufacturer, price
FROM mobile_phones
WHERE quantity > 2;

-- 3. Выведите весь ассортимент товаров марки “Samsung”
SELECT * FROM mobile_phones
WHERE manufacturer = 'Samsung';

