SELECT
    od.order_id,
    p.name AS product_name,
    od.quantity,
    od.price AS unit_price
FROM Order_details od
INNER JOIN Product p ON od.product_id = p.id;

SELECT
    c.name AS client_name,
    c.email,
    o.id AS order_id,
    o.status,
    o.order_date
FROM Client c
LEFT JOIN "order" o ON c.id = o.client_id
ORDER BY c.name;

SELECT
    p.name AS product_name,
    c.name AS category_name
FROM Product p
RIGHT JOIN Category c ON p.category_id = c.id;
