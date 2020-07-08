/********************************************************************************************
NAME:	LoadDFNB_p1
PURPOSE: Load the normalized tables into DFNB2 database and assign keys
SUPPORT: Samuel Silva
		 sasa2@ldsbc.edu 

MODIFICATION LOG:
Ver   Date        Author    Description
---   ----------  -------   -----------------------------------------------------------------
1.0   06/06/2020  SSILVA   1. Created the script

RUNTIME: 
56 seconds
NOTES: 
(None)
LICENSE: 
This code is covered by the GNU General Public License which guarantees end users
the freedom to run, study, share, and modify the code. This license grants the recipients
of the code the rights of the Free Software Definition. All derivative work can only be
distributed under the same license terms.
********************************************************************************************/

USE [DFNB2];

GO

/* 1) Drop Constraints */

IF EXISTS
(
    SELECT pk.* from 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS pk
     WHERE pk.constraint_name = 'PK_tblaccount_dim'
           AND table_name = 'account_dim'
)

    BEGIN

        ALTER TABLE dbo.account_dim DROP CONSTRAINT PK_tblaccount_dim;

END;

IF EXISTS
(
    SELECT pk.* from 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS pk
     WHERE pk.constraint_name = 'PK_tblaccount_fact'
           AND table_name = 'account_fact'
)

    BEGIN

        ALTER TABLE dbo.account_fact DROP CONSTRAINT PK_tblaccount_fact;

END;

IF EXISTS
(
    SELECT pk.* from 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS pk
     WHERE pk.constraint_name = 'PK_tblbank_dim'
           AND table_name = 'bank_dim'
)

    BEGIN

        ALTER TABLE dbo.bank_dim DROP CONSTRAINT PK_tblbank_dim;

END;

IF EXISTS
(
    SELECT pk.* from 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS pk
     WHERE pk.constraint_name = 'PK_tblbranch_dim'
           AND table_name = 'branch_dim'
)

    BEGIN

        ALTER TABLE dbo.branch_dim DROP CONSTRAINT PK_tblbranch_dim;

END;

IF EXISTS
(
    SELECT pk.* from 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS pk
     WHERE pk.constraint_name = 'PK_tblcustomer_account_dim'
           AND table_name = 'customer_account_dim'
)

    BEGIN

        ALTER TABLE dbo.customer_account_dim DROP CONSTRAINT PK_tblcustomer_account_dim;

END;

IF EXISTS
(
    SELECT pk.* from 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS pk
     WHERE pk.constraint_name = 'PK_tblcustomer_address_dim'
           AND table_name = 'customer_address_dim'
)

    BEGIN

        ALTER TABLE dbo.customer_address_dim DROP CONSTRAINT PK_tblcustomer_address_dim;

END;

IF EXISTS
(
    SELECT pk.* from 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS pk
     WHERE pk.constraint_name = 'PK_tblcustomer_dim'
           AND table_name = 'customer_dim'
)

    BEGIN

        ALTER TABLE dbo.customer_dim DROP CONSTRAINT PK_tblcustomer_dim;

END;

IF EXISTS
(
    SELECT pk.* from 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS pk
     WHERE pk.constraint_name = 'PK_tblcustomer_relationship_dim'
           AND table_name = 'customer_relationship_dim'
)

    BEGIN

        ALTER TABLE dbo.customer_relationship_dim DROP CONSTRAINT PK_tblcustomer_relationship_dim;

END;

IF EXISTS
(
    SELECT pk.* from 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS pk
     WHERE pk.constraint_name = 'PK_tblproduct_dim'
           AND table_name = 'product_dim'
)

    BEGIN

        ALTER TABLE dbo.product_dim DROP CONSTRAINT PK_tblproduct_dim;

END;

IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK__tblaccount_dim_tblbranch_dim'
           AND parent_object_id = OBJECT_ID('dbo.account_dim')
)

    BEGIN

        ALTER TABLE dbo.account_dim DROP CONSTRAINT FK__tblaccount_dim_tblbranch_dim;

END;

IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK__tblaccount_dim_tblproduct_dim'
           AND parent_object_id = OBJECT_ID('dbo.account_dim')
)

    BEGIN

        ALTER TABLE dbo.account_dim DROP CONSTRAINT FK__tblaccount_dim_tblproduct_dim;

END;

IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblaccount_fact_tblaccount_dim'
           AND parent_object_id = OBJECT_ID('dbo.account_fact')
)

    BEGIN

        ALTER TABLE dbo.account_fact DROP CONSTRAINT FK_tblaccount_fact_tblaccount_dim;

