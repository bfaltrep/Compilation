package ASA;

public class ASA_FUNCALL extends ASA {
	public ASA_FUNCALL (ASA left, ASA right){
		super(EnumEtiquette.FUNCALL, left, right, null);
	}
}