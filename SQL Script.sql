CREATE TABLE kindergarten.group
(group_id   BIGSERIAL PRIMARY KEY,
 group_name TEXT NOT NULL, 
 classroom_number INTEGER NOT NULL);
 
INSERT INTO kindergarten.group( group_name,classroom_number)
VALUES ('Honeybees', 3),
	   ('Sparrows', 4);
	   
	
-------------------------------------------------------------
CREATE TABLE kindergarten.address
(address_id BIGSERIAL PRIMARY KEY,
city TEXT NOT NULL,
postcode TEXT NOT NULL,
street TEXT NOT NULL,
street_number INTEGER NOT NULL);

ALTER TABLE kindergarten.address 
ADD COLUMN appartment_number INTEGER;


INSERT INTO kindergarten.address (city, postcode,street,street_number,appartment_number)
VALUES ('Lodz','94-302','Krakowska',8,5),
       ('Lodz','92-432', 'Wilenska',10,12),
       ('Pabianice', '95-543', 'Obywatelska', 50,9),
       ('Zgierz','91-010', 'Cudna',15,NULL),
       ('Lodz','92-310', 'Ziemowita',45,7);
       

--------------------------------------------------------------
CREATE TABLE kindergarten.child
( child_id BIGSERIAL PRIMARY KEY,
  group_id BIGINT NOT NULL REFERENCES kindergarten.group,
  address_id BIGINT NOT NULL REFERENCES kindergarten.address,
  name TEXT NOT NULL,
  surname TEXT NOT NULL,
  birth_data DATE NOT NULL);

  
 INSERT INTO kindergarten.child ( group_id,address_id,name,surname,birth_date)
 VALUES (1,1,'Anna','Kowalczyk','2020-12-15':: DATE),
 		(1,2,'Marek','Las','2020-06-02':: DATE),
 		(2,3,'Katarzyna', 'Pyszowska','2019-09-01'::DATE),
 		(2,1, 'Leon','Kowalczyk','2019-03-30'::DATE);
 	

 		
------------------------------------------------------------------
 
 CREATE TABLE kindergarten.teacher
 (teacher_id BIGSERIAL PRIMARY KEY,
 group_id BIGINT NOT NULL REFERENCES kindergarten.group,
 address_id BIGINT NOT NULL REFERENCES kindergarten.address,
 name TEXT NOT NULL,
 surname TEXT NOT NULL,
 email TEXT NOT NULL,
 telephone INTEGER NOT NULL);


 
INSERT INTO kindergarten.teacher (group_id, address_id, name, surname, email, telephone)
VALUES ( 1,5,'Magdalena','Miki','miki.magdalena@o2.pl',546875254),
       ( 2,1, 'Zofia','Kowalczyk','kowalczyk.zofia@gmail.com',710584948);
       
-------------------------------------------
      
CREATE TABLE kindergarten.authorised_person
(authorised_person_id BIGSERIAL PRIMARY KEY,
address_id BIGINT NOT NULL REFERENCES kindergarten.address,
name TEXT NOT NULL,
surname TEXT NOT NULL,
email VARCHAR NOT NULL,
telephone INTEGER NOT NULL,
document_name TEXT NOT NULL,
document_number VARCHAR NOT NULL);


INSERT INTO kindergarten.authorised_person (address_id ,name,surname,email,telephone,document_name ,document_number)
VALUES (1,'Maja', 'Las','m.las@wp.pl', 506478954, 'Id_card', 'AYD124864'),
       (3,'Kamila','Pyszowska','pyszowska20@gmail.com',708458941,'Id_card','ZZA546987');
       
---------------------------------------------------
CREATE TABLE kindergarten.child_authorised
(child_id BIGINT NOT NULL REFERENCES kindergarten.child,
authorised_person_id BIGINT NOT NULL REFERENCES kindergarten.authorised_person);


INSERT INTO kindergarten.child_authorised (child_id, authorised_person_id)
VALUES  (2,1),
		(3,2);
	
		
--SELECT * FROM kindergarten.child_authorised;-----------------------------------------------
CREATE TABLE kindergarten.instructor
(instructor_id BIGSERIAL PRIMARY KEY, 
address_id BIGINT NOT NULL REFERENCES kindergarten.address,
name TEXT NOT NULL,
surname TEXT NOT NULL,
email VARCHAR NOT NULL,
specialization TEXT NOT NULL);


INSERT INTO kindergarten.instructor (address_id,name, surname, email,specialization)
VALUES (3,'Anna', 'Myszka', 'myszkaanna@o2.pl','swimmer'),
	   (1, 'Marcin', 'Nowak', 'm.nowak@gmail.com', 'judo');
	
-------------------------------------------------
CREATE TABLE kindergarten.paid_class 
(paid_class_id BIGSERIAL PRIMARY KEY,
address_id BIGINT NOT NULL REFERENCES kindergarten.address,
class_name TEXT NOT NULL,
classroom_number INTEGER NOT NULL,
week_day TEXT NOT NULL,
start_at TIME NOT NULL,
finish_at TIME NOT NULL,
is_outdoor BOOLEAN NOT NULL);


INSERT INTO kindergarten.paid_class ( address_id, class_name,classroom_number,week_day,start_at,finish_at, is_outdoor)
VALUES  (2, 'Judo', 5, 'Monday','13:00','13:45',False),
		(3, 'Swimming_pool', Null, 'Friday', '9:00','10:30', True );
----------------------------------------------------------------
	
CREATE TABLE kindergarten.instructor_paid_class
(instructor_id BIGINT NOT NULL REFERENCES kindergarten.instructor, 
paid_class_id BIGINT NOT NULL REFERENCES kindergarten.paid_class);


INSERT INTO kindergarten.instructor_paid_class(instructor_id, paid_class_id)
VALUES (1,5),
	   (2,6);
	  
----------------------------------------------------------------
	  
CREATE TABLE kindergarten.child_paid_class
(child_id BIGINT NOT NULL REFERENCES kindergarten.child,
paid_class_id BIGINT NOT NULL REFERENCES kindergarten.paid_class);


INSERT INTO kindergarten.child_paid_class (child_id, paid_class_id)
VALUES  (1,6),
		(2,5);
	
ALTER TABLE kindergarten.address ADD COLUMN record_ts DATE DEFAULT current_date NOT NULL;
ALTER TABLE kindergarten.authorised_person ADD COLUMN record_ts DATE DEFAULT current_date NOT NULL;
ALTER TABLE kindergarten.child ADD COLUMN record_ts DATE DEFAULT current_date NOT NULL;
ALTER TABLE kindergarten.child_authorised ADD COLUMN record_ts DATE DEFAULT current_date NOT NULL;
ALTER TABLE kindergarten.child_paid_class ADD COLUMN record_ts DATE DEFAULT current_date NOT NULL;
ALTER TABLE kindergarten.group ADD COLUMN record_ts DATE DEFAULT current_date NOT NULL;
ALTER TABLE kindergarten.instructor ADD COLUMN record_ts DATE DEFAULT current_date NOT NULL;
ALTER TABLE kindergarten.instructor_paid_class ADD COLUMN record_ts DATE DEFAULT current_date NOT NULL;
ALTER TABLE kindergarten.paid_class ADD COLUMN record_ts DATE DEFAULT current_date NOT NULL;
ALTER TABLE kindergarten.teacher ADD COLUMN record_ts DATE DEFAULT current_date NOT NULL;
	
	   