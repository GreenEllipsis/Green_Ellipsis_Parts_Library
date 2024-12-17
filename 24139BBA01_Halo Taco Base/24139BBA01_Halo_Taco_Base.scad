  // a BOSL2 module
include <../libs/BOSL2/std.scad>
include <../libs/BOSL2/attachments_extras.scad>
//include <../libs/BOSL2/screws.scad>
include <../libs/BOSL2/mounting_plate.scad>
//
function amp(degree, amplitude, min_height)=
  amplitude * sin(degree+90) + amplitude+min_height;
  
// path to make a wall which has one side curved in a sine wave
function sin_wall(cycles, wall_length, thickness, min_thickness) =
  let (
  cycles = cycles,  
  amplitude = (thickness-min_thickness)/2,    // Amplitude of the sine wave
  wavelength = wall_length/cycles,
  facets = $fn > 0 ? $fn :  ceil(max(min(360.0 / $fa, wavelength / $fs), 5)),  // Points per cycle
  min_height=min_thickness,
  // Generate the points for the sine wave
  wave = [ for (c = [0 : cycles - 1])
    for (deg = [0: facets: 360-1])
 // [deg,c*wavelength+deg/360*wavelength,amp(deg,amplitude,min_height)]])
  [c*wavelength+deg/360*wavelength,amp(deg,amplitude,min_height)]])
  //Add the last point and the points for the straight line
  concat(wave, [[wall_length, amp(360,amplitude,min_height)],[wavelength*cycles, 0], [0, 0]]);

//function _24021BBA00_holes(width, vslot_profile, t) = 
//  assert(is_def(width),"frame 'width' not defined")
//  assert(is_def(vslot_profile),"'vslot_profile' not defined")
//  assert(is_def(t),"backet thickness 't' not defined")
//  //TODO add center hole for block mounting screw
//  let (
//    w= width,
//    length = 130, // standard Autotruder distance
//    hole_d = 4.5,
//    hole2_d = 5.5,
//    hole_s = w/2-hole_d*1.5,
//    vslot_distance = length - vslot_profile,
//    d1=15,
//    d2=20,
//    h=sqrt(d1*d1-d2*d2/4)
//  )
//  [
//    [[hole_s, -vslot_distance/2], TOP, [hole_d, t]], //vslot mount
//    [[-hole_s, -vslot_distance/2], TOP, [hole_d, t]], //vslot mount
//    [[hole_s, vslot_distance/2], TOP, [hole_d, t]], // vslot mount
//    [[-hole_s, vslot_distance/2], TOP, [hole_d, t]], // vslot mount
//    [[d2/2, 0], TOP, [hole2_d, t]], // bracket mount
//    [[-d2/2, 0], TOP, [hole2_d, t]], // bracket mount
//    [[0, h], TOP, [hole2_d, t]] // bracket mount
//  ];
//  
function _24139BBA01_default_t() = 3;
function _24139BBA01_stripes() = 15;
function _24139BBA01_halo_shelf_l()=40.25;
function _24139BBA01_standoff_h()=8;
function _24139BBA01_shelf_cut_d()=2.5;
function _24139BBA01_slot_l()=10.5;
function 24139BBA01_Halo_Taco_Base() = 
//  assert(is_def(width),"frame 'width' not defined")
  let (
  length=200, //FIXME
  width=250, //FIXME
  height=50, //FIXME
  size=[length,width,height]
  )
  attachable_geom(geom=mounting_plate_geom(size=size));
 
