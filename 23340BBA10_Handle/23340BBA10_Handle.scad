// a BOSL2 module
if (is_undef(BOSL_VERSION)) include <../libs/BOSL2/std.scad>

module 23340BBA10_handle(anchor=CENTER, spin=0, orient=UP) {
  file="../23340BBA10_Handle/23340BBA10_Handle.stl";
  size = [134.89, 20.7, 54.2];
  size2 = [88, 20.7];
  anchors=[
    named_anchor("right_counterbore",[115/2, 0, -size.z/2+3.4], TOP, 0),
    named_anchor("left_counterbore",[-115/2, 0, -size.z/2+3.4], TOP, 0),
    named_anchor("right_hole",[115/2, 0, -size.z/2], BOTTOM, 0),
    named_anchor("left_hole",[-115/2, 0, -size.z/2], BOTTOM, 0),
  ];
  attachable(anchor,spin,orient, size=size, size2=size2, anchors=anchors) {
    rotate([-90,0,0]) import(file);
    children();
  }
}

*23340BBA10_handle() show_anchors();
