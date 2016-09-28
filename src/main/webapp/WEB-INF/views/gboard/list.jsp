<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false"%>
<html>
<head>
<title>list.jsp</title>
</head>
<body>

	<div class="row">
		<!-- left column -->

		<div class="col-md-12">
			<!-- general form elements -->
			<div class='box'>
				<div class="box-header with-border">
					<h3 class="box-title"><strong>게임 리뷰 게시판</strong></h3>
				</div>
			</div>

			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title"><strong>목록</strong></h3>
				</div>
				<div class="box-body">
					<table class="table table-hover">
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr>

						<c:forEach items="${list}" var="gboardVO">

							<tr>
								<td>${gboardVO.bno}</td>
								<td><a
									href='/gboard/readPage${pageMaker.makeSearch(pageMaker.cri.page) }&bno=${gboardVO.bno}'>
										${gboardVO.title} <strong>[ ${gboardVO.replycnt} ]</strong>
								</a></td>
								<td>${gboardVO.writer}</td>
								<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm"
										value="${gboardVO.regdate}" /></td>
								<td><span class="badge bg-primary">${gboardVO.viewcnt }</span></td>
							</tr>

						</c:forEach>
					</table>
					
					<div class='box-body'>
					
					<select name="searchType">
						<option value="n"
							<c:out value="${cri.searchType == null?'selected':''}"/>>
							---</option>
						<option value="t"
							<c:out value="${cri.searchType eq 't'?'selected':''}"/>>
							제목</option>
						<option value="c"
							<c:out value="${cri.searchType eq 'c'?'selected':''}"/>>
							내용</option>
						<option value="w"
							<c:out value="${cri.searchType eq 'w'?'selected':''}"/>>
							작성자</option>
						<option value="tc"
							<c:out value="${cri.searchType eq 'tc'?'selected':''}"/>>
							제목+작성자</option>
						<option value="cw"
							<c:out value="${cri.searchType eq 'cw'?'selected':''}"/>>
							내용+작성자</option>
						<option value="tcw"
							<c:out value="${cri.searchType eq 'tcw'?'selected':''}"/>>
							제목+내용+작성자</option>
					</select> <input type="text" name='keyword' id="keywordInput"
						value='${cri.keyword }'>
					<button id='searchBtn'>검색하기</button>
					<button id='newBtn'>글쓰기</button>
					
			</div>
					
				</div>
				<!-- /.box-body -->


				<div class="box-footer">

					<div class="text-center">
						<ul class="pagination">

							<c:if test="${pageMaker.prev}">
								<li><a
									href="list${pageMaker.makeSearch(pageMaker.startPage - 1) }">&laquo;</a></li>
							</c:if>

							<c:forEach begin="${pageMaker.startPage }"
								end="${pageMaker.endPage }" var="idx">
								<li
									<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
									<a href="list${pageMaker.makeSearch(idx)}">${idx}</a>
								</li>
							</c:forEach>

							<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
								<li><a
									href="list${pageMaker.makeSearch(pageMaker.endPage +1) }">&raquo;</a></li>
							</c:if>

						</ul>
					</div>

				</div>
				<!-- /.box-footer-->
			</div>
		</div>
		<!--/.col (left) -->

	</div>
	<!-- /.row -->

	<script>
		var result = '${msg}';

		if (result == 'SUCCESS') {
			alert("처리가 완료되었습니다.");
			location.replace(self.location);
		}
	</script>

	<script>
		$(document).ready(
				function() {

					$('#searchBtn').on(
							"click",
							function(event) {

								self.location = "list"
										+ '${pageMaker.makeQuery(1)}'
										+ "&searchType="
										+ $("select option:selected").val()
										+ "&keyword="
										+ $('#keywordInput').val();
							});

					$('#newBtn').on("click", function(evt) {
						self.location = "register";
					});

				});
	</script>

</body>
</html>