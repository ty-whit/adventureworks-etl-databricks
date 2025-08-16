CREATE MATERIALIZED VIEW adventureworksdatawarehouse.default.dim_sales_territory
AS
-- dim_sales_territory
SELECT
  explode() AS sales_territory_key,
  -- NONE sales_territory_alternate_key,
  st.Name AS sales_territory_region,
  st.CountryRegionCode AS sales_territory_country,
  st.Group AS sales_territory_group
  -- NONE AS sales_territory_image
FROM 
  adventureworks.sales.salesterritory AS st
  JOIN adventureworks.person.countryregion AS cr ON cr.CountryRegionCode = st.CountryRegionCode