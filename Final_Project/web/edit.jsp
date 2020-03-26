<%-- 
    Document   : edit
    Created on : May 16, 2017, 8:45:50 PM
    Author     : fotakias
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit</title>
    </head>
    <body>
        <h1>Here you can edit and submit your own CV.</h1>
        <%
            Class.forName("com.mysql.jdbc.Driver");
            String studentsDatabase = "jdbc:mysql://localhost:3306/project?user=root&password=1234";
            Connection myConnection = DriverManager.getConnection(studentsDatabase);
            Statement myStatement = myConnection.createStatement();

            String userID = (String) session.getAttribute("userID");

            //first name
            String selectQuery = "select student_firstname from students "
                    + "where student_id = " + Integer.parseInt(userID) + "";
            ResultSet rs = myStatement.executeQuery(selectQuery);
            rs.first();
            String firstName = rs.getString(1);
            
            if (firstName == null) {
                firstName = "";
            }
            
            //last name
            selectQuery = "select student_lastname from students "
                    + "where student_id = " + Integer.parseInt(userID) + "";
            rs = myStatement.executeQuery(selectQuery);
            rs.first();
            String lastName = rs.getString(1);
            
            if (lastName == null) {
                lastName = "";
            }

            //institution
            selectQuery = "select student_institution from students "
                    + "where student_id = " + Integer.parseInt(userID) + "";
            rs = myStatement.executeQuery(selectQuery);
            rs.first();
            String institution = rs.getString(1);
            
            if (institution == null) {
                institution = "";
            }

            //faculty
            selectQuery = "select student_faculty from students "
                    + "where student_id = " + Integer.parseInt(userID) + "";
            rs = myStatement.executeQuery(selectQuery);
            rs.first();
            String faculty = rs.getString(1);
            
            if (faculty == null) {
                faculty = "";
            }
            
            //department
            selectQuery = "select student_department from students "
                    + "where student_id = " + Integer.parseInt(userID) + "";
            rs = myStatement.executeQuery(selectQuery);
            rs.first();
            String department = rs.getString(1);
            
            if (department == null) {
                department = "";
            }

            //cv
            selectQuery = "select student_cv from students "
                    + "where student_id = " + Integer.parseInt(userID) + "";
            rs = myStatement.executeQuery(selectQuery);
            rs.first();
            String cv = rs.getString(1);
            
            if (cv == null) {
                cv = "";
            }

            //date
            selectQuery = "select student_birth_date from students "
                    + "where student_id = " + Integer.parseInt(userID) + "";
            rs = myStatement.executeQuery(selectQuery);
            rs.first();
            java.util.Date birthDate = rs.getDate(1);
            
            if (birthDate == null) {
                // displays "mm/dd/yyyy" by default
            }
        %>

        <form name="first_name_form" action="update.jsp">
            <p>First name: <input type="text" name="first_name" value="<%=firstName%>"><br><br><input type="submit" value="Update First Name"><br></p>
        </form>

        <form name="last_name_form" action="update.jsp">
            <p>Last name: <input type="text" name="last_name" value="<%=lastName%>"><br><br><input type="submit" value="Update Last Name"><br></p>
        </form>

        <form name="institution_form" action="update.jsp">
            <p>Institution: <input type="text" name="institution" value="<%=institution%>"><br><br><input type="submit" value="Update Institution"><br></p>
        </form>

        <form name="faculty_form" action="update.jsp">
            <p>Faculty: <input type="text" name="faculty" value="<%=faculty%>"><br><br><input type="submit" value="Update Faculty"><br></p>
        </form>

        <form name="department_form" action="update.jsp">
            <p>Department:  <input type="text" name="department" value="<%=department%>"><br><br><input type="submit" value="Update Department"><br></p>
        </form>

        <form name="cv_text_form" action="update.jsp">
            <p>Write a short CV</p>
            <p><textarea name="cv_text" cols="50" rows="10"><%=cv%></textarea><br><br>
                <input type="submit" value="Update CV"><br></p>
        </form>

        <form name="birth_date_form" action="update.jsp">
            <p>Birth date (Month/Day/Year):  <input type="date" name="birth_date" value='<%=birthDate%>'><br><br><input type="submit" value="Update Birth Date"><br></p>
        </form>

        <form name="interests_form" action="update.jsp">
            <p><h3>Interests</h3>
            Your interests:<br><br>
            <%
                /*display current user's interests*/
                rs = myStatement.executeQuery("select assign_student_id, assign_interest_id from assign_students_interests");
                rs.first();
                Statement interestsStatement = myConnection.createStatement();
                ResultSet rsInterests = null;
                
                while (rs.next()) {
                    //if user has at least one interest
                    if (rs.getString(1).equals(userID)) {
                        rsInterests = interestsStatement.executeQuery("select interest_description from interests where interest_id = '" + rs.getInt(2) + "'");
                        
                        if (rsInterests.next()) {
                            out.println("- " + rsInterests.getString(1));
                            %>
                            <br>
                            <%
                        }
                    }
                }

                try {
                    rsInterests.close();
                } catch (java.lang.NullPointerException e) {
                    
                }

                interestsStatement.close();
            %>
            <br>
            <select name="interest">
                <%
                    /*Retrieve elements from interests table*/
                    rs = myStatement.executeQuery("select interest_description from interests");
                    rs.first();
                    
                    while (rs.next()) {
                        String interest = rs.getString(1);
                        %>
                        <option value="<%=interest%>"><%=interest%></option>
                        <%
                    }
                %>
            </select><br><br>

            <input type="submit" name="add_interest" value="Add selected interest"> <input type="submit" name="remove_interest" value="Remove selected interest"><br><br>
        </form>

        <form name="quote_text_form" action="update.jsp">
            <p>Add a Quote</p>
            <p><textarea name="quote_text" cols="50" rows="10"></textarea><br><br>
                <input type="submit" value="Add Quote"><br><br></p>
        </form>

        <p>Upload your photo (max size 10MB)</p>        
        <form name="photo_form" action="update.jsp" enctype="multipart/form-data">
            <p><input type="file" name="photo" accept="image/*"><br></p>
            <input type="submit" value="Upload photo"><br><br>
        </form>

        <p>Upload your video (max size 50MB)</p>
        <form name="video_form" action="update.jsp" enctype="multipart/form-data">
            <p><input type="file" name="video" accept="video/*"><br></p>
            <input type="submit" value="Upload video"><br><br>
        </form>

        <form name="language_form" action="update.jsp">
            <p><h3>Languages</h3>
            Your languages:<br><br><br>
            <%
                //language[i] matches level[i]
                String languages[] = new String[20];
                String levels[] = new String[20];
                //how many languages
                int i = 0;
                rs = myStatement.executeQuery("select assign_student_id, assign_language_id, assign_language_level_id from assign_students_languages");
                rs.first();
                //out.println("is "+rs3.getInt(1)+" equal to "+studentID+" ?");
                
                Statement languagesStatement = myConnection.createStatement();
                ResultSet rsLanguages = null;
                
                while (rs.next()) {
                    int assignStudentID = rs.getInt(1);
                    int assignLanguageID = rs.getInt(2);
                    int assignLevelID = rs.getInt(3);
                    
                    //if the student knows at least one language
                    if (assignStudentID == Integer.parseInt(userID)) {
                        // Statement myStatement4 = myConnection.createStatement();
                        rsLanguages = languagesStatement.executeQuery("select language_description from languages where language_id = '" + assignLanguageID + "'");
                        
                        if (rsLanguages.next()) {
                            languages[i] = rsLanguages.getString(1);
                        }
                        Statement levelStatement = myConnection.createStatement();
                        ResultSet rsLevels = levelStatement.executeQuery("select level_description from language_levels where level_id = '" + assignLevelID + "'");

                        if (rsLevels.next()) {
                            levels[i] = rsLevels.getString(1);
                        }
                        i++;
                    }
                }
                
                try {
                    rsLanguages.close();
                } catch (java.lang.NullPointerException e) {
                    
                }
                
                languagesStatement.close();

                /*Display currents student's languages*/
                if (i > 0) {
                    //if we use smaller or equal we will get one extra result row null null
                    for (int j = 0; j < i; j++) {
                        out.println("- " + languages[j] + ", " + levels[j]);
                        %>
                        <br><br>
                        <%
                    }
                }
            %>

            <p>
                Language: <input type="text" name="language"> Level:
                
                <select name="language_level">
                    <option value="1">Elementary</option>
                    <option value="2">Intermediate</option>
                    <option value="3">Advanced</option>
                    <option value="4">Proficient</option>
                </select>

                <input type="submit" value="Add language" name="add_language"><br><br>
                <input type="submit" value="Remove selected language" name="remove_language"><br><br>
            </p>
        </form>

        <form name="hobbies_form" action="update.jsp">
            <p>
            <h3>Hobbies</h3>
            Your hobbies:<br><br>
            <%
                /*display current user's hobbies*/
                rs = myStatement.executeQuery("select assign_student_id, assign_hobby_id from assign_students_hobbies");
                rs.first();
                Statement hobbiesStatement = myConnection.createStatement();
                ResultSet rsAssignHobbies = null;
                
                while (rs.next()) {
                    //if user has at least one hobby
                    if (rs.getString(1).equals(userID)) {
                        rsAssignHobbies = hobbiesStatement.executeQuery("select hobby_description from hobbies where hobby_id = '" + rs.getInt(2) + "'");
                        
                        if (rsAssignHobbies.next()) {
                            out.println("- " + rsAssignHobbies.getString(1));
                            %>
                            <br>
                            <%
                        }
                    }
                }
                
                try {
                    rsAssignHobbies.close();
                } catch (java.lang.NullPointerException e) {
                    
                }

                hobbiesStatement.close();
            %>
            <br>
            <select name="hobby">
                <%
                    /* Retrieve elements from hobbies table */
                    rs = myStatement.executeQuery("select hobby_description from hobbies");
                    rs.first();
                    
                    while (rs.next()) {
                        String hobby = rs.getString(1);
                        %>
                        <option value="<%=hobby%>"><%=hobby%></option>
                        <%
                    }
                %>
            </select>
            <br><br>
            <input type="submit" name="add_hobby" value="Add selected hobby"> <input type="submit" name="remove_hobby" value="Remove selected hobby"><br><br>
        </form>
        <%
            rs.close();
            myStatement.close();
            myConnection.close();
        %>
        <p><a href="login.jsp">Log out</a></p>
        <p><a href="home.html">Home page</a></p>

    </body>
</html>
