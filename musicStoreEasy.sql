-- 1- who is the senior most employee based on job title?

select *from employee
order by levels desc
limit 1

-- 2-  Which countries have most invoices?

select count(*) , billing_country from invoice
group by billing_country 
order by count desc

-- 3 - what are top3 values of total invoice 

select* from invoice 
order by total desc
limit 3

-- 4- which city has the best customers ?(returns one city that has highest sum of invoice totals , 
city name and sum of all invoices)

select sum(total) as total_invoice , billing_city 
from invoice
group by billing_city
order by total_invoice desc

-- 5- who is best customer ?(returns the person who has spent the most money)


select customer.customer_id , customer.first_name , customer.last_name , SUM(invoice.total) as total
from customer 
join invoice ON customer.customer_id = invoice.customer_id
group by customer.customer_id
order by total desc
limit 1


