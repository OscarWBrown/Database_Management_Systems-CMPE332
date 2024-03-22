drop database if exists doordash;
create database doordash;
use doordash;

create table customerAccount(
    emailAddress varchar(100) not null,
    firstName varchar(100),
    lastName varchar(100),
    cellNum char(10),
    streetAddress varchar(100),
    city varchar(100),
    pc char(6),
    creditAmt decimal(6, 2),
    primary key (emailAddress));

create table foodOrder(
	orderDate date,
	orderID integer not null,
	totalPrice decimal(6,2),
	tip decimal(6, 2),
	primary key (orderID));

create table food (
	name varchar (100) not null,
	primary key (name));

create table restaurant(
	name varchar(100) not null,
	streetAddress varchar(100),
	city varchar(100),
	pc char(6),
	url varchar(200),
	primary key (name));

create table employee(
	ID integer not null,
	firstName varchar(100),
	lastName varchar(100),
	emailAddress varchar(100),
    restaurantName varchar(100) not null,
	primary key (ID),
    foreign key(restaurantName) references restaurant(name) on delete restrict);

create table manager(
	empid integer not null, 
    primary key (empid),
	foreign key (empid) references employee(ID) on delete cascade);

create table serverStaff(
	empid integer not null,
    primary key (empid),
	foreign key (empid) references employee(ID) on delete cascade);

create table chef(
	empid integer not null,  
    primary key (empid),
	foreign key (empid) references employee(ID) on delete cascade);

create table deliveryPerson(
	empid integer not null, 
    primary key (empid),
	foreign key (empid) references employee(ID) on delete cascade);

create table payment(
	customerEmail varchar(100) not null,
	dates date not null,
	paymentAmount decimal(6,2) not null,
	primary key (customerEmail, dates),
	foreign key (customerEmail) references customerAccount(emailAddress) on delete cascade);

create table shift(
	empID integer not null,
	days varchar(15) not null,
	startTime time not null,
	endTime time not null,
	primary key (empID, days),
	foreign key (empID) references employee(ID) on delete cascade);

create table chefCredentials (
	empID integer not null,
	cred varchar(30) not null,
	primary key (empID, cred),
	foreign key (empID) references employee(ID) on delete cascade);

create table orderPlacement(
	customerEmail varchar(100) not null,
	orderID integer not null,
	restaurant varchar(100) not null,
	orderTime time,
	primary key (customerEmail, orderID, restaurant),
	foreign key (customerEmail) references customerAccount(emailAddress) on delete cascade,
	foreign key (orderID) references foodOrder(orderID) on delete cascade,
	foreign key (restaurant) references restaurant(name) on delete cascade);

create table relatedTo(
	customer varchar(100) not null,
	employee integer not null,
	relationship varchar(100),
	primary key (customer, employee),
	foreign key (customer) references customerAccount(emailAddress) on delete cascade,
	foreign key (employee) references employee(ID) on delete cascade);

create table menu(
	restaurant varchar(100) not null,
	food varchar(100) not null,
	price decimal(6, 2),
	primary key (restaurant, food),
	foreign key (restaurant) references restaurant(name) on delete cascade,
	foreign key (food) references food (name) on delete cascade);

create table foodItemsinOrder(
	orderID integer not null,
	food varchar(100) not null,
	primary key (orderID),
	foreign key (orderID) references foodOrder(orderID) on delete cascade);
	# foreign key (food) references food(name) on delete cascade);

create table delivery(
	orderID integer not null,
	deliveryPerson integer not null,
	deliveryTime time,
	primary key (orderID, deliveryPerson),
	foreign key (orderID) references foodOrder(orderID) on delete cascade,
	foreign key (deliveryPerson) references employee(ID) on delete cascade);
    
create table worksAt(
	employeeID integer not null,
	restaurant varchar(100) not null,
	primary key (employeeID, restaurant),
	foreign key (employeeID) references employee(ID) on delete cascade,
	foreign key (restaurant) references restaurant(name) on delete cascade);
	
