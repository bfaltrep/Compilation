package Compilation;

import java.util.List;
import java.util.ArrayList;

public class VariableTable{

	private List<String> name;
	private List<int> type;
	private List<int> memoire_allouee;
	private List<String> valeur_initiale;

	public VariableTable(){
		name = new ArrayList<String>();
		type = new ArrayList<int>();
		memoire_allouee = new ArrayList<int>();
		valeur_initiale = new ArrayList<String>();
	}

	public void add(){

	}

}