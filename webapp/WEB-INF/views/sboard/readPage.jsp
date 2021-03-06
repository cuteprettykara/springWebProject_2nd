<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="../include/header.jsp"%>

<!-- handlebars -->
<script src="/resources/handlebars/handlebars-v4.0.11.js"></script>
<!-- upload -->
<script src="/resources/js/upload.js"></script>

<style type="text/css">
	.popup {position: absolute;}
/* 	.back { background-color: gray; opacity:0.5; width: 100%; height: 300%; overflow:hidden;  z-index:1101;} */
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

<script id="template" type="text/x-handlebars-template">
{{#each .}}
	<li class="replyLi" data-rno={{rno}}>
		<i class="fa fa-comments bg-blue"></i>
		<div class="timeline-item">
  			<span class="time">
    			<i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
  			</span>
			<h3 class="timeline-header"><strong>{{rno}}</strong> -{{replyer}}</h3>
			<div class="timeline-body">{{replytext}} </div>
			<div class="timeline-footer">
				{{#eqReplyer replyer}}
     				<a class="btn btn-primary btn-xs" data-toggle="modal" data-target="#modifyModal">Modify</a>
				{{/eqReplyer}}
    		</div>
		</div>			
	</li>
{{/each}}
</script>

<script id="templateAttach" type="text/x-handlebars-template">
<li data-src="{{fullName}}">
	<span class="mailbox-attachment-icon has-img">
		<img src="{{imgsrc}}" alt="Attachment">
  	</span>
	<div class="mailbox-attachment-info">
		<a href="{{getLink}}" class="mailbox-attachment-name">
			{{fileName}}
    	</a>
	</div>
</li>                
</script> 
	
<script type="text/javascript">
	function getPage(pageInfo) {
		$.getJSON(pageInfo, function(data) {
			printData(data.list, $("#repliesDiv"), $('#template'));
			printPaging(data.pageMaker, $(".pagination"));
			
			$("#replycntSmall").html("[" + data.pageMaker.totalCount + "]");
			$("#modifyModal").modal('hide');	// error 발생함.???
		
		});
	}
	
	function printData(replyArr, target, templateObject) {
	
		var template = Handlebars.compile(templateObject.html());
	
		var html = template(replyArr);
		$(".replyLi").remove();
		target.after(html);
	}
	
	function printPaging(pageMaker, target) {
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

	$(document).ready(function() {
		var bno=${boardVO.bno};
		var replyPage = 1;
		var template = Handlebars.compile($("#templateAttach").html());
		
		var formObj = $("form[role='form']");
		
		$.getJSON("/sboard/getAttach/" + bno, function(list) {
			$(list).each(function() {
				var fileInfo =  getFileInfo(this);
				
				var html = template(fileInfo);
				
				$(".uploadedList").append(html);
			});
		});
		
		$("#modify").on("click", function() {
			formObj.attr("action", "/sboard/modifyPage");
			formObj.attr("method", "get");
			formObj.submit();
		});
		
		$("#remove").on("click", function() {
			
			var replyCnt = $("#replycntSmall").html();
			
			if (replyCnt > 0) {
				alert("댓글이 달린 게시물을 삭제할 수 없습니다.");
				return;
			}
			
			var arr=[];
			
			$(".uploadedList li").each(function(index) {
				arr.push($(this).attr("data-src"));
			});
			
			if (arr.length > 0) {
				$.post("/deleteAllFiles", {files:arr}, function() {
					
				});
			}
			
			formObj.attr("action", "/sboard/removePage");
			formObj.submit();
		});
		
		$("#listAll").on("click", function() {
			formObj.attr("action", "/sboard/list");
			formObj.attr("method", "get");
			formObj.submit();
		});
		
		$("#repliesDiv").on("click", function() {
			
			if ($(".timeline li").length > 1) {
				return;
			}
			
			getPage("/replies/" + bno + "/1");
		});
		
		$("#replyAddBtn").on("click", function() {
			var replyerObj = $("#newReplyWriter");
			var replytextObj = $("#newReplyText");

			var replyer = replyerObj.val();
			var replytext = replytextObj.val();
			
			$.ajax({
				type : 'post',
				url : '/replies',
				headers : {
					"Content-type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',
				data : JSON.stringify({
					bno : bno,
					replyer : replyer,
					replytext : replytext
				}),
				success : function(result) {
					if (result == 'SUCCESS') {
						alert('등록되었습니다.');
						getPage("/replies/" + bno + "/1");
						replyerObj.val("");
						replytextObj.val("");
					}
				}
			})
		});
		
		$(".timeline").on("click", ".replyLi", function() {
			var reply = $(this);
			
			var rno = reply.attr("data-rno");
			var replytext = reply.find(".timeline-body").text();
			
			$(".modal-title").html(rno);
			$("#replytext").val(replytext);
		});
		
		$("#replyModBtn").on("click", function() {
			var rno = $(".modal-title").html();
			var replytext = $("#replytext").val();
			
			$.ajax({
				type : 'patch',
				url : '/replies/' + rno,
				headers : {
					"Content-type" : "application/json",
					"X-HTTP-Method-Override" : "PATCH"
				},
				dataType : 'text',
				data : JSON.stringify({
					replytext : replytext
				}),
				success : function(result) {
					if (result == 'SUCCESS') {
						alert('수정되었습니다.');
						getPage("/replies/" + bno + "/" + replyPage);
					}
				}
			})
		});
		
		$("#replyDelBtn").on("click", function() {
			var rno = $(".modal-title").html();
			
			$.ajax({
				type : 'delete',
				url : '/replies/' + rno,
				headers : {
					"Content-type" : "application/json",
					"X-HTTP-Method-Override" : "DELETE"
				},
				dataType : 'text',
				success : function(result) {
					if (result == 'SUCCESS') {
						alert('삭제되었습니다.');
						getPage("/replies/" + bno + "/" + replyPage);
					}
				}
			})
		});
		
		Handlebars.registerHelper("prettifyDate", function(timeValue) {
			var dateObj = new Date(timeValue);
			var year = dateObj.getFullYear();
			var month = dateObj.getMonth() + 1;
			var date = dateObj.getDate();
			return year + "/" + month + "/" + date;
		});
		
		Handlebars.registerHelper("eqReplyer", function(replyer, block) {
			var accum = '';
			if (replyer == '${login.uid}') {
				accum += block.fn();
			}
			
			return accum;
		});
		
		$(".pagination").on("click", "li a", function(event) {
			event.preventDefault();
			replyPage = $(this).attr("href");
			getPage("/replies/" + bno + "/" + replyPage);
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
				
				
				
<form role="form" method="post">	
	<input type="hidden" name="bno" value="${boardVO.bno}" />	
	<input type="hidden" name="page" value="${cri.page}" />	
	<input type="hidden" name="perPageNum" value="${cri.perPageNum}" />	
	<input type="hidden" name="searchType" value="${cri.searchType}" />	
	<input type="hidden" name="keyword" value="${cri.keyword}" />	
</form>
			
	<div class="box-body">
		<div class="form-group">
			<label for="title">Title</label> 
			<input type="text" id='title' name='title' class="form-control" placeholder="Enter Title" readonly="readonly" value="${boardVO.title}">
		</div>
		<div class="form-group">
			<label for="content">Content</label>
			<textarea class="form-control" id='content' name="content" rows="3" placeholder="Enter ..." readonly="readonly">${boardVO.content}</textarea>
		</div>
		<div class="form-group">
			<label for="writer">Writer</label> 
			<input type="text" id='writer' name="writer" class="form-control" placeholder="Enter Writer" readonly="readonly" value="${boardVO.writer}">
		</div>
	</div>
	<!-- /.box-body -->
	
	<ul class="mailbox-attachments clearfix uploadedList"></ul>
	
	<div class="box-footer">
		<c:if test="${login.uid == boardVO.writer}">
			<button type="button" class="btn btn-warning" id="modify">Modify</button>
			<button type="button" class="btn btn-danger" id="remove">REMOVE</button>
		</c:if>
			<button type="button" class="btn btn-primary" id="listAll">LIST ALL</button>
	</div>
	<!-- /.box-footer-->

				
				
				
			</div>
			<!-- /.box -->
			
		</div>
		<!-- /.col -->
	</div>
	<!-- /.row -->
	
	<!-- /.row -->
	<div class="row">
		<div class="col-md-12">

			<div class="box box-success">
				<div class="box-header">
					<h3 class="box-title">ADD NEW REPLY</h3>
				</div>
				<c:if test="${not empty login}">
					<div class="box-body">
						<label for="exampleInputEmail1">Writer</label> 
						<input class="form-control" type="text" placeholder="USER ID" id="newReplyWriter" value="${login.uid}" readonly="readonly"> 
						<label for="exampleInputEmail1">Reply Text</label> 
						<input class="form-control" type="text" placeholder="REPLY TEXT" id="newReplyText">
					</div>
					<!-- /.box-body -->
					<div class="box-footer">
						<button type="button" class="btn btn-primary" id="replyAddBtn">ADD REPLY</button>
					</div>
				</c:if>
				
				<c:if test="${empty login}">
					<div class="box-body">
						<div>
							<a href="/user/login">Login Please</a>
						</div>
					</div>
				</c:if>
			</div>

			<!-- The time line -->
			<ul class="timeline">
				<!-- timeline time label -->
				<li class="time-label" id="repliesDiv">
					<span class="bg-green">Replies List <small id="replycntSmall">[${boardVO.replycnt}]</small></span>
				</li>
			</ul>

			<div class='text-center'>
				<ul id="pagination" class="pagination pagination-sm no-margin ">

				</ul>
			</div>
		</div>
		<!-- /.col -->
	</div>

<!-- Modal -->
<div id="modifyModal" class="modal modal-primary fade" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title"></h4>
      </div>
      <div class="modal-body" data-rno>
        <p><input type="text" id="replytext" class="form-control"></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
        <button type="button" class="btn btn-danger" id="replyDelBtn">DELETE</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>    

</section>
<!-- /.content -->

<%@ include file="../include/footer.jsp"%>

</body>
</html>
