# sql
select * from supplier;
select * from product;
select * from orders;
select * from order_item;
select * from customer;

--1) Вывести всех клиентов из страны Canada
select * from customer where country ilike ('Canada');

--2) Вывести все страны клиентов
select country from customer;

--3) Вывести количество всех заказов
select count(*) from product;

--4) Вывести максимальную стоимость заказа
select max(total_amount)
from orders;
select * from orders where total_amount = (Select  Max(total_amount) As maximum from product);

--5) Найти сумму всех заказов
select sum(total_amount) from orders;

--6) Найти сумму всех заказов за 2014 год
select sum(total_amount) from orders where (select extract(year from order_date) = '2014');
select sum(total_amount) from orders where order_date between '2014-01-01' and '2014-12-31';

--7) Найти среднюю стоимость всех заказов
select round(avg(total_amount)) as average_total_amount
from orders;

--8) Найти среднюю стоимость всех заказов по каждому клиенту
select round(avg(total_amount)) as average_total_amount, customer_id
from orders
         join customer c on c.id = orders.customer_id
group by customer_id;

--9) Найти всех клиентов, которые живут в Бразилии или Испании
select * from customer where country = 'Brazil' or country = 'Spain';
select * from customer where country in ('Brazil', 'Spain');

--10 Найти все заказы между 2013ым и 2014ым годами, которые стоили меньше 100.00$
select * from orders where (select extract(year from order_date) <= '2013') and (extract(year from order_date) >= '2014') and  total_amount < 100.00;
select * from orders where order_date between '2013-01-01' and '2014-12-31' and total_amount < 100.00;

--11) Найти всех клиентов, которые в одной из стран: Испания, Италия, Германия, Франция. Отсортируйте по странам
select * from customer where country in ('Spain', 'Italy', 'Germany', 'France');

--12) Найти все страны клиентов, страны которых содержаться в таблице поставщиков
select  s.country from customer join supplier s on customer.country = s.country group by s.country;

--13) Найти всех клиентов, имена которых начинаются на 'Jo'
select * from customer where first_name like 'Jo%';;

--14) Найти всех клиентов, имена которых заканчиваются на 'a' и имеют длину ровно 4 символа
select * from customer where first_name like '%a' and  length(first_name) = 4;

--15) Найти количество клиентов по странам
select count(*), country from customer group by country;

--16) Найти количество клиентов по странам. Вывести в порядке убывания
select count(*), customer.country from customer group by customer.country order by count(*) desc;

--17) Найти общую сумму стоимости заказов и количество заказов по каждому клиенту (customer_id). Отсортировать по сумме
select sum(total_amount), count(*), orders.customer_id
from orders
         join customer c on c.id = orders.customer_id
group by customer_id
order by sum(total_amount) desc;

--18) Найти общую сумму стоимости заказов и количество заказов по каждому клиенту (customer_id), у которых общее количество заказов больше 20ти
select sum(total_amount), count(*), customer_id, quantity
from orders
         join order_item oi on orders.id = oi.order_id
where quantity > 20
group by quantity, customer_id;
