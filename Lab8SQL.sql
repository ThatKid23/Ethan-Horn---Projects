/*
Ethan Horn
CNIT 272 Fall 2024
Lab Time: Fri 1:30 PM - 3:20 PM
*/

/*
Ethan Horn
CNIT 272 Fall 2024
Lab Time: Friday 1:30 PM - 3:20 PM
*/
--*********************************************************************************
--Question 1

SELECT * FROM WORKER WHERE WORKER_ID = 600;

INSERT INTO WORKER (WORKER_ID, FIRST_NAME, LAST_NAME, CITY, dept_code, HIRE_DATE, CREDIT_LIMIT, PHONE_NUMBER, MANAGER_ID)
VALUES (600, 'Katie', 'Smith', 'Chicago', 'Com', TO_DATE('30-JAN-2023', 'DD-MON-YYYY'), 22, 7592, 565);

SELECT * FROM WORKER WHERE WORKER_ID = 600;

SELECT * FROM LUNCH WHERE WORKER_ID = 600;

INSERT INTO LUNCH (LUNCH_ID, LUNCH_DATE, WORKER_ID)
VALUES (53, TO_DATE('02-FEB-2023', 'DD-MON-YYYY'), 600);

INSERT INTO LUNCH (LUNCH_ID, LUNCH_DATE, WORKER_ID)
VALUES (54, TO_DATE('04-FEB-2023', 'DD-MON-YYYY'), 600);

INSERT INTO LUNCH (LUNCH_ID, LUNCH_DATE, WORKER_ID)
VALUES (55, TO_DATE('01-NOV-2024', 'DD-MON-YYYY'), 600);


SELECT * FROM LUNCH WHERE WORKER_ID = 600;

COMMIT;
/*
Q1.1:

no rows selected

Q1.2:

1 row inserted.

Q1.3:

WOR FIRST_NAME LAST_NAME            CITY                           DEP HIRE_DATE CREDIT_LIMIT PHON MAN
--- ---------- -------------------- ------------------------------ --- --------- ------------ ---- ---
600 Katie      Smith                Chicago                        Com 30-JAN-23           22 7592 565

Q1.4:

no rows selected.

Q1.5:

1 row inserted.


1 row inserted.

Q1.6:

1 row inserted.

Q1.7:

 LUNCH_ID LUNCH_DAT WOR
---------- --------- ---
        53 02-FEB-23 600
        54 04-FEB-23 600
        55 01-NOV-24 600

Q1.8:

Commit complete.

*/

--*********************************************************************************
--Question 2

SELECT WORKER_ID, FIRST_NAME, LAST_NAME, CITY
FROM WORKER
WHERE WORKER_ID = 600;

UPDATE WORKER
SET LAST_NAME = 'Kelly', CITY = 'Oak Brook'
WHERE WORKER_ID = 600;

COMMIT;

SELECT WORKER_ID, FIRST_NAME, LAST_NAME, CITY
FROM WORKER
WHERE WORKER_ID = 600;


/*
Q2.1:

WOR FIRST_NAME LAST_NAME            CITY                          
--- ---------- -------------------- ------------------------------
600 Katie      Smith                Chicago  

Q2.2:    

1 row updated.

Q2.3:

Commit complete.

Q2.4:

WOR FIRST_NAME LAST_NAME            CITY                          
--- ---------- -------------------- ------------------------------
600 Katie      Kelly                Oak Brook                     
*/

--*********************************************************************************
--Question 3

SELECT SUPPLIER_ID, DESCRIPTION, PRICE
FROM FOOD
WHERE SUPPLIER_ID = 'Ard';

UPDATE FOOD
SET PRICE = PRICE * 1.57
WHERE SUPPLIER_ID = 'Ard';

SELECT SUPPLIER_ID, DESCRIPTION, PRICE
FROM FOOD
WHERE SUPPLIER_ID = 'Ard';


/*
Q3.1:
SUP DESCRIPTION               PRICE
--- -------------------- ----------
Ard PB Cookie                  1.25
Ard Veggie Pizza               6.25
Ard Chicken Avocado Wrap       5.25

Q3.2:
3 rows updated.

Q3.3:
SUP DESCRIPTION               PRICE
--- -------------------- ----------
Ard PB Cookie                  1.96
Ard Veggie Pizza               9.81
Ard Chicken Avocado Wrap       8.24

*/
--*********************************************************************************
--Question 4

