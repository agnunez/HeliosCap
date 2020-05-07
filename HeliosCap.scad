/* HelioCap a celostat adapter as telescope cap for Solar observation */
/* (c) Agustin Nunez 2020  https://github.com/agnunez/HelioCap        */

use <GT2-Belt.scad>;

h1=30;         // height of cap adaptor ring
tod=111.4;     // telescope tube outer diameter. Using 0.2mm sheet twice to better slipage
w1=2;          // cap wall thickness
w2=2;          // mirror baffle thickness(black);
mod=95;        // flat mirror outer diameter.
mid=25;        // flat mirror inner diameter
a=sin(360*$t); // parameter for animation (-1..1)
dec=23.5*a;    // Ecliptic inclination 23º 27' 8" (47" less every 100y)
mt=1.26;       // mirror thickness
ma=45-dec/2;   // mirror angle
ms=80+h1;      // mirror spacing from telescope 
h2=ms+mod*0.6; // baffle height
bm=3.0;        // beam margin. free space around beam
d2=98.5;       // telescope original cap insercion diameter
bid=5;         // 625zz bearing inner diameter
bod=16;        // 625zz bearing outer diameter
bt=5;          // 625zz bearing thickness
brd=7.8;       // 625zz bearing rotating diameter
bw=7;          // GT2 belt width
nt=150;        // GTD number of teeth

//// execution
//cap(); 
cap_frame(); 
//mirror();
//mirror_holder();
//mirror_gear();
//mirror_shaft();
//bearing_caps();
//mirror_retainer();
//fake_bearing();
//translate([0,0,ms])rotate([-ma,0,0])mirror_assembly(); // flat 1st surface mirror
//translate ([0,0,ms]) beam();  // beam toward telescope lense
//translate ([0,0,ms]) rotate([-ma*2,0,0]) beam(); // beam toward Sun
translate([-35.3,0,ms+46])rotate([-90,180,-90])motor();
//pulley20();  



module motor_holder(){
difference(){
  union(){
    translate([-60.9,-5,ms+9.6])rotate([0,62,0])translate([0,0,1])cube([5,10,100]);
    translate([-17.5,0,ms+47])rotate([0,90,0])cylinder(h=3,d=44,center=true,$fn=100);
      
  }
 translate([-20.9,-24,ms+50])cube([5,50,21]);
 translate([-35.3,0,ms+46])rotate([-90,180,-90])motor();
 translate([-17.5,0,ms+47])rotate([0,90,0])translate([0,0,26.5])cylinder(h=50,d=44,center=true,$fn=100);
 translate([0,0,ms])rotate([0,90,0])cylinder(h=mod+bt+bm+10,d=bod+0.5,center=true,$fn=100); 
}
  //translate([-35.3,0,ms+46])rotate([-90,180,-90])motor();
}


module cap_frame(){
  motor_holder();
  gt2_belt_arc(60*3,bw, 1, 360, 2);
  difference(){
    union(){
      difference(){ // cap ring
        union(){
          translate([0,0,(h1+w1)/2])cylinder(h=h1+w1,d=tod+w1*2,center=true,$fn=100);
          translate([tod/2-5,-5,bw+2])cube([10,10,ms-2]);
          translate([-tod/2-5,-5,bw+2])cube([10,10,ms+8-bw]);
        }
        translate([0,0,h1/2])cylinder(h=h1,d=tod,center=true,$fn=100);
        translate([0,0,h1/2])cylinder(h=h1+20,d=mod+bm,center=true,$fn=100);
      }  
      translate([0,0,ms])rotate([-ma,0,0]) 
      union(){
        translate([mod/2+0.5,0,0])rotate([0,90,0]) bearing_caps();
        translate([-mod/2-0.5,0,0])rotate([0,-90,0]) bearing_caps();   
      }
    }
  translate([0,0,ms])rotate([0,90,0])cylinder(h=mod+bt+bm+10,d=bod+0.5,center=true,$fn=100);
  }
}

