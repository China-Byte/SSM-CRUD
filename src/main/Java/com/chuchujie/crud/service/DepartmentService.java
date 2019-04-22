package com.chuchujie.crud.service;

import com.chuchujie.crud.dao.DepartmentMapper;
import com.chuchujie.crud.model.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by 王凌辉 on 2019/4/22.
 */
@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;
    public List<Department> getDepts() {
        List<Department> list = departmentMapper.selectByExample(null);
        return list;
    }
}
