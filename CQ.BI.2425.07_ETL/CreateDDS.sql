--DROP DATABASE AQI_Analysis;
--use master
--CREATE DATABASE AQI_Analysis;

USE AQI_Analysis;

-- Dimension: State
CREATE TABLE Dim_State (
    StateID VARCHAR(10) PRIMARY KEY,
    StateName VARCHAR(50),
    StateCode INT
);

-- Dimension: County
CREATE TABLE Dim_County (
    CountyID INT PRIMARY KEY ,
    CountyName VARCHAR(50),
    StateID VARCHAR(10),
    CountyCode INT,
    CountyFull VARCHAR(50),
    CountyFips INT,
    Lat FLOAT,
    Long FLOAT,
    Population INT,
    CONSTRAINT FK_State_Dim_County FOREIGN KEY (StateID) REFERENCES Dim_State(StateID)
);

-- Dimension: Time
CREATE TABLE Dim_Time (
    TimeID INT PRIMARY KEY ,
    Year INT,
    Quarter INT,
    Month INT,
    Day INT,
    DateDate DATE,
    DayLightSaving BIT
);

---- Dimension: AQI Category
--CREATE TABLE Dim_AQI_Category (
--    AQI_CategoryID INT PRIMARY KEY,
--    CategoryName VARCHAR(50),
--    MinAQI INT,
--    MaxAQI INT
--);

-- Fact Table: AQI
CREATE TABLE Fact_AQI (
    AQI_ID INT PRIMARY KEY,
    --StateID VARCHAR(10),
    CountyID INT,
    TimeID INT,
    AQI_Value INT,
    Category VARCHAR(100),
    DefiningParameter VARCHAR(10),
    DefiningSite VARCHAR(20),
    Color VARCHAR(20),
    --CONSTRAINT FK_State_Fact_AQI FOREIGN KEY (StateID) REFERENCES Dim_State(StateID),
    CONSTRAINT FK_County_Fact_AQI FOREIGN KEY (CountyID) REFERENCES Dim_County(CountyID),
    CONSTRAINT FK_Time_Fact_AQI FOREIGN KEY (TimeID) REFERENCES Dim_Time(TimeID),
);
