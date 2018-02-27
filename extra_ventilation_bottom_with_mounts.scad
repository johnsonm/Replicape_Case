// I wanted a case with more airflow than the original design
// and with cutouts to fit the beaglebone green
// The case is not quite centered; the numbers are approximate
x_off_p = 40.37;
x_off_n = 40.56;
shell = 2.05;
y_off_n = 58.31;
y_off_p = 54.88;
hd = 3; // air holes

module side_fill(x_off) {
    translate([x_off, -y_off_n, 0]) cube([shell, 2*y_off_n, 23]);
}
module hex_hole(x, y, z, r=0) {
    $fn = 6;
    translate([x, y, z]) rotate([0, 90, r]) cylinder(r=hd, h=shell);
}
module vents(x_off) {
    for (y=[-(y_off_n-4*hd):3*hd:(y_off_n-4*hd)]) {
        hex_hole(x_off, y, 2*hd);
        hex_hole(x_off, y, 6*hd);
    }
    for (y=[-(y_off_n-5.5*hd):3*hd:(y_off_n-5.5*hd)]) {
        hex_hole(x_off, y, 4*hd);
    }
}
module end_vents(y_off) {
    for (x=[-(x_off_p-4*hd):3*hd:(x_off_n-4*hd)]) {
        hex_hole(x, y_off_p, 2*hd, 90);
        hex_hole(x, y_off_p, 6*hd, 90);
    }
    for (x=[-(x_off_p-5.5*hd):3*hd:(x_off_n-5.5*hd)]) {
        hex_hole(x, y_off_p, 4*hd, 90);
    }
}
module bbg_slots() {
    // beaglebone green has wider USB instead of 5V barrel,
    translate([-10, -y_off_n, 11.25]) cube([30, shell, 15]);
    // and USB mini under the board
    translate([-25, -y_off_n, 6]) cube([12, shell, 5]);
}
difference() {
    union() {
        translate([0, 0, 20.4]) import("replicape_case_-_bottom_with_mounts.stl");
        side_fill(x_off_p);
        mirror([1,0,0]) side_fill(x_off_n);
    }
    union() {
        vents(x_off_p);
        end_vents(y_off_p);
        mirror([1,0,0]) vents(x_off_n);
        bbg_slots();
    }
}