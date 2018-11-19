DROP DATABASE IF EXISTS sziget;
CREATE database sziget;
use sziget;
CREATE TABLE area(
id INT NOT NULL PRIMARY KEY,
	name nvarchar(40) NOT NULL);
 CREATE TABLE scene(
	id INT NOT NULL PRIMARY KEY,
	id_area INT NOT NULL,
	id_performer  INT NOT NULL,
	name nvarchar(40), 
	id_volunteer int,
	id_sponsor int);      
CREATE TABLE ticket(
	id INT NOT NULL PRIMARY KEY,
	id_ticket_type INT NOT NULL,
	id_area INT NOT NULL,
	id_visitor INT NOT NULL);
CREATE TABLE ticket_type(
	id INT NOT NULL PRIMARY KEY,
	name nvarchar(40),
	description nvarchar(100)	
	);
CREATE TABLE visitor(
	passport_id INT NOT NULL PRIMARY KEY,
	vname nvarchar(40),
	vsurname nvarchar(40));
CREATE TABLE performers(
	id INT NOT NULL PRIMARY KEY,
	pname nvarchar(40),
	psurname nvarchar(40),
	artistname nvarchar(40),
	country nvarchar(40),
	date_arrive datetime,
	date_leave datetime,
	id_equipment int,
	id_day int not null
	);	
CREATE TABLE camping(
	id INT NOT NULL PRIMARY KEY,
	name nvarchar(15),
	conditions nvarchar(35) ,
	number_of_tents int,
	square decimal(6,3),
	id_area int);
CREATE TABLE foodcourt (
	id INT NOT NULL PRIMARY KEY,
	name nvarchar(15),
	number_of_tents int,
	id_area int);
CREATE TABLE sponsor (
	id INT NOT NULL PRIMARY KEY,
	name nvarchar(20),
	principal nvarchar(20),
	representor nvarchar(20)
	);
CREATE TABLE volunteer(
	id INT NOT NULL PRIMARY KEY,
	name nvarchar(20),
	surname nvarchar(20),
	age tinyint,
	sex nvarchar(10),
	country nvarchar(20));
CREATE TABLE day(
	id INT NOT NULL PRIMARY KEY,
	number_of_tickets int,
	id_ticket int) ;
CREATE TABLE equipment(
	id INT NOT NULL PRIMARY KEY,
	type nvarchar(30),
	quantity int
	);
CREATE TABLE program(
	id INT NOT NULL PRIMARY KEY,
	day datetime,
	id_performer int,
	id_scene int);
    
	alter table scene add constraint fk_scene_area FOREIGN KEY(id_area) REFERENCES area(id);
	alter table scene add constraint fk_scene_performer FOREIGN KEY (id_performer) REFERENCES performers(id);
    alter table scene add constraint fk_scene_volunteer FOREIGN KEY (id_volunteer) REFERENCES volunteer(id);
	alter table scene add constraint fk_sponsor_scene FOREIGN KEY (id_sponsor) REFERENCES sponsor(id);
    
    alter table ticket add constraint fk_ticket_type FOREIGN KEY (id_ticket_type) REFERENCES ticket_type(id);
	alter table ticket add constraint fk_ticket_area FOREIGN KEY (id_area) REFERENCES area(id);
	alter table ticket add constraint fk_ticket_visitor  FOREIGN KEY (id_visitor) REFERENCES visitor(passport_id);
    
    alter table visitor add CONSTRAINT unique_visitor UNIQUE NONCLUSTERED (passport_id);

	alter table performers add constraint fk_performers_day FOREIGN KEY (id_day) REFERENCES day(id);
	alter table performers add constraint fk_performers_equipment FOREIGN KEY (id_equipment) REFERENCES equipment(id);
	alter table performers add CONSTRAINT unique_artistname UNIQUE NONCLUSTERED (artistname);
	
       //* "alter table camping add constraint check_numb_tents  CHECK NOT FOR REPLICATION (number_of_tents LIKE (1-8));"
alter table camping drop constraint check_numb_tents;*/
	alter table camping add constraint fk_camping_area FOREIGN KEY (id_area) REFERENCES area(id);

	alter table foodcourt add constraint fk_foodcourt_area FOREIGN KEY (id_area) REFERENCES area (id);
	
	alter table volunteer add constraint check_volunteer_age CHECK (age IN (18-30));
	//*alter table volunteer drop check_volunteer_age;*/
    
    alter table day add constraint fk_ticket_day FOREIGN KEY (id_ticket) REFERENCES ticket(id);
    
    alter table program add constraint fk_program_scene FOREIGN KEY (id_scene) REFERENCES scene(id);
	alter table program add constraint fk_program_performer FOREIGN KEY (id_performer) REFERENCES performers(id);
    
