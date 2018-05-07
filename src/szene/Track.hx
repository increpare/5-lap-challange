package szene;

class Track {
	private var px:Float;
	private var py:Float;

	
	private var vx:Float;
	private var vy:Float;

	private var olda:Float;

	var trackName:String;
	var altName:String;
	var lap:Int=0;
	var tracks:Array<Dynamic> = [
		["track1",52,130,158,131,196,79],
	];

	var targetPoints = [52,130,196,79,189,198];

	var targetPoint=1;
	
	var a:Float=10;
	var g:Float=0;
	var v:Float=1;
	var m1:Float=1;
	var m2:Float=10;

	var radius:Float=15;
	var imageArray:Array<Array<Int> >;
	var bufferArray:Array<Array<Int> >;

	function DoCircle(x:Float,y:Float,r:Float){
		var minx = Math.floor(x-r);
		var maxx = Math.floor(x+r);
		var miny = Math.floor(y-r);
		var maxy = Math.floor(y+r);

		if (minx<0){
			minx=0;
		}
		if (maxx>=Gfx.screenwidth-1){
			maxx=Gfx.screenwidth-1;
		}

		if (miny<20){
			miny=20;
		}

		if (maxy>=Gfx.screenheight-1){
			maxy=Gfx.screenheight-1;
		}

		//can optimize this!
		for (i in minx...maxx){
			for (j in miny...maxy){
				var dx = i-x;
				var dy = j-y;
				if (dx*dx+dy*dy<=r*r){
					bufferArray[i][j]=0;
				}
			}
		}
	}

	function collides():Bool{
		var pxmin=Math.floor(px-1);
		var pxmax=Math.floor(px+1);
		var pymin=Math.floor(py-1);
		var pymax=Math.floor(py+1);
		if (pxmin<0||pymin<0||pxmax>=Gfx.screenwidth||pymax>=Gfx.screenheight){
			return true;
		}		
		for (x in pxmin...pxmax){
			for (y in pymin...pymax){
				if (imageArray[x][y]==1){
					return true;
				}
			}
		}
		return false;

	
	}


	private var firstTurn=false;
	private var stage:Int=0;

	function init(){
		anythingpressed=false;
		time=0;
		lap=0;
		stage=0;
		olda=0;
		Gfx.imagealpha=1;
		
		Gfx.createimage("front",320,240);
		Gfx.drawtoimage("front");
		Gfx.clearscreen(Col.BLACK);
		Gfx.drawimage(0,0,"track1");
		Gfx.drawtoscreen();

		trackName="front";

		altName="alt";
		px = tracks[state.track][1];
		py = tracks[state.track][2];
		vx = 0;
		vy = 0;

		firstTurn=true;


		Gfx.createimage(altName,Gfx.screenwidth,Gfx.screenheight);
		Gfx.drawtoimage(altName);
		Gfx.clearscreen(Col.WHITE);
		Gfx.drawtoscreen();
	}

	function Recalculate(){
		
		var s:String = altName;
		altName=trackName;
		trackName=s;


		Gfx.drawtoimage(altName);
		Gfx.clearscreen(Col.WHITE);
		Gfx.drawtoscreen();

		var tarray = imageArray;
		imageArray=bufferArray;
		bufferArray=tarray;

		trace(imageArray);
		trace(bufferArray);

		var iw = Gfx.screenwidth;
		var ih = Gfx.screenheight;
		for (i in 0...iw){
			for (j in 0...ih){		
				bufferArray[i][j]=1;
			}
		}	
		
	}
	
