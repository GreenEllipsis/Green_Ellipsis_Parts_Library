// a BOSL2 module

include <../libs/BOSL2/std.scad>

module 23340BBA5C_doublegear48t(anchor=CENTER, spin=0, orient=UP) {
  file="../23340BBA5C_DoubleGear48t/23340BBA5C_DoubleGear48t.stl";
  native_r=40;
  native_r2=11.2;
  native_h=23;
  o_offset = [0, 0, -native_h/2]; // offset from mesh origin to geometric center
  attachable(anchor,spin,orient, r=native_r, r2=native_r2, l=native_h) {
    translate(o_offset) import(file);
    children();
  }
}


*23340BBA5C_doublegear48t() show_anchors();
