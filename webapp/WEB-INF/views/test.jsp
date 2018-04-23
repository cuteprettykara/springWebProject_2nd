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
		var bno = 1;
		
		function getAllList() {
			$.getJSON("/replies/all/" + bno, function(data) {
				console.log(data.length);
				var str = "";
				$(data).each(function() {
					str += "<li data-rno='" + this.rno  + "' class='replyLi'>"
						+  this.rno + ":" + this.replytext 
						+ "</li>";
				})
				
				$("#replies").html(str);
			})
		}
		
		$(document).ready(function() {
 			$("#replyAddBtn").on("click", function() {
				var replyer = $("#newReplyWriter").val();
				var replytext = $("#newReplyText").val();
				
				$.ajax({
					type : 'post',
					url : 'replies',
					headers : {
						"Content-type" : "application/json",
						"X-HTTP-Method-Overrid" : "POST"
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
							getAllList();
						}
					}
				})
			})
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
			
			getAllList();
		});
	</script>
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
</body>
</html>