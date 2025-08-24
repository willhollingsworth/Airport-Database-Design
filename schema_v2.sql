CREATE DATABASE IF NOT EXISTS samsdb;
USE samsdb;

CREATE TABLE Country (
    CountryID INT PRIMARY KEY
);

CREATE TABLE Airline (
    AirlineID INT PRIMARY KEY,
    CountryID INT NOT NULL,
    CONSTRAINT fk_airline_country FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
    );

CREATE TABLE AircraftManufacturer (
    ManufacturerID INT PRIMARY KEY
);

CREATE TABLE AircraftModel (
    ModelID INT PRIMARY KEY,
    ManufacturerID INT NOT NULL,
    CONSTRAINT fk_aircraftmodel_manufacturer FOREIGN KEY (ManufacturerID) REFERENCES AircraftManufacturer(ManufacturerID)
    );

CREATE TABLE AircraftSubModel (
    AircraftSubModelID INT PRIMARY KEY,
    ModelID INT NOT NULL,
    EngineModelName VARCHAR(100) NOT NULL,
    AircraftCategoryID INT NOT NULL,
    CONSTRAINT fk_submodel_model FOREIGN KEY (ModelID) REFERENCES AircraftModel(ModelID),
    CONSTRAINT fk_submodel_enginemodel FOREIGN KEY (EngineModelName) REFERENCES EngineModel(EngineModelName),
    CONSTRAINT fk_submodel_category FOREIGN KEY (AircraftCategoryID) REFERENCES AircraftCategory(AircraftCategoryID)
    );

CREATE TABLE EngineModel (
    EngineModelName VARCHAR(100) PRIMARY KEY
);

CREATE TABLE Engine (
    EngineNo INT PRIMARY KEY,
    EngineModelName VARCHAR(100) NOT NULL,
    AircraftID INT,
    CONSTRAINT fk_engine_enginemodel FOREIGN KEY (EngineModelName) REFERENCES EngineModel(EngineModelName),
    CONSTRAINT fk_engine_aircraft FOREIGN KEY (AircraftID) REFERENCES Aircraft(AircraftID)
    );

CREATE TABLE AircraftCategory (
    AircraftCategoryID INT PRIMARY KEY
);

CREATE TABLE PassengerCategory (
    AircraftCategoryID INT PRIMARY KEY,
    CONSTRAINT fk_passengercategory_category FOREIGN KEY (AircraftCategoryID) REFERENCES AircraftCategory(AircraftCategoryID)
);

CREATE TABLE CargoCategory (
    AircraftCategoryID INT PRIMARY KEY,
    CONSTRAINT fk_cargocategory_category FOREIGN KEY (AircraftCategoryID) REFERENCES AircraftCategory(AircraftCategoryID)
);

CREATE TABLE Aircraft (
    AircraftID INT PRIMARY KEY,
    AirlineID INT NOT NULL,
    AircraftSubModelID INT NOT NULL,
    CONSTRAINT fk_aircraft_airline FOREIGN KEY (AirlineID) REFERENCES Airline(AirlineID),
    CONSTRAINT fk_aircraft_submodel FOREIGN KEY (AircraftSubModelID) REFERENCES AircraftSubModel(AircraftSubModelID)
    );

CREATE TABLE Technician (
    EmployeeID INT PRIMARY KEY,
    SupervisorID INT,
    CONSTRAINT fk_technician_supervisor FOREIGN KEY (SupervisorID) REFERENCES Technician(EmployeeID)
    );

CREATE TABLE Manager (
    EmployeeID INT PRIMARY KEY,
    CONSTRAINT fk_manager_technician FOREIGN KEY (EmployeeID) REFERENCES Technician(EmployeeID)
    );

CREATE TABLE Training (
    TrainingID INT PRIMARY KEY
);

CREATE TABLE TestKind (
    TestKindID INT PRIMARY KEY
);

CREATE TABLE TestItem (
    ItemCode VARCHAR(50) PRIMARY KEY,
    TestKindID INT NOT NULL,
    CONSTRAINT fk_testitem_testkind FOREIGN KEY (TestKindID) REFERENCES TestKind(TestKindID)
    );

CREATE TABLE TestEvent (
    TestEventID INT PRIMARY KEY,
    AircraftID INT NOT NULL,
    TestKindID INT NOT NULL,
    ManagerID INT NOT NULL,
    CONSTRAINT fk_testevent_aircraft FOREIGN KEY (AircraftID) REFERENCES Aircraft(AircraftID),
    CONSTRAINT fk_testevent_testkind FOREIGN KEY (TestKindID) REFERENCES TestKind(TestKindID),
    CONSTRAINT fk_testevent_manager FOREIGN KEY (ManagerID) REFERENCES Manager(EmployeeID)
    );

CREATE TABLE TechnicianAircraftModel (
    TechnicianID INT NOT NULL,
    AircraftModelID INT NOT NULL,
    PRIMARY KEY (TechnicianID, AircraftModelID),
    CONSTRAINT fk_techaircraftmodel_technician FOREIGN KEY (TechnicianID) REFERENCES Technician(EmployeeID),
    CONSTRAINT fk_techaircraftmodel_model FOREIGN KEY (AircraftModelID) REFERENCES AircraftModel(ModelID)
);

CREATE TABLE TechnicianTraining (
    TechnicianID INT NOT NULL,
    TrainingID INT NOT NULL,
    PRIMARY KEY (TechnicianID, TrainingID),
    CONSTRAINT fk_techtraining_technician FOREIGN KEY (TechnicianID) REFERENCES Technician(EmployeeID),
    CONSTRAINT fk_techtraining_training FOREIGN KEY (TrainingID) REFERENCES Training(TrainingID)
);

CREATE TABLE TestEventItem (
    TestEventID INT NOT NULL,
    ItemCode VARCHAR(50) NOT NULL,
    PRIMARY KEY (TestEventID, ItemCode),
    CONSTRAINT fk_testeventitem_event FOREIGN KEY (TestEventID) REFERENCES TestEvent(TestEventID),
    CONSTRAINT fk_testeventitem_item FOREIGN KEY (ItemCode) REFERENCES TestItem(ItemCode)
);

CREATE TABLE TechnicianTestEventItem (
    TechnicianID INT NOT NULL,
    TestEventID INT NOT NULL,
    ItemCode VARCHAR(50) NOT NULL,
    PRIMARY KEY (TechnicianID, TestEventID, ItemCode),
    CONSTRAINT fk_techtesteventitem_technician FOREIGN KEY (TechnicianID) REFERENCES Technician(EmployeeID),
    CONSTRAINT fk_techtesteventitem_event FOREIGN KEY (TestEventID) REFERENCES TestEvent(TestEventID),
    CONSTRAINT fk_techtesteventitem_item FOREIGN KEY (ItemCode) REFERENCES TestItem(ItemCode)
);
