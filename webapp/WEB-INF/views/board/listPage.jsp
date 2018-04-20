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
		
		$(".pagination li a").on("click", function(e) {
			e.preventDefault();
			
			var targetPage = $(this).attr("href");
			var jobForm = $("#jobForm");
			
			jobForm.find("[name='page']").val(targetPage);
			jobForm.attr("action", "/board/listPage").attr("method", "get");
			jobForm.submit();
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
				<td><a href="/board/readPage${pageMaker.makeQuery(pageMaker.cri.page)}?bno=${board.bno}">${board.title}</a></td>
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
					<li><a href="${pageMaker.startPage-1}">&laquo;</a></li>
				</c:if>
				
				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
					<li <c:out value="${pageMaker.cri.page == idx ? 'class=active' : '' }"/>>
						<a href="${idx}">${idx}</a>
					</li>
				</c:forEach>
				
				<c:if test="${pageMaker.next}">
					<li><a href="${pageMaker.endPage + 1}">&raquo;</a></li>
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

<form id="jobForm">
	<input type='hidden' name="page">
  	<input type='hidden' name="perPageNum" value=${pageMaker.cri.perPageNum}>
</form>

<%@ include file="../include/footer.jsp"%>

</body>
</html>

