package faehigkeiten;

class Schaeden extends Faehigkeit {
    public var schaedenmenge:Int;

    public function new(spieler:Int,dyn:RuestungDynamisch,zustand:KampfZustand,schaedenmenge:Int){
        super(spieler,dyn,zustand);
        this.schaedenmenge =schaedenmenge;
    }    

    public override function selbstplatzierung(p:Placement){
        zustand.schaeden(1-spieler,schaedenmenge);
    }
}