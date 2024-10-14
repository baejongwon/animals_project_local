
document.addEventListener("DOMContentLoaded", function() {
	const likeImg = document.getElementById("likeImg");
	let isLike = false;
	const animalNo = ${board.animal_no};
    console.log(animalNo);
	
	function likePoint() {
		fetch("like/active", {
			method: "POST",
			headers: {
				"Content-Type": "application/json"
			},
			body: JSON.stringify({
				postNo: animalNO,
			})
		})
		.then(response => response.json())
		.then(data => {
            console.log("좋아요 활성화 성공:", data);
        })
        .catch(error => {
            console.error("좋아요 활성화 실패:", error);
        });
	}

	function unlikePoint() {
		console.log("좋아요 비활성화");
	}

	likeImg.addEventListener("click", function() {
		if (!isLike) {
			likeImg.src = "img/Like_active.png";
			likePoint();
		} else {
			likeImg.src = "img/like.png";
			unlikePoint();
		}
		isLike = !isLike;
	});
});
