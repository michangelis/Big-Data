--Q1

SELECT  
    SUM(input.Amount) AS TotalAmount  
INTO 
    [output]
FROM  
    [input]
WHERE
    input.Type = 0 AND
    input.ATMCode = 21
GROUP BY SlidingWindow(minute, 10)  

--Q2

SELECT 
    SUM(Amount) as TotalAmount 
INTO
    [output]
FROM 
    [input] 
WHERE 
    input.Type = 1 AND input.ATMCode = 21 
GROUP BY 
    TumblingWindow(hour, 1)

--Q3

SELECT 
    SUM(Amount) as TotalAmount
INTO
    [output]
FROM 
    [input]
WHERE
    Type = 1 AND ATMCode = 21
GROUP BY 
    HoppingWindow(Duration(hour, 1), hop(minute, 30))


--Q4

SELECT
    ATMCode,
    SUM([Amount]) AS TotalAmountPerATM
INTO
    [output]
FROM
    [input]
WHERE 
    [Type] = 1
GROUP BY
   [ATMCode], SlidingWindow(hour, 1)


 --Q5

 SELECT
    atm.area_code,
    SUM(input.Amount) as SumPerArea
INTO 
    [output]
FROM 
    [input]
JOIN 
    [atm]
ON input.ATMCode = atm.atm_code
JOIN
    [customer]
ON
    input.CardNumber = customer.card_number
WHERE 
    input.Type = 1
GROUP BY atm.area_code, TumblingWindow(hour, 1)

--Q6

SELECT
    customer.gender AS CustomerGender, 
    area.area_city AS AreaCity,
    SUM(input.Amount) as SumPerGenderArea
INTO 
    [output]
FROM 
    [input]
JOIN 
    [atm]
ON input.ATMCode = atm.atm_code
JOIN 
    [customer]
ON input.CardNumber = customer.card_number
JOIN 
    [area]
ON area.area_code = atm.area_code
GROUP BY customer.gender, area.area_city, TumblingWindow(hour, 1)

--Q7

SELECT 
    '1' as Alert,
    input.CardNumber
INTO 
    [output]
FROM 
    [input]
JOIN 
    [customer]
ON input.CardNumber = customer.card_number
WHERE input.Type = 1
GROUP BY 
    input.CardNumber, SlidingWindow(hour, 1)
HAVING
    COUNT(*) >= 2
--Q8

SELECT
    '1' AS Alert,
    COUNT(*) AS MismatchCount,
    customer.card_number
INTO
    [output]
FROM
    [input]
JOIN 
    [atm]
ON input.ATMCode = atm.atm_code
JOIN 
    [customer]
ON input.CardNumber = customer.card_number
WHERE
    atm.area_code <> customer.area_code
GROUP BY 
    customer.card_number,
    SlidingWindow(minute, 60)

