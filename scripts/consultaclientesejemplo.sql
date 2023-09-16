use sakila;
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    a.address,
    a.address_id,
    a.district,
    ci.city_id,
    ci.city
FROM customer as c
     
     INNER JOIN address as a USING(address_id)
     INNER JOIN city as ci USING(city_id)
LIMIT 5;