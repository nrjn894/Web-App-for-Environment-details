var request;  
//Function for sending AJAX request to getEnvironmentsList.jsp to get the List of Environments in form of HTML table 
function sendEnvironmentListRequest()  
{   
	var url="getEnvironmentsList.jsp";  
  
	if(window.XMLHttpRequest){  
		request=new XMLHttpRequest();  
	}  
	else if(window.ActiveXObject){  
		request=new ActiveXObject("Microsoft.XMLHTTP");  
	}  
  
	try  
	{  
		request.onreadystatechange=setEnvironmetList;  
		request.open("GET",url,true);  
		request.send();  
	}  
	catch(e)  
	{  
		alert("Unable to connect to server");  
	}  
}  

//Function for setting the HTML response returned from getEnvironmentsList.jsp in Home.jsp's TABS portion
function setEnvironmetList()
{  
	if(request.readyState==4)
	{  
		var table =request.responseText;  
		var tabs = document.getElementById('Tabs');
		tabs.innerHTML += table;
		console.log(table);
	}  
}  

var request2;
//Function for sending AJAX request to detailTemplate.jsp to get the details of Environment passed as parameter, in form of HTML page 
function sendEnvironmentDetailsRequest(filename,ButtonId)  
{   
	if(ButtonId!=-1){
		var pastActiveButtons = document.getElementsByClassName("clicked");
		for(var i = 0;i < pastActiveButtons.length; i++){
			pastActiveButtons[0].classList.remove("clicked");
		}
		var clickedButton = document.getElementById(ButtonId);
		clickedButton.classList.add("clicked");
	}
	var url="detailTemplate.jsp?filename="+filename;  
  
	if(window.XMLHttpRequest)
	{  
		request2=new XMLHttpRequest();  
	}  
	else if(window.ActiveXObject){  
		request2=new ActiveXObject("Microsoft.XMLHTTP");  
	}  
  
	try  
	{  
		request2.onreadystatechange=setEnvironmetDetails;  
		request2.open("GET",url,true);  
		request2.send();  
	}  
	catch(e)  
	{  
		alert("Unable to connect to server");  
	}
}  
//Function for setting the HTML response returned from detailTemplate.jsp in Home.jsp's Details portion as iframe
function setEnvironmetDetails()
{  
	if(request2.readyState==4)
	{  
		var html =request2.responseText;  
		var details = document.getElementById('Details');
		var iframe = document.createElement('iframe');
		iframe.style.height = (document.documentElement.clientHeight - 10)+"px";
		iframe.src = 'data:text/html;charset=utf-8,' + encodeURI(html);
		while (details.hasChildNodes()) 
		{  
			details.removeChild(details.firstChild);
		}
		details.appendChild(iframe);
		console.log(html);
	}  
}
sendEnvironmentListRequest();
sendEnvironmentDetailsRequest("Default",-1);