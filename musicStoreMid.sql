-- 1. return the email , firstname , lastname , & genre of all rock music listeners 
--return list ordered alphabetically with email starting with a.

SELECT DISTINCT customer.email, customer.first_name, customer.last_name, genre.name AS genre
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
JOIN track ON invoice_line.track_id = track.track_id
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name = 'Rock'
ORDER BY customer.email

--2. invite the artist who have written the most rock music in our dataset
--write a query that returns the artist name and totaltrack count of top 10 rock bands

select artist.artist_id , artist.name , COUNT(track.track_id) as no_of_songs
from track 
JOIN album on track.album_id = album.album_id
JOIN artist ON album.artist_id = artist.artist_id
JOIN genre ON track.genre_id = genre.genre_id
where genre.name like 'Rock'
group by artist.artist_id  , artist.name
order by no_of_songs desc
limit 10

--3. return all the track names that have a song length longer than average song length . 
-- return name and milliseconds for each track , order by song length with longest being the first
select name , milliseconds from track 
where milliseconds > (
	select AVG(milliseconds) as average_length FROM track
	)
order by milliseconds desc





