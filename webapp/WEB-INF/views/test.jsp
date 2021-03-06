<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Ajax Test page</title>
	<!-- jQuery 3 -->
	<script src="/resources/bower_components/jquery/dist/jquery.min.js"></script>
	
	<script type="text/javascript">
		var bno = 3059;
		var replyPage = 1;
		
		function getAllList() {
			$.getJSON("/replies/all/" + bno, function(data) {
				console.log(data.length);
				var str = "";
				$(data).each(function() {
					str += "<li data-rno='" + this.rno  + "' class='replyLi'>"
						+  this.rno + ":" + this.replytext 
						+ "<button>MOD</button></li>";
				})
				
				$("#replies").html(str);
			})
		}
		
		function getPageList(page) {
			$.getJSON("/replies/" + bno + "/" + page, function(data) {
				console.log(data.list.length);
				
				var str = "";
				$(data.list).each(function() {
					str += "<li data-rno='" + this.rno  + "' class='replyLi'>"
						+  this.rno + ":" + this.replytext 
						+ "<button>MOD</button></li>";
				})
				
				$("#replies").html(str);
				
				printPaging(data.pageMaker);
			})
		}
		
		function printPaging(pageMaker){
			
			var str = "";
			
			if(pageMaker.prev){
				str += "<li><a href='"+(pageMaker.startPage-1)+"'> << </a></li>";
			}
			
			for(var i=pageMaker.startPage, len = pageMaker.endPage; i <= len; i++){				
					var strClass= pageMaker.cri.page == i ? 'class=active' : '';
				  str += "<li " + strClass + "><a href='" + i + "'>" + i + "</a></li>";
			}
			
			if(pageMaker.next){
				str += "<li><a href='"+(pageMaker.endPage + 1)+"'> >> </a></li>";
			}
			$('.pagination').html(str);				
		}
		
		$(document).ready(function() {
			// JSP가 처음 동작하면 1페이지의 댓글을 가져오도록 한다.
			getPageList(1);
			
 			$("#replyAddBtn").on("click", function() {
				var replyer = $("#newReplyWriter").val();
				var replytext = $("#newReplyText").val();
				
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
// 							getAllList();
							getPageList(replyPage);
						}
					}
				})
			});
/* 			
			$("#replyAddBtn").on("click", function() {
				var replyer = $("#newReplyWriter").val();
				var replytext = $("#newReplyText").val();
				
				$.post("/replies",
					{bno : bno, replyer : replyer, replytext : replytext},
					function(result) {
						if (result == 'SUCCESS') {
							alert('등록되었습니다.');
							getAllList();
						}
					}
				);
			}); */
			
			$("#replies").on("click", ".replyLi button",function() {
				var reply = $(this).parent();
				
				var rno = reply.attr("data-rno");
				var replytext = reply.text();
				
				$(".modal-title").html(rno);
				$("#replytext").val(replytext);
				$("#modDiv").show("slow");
			});
			
			$("#closeBtn").on("click", function() {
				$("#modDiv").hide("slow");
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
							$("#modDiv").hide("slow");
// 							getAllList();
							getPageList(replyPage);
						}
					}
				})
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
							$("#modDiv").hide("slow");
// 							getAllList();
							getPageList(replyPage);
						}
					}
				})
			});
			
			$(".pagination").on("click", "li a", function(event) {
				event.preventDefault();
				replyPage = $(this).attr("href");
				getPageList(replyPage);
			});
			
		});
	</script>
	
	<style>
		#modDiv {
			width: 300px;
			height: 100px;
			background-color: gray;
			position: absolute;
			top: 50%;
			left: 50%;
			margin-top: -50px;
			margin-left: -150px;
			padding: 10px;
			z-index: 1000;
		}
		
		.pagination {
		  width: 100%;
		}
		.pagination li{
		  list-style: none;
		  float: left; 
		  padding: 3px; 
		  border: 1px solid blue;
		  margin:3px;  
		}
		.pagination li a{
		  margin: 3px;
		  text-decoration: none;  
		}
	</style>
</head>
<body>
	<h2>Ajax Test page</h2>
	
	<div>
		<div>
			REPLYER <input type="text" name="replyer" id="newReplyWriter" />
		</div>
		<div>
			REPLY TEXT <input type="text" name="replytext" id="newReplyText" />
		</div>
		<button id="replyAddBtn">ADD REPLY</button>
	</div>
	
	<ul id="replies">
	
	</ul>
	
	<ul class='pagination'>
	</ul>
	
	<div id='modDiv' style="display: none;">
		<div class='modal-title'></div>
		<div>
			<input type='text' id='replytext'>
		</div>
		<div>
			<button type="button" id="replyModBtn">Modify</button>
			<button type="button" id="replyDelBtn">DELETE</button>
			<button type="button" id='closeBtn'>Close</button>
		</div>
	</div>
</body>
</html>