/* insert into sakila_dwh.dim_tiempo

select

TO_DAYS(date) as date_key,

date as date_value,

month(date) as month_number,

monthname(date) as month_name,

year(date) as year4,

dayofweek(date) as day_of_week,

dayname(date) as day_of_week_name

from

(select

    distinct date(rental_date) as date

from sakila.rental) fechas */
select *
from sakila_dwh.dim_tiempo;