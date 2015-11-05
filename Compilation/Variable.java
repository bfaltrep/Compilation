package Compilation;

import java.util.List;
import java.util.ArrayList;

public class Variable{

	private String name;
	private TreeNode type;
	//private int memoire_allouee;

	public Variable(String _name, TreeNode _type){
		name = _name;
		type = _type;
		//memoire_allouee = _memoire_allouee;
	}
/*
	public void setValeur(String _valeur){
		valeur = _valeur;
	}
*/
	public String getName(){
		return name;
	}

	public TreeNode getType(){
		return type;
	}
/*
	public int getMemoireAllouee(){
		return memoire_allouee;
	}*/
}