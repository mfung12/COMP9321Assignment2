<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="cs9321ass2.*, user.*, java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="result" class="cs9321ass2.ResultsBean" scope="session" />
<jsp:useBean id="user" class="cs9321ass2.UserBean" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Library Assignment 2">
    <meta name="author" content="">
    
	<title>Results Page - Digital Bibliographic Library</title>
	
	 <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/stylish-portfolio.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">
</head>

<%
	User currUser = user.getLoggedInUser().get(0);
	pageContext.setAttribute("isAdmin", currUser.get("isAdmin"));	
	pageContext.setAttribute("currUser", currUser);
%>

<body>

	<!-- Navigation -->
    <a id="menu-toggle" href="#" class="btn btn-dark btn-lg toggle"><i class="fa fa-bars"></i></a>
    <nav id="sidebar-wrapper">
        <ul class="sidebar-nav">
            <a id="menu-close" href="#" class="btn btn-light btn-lg pull-right toggle"><i class="fa fa-times"></i></a>
            <c:choose>
            	<c:when test="${isAdmin == 'true'}">
            		<li class="sidebar-brand">
		                <a href="#top" onclick=$("#menu-close").click()");>Welcome, <%= currUser.get("Username") %>!</a>
		            </li>		            
		            <li>
		            	<form action="admin.jsp" method="post">
							<input type="submit" value="Admin Control Panel">
						</form>
		            </li>
		            <li>
		            	<form action="search.jsp" method="post">
							<input type="submit" value="Home Page">
						</form>
		            </li>
		            <li>
		            	<form action="userDetails.jsp" method="post">
							<input type="submit" value="Profile">
						</form>
		            </li>
		            <li>
		                <form action="control" method="post">
							<input type="hidden" name="action" value="shopCart">
							<input type="submit" value="Shopping Cart">
						</form>
		            </li>
		            <li>
		            	<form action="addItem.jsp" method="post">
							<input type="submit" value="Register a Publication">
						</form>
		            </li>
		            <li>
		            	<form action="existingItems.jsp" method="post">
							<input type="submit" value="See my existing publications">
						</form>
		            </li>
		            <li>
		            	<form action="control" method="post">
							<input type="hidden" name="action" value="userLogout">
							<input type="submit" value="Logout">
						</form>
		            </li>		            
            	</c:when>
            	<c:otherwise>
            		<li class="sidebar-brand">
		                <a href="#top" onclick=$("#menu-close").click();>Welcome, <%= currUser.get("Username") %>!</a>
		            </li>
		            <li>
		            	<form action="userDetails.jsp" method="post">
							<input type="submit" value="Profile">
						</form>
		            </li>
		            <li>
		            	<form action="search.jsp" method="post">
							<input type="submit" value="Home Page">
						</form>
		            </li>
		            <li>
		                <form action="control" method="post">
							<input type="hidden" name="action" value="shopCart">
							<input type="submit" value="Shopping Cart">
						</form>
		            </li>
		            <li>
		            	<form action="addItem.jsp" method="post">
							<input type="submit" value="Register a Publication">
						</form>
		            </li>
		            <li>
		            	<form action="existingItems.jsp" method="post">
							<input type="submit" value="See my existing publications">
						</form>
		            </li>
		            <li>
		            	<form action="control" method="post">
							<input type="hidden" name="action" value="userLogout">
							<input type="submit" value="Logout">
						</form>
		            </li>
            	</c:otherwise>
            </c:choose>            
        </ul>
    </nav>
    
    
	<!-- Header -->
    <header id="top" class="header">
        <div class="text-vertical-center">
            <h1>Digital Bibliographic Library</h1>
		</div>
    </header>
    
    <!-- Results container -->
	<h1>Search results</h1>
    

	<!-- Pagination -->
	<c:set var="resultLength" value="${fn:length(result.results)}"/>	
	<c:set var="perPage" scope="session"  value="10"/>
	<c:set var="pageStart" value="${param.start}"/>
	<c:set var="pageNum" value="${param.pageNum}"/>
	<c:if test="${empty pageStart or pageStart < 0}">
	    <c:set var="pageStart" value="0"/>
	    <c:set var="pageNum" value="1"/>
	</c:if>
	<c:if test="${resultLength < pageStart}">
	    <c:set var="pageStart" value="${pageStart - perPage}"/>
	</c:if>
	<c:if test="${resultLength < 10 }">
		<c:set var="pageStart" value="0"/>
		<c:set var="perPage" value="${resultLength }"/>
	</c:if>
	
	<c:set var="input1" value="${param.input1 }"/>
	<c:set var="searchType" value="${param.action }"/>
	<c:set var="year" value="${param.year }"/>
	<c:set var="address" value="${param.address }"/>
	<c:set var="author" value="${param.author }"/>
	<c:set var="publisher" value="${param.publisher }"/>
	<c:set var="isbn" value="${param.isbn }"/>
	
	<%int i = Integer.parseInt((String)pageContext.getAttribute("pageStart")); %>
	
	

	<c:choose>
		
		<c:when test="${isEmpty eq 'true'}">
			<h1>Sorry, no results were found.</h1>
		</c:when>
		
		<c:when test="${noneSelected eq 'true'}">
			<h1>Sorry, no publications were selected when adding to cart!</h1>
			
			<form action="control">
				<div id="tablecontainer" style="overflow: auto; height: 200px;">
						<table class="table table-hover" border="2">	
							<tr>
								<th></th>
								<th>
									Title
								</th>
								<th>
									Author
								</th>
								<th>
									Editor
								</th>
								<th>
									Year
								</th>
								<th>
									Volume
								</th>
								<th>
									Price
								</th>
								<th>
									Picture
								</th>								
							</tr>				
							<c:forEach var="book" items="${results}" begin="${pageStart}" end="${pageStart + perPage - 1}">
								<tr>
									<td>
										<input type="radio" name="srchRslts" value="${book.get('pID')}">
									</td>
									<td>
										${book.get("title")}
									</td>
									<td>
										${book.get("author")}
									</td>
									<td>
										${book.get("editor")}
									</td>
									<td>
										${book.get("year")}
									</td>
									<td>
										${book.get("volume")}
									</td>
									<td>
										${book.get("price")}
									</td>
									<td>
										${book.get("picture")}
									</td>
								</tr>
							</c:forEach>
						</table>	
				</div>
				<button type="submit" name="action" value="addtocartFrSearchResult">Add to Cart</button>
				<button type="submit" name="action" value="getdetail">Details</button>		
			</form>
			
		</c:when>
		<c:otherwise>
			<form action="control">
				<div id="tablewrapper">
					<table class="table table-hover" border="2">	
							<tr>
								<th></th>
								<th>
									Title
								</th>
								<th>
									Author
								</th>
								<th>
									Editor
								</th>
								<th>
									Year
								</th>
								<th>
									Volume
								</th>
								<th>
									Price
								</th>
								<th>
									Picture
								</th>								
							</tr>				
							<c:forEach var="book" items="${results}" begin="${pageStart}" end="${pageStart + perPage - 1}">
								<tr>
									<td>
										<input type="radio" name="srchRslts" value="${book.get('pID')}">
									</td>
									<td>
										${book.get("title")}
									</td>
									<td>
										${book.get("author")}
									</td>
									<td>
										${book.get("editor")}
									</td>
									<td>
										${book.get("year")}
									</td>
									<td>
										${book.get("volume")}
									</td>
									<td>
										${book.get("price")}
									</td>
									<td>
										${book.get("picture")}
									</td>
								</tr>
							</c:forEach>
						</table>
				</div>
				<button type="submit" name="action" value="addtocartFrSearchResult">Add to Cart</button>
				<button type="submit" name="action" value="getdetail">Details</button>
			</form>						
		</c:otherwise>
	</c:choose>
	
	<c:choose>
	<c:when test="${searchType eq 'mainSearch' }">
		<div class="right">
			<c:choose>
				<c:when test="${(pageStart eq 0) && (resultLength > 10)}">
					${pageNum }
					<a class="btn btn-primary btn-xs" href="?input1=${input1}&action=${searchType}&start=${pageStart + perPage}&pageNum=${pageNum + 1}">>></a>     
				</c:when>
				<c:when test="${(pageStart + 11 > resultLength) && (pageStart ne 0)}">
					<a class="btn btn-primary btn-xs" href="?input1=${input1}&action=${searchType}&start=${pageStart - perPage}&pageNum=${pageNum -1}"><<</a>
					${pageNum } 
				</c:when>
				<c:when test="${resultLength < 10}">
					${pageNum }
				</c:when>
				<c:otherwise>			  
					<a class="btn btn-primary btn-xs" href="?input1=${input1}&action=${searchType}&prevA=${prevA }&start=${pageStart - perPage}&pageNum=${pageNum -1}"><<</a>
					${pageNum }
					<a class="btn btn-primary btn-xs" href="?input1=${input1}&action=${searchType}&prevA=${prevA }&start=${pageStart + perPage}&pageNum=${pageNum + 1}">>></a>   
				</c:otherwise>
			</c:choose>    
		</div>			
	</c:when>
	<c:when test="${searchType eq 'specSearch' }">
		<div class="right">
			<c:choose>
				<c:when test="${(pageStart eq 0) && (resultLength > 10)}">
					${pageNum }
					<a class="btn btn-primary btn-xs" href="?year=${year }&address=${address }&author=${author }&publisher=${publisher }&isbn=${isbn}&action=${searchType}&start=${pageStart + perPage}&pageNum=${pageNum + 1}">>></a>     
				</c:when>
				<c:when test="${(pageStart + 10 > resultLength) && (pageStart ne 0)}">
					<a class="btn btn-primary btn-xs" href="?year=${year }&address=${address }&author=${author }&publisher=${publisher }&isbn=${isbn}&action=${searchType}&start=${pageStart - perPage}&pageNum=${pageNum -1}"><<</a>
					${pageNum } 
				</c:when>
				<c:when test="${resultLength < 10}">
					${pageNum }
				</c:when>
				<c:otherwise>			  
					<a class="btn btn-primary btn-xs" href="?year=${year }&address=${address }&author=${author }&publisher=${publisher }&isbn=${isbn}&action=${searchType}&prevA=${prevA }&start=${pageStart - perPage}&pageNum=${pageNum -1}"><<</a>
					${pageNum }
					<a class="btn btn-primary btn-xs" href="?year=${year }&address=${address }&author=${author }&publisher=${publisher }&isbn=${isbn}&action=${searchType}&prevA=${prevA }&start=${pageStart + perPage}&pageNum=${pageNum + 1}">>></a>   
				</c:otherwise>
			</c:choose>    
		</div>			
	</c:when>	
	</c:choose>
	
	
	<form action="search.jsp" method="post">
		<input type="submit" name="action" value="Back to Search"/>
	</form>
	
		<!-- jQuery -->
    <script src="<%=request.getContextPath()%>/js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
    
    <!-- Custom Theme JavaScript -->
    <script>   

    // Closes the sidebar menu
    $("#menu-close").click(function(e) {
        e.preventDefault();
        $("#sidebar-wrapper").toggleClass("active");
    });
    // Opens the sidebar menu
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#sidebar-wrapper").toggleClass("active");
    });
   
    // Scrolls to the selected menu item on the page
    $(function() {
        $('a[href*=#]:not([href=#],[data-toggle],[data-target],[data-slide])').click(function() {
            if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') || location.hostname == this.hostname) {
                var target = $(this.hash);
                target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
                if (target.length) {
                    $('html,body').animate({
                        scrollTop: target.offset().top
                    }, 1000);
                    return false;
                }
            }
        });
    });
    //#to-top button appears after scrolling
    var fixed = false;
    $(document).scroll(function() {
        if ($(this).scrollTop() > 250) {
            if (!fixed) {
                fixed = true;
                // $('#to-top').css({position:'fixed', display:'block'});
                $('#to-top').show("slow", function() {
                    $('#to-top').css({
                        position: 'fixed',
                        display: 'block'
                    });
                });
            }
        } else {
            if (fixed) {
                fixed = false;
                $('#to-top').hide("slow", function() {
                    $('#to-top').css({
                        display: 'none'
                    });
                });
            }
        }
    });
    
    </script>
</body>
</html>