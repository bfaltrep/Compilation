package ASA;

public class ASA_WHILE extends ASA {
	public ASA_WHILE (ASA left, ASA right){
		super(EnumEtiquette.WHILE, left, right, null);
	}
}