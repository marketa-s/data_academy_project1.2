/*
 * QUESTION 1
*/

SELECT
    DISTINCT t1.avg_payroll,
    t1.i_b_code,
    t1.year_x
FROM t_marketa_safrankova_project_sql_primary_final t1
WHERE 
    t1.year_x IN (2006, 2018)
ORDER BY
    t1.i_b_code,	
    t1.avg_payroll DESC,
    t1.year_x;
-- shows 2006 and 2018

SELECT
    year_x,
    industry_name,
    AVG(avg_payroll) AS average_payroll
FROM
    t_marketa_safrankova_project_sql_primary_final t1
GROUP BY
    year_x, industry_name
ORDER BY
    year_x, industry_name;
-- shows values for all years

SELECT
    t1.year_x,
    AVG(t1.avg_payroll) AS average_payroll,
    LAG(AVG(t1.avg_payroll)) OVER (ORDER BY t1.year_x) AS previous_year_avg_payroll
FROM
    t_marketa_safrankova_project_sql_primary_final t1
GROUP BY
    t1.year_x
ORDER BY
    t1.year_x;
-- shows averages for all industies combined while comparing them with previous values
   
SELECT
    t1.year_x,
    t1.industry_name,
    AVG(t1.avg_payroll) AS average_payroll,
    LAG(AVG(t1.avg_payroll)) OVER (PARTITION BY t1.industry_name ORDER BY t1.year_x) AS previous_year_avg_payroll
FROM
    t_marketa_safrankova_project_sql_primary_final t1
GROUP BY
    t1.year_x, t1.industry_name
ORDER BY
    t1.industry_name, t1.year_x;
-- distinguishes industries

SELECT
    t1.year_x,
    t1.industry_name,
    AVG(t1.avg_payroll) AS average_payroll,
    LAG(AVG(t1.avg_payroll)) OVER (PARTITION BY t1.industry_name ORDER BY t1.year_x) AS previous_year_avg_payroll,
    round((AVG(t1.avg_payroll) - LAG(AVG(t1.avg_payroll)) OVER (PARTITION BY t1.industry_name ORDER BY t1.year_x)) / (LAG(AVG(t1.avg_payroll)) OVER (PARTITION BY t1.industry_name ORDER BY t1.year_x)) * 100, 2) AS diff
FROM
    t_marketa_safrankova_project_sql_primary_final t1
GROUP BY
    t1.year_x, t1.industry_name
ORDER BY
    t1.industry_name, t1.year_x;
-- calculates the rise of payrolls in each industry in %

SELECT
    t1.year_x,
    t1.industry_name,
    AVG(t1.avg_payroll) AS average_payroll,
    LAG(AVG(t1.avg_payroll)) OVER (PARTITION BY t1.industry_name ORDER BY t1.year_x) AS previous_year_avg_payroll,
    round((AVG(t1.avg_payroll) - LAG(AVG(t1.avg_payroll)) OVER (PARTITION BY t1.industry_name ORDER BY t1.year_x)) / (LAG(AVG(t1.avg_payroll)) OVER (PARTITION BY t1.industry_name ORDER BY t1.year_x)) * 100, 2) AS diff,
    CASE
        WHEN (round((AVG(t1.avg_payroll) - LAG(AVG(t1.avg_payroll)) OVER (PARTITION BY t1.industry_name ORDER BY t1.year_x)) / (LAG(AVG(t1.avg_payroll)) OVER (PARTITION BY t1.industry_name ORDER BY t1.year_x)) * 100, 2)) > 0 THEN '1'
        ELSE '0'
    END AS 'payroll_rises'
FROM
    t_marketa_safrankova_project_sql_primary_final AS t1
GROUP BY
    t1.year_x, t1.industry_name
ORDER BY
    t1.industry_name, t1.year_x;
-- shows clearly whether the change of payroll is positive
