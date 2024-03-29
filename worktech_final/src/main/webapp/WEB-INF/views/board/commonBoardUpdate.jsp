<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>일반 게시판 수정</title>
    
	<!-- CSS Libraries -->
	<link rel="stylesheet" href="resources/dist/assets/modules/summernote/summernote-bs4.css">
	<link rel="stylesheet" href="resources/dist/assets/modules/codemirror/lib/codemirror.css">
	<link rel="stylesheet" href="resources/dist/assets/modules/codemirror/theme/duotone-dark.css">
	<link rel="stylesheet" href="resources/dist/assets/modules/jquery-selectric/selectric.css">
	
    <style>
        .inputData {
            border: 1px #dff5fa solid;
            padding: 10px;
            border-radius: 5px;
            text-align: left;
        }

        .half-col {
            display: inline-block;
            width: 49%;
        }

        .left-item {
            margin-right: 19px;
        }
		
		:disabled,
        input[type="text"]:disabled,
        input[type="date"]:disabled,
        input[type="number"]:disabled {
            background: #fdfdff;
        }
        
        
        .filebox .upload-name {
            display: inline-block;
            height: 40px;
            padding: 0 45px;
            vertical-align: middle;
            border: 1px solid #dff5fa;
            width: 86%;
            color: #999999;
            border-radius: 3px;
            background-color: #ffffff00;
        }

        .filebox label {
            display: inline-block;
            padding: 10px 20px;
            color: #fff;
            vertical-align: middle;
            background-color: #67d4ef;
            cursor: pointer;
            height: 40px;
            margin-left: 10px;
            margin-top: 10px;
        }

        .filebox input[type="file"] {
            position: absolute;
            width: 0;
            height: 0;
            padding: 0;
            overflow: hidden;
            border: 0;
        }
        
        #originalF {
        	display: none;
        }
        
        .deleteBtn{
        	color: red;
        }
        
        .deleteBtn:hover{
        	cursor: pointer;
        }
        
        .select {
        	border: 1px solid white;
        }
        
        .select:focus{
        	border: 1px solid black;
        }
    </style>
</head>

