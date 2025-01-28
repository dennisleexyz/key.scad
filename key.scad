include <units.scad>

$fa = 0.01;
$fs = 0.01;

function k(sw) = sw[0]; // spacing between key centers [X-axis, Y-axis]
function kco(sw) = sw[1]; // Bottom Housing [X, Y, Z-height]
function keyc(sw) = sw[2]; // keycap [X, Y]
function pins(sw) = sw[3]; // [[X position, Y position, Z-height, diameter (circular) or [X, Y] (rectangular)]]
function pinz(sw) = max([for(pin=pins(sw))pin.z]); // max pin Z-height
function h(sw) = sw[4]; // total switch height including pins,  excluding caps
function plate(sw) = sw[5]; // plate Z-height
function housing(sw) = sw[6]; // Top Housing [X, Y, Z-height]
function stem(sw) = sw[7]; // Stem Z-height

// Cherry MX
mx = [
    [U, U],
    [14, 14, 5],
    [18, 18],
    [
        // diameter +- 0.05
        [-3.81, 2.54, 3.3, 1.5],
        [2.54, 5.08, 3.3, 1.5],
        // diameter +- 0.1
        [0, 0, 3.3, 4],
        // diameter - 0.05
        [-5.08, 0, 2.6, 1.7],
        [5.08, 0, 2.6, 1.7],
    ],
    3.3 + 11.6 + 3.6,
    1.5,
    [15.6, 15.6, 11.6-5],
    3.6,
];

//ksw(mx);

// Kailh PG1280 KH Mid-height
kh = [
    [U, U],
    [12.20, 12.20, 3.60],
    [18, 18],
    [
        [-3.81, 2.54, 3.00, 1.5],
        [2.54, 5.08, 3.00, 1.5],
        [0, 0, 3.00, 3.85],
        [-9.00/2, 0, 3.00, 1.7],
        [9.00/2, 0, 3.00, 1.7],
    ],
    11.20 + 3.00,
    1.22, // 1.22 - 1.27
    [13.00, 13.00, 4.40],
    3.00,
];

//ksw(kh);

// Kailh PG1350 Choc v1
choc_v1 = [
    [cx, cy],
    [14.50, 13.80, 2.20],
    [17.5, 16.5],
    [
        [0, 5.90, 3.00, 1.20],
        [5.00, 3.80, 3.00, 1.20],
        [0, 0, 3.00, 3.40],
        [-11.00/2, 0, 2.65, 1.90],
        [11.00/2, 0, 2.65, 1.90],
    ],
    3.00 + 5.00 + 3.00,
    1.30,
    [15.00, 15.00, 5.80-(3.00-0.50)],
    3.00 - 0.50,
];

//ksw(choc_v1);

// Kailh PG1353 Choc v2
choc_v2 = [
    [U, U],
    [13.95, 13.95, 2.20],
    [18, 18],
    [
        [0, 5.90, 3.00, 1.20],
        [5.00, 3.80, 3.00, 1.20],
        [0, 0, 3.30, 5.00],
        [-5, -5.15, 3.00, 1.60],
    ],
    3.30 + 2.20 + 6.40,
    1.65,
    [15.00, 15.00, 3.10],
    6.40 - 3.10,
];

//ksw(choc_v2);

// Kailh PG1425 X
x = [
    [17, 17],
    [14.00, 14.00, 2.50-0.90],
    [16.5, 16.5],
    [
        [-3.40, -2.00, 2, 1.10],
        [-3.40, 2.90, 2, 1.10],
        [0, -0.9, 2, [5.00, 2.90+1.10]],
        [-5.50, 5.50, 0.60, 1.30],
        [5.50, -5.50, 0.60, 1.30],
    ],
    2.00 + 2.50 + 2,
    0.70,
    [14.80, 14.00, 0.90],
    2.00,
];

//ksw(x);

module ksw(sw) {
    for (pin = pins(sw))
        translate([pin.x, pin.y, pinz(sw)-pin.z])
            if (is_list(pin[3]))
                let (x = pin[3].x, y = pin[3].y)
                    translate([-x/2, -y/2])
                        cube([x, y, pin.z]);
            else
                cylinder(h=pin.z, d=pin[3]);
    
    let (x = kco(sw).x, y = kco(sw).y)
        translate([-x/2, -y/2, pinz(sw)])
            cube([x, y, kco(sw).z]);
    
    let (x = housing(sw).x, y = housing(sw).y)
        translate([-x/2, -y/2, pinz(sw)+kco(sw).z])
            cube([x, y, housing(sw).z]);
}