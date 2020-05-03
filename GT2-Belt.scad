

// N_teeth number of teeth
// belt_height  belt width
// bed extra belt thickness. 0 is no bed (standard)

// if dir>0 teeth outward, dir<0 teeth inward

//gt2_belt(N_teeth, belt_height, dir, bed);
//gt2_belt_arc(N_teeth, belt_height, dir, 180, bed);
  gt2_belt_arc(180, 7, 1, 180, 2);
//tooth(6,1, 0);  // single tooth outward
//tooth(6,-1, 0); // single tooth inward

module gt2_belt(N, bh, dir, bed){
    gt2_belt_arc(N, bh, dir, 360, bed);
}
module gt2_belt_arc(N, bh, dir, arc, bed) {
    linear_extrude(height=bh) {
        belt_radius = N / 3.14159;
        n = N * arc / 360;
        for (a =[0:arc/n:arc]) {
           rotate([0,0,a]) translate([-belt_radius,0]) tooth(bh,dir,bed);
        }
    }
}

module toothOut(bh,bed) {
        translate([-(2-.44/2+bed),0]) rotate(30) color("blue")circle(r=.44, $fn=6);
        translate([-(1.25+bed),-1.5]) color("red") square([1.25+bed,3]);
        translate([-(1.75+bed),-.44]) square([1.75+bed,.88]);
}
module toothIn(bh,bed) {
        translate([(2-.44/2+bed),0]) rotate(30) circle(r=.44, $fn=6);
        translate([0,-1.5]) color("red") square([1.25+bed,3]);
        translate([0,-.44]) square([1.75+bed,.88]);
}

module tooth(bh,dir,bed){
    if(dir>0) toothOut(bh,bed);
    if(dir<0) toothIn(bh,bed);
}