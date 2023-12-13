/* Welcome to employee payroll database */

/* UC-1 */

mysql> show databases;
+----------------------+
| Database             |
+----------------------+
| address_book_service |
| information_schema   |
| mysql                |
| payroll_service      |
| performance_schema   |
| school               |
| sql_hr               |
| sql_inventory        |
| sql_invoicing        |
| sql_store            |
| sys                  |
+----------------------+
11 rows in set (0.10 sec)

mysql> use payroll_service;
Database changed


/* UC-2 */
mysql> Create table employee_payroll (
    ->     id int NOT NULL auto_increment,
    ->      name varchar(100) NOT NULL,
    ->      salary int NOT NULL,
    ->      start date,
    ->      primary key (id));
Query OK, 0 rows affected (0.08 sec)

mysql> describe employee_payroll;;
+--------+--------------+------+-----+---------+----------------+
| Field  | Type         | Null | Key | Default | Extra          |
+--------+--------------+------+-----+---------+----------------+
| id     | int          | NO   | PRI | NULL    | auto_increment |
| name   | varchar(100) | NO   |     | NULL    |                |
| salary | int          | NO   |     | NULL    |                |
| start  | date         | YES  |     | NULL    |                |
+--------+--------------+------+-----+---------+----------------+
4 rows in set (0.02 sec)



/* UC-3 */

mysql>     INSERT INTO employee_payroll
    ->      (name, salary, start) VALUES
    ->      ('Mark',1200000, '2021-07-09'), ('David',2200000, '2021-07-02'), ('John',5000000, '2021-04-06'),('Bill',1000000, '2021-07-09');
Query OK, 4 rows affected (0.04 sec)
Records: 4  Duplicates: 0  Warnings: 0



/* UC-4 */

mysql> select * from employee_payroll;
+----+-------+---------+------------+
| id | name  | salary  | start      |
+----+-------+---------+------------+
|  1 | Mark  | 1200000 | 2021-07-09 |
|  2 | David | 2200000 | 2021-07-02 |
|  3 | John  | 5000000 | 2021-04-06 |
|  4 | Bill  | 1000000 | 2021-07-09 |
+----+-------+---------+------------+
4 rows in set (0.01 sec)


/* UC-5 */
mysql>  SELECT salary FROM employee_payroll WHERE start BETWEEN '2021-07-09' AND DATE(NOW());
+---------+
| salary  |
+---------+
| 1200000 |
| 1000000 |
+---------+
2 rows in set (0.01 sec)


/* UC-6 */
mysql> ALTER table employee_payroll
    ->       ADD COLUMN gender CHAR(1);
