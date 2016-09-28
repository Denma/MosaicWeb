<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>

<head>
<title>readPage.jsp</title>
	<!-- Bootstrap 3.3.4 -->
	<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

	<link
		href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
		rel="stylesheet" type="text/css" />
	<!-- 	javascript 댓글관련 ↓  -->
	<script type="text/javascript" src="/resources/js/upload.js"></script>
	
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<!-- Main content -->	
	<style type="text/css">
	.popup {
		position: absolute;
	}
	
	.back {
		background-color: gray;
		opacity: 0.5;
		width: 100%;
		height: 300%;
		overflow: hidden;
		z-index: 1101;
	}
	
	.front {
		z-index: 1110;
		opacity: 1;
		boarder: 1px;
		margin: auto;
	}
	
	.show {
		position: relative;
		max-width: 1200px;
		max-height: 800px;
		overflow: auto;
	}
	</style>
</head>
<body>
<!-- 	이미지 보여주는 영역  ↓-->
    <div class='popup back' style="display:none;"></div>
    <div id="popup_front" class='popup front' style="display:none;">
     <img id="popup_img">
    </div>
    
<!-- 		조회 폼 관련 부분  -->
	<div class="row">
		<!-- left column -->
		<div class="col-md-12">
			<!-- general form elements -->
			<div class="box box-primary">
				<div class="box-header">
					<h3 class="box-title">READ BOARD</h3>
				</div>
				<!-- /.box-header -->

				<form role="form" action="modifyPage" method="post">

					<input type='hidden' name='bno' value="${gboardVO.bno}"> <input
						type='hidden' name='page' value="${cri.page}"> <input
						type='hidden' name='perPageNum' value="${cri.perPageNum}">
					<input type='hidden' name='searchType' value="${cri.searchType}">
					<input type='hidden' name='keyword' value="${cri.keyword}">

				</form>

				<div class="box-body">
					<div class="form-group">
						<label for="exampleInputEmail1">제목</label>
						 
						<input type="text"
								name='title' class="form-control" value="${gboardVO.title}"
								readonly="readonly">
					</div>
					<div class="form-group">
						<label for="exampleInputPassword1">내용</label>
						<textarea class="form-control" name="content" rows="3"
						 autofocus="autofocus" readonly="readonly">${gboardVO.content}</textarea>
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">작성자</label>
						
						<input type="text"
								name="writer" class="form-control" value="${gboardVO.writer}"
								readonly="readonly">
					</div>
				</div>
				<!-- /.box-body -->

				<div class="box-footer">

					<div>
						<hr>
					</div>

					<ul class="mailbox-attachments clearfix uploadedList">
					</ul>
					<c:if test="${login.uid == gboardVO.writer}">
						<button type="submit" class="btn btn-warning" id="modifyBtn">수정</button>
						<button type="submit" class="btn btn-danger" id="removeBtn">삭제</button>
					</c:if>
					<button type="submit" class="btn btn-primary" id="goListBtn">목록으로</button>
				</div>

			</div>
			<!-- /.box -->
		</div>
		<!--/.col (left) -->
<!-- 		<div class="col-md-6"> -->
<!-- 			<img class="img-circle" style="width: 100%" alt="xxx" src="http://www.loremflickr.com/200/200/dog"/> -->
<!-- 		</div> -->

	</div>
	<!-- /.row 댓글관련 부분-->

	<div class="row">
		<div class="col-md-12">


			<div class="box box-success">
				<div class="box-header">
					<h3 class="box-title">댓글 추가하기</h3>
				</div>

				<!-- 로그인 상태 -->
				<c:if test="${not empty login}">
					<div class="box-body">
						<label for="exampleInputEmail1">작성자</label>
						
						<input
							class="form-control" type="text"
							id="newReplyWriter" value="${login.uid }" readonly="readonly">
							
						<label for="exampleInputEmail1">댓글내용</label>
						
						<input
							class="form-control" type="text" id="newReplyText">
							
					</div>

					<div class="box-footer">
						<button type="submit" class="btn btn-primary" id="replyAddBtn">댓글 추가하기</button>
					</div>
				</c:if>
				
				<!-- 로그아웃 상태 -->
				<c:if test="${empty login}">
					<div class="box-body">
						<div>
							<a href="/user/login">로그인 후 이용하세요</a>
						</div>
					</div>
				</c:if>
			</div>



			<!-- The time line -->
			<ul class="timeline">
				<!-- timeline time label -->
				<li class="time-label" id="repliesDiv"><span class="bg-green">
						댓글 목록 <small id='replycntSmall'> [
							${gboardVO.replycnt} ] </small>
				</span></li>
			</ul>

			<div class='text-center'>
				<ul id="pagination" class="pagination pagination-sm no-margin ">

				</ul>
			</div>

		</div>
		<!-- /.col -->
	</div>
	<!-- /.row -->

	<!-- Modal 댓글 수정 알럿 창 관련 부분 ↓ --> 
	<div id="modifyModal" class="modal modal-primary fade" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">댓글 수정 및 삭제</h4>
				</div>
				<div class="modal-body" data-rno>
					<p>
						<input type="text" id="replytext" class="form-control">
					</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-info" id="replyModBtn">수정</button>
					<button type="button" class="btn btn-danger" id="replyDelBtn">삭제</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