<body>
    <c:if test="${ loginUser.mGrade eq 'USER' }">
		<c:import url="../common/headerUser.jsp" />
	</c:if>
	<c:if test="${ loginUser.mGrade eq 'ADMIN' }">
	    <c:import url="../common/headerAdmin.jsp" />
	</c:if>
    <!-- Main Content -->
    <div class="main-content">
        <section class="section">
            <div class="section-header">
                <h1>일반 게시판</h1>
                <div class="section-header-breadcrumb">
                    <div class="breadcrumb-item">게시판</div>
                    <div class="breadcrumb-item active"><a href="commonList.bo">일반 게시판</a></div>
                </div>
            </div>

            <div class="section-body">
                <h2 class="section-title">일반 게시판 수정</h2>
                <c:url var="cupdate" value="cupdate.bo">
                	<c:param name="upd" value="Y"/>
                </c:url>
                <form action="${ cupdate }" method="post" enctype="Multipart/form-data">
                	<input type="hidden" name="page" value="${ page }">
					<input type="hidden" name="bNo" value="${ b.bNo }">
                	
	                <div class="row">
	                    <div class="col-12 col-md-12 col-lg-12">
	                        <div class="card">
	                            <div class="card-body">
	                            	<div class="form-group">
		                            	<label>카테고리&nbsp;&nbsp;</label>
		                            	<select class="select" name="categoryNo">
		                            		<option value=100 <c:if test="${ b.categoryNo == 100 }">selected</c:if>>회의</option>
		                            		<option value=200 <c:if test="${ b.categoryNo == 200 }">selected</c:if>>출장</option>
		                            		<option value=300 <c:if test="${ b.categoryNo == 300 }">selected</c:if>>홍보</option>
		                            		<option value=400 <c:if test="${ b.categoryNo == 400 }">selected</c:if>>기타</option>
		                            		<option value=500 <c:if test="${ b.categoryNo == 500 }">selected</c:if>>자료</option>
		                            	</select>
                            		</div>
	                                <div class="form-group">
	                                    <label>글 제목</label>
	                                    <input type="text" class="form-control" name="bTitle" value="${ b.bTitle }">
	                                    <input type="hidden" name="flag" id="flag" value="0">
	                                </div>
	                                <div class="form-group half-col left-item">
	                                    <label>작성자</label>
	                                    <input type="text" class="form-control" disabled value="${ b.name }">
	                                    <input type="hidden" name="bWriter" value="${ b.bWriter }">
	                                </div>
	                                <div class="form-group half-col">
	                                    <label>작성일</label>
	                                    <input type="text" class="form-control" name="bDate" value="${ b.bDate }" disabled>
	                                </div>
	                                <div class="form-group">
	                                	<label>파일 첨부</label>
	                                	<div class="input-group-icon mt-10 filebox">
	                                		<c:if test="${ !empty b.fileList.get(0).getfName() }">
		                                    	<c:forEach var="f" items="${ b.fileList }">
		                                    		<div>
				                                    	<i class="fas fa-save"></i>
				                                    	<a href="/resources/buploadFiles/${ f.getfRname() }" download="${ f.getfName() }">
															${ f.getfName() }
														</a>
														&nbsp;<i class="fas fa-times deleteBtn" name="fileDelete"></i>
														<input type="hidden" name="fNo" value="${ f.getfNo() }">
													</div>
												</c:forEach>
											</c:if>
												<input type="text" class="upload-name form-control" id="uploadName" value="" disabled>
		                                        <label for="file">파일 찾기</label>
		                                        <input type="file" name="reloadFile" id="file" class="ex_file" multiple="multiple">
                                    	</div>
                                    </div>
	                                <div class="form-group">
	                                    <label>작성 내용</label>
	                                    <div>
	                                    	<textarea name="bContent" class="summernote" id="summernote">${ b.bContent }</textarea>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="card-footer text-right">
	                                <button class="btn btn-primary mr-1" type="submit">수정</button>
	                                <c:url var="clist" value="commonList.bo"/>
	                                <button class="btn btn-danger" type="button" onclick="location.href='${ clist }'">취소</button>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </form>
            </div>
        </section>
    </div>
    <c:import url="../common/footer.jsp" />
    
    <script>
        $("#file").on('change', readInputFile);
		
        // 파일 업로드
        function readInputFile(e) {
            var fileInput = document.getElementsByClassName("ex_file");
            var name = document.getElementById("uploadName").value;
            var area = document.getElementById("uploadName");

            var sel_files = [];

            sel_files = [];

            var files = e.target.files;
            var fileArr = Array.prototype.slice.call(files);

            fileArr.forEach(function (f) {
                if (files.length < 4) {
                    sel_files.push(f);
                    var reader = new FileReader();
                    reader.readAsDataURL(f);
                    area.value = "";

                    for (var i = 0; i < fileInput.length; i++) {
                        if (fileInput[i].files.length > 0) {
                            for (var j = 0; j < fileInput[i].files.length; j++) {
                                if (j == 0) {
                                    area.value += fileInput[i].files[j].name;
                                } else {
                                    area.value += ", " + fileInput[i].files[j].name;
                                }
                            }
                        }
                    }
                }
            })
            if (files.length > 4) {
                alert("파일은 최대 3개까지 업로드 가능합니다.");
            }
        }
        
        $(document).on("click", "i[name='fileDelete']", function() {
//         	var fNo = $(this).parent().find('input').val();
        	var fullDiv = $(this).parent();
        	
        	$('#flag').val('1');
        	
        	fullDiv.html('');
        	
        	// ajax를 이용한 파일 삭제
//         	$.ajax({
// 				url: 'deleteNoticeFile.ad',
// 				data: {fNo:fNo},
// 				success: function(data) {
// 					console.log(data);
					
// 					if(data == 'success'){
// 						fullDiv.html('');
// 					}
// 				}, 
// 				error: function(data) {
// 					console.log(data);
// 				}
// 			});
		})
        
    </script>
    
	<!-- JS Libraies -->
	<script src="resources/dist/assets/modules/summernote/summernote-bs4.js"></script>
	<script src="resources/dist/assets/modules/codemirror/lib/codemirror.js"></script>
	<script src="resources/dist/assets/modules/codemirror/mode/javascript/javascript.js"></script>
	<script src="resources/dist/assets/modules/jquery-selectric/jquery.selectric.min.js"></script>
	
</body>

</html>