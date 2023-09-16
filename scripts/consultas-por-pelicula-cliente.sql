use sakila;

with consulta_principal as (

    SELECT
        film_id
        ,title
        , category.name AS category
        , concat(first_name, ' ', last_name) customer
        , rental_date
        ,year(rental_date) as rental_year
        ,month(rental_date) as rental_month
        ,dayofmonth(rental_date) as rental_day
    FROM inventory

        LEFT JOIN rental USING(inventory_id)
        LEFT JOIN film USING(film_id)
        LEFT JOIN film_category USING(film_id)
        LEFT JOIN category USING(category_id)
        LEFT JOIN customer using (customer_id)  
),
datos_alquiler_anno_mes as(
    select
        customer,
        rental_year,
        rental_month,
        count(*) as rental_times
    from consulta_principal
    group by
        customer,
        rental_year,
        rental_month
),
-- 3. pasar algunas filas a columnas
datos_alquiler_por_mes as (
    select
        customer,
        sum(case when rental_year=2005 and rental_month = 5 then rental_times else 0 end) may2005,
        sum(case when rental_year=2005 and rental_month = 6 then rental_times else 0 end) jun2005
    from datos_alquiler_anno_mes
    group by
        customer
),
-- 4.Diferencia y porcentaje de crecimiento
customer_datos_por_mes as (
    select
        customer,
        may2005,
        jun2005,
        (jun2005- may2005) as diffjun2005,  -- junio - mayo
        case when may2005 <> 0 then
            ((jun2005 - may2005)/may2005) 
        else 
            0
        end as porcjun2005  -- (junio - mayo)/mayo
    from datos_alquiler_por_mes
)
select *
from customer_datos_por_mes
LIMIT 10
;