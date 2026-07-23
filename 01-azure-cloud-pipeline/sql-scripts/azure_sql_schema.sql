CREATE TABLE dbo.stage_quality (
    UDI INT PRIMARY KEY,
    ProductID VARCHAR(20),
    Type VARCHAR(10),
    Target INT,
    FailureType VARCHAR(50)
);

CREATE TABLE dbo.stage_production (
    UDI INT PRIMARY KEY,
    AirTemperature_K FLOAT,
    ProcessTemperature_K FLOAT,
    RotationalSpeed_RPM INT,
    Torque_Nm FLOAT
);

CREATE TABLE dbo.stage_maintenance (
    UDI INT PRIMARY KEY,
    ToolWear_Min INT
);
GO


CREATE TABLE dbo.DimProduct (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    ProductID VARCHAR(20) NOT NULL,
    ProductType VARCHAR(10) NOT NULL
);
GO


CREATE TABLE dbo.FactManufacturingOperations (
    OperationKey INT IDENTITY(1,1) PRIMARY KEY,
    UDI INT NOT NULL,
    ProductKey INT NOT NULL,
    AirTemperature_K FLOAT,
    ProcessTemperature_K FLOAT,
    RotationalSpeed_RPM INT,
    Torque_Nm FLOAT,
    ToolWear_Min INT,
    Target INT,
    FailureType VARCHAR(50),
    CONSTRAINT FK_Fact_DimProduct FOREIGN KEY (ProductKey) REFERENCES dbo.DimProduct(ProductKey)
);
GO
