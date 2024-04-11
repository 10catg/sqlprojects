
SELECT 
    education, 
    AVG(principal) AS Avg_Principal,
    AVG(age) AS Avg_Age,
    COUNT(CASE WHEN loan_status = 'PAIDOFF' THEN 1 END) AS PaidOff,
    COUNT(CASE WHEN loan_status != 'PAIDOFF' THEN 1 END) AS NotPaidOff
FROM 
    loandata
GROUP BY 
    education;
