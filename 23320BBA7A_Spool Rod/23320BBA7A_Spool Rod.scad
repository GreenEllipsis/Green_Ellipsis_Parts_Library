// a BOSL2 module
include <../libs/BOSL2/std.scad>

module 23320BBA7A_spool_rod(anchor=CENTER, spin=0, orient=UP) {
  file="../23320BBA7A_Spool Rod/23320BBA7A_Spool Rod.stl";
  r=26.98/2;
  h=136.67;
  attachable(anchor,spin,orient, r=r, l=h) {
    import(file);
    children();
  }
}

*23320BBA7A_spool_rod() show_anchors();
