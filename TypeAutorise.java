package Compilation;

public class TypeAutorise{

	public class Entity{
		private int id;
		private String nom;

		public TypeAutorise(int id_, String nom_){
			id = id_;
			nom = nom_;
		}

		public int getId(){
			return id;
		}

		public String getNom(){
			return nom;
		}
	}

	private List<Entity> type_autorise; // passer a un set ? plus cohérent il me semble


	public TypeAutorise(){
		type_autorise = new ArrayList<Entity>();
		type_autorise.add(0,"Integer");
		type_autorise.add(1,"Character");
		type_autorise.add(2,"Float");
		type_autorise.add(3,"Boolean");
		type_autorise.add(4,"String");
		type_autorise.add(5,"tableau");
		type_autorise.add(6,"pointeur");
		//error ??
	}

	public void add(String s){
		//on vérifie qu'il n'y est pas déja présent
		ListIterator<Entity> it = new ListIterator<Entity>();
		if()



		type_autorise.add(type_autorise.size(), s);
	}

}