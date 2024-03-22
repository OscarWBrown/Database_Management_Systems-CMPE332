DROP DATABASE IF EXISTS restaurantDB;
CREATE DATABASE restaurantDB;

CREATE TABLE restaurantFranchise(
    URL				varChar(100) NOT NULL,
    name			varChar(30) NOT NULL,
    ZIP				char(6), 
    city			varChar(20), 
    street			varChar(30), 
    PRIMARY KEY (URL, name)
);

CREATE TABLE employee(
	employeeID		int NOT NULL,
    email			varChar(30), 
    firstName		varChar(20),
    lastName		varChar(20),
    PRIMARY KEY (employeeID)
);
    
CREATE TABLE chef(
	chefID			int NOT NULL, 
    PRIMARY KEY (chefID),
	FOREIGN KEY (chefID) REFERENCES employee (employeeID) ON DELETE RESTRICT

);

CREATE TABLE credentials(
	chefID			int NOT NULL,
	credentials		varChar(200),
	PRIMARY KEY (chefID),
	FOREIGN KEY (chefID) REFERENCES employee (employeeID) ON DELETE CASCADE
);

CREATE TABLE management(
	managerID		int NOT NULL, 
    PRIMARY KEY (managerID),
	FOREIGN KEY (managerID) REFERENCES employee (employeeID) ON DELETE RESTRICT

);

CREATE TABLE servers(
	serverID		int NOT NULL, 
    PRIMARY KEY (serverID),
	FOREIGN KEY (serverID) REFERENCES employee (employeeID) ON DELETE RESTRICT

);

CREATE TABLE deliveryDriver(
	ddID			int NOT NULL, 
    PRIMARY KEY (ddID), 
	FOREIGN KEY (ddID) REFERENCES employee (employeeID) ON DELETE RESTRICT
);

CREATE TABLE customer(
	customerID		int NOT NULL,
    email			varChar(30), 
    firstName		varChar(20), 
    lastName		varChar(20), 
    phoneNo			int, 
    ZIP				char(6), 
    city			varChar(20), 
    street			varChar(20),	
    PRIMARY KEY (customerID) 
);

CREATE TABLE relationship(
	customer		int NOT NULL,
	employee		int NOT NULL,
	statuss			varChar(200),
	PRIMARY KEY (customer, employee),
	FOREIGN KEY (employee) REFERENCES employee (employeeID) ON DELETE RESTRICT,
	FOREIGN KEY (customer) REFERENCES customer (customerID) ON DELETE RESTRICT
);

CREATE TABLE currentSchedule(
	dates			date NOT NULL,
	startTime		time, 
    endTime			time,
    workerID		int NOT NULL,
    PRIMARY KEY (dates, workerID),
    FOREIGN KEY (workerID) REFERENCES employee (employeeID) ON DELETE RESTRICT
);

CREATE TABLE orders(
	tip				decimal(4,2),
    price			decimal(4,2) NOT NULL,
    items			varChar(30),
	orderDate		date,
    placementTime	time,
    deliveryTime	time,
    orderID			int NOT NULL,
	customer		int NOT NULL,
    PRIMARY KEY (orderID),
	FOREIGN KEY (customer) REFERENCES customer (customerID) ON DELETE RESTRICT
);

CREATE TABLE items(
	foodItem		varChar(30) NOT NULL,
	PRIMARY KEY (foodItem), 
	FOREIGN KEY (foodItem) REFERENCES orders (item)
);

CREATE TABLE customerAccount(
    credit			decimal(4,2),
    paymentAmount	decimal(4,2),
    paymentDate		date,
	paymentTime		time, 
	accountID		int NOT NULL,
    PRIMARY KEY (accountID),
	FOREIGN KEY (accountID) REFERENCES customer (customerID) ON DELETE RESTRICT
    
);

CREATE TABLE menu(
    item			varChar(30),	
    price			decimal(4,2),
	restaurant		varChar(30) NOT NULL,
    PRIMARY KEY (item),
	FOREIGN KEY (restaurant) REFERENCES restaurantFranchise (URL) ON DELETE RESTRICT
);

INSERT INTO restaurantFranchise VALUES
('www.BurgerPlace.com', 'Burger Place', 'K3L3D3', 'Kingston', 'Frontenac Street'),
('www.PizzaPlace.com', 'Pizza Place', 'B4Q1R7', 'Toronto', 'Bay Street'),
('www.PastaPlace.com', 'Pasta Place', 'M205H4', 'Vancouver', 'Talisman Street'),
('www.TacoPlace.com', 'Taco Place', 'U1A7M2', 'Calgary', 'Main Street');

INSERT INTO employee VALUES
('11111', 'oscar@gmail.com', 'oscar', 'brown'),
('11112', 'henry@gmail.com', 'Henry', 'Wilson'),
('11113', 'shiv@gmail.com', 'Shivam', 'Sood'),
('11114', 'dave@gmail.com', 'Dave', 'Laughton'),
('11115', 'jackson@gmail.com', 'Jackson', 'Cowie'),
('11116', 'cam@gmail.com', 'Cameron', 'Overvelde'),

('33333', 'jarrettCrowell@gmail.com', 'Jarrett', 'Crowell'),
('33332', 'kieran@yahoo.ca', 'Kieran', 'Price'),
('33331', 'logan@gmail.com', 'Logan', 'Whynott'),
('33334', 'logan1@gmail.com', 'Logan', 'Simon'),
('33335', 'cole@gmail.com', 'Cole', 'Simon'),
('33336', 'cole2@gmail.com', 'Cole', 'Sanford'),

