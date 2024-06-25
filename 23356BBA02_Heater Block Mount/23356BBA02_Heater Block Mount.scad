// creates a heater block mount for the Autotrude with an E3D Volcano Heater Block
// TODO set height of nozzle to 21.6+51/2
// TODO add anchors for mounting heater block mounting holes
include <../libs/BOSL2/std.scad>
include <../libs/BOSL2/attachments_extras.scad>
include <../libs/BOSL2/extrusion_angle.scad>
include <../23356BBA01_Volcano Heater Block/23356BBA01_Volcano Heater Block.scad>

// h is thickness
function 23356BBA02_heater_block_mount_geom(size, h) =
  let (
    nozzle_height = 30, // target height of centerline of nozzle above mounting rails
    hb_geom = 23356BBA01_volcano_heater_block_geom(),
    hb_size = _attach_geom_size(23356BBA01_volcano_heater_block_geom()), // heater_block_size
    hb_fh_anchor = _find_anchor("heater_front_hole", hb_geom),
    hb_bh_anchor = _find_anchor("heater_back_hole", hb_geom),
    nozzle_anchor = _find_anchor("nozzle", hb_geom),
    // nozzle_position relative to mount origin
    nozzle_pos = [hb_size.z/2-nozzle_anchor[1][2]+h, nozzle_height, size.z] -size/2,
    // hb_ft position relative to mount origin
    hb_fh_pos = nozzle_pos + rot([-90,0,90],p=(hb_fh_anchor[1] - nozzle_anchor[1])),
    hb_bh_pos = nozzle_pos + rot([-90,0,90],p=(hb_bh_anchor[1] - nozzle_anchor[1])),
    anchors = [
      named_anchor("hole1", [size.x/2, 0, size.z/4]-size/2, , FRONT, 0),
      named_anchor("hole2", [size.x*3/4, 0, size.z*3/4]-size/2, , FRONT, 0),
      named_anchor("hole3", [size.x/4, 0, size.z*3/4]-size/2, , FRONT, 0),
      named_anchor("hb_fh", hb_fh_pos, , LEFT, 0),
      named_anchor("hb_bh", hb_bh_pos, , LEFT, 0),
    ]
  )
  attachable_geom(size=size, anchors=anchors); 
//  attachable_geom(size=size); 

module 23356BBA02_heater_block_mount(anchor, spin, orient) {
  /* [Dimensions of angle extrusion] */
  height=20;
  width=1.5*25.4;
  thickness=1/16*25.4;
  /* [Autotruder Dimensions] */
  nozzle_height = 30; // target height of nozzle above base
  /* [Rendering] */
  preview_fa = 12;
  preview_fs = 5;
  render_fa = 10;
  render_fs = 0.4;
  $fa = $preview ? preview_fa : render_fa;
  $fs = $preview ? preview_fs : render_fs;
  
  // part geometry
  geom = 23356BBA02_heater_block_mount_geom(size=[width, width, height], h=thickness);
  size = _attach_geom_size(geom);
  // [ANCHOR, POS, VEC, ANG]
  hole1 = _find_anchor("hole1", geom);
  hole2 = _find_anchor("hole2", geom);
  hole3 = _find_anchor("hole3", geom);
  hb_fh = _find_anchor("hb_fh", geom);
  hb_bh = _find_anchor("hb_bh", geom);

  module shape() {
    mounting_hole_d = 4.3;
    hb_hole_d = 3.2;
    render(convexity = 1) 
    difference() {
      // angle extrusion
      recolor("Green") extrusion_angle(height=height, width=width, thickness=thickness, anchor=CENTER);
     // {
        // attach and use the heater block to align and cut mounting holes for the heater block
//        tag("removeX") translate([hb_size.z/2-nozzle_anchor[1][2]+thickness, nozzle_height, 0]) position(LEFT+FRONT+TOP) recolor("DarkSalmon") 23356BBA01_volcano_heater_block(anchor="nozzle", orient=BACK, spin=[0,-90,0]) { 
//          tag("removeX") attach("heater_front_hole", CENTER) cyl(d=3.2,h=hb_size.x*2);
//          tag("removeX") attach("heater_back_hole", CENTER) cyl(d=3.2,h=hb_size.x*2);
          //show_anchors(); // DEBUG
    //    }
        // heater block for debugging
        //tag("keep") down(z_offset) position(TOP+LEFT) recolor("DarkSalmon") 23356BBA01_volcano_heater_block(anchor=BOTTOM+RIGHT, spin=[180,-90,0]); 
      //}
      translate(hole1[1]) rotate([90,0,0]) cylinder(d=mounting_hole_d,h=thickness*3, center=true);
      translate(hole2[1]) rotate([90,0,0]) cylinder(d=mounting_hole_d,h=thickness*3, center=true);
      translate(hole3[1]) rotate([90,0,0]) cylinder(d=mounting_hole_d,h=thickness*3, center=true);
      translate(hb_fh[1]) rotate([0,90,0]) cylinder(d=hb_hole_d,h=thickness*3, center=true);
      translate(hb_bh[1]) rotate([0,90,0]) cylinder(d=hb_hole_d,h=thickness*3, center=true);
    }
    
    // find the location of the heater_front_hole by introspection, so we can create an anchor on our part near the same location
    //anchors = "heater_front_hole";
//    echo(block_geom=block_geom, anchors=anchors);
//    for ($idx = idx(anchors)) {
//        anchr = anchors[$idx];
//        anch = _find_anchor(anchr, $parent_geom);
//        two_d = _attach_geom_2d($parent_geom);
//        $attach_to = to;
//        $attach_anchor = anch;
//        $attach_norot = norot;
//        olap = two_d? [0,-overlap,0] : [0,0,-overlap];
//        if (norot || (norm(anch[2]-UP)<1e-9 && anch[3]==0)) {
//            translate(anch[1]) translate(olap) children();
//        } else {
//            fromvec = two_d? BACK : UP;
//            translate(anch[1]) rot(anch[3],from=fromvec,to=anch[2]) translate(olap) children();
//        }
 //   }

  }
  
    
  
  attachable(anchor,spin,orient, geom=geom) {
    shape();
    children();
  }
}

