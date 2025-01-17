// I wanted a case with more airflow than the original design
// and with cutouts to fit the beaglebone green
// The case is not quite centered; the numbers are approximate
// There are a lot of "magic numbers" here from experimenting
x_off_p = 40.37;
x_off_n = 40.56;
shell = 2.05;
y_off_n = 58.31;
y_off_p = 54.88;
hd = 3; // air holes
m_d = 5.2; // diameter of mounting holes in flange
flange = 10; // width of mounting flange

module side_fill(x_off) {
    translate([x_off, -(y_off_n-(2*shell)), 0])
        cube([shell, 2*(y_off_n-(2*shell)), 23]);
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
module end_power_cutout() {
    translate([-(x_off_n-(2*shell)), y_off_p, 22])
        cube([x_off_p+x_off_n-(4*shell), shell, 3]);
}
module bbg_slots() {
    // beaglebone green has wider USB instead of 5V barrel,
    // and just leave room for some manufacturing variance
    translate([-11.5, -y_off_n, 11]) cube([34, shell, 15]);
    // and USB mini under the board
    translate([-25, -y_off_n, 6]) cube([12, shell, 7]);
}
module bottom_flange() {
    // designed to mount to corner of 2020 extrusion
    // similarly to original X5S electronics
    $fn = 30;
    y_n_fl = 2.4;
    mounting_holes = [
        // long sides
        [-(x_off_n+shell+flange/2), -(y_off_n-flange)],
        [-(x_off_n+shell+flange/2), y_off_p-flange],
        [x_off_p+shell+flange/2, -(y_off_n-flange)],
        [x_off_p+shell+flange/2, y_off_p-flange],
        // short sides
        [x_off_p-flange, y_off_p+shell+flange/2],
        [-(x_off_n-flange), y_off_p+shell+flange/2],
        [x_off_p-flange, -(y_off_n+shell+flange/2)],
        [-(x_off_n-flange), -(y_off_n+shell+flange/2)],
    ];
    difference() {
        union() {
            hull() {
                for (loc=[
                    [-(x_off_n+flange), -(y_off_n+flange)],
                    [x_off_p+flange, -(y_off_n+flange)],
                    [x_off_p+flange, y_off_p+flange],
                    [-(x_off_n+flange), y_off_p+flange],
                ]) {
                    x = loc[0];
                    y = loc[1];
                    translate([x, y, 0])
                        cylinder(d=m_d, h=shell);
                }
            }
            for (loc=mounting_holes) {
                x = loc[0];
                y = loc[1];
                translate([x, y, 0]) cylinder(d=8, h=5);
            }
        }
        union() {
            for (loc=mounting_holes) {
                x = loc[0];
                y = loc[1];
                translate([x, y, 0]) cylinder(d=m_d, h=5);
            }
        }
    }
}
difference() {
    union() {
        translate([0, 0, 20.4]) import("replicape_case_-_bottom.stl");
        side_fill(x_off_p);
        mirror([1,0,0]) side_fill(x_off_n);
        bottom_flange();
    }
    union() {
        vents(x_off_p);
        end_vents(y_off_p);
        mirror([1,0,0]) vents(x_off_n);
        bbg_slots();
        end_power_cutout();
    }
}