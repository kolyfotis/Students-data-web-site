<%-- 
    Document   : log_in_check
    Created on : May 15, 2017, 8:29:21 PM
    Author     : fotakias
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Attempting to log in</title>
    </head>
    <body>
<%
    Class.forName("com.mysql.jdbc.Driver");
    String studentsDatabase = "jdbc:mysql://localhost:3306/project?user=root&password=1234";
    Connection myConnection = DriverManager.getConnection(studentsDatabase);
    
    String uname = request.getParameter("username");
    String pword = request.getParameter("password");
    
    Statement myStatement = myConnection.createStatement();
    ResultSet rs = myStatement.executeQuery("select user_name, pass_word, user_id from users");
    
    boolean success = false;
    
    while(rs.next()){
        String username = rs.getString(1);
        String password = rs.getString(2);
        // wrong username or password
        if(uname.equals(username) && pword.equals(password)){
            // current user_id available to all jsp pages with session.getAttribute("userID");
            String userID = rs.getString(3);
            // out.println("userId: "+ userID);
            session.setAttribute("userID", userID);
            success = true;
        }
    }
    
    if(success){
        %>
            <h1>You have successfully logged in to your account!</h1>
            <p>Proceed to <a href="edit.jsp">edit</a> your CV.</p>
            <p><a href="login.jsp">Log out</a>
            <p><a href="home.html">Return to Welcome Page</a>
        <%
    }
    else{
        %>
            Failed to log in. Invalid username or password.<br><br>
            Do you want to <a href="login.jsp">try again</a> or <a href="register.jsp">create</a> a new account?
            <p><a href="home.html">Return to Welcome Page</a>
        <%
    }
    
    rs.close();
    myStatement.close();
    myConnection.close();
    %>


        
    </body>
</html>
