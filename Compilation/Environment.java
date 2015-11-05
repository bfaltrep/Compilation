package Compilation;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class Environment{
	/* Nous avons utilisés la liste doublement chainée proposée par nos enseignants. */

    private Environment prev;
    private Environment next;
    private ScopeTree root; /* scope on top of the stack */
    private int id;   // used in toDot
    protected static int uniqId=1;	
    private int scopenum;
    
    public Environment(Environment prev, Environment next) {
    	this.prev=prev;
    	this.next=next;
    	if (prev!=null){
		    this.root=prev.getRoot();
    	}
    	else {
	    	this.root=null;
		}
		this.id=uniqId++;

    }
    
    public Environment(Environment prev){
    	this(prev,null);
    }

    public Environment() {
    	this(null,null);
    }
    
    public int getId() {
		return id;
    }
    
    public Environment getPrev() {
		return prev;
    }
    
    public void putPrev(Environment prev) {
		this.prev = prev;
    }
    
    public Environment getNext() {
		return next;
    }
    
    public void putNext(Environment next) {
		this.next = next;
    }
    
    public ScopeTree getRoot() {
		return root;
    }
    
    public void toDot(String file) {
		try {
		    BufferedWriter out = new BufferedWriter(new FileWriter("./"+file+".dot"));
		    StringBuffer str = new StringBuffer();
		    str.append("digraph Environment {");
		    str.append(" { rank=same; ");
		    for (Environment e=this; e!=null; e=e.next){
				str.append(" e_"+e.getId());
		    }
		    str.append(" }");
		    Environment p=null;
		    for (Environment e=this; e!=null; e=e.next){
				str.append("e_"+e.id+" [shape=\"box\", label=\"s"+e.id+"\"];"+"\n");
				if (e.root !=null){
				    e.root.flagOff();
				    e.root.toDot(str);
				    str.append("e_"+e.id+" -> r_"+e.root.getId()+";\n");
				}
				if (p!=null)
				    str.append("e_"+p.id+" -> e_"+e.id+";");
				p=e;
		    }
		    str.append("}");
		    out.write(str.toString());
		    out.close();
		    
		} catch (IOException e) {
		    System.out.println("ERROR: build dot");
		}		
    }

    public void add(String s, Object t, boolean uniq) {
		if (root==null){
		    if (prev!=null && prev.root!=null){
				root=new ScopeTree(prev.root.getLeft(), prev.root.getRight(), prev.root.getTag(), prev.root.getObject()); 
				root=root.add(s, t, root, uniq);
		    } 
		    else 
		    {
				root=new ScopeTree(s, t);
				root=root.add(s, t, root, uniq);
		    }
		} 
		else 
		{		
		    root=root.add(s, t, root, uniq);
		}
    }

    public void add(String s, Object t) {
		add (s, t, false);
    }

    public Object find(String s){
		if (root!=null){
		    return root.find(s);
		}
		else
		{
		    return null;
		}
    }
}