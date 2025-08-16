CREATE MATERIALIZED VIEW dim_date AS 
SELECT
  row_number() OVER (ORDER BY date) as date_key,
  date AS full_date_alternate_key,
  DAYOFWEEK(date) AS DayNumberOfWeek,
  date_format(date, 'EEEE') AS EnglishDayNameOfWeek,
  CASE DAYOFWEEK(date)
    WHEN 1 THEN 'Domingo'
    WHEN 2 THEN 'Lunes'
    WHEN 3 THEN 'Martes'
    WHEN 4 THEN 'Miércoles'
    WHEN 5 THEN 'Jueves'
    WHEN 6 THEN 'Viernes'
    WHEN 7 THEN 'Sábado'
  END AS SpanishDayNameOfWeek,
  CASE DAYOFWEEK(date)
    WHEN 1 THEN 'Dimanche'
    WHEN 2 THEN 'Lundi'
    WHEN 3 THEN 'Mardi'
    WHEN 4 THEN 'Mercredi'
    WHEN 5 THEN 'Jeudi'
    WHEN 6 THEN 'Vendredi'
    WHEN 7 THEN 'Samedi'
  END AS FrenchDayNameOfWeek,
  DAY(date) AS DayNumberOfMonth,
  DAYOFYEAR(date) AS DayNumberOfYear,
  WEEKOFYEAR(date) AS WeekNumberOfYear,
  date_format(date, 'MMMM') AS EnglishMonthName,
  CASE MONTH(date)
    WHEN 1 THEN 'Enero'
    WHEN 2 THEN 'Febrero'
    WHEN 3 THEN 'Marzo'
    WHEN 4 THEN 'Abril'
    WHEN 5 THEN 'Mayo'
    WHEN 6 THEN 'Junio'
    WHEN 7 THEN 'Julio'
    WHEN 8 THEN 'Agosto'
    WHEN 9 THEN 'Septiembre'
    WHEN 10 THEN 'Octubre'
    WHEN 11 THEN 'Noviembre'
    WHEN 12 THEN 'Diciembre'
  END AS SpanishMonthName,
  CASE MONTH(date)
    WHEN 1 THEN 'Janvier'
    WHEN 2 THEN 'Février'
    WHEN 3 THEN 'Mars'
    WHEN 4 THEN 'Avril'
    WHEN 5 THEN 'Mai'
    WHEN 6 THEN 'Juin'
    WHEN 7 THEN 'Juillet'
    WHEN 8 THEN 'Août'
    WHEN 9 THEN 'Septembre'
    WHEN 10 THEN 'Octobre'
    WHEN 11 THEN 'Novembre'
    WHEN 12 THEN 'Décembre'
  END AS FrenchMonthName,
  MONTH(date) AS MonthNumberOfYear,
  QUARTER(date) AS CalendarQuarter,
  YEAR(date) AS CalendarYear,
  CASE WHEN MONTH(date) <= 6 THEN 1 ELSE 2 END AS CalendarSemester,
  QUARTER(date) AS FiscalQuarter,
  YEAR(date) AS FiscalYear,
  CASE WHEN QUARTER(date) IN (1,2) THEN 1 ELSE 2 END AS FiscalSemester
FROM (
  SELECT sequence(to_date('2000-01-01'), to_date('2030-12-31'), interval 1 day) AS date_seq
) AS seq
LATERAL VIEW explode(date_seq) AS date