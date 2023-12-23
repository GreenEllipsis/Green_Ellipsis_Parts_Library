// a BOSL2 module
include <../libs/BOSL2/std.scad>

module 23352BBA5D_small_gear(anchor=CENTER, spin=0, orient=UP) {
  file="../23352BBA5D_Small Gear/23352BBA5D_Small Gear.stl";
  native_r=11.2;
  native_h=16;
  attachable(anchor,spin,orient, r=native_r, l=native_h) {
    import(file);
    children();
  }
}

*23352BBA5D_small_gear(anchor=BOTTOM, orient=RIGHT) show_anchors();
