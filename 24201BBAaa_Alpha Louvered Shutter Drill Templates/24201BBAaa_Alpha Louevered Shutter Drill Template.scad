// shutter drill templates
// TODO the center locators are wrong
//shutter parameters
decor_w=39.70; // width of decorative part
edge_w=45.5; // from actual side to edge of decorative part
side_w=50; // total width of side "board"
center_w=72.36; // middle "board" width
center_max_h=9.41; 
center_min_h=5.45;
height=25; // -ish
hole_d=25.4/4; // 1/4 inch
wall_offset=20; // space between edge of window and edge of shutter

// template parameters
wall_t=2;
template_h = height-2;
template_t=1.2;
boss_h=5;
boss_d=hole_d*3;

module corner_template() {
  wall_template("both");
}

module wall_template(locator="left", offset=0) {
  center_s = (edge_w-decor_w)+decor_w/2;
  
  module add() {
    // plate
    plate_h=template_t;
    plate_w=center_s+hole_d*2;
    plate_l=plate_w+offset;
    wall_h=height-5+boss_h;
    cube([plate_w, plate_l, plate_h]);
    // walls
    if (locator=="right" || locator=="both") {
      translate([-wall_t, -wall_t]) cube([wall_t, wall_t+plate_w,wall_h]);
    }
    if (locator=="left" || locator=="both") {
      translate([-wall_t, -wall_t]) cube([wall_t+plate_l,wall_t, wall_h]);
    }
    translate([plate_w-wall_t, 0]) cube([wall_t, plate_w, boss_h]);
    translate([0,plate_l-wall_t]) cube([plate_l, wall_t, boss_h]);
    // boss
    translate([center_s, center_s, template_t]) cylinder(h=boss_h, d=boss_d);
  }
  module subtract() {
    //hole
    translate([center_s, center_s]) cylinder(h=boss_h*10, d=hole_d, center=true);
  }
  
  difference() {
    add();
    subtract();
  }
}

module side_template() {
  plate_h=template_t;
  plate_w=side_w+wall_t*4; // x-coord
  plate_l=center_w+wall_t*4; // y-coord
  wall_h=height-5+boss_h;
  inner_wall_h=(center_max_h+center_min_h)/2+boss_h;

  module add() {

    // plate
    cube([plate_w, plate_l, plate_h]);
    // walls
    // side wall
    translate([-wall_t, 0]) cube([wall_t, plate_l,wall_h]);
    // edge walls
    translate([0, 0]) cube([plate_w, wall_t, boss_h]);
    translate([0, plate_l-wall_t]) cube([plate_w, wall_t, boss_h]);
    translate([plate_w-wall_t, 0]) cube([wall_t, plate_l, boss_h]);
    // locator walls
    translate([plate_w-wall_t*2, plate_l-wall_t*2]) cube([wall_t*2, wall_t*2, inner_wall_h]);
    translate([plate_w-wall_t*2, 0]) cube([wall_t*2, wall_t*2, inner_wall_h]);
    // boss
    translate([center_s, plate_l/2, template_t]) cylinder(h=boss_h, d=boss_d);
  }
  module subtract() {
    //hole
    translate([center_s, plate_l/2]) cylinder(h=boss_h*10, d=hole_d, center=true);
  }
  
  difference() {
    add();
    subtract();
  }
}
    
spacing=edge_w*1.25;
corner_template();
translate([spacing*1,0,0]) wall_template("left", offset=wall_offset);
translate([spacing*2,0,0]) wall_template("right");
translate([spacing*3,0,0]) side_template();
