// (C) 2023 Brian Alano, Green Ellipsis
// Released under the Creative Common 2.0 International Attribution license (CC BY 2.0)
// https://creativecommons.org/licenses/by/2.0/deed.en

// V1.0.1
// * fix spool_r
// * deepen groove for lanyard and filament
// * make symmetric

include <../libs/BOSL2/std.scad>
spool_r = 50.57/2;
arc_len = 35;
big_hole_d = 3.0;
mid_hole_d = 2.5;
t = big_hole_d*5;
w = 15;
small_hole_d = 2.0;
epsilon= 0.01;
/* [Rendering] */
preview_fa = 12;
preview_fs = 5;
render_fa = 5;
render_fs = 0.4;
/* [Hidden] */
angle = arc_len/(2*3.1415*spool_r) * 360;
$fa = $preview ? preview_fa : render_fa;
$fs = $preview ? preview_fs : render_fs;

module _reflect(v) {
  mirror(v) children();
  children();
}

// basic body
//difference() {
//	pie_slice(r=spool_r+w, h=t, ang=angle, anchor=CENTER, spin=-angle/2) show_anchors();
//} 
// holes
//   torus(r_maj|d_maj, r_min|d_min, [center], ...) [ATTACHMENTS];
//   torus(or|od, ir|id, ...) [ATTACHMENTS];
difference() {
  intersection() {
    resize([0,0,t]) torus(r_maj=spool_r, r_min=w);
    color("red") pie_slice(r=spool_r+w, h=t, ang=angle, anchor=CENTER, spin=-angle/2);
  }
  // slot
  slot_r = spool_r+big_hole_d;
  translate([0,0,-big_hole_d/2]) cylinder(r=slot_r, h=big_hole_d);
  down(epsilon) cyl(r=spool_r, h=t+epsilon*4) ;
  _reflect([0,1,0]) 
  {
    // big hole
    translate([spool_r, -big_hole_d, 0]) rotate(20) color("blue") cyl(d=big_hole_d, h=t*3, anchor=TOP, orient=LEFT+FWD);
    // mid hole
    translate([spool_r, big_hole_d*2, 0]) rotate(20) color("blue") cyl(d=mid_hole_d, h=t*3, anchor=CENTER, orient=LEFT+FWD);
    // little hole
    translate([spool_r, big_hole_d*2+mid_hole_d*3, 0]) rotate(20)color("blue") cyl(d=small_hole_d, h=t*3, anchor=CENTER, orient=LEFT+FWD);
  }
  // cut off overhang
  cube_w = 10;
  #translate([spool_r, big_hole_d*2+mid_hole_d*8+cube_w/2, 0]) rotate(-24) color("blue") cube([cube_w,spool_r*2,w*2], center=true);
  // side holes
  for(rot=[angle/5,0,-angle/5]) {
    #rotate(rot)
      translate([spool_r+w*0.75, 0, 0]) cyl(d=big_hole_d, h=t*2, anchor=CENTER);
    echo(angle=angle);
  }
}