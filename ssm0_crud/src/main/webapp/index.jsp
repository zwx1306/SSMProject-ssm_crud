<%--
  Created by IntelliJ IDEA.
  User: 曽文煊
  Date: 2020/3/19
  Time: 15:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Title</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="${APP_PATH}/static/js/jquery-3.1.1.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>SSM CRUD</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
 <!-- 分页信息-->
    <div class="row">
        <div class="col-md-12">
            <table class="table table table-striped table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#</th>
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

    <div class="row">
        <div class="col-md-6" id="page_info_area">

        </div>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>


    <!-- 员工添加 -->
    <div class="modal fade" id="addModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                </div>
                <div class="modal-body">

                    <form class="form-horizontal" method="post">
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="name">
                                <span class="help-block" ></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">Email</label>
                            <div class="col-sm-10">
                                <input type="text" name="email" class="form-control" id="email_add_input" placeholder="xx@xx.com">
                                <span class="help-block" ></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label  class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">

                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender_add_input" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                                </label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">department</label>
                            <div class="col-sm-4">
                                <select class="form-control" name="dId" id="dept_add_select">

                                </select>
                            </div>
                        </div>



                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="emp_save_button">Save</button>
                </div>
            </div>
        </div>
    </div>


  <!-- 员工修改 -->
    <div class="modal fade" id="updateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="ModalLabel">员工添加</h4>
                </div>
                <div class="modal-body">

                    <form class="form-horizontal" method="post">
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <p type="text" name="empName" class="form-control-static" id="empName_update_input" placeholder="name">
                                <span class="help-block" ></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-2 control-label">Email</label>
                            <div class="col-sm-10">
                                <input type="text" name="email" class="form-control" id="email_update_static" placeholder="xx@xx.com">
                                <span class="help-block" ></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label  class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">

                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender_update_input" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                                </label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">department</label>
                            <div class="col-sm-4">
                                <select class="form-control" name="dId" id="dept_update_select">

                                </select>
                            </div>
                        </div>



                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="emp_update_button">Save</button>
                </div>
            </div>
        </div>
    </div>






</div>





<script type="text/javascript">
    var totalRecord, currentPage;

    $(function () {
        to_page(1);
    });

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                console.log(result);
                build_emps_table(result);
                build_page_info(result);
                build_page_nav(result)
            }
        });
    }
    function build_emps_table(result) {

        $("#emps_table tbody").empty();

        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'></input></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            editBtn.attr("edit-id", item.empId);

            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            delBtn.attr("del-id", item.empId);

            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>")
                .append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }
    function build_page_info(result) {

        $("#page_info_area").empty();

        $("#page_info_area").append("当前"
            + result.extend.pageInfo.pageNum
            + "第页,总"
            + result.extend.pageInfo.pages
            + "页,总共"
            + result.extend.pageInfo.total
            + "有条记录")
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }

    function build_page_nav(result) {

        $("#page_nav_area").empty();

        var ul = $("<ul></ul>").addClass("pagination");

        var firstPageLi = $("<li></li>")
            .append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>")
            .append($("<a></a>").append("&laquo;"));
        if (!result.extend.pageInfo.hasPreviousPage) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }


        var nextPageLi = $("<li></li>")
            .append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>")
            .append($("<a></a>").append("尾页").attr("href", "#"));
        if (!result.extend.pageInfo.hasNextPage) {
            lastPageLi.addClass("disabled");
            nextPageLi.addClass("disabled");
        } else {
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
        }

        ul.append(firstPageLi).append(prePageLi);

        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>")
                .append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item)
            });
            ul.append(numLi);
        });

        ul.append(nextPageLi).append(lastPageLi);

        var navEle = $("<nav></nav>").append(ul);

        $("#page_nav_area").append(navEle);
    }

    <!-- 点击新增按钮弹出模块框 -->
    $("#emp_add_modal_btn").click(function () {
        //清楚表单数据 表单重置  不然有上一次的记录 当表单失焦后（没有change） 能重复保存
        //jquery没有这个方法，这个方法是dom对象的，所以要ele[0]取出

        reset_form("#addModel form");
        //发送ajax请求 查出部门信息 ,显示在下拉列表中
        getDepts("#dept_add_select");

        $("#addModel").modal({
            backdrop:"static"
        });
    });

    function reset_form(ele){
        //jquery没有这个方法，这个方法是dom对象的，所以要ele[0]取出
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");   //$(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");   //清空span里面的提示信息
    }


    //查出所有的部门信息并显示在下拉列表中
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",   //controller里的地址
            type: "GET",
            success:function (result) {
                console.log(result)
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });


            }
        })

    }


