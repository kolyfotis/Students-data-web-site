<%-- 
    Document   : results
    Created on : May 24, 2017, 11:57:34 AM
    Author     : fotakias
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>

<%--
    Na ftiakso ta languages sto alphabetical (deixnei a, a)
    na bgalo tin loop pou emfanizei ta info ekso apo tin while & initialize
        variables ekso apo tin while
--%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Results</title>
    </head>
    <body>
        <%
            Class.forName("com.mysql.jdbc.Driver");
            String studentsDatabase = "jdbc:mysql://localhost:3306/project?user=root&password=1234";
            Connection myConnection = DriverManager.getConnection(studentsDatabase);

            Statement myStatement = myConnection.createStatement();

            boolean found = false;

            /*Display the CV of a Student by search*/
            if ((request.getParameter("full_name") != null) && (request.getParameter("firstname") != null) && (request.getParameter("lastname") != null)) {
                //search if student exists
                String firstName = request.getParameter("firstname");
                String lastName = request.getParameter("lastname");

                ResultSet rsStudentName = myStatement.executeQuery("select student_firstname, student_lastname, student_id from students");
                while (rsStudentName.next()) {
                    try {
                        
                        if ((rsStudentName.getString(1).equals(firstName)) && (rsStudentName.getString(2).equals(lastName))) {
                            int studentID = rsStudentName.getInt(3);
                            String fName = rsStudentName.getString(1);
                            String lName = rsStudentName.getString(2);

                            Statement studentInfoStatement = myConnection.createStatement();
                            ResultSet rsStudentInfo = studentInfoStatement.executeQuery("select student_institution, student_faculty, student_department, student_birth_date, student_cv from students where student_id = " + studentID + "");
                            rsStudentInfo.first();
                            String institution = rsStudentInfo.getString(1);
                            String faculty = rsStudentInfo.getString(2);
                            String department = rsStudentInfo.getString(3);
                            java.sql.Date birthDate = rsStudentInfo.getDate(4);
                            String cv = rsStudentInfo.getString(5);
                            rsStudentInfo.close();
                            studentInfoStatement.close();

                            //language[i] matches level[i]
                            String languages[] = new String[20];
                            String levels[] = new String[20];
                            //how many languages
                            int numOfLanguages = 0;
                            Statement assignStatement = myConnection.createStatement();
                            ResultSet rsAssign = assignStatement.executeQuery("select assign_student_id, assign_language_id, assign_language_level_id from assign_students_languages");

                            //out.println("is "+rs3.getInt(1)+" equal to "+studentID+" ?");
                            while (rsAssign.next()) {
                                int assignStudentID = rsAssign.getInt(1);
                                int assignLanguageID = rsAssign.getInt(2);
                                int assignLevelID = rsAssign.getInt(3);

                                //if the student knows at least one language
                                if (assignStudentID == studentID) {
                                    Statement languageStatement = myConnection.createStatement();
                                    ResultSet rsLanguage = languageStatement.executeQuery("select language_description from languages where language_id = '" + assignLanguageID + "'");

                                    if (rsLanguage.next()) {
                                        languages[numOfLanguages] = rsLanguage.getString(1);
                                    }

                                    rsLanguage.close();
                                    languageStatement.close();

                                    Statement levelStatement = myConnection.createStatement();
                                    ResultSet rsLevel = levelStatement.executeQuery("select level_description from language_levels where level_id = '" + assignLevelID + "'");

                                    if (rsLevel.next()) {
                                        levels[numOfLanguages] = rsLevel.getString(1);
                                    }

                                    rsLevel.close();
                                    levelStatement.close();

                                    numOfLanguages++;
                                }
                            }
                            rsAssign.close();
                            assignStatement.close();
                            
                            
                            %><h1>This is the profile of <%=fName%> <%=lName%></h1><%
                            out.println("First name: " + fName);%><br><br><%
                            out.println("Last name: " + lName);%><br><br><%
                            out.println("Institution: " + institution);%><br><br><%
                            out.println("Faculty: " + faculty);%><br><br><%
                            out.println("Birth date (Year-Month-Day): " + birthDate);%><br><br><%
                            out.println("CV: " + cv);%><br><br><%

                            if (numOfLanguages > 0) {
                                %>
                                <br>
                                <%
                                    out.println("Languages:");%><br><br><%
                                    //if we use smaller or equal we will get one extra result row null null
                                    for (int j = 0; j < numOfLanguages; j++) {
                                        out.println("- " + languages[j] + ", " + levels[j]); %><br><br><%
                                    }
                            } else {
                                out.println("This student has added no languages.");
                            }
                            found = true;
                            //after student found
                            break;                        
                        }
                    } catch(java.lang.NullPointerException e){
                        
                    }
                }
            }










            /*Display all student's CVs sorted alphabetically by last name*/ 
            else if (request.getParameter("alphabetical") != null) {
                
                //save all students last names in a String array
                String lastNames[] = new String[50];
                String firstNames[] = new String[50];
                Integer studentIDs[] = new Integer[50];
                ResultSet rsLastName = myStatement.executeQuery("select student_firstname, student_lastname, student_id from students");
                rsLastName.first();
                int numberOfStudents = 0;
                while (rsLastName.next()) {

                    try {
                        if (!rsLastName.getString(2).equals(null)){
                            lastNames[numberOfStudents] = rsLastName.getString(2);
                            firstNames[numberOfStudents] = rsLastName.getString(1);
                            studentIDs[numberOfStudents] = rsLastName.getInt(3);
                            numberOfStudents++;
                        }
                    } catch (java.lang.NullPointerException e) {
                        
                    }
                }

                /*check just in case students table contains no records*/
                if (numberOfStudents > 0) {
                    found = true;
                    //sort string
                    for (int a = 0; a < numberOfStudents - 1; a++) {
                        for (int b = numberOfStudents; b > a; b--) {
                            try {
                                if (lastNames[a].charAt(0) > lastNames[b].charAt(0)) {
                                    // sort last names array
                                    String lastTemp = lastNames[a];
                                    lastNames[a] = lastNames[b];
                                    lastNames[b] = lastTemp;
                                    
                                    // sort first names array
                                    String firstTemp = firstNames[a];
                                    firstNames[a] = firstNames[b];
                                    firstNames[b] = firstTemp;

                                    // sort studentsIDs array
                                    Integer idTemp = studentIDs[a];
                                    studentIDs[a] = studentIDs[b];
                                    studentIDs[b] = idTemp;
                                }
                            } catch (java.lang.NullPointerException e){
                                
                            }
                        }
                    }

                    Statement studentInfoStatement = myConnection.createStatement();
                    ResultSet rsInfo = studentInfoStatement.executeQuery("select student_firstname, student_lastname, student_id from students");
                    rsInfo.first();
                    
                    /* 
                    ** Display sorted Array
                    for (int l = 0; l < numberOfStudents; l++) {
                        out.println("- " + studentIDs[l] + " : " + firstNames[l] + ", " + lastNames[l]);
                    }
                    */

                    //loop to display students' details
                    for (int l = 0; l < numberOfStudents; l++) {
                        
                        String fName = firstNames[l];
                        String lName = lastNames[l];
                        String institution = "Not Available";
                        String faculty = "Not Available";
                        String department = "Not Available";
                        SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
                        java.util.Date birthDate = fmt.parse("1800-01-01");
                        boolean nullDate = false;
                        String cv = "Not Available";
                        String languages[] = new String[20];
                        String levels[] = new String[20];
                        int numOfLanguages = 0;


                        Statement detailsStatement = myConnection.createStatement();
                        ResultSet rsDetails = detailsStatement.executeQuery("select student_institution, student_faculty, student_department, student_birth_date, student_cv from students where student_id = '" + studentIDs[l] + "'");
                        rsDetails.first();

                        // Retrieve institution 
                        try {
                            institution = rsDetails.getString(1);
                            if (institution == null){
                                institution = "Not Available";
                            }
                        } catch (java.lang.NullPointerException e) {
                            
                        } catch (java.sql.SQLException e) {
                        
                        }

                        // Retrieve faculty
                        try {
                            faculty = rsDetails.getString(2);
                            if (faculty == null){
                                faculty = "Not Available";
                            }
                        } catch (java.lang.NullPointerException e) {
                            
                        } catch (java.sql.SQLException e) {
                        
                        }

                        // Retrieve department
                        try {
                            department = rsDetails.getString(3);
                            if (department == null){
                                department = "Not Available";
                            }
                        } catch (java.lang.NullPointerException e) {
                            
                        } catch (java.sql.SQLException e) {

                        }

                        // Retrieve birth date
                        try {
                            birthDate = rsDetails.getDate(4);
                            if (birthDate == null){
                                // String cannot be converted to Date, so we use a flag
                                // and handle the display below
                                // birthDate = "Not Available";
                                nullDate = true;
                            }
                        } catch (java.lang.NullPointerException e) {
                            
                        } catch (java.sql.SQLException e) {

                        }

                        // Retrieve cv
                        try {
                            cv = rsDetails.getString(5);
                            if (cv == null){
                                cv = "Not Available";
                            }
                        } catch (java.lang.NullPointerException e) {

                        } catch (java.sql.SQLException e) {

                        }

                        rsDetails.close();
                        detailsStatement.close();

                        // Retrieve languages
                        
                        Statement assignLanguageStatement = myConnection.createStatement();
                        ResultSet rsAssignLanguage = assignLanguageStatement.executeQuery("select assign_student_id, assign_language_id, assign_language_level_id from assign_students_languages");
                        rsAssignLanguage.first();

                        while (rsAssignLanguage.next()) {
                            int assignStudentID = -2;
                            try {
                                assignStudentID = rsAssignLanguage.getInt(1);
                            } catch (java.lang.NullPointerException e) {

                            } catch (java.sql.SQLException e) {

                            }

                            int assignLanguageID = -3;
                            try {
                                assignLanguageID = rsAssignLanguage.getInt(2);
                            } catch (java.lang.NullPointerException e) {

                            } catch (java.sql.SQLException e) {

                            }

                            int assignLevelID = -4;
                            try {
                                assignLevelID = rsAssignLanguage.getInt(3);
                            } catch (java.lang.NullPointerException e) {

                            } catch (java.sql.SQLException e) {

                            }
                            
                            //if the student knows at least one language
                            if (assignStudentID == studentIDs[l]) {
                                // Retrieve language
                                Statement languageStatement = myConnection.createStatement();
                                ResultSet rsLanguage = languageStatement.executeQuery("select language_description from languages where language_id = '" + assignLanguageID + "'");  
                                rsLanguage.first();
                                
                                // Checking if we got the right values from the result set
                                // out.println("- " + assignStudentID + " is equal to " + studentIDs[l] + " ?");
                                    
                                try {
                                    languages[numOfLanguages] = rsLanguage.getString(1);
                                    // out.println("Current language: " + rsLanguage.getString(1));
                                } catch (java.lang.NullPointerException e) {
                                    languages[numOfLanguages] = "rsLanguage NullPointerException";
                                } catch (java.sql.SQLException e) {
                                    languages[numOfLanguages] = "rsLanguage SQLException";
                                }

                                // Retrieve Level
                                Statement levelStatement = myConnection.createStatement();
                                ResultSet rsLevel = levelStatement.executeQuery("select level_description from language_levels where level_id = '" + assignLevelID + "'"); 
                                rsLevel.first();

                                try {
                                    levels[numOfLanguages] = rsLevel.getString(1);
                                    // out.println("Current level: " + rsLevel.getString(1));
                                } catch (java.lang.NullPointerException e) {
                                    levels[numOfLanguages] = "rsLevel NullPointerException";
                                } catch (java.sql.SQLException e) {
                                    levels[numOfLanguages] = "rsLevel SQLException";
                                }
                                
                                // how many languages
                                numOfLanguages++;
                                rsLanguage.close();
                                rsLevel.close();
                                languageStatement.close();
                                levelStatement.close();
                            }
                        }
                        
                        rsAssignLanguage.close();
                        assignLanguageStatement.close();
                        
                        /* last check in case there are null values */
                        if (fName != null && lName != null){
                            %>
                            <h1>This is the profile of <%=fName%> <%=lName%></h1><%
                            // out.println("Current Student ID is: " + studentIDs[l]);
                            out.println("First name: " + fName);%><br><br><% 
                            out.println("Last name: " + lName);%><br><br><%
                            out.println("Institution: " + institution);%><br><br><%
                            out.println("Faculty: " + faculty);%><br><br><%

                            if (!nullDate) {
                                out.println("Birth date (Year-Month-Day): " + birthDate);%><br><br><%
                            } else {
                                out.println("Birth date (Year-Month-Day): Not Available");
                                %>
                                <br><br>
                                <%
                            }
                            out.println("CV: " + cv);%><br><br><%
                            
                            if (numOfLanguages > 0) {
                                out.println("Languages:");%><br><br><%
                                for (int k = 0; k < numOfLanguages; k++) {
                                    out.println("- " + languages[k] + ", " + levels[k]); %><br><br><%
                                }
                            } else {
                                out.println("This student has added no languages.");%><br><br><br><%
                            }
                        }
                    }

                    rsInfo.close();
                    studentInfoStatement.close();
                } 
                
                /*if students table contain no data*/
                else {
                    out.println("There are no CVs.");
                }
            }

            /*Display all CVs related to a specific Interest*/
            else if (request.getParameter("interests") != null) {
                /* Code to display CVs related to an interest */
            } 

            /*Display all CVs related to a specific institution*/ 
            else if (request.getParameter("institution") != null) {
                /* Code to display CVs related to an institution */
            }

            /*Display how many CVs are there related to each Interest*/ 
            else if (request.getParameter("total_by_interest") != null) {
                /* Code to display how many CVs are related to each interest */
            }

            /*Display how many CVs are there related to each institution*/ 
            else if (request.getParameter("total_by_institute") != null) {
                /* Code to display how many CVs are related to each institition */
            }

            if (!found) {
                out.println("Student does not exist.");
                %>
                <br><br><br>
                <a href="selection.jsp">Try again</a>
                <%
            }

            myStatement.close();
            myConnection.close();
        %>

        <p><a href="selection.jsp">Go back</a></p>
        <p><a href="home.html">Home page</a></p>
    </body>
</html>
