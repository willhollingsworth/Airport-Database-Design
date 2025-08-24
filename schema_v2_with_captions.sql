CREATE DATABASE IF NOT EXISTS samsdb;
USE samsdb;

CREATE TABLE Country (
    CountryID INT PRIMARY KEY
);

CREATE TABLE Airline (
    AirlineID INT PRIMARY KEY,
    CountryID INT NOT NULL,
    CONSTRAINT fk_airline_country FOREIGN KEY (CountryID) REFERENCES Country(CountryID)
    -- CAPTION: is home to
);

CREATE TABLE AircraftManufacturer (
    ManufacturerID INT PRIMARY KEY
);

CREATE TABLE AircraftModel (
    ModelID INT PRIMARY KEY,
    ManufacturerID INT NOT NULL,
    CONSTRAINT fk_aircraftmodel_manufacturer FOREIGN KEY (ManufacturerID) REFERENCES AircraftManufacturer(ManufacturerID)
    -- CAPTION: produces
);

CREATE TABLE AircraftSubModel (
    AircraftSubModelID INT PRIMARY KEY,
    ModelID INT NOT NULL,
    EngineModelName VARCHAR(100) NOT NULL,
    AircraftCategoryID INT NOT NULL,
    CONSTRAINT fk_submodel_model FOREIGN KEY (ModelID) REFERENCES AircraftModel(ModelID),
    -- CAPTION: has
    CONSTRAINT fk_submodel_enginemodel FOREIGN KEY (EngineModelName) REFERENCES EngineModel(EngineModelName),
    -- CAPTION: uses
    CONSTRAINT fk_submodel_category FOREIGN KEY (AircraftCategoryID) REFERENCES AircraftCategory(AircraftCategoryID)
    -- CAPTION: is categorized as
);

CREATE TABLE EngineModel (
    EngineModelName VARCHAR(100) PRIMARY KEY
);

CREATE TABLE Engine (
    EngineNo INT PRIMARY KEY,
    EngineModelName VARCHAR(100) NOT NULL,
    AircraftID INT,
    CONSTRAINT fk_engine_enginemodel FOREIGN KEY (EngineModelName) REFERENCES EngineModel(EngineModelName),
    -- CAPTION: builds
    CONSTRAINT fk_engine_aircraft FOREIGN KEY (AircraftID) REFERENCES Aircraft(AircraftID)
    -- CAPTION: mounts
);

CREATE TABLE AircraftCategory (
    AircraftCategoryID INT PRIMARY KEY
);

CREATE TABLE PassengerCategory (
    AircraftCategoryID INT PRIMARY KEY,
    CONSTRAINT fk_passengercategory_category FOREIGN KEY (AircraftCategoryID) REFERENCES AircraftCategory(AircraftCategoryID)
    -- CAPTION: is a
);

CREATE TABLE CargoCategory (
    AircraftCategoryID INT PRIMARY KEY,
    CONSTRAINT fk_cargocategory_category FOREIGN KEY (AircraftCategoryID) REFERENCES AircraftCategory(AircraftCategoryID)
    -- CAPTION: is a
);

CREATE TABLE Aircraft (
    AircraftID INT PRIMARY KEY,
    AirlineID INT NOT NULL,
    AircraftSubModelID INT NOT NULL,
    CONSTRAINT fk_aircraft_airline FOREIGN KEY (AirlineID) REFERENCES Airline(AirlineID),
    -- CAPTION: owns
    CONSTRAINT fk_aircraft_submodel FOREIGN KEY (AircraftSubModelID) REFERENCES AircraftSubModel(AircraftSubModelID)
    -- CAPTION: is specification for
);

CREATE TABLE Technician (
    EmployeeID INT PRIMARY KEY,
    SupervisorID INT,
    CONSTRAINT fk_technician_supervisor FOREIGN KEY (SupervisorID) REFERENCES Technician(EmployeeID)
    -- CAPTION: supervises
);

CREATE TABLE Manager (
    EmployeeID INT PRIMARY KEY,
    CONSTRAINT fk_manager_technician FOREIGN KEY (EmployeeID) REFERENCES Technician(EmployeeID)
    -- CAPTION: is a
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
    -- CAPTION: consists of
);

CREATE TABLE TestEvent (
    TestEventID INT PRIMARY KEY,
    AircraftID INT NOT NULL,
    TestKindID INT NOT NULL,
    ManagerID INT NOT NULL,
    CONSTRAINT fk_testevent_aircraft FOREIGN KEY (AircraftID) REFERENCES Aircraft(AircraftID),
    -- CAPTION: books
    CONSTRAINT fk_testevent_testkind FOREIGN KEY (TestKindID) REFERENCES TestKind(TestKindID),
    -- CAPTION: is conducted by
    CONSTRAINT fk_testevent_manager FOREIGN KEY (ManagerID) REFERENCES Manager(EmployeeID)
    -- CAPTION: supervises
);

CREATE TABLE TechnicianAircraftModel (
    TechnicianID INT NOT NULL,
    AircraftModelID INT NOT NULL,
    PRIMARY KEY (TechnicianID, AircraftModelID),
    CONSTRAINT fk_techaircraftmodel_technician FOREIGN KEY (TechnicianID) REFERENCES Technician(EmployeeID),
    -- CAPTION: is certified for
    CONSTRAINT fk_techaircraftmodel_model FOREIGN KEY (AircraftModelID) REFERENCES AircraftModel(ModelID)
    -- CAPTION: is certified for
);

CREATE TABLE TechnicianTraining (
    TechnicianID INT NOT NULL,
    TrainingID INT NOT NULL,
    PRIMARY KEY (TechnicianID, TrainingID),
    CONSTRAINT fk_techtraining_technician FOREIGN KEY (TechnicianID) REFERENCES Technician(EmployeeID),
    -- CAPTION: is trained in
    CONSTRAINT fk_techtraining_training FOREIGN KEY (TrainingID) REFERENCES Training(TrainingID)
    -- CAPTION: is attended by
);

CREATE TABLE TestEventItem (
    TestEventID INT NOT NULL,
    ItemCode VARCHAR(50) NOT NULL,
    PRIMARY KEY (TestEventID, ItemCode),
    CONSTRAINT fk_testeventitem_event FOREIGN KEY (TestEventID) REFERENCES TestEvent(TestEventID),
    -- CAPTION: contains
    CONSTRAINT fk_testeventitem_item FOREIGN KEY (ItemCode) REFERENCES TestItem(ItemCode)
    -- CAPTION: is part of
);

CREATE TABLE TechnicianTestEventItem (
    TechnicianID INT NOT NULL,
    TestEventID INT NOT NULL,
    ItemCode VARCHAR(50) NOT NULL,
    PRIMARY KEY (TechnicianID, TestEventID, ItemCode),
    CONSTRAINT fk_techtesteventitem_technician FOREIGN KEY (TechnicianID) REFERENCES Technician(EmployeeID),
    -- CAPTION: performs
    CONSTRAINT fk_techtesteventitem_event FOREIGN KEY (TestEventID) REFERENCES TestEvent(TestEventID),
    -- CAPTION: on
    CONSTRAINT fk_techtesteventitem_item FOREIGN KEY (ItemCode) REFERENCES TestItem(ItemCode)
    -- CAPTION: for
);
