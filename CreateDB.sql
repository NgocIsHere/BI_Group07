CREATE DATABASE BI_THUCHANH_1;

CREATE TABLE Stage_10_state_aqi_2021 (
    -- Định nghĩa các cột với kiểu dữ liệu tương ứng từ file 10_state_aqi_2021.csv
	StateName VARCHAR(50),
    CountyName VARCHAR(50),
	StateCode INT,
	CountyCode INT,
	DateDate DATE,
	AQI INT,
	Category VARCHAR(100),
	DefiningParameter VARCHAR(10),
	DefiningSite VARCHAR(20),
	NumberOfSitesReporting INT,
	Created DATETIME,
	LastUpdated DATETIME
);

CREATE TABLE Stage_10_state_aqi_2022 (
    -- Định nghĩa các cột với kiểu dữ liệu tương ứng từ file 10_state_aqi_2022.csv
	StateName VARCHAR(50),
    CountyName VARCHAR(50),
	StateCode INT,
	CountyCode INT,
	DateDate DATE,
	AQI INT,
	Category VARCHAR(100),
	DefiningParameter VARCHAR(10),
	DefiningSite VARCHAR(20),
	NumberOfSitesReporting INT,
	Created DATETIME,
	LastUpdated DATETIME
);

CREATE TABLE Stage_10_state_aqi_2023 (
    -- Định nghĩa các cột với kiểu dữ liệu tương ứng từ file 10_state_aqi_2023.csv
	StateName VARCHAR(50),
    CountyName VARCHAR(50),
	StateCode INT,
	CountyCode INT,
	DateDate DATE,
	AQI INT,
	Category VARCHAR(100),
	DefiningParameter VARCHAR(10),
	DefiningSite VARCHAR(20),
	NumberOfSitesReporting INT,
	Created DATETIME,
	LastUpdated DATETIME
);

CREATE TABLE Stage_uscounties (
    -- Định nghĩa các cột với kiểu dữ liệu tương ứng từ file (2B)uscounties.csv
	County VARCHAR(50), -- CountyName của 3 bảng kia
	CountyAscii VARCHAR(50), 
	CountyFull VARCHAR(50),
	CountyFips INT,
	StateId VARCHAR(10),
	StateName VARCHAR(50),
	Lat FLOAT,
	Long FLOAT,
	Population INT
);


CREATE TABLE NDS_State (
    StateID VARCHAR(10) PRIMARY KEY,
    StateName VARCHAR(50) ,
    StateCode INT 
);

CREATE TABLE NDS_County (
    CountyID INT PRIMARY KEY IDENTITY(1,1),
    CountyName VARCHAR(50),
    StateID VARCHAR(10),
    CountyCode INT,
	CountyFull VARCHAR(50),
	CountyFips INT,
	Lat FLOAT,
	Long FLOAT,
	Population INT,
    CONSTRAINT FK_State_NDS_County FOREIGN KEY (StateID) REFERENCES NDS_State(StateID)
);

CREATE TABLE NDS_Time (
    TimeID INT PRIMARY KEY IDENTITY(1,1),
    Year INT,
    Quarter INT,
    Month INT,
    Day INT,
	DateDate DATE,
    DayLightSaving BIT
);

CREATE TABLE NDS_AQI (
    AQI_ID INT PRIMARY KEY IDENTITY(1,1),
    CountyID INT,
    TimeID INT,
    AQI INT,
    Category VARCHAR(100),
    DefiningParameter VARCHAR(10),
    DefiningSite VARCHAR(20),
    Color VARCHAR(20),
    DateDate DATE,
    CONSTRAINT FK_County_NDS_AQI FOREIGN KEY (CountyID) REFERENCES NDS_County(CountyID),
    CONSTRAINT FK_Time_NDS_AQI FOREIGN KEY (TimeID) REFERENCES NDS_Time(TimeID)
);

CREATE TABLE Metadata_AQI (
    AQI_ID INT PRIMARY KEY,       -- AQI_ID: ID liên kết với bản ghi trong NDS_AQI hoặc bảng AQI khác
    CET DATETIME,                 -- CET (Creation Time): Thời gian tạo bản ghi
    LSET DATETIME                  -- LSET (Last Update Time): Thời gian cập nhật bản ghi cuối cùng
);

CREATE TRIGGER trg_InsertMetadataAQI
ON NDS_AQI
AFTER INSERT
AS
BEGIN
    INSERT INTO Metadata_AQI (AQI_ID, CET, LSET)
    SELECT AQI_ID, GETDATE(), NULL
    FROM inserted;
END;

SELECT TABLE_NAME 
FROM BI_THUCHANH_1.INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE'

--drop table Stage_10_state_aqi_2021
--drop table Stage_10_state_aqi_2022
--drop table Stage_10_state_aqi_2023
--drop table Stage_uscounties
--drop table NDS_AQI
--drop table NDS_Time
--drop table NDS_County
--drop table NDS_State


select * from Stage_10_state_aqi_2021
select * from Stage_10_state_aqi_2022
select * from Stage_10_state_aqi_2023
select * from Stage_uscounties
select * from NDS_State
select * from NDS_County
select * from NDS_Time
SELECT * FROM NDS_AQI
select * from Metadata_AQI

--truncate table NDS_AQI
--truncate table Metadata_AQI