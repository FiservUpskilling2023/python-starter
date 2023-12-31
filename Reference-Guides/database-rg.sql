/**
 * File: database-rg.sql
 * Auth: Martin Burolla
 * Date: 10/6/2021
 * Desc: DB reference queries.
 */

-- DDL: Entity tables...
CREATE TABLE claim (
     claim_id INT NOT NULL AUTO_INCREMENT,
     person_id INT NOT NULL,
     amount INT NOT NULL,
     PRIMARY KEY (claim_id)
);

CREATE TABLE patient (
     patient_id INT NOT NULL AUTO_INCREMENT,
     name varchar(40),
     PRIMARY KEY (patient_id)
);

CREATE TABLE doctor (
  doctor_id int(11) NOT NULL AUTO_INCREMENT,
  patient_id int(11) DEFAULT NULL,
  doc_name varchar(45) DEFAULT NULL,
  PRIMARY KEY (doctor_id)
);

CREATE TABLE bank (
  bank_id int(11) NOT NULL,
  name varchar(45) DEFAULT NULL,
  PRIMARY KEY (bank_id)
);

-- DDL: Relationship tables...
CREATE TABLE patient_bank (
  patient_bank_id int(11) NOT NULL AUTO_INCREMENT,
  patient_id int(11) DEFAULT NULL,
  bank_id int(11) DEFAULT NULL,
  PRIMARY KEY (patient_bank_id)
);

-- DML
INSERT INTO patient (name) VALUES ('marty');
INSERT INTO patient (name) VALUES ('joe');
INSERT INTO patient (name) VALUES ('fred');
INSERT INTO patient (name) VALUES ('john');
INSERT INTO patient (name) VALUES ('peter');

insert into claim (person_id, amount) values (1, 5);
insert into claim (person_id, amount) values (1, 10);
insert into claim (person_id, amount) values (1, 15);
insert into claim (person_id, amount) values (2, 2);
insert into claim (person_id, amount) values (2, 4);
insert into claim (person_id, amount) values (3, 1);
insert into claim (person_id, amount) values (3, 3);
insert into claim (person_id, amount) values (3, 6);
insert into claim (person_id, amount) values (4, 11);
insert into claim (person_id, amount) values (5, 22);
insert into claim (person_id, amount) values (5, 23);

insert into doctor (patient_id, doc_name) values (1, 'Doc Brown');
insert into doctor (patient_id, doc_name) values (2, 'Doc Brown');

insert into bank values (1, 'Bank of America');
insert into bank values (2, 'Key Bank');
insert into bank values (3, 'Union Bank');
insert into bank values (4, 'ESL');

insert into patient_bank (patient_id, bank_id) values (1,1);
insert into patient_bank (patient_id, bank_id) values (2,1);
insert into patient_bank (patient_id, bank_id) values (3,1);
insert into patient_bank (patient_id, bank_id) values (4,2);
insert into patient_bank (patient_id, bank_id) values (5,2);

-- Find the total amount of claims for all patients.
select sum(amount) from claim;

-- Find the total amount of claims for EACH patient, ordered by patient id.
select 
  p.name,
  sum(c.amount) as total_claims
from patient p
  join claim c on p.patient_id = c.patient_id
group by p.name
order by p.patient_id;

-- Create view from: "Find the total amount of claims for EACH patient, ordered by patient id" query. (A view is an abstraction of one or more tables).
create view vwPatientClaims as
  select 
    p.name,
    sum(c.amount) as total_claims
  from patient p
    join claim c on p.patient_id = c.patient_id
  group by p.name

-- Use the view to return three lowest claims.
select * from vwPatientClaims order by total_claims limit 3; -- Return top 3.

-- Find the patients that do not have doctors.
-- A left join returns nulls from the right table.
select 
  p.name
from patient p 
  left join doctor d on p.patient_id = d.patient_id
where 
  d.doctor_id is null;

-- A right join returns nulls from the left table.
select 
  p.name
from doctor d
  right join patient p on p.patient_id = d.patient_id
where 
  d.doctor_id is null;

/* PROTIP: USE THE LEFT JOIN AS YOUR GOTO DIRECTION. */

-- Find the patients who have doctors and active claims.
select 
  distinct(p.name)
from
  patient p 
  join doctor d on p.patient_id = d.patient_id
  join claim c on p.patient_id = c.patient_id
where 
  c.is_active = true

-- Find the names of the patients that belong to Bank of America.
select 
  p.name
from 
  patient p 
join patient_bank pb on p.patient_id = pb.patient_id
join bank b on b.bank_id = pb.bank_id
where 
  b.name = 'Bank of America'