<script id="templateAttach" type="text/x-handlebars-template">
	<li data-src='{{fullName}}'>
		<span class="mailbox-attachment-icon has-img">
			<img src="{{imgsrc}}" alt="Attachment">
		</span>
	<div class="mailbox-attachment-info">
	     <a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
	     </span>
  	  </div>
    </li>                
</script>  


          
<script id="template" type="text/x-handlebars-template">
	{{#each .}}
	     <li class="replyLi" data-rno={{rno}}>
            <i class="fa fa-forwa0rd bg-blue"></i>
            <div class="timeline-item" >
             <span class="time">
                <i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
             </span>
             <h3 class="timeline-header"><strong>{{rno}}</strong> -{{replyer}}</h3>
             <div class="timeline-body">{{replytext}} </div>
			 <div class="timeline-footer">
			    {{#eqReplyer replyer }}
                   <a class="btn btn-primary btn-xs" data-toggle="modal" data-target="#modifyModal">Modify</a>
				{{/eqReplyer}}
			 </div>
	        </div>			
          </li>
    {{/each}}
</script>  

<script>

// 	댓글은 자바 스크립트로 진행  ↓
	Handlebars.registerHelper("eqReplyer", function(replyer, block) {
		var accum = '';
		if (replyer == '${login.uid}') {
			accum += block.fn();
		}
		return accum;
	});

	Handlebars.registerHelper("prettifyDate", function(timeValue) {
		var dateObj = new Date(timeValue);
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth() + 1;
		var date = dateObj.getDate();
		return year + "/" + month + "/" + date;
	});

	var printData = function(replyArr, target, templateObject) {

		var template = Handlebars.compile(templateObject.html());

		var html = template(replyArr);
		$(".replyLi").remove();
		target.after(html);

	}

	var bno = ${gboardVO.bno};

	var replyPage = 1;
	
// 	Ajax 사용 ↓
	function getPage(pageInfo) {

		$.getJSON(pageInfo, function(data) {
			printData(data.list, $("#repliesDiv"), $('#template'));
			printPaging(data.pageMaker, $(".pagination"));

			$("#modifyModal").modal('hide');
			$("#replycntSmall").html("[ " + data.pageMaker.totalCount + " ]");

		});
	}

	var printPaging = function(pageMaker, target) {

		var str = "";

		if (pageMaker.prev) {
			str += "<li><a href='" + (pageMaker.startPage - 1)
					+ "'> << </a></li>";
		}

		for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
			var strClass = pageMaker.cri.page == i ? 'class=active' : '';
			str += "<li "+strClass+"><a href='"+i+"'>" + i + "</a></li>";
		}

		if (pageMaker.next) {
			str += "<li><a href='" + (pageMaker.endPage + 1)
					+ "'> >> </a></li>";
		}

		target.html(str);
	};

	$("#repliesDiv").on("click", function() {
		
		alert("repliesDiv clicked....");
		
		if ($(".timeline li").size() > 1) {
			return;
		}
		getPage("/greplies/" + bno + "/1");

	});

	$(".pagination").on("click", "li a", function(event) {
		
		alert("pagination clicked...." + replyPage);

		event.preventDefault();

		replyPage = $(this).attr("href");

		getPage("/greplies/" + bno + "/" + replyPage);

	});

	$("#replyAddBtn").on("click", function() {
		
		alert("replyAddBtn clicked....");
		
		var replyerObj = $("#newReplyWriter");
		var replytextObj = $("#newReplyText");
		var replyer = replyerObj.val();
		var replytext = replytextObj.val();

		$.ajax({
			type : 'post',
			url : '/greplies/',
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
			dataType : 'text',
			data : JSON.stringify({
				bno : bno,
				replyer : replyer,
				replytext : replytext
			}),
			success : function(result) {
				console.log("result: " + result);
				if (result == 'SUCCESS') {
					alert("등록 되었습니다.");
					replyPage = 1;
					getPage("/greplies/" + bno + "/" + replyPage);
					replyerObj.val("");
					replytextObj.val("");
				}
			}
		});
	});

	$(".timeline").on("click", ".replyLi", function(event) {

		var reply = $(this);

		$("#replytext").val(reply.find('.timeline-body').text());
		$(".modal-title").html(reply.attr("data-rno"));

	});

	$("#replyModBtn").on("click", function() {

		alert("replyModeBtn clicked.....");
		
		var rno = $(".modal-title").html();
		var replytext = $("#replytext").val();

		$.ajax({
			type : 'put',
			url : '/greplies/' + rno,
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "PUT"
			},
			data : JSON.stringify({
				replytext : replytext
			}),
			dataType : 'text',
			success : function(result) {
				console.log("result: " + result);
				if (result == 'SUCCESS') {
					alert("수정 되었습니다.");
					getPage("/greplies/" + bno + "/" + replyPage);
				}
			}
		});
	});

	$("#replyDelBtn").on("click", function() {

		var rno = $(".modal-title").html();
		var replytext = $("#replytext").val();

		$.ajax({
			type : 'delete',
			url : '/replies/' + rno,
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "DELETE"
			},
			dataType : 'text',
			success : function(result) {
				console.log("result: " + result);
				if (result == 'SUCCESS') {
					alert("삭제 되었습니다.");
					getPage("/replies/" + bno + "/" + replyPage);
				}
			}
		});
	});
</script>


<script>
$(document).ready(function(){
	
	var formObj = $("form[role='form']");
	
	console.log(formObj);
	
	$("#modifyBtn").on("click", function(){
		formObj.attr("action", "/gboard/modifyPage");
		formObj.attr("method", "get");		
		formObj.submit();
	});
	
/* 	$("#removeBtn").on("click", function(){
		formObj.attr("action", "/gboard/removePage");
		formObj.submit();
	}); */

	
	$("#removeBtn").on("click", function(){
		
		var replyCnt =  $("#replycntSmall").html();
		
		if(replyCnt > 0 ){
			alert("댓글이 달린 게시물은 삭제할 수 없습니다.");
			return;
		}	
		
		var arr = [];
		$(".uploadedList li").each(function(index){
			 arr.push($(this).attr("data-src"));
		});
		
		if(arr.length > 0){
			$.post("/deleteAllFiles",{files:arr}, function(){
				
			});
		}
		
		formObj.attr("action", "/gboard/removePage");
		formObj.submit();
	});	
	
	$("#goListBtn ").on("click", function(){
		formObj.attr("method", "get");
		formObj.attr("action", "/gboard/list");
		formObj.submit();
	});
	
	var bno = ${gboardVO.bno};
	var template = Handlebars.compile($("#templateAttach").html());
	
	$.getJSON("/gboard/getAttach/"+bno,function(list){
		$(list).each(function(){
			
			var fileInfo = getFileInfo(this);
			
			var html = template(fileInfo);
			
			 $(".uploadedList").append(html);
			
		});
	});
	


	$(".uploadedList").on("click", ".mailbox-attachment-info a", function(event){
		
		var fileLink = $(this).attr("href");
		
		if(checkImageType(fileLink)){
			
			event.preventDefault();
					
			var imgTag = $("#popup_img");
			imgTag.attr("src", fileLink);
			
			console.log(imgTag.attr("src"));
					
			$(".popup").show('slow');
			imgTag.addClass("show");		
		}	
	});
	
	$("#popup_img").on("click", function(){
		
		$(".popup").hide('slow');
		
	});	
	
		
	
});
</script>

</body>
</html>

