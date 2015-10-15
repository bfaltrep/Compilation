package Compilation;

import java.util.Stack;
import Compilation.Environment;

public class StackEnvironment {

	private Stack<Environment> stack;

	public StackEnvironment(){
		stack = new Stack<Environment>();
	}

	public void addEnvironment(Environment e){
		stack.push(e);
	}

	public Environment deleteEnvironment(){
		return stack.pop();
	}

	public Environment getCurrentEnvironment(){
		return stack.peek();
	}

}