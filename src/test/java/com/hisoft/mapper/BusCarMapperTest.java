package com.hisoft.mapper;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.hisoft.pojo.BusCar;

public class BusCarMapperTest {

	ApplicationContext applicationContext = new ClassPathXmlApplicationContext("spring/applicationContext-mybatis.xml");
	@Autowired
	private BusCarMapper busCarMapper ;
	@Test
	public void testQueryByMore() {
		List<BusCar> list = this.busCarMapper.queryByMore();
		for(BusCar c:list){
		System.out.println(c);
		}
	}

}
