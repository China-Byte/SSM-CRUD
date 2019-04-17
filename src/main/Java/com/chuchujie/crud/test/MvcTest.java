package com.chuchujie.crud.test;

import com.chuchujie.crud.model.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * Created by 王凌辉 on 2019/3/21.
 * 使用Spring测试模块提供的测试功能：测试CRUD请求的正确性
 * Spring4测试的时候，需要servlet3.0的支持
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {
    //传入SpringMvc的ioc
    @Autowired
    WebApplicationContext webApplicationContext;
    //虚拟Mvc请求，获取到处理请求
    MockMvc mockMvc;
    @Before
    public void initMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
    }
    @Test
    public void testPage() throws Exception {
        //模拟请求拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/empSearch").param("pageNumber","5")).andReturn();
        //请求成功后，请求域中会有pageInfo，我们可以去出pageInfo进行验证
        MockHttpServletRequest mockHttpServletRequest = result.getRequest();
        PageInfo pageInfo = (PageInfo) mockHttpServletRequest.getAttribute("pageInfo");
        System.out.println("当前页码："+pageInfo.getPageNum());
        System.out.println("总页码："+pageInfo.getPages());
        System.out.println("总记录数"+pageInfo.getTotal());
        System.out.println("在页面需要连续显示的页码:");
        int[] nums = pageInfo.getNavigatepageNums();
        for(int i: nums){
            System.out.print(" "+i);
        }

        //获取员工数据
        List<Employee> list = pageInfo.getList();
        for(Employee employee:list){
            System.out.println("ID: "+employee.getEmpId()+"==>Name: "+employee.getEmpName());
        }
    }
}