SELECT F.SUPPLIER_ID, F.PRODUCT_CODE
FROM FOOD F
LEFT JOIN LUNCH_ITEM LI ON F.SUPPLIER_ID = LI.SUPPLIER_ID AND F.PRODUCT_CODE = LI.PRODUCT_CODE
WHERE LI.SUPPLIER_ID IS NULL;

DELETE FROM FOOD
WHERE supplier_id || product_code IN (
    SELECT F.supplier_id || F.product_code
    FROM FOOD F
    LEFT JOIN LUNCH_ITEM L 
        ON F.supplier_id = L.supplier_id 
        AND F.product_code = L.product_code
    WHERE L.supplier_id IS NULL
);


SELECT F.SUPPLIER_ID, F.PRODUCT_CODE
FROM FOOD F
LEFT JOIN LUNCH_ITEM LI ON F.SUPPLIER_ID = LI.SUPPLIER_ID AND F.PRODUCT_CODE = LI.PRODUCT_CODE
WHERE LI.SUPPLIER_ID IS NULL;


/*
Q4.1:

SUP PR
--- --
Ard Sw
Jmd Vt
Ard Ds
Gls Vr

Q4.2:

4 rows deleted.

Q4.3:

no rows selected

*/
--*********************************************************************************
--Question 5
SELECT supplier_id, supplier_name
FROM FOOD_SUPPLIER
WHERE supplier_id NOT IN (
    SELECT supplier_id
    FROM FOOD
);

DELETE FROM FOOD_SUPPLIER
WHERE supplier_id NOT IN (
    SELECT supplier_id
    FROM FOOD
);

SELECT supplier_id, supplier_name
FROM FOOD_SUPPLIER
WHERE supplier_id NOT IN (
    SELECT supplier_id
    FROM FOOD
);

ROLLBACK;

SELECT supplier_id, supplier_name
FROM FOOD_SUPPLIER
WHERE supplier_id NOT IN (
    SELECT supplier_id
    FROM FOOD
);

/*
Q5.1:

SUP SUPPLIER_NAME                 
--- ------------------------------
Fas Framer and Samson             
Fdv Fresh Daily Vegetables        
Gio Giovana and Sons              
Har Harold Bakery                 
Met Under the Metra               
Rby Rosemont Bakery               

6 rows selected. 

Q5.2:

6 rows deleted.

Q5.3:

no rows selected

Q5.4:

Rollback complete.

Q5.5:

SUP SUPPLIER_NAME                 
--- ------------------------------
Fas Framer and Samson             
Fdv Fresh Daily Vegetables        
Gio Giovana and Sons              
Har Harold Bakery                 
Met Under the Metra               
Rby Rosemont Bakery               

6 rows selected. 
*/

--*********************************************************************************
--Question 6

CREATE TABLE TRAVEL (
    Worker_ID CHAR(3) PRIMARY KEY,
    Dept_Code VARCHAR2(4),
    Travel_limit NUMBER(5,2),
    Authorization CHAR(2)
);

ALTER TABLE TRAVEL
ADD CONSTRAINT travel_FK
FOREIGN KEY (Worker_ID)
REFERENCES WORKER(Worker_ID);

INSERT INTO TRAVEL (Worker_ID, Dept_Code, Travel_limit, Authorization)
SELECT 
    Worker_ID, 
    Dept_Code, 
    Credit_Limit * 1.5 AS Travel_limit, 
    NULL AS Authorization
FROM 
    WORKER
WHERE 
    Manager_ID = 562;

UPDATE TRAVEL
SET Authorization = 'A5';

SELECT 
    T.Worker_ID,
    T.Dept_Code,
    W.Credit_Limit,
    T.Travel_limit,
    T.Authorization
FROM 
    TRAVEL T
JOIN 
    WORKER W ON T.Worker_ID = W.Worker_ID;

COMMIT;

/*
Q6.1:

Table TRAVEL created.

Q6.2:

Table TRAVEL altered.

Q6.3:
2 rows inserted.


WOR DEP TRAVEL_LIMIT AUTHORIZATION
--- --- ------------ -------------
574               48              
583             37.5      

Q6.4:

2 rows updated.

Q6.5:
WOR DEPT CREDIT_LIMIT TRAVEL_LIMIT AU
--- ---- ------------ ------------ --
574                32           48 A5
583                25         37.5 A5

Q6.6:
Commit complete.
