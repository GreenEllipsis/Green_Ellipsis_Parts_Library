d = 16.21*2+6.25;
h = 22.44+2.5*25.4;
hole_d = 25.4/4+0.8;
countersink_d = 20;
s = 25.4*0.75;
counterbore_h = h-15+1.7;
epsilon=0.01;
countersink_slope = 5.5/15;
countersink_h = countersink_slope*countersink_d;
$fa = $preview? 12 : 5;
$fs = $preview ? 2 : 0.4;

module add() {
  linear_extrude(h) {
    hull() {
      translate([-s/2, 0]) circle(d=d);
      translate([s/2, 0]) circle(d=d);
    }
  }
}

module subtract() {
  translate([-s/2, 0]) {
    // Tapcon hole
    cylinder(d=hole_d,h=h*3,center=true);
    // tapcon countersink
    translate([0,0,h-counterbore_h+epsilon]){
      cylinder(d=countersink_d, h=counterbore_h);
      translate([0,0,-countersink_h]) cylinder(d2=countersink_d, d1=0, h=countersink_h);
    }
  }
  // shutter anchor hole
  translate([s/2,0]) cylinder(d=hole_d, h=h*3, center=true);
}

difference() {
  add();
  subtract();
}
  