package Compilation;

import java.util.List;
import java.util.ArrayList;
import javax.swing.tree.*;

public class Variable{

	private String name;
	private TreeNode type;

	public Variable(String _name, TreeNode _type){
		name = _name;
		type = _type;
	}

	public String getName(){
		return name;
	}

	public TreeNode getType(){
		return type;
	}

}