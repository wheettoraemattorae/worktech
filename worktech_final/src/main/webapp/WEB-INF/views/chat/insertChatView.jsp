<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="resources/js/jquery-3.6.0.min.js"></script>
<script src="resources/ztree/js/jquery.ztree.core.js"></script>
<script src="resources/ztree/js/jquery.ztree.core.min.js"></script>
<script src="resources/ztree/js/jquery.ztree.excheck.js"></script>
<link rel="stylesheet" href="resources/ztree/css/zTreeStyle/zTreeStyle.css">
<meta charset="UTF-8">
<title>채팅방 만들기</title>
<!-- General CSS Files -->
<link rel="stylesheet" href="resources/dist/assets/modules/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/dist/assets/modules/fontawesome/css/all.min.css">

<!-- Template CSS -->
<link rel="stylesheet" href="resources/dist/assets/css/style.css">
<link rel="stylesheet" href="resources/dist/assets/css/components.css">
<script>
	$(document).ready(function() {

		var zNodes = ${jsonArray};
		var setting = {
				data: {
		            simpleData: {
		            	enable: true,
		                idKey: "id",
		                pIdKey: "pId",
		                rootPId: 0
		            }
		        },
		        view: {
		            dblClickExpend: true,
		            selectedMulti: true
		        },
		        callback : {
		            onClick: function(srcEvent, treeId, node, clickFlag) {
		                var dNo = node.id;
		                var dName = node.name;
		                
		                $.ajax({
		                	url: "deptSelect.ct",
		                	data:{dNo:dNo},
		                	success: function(data) {
								$('#deptMemberList').css("display", "block");

								$tableBody = $('#tb tbody');
								$tableBody.html('');

								if(data.length > 0){
									
									var $tr;
									var $name;
									var $dName;
									var $jobGrade;
									var $btn;
									var $check;
									
									for(var i in data){
										$tr = $('<tr>');
										$name = $('<td align="center" width="100">').text(data[i].name);
										$dName = $('<td align="center" width="100">').text(data[i].dName);
										$jobGrade = $('<td align="center" width="100">').text(data[i].jobGrade);
										$btn = $('<td align="center"><button class="btn btn-outline-primary btn-sm" onclick="goOneChat(this);"><i class="fas fa-comment-dots"></i></button>');
										$check = $('<td align="center"><input type="checkbox" name="selectmNo" value="' + data[i].mNo + '">');
										
										$tr.append($name);
										$tr.append($dName);
										$tr.append($jobGrade);
										$tr.append($btn);
										$tr.append($check);
										
										$tableBody.append($tr);
									}
		                		} else {
		                			var $tr;
		                			var $noMember;
		                			
		                			$tr = $('<tr>');
		                			$noMember = $('<td colspan="5">').text('사원이 존재하지 않습니다.');
		                			
		                			$tr.append($noMember);
		                			$tableBody.append($tr);
		                			
		                		}
							},
							error: function(data) {
								console.log("error");
								console.log(data);
							}
		                });
		                
		                
		                
		         	}
		        }
		    };

		zTreeObj = $.fn.zTree.init($("#deptList"), setting, zNodes);
	});
	
</script>
<style type="text/css">
	table {
	    border-collapse: collapse;
	    background: white;
	    width: 100%;
	}
	
	table th {
	    border-bottom: 1px solid #e3e3e3;
	    text-align: center;
	    font-size: 14px;
	    background: rgba(0, 0, 0, 0.1);
	    padding: 0 !important;
	    height: 40px !important;
	}
	
	table td {
	    border-bottom: 1px solid #e3e3e3;
	    text-align: center;
	    font-size: 13px;
	    padding: 0 !important;
	    height: 40px !important;
	}
	
	
	#deptMemberList {
		display: none;
	}
	
	.main-content {
		padding-top: 0;
	}
	
	.deptListDiv{
		border: 1px solid #a0e4f5;
		margin-bottom: 10px;
	}
	
	#groupDiv{
		display: none;
	}
	
	.deleteBtn{
		border: none;
	}
	
	.creatGroup {
		text-align: center;
		margin-bottom: 10px;
	}
	
	#hiddenInput {
		display: none;
	}
	
	.addDiv {
		text-align: right;
		margin-right: 10px;
	}
</style>

