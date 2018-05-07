package szene;

class Results {

	private var newHigh:Bool=false;
	var high:Float;
	function init(){
		newHigh=false;
		var s = Track.time;
		if (Save.exists("time") && Math.floor(Save.loadvalue("time"))>0 ){
			var olds = Save.loadvalue("time");
			if (Math.floor(s)<Math.floor(olds) ){
				Save.savevalue("time",s);
				newHigh=true;
			}
		}else {
			Save.savevalue("time",s);
			newHigh=true;
		}

		high = Save.loadvalue("time");
	}	

	function update() {	

		// Draw a white background
		Gfx.clearscreen(PAL.bg);
		var h = Gfx.screenheight;
		var w = Gfx.screenwidth;
		Text.wordwrap=w;

		Text.size=GUI.titleTextSize;
		Text.display(Text.CENTER,10,S("5 Runden Herausforderung","5 Lap Challange"), PAL.titelFarbe);

		var t = S("ZEIT ","TIME ");
		var hs = S("HIGH ","HIGH ");
		var nhs = S("!!NEUER HIGHSCORE!!","!!NEW HIGH SCORE!!");
		
		Text.size=GUI.titleTextSize/2;
		if (newHigh){
			Text.display(Text.CENTER,10+GUI.titleTextSize+50,t+Math.floor(Track.time),Col.YELLOW);
			Text.display(Text.CENTER,10+GUI.titleTextSize+80,nhs,Col.YELLOW);
		} else {
			Text.display(Text.CENTER,10+GUI.titleTextSize+50,"TIME "+Math.floor(Track.time));
			Text.display(Text.CENTER,10+GUI.titleTextSize+80,hs+Math.floor(high));
		}
		
		if (IMGUI.button( Text.CENTER,Math.round(h/2)+80,S("Titelbildschirm","Title Screen"))){
			Gfx.grabimagefromscreen("sshot",0,0);
			Scene.change(Main);
		}

		if (IMGUI.button( Text.CENTER,Math.round(h/2)+40,S("Wiederholen!","Try again!"))){
			Gfx.grabimagefromscreen("sshot",0,0);
			Scene.change(szene.Track);
		}

		Text.size=1;

		if (Mouse.leftheld()){
			Particle.GenerateParticles(
				{
					min:Mouse.x-10,
					max:Mouse.x+10,
				},
				{
					min:Mouse.y-10,
					max:Mouse.y+10,
				},
				"part",
				1,
				0,
				-10,
				{
					min:1,
					max:1
				},
				{
					min:0,
					max:360
				},
				{
					min:-50, max:50
				},
				{
					min:-100, max:-100
				},
				{
					min:20,
					max:20
				},
				{
					min:1,max:1
				},
				{
					min:0,max:0
				}
			);
		}
		
	}
}
