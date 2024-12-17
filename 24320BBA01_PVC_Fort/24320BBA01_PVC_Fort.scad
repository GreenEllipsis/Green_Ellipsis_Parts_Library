d = 0.5*25.4;
side=d*2;
w=3*side; //side+2*side/(sqrt(2));
ep=0.01;
fillet=side/5;
leadin=side/10;
$fs=$preview ? 5 : 0.5;
$fa=$preview ? 12 : 4;

module reflect(v) {
  mirror(v) children();
  children();
}

module octogon(axes=3) {
  half=(axes % 1) > 0;
  echo(half=half);
  
  module add(){
    chamfer=fillet/4;
    linear_extrude(side, center=true) offset(r=fillet) offset(r=-fillet)  resize([w,w]) rotate(360/8/2) circle($fn=8);
    reflect([0,0,1]) translate([0,0,side/2+chamfer/4]) linear_extrude(chamfer/2, center=true, scale=(w-chamfer)/w) offset(r=fillet) offset(r=-fillet)  resize([w,w]) rotate(360/8/2) circle($fn=8);;
  }
  
  module subtract() {      
    for(z=[360/8:360/8:360]) {
      // main hole
      rotate([90,0,z]) translate([0,0,side/2+ep]) cylinder(d=d, h=side);
      // lead in
      rotate([90,0,z]) translate([0,0,side*1.25+ep]) cylinder(d1=leadin, d2=d+leadin, h=d/2);
    }
  }    

  difference() {
    union() {
      add();
      if (axes>=2) rotate([90,0]) add();
      if (axes>=3) rotate([0,90]) add();
    }
    subtract();
    if (axes>=2) rotate([90,0]) subtract();
    if (axes>=3) rotate([0,90]) subtract();
    // remove bottom
    if (half) translate([-w*2-side/2, -w, -w]) cube(w*2);
    
  }
}


octogon(3);