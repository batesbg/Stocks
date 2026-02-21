// ============================================================
// Arlo Pro 5S (VMC4060P) Rain & Sun Hood
// ============================================================
// A clip-on hood that follows the rounded contours of the Arlo
// Pro 5S camera body. The camera has a pill/capsule shape with
// heavily rounded vertical edges. This hood hugs that shape to
// deflect rain and block direct sunlight from the lens.
//
// Camera dimensions: 89mm H x 52mm W x 78.4mm D
// The body is a rounded rectangle — nearly a vertical capsule.
// ============================================================

$fn = 80;

// --- Camera body dimensions (Arlo Pro 5S) ---
cam_width    = 52;    // mm, side to side
cam_height   = 89;    // mm, top to bottom
cam_depth    = 78.4;  // mm, front to back
cam_corner_r = 26;    // mm, vertical edge radius (half width = capsule)

// --- Hood parameters ---
wall         = 2.5;   // mm, hood shell thickness
clearance    = 0.6;   // mm, gap between hood and camera body
hood_wrap    = 42;    // mm, how far down the sides the hood extends
hood_back    = 35;    // mm, how far back the hood extends on the body
visor_ext    = 30;    // mm, how far the visor projects forward
visor_angle  = 10;    // degrees, downward tilt for water runoff
drip_edge    = 1.5;   // mm, raised rim at visor tip
lip_height   = 3;     // mm, inner retention lip depth
lip_inset    = 1.0;   // mm, retention lip thickness

// --- Derived ---
inner_r = cam_corner_r + clearance;
outer_r = inner_r + wall;
inner_w = cam_width + clearance * 2;
outer_w = inner_w + wall * 2;

// ============================================================
// Main Assembly
// ============================================================
hood();

// ============================================================
// Modules
// ============================================================

module hood() {
    difference() {
        union() {
            contour_shell();
            visor();
        }
        // Trim everything below the hood wrap line
        translate([0, 0, -(hood_wrap + 50)])
            cube([200, 200, 100], center = true);
    }
    retention_lips();
}

// Shell that follows the camera's rounded-rectangle cross-section
module contour_shell() {
    difference() {
        // Outer shape
        camera_shape(outer_w, hood_back + wall, hood_wrap + wall, outer_r);
        // Inner cavity
        translate([0, -wall/2, -wall])
            camera_shape(inner_w, hood_back + wall + 1, hood_wrap + 1, inner_r);
        // Open the back
        translate([0, hood_back/2 + wall, 0])
            cube([outer_w + 2, wall + 2, (hood_wrap + wall) * 2 + 2], center = true);
    }
}

// Camera body profile: a rounded rectangle extruded vertically,
// centered on X, extending rearward on +Y, downward on -Z.
// This is the fundamental contour both inner and outer shells share.
module camera_shape(w, d, h, r) {
    clamp_r = min(r, w / 2);
    translate([0, 0, -h]) {
        hull() {
            // Front-left
            translate([-(w/2 - clamp_r), -clamp_r, 0])
                cylinder(r = clamp_r, h = h);
            // Front-right
            translate([(w/2 - clamp_r), -clamp_r, 0])
                cylinder(r = clamp_r, h = h);
            // Back-left
            translate([-(w/2 - clamp_r), d - clamp_r, 0])
                cylinder(r = clamp_r, h = h);
            // Back-right
            translate([(w/2 - clamp_r), d - clamp_r, 0])
                cylinder(r = clamp_r, h = h);
        }
    }
}

// Visor follows the curved front of the camera body and extends forward
module visor() {
    clamp_r = min(outer_r, outer_w / 2);
    translate([0, -(clamp_r), 0])
    rotate([visor_angle, 0, 0]) {
        // Curved visor plate: hull between the front edge arc and the tip
        hull() {
            // Arc along the front of the camera — matches the shell curvature
            front_arc(outer_w, outer_r, wall);
            // Visor tip — a thin bar extended forward
            translate([0, -visor_ext, 0])
                front_bar(outer_w, wall);
        }
        // Drip edge at visor tip
        translate([0, -visor_ext, 0])
            drip_rim(outer_w, drip_edge, wall);
        // Side flanges for rigidity
        visor_side_flange(outer_w / 2 - wall, visor_ext);
        visor_side_flange(-(outer_w / 2), visor_ext);
    }
}

// Arc shape matching the front curve of the camera body
module front_arc(w, r, thickness) {
    clamp_r = min(r, w / 2);
    hull() {
        translate([-(w/2 - clamp_r), 0, 0])
            cylinder(r = clamp_r, h = thickness);
        translate([(w/2 - clamp_r), 0, 0])
            cylinder(r = clamp_r, h = thickness);
    }
}

// Simple flat bar for the visor tip
module front_bar(w, thickness) {
    translate([-(w / 2), 0, 0])
        cube([w, 0.1, thickness]);
}

// Drip edge: raised rim along the visor front
module drip_rim(w, edge_h, thickness) {
    difference() {
        translate([-(w / 2), -edge_h, 0])
            cube([w, edge_h, thickness + edge_h]);
        // Round the outer edge
        translate([-(w / 2 + 1), -edge_h, thickness + edge_h])
            rotate([0, 90, 0])
                cylinder(r = edge_h, h = w + 2);
    }
}

// Triangular side flange connecting visor to shell
module visor_side_flange(x_pos, length) {
    translate([x_pos, 0, -12]) {
        cube([wall, length * 0.5, 12]);
    }
}

// Retention lips on the inside at the bottom of the shell
module retention_lips() {
    clamp_r = min(inner_r, inner_w / 2);
    for (side = [-1, 1]) {
        translate([side * (inner_w / 2 - lip_inset / 2), 0, -hood_wrap])
            cube([lip_inset, hood_back - clamp_r, lip_height], center = true);
    }
}
