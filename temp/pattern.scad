include <../libs/BOSL2/std.scad>
include <../libs/BOSL2/attachments_extras.scad>
  #sphere(r=10);
  // a BOSL2 module
  move_copies([[-25,-25,0], [25,-25,0], [0,0,50], [0,25,0]]) sphere(r=10);