END;

IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblaccount_fact_tblcustomer_dim'
           AND parent_object_id = OBJECT_ID('dbo.account_fact')
)

    BEGIN

        ALTER TABLE dbo.account_fact DROP CONSTRAINT FK_tblaccount_fact_tblcustomer_dim;

END;


IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblbranch_dim_tblbank_dim'
           AND parent_object_id = OBJECT_ID('dbo.branch_dim')
)

    BEGIN

        ALTER TABLE dbo.branch_dim DROP CONSTRAINT FK_tblbranch_dim_tblbank_dim;

END;

IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblcustomer_relationship_dim_tblcustomer_dim'
           AND parent_object_id = OBJECT_ID('dbo.customer_relationship_dim')
)

    BEGIN

        ALTER TABLE dbo.customer_relationship_dim DROP CONSTRAINT FK_tblcustomer_relationship_dim_tblcustomer_dim;

END;

IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblcustomer_account_dim_tblcustomer_dim'
           AND parent_object_id = OBJECT_ID('dbo.customer_account_dim')
)

    BEGIN

        ALTER TABLE dbo.customer_account_dim DROP CONSTRAINT FK_tblcustomer_account_dim_tblcustomer_dim;

END;

IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblcustomer_account_dim_tblaccount_dim'
           AND parent_object_id = OBJECT_ID('dbo.customer_account_dim')
)

    BEGIN

        ALTER TABLE dbo.customer_account_dim DROP CONSTRAINT FK_tblcustomer_account_dim_tblaccount_dim;

END;

IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblcustomer_address_dim_tblcustomer_dim'
           AND parent_object_id = OBJECT_ID('dbo.customer_address_dim')
)

    BEGIN

        ALTER TABLE dbo.customer_address_dim DROP CONSTRAINT FK_tblcustomer_address_dim_tblcustomer_dim;

END;

IF EXISTS
(
    SELECT fk.*
      FROM sys.foreign_keys AS fk
     WHERE fk.name = 'FK_tblcustomer_address_dim_tblbranch_dim'
           AND parent_object_id = OBJECT_ID('dbo.customer_address_dim')
)

    BEGIN

        ALTER TABLE dbo.customer_address_dim DROP CONSTRAINT FK_tblcustomer_address_dim_tblbranch_dim;

END;


/* 2) Create the Account Dimension table */

SELECT DISTINCT 
       sp1.acct_id
     , sp1.open_date
     , sp1.close_date
     , sp1.open_close_code
     , sp1.loan_amt
     , sp1.branch_id
     , sp1.prod_id
 INTO dbo.account_dim
 FROM dbo.stg_p1 AS sp1
 ORDER BY sp1.acct_id;

/* dbo.account_dim; */

TRUNCATE TABLE dbo.account_dim;

INSERT INTO dbo.account_dim
SELECT DISTINCT 
       sp1.acct_id
     , sp1.open_date
     , sp1.close_date
     , sp1.open_close_code
     , sp1.loan_amt
     , sp1.branch_id
     , sp1.prod_id
  FROM dbo.stg_p1 AS sp1
 ORDER BY sp1.acct_id;

/* 3) Create the Account Fact table */

SELECT DISTINCT 
       sp1.acct_id
     , sp1.cust_id
     , sp1.as_of_date
     , sp1.cur_bal
INTO dbo.account_fact
  FROM dbo.stg_p1 AS sp1
 ORDER BY sp1.acct_id;

/* dbo.account_fact; */

TRUNCATE TABLE dbo.account_fact;

INSERT INTO dbo.account_fact
SELECT DISTINCT 
       sp1.acct_id
     , sp1.cust_id
     , sp1.as_of_date
     , sp1.cur_bal
  FROM dbo.stg_p1 AS sp1
 ORDER BY sp1.acct_id;

/* 4) Create the Bank Dimension table */

CREATE TABLE bank_dim
(bank_id   VARCHAR(2) NOT NULL
, bank_name VARCHAR(50)
);

/* dbo.branch_dim; */

TRUNCATE TABLE dbo.bank_dim;

INSERT INTO dbo.bank_dim(bank_id
                       , bank_name)
VALUES
      (
       '1'
     , 'Deseret First National Bank'
      );

/* 5) Create the Branch Dimension table */