module 24139BBA01_Halo_Taco_Base(anchor,spin,orient) {
  size=_attach_geom_size(24139BBA01_Halo_Taco_Base());
  width=size.x;
  length=size.y;
  height=size.z;
  halo_shelf_height=30.05;
  wheel_t=5;
  default_t=_24139BBA01_default_t();
  bottom_t=default_t;
  wall_t=default_t;
  wall_l = length - wall_t - 0.5;
  stripes=_24139BBA01_stripes();
  flange_h=20;
  bracket_size=[8,8];
  line_width=0.4;
  stop_h=bottom_t;
  drawer_w=width-40*2;
  drawer_l=length-10;
  drawer_h=height-stop_h-1;
  drawer_face_w=width;
  drawer_face_h=height-bottom_t;
  geom=24139BBA01_Halo_Taco_Base();
  module shape() {
    back_wall_t=wall_t/2;
    
    module floor() {
      rib_w=16;
      module add() {
        // floor
        stop_size=[wheel_t,wall_t,stop_h];
        guide_size=[wall_t,wall_l,bottom_t*2];
        up(wall_t/2) cube([width,length,bottom_t], center=true);
        xflip_copy() {
        // drawer guides
        translate([drawer_w/2+0.1,-length/2+wall_t,bottom_t]) 
          cube(guide_size);
        // drawer stops
        translate([drawer_w/2+0.1-stop_size.x,-length/2+stop_size.y,bottom_t])
          cube(stop_size);
        }
      }
      module subtract() {
        // outer holes in floor
        hole_size=[(width - drawer_w)/2- rib_w, length-rib_w*2, bottom_t*4];
        xflip_copy() left(width/2-hole_size.x/2-rib_w/2) cuboid(hole_size, rounding=rib_w/2, edges=[FRONT+RIGHT,FRONT+LEFT,BACK+RIGHT,BACK+LEFT]);
        cuboid([drawer_w-rib_w,length-rib_w*2,bottom_t*4], rounding=rib_w/2, edges=[FRONT+RIGHT,FRONT+LEFT,BACK+RIGHT,BACK+LEFT]);
      }
      difference() {
        add();
        subtract();
      }
    }
    
    module left_wall() {
      
      module add() {
        tol=0.5; // tolerance
//        flange_l = length - _24139BBA01_halo_shelf_l();
        standoff_h=_24139BBA01_standoff_h();
        shelf_cut_d=_24139BBA01_shelf_cut_d();
        flange_h = standoff_h + bottom_t; // use an assembly cut to trim to fit
        flange_l=_24139BBA01_slot_l()-tol*2;
        flange_w=bracket_size.x;
        //corrugated wall
//        rotate(-90)
//          linear_extrude(height) 
//          polygon(sin_wall(stripes, wall_l, wall_t, line_width));
        // simple wall
        translate([0,-length]) cube([wall_t,length,height]);
        //stand support
        translate([0,-wall_l,height]) rotate([-90,0]) linear_extrude(wall_l) right_triangle(bracket_size);
        // flange TODO
        translate([flange_w/2,0,height+flange_h/2])
          ycopies(size.y/stripes, 15, sp=[0,-length+(length/30),0])
          cube([flange_w, flange_l, flange_h], center=true);

       // translate([wall_t,-flange_l,height]) cube([bracket_size.x-wall_t,flange_l,flange_h]);
        
      }
      
      module subtract() {
      }
      
      difference() {
        add();
        subtract();
      }
    }
    
    module back_wall() {
      module add() {
          cube([width,back_wall_t,height]);
      }
      add();
    }
    
    floor();
    xflip_copy() left(width/2) back(length/2) left_wall();
    translate([-width/2,+length/2-back_wall_t,0]) back_wall();    
  }
  
  attachable(anchor,spin,orient, geom=geom) {
    shape();
    children();
  }
}

function 24139BBA02_Halo_Taco_Plate() = 
//  assert(is_def(width),"frame 'width' not defined")
  let (
    base_size=_attach_geom_size(24139BBA01_Halo_Taco_Base()),
    size=[base_size.x,base_size.y,_24139BBA01_default_t()]
  )
  attachable_geom(geom=mounting_plate_geom(size=size));

module 24139BBA02_Halo_Taco_Plate(anchor,spin,orient) {
  stripes=_24139BBA01_stripes();
  base_size=_attach_geom_size(24139BBA01_Halo_Taco_Base());
  ridge_h=0.6;
  size1=_attach_geom_size(24139BBA02_Halo_Taco_Plate());
  size=[size1.x, size1.y,size1.z+ridge_h];
  
  module add() {
    standoff_w=17;
    standoff_h=_24139BBA01_standoff_h();
    // bulk plate
    cube(size, center=true);
    // for support slots
    xflip_copy() 
      translate([size.x/2-standoff_w/2,0,size.z/2+standoff_h/2])
      cube([standoff_w, size.y, standoff_h], center=true);
    //front and back ends
    yflip_copy()
      translate([0,size.y/2-(size.y-5),size.z/2+standoff_h/2])
      cube([size.x, 10, standoff_h], center=true);
    
  }
  
  module subtract() {
    slot_w=13;
    slot_l=_24139BBA01_slot_l();
    xflip_copy() 
      translate([size.x/2-slot_w/2+0.05,0])
      ycopies(size.y/stripes, 15)
      cube([slot_w, slot_l, size.z*10], center=true);
    translate([0,0,size.z*5/2 + size1.z/2]) 
      ycopies(size.y/stripes, 15)
      cube([size.x+0.02, slot_l, size.z*5], center=true);

  }
  
  difference() {
    add();
    subtract();
  }
}

module 24139BBA03_Halo_Taco_Shelf() {
  base_size=_attach_geom_size(24139BBA01_Halo_Taco_Base());
  default_t=_24139BBA01_default_t();
  size=[base_size.x+0.02, base_size.y+0.02,default_t];
  tray_size=[base_size.x, _24139BBA01_halo_shelf_l(),default_t];
  //shelf
  translate([0, -size.y/2+tray_size.y/2]) cube(tray_size, center=true);
  //sides
  xflip_copy()
    right(size.x/2-default_t/2) cube([default_t,size.y,default_t],center=true);
}

module assembly() {
  standoff_h=_24139BBA01_standoff_h();
  shelf_cut_d=_24139BBA01_shelf_cut_d();
  base_h = _attach_geom_size(24139BBA01_Halo_Taco_Base()).z;
  plate_t=_attach_geom_size(24139BBA02_Halo_Taco_Plate()).z;
  plate_h = plate_t+base_h;

  module add() {
    24139BBA01_Halo_Taco_Base();
    color("tan") translate([0,0,plate_t/2+base_h]) 24139BBA02_Halo_Taco_Plate();
  }
  
  module subtract() {
    up(plate_h+standoff_h+plate_t/2-shelf_cut_d) 24139BBA03_Halo_Taco_Shelf();
  }
  
  difference() {
    add();
    subtract(); // cut out shelf unit footprint for alignment
  }
}

assembly();