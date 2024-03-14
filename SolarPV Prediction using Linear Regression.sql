--This sql project is to get predictions of solar pv power output using linear regression

-- Check correlation between variable
SELECT
  CORR(Output, ALLSKY_SFC_LW_DWN) AS longwave_correlation,
  CORR(Output, ALLSKY_SFC_SW_DWN) AS shortwave_correlation,
  CORR(Output, T2M) AS temperature_correlation
FROM `authentic-idea-414103.mydataset.solar_data`;

-- Create Linear Regression Model
CREATE OR REPLACE MODEL `mydataset.regression_model`
OPTIONS
  (model_type='linear_reg',
  input_label_cols=['Output']) AS
SELECT *
FROM `authentic-idea-414103.mydataset.solar_data`
WHERE Output IS NOT NULL;

-- Evaluate Model
SELECT *
FROM ML.EVALUATE(MODEL `mydataset.regression_model`,
    (SELECT *
    FROM `authentic-idea-414103.mydataset.solar_data`
    WHERE Output IS NOT NULL));

-- Predict Future Solar PV Output
SELECT
  *
FROM
  ML.PREDICT(MODEL `mydataset.regression_model`,
    (SELECT*
    FROM `authentic-idea-414103.mydataset.solar_data`
    WHERE Output IS NOT NULL));

-- Prediction result explanation
SELECT *
FROM ML.EXPLAIN_PREDICT(MODEL `mydataset.regression_model`,
  (SELECT *
  FROM `authentic-idea-414103.mydataset.solar_data`
  WHERE Output IS NOT NULL),
  STRUCT(3 as top_k_features));


--Globally result explanation
#standardSQL
CREATE OR REPLACE MODEL `mydataset.regression_model`
  OPTIONS (
    model_type = 'linear_reg',
    input_label_cols = ['Output'],
    enable_global_explain = TRUE)
AS
SELECT *
FROM`authentic-idea-414103.mydataset.solar_data`
WHERE Output IS NOT NULL;

-- View explanation
SELECT *
FROM ML.GLOBAL_EXPLAIN(MODEL `mydataset.regression_model`)
