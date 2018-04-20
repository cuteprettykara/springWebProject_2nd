<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/header.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		var formObj = $("form[role='form']");
		
		$("#save").on("click", function() {
  			formObj.attr("action", "/board/modifyPage");
 			formObj.attr("method", "post");
			formObj.submit();
		});
	
		$("#cancel").on("click", function() {
			self.location = "/board/listPage?page=" + ${cri.page} + "&perPageNum=" + ${cri.perPageNum};
		});
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
					<h3 class="box-title">REGISTER BOARD</h3>
				</div>
				
				
				
<form role="form" method="post">	
	<input type="hidden" name="bno" value="${boardVO.bno}" />
	<input type="hidden" name="page" value="${cri.page}" />	
	<input type="hidden" name="perPageNum" value="${cri.perPageNum}" />	

			
	<div class="box-body">
		<div class="form-group">
			<label for="exampleInputEmail1">Title</label> 
			<input type="text" name='title' class="form-control" placeholder="Enter Title" value="${boardVO.title}">
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1">Content</label>
			<textarea class="form-control" name="content" rows="3" placeholder="Enter ...">${boardVO.content}</textarea>
		</div>
		<div class="form-group">
			<label for="exampleInputEmail1">Writer</label> 
			<input type="text" name="writer" class="form-control" placeholder="Enter Writer" readonly="readonly" value="${boardVO.writer}">
		</div>
	</div>
	<!-- /.box-body -->

	<div class="box-footer">
		<button type="button" class="btn btn-primary" id="save">Save</button>
		<button type="button" class="btn btn-warning" id="cancel">Cancel</button>
	</div>
	<!-- /.box-footer-->
</form>
				
				
				
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
