package org.zerock.aop.test;

import org.springframework.stereotype.Component;

@Component
public class Calc {

	public int add(int x, int y) {
		return x + y;
	}
	
	public int substract(int x, int y) {
		return x - y;
	}
	
}
