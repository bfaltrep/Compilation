package ASA;

public class ASA_REPEAT extends ASA {
	public ASA_REPEAT (ASA left, ASA right){
		super(EnumEtiquette.REPEAT, left, right, null);
	}
}