package Compilation;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

// binary search tree implementing a scope

public class ScopeTree {
    
    protected static int nb=0;	

    private ScopeTree left;
    private ScopeTree right;
    private int id;
    private String tag;	/* node label */
    private Object object;  
    private boolean flag;
    
    public ScopeTree(ScopeTree left, ScopeTree right, String s, Object o) {
		this.left=left;
		this.right=right;
		this.id=nb++;
		this.tag=s;
		this.object=o;
		this.flag=false; // used in toDot
    }
    
    public ScopeTree(String s, Object t) {
		this(null, null, s, t);
    }
    
    public ScopeTree getLeft() {
		return left;
    }
    
    public void putLeft(ScopeTree left) {
		this.left = left;
    }
    
    public ScopeTree getRight() {
		return right;
    }
    
    public int getId() {
		return id;
    }
    
    public Object getObject() {
		return object;
    }
    
    public String getTag() {
		return tag;
    }
    
    public void putRight(ScopeTree right) {
		this.right = right;
    }
    
    public Object find(String s) {
		if (s.compareTo(tag) < 0)
		    if (left==null)
			return null;
		    else
			return left.find(s);
		else if (s.compareTo(tag) > 0)
		    if (right==null)
			return null;
		    else
			return right.find(s);
		else if (s.compareTo(tag) == 0)
		    return object;
		else
		    return null;
    }
    
    public ScopeTree add(String s, Object t, ScopeTree a, boolean uniq) {
		if (a==null){ 
		    return new ScopeTree(s, t);
		}
		else if (s.compareTo(a.tag) < 0)
		    return new ScopeTree(add(s, t, a.left, uniq), a.right, a.tag, a.object);
		else if (s.compareTo(a.tag) > 0)
		    return new ScopeTree(a.left, add(s, t, a.right, uniq), a.tag, a.object);

		else{ 
		    return new ScopeTree(a.left, a.right, s, t);
		}
    }

    public String toString() {
		String result = new String();
		result += tag;
		if ((left != null) || (right != null)){
		    result +="(";
		    if (left != null)
			result += left.toString();
		    result+=",";
		    if (right != null)
			result += right.toString();
		    result+=")";
		}
		return result;
    }
    
    public void toDot(StringBuffer str) {
		if (!flag){
		    flag=true;
		    str.append("r_"+id+" [label=\""+tag);
		    if (object!=null){
			str.append(" (");
			str.append(object.toString());
			str.append(")");
		    }
		    str.append("\"];");
		    if (left != null){
			left.toDot(str);
			str.append("r_"+id+" -> r_"+left.id+"[dir=\"none\"];\n");
		    }
		    if (right != null){
			right.toDot(str);
			str.append("r_"+id+" -> r_"+right.id+"[dir=\"none\"];\n");
		    }
		}
    }
    
    public void flagOff() {
		flag=false;
		if (left != null)
		    left.flagOff();
		if (right != null)
		    right.flagOff();
    }
}
