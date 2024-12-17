/* PVC Fort connectors
based on 

remodeled in OpenSCAD
by Green Ellipsis, LLC. 
(C) 2024 CC BY-NC 4.0
*/
//Pick a part number or change the mode
part=30; // [0:39]
//split connectors that won't print flat
split=true; 
mode="part"; // [part:single part, all:all the connectors, model:show the assembly]
/* [Hidden] */
//connector
base_d = 19/32*25.4+1; // inside diameter of pipe, basically
hex_s = base_d*sqrt(3)/2; // hex flat to flat distance
octo_d = base_d*sqrt(4+2*sqrt(2));
octo_s = base_d*(1+2/sqrt(2));
standoff_s = 3.1*2;
start_s = octo_s/2+standoff_s;
end_s = base_d*1.3;
// common connectors
STRAIGHT=3;
CORNER=14;
BASE9=34;
BASE11=36;
//screw stuff
countersink_d1=6.5;
countersink_d2=3.0;
countersink_h=3.5;
through_hole_d=25.4*9/64;
pilot_hole_d=25.4*7/64;
screw_s=start_s - countersink_d1*0.6;
//pipe stuff
pipe_alpha=0.3;
c = start_s;
c2 = start_s*2;
p2 = 24*25.4; // 2 ft
p1 = (p2 - c2)/2; // ~1 ft
u1 = c+p1+c; // 1 ft pipe section
u2=c+p2+c; // base unit length
p1d = u1*sqrt(2) - u1 - c2;
p2d = (u2)*sqrt(2) - u2 - c2;

parts = [ // 1st 6 are where to put the end, last is how many axes for the middle part
// two-connector variations 
  [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0], // 45 
  [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], // 90
  [1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0], // 135
  [1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0], // 180 - 3
// three-connector variations
//// variations on 45
  [1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0], // 45,45xy
  [1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0], // 
  [1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0], // 
  [1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0], // 
  [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0], // 45,45xy,45xz
  [1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0], // 45,45xy,90z
  [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1], // 45,45xy,135xz - 10
  
//// variations on 90
  [1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0], // 90,90xy
  [1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0], // 90,135xy
  [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0], // 90,45xz
  [1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0], // 90,90zy
  [1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1], // 90,135xz - 15

// four-connector variations
//// variations on 90,90xy
  [1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0], // 90,90xy,90xy
  [1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0], // 90,90xy,90xz
  [1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0], // 45,45xy,90xy
  [1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0], // 90,90xy,45xy
  [1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0], // 90,90xy,45xz
  [1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1], // 90,90xy,135x - 21
//// variations on angled 90
  [0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0], // 90,90xy,45xy - 22
// five-connector variations
//// variations on 90,90xy,90xy
  [1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0], // 90,90xy,90xy,90xz
  [1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0], // 45,45xy,90xy,90xy
  [1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0], // 90,90xy,90xy,45xz - 25
//// variations on 90,90xy,90xz
  [1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0], // 45,45xy,90xy,90xz
  [1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0], // 90,45xy,45xy,90xz
  [1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0], // 90,90xy,45xy,90xz
  [1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0], // 90,90xy,135xy,90xz - 29
// six-connector variations
//// variations on 90,90xy,90xy,90xz
  [1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0], // 90,90xy,90xy,90xz,180xz
  [1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0], // 90,90xy,90xy,45xy,90xz
  [1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0], // 90,90xy,90xy,90xz,45xz -32
// eight connector variations
  [1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0], // all xy
// nine connector variations
  [1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0], // all xy
// ten connector variations
  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0], // 
// elevent-connector variations
  [1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1], // 
// twelve connector variations
  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], // 


  [1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0], // Fan
  [1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0], // Test
  ];
z_v = [0,0,0];
y_v = [-90,0,0];
x_v = [90,0,90];
slit=base_d*0.05;
knob_d=hex_s*0.9;
$fs = $preview ? 4 : 0.4;
$fa = $preview ? 10 : 2;

// part lengths
echo(str("connector thickness = ", hex_s, " mm"));
echo(str("2 ft=",p2, " mm or ", floor(p2/25.4+.01), "-", round(((p2+0.01)%25.4)*16), "/16 in"));
echo(str("1 ft=",p1, " mm or ", floor(p1/25.4), "-", round(p1%25.4/25.4*32), "/32 in"));
echo(str("2 ft diag=",p2d, " mm or ", floor(p2d/25.4), "-", round(p2d%25.4/25.4*32), "/32 in"));
echo(str("1 ft diag=",p1d, " mm or ", floor(p1d/25.4), "-", round(p1d%25.4/25.4*32), "/32 in"));
echo(p1/25.4);

