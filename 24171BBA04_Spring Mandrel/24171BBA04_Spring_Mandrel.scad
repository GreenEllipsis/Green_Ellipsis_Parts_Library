// creates a mandrel about which to wrap spring steel to create a spring
include <../libs/BOSL2/std.scad>
include <../libs/BOSL2/screws.scad>
include <../libs/BOSL2/drawing.scad>

// h is the free spring length
// d is spring inner diameter
// t is wire thickness
// pitch is coil pitch (distance betwee coils, on center)
// end_turns is the number of turns at the ends where pitch = t
// od is mandrel outer diameter, default is d+t
function 24171BBA04_spring_mandrel(h, d, t, pitch, end_turns=3,od, anchor, spin=0, orient=UP) =
  let (
//        outer_d = is_undef(od) ? d+t ? od;
        r = get_radius(d=od, dflt=d+t),
        anchor = get_anchor(anchor,center,BOT,CENTER),
        ovnf = cylinder(h=h, r=r, center=true)
      )
  assert(is_finite(r), "d must be a finite number.")
  reorient(anchor,spin,orient, r1=r, r2=r, l=h, p=ovnf);

module 24171BBA04_spring_mandrel(h, d, t, pitch, end_turns=3, od, core_d, anchor, spin=0, orient=UP) {
  /* [Dimensions of angle extrusion] */
  r = get_radius(d=d, dflt=1);
  outer_r = get_radius(d=od, dflt=d+t);
  starter_r = end_turns > 0 ? outer_r : r; 
  
  raw_length=end_turns > 0 ? h+t*2 : h; // end turns are going to get ground down by t, so compensate
  end_length = t*end_turns;
  full_pitch_length = raw_length-end_length*2;
  echo(h=h,d=d,t=t,pitch=pitch,raw_length=raw_length, full_pitch_length=full_pitch_length);
  
  preview_fa = 12;
  preview_fs = 5;
  render_fa = 10;
  render_fs = 1;
  $fa = $preview ? preview_fa : render_fa;
  $fs = $preview ? preview_fs : render_fs;
  
  module shape() {
    module add() { // basic mandrel shape
      // spring end turns at beginning. Must be about same d as mandrel so we can unwind spring off the mandrel
      color("pink") cylinder(h=end_length, r=outer_r) {
        // full pitch spring section
        up(end_length/2) cylinder(h=full_pitch_length, r=outer_r) {
          // end_turns and finish length
          up(full_pitch_length/2) cylinder(h=end_length, r=r);
        }   
      }
    }
    
    module subtract() { // grooves for the spring
      turns=full_pitch_length/pitch;
      // full pitch turns
      up(end_length) 
        path_sweep(method="natural", shape=rect(size=[t*3, t]), path=helix(l=full_pitch_length, turns=turns, r=r+t*3/2)); 
      // screw hole through everything. 1 mm smaller d
     cylinder(h=h*3, d=core_d, center=true);
    }
    
    difference() {
      add();
      subtract();
    }
  }
  
  attachable(r1=r, r2=r, l=h, anchor,spin,orient) {
    shape();
    children();
  }
}

t=1;
end_turns=4;
inner_d=5.4;
core_d=2.9;
pitch=4.5;
24171BBA04_spring_mandrel(h=40,d=inner_d,t=t,pitch=pitch, end_turns=end_turns, core_d=core_d, od=inner_d+t);
//24171BBA04_spring_mandrel(20,1,1,3) show_anchors();

//translate([20,0]) cyl(20,1) show_anchors();
