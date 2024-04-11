-- Basic metrics for dashboard grouped by loan status
SELECT 
    loan_status,
    COUNT(*) AS LoanCount,
    AVG(Principal) AS AvgPrincipal,
    AVG(past_due_days) AS AvgPastDueDays
FROM 
    LOANDATA
GROUP BY 
    loan_status;



-- Simple risk assessment model based on age and past_due_days
SELECT 
    Loan_ID,
    CASE 
        WHEN age < 25 THEN 'High Risk'
        WHEN past_due_days > 30 THEN 'High Risk'
        ELSE 'Low Risk' 
    END AS RiskLevel
FROM 
    LOANDATA;




-- prepping dataset for predictive analysis, 'PAIDOFF' set as nondefault, all other statuses set to default.
SELECT 
    Loan_ID, 
    Principal, 
    terms, 
    age, 
    education, 
    Gender,
    CASE 
        WHEN loan_status = 'PAIDOFF' THEN 0 
        ELSE 1 
    END AS DefaultIndicator
FROM 
    LOANDATA;




-- optimize loan collection strategy: given past due days will result in either email or call 
SELECT 
    CASE 
        WHEN past_due_days BETWEEN 1 AND 30 THEN 'Contact via Email'
        WHEN past_due_days BETWEEN 31 AND 60 THEN 'Contact via Phone Call'
        ELSE 'Legal Action' 
    END AS CollectionStrategy,
    COUNT(*) AS NumberOfLoans
FROM 
    LOANDATA
WHERE 
    loan_status != 'PAIDOFF'
GROUP BY 
    CASE 
        WHEN past_due_days BETWEEN 1 AND 30 THEN 'Contact via Email'
        WHEN past_due_days BETWEEN 31 AND 60 THEN 'Contact via Phone Call'
        ELSE 'Legal Action' 
    END;





-- Counts # of loans issued and paid off by the week
SELECT 
    DATEPART(week, effective_date) AS WeekNumber,
    COUNT(*) AS LoansIssued,
    SUM(CASE WHEN loan_status = 'PAIDOFF' THEN 1 ELSE 0 END) AS LoansPaidOff
FROM 
    LOANDATA
GROUP BY 
    DATEPART(week, effective_date);



