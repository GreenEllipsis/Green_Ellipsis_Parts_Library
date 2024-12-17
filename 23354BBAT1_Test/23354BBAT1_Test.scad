// a BOSL2 Test module
standalone = is_undef(BOSL_VERSION);
if (standalone) include <../libs/BOSL2/std.scad>
include <../23353BBA01_Gantry Wheel 2020/23353BBA01_Gantry Wheel 2020.scad>

module 23354BBAT1_Test(anchor=CENTER, spin=0, orient=UP) {
  native_r=5;
  native_h=10;
  attachable(anchor,spin,orient, r=native_r, l=native_h) {
    cylinder(r=native_r, h=native_h, center=true);
    children();
  }
}

if (standalone) {
//  *23354BBAT1_Test() show_anchors();
//  recolor("pink") 23354BBAT1_Test() {
//    attach(BOTTOM) recolor("orange") 23353BBA01_gantry_wheel_2020(anchor=BOTTOM);
//  }
  linear_extrude(10) hexagon(ir=6);
}