DELETE FROM claim_dataset
WHERE claim_status IS NULL;

SELECT *
FROM claim_dataset
WHERE claim_status IS NOT NULL;
