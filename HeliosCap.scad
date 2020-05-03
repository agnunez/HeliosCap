use <GT2-Belt.scad>;

h1=20;         // height of cap adaptor ring
d1=110;        // telescope tube outer diameter
w1=2;          // cap wall thickness
w2=2;          // mirror baffle thickness(black);
mod=95;        // flat mirror outer diameter.
mid=25;        // flat mirror inner diameter
a=sin(360*$t); // parameter for animation (-1..1)
dec=23.5*a;    // Ecliptic inclination 23º 27' 8" (47" less every 100y)
mt=1.26;       // mirror thickness
ma=45-dec/2;   // mirror angle
ms=100;        // mirror spacing from telescope 
h2=ms+mod*0.6; // baffle height
bm=3.0;        // beam margin. free space around beam
d2=98.5;       // telescope original cap insercion diameter
bid=5;         // 625zz bearing inner diameter
bod=16;        // 625zz bearing outer diameter
bt=5;          // 625zz bearing thickness
brd=7.8;       // 625zz bearing rotating diameter
bw=8;          // GT2 belt width
nt=140;        // GTD number of teeth

// execution
cap(); 
//mirror();
//mirror_holder();
//mirror_gear();
//mirror_shaft();
//mirror_retainer();
translate([0,0,ms])rotate([-ma,0,0])mirror_assembly(); // flat 1st surface mirror
//translate ([0,0,ms]) beam();  // beam toward telescope lense
//translate ([0,0,ms]) rotate([-ma*2,0,0]) beam(); // beam toward Sun

module cap(){
  difference(){ // cap ring
    translate([0,0,(h1+w1)/2])cylinder(h=h1+w1,d=d1+w1,center=true,$fn=100);
    translate([0,0,h1/2])cylinder(h=h1,d=d1,center=true,$fn=100);
    translate([0,0,h1/2])cylinder(h=h1+20,d=mod+bm,center=true,$fn=100);
  }
  difference(){ // cap baffle
    color("black")
    translate([0,0,h2/2+h1])cylinder(h=h2,d=mod+bm*2+w2*2,center=true,$fn=100);
    translate([0,0,h2/2+h1])cylinder(h=h2,d=mod+bm*2,center=true,$fn=100);  // baffle hollow cylinder considering w2 
    translate ([0,0,ms]) rotate([-(45-23.5/2)*2,0,0]) beam();  // lateral holes Sunlight entry
    translate ([0,0,ms]) rotate([-45*2,0,0]) beam();  
    translate ([0,0,ms]) rotate([-(45+23.5/2)*2,0,0]) beam();  
  }
  difference(){ // original telescope cap adapter hole
     translate([0,0,h2+h1]) cylinder(h=w2,d=mod+bm+w2*2,center=true,$fn=100);
     translate([0,0,h2+h1]) cylinder(h=w2,d=d2,center=true,$fn=100);
  }
}

module mirror_assembly(){
  mirror();
  mirror_holder();
  mirror_gear();
}

module mirror_gear(){   // mirror holder with GT2 belt like gear
  mhd=mod+2;  // mirror holder diameter
  rotate([0,0,90]) difference(){
    union(){
      translate([-mhd/2,-bw/2,0])cube([mhd,bw,bw-3]);
      translate([-mid/2,-bw/2,0])cube([mid,bw,bw+3]);
    }
    rotate([ 0,0,90])translate([-mhd/2,-bw/2,0])cube([mhd,bw,bw+1]);
    disk(mid,mod+1,mt);                        // mirror finger print
    disk(mid+10,mod,mt+0.5);                   // central contact 
    cylinder(h=bw+20,d=3,center=true,$fn=100);
  }
  //gt2_belt_arc(N_teeth, belt_height, dir, arc, bed);
  rotate([-90,0,90])translate([0,0,-bw/2])gt2_belt_arc(nt,bw, 1, 180, 2);
}

module mirror_holder(){
  mhd=mod+bt+2;  // mirror holder diameter
  difference(){
    union(){
      translate([-mhd/2,-bw/2,0])cube([mhd,bw,bw+1]);
      translate([mod/2+0.5,0,0])rotate([0,90,0])mirror_shaft();    
      translate([-mod/2-0.5,0,0])rotate([0,-90,0])mirror_shaft();    
    }
    disk(mid,mod+1,mt);                        // mirror finger print
    disk(mid+10,mod,mt+0.5);                   // central contact 
    cylinder(h=bw+20,d=3,center=true,$fn=100); // screw hole
  }
}

module mirror_shaft(){
  translate([0,0,bm/2])cylinder(h=bm,d=bod,center=true,$fn=100); // beam margin
  difference(){
    translate([0,0,(bm+bt)/2])cylinder(h=bm+bt,d=bid,center=true,$fn=100); // shaft
    translate([0,0,(bm+bt)/2+bm+w2+bt-10])cylinder(h=10,d=2,center=true,$fn=100);
  }
  translate([0,0,(bm+0.5)/2])cylinder(h=(bm+0.5),d=brd,center=true,$fn=100); // fledge
}

module mirror_retainer(){
  difference(){
    translate([0,0,-1])cylinder(h=2,d=mid+2,center=true,$fn=100);
    cylinder(h=bod*2,d=3,center=true,$fn=100);
  }
}

module mirror(){
    disk(mid,mod,mt);
}
module disk(id,od,t){   // t=thickness, id=inner diam., od=outer diam
  translate([0,0,t/2])
  difference(){
    cylinder(h=t,d=od,center=true,$fn=100);
    translate([0,0,-1])cylinder(h=t+2,d=id,center=true,$fn=100);
  }
}

module beam(){
    translate ([0,0,-ms/2]) color("gray",0.2)cylinder(h=ms,d=mod,center=true,$fn=100);
}