// determine if part is splittable
function splittable(part) = split && part[5];

// determine if part should have a through hole
function piercable(part) = !part[4] && !part[5];

module part(part) {
  data = parts[part];
    
  module add() {
    // center fill
   rotate(90) base(0, hex_s);
//    intersection() {
//      cube(octo_s, center=true);
//      rotate(45) cube(octo_s, center=true);
//    }
    // knob
    translate([0,0,hex_s/2]) difference() {
      cylinder(h=start_s/6, d=knob_d);
      translate([0,0,start_s/5+knob_d*0.3]) sphere(d=knob_d);
   }
    end(data, pipe=false);
  }
  
  module subtract() {
    // hole through middle
    if (piercable(data)) cylinder(h=(start_s+end_s)*3, d=hex_s*0.4, center=true);
    if (splittable(data)) { // add screw holes
      for (angle=[360/8:360/8:360]) {
        rotate(angle) translate([screw_s,0,0]) {
          cylinder(h=hex_s+0.02, d=pilot_hole_d, center=true); // pilot hole
          cylinder(h=hex_s/2+0.01, d=through_hole_d); // through hole
          translate([0,0,hex_s/2-countersink_h]) cylinder(h=countersink_h+0.01, d1=countersink_d2, d2=countersink_d1); // through hole
        }
      }
    }
  }
  
//  if (data[0] || data[2]) { // we need the x middle
  module whole() {
    difference() {
      add();
      subtract();
    }
  }
  
  cube_s = (start_s + end_s)*3;
  if (splittable(data)) {
    //top half
    difference() {
      whole();
      translate([0,0,-cube_s/2]) cube(cube_s, center=true);
    }
    // bottom half
    translate([0, (start_s+end_s)*2.1]) rotate([180,0,0]) difference() {
      whole();
      translate([0,0,cube_s/2]) cube(cube_s, center=true);
    }
  } else {
    whole();
  }
  children();
}

module end(part, pipe=false) { 
  if (part[0]) end_add(x_v, pipe);
  if (part[1]) rotate(90) end_add(x_v, pipe);
  if (part[2]) rotate(180)  end_add(x_v, pipe);
  if (part[3]) rotate(270) end_add(x_v, pipe);
  if (part[4]) rotate(90) end_add(z_v, pipe);
  if (part[5]) rotate([180,0,90]) end_add(z_v, pipe);
  if (part[6]) rotate(360/8) end_add(x_v, pipe);
  if (part[7]) rotate(360/8*3) end_add(x_v, pipe);
  if (part[8]) rotate(180+360/8) end_add(x_v, pipe);
  if (part[9]) rotate(180+360/8) end_add(y_v, pipe);
  if (part[10]) rotate([0,-360/8]) end_add(x_v, pipe);
  if (part[11]) rotate([0,-360/8*3]) end_add(-x_v, pipe);
}

module base(dz,h) {
  translate([0,0,dz]) intersection() {
  cube([base_d, hex_s, h], center=true);
    rotate(45) cube([hex_s*1.3, base_d, h], center=true);
    rotate(-45) cube([hex_s*1.3, base_d, h], center=true);
  }
}

module end_add(v, pipe) {
  end1 = end_s * 0.9;
  end2 = end_s * 0.1;
  sphere_r = (base_d-hex_s)/2;
  
  module add() {
    // base
    base(dz=octo_s/4+standoff_s/2, h=start_s);
    // remove stress concentration
    ring_s=end_s*0.3;
    hull() {
      translate([0,0,start_s]) intersection() {
        scale([0.9,1.1,1]) cylinder(d=base_d,h=end_s*0.20);
        cylinder(h=ring_s, d=base_d, $fn=6);
      }
      translate([0, 0, start_s+ring_s]) cylinder(h=end1-ring_s, d=base_d, $fn=6);
    }
////    %cylinder(h=end1, d=base_d, $fn=32);
    translate([0,0,start_s+end1]) cylinder(h=end2, d1=base_d, d2=base_d-end2, $fn=6);
      //detents
    rotate(30) translate([hex_s/2,0, start_s+end1-sphere_r]) sphere(r=sphere_r);
    rotate(150) translate([hex_s/2,0, start_s+end1-sphere_r]) sphere(r=sphere_r);
  }
  
