-- task 1
-- Используйте бд airport :
-- 1) Выведите данные о билетах разной ценовой категории. Среди билетов экономкласса (Economy) добавьте в выборку билеты с ценой от 10 000 до 11 000 включительно. Среди билетов комфорт-класса (PremiumEconomy) — билеты с ценой от 20 000 до 30 000 включительно. Среди билетов бизнес-класса (Business) — с ценой строго больше 100 000. В решении необходимо использовать оператор CASE.
-- В выборке должны присутствовать три атрибута — id, service_class, price.
use airport;
SELECT 
id, 
service_class,
  CASE 
    WHEN service_class = 'Economy' AND price BETWEEN 10000 AND 11000 THEN price
    WHEN service_class = 'PremiumEconomy' AND price BETWEEN 20000 AND 30000 THEN price
    WHEN service_class = 'Business' AND price > 100000 THEN price
  END AS price
FROM tickets
WHERE service_class IN ('Economy', 'PremiumEconomy', 'Business');

-- Task 2
 -- Разделите самолеты на три класса по возрасту. Если самолет произведен раньше 2000 года, то отнесите его к классу 'Old'. Если самолет произведен между 2000 и 2010 годами включительно, то отнесите его к классу 'Mid'. Более новые самолеты отнесите к классу 'New'. Исключите из выборки дальнемагистральные самолеты с максимальной дальностью полета больше 10000 км. Отсортируйте выборку по классу возраста в порядке возрастания.
-- В выборке должны присутствовать два атрибута — side_number, age.
SELECT 
side_number,
  CASE
    WHEN production_year < 2000 THEN 'Old'
    WHEN production_year BETWEEN 2000 AND 2010 THEN 'Mid'
    ELSE 'New'
  END AS age
FROM airliners
WHERE distance <= 10000
ORDER BY production_year;
-- Task 3
-- Руководство авиакомпании снизило цены на билеты рейсов LL4S1G8PQW, 0SE4S0HRRU и JQF04Q8I9G. Скидка на билет экономкласса (Economy) составила 15%, на билет бизнес-класса (Business) — 10%, а на билет комфорт-класса (PremiumEconomy) — 20%. Определите цену билета в каждом сегменте с учетом скидки.
-- В выборке должны присутствовать три атрибута — id, tripid, newprice.

SELECT 
id, 
trip_id,
  CASE 
    WHEN trip_id IN ('LL4S1G8PQW', '0SE4S0HRRU','JQF04Q8I9G') AND service_class = 'Economy' THEN price * 0.85 -- 15%
    WHEN trip_id IN ('LL4S1G8PQW', '0SE4S0HRRU','JQF04Q8I9G') AND service_class = 'Business' THEN price * 0.90 -- 10%
    WHEN trip_id IN ('LL4S1G8PQW', '0SE4S0HRRU','JQF04Q8I9G') AND service_class = 'PremiumEconomy' THEN price * 0.80 -- 20%
    ELSE price
  END AS newprice
FROM tickets
WHERE trip_id IN ('LL4S1G8PQW', '0SE4S0HRRU', 'JQF04Q8I9G');
-- Task 4
-- Вывести сотрудников, чьи имена начинаются на букву D и отсортировать их в алфавитном порядке по фамилии
use hr;
SELECT * 
FROM employees
WHERE first_name LIKE 'D%'
ORDER BY last_name;