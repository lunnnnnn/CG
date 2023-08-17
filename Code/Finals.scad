
cyl_fn = 20; // [0::360]
in_fn = 20; // [0::360]
out_fn = 20; // [0::360]

module ring(outside_rad, height)
{
    
    chamfer_dia = 0.5;
    chamfer_rad = chamfer_dia /2;
    thickness = 0.5;
    inside_rad = outside_rad - thickness;

        // Rotate the cylinder profile into an actual cylinder
    rotate_extrude($fn=cyl_fn)
    {
        // Hull the "corners" into a cylinder profile
        hull(){
            translate([inside_rad + chamfer_rad, chamfer_rad, 0]) circle(d=chamfer_dia, $fn=in_fn, false);
            translate([inside_rad + chamfer_rad, height - chamfer_rad, 0]) circle(d=chamfer_dia, $fn=in_fn, false);
            translate([inside_rad + thickness - chamfer_rad, height - chamfer_rad, 0]) circle(d=chamfer_dia, $fn=out_fn, false);
            translate([inside_rad + thickness - chamfer_rad, chamfer_rad, 0]) circle(d=chamfer_dia, $fn=out_fn, false);
            }
    }
}
module ringLanternbody(radius, ringnum){
    translate([0, 0, radius*ringnum+30])linear_extrude(height = 30*radius, center = true, convexity = 10, twist = 0) circle(r = 2);
    translate([0, 0, radius*ringnum])cross(20);
    for (i=[0:1:ringnum]){
        translate([0, 0, i * (radius+3)])
        rotate_extrude()
        translate([20, 0, 0])
        circle(r = 5);
    }  
}
module tLanternbody(radius, height){
    translate([0, 0, 1.3*height])linear_extrude(height = 2*height, center = true, convexity = 10, twist = 0) circle(r = 2);
    h = height/15;
    for(i=[0:1:14]){
        translate([0, 0, i*h])ring(radius, h);
    }
    translate([0, 0, height])cylinder(h = 3, r = radius, center = true, $fn=100);
}

module Lanternbody(radius){
    translate([0, 0, 1.2*radius])linear_extrude(height = 1*radius, center = true, convexity = 10, twist = 0) circle(r = 2);
    difference(){
        sphere(radius, $fn =18);
        sphere(radius-2, $fn =18);
        }
    
}
module cross(radius){
    diameter = 2*radius;
    union(){
        rotate ([90,0,0]) cylinder (h = diameter, r=3, center = true, $fn=100);
        rotate ([0,90,0]) cylinder (h = diameter, r=3, center = true, $fn=100);
        }
    }
        
translate([0,0,200])rotate([90,0,0])color(c = [0.7, 0, 0, 1])cube([10000,4,4],true);
translate([200, 0,150])color(c = [0.7, 0, 0, 0.6])Lanternbody(30);
translate([90, 0,110])color(c = [0.7, 0, 0, 0.5])tLanternbody(20, 40);
translate([0, 0,70])color(c = [0.7, 0, 0, 0.7])ringLanternbody(4, 10);