INSERT INTO area VALUES (1,'jazz zone'),
						(2,'green zone'),
                        (3,'hard rock zone'),	
                        (4,'chill zone'),	
                        (5,'indie zone');

INSERT INTO camping(id, name, conditions, number_of_tents, square, id_area)VALUES
					(1, 'simple', 'public toilet', 8, 24.4, 2),
                    (2, 'improved', 'public toilet', '5', 35.4, '1'),
                    (3, 'bronze', 'public toilet', '8', 46.4, '3'),
                    (4, 'silver', 'private toilet', '6', 54.4, '4'),
                    (5, 'golden', 'private toilet', '5', 64.4, '5');

INSERT INTO ticket_type VALUES  (1,'GOLD','offers you to visit each concert + free drinks'),
								(2,'SILVER','offers you to visit each concert'),
								(3,'BRONZE','offers you to visit main scene and master card scene + drinks'),
								(4,'EXTRAGOLD','offers you to visit each concert + free drinks + camping'),
								(5,'EXTRASILVER','offers you to visit each concert + camping');
	select * from ticket_type;
    
    
INSERT INTO visitor VALUES (56789,'Helen','Dimitrieva'),
							(12904,'Olga','Yankovskaya'),
							(20394,'John','Smith'),
							(40392,'Jack','Hugo'),
							(51234,'Alice','Merton');
                            
INSERT INTO equipment(id, type, quantity) VALUES (1, 'sound', 10),
												(2, 'lights', 15),
												(3, 'special effects', 5),
												(4, 'instruments', 100),
												(5, 'other', 10);

	select * from visitor;
INSERT INTO foodcourt(id, name, number_of_tents, id_area) VALUES (1, 'sector1', '10', 1),
																(2, 'sector2', '15', 3),
																(3, 'sector3', '12', 2),
																(4, 'sector4', '20', 5),
																(5, 'sector5', '25', 4);

INSERT INTO sponsor(id, name, principal, representor) VALUES (1, 'Airlines', 'John', 'John1'),
																(2,'Motors', 'Devid', 'Devid1'),
																(3, 'Food', 'Mark', 'Mark1'),
																(4, 'Academy', 'Kevin', 'Kevin1'),
                                                                (5, 'Hotel', 'Alisa', 'Alisa1');
	SELECT * FROM sponsor;
  
  INSERT INTO volunteer(id, name, surname, age, sex, country) VALUES (1, 'Petro', 'V', 19, 'm', 'Ukraine'),
																	(2, 'Mary', 'B', 20, 'f', 'Ukraine'),
																	(3, 'Max', 'C', 24, 'm', 'Poland'),
																	(4, 'Jenifer', 'S', 22, 'f', 'Germany'),
																	(5, 'Stepan', 'D', 25, 'm', 'Ukraine');

INSERT INTO ticket (id, id_ticket_type, id_area, id_visitor) VALUES (1,1,5,56789),
																	(2,5,4,20394),
																	(3,4,3,12904),
																	(4,2,2,40392),
																	(5,3,1,51234);

INSERT INTO day(id, number_of_tickets, id_ticket) VALUES (1, 200, 1),
														 (2, 300, 2),
														 (3, 400, 4),
														 (4, 500, 3),
														 (5, 600, 5);
                                                         
INSERT INTO performers (id, pname,psurname ,artistname ,country ,date_arrive ,date_leave ,id_equipment ,id_day )VALUES
						(1,'Theo','Hutchcraft','Hurts','England','2018-03-02','2018-02-04',1,1),
						(2,'Jared','Leto','30 seconds to Mars','USA','2018-03-02','2018-02-04',4,4),
						(3,'Zarra','Larson','-','USA','2018-03-02','2018-02-04',5,2),
						(4,'Jack','Bim','The Kooks','USA','2018-03-02','2018-02-04',2,5),
						(5,'Charlie','Puth','--','USA','2018-03-02','2018-02-04',3,3);

INSERT INTO scene (id, id_area, id_performer, name, id_volunteer, id_sponsor ) VALUES 
					(1,2,5,'MAIN',2,1),
					(2,2,4,'SILVER',3,3),
                    (3,3,3,'ROCK',4,2),
                    (4,4,2,'MASTER CARD',5,4),
                    (5,1,1,'INDIE',1,5);


INSERT INTO program(id, day, id_performer, id_scene) VALUES (1, '2019-08-13', 1, 1),
															(2, '2019-08-14', 2, 3),
                                                            (3, '2019-08-15', 3, 2),
                                                            (4, '2019-08-16', 4, 5),
                                                            (5, '2019-08-17', 5, 4);
