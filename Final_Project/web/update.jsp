<%-- 
    Document   : update
    Created on : May 17, 2017, 5:06:45 PM
    Author     : fotakias
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Updating content</title>
    </head>
    <body>
        <%
            Class.forName("com.mysql.jdbc.Driver");
            String studentsDatabase = "jdbc:mysql://localhost:3306/project?user=root&password=1234";
            Connection myConnection = DriverManager.getConnection(studentsDatabase);
            Statement myStatement = myConnection.createStatement();

            String userID = (String) session.getAttribute("userID");

            if (request.getParameter("first_name") != null) {
                // get first name from edit.jsp
                String firstname = request.getParameter("first_name");
                // retain first name column
                String checkFirstnameQuery = "select student_id, student_firstname from students";
                ResultSet firstnameResultSet = myStatement.executeQuery(checkFirstnameQuery);

                boolean flag = false;
                
                //check if filled already to use update query
                while (firstnameResultSet.next()) {
                    //***DEBUG
                    //shows current used logged in ID
                    //out.println("user_id: " + userID+"<br>");
                    //show columns student_id and student_firstname
                    //out.println("student_id: " + firstnameResultSet.getString(1)+"<br>");
                    //out.println("student_firstname: " + firstnameResultSet.getString(2)+"<br>");
                    //DEBUG***
                    
                    //if null and student_id = user_id insert
                    if ((firstnameResultSet.getString(1) == userID) && (firstnameResultSet.getString(2).equals(null))) {
                        String insertFirstnameQuery = "insert into students (student_firstname) values ('" + firstname + "')"
                                + "where student_id = '" + userID + "'";
                        //if we use a query with the same statement used for fetching firstNameResultSet
                        //then our ResultSet will get closed!
                        //so we create a new statement to avoid exception "...after Result closed"
                        Statement myInsertStatement = myConnection.createStatement();
                        myInsertStatement.executeUpdate(insertFirstnameQuery);
                        myInsertStatement.close();
                        flag = true;
                    }
                    //if not null update
                    else if ((firstnameResultSet.getString(1).equals(userID))/* && (firstnameResultSet.getString(2)!=null)*/) {
                        String updateFirstnameQuery = "update students set student_firstname = '" + firstname + "'"
                                + "where student_id = '" + userID + "'";
                        Statement myUpdateStatement = myConnection.createStatement();
                        myUpdateStatement.executeUpdate(updateFirstnameQuery);
                        myUpdateStatement.close();
                        flag = true;
                    }
                }
                firstnameResultSet.close();
                
                if (flag) {
                    %>
                    First name updated successfully
                    <%
                }
                else {
                    %>
                    Failed to update first name
                    <%
                }
            }

            else if (request.getParameter("last_name") != null) {
                //get last name from edit.jsp
                String lastname = request.getParameter("last_name");
                //retain last name column
                String checkLastnameQuery = "select student_id, student_lastname from students";
                ResultSet lastnameResultSet = myStatement.executeQuery(checkLastnameQuery);

                boolean flag = false;

                //check if filled already to use update query
                while (lastnameResultSet.next()) {
                    //if null and student_id = user_id insert
                    if ((lastnameResultSet.getString(1) == userID) && (lastnameResultSet.getString(2).equals(null))) {
                        String insertLastnameQuery = "insert into students (student_lastname) values ('" + lastname + "')"
                                            + "where student_id = '" + userID + "'";

                        Statement myInsertStatement = myConnection.createStatement();
                        myInsertStatement.executeUpdate(insertLastnameQuery);
                        myInsertStatement.close();
                        flag = true;
                    } //if not null update
                    else if ((lastnameResultSet.getString(1).equals(userID))/* && (lastnameResultSet.getString(2)!=null)*/) {
                        String updateLastnameQuery = "update students set student_lastname = '" + lastname + "'"
                                            + "where student_id = '" + userID + "'";
                        Statement myUpdateStatement = myConnection.createStatement();
                        myUpdateStatement.executeUpdate(updateLastnameQuery);
                        myUpdateStatement.close();
                        flag = true;
                    }
                }
                lastnameResultSet.close();

                if (flag) {
                    %>
                    Last name updated successfully
                    <%
                }
                else {
                    %>
                    Failed to update last name
                    <%
                }
            }

            else if (request.getParameter("institution") != null) {
                //get institution from edit.jsp
                String institution = request.getParameter("institution");
                //retain institution column
                String checkInstitutionQuery = "select student_id, student_lastname from students";
                ResultSet institutionResultSet = myStatement.executeQuery(checkInstitutionQuery);

                boolean flag = false;
                //check if filled already to use update query
                while (institutionResultSet.next()) {
                    //if null and student_id = user_id insert
                    if ((institutionResultSet.getString(1) == userID) && (institutionResultSet.getString(2).equals(null))) {
                        String insertInstitutionQuery = "insert into students (student_institution) values ('" + institution + "')"
                                            + "where student_id = '" + userID + "'";

                        Statement myInsertStatement = myConnection.createStatement();
                        myInsertStatement.executeUpdate(insertInstitutionQuery);
                        myInsertStatement.close();
                        flag = true;
                    } //if not null update
                    else if ((institutionResultSet.getString(1).equals(userID))) {
                        String updateInstitutionQuery = "update students set student_institution = '" + institution + "'"
                                            + "where student_id = '" + userID + "'";
                        Statement myUpdateStatement = myConnection.createStatement();
                        myUpdateStatement.executeUpdate(updateInstitutionQuery);
                        myUpdateStatement.close();
                        flag = true;
                    }
                }
                institutionResultSet.close();

                if (flag) {
                    %>
                    Institution updated successfully
                    <%
                }
                else {
                    %>
                    Failed to update institution
                    <%
                }
            }
            else if (request.getParameter("faculty") != null) {
                //get faculty from edit.jsp
                String faculty = request.getParameter("faculty");
                //retain faculty column
                String checkFacultyQuery = "select student_id, student_lastname from students";
                ResultSet facultyResultSet = myStatement.executeQuery(checkFacultyQuery);

                boolean flag = false;
                //check if filled already to use update query
                while (facultyResultSet.next()) {
                    //if null and student_id = user_id insert
                    if ((facultyResultSet.getString(1) == userID) && (facultyResultSet.getString(2).equals(null))) {
                        String insertFacultyQuery = "insert into students (student_faculty) values ('" + faculty + "')"
                                            + "where student_id = '" + userID + "'";

                        Statement myInsertStatement = myConnection.createStatement();
                        myInsertStatement.executeUpdate(insertFacultyQuery);
                        myInsertStatement.close();
                        flag = true;
                    } //if not null update
                    else if ((facultyResultSet.getString(1).equals(userID))) {
                        String updateFacultyQuery = "update students set student_faculty = '" + faculty + "'"
                                            + "where student_id = '" + userID + "'";
                        Statement myUpdateStatement = myConnection.createStatement();
                        myUpdateStatement.executeUpdate(updateFacultyQuery);
                        myUpdateStatement.close();
                        flag = true;
                    }
                }
                facultyResultSet.close();

                if (flag) {
                    %>Faculty updated successfully<%
                }
                else {
                    %>Failed to update faculty<%
                }
            }
            else if (request.getParameter("department") != null) {
                //get department from edit.jsp
                String department = request.getParameter("department");
                //retain department column
                String checkDepartmentQuery = "select student_id, student_department from students";
                ResultSet departmentResultSet = myStatement.executeQuery(checkDepartmentQuery);

                boolean flag = false;
                //check if filled already to use update query
                while (departmentResultSet.next()) {
                    //if null and student_id = user_id insert
                    if ((departmentResultSet.getString(1) == userID) && (departmentResultSet.getString(2).equals(null))) {
                        String insertDepartmentQuery = "insert into students (student_department) values ('" + department + "')"
                                            + "where student_id = '" + userID + "'";

                        Statement myInsertStatement = myConnection.createStatement();
                        myInsertStatement.executeUpdate(insertDepartmentQuery);
                        myInsertStatement.close();
                        flag = true;
                    } //if not null update
                    else if ((departmentResultSet.getString(1).equals(userID))) {
                        String updateDepartmentQuery = "update students set student_department = '" + department + "'"
                                            + "where student_id = '" + userID + "'";
                        Statement myUpdateStatement = myConnection.createStatement();
                        myUpdateStatement.executeUpdate(updateDepartmentQuery);
                        myUpdateStatement.close();
                        flag = true;
                    }
                }
                departmentResultSet.close();

                if (flag) {
                    %>Department updated successfully<%
                }
                else {
                    %>Failed to update department<%
                }
            }
            else if (request.getParameter("cv_text") != null) {
                //get cv from edit.jsp
                String cv = request.getParameter("cv_text");
                //String cv = ParamUtil.get(request, "")
                //retain cv column
                String checkCvQuery = "select student_id, student_cv from students";
                ResultSet cvResultSet = myStatement.executeQuery(checkCvQuery);

                boolean flag = false;
                //check if filled already to use update query
                while (cvResultSet.next()) {
                    //if null and student_id = user_id insert
                    if ((cvResultSet.getString(1) == userID) && (cvResultSet.getString(2).equals(null))) {
                        String insertCvQuery = "insert into students (student_cv) values ('" + cv + "')"
                                            + "where student_id = '" + userID + "'";

                        Statement myInsertStatement = myConnection.createStatement();
                        myInsertStatement.executeUpdate(insertCvQuery);
                        myInsertStatement.close();
                        flag = true;
                    } //if not null update
                    else if ((cvResultSet.getString(1).equals(userID))) {
                        String updateCvQuery = "update students set student_cv = '" + cv + "'"
                                            + "where student_id = '" + userID + "'";
                        Statement myUpdateStatement = myConnection.createStatement();
                        myUpdateStatement.executeUpdate(updateCvQuery);
                        myUpdateStatement.close();
                        flag = true;
                    }
                }
                cvResultSet.close();

                if (flag) {
                    %>
                    CV updated successfully
                    <%
                }
                else {
                    %>
                    Failed to update CV
                    <%
                }
            }
            else if (request.getParameter("birth_date") != null) {
                //get birth date from edit.jsp
                String birthDate = request.getParameter("birth_date");
                //String cv = ParamUtil.get(request, "")
                //retain cv column
                String checkBirthDateQuery = "select student_id, student_birth_date from students";
                ResultSet birthDateResultSet = myStatement.executeQuery(checkBirthDateQuery);

                boolean bDateUpdated = false;
                //check if filled already to use update query
                while (birthDateResultSet.next()) {
                    //if null and student_id = user_id insert
                    if ((birthDateResultSet.getString(1) == userID) && (birthDateResultSet.getString(2).equals(null))) {
                        String insertBirthDateQuery = "insert into students (student_birth_date) values ('" + birthDate + "')"
                                                + "where student_id = '" + userID + "'";

                        Statement myInsertStatement = myConnection.createStatement();
                        myInsertStatement.executeUpdate(insertBirthDateQuery);
                        myInsertStatement.close();
                        bDateUpdated = true;
                    } //if not null update
                    else if ((birthDateResultSet.getString(1).equals(userID))) {
                        String updateBirthDateQuery = "update students set student_birth_date = '" + birthDate + "'"
                                                + "where student_id = '" + userID + "'";
                        Statement myUpdateStatement = myConnection.createStatement();
                        myUpdateStatement.executeUpdate(updateBirthDateQuery);
                        myUpdateStatement.close();
                        bDateUpdated = true;
                    }
                }
                birthDateResultSet.close();

                if (bDateUpdated) {
                    %>
                    Birth date updated successfully
                    <%
                }
                else {
                    %>
                    Failed to update birth date
                    <%
                }
            }
            else if (request.getParameter("add_interest") != null) {
                /*Code to add interest*/
                String interest = request.getParameter("interest");
                //check if interest is already assigned to current user
                ResultSet rsAssign = myStatement.executeQuery("select assign_student_id, assign_interest_id from assign_students_interests");
                Statement interestsStatement = myConnection.createStatement();
                ResultSet rsInterests = interestsStatement.executeQuery("select interest_id from interests where interest_description = '" + interest + "'");
                rsInterests.first();
                int interestID = rsInterests.getInt(1);
                boolean exists = false;
                while (rsAssign.next()) {
                    if ((rsAssign.getString(1).equals(userID)) && (rsAssign.getInt(2) == interestID)) {
                        %>
                        The selected interest has already been added
                        <%
                        exists = true;
                     }
                }
                rsAssign.close();
                rsInterests.close();
                interestsStatement.close();

                //assign interest to current student using insert
                if (!exists) {
                    Statement insertAssignStatement = myConnection.createStatement();
                    insertAssignStatement.executeUpdate("insert into assign_students_interests (assign_student_id, assign_interest_id) values('" + userID + "', '" + interestID + "')");
                    %>
                    Interests updated successfully
                    <%
                    insertAssignStatement.close();
                }
            }
            else if (request.getParameter("remove_interest") != null) {
                /*Code to remove interest*/
                String interest = request.getParameter("interest");
                //check if interest is assigned to current user
                ResultSet rsAssign = myStatement.executeQuery("select assign_student_id, assign_interest_id from assign_students_interests");
                Statement interestsStatement = myConnection.createStatement();
                ResultSet rsInterests = interestsStatement.executeQuery("select interest_id from interests where interest_description = '" + interest + "'");
                rsInterests.first();
                int interestID = rsInterests.getInt(1);
                boolean exists = false;
                while (rsAssign.next()) {
                    if ((rsAssign.getString(1).equals(userID)) && (rsAssign.getInt(2) == interestID)) {
                        %>The selected interest has been deleted successfully<%
                        Statement myStatement3 = myConnection.createStatement();
                        myStatement3.executeUpdate("delete from assign_students_interests where assign_student_id = '" + userID + "' and assign_interest_id = '" + interestID + "'");
                        exists = true;
                        myStatement3.close();
                    }
                }

                rsAssign.close();
                rsInterests.close();
                interestsStatement.close();
                //assign interest to current student using insert
                if (!exists) {
                    %>The interest you are trying to remove has not been added to your interests<%
                }
            }
            else if (request.getParameter("quote_text") != null) {

            //get quote text from edit.jsp
            String quoteText = request.getParameter("quote_text");
            boolean flag = false;

            String insertQuoteQuery = "insert into quotes (quote_description, quote_student_id) "
                                + "values ('" + quoteText + "', '" + userID + "')";
            Statement myInsertStatement = myConnection.createStatement();
            myInsertStatement.executeUpdate(insertQuoteQuery);
            myInsertStatement.close();
            flag = true;
            if (flag) {
                %>
                Quote added successfully
                <%
            }
            else {
                %>
                Failed to add quote
                <%
            }
            }
            else if (request.getParameter("photo") != null) {

                %>
                Upload photo action to be added here
                <%

            }
            else if (request.getParameter("video") != null) {

                %>
                Upload video action to be added here
                <%

            }
            else if (request.getParameter("add_language") != null) {
                //get language from edit.jsp
                String language = request.getParameter("language");
                //retain language column
                String checkLanguageQuery = "select language_description from languages";
                ResultSet languageResultSet = myStatement.executeQuery(checkLanguageQuery);

                boolean flag = false;
                boolean languageExists = false;
                //check if language already exists
                while (languageResultSet.next()) {
                    //if exists do not insert something into languages table
                    if (languageResultSet.getString(1).equals(language)) {
                        languageExists = true;
                        break;
                    }
                }
                languageResultSet.close();

                //if language does not exist already, insert into languages table
                if (!languageExists) {
                    String insertNewLanguageQuery = "insert into languages (language_description)"
                                    + "values ('" + language + "')";
                    Statement myInsertStatement = myConnection.createStatement();
                    myInsertStatement.executeUpdate(insertNewLanguageQuery);
                    myInsertStatement.close();
                }

                //insert into assign_students_languages table
                //select current language id
                String selectLanguageIDQuery = "select language_id from languages where language_description = '" + language + "'";
                ResultSet languageIDResultSet = myStatement.executeQuery(selectLanguageIDQuery);
                languageIDResultSet.first();
                int languageID = languageIDResultSet.getInt(1);

                languageIDResultSet.close();

                //debug
                //out.println("current language id = " + languageID);

                //select current language level id
                String languageLevel = request.getParameter("language_level");

                //debug
                //out.println("current language level id = " + languageLevel);

                //debug
                //out.println("current user id  = " + userID);

                String checkAssignQuery = "select assign_student_id, assign_language_id from assign_students_languages";
                ResultSet assignResultSet = myStatement.executeQuery(checkAssignQuery);

                //if user has already added this language, update level
                boolean updated = false;

                while (assignResultSet.next()) {
                    //out.println("table content userID = " + assignResultSet.getString(1));
                    //out.println("table content languageID = " + assignResultSet.getString(2));
                    if ((assignResultSet.getInt(1) == (Integer.parseInt(userID)))
                                    && (Integer.parseInt(assignResultSet.getString(2)) == (languageID))) {
                        try {
                            //update assign_language_level_id column
                            String updateAssignQuery = "update assign_students_languages set assign_language_level_id = '" + Integer.parseInt(languageLevel) + "'"
                                            + "where assign_student_id = '" + Integer.parseInt(userID) + "'"
                                            + "AND assign_language_id = '" + languageID + "'";
                            Statement myUpdateStatement = myConnection.createStatement();
                            myUpdateStatement.executeUpdate(updateAssignQuery);
                            myUpdateStatement.close();
                            updated = true;
                        } catch (Exception e) {
                            out.println("Failed to update language");
                        }
                    }
                }
                assignResultSet.close();

                //insert new row
                if (!updated) {
                    try {
                        //insert valuse into assign_students_languages table
                        String insertAssignQuery = "insert into assign_students_languages(assign_student_id, assign_language_id, assign_language_level_id)"
                            + "values('" + Integer.parseInt(userID) + "','" + languageID + "','" + Integer.parseInt(languageLevel) + "')";
                        Statement myInsertStatement = myConnection.createStatement();
                        myInsertStatement.executeUpdate(insertAssignQuery);
                        myInsertStatement.close();
                        %>
                        Language added successfully
                        <%
                    }/*userId, languageId and levelId combination alreasy exists*/
                    catch (Exception e) {
                        %>
                        Failed to add language. You have already added this language combined with this specific level.
                        <%
                    }
                }
            }
            else if (request.getParameter("remove_language") != null) {
                /*Code to remove language*/
                String language = request.getParameter("language");
                //check if language is assigned to current user
                ResultSet rsAssign = myStatement.executeQuery("select assign_student_id, assign_language_id, assign_language_level_id from assign_students_languages");
                Statement languageStatement = myConnection.createStatement();
                ResultSet rsLanguage = languageStatement.executeQuery("select language_id from languages where language_description = '" + language + "'");
                rsLanguage.first();
                int languageID = rsLanguage.getInt(1);
                boolean exists = false;

                while (rsAssign.next()) {
                    if ((rsAssign.getString(1).equals(userID)) && (rsAssign.getInt(2) == languageID)) {
                        %>
                        The selected language has been deleted successfully
                        <%
                        Statement deleteStatement = myConnection.createStatement();
                        deleteStatement.executeUpdate("delete from assign_students_languages where assign_student_id = '" + userID + "' and assign_language_id = '" + languageID + "'");
                        exists = true;
                        deleteStatement.close();
                    }
                }
                rsLanguage.close();
                languageStatement.close();
                rsAssign.close();

                //when user tries to remove a language he has not added
                if (!exists) {
                    %>
                    The language you are trying to remove has not been added to your hobbies
                    <%                
                }
            }
            else if (request.getParameter("add_hobby") != null) {
                /*Code to add hobby*/
                String hobby = request.getParameter("hobby");
                //check if hobby is already assigned to current user
                ResultSet rsAssign = myStatement.executeQuery("select assign_student_id, assign_hobby_id from assign_students_hobbies");
                Statement hobbiesStatement = myConnection.createStatement();
                ResultSet rsHobbies = hobbiesStatement.executeQuery("select hobby_id from hobbies where hobby_description = '" + hobby + "'");
                rsHobbies.first();
                int hobbyID = rsHobbies.getInt(1);
                boolean exists = false;
                while (rsAssign.next()) {
                    if ((rsAssign.getString(1).equals(userID)) && (rsAssign.getInt(2) == hobbyID)) {
                        %>
                        The selected hobby has already been added
                        <%
                        exists = true;
                    }
                }
                rsHobbies.close();
                hobbiesStatement.close();
                rsAssign.close();
                //assign hobby to current student using insert
                if (!exists) {
                    Statement insertStatement = myConnection.createStatement();
                    insertStatement.executeUpdate("insert into assign_students_hobbies (assign_student_id, assign_hobby_id) values('" + userID + "', '" + hobbyID + "')");
                    %>
                    Hobbies updated successfully
                    <%
                    insertStatement.close();
                }
            }
            else if (request.getParameter("remove_hobby") != null) {
                /*Code to remove hobby*/
                String hobby = request.getParameter("hobby");
                //check if hobby is assigned to current user
                ResultSet rsAssign = myStatement.executeQuery("select assign_student_id, assign_hobby_id from assign_students_hobbies");
                Statement hobbiesStatement = myConnection.createStatement();
                ResultSet rsHobbies = hobbiesStatement.executeQuery("select hobby_id from hobbies where hobby_description = '" + hobby + "'");
                rsHobbies.first();
                int hobbyID = rsHobbies.getInt(1);
                boolean exists = false;
                while (rsAssign.next()) {
                    if ((rsAssign.getString(1).equals(userID)) && (rsAssign.getInt(2) == hobbyID)) {
                        %>
                        The selected hobby has been deleted successfully
                        <%
                        Statement myStatement3 = myConnection.createStatement();
                        myStatement3.executeUpdate("delete from assign_students_hobbies where assign_student_id = '" + userID + "' and assign_hobby_id = '" + hobbyID + "'");
                        exists = true;
                        myStatement3.close();
                    }
                }
                rsHobbies.close();
                hobbiesStatement.close();
                rsAssign.close();

                //if user tried to remove a hobby he has not added
                if (!exists) {
                    %>
                    The hobby you are trying to remove has not been added to your hobbies
                    <%
                }
            }
            else {/*DEBUG*/
                %>
                Servlet failed to recognize which form has been selected
                <%
            }

            myStatement.close();
            myConnection.close();
        %>
        <p><a href="edit.jsp">Go back</a></p>
    </body>
</html>
