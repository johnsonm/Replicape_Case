face = 2.02;
$fn = 180;

difference() {
    union() {
        translate([0, 0, 18.86]) rotate([180, 0, 0]) import("replicape_case_-_top.stl");
        translate([-30, -50, 0]) cube([60, 100, face]);
    }
    union() {
        difference() {
            union() {
                cylinder(d=80, h=face);
                translate([-36, -36, 0]) cylinder(d=4, h=face);
                translate([36, -36, 0]) cylinder(d=4, h=face);
                translate([-36, 36, 0]) cylinder(d=4, h=face);
                translate([36, 36, 0]) cylinder(d=4, h=face);
            }
            union() {
                cylinder(d=40, h=face);
                translate([-40, -2, 0]) cube([80, 4, face]);
                translate([-2, -40, 0]) cube([4, 80, face]);
            }
        }
    }
}