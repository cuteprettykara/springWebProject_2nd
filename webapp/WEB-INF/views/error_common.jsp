<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<title>Error Page</title>
</head>

<body>
	<h4>${exception.message}</h4>
	
	<ul>
		<c:forEach items="${exception.stackTrace}" var="stack">
			<li>${stack }</li>
		</c:forEach>
	</ul>


</body>
</html>