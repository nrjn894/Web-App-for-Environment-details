<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Page</title>
<style type="text/css">
   * {
	    margin: 0;
	    padding: 0;
   }
    html, body {
		height: 100%;
	}
	table,tr,td{
		
		padding:40px;
		
	}
	table{
	    border:1px solid black;
		width: 40%;
		table-layout: fixed;
	}
	tr,td{
		padding:10px;
	}
	input{
		padding: 5px;
		border:2px solid black;
		border-radius:5px;
		width:100%;
	}
</style>
<script type="text/javascript">
	
</script>
</head>
<body>
	<form action="login.jsp">
		<table>
			<thead>
				<th colspan = "4">Please Login</th>
			</thead>
			<tbody>
				<tr>
				<td colspan = "1">Username: </td>
				<td colspan = "3"><input type="text" name="username"> </td>
				</tr>
				<tr>
				<td colspan = "1">Password: </td>
				<td colspan = "3"><input type="password" name="password"> </td>
				</tr>
				<tr>
				<td colspan = "2"></td>
				<td colspan = "1"><input type="submit" name="submit"> </td>
				<td colspan = "1"></td>
				
				</tr>
			</tbody>
		</table>
	</form>
</body>
</html>