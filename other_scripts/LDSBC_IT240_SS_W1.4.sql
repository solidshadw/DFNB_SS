--By Order Quantity, what were the five most popular products sold in 2014?
--Include these data points in the output:
--Order Date Year *
--Product ID*
--Product Name*
--Product Number*
--Product Color *
--Sales Order Count
--Order Quantity*
--SalesOrder Line total*

USE AdventureWorks2017;

SELECT TOP 5 YEAR(soh.OrderDate) AS OderDate 
	 , p.ProductID
	 , soh.OrderDate AS OderDate
	 , p.Color AS ProductColor
	 , p.ProductNumber
	 , p.Name AS ProductName
	 , COUNT(sod.SalesOrderID)
	 , SUM(sod.OrderQty)
	 , SUM(sod.LineTotal)

  FROM Production.Product AS p 
	   INNER JOIN
	   Sales.SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
	   INNER JOIN
	   Sales.SalesOrderHeader AS soh ON sod.SalesOrderID = soh.SalesOrderID

 WHERE YEAR(soh.OrderDate) = '2014'
 GROUP BY YEAR(soh.OrderDate)
	 , p.ProductID
	 , p.Name
	 , p.ProductNumber	
	 , p.Color
ORDER BY sod.OrderQty DESC;
 
 
 --How long are the 7 longest Person names and to whom do they belong? Rank by Full Name length, Last Name Length, First Name Length

--Business Entity ID
--Full Name
--Full Name Length
--First Name
--First Name Length
--Middle Name
--Last Name
--Last Name Length

USE AdventureWorks2017;

SELECT TOP 7 p.BusinessEntityID
           , replace(ISNULL(p.FirstName, '') + ' ' + ISNULL(p.MiddleName, '') + ' ' + ISNULL(p.LastName, ''), '  ', ' ') AS 'Full Name'
           , LEN(replace(ISNULL(p.FirstName, '') + ' ' + ISNULL(p.MiddleName, '') + ' ' + ISNULL(p.LastName, ''), '  ', ' ')) AS 'Full Name Length'
           , p.FirstName
           , LEN(p.FirstName) AS 'First Name Length'
           , ISNULL(p.MiddleName, '') AS MiddleName
           , p.LastName
           , LEN(p.LastName) AS 'Last Name Length'
  FROM Person.Person AS p
 ORDER BY [Full Name Length] DESC
        , [Last Name Length] DESC
        , [First Name Length] DESC;


--Which Department pays its female workers on average the most per year?
--Department ID
--Department Name
--Gender
--Total Yearly Pay
--Business Entity ID Count
--Average Yearly Pay

 
USE AdventureWorks2017;
GO

WITH s1
     AS (SELECT edh.DepartmentID
              , hre.Gender
              , hrd.Name
              , hre.SalariedFlag
              , CASE
                    WHEN hre.SalariedFlag = 1
                    THEN rate * 1000
                    WHEN hre.SalariedFlag = 0
                    THEN rate * 2080
                    ELSE 0
                END AS YearlyPay
              , COUNT(hre.BusinessEntityID) AS BusinessEntityIDCount
              , CASE
                    WHEN hre.SalariedFlag = 1
                    THEN rate * 1000
                    WHEN hre.SalariedFlag = 0
                    THEN rate * 2080
                    ELSE 0
                END * COUNT(hre.BusinessEntityID) AS TotalYearlyPay
           FROM HumanResources.Employee AS hre
                JOIN
                HumanResources.EmployeeDepartmentHistory AS edh ON hre.BusinessEntityID = edh.BusinessEntityID
                JOIN
                HumanResources.Department AS hrd ON edh.DepartmentID = hrd.DepartmentID
                JOIN
                HumanResources.EmployeePayHistory AS eph ON hre.BusinessEntityID = eph.BusinessEntityID
          WHERE hre.Gender = 'F'
          GROUP BY hre.Gender
                 , edh.DepartmentID
                 , hrd.Name
                 , eph.Rate
                 , eph.payfrequency
                 , hre.SalariedFlag
                 , CASE
                       WHEN hre.SalariedFlag = 1
                       THEN rate * 1000
                       WHEN hre.SalariedFlag = 0
                       THEN rate * 2080
                       ELSE 0
                   END)
     SELECT TOP 10 s1.DepartmentID
                 , s1.Name
                 , s1.Gender
                 , SUM(s1.TotalYearlyPay) AS TotalYearlyPay
                 , SUM(s1.BusinessEntityIDCount) AS BusinessEntityIDCount
                 , SUM(s1.TotalYearlyPay) / SUM(s1.BusinessEntityIDCount) AS AverageYearlyPay
       FROM s1
      GROUP BY s1.DepartmentID
             , s1.name
             , s1.gender
      ORDER BY 6 DESC;