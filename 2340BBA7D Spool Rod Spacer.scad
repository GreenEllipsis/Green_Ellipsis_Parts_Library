// a BOSL2 module
include <../libs/BOSL2/std.scad>

module 23340BBA7D_spool_rod_spacer(anchor=CENTER, spin=0, orient=UP) {
  r=40/2;
  r2=30/2;
  h=10;
  hole_r=27.5/2;
  diff("remove") {
    tag("base") cyl(r=r, h=h/2) {
      attach(TOP,BOTTOM) cyl(r=r, r2=r2, h=h/2);
    }
    tag("remove") cyl(r=hole_r,h=h*2);
  }
}
//  anchors=[
//    named_anchor("face",[0,0,-h/2+10.17], TOP, 0),
//  ];
//  attachable(anchor,spin,orient, r=r, l=h) {
//    import(file);
//    children();
//  }
//}

23340BBA7D_spool_rod_spacer() show_anchors();
