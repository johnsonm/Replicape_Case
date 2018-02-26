// I wanted a case with more airflow than the original design
// The case is not quite centered; the numbers are approximate
x_off_p = 40.37;
x_off_n = 40.56;
shell = 2.05;
y_off = 60;
hd = 3; // air holes

module side_fill(x_off) {
    translate([x_off, -y_off, 0]) cube([shell, 2*y_off, 23]);
}
module hex_hole(x, y, z) {
    $fn = 6;
    translate([x, y, z]) rotate([0, 90, 0]) cylinder(r=hd, h=shell);
}
module vents(x_off) {
    for (y=[-(y_off-3*hd):3*hd:(y_off-3*hd)]) {
        hex_hole(x_off, y, 2*hd);
        hex_hole(x_off, y, 6*hd);
    }
    for (y=[-(y_off-4.5*hd):3*hd:(y_off-4.5*hd)]) {
        hex_hole(x_off, y, 4*hd);
    }
}
difference() {
    union() {
        translate([0, 0, 20.4]) import("replicape_case_-_bottom_with_mounts.stl");
        side_fill(x_off_p);
        mirror([1,0,0]) side_fill(x_off_n);
    }
    union() {
        vents(x_off_p);
        mirror([1,0,0]) vents(x_off_n);
    }
}