	public function DoFirst() {

		anythingpressed=false;
		time=0;
		lap=0;
		stage=0;
		olda=0;
		trackName = "front";
		Gfx.imagealpha=1;

		px = tracks[state.track][1];
		py = tracks[state.track][2];
		vx = 0;
		vy = 0;


		lap=0;
		imageArray = [];
		bufferArray = [];


		var bmd = Gfx.bmds["track1"];
		trace(bmd);
		var iw = Gfx.screenwidth;
		var ih = Gfx.screenheight;
		for (i in 0...iw){
			var col = [];
			var acol = [];
			for (j in 0...ih){				
				var p = bmd.getPixel(i,j);
				if (p==0xffffff){
					col.push(1);
				}else {
					col.push(0);
				}
				acol.push(1);
			}
			imageArray.push(col);
			bufferArray.push(acol);
		}	
		Gfx.drawtoscreen();
			
	}
	var anythingpressed:Bool=false;
	public static var time:Float=0;
	var difficulty:Float=1;
	function update() {	
		if (firstTurn){
			DoFirst();
			firstTurn=false;
		}
		Gfx.reset();
		Gfx.drawtoscreen();

		var delta =1/haxegon.Core.fps;
		if (anythingpressed && radius>5){
			time+=delta;
			radius-=difficulty*delta;
		}

		var ax:Float=0;
		var ay:Float=0;

		if (Input.pressed(Key.UP)){
			anythingpressed=true;
			ay--;
		}
		if (Input.pressed(Key.DOWN)){
			anythingpressed=true;
			ay++;
		}
		if (ay!=0){
			if (Input.pressed(Key.LEFT)){	
				ay /=  Math.sqrt(2);
				ax  = -Math.sqrt(2);
			}
			if (Input.pressed(Key.RIGHT)){
				ay /=  Math.sqrt(2);
				ax  =  Math.sqrt(2);
			}		
		} else {
			if (Input.pressed(Key.LEFT)){
				anythingpressed=true;
				ax--;
			}
			if (Input.pressed(Key.RIGHT)){
				anythingpressed=true;
				ax++;
			}		
		}

		var v0 = Math.sqrt(vx*vx+vy*vy);
		if (v0<10){
				ax*=2;
				ay*=2;
		}

		vx += a*ax*delta;
		vy += a*ay*delta;

		var v = Math.sqrt(vx*vx+vy*vy);
		var maxspeed=10;
		if (v>maxspeed){
			vx=vx*maxspeed/v;
			vy=vy*maxspeed/v;
		}		

		var ox = px;
		var oy = py;
		var tx:Float;
		var ty:Float;
		var collision:Bool=false;
		if (py*py>px*px){
			px += v*vx*delta;
			tx = px;
			if (collides()){
				collision=true;
				px=ox;
				vx=-vx*0.9;
			}
			py += v*vy*delta;
			ty = py;

			if (collides()){
				collision=true;
				py=oy;
				vy=-vy*0.9;
			}
		} else {

			py += v*vy*delta;
			ty = py;

			if (collides()){
				collision=true;
				py=oy;
				vy=-vy*0.9;
			}
			px += v*vx*delta;
			tx = px;
			if (collides()){
				collision=true;
				px=ox;
				vx=-vx*0.9;
			}
		}

		if (collision){
			#if js
			untyped playSound(41638307,1.0);
			#end
		}
		Gfx.clearscreen(0xffffff);
		Gfx.imagealpha=0.8;
		Gfx.drawimage(0,0,trackName);

		Gfx.drawtoimage(altName);
		Gfx.imagealpha=1;
		Gfx.fillcircle(px,py,radius,Col.BLACK);
		DoCircle(px,py,radius);
		Gfx.drawtoscreen();
		Gfx.linethickness=1.0;
		Gfx.drawcircle(px,py,radius,Col.GRAY,0.5);
		Gfx.imagealpha=0.3;
		Gfx.drawimage(0,0,altName);
		Gfx.imagealpha=1.0;


		for (i in 0...3){
			var col=Col.GRAY;
			
			var point_x = targetPoints[2*i+0];
			var point_y = targetPoints[2*i+1];

			if (i==targetPoint){
				col=0xff0000;


				var ddx = point_x-px;
				var ddy = point_y-py;
				var dd2 = ddx*ddx+ddy*ddy;
				if (dd2<10*10){
					targetPoint=(targetPoint+1)%3;
					radius=15;

					
					if (targetPoint==1)
					{
						Recalculate();
						lap++;
						if (lap==5){
							Scene.change(szene.Results);
							firstTurn=true;
							var oldtime=time;
							init();
							time=oldtime;
						}

						#if js
						untyped playSound(57146903,1.0);
						#end
					} else {

						#if js
						untyped playSound(81688903,1.0);
						#end
					}
				}

			}

			Gfx.linethickness=1;
			Gfx.drawcircle(point_x-1,point_y-1,10,col,1);

		}
		

		Gfx.linethickness=2;
		Gfx.drawline(ox,oy,px,py,0xff0000);
		Gfx.linethickness=4;
		Gfx.drawline(px,py,tx,ty,0xff0000);
		Gfx.fillbox(px-1,py-1,2,2,0xff0000,1);

		Gfx.fillbox(0,0,Gfx.screenwidth,20,Col.BLACK);
		
		Text.size=15;
		var s1 = S("   Runde ", "   Lap ");
		var s2 = S("/5     Zeit : ", "/5     Time : ");
		Text.display(0,-2,s1 +(lap+1)+s2 + Math.floor(time),Col.WHITE,1.0);
		//Gfx.fillbox(ox-2,oy-2,2,2,0xff0000,1);
		//Gfx.fillbox(tx-2,ty-2,2,2,0xff0000,1);
	}
}
