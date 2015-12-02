package ASA;

public class ASA_FOREACH extends ASA {
	public ASA_FOREACH (ASA left, ASA right){
		super(EnumEtiquette.FOREACH, left, right, null);
	}
}