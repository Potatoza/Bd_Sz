
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
	
CREATE TABLE dayc(
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
	daycc datetime,
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

	alter table performers add constraint fk_performers_day FOREIGN KEY (id_day) REFERENCES dayc(id);
	
	alter table performers add constraint fk_performers_equipment FOREIGN KEY (id_equipment) REFERENCES equipment(id);
	alter table performers add CONSTRAINT unique_artistname UNIQUE NONCLUSTERED (artistname);
	
     
	alter table camping add constraint fk_camping_area FOREIGN KEY (id_area) REFERENCES area(id);

	alter table foodcourt add constraint fk_foodcourt_area FOREIGN KEY (id_area) REFERENCES area (id);
	
    alter table dayc add constraint fk_ticket_day FOREIGN KEY (id_ticket) REFERENCES ticket(id);
    
    alter table program add constraint fk_program_scene FOREIGN KEY (id_scene) REFERENCES scene(id);
	alter table program add constraint fk_program_performer FOREIGN KEY (id_performer) REFERENCES performers(id);
    
INSERT INTO area VALUES (1,'jazz zone')
INSERT INTO area VALUES(2,'green zone')
INSERT INTO area VALUES(3,'hard rock zone')	
INSERT INTO area VALUES(4,'chill zone')	
INSERT INTO area VALUES(5,'indie zone')

INSERT INTO camping(id, name, conditions, number_of_tents, square, id_area)VALUES (1, 'simple', 'public toilet', 8, 24.4, 2)
INSERT INTO camping(id, name, conditions, number_of_tents, square, id_area)VALUES(2, 'improved', 'public toilet', '5', 35.4, '1')
INSERT INTO camping(id, name, conditions, number_of_tents, square, id_area)VALUES(3, 'bronze', 'public toilet', '8', 46.4, '3')
INSERT INTO camping(id, name, conditions, number_of_tents, square, id_area)VALUES(4, 'silver', 'private toilet', '6', 54.4, '4')
INSERT INTO camping(id, name, conditions, number_of_tents, square, id_area)VALUES(5, 'golden', 'private toilet', '5', 64.4, '5')

INSERT INTO ticket_type VALUES (1,'GOLD','offers you to visit each concert + free drinks')
INSERT INTO ticket_type VALUES(2,'SILVER','offers you to visit each concert')
INSERT INTO ticket_type VALUES(3,'BRONZE','offers you to visit main scene and master card scene + drinks')
INSERT INTO ticket_type VALUES(4,'EXTRAGOLD','offers you to visit each concert + free drinks + camping')
INSERT INTO ticket_type VALUES(5,'EXTRASILVER','offers you to visit each concert + camping')

    
    
INSERT INTO visitor VALUES (56789,'Helen','Dimitrieva')
INSERT INTO visitor VALUES(12904,'Olga','Yankovskaya')
INSERT INTO visitor VALUES(20394,'John','Smith')
INSERT INTO visitor VALUES(40392,'Jack','Hugo')
INSERT INTO visitor VALUES(51234,'Alice','Merton')
                            
INSERT INTO equipment(id, type, quantity) VALUES (1, 'sound', 10)
INSERT INTO equipment(id, type, quantity) VALUES(2, 'lights', 15)
INSERT INTO equipment(id, type, quantity) VALUES(3, 'special effects', 5)
INSERT INTO equipment(id, type, quantity) VALUES(4, 'instruments', 100)
INSERT INTO equipment(id, type, quantity) VALUES(5, 'other', 10)


INSERT INTO foodcourt(id, name, number_of_tents, id_area) VALUES (1, 'sector1', '10', 1)
INSERT INTO foodcourt(id, name, number_of_tents, id_area) VALUES(2, 'sector2', '15', 3)
INSERT INTO foodcourt(id, name, number_of_tents, id_area) VALUES(3, 'sector3', '12', 2)
INSERT INTO foodcourt(id, name, number_of_tents, id_area) VALUES(4, 'sector4', '20', 5)
INSERT INTO foodcourt(id, name, number_of_tents, id_area) VALUES(5, 'sector5', '25', 4)

INSERT INTO sponsor(id, name, principal, representor) VALUES(1, 'Airlines', 'John', 'John1')
INSERT INTO sponsor(id, name, principal, representor) VALUES(2,'Motors', 'Devid', 'Devid1')
INSERT INTO sponsor(id, name, principal, representor) VALUES(3, 'Food', 'Mark', 'Mark1')
INSERT INTO sponsor(id, name, principal, representor) VALUES(4, 'Academy', 'Kevin', 'Kevin1')
INSERT INTO sponsor(id, name, principal, representor) VALUES(5, 'Hotel', 'Alisa', 'Alisa1')

  
  INSERT INTO volunteer(id, name, surname, age, sex, country) VALUES (1, 'Petro', 'V', 19, 'm', 'Ukraine')
INSERT INTO volunteer(id, name, surname, age, sex, country) VALUES (2, 'Mary', 'B', 20, 'f', 'Ukraine')
INSERT INTO volunteer(id, name, surname, age, sex, country) VALUES (3, 'Max', 'C', 24, 'm', 'Poland')
INSERT INTO volunteer(id, name, surname, age, sex, country) VALUES (4, 'Jenifer', 'S', 22, 'f', 'Germany')
INSERT INTO volunteer(id, name, surname, age, sex, country) VALUES (5, 'Stepan', 'D', 25, 'm', 'Ukraine')

INSERT INTO ticket (id, id_ticket_type, id_area, id_visitor) VALUES(1,1,5,56789)
INSERT INTO ticket (id, id_ticket_type, id_area, id_visitor) VALUES(2,5,4,20394)
INSERT INTO ticket (id, id_ticket_type, id_area, id_visitor) VALUES(3,4,3,12904)
INSERT INTO ticket (id, id_ticket_type, id_area, id_visitor) VALUES(4,2,2,40392)
INSERT INTO ticket (id, id_ticket_type, id_area, id_visitor) VALUES(5,3,1,51234)

INSERT INTO dayc(id, number_of_tickets, id_ticket) VALUES (1, 200, 1)
INSERT INTO dayc(id, number_of_tickets, id_ticket) VALUES(2, 300, 2)
INSERT INTO dayc(id, number_of_tickets, id_ticket) VALUES(3, 400, 4)
INSERT INTO dayc(id, number_of_tickets, id_ticket) VALUES(4, 500, 3)
INSERT INTO dayc(id, number_of_tickets, id_ticket) VALUES(5, 600, 5)
                                                         
INSERT INTO performers (id, pname,psurname ,artistname ,country ,date_arrive ,date_leave ,id_equipment ,id_day )VALUES(1,'Theo','Hutchcraft','Hurts','England','2018-03-02','2018-02-04',1,1)
INSERT INTO performers (id, pname,psurname ,artistname ,country ,date_arrive ,date_leave ,id_equipment ,id_day )VALUES (2,'Jared','Leto','30 seconds to Mars','USA','2018-03-02','2018-02-04',4,4)
INSERT INTO performers (id, pname,psurname ,artistname ,country ,date_arrive ,date_leave ,id_equipment ,id_day )VALUES(3,'Zarra','Larson','-','USA','2018-03-02','2018-02-04',5,2)
INSERT INTO performers (id, pname,psurname ,artistname ,country ,date_arrive ,date_leave ,id_equipment ,id_day )VALUES(4,'Jack','Bim','The Kooks','USA','2018-03-02','2018-02-04',2,5)
INSERT INTO performers (id, pname,psurname ,artistname ,country ,date_arrive ,date_leave ,id_equipment ,id_day )VALUES(5,'Charlie','Puth','--','USA','2018-03-02','2018-02-04',3,3)


INSERT INTO scene (id, id_area, id_performer, name, id_volunteer, id_sponsor ) VALUES(1,2,5,'MAIN',2,1)
INSERT INTO scene (id, id_area, id_performer, name, id_volunteer, id_sponsor ) VALUES(2,2,4,'SILVER',3,3)
INSERT INTO scene (id, id_area, id_performer, name, id_volunteer, id_sponsor ) VALUES(3,3,3,'ROCK',4,2)
INSERT INTO scene (id, id_area, id_performer, name, id_volunteer, id_sponsor ) VALUES(4,4,2,'MASTER CARD',5,4)
INSERT INTO scene (id, id_area, id_performer, name, id_volunteer, id_sponsor ) VALUES(5,1,1,'INDIE',1,5)


INSERT INTO program(id, daycc, id_performer, id_scene) VALUES (1, '2019-08-13', 1, 1)
INSERT INTO program(id, daycc, id_performer, id_scene) VALUES(2, '2019-08-14', 2, 3)
INSERT INTO program(id, daycc, id_performer, id_scene) VALUES(3, '2019-08-15', 3, 2)
INSERT INTO program(id, daycc, id_performer, id_scene) VALUES(4, '2019-08-16', 4, 5)
INSERT INTO program(id, daycc, id_performer, id_scene) VALUES(5, '2019-08-17', 5, 4)


/**показує імя і прізвище найстаршого волонтера
shows name and surname of the oldest volunteer
*/
SELECT name as Name, surname as Surname, age as Age from volunteer where age=(select max(age) from volunteer);
 /**counts and shows the quantity of tickets */
 select count(*)  as quantity from ticket;
 /** shows description and name  of ticket type  if name of ticket like '%___D' / показує ім'я та опис типу квитка, якщо ім'я типу квитка розпочинається із будь-якого символа та містить щонайменше 4 символи та закінчується на літеру 'D' */
 select name, description from ticket_type where name like '%___D';
 /**shows scene name and artist name where artist is from England / показує  назву сцени та назву артиста, який є з Англії*/
 select name as SceneName, artistname from scene inner join performers on scene.id_performer=performers.id where country='England';
  /**показує всіх виконавців/ shows all performers*/
 select * from performers
/**показує та обраховує середню кількість інвентару / counts and shows average quantity of equipment*/
SELECT AVG(quantity) AS AVG FROM equipment;
/**shows performers' name, surname, artistname and equipment where equipment is special effects*/
SELECT performers.pname, performers.psurname, performers.artistname, equipment.type
	FROM performers inner join equipment on performers.id_equipment=equipment.id
		WHERE equipment.type='special effects';
        
        /** Покзатаи унікальні країни з таблиці волонтер
        shows distinct countries from volunteer
        */
SELECT DISTINCT country FROM volunteer;
/** показати  інформацію про квитики 'GOLD'і 'BRONZE'
shows information about gold and bronxe tickets
  */
SELECT * FROM ticket_type WHERE name IN('GOLD', 'BRONZE');

select id FROM dayc where number_of_tickets=(select MAX(number_of_tickets) from dayc);
//** показати виконавців і кількість відвідувачів у найбільш людний день(найбільшою кількістю відвідувачів)
shows performers and visitors quantity on the day with the bigest visitors quantity
*/
SELECT performers.pname, performers.psurname, performers.artistname, dayc.number_of_tickets
	FROM performers inner join dayc on performers.id_day=dayc.id
		WHERE dayc.id=(Select id FROM dayc where number_of_tickets=(select MAX(number_of_tickets) from dayc));
		
/** показати артистів з найбільшою кількістю обладнання і  сцену на яких они виступали
shows performers with the bigest equipment quatity and scene where they performed
 */
Select performers.pname, performers.psurname,performers.artistname, scene.name 
	from scene inner join performers on scene.id_performer=performers.id
    where performers.id_equipment = (select id from equipment where quantity = (select max(quantity) from equipment));
    
/**Порахувати кількість виконавців з амеhики
counts quantity of american performers
*/
SELECT count(*) as american_performers from performers where country= 'USA'
