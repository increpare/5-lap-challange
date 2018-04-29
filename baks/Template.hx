package faehigkeiten;

class Template implements Faehigkeit {
    public var menge:Int;

    public function new(spieler:Int,dyn:RuestungDynamisch,zustand:KampfZustand,menge:Int){
        super(spieler,dyn,zustand);
        this.menge =menge;
    }    

    private override function spielerschadenzufuegung(s:Int):Int{
        return s;
    }

    private override function gegnerschadenzufuegung(s:Int):Int{
        return s;
    }

    public override function selbstplatzierung(p:Placement){

    }

    public override function vorRuestungPlatzierung(p:Placement):Bool{
        return false;
    }

    public override function nachRuestungPlazierung(p:Placement){

    }

    public override function vorRuestungWegwerfen(p:Placement):Bool{
        return false;
    }

    public override function nachRuestungWegwerfen(){

    }

    private override function spielerzugbeginn(){

    }

    private override function spielerzugend(){

    }

    private override function gegnerzugbeginn(){

    }

    private override function gegnerzugend(){

    }
}