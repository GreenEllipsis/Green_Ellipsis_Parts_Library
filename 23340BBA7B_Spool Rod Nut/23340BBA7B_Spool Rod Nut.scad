// a BOSL2 module
if (is_undef(BOSL_VERSION)) include <../libs/BOSL2/std.scad>

module 23340BBA7B_spool_rod_nut(anchor=CENTER, spin=0, orient=UP) {
  file="../23340BBA7B_Spool Rod Nut/23340BBA7B_Spool Rod Nut.stl";
  r=37.75/2;
  h=12.41;
  anchors=[
    named_anchor("ceiling",[0, 0, -3.4], TOP, 0),
  ];
  attachable(anchor,spin,orient, r=r, l=h, anchors=anchors) {
    import(file);
    children();
  }
}

*23340BBA7B_spool_rod_nut() show_anchors();