SELECT DISTINCT 
       sp1.branch_id
     , sp1.acct_branch_code AS branch_code
     , sp1.acct_branch_desc AS branch_desc
     , sp1.acct_region_id AS region_id
     , sp1.acct_area_id AS area_id
     , sp1.acct_branch_lat AS branch_lat
     , sp1.acct_branch_lon AS branch_lon
     , bd.bank_id
INTO dbo.branch_dim
  FROM dbo.stg_p1 AS sp1
     , dbo.bank_dim AS bd
 ORDER BY sp1.branch_id;

/* dbo.branch_dim; */

TRUNCATE TABLE dbo.branch_dim;

INSERT INTO dbo.branch_dim
SELECT DISTINCT 
       sp1.branch_id
     , sp1.acct_branch_code AS branch_code
     , sp1.acct_branch_desc AS branch_desc
     , sp1.acct_region_id AS region_id
     , sp1.acct_area_id AS area_id
     , sp1.acct_branch_lat AS branch_lat
     , sp1.acct_branch_lon AS branch_lon
     , '1' AS bank_id
  FROM dbo.stg_p1 AS sp1
 ORDER BY sp1.branch_id;

/* 6) Create the Customer Dimension table */

SELECT DISTINCT 
       sp1.cust_id
     , sp1.last_name
     , sp1.first_name
     , sp1.gender
     , sp1.birth_date
     , sp1.cust_since_date
INTO dbo.customer_dim
  FROM dbo.stg_p1 AS sp1
 ORDER BY sp1.cust_id;

/* dbo.customer_dim; */

TRUNCATE TABLE dbo.customer_dim;

INSERT INTO dbo.customer_dim
SELECT DISTINCT 
       sp1.cust_id
     , sp1.last_name
     , sp1.first_name
     , sp1.gender
     , sp1.birth_date
     , sp1.cust_since_date
  FROM dbo.stg_p1 AS sp1
 ORDER BY sp1.cust_id;

/* 7) Create the Customer Account Dimension table */

SELECT DISTINCT 
       sp1.cust_id
     , sp1.acct_id
     , sp1.acct_cust_role_id
INTO dbo.customer_account_dim
  FROM dbo.stg_p1 AS sp1
 ORDER BY sp1.cust_id;

/* dbo.customer_account_dim; */

TRUNCATE TABLE dbo.customer_account_dim;

INSERT INTO dbo.customer_account_dim
SELECT DISTINCT 
       sp1.cust_id
     , sp1.acct_id
     , sp1.acct_cust_role_id
  FROM dbo.stg_p1 AS sp1
 ORDER BY sp1.cust_id;

/* 8) Create the Product Dimension table */

SELECT DISTINCT 
       sp1.prod_id
INTO dbo.product_dim
  FROM dbo.stg_p1 AS sp1
 ORDER BY sp1.prod_id;

/* dbo.product_dim; */

TRUNCATE TABLE dbo.product_dim;

INSERT INTO dbo.product_dim
SELECT DISTINCT 
       sp1.prod_id
  FROM dbo.stg_p1 AS sp1
 ORDER BY sp1.prod_id;

/* 9) Create the Customer Address Dimension table */

SELECT DISTINCT 
       sp1.cust_add_id
     , sp1.cust_id
     , sp1.pri_branch_id as branch_id
     , sp1.cust_pri_branch_dist as cust_branch_dist
     , sp1.cust_lat
     , sp1.cust_lon
     , sp1.cust_add_type
INTO dbo.customer_address_dim
  FROM dbo.stg_p1 AS sp1
 ORDER BY sp1.cust_add_id;

/* dbo.customer_address_dim; */

TRUNCATE TABLE dbo.customer_address_dim;

INSERT INTO dbo.customer_address_dim
SELECT DISTINCT 
       sp1.cust_add_id
     , sp1.cust_id
     , sp1.pri_branch_id AS branch_id
     , sp1.cust_pri_branch_dist AS cust_branch_dist
     , sp1.cust_lat
     , sp1.cust_lon
     , sp1.cust_add_type
  FROM dbo.stg_p1 AS sp1
 ORDER BY sp1.cust_add_id;

/* 10) Create the Customer Relationship Dimension table */

SELECT DISTINCT 
       sp1.cust_rel_id
     , sp1.cust_id
INTO dbo.customer_relationship_dim
  FROM dbo.stg_p1 AS sp1
 ORDER BY sp1.cust_rel_id;

/* dbo.customer_relationship_dim; */

TRUNCATE TABLE dbo.customer_relationship_dim;

