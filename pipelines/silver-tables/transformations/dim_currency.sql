CREATE MATERIALIZED VIEW adventureworksdatawarehouse.default.dim_currency AS 
SELECT
  row_number() over (ORDER BY CurrencyCode) as CurrencyKey,
  CurrencyCode as CurrencyAlternateKey,
  "name" AS CurrencyName
FROM 
  adventureworks.sales.currency