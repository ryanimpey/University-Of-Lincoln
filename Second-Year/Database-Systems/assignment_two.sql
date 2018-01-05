/* Removes the previous database only if it currently exists TODO:: REMOVE AS FOR TESTING PURPOSES */
DROP DATABASE IF EXISTS assignment;

/* Create database to store all tables etc */
CREATE DATABASE assignment;
USE assignment;

/* Create customer table using varchar for house due to house names (e.g. Flat 001 The Junxion) */
CREATE TABLE Customers (
    CustomerId int NOT NULL AUTO_INCREMENT, -- Primary Key
    FirstName varchar(25),
    LastName varchar(25),
    DateOfBirth date,
    Email varchar(255),
    HouseAddress varchar(25),
    StreetAddress varchar(50),
    CityAddress varchar(25),
    CountyAddress varchar(25),
    PostcodeAddress varchar(8),
    PRIMARY KEY (CustomerId),
    UNIQUE (CustomerId, Email)
);

/* Create customer order table to store each order the customer creates */
CREATE TABLE Customer_Orders (
    OrderId int NOT NULL AUTO_INCREMENT, -- Primary Key
    CustomerId int NOT NULL, -- Foreign Key (Customer ID)
    PaymentDate date,
    DispatchDate date,
    DeliveryDate date,
    HouseAddress varchar(25),
    StreetAddress varchar(50),
    CityAddress varchar(25),
    CountyAddress varchar(25),
    PostcodeAddress varchar(8),
    OrderStatus varchar(10) DEFAULT 'PROCESSING', -- Default value for all orders
    FullfilledBy int NOT NULL,
    PRIMARY KEY (OrderId),
    UNIQUE (OrderId)
);

/* Create table to store items in each customer order */
CREATE TABLE Customer_Orders_Items (
    OrderId int NOT NULL, -- Part Primary Key
    ItemId int NOT NULL, -- Part Primary Key
    Quantity int NOT NULL,
    PRIMARY KEY (OrderId, ItemId)
);

/* Create suppliers table */
CREATE TABLE Suppliers (
    SupplierId int NOT NULL AUTO_INCREMENT, -- Primary Key
    SupplierName varchar(25),
    HouseAddress varchar(25),
    StreetAddress varchar(50),
    CityAddress varchar(25),
    CountyAddress varchar(25),
    PostcodeAddress varchar(8),
    PRIMARY KEY (SupplierId),
    UNIQUE (SupplierId)
);

/* Create purchase orders table */
CREATE TABLE Purchase_Orders (
    OrderId int NOT NULL AUTO_INCREMENT, -- Primary Key
    PaymentDate date,
    PRIMARY KEY (OrderId),
    UNIQUE (OrderId)
);

/* Create table to store items in each purchase order */
CREATE TABLE Purchase_Orders_Items (
    OrderId int NOT NULL, -- Part Primary Key
    ItemId int NOT NULL, -- Part Primary Key
    Quantity int NOT NULL,
    PRIMARY KEY (OrderId, ItemId)
);

/* Create staff members table */
CREATE TABLE Staffs (
    StaffId int NOT NULL AUTO_INCREMENT, -- Primary Key
    FirstName varchar(25),
    LastName varchar(25),
    DateOfBirth date,
    Email varchar(255),
    PRIMARY KEY (StaffId),
    UNIQUE (StaffId)
);

/* Create stock table */
CREATE TABLE Stock_Items (
    StockId int NOT NULL AUTO_INCREMENT, -- Primary Key
    SupplierId int NOT NULL, -- Foreign Key (Suppliers)
    StockName varchar(255),
    StockPrice decimal(4,2), -- Decimal value for price
    PRIMARY KEY (StockId),
    UNIQUE (StockId)
);

/* --- Add foreign keys and constraints --- */
-- KEY: fk_{column_name}_{table_name}
ALTER TABLE Customer_Orders ADD CONSTRAINT fk_customer_id_customer_orders
FOREIGN KEY (CustomerId) REFERENCES Customers (CustomerId) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Stock_Items ADD CONSTRAINT fk_supplier_id_stock_items
FOREIGN KEY (SupplierId) REFERENCES Suppliers (SupplierId) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Customer_Orders_Items ADD CONSTRAINT fk_order_id_cus_order_items
FOREIGN KEY (OrderId) REFERENCES Customer_Orders (OrderId) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Customer_Orders_Items ADD CONSTRAINT fk_item_id_cus_order_items
FOREIGN KEY (ItemId) REFERENCES Stock_Items (StockId) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Purchase_Orders_Items ADD CONSTRAINT fk_order_id_pur_order_items
FOREIGN KEY (OrderId) REFERENCES Purchase_Orders (OrderId) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Purchase_Orders_Items ADD CONSTRAINT fk_item_id_pur_order_items
FOREIGN KEY (ItemId) REFERENCES Stock_Items (StockId) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE Customer_Orders ADD CONSTRAINT fk_staff_id_customer_orders
FOREIGN KEY (FullfilledBy) REFERENCES Staffs (StaffId) ON UPDATE CASCADE; -- Don't delete order on staff member deletion but still update it
/* --- End foreign keys and constraints --- */

