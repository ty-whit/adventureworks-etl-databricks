-- dim_employee
CREATE MATERIALIZED VIEW adventureworksdatawarehouse.default.dim_employee_silver AS 
SELECT  DISTINCT
  NULL AS employee_key,
  NULL AS parent_employee_key,
  e.NationalIDNumber AS employee_national_id_alternate_key,
  NULL AS parent_employee_national_id_alternate_key,
  NULL sales_territory_key, 
  p.FirstName AS first_name,
  p.LastName AS last_name,
  p.MiddleName AS middle_name,
  p.NameStyle AS name_style,
  p.Title AS title,
  e.HireDate, 
  e.BirthDate AS birth_date, 
  e.LoginID AS login_id,
  ea.EmailAddress,
  pp.PhoneNumber,
  e.MaritalStatus AS marital_status,
  -- AS emergency_contact_name,
  -- AS emergency_contact_phone,
  e.salariedFlag as salaried_flag,
  LAST(eph.PayFrequency) OVER (PARTITION BY p.businessentityid ORDER BY eph.RateChangeDate) AS pay_frequency,
  LAST(eph.Rate) OVER (PARTITION BY p.businessentityid ORDER BY eph.RateChangeDate) AS base_rate,
  e.VacationHours AS vacation_hours, 
  e.SickLeaveHours AS sick_leave_hours,
  e.CurrentFlag AS current_flag,
  case
    when p.PersonType = 'SP' then 1
    when p.PersonType = 'EM' then 0
  end AS sales_person_flag,
  LAST(d.Name) OVER (PARTITION BY p.businessentityid ORDER BY edh.StartDate) AS department_name,
  LAST(edh.StartDate) OVER (PARTITION BY p.businessentityid ORDER BY edh.StartDate) AS department_start_date,
  LAST(edh.EndDate) OVER (PARTITION BY p.businessentityid ORDER BY edh.StartDate) AS department_end_date
  -- e AS status
  -- AS employee_photo
FROM 
  adventureworks.person.person AS p
  JOIN adventureworks.person.emailaddress AS ea ON p.businessentityid = ea.businessentityid
  JOIN adventureworks.person.personphone AS pp ON p.businessentityid = pp.businessentityid
  JOIN adventureworks.humanresources.employee AS e ON p.businessentityid = e.EmployeeID
  JOIN adventureworks.humanresources.employeepayhistory AS eph ON p.businessentityid = eph.businessentityid 
  JOIN adventureworks.humanresources.employeedepartmenthistory AS edh ON p.businessentityid = edh.businessentityid
  JOIN adventureworks.humanresources.department AS d ON edh.DepartmentID = d.DepartmentID
WHERE p.PersonType in ('EM', 'SP')
limit 100;

