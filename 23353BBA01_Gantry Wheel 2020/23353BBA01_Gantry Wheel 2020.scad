// a BOSL2 module

include <../libs/BOSL2/std.scad>

module 23353BBA01_gantry_wheel_2020(anchor=CENTER, spin=0, orient=UP) {
    file = "../23353BBA01_Gantry Wheel 2020/23353BBA01_Gantry Wheel 2020.stl";
    native_r=23.87/2;
    native_h=10.23;
    attachable(anchor,spin,orient, r=native_r, l=native_h) {
      import(file);
      children();
    }
}

*23353BBA01_gantry_wheel_2020(anchor=BOTTOM, orient=RIGHT) show_anchors();
//
//recolor("lavender") 23353BBA01_gantry_wheel_2020(anchor=BOTTOM) {
//  attach(BOTTOM) recolor("pink") 23352BBA5D_small_gear(anchor=BOTTOM);
//  attach(TOP) recolor("Orange") 23353BBA01_gantry_wheel_2020(anchor=BOTTOM); 
//}