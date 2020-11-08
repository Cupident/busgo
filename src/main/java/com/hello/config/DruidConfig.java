package com.hello.config;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.support.http.StatViewServlet;
import com.alibaba.druid.support.http.WebStatFilter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.servlet.Filter;
import javax.sql.DataSource;
import java.util.HashMap;
import java.util.Map;

@Configuration
public class DruidConfig {

    /**
     * 解释:@bean 把druid数据连接池放入spring容器
     *
     * @return
     * @ConfigurationProperties(prefix = "spring.datasource"):注入spring参数，进行绑定
     * 作用：使用自定义的druid
     */
    @Bean
    @ConfigurationProperties(prefix = "spring.datasource")
    public DataSource druidDataSource() {
        DruidDataSource druidDataSource = new DruidDataSource();
        return druidDataSource;
    }

    @Bean
    public ServletRegistrationBean statViewServlet() {
        //ServletRegistrationBean提供类的进行注册
        ServletRegistrationBean<StatViewServlet> statViewServlet = new ServletRegistrationBean<>(new StatViewServlet(), "/druid/*");
        Map<String, String> initParameters = new HashMap<>();
        initParameters.put("loginUsername", "root");//用户名
        initParameters.put("loginPassword", "root");//密码
//        initParameters.put("allow", "localhost");//表示谁可以访问
        initParameters.put("allow", "");//为空表示所有的人都可以访问
        initParameters.put("deny", "指定ip");//表示禁止指定ip访问
        statViewServlet.setInitParameters(initParameters);
        return statViewServlet;
    }


    @Bean
    public FilterRegistrationBean druidStatFilter() {
        FilterRegistrationBean<Filter> druidStatFilter = new FilterRegistrationBean<>(new WebStatFilter());
        //添加过滤规则
        druidStatFilter.addUrlPatterns("/*");
        Map<String, String> initParameters=new HashMap<>();
        //exclusions：设置哪些请求进行过滤排除掉，从而不进行统计
        initParameters.put("exclusions","*.js,*.gif,*.jpg,*.png, *.css,*.ico,/druid/*");
        //添加需要忽略的格式信息
        druidStatFilter.setInitParameters(initParameters);
        return druidStatFilter;
    }
}
