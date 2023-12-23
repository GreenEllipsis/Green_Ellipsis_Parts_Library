// a BOSL2 module

if (is_undef(BOSL_VERSION)) include <../libs/BOSL2/std.scad>

use <../23329BBA02_MKS Robin Nano V3 Project Box Lid/YAPP_MKS_Robin_V3.0_Autotruder Lid.scad> 


module 23329BBA02_mks_robin_nano_v3_project_box_lid(anchor=CENTER, spin=0, orient=UP) {
  file="../23329BBA02_MKS Robin Nano V3 Project Box Lid/23329BBA02_MKS Robin Nano V3 Project Box Lid.stl";
  size = lidSize();
  baseSize = baseSize();
  o_offset = -size/2;
  s_offset = [connectors()[0][0], connectors()[0][1]]; // connector standoff offset from corner (positive inward)
  echo(s_offset=s_offset, "connectors[0]:", connectors()[0]);
  // In BOSL, back is +y and right is +x, but in YAPP, back is -x and right is +y. 
  // These anchors are in BOSL directions
  anchors = [
    named_anchor("s_left_front", o_offset+[s_offset.x, s_offset.y, 0], BOTTOM, 0),
    named_anchor("s_right_front", o_offset+[size.x - s_offset.x, s_offset.y, 0], BOTTOM, 0),
    named_anchor("s_left_back", o_offset+[s_offset.x, size.y - s_offset.y, 0], BOTTOM, 0),
    named_anchor("s_right_back", o_offset+[size.x - s_offset.x, size.y - s_offset.y, 0], BOTTOM, 5),
  ];
  attachable(anchor,spin,orient, size=size, anchors=anchors) {
    move(-size/2) down(baseSize.z) import(file);
    children();
  }
}

//TESTS
*color_this("lavender") cuboid([100,50,10]) 
  attach(TOP) color_this("pink") 23329BBA02_mks_robin_nano_v3_project_box_lid(anchor=BOTTOM); //show_anchors();
*color_this("lavender") cuboid([100,50,10]) 
  attach(TOP)  23329BBA02_mks_robin_nano_v3_project_box_lid(anchor=BOTTOM); //show_anchors();