CREATE PROCEDURE dbo.sp_PopulateStarSchema
AS
BEGIN
    SET NOCOUNT ON;

    
    INSERT INTO dbo.DimProduct (ProductID, ProductType)
    SELECT DISTINCT p.ProductID, p.Type
    FROM dbo.stage_production p
    WHERE NOT EXISTS (
        SELECT 1 FROM dbo.DimProduct dp WHERE dp.ProductID = p.ProductID
    );

    
    TRUNCATE TABLE dbo.FactManufacturingOperations;

    
 Table
    INSERT INTO dbo.FactManufacturingOperations (
        UDI,
        ProductKey,
        AirTemperature_K,
        ProcessTemperature_K,
        RotationalSpeed_RPM,
        Torque_NM,
        ToolWear_Min,
        IsDefective,
        IsFailure,

        FailureType
    )
    SELECT 
        p.UDI,
        dp.ProductKey,
        p.AirTemperature_K,
        p.ProcessTemperature_K,
        p.RotationalSpeed_RPM,
        p.Torque_NM,
        q.ToolWear_Min,
        q.Target AS IsDefective,
        C
ASE WHEN m.FailureType <> 'No Failure' THEN 1 ELSE 0 END AS IsFailure,
        m.FailureType
    FROM dbo.stage_production p
    INNER JOIN dbo.DimProduct dp ON p.ProductID = dp.ProductID
    LEFT JOIN dbo.stage_quality q ON p.ProductID = q.ProductID
    
LEFT JOIN dbo.stage_maintenance m ON p.ProductID = m.ProductID;
END;
