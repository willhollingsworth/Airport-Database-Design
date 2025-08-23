
CREATE TABLE aircraft (
	id INTEGER NOT NULL AUTO_INCREMENT, 
	sub_model_id VARCHAR(255) NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(sub_model_id) REFERENCES aircraftsubmodel (id)
)

;


CREATE TABLE aircraftmodel (
	id VARCHAR(255) NOT NULL, 
	manufacturer_id INTEGER NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(manufacturer_id) REFERENCES manufacturer (id)
)

;


CREATE TABLE aircraftownership (
	aircraft_id INTEGER NOT NULL, 
	airline_id VARCHAR(255) NOT NULL, 
	PRIMARY KEY (aircraft_id, airline_id), 
	FOREIGN KEY(aircraft_id) REFERENCES aircraft (id), 
	FOREIGN KEY(airline_id) REFERENCES airline (id)
)

;


CREATE TABLE aircraftsubmodel (
	id VARCHAR(255) NOT NULL, 
	model_id VARCHAR(255) NOT NULL, 
	engine_model_name VARCHAR(255) NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(model_id) REFERENCES aircraftmodel (id), 
	FOREIGN KEY(engine_model_name) REFERENCES enginemodel (name)
)

;


CREATE TABLE airline (
	id VARCHAR(255) NOT NULL, 
	country_id INTEGER NOT NULL, 
	PRIMARY KEY (id), 
	FOREIGN KEY(country_id) REFERENCES country (id)
)

;


CREATE TABLE country (
	id INTEGER NOT NULL AUTO_INCREMENT, 
	PRIMARY KEY (id)
)

;


CREATE TABLE engine (
	id VARCHAR(255) NOT NULL, 
	engine_model_name VARCHAR(255) NOT NULL, 
	aircraft_id INTEGER, 
	PRIMARY KEY (id), 
	FOREIGN KEY(engine_model_name) REFERENCES enginemodel (name), 
	FOREIGN KEY(aircraft_id) REFERENCES aircraft (id)
)

;


CREATE TABLE enginemodel (
	name VARCHAR(255) NOT NULL, 
	PRIMARY KEY (name)
)

;


CREATE TABLE manufacturer (
	id INTEGER NOT NULL AUTO_INCREMENT, 
	PRIMARY KEY (id)
)

;