  module subtract() {
    slit_s = end_s*0.9;
    translate([0,0,slit_s/2+(end_s-slit_s)+start_s+00.1]) cube([slit, base_d, slit_s], center=true);
  }
  
  rotate(v) difference() {
    add();
    subtract();
    %if (pipe) translate([0,0,start_s]) pipe(25);
  }
  
}

module pipe(length, center=false) {
  id = 15.06;
  od = 21.28;
  difference() {
    cylinder(h=length, d=od, center=center);
    translate([0,0,-0.01]) cylinder(h=length*2, d=id, center=center);
  }
}

//part(part);
//end(parts[part], pipe=true);
//%translate([0,0,start_s]) pipe(200, center=false);
//part(part);
//translate([base_s*2.5,0,0]) part(1);
//translate([base_s*6,0,0]) part(2);
//translate([base_s*9,0,0]) part(3);
//translate([base_s*12,0,0]) part(4);
//translate([base_s*15,0,0]) part(5);
   

module pipe1() {
  color("yellow", pipe_alpha) pipe(p1);
  children();
}
module pipe2() {
  color("white", pipe_alpha) pipe(p2);
  children();
}

module pipe1d() {
  color("yellow", pipe_alpha) pipe(p1d);
  children();
}
module pipe2d() {
  color("white", pipe_alpha) pipe(p2d);
  children();
}

module up(s) translate([0,0,s]) children();
module back(s) translate([0,s]) children();
module right(s) translate([s,0,0]) children();
module diag(v) translate(v/sqrt(2)) children();

// assembly
module square1() {
  part(BASE11);
  right(c) rotate([0,90,0]) pipe1();
  up(c) pipe1();
  up(u1) rotate([90,0,90]) part(BASE11);
  up(u1) right(c) rotate([0,90,0]) pipe1();
  up(u1) right(u1) rotate([90,0]) part(BASE11);
  up(c) right(u1) pipe1();
  right(u1) part(BASE11);
}
module square2() {
  part(BASE11);
  right(c) rotate([0,90,0]) pipe2();
  up(c) pipe2();
  up(u2) rotate([90,0,90]) part(BASE11);
  up(u2) right(c) rotate([0,90,0]) pipe2();
  up(u2) right(u2) rotate([90,0]) part(BASE11);
  up(c) right(u2) pipe2();
  right(u2) part(BASE11);
}


module diag1() {
  rotate([0,45]) up(c) pipe1();
  diag([u1,0, u1]) {
    rotate([0,-45,0]) part(STRAIGHT);
    diag([c, 0, c]) rotate([0,45]) pipe1d();
  }
}

module diag2() {
  rotate([0,45]) up(c) pipe2();
  diag([u2,0, u2]) {
    rotate([0,-45,0]) part(STRAIGHT);
    diag([c, 0, c]) rotate([0,45]) pipe2d();
  }
}

module grid1() {
  square1();
  diag1();
}

module grid2() {
  square2();
  diag2();
}

// just playing with putting the pieces together
module model() {
  grid2();
  translate([u2,u2]) rotate(180) grid2();
  // two 1=foot pipes
  back(c) {
    rotate([-90,0]) pipe1();
    back(p1+c) {
      rotate(90) part(STRAIGHT);
      back(c) rotate([-90,0]) pipe1();
    }
  }
  back(c) up(u2) rotate([-90,0]) pipe2();
  // u2 diagonal made from 1-foot pipes
  diag([0,c,c]) {
    rotate([45,0]) 
    {
      rotate([-90,0]) pipe1();
      back(p1+c) {
        rotate([0,0,90]) part(STRAIGHT);
        back(c) {
          rotate([-90,0]) pipe1();
          back(p1+c) {
            rotate([0,0,90]) part(STRAIGHT);
            back(c) rotate([-90,0]) pipe2d();
          }
          
        }
      }
    }
  }
    
  right(u2) rotate(90) grid1();
}

if (mode=="all") {
  dy = (c+end_s)*2*1.1 * (split ? 2 : 1);
  for (part=[0:len(parts)-1]) {
    right(((c+end_s)*2*1.1)*(part%7)) back(dy*floor(part/7)) part(part);
  }
} else if (mode=="model") {
  model();
} else {
  part(part);
}
    