// creates a heater block mount for the Autotrude with an E3D Volcano Heater Block
// TODO set height of nozzle to 21.6+51/2
// TODO add anchors for mounting heater block mounting holes
include <../libs/BOSL2/std.scad>
include <../libs/BOSL2/attachments_extras.scad>
include <../libs/BOSL2/extrusion_vslot.scad>
include <../23356BBA01_Volcano Heater Block/23356BBA01_Volcano Heater Block.scad>

function 23355BBA02_heater_block_mount_geom() =
  let (
    nozzle_height = 30, // target height of centerline of nozzle above mounting rails
    baseplate_t = 6, // thickness of mounting plate
    nozzle_offset_up = 15.5, // distance from bottom of heater block to centerline of nozzle
    z_offset = 6, // distance between top vslot and top of heater
    hb_geom = 23356BBA01_volcano_heater_block_geom(),
    nozzle_offset_down = _attach_geom_size(hb_geom).x - nozzle_offset_up,
    size = [20, 20, nozzle_height-baseplate_t+nozzle_offset_down+z_offset],
    fa = _find_anchor("heater_front_hole", hb_geom),
    ba = _find_anchor("heater_back_hole", hb_geom),
    anchors = [
      named_anchor("heater_front_mount", [size.x/2, fa[1].y, fa[1].z-z_offset],, RIGHT, 0),
      named_anchor("heater_back_mount",  [size.x/2, ba[1].y, ba[1].z-z_offset],, RIGHT, 0)
    ]
  )
  attachable_geom(size=size, anchors=anchors);

module 23355BBA02_heater_block_mount(anchor, spin, orient) {
  /* [Rendering] */
  preview_fa = 12;
  preview_fs = 5;
  render_fa = 10;
  render_fs = 0.4;
  $fa = $preview ? preview_fa : render_fa;
  $fs = $preview ? preview_fs : render_fs;
  geom = 23355BBA02_heater_block_mount_geom();
  size = _attach_geom_size(geom);
  echo(str("23355BBA02_heater_block_mount size=",size));
  hb_size = _attach_geom_size(23356BBA01_volcano_heater_block_geom()); // heater_block_size
  z_offset = 6;

  module shape() {
    render(convexity = 1) 
    diff() {
      // v-slot extrusion
      recolor("Green") extrusion_vslot(profile=size.x, height=size.z, anchor=CENTER) {
        // cut-outs for heater block
        tag("remove") down(-2 + z_offset) position(TOP+LEFT) cuboid([hb_size.x+4, hb_size.y+1, hb_size.z+.02], anchor=TOP+LEFT, spin=[180,90,0]);
        tag("remove") down(-2 + z_offset) position(TOP+LEFT) cuboid([hb_size.x-4, hb_size.y+2, hb_size.z+1], anchor=TOP+LEFT, spin=[180,90,0]);
        // use heater block to align and cut mounting holes for the heater block
        tag("remove") down(z_offset) position(TOP+LEFT) recolor("DarkSalmon") 23356BBA01_volcano_heater_block(anchor=BOTTOM+RIGHT, spin=[180,-90,0]) { 
          tag("remove") attach("heater_front_hole", CENTER) cyl(d=3.2,h=hb_size.x*2);
          tag("remove") attach("heater_back_hole", CENTER) cylinder(d=3.2,h=hb_size.x*2);
          //show_anchors(); // DEBUG
        }
        // heater block for debugging
        //tag("keep") down(z_offset) position(TOP+LEFT) recolor("DarkSalmon") 23356BBA01_volcano_heater_block(anchor=BOTTOM+RIGHT, spin=[180,-90,0]); 
      }
    }
    
    // find the location of the heater_front_hole by introspection, so we can create an anchor on our part near the same location
    anchors = "heater_front_hole";
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

//TESTS

*23355BBA02_heater_block_mount() show_anchors();
23355BBA02_heater_block_mount();
*23355BBA02_heater_block_mount() attach("heater_front_hole") recolor("red") cube(10);

