SELECT name, price
FROM Product
WHERE price > (SELECT AVG(price) FROM Product)
ORDER BY price DESC;

SELECT
    c.name,
    c.email,
    (SELECT COUNT(*)
     FROM "order" o
     WHERE o.client_id = c.id) AS total_orders
FROM Client c;

SELECT name, email
FROM Client
WHERE id IN (
    SELECT o.client_id
    FROM "order" o
    JOIN Order_details od ON o.id = od.order_id
    JOIN Product p ON od.product_id = p.id
    JOIN Category c ON p.category_id = c.id
    WHERE c.name = 'Electronics'
);

SELECT
    c.name AS category_name,
    ROUND(AVG(p.price), 2) AS avg_price
FROM Product p
JOIN Category c ON p.category_id = c.id
GROUP BY c.name
HAVING AVG(p.price) > (SELECT AVG(price) FROM Product)
ORDER BY avg_price DESC;