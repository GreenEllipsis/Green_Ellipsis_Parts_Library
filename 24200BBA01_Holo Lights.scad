base_w = 117.24/3;
base_h = 150/5;
base_l = 150+110;
 foo_gap = 4;
 slit_t =0.1;
 line_w=0.5;
 layer_h=0.2;
step_t=line_w*3;
step_w=base_w+step_t;
shelves=5;

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

module cover() {
  foo(0,layer_h*3);
  for(i=[0:shelves-3]) {
    translate([-i*base_w, i*base_h]) step();
  }
  translate([-(shelves-2)*base_w, (shelves-2)*base_h]) step_riser();
  //top tread
  translate([-(shelves-1)*base_w, (shelves-1)*base_h-1-step_t]) cube([step_w-step_t-1, step_t, base_l]);
}

module foo(gap=foo_gap, l=base_l) {
  foo_h=base_h-step_t-gap;
  for (i=[0:shelves-2]) {
    translate([-(shelves-1)*base_w, base_h*((shelves-2)-i)]) cube([base_w*(i+1)-step_t-gap, foo_h, l]);
  }
  for (i=[1:shelves-2]) {
    translate([-(shelves-1)*base_w, base_h*((shelves-2)-i)+foo_h]) cube([base_w*(i)-step_t-gap, step_t+gap, l]);
  }
}

// slits for vase mode printing. Nevermind. I'll do it in the slicer.
module subtract() {
  corner1_x=-base_w-step_t-foo_gap;
  corner1_y=base_h*2-step_t-foo_gap;
  linear_extrude(base_l) polygon([
  [-base_w*3+line_w, line_w],
  [-base_w*3+line_w, line_w+slit_t],
  [corner1_x, corner1_y],
  [corner1_x, corner1_y-slit_t]
  ]);
  
}

%stand();
cover();
% color("green") difference() {
  foo();
  #subtract();
}