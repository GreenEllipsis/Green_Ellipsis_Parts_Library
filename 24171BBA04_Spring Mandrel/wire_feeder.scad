// wire feeder
handle_d = 15;
handle_h = 75;
slot_w = 6;
gap = 0.5;
screw_d=2.7;
wire_d=3;
layer_height=0.3;
preview_fa = 12;
preview_fs = 5;
render_fa = 10;
render_fs = 1;
$fa = $preview ? preview_fa : render_fa;
$fs = $preview ? preview_fs : render_fs;



module subtract() {
  // slot
  translate([0,0,wire_d*2]) cylinder(h=wire_d*3, d=slot_w+gap*2);
  // wire hole
  translate([0,0,screw_d*5]) rotate([90,0,0]) cylinder(h=handle_d*2, d=wire_d, center=true);
  // screw hole
  translate([0,0,-0.01]) cylinder(h=wire_d*3, d=screw_d);
  // cutaway view
  //cube([handle_d, handle_d, handle_h*2]);
}

difference() {
  // main body
  union() {
    cylinder(h=handle_h, d=handle_d);
    translate([0,0,handle_h]) sphere(d=handle_d);
  }
  subtract();
}
// floating wedge
color("green") translate([0,0,wire_d*2+layer_height]) cylinder(h=wire_d*2, d=slot_w);