package com.chuchujie.crud.test;

import com.chuchujie.crud.dao.DepartmentMapper;
import com.chuchujie.crud.dao.EmployeeMapper;
import com.chuchujie.crud.model.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * 1.导入Spring-test模块
 * 2.@ContextConfiguration指定Spring配置文件的位置
 * 3.直接Autowired要使用的组件即可
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MappersTest {
    /**
     * 测试DepartmentMapper
     */
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;
    @Test
    public void testCRUD(){
        System.out.println(departmentMapper);

    //插入几个部门
//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));

//    //删除ID为5的部门
//        departmentMapper.deleteByPrimaryKey(5);
//
//    //修改ID为6的部门信息
//        Department department = new Department();
//        department.setDeptId(6);
//        department.setDeptName("人事部");
//        departmentMapper.updateByPrimaryKey(department);

    //生成员工数据，测试员工插入
    //插入几个员工信息
       // employeeMapper.insertSelective(new Employee(null,"小明","男","12345@qq.com",6));

    //批量插入多个员工,使用可以执行批量操作的SqlSession
        EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);
            for(int i=0;i<1000;i++){
                String uid = UUID.randomUUID().toString().substring(0,5)+i;
                employeeMapper.insertSelective(new Employee(null,uid,"男",uid+"@chuchujie.com",6));
            }
        System.out.println("批量插入完成！！！");
    }
}
