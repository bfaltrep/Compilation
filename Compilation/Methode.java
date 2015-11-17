package Compilation;

import java.util.List;
import java.util.ArrayList;

public class Methode{

	private String type;
	private List<TreeNode> parametres;
	private TreeNode type_return;

	public Methode(String _type, List<TreeNode> _parametres, TreeNode type_return){
		type = _type;
		parametres = _parametres;
		type_return = _type_return;
	}

	public String getType(){
		return type;
	}

	public String getParametres(){
		return parametres;
	}

	public String getTypeReturn(){
		return type_return;
	}

}