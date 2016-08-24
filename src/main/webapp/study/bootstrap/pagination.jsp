<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pagination.jsp</title>
   
   <!-- Bootstrap 3.3.4 -->
   <link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
   
   <!-- jQuery 2.1.4 -->
   <script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
   
   <!-- Font Awesome Icons -->
   <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
   
</head>
<body>

<div class="text-center">
		<ul class="pagination">
			<li><a href="/sboard/list?page=1">&lt;&lt;</a></li>
			<li><a href="/sboard/list?page=1">1</a></li>
			<li><a href="/sboard/list?page=2">2</a></li>
			<li><a href="/sboard/list?page=3">3</a></li>
			<li><a href="/sboard/list?page=4">4</a></li>
			<li><a href="/sboard/list?page=5">5</a></li>
			<li><a href="/sboard/list?page=1">&gt;&gt;</a></li>
		</ul>
	</div>
</body>
</html>