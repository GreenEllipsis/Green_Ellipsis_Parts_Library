w=20;
h=40.3;
t=2;
tab_offset=18;
tab_w=12.12;
tab_h=0;
tab_t=0;
insert_s=19.75;
post_d=6.95;
post_center_center_s= (32.74+25.24)/2;

//cap
hull() {
  center_center_s = h-w;
  translate([center_center_s/2, 0, 0]) cylinder(d2=w,d1=w-t,h=t);
  translate([-center_center_s/2, 0, 0]) cylinder(d2=w,d1=w-t,h=t);
}
rib_s=1;
translate([0,0,t]) {
  for (rib=[0:rib_s*2:insert_s]) {
    hull() {
//      translate([post_center_center_s/2, 0, rib]) cylinder(d2=post_d-rib_s*2,d1=post_d,h=rib_s*2);
      translate([-post_center_center_s/2, 0, rib]) cylinder(d2=post_d-rib_s*2,d1=post_d,h=rib_s*2);
    }
  }
}