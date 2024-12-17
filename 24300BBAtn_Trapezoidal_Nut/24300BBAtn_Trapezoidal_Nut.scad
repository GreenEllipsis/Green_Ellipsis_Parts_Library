// Creates Trapezoidal Nuts
// Copyright 2024 Green Ellipsis, LLC
// CC BY-NC 4.0 license
include <../libs/BOSL2/std.scad>
//include <../libs/BOSL2/attachments_extras.scad>
//include <../libs/BOSL2/extrusion_angle.scad>
include <../libs/BOSL2/threading.scad>


module shape(nutwidth, tsize, od, id, h, shape, flange_height, mounting_holes, mounting_hole_d, mounting_r) {
  
  module add() {
    difference() {
      cylinder(d=od, h=flange_height);  
      cylinder(d=id,h=flange_height, anchor=BOTTOM);
    }
  }
  
  module add2() {
      trapezoidal_threaded_nut(
      nutwidth=nutwidth,
      id=tsize,
      h=h,
      pitch=1,
//    thread_angle=14.287
//      thread_depth=0.3,
      shape=shape,
//    flank_angle,
    left_handed=false,
      starts=4,
//    bevel,bevel1,bevel2,bevang=30,
//    ibevel1,ibevel2,ibevel,
//    thickness,height,
//    id1,id2,
//    length, l,
//    blunt_start, blunt_start1, blunt_start2,
//    lead_in, lead_in1, lead_in2,
//    lead_in_ang, lead_in_ang1, lead_in_ang2,
//    end_len, end_len1, end_len2,
//    lead_in_shape="default",
      anchor=BOTTOM
//      , spin, orient
    );
  }
  
  module subtract() {
    countersink_d1=mounting_hole_d * 2.1;
    countersink_d2=mounting_hole_d;
    countersink_h=mounting_hole_d*0.5625;
    
    if (mounting_holes > 0) {
      for (angle=[360/mounting_holes:360/mounting_holes:360]) {
        rotate(angle) right(mounting_r) {
          cylinder(h=flange_height*3, d=mounting_hole_d, anchor=CENTER);
          // flat head
          cylinder(h=countersink_h,d2=countersink_d2,d1=countersink_d1);
          //translate([0,0,flange_height]) cylinder(h=min(h,2),d=countersink_d1);
          
        }
      }
    }
   // translate([-50,0,-50])cube([100,100,100]);
  }
    
  module subtract2() {
   translate([-50,0,-50])cube([100,100,100]);
  }
  
  difference() {
    union() {
        difference() {
        union() {
          add();
          add2();
        }
        subtract();
      }
      //add2();
    }
//    subtract2();
  }
}

shape(nutwidth=8.7, tsize=5.3, id=6, od=20, h=8.3, shape="circle", flange_height=1.8, mounting_holes=3, mounting_hole_d=3.2, mounting_r=6.25);
//tsize 5.5, default thread_depth worked, with just a touch of radial slop
//tsize 5, thread_depth 0.3 too tight
$fs=$preview ? $fs : .4;
$fa=$preview ? $fa : 5;
