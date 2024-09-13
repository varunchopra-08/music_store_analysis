-- 1.how much amount of money is spent by each customer on artists? 
-- return customer name , artist name and total spent
with best_selling_artist as (
	 select artist.artist_id as artist_id , artist.name as artist_name , SUM(invoice_line.unit_price*invoice_line.quantity) as amount_spent
	 from invoice_line
	 join track on invoice_line.track_id  = track.track_id
	 join album on track.album_id = album.album_id
	 join artist on album.artist_id = artist.artist_id
	 GROUP BY 1
	 ORDER BY 3 DESC 
	 LIMIT 1
	 )
select c.customer_id , c.first_name , c.last_name , bsa.artist_name , SUM (il.unit_price*il.quantity) as amount_spent
from invoice_line il
join invoice i ON i.invoice_id = il.invoice_id
join customer c ON c.customer_id = i.customer_id
join track t ON t.track_id = il.track_id
join album a ON a.album_id = t.album_id
join artist ar ON ar.artist_id = a.artist_id
join best_selling_artist bsa ON bsa.artist_id = ar.artist_id
GROUP BY 1,2,3,4
ORDER BY 5 DESC

-- 2. most popular music country for each country(genre with highest amount of purchases)
-- returns each country along with top genre
-- For countries where maximum no. of purchases are shared return all genres

WITH popular_genre AS(
	SELECT COUNT(invoice_line.quantity) AS purchases, customer.country, genre.name, genre.genre_id,
	ROW_NUMBER() OVER (PARTITION BY customer.country ORDER BY COUNT (invoice_line.quantity) DESC) AS RowNo
	FROM invoice_line
	JOIN invoice ON invoice.invoice_id = invoice_line.invoice_id
	JOIN customer ON customer.customer_id = invoice.customer_id
	Join track ON track.track_id = invoice_line.track_id
	JOIN genre ON genre.genre_id = track.genre_id
	GROUP BY 2,3,4
	ORDER BY 2 ASC, 1 DESC
)

SELECT * FROM popular_genre WHERE RowNo <=1

-- 3. customer that has spent most on music for each country
--returns the country alongwith the top customer and how much they spent is shared 
--provide all customers who spent this amounut 
WITH Customer_with_country AS(
	SELECT customer.customer_id, first_name, last_name, billing_country, SUM(total) AS total_spending,
	ROW_NUMBER() OVER (PARTITION BY billing_country ORDER BY SUM(total) DESC) AS ROWNO
	From invoice
	JOIN customer ON customer.customer_id = invoice.customer_id
	GROUP BY 1,2,3,4
	ORDER BY 4 ASC, 5 DESC
	) 
SELECT * FROM Customer_with_country where RowNo <=1
