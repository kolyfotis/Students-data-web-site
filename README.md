# Students-data-web-page

This is a web site where students can upload their data, and view other students' data. This is a project i had to complete during the 8th semester of my studies, for the course "Databases 2". It was supposed to be done by a group of 2 people, but unfortunately i did not find someone to work with, and i had to do it alone. For this reason there were many occasions when i had to choose the quickest way to get things done, instead of choosing the most optimal way. The deadline was 2 weeks, so this is what i managed to complete whithin the deadline. The project was implemented with Java Server Pages (.jsp).



## Requirements

### Website for posting students' CVs

Design and implement a web site where the students from the university can upload their CVs. Students can log in to the site and upload data such as:

	1. Surname, first name
	
	2. Department, faculty, institution
	
	3. A short CV up to 500 words
	
	4. Birthdate, or birth year
	
	5. Scientific interests (e.g. Databases, Software Engineering, etc.)
	
	6. Quotes with short description on several subjects, with the date which the quote was posted.
	
	7. Photos
	
	8. Videos
	
	9. Languages and the level of each language
	
	10. Hobbies, preferably from a list.


**Database Restrictions**

	1. One student belongs to one department, one faculty, one institution
	
	2. Each student has one surname, first name, date of birth, one CV, and many quotes. Student's quotes have a unique number each one and the date they were posted.
	
	3. Each student can upload many photos, which have a unique number each one, and many videos which have a unique number each one as well.
	
	4. Each interest can be assigned to many students and each student can have many interests.
	
	5. Each language can be assigned to many students and each student can have many languages assigned. For each language there is also a level registered. The levels are four: Elementary, Intermediate, Advanced, Proficient.
	
	6. Each hobby can be assigned to many students and each student can have many hobbies.
	
	7. Interests, languages, language levels, and hobbies are saved in separate tables.
	
	
**The user of the web site can see:**

	1. The CV of a specific student
	
	2. All CVs sorted alphabetically
	
	3. All CVs related to a specific interest
	
	4. All CVs related to a specific institution
	
	5. How many CVs have been uploaded for each institution
	
	6. How many CVs have been uploaded for each interest
	

**Deliverables:**

	1. Design of the database (EER model)
	
	2. Database implementation, and parameters (IP, port, database, user, password)
	
	3. Implementation of triggers, proceures and functions
	
	4. System architecture (web pages, how they call each other, short description of each web page)
	
	5. Code of the web pages



## Project Description

###Features

1. Users can `log in` to the web site or create a new account (`register`). After logging in succesfully the current user's ID will be saved to the current `session`.
	
2. Users can `view` and `edit` their data (`First Name`, `Last Name`, `Institution`, `Faculty`, `Department`, `CV description`, `Birth Date`, `Interests`, `Languages` and `Hobbies`). There is also some data displayed, such as Quotes, Photos and Videos, but is not functional since i did not have enough time to write the necessary code. Each field is updated separately. First Name, Last Name, Institution, Faculty, Department, CV description and Languages are updated with `text` as input. Interests, Hobbies and Language Level have a `drop down list` with some options as input.
	
3. After updating their data, users can `log out`  and `return to the home page`.
	
4. Additionally users can `read the CV of a student searching by name`. Both `First Name` and `Last Name` text fields have to be filled in correctly.
	
5. Finally users can `read all CVs sorted alphabetically`. Only CVs with valid (not null) `First Name` and `Last Name` will be displayed.



## Technologies used

### IDEs

	1. MySQL Workbench
	
	2. NetBeansIDE

### Languages
	
	1. Java
	
	2. MySQL
	
	3. HTML

### APIs

	1. JDBC (Java Database Connectivity)



## Pages description

1. `home.jsp` is the Home Page. It displays a Welcome message and allows users to navigate to `login.jsp`, `register.jsp` and `selection.jsp` pages.
	
2. `login.jsp` contains a form where users can insert their user name and password in order to log in.
	
3. `register.jsp` contains a form where users can insert a user name and a password in order to create a new account.
	
4. `login_check.jsp` checks the user's input while trying to log in and displays the appropriate message and options depending on the input. If it's valid user can gain access to `edit.jsp`, otherwise he can try again, register a new account, or return to the home page.
	
5. `reg_check.jsp` checks the user's input while trying to register a new account. If the user name is already in use a message is displayed and allows the user to try again with a new user name, otherwise displays a message of success and allows the user to log in to his account.
	
6. `edit.jsp` displays the user's data (`First Name`, `Last Name`, `Institution`, `Faculty`, `Department`, `CV description`, `Birth Date`, `Interests`, `Languages` and `Hobbies`). They can be updated separately using text fields or drop down lists. `edit.jsp` calls `update.jsp` every time the user tries to update a field.
	
7. `update.jsp` is being called from `edit.jsp` every time users try to update their data, and is only responsible for this puprose.
	
8. `selection.jsp` displays the options users have in order to read CVs. Only two options are currently working. `Read the CV of a student searching by name` and `Read all CVs sorted alphabetically`. `selection.jsp` calls `result.jsp` to preview the results of the search.
	
9. `result.jsp` displays the result of the search based on the user's input in `selection.jsp`.


## Run instructions

First of all you will need `MySQL Workbench` and `NetBeansIDE` installed. You can also use different tools and IDEs, but i will give the instructions based on those that i have used.

1. Launch `MySQL Workbench` and create a connection with a `Port`, `user name` and `password`.
	
2. Open the connection. Open the `database.sql` file and run it in order to create the database.
	
3. Make sure to `start` the server, if it's not already running. `Server` -> `Startup/Shutdown`.
	
4. Now launch `NetBeansIDE`, and `open` the project. You will have to change the values of `studentsDatabase` String in the following files to make sure that it's contents will match your database's attributes. You can edit the line below and just copy and paste it in the files.
	
	String studentsDatabase = "jdbc:mysql://localhost:YOUR_PORT/project?user=YOUR_USER_NAME&password=YOUR_PASSWORD";
	
	- result.jsp, line 27
	- edit.jsp, line 19
	- login_check.jsp, line 18
	- reg_check.jsp, line 21
	- selection.jsp, line 12
	- update.jsp, line 18
	
5. You can `run` the project by right clicking on the project name on the left tab named `Projects` and then click `Run`.

I would not recommend to change values directly from the database, but use the web pages instead.
