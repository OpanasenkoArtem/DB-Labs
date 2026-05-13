CREATE TABLE Category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Client (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE Address (
    id SERIAL PRIMARY KEY,
    street VARCHAR(200) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    client_id INT NOT NULL,
    CONSTRAINT fk_address_client FOREIGN KEY (client_id) REFERENCES client(id)
);

CREATE TABLE Product (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    description TEXT,
    category_id INT NOT NULL,
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES category(id)
);

CREATE TABLE "order" (
    id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    address_id INT NOT NULL,
    client_id  INT NOT NULL,
    CONSTRAINT fk_order_address FOREIGN KEY (address_id) REFERENCES address(id),
    CONSTRAINT fk_order_client  FOREIGN KEY (client_id)  REFERENCES client(id)
);

CREATE TABLE Payment (
    id SERIAL PRIMARY KEY,
    amount NUMERIC(10, 2) NOT NULL,
    method VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL,
    date DATE NOT NULL,
    order_id INT NOT NULL UNIQUE,
    CONSTRAINT fk_payment_order FOREIGN KEY (order_id) REFERENCES "order"(id)
);

CREATE TABLE Order_details (
    id SERIAL PRIMARY KEY,
    quantity INT NOT NULL CHECK (quantity > 0),
    price NUMERIC(10, 2) NOT NULL,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    CONSTRAINT fk_orderdetails_order   FOREIGN KEY (order_id)   REFERENCES "order"(id),
    CONSTRAINT fk_orderdetails_product FOREIGN KEY (product_id) REFERENCES product(id)
);