/* Blanket error handling */
    -- USE WHEN PROCEDURES ARE CREATED
/* End blanket error handling */

-- Alter starting auto_increment value to start and increment from 1000
ALTER TABLE Customers AUTO_INCREMENT=1000;
ALTER TABLE Customer_Orders AUTO_INCREMENT=1000;
ALTER TABLE Purchase_Orders AUTO_INCREMENT=1000;
ALTER TABLE Stock_Items AUTO_INCREMENT=100;

/* Inserting Data into customers table */
INSERT INTO Customers (
    FirstName, LastName, DateOfBirth, Email, HouseAddress,
    StreetAddress, CityAddress, CountyAddress, PostcodeAddress
) VALUES (
    'Eliza', 'Megahey', '2017-01-16', 'emegahey0@google.com.au',
    '160', 'Tennyson Burrows', 'Almeirim', 'Ontario', 'LC5 9NH'
), (
    'Lauriane', 'Casey', '2013-03-04', 'Zelma@noemy.name',
    '556', 'Paula Village', 'vicenta', 'Era', '57F 6HJ'
), (
    'Sarah', 'Hewitt', '1992-01-02', 'user@biinote.com',
    '61', 'Stroude Road', 'Siefton', 'Birmingham' ,'SY8 3XG'
);

/* Inserting data into the staff member table */
INSERT INTO Staffs (
    FirstName, LastName, DateOfBirth, Email
) VALUES (
    'Doug', 'Sheringham', '1996-05-13', 'Dougie129@gmail.com'
), (
    'Scott', 'Saunders', '1990-09-28', 'ScottSaunders@dayrep.com'
), (
    'Daniel', 'Burgess', '1995-07-17', 'DanielBurgess@armyspy.com'
);

/* Inserting data into customer_orders table */
INSERT INTO Customer_Orders (
    CustomerId, PaymentDate, DispatchDate, DeliveryDate,
    HouseAddress, StreetAddress, CityAddress, CountyAddress,
    PostcodeAddress, FullfilledBy
) VALUES (
    1001, '2017-12-31', '2018-01-03', '2018-01-08', '96', 'Carriers Road',
    'Crewe', 'Cheshire', 'CH3 7BA', 3
), (
    1000, '2015-11-27', '2016-05-13', '2016-05-21', '56', 'Overton Circle',
    'Little Weighton', 'Leeds', 'LE20 5HJ', 2
), (
    1002, '2016-06-06', '2016-07-01', '2016-07-05', '12', 'Bridge Street',
    'Gordonstown', 'Absfleet', 'AB51 9TX', 2
), (
    1000, '2015-11-29', '2015-12-01', '2015-12-04', '56', 'Overton Circle',
    'Little Weighton', 'Leeds', 'LE20 5HJ', 3
);

/* Inserting data into the suppliers table */
INSERT INTO Suppliers (
    SupplierName, HouseAddress, StreetAddress,
    CityAddress, CountyAddress, PostcodeAddress
) VALUES (
    'Big Plant Co.', '64', 'Glenurquhart Road',
    'Balgove', 'Sheringham', 'AB51 5QP'
), (
    'The Stock Inc.', '44', 'Cefn Road',
    'Farlary', 'Ivington', 'IV28 8SE'
), (
    'Plant Pals', '83', '89 Thompsons Lane',
    'Mendlesham', 'Suffolk', 'IP14 5FX'
);

/*  Inserting data into the purchase_orders table */
INSERT INTO Purchase_Orders ( PaymentDate ) VALUES
( '2018-01-01' ), ( '2017-12-31'), ( '2018-01-02');

/* Inserting data into the purchase_orders_items table
INSERT INTO Purchase_Orders_Items VALUES (1000, 100, 2), (1001, 101, 3), (1002, 104, 6), (1000, 102, 1);
*/

/* Inserting data into the stock items table */
INSERT INTO Stock_Items (
    SupplierId, StockName, StockPrice
) VALUES (
    1, 'Sunflower Seeds', 1.99
), (
    1, 'Roses x5', 4.99
), (
    2, 'XL Shovel', 9.99
), (
    3, 'Plant Fertiliser', 6.49
);

/* Inserting data into the purchase_orders_items table */
INSERT INTO Purchase_Orders_Items VALUES (1000, 100, 2), (1001, 101, 3), (1002, 102, 6), (1002, 103, 1);

/* Inserting data into the customer_orders_items table */
INSERT INTO Customer_Orders_Items VALUES (1000, 100, 1), (1000, 101, 2), (1002, 103, 10);

/* Updating data about a customers order */
UPDATE Customer_Orders SET OrderStatus = 'CONFIRMED' WHERE OrderId = 1000;
UPDATE Customer_Orders SET OrderStatus = 'DELIVERED' WHERE OrderId = 1002;

/* Deleting a staff member from a table */
DELETE FROM Staffs WHERE Email = 'Dougie129@gmail.com';

