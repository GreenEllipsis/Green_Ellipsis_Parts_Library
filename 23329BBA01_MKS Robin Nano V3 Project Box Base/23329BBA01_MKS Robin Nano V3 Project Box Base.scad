// a BOSL2 module
//TODO don't know why the lid will recolor() but the base won't.

if (is_undef(BOSL_VERSION)) include <../libs/BOSL2/std.scad>

use <../23329BBA01_MKS Robin Nano V3 Project Box Base/YAPP_MKS_Robin_V3.0_Autotruder Base.scad> 


module 23329BBA01_mks_robin_nano_v3_project_box_base(anchor=CENTER, spin=0, orient=UP) {
  file = "../23329BBA01_MKS Robin Nano V3 Project Box Base/23329BBA01_MKS Robin Nano V3 Project Box Base.stl";
  size = baseSize();
  o_offset = -size/2;
  s_offset = [connectors()[0][0], connectors()[0][1]]; // connector standoff offset from corner (positive inward)
  p_height = standoffHeight() + basePlaneThickness();
  p_offset = [wallThickness() + pcbStands()[0][0], wallThickness() + pcbStands()[0][1]]; //   //echo(s_offset=s_offset, "connectors[0]:", connectors()[0]);
  // In BOSL, back is +y and right is +x, but in YAPP, back is -x and right is +y. 
  // These anchors are in BOSL directions
  anchors = [
    named_anchor("m_left_front", o_offset+[-baseMounts()[3][0][1],baseMounts()[3][0][0], 0], BOTTOM, 0),
    named_anchor("m_right_front", o_offset+[size.x+baseMounts()[2][0][1], baseMounts()[2][0][0], 0], BOTTOM, 0),
    named_anchor("m_left_back", o_offset+[-baseMounts()[1][0][1],baseMounts()[1][0][0], 0], BOTTOM, 0),
    named_anchor("m_right_back", o_offset+[size.x+baseMounts()[0][0][1],baseMounts()[0][0][0], 0], BOTTOM, 5),
    named_anchor("s_left_front", o_offset+[s_offset.x, s_offset.y, size.z], TOP, 0),
    named_anchor("s_right_front", o_offset+[size.x - s_offset.x, s_offset.y, size.z], TOP, 0),
    named_anchor("s_left_back", o_offset+[s_offset.x, size.y - s_offset.y, size.z], TOP, 0),
    named_anchor("s_right_back", o_offset+[size.x - s_offset.x, size.y - s_offset.y, size.z], TOP, 5),
    named_anchor("p_left_front", o_offset+[paddingBack() + p_offset.x, paddingLeft() + p_offset.y, p_height], TOP, 0),
    named_anchor("p_right_front", o_offset+[-paddingFront() + size.x - p_offset.x, paddingLeft() + p_offset.y, p_height], TOP, 0),
    named_anchor("p_left _back", o_offset+[paddingBack() + p_offset.x, size.y - paddingRight() - p_offset.y, p_height], TOP, 0),
    named_anchor("p_right_back", o_offset + [-paddingFront() + size.x - p_offset.x, -paddingRight() + size.y - p_offset.y, p_height], TOP, 5),
  ];
  attachable(anchor,spin,orient, size=size, anchors=anchors) {
    move(-size/2) import(file);
    children();
  }
}

//TESTS
*23329BBA01_mks_robin_nano_v3_project_box_base() show_anchors();

*color_this("lavender") cuboid([100,150,10]) 
  attach(TOP) color_this("pink") 23329BBA01_mks_robin_nano_v3_project_box_base(anchor=BOTTOM); //show_anchors();