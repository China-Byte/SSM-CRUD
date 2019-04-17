package com.chuchujie.crud.service;

import com.chuchujie.crud.dao.EmployeeMapper;
import com.chuchujie.crud.model.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by 王凌辉 on 2019/3/21.
 */
@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工信息
     * @return
     */
    public List<Employee> getAll() {
        return  employeeMapper.selectByExampleWithDept(null);
    }
}
