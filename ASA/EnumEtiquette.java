package ASA;

public enum EnumEtiquette {
	ADD,
	BOOLEAN,
	BREAK,
	CHAR,
	DIVISION,
	EQUAL,
	FLOAT,
	FOR,
	FOREACH,
	FUNCALL,
	IDENTIFIER,
	IF,
	INT,
	MODULO,
	MULTIPLICATION,
	REPEAT,
	RETURN,
	MOINS,
	SOUSTRACTION,
	THENELSE,
	WHILE;

	private String etiquette;

	public void EnumEtiquette(String etiquette){
		this.etiquette = etiquette;
	}

	public String toString(){
		return etiquette;
	}
}

