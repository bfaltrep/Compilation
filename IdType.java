public enum IdType {
	INTEGER (0, "integer"), 
	CHARACTER (1, "character"),
	FLOAT (2, "float"), 
	BOOLEAN (3, "boolean"), 
	STRING (4, "string");


	private int value;
	private String name;
	IdType(int i, String s){
		name = s;
	value = i;

	}

	public int getValue(){
	return value;
	}

	public String getName(){
		return name;
	}

}