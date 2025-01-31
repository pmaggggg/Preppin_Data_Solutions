-- Preppin' Data 2023 Week 2
--In the Transactions table, there is a Sort Code field which contains dashes. We need to remove these so just have a 6 digit string
--Use the SWIFT Bank Code lookup table to bring in additional information about the SWIFT code and Check Digits of the receiving bank account 
--Add a field for the Country Code
--Hint: all these transactions take place in the UK so the Country Code should be GB
--Create the IBAN as above
--Hint: watch out for trying to combine sting fields with numeric fields - check data types
--Remove unnecessary fields

SELECT transaction_id,
'GB' || CHECK_DIGITS || SWIFT_CODE || replace(sort_code, '-', '') || ACCOUNT_NUMBER AS IBAN
-- ACCOUNT_NUMBER, *, replace(sort_code, '-', '') AS SortCode, 'GB' AS Country_code,
-- CONCAT(COUNTRY_CODE, CHECK_DIGITS, SWIFT_CODE, SORTCODE, ACCOUNT_NUMBER) AS IBAN
FROM TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK02_TRANSACTIONS as T
INNER JOIN TIL_PLAYGROUND.PREPPIN_DATA_INPUTS.PD2023_WK02_SWIFT_CODES as S
ON S.BANK = T.BANK ;