insert into customerAccount (emailAddress, firstName, lastName, cellNum, streetAddress, city, pc, creditAmt) values
('ob@gmail.com', 'Oscar', 'Brown', '9027176666', '333 Frontenac Street', 'Kingston', 'K7Y5G9', '10.00'), 
('hw@yahoo.com', 'Henry', 'Wilson', '9023334444', '444 Albert Street', 'Kingston', 'K9T6G6', '15.00'), 
('ms@outlook.com', 'Mila', 'Stosic', '6478889999', '555 Union Street', 'Kingston', 'B2T1E4', '0.00'), 
('eb@gmail.com', 'Euan', 'Brydie', '6475008000', '600 Alfred Street', 'Kingston', 'O3T4A4', '30.00'), 
('nl@gmail.com', 'Nick', 'Levy', '6477863452', '777 Princess Street', 'Kinsgton', 'F8T2S2', '100.00'),
('sl@yahoo.com', 'Sebastian', 'Lee', '7078804454', '888 University Avenue', 'Kingston', 'H0I5Y7', '0.00');

insert into foodOrder (orderDate, orderID, totalPrice, tip) values
('2023-04-08', '11111', '87.88', '10.00'),
('2023-04-07', '11112', '15.00', '2.00'),
('2023-04-07', '11113', '10.00', '3.00'),
('2023-04-07', '11114', '30.00', '5.00'),
('2023-04-05', '11115', '45.00', '7.00'),
('2023-04-05', '11116', '20.00', '4.00'), 
('2023-04-02', '11117', '20.00', '3.00');

insert into food (name) values
('Burger'),
('Nachos'),
('Burrito'), 
('Tacos'),
('Pizza'),
('Pasta'),
('Sandwich'),
('Water'), 
('Juice'), 
('Pop');

insert into restaurant (name, streetAddress, city, pc, url) values
('Mexican Place', '111 Frontenac Street', 'Kingston', 'B7B3T3', 'www.MexicanPlace.com'),
('Pizza Place', '222 Albert Street', 'Kinsgton', 'H6H0N0', 'www.PizzaPlace.com'),
('Burger Place', '303 Union Street', 'Kingston', 'U8G7R4', 'www.BurgerPlace.com'),
('Sandwich Place', '545 Alfred Street', 'Kingston', 'Y5T0G2', 'www.SandwichPlace.com');

insert into employee (ID, firstName, lastName, emailAddress, restaurantName) values
('111', 'Nate', 'Fergusson', 'nf@gmail.com', 'Pizza Place'), 
('112', 'Jack', 'Fergusson', 'jf@yahoo.com', 'Pizza Place'), 
('113', 'Jeremy', 'Harper', 'jh@gmail.com', 'Pizza Place'), 
('114', 'Robert', 'Rushton', 'rr@outlook.com', 'Pizza Place'),
('115', 'Stacey', 'Shane', 'ss@gmail.com', 'Mexican Place'), 
('116', 'Bella', 'Perin', 'bp@outlook.com', 'Mexican Place'), 
('117', 'Mathew', 'Mamelak', 'mm@gmail.com', 'Mexican Place'),
('118', 'Cole', 'Sanford', 'cs@gmail.com', 'Mexican Place'), 
('119', 'Shiv', 'Sood', 'sss@outlook.com', 'Burger Place'), 
('120', 'Dave', 'Laughton', 'dl@yahoo.com', 'Burger Place'), 
('121', 'Jackson', 'Cowie', 'jc@outlook.com', 'Burger Place'), 
('122', 'Cameron', 'Overvelde', 'co@gmail.com', 'Burger Place'), 
('123', 'Jarret', 'Crowell', 'jc@gmail.com', 'Sandwich Place'), 
('124', 'Keiran', 'Price', 'kp@gmail.com', 'Sandwich Place'), 
('125', 'Logan', 'Whynott', 'lw@yahoo.com', 'Sandwich Place'), 
('126', 'Tyler', 'Allison', 'ta@yahoo.com', 'Sandwich Place');

insert into manager (empid) values
('111'), 
('112'), 
('113'), 
('114');

insert into serverStaff (empid) values
('115'), 
('116'), 
('117'), 
('118');

insert into chef (empid) values
('119'), 
('120'), 
('121'), 
('122');

insert into deliveryPerson (empid) values
('123'), 
('124'), 
('125'), 
('126');

insert into payment (customerEmail, dates, paymentAmount) values
('ob@gmail.com', '2023-04-08', '97.88'),
('hw@yahoo.com', '2023-04-07', '17.00'), 
('ms@outlook.com', '2023-04-07', '13.00'), 
('eb@gmail.com', '2023-04-07', '35.00'),
('nl@gmail.com', '2023-04-05', '52.00'), 
('sl@yahoo.com', '2023-04-05', '24.00'), 
('ms@outlook.com', '2023-04-02', '23.00'); 

