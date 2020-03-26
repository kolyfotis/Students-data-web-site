<%-- 
    Document   : login
    Created on : May 16, 2017, 8:17:15 PM
    Author     : fotakias
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Log in</title>
    </head>
    <body>
        <h1>Enter your username and your password in the form below.</h1>
        <p>
        <form name="login_form" action="login_check.jsp">
            <p>Username: <input type="text" name="username"></p>
            <p>Password: <input type="password" name="password"></p>
            <p><input type="submit" value="Log in"></p>
        </form>
        <p><a href="register.jsp">Create a new account</a></p>
        <p><a href="home.html">Home page</a></p>
        
    </body>
</html>
