<%-- 
    Document   : register
    Created on : May 16, 2017, 8:17:23 PM
    Author     : fotakias
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
    </head>
    <body>
        <h1>Enter username and password in the form below.</h1>
        <form name="registration_form" action="reg_check.jsp">
            <p>Username: <input type="text" name="username"></p>
            <p>Password: <input type="password" name="password"></p>
            <p><input type="submit" value="Register"></p>
        </form>
        <p><a href="login.jsp">Log in</a></p>
        <p><a href="home.html">Home page</a></p>
    </body>
</html>
