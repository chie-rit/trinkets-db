CREATE DATABASE IF NOT EXISTS 'Trinkets';
USE 'Trinkets';

-- USER AND ADDRESS TABLES

CREATE TABLE User (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    contact VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE Address (
    id INT AUTO_INCREMENT PRIMARY KEY,
    location VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE User_address (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    address_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(id),
    FOREIGN KEY (address_id) REFERENCES Address(id)
) ENGINE=InnoDB;

-- PAYMENT TABLES

CREATE TABLE Payment_Method (
    id INT AUTO_INCREMENT PRIMARY KEY,
    value VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE User_Payment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    payment_method_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(id),
    FOREIGN KEY (payment_method_id) REFERENCES Payment_Method(id)
) ENGINE=InnoDB;

-- DELIVERY TABLES

CREATE TABLE Delivery_Method (
    id INT AUTO_INCREMENT PRIMARY KEY,
    method VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE Delivery_Status (
    id INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- PRODUCT TABLES

CREATE TABLE Product (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    product_image VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE Product_Item (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    name VARCHAR(100),
    item_qty INT DEFAULT 0,
    image VARCHAR(255),
    price DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES Product(id)
) ENGINE=InnoDB;

CREATE TABLE Variation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    name VARCHAR(100),
    FOREIGN KEY (product_id) REFERENCES Product(id)
) ENGINE=InnoDB;

CREATE TABLE Variation_type (
    id INT AUTO_INCREMENT PRIMARY KEY,
    variation_id INT NOT NULL,
    type VARCHAR(100),
    FOREIGN KEY (variation_id) REFERENCES Variation(id)
) ENGINE=InnoDB;

CREATE TABLE Item_Description (
    variation_id INT NOT NULL,
    item_id INT NOT NULL,
    PRIMARY KEY (variation_id, item_id),
    FOREIGN KEY (variation_id) REFERENCES Variation(id),
    FOREIGN KEY (item_id) REFERENCES Product_Item(id)
) ENGINE=InnoDB;

-- CART TABLES

CREATE TABLE Cart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(id)
) ENGINE=InnoDB;

CREATE TABLE Cart_Item (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cart_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    FOREIGN KEY (cart_id) REFERENCES Cart(id),
    FOREIGN KEY (item_id) REFERENCES Product_Item(id)
) ENGINE=InnoDB;

-- ORDER TABLES

CREATE TABLE `Order` (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATE NOT NULL,
    payment_method INT NOT NULL,
    delivery_address INT NOT NULL,
    delivery_method INT NOT NULL,
    total_payment DECIMAL(10,2) NOT NULL,
    status INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(id),
    FOREIGN KEY (payment_method) REFERENCES Payment_Method(id),
    FOREIGN KEY (delivery_address) REFERENCES Address(id),
    FOREIGN KEY (delivery_method) REFERENCES Delivery_Method(id),
    FOREIGN KEY (status) REFERENCES Delivery_Status(id)
) ENGINE=InnoDB;

CREATE TABLE Order_Item (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    order_id INT NOT NULL,
    qty INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Product_Item(id),
    FOREIGN KEY (order_id) REFERENCES `Order`(id)
) ENGINE=InnoDB;

-- REVIEW TABLE

CREATE TABLE Review (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    FOREIGN KEY (user_id) REFERENCES User(id),
    FOREIGN KEY (order_id) REFERENCES `Order`(id)
) ENGINE=InnoDB;
