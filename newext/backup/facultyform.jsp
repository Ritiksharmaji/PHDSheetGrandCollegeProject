<%@ include file="loginCheck.jsp" %>
<%@ page import="java.sql.*,model.DataManager"%>
<% DataManager database=(DataManager)pageContext.getAttribute("db",PageContext.APPLICATION_SCOPE); Connection con=database.getConnection(); %>
<head>
<style type="text/css">
td	{font-size:9pt; font-family: arial, Verdana; font-weight:bold;}
</style>
<link rel="stylesheet" type="text/css" href="./cal/epoch_styles.css" />
	<script type="text/javascript" src="./cal/epoch_classes.js"></script>
	<script type="text/javascript">
	var xmlhttp,xmlhttp1,xmlhttp2;
	var cal1,cal2;      
	window.onload = function ()
	{	
		cal1  = new Epoch('epoch_popup','popup',document.getElementById('dt1'));
		cal2  = new Epoch('epoch_popup','popup',document.getElementById('dt2'));
	};
		</script>
<script type="text/javascript">
var xmlhttp,xmlhttp1,xmlhttp2,xmlhttp3,xmlhttp5;
function showBranch()
{
	var str=document.RMatt.course.value;
	//alert(str);
	xmlhttp=GetXmlHttpObject();
	if (xmlhttp==null)
	{
		alert ("Your browser does not support AJAX!");
		return;
	}
	var url="branchAJAX.jsp";
	url=url+"?cc="+str;

	xmlhttp.onreadystatechange=stateChanged;
	xmlhttp.open("GET",url,true);
	xmlhttp.send(null);
}

function stateChanged()
{		

	if (xmlhttp.readyState==4)
	{

		var xmldoc = xmlhttp.responseXML.documentElement;
		
		
		document.RMatt.branch.options.length=0;
		var bcode;
		var btitle;
		var bname;
		var i;
		var x=xmldoc.getElementsByTagName("branch");

		for(i=0;i<x.length;i++)
		{
			bcode=x[i].getElementsByTagName("bcode")[0].childNodes[0].nodeValue;
			btitle=x[i].getElementsByTagName("btitle")[0].childNodes[0].nodeValue;
			bname=x[i].getElementsByTagName("bname")[0].childNodes[0].nodeValue;
			//alert(bcode+"\n"+btitle+"\n"+bname);
			
			var y = document.createElement("option");
			y.text=bname;
			y.value=bcode;
			y.title=btitle;

			try
			{
				document.RMatt.branch.add(y,null);
			}
			catch(e)
			{
				document.RMatt.branch.add(y);
			}
		}
	}
}

function GetXmlHttpObject()
{
	if (window.XMLHttpRequest)
	{
		// code for IE7+, Firefox, Chrome, Opera, Safari
		return new XMLHttpRequest();
	}
	if (window.ActiveXObject)
	{
		// code for IE6, IE5
		return new ActiveXObject("Microsoft.XMLHTTP");
	}
	return null;
}
function validate()
{
	//alert("hi");
	if(document.RMatt.course.value=="select")
	{
		alert("Select Course");
		document.RMatt.course.focus();
	}
	else if(document.RMatt.branch.value=="select")
	{
		alert("Select Branch");
		document.RMatt.branch.focus();
	}
	else if(document.RMatt.section.value=="")
	{
		alert("Enter Section ");
		document.RMatt.section.focus();
	}
	else if(document.RMatt.batch.value=="")
	{
		alert("Enter Batch ");
		document.RMatt.batch.focus();
	}
	else
	{
		//Form Submit Code
		document.RMatt.action="faculty.jsp";
		document.RMatt.submit();
	}

}
function showSubject()
{
	xmlhttp2=GetXmlHttpObject();
	if (xmlhttp2==null)
	{
		alert ("Your browser does not support AJAX!");
		return;
	}
	var url="subjectAJAX.jsp";
	url=url+"?sc="+document.RMatt.course.value;
	url=url+"&bc="+document.RMatt.branch.value;
	url=url+"&cyear="+document.RMatt.cyear.value;
	url=url+"&semester="+document.RMatt.semester.value;
	url=url+"&regulation="+document.RMatt.regulation.value;

	xmlhttp2.onreadystatechange=subjectChanged;
	xmlhttp2.open("GET",url,true);
	xmlhttp2.send(null);
}
function subjectChanged()
{
	if (xmlhttp2.readyState==4)
	{
		var xmldoc = xmlhttp2.responseXML.documentElement;
		
		document.RMatt.subject.options.length=1;
		var scode;
		var i;
		var shortname;
		var x=xmldoc.getElementsByTagName("subject");
		for(i=0;i<x.length;i++)
		{
			scode=x[i].getElementsByTagName("scode")[0].childNodes[0].nodeValue;
			shortname=x[i].getElementsByTagName("shortname")[0].childNodes[0].nodeValue;
			var y = document.createElement("option");
			y.text=shortname;
			y.value=scode;
			try
			{
				document.RMatt.subject.add(y,null);
			}
			catch(e)
			{

				document.RMatt.subject.add(y);
			}
		}
	}
}
</script>
</head>
<body>
<center>
<fieldset style="width:100%;">
<legend style="font-size:10pt;font-family:Verdana;font-weight:bold;color:blue;">Student Current Status -  Report</legend>
<form name="RMatt" method="POST">
<table border=0 cellspacing=0 cellpadding=5 align="center">

<tr>
<td>From Date:</td>
<td><input type=text size=10 name="date1"  id="dt1">
</tr>
<tr>
<td>To Date:</td>
<td><input type=text size=10 name="date2"  id="dt2">
</tr>

<tr>
<td colspan="3" align="center"><input type="button" value="Submit" onclick="validate()">
</tr>
</table>
</form>
</fieldset>
</div>
</div>
</body>
</html>