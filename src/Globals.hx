typedef SpielState = {
    var sprache : Int;
    var auserwaehlte : Int;
    var ort : Int;
    var tx : Int;
    var ty : Int;
    var track:Int;
};

class Globals
{


  public static var PAL = {
      fg : Col.WHITE,   
      bg : Col.BLACK,
      
      fgDisabled : Col.GRAY,

      bghighlight : 0x999999,

      buttonTextCol : Col.WHITE,
      buttonBorderCol : Col.WHITE,
      buttonCol : Col.BLACK,
      buttonHighlightCol : 0x444444,
      buttonHighlightCol2 : 0xcccccc,
      titelFarbe: Col.WHITE,

      giltFarb: Col.GREEN,
      schlechtFarb: Col.RED,
  };

  public static var CONST = {
      invW : 6,    
      invH : 5,
      schlangelaenge : 4,
  };

  public static var GUI = {
      smalltextsize:20,
      textsize:30,
      buttonTextSize:20,
      buttonPaddingX : 10,
      buttonPaddingY : 1,
      linethickness : 2,
      slimlinethickness : 2,
      thicklinethickness : 2,
      titleTextSize:30,
      subTitleTextSize:20,
      vpadding:10,
      healthbarheight:20,
    subSubTitleTextSize:60,

    portraitsize:80,
      
      screenPaddingTop:30,
      
      font:"Rosarivo-Italic",
  };

  public static var state : SpielState = {
      sprache:0,
      auserwaehlte:0,
      ort:0,
      tx:-1,
      ty:-1,
      track:0
  };

  public static function S(de:String,en:String):String{
      if (state.sprache==0){
          return de;
      } else {
        return en;
      }
  }

    public static function LoadDat(){
   
    }
}