package com.ecut.service;

import com.ecut.dao.DepartmentMapper;
import com.ecut.domain.Department;
import com.ecut.domain.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {
    @Autowired
    DepartmentMapper departmentMapper;
    public List<Department> getDepts(){
        List<Department> list=departmentMapper.selectByExample(null);
        return list;
    }
}
