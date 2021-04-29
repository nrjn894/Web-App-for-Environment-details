<%@ page language="java" %>
<%@ page import="java.io.*" %>
<table>
	<thead>
		<th><h3>Environment Lists</h3></th>
	</thead>
	<tbody>
<%
String EnvironmentsListFilePath = application.getInitParameter("Environment_List_File_Path");
String EnvironmentsListFileName = application.getInitParameter("Environment_List_File_Name");
String DefaultEnvironmentFileName = application.getInitParameter("Default_Environment_Details_File");
if(EnvironmentsListFilePath.contains("\\")&&!EnvironmentsListFilePath.endsWith("\\")){
	EnvironmentsListFilePath = EnvironmentsListFilePath+"\\";
}
else if(EnvironmentsListFilePath.contains("/")&&!EnvironmentsListFilePath.endsWith("/")){
	EnvironmentsListFilePath = EnvironmentsListFilePath+"/";
}
BufferedReader in = null;
try{
	FileReader fre = new FileReader(EnvironmentsListFilePath + EnvironmentsListFileName);
	in = new BufferedReader(fre);
	String line = null;
	line = in.readLine();
	int buttonId = 1;
	while(line !=null) 
	{
		line = line.trim();
		if(!"".equals(line))
		{
			String[] arr = line.split("#");
			String EnvName = null;
			String fileName = null;
			if(arr.length>0){
				EnvName = arr[0];
			}
			if(arr.length>1)
			{
				fileName = arr[1];
			}
			else
			{
				fileName = "#";
			}
			if(fileName.equals(DefaultEnvironmentFileName) ){
				out.print("<tr><td><button class=\"clicked\" id =\""+buttonId+++"\" onclick=\"sendEnvironmentDetailsRequest("+"\'"+fileName+"\',this.id"+")\">"+EnvName+"</button></td></tr>");
			}
			else{
				out.print("<tr><td><button id =\""+buttonId+++"\" onclick=\"sendEnvironmentDetailsRequest("+"\'"+fileName+"\',this.id"+")\">"+EnvName+"</button></td></tr>");
			}
			
		}
	   line = in.readLine();
	}
}catch(Exception e)
{
}finally
{
	try
	{
		in.close();
	}catch(Exception e){}
}

%>
	</tbody>
</table>