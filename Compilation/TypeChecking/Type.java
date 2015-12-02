package Compilation;

public interface Type{

	public void toDot(String fichier);

	public boolean equal(Type t);

	public void unify(Type t);


}