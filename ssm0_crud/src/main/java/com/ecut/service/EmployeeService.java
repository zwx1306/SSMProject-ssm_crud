package com.ecut.service;

import com.ecut.dao.EmployeeMapper;
import com.ecut.domain.Employee;
import com.ecut.domain.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;
    public List<Employee> getAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }
    public void saveEmp(Employee employee){
        employeeMapper.insertSelective(employee);

    }
    //检查用户名是否可用
    public boolean checkUser(String empName){
        EmployeeExample employeeExample=new EmployeeExample();
        EmployeeExample.Criteria criteria=employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count=employeeMapper.countByExample(employeeExample);
     //   System.out.println(count);
        return count==0;




    }

    public Employee getEmp(Integer id){
       Employee employee=employeeMapper.selectByPrimaryKey(id);
       return employee;
    }

    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }
    public void deleteEmp(Integer id){
        employeeMapper.deleteByPrimaryKey(id);
    }


    public void deleteBatch(List<Integer> ids){
        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria=example.createCriteria();
        //delete from xxx where emp_id in(1,2,3)按照条件删除
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
