-- Please edit the sample below

CREATE MATERIALIZED VIEW dim_sales_reason AS
SELECT
    pickup_zip,
    fare_amount
FROM samples.nyctaxi.trips;