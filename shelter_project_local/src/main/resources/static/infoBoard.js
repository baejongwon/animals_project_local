function deleteCheck() {
		var result = confirm('진짜로 삭제하겠습니까?');
		if (result == true) {
			var postNo = document.getElementById("postNo").value;
			location.href = 'deleteBoard?postNo=' + postNo;
		}
	}
	
	function showReplyForm(commentNo) {
	    var form = document.getElementById("replyForm-" + commentNo);
	    if (form.style.display === "none") {
	        form.style.display = "block";
	    } else {
	        form.style.display = "none";
	    }
	}
	
	function deleteComment(commentNo,no,type){
		var result = confirm('진짜로 삭제하겠습니까?');
		if (result == true) {
			if(type==='info'){
				location.href = 'deleteComment?no='+ no +'&commentNo=' + commentNo + '&type=' + type;
			} else if(type==='per'){
				location.href = 'deleteComment?no='+ no +'&commentNo=' + commentNo + '&type=' + type;
			}
		}
	}

	function showButton() {
	    var submitButton = document.getElementById('submitButton');
	    var cancelButton = document.getElementById('cancelButton');
	    submitButton.style.display = 'block';
	    cancelButton.style.display = 'block';
	}

	function hideButton() {
		var submitButton = document.getElementById('submitButton');
	    var cancelButton = document.getElementById('cancelButton');
	    submitButton.style.display = 'none';
	    cancelButton.style.display = 'none';
	}
	
	function modifyComment(commentNo, content, type) {
	    var commentText = document.getElementById("commentText-" + commentNo);
	    var modifyButton = document.getElementById("modifyButton-" + commentNo);

	    // 원래의 HTML 구조를 저장
	    var originalHTML = commentText.innerHTML;
	    
	    var originalContent = content
        .replace(/<br\s*\/?>/gi, "\n")
        .replace(/&nbsp;/g, " ");
        
	    // 기존 내용을 가진 textarea 생성
	    var textarea = document.createElement("textarea");
	    textarea.value = originalContent;
	    textarea.className = "form-control";
	    textarea.name = "modifiedContent";
	    textarea.rows = 3;

	    // 수정 완료 버튼 생성
	    var submitButton = document.createElement("button");
	    submitButton.type = "button";
	    submitButton.className = "btn-n";
	    submitButton.textContent = "수정";
	    submitButton.onclick = function() {
	        updateComment(commentNo, textarea.value, type);
	    };
	    // 취소 버튼 생성
	    var cancelButton = document.createElement("button");
	    cancelButton.type = "button";
	    cancelButton.className = "btn-n";
	    cancelButton.textContent = "취소";
	    cancelButton.onclick = function() {
	        commentText.innerHTML = originalHTML; // 원래 내용으로 복구
	        modifyButton.style.display = "inline-block"; // 수정 버튼 다시 보이기
	    };

	    // 원래의 댓글 내용을 textarea와 버튼으로 대체
	    commentText.innerHTML = "";
	    commentText.appendChild(textarea);
	    commentText.appendChild(submitButton);
	    commentText.appendChild(cancelButton);

	    // 수정 버튼 숨기기
	    modifyButton.style.display = "none";
	}

	function updateComment(commentNo, content, type) {
	      var encodedContent = encodeURIComponent(content); 
	      var no;
		    if (type === 'info') {
		        no = document.getElementById("postNo").value;
		    } else if (type === 'per') {
		        no = document.getElementById("animal_no").value;
		    }
	 
		    if (no) {
		        location.href = 'updateComment?no=' + no + '&commentNo=' + commentNo + '&content=' + encodedContent + '&type='+ type; 
		    } else {
		        console.log('에러입니다.');
		    }
	    
	}