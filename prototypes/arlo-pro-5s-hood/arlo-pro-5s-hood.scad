// ============================================================
// Arlo Pro 5S (VMC4060P) Rain & Sun Hood
// ============================================================
// A clip-on hood that fits over the top of the Arlo Pro 5S
// camera body to deflect rain and block direct sunlight from
// hitting the lens. Designed to not obstruct the 160° FOV.
//
// Camera dimensions: 89mm H x 52mm W x 78.4mm D
// The camera body is a rounded rectangle (pill-shaped).
// ============================================================

$fn = 60;

// --- Camera dimensions (Arlo Pro 5S) ---
cam_width  = 52;    // mm, side to side
cam_height = 89;    // mm, top to bottom
cam_depth  = 78.4;  // mm, front to back
cam_corner_r = 14;  // mm, corner rounding radius of the body

// --- Hood parameters ---
wall_thickness = 2.5;       // mm, hood shell thickness
clearance      = 0.8;       // mm, gap between hood and camera for fit
visor_length   = 35;        // mm, how far the visor extends forward
visor_angle    = 12;        // degrees, downward tilt for water runoff
hood_height    = 40;        // mm, how far down the hood wraps on the sides
clip_depth     = 30;        // mm, how far back the hood wraps on the camera
lip_height     = 3;         // mm, inner retention lip height
lip_thickness  = 1.0;       // mm, inner retention lip thickness
drip_edge      = 1.5;       // mm, raised edge at visor front to channel water

// --- Derived dimensions ---
inner_w = cam_width + clearance * 2;
inner_d = cam_depth + clearance * 2;
outer_w = inner_w + wall_thickness * 2;
outer_d = inner_d + wall_thickness * 2;
inner_r = cam_corner_r + clearance;
outer_r = inner_r + wall_thickness;

// ============================================================
// Main Assembly
// ============================================================
hood();

// ============================================================
// Modules
// ============================================================

module hood() {
    union() {
        hood_shell();
        visor();
        retention_lips();
    }
}

// The U-shaped shell that wraps over the top and sides of the camera
module hood_shell() {
    difference() {
        // Outer shell
        rounded_box(outer_w, clip_depth + wall_thickness, hood_height + wall_thickness, outer_r);

        // Inner cutout (camera cavity)
        translate([0, -wall_thickness, -wall_thickness])
            rounded_box(inner_w, clip_depth + wall_thickness + 1, hood_height + 1, inner_r);

        // Open bottom
        translate([-(outer_w/2 + 1), -(clip_depth/2 + wall_thickness + 1), -(hood_height + wall_thickness + 1)])
            cube([outer_w + 2, outer_d + 2, hood_height + 1]);

        // Open back - cut away the rear so it slides on from behind
        translate([-(outer_w/2 + 1), clip_depth/2, -(hood_height + 1)])
            cube([outer_w + 2, wall_thickness + 2, hood_height + wall_thickness + 2]);
    }
}

// The visor that extends forward over the lens
module visor() {
    translate([0, -(clip_depth/2 + wall_thickness), 0])
    rotate([visor_angle, 0, 0])
    translate([0, 0, 0]) {
        difference() {
            union() {
                // Main visor plate
                translate([-(outer_w/2), 0, 0])
                    cube([outer_w, visor_length, wall_thickness]);

                // Drip edge at front
                translate([-(outer_w/2), visor_length - drip_edge, 0])
                    cube([outer_w, drip_edge, wall_thickness + drip_edge]);

                // Side walls for rigidity
                visor_side_wall(outer_w/2 - wall_thickness);
                visor_side_wall(-(outer_w/2));
            }

            // Round the front corners of the drip edge
            translate([-(outer_w/2 + 1), visor_length + 1, wall_thickness + drip_edge])
                rotate([0, 90, 0])
                    cylinder(r = drip_edge, h = outer_w + 2);
        }
    }
}

module visor_side_wall(x_pos) {
    translate([x_pos, 0, -10])
        cube([wall_thickness, visor_length * 0.6, 10 + wall_thickness]);
}

// Small lips on the inside that grip the camera body
module retention_lips() {
    // Left lip
    translate([-(inner_w/2), 0, -(hood_height)])
        retention_lip_strip();
    // Right lip
    translate([inner_w/2 - lip_thickness, 0, -(hood_height)])
        retention_lip_strip();
}

module retention_lip_strip() {
    translate([0, -(clip_depth/2), 0])
        cube([lip_thickness, clip_depth, lip_height]);
}

// A box with rounded vertical edges, centered on X, back-aligned on Y
module rounded_box(w, d, h, r) {
    hull_r = min(r, w/2, d/2);
    translate([0, 0, -h]) {
        hull() {
            for (x = [-(w/2 - hull_r), (w/2 - hull_r)]) {
                for (y = [-(d - hull_r), hull_r]) {
                    translate([x, y, 0])
                        cylinder(r = hull_r, h = h);
                }
            }
        }
    }
}
