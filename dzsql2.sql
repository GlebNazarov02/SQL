-- Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными
use hw1;
CREATE TABLE sales (
  id INT PRIMARY KEY,
  order_date DATE,
  count_product INT
);

INSERT INTO sales (id, order_date, count_product)
VALUES (1, '2022-01-01', 156),
       (2, '2022-01-02', 180),
       (3, '2022-01-03', 21),
       (4, '2022-01-04', 124),
       (5, '2022-01-05', 341);

-- Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300.
SELECT 
  CASE 
    WHEN count_product < 100 THEN 'Маленький заказ' 
    WHEN count_product BETWEEN 100 AND 300 THEN 'Средний заказ' 
    ELSE 'Большой заказ' 
  END AS count_segment, 
  COUNT(*) AS count_segment_count
FROM sales
GROUP BY count_segment;

SELECT id,
  CASE 
    WHEN count_product < 100 THEN 'Маленький заказ' 
    WHEN count_product BETWEEN 100 AND 300 THEN 'Средний заказ' 
    ELSE 'Большой заказ' 
  END AS count_segment
FROM sales
GROUP BY id;

-- Создайте таблицу “orders”, заполните ее значениями. Покажите “полный” статус заказа, используя оператор CASE
CREATE TABLE orders (
  id INT PRIMARY KEY,
  employee_id VARCHAR(10),
  amount DECIMAL(10, 2),
  order_status VARCHAR(10)
);

INSERT INTO orders (id, employee_id, amount, order_status)
VALUES (1, 'e03', 15.00, 'OPEN'),
       (2, 'e01', 25.50, 'OPEN'),
       (3, 'e05', 100.70, 'CLOSED'),
       (4, 'e02', 22.18, 'OPEN'),
       (5, 'e04', 9.50, 'CANCELLED');

SELECT id,employee_id, amount,order_status, 
  CASE 
    WHEN order_status = 'OPEN' THEN 'Order is in open state'
    WHEN order_status = 'CLOSED' THEN 'Order is closed'
    WHEN order_status = 'CANCELLED' THEN 'Order is cancelled'
    ELSE 'Unknown order status'
  END AS full_order_status
FROM orders;
