//ykc 5mm deep, 12/13mm wide 
// strap, 3x20mm
$fn=12;
// watch strap
STRAP_WIDTH = 20;
STRAP_DEPTH = 3;

// USB metal part of YKNano
USB_WIDTH = 8.4;
USB_HEIGHT = 2.6;
USB_DEPTH = 7.3;
USB_DIMS = [USB_WIDTH, USB_DEPTH, USB_HEIGHT];
// plastic black part of YKNano
YKN_WIDTH = 13;
YKN_DEPTH = 22;
YKN_HEIGHT = 5;
YKN_DIMS = [YKN_WIDTH, YKN_DEPTH, YKN_HEIGHT];

// CAP = USB cap recepticle
CAP_HEIGHT = 6;
CAP_WIDTH = 12;

// mount band that goes round strap
MOUNT_DEPTH = 1;
MOUNT_LENGTH = 5;
MOUNT_WIDTH = STRAP_WIDTH + 2 * MOUNT_DEPTH;

// hole strap, strap/mount bit with hole fixing
HS_WIDTH = YKN_WIDTH+(2*MOUNT_DEPTH);
HS_LENGTH = 8;

module yubikeynano() {
    // body offset to position USB bit in centre of YKN bit
    body_offset = [(YKN_DIMS[0] - USB_DIMS[0])/2, 0, (YKN_DIMS[2] - USB_DIMS[2])/2];
    translate(body_offset)
        cube(USB_DIMS);
    translate([0,USB_DEPTH,0])
        cube(YKN_DIMS);
}

module cap(){
    difference(){
        cube([CAP_WIDTH,8,YKN_HEIGHT]);
        translate([((CAP_WIDTH-YKN_WIDTH)/2),USB_DEPTH,5])
            rotate(a=[180,0,0])
                yubikeynano();
    }
}

module strap(){
    cube([STRAP_WIDTH,70,STRAP_DEPTH]);
}

module mount(len){
   difference(){
        cube([STRAP_WIDTH+2*MOUNT_DEPTH,len,STRAP_DEPTH+2*MOUNT_DEPTH]);
       translate([MOUNT_DEPTH,0,MOUNT_DEPTH])
        strap();
    }
}

module cap_strap(){
    union(){
        mount(MOUNT_LENGTH);
        translate([((STRAP_WIDTH+(2*MOUNT_DEPTH))-CAP_WIDTH)/2,0,MOUNT_DEPTH + STRAP_DEPTH])
            cap();
    }
}

// strap which wraps around watchband, with USB-c cap
module hole_strap(){

    difference(){
        union(){
            mount(HS_LENGTH);
            translate([(MOUNT_WIDTH - HS_WIDTH)/2,0,STRAP_DEPTH + MOUNT_DEPTH])
                cube([HS_WIDTH,HS_LENGTH,YKN_HEIGHT+MOUNT_DEPTH]);
        }
        translate([((MOUNT_WIDTH-YKN_WIDTH)/2), -15,STRAP_DEPTH + MOUNT_DEPTH])
            yubikeynano();
    }

    translate([MOUNT_WIDTH/2,HS_LENGTH/2,(YKN_HEIGHT/2)+STRAP_DEPTH+MOUNT_DEPTH])
        hole_template();
}
module hole_template(){
    cylinder(r2=4, r1=2,h=YKN_HEIGHT/2);
    //cylinder(r=3,h=1);
}
/*
rotate([180,0,0]) translate([0,0,(-YKN_HEIGHT)+0])
    yubikeynano();*/
translate([0,30,0])
    cap_strap();

hole_strap();
//cap();