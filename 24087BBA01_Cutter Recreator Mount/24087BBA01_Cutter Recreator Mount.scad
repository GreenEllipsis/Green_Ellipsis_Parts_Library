
module _reflect(v) {
  mirror(v) children();
  children();
}

module 24087BBA01_cutter_recreator_mount() {
// cutter test stand
  bearing_d = 4.8; //tap hole
  //counterbore_sz = [5, 8.8]; // h, d
  bearing_sz = [4.66, 16]; //h, d
  overlap = 1.8; // 2.5 was too much; // tolerance is about 0.8, so 0.8+2x material thickness, minimum (=0.8+0.33*2=1.46
  base_sz= [130, 28, 6];
  mount_d = 5;
  extrusion_w = 20;
  guide_d = 5; // tap hole
  slot_w = 1.5;
  slot_h = 14;
  rod_d=9; // 7.7 is nominal (5/16") for Recreator MK III, 8.95 for telescoping antenna
  rod_offset = 25;
  rod_rotation=[3, -5, 0];
  rod_boss_h=20;
  X = [1,0,0];
  Y = [0,1,0];
  r1 = guide_d/2+2;
  r2 = bearing_sz.y/2;
  top_bearing_boss_d = 8.5; 
  guide_offset = sqrt(r1*r2+r1^2)+1.5;
  guide_boss_size = [guide_offset*2, 30]; // [d, h]
  // rendering
  $fa = $preview ? 12 : 5;
  $fs = $preview ? 2 : 0.4;
  difference() {
    union() {
      // base
      cube(base_sz, center=true);
      //rod boss
      mirror(X) translate([rod_offset, guide_offset/2, -base_sz.z/2+2.5]) rotate(rod_rotation) { //2.5 is fudge factor to keep boss above bottom of base after rotation
        //boss
        cylinder(h=rod_boss_h, d=rod_d*2.25);
        // rod for show
        %cylinder(h=180, d=rod_d);
      }
      //guide boss
      translate([0, -guide_offset/2, -base_sz.z/2]) cylinder(h=guide_boss_size[1], d=guide_boss_size[0]);
      //support for top bearing
      translate([-overlap/2+bearing_sz.y/2,guide_offset/2, -base_sz.z/2]) cylinder(h=guide_boss_size[1], d=top_bearing_boss_d, center=false);
    }
    //base mounting holes
    _reflect(Y) _reflect(X) translate([base_sz.x/2-extrusion_w/2, base_sz.y/2-mount_d*1.25]) cylinder(h=2*base_sz.z, d=mount_d, center=true);
    // bearing mounting holes
    _reflect(X) translate([-overlap/2+bearing_sz.y/2,guide_offset/2]) cylinder(h=guide_boss_size[1]*3, d=bearing_d, center=true);
    // clearance hole through guide boss for bottom bearing
    mirror(X) translate([-overlap/2+a.y/2,guide_offset/2, base_sz.z/2]) cylinder(h=guide_boss_size[1]*2, d=bearing_sz[1]+0.5, center=false);
    // clearance hole through top bearing mount
    translate([-overlap/2+bearing_sz.y/2,guide_offset/2,base_sz.z/2]) cylinder(h=guide_boss_size[1]*2, d=bearing_d*1.1, center=false);
    // slot through guide boss
    translate([0, -guide_offset/2, -base_sz.z/2+guide_boss_size[1]-slot_h/2]) cube([slot_w, guide_boss_size[0], slot_h+1], center=true);
    // slot lead in
    translate([0, -guide_offset/2-guide_boss_size[0]/2, -base_sz.z/2+guide_boss_size[1]-slot_h/2]) rotate(45) cube([slot_w*2, slot_w*2, slot_h+1], center=true);
    // guide screw clearance
    //translate([0, -guide_offset/2, base_sz.z/2+guide_boss_size[1]-slot_h/2-3]) cylinder(d=guide_d+0.7, h=slot_h+7, center=true);
    // bottle guide ribbon bearing hole
    translate([0, -guide_offset/2]) cylinder(h=(base_sz.z+guide_boss_size[1])*2, d=guide_d, center=true);
    mirror(X) translate([rod_offset, guide_offset/2, -base_sz.z/2+2]) rotate(rod_rotation) cylinder(h=400, d=rod_d);
  }
}


