UPDATE loandata
SET Gender = CASE
    WHEN Gender = 'male' THEN 'Male'
    WHEN Gender = 'female' THEN 'Female'
    ELSE Gender
END,
education = CASE
    WHEN education = 'Bechalor' THEN 'Bachelor'
    ELSE education
END;


select * from loandata;