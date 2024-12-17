// creates a heater block mount for the Autotrude with an E3D Volcano Heater Block
// TODO set height of nozzle to 21.6+51/2
// TODO add anchors for mounting heater block mounting holes
include <../libs/BOSL2/std.scad>
include <../libs/BOSL2/attachments_extras.scad>
include <../libs/BOSL2/extrusion_vslot.scad>

  size=[20, 20, 60];
  preview_fa = 12;
  preview_fs = 5;
  render_fa = 10;
  render_fs = 0.4;
  $fa = $preview ? preview_fa : render_fa;
  $fs = $preview ? preview_fs : render_fs;
  recolor("Green") extrusion_vslot(profile=size.x, height=size.z, anchor=CENTER);
