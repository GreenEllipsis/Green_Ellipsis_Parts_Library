/* PVC Fort connectors
based on 

remodeled in OpenSCAD
by Green Ellipsis, LLC. 
(C) 2024 CC BY-NC 4.0
*/
/* [Parts] */
part=0; // [0:I, 1:L, 2:corner, 3:T, 4:TT, 5:X, 6:Base, 7:Jack, 8:test]
/* [Hidden] */
base_s = 5/8*25.4;
base_d = 19/32*25.4+1;
end_s = base_s;
mid_s = base_d*sqrt(3)/2; // hex flat to flat distance
parts = [ // 1st 6 are where to put the end, last is how many axes for the middle part
  [1, 0, 1, 0, 0, 0, 1], // I
  [1, 1, 0, 0, 0, 0, 2], // L
  [1, 1, 0, 0, 1, 0, 2], // corner
  [1, 1, 1, 0, 0, 0, 3], // T
  [1, 1, 1, 0, 1, 0, 3], // TT
  [1, 1, 1, 1, 0, 0, 3], // X
  [1, 1, 1, 1, 1, 0, 3], // Base
  [1, 1, 1, 1, 1, 1, 3], // Jack
  [1, 0, 0, 0, 0, 0, 1], // Test
  ];
z_v = [0,0,0];
y_v = [90,0,0];
x_v = [90,0,90];
slit=base_d*0.1;
knob_d=mid_s*0.9;
$fs = $preview ? 2 : 0.4;
$fa = $preview ? 5 : 2;

module middle(part) {
  axes = parts[part][6];
  module add() {
    middle_add(x_v);
    if (axes > 1) middle_add(y_v);
    if (axes > 2) middle_add(z_v);
  }
  module subtract() {
    // hole through middle
    cylinder(h=mid_s*2, d=mid_s*0.4, center=true);
  }
  
  difference() {
    add();
    subtract();
  }
}

module middle_add(v) {
  chamfer_s = mid_s*(24/32)*(8/5);
  rotate(v) intersection() {
    cube(mid_s, center=true);
    rotate(45) cube(chamfer_s, center=true);
  }
  // knob
  translate([0,0,mid_s/2]) difference() {
    cylinder(h=mid_s/6, d=knob_d);
    translate([0,0,mid_s/5+knob_d*0.3]) sphere(d=knob_d);
  }
}

module end(part) {
  echo(part=part);
  if (part[0]) end_add(x_v);
  if (part[1]) end_add(y_v);
  if (part[2]) rotate(180) end_add(x_v);
  if (part[3]) rotate(180) end_add(y_v);
  if (part[4]) end_add(z_v);
  if (part[5]) rotate([180,0,0]) end_add(z_v);
    
    
}

module end_add(v) {
  echo(v=v);
  end1 = end_s * 0.9;
  end2 = end_s * 0.1;
  sphere_r = (base_d-mid_s)/2;
  echo(sphere_r = sphere_r);
  module add() {
    cylinder(h=end1, d=base_d, $fn=6);
//    %cylinder(h=end1, d=base_d, $fn=32);
    translate([0,0,end1]) cylinder(h=end2, d1=base_d, d2=base_d-end2, $fn=6);
      //detents
  rotate(30) translate([mid_s/2,0, end1-sphere_r]) sphere(r=sphere_r);
  rotate(150) translate([mid_s/2,0, end1-sphere_r]) sphere(r=sphere_r);

  }
  
  module subtract() {
    translate([0,0,end_s/2+0.01]) cube([slit, base_d, end_s], center=true);
  }
  
  rotate(v) translate([0,0,mid_s/2]) difference() {
    add();
    subtract();
  }
  
}

module part(part) {
  middle(part);
  end(parts[part]);
}
  
part(part);
//translate([base_s*2.5,0,0]) part(1);
//translate([base_s*6,0,0]) part(2);
//translate([base_s*9,0,0]) part(3);
//translate([base_s*12,0,0]) part(4);
//translate([base_s*15,0,0]) part(5);
    
    
  


