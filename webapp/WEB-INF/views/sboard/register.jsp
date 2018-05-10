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

<script>
$(document).ready(function() {
	var template = Handlebars.compile($("#templateAttach").html());
	
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
		
		$.ajax({
			url: '/uploadAjax',
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
	
	$("#registerForm").submit(function(e) {
		e.preventDefault();
		
		var objThis = $(this);
		var str = "";
		
		$(".uploadedList .delbtn").each(function(index) {
			str += "<input type='hidden' name='files[" + index + "]' value='" 
			    + $(this).attr("href") + "'>";
		});
		
		objThis.append(str);
		
 		objThis.get(0).submit();
	});
	
	$(".uploadedList").on("click", "i", function(e) {
		e.preventDefault();
		
		var objThis = $(this);
		
		$.ajax({
			url: "/deleteFile",
			type: "post",
			data: {fileName: $(this).parent().attr("href")},
			dataType: "text",
			success: function(result) {
				if (result == "deleted") {
// 					objThis.parent().parent().parent().remove();
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
	})
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
				
				
				
<form id="registerForm" role="form" method="post">
	<div class="box-body">
		<div class="form-group">
			<label for="exampleInputEmail1">Title</label> 
			<input type="text" name='title' class="form-control" placeholder="Enter Title">
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1">Content</label>
			<textarea class="form-control" name="content" rows="3" placeholder="Enter ..."></textarea>
		</div>
		<div class="form-group">
			<label for="exampleInputEmail1">Writer</label> 
			<input type="text" name="writer" class="form-control" placeholder="Enter Writer">
		</div>
		
		<div class="form-group">
			<label for="exampleInputEmail1">File DROP Here</label> 
			<div class="fileDrop"></div>
		</div>
	</div>
	<!-- /.box-body -->
	
	<div class="box-footer">
		<div><hr></div>
		
		<ul class="mailbox-attachments clearfix uploadedList"></ul>
		
		<button type="submit" class="btn btn-primary">Submit</button>
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
