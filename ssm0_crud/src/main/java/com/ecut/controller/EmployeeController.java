package com.ecut.controller;

import com.ecut.domain.Employee;
import com.ecut.domain.Msg;
import com.ecut.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;


//    //处理员工CRUD请求
////不使用  使用Jason 得加responsebody
//    //@RequestMapping("/emps")
//    public String getEmps(@RequestParam(value = "pn",defaultValue="1")Integer pn,Model model){
//        //查询出1000条  得分页查询
//        //引入pageHelper分页插件 在mybatis的配置文件里
//        //在查询之前只需要调用 传入页码 以及每页的大小
//        PageHelper.startPage(pn,5);
//        //startPage后面紧跟的这个查询就是一个分页查询
//        List<Employee> emps= employeeService.getAll();
//        //使用pageInfo包装查询后的结果 只需要将pageInfo交给页面就行.
//        //封装了详细的分页信息 包括我们查询出来的数据
//        PageInfo page=new PageInfo(emps,5);  //连续显示的页数为5
//        model.addAttribute("pageInfo",page);
//        System.out.println(page);
//        return "list";
//    }

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(
            @RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 5);
        List<Employee> emps = employeeService.getAll();
        PageInfo pageInfo = new PageInfo(emps, 5);

        return Msg.success().add("pageInfo", pageInfo);
    }

    @RequestMapping(value = "/emp",method=RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        System.out.println(result.hasErrors());
        if (result.hasErrors()) {
            //校验失败，应该返回失败，在模态框中显示校验失败的错误信息
            List<FieldError> errors = result.getFieldErrors();
            Map<String, Object> map = new HashMap();
            for (FieldError fieldError : errors) {
                System.out.println("错误的字段名:" + fieldError.getField());
                System.out.println("错误的信息:" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);    //校验失败
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    @RequestMapping(value = "/checkuser",method=RequestMethod.POST)
    @ResponseBody
    public Msg checkUser(String empName){
        //1.先判断用户名是否是合法的表达式
        String regx="(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        //String 里面的方法  判断是否符合表达式
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名可以是2-5位中文或者6-16位英文和数字或者下划线的组合!!!");
        }
        System.out.println(empName);

        //用户名是否已经注册校验
      boolean b=employeeService.checkUser(empName);
       // System.out.println(b);
      if (b){
          return Msg.success();
      }
      else {
          return Msg.fail().add("va_msg","用户名重复");
      }

    }


    //按照员工id查询
    @RequestMapping(value="/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee=employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

//根据id修改保存员工
@RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
@ResponseBody
public Msg saveEmp(Employee employee) {
    employeeService.updateEmp(employee);
    System.out.println(employee);
    return Msg.success();

    }

//  删除单个id
//@RequestMapping(value="/emp/{id}",method=RequestMethod.DELETE)
//@ResponseBody
//public Msg deleteEmpById(@PathVariable("id") Integer id){
//        employeeService.deleteEmp(id);
//        return Msg.success();
//
//
//}


    //单个id和批量删除 合成一个方法
    @RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
    @ResponseBody
     public Msg deleteEmpById(@PathVariable("ids") String ids) {
        if (ids.contains("-")) {   //表示是多个id  要进行批量删除
            String[] str_ids=ids.split("-");   //用-进行分割
            List<Integer> del_ids=new ArrayList<>();   //将分割好的string数组 转成Integer 放进List
            for (String string:str_ids
                 ) {
                del_ids.add(Integer.parseInt(string));

            }
            employeeService.deleteBatch(del_ids);//批量删除
            return Msg.success();
        } else {  //单个删除
            Integer id=Integer.parseInt(ids);
            employeeService.deleteEmp(id);
            return Msg.success();

        }
    }


}
