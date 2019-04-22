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

<!-- 添加员工的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>

            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type=text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type=text" name="email" class="form-control" id="email_add_input" placeholder="email@chuchujie.com">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-3">
                            <!--部门提交部门id即可 -->
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>

<%--搭建显示页面！！--%>
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
            <button class="btn btn-primary" id="emp_add_modal_btn">
                <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                新增</button>
            <button class="btn btn-danger">
                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                删除</button>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>empId</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
    <script type="text/javascript">
        //1.页面加载完成后，直接发送一个ajax请求，要到分页数据
        $(function(){
            //去首页
           to_Page(1);
        });

        function to_Page(pageNumber) {
            $.ajax({
                url:"${APP_PATH}/empSearch",
                data:"pageNumber="+pageNumber,
                type:"GET",
                success:function(result){
                    //console.log(result);
                    //1.解析并显示员工数据
                    build_emps_table(result);
                    //2.解析并显示分页信息
                    build_page_info(result);
                    //3.解析并显示分页条数据
                    build_page_nav(result);
                }
            });
        }

        function build_emps_table(result){
            //清空table数据
            $("#emps_table tbody").empty();
            var emps = result.extend.pageInfo.list;
            $.each(emps,function(index,item){
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
                var emailTd = $("<td></td>").append(item.email);
                var deptNameTd = $("<td></td>").append(item.department.deptName);
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                    .append("编辑");
                var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                    .append("删除");
                var btnTd = $("<td></td>").append(editBtn).append("  ").append(delBtn);
                //append方法执行完成后还是返回原来的元素tr
                $("<tr></tr>").append(empIdTd)
                        .append(empNameTd)
                        .append(genderTd)
                        .append(emailTd)
                        .append(deptNameTd)
                    .append(btnTd)
                        .appendTo("#emps_table tbody");
            });
        }
        //解析显示分页信息
        function  build_page_info(result) {
            $("#page_info_area").empty();
            $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总"+
                result.extend.pageInfo.pages+"页,总"+
                result.extend.pageInfo.total+"条记录");
        }
        //解析显示分页条
        function build_page_nav(result){
            $("#page_nav_area").empty();
            var ul = $("<ul></ul>").addClass("pagination");
            //构建元素
            var firstPageLi = $("<li></li>")
                .append($("<a></a>")
                .append("首页")
                .attr("href","#"));
            var prePageLi = $("<li></li>")
                    .append($("<a></a>")
                    .append("&laquo;"));
            if(result.extend.pageInfo.hasPreviousPage == false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else {
                firstPageLi.click(function () {
                    to_Page(1);
                });
                prePageLi.click(function () {
                    to_Page(result.extend.pageInfo.pageNum -1);
                });

            }

            //为元素添加翻页的事件
            var nextPageLi = $("<li></li>")
                    .append($("<a></a>")
                    .append("&raquo;"));
            var lastPageLi = $("<li></li>")
                    .append($("<a></a>")
                    .append("尾页")
                    .attr("href","#"));
            if(result.extend.pageInfo.hasNextPage == false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else{
                nextPageLi.click(function () {
                    to_Page(result.extend.pageInfo.pageNum +1);
                });
                lastPageLi.click(function () {
                    to_Page(result.extend.pageInfo.pages);
                });
            }

            //添加首页和前一页的提示
            ul.append(firstPageLi).append(prePageLi);
            //遍历给ul中添加页码提示
            $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
                var numLi = $("<li></li>").append($("<a></a>").append(item));
                if(result.extend.pageInfo.pageNum == item){
                    numLi.addClass("active");
                }
                numLi.click(function () {
                    to_Page(item);
                });
                ul.append(numLi);
            });
            //添加下一页和尾页的提示
            ul.append(nextPageLi).append(lastPageLi);
            //把ul加入到nav元素
            var navEle = $("<nav><nav>").append(ul);
            navEle.appendTo("#page_nav_area");
        }

        //点击新增按钮弹出模态框
        $("#emp_add_modal_btn").click(function () {
            //发送ajax请求，查出部门信息，显示在下拉列表中
            getDepts();
            //弹出模态框
            $("#empAddModal").modal({
                backdrop:"static"
            });
        });

        //查出所有的部门信息并显示在下拉列表中
        function getDepts() {
            $.ajax({
                url:"${APP_PATH}/deptSearch",
                type:"GET",
                success:function (result) {
                    //console.log(result);
                    //显示部门信息在下拉列表中
                    //$("#empAddModal select").append("")
                    $.each(result.extend.depts,function () {
                        var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                        optionEle.appendTo("#empAddModal select");
                    });
                }
            });
        }
    </script>
</body>
</html>
