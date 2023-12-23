// a BOSL2 module
if (is_undef(BOSL_VERSION)) include <../libs/BOSL2/std.scad>

module 23345BBA01_mks_robin_nano_v3_1_001_3d(anchor=CENTER, spin=0, orient=UP) {
  file="../23345BBA01_MKS Robin Nano V3.1_001 3D/23345BBA01_MKS Robin Nano V3.1_001 3D.stl";
  size=[110,84,16.72];
  h_offset = [4, 4, 0];
  anchors=[
    named_anchor("left_back", -size/2+[h_offset.x, size.y-h_offset.y, h_offset.z], BOTTOM, 0),
    named_anchor("left_front", -size/2+h_offset, BOTTOM, 0),
    named_anchor("right_back", -size/2 + [size.x-h_offset.x, size.y-h_offset.y, h_offset.z], BOTTOM, 0),
    named_anchor("right_front", -size/2 + [size.x-h_offset.x, h_offset.y, h_offset.z], BOTTOM, 5),
  ];
  attachable(anchor,spin,orient, size, anchors=anchors) {
    import(file);
    children();
  }
}

*23345BBA01_mks_robin_nano_v3_1_001_3d() show_anchors();
*left(10) 23345BBA01_mks_robin_nano_v3_1_001_3d() show_anchors();