/* Altering table to add customer order information and adding a default value of none. */
ALTER TABLE Customer_Orders ADD OrderInformation varchar(255) DEFAULT "None.";
UPDATE Customer_Orders SET OrderInformation = "Leave deliveries in porch." WHERE PostcodeAddress = 'LE20 5HJ';

/* INNER JOIN statement to return stock information and who supplies it along with their supplier id */
PREPARE inner_join FROM 'SELECT * FROM stock_items INNER JOIN suppliers ON stock_items.SupplierId = ?';
/* Creating user defined variable to be used in the prepared statement */
SET @supplier_id = 'suppliers.SupplierId';
EXECUTE inner_join USING @supplier_id;
DEALLOCATE PREPARE inner_join;

/* LEFT JOIN statement to return who fullfilled a customers order and on what date */
SELECT customer_orders.OrderId AS `Order Number`, customer_orders.DispatchDate AS `Day of Dispatch`,
CONCAT(staffs.FirstName,' ', staffs.LastName) AS `Fulfilled by` FROM customer_orders
LEFT JOIN staffs ON customer_orders.FullfilledBy = staffs.StaffId;

/* RIGHT JOIN Statement to return item information for each order as well as the individual sum(s) of the ordered item(s)*/
/* TRUNCATES the returned value of quantity * price to two decimal places */
SELECT customer_orders_items.OrderId AS `Order Number`, customer_orders_items.Quantity AS `Item Quantity`,
stock_items.StockName AS `Item Name` ,stock_items.StockPrice AS `Item Price`,
TRUNCATE((customer_orders_items.Quantity * stock_items.StockPrice),2) AS `Total Item Price` FROM customer_orders_items
RIGHT JOIN stock_items ON customer_orders_items.ItemId = stock_items.StockId WHERE customer_orders_items.OrderId IS NOT NULL;

/* Union query to return all addresses on record from suppliers and customers, including their ID and name */
SELECT CustomerId AS `ID Number`, CONCAT(FirstName, " ", LastName) AS Name,
CONCAT(HouseAddress,", ", StreetAddress, ", ", CityAddress, ", ", CountyAddress, ", ", PostcodeAddress) AS `Address on Record`
FROM customers UNION SELECT SupplierId AS `ID Number`, SupplierName AS Name,
CONCAT(HouseAddress,", ", StreetAddress, ", ", CityAddress, ", ", CountyAddress, ", ", PostcodeAddress) AS `Address on Record`
FROM suppliers ORDER BY `ID Number` ASC;

DELIMITER //
CREATE PROCEDURE BackupTablesAndConstraints()
    BEGIN

        /* MYSQL ERROR HANDLING - Catches any SQLEXCEPTIONS and will rollback the changes made */
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
            BEGIN
                ROLLBACK;
                SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
            END;

        /* Copy customer table */
        CREATE TABLE IF NOT EXISTS copy_of_customers LIKE Customers;
        INSERT copy_of_customers SELECT * FROM Customers;

        /* Copy customer_orders table */
        CREATE TABLE IF NOT EXISTS copy_of_customer_orders LIKE Customer_Orders;
        INSERT copy_of_customer_orders SELECT * FROM Customer_Orders;

        /* Copy customer_orders table */
        CREATE TABLE IF NOT EXISTS copy_of_customer_orders_items LIKE Customer_Orders_Items;
        INSERT copy_of_customer_orders_items SELECT * FROM Customer_Orders_Items;

        /* Copy customer_orders table */
        CREATE TABLE IF NOT EXISTS copy_of_suppliers LIKE Suppliers;
        INSERT copy_of_suppliers SELECT * FROM Suppliers;

        /* Copy customer_orders table */
        CREATE TABLE IF NOT EXISTS copy_of_purchase_orders LIKE Purchase_Orders;
        INSERT copy_of_purchase_orders SELECT * FROM Purchase_Orders;

        /* Copy customer_orders table */
        CREATE TABLE IF NOT EXISTS copy_of_purchase_orders_items LIKE Purchase_Orders_Items;
        INSERT copy_of_purchase_orders_items SELECT * FROM Purchase_Orders_Items;

        /* Copy staffs table */
        CREATE TABLE IF NOT EXISTS copy_of_staffs LIKE Staffs;
        INSERT copy_of_staffs SELECT * FROM Staffs;

        /* Copy customer_orders table */
        CREATE TABLE IF NOT EXISTS copy_of_stock_items LIKE Stock_Items;
        INSERT copy_of_stock_items SELECT * FROM Stock_Items;
    END //
DELIMITER ;

/* Call stored procedure previously created */
CALL BackupTablesAndConstraints();

/* Create new user account without drop privilege */
CREATE USER IF NOT EXISTS 'default'@'localhost' IDENTIFIED BY 'alpine';
GRANT SELECT, INSERT, UPDATE, DELETE, INDEX, CREATE, ALTER ON assignment TO 'default'@'localhost';

/* Show privileges for user default */
SHOW GRANTS FOR 'default'@'localhost';