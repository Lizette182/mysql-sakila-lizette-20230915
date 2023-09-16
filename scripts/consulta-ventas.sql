use sakila;

with ventas_por_tienda as (
    SELECT 
        st.store_id,
        concat (a.address,',',ci.city)as store,
        co.country,
        concat (sf.first_name,' ',sf.last_name) as staff,
        ci.city,
        sf.first_name,
        sf.last_name,
        p.amount,
        year(p.payment_date) as year,
        month(p.payment_date) as month,
        dayofmonth(payment_date) as day,
        p.payment_date
    FROM store as st
        join address as a using (address_id)
        join city as ci using (city_id)
        join country as co using (country_id)
        join staff as sf using (store_id)
        join payment as p using (staff_id)
), 
-- 2. agrupar y sumar
ventas_por_tienda_por_anno_mes as (
    select
        store,
        year,
        month,
        sum(amount) amount
    from ventas_por_tienda
    group by
        store,
        year,
        month
),select *
from ventas_por_tienda_por_anno_mes   
limit 5;

-- 3.colocar las sumas de ls meses en columnas
ventas_por_tienda_por_anno_mes as(
    select
        store,
        sum(case when year=2005 and month=5 then amount else 0 end) may2005,
        sum(case when year=2005 and month=6 then amount else 0 end) jun2005,
        sum(case when year=2005 and month=7 then amount else 0 end) jul2005
    from ventas_por_tienda_por_anno_mes
    group by store;
)


