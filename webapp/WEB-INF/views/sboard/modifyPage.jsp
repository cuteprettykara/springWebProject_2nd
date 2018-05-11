<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/header.jsp"%>

<!-- handlebars -->
<script src="/resources/handlebars/handlebars-v4.0.11.js"></script>
<!-- upload -->
<script src="/resources/js/upload.js"></script>

<style type="text/css">
	.fileDrop {
	  width: 80%;
	  height: 100px;
	  border: 1px dotted gray;
	  background-color: lightslategrey;
	  margin: auto;
	  
	}

	.popup {position: absolute;}
	.back { background-color: gray; opacity:0.5; width: 100%; height: 100%; overflow:hidden;  z-index:1101;}
	.front { 
   		z-index:1110; opacity:1; boarder:1px; margin: auto; 
  	}
 	.show{
  		position:relative;
   		max-width: 1200px; 
   		max-height: 800px; 
   		overflow: auto;       
 	} 
</style>

<script id="templateAttach" type="text/x-handlebars-template">
<li>
	<span class="mailbox-attachment-icon has-img">
		<img src="{{imgsrc}}" alt="Attachment">
  	</span>
	<div class="mailbox-attachment-info">
		<a href="{{getLink}}" class="mailbox-attachment-name">
			{{fileName}}
    	</a>
		<a href="{{fullName}}" class="btn btn-default btn-xs pull-right delbtn">
			<i class="fa fa-fw fa-remove"></i>
		</a>
	</div>
</li>                
</script> 

<script type="text/javascript">
	$(document).ready(function() {
		var formObj = $("form[role='form']");
		var bno=${boardVO.bno};
		var template = Handlebars.compile($("#templateAttach").html());
		
		$("#save").on("click", function() {
  			formObj.attr("action", "/sboard/modifyPage");
 			formObj.attr("method", "post");
			formObj.submit();
		});
	
		$("#cancel").on("click", function() {
			self.location = "/sboard/list?page=${cri.page}&perPageNum=${cri.perPageNum}"
					      + "&searchType=${cri.searchType}&keyword=${cri.keyword}";
		});
		
		$.getJSON("/sboard/getAttach/" + bno, function(list) {
			$(list).each(function() {
				var fileInfo =  getFileInfo(this);
				
				var html = template(fileInfo);
				
				$(".uploadedList").append(html);
			});
		});
		
		$(".fileDrop").on("dragenter dragover", function(e) {
			e.preventDefault();
		});
		
		$(".fileDrop").on("drop", function(e) {
			e.preventDefault();
			
			var files = e.originalEvent.dataTransfer.files;
			var file = files[0];
			
			console.log("file : " + file);
			
			var formData = new FormData();
			formData.append("file", file);
			formData.append("bno", bno);
			
			$.ajax({
				url: '/uploadAjax_bno',
				type: 'POST',
				data: formData,
				dataType: 'text',
				processData: false,
				contentType: false,
				success: function(data) {
					var fileInfo =  getFileInfo(data);
					
					var html = template(fileInfo);
					
					$(".uploadedList").append(html);
				}
			});
		});
		
		$(".uploadedList").on("click", ".delbtn", function(e) {
			e.preventDefault();
			
			var objThis = $(this);
			
			$.ajax({
				url: "/deleteFile_bno",
				type: "post",
				data: {
					fileName: $(this).attr("href"), 
					bno: bno
				},
				dataType: "text",
				success: function(result) {
					if (result == "deleted") {
						objThis.parents("li").remove();
					}
				}
			});
		});
		
		$(".uploadedList").on("click", ".mailbox-attachment-name", function(e) {
			var fileLink = $(this).attr("href");
			
			if (checkImageType(fileLink)) {
				e.preventDefault();
				
				var imgTag = $("#popup_img");
				imgTag.attr("src", fileLink);
				
				console.log(imgTag.attr("src"));
				
				$(".popup").show("slow");
					imgTag.addClass("show");
			}
		});
		
		$(".popup").on("click", function() {
			$(".popup").hide("slow");
		});
		
	});
</script>
</head>

<body class="hold-transition skin-blue sidebar-mini">
<%@ include file="../include/navigation.jsp"%>

<!-- Image Display -->
<div class="popup back" style="display: none;"></div>

<div id="popup_front" class="popup front" style="display: none;">
	<img id="popup_img">
</div>

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
	<input type="hidden" name="searchType" value="${cri.searchType}" />	
	<input type="hidden" name="keyword" value="${cri.keyword}" />
			
	<div class="box-body">
		<div class="form-group">
			<label for="title">Title</label> 
			<input type="text" id='title' name='title' class="form-control" placeholder="Enter Title" value="${boardVO.title}">
		</div>
		<div class="form-group">
			<label for="content">Content</label>
			<textarea class="form-control" id='content' name="content" rows="3" placeholder="Enter ...">${boardVO.content}</textarea>
		</div>
		<div class="form-group">
			<label for="writer">Writer</label> 
			<input type="text" id='writer' name="writer" class="form-control" placeholder="Enter Writer" readonly="readonly" value="${boardVO.writer}">
		</div>
		<div class="form-group">
			<label for="fileDrop">File DROP Here</label> 
			<div class="fileDrop" id='fileDrop'></div>
		</div>
	</div>
	<!-- /.box-body -->
	
	<ul class="mailbox-attachments clearfix uploadedList" ></ul>

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
