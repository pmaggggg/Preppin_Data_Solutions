Preppin Data 2023 Week 1

-- Input the data 
-- Split the Transaction Code to extract the letters at the start of the transaction code. These identify the bank who processes the transaction 
-- Rename the new field with the Bank code 'Bank'. 
-- Rename the values in the Online or In-person field, Online of the 1 values and In-Person for the 2 values. 
-- Change the date to be the day of the week
-- Different levels of detail are required in the outputs. You will need to sum up the values of the transactions in three ways (help):
-- 1. Total Values of Transactions by each bank
-- 2. Total Values by Bank, Day of the Week and Type of Transaction (Online or In-Person)
-- 3. Total Values by Bank and Customer Code

SELECT 
split_part(transaction_code,'-', 1) AS Bank,
CASE 
WHEN online_or_in_person = 1 THEN 'Online'
WHEN online_or_in_person = 2 THEN 'In-Person'
END AS OnlIP,
DAYNAME(DATE(LEFT(transaction_date, 10),'dd/mm/yyyy')) AS datey,
*
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK01;


SELECT SPLIT_PART(transaction_code,'-', 1) AS Bank,
SUM(value) AS Value
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK01
GROUP BY Bank;


SELECT SPLIT_PART(transaction_code,'-', 1) AS Bank,
CASE 
WHEN online_or_in_person = 1 THEN 'Online'
WHEN online_or_in_person = 2 THEN 'In-Person' END
AS OnlIP,
DAYNAME(DATE(LEFT(transaction_date, 10),'dd/mm/yyyy')) AS datey,
SUM(value)
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK01
GROUP BY Bank, OnlIP, datey;

SELECT SPLIT_PART(transaction_code,'-', 1) AS Bank,
customer_code,
SUM(value)
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK01
GROUP BY Bank, customer_code;