-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
SELECT a.company_name as customers, CONCAT(b.first_name, ' ', b.last_name) as employee
from customers a
join orders c on a.customer_id = c.customer_id
join employees b on b.employee_id = c.employee_id
join shippers d on d.shipper_id = c.ship_via
where a.city = 'London'
and b.city = 'London'
and d.company_name = 'United Package'

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
select a.product_name, a.units_in_stock, b.contact_name, b.phone
from products a
join suppliers b using(supplier_id)
join categories c using(category_id)
where a.discontinued != 1 and a.units_in_stock < 25
and c.category_name in ('Dairy Products', 'Condiments')
order by units_in_stock

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
select a.company_name from customers a
left join orders using(customer_id)
where order_id is null

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
select distinct a.product_name from products a
where product_id in (select product_id from order_details where quantity = 10)