</head>
<body>
	<div class="main-content">
		<section class="section">
			<div class="section-body">
				<h2 class="section-title">부서 선택</h2>
			</div>
		</section>
		<div class="deptListDiv">
			<ul id="deptList" class="ztree"></ul>
		</div>
		
		<div id="deptMemberList">
			<table class="table" id="tb">
			    <thead>
			        <tr>
			            <th>사원명</th>
			            <th>부서명</th>
			            <th>직책</th>
			            <th>1:1 대화</th>
			            <th><input type="checkbox" id="allCheck"></th>
			        </tr>
			    </thead>
		        <tbody>
		        </tbody>
		   	</table>
		   	<div class="addDiv">
		   		<button class="btn btn-warning btn-sm" onclick="addGroup();"><i class="fas fa-users"></i> 인원 추가</button>
		   	</div>
		</div>
		
		<div id="groupDiv">
			<section class="section">
				<div class="section-body">
					<h2 class="section-title">단체 대화 추가 인원</h2>
				</div>
			</section>
			<table class="table" id="groupTb">
			    <thead>
			        <tr>
			            <th>사원명</th>
			            <th>부서명</th>
			            <th>직책</th>
			            <th>추가 취소</th>
			        </tr>
			    </thead>
		        <tbody>
		        </tbody>
		   	</table>
		   	<form action="addGroupChat.ct" method="post">
			   	<div class="creatGroup">
			   		<div id="hiddenInput"></div>
			   		<button class="btn btn-warning" onclick="return createGroupChat(1);">공지사항 채팅 생성</button>
			   		<button class="btn btn-primary" onclick="return createGroupChat(0);">그룹 채팅 생성</button>
			   	</div>
		   	</form>
		</div>
	</div>

	<script>
		var chk_arr = [];
		
		function addGroup() {
			$('#groupDiv').css("display", "block");
    		
			$tableBody = $('#groupTb tbody');

			var $tr;
			var $name;
			var $dName;
			var $jobGrade;
			var $delete;
			
			
			$("input[name=selectmNo]:checked").each(function(){
				var chk = $(this).val();
				
				if(!chk_arr.includes(chk)){
					chk_arr.push(chk);
					
					name = $(this).parent().parent().children().eq(0).text();
					dName = $(this).parent().parent().children().eq(1).text();
					jobGrade = $(this).parent().parent().children().eq(2).text();
					
					$tr = $('<tr>');
					$name = $('<td align="center">').text(name);
					$dName = $('<td align="center">').text(dName);
					$jobGrade = $('<td align="center">').text(jobGrade);
					$delete = $('<td align="center" width="100">'
								+ '<button class="btn btn-outline-danger deleteBtn btn-sm" onclick="deleteGroup(this);"><i class="fas fa-times"></i></button>'
								+ '<input type="hidden" name="deleteMno" value="' + chk + '">');
					
					$tr.append($name);
					$tr.append($dName);
					$tr.append($jobGrade);
					$tr.append($delete);
					
					$tableBody.append($tr);
				}
			});
			
			// 추가 후 체크박스 리셋
			$("input[name=selectmNo]").prop("checked", false);
			$("#allCheck").prop("checked", false);
		}
		
		function deleteGroup(e) {
			$(e).parent().parent().remove(); // 삭제한 tr 제거
			
			var deleteNo = $(e).next().val();
			
			// 삭제한 사람 사번 삭제
			chk_arr = chk_arr.filter((element) => element !== deleteNo);
			
			// tr이 존재하지 않으면 div 숨김
			var isTbEmpty = $('#groupTb tbody tr').length;
			
			if(isTbEmpty == 0){
				$('#groupDiv').css('display', 'none');
			}
		}
		
		function createGroupChat(e) {
			if(chk_arr.length < 2) {
				alert('단체 대화 생성 시에는 2명 이상 초대하여야 합니다.');
				return false;
			} else {
				var addInput = '';
				
				if(e == 0){
					var chatTitle = prompt('채팅방 제목을 입력하세요');
					
					if(chatTitle != null) {
						addInput += '<input type="hidden" name="chatTitle" value="' + chatTitle + '">';
						addInput += '<input type="hidden" name="chatType" value="' + e + '">';
						
						for(var item of chk_arr){
							addInput += '<input type="hidden" name="mNo" value="' + item + '">';
						}
						
						$('#hiddenInput').html(addInput);
					} else {
						return false;
					}
				} else if (e == 1){
					addInput += '<input type="hidden" name="chatType" value="' + e + '">';
					
					for(var item of chk_arr){
						addInput += '<input type="hidden" name="mNo" value="' + item + '">';
					}
					
					$('#hiddenInput').html(addInput);
				}
				
			}
		}
		
		// 전체 선택
		$(document).on('click', '#allCheck', function() {
			if($("#allCheck").is(":checked")) $("input[name=selectmNo]").prop("checked", true);
			else $("input[name=selectmNo]").prop("checked", false);
		});
		
		$(document).on('click', "input[name=selectmNo]", function() {
			var total = $("input[name=selectmNo]").length;
				var checked = $("input[name=selectmNo]:checked").length;
	
				if(total != checked) $("#allCheck").prop("checked", false);
				else $("#allCheck").prop("checked", true); 
		});
		
		// 개인 대화
		function goOneChat(e) {
			var selectOneMNo = $(e).parent().next().children().eq(0).val();
			location.href='addPersonalChat.ct?selectmNo=' + selectOneMNo;
		}
		
		
	</script>
</body>
</html>