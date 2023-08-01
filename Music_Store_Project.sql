--Who is the customer with the highest number of purchases?

select * from invoice

SELECT customer_id, COUNT(*) AS TotalPurchases
FROM invoice
GROUP BY customer_id
ORDER BY TotalPurchases DESC
LIMIT 1

select * from customer 
where customer_id = 5

--Which countries have the highest number of customers?

select * from invoice

select count(*) as c, billing_country
from invoice
group by billing_country
order by c desc

--What are the top 3 values of the total invoice amount?

SELECT total
FROM invoice
ORDER BY total DESC
LIMIT 3

/*Which city has the best-selling albums?
Write a query that returns one city that has the highest count of album purchases.
Return both the city name & the count of album purchases.*/

select * from invoice

SELECT billing_city AS City, COUNT(*) AS AlbumPurchases
FROM invoice
WHERE billing_city IS NOT NULL
GROUP BY billing_city
ORDER BY AlbumPurchases DESC
LIMIT 1;

/*Who is the top-spending customer?
Write a query that returns the person who has spent the most money on purchases.*/

select * from invoice

SELECT customer_id, SUM(total) AS TotalSpent
FROM invoice
GROUP BY customer_id
ORDER BY TotalSpent DESC
LIMIT 1;

/*Write a query to return the email, first name, last name, & Genre of all Pop Music listeners.
Return your list ordered alphabetically by email starting with A.*/

SELECT c.email, c.first_name, c.last_name, g.name AS Genre
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.Name = 'Pop'
ORDER BY c.email

/*Let's invite the artists who have the most tracks in our dataset.
Write a query that returns the Artist name and total track count of the top 10 artists with the highest track counts.*/

SELECT ar.name AS ArtistName, COUNT(t.track_id) AS TotalTracks
FROM artist ar
JOIN album al ON ar.artist_id = al.artist_id
JOIN Track t ON al.album_id = t.album_id
GROUP BY ar.name
ORDER BY TotalTracks DESC
LIMIT 10;

/*Return all the track names that have a song length shorter than the average song length.
Return the Name and Milliseconds for each track.
Order by the song length with the shortest songs listed first.*/

SELECT name, milliseconds
FROM track
WHERE milliseconds < (SELECT AVG(milliseconds) FROM track)
ORDER BY milliseconds