//保存的事件
    $("#emp_save_button").click(function () {
        //1模态框中填写的数据提交给服务器进行保存
        //先对提交服务器的数据校验

        if(!validae_add_form()){
            return false;
        }


        if($(this).attr("ajax-va")=="error"){
            alert("用户名已注册 保存失败")
            return false;

        }
        //2 发送ajax请求保存员工

        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#addModel form").serialize(),  //拿到表单的数据并且生成json
            success:function (result) {
              //  alert(result.msg);
                if(result.code==100) {
                    $("#addModel").modal('hide');
                    to_page(totalRecord)   //总记录数大于总页码数 就跳到最后一页
                }else
                {
                    console.log(result);
                    //如果成功则是未定义  如果不是未定义则说明 有错误
                    if(undefined!=result.extend.errorFields.email){
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                    }
                    if(undefined!=result.extend.errorFields.empName){
                        //显示用户名错误信息
                        show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                    }
                }

            }
        })

    })

    //校验表单数据
     function validae_add_form(){
         var empName=$("#empName_add_input").val();
         var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;  //允许1.“a-z”  2.“A-Z”  3.“0-9”  4.“_”（下划线） 5.“-” 6. 6到16位字符  7.允许中文
         if(!regName.test(empName)){
             // alert("用户名可以是2-5位中文或者6-16位英文和数字或者下划线的组合!!!");
             show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文和数字或者下划线的组合!!!（前端）");
             return false;
         }else{
             show_validate_msg("#empName_add_input","success","");
         }

         //2.校验邮箱信息
         var email=$("#email_add_input").val();
         var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
         if(!regEmail.test(email)){
             //alert("邮箱格式不正确!!!");
             show_validate_msg("#email_add_input","error","邮箱格式不正确!!!（前端）");
             return false;
         }else{
             show_validate_msg("#email_add_input","success","");
         }

         return true;

     }

    //显示校验信息
    function show_validate_msg(element,status_info,msg){
        //清除当前元素的校验状态
        $(element).parent().removeClass("has-success has-error");
        $(element).next("span").text("");
        if("success"==status_info){
            $(element).parent().addClass("has-success");
            $(element).next("span").text(msg);
        }else if("error"==status_info){
            $(element).parent().addClass("has-error");
            $(element).next("span").text(msg);
        }
    }


    //给输入框添加一个change事件
    $("#empName_add_input").change(function(){
        //发送ajax请求校验用户名是否可用
        var empName=this.value;
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function(result){
                if(result.code==100){
                    show_validate_msg("#empName_add_input","success","用户名可用!");
                    //给保存按钮添加一个属性（任意key-value值）
                    $('#emp_save_button').attr("ajax-va","success");//添加一个校验标记    判断是否真的可以保存  禁用保存按钮
                }else{
                    //返回controller里的vamsg的信息
                    show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                    $('#emp_save_button').attr("ajax-va","error");
                }
            }
        });
    });


