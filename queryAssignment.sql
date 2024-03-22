-- 1
SELECT FName, LName, SSN 
FROM Employee
WHERE Salary = (SELECT MIN(Salary) 
	FROM Employee);

-- 2
SELECT DISTINCT e.FName, e.LName 
FROM Employee e 
INNER JOIN Dependent d1 ON e.SSN = d1.ESSN AND d1.Relationship = 'SPOUSE' 
INNER JOIN Dependent d2 ON e.SSN = d2.ESSN AND d2.Relationship = 'DAUGHTER';

-- 3
SELECT FName, LName, PName
FROM Employee NATURAL JOIN Project 
	NATURAL JOIN Works_On
WHERE SSN = ESSN 
	AND PNo = PNumber
	AND LName IN ('Wong', 'Borg', 'English');
	
-- 4
SELECT FName, LName, MGRSSN, Salary
FROM Employee NATURAL JOIN Department 
WHERE SSN = MGRSSN
	AND Sex = 'M'
	AND Salary > 30000;
	
-- 5
SELECT p.PName, p.PNumber 
FROM Project p, Works_On w1, Works_On w2, Employee e1, Employee e2 
WHERE p.PNumber = w1.PNo 
	AND w1.ESSN = e1.SSN 
	AND p.PNumber = w2.PNo 
	AND w2.ESSN = e2.SSN 
	AND e1.LName = 'Narayan' 
	AND e2.LName = 'Jabbar'; 

SELECT p.PName, p.PNumber 
FROM Project p 
INNER JOIN Works_On w1 ON p.PNumber = w1.PNo 
INNER JOIN Employee e1 ON w1.ESSN = e1.SSN AND e1.LName = 'Narayan' AND e1.FName = 'Ramesh'
INNER JOIN Works_On w2 ON p.PNumber = w2.PNo 
INNER JOIN Employee e2 ON w2.ESSN = e2.SSN AND e2.LName = 'Jabbar' AND e2.FName = 'Ahmad';

-- 6
SELECT e.FName, e.LName, (2023 - YEAR(d.Bdate)) AS Age 
FROM Employee e, Dependent d 
WHERE e.SSN = d.ESSN AND (YEAR(d.Bdate) > 1970);

-- 7
SELECT e.FName, e.LName, p.PName, SUM(w.Hours) AS TotalHours 
FROM Employee e, Project p, Works_On w, DeptLocations dl 
WHERE e.SSN = w.ESSN 
	AND p.PNumber = w.PNo 
	AND p.DNum = dl.Dnumber 
	AND dl.DLocation = 'Houston' 
	GROUP BY e.FName, e.LName, p.PName;

-- 8	
SELECT e.FName, e.LName, s.FName AS SupervisorFirstName, s.LName AS SupervisorLastName 
FROM Employee e LEFT JOIN Employee s ON e.SuperSSN = s.SSN;

-- 9
SELECT p.PName, e.FName, e.LName, p.PLocation 
FROM Project p, Employee e, Department d 
WHERE p.DNum = d.DNumber AND d.MGRSSN = e.SSN;

-- 10
SELECT e.FName, e.LName 
FROM Employee e, Department d 
WHERE e.SSN = d.MGRSSN 
	ORDER BY e.Salary DESC 
	LIMIT 1;