insert into shift (empID, days, startTime, endTime) values
('111', '2023-04-10', '12:00:00', '20:00:00'), 
('115', '2023-04-10', '13:00:00', '20:00:00'), 
('119', '2023-04-11', '12:00:00', '22:00:00'), 
('123', '2023-04-11', '12:00:00', '22:00:00'), 
('112', '2023-04-12', '16:00:00', '22:00:00'), 
('116', '2023-04-12', '15:00:00', '19:00:00'), 
('120', '2023-04-13', '14:00:00', '16:00:00'), 
('124', '2023-04-13', '15:00:00', '20:00:00'), 
('124', '2023-04-14', '10:00:00', '17:00:00'), 
('113', '2023-04-14', '12:00:00', '17:00:00'), 
('117', '2023-04-15', '15:00:00', '18:00:00'), 
('121', '2023-04-15', '11:00:00', '18:00:00'), 
('121', '2023-04-16', '11:00:00', '18:00:00'), 
('125', '2023-04-17', '13:00:00', '20:00:00'), 
('114', '2023-04-18', '13:00:00', '20:00:00'), 
('118', '2023-04-19', '12:00:00', '22:00:00'), 
('122', '2023-04-19', '12:00:00', '20:00:00'), 
('126', '2023-04-20', '12:00:00', '17:00:00');

insert into chefCredentials (empID, cred) values 
('119', 'MasterChef'),
('120', 'DecentChef'),
('121', 'MidChef'),
('122', 'BadChef');

insert into orderPlacement (customerEmail, orderID, restaurant, orderTime) values 
('ob@gmail.com', '11111', 'Burger Place', '20:00:00'),
('hw@yahoo.com', '11112', 'Pizza Place', '19:00:00'), 
('ms@outlook.com', '11113', 'Mexican Place', '18:00:00'), 
('eb@gmail.com', '11114', 'Mexican Place', '12:00:00'), 
('nl@gmail.com', '11115', 'Sandwich Place', '13:00:00'), 
('sl@yahoo.com', '11116', 'Sandwich Place', '14:00:00'),
('ms@outlook.com', '11117', 'Burger Place', '13:00:00');

insert into relatedTo (customer, employee, relationship) values 
('ob@gmail.com', '111', 'Very friendly');

insert into menu (restaurant, food, price) values 
('Burger Place', 'Burger', '10.00'),
('Pizza Place', 'Pizza', '20.00'), 
('Pizza Place', 'Pasta', '15.00'), 
('Mexican Place', 'Burrito', '10.00'),
('Mexican Place', 'Tacos', '10.00'),
('Mexican Place', 'Nachos', '10.00'),
('Sandwich Place', 'Sandwich', '10.00'), 
('Sandwich Place', 'Water', '1.00'),
('Burger Place', 'Pop', '2.00'), 
('Pizza Place', 'Juice', '2.50'); 

insert into foodItemsinOrder (orderID, food) values 
('11111', '8 x Burger'), 
('11112', '1 x Pasta'), 
('11113', '1 x Burrito'), 
('11114', '1 x Nacho, 1 x Tacos, 1 x Burrito'), 
('11115', '4 x Sandwich, 1 x Water'), 
('11116', '2 x Sandwich'), 
('11117', '1 x Burger, 2 x Pop');

insert into delivery (orderID, deliveryPerson, deliveryTime) values 
('11111', '123', '20:10:00'), 
('11112', '124', '19:10:00'), 
('11113', '125', '18:20:00'), 
('11114', '125', '12:20:00'), 
('11115', '126', '13:30:00'), 
('11116', '126', '14:10:00'), 
('11117', '123', '13:05:00');

insert into worksAt (employeeID, restaurant) values 
('111', 'Burger Place'), 
('112', 'Pizza Place'),
('113', 'Mexican Place'),
('114', 'Sandwich Place'),
('115', 'Burger Place'),
('116', 'Pizza Place'),
('117', 'Mexican Place'),
('118', 'Sandwich Place'),
('119', 'Burger Place'),
('120', 'Pizza Place'),
('121', 'Mexican Place'),
('122', 'Sandwich Place'),
('123', 'Burger Place'),
('124', 'Pizza Place'),
('125', 'Mexican Place'),
('126', 'Sandwich Place');