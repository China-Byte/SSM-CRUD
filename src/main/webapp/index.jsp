<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <!--引入jquery -->
    <script type="text/javascript" src="${APP_PATH}/static/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <!-- 引入Bootstrap -->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>

<body>
<%--搭建显示页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
    <div class="col-md-12">
        <h1>SSM-CRUD</h1>
    </div>
    </div>
    <%--按钮--%>
    <div class="row">
    <div class="col-md-4 col-md-offset-8">
        <button class="btn btn-primary">新增</button>
        <button class="btn btn-danger">删除</button>
    </div>
    </div>
    <%--显示表格数据--%>
    <div class="col-md-12">
        <table class="table table-hover">
            <tr>
                <th>empId</th>
                <th>empName</th>
                <th>gender</th>
                <th>email</th>
                <th>deptName</th>
                <th>操作</th>
            </tr>
        </table>
    </div>
    <%--显示分页信息--%>
    <div class="row"></div>
    <%--分页文字信息--%>
    <div class="col-md-6">
        当前页,总页,总条记录
    </div>
    <%--分页条信息--%>
    <div class="col-md-6">

    </div>
    <div class="row"></div>
</div>
<script type="text/javascript">
    //1.页面加载完成后，直接去发送ajax请求，要到分页数据
    $(function(){
        $.ajax({
            url:"${APP_PATH}/empSearch",
            data:"pageNumber=1",
            type:"get",
            success:function(result){
                //console.log(result);
                //1.解析并显示员工信息
                //2.解析并显示分页信息
                build_emps_table(result);
        }
    });
    });

    function build_emps_table(result){
        var emps = result.extend.pageInfo.list;
        $each(emps,function(index,item){
            alert(item.empName);
        })
    }
    function bulid_page_nav(result){

    }
</script>
</body>
</html>
