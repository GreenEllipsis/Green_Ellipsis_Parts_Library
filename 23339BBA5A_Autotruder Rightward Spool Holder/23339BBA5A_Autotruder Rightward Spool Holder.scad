// a BOSL2 module

include <../libs/BOSL2/std.scad>

module 23339BBA5A_autotruder_rightward_spool_holder(anchor=CENTER, spin=0, orient=UP) {
  file="../23339BBA5A_Autotruder Rightward Spool Holder/23339BBA5A_REV -_Autotruder Rightward Spool Holder.3mf";
  size=[192.4, 76.5, 20.5];
  base_t = 8;
  o_convert=[40-size.x/2, -size.y/2, -size.z/2]; // mesh offset from measurementdatum to geometric center
  o_offset=[152.109-size.x/2,-size.y/2,-size.z/2]; // offset from mesh origin to geometric center
  holes_z = 14.25;
  anchors = [
    named_anchor("spool", [73.7, 21.7, 0], BOTTOM, 0),
    named_anchor("right_holes", [-size.x/2+80, -size.y/2, o_convert.z + holes_z], FRONT+RIGHT, 45),
    named_anchor("hole1", o_convert + [-29.9, 4, holes_z], BACK, 0),
    named_anchor("hole2", o_convert + [-9.6, 4, holes_z], BACK, 0),
    named_anchor("hole3", o_convert + [10.1, 4, holes_z], BACK, 0),
    named_anchor("hole4", o_convert + [30.37, 5, holes_z], BACK, 0),
  ];
  attachable(anchor,spin,orient, anchors=anchors, size=size) {
    translate(o_offset) import(file);
    children();
  }
}

*23339BBA5A_autotruder_rightward_spool_holder() show_anchors();

//23339BBA5A_autotruder_rightward_spool_holder(orient=FRONT, anchor="right_holes"); // show_anchors();

//*fwd(40) cuboid(10) position(TOP+RIGHT) {
//  color("yellow") 23339BBA5A_autotruder_rightward_spool_holder(orient=FRONT, anchor="right_holes") show_anchors();
//}