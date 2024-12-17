base_w = 117.24/3;
base_h = 150/5;
base_l = 150+110;
 foo_gap = 5;
 slit_t =0.1;
 line_w=0.5;
 layer_h=0.2;
step_t=line_w*3;
step_w=base_w+step_t;
shelves=5;
sine_wave=[for (i=[-3.14159/2:0.1:3.1416*3/2]) [i+3.14159/2, sin(i*180/3.14159)+1]];

module rib(w,l,h) {
  linear_extrude(h) resize([w,l]) polygon(sine_wave);
}
  
module shelf() {
  cube([base_w, base_h, base_l]);
}

module stand() {
  for(i=[0:shelves-1]) {
    translate([-i*base_w, i*base_h]) shelf();
  }
}

module step_riser() {
  // riser
  translate([-1-step_t,0]) cube([step_t, base_h-1-step_t, base_l]);
}

module step() {
    step_riser();
  //tread
  translate([-1-step_t-base_w, base_h-1-step_t]) cube([step_w, step_t, base_l]);
  //filler
  translate([-1-step_t-base_w, base_h-1]) cube([step_t, 1, base_l]);
}

module taco(h=step_t/2) {
  d=10;
  rotate(round(rands(0,1,1).x)* 90) difference() {
    cylinder(d=d, h=h);
    translate([-d,-d*2]) cube(d*2);
  }
}

module cover() {
  foo(0,layer_h*3,rib=false);
  for(i=[0:shelves-3]) {
    translate([-i*base_w, i*base_h]) step();
  }
  translate([-(shelves-2)*base_w, (shelves-2)*base_h]) step_riser();
  //top tread
  translate([-(shelves-1)*base_w, (shelves-1)*base_h-1-step_t]) cube([step_w-step_t-1, step_t, base_l]);
  r_shelf=rands(0,3,30);
  r_z=rands(10,base_l-10,30);
  r_x=rands(10,base_w-10,15);
  r_y=rands(10,base_h-10,15);
  echo(r_shelf,r_z);
  for(i=[0:14]) {
    shelf=round(r_shelf[i]);
    translate([-(shelf+1)*base_w+r_x[i], (shelf+1)*base_h-step_t, r_z[i]]) color("green") rotate([-90,0]) taco(h=10);
  }
}

module foo(gap=foo_gap, l=base_l,rib=true) {
  foo_h=base_h-step_t-gap;

  module add() {
    for (i=[0:shelves-2]) {
      translate([-(shelves-1)*base_w, base_h*((shelves-2)-i)]) cube([base_w*(i+1)-step_t-gap, foo_h, l]);
    }
    for (i=[1:shelves-2]) {
      translate([-(shelves-1)*base_w, base_h*((shelves-2)-i)+foo_h]) cube([base_w*(i)-step_t-gap, step_t+gap, l]);
    }
  }
  
  module subtract() {
    //ribs for strength
    rib_w=base_w/5;
    rib_h=base_w/10;
    // bottom/top
    for (i=[1:shelves-1]) {
      translate([-i*base_w+(base_w)/2,0, -l/2]) {
        translate([-step_t-gap, -0.02]) rib(rib_w,rib_h,l*2);
        translate([gap/2, i*base_h-step_t-gap+0.02]) rotate(180) rib(rib_w, rib_h,l*2);
      }
    }
    // back/front
    for (i=[0:shelves-2]) {
      translate([0, (i*base_h)+base_h/2,-l/2]) {
          translate([-(shelves-1)*base_w-0.02, 0]) rotate(-90) rib(rib_w, rib_h,l*2);
          translate([-i*base_w-step_t-gap+0.02, -rib_w-step_t]) rotate(90) rib(rib_w,rib_h,l*2);
      }
    }
  }
  
  difference() {
    add();
    if (rib) subtract();
  }
    
}


*stand();
*cover();
color("green") difference() {
  foo();
}