INSERT INTO dbo.customer_relationship_dim
SELECT DISTINCT 
       sp1.cust_rel_id
     , sp1.cust_id
  FROM dbo.stg_p1 AS sp1
 ORDER BY sp1.cust_rel_id;

 /* 12) Create the Transaction table */
 SELECT DISTINCT 
      sp2.tran_type_id
	  ,sp2.acct_id
	  ,sp2.tran_date
      ,sp2.tran_time
      ,sp2.tran_amt
INTO dbo.transac_dim
FROM dbo.stg_p2 AS sp2
ORDER BY sp2.acct_id;

TRUNCATE TABLE dbo.transac_dim;

INSERT INTO dbo.transac_dim
SELECT DISTINCT 
       sp2.acct_id
	  ,sp2.tran_date
      ,sp2.tran_time
      ,sp2.tran_type_id
	  ,sp2.tran_amt
  FROM dbo.stg_p2 AS sp2
 ORDER BY sp2.acct_id;

/* 12) Add constraints */

ALTER TABLE dbo.account_dim
ADD CONSTRAINT PK_tblaccount_dim PRIMARY KEY (acct_id);

ALTER TABLE dbo.account_fact
ADD CONSTRAINT PK_tblaccount_fact PRIMARY KEY (acct_id, cust_id, as_of_date);

ALTER TABLE dbo.bank_dim
ADD CONSTRAINT PK_tblbank_dim PRIMARY KEY (bank_id);

ALTER TABLE dbo.branch_dim
ADD CONSTRAINT PK_tblbranch_dim PRIMARY KEY (branch_id);

ALTER TABLE dbo.customer_account_dim
ADD CONSTRAINT PK_tblcustomer_account_dim PRIMARY KEY (cust_id, acct_id);

ALTER TABLE dbo.customer_address_dim
ADD CONSTRAINT PK_tblcustomer_address_dim PRIMARY KEY (cust_add_id);

ALTER TABLE dbo.customer_dim
ADD CONSTRAINT PK_tblcustomer_dim PRIMARY KEY (cust_id);

ALTER TABLE dbo.customer_relationship_dim
ADD CONSTRAINT PK_tblcustomer_relationship_dim PRIMARY KEY (cust_rel_id, cust_id);

ALTER TABLE dbo.product_dim
ADD CONSTRAINT PK_tblproduct_dim PRIMARY KEY (prod_id);

ALTER TABLE dbo.account_dim
ADD CONSTRAINT FK__tblaccount_dim_tblbranch_dim FOREIGN KEY(branch_id) REFERENCES dbo.branch_dim;

ALTER TABLE dbo.account_dim
ADD CONSTRAINT FK__tblaccount_dim_tblproduct_dim FOREIGN KEY(prod_id) REFERENCES dbo.product_dim;

ALTER TABLE dbo.account_fact
ADD CONSTRAINT FK_tblaccount_fact_tblaccount_dim FOREIGN KEY(acct_id) REFERENCES dbo.account_dim;

ALTER TABLE dbo.account_fact
ADD CONSTRAINT FK_tblaccount_fact_tblcustomer_dim FOREIGN KEY(cust_id) REFERENCES dbo.customer_dim;

ALTER TABLE dbo.branch_dim
ADD CONSTRAINT FK_tblbranch_dim_tblbank_dim FOREIGN KEY(bank_id) REFERENCES dbo.bank_dim;

ALTER TABLE dbo.customer_relationship_dim
ADD CONSTRAINT FK_tblcustomer_relationship_dim_tblcustomer_dim FOREIGN KEY(cust_id) REFERENCES dbo.customer_dim;

ALTER TABLE dbo.customer_account_dim
ADD CONSTRAINT FK_tblcustomer_account_dim_tblcustomer_dim FOREIGN KEY(cust_id) REFERENCES dbo.customer_dim;

ALTER TABLE dbo.customer_account_dim
ADD CONSTRAINT FK_tblcustomer_account_dim_tblaccount_dim FOREIGN KEY(acct_id) REFERENCES dbo.account_dim;

ALTER TABLE dbo.customer_address_dim
ADD CONSTRAINT FK_tblcustomer_address_dim_tblcustomer_dim FOREIGN KEY(cust_id) REFERENCES dbo.customer_dim;

ALTER TABLE dbo.customer_address_dim
ADD CONSTRAINT FK_tblcustomer_address_dim_tblbranch_dim FOREIGN KEY(branch_id) REFERENCES dbo.branch_dim;



