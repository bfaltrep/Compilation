package Compilation;

import java.util.Set;
import java.util.HashSet;
import java.util.Iterator;

public class TypeAutorise{

	public class Entity{
		private int id;
		private String nom;
		private int hash;

		public Entity(int id_, String nom_){
			id = id_;
			nom = nom_;
			hash = nom.hashCode();
		}

		public int getId(){
			return id;
		}

		public String getNom(){
			return nom;
		}
		
		public void print(){
			System.out.println(id+" "+nom);
		}
		
		@Override
		public int hashCode() {
			return hash;
		}
		
		@Override
		public boolean equals(Object obj) {
			if(obj instanceof Entity){
				return nom.equals(((Entity) obj).getNom());
			}
			else {
				return false;
			}
		}
	}

	private Set<Entity> type_autorise; // passer a un set ? plus cohérent il me semble

	public TypeAutorise(){
		type_autorise = new HashSet<Entity>();
		type_autorise.add(new Entity(0,"integer"));
		type_autorise.add(new Entity(1,"character"));
		type_autorise.add(new Entity(2,"float"));
		type_autorise.add(new Entity(3,"boolean"));
		type_autorise.add(new Entity(4,"string"));
		type_autorise.add(new Entity(5,"tableau"));
		type_autorise.add(new Entity(6,"pointeur"));
		type_autorise.add(new Entity(7,"listof"));
		type_autorise.add(new Entity(8,"structure"));
		//error ??
	}

	public void add(String s){
		//on vérifie qu'il n'y est pas déja présent
		type_autorise.add(new Entity(type_autorise.size(), s));
	}

	public void print(){
		Iterator<Entity> it = type_autorise.iterator();
		while(it.hasNext()){
			it.next().print();
		}
	}

	public int getId(String s){
		Iterator<Entity> it = type_autorise.iterator();
		while(it.hasNext()){
			Entity e = it.next();
			if(e.getNom().equals(s)){
				return e.getId();
			}
		}
		return -1;
	}

	public String getString(int id){
		Iterator<Entity> it = type_autorise.iterator();
		while(it.hasNext()){
			Entity e = it.next();
			if(e.getId().equals(id)){
				return e.getNom();
			}
		}
		return null;
	}

	public boolean isAutorised(int id){
		if(id == -1){
			return false;
		}
		else{
			return id < type_autorise.size();
		}
	}

	/*
	Fonction conservée pour présenter et tester la classe. A retirer plus tard.
	*/
	public static void main(String[] args){
		TypeAutorise ta = new TypeAutorise();
		ta.print();
		System.out.println();
		ta.add("tutu");//doit le prendre
		ta.add("integer");//ne dois pas le prendre
		ta.print();
	}

}