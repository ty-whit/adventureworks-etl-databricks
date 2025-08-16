-- dim_customer
CREATE MATERIALIZED VIEW adventureworksdatawarehouse.default.dim_customer_silver AS 
SELECT
  row_number() OVER (ORDER BY LastName, FirstName)
  Title, 
  FirstName,
  MiddleName,
  LastName,
  NameStyle,
  -- as Birth,
  -- as MaritalStatus,
  Suffix, 
  -- as Gender
  ea.EmailAddress as EmailAddress,
  -- totalChildren,
  -- NumberChildrenAtHome,
  -- EnglishEducation,
  -- SpanishEducation,
  -- FrenchEducation,
  -- EnglishOccupation,
  -- SpanishOccupation,
  -- FrenchOccupation,
  -- HouseOwnerFlag,
  -- NumberCarsOwned,
  -- AddressLine1,
  -- AddressLine2, 
  -- Phone,
  -- DateFirstPurchase,
  concat(
    -- CASE 
    --   WHEN "column" BETWEEN 0 AND 1 THEN '0-1'
    --   WHEN "column" BETWEEN 1 AND 2 THEN '1-2'
    --   WHEN "column" BETWEEN 2 AND 5 THEN '2-5'
    --   WHEN "column" BETWEEN 5 AND 10 THEN '5-10'
    --   ELSE '10+'
    -- END,
    " Miles"
  ) AS CommuteDistance
FROM 
  adventureworks.person.person AS p
  JOIN adventureworks.person.emailaddress AS ea ON p.BusinessEntityID = ea.BusinessEntityID
ORDER BY
  LastName, FirstName