package faehigkeiten;

class Schaeden extends Faehigkeit {
    public var heilungmenge:Int;

    public function new(spieler:Int,dyn:RuestungDynamisch,zustand:KampfZustand,heilungmenge:Int){
        super(spieler,dyn,zustand);
        this.heilungmenge =heilungmenge;
    }    

    public override function selbstplatzierung(p:Placement){
        zustand.heilen(spieler,heilungmenge);
    }
}