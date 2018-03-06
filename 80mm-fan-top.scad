// remove grills for two smaller fans
// replace with one 80mm fan
// this should be more parameterized; numbers are approximate
face = 2.02;
$fn = 180;
screw_off = 36; // x/y offsets for mounting screw holes
screw_d = 5;    // hole diameter for mounting screws

difference() {
    union() {
        // turn upside down and align with 0 Z to print and model
        translate([0, 0, 18.86]) rotate([180, 0, 0])
            import("replicape_case_-_top.stl");
        // fill in the old fan grills
        translate([-30, -50, 0]) cube([60, 100, face]);
    }
    union() {
        // this difference is itself subtracted, so the
        // effect is essentially inverted
        difference() {
            union() {
                // fan area
                cylinder(d=80, h=face);
                // mounting screw holes
                translate([-screw_off, -screw_off, 0]) cylinder(d=screw_d, h=face);
                translate([screw_off, -screw_off, 0]) cylinder(d=screw_d, h=face);
                translate([-screw_off, screw_off, 0]) cylinder(d=screw_d, h=face);
                translate([screw_off, screw_off, 0]) cylinder(d=screw_d, h=face);
            }
            union() {
                // grill center and bars
                cylinder(d=30, h=face);
                translate([-40, -2, 0]) cube([80, 4, face]);
                translate([-2, -40, 0]) cube([4, 80, face]);
            }
        }
    }
}
