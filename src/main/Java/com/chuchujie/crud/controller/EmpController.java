package com.chuchujie.crud.controller;

import com.chuchujie.crud.model.Employee;
import com.chuchujie.crud.model.Msg;
import com.chuchujie.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by 王凌辉 on 2019/3/21.
 * 处理员工的CRUD请求
 * 你好
 */
@Controller
public class EmpController {
    @Autowired
    EmployeeService employeeService;
//    @RequestMapping(value = "/empSearch")
//    @ResponseBody
//    public  Msg getEmpsWithJson(@RequestParam(value = "pageNumber",defaultValue = "1")Integer pageNumber){
//        //传入页码，每页有多少条数据
//        PageHelper.startPage(pageNumber,5);
//        //startPage后边紧跟的查询就是分页查询
//        List<Employee> employees = employeeService.getAll();
//        //使用pageInfo包装查询后的结果,只需将pageInfo交给页面即可,封装了详细的页面信息
//        //包括我们查询出来的数据，传入连续显示的页数(5页)
//        PageInfo page = new PageInfo(employees,5);
//        return Msg.success().add("pageInfo",page);
//    }

    /**
     * 查询员工列表数据（分页查询）
     * @return
     */
    @RequestMapping(value = "/empSearch")
    //引入pageHelper分页插件
    public String getEmpList(@RequestParam(value = "pageNumber",defaultValue = "1")
                                 Integer pageNumber, Model model){
        //传入页码，每页有多少条数据
        PageHelper.startPage(pageNumber,5);
        //startPage后边紧跟的查询就是分页查询
        List<Employee> employees = employeeService.getAll();
        //使用pageInfo包装查询后的结果,只需将pageInfo交给页面即可,封装了详细的页面信息
        //包括我们查询出来的数据，传入连续显示的页数(5页)
        PageInfo page = new PageInfo(employees,5);
        model.addAttribute("pageInfo",page);
        return "list";
    }
}
