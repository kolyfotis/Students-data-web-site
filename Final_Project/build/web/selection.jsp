<%-- 
    Document   : overview
    Created on : May 16, 2017, 8:17:48 PM
    Author     : fotakias
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="java.sql.*"%>
<%
    Class.forName("com.mysql.jdbc.Driver");
    String testDatabase = "jdbc:mysql://localhost:3306/project?user=root&password=1234";
    Connection myConnection = DriverManager.getConnection(testDatabase);

    Statement myStatement = myConnection.createStatement();
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Choose operation</title>
    </head>
    <body>
        <h1>Choose what would you like to see</h1>
        <form name="full_name_form" action="result.jsp">
            First name: <input type="text" name="firstname"><br><br>
            Last name: <input type="text" name="lastname"><br><br>
            <input type="submit" value="Read the CV of a student searching by name" name="full_name"><br><br><br>
        </form>

        <form name="alphabetical_form" action="result.jsp">
            <input type="submit" value="Read all CVs sorted alphabetically" name="alphabetical"><br><br><br>
        </form>

        <form name="interests_form" action="result.jsp">
            Interest: <select name="interest">
                <%
                    /*Retrieve elements from interests table*/
                    ResultSet rs = myStatement.executeQuery("select interest_description from interests");
                    
                    while (rs.next()) {
                        String interest = rs.getString(1);
                        %>
                        <option value="<%=interest%>"><%=interest%></option>
                        <%
                    }
                %>
            </select><br><br>
            <input type="submit" value="Read all CVs related to an Interest" name="interests"><br><br><br>
        </form>
            
        <form name="institution_form" action="result.jsp">
            Institution: <input type="text" name="institution"><br><br>
            <input type="submit" value="Read all CVs of Students of an Institution" name="institution"><br><br><br>
        </form>
            
        <form name="total_by_interest_form" action="result.jsp">
            <input type="submit" value="Check how many CVs are there in each Institution" name="total_by_interest"><br><br><br>
        </form>
            
        <form name="total_by_institute_form" action="result.jsp">
            <input type="submit" value="Check how many CVs are there for each Interest" name="total_by_institute"><br><br><br>
        </form>

        <p><a href="login.jsp">Log in</a> to edit your CV.</p>
        <p><a href="register.jsp">Register</a> to create your own CV.</p>
        <p><a href="home.html">Home page</a></p>
        <%
            myStatement.close();
            myConnection.close();
        %>
    </body>
</html>