Query OK, 0 rows affected (0.05 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> describe employee_payroll;
+--------+--------------+------+-----+---------+----------------+
| Field  | Type         | Null | Key | Default | Extra          |
+--------+--------------+------+-----+---------+----------------+
| id     | int          | NO   | PRI | NULL    | auto_increment |
| name   | varchar(100) | NO   |     | NULL    |                |
| salary | int          | NO   |     | NULL    |                |
| start  | date         | YES  |     | NULL    |                |
| gender | char(1)      | YES  |     | NULL    |                |
+--------+--------------+------+-----+---------+----------------+
5 rows in set (0.02 sec)

mysql> UPDATE employee_payroll set gender = 'M' WHERE name = 'Bill' or name = 'David' or name = 'John';
Query OK, 3 rows affected (0.01 sec)
Rows matched: 3  Changed: 3  Warnings: 0

mysql> select * from employee_payroll;
+----+-------+---------+------------+--------+
| id | name  | salary  | start      | gender |
+----+-------+---------+------------+--------+
|  1 | Mark  | 1200000 | 2021-07-09 | NULL   |
|  2 | David | 2200000 | 2021-07-02 | M      |
|  3 | John  | 5000000 | 2021-04-06 | M      |
|  4 | Bill  | 1000000 | 2021-07-09 | M      |
+----+-------+---------+------------+--------+
4 rows in set (0.00 sec)



/* UC-7 */
mysql> SELECT gender,SUM(salary),AVG(salary),MAX(salary),MIN(salary),COUNT(*)AS Count FROM employee_payroll GROUP BY gender;
+--------+-------------+--------------+-------------+-------------+-------+
| gender | SUM(salary) | AVG(salary)  | MAX(salary) | MIN(salary) | Count |
+--------+-------------+--------------+-------------+-------------+-------+
| NULL   |     1200000 | 1200000.0000 |     1200000 |     1200000 |     1 |
| M      |     8200000 | 2733333.3333 |     5000000 |     1000000 |     3 |
+--------+-------------+--------------+-------------+-------------+-------+
2 rows in set (0.00 sec)



/* UC-8 */

mysql> ALTER TABLE employee_payroll ADD phone_number VARCHAR(250) AFTER name;
Query OK, 0 rows affected (0.09 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD address VARCHAR(250) AFTER phone_number;
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD department VARCHAR(150) NOT NULL AFTER address;
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ALTER address SET DEFAULT 'TBD';
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> describe employee_payroll;
+--------------+--------------+------+-----+---------+----------------+
| Field        | Type         | Null | Key | Default | Extra          |
+--------------+--------------+------+-----+---------+----------------+
| id           | int          | NO   | PRI | NULL    | auto_increment |
| name         | varchar(100) | NO   |     | NULL    |                |
| phone_number | varchar(250) | YES  |     | NULL    |                |
| address      | varchar(250) | YES  |     | TBD     |                |
| department   | varchar(150) | NO   |     | NULL    |                |
| salary       | int          | NO   |     | NULL    |                |
| start        | date         | YES  |     | NULL    |                |
| gender       | char(1)      | YES  |     | NULL    |                |
+--------------+--------------+------+-----+---------+----------------+
8 rows in set (0.02 sec)


/* UC-9 */

mysql> ALTER TABLE employee_payroll RENAME COLUMN salary TO basic_pay;
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD deductions Double NOT NULL AFTER basic_pay;
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql>  ALTER TABLE employee_payroll ADD taxable_pay Double NOT NULL AFTER deductions;
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD tax Double NOT NULL AFTER taxable_pay;
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE employee_payroll ADD net_pay Double NOT NULL AFTER tax;
Query OK, 0 rows affected (0.04 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql>  SELECT * FROM employee_payroll;
+----+-------+--------------+---------+------------+-----------+------------+-------------+-----+---------+------------+--------+
| id | name  | phone_number | address | department | basic_pay | deductions | taxable_pay | tax | net_pay | start      | gender |
+----+-------+--------------+---------+------------+-----------+------------+-------------+-----+---------+------------+--------+
|  1 | Mark  | NULL         | NULL    |            |   1200000 |          0 |           0 |   0 |       0 | 2021-07-09 | NULL   |
|  2 | David | NULL         | NULL    |            |   2200000 |          0 |           0 |   0 |       0 | 2021-07-02 | M      |
|  3 | John  | NULL         | NULL    |            |   5000000 |          0 |           0 |   0 |       0 | 2021-04-06 | M      |
|  4 | Bill  | NULL         | NULL    |            |   1000000 |          0 |           0 |   0 |       0 | 2021-07-09 | M      |
+----+-------+--------------+---------+------------+-----------+------------+-------------+-----+---------+------------+--------+
4 rows in set (0.01 sec)



/* UC-10 */


mysql> INSERT INTO employee_payroll
    ->     (name, department, gender, basic_pay, deductions, taxable_pay, tax, net_pay, start) VALUES
    ->     ('Merrisa', 'Marketing', 'F', 300000.00, 100000.00, 200000.00, 500000.00, 150000.00, '2021-03-01');
Query OK, 1 row affected (0.01 sec)

mysql> select * from employee_payroll;
+----+---------+--------------+---------+------------+-----------+------------+-------------+--------+---------+------------+--------+
| id | name    | phone_number | address | department | basic_pay | deductions | taxable_pay | tax    | net_pay | start      | gender |
+----+---------+--------------+---------+------------+-----------+------------+-------------+--------+---------+------------+--------+
|  1 | Mark    | NULL         | NULL    |            |   1200000 |          0 |           0 |      0 |       0 | 2021-07-09 | NULL   |
|  2 | David   | NULL         | NULL    |            |   2200000 |          0 |           0 |      0 |       0 | 2021-07-02 | M      |
|  3 | John    | NULL         | NULL    |            |   5000000 |          0 |           0 |      0 |       0 | 2021-04-06 | M      |
|  4 | Bill    | NULL         | NULL    |            |   1000000 |          0 |           0 |      0 |       0 | 2021-07-09 | M      |
|  5 | Merissa | NULL         | TBD     | Sales      |   3200000 |          0 |           0 |      0 |       0 | 2021-07-03 | F      |
|  6 | Merrisa | NULL         | TBD     | Marketing  |    300000 |     100000 |      200000 | 500000 |  150000 | 2021-03-01 | F      |
+----+---------+--------------+---------+------------+-----------+------------+-------------+--------+---------+------------+--------+
6 rows in set (0.00 sec)







/* UC-11  ER Diagram*/
 

+------------------+        +------------------+
|    Employee      |        | SalaryStructure  |
+------------------+        +------------------+
| id (PK)          |   1    | structure_id (PK)|
| name             |-------<| common_basic_pay |
| phone_number     |        | common_deductions|
| address          |        | common_taxable_pay|
| department       |        | common_tax       |
| gender           |        | common_net_pay   |
| salary_structure_id (FK)| +------------------+
+------------------+

/*Each employee references a common salary structure through salary_structure_id.*/