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

	private List<Entity> type_autorise;

	public TypeAutorise(){
		type_autorise = new ArrayList<Entity>();
		type_autorise.add(0,"Integer");
		type_autorise.add(1,"Character");
		type_autorise.add(2,"Float");
		type_autorise.add(3,"Boolean");
		type_autorise.add(4,"String");
	}
}