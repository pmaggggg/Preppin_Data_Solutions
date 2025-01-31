-- Preppin' Data 2023 Week 3
--For the transactions file:
--Filter the transactions to just look at DSB
--These will be transactions that contain DSB in the Transaction Code field
--Rename the values in the Online or In-person field, Online of the 1 values and In-Person for the 2 values
--Change the date to be the quarter
--Sum the transaction values for each quarter and for each Type of Transaction (Online or In-Person) 
--For the targets file:
--Pivot the quarterly targets so we have a row for each Type of Transaction and each Quarter 
-- Rename the fields
--Remove the 'Q' from the quarter field and make the data type numeric
--Join the two datasets together
--You may need more than one join clause!
--Remove unnecessary fields
--Calculate the Variance to Target for each row 

WITH CTE AS (
SELECT 
CASE
WHEN ONLINE_OR_IN_PERSON = 1 THEN 'Online'
WHEN ONLINE_OR_IN_PERSON = 2 THEN 'In-Person'
END AS ONLINEINPERSON,
DATE_PART('quarter',DATE(LEFT(transaction_date,10), 'dd/MM/yyyy')) AS QUARTER,
SUM(VALUE) AS VALUE
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK01
WHERE CONTAINS(TRANSACTION_CODE, 'DSB')
GROUP BY 
CASE
WHEN ONLINE_OR_IN_PERSON = 1 THEN 'Online'
WHEN ONLINE_OR_IN_PERSON = 2 THEN 'In-Person'
END,
DATE_PART('quarter',DATE(LEFT(transaction_date,10), 'dd/MM/yyyy'))
)

SELECT REPLACE(T.QUARTER, 'Q', ''):: INT AS QUARTER,
TARGET, 
ONLINE_OR_IN_PERSON,
V.VALUE,
V.VALUE - T.TARGET AS VARIANCE_TO_TARGET
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK03_TARGETS AS T
UNPIVOT(TARGET FOR QUARTER IN (Q1, Q2, Q3, Q4))
INNER JOIN CTE AS V ON T.ONLINE_OR_IN_PERSON =V.ONLINEINPERSON
AND
REPLACE(T.QUARTER, 'Q', ''):: INT = V.QUARTER