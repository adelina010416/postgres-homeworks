-- Напишите запросы, которые выводят следующую информацию:
-- 1. "имя контакта" и "город" (contact_name, country) из таблицы customers (только эти две колонки)
select contact_name, country from customers

-- 2. идентификатор заказа и разницу между датами формирования (order_date) заказа и его отгрузкой (shipped_date) из таблицы orders
select order_id,
shipped_date::timestamp without time zone - order_date::timestamp without time zone
from orders

-- 3. все города без повторов, в которых зарегистрированы заказчики (customers)
select distinct city from customers

-- 4. количество заказов (таблица orders)
select count(*) from orders

-- 5. количество стран, в которые отгружался товар (таблица orders, колонка ship_country)
select count(distinct ship_country) from orders
