<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<!Doctype html>
<%
String EnvironmentDetailsFilePath = application.getInitParameter("Environment_Details_Files_Path");
String EnvironmentDetailsFileName = request.getParameter("filename");
EnvironmentDetailsFileName = EnvironmentDetailsFileName.trim();
if("Default".equals(EnvironmentDetailsFileName)){
	EnvironmentDetailsFileName = application.getInitParameter("Default_Environment_Details_File").trim();
}
//System.out.println("EnvironmentDetailsFileName "+EnvironmentDetailsFileName);
if(EnvironmentDetailsFileName != null && !"".equals(EnvironmentDetailsFileName)){
	//System.out.println("i am here1 ");
	if(EnvironmentDetailsFilePath.contains("\\")&&!EnvironmentDetailsFilePath.endsWith("\\")){
		EnvironmentDetailsFilePath = EnvironmentDetailsFilePath+"\\";
	}
	else if(EnvironmentDetailsFilePath.contains("/")&&!EnvironmentDetailsFilePath.endsWith("/")){
		EnvironmentDetailsFilePath = EnvironmentDetailsFilePath+"/";
	}
	BufferedReader in = null;
	Map<String,String> detailsMap=new HashMap<String,String>();
	try{
		FileReader fre = new FileReader(EnvironmentDetailsFilePath + EnvironmentDetailsFileName);
		in = new BufferedReader(fre);
		String line = null;
		line = in.readLine();
		while(line !=null) 
		{
			line = line.trim();
			if(!"".equals(line))
			{
				String[] arr = line.split("#");
				String key = null;
				String value = null;
				if(arr.length>0){
					key = arr[0];
				}
				if(arr.length>1)
				{
					value = arr[1];
				}
				else
				{
					value = "**NOT PROVIDED**";
				}
				if(key!=null && value!=null)
				{
					detailsMap.put(key,value);
				}
			}
	   		line = in.readLine();
		}
	}catch(Exception e)
	{
	}finally
	{
		try{
			in.close();
		}catch(Exception e){}
	}
%>
<html>
<head>
<style type="text/css">
@charset "ISO-8859-1";

* {
	margin: 0;
	padding: 0;
}

html, body {
	height: 100%;
}

table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
	padding: 5px;
	width:95%;
}
table{
	table-layout: fixed;
}
th {
	background-color: gray;
	color: white;
}

td {
	background-color: gainsboro;
}

.front-container {
	width: 70%;
}

.front-container table {
	width: 100%;
}

