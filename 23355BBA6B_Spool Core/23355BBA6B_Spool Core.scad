// a BOSL2 module
include <../libs/BOSL2/std.scad>

module 23355BBA6B_spool_core(anchor=CENTER, spin=0, orient=UP) {
  file="../23355BBA6B_Spool Core/23355BBA6B_Spool Core.stl";
  r=51/2;
  h=74.44;
//  anchors=[
//    named_anchor("face",[0,0,-h/2+10.17], TOP, 0),
//  ];
  attachable(anchor,spin,orient, r=r, l=h) {
    import(file);
    children();
  }
}

*23355BBA6B_spool_core() show_anchors();
