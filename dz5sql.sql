CREATE DATABASE IF NOT EXISTS hw5; 
USE hw5;

SELECT * FROM cars;

-- Создайте представление, в которое попадут автомобили стоимостью  до 25 000 долларов

CREATE OR REPLACE VIEW view_cars 
AS SELECT *
FROM cars
WHERE cost < 25000
ORDER BY cost;
SELECT * FROM view_cars;

-- Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов 
-- (используя оператор ALTER VIEW) 

ALTER VIEW view_cars 
AS SELECT *
FROM cars
WHERE cost < 30000
ORDER BY cost;
SELECT * FROM view_cars;

-- Создайте представление, в котором будут только автомобили марки “BMW” и “Ауди”
CREATE OR REPLACE VIEW cars_audi_bmw 
AS SELECT *
FROM cars 
WHERE name IN ('BMW', 'Audi')
ORDER BY name;
SELECT * FROM cars_audi_bmw;

-- Добавьте новый столбец под названием «время до следующей станции». 

DROP TABLE IF EXISTS train_schedule;
CREATE TABLE train_schedule
(
     train_id_integer INT,
     station_character_varying VARCHAR(45),
     station_time TIME
);
INSERT INTO train_schedule (train_id_integer, station_character_varying, station_time)
VALUES
 (110, 'San Francisco', '10:00:00'),
 (110, 'Redwood City', '10:54:00'),
 (110, 'Palo Alto', '11:02:00'),
 (110, 'San Jose', '12:35:00'),
 (120, 'San Francisco', '11:00:00'),
 (120, 'Palo Alto', '12:49:00'),
 (120, 'San Jose', '13:30:00');
 
SELECT train_id_integer, station_character_varying, station_time,
       TIMEDIFF(LEAD(station_time) OVER (PARTITION BY train_id_integer), station_time) AS time_to_next_station
FROM train_schedule;


USE lesson_4;
-- Создайте представление, в которое попадет информация о пользователях (имя, фамилия, город и пол), которые не старше 20 лет.
CREATE OR REPLACE VIEW view_user AS 
SELECT CONCAT(firstname, ' ', lastname, '; ', hometown, '; ', gender) AS 'Пользователи (младше 20 лет)'
FROM users u
JOIN profiles p ON u.id = p.user_id
WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 20
GROUP BY u.id
;

-- Найдите кол-во, отправленных сообщений каждым пользователем и выведите ранжированный список пользователь...
SELECT 
	DENSE_RANK() OVER (ORDER BY COUNT(from_user_id) DESC) AS 'Место в рейтинге',
	COUNT(from_user_id) AS 'Количество отправленных сообщений',
	CONCAT(firstname, ' ', lastname) AS 'Пользователи'
FROM users u
JOIN messages m ON u.id = m.from_user_id
GROUP BY u.id
;

-- Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления (created_at) ...

SELECT *, 
LAG(created_at, 1, 0) OVER (PARTITION BY TIMESTAMPDIFF(SECOND, created_at, created_at)) AS lag_created_at, -- смещение на 1 и вместо NULL будет 0
LEAD(created_at) OVER (PARTITION BY TIMESTAMPDIFF(SECOND, created_at, created_at)) AS lead_created_at
FROM messages ORDER BY TIMESTAMPDIFF(SECOND, created_at, NOW()) DESC;