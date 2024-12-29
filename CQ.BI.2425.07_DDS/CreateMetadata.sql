--CREATE DATABASE METADATA_BI

USE METADATA_BI
-- Table for Source to Stage metadata
CREATE TABLE SourceToStage_Metadata (
    SourceName VARCHAR(255) NOT NULL,
    SourceType VARCHAR(255) NOT NULL,
    ExtractionTime DATETIME NOT NULL,
    RowCountSource INT NOT NULL,
    LoadTimestamp DATETIME NOT NULL,
    RowCountStage INT NOT NULL,
    ErrorCount INT DEFAULT 0,
    Status VARCHAR(50) NOT NULL
);

-- Table for Stage to NDS metadata
CREATE TABLE StageToNDS_Metadata (
    StageTableName VARCHAR(255) NOT NULL,
    RowCountStage INT NOT NULL,
    LoadTimestamp DATETIME NOT NULL,
    ColumnMapping TEXT NOT NULL,
    Transformation TEXT NOT NULL,
    ErrorCount INT DEFAULT 0,
    Status VARCHAR(50) NOT NULL
);

-- Table for NDS to DDS metadata
CREATE TABLE NDSToDDS_Metadata (
    NDSTableName VARCHAR(255) NOT NULL,
    RowCountNDS INT NOT NULL,
    LoadTimestamp DATETIME NOT NULL,
    AggregationRules TEXT NOT NULL,
    DimensionRules TEXT NOT NULL,
    SCDType VARCHAR(50) NOT NULL,
    ErrorCount INT DEFAULT 0,
    Status VARCHAR(50) NOT NULL
);

select * from SourceToStage_Metadata