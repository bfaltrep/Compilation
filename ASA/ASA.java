package ASA;

public class ASA {

	protected EnumEtiquette etiquette;	
    protected ASA gauche;
    protected ASA droite;
    protected Object contenu;
    protected int id;   
    protected static int compteurId=0;

    public ASA (EnumEtiquette etiquette, ASA gauche, ASA droite, Object contenu){
    	this.etiquette = etiquette;
    	this.gauche = gauche;
    	this.droite = droite;
    	this.contenu = contenu;
    	this.id = compteurId;

    	compteurId++;
    }

    public EnumEtiquette getEtiquette(){
    	return etiquette;
    }

    public ASA getFilsGauche(){
    	return gauche;
    }

    public ASA getFilsDroit(){
    	return droite;
    }

    public Object getContenu(){
    	return contenu;
    }

    public int getId(){
    	return id;
    }

    public String toString(){
    	String res;
    	res += etiquette.toString();
    	if (gauche!=null || right!=null) {
    		res += " ( ";
    		if (gauche!=null) {
    			res += gauche.toString();
    		}
    		if (droite!=null) {
                res+=" | ";
    			res += droite.toString();
    		}
            res+=" ) ";
    	}
        return res ; 
    }

}