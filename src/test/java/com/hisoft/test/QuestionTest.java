package com.hisoft.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.hisoft.mapper.QuestionBackMapper;
import com.hisoft.mapper.QuestionMapper;
import com.hisoft.pojo.Question;
public class QuestionTest {

	private QuestionMapper questionMapper;
	private QuestionBackMapper backMapper;
	
	ApplicationContext applicationContext = new ClassPathXmlApplicationContext("spring/applicationContext-mybatis.xml");
	
	//查询所有问题信息
	@Test
	public void queryAllqusetion(){
		questionMapper = applicationContext.getBean(QuestionMapper.class);
		List<Question> lq = questionMapper.queryAllQuestion();
		
		for(Question li :lq){
			System.out.println(li);
		}
	}
    //查询所有问题数量
	@Test 
	public void querycountall(){
		questionMapper = applicationContext.getBean(QuestionMapper.class);
		 Integer queryCountAllQuestion = questionMapper.queryCountAllQuestion();
		System.out.println(queryCountAllQuestion);
			
	}
     //查询问题指定状态数量
	/*@Test 
	public void queryCountAllStatus(){
		questionMapper = applicationContext.getBean(QuestionMapper.class);
//		int queryCountAllQusetionByStatus = questionMapper.queryCountAllQusetionByStatus(1);
//		System.out.println(queryCountAllQusetionByStatus);
	}*/
	//查询所有问题反馈数量
	@Test
	public void queryCountQuestionback(){
		backMapper = applicationContext.getBean(QuestionBackMapper.class);
		int queryCountQuestionBack = backMapper.queryCountQuestionBack();
		System.out.println(queryCountQuestionBack);
	}
}
