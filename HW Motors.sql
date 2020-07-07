CREATE TABLE `Address` ( 
						`line1` varchar(50) NOT NULL, 
						`line2` varchar(30) DEFAULT NULL, 
						`line3` varchar(30) DEFAULT NULL, 
						`city` varchar(58) NOT NULL, 
						`postcode` varchar(8) NOT NULL, 
						`isDriver` tinyint(1) DEFAULT NULL 
						) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Base` ( 
					`baseID` char(5) NOT NULL, 
					`name` varchar(20) NOT NULL, 
					`postcode` varchar(300) NOT NULL, 
					`line1` varchar(50) NOT NULL 
					) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Booking` ( 
						`ID` char(5) NOT NULL, 
						`driverID` varchar(7) NOT NULL, 
						`startDate` date NOT NULL, 
						`endDate` date NOT NULL, 
						`noOfDrivers` int(1) NOT NULL, 
						`insurance` varchar(10) NOT NULL, 
						`regNumber` char(7) NOT NULL, 
						`pricePerDay` double(6,2) NOT NULL, 
						`discount` tinyint(1) DEFAULT NULL, 
						`price` double(6,2) NOT NULL, 
						`duration` int(2) NOT NULL, 
						`baseID` char(5) NOT NULL 
						) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `CoDriver` ( 
						`dID` varchar(7) NOT NULL, 
						`mainDriver` varchar(7) NOT NULL 
						) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Customer` ( 
						`dID` varchar(7) DEFAULT NULL, 
						`email` varchar(80) NOT NULL, 
						`mobile` varchar(13) DEFAULT NULL, 
						`pass` varchar(32) NOT NULL 
						) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Driver` ( 
						`ID` varchar(7) NOT NULL, 
						`firstName` varchar(20) NOT NULL, 
						`surname` varchar(20) NOT NULL, 
						`license` varchar(16) NOT NULL, 
						`DOB` date NOT NULL, 
						`postcode` varchar(300) NOT NULL, 
						`line1` varchar(50) NOT NULL, 
						`Age` int(2) DEFAULT NULL 
						) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Model` ( 
						`name` char(30) NOT NULL, 
						`engineSize` int(10) NOT NULL, 
						`gearType` enum('M','A') NOT NULL, 
						`noOfSeats` tinyint(1) NOT NULL, 
						`value` double(7,2) NOT NULL, 
						`type` enum('C','V') NOT NULL, 
						`category` varchar(10) NOT NULL 
						) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Vehicle` ( 
						`regNumber` varchar(7) NOT NULL, 
						`baseID` char(5) NOT NULL, 
						`bookingID` varchar(7) NOT NULL, 
						`MOT` char(12) NOT NULL, 
						`pricePerDay` double(5,2) DEFAULT NULL, 
						`availability` tinyint(1) NOT NULL, 
						`modelName` varchar(30) NOT NULL 
						) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `Address` ADD PRIMARY KEY (`line1`,`postcode`);

ALTER TABLE `Base` ADD PRIMARY KEY (`baseID`), 
				   ADD KEY `line1` (`line1`,`postcode`);

ALTER TABLE `Booking` ADD PRIMARY KEY (`ID`), 
					  ADD KEY `driverID` (`driverID`), 
					  ADD KEY `regNumber` (`regNumber`), 
					  ADD KEY `baseID` (`baseID`), 
					  ADD KEY `Booking_Index` (`insurance`,`regNumber`) USING BTREE;

ALTER TABLE `CoDriver` ADD KEY `dID` (`dID`), 
					   ADD KEY `mainDriver` (`mainDriver`);

ALTER TABLE `Customer` ADD KEY `dID` (`dID`);

ALTER TABLE `Driver` ADD PRIMARY KEY (`ID`), 
					 ADD KEY `line1` (`line1`,`postcode`), 
					 ADD KEY `License_Index` (`license`);

ALTER TABLE `Model` ADD PRIMARY KEY (`name`), 
					ADD KEY `engine_Index` (`engineSize`,`gearType`), 
					ADD KEY `seats_Index` (`noOfSeats`);

ALTER TABLE `Vehicle` ADD PRIMARY KEY (`regNumber`), 
					  ADD KEY `baseID` (`baseID`), 
					  ADD KEY `bookingID` (`bookingID`), 
					  ADD KEY `Vehicle_Index` (`pricePerDay`) USING BTREE, 
					  ADD KEY `modelName` (`modelName`);

ALTER TABLE `Base` ADD CONSTRAINT `Base_ibfk_1` FOREIGN KEY (`line1`,`postcode`) REFERENCES `Address` (`line1`, `postcode`);

ALTER TABLE `Booking` ADD CONSTRAINT `Booking_ibfk_1` FOREIGN KEY (`driverID`) REFERENCES `Driver` (`ID`), 
					  ADD CONSTRAINT `Booking_ibfk_2` FOREIGN KEY (`baseID`) REFERENCES `Base` (`baseID`), 
					  ADD CONSTRAINT `Booking_ibfk_3` FOREIGN KEY (`regNumber`) REFERENCES `Vehicle` (`regNumber`);

ALTER TABLE `CoDriver` ADD CONSTRAINT `CoDriver_ibfk_1` FOREIGN KEY (`dID`) REFERENCES `Driver` (`ID`), 
					   ADD CONSTRAINT `CoDriver_ibfk_2` FOREIGN KEY (`mainDriver`) REFERENCES `Driver` (`ID`);

ALTER TABLE `Customer` ADD CONSTRAINT `Customer_ibfk_1` FOREIGN KEY (`dID`) REFERENCES `Driver` (`ID`);

ALTER TABLE `Driver` ADD CONSTRAINT `Driver_ibfk_1` FOREIGN KEY (`line1`,`postcode`) REFERENCES `Address` (`line1`, `postcode`);

ALTER TABLE `Vehicle` ADD CONSTRAINT `Vehicle_ibfk_1` FOREIGN KEY (`baseID`) REFERENCES `Base` (`baseID`), 
					  ADD CONSTRAINT `Vehicle_ibfk_2` FOREIGN KEY (`bookingID`) REFERENCES `Booking` (`ID`), 
					  ADD CONSTRAINT `Vehicle_ibfk_3` FOREIGN KEY (`modelName`) REFERENCES `Model` (`name`); COMMIT;


