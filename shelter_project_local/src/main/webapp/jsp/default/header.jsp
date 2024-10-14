<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link href="main.css" rel="stylesheet">
<link href="common.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<link rel="stylesheet"
	href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css">
<link rel="stylesheet"
	href="https://uicdn.toast.com/editor/latest/toastui-editor-viewer.min.css">
<script
	src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
<script src="dbQuiz.js"></script>
<script src="jssor.slider-22.1.8.mini.js" type="text/javascript"></script>
<!-- Summernote CSS/JS -->
<link href="summernote/summernote-lite.css" rel="stylesheet">
<script src="summernote/summernote-lite.js"></script>
<script src="summernote/summernote-ko-KR.js"></script>

<script>
	jQuery(document).ready(function() {
		//메뉴 부분
		$(".gnb>li").on("mouseover", function() {
			$(this).find(".sub").slideDown(200);

		});

		$(".gnb>li").on("mouseleave", function() {
			$(this).find(".sub").slideUp(200);

		});

		var nav = $('.header_menu');
		var navoffset = $('.header_menu').offset();

		$(window).scroll(function() {
			if ($(this).scrollTop() >= navoffset.top) {
				nav.css('position', 'fixed').css('top', 0);

			} else {
				nav.css('position', 'absolute').css('top', 120);
			}

		});

		var jssor_1_options = {
			$AutoPlay : true,
			$SlideDuration : 800,
			$SlideEasing : $Jease$.$OutQuint,
			$ArrowNavigatorOptions : {
				$Class : $JssorArrowNavigator$
			},
			$BulletNavigatorOptions : {
				$Class : $JssorBulletNavigator$
			}
		};

		var jssor_1_slider = new $JssorSlider$("jssor_1", jssor_1_options);

		/*responsive code begin*/
		/*you can remove responsive code if you don't want the slider scales while window resizing*/
		function ScaleSlider() {
			var refSize = jssor_1_slider.$Elmt.parentNode.clientWidth;
			if (refSize) {
				refSize = Math.min(refSize, 1920);
				jssor_1_slider.$ScaleWidth(refSize);
			} else {
				window.setTimeout(ScaleSlider, 30);
			}
		}
		ScaleSlider();
		$(window).bind("load", ScaleSlider);
		$(window).bind("resize", ScaleSlider);
		$(window).bind("orientationchange", ScaleSlider);
		/*responsive code end*/

	});
</script>
<div class="header">
	<div class="header_login">
		<ul class="pc_login">
			<c:choose>
				<c:when test="${empty sessionScope.id }">
					<li><a href="login">로그인</a></li>
					<li><a href="#">|</a></li>
					<li><a href="regist">회원가입</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="logout">로그아웃</a></li>
					<li><a href="#">|</a></li>
					<li><a href="mypage">마이페이지</a></li>
				</c:otherwise>
			</c:choose>

			<c:if test="${sessionScope.id eq 'admin'}">
				<li><a href="#">|</a></li>
				<li><a href="login">관리자페이지</a></li>
			</c:if>
		</ul>
	</div>
	<div class="logo">
		<h1>
			<a href="index"><img src="img/logo.png" alt="logo"></a>
		</h1>
	</div>

	<div class="header_menu">
		<nav class="nav">
			<ul class="gnb">
				<li><a href="/personalBoards">개인분양</a>
					<ul class="sub">
						<li><a href="#">강아지</a></li>
						<li><a href="#">고양이</a></li>
					</ul></li>
				<li><a href="/adoption">보호센터</a></li>
				<li><a href="/donate">기부하기</a></li>
				<li><a href="/infoBoard">지식공유</a>
				<!-- 
				<li><a href="/notice">고객센터</a>
					<ul class="sub">
						<li><a href="#">1:1문의</a></li>
					</ul></li>
					 -->
			</ul>
		</nav>
	</div>
</div>







