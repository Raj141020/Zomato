CREATE DATABASE ZomatoDB;

USE ZomatoDB;

CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    cuisine VARCHAR(50),
    average_cost DECIMAL(10, 2),
    rating DECIMAL(3, 2)
);

INSERT INTO Restaurants (name, location, cuisine, average_cost, rating)
VALUES 
('Spice Garden', 'New York', 'Indian', 40.00, 4.8),
('Sushi Palace', 'Tokyo', 'Japanese', 50.00, 4.6),
('Pizza World', 'London', 'Italian', 25.00, 4.2);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15),
    location VARCHAR(100)
);


INSERT INTO Customers (name, email, phone_number, location)
VALUES 
('Alice Smith', 'alice@example.com', '1234567890', 'New York'),
('Bob Johnson', 'bob@example.com', '0987654321', 'Tokyo');

CREATE TABLE Orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);

INSERT INTO Orders (customer_id, restaurant_id, order_date, total_amount)
VALUES 
(1, 1, '2024-01-15', 80.00),
(2, 2, '2024-02-10', 100.00);

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    rating DECIMAL(3, 2),
    review_text TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);


INSERT INTO Reviews (customer_id, restaurant_id, rating, review_text)
VALUES 
(1, 1, 4.8, 'Excellent food and great service!'),
(2, 2, 4.5, 'Fresh sushi, will visit again.');


SELECT * FROM Restaurants;

SELECT * FROM Customers;

SELECT * FROM Orders;

SELECT * FROM Reviews;

/* Top 5 Highest-Rated Restaurants */

SELECT TOP 5 name, rating
FROM Restaurants
ORDER BY rating DESC;


/* Average Order Amount per Customer */

SELECT customer_id, AVG(total_amount) AS avg_order_amount
FROM Orders
GROUP BY customer_id;


/* Most Popular Cuisine Type */

SELECT cuisine, COUNT(restaurant_id) AS total_restaurants
FROM Restaurants
GROUP BY cuisine
ORDER BY total_restaurants DESC;


/* Total Orders Placed in the Last Month */

SELECT COUNT(order_id) AS total_orders
FROM Orders
WHERE order_date >= DATEADD(MONTH, -1, GETDATE());


/* Customers Who Ordered from a Specific Restaurant */

SELECT C.name, O.order_id
FROM Orders O
JOIN Customers C ON O.customer_id = C.customer_id
WHERE O.restaurant_id = 1;

/* Create a Stored Procedure to Get Restaurant Orders */

CREATE PROCEDURE GetRestaurantOrders
    @restaurant_id INT
AS
BEGIN
    SELECT O.order_id, C.name AS customer_name, O.total_amount, O.order_date
    FROM Orders O
    JOIN Customers C ON O.customer_id = C.customer_id
    WHERE O.restaurant_id = @restaurant_id;
END;

EXEC GetRestaurantOrders @restaurant_id = 1;

/* Create a View for High-Rated Restaurants */

CREATE VIEW HighRatedRestaurants AS
SELECT name, location, rating
FROM Restaurants
WHERE rating > 4.5;


/* Create a Trigger to Log Deletions from Orders Table */

CREATE TABLE DeletedOrders (
    order_id INT,
    customer_id INT,
    restaurant_id INT,
    total_amount DECIMAL(10, 2),
    deleted_at DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER trg_LogOrderDeletion
ON Orders
FOR DELETE
AS
BEGIN
    INSERT INTO DeletedOrders (order_id, customer_id, restaurant_id, total_amount)
    SELECT order_id, customer_id, restaurant_id, total_amount
    FROM DELETED;
END;
