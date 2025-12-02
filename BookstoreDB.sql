USE BookstoreDB;

SELECT * FROM Books 
WHERE Genre='Fiction';

SELECT * FROM Books
WHERE Published_Year>1950;

SELECT * FROM Customers WHERE country='Canada';

SELECT * FROM Orders WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

SELECT SUM(Stock) AS Total_Stock FROM Books;

SELECT * 
FROM Books 
ORDER BY Price DESC 
LIMIT 1;

SELECT * FROM Orders
WHERE Quantity > 1;

SELECT * FROM Orders WHERE Total_Amount>20;

SELECT DISTINCT genre FROM Books;

SELECT * 
FROM Books 
ORDER BY Stock ASC 
LIMIT 5;

SELECT SUM(Total_Amount) 
AS Total_Revenue 
FROM Orders;

SELECT b.Genre, SUM(o.Quantity) AS Total_Books_Sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Genre;

SELECT AVG(Price) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy';

SELECT o.customer_id, c.name,
COUNT(o.Order_ID) AS Total_Orders
FROM Orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_ID, c.name
HAVING COUNT(Order_ID) >= 2;

SELECT b.Title, SUM(o.Quantity) AS Total_Ordered
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Title
ORDER BY Total_Ordered DESC
LIMIT 1;

SELECT * 
FROM Books 
WHERE Genre = 'Fantasy'
ORDER BY Price DESC 
LIMIT 3;

SELECT b.Author, SUM(o.Quantity) AS Total_Sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Author
ORDER BY Total_Sold DESC;

SELECT DISTINCT c.City
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.City
HAVING SUM(o.Total_Amount) > 30;

SELECT c.Customer_ID, c.Name, SUM(o.Total_Amount) AS Total_Spent
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID
ORDER BY Total_Spent DESC
LIMIT 1;

SELECT b.Book_ID, 
       b.Title, 
       b.Stock AS Initial_Stock, 
       COALESCE(SUM(o.Quantity), 0) AS Total_Sold, 
       (b.Stock - COALESCE(SUM(o.Quantity), 0)) AS Remaining_Stock
FROM Books b
LEFT JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock;
