package Compilation;

import java.util.List;
import java.util.ArrayList;
import javax.swing.tree.*;

public class Methode{

	private String type;
	private List<TreeNode> parametres;
	private TreeNode type_return;

	public Methode(String _type, List<TreeNode> _parametres, TreeNode _type_return){
		type = _type;
		parametres = _parametres;
		type_return = _type_return;
	}

	public String getType(){
		return type;
	}

	public List<TreeNode> getParametres(){
		return parametres;
	}

	public TreeNode getTypeReturn(){
		return type_return;
	}

}