('22221', 'carter@gmail.com', 'Carter', 'Theriault'),
('22222', 'ethan@gmail.com', 'Ethan', 'Price'),
('22223', 'jake@gmail.com', 'Jake', 'Kelln'),
('22224', 'cohen@gmail.com', 'Cohen', 'Gagnon'),
('22225', 'josh@gmail.com', 'Josh', 'Brown'),
('22226', 'ty@gmail.com', 'Tyler', 'Allison'),

('44444', 'jackferguson@gmail.com', 'Jack', 'Ferguson'), 
('44441', 'jacky@gmail.com', 'Jaclyn', 'Brown'),
('44442', 'alan@gmail.com', 'Alan', 'Brown'),
('44443', 'linda@hotmail.com', 'Linda', 'Cosentino'),
('44445', 'fillipo@gmail.com', 'Phillopo', 'Cosentino'),
('44446', 'sam@yahoo.co.uk', 'Sam', 'Collard');

INSERT INTO chef VALUES
('11111'),
('11112'),
('11113'),
('11114'),
('11115'),
('11116');

INSERT INTO credentials VALUES		
('11111', 'master chef'),
('11112', 'line chef, grill chef'),
('11113', 'appetizer chef'),
('11114', 'desert chef'),
('11115', 'top chef'),
('11116', 'regular chef');

INSERT INTO management VALUES
('22221'),
('22222'),
('22223'),
('22224'),
('22225'),
('22226');

INSERT INTO servers VALUES
('33331'),
('33332'),
('33333'),
('33334'),
('33335'),
('33336');

INSERT INTO deliveryDriver VALUES
('44441'),
('44442'),
('44443'),
('44444'),
('44445'),
('44446');

INSERT INTO customer VALUES
('55551', 'nate@gmail.com', 'Nate', 'Ferguson', '9022193333', 'K7Y5G9', 'Kingston', 'University Avenue'),
('55552', 'jer@gmail.com', 'Jeremy', 'Harper', '9023334444', 'K9T6G6', 'Kingston', 'Frontenac Street'),
('55553', 'rob@gmail.com', 'Robert', 'McNeil', '6478889999', 'B2T1E4', 'Halifax', 'Main Street'),
('55554', 'stacy@outlook.com', 'Stacey', 'Shane', '6475008000', 'O3T4A4', 'Toronto', 'Bloor Street'),
('55555', 'bella@gmail.com', 'Bella', 'Perin', '6477863452', 'F8T2S2', 'Calgary', 'Rocky Road'),
('55556', 'metty@hotmail.com', 'Matthew', 'Mamelak', '7078804454', 'H0I5Y7', 'Vancouver', 'Peach Street');

INSERT INTO relationship VALUES
('55551', '11111', 'very friendly'),
('55552', '11112', 'not the best'),
('55553', '11113', 'improving'),
('55554', '11114', 'not improving'),
('55555', '11115', 'logest and strongest relationship'),
('55556', '11116', 'worst relatioship ever');

INSERT INTO currentSchedule VALUES
('2023-03-03', '9:00:00', '24:00:00', '11111'),
('2023-03-03', '10:00:00', '24:00:00', '11112'),
('2023-03-05', '9:00:00', '18:00:00', '11113'),
('2023-03-06', '11:00:00', '20:00:00', '11114'),
('2023-03-06', '11:00:00', '20:00:00', '11115'),
('2023-03-08', '12:00:00', '19:00:00', '11116');

INSERT INTO customerAccount VALUES
('113.67', '62.00', '2023-03-03', '18:12:00', '55551'),
('0.00', '20.00', '2023-03-03', '18:45:00', '55552'),
('20.11', '27.00', '2023-03-03', '18:58:00', '55553'),
('300.00', '41.00', '2023-03-03', '20:00:00', '55554'),
('0.40', '14.00', '2023-03-03', '21:00:00', '55555'),
('0.00', '13.00', '2023-03-02', '16:00:00', '55556');

INSERT INTO orders VALUES
('12.00', '50.00', '5 Burgers', '2023-03-03', '18:12:00', '18:30:00', '11111111', '55551'),
('5.00', '15.00', '1 Pizza', '2023-03-03', '18:45:00', '19:00:00', '11111112', '55552'),
('5.00', '22.00', '2 Taco', '2023-03-03', '18:58:00', '19:02:00', '11111113', '55553'),
('9.00', '32.00', '2 Peperoni Pizza', '2023-03-03', '20:00:00', '20:22:00', '11111114', '55554'),
('2.00', '12.00', '1 Cheeseburger', '2023-03-03', '21:00:00', '21:30:00', '111111115', '55555'),
('1.00', '12.00', 'Pasta', '2023-03-02', '16:00:00', '16:14:00', '11111116', '55556');

INSERT INTO menu VALUES
('Burger', '10.00', 'www.BurgerPlace.com'),
('Pizza', '15.00', 'www.PizzaPlace.com'),
('Taco', '11.00', 'www.TacoPlace.com'),
('Peperoni Pizza', '16.00', 'www.PizzaPlace.com'),
('Cheeseburger', '12.00', 'www.BurgerPlace.com'),
('Pasta', '12.00', 'www.PastaPlace.com');