//------------------------关于编辑按钮
    //为编辑按钮绑事件     按钮创建之前就去绑定事件  所以不能成功（按钮是通过Ajax去请求得到的）
    //方法1.在创建按钮的时候就绑定事件
    //方法2.绑定单击事件   使用on方法

    $(document).on("click",".edit_btn",function(){  //第二个为类选择器
        //alert("edit");
        //1.查出部门信息，显示部门列表  返回到updateModel select标签下

         getDepts("#updateModel select");  //updateModel 下的select标签
        // //2.查出员工信息，显示员工信息
        getEmp($(this).attr("edit-id"));
        // //3.将员工id传递到模态框的更新按钮里面
         $("#emp_update_button").attr("edit-id",$(this).attr("edit-id"));


        //弹出模态框
        $("#updateModel").modal({
            backdrop:"static"
        });
    });

    //修改时候获取当前员工的信息
    function getEmp(id){
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function(result){
                var emp=result.extend.emp;
                $("#empName_update_input").text(emp.empName);
                $("#email_update_static").val(emp.email);
                $("#updateModel input[name=gender]").val([emp.gender]);
                $("#updateModel select").val([emp.dId]);

            }
        });
    }

    $("#emp_update_button").click(function () {
        //2.校验邮箱信息
        var email=$("#email_update_static").val();
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //alert("邮箱格式不正确!!!");
            show_validate_msg("#email_update_static","error","邮箱格式不正确!!!（前端）");
            return false;
        }else{
            show_validate_msg("#email_update_static","success","");
        }

        //校验完之后发送ajax请求更新员工的数据
        $.ajax({
            url : "${APP_PATH}/emp/" + $(this).attr("edit-id"),
            type : "PUT",
            data : $("#updateModel form").serialize(),
            success : function(result) {
                if (result.code == 100) {
                    $("#updateModel").modal("hide");
                    to_page(currentPage);
                } else {
                    alert("更新失败");
                }
            }
        });

    })

    //------------------------关于删除按钮
    // 编辑和删除的绑定方法都一样  都是用 $(document).on()来绑定
    $(document).on("click",".delete_btn",function(){
        //弹出是否确认删除对话框
        //找到祖先 元素  第二个td
        var delempName=$(this).parents("tr").find("td:eq(2)").text();
        var delempId=$(this).attr("del-id");
        //confirm确认框
        if(confirm("确认删除【"+delempName+"】吗？")){
            //确认之后发送ajax请求
            $.ajax({
                url:"${path}/emp/"+delempId,
                type:"DELETE",
                success:function(result){
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });

    //完成全选和全不选的功能
    $("#check_all").click(function(){
        //attr是获取自定义属性的值$(this).attr("checked");
        //prop是获取原始属性的值
        //alert($(this).prop("checked"));   $(this).prop("checked") 返回值为true和false
        $(".check_item").prop("checked",$(this).prop("checked"));  //check_all的checked赋值给clikck item
    });

    //为每一个选择绑定事件上
    $(document).on("click",".check_item",function(){
        //$("#check_all").prop("checked");
        //alert($(".check_item:checked").length);   //$(".check_item").length
        //被选中的单选框个数是否等于所有单选框的个数
        var flag=$(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag); //当下面的选满的时候 那个大的全选框也选中
    });



    //点击全部删除   即批量删除
    $("#emp_delete_all_btn").click(function(){
        var empNames="";
        var del_ids="";
        $.each($(".check_item:checked"),function(){   //遍历已经选中的元素
            empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";//找到父元素的tr里面的索引为2的td
            //组装员工ids
            del_ids+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });


        empNames=empNames.substring(0,empNames.length-1);// 去掉最后一个逗号
        del_ids=del_ids.substring(0,del_ids.length-1);

        if(del_ids.length>0){
            if(confirm("确认删除【"+empNames+"】吗？")){
                //发送ajax请求
                // alert(1);
                $.ajax({
                    url:"${path}/emp/"+del_ids,
                    type:"DELETE",
                    success:function(result){
                        alert(result.msg);
                        //回到当前页面
                        to_page(currentPage);
                    }
                });
            }
        }else {
            confirm("请选择要删除的员工！");
        }

    });



</script>
</body>
</html>