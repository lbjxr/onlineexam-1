<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	pageContext.setAttribute("basePath", basePath);
%>
<html>
<head>
<title>试卷</title>
<meta charset="UTF-8">
<base href="<%=basePath%>">
<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/head.css">
<link rel="stylesheet" type="text/css" href="css/list_main.css">
<link rel="stylesheet" type="text/css" href="css/modal.css">
<script type="text/javascript" src="script/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script src="script/teacher/exam_list.js"></script>
<script src="script/time.js"></script>
<script src="script/tips.js"></script>
</head>
<body>
	<!--头部-->
	<jsp:include page="share/head.jsp"></jsp:include>

	<!--中间主体部分-->
	<div class="main">
		<!--年级-->
		<div class="list" id="clazz_list">
			<!--搜索框-->
			<div class="search form-inline">
				
			</div>
			<table class="table table-hover">
				<thead>
					<tr>
						<th width="15%">id</th>
						<th width="25%">标题</th>
						<th width="30%">适用班级</th>
						<th width="15%">状态</th>
						<th width="25%">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageBean.records}" var="exam">
						<tr>
							<td>${exam.id}</td>
							<td>${exam.title}</td>
							<td><a href="javascript:showClazz();">显示</a></td>
							<td>${exam.status ? '关闭' : '运行'}</td>
							<td>
								<button class="btn btn-danger" onclick="deleteExam(this);">删除</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!--分页-->
		<div class="page">
			<!-- 用于javascript提交，搜索内容 -->
			<input type="hidden" id="search_grade" value="${grade}">
			<input type="hidden" id="search_major" value="${major}">
			<script type="text/javascript">
				function page(pageCode) {
					var grade = document.getElementById("search_grade").value;
					var major = document.getElementById("search_major").value;
					window.location.href = "admin/clazz/list?pn=" + pageCode + "&grade=" + grade + "&major=" + major;
				}
			</script>
			<jsp:include page="../share/page.jsp"></jsp:include>
		</div>
	</div>
	
	<!-- 适用班级的显示&编辑 -->
    <div class="modal_window teacher_clazz_window form-control" id="clazz-show">
        <div class="modal_window_title">
            所教班级: <img src="images/error.png" id="show-clazz-btn">
        </div>
        <div style="text-align: center;height: 100px;overflow-y: scroll;overflow-x: hidden;">
            <ul style="list-style: none;padding: 0px;margin: 0px;" id="clazz_list"></ul>
        </div>
        <div style="text-align: center;border-top: 1px solid #E2E2E2;margin-top: 5px;">
            <button id="remove-class-btn">移除所选</button>
        </div>
        <div class="modal_window_title">
            添加班级:
        </div>
        <div>
            年级:<select id="grade_select" onchange="changeMajor(this);"></select>
            专业:<select id="major_select" onchange="changeClazz(this);"><option>专业...</option></select>
            班级:<select id="clazz_select"><option>班级...</option></select>
        </div>
        <div class="error" style="text-align: center;" id="clazz_error">
            &nbsp;
        </div>
        <div style="text-align: center;margin-top: 10px;">
            <button onclick="addClazz();">添加</button>
            <button onclick="save();">保存</button>
        </div>
    </div>
</body>
</html>