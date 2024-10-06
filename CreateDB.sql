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


CREATE TABLE DimState (
    StateID INT PRIMARY KEY IDENTITY(1,1),
    StateName VARCHAR(50) UNIQUE,
    StateCode INT UNIQUE
);

-- Tạo bảng DimCounty (chứa thông tin về các quận/huyện)
CREATE TABLE DimCounty (
    CountyID INT PRIMARY KEY IDENTITY(1,1),
    CountyName VARCHAR(50),
    StateID INT,
    CountyCode INT,
    CONSTRAINT FK_State FOREIGN KEY (StateID) REFERENCES DimState(StateID)
);

-- Tạo bảng DimDate (chứa thông tin về thời gian)
CREATE TABLE DimDate (
    DateID INT PRIMARY KEY IDENTITY(1,1),
    Date DATE,
    Year INT,
    Quarter INT,
    Month INT,
    Day INT
);

-- Tạo bảng DimSite (chứa thông tin về các địa điểm đo lường)
CREATE TABLE DimSite (
    SiteID INT PRIMARY KEY IDENTITY(1,1),
    DefiningParameter VARCHAR(10),
    DefiningSite VARCHAR(20),
    NumberOfSitesReporting INT
);

CREATE TABLE FactAQI (
    FactID INT PRIMARY KEY IDENTITY(1,1),
    CountyID INT,
    StateID INT,
    DateID INT,
    SiteID INT,
    AQI INT,
    Category VARCHAR(50),
    Created DATETIME,
    LastUpdated DATETIME,
    CONSTRAINT FK_County_FactAQI FOREIGN KEY (CountyID) REFERENCES DimCounty(CountyID),
    CONSTRAINT FK_State_FactAQI FOREIGN KEY (StateID) REFERENCES DimState(StateID),
    CONSTRAINT FK_Date_FactAQI FOREIGN KEY (DateID) REFERENCES DimDate(DateID),
    CONSTRAINT FK_Site_FactAQI FOREIGN KEY (SiteID) REFERENCES DimSite(SiteID)
);


SELECT TABLE_NAME 
FROM BI_THUCHANH_1.INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE'

-- drop table Stage_10_state_aqi_2021
-- drop table Stage_10_state_aqi_2022
-- drop table Stage_10_state_aqi_2023
-- drop table Stage_uscounties


select * from Stage_10_state_aqi_2021
select * from Stage_uscounties