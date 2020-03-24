package com.ecut.test;

import com.ecut.dao.DepartmentMapper;
import com.ecut.dao.EmployeeMapper;
import com.ecut.domain.Department;
import com.ecut.domain.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

//推荐spring项目使用spring单元测试 可以自动注入我们需要的组件
//1.导入spring单元测试模块 jar包
//2.@ContextConfiguration指定spring配置文件的位置
//3.进入spring的开发模式  autowired....
//

@RunWith(SpringJUnit4ClassRunner.class)  //指定哪个的测试单元模块
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;

    //    <!--在 MyBatis 中,你可以使用 SqlSessionFactory 来创建 SqlSession。
//    一旦你获得一个 session 之后,你可以使用它来执行映射语句，提交或回滚连接。最后，当不再需要它的时候， 你可以关闭session。
//    使用 MyBatis-Spring 之后, 你不再需要直接使用 SqlSessionFactory 了，
//    因为你的 bean 可以通过一个线程安全的 SqlSession 来注入,基于 Spring 的事务配置来自动提交、回滚、关闭 session。
//            -->
    //在applicationContext里面注入了 sqlSession 来执行批量操作
   @Autowired
   SqlSession sqlSession;

    @Test
    public void testCRUD() {
//        //1.创建ioc容器
//        //2.从容器中获取mapper
//        ApplicationContext ioc=new ClassPathXmlApplicationContext("applicationContext.xml");
//        DepartmentMapper bean=ioc.getBean(DepartmentMapper.class);
        System.out.println(departmentMapper);
        //1.插入几个部门

   //   departmentMapper.insertSelective(new Department(null,"发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));

        //2.生成员工数据 测试员工
        //employeeMapper.insertSelective(new Employee(null,"陈刀仔","m","123@qq.com",1));

        //3. 批量插入多个员工  批量  使用可以执行批量操作的sqlSession
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for(int i=0;i<50;i++){
           String uid= UUID.randomUUID().toString().substring(0,5)+i;
           mapper.insertSelective(new Employee(null,uid,"m",uid+"@qq.com",1));
       }
       System.out.println("批量完成");
    }
}
