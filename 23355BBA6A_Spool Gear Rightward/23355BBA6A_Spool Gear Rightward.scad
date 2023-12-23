// a BOSL2 module
include <../libs/BOSL2/std.scad>

module 23355BBA6A_spool_gear_rightward(anchor=CENTER, spin=0, orient=UP) {
  file="../23355BBA6A_Spool Gear Rightward/23355BBA6A_Spool Gear Rightward.stl";
  r=200.24/2;
  h=25.6;
  r2=40.04/2;
  anchors=[
    named_anchor("face",[0,0,-h/2+10.17], TOP, 0),
  ];
  attachable(anchor,spin,orient, r=r, l=h, r2=r2, anchors=anchors) {
    import(file);
    children();
  }
}

* 23355BBA6A_spool_gear_rightward() show_anchors();
* difference() {
23355BBA6A_spool_gear_rightward() show_anchors();
  translate([0,0,-100]) cube(200);
}
*23355BBA6A_spool_gear_rightward() show_anchors()
position("face") up(0.2) cuboid(50, anchor=BOTTOM+RIGHT+BACK, orient=TOP);
