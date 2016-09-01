package org.zerock.aop.test;

import org.springframework.context.support.GenericXmlApplicationContext;

public class CalcTest {

	public static void main(String[] args) {
		
		GenericXmlApplicationContext ctx = 
				new GenericXmlApplicationContext("file:src/main/webapp/WEB-INF/spring/root-context.xml");
		
		Calc c = ctx.getBean(Calc.class);
		
		c.add(10, 20);
		c.substract(10, 20);
		
		System.out.println("Program End...");
		
	}
}
