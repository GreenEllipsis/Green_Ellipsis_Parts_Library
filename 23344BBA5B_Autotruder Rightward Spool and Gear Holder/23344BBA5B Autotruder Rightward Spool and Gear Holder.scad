// a BOSL2 module

include <../libs/BOSL2/std.scad>

module 23344BBA5B_autotruder_rightward_spool_and_gear_holder(anchor=CENTER, spin=0, orient=UP) {
  file="../23344BBA5B_Autotruder Rightward Spool and Gear Holder/23344BBA5B_Autotruder Rightward Spool and Gear Holder REV -.stl";
  size=[192.13, 92.4, 40];
  inside_z = -12;
  base_t = 8;
  o_convert=[40-size.x/2, -size.y/2, -size.z/2];
  holes_z = o_convert.z + 12.97;
  anchors = [
    named_anchor("motor", o_convert + [69.3, 38.6, 0], TOP, 0),
    named_anchor("gear",  o_convert + [22 , 48.4,  0], TOP, 0),
    named_anchor("spool", o_convert + [129.63 , 60, 0], TOP, 0),
    named_anchor("right_holes", [-size.x/2+80, -size.y/2, holes_z], FRONT+RIGHT, 45),
    named_anchor("hole1", o_convert + [-30, 4, 12.97], BACK, 0),
    named_anchor("hole2", o_convert + [-10, 4, 12.97], BACK, 0),
    named_anchor("hole3", o_convert + [10, 4, 12.97], BACK, 0),
    named_anchor("hole4", o_convert + [30, 4, 12.97], BACK, 0),
  ];
  attachable(anchor,spin,orient, anchors=anchors, size=size) {
    import(file);
      children();
  }
}
*color_this("purple") 23344BBA5B_autotruder_rightward_spool_and_gear_holder(orient=FRONT, anchor="right_holes");// show_anchors();

*fwd(40) recolor("green") cuboid(10) position(TOP+RIGHT) {
  recolor("blue") attach(BOTTOM) cuboid(3,anchor=TOP);
  recolor("yellow") 23344BBA5B_autotruder_rightward_spool_and_gear_holder(orient=FRONT, anchor="right_holes"); // show_anchors();
}