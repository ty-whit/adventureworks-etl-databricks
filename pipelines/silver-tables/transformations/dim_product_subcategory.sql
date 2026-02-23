-- Please edit the sample below

CREATE MATERIALIZED VIEW dim_product_subcategory AS
SELECT
    pickup_zip,
    fare_amount
FROM samples.nyctaxi.trips;