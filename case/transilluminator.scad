/*This project is based on IORodeo & reGOSH  transiluminator
All this code is licensed under the Creative Commons - Attribution  (CC BY 3.0)
Fernán Federici 2025
*/



corr=0.2;// used for printing imperfections when one piece has to go into another; highly reccommended
screw_d=54;//distance between screw holes
screw_r=3/2;
holder_x=126.6;
holder_y=74.6;
holder_z=4;
hat= 50;
toehold=10;
neck_x=hat/2;
neck_y=holder_y;
neck_h=30;
wall=3;
dist_from_border=8;//d of screw holes from border of acrylic
     

use <threadlib/threadlib.scad> //read https://github.com/adrianschlatter/threadlib to install the lib

////////////////////////////////////
//  Parameters  //

standoff_type= [19.05, 9.5];
thread_h = standoff_type[0];// define here the standoff type 0=19,05 and 1=9,5
standoff_d=7;
thread_ri = 3/2; // thread internal radius
stand_r=7/2;
thread_size = "M3x0.5"; //  thread.
specs = thread_specs(str(thread_size, "-ext"));
pitch = specs[0];
turns = thread_h/pitch - 1; // 


//these versions are scaled for better fit with the M3s
standoff();
module standoff(){
      difference(){
                //internal cylinder space
                 color("grey") cylinder(h=thread_h, r=stand_r, $fn=6, center =false);
          scale([1.2,1.2,1]) tap(thread_size, turns=turns+corr);

            }}              
            
 

hat_screen();
module hat_screen(){
 difference(){ union(){ 
     frame();
    negative_neck();
  }
  //screw holes
    translate([-holder_x/2+dist_from_border+screw_r, screw_d/2+screw_r/2,0]) cylinder(h=wall*4, r=screw_r,$fn=40, center=true);
  translate([-holder_x/2+dist_from_border+screw_r, -screw_d/2-screw_r/2,0]) cylinder(h=wall*4, r=screw_r,$fn=40, center=true);
  translate([holder_x/2-dist_from_border-screw_r, screw_d/2+screw_r/2,0]) cylinder(h=wall*4, r=screw_r,$fn=40, center=true);
  translate([holder_x/2-dist_from_border-screw_r, -screw_d/2-screw_r/2,0]) cylinder(h=wall*4, r=screw_r,$fn=40, center=true);
  }
    }


//frame(); //
module frame(){
 difference(){
        minkowski(){
            cube(size=[holder_x+hat,holder_y+hat,holder_z], center= true);
            cylinder(r=3,h=holder_z*0.5, $fn=50);}
    translate([0,0,-holder_z/2]) color("red") cube(size=[holder_x-toehold,holder_y-toehold,holder_z], center= true);
            translate([0,0,holder_z/2]) 
                 minkowski(){cylinder(r=6, h=holder_z/2);
                cube(size=[holder_x+wall-6,holder_y-6,holder_z], center= true);
               }
        }
        //screw toeholds
        difference(){
              union(){
             translate([-holder_x/2+dist_from_border+screw_r, screw_d/2+screw_r/2,-holder_z*0.5/2])cylinder(h=holder_z*0.5, r=6.5, $fn=20, center=true);
             translate([-holder_x/2+dist_from_border+screw_r, -screw_d/2-screw_r/2,-holder_z*0.5/2])cylinder(h=holder_z*0.5, r=6.5,$fn=20,  center=true);
             translate([+holder_x/2-dist_from_border-screw_r, -screw_d/2-screw_r/2,-holder_z*0.5/2])cylinder(h=holder_z*0.5, r=6.5,$fn=20, center=true);
             translate([+holder_x/2-dist_from_border-+screw_r, screw_d/2+screw_r/2,-holder_z*0.5/2])cylinder(h=holder_z*0.5, r=6.5,$fn=20, center=true);}
                        translate([0,0,holder_z/2]) cube(size=[holder_x,holder_y,holder_z], center= true);

            }}
//  negative_neck();
module negative_neck(){
 difference(){
       translate([-holder_x/2-neck_x/2,0,-neck_h/2])   cube(size=[neck_x,neck_y-dist_from_border*2
     ,neck_h], center= true);
        translate([-holder_x/2-neck_x/2,0,-neck_h/2])   cube(size=[neck_x-wall*2-corr,neck_y-dist_from_border*2-wall*2,neck_h], center= true);
        }}

//  positive_neck();
module positive_neck(){
 difference(){
     union(){
       translate([-holder_x/2-neck_x/2,0,-neck_h/2])   cube(size=[neck_x-wall*2-corr*2,neck_y-dist_from_border*2-wall*2-corr*2,neck_h], center= true);
     
        translate([-holder_x/2,0,-neck_h+holder_z/2]) minkowski(){  cylinder(r=2, $fn=40);cube(size=[neck_x-4,holder_y-4,holder_z], center= true);
        }
         }
      
            translate([-holder_x/2+dist_from_border, screw_d/2+screw_r/2,-neck_h+holder_z/2]) cylinder(h=wall*2, r=screw_r, $fn=20, center=true);
  translate([-holder_x/2+dist_from_border, -screw_d/2-screw_r/2,-neck_h+holder_z/2]) cylinder(h=wall*2, r=screw_r, $fn=20, center=true);
        }}

 

