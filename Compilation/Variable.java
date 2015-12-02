package Compilation;

import javax.swing.tree.*;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class Variable{

	private String name;
	private DefaultMutableTreeNode type;
	private boolean _static; 

	public Variable(String _name, DefaultMutableTreeNode _type, boolean statiq){
		name = _name;
		type = _type;
		_static = statiq;
	}

	public String getName(){
		return name;
	}

	public DefaultMutableTreeNode getType(){
		return type;
	}

	public boolean isStatic(){
		return _static;
	}

	public void toDot(String fichier){
		try {
			BufferedWriter out = new BufferedWriter(new FileWriter("./"+fichier+".dot"));
			StringBuffer str = new StringBuffer();
			str.append("digraph "+fichier+" {");

			//parcours arbre
			parcours_prefixe(str,type);


			str.append("}");
		    out.write(str.toString());
		    out.close();

		} catch (IOException e) {
		    System.out.println("ERROR: build dot");
		}
	}

	private void parcours_prefixe(StringBuffer sb, DefaultMutableTreeNode node){
		if(node != null){
			if(node.getChildCount() == 0){
				sb.append(node.getUserObject()+";");
			}else{
				for(int i = 0 ; i < node.getChildCount() ; i++){
					sb.append(node.getUserObject()+" -> "+((DefaultMutableTreeNode) node.getChildAt(i)).getUserObject()+";");
					parcours_prefixe(sb, (DefaultMutableTreeNode) node.getChildAt(i));
				}
			}
		}
	}

}