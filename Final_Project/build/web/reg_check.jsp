<%-- 
    Document   : reg_check
    Created on : May 15, 2017, 6:30:10 PM
    Author     : fotakias
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account created successfully</title>
    </head>
    <body>
        
<%
    Class.forName("com.mysql.jdbc.Driver");
    String studentsDatabase = "jdbc:mysql://localhost:3306/project?user=root&password=1234";
    Connection myConnection = DriverManager.getConnection(studentsDatabase);
    String userName = request.getParameter("username");
    String passWord = request.getParameter("password");
    
    Statement myStatement = myConnection.createStatement();
    String insertQuery = "insert into users (user_name, pass_word) values ('"+userName+"', '"+passWord+"')";
    
    try{
        myStatement.executeUpdate(insertQuery);
        %>
            <h1>Your account has been created!</h1>
            <p>Do you wish to <a href="login.jsp">log in</a> or go back and <a href="register.jsp">create a new account</a>?
            <p><a href="index.html">Return to Welcome Page</a>
        <%
    }
    catch(com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException e){
        %>
            Username already in use.
            <p><a href="register.jsp">Try again</a>
            <p><a href="home.html">Home Page</a>
        <%
    }
        
    myStatement.close();
    myConnection.close();
%>
    </body>
</html>
