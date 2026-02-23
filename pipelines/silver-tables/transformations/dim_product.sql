-- Please edit the sample below

CREATE MATERIALIZED VIEW adventureworks_warehouse.default.dim_product AS
SELECT
    ProductID, 
    product.ProductSubcategoryID AS ProductSubcategoryKey,
    product.WeightUnitMeasureCode,
    product.SizeUnitMEasureCode,
    product.Name AS EnglishProductName,
    -- SpanishProductName,
    -- FrenchProductName,
    product.StandardCost,
    product.FinishedGoodsFlag,
    product.Color, 
    product.SafetyStockLevel, 
    product.ReorderPoint, 
    product.ListPrice, 
    product.Size,
    -- SizeRange, 
    product.Weight, 
    product.DaysToManufacture,
    product.ProductLine, 
    -- DealerPrice, 
    product.Class,
    product.Style,
    -- ModelName, 
    -- LargePhoto, 
    -- EnglishDescription, 
    -- FrenchDescription, 
    -- ChineseDescription, 
    -- AribicDescription, 
    -- HebrewDescription, 
    -- ThaiDescription, 
    -- GermanDescription, 
    -- JapaneseDescription, 
    -- TurkishDescription, 
    productlistpricehistory.StartDate AS StartDate, 
    productlistpricehistory.EndDate AS EndDate, 
    iff(enddate is not null AND current_date() between startdate and enddate, 'Current', 'Historical') AS Status
FROM 
    production.product
    LEFT JOIN production.productsubcategory
        ON production.product.ProductSubcategoryID = production.productsubcategory.ProductSubcategoryID
    LEFT JOIN production.productlistpricehistory
        ON production.product.ProductID = production.productlistpricehistory.ProductID