module cap(){
  difference(){ // cap ring
    translate([0,0,(h1+w1)/2])cylinder(h=h1+w1,d=tod+w1*2,center=true,$fn=100);
    translate([0,0,h1/2])cylinder(h=h1,d=tod,center=true,$fn=100);
    translate([0,0,h1/2])cylinder(h=h1+20,d=mod+bm,center=true,$fn=100);
  }
  difference(){ // cap baffle
    color("black")
    translate([0,0,h2/2+h1])cylinder(h=h2,d=mod+bt*2+w2*2,center=true,$fn=100);
    translate([0,0,h2/2+h1])cylinder(h=h2,d=mod+bt*2,center=true,$fn=100);  // baffle hollow cylinder considering w2 
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

module fake_bearing(){
  translate([0,0,bt/2])color("red")difference(){ //translated to its position in shaft
    cylinder(h=bt,d=bod,center=true,$fn=100);
    translate([0,0,-1])cylinder(h=bt+3,d=bid,center=true,$fn=100);
  }
}

module bearing_caps(){
    ct=bt;
    translate([0,0,bm+0.3])
    difference(){
        translate([0,0,(bt+w2)/2])cylinder(h=bt+w2,d=bod+2*w2,center=true,$fn=100);
        translate([0,0,bt/2]) cylinder(h=bt,d=bod+0.5,center=true,$fn=100); // beam margin
    }
}

module mirror_gear(){   // mirror holder with GT2 belt like gear
  mhd=mod+2;  // mirror holder diameter
  difference(){
    union(){
        rotate([0,0,90]) translate([-mhd/2,-bw/2,0])cube([mhd,bw,bw-3]);
        rotate([0,0,90]) translate([-mid/2,-bw/2,0])cube([mid,bw,bw+3]);
        //gt2_belt_arc(N_teeth, belt_height, dir, arc, bed);
        rotate([-90,0,90])translate([0,0,-bw/2])gt2_belt_arc(nt,bw, -1, 180, 2);
    }
    translate([-mhd/2,-bw/2,0])cube([mhd,bw,bw+1]); // clear holder bar
    disk(mid-0.5,mod+1,mt);                         // room for mirror finger print
    disk(mid+10,mod,mt+0.5);                        // central contact ring
    cylinder(h=bw+20,d=3,center=true,$fn=100);      // central screw
    translate([0,0,-5])cube([mod+10,mod+10,10],center=true); // clean below z=0
  }
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
  //translate([0,0,(bm+0.5)])fake_bearing();  // !!!OPTION to show bearing position
  bearing_caps();                           // !!!OPTION to show bearing caps
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

module motor(){
  // motor dimensions
  $fn=100;
  fw=40.00;  // width
  mfov=10; //motorplate over wide
  mfh=60;  // height
  mfw=fw+mfov;  // width
  mft=5;      // thickness
  motd=28;   // motor diameter
  moth=20.5; // motor height
  motd2=31;  // motor contacts extrusion
  motd3=17.5; // motor contacts extrusion width  
  play=0.5;
  color("blue") translate([-1.1*motd3/2,0,0]) cube([motd2-motd/2+play*2,motd3+play,moth]);
  color("blue") translate([-motd3/2+5,3,0]) cube([7,motd3,moth]);
  color("gray") cylinder(h=moth,d=motd+play);
  union(){
    translate([(motd/2+3.5),0,moth-1]) cylinder(1,d=7);
    translate([-(motd/2+3.5),0,moth-1]) cylinder(1,d=7);
    translate([-(motd/2+3.5),-3.5,moth-1]) cube([motd+7,7,1]);
    color("red")translate([(motd/2+3.5),0,moth-15]) cylinder(15,d=4);
    color("red")translate([-(motd/2+3.5),0,moth-15]) cylinder(15,d=4);
    color("green")translate([0,-motd/2+10.75-9.2/2,moth]) cylinder(2,d=9);
    color("red")translate([0,-motd/2+10.75-9.2/2,moth]) cylinder(10,d=4.91);
  }
  translate([0,-motd/2+10.75-9.2/2,moth+2])pulley20();  
}
module pulley20(){
    $fn=100;
    ph1=17.5; // pulley total shaft height
    ph2=9.56; // pulley height
    ph3=8;    // shaft height
    ph4=7.57;  // teeth height
    pd1=9.75; // shaft diameter
    pd2=17.8; // pulley diameter
    pd3=12.3; // pulley teeth diameter
    dt=1.07;     // disk thickness
    translate([0,0,ph1/2]) cylinder(h=ph1,d=pd1,center=true); //shaft
    translate([0,0,ph3+dt/2]) cylinder(h=dt,d=pd2,center=true); //disk 1
    color("red")
    translate([0,0,ph3+dt+ph4/2]) cylinder(h=ph4,d=pd3,center=true); // teeths
    translate([0,0,ph3+dt+ph4+dt/2]) cylinder(h=dt,d=pd2,center=true); //disk 2
    //translate([0,0,ph3+dt])gt2_belt_arc(20,ph4, 1, 360, 0);
}