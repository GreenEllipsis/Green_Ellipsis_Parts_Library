// a BOSL2 module
include <../libs/BOSL2/std.scad>

module 23355BBA6C_spool_end_cap_removable(anchor=CENTER, spin=0, orient=UP) {
  file="../23355BBA6C_Spool End Cap Removable/23355BBA6C_Spool End Cap Removable.stl";
  r=80/2;
  h=10.62;
  r2=40.04/2;
  anchors=[
    named_anchor("face",[0,0,-h/2+5], TOP, 0),
  ];
  attachable(anchor,spin,orient, r=r, l=h, r2=r2, anchors=anchors) {
    import(file);
    children();
  }
}

//TESTS
*23355BBA6C_spool_end_cap_removable() show_anchors();
* difference() {
23355BBA6C_spool_end_cap_removable() show_anchors();
  translate([0,0,-100]) cube(200);
}
*23355BBA6C_spool_end_cap_removable() show_anchors()
position("face") up(0.2) recolor("Beige") cuboid(50, anchor=BOTTOM+RIGHT+BACK, orient=TOP);
