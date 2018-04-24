<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/header.jsp"%>
	
<script>
	$(document).ready(function() {
		var result ='${msg}';
		if (result == 'success') {
			alert('처리가 완료되었습니다.');
		}
		
		$("#searchBtn").on("click", function() {
			self.location = "list"
					+ "${pageMaker.makeQuery(1)}"
					+ "&searchType=" + $("select option:selected").val()
					+ "&keyword=" + $("#keywordInput").val();
		})
		
		$("#newBtn").on("click", function() {
			self.location = "register";
		})
	});
</script>
</head>

<body class="hold-transition skin-blue sidebar-mini">
<%@ include file="../include/navigation.jsp"%>

<!-- Main content -->
<section class="content">
	<div class="row">
		<div class="col-md-12">
		
		
			<!-- general form elements -->
			<div class='box'>
				<div class="box-header with-border">
					<h3 class="box-title">Search Board</h3>
				</div>
				<div class='box-body'>
					<select>
						<c:forEach var="option" items="${searchTypeMap}">
							<option value="${option.value}" <c:out value="${cri.searchType eq option.value  ? 'selected' : ''}" />>${option.key}</option>
						</c:forEach>
					</select>
					<input type="text" name="keyword" id="keywordInput" value="${cri.keyword}">
					<button id='searchBtn'>Search</button>
					<button id='newBtn'>New Board</button>
				</div>
			</div>
	
			<!-- Default box -->
			<div class="box">
				<div class="box-header with-border">
					<h3 class="box-title">LIST ALL PAGE</h3>
				</div>
				
				
				
	<div class="box-body">
		<table class="table table-bordered">
			<tr>
				<th style="width: 10px">BNO</th>
				<th>TITLE</th>
				<th>WRITER</th>
				<th>REGDATE</th>
				<th style="width: 40px">VIEWCNT</th>
			</tr>
		<c:forEach var="board" items="${list}">
			<tr>
				<td>${board.bno}</td>
				<td>
					<a href="/sboard/readPage${pageMaker.makeSearch(pageMaker.cri.page)}&bno=${board.bno}">
						${board.title}&nbsp;<strong>[${board.replycnt}]</strong>
					</a>
				</td>
				<td>${board.writer}</td>
				<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${board.regdate}"/></td>
				<td>${board.viewcnt}</td>
			</tr>
		</c:forEach>
		</table>
	</div>
	<!-- /.box-body -->
	
	<div class="box-footer">
		<div class="text-center">
			<ul class="pagination">
				<c:if test="${pageMaker.prev}">
					<li><a href="list${pageMaker.makeSearch(pageMaker.startPage-1)}">&laquo;</a></li>
				</c:if>
				
				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
					<li <c:out value="${pageMaker.cri.page == idx ? 'class=active' : '' }"/>>
						<a href="list${pageMaker.makeSearch(idx)}">${idx}</a>
					</li>
				</c:forEach>
				
				<c:if test="${pageMaker.next}">
					<li><a href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}">&raquo;</a></li>
				</c:if>
			</ul>
		</div>
	</div>
	<!-- /.box-footer-->
				
				
				
			</div>
			<!-- /.box -->
			
		</div>
		<!-- /.col -->
	</div>
	<!-- /.row -->
</section>
<!-- /.content -->

<%@ include file="../include/footer.jsp"%>

</body>
</html>

