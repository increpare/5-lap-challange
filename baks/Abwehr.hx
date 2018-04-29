package faehigkeiten;

class Abwehr extends Faehigkeit {
    public var heilungmenge:Int;

    public function new(spieler:Int,dyn:RuestungDynamisch,zustand:KampfZustand,heilungmenge:Int){
        super(spieler,dyn,zustand);
        this.heilungmenge =heilungmenge;
    }    

    public override function vorSelbstSchaedenErleiden(s:Int):Int{
        zustand.wegwerf(this.spieler,this.dyn);
        return 0;
    }
}