.Title {
	text-align: center;
}
.param-name{
	max-width: 100px;
}
</style>
</head>
<body>
	<h1 class="Title"><%= detailsMap.get("TITLE") %></h1>
	<hr />
	<%
		if(detailsMap.get("FRONTEND_DETAILS_REQD").equals("Y")){
	%>
	<h2>Frontend Details</h2>
	<br />
	<div class="front-container">
		<%
		if(detailsMap.get("TXN_FE_REQD").equals("Y")){
		%>
		<table>
			<th colspan="10">TXN</th>
			<tr>
				<td colspan="3"><b> TXN APPLICATION LINK</b></td>
				<td colspan="7"><a href="<%= detailsMap.get("TXN_APP_LINK") %>"
					target="_blank"><%= detailsMap.get("TXN_APP_LINK") %></a></td>
			</tr>
			<tr>
				<td colspan="3"><b>WEBLOGIC CONSOLE</b></td>
				<td colspan="7"><a href="<%= detailsMap.get("TXN_WEBLOGIC_CONSOLE") %>"
					target="_blank"><%= detailsMap.get("TXN_WEBLOGIC_CONSOLE") %></a></td>
			</tr>
			<tr>
				<td colspan="3"><b class="param-name">DEBUG PATH</b></td>
				<td colspan="7"><%= detailsMap.get("TXN_FRONT_END_DEBUG_PATH") %></td>
			</tr>
		</table>
		<br />
		<%
		}
		if(detailsMap.get("ELCM_FE_REQD").equals("Y")){
		%>
		<table>
			<th colspan="10">ELCM</th>
			<tr>
				<td colspan="3"><b> ELCM APPLICATION LINK</b></td>
				<td colspan="7"><a href="<%= detailsMap.get("ELCM_APP_LINK") %>"
					target="_blank"><%= detailsMap.get("ELCM_APP_LINK") %></a></td>
			</tr>
			<tr>
				<td colspan="3"><b>WEBLOGIC CONSOLE</b></td>
				<td colspan="7"><a href="<%= detailsMap.get("ELCM_WEBLOGIC_CONSOLE") %>"
					target="_blank"><%= detailsMap.get("ELCM_WEBLOGIC_CONSOLE") %></a></td>
			</tr>
			<tr>
				<td colspan="3"><b>DEBUG PATH</b></td>
				<td colspan="7"><%= detailsMap.get("ELCM_FRONT_END_DEBUG_PATH") %></td>
			</tr>
		</table>
		<br />
		<%
		}
		%>
	</div>
	<hr />
	<%
		}
		if(detailsMap.get("BACKEND_DETAILS_REQD").equals("Y")){
		%>
	<h2>Backend Details</h2>
	<br />
	<%
		if(detailsMap.get("GRM_BE_REQD").equals("Y")){
		%>
	<table>
		<th colspan="10">GRM</th>
		<tr>
			<td colspan="2"><b>USERNAME</b></td>
			<td colspan="8"><%= detailsMap.get("GRM_USERNAME") %></td>
		</tr>
		<tr>
			<td colspan="2"><b>PASSWORD</b></td>
			<td colspan="8"><%= detailsMap.get("GRM_PASSWORD") %></td>
		</tr>
		<tr>
			<td colspan="2"><b>TNS</b></td>
			<td colspan="8"><pre><%= detailsMap.get("GRM_SERVICE_NAME") %>=
  (DESCRIPTION=
    (ADDRESS=(PROTOCOL=TCP)(HOST=<%= detailsMap.get("GRM_HOST") %>)(PORT=<%= detailsMap.get("GRM_PORT") %>))
    (CONNECT_DATA=
	  (SERVER=DEDICATED)
	  (SERVICE_NAME=<%= detailsMap.get("GRM_SERVICE_NAME") %>)
    )
  )</pre></td>
		</tr>
		<tr>
			<td colspan="2"><b>DEBUG PATH</b></td>
			<td colspan="8"><%= detailsMap.get("GRM_BACKEND_DEBUG_PATH") %></td>
		</tr>
	</table>
	<br />
	<%
		}
		if(detailsMap.get("TXN_BE_REQD").equals("Y")){
		%>
	<table>
		<th colspan="10">TXN</th>
		<tr>
			<td colspan="2"><b>USERNAME</b></td>
			<td colspan="8"><%= detailsMap.get("TXN_USERNAME") %></td>
		</tr>
		<tr>
			<td colspan="2"><b>PASSWORD</b></td>
			<td colspan="8"><%= detailsMap.get("TXN_PASSWORD") %></td>
		</tr>
		<tr>
			<td colspan="2"><b>TNS</b></td>
			<td colspan="8"><pre><%= detailsMap.get("TXN_SERVICE_NAME") %>=
  (DESCRIPTION=
    (ADDRESS=(PROTOCOL=TCP)(HOST=<%= detailsMap.get("TXN_HOST") %>)(PORT=<%= detailsMap.get("TXN_PORT") %>))
    (CONNECT_DATA=
	  (SERVER=DEDICATED)
	  (SERVICE_NAME=<%= detailsMap.get("TXN_SERVICE_NAME") %>)
    )
  )</pre></td>
		</tr>
		<tr>
			<td colspan="2"><b>DEBUG PATH</b></td>
			<td colspan="8"><%= detailsMap.get("TXN_BACKEND_DEBUG_PATH") %></td>
		</tr>
	</table>
	<br />
	<%
		}
		if(detailsMap.get("ELCM_BE_REQD").equals("Y")){
		%>
	<table>
		<th colspan="10">ELCM</th>
		<tr>
			<td colspan="2"><b>USERNAME</b></td>
			<td colspan="8"><%= detailsMap.get("ELCM_USERNAME") %></td>
		</tr>
		<tr>
			<td colspan="2"><b>PASSWORD</b></td>
			<td colspan="8"><%= detailsMap.get("ELCM_PASSWORD") %></td>
		</tr>
		<tr>
			<td colspan="2"><b>TNS</b></td>
			<td colspan="8"><pre><%= detailsMap.get("ELCM_SERVICE_NAME") %>=
  (DESCRIPTION=
    (ADDRESS=(PROTOCOL=TCP)(HOST=<%= detailsMap.get("ELCM_HOST") %>)(PORT=<%= detailsMap.get("ELCM_PORT") %>))
    (CONNECT_DATA=
	  (SERVER=DEDICATED)
	  (SERVICE_NAME=<%= detailsMap.get("ELCM_SERVICE_NAME") %>)
    )
  )</pre></td>
		</tr>
		<tr>
			<td colspan="2"><b>DEBUG PATH</b></td>
			<td colspan="8"><%= detailsMap.get("ELCM_BACKEND_DEBUG_PATH") %></td>
		</tr>
	</table>

	<%
		}
		}
    %>
</body>
</html>
<%
}
else{
//	System.out.println("i am here2 ");
%>
<html>
<head>
<style type="text/css">
	div{
		width:100%;
		padding-top:150px;
	}
	h1{
	    
		text-align: center;
	}
</style>
</head>
<body>
    <div>
		<h1>NO DETAILS ARE MAINTAINED FOR THE ENVIRONMENT.</h1>
	</div>
</body>
</html>
<%
}
%>

