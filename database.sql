#create database project;
#use project;
drop table if exists assign_students_hobbies;
drop table if exists hobbies;
drop table if exists assign_students_interests;
drop table if exists quotes;
drop table if exists photos;
drop table if exists videos;
drop table if exists assign_students_languages;
drop table if exists languages;
drop table if exists language_levels;
drop table if exists students;
drop table if exists users;
drop table if exists interests;


create table users(user_id int(4) auto_increment, user_name varchar(255), pass_word varchar(255), primary key (user_id));

create table students(student_id int(4), student_lastname varchar(255), student_firstname varchar(255),
						student_institution varchar(255), student_faculty varchar(255), student_department varchar(255),
                        student_cv text, student_birth_date date, primary key (student_id),
                        foreign key (student_id) references users(user_id));
                        
create table interests(interest_id int(4) auto_increment, interest_description varchar(255), primary key (interest_id));

create table assign_students_interests(assign_student_id int(4), assign_interest_id int(4), primary key (assign_student_id, assign_interest_id),
										foreign key (assign_student_id) references students(student_id),
										foreign key (assign_interest_id) references interests(interest_id));


create table quotes(quote_id int(4) auto_increment, quote_description text, quote_date date, quote_student_id int(4),
					primary key (quote_id), foreign key (quote_student_id) references students(student_id));
                    
create table photos(photo_id int(4) auto_increment, photo_content blob(10000000), photo_date date, photo_student_id int(4),
					primary key (photo_id), foreign key (photo_student_id) references students(student_id));
#up to 10 MB per photo

create table videos(video_id int(4) auto_increment, video_content blob(50000000), video_date date, video_student_id int(4),
					primary key (video_id), foreign key (video_student_id) references students(student_id));
#up to 50 MB per video

create table languages(language_id int(4) auto_increment, language_description varchar(255),
						primary key (language_id));
                        
                        
create table language_levels(level_id int (2) auto_increment, level_description varchar(32), 
									primary key (level_id));


create table assign_students_languages(assign_student_id int(4), assign_language_id int(4), assign_language_level_id int(2),
										primary key (assign_student_id, assign_language_id, assign_language_level_id), 
                                        foreign key (assign_student_id) references students(student_id),
                                        foreign key (assign_language_id) references languages(language_id),
                                        foreign key (assign_language_level_id) references language_levels (level_id));


create table hobbies(hobby_id int(4) auto_increment, hobby_description varchar(50),
					primary key (hobby_id));
                    
create table assign_students_hobbies(assign_hobby_id int(4), assign_student_id int(4),
									primary key(assign_hobby_id, assign_student_id),
                                    foreign key (assign_hobby_id) references hobbies(hobby_id),
                                    foreign key (assign_student_id) references students(student_id));



------------------------------------------------------------------------------


#FILL INTERESTS TABLE

insert into interests(interest_description)
	values ('Database');
	
insert into interests(interest_description)
	values ('Web Programming');
    
insert into interests(interest_description)
	values ('Human Computer Interaction');

insert into interests(interest_description)
	values ('Data Mining');
    
insert into interests(interest_description)
	values ('Software Engineering');
    
insert into interests(interest_description)
	values ('Information Retrieval');
    
insert into interests(interest_description)
	values ('Machine Learning');
    
insert into interests(interest_description)
	values ('Software Quality');
    
insert into interests(interest_description)
	values ('E-Commerce');
    
insert into interests(interest_description)
	values ('Management Information Systems');

insert into interests(interest_description)
	values ('Information Systems');
    
insert into interests(interest_description)
	values ('Network Engineering');
    
insert into interests(interest_description)
	values ('Hardware Engineering');
	

	
	
	
------------------------------------------------------------------------------


#FILL HOBBIES TABLE


insert into hobbies(hobby_description)
	values('Backgammon');
insert into hobbies(hobby_description)
	values('Basketball');
insert into hobbies(hobby_description)
	values('Bicycling');
insert into hobbies(hobby_description)
	values('Board Games');
insert into hobbies(hobby_description)
	values('Camping');
insert into hobbies(hobby_description)
	values('Canoeing');
insert into hobbies(hobby_description)
	values('Chess');
insert into hobbies(hobby_description)
	values('Collecting');
insert into hobbies(hobby_description)
	values('Cooking');
insert into hobbies(hobby_description)
	values('Dancing');
insert into hobbies(hobby_description)
	values('Exercise');
insert into hobbies(hobby_description)
	values('Football');
insert into hobbies(hobby_description)
	values('Guitar');
insert into hobbies(hobby_description)
	values('Hiking');
insert into hobbies(hobby_description)
	values('Movies');
insert into hobbies(hobby_description)
	values('Music');
insert into hobbies(hobby_description)
	values('Relaxing');
insert into hobbies(hobby_description)
	values('Shopping');
insert into hobbies(hobby_description)
	values('Video Games');
insert into hobbies(hobby_description)
	values('Yoga');
	
	
	
------------------------------------------------------------------------------

#TRIGGER FOR STUDENTS ID ON STUDENTS



drop trigger if exists insert_student_id;

delimiter #

create trigger insert_student_id
	after insert on users
    for each row
	begin
		insert into students (student_id) values (new.user_id);
	end#

delimiter ;

------------------------------------------------------------------------------

#TRIGGER FOR PHOTO DATE

drop trigger if exists insert_photo_date;

create trigger insert_photo_date
before insert on photos
for each row
set new.photo_date = now();




------------------------------------------------------------------------------


#TRIGGER FOR VIDEO DATE

drop trigger if exists insert_video_date;

create trigger insert_video_date
before insert on videos
for each row
set new.video_date = now();






------------------------------------------------------------------------------


#TRIGGER FOR QUOTE DATE
    
drop trigger if exists insert_quote_date;

create trigger insert_quote_date
before insert on quotes
for each row
set new.quote_date = now();




