; HEADER_BLOCK_START
; BambuStudio 02.08.02.60
; model printing time: 13m 50s; total estimated time: 20m 11s
; total layer number: 23
; total filament length [mm] : 522.13
; total filament volume [cm^3] : 1255.87
; total filament weight [g] : 1.59
; model label id: 82,118
; object max height: 4.60,4.60
; filament_density: 1.27
; filament_diameter: 1.75
; max_z_height: 4.60
; filament: 1
; support_material_on_wipe_tower: 0
; HEADER_BLOCK_END

; CONFIG_BLOCK_START
; accel_to_decel_enable = 0
; accel_to_decel_factor = 50%
; activate_air_filtration = 0
; additional_cooling_fan_speed = 0
; additional_fan_full_speed_layer = 0
; alternate_extra_wall = 0
; ams_filament_load_time_ams = 0
; ams_filament_load_time_ams_lite = 0
; ams_filament_load_time_n3f_s = 0
; ams_filament_unload_time_ams = 0
; ams_filament_unload_time_ams_lite = 0
; ams_filament_unload_time_n3f_s = 0
; apply_scarf_seam_on_circles = 1
; auxiliary_fan = 0
; avoid_crossing_wall_includes_support = 0
; bed_custom_model = 
; bed_custom_texture = 
; bed_exclude_area = 
; bed_heat_soak_area = 
; bed_temperature_formula = by_first_filament
; before_layer_change_gcode = 
; best_object_pos = 0.5,0.5
; bottom_color_penetration_layers = 3
; bottom_shell_layers = 3
; bottom_shell_thickness = 0
; bottom_surface_density = 100%
; bottom_surface_pattern = monotonic
; bridge_angle = 0
; bridge_flow = 1
; bridge_no_support = 0
; bridge_speed = 50
; brim_object_gap = 0.1
; brim_type = auto_brim
; brim_width = 5
; chamber_temperatures = 0
; change_filament_gcode = ;===== A1 20251031 =======================\nM1007 S0 ; turn off mass estimation\nG392 S0\nM620 S[next_extruder]A\nM204 S9000\nG1 Z{max_layer_z + 3.0} F1200\n\nM400\nM106 P1 S0\nM106 P2 S0\n{if old_filament_temp > 142 && next_extruder < 255}\nM104 S[old_filament_temp]\n{endif}\n\nG1 X267 F18000\n\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E-{retraction_distances_when_cut[previous_extruder]} F1200\n{else}\nM620.11 S0\n{endif}\nM400\n\nM620.1 E F{flush_volumetric_speeds[previous_extruder]/2.4053*60} T{flush_temperatures[previous_extruder]}\nM620.10 A0 F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nT[next_extruder]\nM620.1 E F{flush_volumetric_speeds[next_extruder]/2.4053*60} T{flush_temperatures[next_extruder]}\nM620.10 A1 F{flush_volumetric_speeds[next_extruder]/2.4053*60} L[flush_length] H[nozzle_diameter] T{flush_temperatures[next_extruder]}\n\nG1 Y128 F9000\n\n{if next_extruder < 255}\n\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nM628 S1\nG92 E0\nG1 E{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nM400\nM629 S1\n{else}\nM620.11 S0\n{endif}\n\nM400\nG92 E0\nM628 S0\n\n{if flush_length_1 > 1}\n; FLUSH_START\n; always use highest temperature to flush\nM400\nM1002 set_filament_type:UNKNOWN\nM109 S[flush_temperatures[next_extruder]]\nM106 P1 S60\n{if flush_length_1 > 23.7}\nG1 E23.7 F{flush_volumetric_speeds[previous_extruder]/2.4053*60} ; do not need pulsatile flushing for start part\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\n{else}\nG1 E{flush_length_1} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\n{endif}\n; FLUSH_END\nG1 E-[old_retract_length_toolchange] F1800\nG1 E[old_retract_length_toolchange] F300\nM400\nM1002 set_filament_type:{filament_type[next_extruder]}\n{endif}\n\n{if flush_length_1 > 45 && flush_length_2 > 1}\n; WIPE\nM400\nM106 P1 S178\nM400 S3\nG1 X-38.2 F18000\nG1 X-48.2 F3000\nG1 X-38.2 F18000\nG1 X-48.2 F3000\nG1 X-38.2 F18000\nG1 X-48.2 F3000\nM400\nM106 P1 S0\n{endif}\n\n{if flush_length_2 > 1}\nM106 P1 S60\n; FLUSH_START\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_2 > 45 && flush_length_3 > 1}\n; WIPE\nM400\nM106 P1 S178\nM400 S3\nG1 X-38.2 F18000\nG1 X-48.2 F3000\nG1 X-38.2 F18000\nG1 X-48.2 F3000\nG1 X-38.2 F18000\nG1 X-48.2 F3000\nM400\nM106 P1 S0\n{endif}\n\n{if flush_length_3 > 1}\nM106 P1 S60\n; FLUSH_START\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_3 > 45 && flush_length_4 > 1}\n; WIPE\nM400\nM106 P1 S178\nM400 S3\nG1 X-38.2 F18000\nG1 X-48.2 F3000\nG1 X-38.2 F18000\nG1 X-48.2 F3000\nG1 X-38.2 F18000\nG1 X-48.2 F3000\nM400\nM106 P1 S0\n{endif}\n\n{if flush_length_4 > 1}\nM106 P1 S60\n; FLUSH_START\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\n; FLUSH_END\n{endif}\n\nM629\n\nM400\nM106 P1 S60\nM109 S[new_filament_temp]\nG1 E6 F{flush_volumetric_speeds[next_extruder]/2.4053*60} ;Compensate for filament spillage during waiting temperature\nM400\nG92 E0\nG1 E-[new_retract_length_toolchange] F1800\nM400\nM106 P1 S178\nM400 S3\nG1 X-38.2 F18000\nG1 X-48.2 F3000\nG1 X-38.2 F18000\nG1 X-48.2 F3000\nG1 X-38.2 F18000\nG1 X-48.2 F3000\nG1 X-38.2 F18000\nG1 X-48.2 F3000\nM400\nG1 Z{max_layer_z + 3.0} F3000\nM106 P1 S0\n{if layer_z <= (initial_layer_print_height + 0.001)}\nM204 S[initial_layer_acceleration]\n{else}\nM204 S[default_acceleration]\n{endif}\n{else}\nG1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000\n{endif}\n\nM622.1 S0\nM9833 F{outer_wall_volumetric_speed/2.4} A0.3 ; cali dynamic extrusion compensation\nM1002 judge_flag filament_need_cali_flag\nM622 J1\n  G92 E0\n  G1 E-[new_retract_length_toolchange] F1800\n  M400\n  \n  M106 P1 S178\n  M400 S4\n  G1 X-38.2 F18000\n  G1 X-48.2 F3000\n  G1 X-38.2 F18000 ;wipe and shake\n  G1 X-48.2 F3000\n  G1 X-38.2 F12000 ;wipe and shake\n  G1 X-48.2 F3000\n  M400\n  M106 P1 S0 \nM623\n\nM621 S[next_extruder]A\nG392 S0\n\nM1007 S1\n
; circle_compensation_manual_offset = 0
; circle_compensation_speed = 200
; close_additional_fan_first_x_layers = 3
; close_fan_the_first_x_layers = 3
; complete_print_exhaust_fan_speed = 70
; cool_plate_temp = 0
; cool_plate_temp_initial_layer = 0
; cooling_filter_enabled = 0
; cooling_perimeter_transition_distance = 10
; cooling_slowdown_logic = uniform_cooling
; counter_coef_1 = 0
; counter_coef_2 = 0.008
; counter_coef_3 = -0.041
; counter_limit_max = 0.033
; counter_limit_min = -0.035
; counterbore_hole_bridging = none
; curr_bed_type = Textured PEI Plate
; default_acceleration = 750
; default_ams_type = -1
; default_filament_colour = ""
; default_filament_profile = "Bambu PLA Basic @BBL A1"
; default_jerk = 0
; default_nozzle_volume_type = Standard
; default_print_profile = 0.20mm Standard @BBL A1
; deretraction_speed = 30
; detect_floating_vertical_shell = 1
; detect_narrow_internal_solid_infill = 1
; detect_overhang_wall = 1
; detect_thin_wall = 0
; diameter_limit = 50
; different_settings_to_system = default_acceleration;gap_infill_speed;initial_layer_travel_acceleration;inner_wall_speed;internal_solid_infill_speed;outer_wall_acceleration;outer_wall_speed;sparse_infill_speed;top_surface_acceleration;top_surface_speed;travel_acceleration;travel_speed;wall_loops;eng_plate_temp;eng_plate_temp_initial_layer;nozzle_temperature;nozzle_temperature_initial_layer;nozzle_temperature_range_high;supertack_plate_temp;supertack_plate_temp_initial_layer;
; draft_shield = disabled
; during_print_exhaust_fan_speed = 70
; elefant_foot_compensation = 0.075
; embedding_wall_into_infill = 0
; enable_arc_fitting = 1
; enable_circle_compensation = 0
; enable_filament_dynamic_map = 0
; enable_height_slowdown = 0
; enable_long_retraction_when_cut = 2
; enable_mixed_color_sublayer = 0
; enable_order_independent_overlap_carving = 0
; enable_overhang_bridge_fan = 1
; enable_overhang_speed = 1
; enable_pre_heating = 0
; enable_pressure_advance = 0
; enable_prime_tower = 0
; enable_support = 0
; enable_support_ironing = 0
; enable_tower_interface_features = 0
; enable_wrapping_detection = 0
; enforce_support_layers = 0
; eng_plate_temp = 80
; eng_plate_temp_initial_layer = 80
; ensure_vertical_shell_thickness = enabled
; exclude_object = 1
; extruder_ams_count = 1#0|4#0;1#0|4#0
; extruder_clearance_dist_to_rod = 56.5
; extruder_clearance_height_to_lid = 256
; extruder_clearance_height_to_rod = 25
; extruder_clearance_max_radius = 73
; extruder_colour = #018001
; extruder_max_nozzle_count = 1
; extruder_nozzle_stats = Standard#1
; extruder_nozzle_stats_new = 
; extruder_offset = 0x0
; extruder_printable_area = 
; extruder_type = Direct Drive
; extruder_variant_list = "Direct Drive Standard"
; fan_cooling_layer_time = 30
; fan_direction = undefine
; fan_max_speed = 90
; fan_min_speed = 40
; farthest_point_timelapse = 0
; filament_adaptive_volumetric_speed = 0
; filament_adhesiveness_category = 300
; filament_bridge_speed = 25
; filament_change_length = 10
; filament_change_length_nc = 10
; filament_colour = #00AE42
; filament_colour_type = 1
; filament_cooling_before_tower = 0
; filament_cost = 30
; filament_density = 1.27
; filament_dev_ams_drying_ams_limitations = 1;0
; filament_dev_ams_drying_heat_distortion_temperature = 75
; filament_dev_ams_drying_temperature = 65,65,55,55
; filament_dev_ams_drying_time = 12,12,12,12
; filament_dev_chamber_drying_bed_temperature = 80
; filament_dev_chamber_drying_time = 12
; filament_dev_drying_cooling_temperature = 55
; filament_dev_drying_softening_temperature = 60
; filament_diameter = 1.75
; filament_enable_overhang_speed = 1
; filament_end_gcode = "; filament end gcode \n\n"
; filament_extruder_compatibility = 0
; filament_extruder_variant = "Direct Drive Standard"
; filament_flow_ratio = 0.95
; filament_flush_temp = 0
; filament_flush_temp_fast = 0
; filament_flush_volumetric_speed = 0
; filament_ids = GFG99
; filament_is_mixed = 0
; filament_is_support = 0
; filament_map = 1
; filament_map_2 = 0
; filament_map_mode = Auto For Flush
; filament_max_volumetric_speed = 8
; filament_metal_stickiness = High
; filament_minimal_purge_on_wipe_tower = 15
; filament_mixed_components = ""
; filament_mixed_gradient = 0
; filament_mixed_gradient_curve = ""
; filament_mixed_gradient_per_part = 0
; filament_mixed_gradient_range = ""
; filament_mixed_sublayer_ratios = ""
; filament_multi_colour = #00AE42
; filament_notes = 
; filament_nozzle_map = 0
; filament_overhang_1_4_speed = 0
; filament_overhang_2_4_speed = 50
; filament_overhang_3_4_speed = 30
; filament_overhang_4_4_speed = 10
; filament_overhang_totally_speed = 10
; filament_pre_cooling_temperature = 0
; filament_pre_cooling_temperature_nc = 0
; filament_preheat_temperature_delta = 0
; filament_prime_volume = 45
; filament_prime_volume_nc = 60
; filament_printable = 3
; filament_ramming_travel_time = 0
; filament_ramming_travel_time_nc = 0
; filament_ramming_volumetric_speed = -1
; filament_ramming_volumetric_speed_nc = -1
; filament_retract_length_nc = 14
; filament_scarf_gap = 0%
; filament_scarf_height = 10%
; filament_scarf_length = 10
; filament_scarf_seam_type = none
; filament_self_index = 1
; filament_settings_id = "PETG Pro"
; filament_shrink = 100%
; filament_soluble = 0
; filament_start_gcode = "; filament start gcode\n{if (bed_temperature[current_extruder] >80)||(bed_temperature_initial_layer[current_extruder] >80)}M106 P3 S255\n{elsif (bed_temperature[current_extruder] >60)||(bed_temperature_initial_layer[current_extruder] >60)}M106 P3 S180\n{endif}\n\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}"
; filament_tower_interface_pre_extrusion_dist = 10
; filament_tower_interface_pre_extrusion_length = 0
; filament_tower_interface_print_temp = -1
; filament_tower_interface_purge_volume = 20
; filament_tower_ironing_area = 4
; filament_type = PETG
; filament_velocity_adaptation_factor = 1
; filament_vendor = Generic
; filament_volume_map = 0
; filename_format = {input_filename_base}_{filament_type[0]}_{print_time}.gcode
; fill_multiline = 1
; filter_out_gap_fill = 0
; first_layer_print_sequence = 0
; first_x_layer_fan_speed = 0
; first_x_layer_part_fan_speed = 0
; flush_into_infill = 0
; flush_into_objects = 0
; flush_into_support = 1
; flush_multiplier = 1
; flush_multiplier_fast = 1.2
; flush_volumes_matrix = 0
; flush_volumes_vector = 140,140
; full_fan_speed_layer = 0
; fuzzy_skin = none
; fuzzy_skin_first_layer = 0
; fuzzy_skin_mode = displacement
; fuzzy_skin_noise_type = classic
; fuzzy_skin_octaves = 4
; fuzzy_skin_persistence = 0.5
; fuzzy_skin_point_distance = 0.8
; fuzzy_skin_scale = 1
; fuzzy_skin_thickness = 0.3
; gap_infill_speed = 150
; gcode_add_line_number = 0
; gcode_flavor = marlin
; grab_length = 17.4
; group_algo_with_time = 0
; has_filament_switcher = 0
; has_scarf_joint_seam = 0
; head_wrap_detect_zone = 226x224,256x224,256x256,226x256
; hole_coef_1 = 0
; hole_coef_2 = -0.008
; hole_coef_3 = 0.23415
; hole_limit_max = 0.22
; hole_limit_min = 0.088
; host_type = octoprint
; hot_plate_temp = 80
; hot_plate_temp_initial_layer = 80
; hotend_cooling_rate = 2
; hotend_heating_rate = 2
; impact_strength_z = 10
; independent_support_layer_height = 1
; infill_combination = 0
; infill_direction = 45
; infill_instead_top_bottom_surfaces = 0
; infill_jerk = 9
; infill_lock_depth = 1
; infill_rotate_step = 0
; infill_shift_step = 0.4
; infill_wall_overlap = 15%
; inherits_group = ;"Generic PETG @BBL A1";
; initial_layer_acceleration = 500
; initial_layer_flow_ratio = 1
; initial_layer_infill_speed = 105
; initial_layer_jerk = 9
; initial_layer_line_width = 0.5
; initial_layer_print_height = 0.2
; initial_layer_speed = 50
; initial_layer_travel_acceleration = 500
; inner_wall_acceleration = 0
; inner_wall_jerk = 9
; inner_wall_line_width = 0.45
; inner_wall_speed = 150
; interface_shells = 0
; interlocking_beam = 0
; interlocking_beam_layer_count = 2
; interlocking_beam_width = 0.8
; interlocking_boundary_avoidance = 2
; interlocking_depth = 2
; interlocking_orientation = 22.5
; internal_bridge_support_thickness = 0.8
; internal_solid_infill_line_width = 0.42
; internal_solid_infill_pattern = zig-zag
; internal_solid_infill_speed = 150
; ironing_direction = 45
; ironing_fan_speed = -1
; ironing_flow = 10%
; ironing_inset = 0.21
; ironing_pattern = zig-zag
; ironing_spacing = 0.15
; ironing_speed = 30
; ironing_type = no ironing
; is_infill_first = 0
; layer_change_gcode = ; layer num/total_layer_count: {layer_num+1}/[total_layer_count]\n; update layer progress\nM73 L{layer_num+1}\nM991 S0 P{layer_num} ;notify layer change
; layer_height = 0.2
; line_width = 0.42
; locked_skeleton_infill_pattern = zigzag
; locked_skin_infill_pattern = crosszag
; long_retractions_when_cut = 0
; long_retractions_when_ec = 0
; machine_bed_mass_Y = 0
; machine_end_gcode = ;===== date: 20260513 =====================\nG392 S0 ;turn off nozzle clog detect\n\nM400 ; wait for buffer to clear\nG92 E0 ; zero the extruder\nG90\nG1 Z{max_layer_z + 0.4} F900 ; lower z a little\nG1 X0 Y{first_layer_center_no_wipe_tower[1]} F18000 ; move to safe pos\nG1 X-13.0 F3000 ; move to safe pos\n{if !spiral_mode && print_sequence != \"by object\"}\nM1002 judge_flag timelapse_record_flag\nM622 J1\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM991 S0 P-1 ;end timelapse at safe pos\nM623\n{endif}\n\nM140 S0 ; turn off bed\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off remote part cooling fan\nM106 P3 S0 ; turn off chamber cooling fan\n\n;G1 X27 F15000 ; wipe\n\n; pull back filament to AMS\nM620 S255\nG1 X267 F15000\nT255\nG1 X-28.5 F18000\nG1 X-48.2 F3000\nG1 X-28.5 F18000\nG1 X-48.2 F3000\nM621 S255\n\nM104 S0 ; turn off hotend\n\nM400 ; wait all motion done\nM17 S\nM17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom\n{if (max_layer_z + 100.0) < 256}\n    G1 Z{max_layer_z + 100.0} F600\n    G1 Z{max_layer_z +98.0}\n{else}\n    G1 Z256 F600\n    G1 Z256\n{endif}\nM400 P100\nM17 R ; restore z current\n\nG90\nG1 X-48 Y180 F3600\n\nM220 S100  ; Reset feedrate magnitude\nM201.2 K1.0 ; Reset acc magnitude\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 0\n\n;=====printer finish  sound=========\nM17\nM400 S1\nM1006 S1\nM1006 A0 B20 L100 C37 D20 M40 E42 F20 N60\nM1006 A0 B10 L100 C44 D10 M60 E44 F10 N60\nM1006 A0 B10 L100 C46 D10 M80 E46 F10 N80\nM1006 A44 B20 L100 C39 D20 M60 E48 F20 N60\nM1006 A0 B10 L100 C44 D10 M60 E44 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A0 B10 L100 C39 D10 M60 E39 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A0 B10 L100 C44 D10 M60 E44 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A0 B10 L100 C39 D10 M60 E39 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A0 B10 L100 C48 D10 M60 E44 F10 N80\nM1006 A0 B10 L100 C0 D10 M60 E0 F10  N80\nM1006 A44 B20 L100 C49 D20 M80 E41 F20 N80\nM1006 A0 B20 L100 C0 D20 M60 E0 F20 N80\nM1006 A0 B20 L100 C37 D20 M30 E37 F20 N60\nM1006 W\n;=====printer finish  sound=========\n\n;M17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power\nM400\nM18 X Y Z\n\n
; machine_hotend_change_time = 0
; machine_load_filament_time = 25
; machine_max_acceleration_e = 5000,5000
; machine_max_acceleration_extruding = 12000,12000
; machine_max_acceleration_retracting = 5000,5000
; machine_max_acceleration_travel = 9000,9000
; machine_max_acceleration_x = 12000,12000
; machine_max_acceleration_y = 12000,12000
; machine_max_acceleration_z = 1500,1500
; machine_max_force_Y = 0
; machine_max_jerk_e = 3,3
; machine_max_jerk_x = 9,9
; machine_max_jerk_y = 9,9
; machine_max_jerk_z = 3,3
; machine_max_printed_mass = 0
; machine_max_speed_e = 30,30
; machine_max_speed_x = 500,200
; machine_max_speed_y = 500,200
; machine_max_speed_z = 30,30
; machine_min_extruding_rate = 0,0
; machine_min_travel_rate = 0,0
; machine_pause_gcode = M400 U1
; machine_prepare_compensation_time = 260
; machine_start_gcode = ;===== machine: A1 =========================\n;===== date: 20260513 ==================\nG392 S0\nM9833.2\n;M400\n;M73 P1.717\n\n;===== start to heat heatbead&hotend==========\nM1002 gcode_claim_action : 2\nM1002 set_filament_type:{filament_type[initial_no_support_extruder]}\nM104 S140\nM140 S[bed_temperature_initial_layer_single]\n\n;=====start printer sound ===================\nM17\nM400 S1\nM1006 S1\nM1006 A0 B10 L100 C37 D10 M60 E37 F10 N60\nM1006 A0 B10 L100 C41 D10 M60 E41 F10 N60\nM1006 A0 B10 L100 C44 D10 M60 E44 F10 N60\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N60\nM1006 A43 B10 L100 C46 D10 M70 E39 F10 N80\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N80\nM1006 A0 B10 L100 C43 D10 M60 E39 F10 N80\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N80\nM1006 A0 B10 L100 C41 D10 M80 E41 F10 N80\nM1006 A0 B10 L100 C44 D10 M80 E44 F10 N80\nM1006 A0 B10 L100 C49 D10 M80 E49 F10 N80\nM1006 A0 B10 L100 C0 D10 M80 E0 F10 N80\nM1006 A44 B10 L100 C48 D10 M60 E39 F10 N80\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N80\nM1006 A0 B10 L100 C44 D10 M80 E39 F10 N80\nM1006 A0 B10 L100 C0 D10 M60 E0 F10 N80\nM1006 A43 B10 L100 C46 D10 M60 E39 F10 N80\nM1006 W\nM18 \n;=====start printer sound ===================\n\n;=====avoid end stop =================\nG91\nG380 S2 Z40 F1200\nG380 S3 Z-15 F1200\nG90\n\n;===== reset machine status =================\n;M290 X39 Y39 Z8\nM204 S6000\n\nM630 S0 P0\nG91\nM17 Z0.3 ; lower the z-motor current\n\nG90\nM17 X0.65 Y1.2 Z0.6 ; reset motor current to default\nM960 S5 P1 ; turn on logo lamp\nG90\nM220 S100 ;Reset Feedrate\nM221 S100 ;Reset Flowrate\nM73.2   R1.0 ;Reset left time magnitude\n;M211 X0 Y0 Z0 ; turn off soft endstop to prevent protential logic problem\n\n;====== cog noise reduction=================\nM982.2 S1 ; turn on cog noise reduction\n\nM1002 gcode_claim_action : 13\n\nG28 X\nG91\nG1 Z5 F1200\nG90\nG0 X128 F30000\nG0 Y254 F3000\nG91\nG1 Z-5 F1200\n\nM109 S25 H140\n\nM17 E0.3\nM83\nG1 E10 F1200\nG1 E-0.5 F30\nM17 D\n\nG28 Z P0 T140; home z with low precision,permit 300deg temperature\nM104 S{nozzle_temperature_initial_layer[initial_extruder]}\n\nM1002 judge_flag build_plate_detect_flag\nM622 S1\n  G39.4\n  G90\n  G1 Z5 F1200\nM623\n\n;M400\n;M73 P1.717\n\n;===== prepare print temperature and material ==========\nM1002 gcode_claim_action : 24\n\nM400\n;G392 S1\nM211 X0 Y0 Z0 ;turn off soft endstop\nM975 S1 ; turn on\n\nG90\nG1 X-28.5 F30000\nG1 X-48.2 F3000\n\nM620 M ;enable remap\nM620 S[initial_no_support_extruder]A   ; switch material if AMS exist\n    M1002 gcode_claim_action : 4\n    M400\n    M1002 set_filament_type:UNKNOWN\n    M109 S[nozzle_temperature_initial_layer]\n{if (filament_type[initial_no_support_extruder] == \"PLA\") && (nozzle_diameter != 0.2)}\n    M104 S220\n{else}\n    M104 S250\n{endif}\n    M400\n    T[initial_no_support_extruder]\n    G1 X-48.2 F3000\n    M400\n\n{if (filament_type[initial_no_support_extruder] == \"PLA\") && (nozzle_diameter != 0.2)}\n    M620.1 E F{flush_volumetric_speeds[initial_no_support_extruder]/2.4053*60} T220\n    M109 S220 ;set nozzle to common flush temp\n{else}\n    M620.1 E F{flush_volumetric_speeds[initial_no_support_extruder]/2.4053*60} T{flush_temperatures[initial_no_support_extruder]}\n    M109 S250 ;set nozzle to common flush temp\n{endif}\n    M106 P1 S0\n    G92 E0\n    G1 E50 F200\n    M400\n    M1002 set_filament_type:{filament_type[initial_no_support_extruder]}\nM621 S[initial_no_support_extruder]A\n\n{if (filament_type[initial_no_support_extruder] == \"PLA\") && (nozzle_diameter != 0.2)}\n    M109 S220 H300\n{else}\n    M109 S{flush_temperatures[initial_no_support_extruder]} H300\n{endif}\nG92 E0\nG1 E50 F200 ; lower extrusion speed to avoid clog\nM400\nM106 P1 S178\nG92 E0\nG1 E5 F200\nM104 S{nozzle_temperature_initial_layer[initial_no_support_extruder]}\nG92 E0\nG1 E-0.5 F300\n\nG1 X-28.5 F30000\nG1 X-48.2 F3000\nG1 X-28.5 F30000 ;wipe and shake\nG1 X-48.2 F3000\nG1 X-28.5 F30000 ;wipe and shake\nG1 X-48.2 F3000\n\n;G392 S0\n\nM400\nM106 P1 S0\n;===== prepare print temperature and material end =====\n\n;M400\n;M73 P1.717\n\n;===== auto extrude cali start =========================\nM975 S1\n;G392 S1\n\nG90\nM83\nT1000\nG1 X-48.2 Y0 Z10 F10000\nM400\nM1002 set_filament_type:UNKNOWN\n\nM412 S1 ;  ===turn on  filament runout detection===\nM400 P10\nM620.3 W1; === turn on filament tangle detection===\nM400 S2\n\nM1002 set_filament_type:{filament_type[initial_no_support_extruder]}\n\n;M1002 set_flag extrude_cali_flag=1\nM1002 judge_flag extrude_cali_flag\n\nM622 J1\n    M1002 gcode_claim_action : 8\n\n    M109 S{nozzle_temperature[initial_extruder]}\n    G1 E10 F{outer_wall_volumetric_speed/2.4*60}\n    M983 F{outer_wall_volumetric_speed/2.4} A0.3 H[nozzle_diameter]; cali dynamic extrusion compensation\n\n    M106 P1 S255\n    M400 S5\n    G1 X-28.5 F18000\n    G1 X-48.2 F3000\n    G1 X-28.5 F18000 ;wipe and shake\n    G1 X-48.2 F3000\n    G1 X-28.5 F12000 ;wipe and shake\n    G1 X-48.2 F3000\n    M400\n    M106 P1 S0\n\n    M1002 judge_last_extrude_cali_success\n    M622 J0\n        M983 F{outer_wall_volumetric_speed/2.4} A0.3 H[nozzle_diameter]; cali dynamic extrusion compensation\n        M106 P1 S255\n        M400 S5\n        G1 X-28.5 F18000\n        G1 X-48.2 F3000\n        G1 X-28.5 F18000 ;wipe and shake\n        G1 X-48.2 F3000\n        G1 X-28.5 F12000 ;wipe and shake\n        M400\n        M106 P1 S0\n    M623\n    \n    G1 X-48.2 F3000\n    M400\n    M984 A0.1 E1 S1 F{outer_wall_volumetric_speed/2.4} H[nozzle_diameter]\n    M106 P1 S178\n    M400 S7\n    G1 X-28.5 F18000\n    G1 X-48.2 F3000\n    G1 X-28.5 F18000 ;wipe and shake\n    G1 X-48.2 F3000\n    G1 X-28.5 F12000 ;wipe and shake\n    G1 X-48.2 F3000\n    M400\n    M106 P1 S0\nM623 ; end of \"draw extrinsic para cali paint\"\n\n;G392 S0\n;===== auto extrude cali end ========================\n\n;M400\n;M73 P1.717\n\nM104 S170 ; prepare to wipe nozzle\nM106 S255 ; turn on fan\n\n;===== mech mode fast check start =====================\nM1002 gcode_claim_action : 3\n\nG1 X128 Y128 F20000\nG1 Z5 F1200\nM400 P200\nM970.3 Q1 A5 K0 O3\nM974 Q1 S2 P0\n\nM970.2 Q1 K1 W58 Z0.1\nM974 S2\n\nG1 X128 Y128 F20000\nG1 Z5 F1200\nM400 P200\nM970.3 Q0 A10 K0 O1\nM974 Q0 S2 P0\n\nM970.2 Q0 K1 W78 Z0.1\nM974 S2\n\nM975 S1\nG1 F30000\nG1 X0 Y5\nG28 X ; re-home XY\n\nG1 Z4 F1200\n\n;===== mech mode fast check end =======================\n\n;M400\n;M73 P1.717\n\n;===== wipe nozzle ===============================\nM1002 gcode_claim_action : 14\n\nM975 S1\nM106 S255 ; turn on fan (G28 has turn off fan)\nM211 S; push soft endstop status\nM211 X0 Y0 Z0 ;turn off Z axis endstop\n\n;===== remove waste by touching start =====\n\nM104 S170 ; set temp down to heatbed acceptable\n\nM83\nG1 E-1 F500\nG90\nM83\n\nM109 S170\nG0 X108 Y-0.5 F30000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X110 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X112 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X114 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X116 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X118 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X120 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X122 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X124 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X126 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X128 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X130 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X132 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X134 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X136 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X138 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X140 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X142 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X144 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X146 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X148 F10000\nG380 S3 Z-5 F1200\n\nG1 Z5 F30000\n;===== remove waste by touching end =====\n\nG1 Z10 F1200\nG0 X118 Y261 F30000\nG1 Z5 F1200\nM109 S{nozzle_temperature_initial_layer[initial_extruder]-50}\n\nG28 Z P0 T300; home z with low precision,permit 300deg temperature\nG29.2 S0 ; turn off ABL\nM104 S140 ; prepare to abl\nG0 Z5 F20000\n\nG0 X128 Y261 F20000  ; move to exposed steel surface\nG0 Z-1.01 F1200      ; stop the nozzle\n\nG91\nG2 I1 J0 X2 Y0 F2000.1\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\n\nG90\nG1 Z10 F1200\n\n;===== brush material wipe nozzle =====\n\nG90\nG1 Y250 F30000\nG1 X55\nG1 Z1.300 F1200\nG1 Y262.5 F6000\nG91\nG1 X-35 F30000\nG1 Y-0.5\nG1 X45\nG1 Y-0.5\nG1 X-45\nG1 Y-0.5\nG1 X45\nG1 Y-0.5\nG1 X-45\nG1 Y-0.5\nG1 X45\nG1 Z5.000 F1200\n\nG90\nG1 X30 Y250.000 F30000\nG1 Z1.300 F1200\nG1 Y262.5 F6000\nG91\nG1 X35 F30000\nG1 Y-0.5\nG1 X-45\nG1 Y-0.5\nG1 X45\nG1 Y-0.5\nG1 X-45\nG1 Y-0.5\nG1 X45\nG1 Y-0.5\nG1 X-45\nG1 Z10.000 F1200\n\n;===== brush material wipe nozzle end =====\n\nG90\n;G0 X128 Y261 F20000  ; move to exposed steel surface\nG1 Y250 F30000\nG1 X138\nG1 Y261\nG0 Z-1.01 F1200      ; stop the nozzle\n\nG91\nG2 I1 J0 X2 Y0 F2000.1\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\n\nM109 S140\nM106 S255 ; turn on fan (G28 has turn off fan)\n\nM211 R; pop softend status\n\n;===== wipe nozzle end ================================\n\n;M400\n;M73 P1.717\n\n;===== bed leveling ==================================\nM1002 judge_flag g29_before_print_flag\n\nG90\nG1 Z5 F1200\nG1 X0 Y0 F30000\nG29.2 S1 ; turn on ABL\n\nM190 S[bed_temperature_initial_layer_single]; ensure bed temp\nM109 S140\nM106 S0 ; turn off fan , too noisy\n\nM622 J1\n    M1002 gcode_claim_action : 1\n    G29 A1 X{first_layer_print_min[0]} Y{first_layer_print_min[1]} I{first_layer_print_size[0]} J{first_layer_print_size[1]}\n    M400\n    M500 ; save cali data\nM623\n;===== bed leveling end ================================\n\n;===== home after wipe mouth============================\nM1002 judge_flag g29_before_print_flag\nM622 J0\n\n    M1002 gcode_claim_action : 13\n    G28\n\nM623\n\n;===== home after wipe mouth end =======================\n\n;M400\n;M73 P1.717\n\nG1 X108.000 Y-0.500 F30000\nG1 Z0.300 F1200\nM400\nG2814 Z0.32\n\nM104 S{nozzle_temperature_initial_layer[initial_extruder]} ; prepare to print\n\n;===== nozzle load line ===============================\n;G90\n;M83\n;G1 Z5 F1200\n;G1 X88 Y-0.5 F20000\n;G1 Z0.3 F1200\n\n;M109 S{nozzle_temperature_initial_layer[initial_extruder]}\n\n;G1 E2 F300\n;G1 X168 E4.989 F6000\n;G1 Z1 F1200\n;===== nozzle load line end ===========================\n\n;===== extrude cali test ===============================\n\nM400\n    M900 S\n    M900 C\n    G90\n    M83\n\n    M109 S{nozzle_temperature_initial_layer[initial_extruder]}\n    G0 X128 E8  F{outer_wall_volumetric_speed/(24/20)    * 60}\n    G0 X133 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\n    G0 X138 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\n    G0 X143 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\n    G0 X148 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\n    G0 X153 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\n    G91\n    G1 X1 Z-0.300\n    G1 X4\n    G1 Z1 F1200\n    G90\n    M400\n\nM900 R\n\nM1002 judge_flag extrude_cali_flag\nM622 J1\n    G90\n    G1 X108.000 Y1.000 F30000\n    G91\n    G1 Z-0.700 F1200\n    G90\n    M83\n    G0 X128 E10  F{outer_wall_volumetric_speed/(24/20)    * 60}\n    G0 X133 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\n    G0 X138 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\n    G0 X143 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\n    G0 X148 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\n    G0 X153 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\n    G91\n    G1 X1 Z-0.300\n    G1 X4\n    G1 Z1 F1200\n    G90\n    M400\nM623\n\nG1 Z0.2\n\n;M400\n;M73 P1.717\n\n;========turn off light and wait extrude temperature =============\nM1002 gcode_claim_action : 0\nM400\n\n;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==\n;curr_bed_type={curr_bed_type}\n{if curr_bed_type==\"Textured PEI Plate\"}\nG29.1 Z{-0.02} ; for Textured PEI Plate\n{endif}\n\nM960 S1 P0 ; turn off laser\nM960 S2 P0 ; turn off laser\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off big fan\nM106 P3 S0 ; turn off chamber fan\n\nM975 S1 ; turn on mech mode supression\nG90\nM83\nT1000\n\nM211 X0 Y0 Z0 ;turn off soft endstop\n;G392 S1 ; turn on clog detection\nM1007 S1 ; turn on mass estimation\nG29.4\n
; machine_switch_extruder_time = 0
; machine_unload_filament_time = 29
; master_extruder_id = 1
; max_bridge_length = 0
; max_layer_height = 0.28
; max_travel_detour_distance = 0
; min_bead_width = 85%
; min_feature_size = 25%
; min_layer_height = 0.08
; minimum_sparse_infill_area = 15
; mmu_segmented_region_interlocking_depth = 0
; mmu_segmented_region_max_width = 0
; monotonic_travel_into_wall = 0%
; no_slow_down_for_cooling_on_outwalls = 0
; nozzle_diameter = 0.4
; nozzle_flush_dataset = 0
; nozzle_height = 4.76
; nozzle_temperature = 230
; nozzle_temperature_initial_layer = 230
; nozzle_temperature_range_high = 240
; nozzle_temperature_range_low = 220
; nozzle_type = stainless_steel
; nozzle_volume = 92
; nozzle_volume_type = Standard
; only_one_wall_first_layer = 0
; ooze_prevention = 0
; other_layers_print_sequence = 0
; other_layers_print_sequence_nums = 0
; outer_wall_acceleration = 750
; outer_wall_jerk = 9
; outer_wall_line_width = 0.42
; outer_wall_speed = 150
; overhang_1_4_speed = 0
; overhang_2_4_speed = 50
; overhang_3_4_speed = 30
; overhang_4_4_speed = 10
; overhang_fan_speed = 90
; overhang_fan_threshold = 10%
; overhang_threshold_participating_cooling = 95%
; overhang_totally_speed = 10
; override_filament_scarf_seam_setting = 0
; override_process_overhang_speed = 0
; physical_extruder_map = 0
; post_process = 
; pre_start_fan_time = 0
; precise_outer_wall = 0
; precise_z_height = 0
; pressure_advance = 0.02
; prime_tower_brim_width = 3
; prime_tower_enable_framework = 0
; prime_tower_extra_rib_length = 0
; prime_tower_fillet_wall = 1
; prime_tower_flat_ironing = 0
; prime_tower_infill_gap = 150%
; prime_tower_lift_height = -1
; prime_tower_lift_speed = 90
; prime_tower_max_speed = 90
; prime_tower_rib_wall = 1
; prime_tower_rib_width = 8
; prime_tower_skip_points = 1
; prime_tower_width = 35
; prime_volume_mode = Default
; print_compatible_printers = "Bambu Lab A1 0.4 nozzle"
; print_extruder_id = 1
; print_extruder_variant = "Direct Drive Standard"
; print_flow_ratio = 1
; print_in_clockwise = 0
; print_sequence = by layer
; print_settings_id = 0.20mm Standard @BBL A1
; printable_area = 0x0,256x0,256x256,0x256
; printable_height = 256
; printer_extruder_id = 1
; printer_extruder_variant = "Direct Drive Standard"
; printer_model = Bambu Lab A1
; printer_notes = 
; printer_settings_id = Bambu Lab A1 0.4 nozzle
; printer_structure = i3
; printer_technology = FFF
; printer_variant = 0.4
; printhost_authorization_type = key
; printhost_ssl_ignore_revoke = 0
; printing_by_object_gcode = 
; process_notes = 
; raft_contact_distance = 0.1
; raft_expansion = 1.5
; raft_first_layer_density = 90%
; raft_first_layer_expansion = -1
; raft_layers = 0
; reduce_crossing_wall = 0
; reduce_fan_stop_start_freq = 1
; reduce_infill_retraction_mode = Auto
; required_nozzle_HRC = 3
; resolution = 0.012
; retract_before_wipe = 0%
; retract_length_toolchange = 2
; retract_lift_above = 0
; retract_lift_below = 255
; retract_restart_extra = 0
; retract_restart_extra_toolchange = 0
; retract_when_changing_layer = 1
; retraction_distances_when_cut = 18
; retraction_distances_when_ec = 0
; retraction_length = 0.8
; retraction_minimum_travel = 1
; retraction_speed = 30
; role_base_wipe_speed = 1
; scan_first_layer = 0
; scarf_angle_threshold = 155
; seam_gap = 15%
; seam_placement_away_from_overhangs = 0
; seam_position = aligned
; seam_slope_conditional = 1
; seam_slope_entire_loop = 0
; seam_slope_gap = 0
; seam_slope_inner_walls = 1
; seam_slope_min_length = 10
; seam_slope_start_height = 10%
; seam_slope_steps = 10
; seam_slope_type = none
; silent_mode = 0
; single_extruder_multi_material = 1
; skeleton_infill_density = 15%
; skeleton_infill_line_width = 0.45
; skin_infill_density = 15%
; skin_infill_depth = 2
; skin_infill_line_width = 0.45
; skirt_distance = 2
; skirt_height = 1
; skirt_loops = 0
; skirt_per_object = 1
; slice_closing_radius = 0.049
; slicing_mode = regular
; slow_down_for_layer_cooling = 1
; slow_down_layer_time = 12
; slow_down_min_speed = 20
; slowdown_end_acc = 100000
; slowdown_end_height = 400
; slowdown_end_speed = 1000
; slowdown_start_acc = 100000
; slowdown_start_height = 0
; slowdown_start_speed = 1000
; small_perimeter_speed = 50%
; small_perimeter_threshold = 0
; smooth_coefficient = 80
; smooth_speed_discontinuity_area = 1
; solid_infill_filament = 0
; sparse_infill_acceleration = 100%
; sparse_infill_anchor = 400%
; sparse_infill_anchor_max = 20
; sparse_infill_density = 15%
; sparse_infill_filament = 0
; sparse_infill_lattice_angle_1 = -45
; sparse_infill_lattice_angle_2 = 45
; sparse_infill_line_width = 0.45
; sparse_infill_pattern = grid
; sparse_infill_speed = 150
; spiral_mode = 0
; spiral_mode_max_xy_smoothing = 200%
; spiral_mode_smooth = 0
; standby_temperature_delta = -5
; start_end_points = 30x-3,54x245
; supertack_plate_temp = 80
; supertack_plate_temp_initial_layer = 80
; support_air_filtration = 0
; support_angle = 0
; support_base_pattern = default
; support_base_pattern_spacing = 2.5
; support_bottom_interface_spacing = 0.5
; support_bottom_z_distance = 0.2
; support_chamber_temp_control = 0
; support_cooling_filter = 0
; support_critical_regions_only = 0
; support_expansion = 0
; support_fast_purge_mode = 0
; support_filament = 0
; support_interface_bottom_layers = 2
; support_interface_filament = 0
; support_interface_loop_pattern = 0
; support_interface_not_for_body = 1
; support_interface_pattern = auto
; support_interface_spacing = 0.5
; support_interface_speed = 80
; support_interface_top_layers = 2
; support_ironing_direction = 0
; support_ironing_flow = 10%
; support_ironing_inset = 0
; support_ironing_pattern = zig-zag
; support_ironing_spacing = 0.15
; support_ironing_speed = 30
; support_line_width = 0.42
; support_object_first_layer_gap = 0.2
; support_object_skip_flush = 0
; support_object_xy_distance = 0.35
; support_on_build_plate_only = 0
; support_remove_small_overhang = 1
; support_speed = 150
; support_style = default
; support_threshold_angle = 30
; support_top_z_distance = 0.2
; support_type = tree(auto)
; symmetric_infill_y_axis = 0
; temperature_vitrification = 70
; template_custom_gcode = 
; textured_plate_temp = 80
; textured_plate_temp_initial_layer = 80
; thick_bridges = 0
; thumbnail_size = 50x50
; time_lapse_gcode = ;===================== date: 20250206 =====================\n{if !spiral_mode && print_sequence != \"by object\"}\n; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer\n; SKIPPABLE_START\n; SKIPTYPE: timelapse\nM622.1 S1 ; for prev firmware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\nG92 E0\nG1 Z{max_layer_z + 0.4}\nG1 X0 Y{first_layer_center_no_wipe_tower[1]} F18000 ; move to safe pos\nG1 X-48.2 F3000 ; move to safe pos\nM400\nM1004 S5 P1  ; external shutter\nM400 P300\nM971 S11 C11 O0\nG92 E0\nG1 X0 F18000\nM623\n\n; SKIPTYPE: head_wrap_detect\nM622.1 S1\nM1002 judge_flag g39_3rd_layer_detect_flag\nM622 J1\n    ; enable nozzle clog detect at 3rd layer\n    {if layer_num == 2}\n      M400\n      G90\n      M83\n      M204 S5000\n      G0 Z2 F4000\n      G0 X261 Y250 F20000\n      M400 P200\n      G39 S1\n      G0 Z2 F4000\n    {endif}\n\n\n    M622.1 S1\n    M1002 judge_flag g39_detection_flag\n    M622 J1\n      {if !in_head_wrap_detect_zone}\n        M622.1 S0\n        M1002 judge_flag g39_mass_exceed_flag\n        M622 J1\n        {if layer_num > 2}\n            G392 S0\n            M400\n            G90\n            M83\n            M204 S5000\n            G0 Z{max_layer_z + 0.4} F4000\n            G39.3 S1\n            G0 Z{max_layer_z + 0.4} F4000\n            G392 S0\n          {endif}\n        M623\n    {endif}\n    M623\nM623\n; SKIPPABLE_END\n{endif}\n
; timelapse_type = 0
; top_area_threshold = 200%
; top_color_penetration_layers = 5
; top_one_wall_type = all top
; top_shell_layers = 5
; top_shell_thickness = 1
; top_solid_infill_flow_ratio = 1
; top_surface_acceleration = 500
; top_surface_density = 100%
; top_surface_jerk = 9
; top_surface_line_width = 0.42
; top_surface_pattern = monotonicline
; top_surface_speed = 150
; top_z_overrides_xy_distance = 0
; travel_acceleration = 750
; travel_jerk = 9
; travel_short_distance_acceleration = 250
; travel_speed = 150
; travel_speed_z = 0
; tree_support_branch_angle = 45
; tree_support_branch_diameter = 2
; tree_support_branch_diameter_angle = 5
; tree_support_branch_distance = 5
; tree_support_wall_count = -1
; upward_compatible_machine = "Bambu Lab H2D 0.4 nozzle";"Bambu Lab H2D Pro 0.4 nozzle";"Bambu Lab H2S 0.4 nozzle";"Bambu Lab P2S 0.4 nozzle";"Bambu Lab H2C 0.4 nozzle";"Bambu Lab X2D 0.4 nozzle";"Bambu Lab A2L 0.4 nozzle"
; use_firmware_retraction = 0
; use_relative_e_distances = 1
; vertical_shell_speed = 80%
; volumetric_speed_coefficients = "0 0 0 0 0 0"
; wall_distribution_count = 1
; wall_filament = 0
; wall_generator = classic
; wall_loops = 4
; wall_sequence = inner wall/outer wall
; wall_transition_angle = 10
; wall_transition_filter_deviation = 25%
; wall_transition_length = 100%
; wipe = 1
; wipe_distance = 2
; wipe_speed = 80%
; wipe_tower_no_sparse_layers = 0
; wipe_tower_rotation_angle = 0
; wipe_tower_x = 15
; wipe_tower_y = 216.972
; wrapping_detection_gcode = 
; wrapping_detection_layers = 20
; wrapping_exclude_area = 
; xy_contour_compensation = 0
; xy_hole_compensation = 0
; z_direction_outwall_speed_continuous = 0
; z_hop = 0.4
; z_hop_types = Auto Lift
; CONFIG_BLOCK_END

; EXECUTABLE_BLOCK_START
M73 P0 R20
M201 X12000 Y12000 Z1500 E5000
M203 X500 Y500 Z30 E30
M204 P12000 R5000 T12000
M205 X9.00 Y9.00 Z3.00 E3.00
M106 S0
; FEATURE: Custom
;===== machine: A1 =========================
;===== date: 20260513 ==================
G392 S0
M9833.2
;M400
;M73 P1.717

;===== start to heat heatbead&hotend==========
M1002 gcode_claim_action : 2
M1002 set_filament_type:PETG
M104 S140
M140 S80

;=====start printer sound ===================
M17
M400 S1
M1006 S1
M1006 A0 B10 L100 C37 D10 M60 E37 F10 N60
M1006 A0 B10 L100 C41 D10 M60 E41 F10 N60
M1006 A0 B10 L100 C44 D10 M60 E44 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A43 B10 L100 C46 D10 M70 E39 F10 N80
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N80
M1006 A0 B10 L100 C43 D10 M60 E39 F10 N80
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N80
M1006 A0 B10 L100 C41 D10 M80 E41 F10 N80
M1006 A0 B10 L100 C44 D10 M80 E44 F10 N80
M1006 A0 B10 L100 C49 D10 M80 E49 F10 N80
M1006 A0 B10 L100 C0 D10 M80 E0 F10 N80
M1006 A44 B10 L100 C48 D10 M60 E39 F10 N80
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N80
M1006 A0 B10 L100 C44 D10 M80 E39 F10 N80
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N80
M1006 A43 B10 L100 C46 D10 M60 E39 F10 N80
M1006 W
M18 
;=====start printer sound ===================

;=====avoid end stop =================
G91
G380 S2 Z40 F1200
G380 S3 Z-15 F1200
G90

;===== reset machine status =================
;M290 X39 Y39 Z8
M204 S6000

M630 S0 P0
G91
M17 Z0.3 ; lower the z-motor current

G90
M17 X0.65 Y1.2 Z0.6 ; reset motor current to default
M960 S5 P1 ; turn on logo lamp
G90
M220 S100 ;Reset Feedrate
M221 S100 ;Reset Flowrate
M73.2   R1.0 ;Reset left time magnitude
;M211 X0 Y0 Z0 ; turn off soft endstop to prevent protential logic problem

;====== cog noise reduction=================
M982.2 S1 ; turn on cog noise reduction

M1002 gcode_claim_action : 13

G28 X
G91
G1 Z5 F1200
G90
G0 X128 F30000
G0 Y254 F3000
G91
G1 Z-5 F1200

M109 S25 H140

M17 E0.3
M83
G1 E10 F1200
G1 E-0.5 F30
M17 D

G28 Z P0 T140; home z with low precision,permit 300deg temperature
M104 S230

M1002 judge_flag build_plate_detect_flag
M622 S1
  G39.4
  G90
  G1 Z5 F1200
M623

;M400
;M73 P1.717

;===== prepare print temperature and material ==========
M1002 gcode_claim_action : 24

M400
;G392 S1
M211 X0 Y0 Z0 ;turn off soft endstop
M975 S1 ; turn on

G90
G1 X-28.5 F30000
G1 X-48.2 F3000

M620 M ;enable remap
M620 S0A   ; switch material if AMS exist
    M1002 gcode_claim_action : 4
    M400
    M1002 set_filament_type:UNKNOWN
    M109 S230

    M104 S250

    M400
    T0
    G1 X-48.2 F3000
    M400


    M620.1 E F199.559 T240
    M109 S250 ;set nozzle to common flush temp

    M106 P1 S0
    G92 E0
    G1 E50 F200
    M400
    M1002 set_filament_type:PETG
M621 S0A


    M109 S240 H300

G92 E0
G1 E50 F200 ; lower extrusion speed to avoid clog
M400
M106 P1 S178
G92 E0
G1 E5 F200
M104 S230
G92 E0
M73 P2 R19
G1 E-0.5 F300

G1 X-28.5 F30000
M73 P4 R19
G1 X-48.2 F3000
M73 P5 R19
G1 X-28.5 F30000 ;wipe and shake
G1 X-48.2 F3000
G1 X-28.5 F30000 ;wipe and shake
G1 X-48.2 F3000

;G392 S0

M400
M106 P1 S0
;===== prepare print temperature and material end =====

;M400
;M73 P1.717

;===== auto extrude cali start =========================
M975 S1
;G392 S1

G90
M83
T1000
G1 X-48.2 Y0 Z10 F10000
M400
M1002 set_filament_type:UNKNOWN

M412 S1 ;  ===turn on  filament runout detection===
M400 P10
M620.3 W1; === turn on filament tangle detection===
M400 S2

M1002 set_filament_type:PETG

;M1002 set_flag extrude_cali_flag=1
M1002 judge_flag extrude_cali_flag

M622 J1
    M1002 gcode_claim_action : 8

    M109 S230
    G1 E10 F200
    M983 F3.33333 A0.3 H0.4; cali dynamic extrusion compensation

    M106 P1 S255
    M400 S5
    G1 X-28.5 F18000
    G1 X-48.2 F3000
    G1 X-28.5 F18000 ;wipe and shake
    G1 X-48.2 F3000
M73 P6 R18
    G1 X-28.5 F12000 ;wipe and shake
    G1 X-48.2 F3000
    M400
    M106 P1 S0

    M1002 judge_last_extrude_cali_success
    M622 J0
        M983 F3.33333 A0.3 H0.4; cali dynamic extrusion compensation
        M106 P1 S255
        M400 S5
        G1 X-28.5 F18000
        G1 X-48.2 F3000
M73 P7 R18
        G1 X-28.5 F18000 ;wipe and shake
        G1 X-48.2 F3000
        G1 X-28.5 F12000 ;wipe and shake
        M400
        M106 P1 S0
    M623
    
    G1 X-48.2 F3000
    M400
    M984 A0.1 E1 S1 F3.33333 H0.4
    M106 P1 S178
    M400 S7
    G1 X-28.5 F18000
    G1 X-48.2 F3000
    G1 X-28.5 F18000 ;wipe and shake
    G1 X-48.2 F3000
    G1 X-28.5 F12000 ;wipe and shake
    G1 X-48.2 F3000
    M400
    M106 P1 S0
M623 ; end of "draw extrinsic para cali paint"

;G392 S0
;===== auto extrude cali end ========================

;M400
;M73 P1.717

M104 S170 ; prepare to wipe nozzle
M106 S255 ; turn on fan

;===== mech mode fast check start =====================
M1002 gcode_claim_action : 3

G1 X128 Y128 F20000
G1 Z5 F1200
M400 P200
M970.3 Q1 A5 K0 O3
M974 Q1 S2 P0

M970.2 Q1 K1 W58 Z0.1
M974 S2

G1 X128 Y128 F20000
G1 Z5 F1200
M400 P200
M970.3 Q0 A10 K0 O1
M974 Q0 S2 P0

M970.2 Q0 K1 W78 Z0.1
M974 S2

M975 S1
G1 F30000
G1 X0 Y5
G28 X ; re-home XY

M73 P8 R18
G1 Z4 F1200

;===== mech mode fast check end =======================

;M400
;M73 P1.717

;===== wipe nozzle ===============================
M1002 gcode_claim_action : 14

M975 S1
M106 S255 ; turn on fan (G28 has turn off fan)
M211 S; push soft endstop status
M211 X0 Y0 Z0 ;turn off Z axis endstop

;===== remove waste by touching start =====

M104 S170 ; set temp down to heatbed acceptable

M83
G1 E-1 F500
G90
M83

M109 S170
G0 X108 Y-0.5 F30000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X110 F10000
G380 S3 Z-5 F1200
M73 P29 R14
G1 Z2 F1200
G1 X112 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X114 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X116 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X118 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X120 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X122 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X124 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X126 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X128 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X130 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X132 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X134 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X136 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X138 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X140 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X142 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X144 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X146 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X148 F10000
G380 S3 Z-5 F1200

G1 Z5 F30000
;===== remove waste by touching end =====

G1 Z10 F1200
G0 X118 Y261 F30000
G1 Z5 F1200
M109 S180

G28 Z P0 T300; home z with low precision,permit 300deg temperature
G29.2 S0 ; turn off ABL
M104 S140 ; prepare to abl
G0 Z5 F20000

G0 X128 Y261 F20000  ; move to exposed steel surface
G0 Z-1.01 F1200      ; stop the nozzle

G91
G2 I1 J0 X2 Y0 F2000.1
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5

G90
G1 Z10 F1200

;===== brush material wipe nozzle =====

G90
G1 Y250 F30000
G1 X55
G1 Z1.300 F1200
G1 Y262.5 F6000
G91
G1 X-35 F30000
G1 Y-0.5
G1 X45
G1 Y-0.5
G1 X-45
G1 Y-0.5
G1 X45
G1 Y-0.5
G1 X-45
G1 Y-0.5
G1 X45
M73 P30 R14
G1 Z5.000 F1200

G90
G1 X30 Y250.000 F30000
G1 Z1.300 F1200
G1 Y262.5 F6000
G91
G1 X35 F30000
G1 Y-0.5
G1 X-45
G1 Y-0.5
G1 X45
G1 Y-0.5
G1 X-45
G1 Y-0.5
G1 X45
G1 Y-0.5
G1 X-45
G1 Z10.000 F1200

;===== brush material wipe nozzle end =====

G90
;G0 X128 Y261 F20000  ; move to exposed steel surface
G1 Y250 F30000
G1 X138
G1 Y261
G0 Z-1.01 F1200      ; stop the nozzle

G91
G2 I1 J0 X2 Y0 F2000.1
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5

M109 S140
M106 S255 ; turn on fan (G28 has turn off fan)

M211 R; pop softend status

;===== wipe nozzle end ================================

;M400
;M73 P1.717

;===== bed leveling ==================================
M1002 judge_flag g29_before_print_flag

G90
G1 Z5 F1200
G1 X0 Y0 F30000
G29.2 S1 ; turn on ABL

M190 S80; ensure bed temp
M109 S140
M106 S0 ; turn off fan , too noisy

M622 J1
    M1002 gcode_claim_action : 1
    G29 A1 X97.0067 Y118.001 I40.991 J19.9978
    M400
    M500 ; save cali data
M623
;===== bed leveling end ================================

;===== home after wipe mouth============================
M1002 judge_flag g29_before_print_flag
M622 J0

    M1002 gcode_claim_action : 13
    G28

M623

;===== home after wipe mouth end =======================

;M400
;M73 P1.717

G1 X108.000 Y-0.500 F30000
G1 Z0.300 F1200
M400
G2814 Z0.32

M104 S230 ; prepare to print

;===== nozzle load line ===============================
;G90
;M83
;G1 Z5 F1200
;G1 X88 Y-0.5 F20000
;G1 Z0.3 F1200

;M109 S230

;G1 E2 F300
;G1 X168 E4.989 F6000
;G1 Z1 F1200
;===== nozzle load line end ===========================

;===== extrude cali test ===============================

M400
    M900 S
    M900 C
    G90
    M83

    M109 S230
    G0 X128 E8  F480
    G0 X133 E.3742  F800
    G0 X138 E.3742  F3200
    G0 X143 E.3742  F800
    G0 X148 E.3742  F3200
    G0 X153 E.3742  F800
    G91
    G1 X1 Z-0.300
    G1 X4
    G1 Z1 F1200
    G90
    M400

M900 R

M1002 judge_flag extrude_cali_flag
M622 J1
    G90
    G1 X108.000 Y1.000 F30000
    G91
    G1 Z-0.700 F1200
    G90
    M83
    G0 X128 E10  F480
    G0 X133 E.3742  F800
    G0 X138 E.3742  F3200
    G0 X143 E.3742  F800
    G0 X148 E.3742  F3200
    G0 X153 E.3742  F800
    G91
    G1 X1 Z-0.300
    G1 X4
    G1 Z1 F1200
    G90
    M400
M623

G1 Z0.2

;M400
;M73 P1.717

;========turn off light and wait extrude temperature =============
M1002 gcode_claim_action : 0
M400

;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==
;curr_bed_type=Textured PEI Plate

G29.1 Z-0.02 ; for Textured PEI Plate


M960 S1 P0 ; turn off laser
M960 S2 P0 ; turn off laser
M106 S0 ; turn off fan
M106 P2 S0 ; turn off big fan
M106 P3 S0 ; turn off chamber fan

M975 S1 ; turn on mech mode supression
G90
M83
T1000

M211 X0 Y0 Z0 ;turn off soft endstop
;G392 S1 ; turn on clog detection
M1007 S1 ; turn on mass estimation
G29.4
; MACHINE_START_GCODE_END
; filament start gcode
M106 P3 S180


;VT0 H-1
G90
G21
M83 ; use relative distances for extrusion
M981 S1 P20000 ;open spaghetti detector
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; LAYER_HEIGHT: 0.2
G1 E-.8 F1800
; layer num/total_layer_count: 1/23
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X128.686 Y136.691 F9000
M204 S500
G1 Z.4
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.5
M73 P30 R13
G1 F3000
G1 X128.418 Y136.773 E.0101
G3 X127.723 Y133.195 I-.423 J-1.774 E.2124
G1 X127.99 Y133.175 E.00964
G3 X128.739 Y136.664 I.006 J1.824 E.17945
; WIPE_START
G1 X128.418 Y136.773 E-.12864
G1 X128.142 Y136.821 E-.10656
M73 P31 R13
G1 X127.862 Y136.821 E-.10622
G1 X127.586 Y136.778 E-.10623
G1 X127.32 Y136.694 E-.10624
G1 X127.069 Y136.57 E-.10621
G1 X126.854 Y136.418 E-.0999
; WIPE_END
G1 E-.04 F1800
G1 X132.241 Y131.011 Z.6 F9000
G1 X136.404 Y126.831 Z.6
G1 Z.2
G1 E.8 F1800
G1 F3000
G1 X136.406 Y126.843 E.00041
G3 X134.655 Y126.207 I-1.41 J1.156 E.34313
G1 X134.92 Y126.177 E.00964
G3 X136.212 Y126.64 I.076 J1.822 E.05083
G1 X136.362 Y126.789 E.0076
; WIPE_START
G1 X136.406 Y126.843 E-.0264
G1 X136.572 Y127.067 E-.1061
G1 X136.69 Y127.306 E-.1014
G1 X136.78 Y127.583 E-.11053
G1 X136.823 Y127.86 E-.10669
G1 X136.823 Y128.14 E-.10623
G1 X136.78 Y128.416 E-.10624
G1 X136.704 Y128.658 E-.09641
; WIPE_END
G1 E-.04 F1800
G1 X131.839 Y122.776 Z.6 F9000
G1 X129.369 Y119.79 Z.6
G1 Z.2
G1 E.8 F1800
G1 F3000
G1 X129.534 Y120.008 E.00988
G3 X127.861 Y119.179 I-1.532 J.99 E.34307
G1 X128.142 Y119.179 E.01013
G3 X129.328 Y119.746 I-.14 J1.819 E.04855
; WIPE_START
G1 X129.534 Y120.008 E-.12666
G1 X129.668 Y120.253 E-.1062
G1 X129.759 Y120.504 E-.10142
G1 X129.816 Y120.789 E-.11056
G1 X129.827 Y121.07 E-.10665
G1 X129.795 Y121.348 E-.10626
G1 X129.723 Y121.607 E-.10225
; WIPE_END
G1 E-.04 F1800
G1 X125.2 Y126.468 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
G1 X125.393 Y126.165 E.01299
G3 X127.728 Y124.819 I2.615 J1.838 E.10043
G3 X130.666 Y126.239 I.301 J3.127 E.1239
G1 X130.754 Y126.364 E.00553
G1 X130.971 Y126.803 E.01769
G3 X125.144 Y126.585 I-2.963 J1.2 E.46006
G1 X125.174 Y126.522 E.0025
G1 X125.593 Y126.702 F9000
G1 F3000
G1 X125.767 Y126.428 E.01172
G3 X127.78 Y125.273 I2.241 J1.574 E.08652
G3 X130.118 Y126.255 I.213 J2.767 E.0951
G3 X125.554 Y126.788 I-2.109 J1.747 E.42452
G1 X125.568 Y126.756 E.00124
G1 X125.986 Y126.935 F9000
G1 F3000
G1 X126.142 Y126.691 E.01046
G3 X127.832 Y125.727 I1.868 J1.31 E.0726
G3 X129.244 Y126.083 I.158 J2.351 E.05343
G3 X125.964 Y126.991 I-1.234 J1.919 E.37884
G1 X126.378 Y127.169 F9000
; FEATURE: Outer wall
G1 F3000
G1 X126.515 Y126.954 E.00919
G3 X127.885 Y126.181 I1.493 J1.045 E.05871
G3 X128.749 Y126.334 I.13 J1.784 E.03202
G3 X126.359 Y127.225 I-.74 J1.666 E.31151
; WIPE_START
G1 X126.515 Y126.954 E-.11885
G1 X126.687 Y126.734 E-.10605
G1 X126.895 Y126.548 E-.10621
G1 X127.13 Y126.396 E-.10625
G1 X127.385 Y126.282 E-.1062
G1 X127.655 Y126.207 E-.10623
G1 X127.885 Y126.181 E-.08806
G1 X127.943 Y126.182 E-.02215
; WIPE_END
G1 E-.04 F1800
G1 X124.885 Y120.307 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
G2 X131.115 Y120.296 I3.116 J.7 E.41362
G1 X131.716 Y120.574 E.02391
G3 X135.7 Y124.884 I-3.75 J7.462 E.21652
G2 X135.7 Y131.116 I-.703 J3.116 E.41354
G3 X131.117 Y135.704 I-7.77 J-3.179 E.24037
G2 X124.885 Y135.693 I-3.115 J-.71 E.41371
G3 X120.293 Y131.114 I3.235 J-7.837 E.2403
G2 X120.31 Y124.883 I.715 J-3.113 E.41379
G3 X124.83 Y120.329 I7.667 J3.09 E.23789
; WIPE_START
G1 X124.822 Y120.633 E-.1154
G1 X124.803 Y121.122 E-.1862
G1 X124.86 Y121.61 E-.18633
G1 X124.989 Y122.082 E-.18624
G1 X125.082 Y122.288 E-.08584
; WIPE_END
G1 E-.04 F1800
G1 X125.673 Y119.558 Z.6 F9000
G1 Z.2
G1 E.8 F1800
G1 F3000
G2 X130.325 Y119.548 I2.329 J1.444 E.42103
G1 X130.957 Y119.753 E.02398
G3 X136.448 Y125.673 I-2.962 J8.253 E.30297
G2 X136.448 Y130.327 I-1.447 J2.327 E.42092
G3 X130.327 Y136.45 I-8.478 J-2.355 E.32682
G2 X125.673 Y136.442 I-2.324 J-1.451 E.42097
G3 X119.8 Y131.078 I2.322 J-8.44 E.29812
G1 X119.541 Y130.319 E.02896
G2 X119.54 Y125.682 I1.462 J-2.319 E.42229
G3 X121.405 Y122.236 I8.821 J2.546 E.14256
G3 X125.616 Y119.574 I6.583 J5.751 E.1824
; WIPE_START
G1 X125.499 Y119.878 E-.1237
G1 X125.357 Y120.273 E-.15956
M73 P32 R13
G1 X125.278 Y120.685 E-.15954
G1 X125.261 Y121.105 E-.15954
G1 X125.309 Y121.517 E-.15766
; WIPE_END
G1 E-.04 F1800
G1 X129.678 Y119.452 Z.6 F9000
G1 Z.2
G1 E.8 F1800
G1 F3000
G1 X129.453 Y119.241 E.01114
G2 X129.232 Y119.08 I-1.451 J1.761 E.00988
G1 X129.31 Y118.88 E.00778
G3 X137.128 Y126.69 I-1.311 J9.13 E.42781
G1 X136.925 Y126.775 E.00796
G2 X136.925 Y129.225 I-1.925 J1.225 E.4242
G1 X137.128 Y129.31 E.00796
G3 X129.31 Y137.12 I-9.129 J-1.32 E.42781
G1 X129.232 Y136.92 E.00778
G2 X126.772 Y136.919 I-1.229 J-1.922 E.4238
G1 X126.689 Y137.122 E.0079
G3 X118.884 Y129.314 I1.305 J-9.11 E.42749
G1 X119.085 Y129.233 E.00783
G2 X119.084 Y126.768 I1.919 J-1.233 E.42352
G1 X118.883 Y126.687 E.00784
G3 X126.69 Y118.878 I9.113 J1.304 E.42759
G1 X126.774 Y119.08 E.00787
G2 X129.717 Y119.497 I1.229 J1.922 E.40065
; WIPE_START
G1 X129.453 Y119.241 E-.13996
G1 X129.232 Y119.08 E-.10394
G1 X129.31 Y118.88 E-.08185
G1 X130.052 Y119.013 E-.28657
G1 X130.428 Y119.112 E-.14769
; WIPE_END
G1 E-.04 F1800
G1 X125.621 Y125.041 Z.6 F9000
G1 X122.712 Y128.629 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
G1 F3000
G1 X122.631 Y128.806 E.00704
G3 X120.793 Y126.186 I-1.635 J-.808 E.27275
G1 X121.06 Y126.176 E.00964
G3 X122.735 Y128.548 I-.064 J1.823 E.1213
G1 X122.728 Y128.571 E.00087
; WIPE_START
G1 X122.631 Y128.806 E-.09667
G1 X122.496 Y129.051 E-.10603
G1 X122.318 Y129.266 E-.10622
G1 X122.109 Y129.452 E-.10622
G1 X121.874 Y129.604 E-.10626
G1 X121.619 Y129.718 E-.10621
G1 X121.35 Y129.793 E-.10622
G1 X121.281 Y129.8 E-.02618
; WIPE_END
G1 E-.04 F1800
G1 X124.825 Y123.04 Z.6 F9000
G1 X127.279 Y118.357 Z.6
G1 Z.2
G1 E.8 F1800
G1 F3000
G3 X128.162 Y118.331 I.728 J9.696 E.03189
G3 X123.444 Y119.467 I-.167 J9.67 E2.01698
G3 X127.22 Y118.362 I4.564 J8.586 E.14303
; WIPE_START
G1 X128.162 Y118.331 E-.35827
G1 X129.014 Y118.378 E-.32415
G1 X129.216 Y118.406 E-.07758
; WIPE_END
G1 E-.04 F1800
G17
G3 Z.6 I1.217 J0 P1  F9000
; stop printing object, unique label id: 82
M625
; object ids of layer 1 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z0.6
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
        M623
    
    M623
M623
; SKIPPABLE_END


; object ids of this layer1 end: 82,118
M625
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X128.817 Y118.86 F9000
G1 Z.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.513125
G1 F3000
G1 X128.81 Y118.843 E.00067
G1 X128.536 Y118.791 E.01034
; LINE_WIDTH: 0.451222
G2 X127.455 Y118.793 I-.531 J3.832 E.035
; LINE_WIDTH: 0.501307
G1 X127.313 Y118.818 E.0052
; LINE_WIDTH: 0.532457
G1 X127.195 Y118.843 E.00468
; LINE_WIDTH: 0.523748
G1 X127.183 Y118.869 E.00108
; LINE_WIDTH: 0.48196
G1 X127.171 Y118.895 E.00098
; LINE_WIDTH: 0.44607
G1 X127.114 Y119.03 E.00468
; LINE_WIDTH: 0.416064
G1 X127.057 Y119.165 E.00433
G1 X126.211 Y119.215 F9000
; LINE_WIDTH: 0.113854
G1 F3000
G2 X126.087 Y119.33 I.065 J.194 E.00097
; WIPE_START
G1 X126.148 Y119.249 E-.4478
G1 X126.211 Y119.215 E-.3122
; WIPE_END
G1 E-.04 F1800
G1 X124.675 Y121.6 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.5244
G1 F4984.631
G1 X124.16 Y121.085 E.02769
G2 X123.733 Y121.339 I1.809 J3.525 E.01891
G1 X124.635 Y122.242 E.04854
M73 P33 R13
G2 X126.721 Y124.342 I3.313 J-1.204 E.11619
G1 X126.668 Y124.361 E.00215
G1 X126.765 Y124.631 E.0109
G1 X126.474 Y124.761 E.0121
G1 X123.329 Y121.616 E.16917
G2 X122.947 Y121.915 I2.306 J3.348 E.01846
G1 X126.038 Y125.006 E.16629
G2 X125.651 Y125.3 I.756 J1.401 E.01856
G1 X122.585 Y122.234 E.16489
G2 X122.245 Y122.575 I2.671 J3.015 E.01832
G1 X125.309 Y125.639 E.16482
G2 X125.012 Y126.023 I1.095 J1.152 E.01854
G1 X121.925 Y122.936 E.16608
G2 X121.626 Y123.318 I3.041 J2.687 E.01846
G1 X124.764 Y126.456 E.16882
G1 X124.589 Y126.892 E.01789
G1 X124.488 Y126.861 E.00402
G1 X124.346 Y126.719 E.00764
G1 X124.22 Y126.407 E.01279
G2 X122.274 Y124.646 I-3.297 J1.69 E.10202
G1 X121.348 Y123.721 E.04978
G2 X121.093 Y124.147 I3.424 J2.342 E.01889
G1 X121.62 Y124.673 E.02833
; WIPE_START
G1 X121.093 Y124.147 E-.28303
G1 X121.348 Y123.721 E-.18861
G1 X121.885 Y124.258 E-.28836
; WIPE_END
G1 E-.04 F1800
G1 X119.332 Y126.084 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.11365
G1 F3000
G2 X119.22 Y126.206 I.076 J.183 E.00095
G1 X119.17 Y127.049 F9000
; LINE_WIDTH: 0.451678
G1 F3000
G1 X119.022 Y127.112 E.00519
; LINE_WIDTH: 0.482673
G1 X118.875 Y127.176 E.00558
; LINE_WIDTH: 0.518408
G1 X118.847 Y127.189 E.00115
G1 X118.8 Y127.421 E.00887
; LINE_WIDTH: 0.482768
G1 X118.788 Y127.499 E.00275
; LINE_WIDTH: 0.449639
G2 X118.792 Y128.535 I3.831 J.504 E.03338
; LINE_WIDTH: 0.484588
G1 X118.795 Y128.552 E.0006
; LINE_WIDTH: 0.50133
G1 X118.821 Y128.682 E.00481
; LINE_WIDTH: 0.524265
G1 X118.847 Y128.812 E.00505
G1 X118.891 Y128.833 E.00186
; LINE_WIDTH: 0.457451
G1 X119.031 Y128.893 E.00498
; LINE_WIDTH: 0.427006
G1 X119.171 Y128.953 E.00461
G1 X119.22 Y129.794 F9000
; LINE_WIDTH: 0.112752
G1 F3000
G2 X119.307 Y129.899 I.156 J-.041 E.00077
G1 X119.349 Y129.926 E.00027
; WIPE_START
G1 X119.307 Y129.899 E-.19982
G1 X119.255 Y129.859 E-.26376
G1 X119.22 Y129.794 E-.29641
; WIPE_END
G1 E-.04 F1800
G1 X124.146 Y129.227 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.52168
G1 F5012.95
G1 X126.617 Y131.698 E.13216
G2 X126.168 Y131.926 I.48 J1.5 E.01913
G1 X124.077 Y129.835 E.11186
G3 X123.8 Y130.235 I-1.434 J-.696 E.01848
G1 X125.767 Y132.203 E.10523
G2 X125.412 Y132.525 I.866 J1.31 E.0182
G1 X123.477 Y130.59 E.10349
G1 X123.111 Y130.9 E.01817
G1 X125.102 Y132.892 E.10652
G1 X124.839 Y133.305 E.01854
G1 X122.697 Y131.164 E.11453
G1 X122.23 Y131.373 E.01938
G1 X124.629 Y133.773 E.12833
G1 X124.481 Y134.302 E.02078
G1 X121.7 Y131.521 E.14873
G1 X121.088 Y131.586 E.02328
G1 X124.416 Y134.914 E.17798
G1 X124.421 Y135.054 E.00531
G3 X122.708 Y133.883 I3.679 J-7.221 E.07869
G1 X121.105 Y132.28 E.08576
; WIPE_START
G1 X122.519 Y133.694 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X124.622 Y128.69 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.121558
G1 F3000
G1 X124.552 Y128.445 E.00158
; LINE_WIDTH: 0.172382
G1 X124.527 Y128.407 E.00047
; LINE_WIDTH: 0.216144
G1 X124.502 Y128.368 E.00063
; LINE_WIDTH: 0.224164
G1 X124.502 Y128.187 E.0026
; LINE_WIDTH: 0.196421
G1 X124.502 Y128.005 E.0022
; LINE_WIDTH: 0.182549
G1 X124.502 Y127.995 E.00012
; LINE_WIDTH: 0.210944
G1 X124.502 Y127.632 E.00481
G1 X124.527 Y127.593 E.00061
; LINE_WIDTH: 0.17234
G1 X124.552 Y127.555 E.00047
; LINE_WIDTH: 0.121517
G1 X124.622 Y127.311 E.00158
; WIPE_START
G1 X124.552 Y127.555 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.184 Y124.649 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; LINE_WIDTH: 0.113211
G1 F3000
G1 X127.338 Y124.593 E.00091
; LINE_WIDTH: 0.138501
G1 X127.436 Y124.566 E.00076
; LINE_WIDTH: 0.168453
G1 X127.528 Y124.541 E.00094
; LINE_WIDTH: 0.198774
G1 X127.563 Y124.521 E.0005
; LINE_WIDTH: 0.23042
G1 X127.598 Y124.501 E.0006
; LINE_WIDTH: 0.233587
G1 X127.73 Y124.499 E.00199
; LINE_WIDTH: 0.208295
G1 X127.862 Y124.496 E.00173
; LINE_WIDTH: 0.204068
G2 X128.343 Y124.497 I.25 J-4.278 E.00612
; LINE_WIDTH: 0.204414
G1 X128.37 Y124.523 E.00047
; LINE_WIDTH: 0.156129
G1 X128.397 Y124.548 E.00033
; LINE_WIDTH: 0.113826
G1 X128.404 Y124.551 E.00004
G2 X128.562 Y124.596 I.294 J-.73 E.00092
G1 X128.529 Y124.434 F9000
; LINE_WIDTH: 0.149353
G1 F3000
G1 X128.409 Y124.462 E.00104
; LINE_WIDTH: 0.183665
G1 X128.376 Y124.48 E.00042
; LINE_WIDTH: 0.213592
G1 X128.343 Y124.497 E.0005
G1 X128.529 Y124.434 F9000
; LINE_WIDTH: 0.116127
G1 F3000
G1 X128.716 Y124.374 E.00113
; WIPE_START
G1 X128.529 Y124.434 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.598 Y124.501 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; LINE_WIDTH: 0.226899
G1 F3000
G1 X127.57 Y124.48 E.00051
; LINE_WIDTH: 0.188219
G1 X127.543 Y124.458 E.0004
; LINE_WIDTH: 0.14954
G1 X127.515 Y124.437 E.00029
; LINE_WIDTH: 0.113506
G1 X127.35 Y124.389 E.00096
; WIPE_START
G1 X127.515 Y124.437 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.319 Y127.054 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; LINE_WIDTH: 0.113209
G1 F3000
G1 X131.381 Y127.206 E.00091
; LINE_WIDTH: 0.145746
G1 X131.426 Y127.348 E.00121
; LINE_WIDTH: 0.190214
G1 X131.469 Y127.484 E.00166
; LINE_WIDTH: 0.233833
G1 X131.5 Y127.543 E.00101
G1 X131.525 Y127.52 F9000
; LINE_WIDTH: 0.233395
G1 F3000
G1 X131.5 Y127.543 E.00051
G1 X131.507 Y127.737 E.00292
; LINE_WIDTH: 0.202305
G2 X131.507 Y128.276 I5.847 J.269 E.00678
; LINE_WIDTH: 0.235519
G1 X131.5 Y128.462 E.00284
; LINE_WIDTH: 0.234975
G1 X131.524 Y128.486 E.00051
; LINE_WIDTH: 0.191051
G1 X131.548 Y128.51 E.00039
; LINE_WIDTH: 0.139864
G1 X131.577 Y128.547 E.00036
; LINE_WIDTH: 0.111551
G1 X131.622 Y128.688 E.00081
G1 X131.425 Y128.656 F9000
; LINE_WIDTH: 0.188196
G1 F3000
G1 X131.466 Y128.524 E.00159
; LINE_WIDTH: 0.23312
G1 X131.5 Y128.462 E.00106
G1 X131.425 Y128.656 F9000
; LINE_WIDTH: 0.145055
G1 F3000
G1 X131.381 Y128.794 E.00117
; LINE_WIDTH: 0.113186
G1 X131.319 Y128.946 E.00091
; WIPE_START
G1 X131.381 Y128.794 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.525 Y127.52 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; LINE_WIDTH: 0.188365
G1 F3000
G1 X131.549 Y127.497 E.00039
; LINE_WIDTH: 0.143488
G1 X131.573 Y127.473 E.00027
; LINE_WIDTH: 0.110234
G1 X131.614 Y127.348 E.0007
; WIPE_START
G1 X131.573 Y127.473 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.408 Y131.328 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.52536
G1 F4974.712
G1 X134.921 Y131.842 E.02766
G3 X134.666 Y132.269 I-37.764 J-22.242 E.01896
G1 X133.768 Y131.37 E.04844
G3 X131.671 Y129.311 I1.202 J-3.321 E.11551
G1 X131.655 Y129.305 E.00065
G1 X131.587 Y129.473 E.00688
G1 X131.321 Y129.366 E.01093
G1 X131.242 Y129.526 E.00684
G1 X134.389 Y132.673 E.16961
G3 X134.089 Y133.056 I-3.355 J-2.312 E.01853
G1 X130.998 Y129.965 E.16664
G1 X130.705 Y130.354 E.01857
G1 X133.769 Y133.418 E.16513
G3 X133.428 Y133.76 I-3.03 J-2.689 E.0184
G1 X130.367 Y130.699 E.16496
G1 X129.98 Y130.994 E.01855
G1 X133.066 Y134.08 E.16632
G3 X132.683 Y134.379 I-2.573 J-2.904 E.01854
G1 X129.542 Y131.238 E.16928
G1 X129.096 Y131.411 E.01823
G1 X129.097 Y131.476 E.00245
G1 X129.274 Y131.653 E.00953
G1 X129.596 Y131.782 E.01321
G3 X131.36 Y133.739 I-1.692 J3.3 E.10265
G1 X132.279 Y134.657 E.04949
G3 X131.852 Y134.912 I-2.344 J-3.436 E.01897
G1 X131.329 Y134.389 E.02818
; WIPE_START
G1 X131.852 Y134.912 E-.28098
G1 X132.279 Y134.657 E-.18905
G1 X131.739 Y134.117 E-.28997
; WIPE_END
G1 E-.04 F1800
G1 X129.918 Y136.67 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113837
G1 F3000
G3 X129.795 Y136.782 I-.181 J-.074 E.00096
G1 X129.059 Y137.107 F9000
; LINE_WIDTH: 0.529309
G1 F3000
G1 X128.8 Y137.158 E.01017
; LINE_WIDTH: 0.48911
G3 X128.416 Y137.224 I-.66 J-2.657 E.01372
; LINE_WIDTH: 0.448217
G3 X127.468 Y137.209 I-.419 J-3.431 E.03046
; LINE_WIDTH: 0.499656
G1 X127.314 Y137.182 E.00563
; LINE_WIDTH: 0.532524
G1 X127.193 Y137.156 E.0048
; LINE_WIDTH: 0.525316
G1 X127.181 Y137.132 E.00102
; LINE_WIDTH: 0.485873
G1 X127.17 Y137.108 E.00094
; LINE_WIDTH: 0.451023
G1 X127.112 Y136.971 E.0048
; LINE_WIDTH: 0.420774
G1 X127.054 Y136.834 E.00445
G1 X126.211 Y136.785 F9000
; LINE_WIDTH: 0.113851
G1 F3000
G3 X126.087 Y136.67 I.065 J-.194 E.00097
; WIPE_START
G1 X126.148 Y136.751 E-.44777
G1 X126.211 Y136.785 E-.31223
; WIPE_END
G1 E-.04 F1800
G1 X127.313 Y131.62 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; LINE_WIDTH: 0.113151
G1 F3000
G1 X127.469 Y131.571 E.00091
; LINE_WIDTH: 0.140564
G2 X127.535 Y131.54 I-.021 J-.133 E.00057
; LINE_WIDTH: 0.191267
G1 X127.563 Y131.52 E.00041
; LINE_WIDTH: 0.228828
G1 X127.591 Y131.499 E.00051
; LINE_WIDTH: 0.230727
G1 X127.555 Y131.477 E.00062
; LINE_WIDTH: 0.196952
G1 X127.518 Y131.456 E.00051
; LINE_WIDTH: 0.166296
G1 X127.431 Y131.432 E.00088
; LINE_WIDTH: 0.122325
G1 X127.183 Y131.351 E.00164
G1 X127.591 Y131.499 F9000
; LINE_WIDTH: 0.23463
G1 F3000
G1 X127.726 Y131.501 E.00205
; LINE_WIDTH: 0.208669
G1 X127.862 Y131.504 E.00178
; LINE_WIDTH: 0.204756
G3 X128.334 Y131.503 I.247 J4.394 E.00604
G1 X128.355 Y131.485 F9000
; LINE_WIDTH: 0.200202
G1 F3000
G1 X128.334 Y131.503 E.00034
G1 X128.401 Y131.539 E.00095
; LINE_WIDTH: 0.144339
G1 X128.528 Y131.568 E.00104
; LINE_WIDTH: 0.113701
G1 X128.691 Y131.62 E.00096
G1 X128.562 Y131.404 F9000
; LINE_WIDTH: 0.113568
G1 F3000
G1 X128.397 Y131.45 E.00095
; LINE_WIDTH: 0.144146
G1 X128.376 Y131.468 E.00022
; LINE_WIDTH: 0.177637
G1 X128.355 Y131.485 E.00029
; WIPE_START
G1 X128.376 Y131.468 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X135.879 Y130.064 Z.6 F9000
G1 X136.672 Y129.916 Z.6
G1 Z.2
G1 E.8 F1800
; LINE_WIDTH: 0.114377
G1 F3000
G2 X136.787 Y129.79 I-.074 J-.183 E.001
G1 X137.374 Y129.146 F9000
; LINE_WIDTH: 0.53029
G1 F3000
G1 X137.161 Y128.804 E.01553
G1 X137.186 Y128.669 E.00528
; LINE_WIDTH: 0.495365
G1 X137.211 Y128.534 E.0049
; LINE_WIDTH: 0.450282
G2 X137.216 Y127.497 I-3.939 J-.536 E.03347
; LINE_WIDTH: 0.491614
G2 X137.186 Y127.333 I-2.05 J.285 E.00589
; LINE_WIDTH: 0.528989
G1 X137.162 Y127.204 E.00504
; LINE_WIDTH: 0.546301
G1 X137.105 Y126.947 E.01047
G1 X136.787 Y126.21 F9000
; LINE_WIDTH: 0.114358
G1 F3000
G2 X136.672 Y126.084 I-.189 J.057 E.00099
; WIPE_START
G1 X136.756 Y126.148 E-.45712
G1 X136.787 Y126.21 E-.30288
; WIPE_END
G1 E-.04 F1800
G1 X132.286 Y121.107 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.51839
G1 F5047.637
G1 X133.859 Y122.68 E.08356
G3 X135.057 Y124.421 I-5.947 J5.376 E.07959
G1 X134.923 Y124.416 E.00505
G1 X131.588 Y121.081 E.17714
G1 X131.525 Y121.691 E.02301
G1 X134.311 Y124.477 E.14798
G1 X133.784 Y124.622 E.02053
G1 X131.38 Y122.218 E.12772
G1 X131.172 Y122.682 E.01911
G1 X133.32 Y124.831 E.11412
G1 X132.908 Y125.091 E.01831
G1 X130.911 Y123.094 E.10605
G3 X130.605 Y123.46 I-1.339 J-.808 E.018
G1 X132.542 Y125.397 E.10287
G2 X132.219 Y125.747 I.972 J1.219 E.01794
G1 X130.255 Y123.783 E.10434
G3 X129.86 Y124.06 I-1.096 J-1.138 E.0182
G1 X131.942 Y126.142 E.11056
G2 X131.713 Y126.585 I1.254 J.929 E.01882
G1 X129.259 Y124.131 E.13035
; WIPE_START
G1 X130.673 Y125.545 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.918 Y119.33 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113799
G1 F3000
G2 X129.795 Y119.218 I-.181 J.074 E.00096
G1 X128.952 Y119.167 F9000
; LINE_WIDTH: 0.445885
G1 F3000
G1 X128.889 Y119.022 E.00505
; LINE_WIDTH: 0.476208
G1 X128.825 Y118.876 E.00543
; LINE_WIDTH: 0.504558
G1 X128.817 Y118.86 E.00066
; OBJECT_ID: 118
; WIPE_START
G1 X128.825 Y118.876 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X122.99 Y123.795 Z.6 F9000
M73 P34 R13
G1 X107.691 Y136.691 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.5
G1 F3000
G1 X107.423 Y136.773 E.0101
G3 X106.728 Y133.195 I-.423 J-1.774 E.2124
G1 X106.994 Y133.175 E.00964
G3 X107.743 Y136.664 I.006 J1.824 E.17945
; WIPE_START
G1 X107.423 Y136.773 E-.12864
G1 X107.146 Y136.821 E-.10656
G1 X106.867 Y136.821 E-.10622
G1 X106.591 Y136.778 E-.10623
G1 X106.324 Y136.694 E-.10624
G1 X106.074 Y136.57 E-.10621
G1 X105.859 Y136.418 E-.0999
; WIPE_END
G1 E-.04 F1800
G1 X111.245 Y131.011 Z.6 F9000
G1 X115.409 Y126.831 Z.6
G1 Z.2
G1 E.8 F1800
G1 F3000
G1 X115.41 Y126.843 E.00041
G3 X113.659 Y126.207 I-1.41 J1.156 E.34313
G1 X113.924 Y126.177 E.00964
G3 X115.217 Y126.64 I.076 J1.822 E.05083
G1 X115.366 Y126.789 E.0076
; WIPE_START
G1 X115.41 Y126.843 E-.0264
G1 X115.576 Y127.067 E-.1061
G1 X115.695 Y127.306 E-.1014
G1 X115.784 Y127.583 E-.11053
G1 X115.827 Y127.86 E-.10669
G1 X115.827 Y128.14 E-.10623
G1 X115.785 Y128.416 E-.10624
G1 X115.708 Y128.658 E-.09641
; WIPE_END
G1 E-.04 F1800
G1 X110.844 Y122.776 Z.6 F9000
G1 X108.373 Y119.79 Z.6
G1 Z.2
G1 E.8 F1800
G1 F3000
G1 X108.538 Y120.008 E.00988
G3 X106.866 Y119.179 I-1.532 J.99 E.34307
G1 X107.146 Y119.179 E.01013
G3 X108.333 Y119.746 I-.14 J1.819 E.04855
; WIPE_START
G1 X108.538 Y120.008 E-.12666
G1 X108.673 Y120.253 E-.1062
G1 X108.763 Y120.504 E-.10142
G1 X108.821 Y120.789 E-.11056
G1 X108.831 Y121.07 E-.10665
G1 X108.799 Y121.348 E-.10626
G1 X108.728 Y121.607 E-.10225
; WIPE_END
G1 E-.04 F1800
G1 X104.204 Y126.468 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
G1 X104.398 Y126.165 E.01299
G3 X106.732 Y124.819 I2.615 J1.838 E.10043
G3 X109.67 Y126.239 I.301 J3.127 E.1239
G1 X109.758 Y126.364 E.00553
G1 X109.976 Y126.803 E.01769
G3 X104.148 Y126.585 I-2.963 J1.2 E.46006
G1 X104.178 Y126.522 E.0025
G1 X104.597 Y126.702 F9000
G1 F3000
G1 X104.772 Y126.428 E.01172
G3 X106.784 Y125.273 I2.241 J1.574 E.08652
G3 X109.123 Y126.255 I.213 J2.767 E.0951
G3 X104.558 Y126.788 I-2.109 J1.747 E.42452
G1 X104.573 Y126.756 E.00124
G1 X104.99 Y126.935 F9000
G1 F3000
G1 X105.146 Y126.691 E.01046
G3 X106.837 Y125.727 I1.868 J1.31 E.0726
G3 X108.248 Y126.083 I.158 J2.351 E.05343
G3 X104.969 Y126.991 I-1.234 J1.919 E.37884
G1 X105.383 Y127.169 F9000
; FEATURE: Outer wall
G1 F3000
G1 X105.52 Y126.954 E.00919
G3 X106.889 Y126.181 I1.493 J1.045 E.05871
G3 X107.754 Y126.334 I.13 J1.784 E.03202
G3 X105.363 Y127.225 I-.74 J1.666 E.31151
; WIPE_START
G1 X105.52 Y126.954 E-.11885
G1 X105.691 Y126.734 E-.10605
G1 X105.9 Y126.548 E-.10621
G1 X106.134 Y126.396 E-.10625
G1 X106.389 Y126.282 E-.1062
G1 X106.659 Y126.207 E-.10623
G1 X106.889 Y126.181 E-.08806
G1 X106.948 Y126.182 E-.02215
; WIPE_END
G1 E-.04 F1800
G1 X103.89 Y120.307 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
G2 X110.12 Y120.296 I3.116 J.7 E.41362
G1 X110.721 Y120.574 E.02391
G3 X114.704 Y124.884 I-3.75 J7.462 E.21652
G2 X114.704 Y131.116 I-.703 J3.116 E.41354
G3 X110.122 Y135.704 I-7.77 J-3.179 E.24037
G2 X103.89 Y135.693 I-3.115 J-.71 E.41371
G3 X99.297 Y131.114 I3.235 J-7.837 E.2403
G2 X99.315 Y124.883 I.715 J-3.113 E.41379
G3 X103.834 Y120.329 I7.667 J3.09 E.23789
; WIPE_START
G1 X103.827 Y120.633 E-.1154
G1 X103.808 Y121.122 E-.1862
G1 X103.864 Y121.61 E-.18633
G1 X103.994 Y122.082 E-.18624
G1 X104.086 Y122.288 E-.08584
; WIPE_END
G1 E-.04 F1800
G1 X104.678 Y119.558 Z.6 F9000
G1 Z.2
G1 E.8 F1800
G1 F3000
G2 X109.33 Y119.548 I2.329 J1.444 E.42103
G1 X109.962 Y119.753 E.02398
G3 X115.453 Y125.673 I-2.962 J8.253 E.30297
G2 X115.453 Y130.327 I-1.447 J2.327 E.42092
G3 X109.331 Y136.45 I-8.478 J-2.355 E.32682
G2 X104.678 Y136.442 I-2.324 J-1.451 E.42097
G3 X98.805 Y131.078 I2.322 J-8.44 E.29812
G1 X98.546 Y130.319 E.02896
G2 X98.545 Y125.682 I1.462 J-2.319 E.42229
G3 X100.409 Y122.236 I8.821 J2.546 E.14256
G3 X104.62 Y119.574 I6.583 J5.751 E.1824
; WIPE_START
G1 X104.504 Y119.878 E-.1237
G1 X104.362 Y120.273 E-.15956
G1 X104.282 Y120.685 E-.15954
G1 X104.266 Y121.105 E-.15954
G1 X104.314 Y121.517 E-.15766
; WIPE_END
G1 E-.04 F1800
G1 X108.683 Y119.452 Z.6 F9000
G1 Z.2
G1 E.8 F1800
G1 F3000
G1 X108.457 Y119.241 E.01114
G2 X108.236 Y119.08 I-1.451 J1.761 E.00988
G1 X108.315 Y118.88 E.00778
G3 X116.133 Y126.69 I-1.311 J9.13 E.42781
G1 X115.93 Y126.775 E.00796
G2 X115.93 Y129.225 I-1.925 J1.225 E.4242
G1 X116.133 Y129.31 E.00796
G3 X108.315 Y137.12 I-9.129 J-1.32 E.42781
G1 X108.236 Y136.92 E.00778
G2 X105.776 Y136.919 I-1.229 J-1.922 E.4238
G1 X105.693 Y137.122 E.0079
G3 X97.888 Y129.314 I1.305 J-9.11 E.42749
G1 X98.09 Y129.233 E.00783
G2 X98.088 Y126.768 I1.919 J-1.233 E.42352
G1 X97.887 Y126.687 E.00784
G3 X105.695 Y118.878 I9.113 J1.304 E.42759
G1 X105.778 Y119.08 E.00787
G2 X108.722 Y119.497 I1.229 J1.922 E.40065
; WIPE_START
G1 X108.457 Y119.241 E-.13996
G1 X108.236 Y119.08 E-.10394
G1 X108.315 Y118.88 E-.08185
G1 X109.057 Y119.013 E-.28657
G1 X109.433 Y119.112 E-.14769
; WIPE_END
G1 E-.04 F1800
G1 X104.626 Y125.041 Z.6 F9000
G1 X101.716 Y128.629 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
G1 F3000
M73 P35 R13
G1 X101.635 Y128.806 E.00704
G3 X99.797 Y126.186 I-1.635 J-.808 E.27275
G1 X100.064 Y126.176 E.00964
G3 X101.739 Y128.548 I-.064 J1.823 E.1213
G1 X101.733 Y128.571 E.00087
; WIPE_START
G1 X101.635 Y128.806 E-.09667
G1 X101.5 Y129.051 E-.10603
G1 X101.322 Y129.266 E-.10622
G1 X101.114 Y129.452 E-.10622
G1 X100.879 Y129.604 E-.10626
G1 X100.624 Y129.718 E-.10621
G1 X100.354 Y129.793 E-.10622
G1 X100.286 Y129.8 E-.02618
; WIPE_END
G1 E-.04 F1800
G1 X103.829 Y123.04 Z.6 F9000
G1 X106.284 Y118.357 Z.6
G1 Z.2
G1 E.8 F1800
G1 F3000
G3 X107.166 Y118.331 I.728 J9.696 E.03189
G3 X102.449 Y119.467 I-.167 J9.67 E2.01698
G3 X106.224 Y118.362 I4.564 J8.586 E.14303
G1 X106.318 Y118.818 F9000
; FEATURE: Gap infill
; LINE_WIDTH: 0.532457
G1 F3000
G1 X106.199 Y118.843 E.00468
; LINE_WIDTH: 0.523748
G1 X106.187 Y118.869 E.00108
; LINE_WIDTH: 0.48196
G1 X106.175 Y118.895 E.00098
; LINE_WIDTH: 0.44607
G1 X106.118 Y119.03 E.00468
; LINE_WIDTH: 0.416064
G1 X106.061 Y119.165 E.00433
G1 X106.318 Y118.818 F9000
; LINE_WIDTH: 0.501307
G1 F3000
G1 X106.459 Y118.793 E.0052
; LINE_WIDTH: 0.451222
G3 X107.541 Y118.791 I.551 J3.829 E.035
; LINE_WIDTH: 0.513125
G1 X107.814 Y118.843 E.01034
G1 X107.822 Y118.86 E.00067
; LINE_WIDTH: 0.504558
G1 X107.83 Y118.876 E.00066
; LINE_WIDTH: 0.476208
G1 X107.893 Y119.022 E.00543
; LINE_WIDTH: 0.445885
G1 X107.956 Y119.167 E.00505
G1 X108.8 Y119.218 F9000
; LINE_WIDTH: 0.113799
G1 F3000
G3 X108.922 Y119.33 I-.058 J.186 E.00096
; WIPE_START
G1 X108.861 Y119.249 E-.45317
G1 X108.8 Y119.218 E-.30683
; WIPE_END
G1 E-.04 F1800
G1 X111.291 Y121.107 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.51839
G1 F5047.637
G1 X112.864 Y122.68 E.08356
G3 X114.062 Y124.421 I-5.947 J5.376 E.07959
G1 X113.928 Y124.416 E.00505
G1 X110.593 Y121.081 E.17714
G1 X110.53 Y121.691 E.02301
G1 X113.316 Y124.477 E.14798
G1 X112.789 Y124.622 E.02053
G1 X110.384 Y122.218 E.12772
G1 X110.176 Y122.682 E.01911
G1 X112.325 Y124.831 E.11412
G1 X111.912 Y125.091 E.01831
G1 X109.916 Y123.094 E.10605
G3 X109.61 Y123.46 I-1.339 J-.808 E.018
G1 X111.546 Y125.397 E.10287
G2 X111.224 Y125.747 I.972 J1.219 E.01794
G1 X109.259 Y123.783 E.10434
G3 X108.865 Y124.06 I-1.096 J-1.138 E.0182
G1 X110.946 Y126.142 E.11056
G2 X110.717 Y126.585 I1.254 J.929 E.01882
G1 X108.263 Y124.131 E.13035
G1 X107.72 Y124.374 F9000
; FEATURE: Gap infill
; LINE_WIDTH: 0.116127
G1 F3000
G1 X107.534 Y124.434 E.00113
; LINE_WIDTH: 0.149353
G1 X107.413 Y124.462 E.00104
; LINE_WIDTH: 0.183665
G1 X107.38 Y124.48 E.00042
; LINE_WIDTH: 0.213592
G1 X107.347 Y124.497 E.0005
; LINE_WIDTH: 0.204414
G1 X107.375 Y124.523 E.00047
; LINE_WIDTH: 0.156129
G1 X107.402 Y124.548 E.00033
; LINE_WIDTH: 0.113826
G1 X107.408 Y124.551 E.00004
G2 X107.566 Y124.596 I.294 J-.73 E.00092
G1 X107.347 Y124.497 F9000
; LINE_WIDTH: 0.204068
G1 F3000
G3 X106.867 Y124.496 I-.23 J-4.279 E.00612
; LINE_WIDTH: 0.208295
G1 X106.735 Y124.499 E.00173
; LINE_WIDTH: 0.233587
G1 X106.602 Y124.501 E.00199
; LINE_WIDTH: 0.23042
G1 X106.567 Y124.521 E.0006
; LINE_WIDTH: 0.198774
G1 X106.532 Y124.541 E.0005
; LINE_WIDTH: 0.168453
G1 X106.441 Y124.566 E.00094
; LINE_WIDTH: 0.138501
G1 X106.343 Y124.593 E.00076
; LINE_WIDTH: 0.113211
G1 X106.188 Y124.649 E.00091
G1 X106.355 Y124.389 F9000
; LINE_WIDTH: 0.113506
G1 F3000
G1 X106.52 Y124.437 E.00096
; LINE_WIDTH: 0.14954
G1 X106.547 Y124.458 E.00029
; LINE_WIDTH: 0.188219
G1 X106.575 Y124.48 E.0004
; LINE_WIDTH: 0.226899
G1 X106.602 Y124.501 E.00051
; WIPE_START
G1 X106.575 Y124.48 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.627 Y127.311 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; LINE_WIDTH: 0.121517
G1 F3000
G1 X103.557 Y127.555 E.00158
; LINE_WIDTH: 0.17234
G1 X103.532 Y127.593 E.00047
; LINE_WIDTH: 0.210944
G1 X103.507 Y127.632 E.00061
G1 X103.507 Y127.995 E.00481
; LINE_WIDTH: 0.182549
G1 X103.507 Y128.005 E.00012
; LINE_WIDTH: 0.196421
G1 X103.507 Y128.187 E.0022
; LINE_WIDTH: 0.224164
G1 X103.507 Y128.368 E.0026
; LINE_WIDTH: 0.216144
G1 X103.532 Y128.407 E.00063
; LINE_WIDTH: 0.172382
G1 X103.557 Y128.445 E.00047
; LINE_WIDTH: 0.121558
G1 X103.627 Y128.69 E.00158
G1 X103.15 Y129.227 F9000
; FEATURE: Bottom surface
; LINE_WIDTH: 0.52168
G1 F5012.95
G1 X105.621 Y131.698 E.13216
G2 X105.172 Y131.926 I.48 J1.5 E.01913
G1 X103.081 Y129.835 E.11186
G3 X102.804 Y130.235 I-1.434 J-.696 E.01848
G1 X104.772 Y132.203 E.10523
G2 X104.417 Y132.525 I.866 J1.31 E.0182
G1 X102.482 Y130.59 E.10349
G1 X102.115 Y130.9 E.01817
G1 X104.107 Y132.892 E.10652
G1 X103.843 Y133.305 E.01854
G1 X101.702 Y131.164 E.11453
G1 X101.234 Y131.373 E.01938
G1 X103.633 Y133.773 E.12833
G1 X103.486 Y134.302 E.02078
G1 X100.705 Y131.521 E.14873
G1 X100.093 Y131.586 E.02328
G1 X103.421 Y134.914 E.17798
G1 X103.426 Y135.054 E.00531
G3 X101.713 Y133.883 I3.679 J-7.221 E.07869
G1 X100.109 Y132.28 E.08576
; WIPE_START
G1 X101.524 Y133.694 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X98.353 Y129.926 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.112752
G1 F3000
M73 P35 R12
G1 X98.311 Y129.899 E.00027
G3 X98.225 Y129.794 I.069 J-.146 E.00077
G1 X98.175 Y128.953 F9000
; LINE_WIDTH: 0.427006
G1 F3000
G1 X98.035 Y128.893 E.00461
; LINE_WIDTH: 0.457451
G1 X97.896 Y128.833 E.00498
; LINE_WIDTH: 0.524265
G1 X97.851 Y128.812 E.00186
G1 X97.825 Y128.682 E.00505
; LINE_WIDTH: 0.50133
G1 X97.799 Y128.552 E.00481
; LINE_WIDTH: 0.484588
G1 X97.796 Y128.535 E.0006
; LINE_WIDTH: 0.449639
G3 X97.793 Y127.499 I3.827 J-.531 E.03338
; LINE_WIDTH: 0.482768
G1 X97.805 Y127.421 E.00275
; LINE_WIDTH: 0.518408
G1 X97.852 Y127.189 E.00887
G1 X97.879 Y127.176 E.00115
; LINE_WIDTH: 0.482673
G1 X98.027 Y127.112 E.00558
; LINE_WIDTH: 0.451678
G1 X98.174 Y127.049 E.00519
G1 X98.225 Y126.206 F9000
; LINE_WIDTH: 0.11365
G1 F3000
G3 X98.337 Y126.084 I.188 J.061 E.00095
; WIPE_START
G1 X98.257 Y126.145 E-.45008
G1 X98.225 Y126.206 E-.30992
; WIPE_END
G1 E-.04 F1800
G1 X103.679 Y121.6 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.5244
G1 F4984.631
G1 X103.164 Y121.085 E.02769
G2 X102.737 Y121.339 I1.809 J3.525 E.01891
G1 X103.64 Y122.242 E.04854
G2 X105.726 Y124.342 I3.313 J-1.204 E.11619
G1 X105.672 Y124.361 E.00215
G1 X105.769 Y124.631 E.0109
G1 X105.479 Y124.761 E.0121
G1 X102.334 Y121.616 E.16917
G2 X101.951 Y121.915 I2.306 J3.348 E.01846
G1 X105.043 Y125.006 E.16629
G2 X104.655 Y125.3 I.756 J1.401 E.01856
G1 X101.59 Y122.234 E.16489
G2 X101.249 Y122.575 I2.671 J3.015 E.01832
G1 X104.313 Y125.639 E.16482
G2 X104.017 Y126.023 I1.095 J1.152 E.01854
G1 X100.929 Y122.936 E.16608
G2 X100.63 Y123.318 I3.041 J2.687 E.01846
G1 X103.769 Y126.456 E.16882
G1 X103.593 Y126.892 E.01789
G1 X103.492 Y126.861 E.00402
G1 X103.35 Y126.719 E.00764
G1 X103.225 Y126.407 E.01279
G2 X101.278 Y124.646 I-3.297 J1.69 E.10202
G1 X100.353 Y123.721 E.04978
G2 X100.098 Y124.147 I3.424 J2.342 E.01889
G1 X100.624 Y124.673 E.02833
; WIPE_START
G1 X100.098 Y124.147 E-.28303
G1 X100.353 Y123.721 E-.18861
G1 X100.889 Y124.258 E-.28836
; WIPE_END
G1 E-.04 F1800
G1 X105.091 Y119.33 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113854
G1 F3000
G3 X105.215 Y119.215 I.189 J.08 E.00097
; WIPE_START
G1 X105.153 Y119.249 E-.3122
G1 X105.091 Y119.33 E-.4478
; WIPE_END
G1 E-.04 F1800
G1 X109.372 Y125.649 Z.6 F9000
G1 X110.324 Y127.054 Z.6
G1 Z.2
M73 P36 R12
G1 E.8 F1800
; LINE_WIDTH: 0.113209
G1 F3000
G1 X110.385 Y127.206 E.00091
; LINE_WIDTH: 0.145746
G1 X110.43 Y127.348 E.00121
; LINE_WIDTH: 0.190214
G1 X110.473 Y127.484 E.00166
; LINE_WIDTH: 0.233833
G1 X110.505 Y127.543 E.00101
G1 X110.529 Y127.52 F9000
; LINE_WIDTH: 0.233395
G1 F3000
G1 X110.505 Y127.543 E.00051
G1 X110.512 Y127.737 E.00292
; LINE_WIDTH: 0.202305
G2 X110.512 Y128.276 I5.847 J.269 E.00678
; LINE_WIDTH: 0.235519
G1 X110.504 Y128.462 E.00284
; LINE_WIDTH: 0.234975
G1 X110.528 Y128.486 E.00051
; LINE_WIDTH: 0.191051
G1 X110.552 Y128.51 E.00039
; LINE_WIDTH: 0.139864
G1 X110.581 Y128.547 E.00036
; LINE_WIDTH: 0.111551
G1 X110.627 Y128.688 E.00081
G1 X110.429 Y128.656 F9000
; LINE_WIDTH: 0.188196
G1 F3000
G1 X110.471 Y128.524 E.00159
; LINE_WIDTH: 0.23312
G1 X110.504 Y128.462 E.00106
G1 X110.429 Y128.656 F9000
; LINE_WIDTH: 0.145055
G1 F3000
G1 X110.385 Y128.794 E.00117
; LINE_WIDTH: 0.113186
G1 X110.324 Y128.946 E.00091
; WIPE_START
G1 X110.385 Y128.794 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.529 Y127.52 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; LINE_WIDTH: 0.188365
G1 F3000
G1 X110.553 Y127.497 E.00039
; LINE_WIDTH: 0.143488
G1 X110.578 Y127.473 E.00027
; LINE_WIDTH: 0.110234
G1 X110.618 Y127.348 E.0007
; WIPE_START
G1 X110.578 Y127.473 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.413 Y131.328 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.52536
G1 F4974.712
G1 X113.926 Y131.842 E.02766
G3 X113.671 Y132.269 I-37.764 J-22.242 E.01896
G1 X112.772 Y131.37 E.04844
G3 X110.675 Y129.311 I1.202 J-3.321 E.11551
G1 X110.659 Y129.305 E.00065
G1 X110.592 Y129.473 E.00688
G1 X110.326 Y129.366 E.01093
G1 X110.246 Y129.526 E.00684
G1 X113.393 Y132.673 E.16961
G3 X113.094 Y133.056 I-3.355 J-2.312 E.01853
G1 X110.002 Y129.965 E.16664
G1 X109.71 Y130.354 E.01857
G1 X112.774 Y133.418 E.16513
G3 X112.433 Y133.76 I-3.03 J-2.689 E.0184
G1 X109.372 Y130.699 E.16496
G1 X108.985 Y130.994 E.01855
G1 X112.071 Y134.08 E.16632
G3 X111.687 Y134.379 I-2.573 J-2.904 E.01854
G1 X108.546 Y131.238 E.16928
G1 X108.101 Y131.411 E.01823
G1 X108.102 Y131.476 E.00245
G1 X108.279 Y131.653 E.00953
G1 X108.6 Y131.782 E.01321
G3 X110.365 Y133.739 I-1.692 J3.3 E.10265
G1 X111.283 Y134.657 E.04949
G3 X110.856 Y134.912 I-2.344 J-3.436 E.01897
G1 X110.333 Y134.389 E.02818
; WIPE_START
G1 X110.856 Y134.912 E-.28098
G1 X111.283 Y134.657 E-.18905
G1 X110.743 Y134.117 E-.28997
; WIPE_END
G1 E-.04 F1800
G1 X108.922 Y136.67 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113837
G1 F3000
G3 X108.8 Y136.782 I-.181 J-.074 E.00096
G1 X108.064 Y137.107 F9000
; LINE_WIDTH: 0.529309
G1 F3000
G1 X107.804 Y137.158 E.01017
; LINE_WIDTH: 0.48911
G3 X107.421 Y137.224 I-.66 J-2.657 E.01372
; LINE_WIDTH: 0.448217
G3 X106.473 Y137.209 I-.419 J-3.431 E.03046
; LINE_WIDTH: 0.499656
G1 X106.319 Y137.182 E.00563
; LINE_WIDTH: 0.532524
G1 X106.197 Y137.156 E.0048
; LINE_WIDTH: 0.525316
G1 X106.186 Y137.132 E.00102
; LINE_WIDTH: 0.485873
G1 X106.175 Y137.108 E.00094
; LINE_WIDTH: 0.451023
G1 X106.116 Y136.971 E.0048
; LINE_WIDTH: 0.420774
G1 X106.058 Y136.834 E.00445
G1 X105.215 Y136.785 F9000
; LINE_WIDTH: 0.113851
G1 F3000
G3 X105.091 Y136.67 I.065 J-.194 E.00097
; WIPE_START
G1 X105.153 Y136.751 E-.44777
G1 X105.215 Y136.785 E-.31223
; WIPE_END
G1 E-.04 F1800
G1 X106.318 Y131.62 Z.6 F9000
G1 Z.2
G1 E.8 F1800
; LINE_WIDTH: 0.113151
G1 F3000
G1 X106.474 Y131.571 E.00091
; LINE_WIDTH: 0.140564
G2 X106.54 Y131.54 I-.021 J-.133 E.00057
; LINE_WIDTH: 0.191267
G1 X106.567 Y131.52 E.00041
; LINE_WIDTH: 0.228828
G1 X106.595 Y131.499 E.00051
; LINE_WIDTH: 0.230727
G1 X106.559 Y131.477 E.00062
; LINE_WIDTH: 0.196952
G1 X106.523 Y131.456 E.00051
; LINE_WIDTH: 0.166296
G1 X106.436 Y131.432 E.00088
; LINE_WIDTH: 0.122325
G1 X106.188 Y131.351 E.00164
G1 X106.595 Y131.499 F9000
; LINE_WIDTH: 0.23463
G1 F3000
G1 X106.731 Y131.501 E.00205
; LINE_WIDTH: 0.208669
G1 X106.866 Y131.504 E.00178
; LINE_WIDTH: 0.204756
G3 X107.338 Y131.503 I.247 J4.394 E.00604
G1 X107.36 Y131.485 F9000
; LINE_WIDTH: 0.200202
G1 F3000
G1 X107.338 Y131.503 E.00034
G1 X107.406 Y131.539 E.00095
; LINE_WIDTH: 0.144339
G1 X107.533 Y131.568 E.00104
; LINE_WIDTH: 0.113701
G1 X107.696 Y131.62 E.00096
G1 X107.566 Y131.404 F9000
; LINE_WIDTH: 0.113568
G1 F3000
G1 X107.402 Y131.45 E.00095
; LINE_WIDTH: 0.144146
G1 X107.381 Y131.468 E.00022
; LINE_WIDTH: 0.177637
G1 X107.36 Y131.485 E.00029
; WIPE_START
G1 X107.381 Y131.468 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.883 Y130.064 Z.6 F9000
G1 X115.677 Y129.916 Z.6
G1 Z.2
G1 E.8 F1800
; LINE_WIDTH: 0.114377
G1 F3000
G2 X115.792 Y129.79 I-.074 J-.183 E.001
G1 X116.379 Y129.146 F9000
; LINE_WIDTH: 0.53029
G1 F3000
G1 X116.166 Y128.804 E.01553
G1 X116.19 Y128.669 E.00528
; LINE_WIDTH: 0.495365
G1 X116.215 Y128.534 E.0049
; LINE_WIDTH: 0.450282
G2 X116.22 Y127.497 I-3.939 J-.536 E.03347
; LINE_WIDTH: 0.491614
G2 X116.191 Y127.333 I-2.05 J.285 E.00589
; LINE_WIDTH: 0.528989
G1 X116.166 Y127.204 E.00504
; LINE_WIDTH: 0.546301
G1 X116.11 Y126.947 E.01047
G1 X115.792 Y126.21 F9000
; LINE_WIDTH: 0.114358
G1 F3000
G2 X115.677 Y126.084 I-.189 J.057 E.00099
; CHANGE_LAYER
; Z_HEIGHT: 0.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F3000
G1 X115.76 Y126.148 E-.45712
G1 X115.792 Y126.21 E-.30288
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 118
M625
; layer num/total_layer_count: 2/23
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
; open powerlost recovery
M1003 S1
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
M204 S750
G17
G3 Z.6 I-.773 J.94 P1  F9000
G1 X128.827 Y136.931 Z.6
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X128.786 Y136.946 E.00138
G3 X127.922 Y132.902 I-.784 J-1.946 E.23524
G3 X129.143 Y133.238 I.071 J2.131 E.04136
G3 X129.143 Y136.761 I-1.141 J1.761 E.13444
G1 X128.88 Y136.903 E.00961
M204 S250
G1 X128.643 Y136.586 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X128.642 Y136.588 E.00006
G3 X127.952 Y133.293 I-.631 J-1.587 E.1773
G3 X128.518 Y133.369 I.023 J1.979 E.01709
G3 X128.921 Y136.446 I-.507 J1.631 E.11596
G1 X128.696 Y136.559 E.00748
; WIPE_START
G1 X128.642 Y136.588 E-.02328
G1 X128.392 Y136.666 E-.09958
G1 X128.133 Y136.706 E-.09953
G1 X127.871 Y136.706 E-.0995
G1 X127.612 Y136.666 E-.09953
G1 X127.363 Y136.587 E-.09953
G1 X127.128 Y136.47 E-.0995
G1 X126.914 Y136.32 E-.09952
G1 X126.838 Y136.247 E-.04003
; WIPE_END
G1 E-.04 F1800
G1 X132.279 Y130.894 Z.8 F9000
G1 X136.604 Y126.64 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X136.627 Y126.66 E.00098
G3 X134.842 Y125.907 I-1.617 J1.34 E.35948
G3 X136.146 Y126.234 I.151 J2.163 E.04396
G3 X136.403 Y126.429 I-1.136 J1.766 E.01037
G1 X136.563 Y126.596 E.00746
M204 S250
G1 X136.326 Y126.909 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X134.886 Y126.296 I-1.314 J1.091 E.2713
G3 X135.455 Y126.351 I.099 J1.978 E.01708
G3 X136.287 Y126.863 I-.444 J1.649 E.0295
; WIPE_START
G1 X136.473 Y127.126 E-.12232
G1 X136.589 Y127.361 E-.09949
G1 X136.668 Y127.61 E-.09952
G1 X136.708 Y127.869 E-.09954
G1 X136.708 Y128.131 E-.0995
G1 X136.668 Y128.39 E-.09953
G1 X136.589 Y128.64 E-.09953
G1 X136.541 Y128.735 E-.04055
; WIPE_END
G1 E-.04 F1800
G1 X131.91 Y122.669 Z.8 F9000
G1 X129.553 Y119.581 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X129.573 Y119.6 E.00089
G3 X127.841 Y118.902 I-1.57 J1.398 E.3626
G3 X128.712 Y119.024 I.125 J2.276 E.02845
G1 X128.789 Y119.049 E.0026
G3 X129.341 Y119.377 I-.786 J1.95 E.02073
G1 X129.51 Y119.54 E.00754
M204 S250
G1 X129.279 Y119.862 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X127.871 Y119.294 I-1.277 J1.136 E.273
G1 X128.133 Y119.294 E.0078
G3 X129.238 Y119.818 I-.131 J1.704 E.03725
; WIPE_START
G1 X129.438 Y120.07 E-.12218
G1 X129.563 Y120.3 E-.09953
G1 X129.652 Y120.547 E-.09954
G1 X129.702 Y120.804 E-.0995
G1 X129.712 Y121.065 E-.09949
G1 X129.682 Y121.326 E-.09955
G1 X129.612 Y121.578 E-.09952
G1 X129.568 Y121.676 E-.04068
; WIPE_END
G1 E-.04 F1800
G1 X125.441 Y126.61 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X125.62 Y126.324 E.01085
G3 X127.714 Y125.102 I2.381 J1.676 E.08042
G3 X127.186 Y130.796 I.295 J2.899 E.33066
G3 X125.392 Y126.707 I.815 J-2.796 E.16359
G1 X125.414 Y126.664 E.00157
G1 X125.791 Y126.818 F9000
G1 F5895.652
G1 X125.953 Y126.558 E.00985
G3 X127.761 Y125.507 I2.049 J1.442 E.06938
G3 X127.294 Y130.403 I.247 J2.494 E.28444
G3 X125.757 Y126.888 I.707 J-2.403 E.14051
G1 X125.764 Y126.872 E.00057
G1 X126.141 Y127.026 F9000
G1 F5895.652
G1 X126.285 Y126.792 E.00885
G3 X127.807 Y125.911 I1.717 J1.211 E.05837
G3 X129.045 Y126.179 I.193 J2.1 E.04135
G3 X126.114 Y127.08 I-1.043 J1.824 E.31398
M204 S250
G1 X126.478 Y127.227 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X126.611 Y127.022 E.00729
G3 X127.852 Y126.3 I1.399 J.98 E.04412
G3 X128.702 Y126.439 I.166 J1.654 E.02594
G3 X126.461 Y127.283 I-.691 J1.562 E.24069
; WIPE_START
G1 X126.611 Y127.022 E-.11445
G1 X126.77 Y126.814 E-.0993
G1 X126.965 Y126.64 E-.09951
G1 X127.185 Y126.497 E-.09953
G1 X127.424 Y126.39 E-.0995
G1 X127.677 Y126.321 E-.09952
G1 X127.852 Y126.3 E-.06722
G1 X128.065 Y126.301 E-.08096
; WIPE_END
G1 E-.04 F1800
G1 X125.323 Y119.847 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G2 X130.677 Y119.833 I2.68 J1.15 E.3711
G1 X131.376 Y120.108 E.02413
G3 X136.161 Y125.322 I-3.405 J7.928 E.23451
G2 X136.161 Y130.678 I-1.155 J2.678 E.37099
G3 X130.677 Y136.167 I-8.233 J-2.743 E.25863
G2 X125.322 Y136.153 I-2.675 J-1.163 E.37108
G3 X119.852 Y130.681 I2.67 J-8.139 E.25815
G2 X119.852 Y125.319 I1.147 J-2.681 E.3704
G3 X125.266 Y119.866 I8.14 J2.667 E.25624
; WIPE_START
G1 X125.186 Y120.226 E-.14025
G1 X125.101 Y120.665 E-.16996
G1 X125.084 Y121.112 E-.16987
G1 X125.135 Y121.556 E-.1699
G1 X125.212 Y121.835 E-.11002
; WIPE_END
G1 E-.04 F1800
G1 X129.919 Y119.383 Z.8 F9000
G1 Z.4
G1 E.8 F1800
G1 F5895.652
G1 X130.016 Y119.238 E.0056
G3 X136.822 Y126.238 I-2.037 J8.79 E.33173
G1 X136.368 Y125.891 E.01838
G2 X136.368 Y130.109 I-1.361 J2.109 E.34609
G1 X136.822 Y129.762 E.01838
G3 X130.016 Y136.762 I-8.843 J-1.79 E.33174
G1 X129.919 Y136.617 E.0056
G2 X125.894 Y136.365 I-1.92 J-1.616 E.35634
G1 X126.236 Y136.814 E.01815
G3 X119.395 Y130.593 I1.775 J-8.823 E.31227
G3 X119.191 Y129.769 I6.766 J-2.115 E.02731
M73 P37 R12
G1 X119.637 Y130.109 E.01802
G2 X119.548 Y125.959 I1.365 J-2.105 E.34973
G1 X119.191 Y126.231 E.01442
G3 X126.236 Y119.186 I8.805 J1.759 E.33963
G1 X125.894 Y119.634 E.01815
G2 X129.957 Y119.43 I2.106 J1.364 E.35437
; WIPE_START
G1 X130.016 Y119.238 E-.07598
G1 X130.523 Y119.37 E-.19936
G1 X131.035 Y119.536 E-.20433
G1 X131.536 Y119.733 E-.20446
G1 X131.717 Y119.817 E-.07587
; WIPE_END
G1 E-.04 F1800
G1 X126.367 Y125.261 Z.8 F9000
G1 X122.978 Y128.709 Z.8
G1 Z.4
G1 E.8 F1800
G1 F5895.652
G1 X122.89 Y128.935 E.00779
G3 X121.002 Y125.901 I-1.88 J-.934 E.2868
G3 X122.278 Y126.327 I-.015 J2.168 E.04397
G3 X123.011 Y128.636 I-1.268 J1.674 E.08304
G1 X123.003 Y128.654 E.00066
M204 S250
G1 X122.614 Y128.563 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X122.541 Y128.762 E.00632
G3 X121.017 Y126.293 I-1.529 J-.761 E.21644
G3 X121.58 Y126.39 I-.053 J1.98 E.01709
G3 X122.642 Y128.51 I-.569 J1.611 E.07804
; WIPE_START
G1 X122.541 Y128.762 E-.10327
G1 X122.401 Y128.984 E-.09972
G1 X122.235 Y129.186 E-.09952
G1 X122.039 Y129.36 E-.09951
G1 X121.819 Y129.503 E-.09952
G1 X121.58 Y129.61 E-.09951
G1 X121.328 Y129.679 E-.09952
G1 X121.173 Y129.697 E-.05942
; WIPE_END
G1 E-.04 F1800
G1 X124.87 Y123.02 Z.8 F9000
G1 X127.3 Y118.633 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G3 X127.933 Y118.604 I.752 J9.805 E.02038
G3 X125.638 Y118.905 I.061 J9.395 E1.82356
G3 X127.24 Y118.637 I2.414 J9.533 E.0523
M204 S250
G1 X127.272 Y118.237 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X127.939 Y118.212 E.01989
G3 X125.539 Y118.525 I.054 J9.788 E1.75959
G3 X127.215 Y118.246 I2.511 J9.911 E.05067
; WIPE_START
G1 X127.939 Y118.212 E-.27535
G1 X128.441 Y118.22 E-.19085
G1 X129.026 Y118.264 E-.22261
G1 X129.211 Y118.289 E-.0712
; WIPE_END
G1 E-.04 F1800
G17
G3 Z.8 I1.217 J0 P1  F9000
; stop printing object, unique label id: 82
M625
; object ids of layer 2 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z0.8
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
        M623
    
    M623
M623
; SKIPPABLE_END


; object ids of this layer2 end: 82,118
M625
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X129.091 Y118.874 F9000
G1 Z.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.3531
G1 F7737.446
G1 X129.793 Y119.206 E.01903
G1 X129.818 Y119.168 F9000
; LINE_WIDTH: 0.177555
G1 X129.211 Y118.957 E.00683
; LINE_WIDTH: 0.155808
G1 X129.082 Y118.917 E.0012
; LINE_WIDTH: 0.116544
G1 X128.953 Y118.878 E.00078
; WIPE_START
G1 X129.082 Y118.917 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.042 Y118.883 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.117479
G1 F9000
G1 X126.917 Y118.919 E.00077
; LINE_WIDTH: 0.161176
G1 X126.778 Y118.96 E.00136
; LINE_WIDTH: 0.192035
G1 X126.754 Y118.97 E.00031
; LINE_WIDTH: 0.172894
G1 X126.636 Y119.083 E.00168
; LINE_WIDTH: 0.122973
G1 X126.518 Y119.197 E.00103
; LINE_WIDTH: 0.09706
G1 X126.497 Y119.221 E.00014
; WIPE_START
G1 X126.518 Y119.197 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.843 Y124.501 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6364.866
G3 X124.318 Y121.185 I1.159 J-3.501 E.13194
G1 X124.299 Y121.119 E.00202
G2 X121.116 Y124.313 I3.76 J6.932 E.13622
G3 X124.502 Y126.837 I-.113 J3.685 E.13396
G3 X126.785 Y124.519 I3.494 J1.158 E.10039
; WIPE_START
G1 X126.278 Y124.739 E-.21009
G1 X125.793 Y125.045 E-.21812
G1 X125.364 Y125.421 E-.2164
G1 X125.169 Y125.653 E-.11539
; WIPE_END
G1 E-.04 F1800
G1 X124.737 Y124.503 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.37621
G1 F7200.937
G1 X124.262 Y124.014 E.01797
; LINE_WIDTH: 0.41452
G1 F6458.557
G1 X124.103 Y123.824 E.00725
; LINE_WIDTH: 0.4616
G1 F5732.301
G1 X123.944 Y123.635 E.00817
; LINE_WIDTH: 0.50868
G1 F5152.869
G1 X123.786 Y123.445 E.00909
; LINE_WIDTH: 0.549687
G1 F4735.906
G1 X123.576 Y123.085 E.01667
G2 X123.081 Y123.584 I5.6 J6.054 E.02813
G1 X123.448 Y123.784 E.01669
; LINE_WIDTH: 0.50868
G1 F5152.869
G1 X123.637 Y123.942 E.00909
; LINE_WIDTH: 0.4616
G1 F5732.301
G1 X123.826 Y124.101 E.00817
; LINE_WIDTH: 0.41452
G1 F6458.557
G1 X124.016 Y124.259 E.00725
; LINE_WIDTH: 0.369549
G1 F7347.792
G3 X124.502 Y124.732 I-3.725 J4.318 E.01752
G1 X124.694 Y124.545 E.00691
G1 X124.502 Y125.273 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G3 X125.272 Y124.497 I4.211 J3.408 E.03262
G3 X124.15 Y123.21 I2.891 J-3.654 E.05116
G1 X123.857 Y122.596 E.02025
G1 X123.774 Y122.351 E.00771
G2 X122.353 Y123.772 I4.302 J5.726 E.06005
G1 X123.035 Y124.051 E.02195
G1 X123.614 Y124.407 E.02026
G1 X124.132 Y124.848 E.02026
G1 X124.463 Y125.228 E.01501
G1 X124.502 Y125.946 F9000
G1 F6364.866
G1 X124.719 Y125.603 E.01211
G3 X125.945 Y124.498 I3.467 J2.614 E.04944
G3 X124.004 Y121.733 I2.092 J-3.532 E.1037
G2 X121.736 Y124.002 I4.027 J6.293 E.09632
G3 X124.47 Y125.895 I-.722 J3.963 E.10212
; WIPE_START
G1 X124.285 Y125.603 E-.13167
G1 X123.881 Y125.13 E-.23648
G1 X123.409 Y124.724 E-.23651
G1 X123.062 Y124.508 E-.15535
; WIPE_END
G1 E-.04 F1800
G1 X124.75 Y127.469 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.422499
G1 F6322.808
G1 X124.848 Y126.987 E.01475
G3 X130.567 Y125.904 I3.154 J1.014 E.21309
G1 X130.932 Y126.499 E.02094
G3 X131.138 Y129.041 I-2.949 J1.519 E.07848
G3 X130.317 Y130.359 I-3.561 J-1.303 E.04691
G1 X129.815 Y130.773 E.0195
G3 X127.358 Y131.249 I-1.813 J-2.773 E.07696
G1 X126.542 Y130.961 E.02593
G1 X126.006 Y130.643 E.0187
G3 X124.716 Y128.523 I2.207 J-2.796 E.07599
G3 X124.744 Y127.528 I3.085 J-.411 E.02997
G1 X124.314 Y127.986 F9000
; LINE_WIDTH: 0.420655
G1 F6353.665
G1 X124.296 Y128.493 E.01514
M73 P38 R12
G3 X123.022 Y130.626 I-3.521 J-.656 E.07571
G3 X120.493 Y131.267 I-2.006 J-2.605 E.08005
G2 X124.735 Y135.507 I7.52 J-3.281 E.18323
G1 X124.692 Y134.888 E.01854
G3 X126.005 Y132.37 I3.276 J.109 E.08762
G1 X126.513 Y132.042 E.01805
G3 X131.269 Y135.51 I1.489 J2.952 E.21653
G2 X135.504 Y131.268 I-3.282 J-7.512 E.1831
G1 X134.89 Y131.311 E.01837
G3 X135.51 Y124.733 I.112 J-3.307 E.32208
G2 X131.271 Y120.502 I-7.491 J3.266 E.18296
G1 X131.313 Y121.112 E.01826
G3 X124.735 Y120.493 I-3.307 J-.112 E.32208
G2 X120.507 Y124.731 I3.267 J7.489 E.1829
G1 X121.034 Y124.692 E.01579
G1 X121.619 Y124.745 E.0175
G3 X124.31 Y127.926 I-.645 J3.275 E.13426
; WIPE_START
G1 X124.277 Y127.479 E-.17012
G1 X124.156 Y126.987 E-.1928
G1 X123.964 Y126.517 E-.19268
G1 X123.703 Y126.082 E-.19271
G1 X123.684 Y126.059 E-.0117
; WIPE_END
G1 E-.04 F1800
G1 X124.502 Y130.054 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X124.285 Y130.397 E.01211
G3 X121.736 Y131.998 I-3.281 J-2.396 E.09184
G2 X124.004 Y134.267 I6.242 J-3.971 E.09634
G3 X125.952 Y131.507 I3.945 J.716 E.10388
G3 X124.534 Y130.105 I1.92 J-3.358 E.06007
G1 X124.502 Y130.727 F9000
G1 F6364.866
G3 X123.212 Y131.853 I-3.659 J-2.89 E.05129
G1 X122.599 Y132.145 E.02025
G1 X122.353 Y132.228 E.00774
G2 X123.774 Y133.649 I5.469 J-4.051 E.06008
G1 X123.996 Y133.094 E.01779
G1 X124.41 Y132.389 E.02437
G1 X124.85 Y131.871 E.02025
G3 X125.273 Y131.505 I2.83 J2.843 E.01667
G3 X124.542 Y130.772 I2.413 J-3.14 E.03093
G1 X124.737 Y131.497 F9000
; LINE_WIDTH: 0.371395
G1 F7306.497
G1 X124.502 Y131.268 E.00851
G1 X124.016 Y131.741 E.01761
; LINE_WIDTH: 0.414525
G1 F6458.471
G1 X123.826 Y131.899 E.00725
; LINE_WIDTH: 0.461595
G1 F5732.37
G1 X123.637 Y132.058 E.00817
; LINE_WIDTH: 0.508665
G1 F5153.034
G1 X123.448 Y132.216 E.00908
; LINE_WIDTH: 0.549748
G1 F4735.338
G1 X123.081 Y132.416 E.0167
G1 X123.476 Y132.819 E.02257
G1 X123.59 Y132.912 E.0059
G1 X123.786 Y132.555 E.01633
; LINE_WIDTH: 0.509334
G1 F5145.651
G1 X123.933 Y132.377 E.00848
; LINE_WIDTH: 0.4636
G1 F5705.049
G1 X124.08 Y132.2 E.00765
; LINE_WIDTH: 0.417867
G1 F6400.91
G1 X124.227 Y132.023 E.00682
; LINE_WIDTH: 0.375637
G1 F7213.354
G3 X124.694 Y131.538 I5.388 J4.72 E.01769
; WIPE_START
G1 X124.227 Y132.023 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.846 Y131.492 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X126.301 Y131.271 E.01752
G1 X125.801 Y130.96 E.01756
G3 X124.502 Y129.163 I2.198 J-2.956 E.06707
G3 X121.116 Y131.687 I-3.532 J-1.205 E.13372
G2 X124.248 Y134.851 I6.934 J-3.731 E.13444
G1 X124.314 Y134.872 E.00208
G3 X125.801 Y132.054 I3.671 J.135 E.09816
G1 X126.308 Y131.725 E.01802
G1 X126.791 Y131.516 E.01567
; WIPE_START
G1 X126.308 Y131.725 E-.19997
G1 X125.801 Y132.054 E-.22989
G1 X125.413 Y132.372 E-.19056
G1 X125.172 Y132.65 E-.13958
; WIPE_END
G1 E-.04 F1800
G1 X130.058 Y131.501 Z.8 F9000
G1 Z.4
G1 E.8 F1800
G1 F6364.866
G3 X131.191 Y132.478 I-2.184 J3.676 E.04479
G3 X132 Y134.267 I-3.187 J2.52 E.05906
G2 X134.267 Y132.002 I-3.996 J-6.265 E.0962
G3 X132.596 Y131.276 I.99 J-4.565 E.05462
G3 X131.505 Y130.058 I2.744 J-3.555 E.04898
G1 X131.184 Y130.53 E.017
G3 X130.109 Y131.47 I-3.642 J-3.078 E.04268
G1 X130.728 Y131.499 F9000
G1 F6364.866
G3 X131.855 Y132.79 I-2.891 J3.662 E.05134
G3 X132.234 Y133.645 I-5.313 J2.868 E.02788
G2 X133.652 Y132.228 I-4.652 J-6.076 E.05987
G1 X133.007 Y131.966 E.02075
G1 X132.391 Y131.593 E.02146
G1 X131.873 Y131.152 E.02024
G1 X131.518 Y130.746 E.01606
G3 X130.773 Y131.459 I-4.875 J-4.348 E.03076
G1 X131.499 Y131.264 F9000
; LINE_WIDTH: 0.371251
G1 F7309.709
G1 X131.272 Y131.499 E.00846
G1 X131.743 Y131.986 E.01757
; LINE_WIDTH: 0.414519
G1 F6458.587
G1 X131.901 Y132.176 E.00725
; LINE_WIDTH: 0.461595
G1 F5732.37
G1 X132.06 Y132.365 E.00817
; LINE_WIDTH: 0.508672
G1 F5152.96
G1 X132.218 Y132.555 E.00909
; LINE_WIDTH: 0.549513
G1 F4737.532
G1 X132.418 Y132.92 E.01666
G2 X132.923 Y132.416 I-3.612 J-4.123 E.02858
G1 X132.557 Y132.216 E.01669
; LINE_WIDTH: 0.509342
G1 F5145.559
G1 X132.38 Y132.069 E.00848
; LINE_WIDTH: 0.463605
G1 F5704.981
G1 X132.202 Y131.922 E.00765
; LINE_WIDTH: 0.417869
G1 F6400.882
G1 X132.025 Y131.775 E.00682
; LINE_WIDTH: 0.375584
G1 F7214.489
G3 X131.54 Y131.307 I4.401 J-5.05 E.01771
; WIPE_START
G1 X132.025 Y131.775 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.259 Y129.703 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X130.957 Y130.198 E.01727
G3 X129.157 Y131.497 I-2.959 J-2.205 E.06716
G3 X131.689 Y134.885 I-1.203 J3.54 E.13393
G2 X134.888 Y131.687 I-3.674 J-6.874 E.13671
G3 X133.315 Y131.278 I.228 J-4.105 E.04872
G1 X132.801 Y130.96 E.01803
G3 X131.498 Y129.154 I2.423 J-3.12 E.06721
G1 X131.283 Y129.648 E.01604
; WIPE_START
G1 X131.498 Y129.154 E-.20459
G1 X131.716 Y129.675 E-.21456
G1 X132.01 Y130.157 E-.21456
G1 X132.225 Y130.411 E-.12629
; WIPE_END
G1 E-.04 F1800
G1 X131.262 Y126.317 Z.8 F9000
G1 Z.4
G1 E.8 F1800
G1 F6364.866
G3 X131.498 Y126.846 I-1.454 J.966 E.01733
G3 X134.888 Y124.313 I3.531 J1.192 E.13403
G2 X133.402 Y122.352 I-6.938 J3.715 E.07359
G2 X131.689 Y121.115 I-5.559 J5.891 E.06312
G3 X131.263 Y122.724 I-4.122 J-.23 E.04992
G3 X129.157 Y124.503 I-3.361 J-1.843 E.08402
G3 X131.232 Y126.265 I-1.13 J3.433 E.08313
G1 X131.495 Y125.958 F9000
G1 F6364.866
G3 X133.526 Y124.215 I3.512 J2.036 E.08126
G3 X134.267 Y123.998 I2.099 J5.803 E.02301
G2 X132 Y121.733 I-6.295 J4.033 E.09619
G1 X131.866 Y122.254 E.01604
G1 X131.607 Y122.878 E.02012
G3 X130.399 Y124.283 I-3.991 J-2.21 E.05557
G1 X130.058 Y124.499 E.01203
G1 X130.652 Y124.918 E.02166
G3 X131.465 Y125.906 I-2.976 J3.274 E.03825
; WIPE_START
G1 X131.348 Y125.703 E-.08931
G1 X131.009 Y125.272 E-.20807
G1 X130.652 Y124.918 E-.19115
G1 X130.069 Y124.506 E-.27148
; WIPE_END
G1 E-.04 F1800
G1 X131.499 Y124.736 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.37609
G1 F7203.53
G1 X131.989 Y124.259 E.01799
; LINE_WIDTH: 0.41452
G1 F6458.557
G1 X132.178 Y124.101 E.00725
; LINE_WIDTH: 0.46158
G1 F5732.576
G1 X132.367 Y123.942 E.00817
; LINE_WIDTH: 0.50864
G1 F5153.311
G1 X132.557 Y123.784 E.00908
; LINE_WIDTH: 0.549481
G1 F4737.837
G1 X132.923 Y123.584 E.01669
G2 X132.418 Y123.08 I-3.768 J3.269 E.02858
G1 X132.218 Y123.445 E.01666
; LINE_WIDTH: 0.50864
G1 F5153.311
G1 X132.06 Y123.635 E.00908
; LINE_WIDTH: 0.46158
G1 F5732.576
G1 X131.902 Y123.824 E.00816
; LINE_WIDTH: 0.41452
G1 F6458.557
G1 X131.743 Y124.013 E.00725
; LINE_WIDTH: 0.36962
G1 F7346.198
G2 X131.283 Y124.511 I4.824 J4.925 E.01751
G1 X131.457 Y124.693 E.0065
G1 X130.728 Y124.501 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G3 X131.492 Y125.253 I-2.949 J3.762 E.032
G3 X133.652 Y123.772 I3.722 J3.112 E.07899
G2 X132.234 Y122.355 I-5.457 J4.046 E.05992
G1 X131.951 Y123.033 E.02186
G1 X131.595 Y123.612 E.02026
G1 X131.154 Y124.129 E.02025
G1 X130.773 Y124.462 E.01506
; WIPE_START
G1 X131.154 Y124.129 E-.19218
G1 X131.595 Y123.612 E-.2583
G1 X131.951 Y123.033 E-.25842
G1 X132.003 Y122.908 E-.0511
; WIPE_END
G1 E-.04 F1800
G1 X136.781 Y126.494 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970654
G1 F9000
G1 X136.805 Y126.516 E.00014
; LINE_WIDTH: 0.122804
G1 X136.918 Y126.633 E.00102
; LINE_WIDTH: 0.172326
G1 X137.03 Y126.749 E.00166
; LINE_WIDTH: 0.188856
G1 X137.042 Y126.781 E.00039
; LINE_WIDTH: 0.15806
G1 X137.083 Y126.916 E.00128
; LINE_WIDTH: 0.116755
G1 X137.12 Y127.041 E.00076
; WIPE_START
G1 X137.083 Y126.916 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.121 Y128.959 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.116752
G1 F9000
G1 X137.083 Y129.084 E.00076
; LINE_WIDTH: 0.158083
G1 X137.042 Y129.219 E.00129
; LINE_WIDTH: 0.188856
G1 X137.03 Y129.25 E.00039
; LINE_WIDTH: 0.172289
G1 X136.918 Y129.367 E.00166
; LINE_WIDTH: 0.122772
G1 X136.805 Y129.484 E.00102
; LINE_WIDTH: 0.0970554
G1 X136.782 Y129.506 E.00014
; WIPE_START
G1 X136.805 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.383 Y134.856 Z.8 F9000
G1 X129.091 Y137.126 Z.8
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.353151
G1 F7736.185
G1 X129.793 Y136.794 E.01903
G1 X129.818 Y136.832 F9000
; LINE_WIDTH: 0.177519
G1 X129.211 Y137.043 E.00683
; LINE_WIDTH: 0.155797
G1 X129.082 Y137.083 E.0012
; LINE_WIDTH: 0.116545
G1 X128.953 Y137.122 E.00078
; WIPE_START
G1 X129.082 Y137.083 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.042 Y137.117 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.117491
G1 F9000
G1 X126.917 Y137.081 E.00077
; LINE_WIDTH: 0.161211
G1 X126.778 Y137.04 E.00136
; LINE_WIDTH: 0.192079
G1 X126.754 Y137.03 E.00031
; LINE_WIDTH: 0.172947
G1 X126.636 Y136.917 E.00168
; LINE_WIDTH: 0.12304
G1 X126.518 Y136.803 E.00103
; LINE_WIDTH: 0.097089
G1 X126.496 Y136.779 E.00014
; WIPE_START
G1 X126.518 Y136.803 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.122 Y131.405 Z.8 F9000
G1 X119.223 Y129.506 Z.8
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.0970835
G1 F9000
G1 X119.199 Y129.484 E.00014
; LINE_WIDTH: 0.122741
G1 X119.087 Y129.368 E.00102
; LINE_WIDTH: 0.175227
G1 X118.975 Y129.251 E.00169
G1 X118.958 Y129.209 E.00047
; LINE_WIDTH: 0.157741
G1 X118.922 Y129.092 E.00111
; LINE_WIDTH: 0.117852
G1 X118.883 Y128.956 E.00083
; WIPE_START
G1 X118.922 Y129.092 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.883 Y127.044 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.117847
G1 F9000
G1 X118.922 Y126.908 E.00083
; LINE_WIDTH: 0.157736
G1 X118.958 Y126.791 E.00111
; LINE_WIDTH: 0.175218
G1 X118.975 Y126.749 E.00047
G1 X119.087 Y126.632 E.00169
; LINE_WIDTH: 0.122719
G1 X119.199 Y126.516 E.00102
; LINE_WIDTH: 0.0970684
G1 X119.223 Y126.494 E.00014
; OBJECT_ID: 118
; WIPE_START
G1 X119.199 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X113.571 Y131.672 Z.8 F9000
G1 X107.831 Y136.931 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X107.791 Y136.946 E.00138
G3 X106.926 Y132.902 I-.784 J-1.946 E.23524
G3 X108.148 Y133.238 I.071 J2.131 E.04136
G3 X108.147 Y136.761 I-1.141 J1.761 E.13444
G1 X107.884 Y136.903 E.00961
M204 S250
G1 X107.647 Y136.586 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X107.647 Y136.588 E.00006
G3 X106.956 Y133.293 I-.631 J-1.587 E.1773
G3 X107.523 Y133.369 I.023 J1.979 E.01709
G3 X107.925 Y136.446 I-.507 J1.631 E.11596
G1 X107.701 Y136.559 E.00748
; WIPE_START
G1 X107.647 Y136.588 E-.02328
G1 X107.396 Y136.666 E-.09958
G1 X107.138 Y136.706 E-.09953
G1 X106.876 Y136.706 E-.0995
G1 X106.617 Y136.666 E-.09953
G1 X106.367 Y136.587 E-.09953
G1 X106.133 Y136.47 E-.0995
G1 X105.918 Y136.32 E-.09952
G1 X105.842 Y136.247 E-.04003
; WIPE_END
G1 E-.04 F1800
G1 X111.284 Y130.894 Z.8 F9000
G1 X115.609 Y126.64 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X115.631 Y126.66 E.00098
G3 X113.846 Y125.907 I-1.617 J1.34 E.35948
G3 X115.15 Y126.234 I.151 J2.163 E.04396
G3 X115.407 Y126.429 I-1.136 J1.766 E.01037
G1 X115.567 Y126.596 E.00746
M204 S250
G1 X115.33 Y126.909 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X113.891 Y126.296 I-1.314 J1.091 E.2713
G3 X114.46 Y126.351 I.099 J1.978 E.01708
M73 P39 R12
G3 X115.291 Y126.863 I-.444 J1.649 E.0295
; WIPE_START
G1 X115.477 Y127.126 E-.12232
G1 X115.593 Y127.361 E-.09949
G1 X115.672 Y127.61 E-.09952
G1 X115.712 Y127.869 E-.09954
G1 X115.712 Y128.131 E-.0995
G1 X115.672 Y128.39 E-.09953
G1 X115.593 Y128.64 E-.09953
G1 X115.546 Y128.735 E-.04055
; WIPE_END
G1 E-.04 F1800
G1 X110.914 Y122.669 Z.8 F9000
G1 X108.557 Y119.581 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X108.577 Y119.6 E.00089
G3 X106.846 Y118.902 I-1.57 J1.398 E.3626
G3 X107.716 Y119.024 I.125 J2.276 E.02845
G1 X107.793 Y119.049 E.0026
G3 X108.345 Y119.377 I-.786 J1.95 E.02073
G1 X108.514 Y119.54 E.00754
M204 S250
G1 X108.283 Y119.862 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X106.876 Y119.294 I-1.277 J1.136 E.273
G1 X107.138 Y119.294 E.0078
G3 X108.243 Y119.818 I-.131 J1.704 E.03725
; WIPE_START
G1 X108.443 Y120.07 E-.12218
G1 X108.568 Y120.3 E-.09953
G1 X108.656 Y120.547 E-.09954
G1 X108.706 Y120.804 E-.0995
G1 X108.716 Y121.065 E-.09949
G1 X108.686 Y121.326 E-.09955
G1 X108.617 Y121.578 E-.09952
G1 X108.573 Y121.676 E-.04068
; WIPE_END
G1 E-.04 F1800
G1 X104.445 Y126.61 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X104.624 Y126.324 E.01085
G3 X106.718 Y125.102 I2.381 J1.676 E.08042
G3 X106.191 Y130.796 I.295 J2.899 E.33066
G3 X104.396 Y126.707 I.815 J-2.796 E.16359
G1 X104.418 Y126.664 E.00157
G1 X104.795 Y126.818 F9000
G1 F5895.652
G1 X104.957 Y126.558 E.00985
G3 X106.765 Y125.507 I2.049 J1.442 E.06938
G3 X106.299 Y130.403 I.247 J2.494 E.28444
G3 X104.761 Y126.888 I.707 J-2.403 E.14051
G1 X104.769 Y126.872 E.00057
G1 X105.145 Y127.026 F9000
G1 F5895.652
G1 X105.289 Y126.792 E.00885
G3 X106.812 Y125.911 I1.717 J1.211 E.05837
G3 X108.049 Y126.179 I.193 J2.1 E.04135
G3 X105.119 Y127.08 I-1.043 J1.824 E.31398
M204 S250
G1 X105.482 Y127.227 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X105.616 Y127.022 E.00729
G3 X106.857 Y126.3 I1.399 J.98 E.04412
G3 X107.706 Y126.439 I.166 J1.654 E.02594
G3 X105.466 Y127.283 I-.691 J1.562 E.24069
; WIPE_START
G1 X105.616 Y127.022 E-.11445
G1 X105.774 Y126.814 E-.0993
G1 X105.97 Y126.64 E-.09951
G1 X106.19 Y126.497 E-.09953
G1 X106.428 Y126.39 E-.0995
G1 X106.681 Y126.321 E-.09952
G1 X106.857 Y126.3 E-.06722
G1 X107.07 Y126.301 E-.08096
; WIPE_END
G1 E-.04 F1800
G1 X104.327 Y119.847 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G2 X109.682 Y119.833 I2.68 J1.15 E.3711
G1 X110.38 Y120.108 E.02413
G3 X115.165 Y125.322 I-3.405 J7.928 E.23451
G2 X115.165 Y130.678 I-1.155 J2.678 E.37099
G3 X109.682 Y136.167 I-8.233 J-2.743 E.25863
G2 X104.326 Y136.153 I-2.675 J-1.163 E.37108
G3 X98.856 Y130.681 I2.67 J-8.139 E.25815
G2 X98.856 Y125.319 I1.147 J-2.681 E.3704
G3 X104.27 Y119.866 I8.14 J2.667 E.25624
; WIPE_START
G1 X104.191 Y120.226 E-.14025
G1 X104.106 Y120.665 E-.16996
G1 X104.088 Y121.112 E-.16987
G1 X104.14 Y121.556 E-.1699
G1 X104.216 Y121.835 E-.11002
; WIPE_END
G1 E-.04 F1800
G1 X108.924 Y119.383 Z.8 F9000
G1 Z.4
G1 E.8 F1800
G1 F5895.652
G1 X109.02 Y119.238 E.0056
G3 X115.827 Y126.238 I-2.037 J8.79 E.33173
G1 X115.372 Y125.891 E.01838
G2 X115.372 Y130.109 I-1.361 J2.109 E.34609
G1 X115.827 Y129.762 E.01838
G3 X109.02 Y136.762 I-8.843 J-1.79 E.33174
G1 X108.924 Y136.617 E.0056
G2 X104.898 Y136.365 I-1.92 J-1.616 E.35634
G1 X105.24 Y136.814 E.01815
G3 X98.4 Y130.593 I1.775 J-8.823 E.31227
G3 X98.196 Y129.769 I6.766 J-2.115 E.02731
G1 X98.641 Y130.109 E.01802
G2 X98.552 Y125.959 I1.365 J-2.105 E.34973
G1 X98.196 Y126.231 E.01442
G3 X105.24 Y119.186 I8.805 J1.759 E.33963
G1 X104.898 Y119.634 E.01815
G2 X108.962 Y119.43 I2.106 J1.364 E.35437
; WIPE_START
G1 X109.02 Y119.238 E-.07598
G1 X109.528 Y119.37 E-.19936
G1 X110.039 Y119.536 E-.20433
G1 X110.54 Y119.733 E-.20446
G1 X110.721 Y119.817 E-.07587
; WIPE_END
G1 E-.04 F1800
G1 X105.372 Y125.261 Z.8 F9000
G1 X101.983 Y128.709 Z.8
G1 Z.4
G1 E.8 F1800
G1 F5895.652
G1 X101.895 Y128.935 E.00779
G3 X100.007 Y125.901 I-1.88 J-.934 E.2868
G3 X101.282 Y126.327 I-.015 J2.168 E.04397
G3 X102.016 Y128.636 I-1.268 J1.674 E.08304
G1 X102.007 Y128.654 E.00066
M204 S250
G1 X101.619 Y128.563 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X101.545 Y128.762 E.00632
G3 X100.022 Y126.293 I-1.529 J-.761 E.21644
G3 X100.585 Y126.39 I-.053 J1.98 E.01709
G3 X101.647 Y128.51 I-.569 J1.611 E.07804
; WIPE_START
G1 X101.545 Y128.762 E-.10327
G1 X101.406 Y128.984 E-.09972
G1 X101.239 Y129.186 E-.09952
G1 X101.044 Y129.36 E-.09951
G1 X100.824 Y129.503 E-.09952
G1 X100.585 Y129.61 E-.09951
G1 X100.332 Y129.679 E-.09952
G1 X100.177 Y129.697 E-.05942
; WIPE_END
G1 E-.04 F1800
G1 X103.875 Y123.02 Z.8 F9000
G1 X106.305 Y118.633 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G3 X106.938 Y118.604 I.752 J9.805 E.02038
G3 X104.642 Y118.905 I.061 J9.395 E1.82356
G3 X106.245 Y118.637 I2.414 J9.533 E.0523
M204 S250
G1 X106.276 Y118.237 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X106.944 Y118.212 E.01989
G3 X104.544 Y118.525 I.054 J9.788 E1.75959
G3 X106.22 Y118.246 I2.511 J9.911 E.05067
G1 X106.047 Y118.883 F9000
; FEATURE: Gap infill
; LINE_WIDTH: 0.117479
G1 X105.922 Y118.919 E.00077
; LINE_WIDTH: 0.161176
G1 X105.782 Y118.96 E.00136
; LINE_WIDTH: 0.192035
G1 X105.758 Y118.97 E.00031
; LINE_WIDTH: 0.172894
G1 X105.64 Y119.083 E.00168
; LINE_WIDTH: 0.122973
G1 X105.522 Y119.197 E.00103
; LINE_WIDTH: 0.09706
G1 X105.501 Y119.221 E.00014
; WIPE_START
G1 X105.522 Y119.197 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.958 Y118.878 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.116544
G1 F9000
G1 X108.087 Y118.917 E.00078
; LINE_WIDTH: 0.155808
G1 X108.216 Y118.957 E.0012
; LINE_WIDTH: 0.177555
G1 X108.822 Y119.168 E.00683
G1 X108.797 Y119.206
; LINE_WIDTH: 0.3531
G1 F7737.446
G1 X108.095 Y118.874 E.01903
; WIPE_START
G1 X108.797 Y119.206 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.847 Y124.501 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6364.866
G3 X103.323 Y121.185 I1.159 J-3.501 E.13194
G1 X103.304 Y121.119 E.00202
G2 X100.12 Y124.313 I3.76 J6.932 E.13622
G3 X103.507 Y126.837 I-.113 J3.685 E.13396
G3 X105.79 Y124.519 I3.494 J1.158 E.10039
; WIPE_START
G1 X105.283 Y124.739 E-.21009
G1 X104.797 Y125.045 E-.21812
G1 X104.369 Y125.421 E-.2164
G1 X104.174 Y125.653 E-.11539
; WIPE_END
G1 E-.04 F1800
G1 X103.742 Y124.503 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.37621
G1 F7200.937
G1 X103.266 Y124.014 E.01797
; LINE_WIDTH: 0.41452
G1 F6458.557
M73 P40 R12
G1 X103.107 Y123.824 E.00725
; LINE_WIDTH: 0.4616
G1 F5732.301
G1 X102.949 Y123.635 E.00817
; LINE_WIDTH: 0.50868
G1 F5152.869
G1 X102.79 Y123.445 E.00909
; LINE_WIDTH: 0.549687
G1 F4735.906
G1 X102.581 Y123.085 E.01667
G2 X102.086 Y123.584 I5.6 J6.054 E.02813
G1 X102.452 Y123.784 E.01669
; LINE_WIDTH: 0.50868
G1 F5152.869
G1 X102.641 Y123.942 E.00909
; LINE_WIDTH: 0.4616
G1 F5732.301
G1 X102.831 Y124.101 E.00817
; LINE_WIDTH: 0.41452
G1 F6458.557
G1 X103.02 Y124.259 E.00725
; LINE_WIDTH: 0.369549
G1 F7347.792
G3 X103.507 Y124.732 I-3.725 J4.318 E.01752
G1 X103.699 Y124.545 E.00691
G1 X103.507 Y125.273 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G3 X104.277 Y124.497 I4.211 J3.408 E.03262
G3 X103.154 Y123.21 I2.891 J-3.654 E.05116
G1 X102.862 Y122.596 E.02025
G1 X102.779 Y122.351 E.00771
G2 X101.357 Y123.772 I4.302 J5.726 E.06005
G1 X102.039 Y124.051 E.02195
G1 X102.618 Y124.407 E.02026
G1 X103.136 Y124.848 E.02026
G1 X103.467 Y125.228 E.01501
G1 X103.507 Y125.946 F9000
G1 F6364.866
G1 X103.724 Y125.603 E.01211
G3 X104.949 Y124.498 I3.467 J2.614 E.04944
G3 X103.009 Y121.733 I2.092 J-3.532 E.1037
G2 X100.74 Y124.002 I4.027 J6.293 E.09632
G3 X103.475 Y125.895 I-.722 J3.963 E.10212
; WIPE_START
G1 X103.29 Y125.603 E-.13167
G1 X102.885 Y125.13 E-.23648
G1 X102.413 Y124.724 E-.23651
G1 X102.066 Y124.508 E-.15535
; WIPE_END
G1 E-.04 F1800
G1 X103.755 Y127.469 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.422499
G1 F6322.808
G1 X103.853 Y126.987 E.01475
G3 X109.571 Y125.904 I3.154 J1.014 E.21309
G1 X109.936 Y126.499 E.02094
G3 X110.143 Y129.041 I-2.949 J1.519 E.07848
G3 X109.321 Y130.359 I-3.561 J-1.303 E.04691
G1 X108.819 Y130.773 E.0195
G3 X106.362 Y131.249 I-1.813 J-2.773 E.07696
G1 X105.547 Y130.961 E.02593
G1 X105.01 Y130.643 E.0187
G3 X103.72 Y128.523 I2.207 J-2.796 E.07599
G3 X103.748 Y127.528 I3.085 J-.411 E.02997
G1 X103.319 Y127.986 F9000
; LINE_WIDTH: 0.420655
G1 F6353.665
G1 X103.301 Y128.493 E.01514
G3 X102.026 Y130.626 I-3.521 J-.656 E.07571
G3 X99.497 Y131.267 I-2.006 J-2.605 E.08005
G2 X103.74 Y135.507 I7.52 J-3.281 E.18323
G1 X103.696 Y134.888 E.01854
G3 X105.01 Y132.37 I3.276 J.109 E.08762
G1 X105.518 Y132.042 E.01805
G3 X110.273 Y135.51 I1.489 J2.952 E.21653
G2 X114.508 Y131.268 I-3.282 J-7.512 E.1831
G1 X113.894 Y131.311 E.01837
G3 X114.514 Y124.733 I.112 J-3.307 E.32208
G2 X110.276 Y120.502 I-7.491 J3.266 E.18296
G1 X110.317 Y121.112 E.01826
G3 X103.74 Y120.493 I-3.307 J-.112 E.32208
G2 X99.511 Y124.731 I3.267 J7.489 E.1829
G1 X100.039 Y124.692 E.01579
G1 X100.623 Y124.745 E.0175
G3 X103.315 Y127.926 I-.645 J3.275 E.13426
; WIPE_START
G1 X103.282 Y127.479 E-.17012
G1 X103.16 Y126.987 E-.1928
G1 X102.969 Y126.517 E-.19268
G1 X102.708 Y126.082 E-.19271
G1 X102.688 Y126.059 E-.0117
; WIPE_END
G1 E-.04 F1800
G1 X103.507 Y130.054 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X103.29 Y130.397 E.01211
G3 X100.74 Y131.998 I-3.281 J-2.396 E.09184
G2 X103.009 Y134.267 I6.242 J-3.971 E.09634
G3 X104.956 Y131.507 I3.945 J.716 E.10388
G3 X103.539 Y130.105 I1.92 J-3.358 E.06007
G1 X103.507 Y130.727 F9000
G1 F6364.866
G3 X102.217 Y131.853 I-3.659 J-2.89 E.05129
G1 X101.603 Y132.145 E.02025
G1 X101.357 Y132.228 E.00774
G2 X102.779 Y133.649 I5.469 J-4.051 E.06008
G1 X103.001 Y133.094 E.01779
G1 X103.414 Y132.389 E.02437
G1 X103.855 Y131.871 E.02025
G3 X104.278 Y131.505 I2.83 J2.843 E.01667
G3 X103.546 Y130.772 I2.413 J-3.14 E.03093
G1 X103.742 Y131.497 F9000
; LINE_WIDTH: 0.371395
G1 F7306.497
G1 X103.507 Y131.268 E.00851
G1 X103.02 Y131.741 E.01761
; LINE_WIDTH: 0.414525
G1 F6458.471
G1 X102.831 Y131.899 E.00725
; LINE_WIDTH: 0.461595
G1 F5732.37
G1 X102.642 Y132.058 E.00817
; LINE_WIDTH: 0.508665
G1 F5153.034
G1 X102.452 Y132.216 E.00908
; LINE_WIDTH: 0.549748
G1 F4735.338
G1 X102.086 Y132.416 E.0167
G1 X102.481 Y132.819 E.02257
G1 X102.594 Y132.912 E.0059
G1 X102.79 Y132.555 E.01633
; LINE_WIDTH: 0.509334
G1 F5145.651
G1 X102.938 Y132.377 E.00848
; LINE_WIDTH: 0.4636
G1 F5705.049
G1 X103.085 Y132.2 E.00765
; LINE_WIDTH: 0.417867
G1 F6400.91
G1 X103.232 Y132.023 E.00682
; LINE_WIDTH: 0.375637
G1 F7213.354
G3 X103.698 Y131.538 I5.388 J4.72 E.01769
; WIPE_START
G1 X103.232 Y132.023 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.851 Y131.492 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X105.306 Y131.271 E.01752
G1 X104.805 Y130.96 E.01756
G3 X103.507 Y129.163 I2.198 J-2.956 E.06707
G3 X100.12 Y131.687 I-3.532 J-1.205 E.13372
G2 X103.252 Y134.851 I6.934 J-3.731 E.13444
G1 X103.319 Y134.872 E.00208
G3 X104.805 Y132.054 I3.671 J.135 E.09816
G1 X105.313 Y131.725 E.01802
G1 X105.796 Y131.516 E.01567
; WIPE_START
G1 X105.313 Y131.725 E-.19997
G1 X104.805 Y132.054 E-.22989
G1 X104.418 Y132.372 E-.19056
G1 X104.177 Y132.65 E-.13958
; WIPE_END
G1 E-.04 F1800
G1 X109.063 Y131.501 Z.8 F9000
G1 Z.4
G1 E.8 F1800
G1 F6364.866
G3 X110.195 Y132.478 I-2.184 J3.676 E.04479
G3 X111.005 Y134.267 I-3.187 J2.52 E.05906
G2 X113.271 Y132.002 I-3.996 J-6.265 E.0962
G3 X111.6 Y131.276 I.99 J-4.565 E.05462
G3 X110.509 Y130.058 I2.744 J-3.555 E.04898
G1 X110.188 Y130.53 E.017
G3 X109.114 Y131.47 I-3.642 J-3.078 E.04268
G1 X109.732 Y131.499 F9000
G1 F6364.866
G3 X110.859 Y132.79 I-2.891 J3.662 E.05134
G3 X111.238 Y133.645 I-5.313 J2.868 E.02788
G2 X112.657 Y132.228 I-4.652 J-6.076 E.05987
G1 X112.011 Y131.966 E.02075
G1 X111.395 Y131.593 E.02146
G1 X110.878 Y131.152 E.02024
G1 X110.523 Y130.746 E.01606
G3 X109.777 Y131.459 I-4.875 J-4.348 E.03076
G1 X110.503 Y131.264 F9000
; LINE_WIDTH: 0.371251
G1 F7309.709
G1 X110.277 Y131.499 E.00846
G1 X110.747 Y131.986 E.01757
; LINE_WIDTH: 0.414519
G1 F6458.587
G1 X110.906 Y132.176 E.00725
; LINE_WIDTH: 0.461595
G1 F5732.37
G1 X111.064 Y132.365 E.00817
; LINE_WIDTH: 0.508672
G1 F5152.96
G1 X111.223 Y132.555 E.00909
; LINE_WIDTH: 0.549513
G1 F4737.532
G1 X111.422 Y132.92 E.01666
G2 X111.927 Y132.416 I-3.612 J-4.123 E.02858
G1 X111.561 Y132.216 E.01669
; LINE_WIDTH: 0.509342
G1 F5145.559
G1 X111.384 Y132.069 E.00848
; LINE_WIDTH: 0.463605
M73 P40 R11
G1 F5704.981
G1 X111.207 Y131.922 E.00765
; LINE_WIDTH: 0.417869
G1 F6400.882
G1 X111.03 Y131.775 E.00682
; LINE_WIDTH: 0.375584
G1 F7214.489
G3 X110.545 Y131.307 I4.401 J-5.05 E.01771
; WIPE_START
G1 X111.03 Y131.775 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.264 Y129.703 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X109.961 Y130.198 E.01727
G3 X108.161 Y131.497 I-2.959 J-2.205 E.06716
G3 X110.694 Y134.885 I-1.203 J3.54 E.13393
G2 X113.893 Y131.687 I-3.674 J-6.874 E.13671
G3 X112.32 Y131.278 I.228 J-4.105 E.04872
G1 X111.805 Y130.96 E.01803
G3 X110.503 Y129.154 I2.423 J-3.12 E.06721
G1 X110.288 Y129.648 E.01604
; WIPE_START
G1 X110.503 Y129.154 E-.20459
G1 X110.72 Y129.675 E-.21456
G1 X111.015 Y130.157 E-.21456
G1 X111.229 Y130.411 E-.12629
; WIPE_END
G1 E-.04 F1800
G1 X110.267 Y126.317 Z.8 F9000
G1 Z.4
G1 E.8 F1800
G1 F6364.866
G3 X110.503 Y126.846 I-1.454 J.966 E.01733
G3 X113.893 Y124.313 I3.531 J1.192 E.13403
G2 X112.406 Y122.352 I-6.938 J3.715 E.07359
G2 X110.693 Y121.115 I-5.559 J5.891 E.06312
G3 X110.268 Y122.724 I-4.122 J-.23 E.04992
G3 X108.161 Y124.503 I-3.361 J-1.843 E.08402
G3 X110.236 Y126.265 I-1.13 J3.433 E.08313
G1 X110.5 Y125.958 F9000
G1 F6364.866
G3 X112.531 Y124.215 I3.512 J2.036 E.08126
G3 X113.271 Y123.998 I2.099 J5.803 E.02301
G2 X111.005 Y121.733 I-6.295 J4.033 E.09619
G1 X110.871 Y122.254 E.01604
G1 X110.612 Y122.878 E.02012
G3 X109.404 Y124.283 I-3.991 J-2.21 E.05557
G1 X109.063 Y124.499 E.01203
G1 X109.657 Y124.918 E.02166
G3 X110.47 Y125.906 I-2.976 J3.274 E.03825
; WIPE_START
G1 X110.352 Y125.703 E-.08931
G1 X110.014 Y125.272 E-.20807
G1 X109.657 Y124.918 E-.19115
G1 X109.073 Y124.506 E-.27148
; WIPE_END
G1 E-.04 F1800
G1 X110.503 Y124.736 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.37609
G1 F7203.53
G1 X110.993 Y124.259 E.01799
; LINE_WIDTH: 0.41452
G1 F6458.557
G1 X111.183 Y124.101 E.00725
; LINE_WIDTH: 0.46158
G1 F5732.576
G1 X111.372 Y123.942 E.00817
; LINE_WIDTH: 0.50864
G1 F5153.311
G1 X111.561 Y123.784 E.00908
; LINE_WIDTH: 0.549481
G1 F4737.837
G1 X111.927 Y123.584 E.01669
G2 X111.422 Y123.08 I-3.768 J3.269 E.02858
G1 X111.223 Y123.445 E.01666
; LINE_WIDTH: 0.50864
G1 F5153.311
G1 X111.065 Y123.635 E.00908
; LINE_WIDTH: 0.46158
G1 F5732.576
G1 X110.906 Y123.824 E.00816
; LINE_WIDTH: 0.41452
G1 F6458.557
G1 X110.748 Y124.013 E.00725
; LINE_WIDTH: 0.36962
G1 F7346.198
G2 X110.287 Y124.511 I4.824 J4.925 E.01751
G1 X110.462 Y124.693 E.0065
G1 X109.732 Y124.501 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G3 X110.497 Y125.253 I-2.949 J3.762 E.032
G3 X112.657 Y123.772 I3.722 J3.112 E.07899
G2 X111.238 Y122.355 I-5.457 J4.046 E.05992
G1 X110.956 Y123.033 E.02186
G1 X110.599 Y123.612 E.02026
G1 X110.159 Y124.129 E.02025
G1 X109.778 Y124.462 E.01506
; WIPE_START
G1 X110.159 Y124.129 E-.19218
G1 X110.599 Y123.612 E-.2583
G1 X110.956 Y123.033 E-.25842
G1 X111.008 Y122.908 E-.0511
; WIPE_END
G1 E-.04 F1800
G1 X115.786 Y126.494 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970654
G1 F9000
G1 X115.81 Y126.516 E.00014
; LINE_WIDTH: 0.122804
G1 X115.922 Y126.633 E.00102
; LINE_WIDTH: 0.172326
G1 X116.035 Y126.749 E.00166
; LINE_WIDTH: 0.188856
G1 X116.047 Y126.781 E.00039
; LINE_WIDTH: 0.15806
G1 X116.088 Y126.916 E.00128
; LINE_WIDTH: 0.116755
G1 X116.125 Y127.041 E.00076
; WIPE_START
G1 X116.088 Y126.916 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.125 Y128.959 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.116752
G1 F9000
G1 X116.088 Y129.084 E.00076
; LINE_WIDTH: 0.158083
G1 X116.047 Y129.219 E.00129
; LINE_WIDTH: 0.188856
G1 X116.035 Y129.25 E.00039
; LINE_WIDTH: 0.172289
G1 X115.922 Y129.367 E.00166
; LINE_WIDTH: 0.122772
G1 X115.81 Y129.484 E.00102
; LINE_WIDTH: 0.0970554
G1 X115.786 Y129.506 E.00014
; WIPE_START
G1 X115.81 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.526 Y134.992 Z.8 F9000
G1 X108.797 Y136.794 Z.8
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.353151
G1 F7736.185
G1 X108.095 Y137.126 E.01903
G1 X108.087 Y137.083 F9000
; LINE_WIDTH: 0.116545
G1 X107.958 Y137.122 E.00078
G1 X108.087 Y137.083
; LINE_WIDTH: 0.155797
G1 X108.215 Y137.043 E.0012
; LINE_WIDTH: 0.177519
G1 X108.822 Y136.832 E.00683
; WIPE_START
G1 X108.215 Y137.043 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X106.047 Y137.117 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.117491
G1 F9000
G1 X105.922 Y137.081 E.00077
; LINE_WIDTH: 0.161211
G1 X105.782 Y137.04 E.00136
; LINE_WIDTH: 0.192079
G1 X105.758 Y137.03 E.00031
; LINE_WIDTH: 0.172947
G1 X105.64 Y136.917 E.00168
; LINE_WIDTH: 0.12304
G1 X105.522 Y136.803 E.00103
; LINE_WIDTH: 0.097089
G1 X105.501 Y136.779 E.00014
; WIPE_START
G1 X105.522 Y136.803 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.126 Y131.405 Z.8 F9000
G1 X98.228 Y129.506 Z.8
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.0970835
G1 F9000
G1 X98.204 Y129.484 E.00014
; LINE_WIDTH: 0.122741
G1 X98.091 Y129.368 E.00102
; LINE_WIDTH: 0.175227
G1 X97.979 Y129.251 E.00169
G1 X97.963 Y129.209 E.00047
; LINE_WIDTH: 0.157741
G1 X97.926 Y129.092 E.00111
; LINE_WIDTH: 0.117852
G1 X97.888 Y128.956 E.00083
; WIPE_START
M73 P41 R11
G1 X97.926 Y129.092 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X97.888 Y127.044 Z.8 F9000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.117847
G1 F9000
G1 X97.926 Y126.908 E.00083
; LINE_WIDTH: 0.157736
G1 X97.963 Y126.791 E.00111
; LINE_WIDTH: 0.175218
G1 X97.979 Y126.749 E.00047
G1 X98.091 Y126.632 E.00169
; LINE_WIDTH: 0.122719
G1 X98.204 Y126.516 E.00102
; LINE_WIDTH: 0.0970684
G1 X98.228 Y126.494 E.00014
; CHANGE_LAYER
; Z_HEIGHT: 0.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F9000
G1 X98.204 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 118
M625
; layer num/total_layer_count: 3/23
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G17
G3 Z.8 I-.392 J1.152 P1  F9000
G1 X128.815 Y136.938 Z.8
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X128.789 Y136.952 E.00096
G3 X127.899 Y132.904 I-.779 J-1.951 E.23426
G3 X129.213 Y133.279 I.095 J2.155 E.0447
G3 X129.078 Y136.81 I-1.202 J1.722 E.135
G1 X128.869 Y136.912 E.00747
M204 S250
G1 X128.642 Y136.587 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X127.929 Y133.295 I-.631 J-1.586 E.17662
G3 X128.761 Y133.467 I.09 J1.663 E.0256
G3 X128.697 Y136.564 I-.751 J1.534 E.11557
; WIPE_START
G1 X128.392 Y136.666 E-.12223
G1 X128.133 Y136.706 E-.09954
G1 X127.871 Y136.706 E-.0995
G1 X127.612 Y136.666 E-.09953
G1 X127.363 Y136.587 E-.09954
G1 X127.128 Y136.47 E-.09948
G1 X126.914 Y136.32 E-.09952
G1 X126.837 Y136.246 E-.04065
; WIPE_END
G1 E-.04 F1800
G1 X132.279 Y130.894 Z1 F9000
G1 X136.605 Y126.641 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X136.627 Y126.66 E.00093
G3 X134.819 Y125.91 I-1.617 J1.341 E.35889
G3 X136.146 Y126.234 I.177 J2.15 E.0447
G3 X136.403 Y126.429 I-1.135 J1.767 E.01037
G1 X136.564 Y126.597 E.00751
M204 S250
G1 X136.324 Y126.91 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X134.864 Y126.299 I-1.314 J1.091 E.2706
G3 X135.702 Y126.439 I.154 J1.658 E.0256
G3 X136.285 Y126.864 I-.692 J1.562 E.02166
; WIPE_START
G1 X136.473 Y127.126 E-.12228
G1 X136.589 Y127.361 E-.09949
G1 X136.668 Y127.61 E-.09952
G1 X136.708 Y127.869 E-.09954
G1 X136.708 Y128.131 E-.0995
G1 X136.668 Y128.39 E-.09954
G1 X136.589 Y128.639 E-.09952
G1 X136.541 Y128.735 E-.0406
; WIPE_END
G1 E-.04 F1800
G1 X131.91 Y122.669 Z1 F9000
G1 X129.553 Y119.581 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X129.573 Y119.6 E.00091
G3 X125.912 Y121.184 I-1.569 J1.397 E.25538
G3 X127.841 Y118.902 I2.098 J-.182 E.1068
G3 X129.341 Y119.376 I.163 J2.095 E.05185
G1 X129.51 Y119.539 E.00753
M204 S250
G1 X129.279 Y119.862 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X127.871 Y119.294 I-1.277 J1.137 E.27308
G3 X128.572 Y119.391 I.102 J1.844 E.02119
G1 X128.642 Y119.413 E.00219
G3 X129.238 Y119.818 I-.639 J1.585 E.02164
; WIPE_START
G1 X129.438 Y120.07 E-.12219
G1 X129.563 Y120.3 E-.09954
G1 X129.652 Y120.547 E-.09953
G1 X129.702 Y120.804 E-.09951
G1 X129.712 Y121.065 E-.09949
G1 X129.682 Y121.326 E-.09955
G1 X129.612 Y121.578 E-.09951
G1 X129.568 Y121.676 E-.04069
; WIPE_END
G1 E-.04 F1800
G1 X125.441 Y126.61 Z1 F9000
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X125.623 Y126.327 E.01082
G3 X127.668 Y125.107 I2.385 J1.677 E.07887
G3 X130.711 Y126.908 I.335 J2.905 E.12209
G3 X125.396 Y126.709 I-2.702 J1.095 E.37374
G1 X125.416 Y126.664 E.00159
G1 X125.791 Y126.818 F9000
G1 F5895.652
G1 X125.949 Y126.556 E.00984
G3 X127.715 Y125.512 I2.046 J1.446 E.06796
G3 X128.849 Y130.357 I.295 J2.486 E.23497
G3 X125.752 Y126.886 I-.853 J-2.356 E.19173
G1 X125.761 Y126.87 E.00059
G1 X126.141 Y127.026 F9000
G1 F5895.652
G1 X126.29 Y126.796 E.00881
G3 X127.762 Y125.916 I1.719 J1.206 E.05679
G3 X129.402 Y126.429 I.236 J2.124 E.05688
G3 X126.121 Y127.082 I-1.392 J1.572 E.29991
M204 S250
G1 X126.478 Y127.226 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X126.606 Y127.018 E.00728
G3 X127.807 Y126.306 I1.396 J.985 E.04284
G3 X128.817 Y126.502 I.196 J1.694 E.03114
G3 X126.454 Y127.281 I-.815 J1.501 E.23663
; WIPE_START
G1 X126.606 Y127.018 E-.11546
G1 X126.77 Y126.814 E-.09943
G1 X126.965 Y126.64 E-.09951
G1 X127.185 Y126.497 E-.09953
G1 X127.424 Y126.39 E-.09949
G1 X127.677 Y126.321 E-.09953
G1 X127.807 Y126.306 E-.04977
G1 X127.937 Y126.291 E-.04978
G1 X128.062 Y126.295 E-.0475
; WIPE_END
G1 E-.04 F1800
G1 X125.323 Y119.847 Z1 F9000
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G2 X130.677 Y119.833 I2.68 J1.15 E.3711
G1 X131.376 Y120.108 E.02413
G3 X136.161 Y125.322 I-3.417 J7.939 E.23448
G2 X136.161 Y130.678 I-1.155 J2.678 E.37094
G3 X130.677 Y136.167 I-8.233 J-2.742 E.25866
G2 X125.322 Y136.153 I-2.674 J-1.163 E.37111
G3 X119.852 Y130.681 I2.694 J-8.164 E.2581
G2 X119.852 Y125.319 I1.153 J-2.681 E.37099
G3 X125.266 Y119.866 I8.149 J2.676 E.25621
; WIPE_START
G1 X125.186 Y120.226 E-.14021
G1 X125.101 Y120.665 E-.16998
G1 X125.084 Y121.112 E-.16979
G1 X125.135 Y121.556 E-.16998
G1 X125.212 Y121.835 E-.11006
; WIPE_END
G1 E-.04 F1800
G1 X129.919 Y119.383 Z1 F9000
G1 Z.6
G1 E.8 F1800
G1 F5895.652
G1 X130.016 Y119.238 E.0056
G3 X136.822 Y126.238 I-2.031 J8.784 E.33177
G1 X136.368 Y125.891 E.01838
G2 X134.772 Y125.505 I-1.371 J2.176 E.05373
G2 X136.368 Y130.109 I.235 J2.497 E.29207
G1 X136.822 Y129.762 E.01838
G3 X130.016 Y136.762 I-8.843 J-1.79 E.33173
G1 X129.919 Y136.617 E.0056
G2 X125.894 Y136.365 I-1.92 J-1.613 E.35601
G1 X126.236 Y136.814 E.01815
G3 X119.191 Y129.769 I1.776 J-8.821 E.33953
G1 X119.637 Y130.109 E.01802
G2 X119.637 Y125.891 I1.365 J-2.109 E.34662
G1 X119.191 Y126.231 E.01802
G3 X126.236 Y119.186 I8.812 J1.767 E.33958
G1 X125.894 Y119.634 E.01814
G1 X125.829 Y119.753 E.00434
G2 X125.507 Y121.23 I2.187 J1.25 E.04937
G2 X129.957 Y119.43 I2.496 J-.231 E.3003
; WIPE_START
G1 X130.016 Y119.238 E-.07596
G1 X130.523 Y119.37 E-.19929
G1 X131.035 Y119.537 E-.20448
G1 X131.536 Y119.733 E-.20433
G1 X131.717 Y119.817 E-.07594
; WIPE_END
G1 E-.04 F1800
G1 X126.362 Y125.256 Z1 F9000
G1 X122.988 Y128.684 Z1
G1 Z.6
G1 E.8 F1800
G1 F5895.652
G1 X122.891 Y128.935 E.00868
G3 X120.051 Y126.13 I-1.881 J-.937 E.25511
G3 X120.761 Y125.91 I1.027 J2.061 E.02402
G3 X121.403 Y125.935 I.241 J2.089 E.02073
G3 X123.014 Y128.63 I-.392 J2.064 E.11404
M204 S250
G1 X122.625 Y128.537 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X122.532 Y128.757 E.00712
G3 X120.806 Y126.301 I-1.53 J-.76 E.21044
G1 X121.068 Y126.291 E.0078
G3 X122.641 Y128.479 I-.066 J1.707 E.09252
; WIPE_START
G1 X122.532 Y128.757 E-.11349
G1 X122.401 Y128.984 E-.09944
G1 X122.235 Y129.186 E-.09949
G1 X122.039 Y129.36 E-.09953
G1 X121.819 Y129.503 E-.09953
G1 X121.58 Y129.61 E-.0995
G1 X121.399 Y129.66 E-.07159
G1 X121.197 Y129.69 E-.07743
; WIPE_END
G1 E-.04 F1800
G1 X124.885 Y123.007 Z1 F9000
G1 X127.3 Y118.63 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G3 X127.993 Y118.605 I.681 J9.295 E.0223
G3 X125.098 Y119.062 I-.001 J9.396 E1.80374
G3 X127.24 Y118.635 I2.882 J8.863 E.0704
M204 S250
G1 X127.272 Y118.237 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X127.999 Y118.213 E.02167
G3 X137.216 Y131.298 I.001 J9.788 E.55817
G3 X127.215 Y118.245 I-9.214 J-3.299 E1.24993
; WIPE_START
G1 X127.999 Y118.213 E-.29833
M73 P42 R11
G1 X128.441 Y118.22 E-.16811
G1 X129.026 Y118.264 E-.22261
G1 X129.211 Y118.289 E-.07094
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1 I1.217 J0 P1  F9000
; stop printing object, unique label id: 82
M625
; object ids of layer 3 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    
      M400
      G90
      M83
      M204 S5000
      G0 Z2 F4000
      G0 X261 Y250 F20000
      M400 P200
      G39 S1
      G0 Z2 F4000
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
        M623
    
    M623
M623
; SKIPPABLE_END


G1 Z1.000
; object ids of this layer3 end: 82,118
M625
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X129.091 Y118.874 F9000
G1 Z.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.353126
G1 F7736.802
G1 X129.793 Y119.206 E.01903
G1 X129.818 Y119.168 F9000
; LINE_WIDTH: 0.177582
G1 X129.211 Y118.957 E.00683
; LINE_WIDTH: 0.155828
G1 X129.082 Y118.917 E.0012
; LINE_WIDTH: 0.116551
G1 X128.953 Y118.878 E.00078
; WIPE_START
G1 X129.082 Y118.917 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.042 Y118.883 Z1 F9000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.117475
G1 F9000
G1 X126.917 Y118.919 E.00077
; LINE_WIDTH: 0.161186
G1 X126.778 Y118.96 E.00136
; LINE_WIDTH: 0.192069
G1 X126.754 Y118.97 E.00031
; LINE_WIDTH: 0.172929
G1 X126.636 Y119.083 E.00168
; LINE_WIDTH: 0.123021
G1 X126.518 Y119.197 E.00103
; LINE_WIDTH: 0.0970886
G1 X126.496 Y119.221 E.00014
; WIPE_START
G1 X126.518 Y119.197 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.843 Y124.501 Z1 F9000
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6364.866
G3 X124.318 Y121.184 I1.159 J-3.501 E.13195
G1 X124.299 Y121.119 E.00201
G2 X121.116 Y124.313 I3.76 J6.932 E.13622
G3 X124.502 Y126.837 I-.113 J3.685 E.13396
G3 X126.785 Y124.519 I3.494 J1.157 E.10039
; WIPE_START
G1 X126.278 Y124.739 E-.21007
G1 X125.793 Y125.045 E-.21812
G1 X125.364 Y125.421 E-.21646
G1 X125.169 Y125.653 E-.11534
; WIPE_END
G1 E-.04 F1800
G1 X124.737 Y124.503 Z1 F9000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.3762
G1 F7201.152
G1 X124.261 Y124.013 E.01797
; LINE_WIDTH: 0.414525
G1 F6458.471
G1 X124.103 Y123.824 E.00725
; LINE_WIDTH: 0.461595
G1 F5732.37
G1 X123.944 Y123.635 E.00817
; LINE_WIDTH: 0.508665
G1 F5153.034
G1 X123.786 Y123.445 E.00908
; LINE_WIDTH: 0.549673
G1 F4736.038
G1 X123.576 Y123.085 E.01668
G2 X123.081 Y123.584 I5.605 J6.058 E.02813
G1 X123.448 Y123.784 E.0167
; LINE_WIDTH: 0.508669
G1 F5152.998
G1 X123.637 Y123.942 E.00908
; LINE_WIDTH: 0.461605
G1 F5732.233
G1 X123.826 Y124.101 E.00816
; LINE_WIDTH: 0.414542
G1 F6458.181
G1 X124.016 Y124.259 E.00725
; LINE_WIDTH: 0.369537
G1 F7348.06
G3 X124.502 Y124.732 I-3.73 J4.323 E.01752
G1 X124.694 Y124.545 E.00691
G1 X124.502 Y125.273 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G3 X125.272 Y124.497 I4.211 J3.408 E.03262
G3 X124.15 Y123.21 I2.891 J-3.654 E.05116
G1 X123.857 Y122.596 E.02025
G1 X123.774 Y122.351 E.00771
G2 X122.353 Y123.772 I4.301 J5.726 E.06005
G1 X123.035 Y124.051 E.02195
G1 X123.614 Y124.407 E.02025
G1 X124.131 Y124.848 E.02025
G1 X124.463 Y125.228 E.01502
G1 X124.502 Y125.946 F9000
G1 F6364.866
G1 X124.719 Y125.603 E.01211
G3 X125.945 Y124.498 I3.468 J2.615 E.04944
G3 X124.004 Y121.733 I2.092 J-3.531 E.1037
G2 X121.736 Y124.002 I4.027 J6.294 E.09633
G3 X124.47 Y125.895 I-.721 J3.963 E.10212
; WIPE_START
G1 X124.285 Y125.603 E-.13171
G1 X123.88 Y125.129 E-.23652
G1 X123.409 Y124.724 E-.2364
G1 X123.062 Y124.508 E-.15537
; WIPE_END
G1 E-.04 F1800
G1 X124.314 Y127.986 Z1 F9000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.420797
G1 F6351.278
G1 X124.296 Y128.493 E.01515
G3 X123.022 Y130.626 I-3.521 J-.656 E.07574
G3 X120.493 Y131.267 I-2.006 J-2.605 E.08008
G2 X124.735 Y135.507 I7.532 J-3.292 E.18328
G1 X124.692 Y134.888 E.01855
G1 X124.748 Y134.384 E.01513
G3 X125.099 Y133.405 I6.243 J1.69 E.03108
G3 X131.269 Y135.51 I2.9 J1.593 E.27605
G2 X135.504 Y131.268 I-3.282 J-7.512 E.18317
G1 X134.89 Y131.311 E.01837
G3 X135.51 Y124.733 I.112 J-3.307 E.3222
G2 X132.601 Y121.225 I-7.506 J3.264 E.13786
G1 X131.665 Y120.674 E.03241
G1 X131.271 Y120.502 E.01283
G1 X131.313 Y121.112 E.01826
G3 X124.735 Y120.493 I-3.307 J-.112 E.3222
G2 X120.507 Y124.731 I3.267 J7.488 E.18297
G1 X121.035 Y124.692 E.01581
G1 X121.619 Y124.745 E.01749
G3 X124.156 Y126.987 I-.663 J3.308 E.10587
G1 X124.288 Y127.477 E.01515
G1 X124.311 Y127.926 E.01342
; WIPE_START
G1 X124.288 Y127.477 E-.17083
G1 X124.156 Y126.987 E-.19287
G1 X123.964 Y126.517 E-.19275
G1 X123.703 Y126.082 E-.19275
G1 X123.685 Y126.06 E-.01081
; WIPE_END
G1 E-.04 F1800
G1 X124.502 Y130.054 Z1 F9000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X124.285 Y130.397 E.0121
G3 X121.736 Y131.998 I-3.281 J-2.396 E.09185
G2 X124.004 Y134.267 I6.46 J-4.188 E.09628
G3 X125.132 Y132.122 I4.294 J.887 E.07315
G1 X125.605 Y131.717 E.01854
G1 X125.945 Y131.502 E.01197
G3 X124.534 Y130.105 I1.936 J-3.364 E.05981
G1 X124.502 Y130.727 F9000
G1 F6364.866
G3 X123.212 Y131.853 I-3.658 J-2.889 E.05129
G1 X122.598 Y132.145 E.02025
G1 X122.353 Y132.228 E.00773
G2 X123.598 Y133.516 I6.052 J-4.605 E.05348
G1 X123.788 Y133.63 E.0066
G1 X124.031 Y133.019 E.01961
G1 X124.41 Y132.388 E.02189
G1 X124.85 Y131.871 E.02025
G3 X125.272 Y131.503 I6.164 J6.642 E.01668
G3 X124.542 Y130.772 I2.37 J-3.099 E.03087
G1 X124.737 Y131.497 F9000
; LINE_WIDTH: 0.371382
G1 F7306.785
G1 X124.502 Y131.268 E.00851
G1 X124.016 Y131.741 E.01761
; LINE_WIDTH: 0.414525
G1 F6458.471
G1 X123.826 Y131.899 E.00725
; LINE_WIDTH: 0.461595
G1 F5732.37
G1 X123.637 Y132.058 E.00817
; LINE_WIDTH: 0.508665
G1 F5153.034
G1 X123.448 Y132.216 E.00908
; LINE_WIDTH: 0.54978
G1 F4735.042
G1 X123.081 Y132.416 E.0167
G1 X123.532 Y132.873 E.02568
G1 X123.595 Y132.91 E.00295
G1 X123.786 Y132.555 E.01616
; LINE_WIDTH: 0.509334
G1 F5145.651
G1 X123.933 Y132.377 E.00848
; LINE_WIDTH: 0.4636
G1 F5705.049
G1 X124.08 Y132.2 E.00765
; LINE_WIDTH: 0.417867
G1 F6400.91
G1 X124.227 Y132.023 E.00682
; LINE_WIDTH: 0.375617
G1 F7213.787
G3 X124.694 Y131.538 I5.387 J4.72 E.01769
; WIPE_START
G1 X124.227 Y132.023 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.843 Y131.499 Z1 F9000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G3 X124.502 Y129.163 I1.148 J-3.491 E.10216
G3 X121.116 Y131.687 I-3.532 J-1.205 E.13372
G2 X124.299 Y134.881 I6.952 J-3.746 E.13622
G1 X124.373 Y134.34 E.01624
G3 X124.768 Y133.224 I6.155 J1.549 E.03533
G3 X126.787 Y131.521 I3.324 J1.894 E.08032
; WIPE_START
G1 X126.305 Y131.727 E-.19912
G1 X125.845 Y132.008 E-.20493
G1 X125.413 Y132.372 E-.21468
G1 X125.169 Y132.653 E-.14127
; WIPE_END
G1 E-.04 F1800
G1 X130.058 Y131.501 Z1 F9000
G1 Z.6
G1 E.8 F1800
G1 F6364.866
G3 X131.191 Y132.479 I-2.183 J3.676 E.04479
G3 X132 Y134.267 I-3.186 J2.519 E.05906
G2 X134.267 Y132.002 I-4.051 J-6.32 E.09619
G3 X132.596 Y131.276 I.986 J-4.559 E.05463
G3 X131.505 Y130.058 I2.744 J-3.555 E.04899
G1 X131.184 Y130.53 E.01701
G3 X130.109 Y131.47 I-3.642 J-3.079 E.04268
G1 X130.728 Y131.499 F9000
G1 F6364.866
G3 X131.855 Y132.79 I-2.891 J3.662 E.05134
G3 X132.234 Y133.645 I-5.327 J2.874 E.02787
G2 X133.652 Y132.228 I-4.647 J-6.071 E.05987
G1 X133.007 Y131.966 E.02075
G1 X132.391 Y131.593 E.02146
G1 X131.873 Y131.152 E.02025
G1 X131.518 Y130.746 E.01606
G3 X130.773 Y131.459 I-4.88 J-4.353 E.03076
G1 X131.499 Y131.264 F9000
; LINE_WIDTH: 0.371246
G1 F7309.816
G1 X131.272 Y131.499 E.00846
G1 X131.743 Y131.987 E.01758
; LINE_WIDTH: 0.41453
G1 F6458.384
G1 X131.902 Y132.176 E.00725
; LINE_WIDTH: 0.46159
G1 F5732.439
G1 X132.06 Y132.365 E.00817
; LINE_WIDTH: 0.50865
G1 F5153.2
G1 X132.218 Y132.555 E.00908
; LINE_WIDTH: 0.549498
G1 F4737.679
G1 X132.418 Y132.92 E.01667
G2 X132.923 Y132.416 I-3.609 J-4.12 E.02858
G1 X132.557 Y132.216 E.01669
; LINE_WIDTH: 0.509319
G1 F5145.816
G1 X132.38 Y132.069 E.00848
; LINE_WIDTH: 0.463595
G1 F5705.117
G1 X132.202 Y131.922 E.00765
; LINE_WIDTH: 0.417872
G1 F6400.825
G1 X132.025 Y131.775 E.00682
; LINE_WIDTH: 0.375577
G1 F7214.644
G3 X131.54 Y131.307 I4.41 J-5.06 E.01771
; WIPE_START
G1 X132.025 Y131.775 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.258 Y129.705 Z1 F9000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X130.957 Y130.198 E.0172
G3 X129.157 Y131.497 I-2.959 J-2.205 E.06715
G3 X131.689 Y134.885 I-1.203 J3.54 E.13393
G2 X134.888 Y131.687 I-3.675 J-6.875 E.13671
G3 X133.315 Y131.278 I.228 J-4.105 E.04873
G1 X132.801 Y130.96 E.01802
G3 X131.503 Y129.165 I2.197 J-2.955 E.067
G1 X131.282 Y129.65 E.01588
G1 X130.96 Y129.443 F9000
; LINE_WIDTH: 0.423985
G1 F6298.146
G3 X128.866 Y131.198 I-2.933 J-1.373 E.08489
G1 X128.368 Y131.304 E.01532
G3 X124.84 Y128.986 I-.321 J-3.356 E.13732
G1 X124.708 Y128.495 E.0153
G3 X124.708 Y127.507 I6.652 J-.494 E.02975
G3 X125.983 Y125.374 I3.521 J.657 E.07638
G3 X130.195 Y125.517 I2.02 J2.626 E.13752
G1 X130.693 Y126.084 E.02269
G3 X131.312 Y127.731 I-3.264 J2.167 E.05342
G1 X131.312 Y128.239 E.0153
G1 X131.157 Y128.978 E.02273
G1 X130.983 Y129.388 E.0134
; WIPE_START
G1 X131.157 Y128.978 E-.16917
G1 X131.312 Y128.239 E-.28693
G1 X131.312 Y127.731 E-.19316
G1 X131.251 Y127.446 E-.11073
; WIPE_END
G1 E-.04 F1800
G1 X131.261 Y126.319 Z1 F9000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G3 X131.498 Y126.846 I-1.404 J.949 E.01729
G3 X134.888 Y124.313 I3.531 J1.192 E.13403
G2 X133.402 Y122.352 I-6.939 J3.716 E.0736
G2 X131.689 Y121.125 I-5.325 J5.627 E.06296
G3 X129.157 Y124.503 I-3.686 J-.125 E.13388
G3 X130.542 Y125.335 I-1.43 J3.95 E.04843
G1 X130.977 Y125.837 E.01978
G1 X131.231 Y126.267 E.01488
G1 X131.493 Y125.962 F9000
G1 F6364.866
G3 X132.481 Y124.811 I3.824 J2.285 E.04538
G1 X132.997 Y124.464 E.01853
G1 X133.526 Y124.215 E.01743
G3 X134.267 Y123.998 I2.107 J5.828 E.023
G2 X131.998 Y121.745 I-6.167 J3.943 E.09601
G1 X131.852 Y122.306 E.01726
G3 X130.4 Y124.283 I-3.85 J-1.306 E.07422
G1 X130.058 Y124.499 E.01204
G1 X130.652 Y124.918 E.02166
G1 X131.262 Y125.589 E.02702
G1 X131.461 Y125.911 E.01126
G1 X131.495 Y125.282 F9000
G1 F6364.866
G3 X132.792 Y124.148 I3.675 J2.892 E.05163
G3 X133.652 Y123.772 I2.197 J3.853 E.02801
G2 X132.228 Y122.361 I-5.253 J3.88 E.05994
G1 X131.951 Y123.033 E.02163
G1 X131.595 Y123.611 E.02025
G1 X131.154 Y124.129 E.02025
G1 X130.728 Y124.501 E.01685
G3 X131.455 Y125.237 I-2.447 J3.146 E.03092
G1 X131.489 Y124.746 F9000
; LINE_WIDTH: 0.37605
G1 F7204.395
G1 X131.989 Y124.259 E.01836
; LINE_WIDTH: 0.41453
G1 F6458.384
G1 X132.178 Y124.101 E.00724
; LINE_WIDTH: 0.46155
G1 F5732.986
M73 P43 R11
G1 X132.367 Y123.942 E.00816
; LINE_WIDTH: 0.50857
G1 F5154.086
G1 X132.556 Y123.784 E.00908
; LINE_WIDTH: 0.549454
G1 F4738.085
G1 X132.923 Y123.584 E.0167
G2 X132.418 Y123.08 I-3.769 J3.27 E.02858
G1 X132.218 Y123.446 E.01668
; LINE_WIDTH: 0.508572
G1 F5154.067
G1 X132.06 Y123.635 E.00908
; LINE_WIDTH: 0.461555
G1 F5732.918
G1 X131.902 Y123.824 E.00816
; LINE_WIDTH: 0.414539
G1 F6458.239
G1 X131.743 Y124.013 E.00724
; LINE_WIDTH: 0.369464
G1 F7349.697
G3 X131.27 Y124.501 I-4.486 J-3.878 E.01753
G1 X131.449 Y124.701 E.00693
; WIPE_START
G1 X131.27 Y124.501 E-.21544
G1 X131.743 Y124.013 E-.54456
; WIPE_END
G1 E-.04 F1800
G1 X136.781 Y126.494 Z1 F9000
G1 Z.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970898
G1 F9000
G1 X136.805 Y126.516 E.00014
; LINE_WIDTH: 0.122851
G1 X136.918 Y126.633 E.00102
; LINE_WIDTH: 0.172371
G1 X137.03 Y126.749 E.00166
; LINE_WIDTH: 0.188876
G1 X137.042 Y126.781 E.00039
; LINE_WIDTH: 0.158058
G1 X137.083 Y126.916 E.00128
; LINE_WIDTH: 0.116755
G1 X137.12 Y127.041 E.00076
; WIPE_START
G1 X137.083 Y126.916 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.121 Y128.958 Z1 F9000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.116752
G1 F9000
G1 X137.083 Y129.084 E.00076
; LINE_WIDTH: 0.158083
G1 X137.042 Y129.219 E.00129
; LINE_WIDTH: 0.188896
G1 X137.03 Y129.251 E.00039
; LINE_WIDTH: 0.172378
G1 X136.918 Y129.367 E.00166
; LINE_WIDTH: 0.122861
G1 X136.805 Y129.484 E.00102
; LINE_WIDTH: 0.0970972
G1 X136.781 Y129.506 E.00014
; WIPE_START
G1 X136.805 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.383 Y134.856 Z1 F9000
G1 X129.091 Y137.126 Z1
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.353137
G1 F7736.518
G1 X129.793 Y136.794 E.01903
G1 X129.818 Y136.832 F9000
; LINE_WIDTH: 0.17754
G1 X129.211 Y137.043 E.00683
; LINE_WIDTH: 0.155815
G1 X129.082 Y137.083 E.0012
; LINE_WIDTH: 0.116551
G1 X128.953 Y137.122 E.00078
; WIPE_START
G1 X129.082 Y137.083 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.042 Y137.117 Z1 F9000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.117491
G1 F9000
G1 X126.917 Y137.081 E.00077
; LINE_WIDTH: 0.161209
G1 X126.778 Y137.04 E.00136
; LINE_WIDTH: 0.192074
G1 X126.754 Y137.03 E.00031
; LINE_WIDTH: 0.172943
G1 X126.636 Y136.917 E.00168
; LINE_WIDTH: 0.123031
G1 X126.518 Y136.803 E.00103
; LINE_WIDTH: 0.0970841
G1 X126.496 Y136.779 E.00014
; WIPE_START
G1 X126.518 Y136.803 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.122 Y131.405 Z1 F9000
G1 X119.223 Y129.506 Z1
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.0971035
G1 F9000
G1 X119.199 Y129.484 E.00014
; LINE_WIDTH: 0.12276
G1 X119.087 Y129.368 E.00102
; LINE_WIDTH: 0.175257
G1 X118.975 Y129.251 E.00169
G1 X118.958 Y129.209 E.00047
; LINE_WIDTH: 0.157741
G1 X118.922 Y129.092 E.00111
; LINE_WIDTH: 0.117853
G1 X118.883 Y128.956 E.00083
; WIPE_START
G1 X118.922 Y129.092 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.883 Y127.044 Z1 F9000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.117855
G1 F9000
G1 X118.922 Y126.908 E.00083
; LINE_WIDTH: 0.157748
G1 X118.958 Y126.791 E.00111
; LINE_WIDTH: 0.175216
G1 X118.975 Y126.749 E.00047
G1 X119.087 Y126.632 E.00169
; LINE_WIDTH: 0.122719
G1 X119.199 Y126.516 E.00102
; LINE_WIDTH: 0.0970641
G1 X119.223 Y126.494 E.00014
; OBJECT_ID: 118
; WIPE_START
G1 X119.199 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X113.571 Y131.671 Z1 F9000
G1 X107.82 Y136.938 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X107.794 Y136.952 E.00096
G3 X106.903 Y132.904 I-.779 J-1.951 E.23426
G3 X108.217 Y133.279 I.095 J2.155 E.0447
G3 X108.083 Y136.81 I-1.202 J1.722 E.135
G1 X107.874 Y136.912 E.00747
M204 S250
G1 X107.646 Y136.587 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X106.933 Y133.295 I-.631 J-1.586 E.17662
G3 X107.766 Y133.467 I.09 J1.663 E.0256
G3 X107.702 Y136.564 I-.751 J1.534 E.11557
; WIPE_START
G1 X107.397 Y136.666 E-.12223
G1 X107.138 Y136.706 E-.09954
G1 X106.876 Y136.706 E-.0995
G1 X106.617 Y136.666 E-.09953
G1 X106.367 Y136.587 E-.09954
G1 X106.133 Y136.47 E-.09948
G1 X105.918 Y136.32 E-.09952
G1 X105.841 Y136.246 E-.04065
; WIPE_END
G1 E-.04 F1800
G1 X111.284 Y130.894 Z1 F9000
G1 X115.61 Y126.641 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X115.631 Y126.66 E.00093
G3 X113.823 Y125.91 I-1.617 J1.341 E.35889
G3 X115.15 Y126.234 I.177 J2.15 E.0447
G3 X115.407 Y126.429 I-1.135 J1.767 E.01037
G1 X115.568 Y126.597 E.00751
M204 S250
G1 X115.329 Y126.91 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X113.868 Y126.299 I-1.314 J1.091 E.2706
G3 X114.706 Y126.439 I.154 J1.658 E.0256
G3 X115.29 Y126.864 I-.692 J1.562 E.02166
; WIPE_START
G1 X115.477 Y127.126 E-.12228
G1 X115.593 Y127.361 E-.09949
G1 X115.672 Y127.61 E-.09952
G1 X115.712 Y127.869 E-.09954
G1 X115.712 Y128.131 E-.0995
G1 X115.672 Y128.39 E-.09954
G1 X115.593 Y128.639 E-.09952
G1 X115.546 Y128.735 E-.0406
; WIPE_END
G1 E-.04 F1800
G1 X110.914 Y122.669 Z1 F9000
G1 X108.557 Y119.581 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X108.578 Y119.6 E.00091
G3 X104.916 Y121.184 I-1.569 J1.397 E.25538
G3 X106.846 Y118.902 I2.098 J-.182 E.1068
G3 X108.346 Y119.376 I.163 J2.095 E.05185
G1 X108.514 Y119.539 E.00753
M204 S250
G1 X108.284 Y119.862 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X106.876 Y119.294 I-1.277 J1.137 E.27308
G3 X107.576 Y119.391 I.102 J1.844 E.02119
G1 X107.646 Y119.413 E.00219
G3 X108.243 Y119.818 I-.639 J1.585 E.02164
; WIPE_START
G1 X108.443 Y120.07 E-.12219
G1 X108.568 Y120.3 E-.09954
G1 X108.656 Y120.547 E-.09953
G1 X108.706 Y120.804 E-.09951
G1 X108.716 Y121.065 E-.09949
G1 X108.686 Y121.326 E-.09955
G1 X108.617 Y121.578 E-.09951
G1 X108.573 Y121.676 E-.04069
; WIPE_END
G1 E-.04 F1800
G1 X104.446 Y126.61 Z1 F9000
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X104.628 Y126.327 E.01082
G3 X106.673 Y125.107 I2.385 J1.677 E.07887
G3 X109.715 Y126.908 I.335 J2.905 E.12209
G3 X104.4 Y126.709 I-2.702 J1.095 E.37374
G1 X104.421 Y126.664 E.00159
G1 X104.796 Y126.818 F9000
G1 F5895.652
G1 X104.954 Y126.556 E.00984
G3 X106.719 Y125.512 I2.046 J1.446 E.06796
G3 X107.853 Y130.357 I.295 J2.486 E.23497
G3 X104.757 Y126.886 I-.853 J-2.356 E.19173
G1 X104.766 Y126.87 E.00059
G1 X105.146 Y127.026 F9000
G1 F5895.652
G1 X105.295 Y126.796 E.00881
G3 X106.766 Y125.916 I1.719 J1.206 E.05679
G3 X108.406 Y126.429 I.236 J2.124 E.05688
G3 X105.126 Y127.082 I-1.392 J1.572 E.29991
M204 S250
G1 X105.483 Y127.226 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X105.611 Y127.018 E.00728
G3 X106.811 Y126.306 I1.396 J.985 E.04284
G3 X107.822 Y126.502 I.196 J1.694 E.03114
G3 X105.458 Y127.281 I-.815 J1.501 E.23663
; WIPE_START
G1 X105.611 Y127.018 E-.11546
G1 X105.774 Y126.814 E-.09943
G1 X105.97 Y126.64 E-.09951
G1 X106.19 Y126.497 E-.09953
G1 X106.428 Y126.39 E-.09949
G1 X106.681 Y126.321 E-.09953
G1 X106.811 Y126.306 E-.04977
G1 X106.941 Y126.291 E-.04978
G1 X107.066 Y126.295 E-.0475
; WIPE_END
G1 E-.04 F1800
G1 X104.327 Y119.847 Z1 F9000
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G2 X109.682 Y119.833 I2.68 J1.15 E.3711
G1 X110.38 Y120.108 E.02413
G3 X115.165 Y125.322 I-3.417 J7.939 E.23448
G2 X115.165 Y130.678 I-1.155 J2.678 E.37094
G3 X109.682 Y136.167 I-8.233 J-2.742 E.25866
G2 X104.327 Y136.153 I-2.674 J-1.163 E.37111
G3 X98.856 Y130.681 I2.694 J-8.164 E.2581
G2 X98.856 Y125.319 I1.153 J-2.681 E.37099
G3 X104.27 Y119.866 I8.149 J2.676 E.25621
; WIPE_START
G1 X104.191 Y120.226 E-.14021
G1 X104.106 Y120.665 E-.16998
G1 X104.088 Y121.112 E-.16979
G1 X104.14 Y121.556 E-.16998
G1 X104.217 Y121.835 E-.11006
; WIPE_END
G1 E-.04 F1800
G1 X108.924 Y119.383 Z1 F9000
G1 Z.6
G1 E.8 F1800
G1 F5895.652
G1 X109.02 Y119.238 E.0056
G3 X115.827 Y126.238 I-2.031 J8.784 E.33177
G1 X115.372 Y125.891 E.01838
G2 X113.777 Y125.505 I-1.371 J2.176 E.05373
G2 X115.372 Y130.109 I.235 J2.497 E.29207
G1 X115.827 Y129.762 E.01838
G3 X109.02 Y136.762 I-8.843 J-1.79 E.33173
G1 X108.924 Y136.617 E.0056
G2 X104.898 Y136.365 I-1.92 J-1.613 E.35601
G1 X105.24 Y136.814 E.01815
G3 X98.196 Y129.769 I1.776 J-8.821 E.33953
G1 X98.641 Y130.109 E.01802
G2 X98.641 Y125.891 I1.365 J-2.109 E.34662
G1 X98.196 Y126.231 E.01802
G3 X105.24 Y119.186 I8.812 J1.767 E.33958
G1 X104.898 Y119.634 E.01814
G1 X104.834 Y119.753 E.00434
G2 X104.512 Y121.23 I2.187 J1.25 E.04937
G2 X108.962 Y119.43 I2.496 J-.231 E.3003
; WIPE_START
G1 X109.02 Y119.238 E-.07596
G1 X109.528 Y119.37 E-.19929
G1 X110.04 Y119.537 E-.20448
G1 X110.54 Y119.733 E-.20433
G1 X110.721 Y119.817 E-.07594
; WIPE_END
G1 E-.04 F1800
G1 X105.367 Y125.256 Z1 F9000
G1 X101.993 Y128.684 Z1
G1 Z.6
G1 E.8 F1800
G1 F5895.652
G1 X101.896 Y128.935 E.00868
G3 X99.055 Y126.13 I-1.881 J-.937 E.25511
G3 X99.765 Y125.91 I1.027 J2.061 E.02402
G3 X100.407 Y125.935 I.241 J2.089 E.02073
G3 X102.019 Y128.63 I-.392 J2.064 E.11404
M204 S250
G1 X101.629 Y128.537 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X101.536 Y128.757 E.00712
G3 X99.811 Y126.301 I-1.53 J-.76 E.21044
G1 X100.072 Y126.291 E.0078
G3 X101.645 Y128.479 I-.066 J1.707 E.09252
; WIPE_START
G1 X101.536 Y128.757 E-.11349
G1 X101.406 Y128.984 E-.09944
G1 X101.239 Y129.186 E-.09949
G1 X101.044 Y129.36 E-.09953
G1 X100.824 Y129.503 E-.09953
G1 X100.585 Y129.61 E-.0995
G1 X100.403 Y129.66 E-.07159
G1 X100.202 Y129.69 E-.07743
; WIPE_END
G1 E-.04 F1800
G1 X103.889 Y123.007 Z1 F9000
G1 X106.305 Y118.63 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G3 X106.998 Y118.605 I.681 J9.295 E.0223
G3 X104.103 Y119.062 I-.001 J9.396 E1.80374
G3 X106.245 Y118.635 I2.882 J8.863 E.0704
M204 S250
G1 X106.276 Y118.237 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X107.004 Y118.213 E.02167
G3 X116.221 Y131.298 I.001 J9.788 E.55817
G3 X106.219 Y118.245 I-9.214 J-3.299 E1.24993
G1 X106.047 Y118.883 F9000
; FEATURE: Gap infill
; LINE_WIDTH: 0.117475
G1 X105.922 Y118.919 E.00077
; LINE_WIDTH: 0.161186
G1 X105.782 Y118.96 E.00136
; LINE_WIDTH: 0.192069
G1 X105.758 Y118.97 E.00031
; LINE_WIDTH: 0.172929
G1 X105.64 Y119.083 E.00168
; LINE_WIDTH: 0.123021
G1 X105.522 Y119.197 E.00103
; LINE_WIDTH: 0.0970886
M73 P44 R11
G1 X105.501 Y119.221 E.00014
; WIPE_START
G1 X105.522 Y119.197 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.958 Y118.878 Z1 F9000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.116551
G1 F9000
G1 X108.087 Y118.917 E.00078
; LINE_WIDTH: 0.155828
G1 X108.216 Y118.957 E.0012
; LINE_WIDTH: 0.177582
G1 X108.822 Y119.168 E.00683
G1 X108.797 Y119.206
; LINE_WIDTH: 0.353126
G1 F7736.802
G1 X108.095 Y118.874 E.01903
; WIPE_START
G1 X108.797 Y119.206 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.847 Y124.501 Z1 F9000
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6364.866
G3 X103.323 Y121.184 I1.159 J-3.501 E.13195
G1 X103.304 Y121.119 E.00201
G2 X100.12 Y124.313 I3.76 J6.932 E.13622
G3 X103.507 Y126.837 I-.113 J3.685 E.13396
G3 X105.79 Y124.519 I3.494 J1.157 E.10039
; WIPE_START
G1 X105.283 Y124.739 E-.21007
G1 X104.797 Y125.045 E-.21812
G1 X104.369 Y125.421 E-.21646
G1 X104.174 Y125.653 E-.11534
; WIPE_END
G1 E-.04 F1800
G1 X103.742 Y124.503 Z1 F9000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.3762
G1 F7201.152
G1 X103.266 Y124.013 E.01797
; LINE_WIDTH: 0.414525
G1 F6458.471
G1 X103.107 Y123.824 E.00725
; LINE_WIDTH: 0.461595
G1 F5732.37
G1 X102.949 Y123.635 E.00817
; LINE_WIDTH: 0.508665
G1 F5153.034
G1 X102.79 Y123.445 E.00908
; LINE_WIDTH: 0.549673
G1 F4736.038
G1 X102.581 Y123.085 E.01668
G2 X102.086 Y123.584 I5.605 J6.058 E.02813
G1 X102.452 Y123.784 E.0167
; LINE_WIDTH: 0.508669
G1 F5152.998
G1 X102.641 Y123.942 E.00908
; LINE_WIDTH: 0.461605
G1 F5732.233
G1 X102.831 Y124.101 E.00816
; LINE_WIDTH: 0.414542
G1 F6458.181
G1 X103.02 Y124.259 E.00725
; LINE_WIDTH: 0.369537
G1 F7348.06
G3 X103.507 Y124.732 I-3.73 J4.323 E.01752
G1 X103.699 Y124.545 E.00691
G1 X103.507 Y125.273 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G3 X104.277 Y124.497 I4.211 J3.408 E.03262
G3 X103.154 Y123.21 I2.891 J-3.654 E.05116
G1 X102.862 Y122.596 E.02025
G1 X102.779 Y122.351 E.00771
G2 X101.357 Y123.772 I4.301 J5.726 E.06005
G1 X102.039 Y124.051 E.02195
G1 X102.618 Y124.407 E.02025
G1 X103.136 Y124.848 E.02025
G1 X103.467 Y125.228 E.01502
G1 X103.507 Y125.946 F9000
G1 F6364.866
G1 X103.724 Y125.603 E.01211
G3 X104.949 Y124.498 I3.468 J2.615 E.04944
G3 X103.009 Y121.733 I2.092 J-3.531 E.1037
G2 X100.74 Y124.002 I4.027 J6.294 E.09633
G3 X103.475 Y125.895 I-.721 J3.963 E.10212
; WIPE_START
G1 X103.289 Y125.603 E-.13171
G1 X102.885 Y125.129 E-.23652
G1 X102.413 Y124.724 E-.2364
G1 X102.066 Y124.508 E-.15537
; WIPE_END
G1 E-.04 F1800
G1 X103.319 Y127.986 Z1 F9000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.420797
G1 F6351.278
G1 X103.301 Y128.493 E.01515
G3 X102.026 Y130.626 I-3.521 J-.656 E.07574
G3 X99.497 Y131.267 I-2.006 J-2.605 E.08008
G2 X103.74 Y135.507 I7.532 J-3.292 E.18328
G1 X103.696 Y134.888 E.01855
G1 X103.752 Y134.384 E.01513
G3 X104.104 Y133.405 I6.243 J1.69 E.03108
G3 X110.273 Y135.51 I2.9 J1.593 E.27605
G2 X114.508 Y131.268 I-3.282 J-7.512 E.18317
G1 X113.894 Y131.311 E.01837
G3 X114.514 Y124.733 I.112 J-3.307 E.3222
G2 X111.605 Y121.225 I-7.506 J3.264 E.13786
G1 X110.669 Y120.674 E.03241
G1 X110.276 Y120.502 E.01283
G1 X110.317 Y121.112 E.01826
G3 X103.74 Y120.493 I-3.307 J-.112 E.3222
G2 X99.511 Y124.731 I3.267 J7.488 E.18297
G1 X100.039 Y124.692 E.01581
G1 X100.623 Y124.745 E.01749
G3 X103.16 Y126.987 I-.663 J3.308 E.10587
G1 X103.293 Y127.477 E.01515
G1 X103.316 Y127.926 E.01342
; WIPE_START
G1 X103.293 Y127.477 E-.17083
G1 X103.16 Y126.987 E-.19287
G1 X102.969 Y126.517 E-.19275
G1 X102.708 Y126.082 E-.19275
G1 X102.689 Y126.06 E-.01081
; WIPE_END
G1 E-.04 F1800
G1 X103.507 Y130.054 Z1 F9000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X103.29 Y130.397 E.0121
G3 X100.74 Y131.998 I-3.281 J-2.396 E.09185
G2 X103.009 Y134.267 I6.46 J-4.188 E.09628
G3 X104.136 Y132.122 I4.294 J.887 E.07315
G1 X104.609 Y131.717 E.01854
G1 X104.949 Y131.502 E.01197
G3 X103.539 Y130.105 I1.936 J-3.364 E.05981
G1 X103.507 Y130.727 F9000
G1 F6364.866
G3 X102.217 Y131.853 I-3.658 J-2.889 E.05129
G1 X101.603 Y132.145 E.02025
G1 X101.357 Y132.228 E.00773
G2 X102.602 Y133.516 I6.052 J-4.605 E.05348
G1 X102.792 Y133.63 E.0066
G1 X103.036 Y133.019 E.01961
G1 X103.414 Y132.388 E.02189
G1 X103.855 Y131.871 E.02025
G3 X104.277 Y131.503 I6.164 J6.642 E.01668
G3 X103.546 Y130.772 I2.37 J-3.099 E.03087
G1 X103.742 Y131.497 F9000
; LINE_WIDTH: 0.371382
G1 F7306.785
G1 X103.507 Y131.268 E.00851
G1 X103.02 Y131.741 E.01761
; LINE_WIDTH: 0.414525
G1 F6458.471
G1 X102.831 Y131.899 E.00725
; LINE_WIDTH: 0.461595
G1 F5732.37
G1 X102.642 Y132.058 E.00817
; LINE_WIDTH: 0.508665
G1 F5153.034
G1 X102.452 Y132.216 E.00908
; LINE_WIDTH: 0.54978
G1 F4735.042
G1 X102.086 Y132.416 E.0167
G1 X102.537 Y132.873 E.02568
G1 X102.6 Y132.91 E.00295
G1 X102.79 Y132.555 E.01616
; LINE_WIDTH: 0.509334
G1 F5145.651
G1 X102.938 Y132.377 E.00848
; LINE_WIDTH: 0.4636
G1 F5705.049
G1 X103.085 Y132.2 E.00765
; LINE_WIDTH: 0.417867
G1 F6400.91
G1 X103.232 Y132.023 E.00682
; LINE_WIDTH: 0.375617
G1 F7213.787
G3 X103.698 Y131.538 I5.387 J4.72 E.01769
; WIPE_START
G1 X103.232 Y132.023 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.847 Y131.499 Z1 F9000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G3 X103.507 Y129.163 I1.148 J-3.491 E.10216
G3 X100.12 Y131.687 I-3.532 J-1.205 E.13372
G2 X103.304 Y134.881 I6.952 J-3.746 E.13622
G1 X103.377 Y134.34 E.01624
G3 X103.772 Y133.224 I6.155 J1.549 E.03533
G3 X105.792 Y131.521 I3.324 J1.894 E.08032
; WIPE_START
G1 X105.309 Y131.727 E-.19912
G1 X104.849 Y132.008 E-.20493
G1 X104.418 Y132.372 E-.21468
G1 X104.174 Y132.653 E-.14127
; WIPE_END
G1 E-.04 F1800
G1 X109.063 Y131.501 Z1 F9000
G1 Z.6
G1 E.8 F1800
G1 F6364.866
G3 X110.195 Y132.479 I-2.183 J3.676 E.04479
G3 X111.005 Y134.267 I-3.186 J2.519 E.05906
G2 X113.272 Y132.002 I-4.051 J-6.32 E.09619
G3 X111.6 Y131.276 I.986 J-4.559 E.05463
G3 X110.509 Y130.058 I2.744 J-3.555 E.04899
G1 X110.188 Y130.53 E.01701
G3 X109.114 Y131.47 I-3.642 J-3.079 E.04268
G1 X109.732 Y131.499 F9000
G1 F6364.866
G3 X110.859 Y132.79 I-2.891 J3.662 E.05134
G3 X111.238 Y133.645 I-5.327 J2.874 E.02787
G2 X112.657 Y132.228 I-4.647 J-6.071 E.05987
G1 X112.011 Y131.966 E.02075
G1 X111.395 Y131.593 E.02146
G1 X110.878 Y131.152 E.02025
G1 X110.523 Y130.746 E.01606
G3 X109.777 Y131.459 I-4.88 J-4.353 E.03076
G1 X110.503 Y131.264 F9000
; LINE_WIDTH: 0.371246
G1 F7309.816
G1 X110.277 Y131.499 E.00846
G1 X110.748 Y131.987 E.01758
; LINE_WIDTH: 0.41453
G1 F6458.384
G1 X110.906 Y132.176 E.00725
; LINE_WIDTH: 0.46159
G1 F5732.439
G1 X111.064 Y132.365 E.00817
; LINE_WIDTH: 0.50865
G1 F5153.2
G1 X111.223 Y132.555 E.00908
; LINE_WIDTH: 0.549498
G1 F4737.679
G1 X111.422 Y132.92 E.01667
G2 X111.927 Y132.416 I-3.609 J-4.12 E.02858
G1 X111.561 Y132.216 E.01669
; LINE_WIDTH: 0.509319
G1 F5145.816
G1 X111.384 Y132.069 E.00848
; LINE_WIDTH: 0.463595
G1 F5705.117
G1 X111.207 Y131.922 E.00765
; LINE_WIDTH: 0.417872
G1 F6400.825
G1 X111.03 Y131.775 E.00682
; LINE_WIDTH: 0.375577
G1 F7214.644
G3 X110.545 Y131.307 I4.41 J-5.06 E.01771
; WIPE_START
G1 X111.03 Y131.775 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.262 Y129.705 Z1 F9000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X109.961 Y130.198 E.0172
G3 X108.161 Y131.497 I-2.959 J-2.205 E.06715
G3 X110.694 Y134.885 I-1.203 J3.54 E.13393
G2 X113.893 Y131.687 I-3.675 J-6.875 E.13671
G3 X112.32 Y131.278 I.228 J-4.105 E.04873
G1 X111.805 Y130.96 E.01802
G3 X110.508 Y129.165 I2.197 J-2.955 E.067
G1 X110.287 Y129.65 E.01588
G1 X109.964 Y129.443 F9000
; LINE_WIDTH: 0.423985
G1 F6298.146
G3 X107.87 Y131.198 I-2.933 J-1.373 E.08489
G1 X107.373 Y131.304 E.01532
G3 X103.844 Y128.986 I-.321 J-3.356 E.13732
G1 X103.713 Y128.495 E.0153
G3 X103.713 Y127.507 I6.652 J-.494 E.02975
G3 X104.987 Y125.374 I3.521 J.657 E.07638
G3 X109.2 Y125.517 I2.02 J2.626 E.13752
G1 X109.697 Y126.084 E.02269
G3 X110.316 Y127.731 I-3.264 J2.167 E.05342
G1 X110.316 Y128.239 E.0153
G1 X110.161 Y128.978 E.02273
G1 X109.988 Y129.388 E.0134
; WIPE_START
G1 X110.161 Y128.978 E-.16917
G1 X110.316 Y128.239 E-.28693
G1 X110.316 Y127.731 E-.19316
G1 X110.255 Y127.446 E-.11073
; WIPE_END
G1 E-.04 F1800
G1 X110.265 Y126.319 Z1 F9000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G3 X110.503 Y126.846 I-1.404 J.949 E.01729
G3 X113.893 Y124.313 I3.531 J1.192 E.13403
G2 X112.406 Y122.352 I-6.939 J3.716 E.0736
G2 X110.693 Y121.125 I-5.325 J5.627 E.06296
G3 X108.161 Y124.503 I-3.686 J-.125 E.13388
G3 X109.546 Y125.335 I-1.43 J3.95 E.04843
G1 X109.982 Y125.837 E.01978
G1 X110.235 Y126.267 E.01488
G1 X110.498 Y125.962 F9000
G1 F6364.866
G3 X111.485 Y124.811 I3.824 J2.285 E.04538
G1 X112.001 Y124.464 E.01853
G1 X112.531 Y124.215 E.01743
G3 X113.271 Y123.998 I2.107 J5.828 E.023
G2 X111.002 Y121.745 I-6.167 J3.943 E.09601
G1 X110.856 Y122.306 E.01726
G3 X109.404 Y124.283 I-3.85 J-1.306 E.07422
G1 X109.063 Y124.499 E.01204
G1 X109.657 Y124.918 E.02166
G1 X110.266 Y125.589 E.02702
G1 X110.466 Y125.911 E.01126
G1 X110.499 Y125.282 F9000
G1 F6364.866
G3 X111.796 Y124.148 I3.675 J2.892 E.05163
G3 X112.657 Y123.772 I2.197 J3.853 E.02801
G2 X111.232 Y122.361 I-5.253 J3.88 E.05994
G1 X110.956 Y123.033 E.02163
G1 X110.599 Y123.611 E.02025
G1 X110.159 Y124.129 E.02025
G1 X109.732 Y124.501 E.01685
G3 X110.46 Y125.237 I-2.447 J3.146 E.03092
G1 X110.494 Y124.746 F9000
; LINE_WIDTH: 0.37605
G1 F7204.395
G1 X110.993 Y124.259 E.01836
; LINE_WIDTH: 0.41453
G1 F6458.384
G1 X111.183 Y124.101 E.00724
; LINE_WIDTH: 0.46155
G1 F5732.986
G1 X111.372 Y123.942 E.00816
; LINE_WIDTH: 0.50857
G1 F5154.086
M73 P45 R11
G1 X111.561 Y123.784 E.00908
; LINE_WIDTH: 0.549454
G1 F4738.085
G1 X111.927 Y123.584 E.0167
G2 X111.422 Y123.08 I-3.769 J3.27 E.02858
G1 X111.223 Y123.446 E.01668
; LINE_WIDTH: 0.508572
G1 F5154.067
G1 X111.064 Y123.635 E.00908
; LINE_WIDTH: 0.461555
G1 F5732.918
G1 X110.906 Y123.824 E.00816
; LINE_WIDTH: 0.414539
G1 F6458.239
G1 X110.748 Y124.013 E.00724
; LINE_WIDTH: 0.369464
G1 F7349.697
G3 X110.275 Y124.501 I-4.486 J-3.878 E.01753
G1 X110.454 Y124.701 E.00693
; WIPE_START
G1 X110.275 Y124.501 E-.21544
G1 X110.748 Y124.013 E-.54456
; WIPE_END
G1 E-.04 F1800
G1 X115.786 Y126.494 Z1 F9000
G1 Z.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970898
G1 F9000
G1 X115.81 Y126.516 E.00014
; LINE_WIDTH: 0.122851
G1 X115.922 Y126.633 E.00102
; LINE_WIDTH: 0.172371
G1 X116.035 Y126.749 E.00166
; LINE_WIDTH: 0.188876
G1 X116.047 Y126.781 E.00039
; LINE_WIDTH: 0.158058
G1 X116.088 Y126.916 E.00128
; LINE_WIDTH: 0.116755
G1 X116.125 Y127.041 E.00076
; WIPE_START
G1 X116.088 Y126.916 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.125 Y128.958 Z1 F9000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.116752
G1 F9000
G1 X116.088 Y129.084 E.00076
; LINE_WIDTH: 0.158083
G1 X116.047 Y129.219 E.00129
; LINE_WIDTH: 0.188896
G1 X116.035 Y129.251 E.00039
; LINE_WIDTH: 0.172378
G1 X115.922 Y129.367 E.00166
; LINE_WIDTH: 0.122861
G1 X115.81 Y129.484 E.00102
; LINE_WIDTH: 0.0970972
G1 X115.786 Y129.506 E.00014
; WIPE_START
G1 X115.81 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.388 Y134.856 Z1 F9000
G1 X108.095 Y137.126 Z1
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.353137
G1 F7736.518
G1 X108.797 Y136.794 E.01903
G1 X108.822 Y136.832 F9000
; LINE_WIDTH: 0.17754
G1 X108.216 Y137.043 E.00683
; LINE_WIDTH: 0.155815
G1 X108.087 Y137.083 E.0012
; LINE_WIDTH: 0.116551
G1 X107.958 Y137.122 E.00078
; WIPE_START
G1 X108.087 Y137.083 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X106.047 Y137.117 Z1 F9000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.117491
G1 F9000
G1 X105.922 Y137.081 E.00077
; LINE_WIDTH: 0.161209
G1 X105.782 Y137.04 E.00136
; LINE_WIDTH: 0.192074
G1 X105.758 Y137.03 E.00031
; LINE_WIDTH: 0.172943
G1 X105.64 Y136.917 E.00168
; LINE_WIDTH: 0.123031
G1 X105.522 Y136.803 E.00103
; LINE_WIDTH: 0.0970841
G1 X105.501 Y136.779 E.00014
; WIPE_START
G1 X105.522 Y136.803 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.126 Y131.405 Z1 F9000
G1 X98.228 Y129.506 Z1
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.0971035
G1 F9000
G1 X98.204 Y129.484 E.00014
; LINE_WIDTH: 0.12276
G1 X98.092 Y129.368 E.00102
; LINE_WIDTH: 0.175257
G1 X97.979 Y129.251 E.00169
G1 X97.963 Y129.209 E.00047
; LINE_WIDTH: 0.157741
G1 X97.926 Y129.092 E.00111
; LINE_WIDTH: 0.117853
G1 X97.888 Y128.956 E.00083
; WIPE_START
G1 X97.926 Y129.092 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X97.888 Y127.044 Z1 F9000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.117855
G1 F9000
G1 X97.926 Y126.908 E.00083
; LINE_WIDTH: 0.157748
G1 X97.963 Y126.791 E.00111
; LINE_WIDTH: 0.175216
G1 X97.979 Y126.749 E.00047
G1 X98.092 Y126.632 E.00169
; LINE_WIDTH: 0.122719
G1 X98.204 Y126.516 E.00102
; LINE_WIDTH: 0.0970641
G1 X98.228 Y126.494 E.00014
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F9000
G1 X98.204 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 118
M625
; layer num/total_layer_count: 4/23
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
M106 S163.2
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G17
G3 Z1 I-.394 J1.152 P1  F9000
G1 X128.76 Y136.96 Z1
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X128.482 Y137.049 E.00941
G3 X127.876 Y132.906 I-.473 J-2.047 E.22328
G3 X129.461 Y133.484 I.14 J2.077 E.05586
G3 X128.817 Y136.942 I-1.452 J1.518 E.13401
M204 S250
G1 X128.643 Y136.589 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X127.906 Y133.297 I-.631 J-1.587 E.17598
G3 X128.761 Y133.467 I.115 J1.658 E.02628
G3 X128.698 Y136.566 I-.75 J1.535 E.11567
; WIPE_START
G1 X128.392 Y136.666 E-.12228
G1 X128.133 Y136.706 E-.09953
G1 X127.871 Y136.706 E-.0995
G1 X127.612 Y136.666 E-.09954
G1 X127.363 Y136.587 E-.09952
G1 X127.128 Y136.47 E-.0995
G1 X126.914 Y136.32 E-.09954
G1 X126.837 Y136.246 E-.04059
; WIPE_END
G1 E-.04 F1800
G1 X132.302 Y130.918 Z1.2 F9000
G1 X136.643 Y126.686 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X136.812 Y126.924 E.0094
G3 X134.796 Y125.912 I-1.803 J1.078 E.34789
G3 X136.402 Y126.429 I.2 J2.13 E.05577
G3 X136.607 Y126.638 I-1.393 J1.573 E.00941
M204 S250
G1 X136.325 Y126.909 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X134.841 Y126.302 I-1.313 J1.092 E.26998
G3 X135.702 Y126.439 I.178 J1.652 E.02628
G3 X136.286 Y126.864 I-.691 J1.562 E.02167
; WIPE_START
G1 X136.473 Y127.126 E-.12232
G1 X136.589 Y127.361 E-.0995
G1 X136.668 Y127.61 E-.09953
G1 X136.708 Y127.869 E-.09953
G1 X136.708 Y128.131 E-.0995
G1 X136.668 Y128.39 E-.09953
G1 X136.589 Y128.64 E-.09955
G1 X136.541 Y128.735 E-.04055
; WIPE_END
G1 E-.04 F1800
G1 X131.912 Y122.667 Z1.2 F9000
G1 X129.59 Y119.623 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X129.767 Y119.857 E.00944
G3 X127.841 Y118.902 I-1.765 J1.14 E.35192
G3 X128.668 Y119.01 I.126 J2.248 E.02697
G1 X128.789 Y119.049 E.00407
G3 X129.551 Y119.577 I-.786 J1.948 E.03008
M204 S250
G1 X129.278 Y119.863 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X127.871 Y119.294 I-1.275 J1.131 E.27222
G3 X128.55 Y119.384 I.103 J1.831 E.0205
G1 X128.642 Y119.413 E.00288
G3 X129.238 Y119.819 I-.639 J1.581 E.02163
; WIPE_START
G1 X129.438 Y120.07 E-.12219
G1 X129.563 Y120.3 E-.09954
G1 X129.652 Y120.547 E-.09953
G1 X129.702 Y120.804 E-.09951
G1 X129.712 Y121.065 E-.09949
G1 X129.682 Y121.326 E-.09955
G1 X129.612 Y121.578 E-.09952
G1 X129.568 Y121.676 E-.04067
; WIPE_END
G1 E-.04 F1800
G1 X125.442 Y126.609 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X125.616 Y126.322 E.01082
G3 X127.446 Y125.133 I2.388 J1.674 E.07192
G1 X127.623 Y125.113 E.00571
G3 X130.255 Y126.142 I.394 J2.873 E.09495
G1 X130.513 Y126.508 E.01438
G3 X125.388 Y126.706 I-2.508 J1.488 E.38781
G1 X125.413 Y126.662 E.00162
G1 X125.792 Y126.817 F9000
G1 F5895.652
G1 X125.956 Y126.561 E.0098
G3 X127.669 Y125.517 I2.053 J1.442 E.06636
G3 X129.94 Y126.402 I.345 J2.471 E.08188
G3 X125.76 Y126.89 I-1.931 J1.601 E.34634
G1 X125.768 Y126.872 E.00062
G1 X126.141 Y127.025 F9000
G1 F5895.652
G1 X126.286 Y126.793 E.0088
G3 X127.716 Y125.921 I1.716 J1.208 E.05539
G3 X128.964 Y126.135 I.284 J2.089 E.04135
G3 X126.116 Y127.079 I-.962 J1.866 E.31664
M204 S250
G1 X126.478 Y127.226 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X126.611 Y127.021 E.00725
G3 X127.761 Y126.311 I1.399 J.979 E.0414
G3 X128.702 Y126.439 I.254 J1.653 E.02868
G3 X126.461 Y127.282 I-.692 J1.562 E.24063
; WIPE_START
G1 X126.611 Y127.021 E-.11415
G1 X126.77 Y126.814 E-.0993
G1 X126.965 Y126.64 E-.09951
G1 X127.185 Y126.497 E-.09953
G1 X127.424 Y126.39 E-.09949
G1 X127.761 Y126.311 E-.13155
G1 X127.937 Y126.291 E-.06724
G1 X128.066 Y126.296 E-.04922
; WIPE_END
M73 P45 R10
G1 E-.04 F1800
G1 X125.323 Y119.847 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G2 X130.677 Y119.833 I2.68 J1.15 E.37113
G1 X131.376 Y120.108 E.02413
G3 X136.161 Y125.322 I-3.405 J7.928 E.23451
G2 X132.314 Y126.88 I-1.151 J2.685 E.14839
G2 X136.161 Y130.678 I2.694 J1.119 E.22237
G1 X136.066 Y130.93 E.00868
G3 X130.677 Y136.167 I-8.124 J-2.97 E.24994
G2 X125.204 Y134.195 I-2.673 J-1.164 E.30666
G2 X125.323 Y136.153 I2.846 J.81 E.0643
G3 X119.852 Y130.681 I2.688 J-8.157 E.25812
G2 X119.852 Y125.319 I1.147 J-2.681 E.37033
G3 X125.266 Y119.866 I8.158 J2.685 E.25619
; WIPE_START
G1 X125.186 Y120.226 E-.14023
G1 X125.101 Y120.665 E-.16996
G1 X125.084 Y121.112 E-.16987
G1 X125.135 Y121.556 E-.16989
G1 X125.212 Y121.835 E-.11005
; WIPE_END
G1 E-.04 F1800
G1 X129.919 Y119.383 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
G1 F5895.652
G1 X130.016 Y119.238 E.0056
G3 X136.822 Y126.238 I-2.037 J8.79 E.33173
G1 X136.368 Y125.891 E.01838
G1 X136.229 Y125.816 E.00508
G2 X136.368 Y130.109 I-1.224 J2.188 E.34078
G1 X136.822 Y129.762 E.01838
G3 X130.016 Y136.762 I-8.843 J-1.79 E.33173
G1 X129.919 Y136.617 E.0056
G2 X125.894 Y136.366 I-1.92 J-1.616 E.3563
G1 X126.236 Y136.814 E.01815
G3 X119.191 Y129.769 I1.773 J-8.817 E.33955
G1 X119.637 Y130.109 E.01802
G2 X119.511 Y125.987 I1.365 J-2.104 E.35116
G1 X119.191 Y126.231 E.01295
G3 X126.236 Y119.186 I8.817 J1.771 E.33956
G1 X125.894 Y119.634 E.01815
G1 X125.818 Y119.773 E.00508
G2 X129.957 Y119.43 I2.186 J1.226 E.34885
; WIPE_START
G1 X130.016 Y119.238 E-.07596
G1 X130.523 Y119.37 E-.19937
G1 X131.035 Y119.537 E-.20437
G1 X131.536 Y119.733 E-.20437
G1 X131.717 Y119.817 E-.07593
; WIPE_END
G1 E-.04 F1800
G1 X126.346 Y125.24 Z1.2 F9000
G1 X123.015 Y128.605 Z1.2
G1 Z.8
G1 E.8 F1800
G1 F5895.652
G1 X123.012 Y128.636 E.00101
G3 X120.956 Y125.903 I-2.003 J-.634 E.29589
G3 X122.518 Y126.541 I.037 J2.139 E.05577
G3 X123.085 Y128.322 I-1.509 J1.461 E.06228
G1 X123.029 Y128.546 E.00745
M204 S250
G1 X122.633 Y128.515 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X122.64 Y128.518 E.0002
G3 X120.971 Y126.294 I-1.628 J-.516 E.22297
M73 P46 R10
G3 X121.819 Y126.497 I.051 J1.661 E.02628
G3 X122.699 Y128.262 I-.808 J1.505 E.06262
G1 X122.648 Y128.457 E.00601
; WIPE_START
G1 X122.64 Y128.518 E-.02335
G1 X122.535 Y128.759 E-.09977
G1 X122.401 Y128.984 E-.09951
G1 X122.235 Y129.186 E-.09952
G1 X122.039 Y129.36 E-.09951
G1 X121.819 Y129.503 E-.09953
G1 X121.58 Y129.61 E-.0995
G1 X121.328 Y129.679 E-.09952
G1 X121.224 Y129.691 E-.03978
; WIPE_END
G1 E-.04 F1800
G1 X124.899 Y123.002 Z1.2 F9000
G1 X127.3 Y118.631 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G3 X128.053 Y118.606 I.684 J9.328 E.02423
G3 X124.052 Y119.473 I-.059 J9.395 E1.76559
G3 X127.24 Y118.636 I3.933 J8.486 E.10657
M204 S250
G1 X127.272 Y118.237 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X128.059 Y118.214 E.02346
G3 X123.887 Y119.117 I-.066 J9.787 E1.70362
G3 X127.214 Y118.244 I4.097 J8.84 E.10299
; WIPE_START
G1 X128.059 Y118.214 E-.32133
G1 X128.441 Y118.22 E-.14537
G1 X129.026 Y118.264 E-.22261
G1 X129.21 Y118.289 E-.07069
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.2 I1.217 J0 P1  F9000
; stop printing object, unique label id: 82
M625
; object ids of layer 4 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.2
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z1.2 F4000
            G39.3 S1
            G0 Z1.2 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END


; object ids of this layer4 end: 82,118
M625
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X129.091 Y118.874 F9000
G1 Z.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.353186
G1 F7735.31
G1 X129.793 Y119.206 E.01902
G1 X129.817 Y119.169 F9000
; LINE_WIDTH: 0.177528
G1 X129.211 Y118.957 E.00683
; LINE_WIDTH: 0.155808
G1 X129.082 Y118.917 E.0012
; LINE_WIDTH: 0.116544
G1 X128.953 Y118.878 E.00078
; WIPE_START
G1 X129.082 Y118.917 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.042 Y118.883 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.117478
G1 F9000
G1 X126.917 Y118.919 E.00077
; LINE_WIDTH: 0.161197
G1 X126.778 Y118.96 E.00136
; LINE_WIDTH: 0.192068
G1 X126.754 Y118.97 E.00031
; LINE_WIDTH: 0.172908
G1 X126.636 Y119.084 E.00168
; LINE_WIDTH: 0.122969
G1 X126.518 Y119.197 E.00103
; LINE_WIDTH: 0.0970487
G1 X126.496 Y119.221 E.00014
; WIPE_START
G1 X126.518 Y119.197 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.122 Y124.595 Z1.2 F9000
G1 X119.223 Y126.494 Z1.2
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.097088
G1 F9000
G1 X119.199 Y126.516 E.00014
; LINE_WIDTH: 0.122731
G1 X119.087 Y126.632 E.00102
; LINE_WIDTH: 0.17522
G1 X118.975 Y126.749 E.00169
G1 X118.958 Y126.791 E.00047
; LINE_WIDTH: 0.157757
G1 X118.922 Y126.908 E.00111
; LINE_WIDTH: 0.11786
G1 X118.883 Y127.044 E.00083
; WIPE_START
G1 X118.922 Y126.908 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.883 Y128.956 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.117842
G1 F9000
G1 X118.922 Y129.092 E.00083
; LINE_WIDTH: 0.157729
G1 X118.958 Y129.209 E.00111
; LINE_WIDTH: 0.175238
G1 X118.975 Y129.251 E.00047
G1 X119.087 Y129.368 E.00169
; LINE_WIDTH: 0.122742
G1 X119.199 Y129.484 E.00102
; LINE_WIDTH: 0.0970945
G1 X119.223 Y129.506 E.00014
; WIPE_START
G1 X119.199 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X124.597 Y134.88 Z1.2 F9000
G1 X126.496 Y136.779 Z1.2
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.0970598
G1 F9000
G1 X126.518 Y136.803 E.00014
; LINE_WIDTH: 0.122976
G1 X126.636 Y136.916 E.00103
; LINE_WIDTH: 0.172899
G1 X126.754 Y137.03 E.00168
; LINE_WIDTH: 0.192047
G1 X126.778 Y137.04 E.00031
; LINE_WIDTH: 0.161171
G1 X126.917 Y137.081 E.00136
; LINE_WIDTH: 0.117474
G1 X127.042 Y137.117 E.00077
; WIPE_START
G1 X126.917 Y137.081 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128.953 Y137.122 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.116552
G1 F9000
G1 X129.082 Y137.083 E.00078
; LINE_WIDTH: 0.155822
G1 X129.211 Y137.043 E.0012
; LINE_WIDTH: 0.177544
G1 X129.818 Y136.832 E.00683
G1 X129.793 Y136.794
; LINE_WIDTH: 0.353128
G1 F7736.755
G1 X129.091 Y137.126 E.01903
; WIPE_START
G1 X129.793 Y136.794 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.499 Y131.264 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.371252
G1 F7309.676
G1 X131.272 Y131.499 E.00846
G1 X131.743 Y131.987 E.01758
; LINE_WIDTH: 0.41453
G1 F6458.384
G1 X131.902 Y132.176 E.00725
; LINE_WIDTH: 0.46159
G1 F5732.439
G1 X132.06 Y132.365 E.00817
; LINE_WIDTH: 0.50865
G1 F5153.2
G1 X132.218 Y132.555 E.00908
; LINE_WIDTH: 0.549498
G1 F4737.677
G1 X132.418 Y132.92 E.01666
G2 X132.923 Y132.416 I-3.612 J-4.123 E.02858
G1 X132.557 Y132.216 E.01669
; LINE_WIDTH: 0.509319
G1 F5145.816
G1 X132.38 Y132.069 E.00848
; LINE_WIDTH: 0.463595
G1 F5705.117
G1 X132.202 Y131.922 E.00765
; LINE_WIDTH: 0.417872
G1 F6400.825
G1 X132.025 Y131.775 E.00682
; LINE_WIDTH: 0.375585
G1 F7214.481
G3 X131.54 Y131.307 I4.417 J-5.067 E.01771
G1 X130.728 Y131.499 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G3 X131.855 Y132.79 I-2.892 J3.662 E.05134
G3 X132.234 Y133.645 I-5.302 J2.862 E.02788
G2 X133.652 Y132.228 I-4.646 J-6.07 E.05987
G1 X133.007 Y131.966 E.02074
G1 X132.391 Y131.593 E.02146
G1 X131.873 Y131.152 E.02025
G1 X131.518 Y130.746 E.01606
G3 X130.773 Y131.459 I-4.885 J-4.359 E.03076
G1 X130.058 Y131.501 F9000
G1 F6364.866
G3 X131.191 Y132.479 I-2.183 J3.676 E.04479
G3 X132 Y134.267 I-3.185 J2.519 E.05906
G2 X134.267 Y132.002 I-3.992 J-6.261 E.0962
G3 X132.596 Y131.276 I.99 J-4.566 E.05462
G3 X131.506 Y130.06 I2.745 J-3.556 E.04891
G1 X131.184 Y130.53 E.01698
G3 X130.109 Y131.47 I-3.642 J-3.079 E.04268
G1 X130.179 Y130.969 F9000
G1 F6364.866
G3 X129.157 Y131.497 I-2.177 J-2.965 E.03443
G3 X131.689 Y134.885 I-1.203 J3.54 E.13393
G2 X134.888 Y131.687 I-3.676 J-6.876 E.13671
G3 X133.315 Y131.278 I.228 J-4.104 E.04872
G1 X132.801 Y130.96 E.01803
G3 X131.498 Y129.154 I2.21 J-2.967 E.06734
G3 X130.225 Y130.93 I-3.472 J-1.146 E.06608
; WIPE_START
G1 X130.589 Y130.621 E-.1814
G1 X130.957 Y130.198 E-.21296
G1 X131.272 Y129.693 E-.22627
G1 X131.414 Y129.354 E-.13937
; WIPE_END
G1 E-.04 F1800
G1 X126.843 Y131.499 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
G1 F6364.866
G3 X124.502 Y129.163 I1.148 J-3.49 E.10216
G3 X121.116 Y131.687 I-3.532 J-1.205 E.13372
G2 X124.248 Y134.851 I6.933 J-3.731 E.13444
G1 X124.314 Y134.872 E.00208
G3 X126.787 Y131.521 I3.693 J.137 E.13176
; WIPE_START
G1 X126.305 Y131.727 E-.19909
G1 X125.845 Y132.008 E-.205
G1 X125.413 Y132.372 E-.21459
G1 X125.169 Y132.653 E-.14131
; WIPE_END
G1 E-.04 F1800
G1 X124.737 Y131.497 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.371386
G1 F7306.711
G1 X124.502 Y131.268 E.00851
G1 X124.016 Y131.741 E.01761
; LINE_WIDTH: 0.414525
G1 F6458.471
G1 X123.826 Y131.899 E.00725
; LINE_WIDTH: 0.461575
G1 F5732.644
G1 X123.637 Y132.058 E.00816
; LINE_WIDTH: 0.508625
G1 F5153.477
G1 X123.448 Y132.216 E.00908
; LINE_WIDTH: 0.549719
G1 F4735.61
G1 X123.081 Y132.416 E.01671
G1 X123.476 Y132.819 E.02257
G1 X123.59 Y132.912 E.0059
G1 X123.786 Y132.554 E.01634
; LINE_WIDTH: 0.509295
G1 F5146.074
G1 X123.933 Y132.377 E.00848
; LINE_WIDTH: 0.463585
G1 F5705.252
G1 X124.08 Y132.2 E.00765
; LINE_WIDTH: 0.417875
G1 F6400.768
G1 X124.227 Y132.023 E.00682
; LINE_WIDTH: 0.375632
G1 F7213.454
G3 X124.694 Y131.538 I5.379 J4.711 E.01769
G1 X124.502 Y130.727 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G3 X123.212 Y131.853 I-3.658 J-2.889 E.05129
G1 X122.598 Y132.145 E.02025
G1 X122.353 Y132.228 E.00773
G2 X123.774 Y133.649 I5.469 J-4.051 E.06008
G1 X123.996 Y133.094 E.01779
G1 X124.41 Y132.388 E.02437
G1 X124.85 Y131.871 E.02025
G3 X125.272 Y131.503 I6.16 J6.637 E.01668
G3 X124.542 Y130.772 I2.372 J-3.101 E.03087
G1 X124.502 Y130.054 F9000
G1 F6364.866
G1 X124.285 Y130.397 E.01211
G3 X121.736 Y131.998 I-3.281 J-2.395 E.09185
G2 X124.004 Y134.267 I6.242 J-3.971 E.09634
G1 X124.153 Y133.694 E.01764
G3 X125.605 Y131.717 I3.85 J1.306 E.07422
G1 X125.945 Y131.502 E.01198
G3 X124.534 Y130.105 I1.936 J-3.364 E.05981
; WIPE_START
G1 X124.719 Y130.397 E-.13164
G1 X125.107 Y130.855 E-.22772
G1 X125.481 Y131.189 E-.1906
G1 X125.939 Y131.498 E-.21004
; WIPE_END
G1 E-.04 F1800
G1 X124.69 Y127.986 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.42344
G1 F6307.168
G1 X124.716 Y127.477 E.01532
G3 X126.003 Y125.359 I3.497 J.675 E.07609
G3 X131.231 Y127.259 I1.999 J2.643 E.19844
G3 X128.866 Y131.198 I-3.229 J.741 E.15258
G1 X128.368 Y131.304 E.0153
G3 X124.84 Y128.986 I-.321 J-3.356 E.13712
G1 X124.708 Y128.495 E.01527
G1 X124.692 Y128.046 E.01352
G1 X124.314 Y127.986 F9000
; LINE_WIDTH: 0.420812
G1 F6351.027
G1 X124.296 Y128.493 E.01515
G3 X123.022 Y130.626 I-3.521 J-.657 E.07574
G3 X120.493 Y131.267 I-2.006 J-2.605 E.08008
G2 X124.735 Y135.507 I7.532 J-3.292 E.18329
G1 X124.692 Y134.888 E.01855
G3 X131.269 Y135.51 I3.307 J.112 E.3223
G2 X135.504 Y131.268 I-3.282 J-7.512 E.18317
G1 X134.89 Y131.311 E.01837
G3 X135.51 Y124.733 I.112 J-3.307 E.32222
G2 X131.271 Y120.502 I-7.491 J3.266 E.18304
G1 X131.313 Y121.112 E.01826
G3 X124.735 Y120.493 I-3.307 J-.112 E.32222
G2 X120.507 Y124.731 I3.267 J7.489 E.18298
G1 X121.035 Y124.692 E.0158
G1 X121.619 Y124.745 E.0175
G3 X124.156 Y126.987 I-.663 J3.307 E.10587
G1 X124.288 Y127.477 E.01515
G1 X124.311 Y127.926 E.01342
; WIPE_START
G1 X124.288 Y127.477 E-.17084
G1 X124.156 Y126.987 E-.1929
G1 X123.964 Y126.517 E-.19274
G1 X123.703 Y126.082 E-.1927
G1 X123.685 Y126.06 E-.01081
; WIPE_END
G1 E-.04 F1800
G1 X124.502 Y125.946 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X124.719 Y125.603 E.01211
G3 X125.945 Y124.498 I3.467 J2.614 E.04944
G3 X124.004 Y121.733 I2.092 J-3.532 E.1037
G2 X121.736 Y124.002 I4.026 J6.293 E.09633
G3 X124.47 Y125.896 I-.722 J3.963 E.10212
G1 X124.502 Y125.273 F9000
G1 F6364.866
G3 X125.272 Y124.497 I4.21 J3.407 E.03262
G3 X124.15 Y123.21 I2.891 J-3.654 E.05116
G1 X123.857 Y122.596 E.02025
G1 X123.774 Y122.351 E.00771
G2 X122.353 Y123.772 I4.302 J5.726 E.06005
G1 X123.035 Y124.051 E.02196
G1 X123.614 Y124.407 E.02025
G1 X124.131 Y124.848 E.02025
G1 X124.463 Y125.228 E.01502
G1 X124.737 Y124.503 F9000
; LINE_WIDTH: 0.3762
G1 F7201.152
G1 X124.261 Y124.013 E.01798
; LINE_WIDTH: 0.414534
G1 F6458.326
G1 X124.103 Y123.824 E.00725
; LINE_WIDTH: 0.46158
G1 F5732.576
G1 X123.945 Y123.635 E.00816
; LINE_WIDTH: 0.508627
G1 F5153.458
G1 X123.786 Y123.446 E.00908
; LINE_WIDTH: 0.549659
G1 F4736.171
G1 X123.576 Y123.085 E.01669
G2 X123.081 Y123.584 I5.602 J6.056 E.02813
G1 X123.448 Y123.784 E.01671
; LINE_WIDTH: 0.508627
G1 F5153.458
G1 X123.637 Y123.942 E.00908
; LINE_WIDTH: 0.46158
G1 F5732.576
G1 X123.826 Y124.101 E.00816
; LINE_WIDTH: 0.414534
G1 F6458.326
G1 X124.016 Y124.259 E.00725
; LINE_WIDTH: 0.369523
G1 F7348.39
G3 X124.502 Y124.732 I-3.718 J4.311 E.01752
G1 X124.694 Y124.545 E.00691
; WIPE_START
G1 X124.502 Y124.732 E-.21508
G1 X124.016 Y124.259 E-.54492
; WIPE_END
G1 E-.04 F1800
G1 X126.843 Y124.501 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G3 X124.318 Y121.184 I1.159 J-3.501 E.13194
G1 X124.3 Y121.119 E.00202
G2 X121.116 Y124.313 I3.76 J6.932 E.13623
G3 X124.502 Y126.837 I-.113 J3.685 E.13396
G3 X126.785 Y124.519 I3.494 J1.158 E.10039
; WIPE_START
G1 X126.278 Y124.739 E-.21009
G1 X125.793 Y125.045 E-.21814
G1 X125.364 Y125.421 E-.21641
G1 X125.169 Y125.653 E-.11536
; WIPE_END
G1 E-.04 F1800
M73 P47 R10
G1 X130.18 Y125.031 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
G1 F6364.866
G3 X131.498 Y126.846 I-2.179 J2.97 E.06789
G3 X134.888 Y124.313 I3.531 J1.192 E.13403
G2 X133.402 Y122.352 I-6.94 J3.716 E.07359
G2 X131.689 Y121.115 I-5.56 J5.892 E.06312
G3 X131.263 Y122.724 I-4.122 J-.23 E.04993
G3 X129.157 Y124.503 I-3.361 J-1.843 E.08402
G3 X130.129 Y125 I-1.081 J3.317 E.03264
G1 X130.728 Y124.501 F9000
G1 F6364.866
G3 X131.492 Y125.253 I-2.948 J3.762 E.032
G3 X133.652 Y123.772 I3.72 J3.11 E.07899
G2 X132.234 Y122.355 I-5.459 J4.048 E.05992
G1 X131.951 Y123.033 E.02186
G1 X131.595 Y123.611 E.02025
G1 X131.154 Y124.129 E.02025
G1 X130.773 Y124.462 E.01506
G1 X131.499 Y124.736 F9000
; LINE_WIDTH: 0.376105
G1 F7203.205
G1 X131.989 Y124.259 E.018
; LINE_WIDTH: 0.414539
G1 F6458.239
G1 X132.178 Y124.101 E.00725
; LINE_WIDTH: 0.461595
G1 F5732.37
G1 X132.367 Y123.942 E.00816
; LINE_WIDTH: 0.508652
G1 F5153.182
G1 X132.557 Y123.784 E.00908
; LINE_WIDTH: 0.549498
G1 F4737.677
G1 X132.923 Y123.584 E.01669
G2 X132.418 Y123.08 I-3.764 J3.265 E.02858
G1 X132.218 Y123.445 E.01667
; LINE_WIDTH: 0.508652
G1 F5153.182
G1 X132.06 Y123.635 E.00908
; LINE_WIDTH: 0.461595
G1 F5732.37
G1 X131.902 Y123.824 E.00816
; LINE_WIDTH: 0.414539
G1 F6458.239
G1 X131.743 Y124.013 E.00725
; LINE_WIDTH: 0.369631
G1 F7345.94
G2 X131.283 Y124.511 I4.859 J4.957 E.01751
G1 X131.457 Y124.693 E.0065
; WIPE_START
G1 X131.283 Y124.511 E-.20578
G1 X131.743 Y124.013 E-.55422
; WIPE_END
G1 E-.04 F1800
G1 X131.368 Y125.731 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X131.506 Y125.94 E.00746
G3 X133.526 Y124.214 I3.499 J2.051 E.08063
G3 X134.267 Y123.998 I2.025 J5.558 E.02301
G2 X132 Y121.733 I-6.307 J4.044 E.0962
G1 X131.866 Y122.254 E.01604
G1 X131.607 Y122.878 E.02012
G3 X130.4 Y124.283 I-3.991 J-2.21 E.05556
G1 X130.058 Y124.499 E.01203
G1 X130.653 Y124.918 E.02166
G3 X131.331 Y125.684 I-2.713 J3.085 E.03055
; WIPE_START
G1 X131.009 Y125.272 E-.19835
G1 X130.653 Y124.918 E-.19115
G1 X130.058 Y124.499 E-.27636
G1 X130.267 Y124.366 E-.09413
; WIPE_END
G1 E-.04 F1800
G1 X136.781 Y126.494 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.097072
G1 F9000
G1 X136.805 Y126.516 E.00014
; LINE_WIDTH: 0.122819
G1 X136.918 Y126.633 E.00102
; LINE_WIDTH: 0.172349
G1 X137.03 Y126.749 E.00166
; LINE_WIDTH: 0.188873
G1 X137.042 Y126.781 E.00039
; LINE_WIDTH: 0.158068
G1 X137.083 Y126.916 E.00129
; LINE_WIDTH: 0.116757
G1 X137.121 Y127.041 E.00076
; WIPE_START
G1 X137.083 Y126.916 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.121 Y128.958 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.116753
G1 F9000
G1 X137.083 Y129.084 E.00076
; LINE_WIDTH: 0.158084
G1 X137.042 Y129.219 E.00129
; LINE_WIDTH: 0.188889
G1 X137.03 Y129.251 E.00039
; LINE_WIDTH: 0.172367
G1 X136.918 Y129.367 E.00166
; LINE_WIDTH: 0.122857
G1 X136.805 Y129.484 E.00102
; LINE_WIDTH: 0.0971031
G1 X136.781 Y129.506 E.00014
; OBJECT_ID: 118
; WIPE_START
G1 X136.805 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X129.414 Y131.387 Z1.2 F9000
G1 X107.765 Y136.96 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X107.486 Y137.049 E.00941
G3 X106.881 Y132.906 I-.473 J-2.047 E.22328
G3 X108.466 Y133.484 I.14 J2.077 E.05586
G3 X107.822 Y136.942 I-1.452 J1.518 E.13401
M204 S250
G1 X107.647 Y136.589 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X106.911 Y133.297 I-.631 J-1.587 E.17598
G3 X107.766 Y133.467 I.115 J1.658 E.02628
G3 X107.702 Y136.566 I-.75 J1.535 E.11567
; WIPE_START
G1 X107.396 Y136.666 E-.12228
G1 X107.138 Y136.706 E-.09953
G1 X106.876 Y136.706 E-.0995
G1 X106.617 Y136.666 E-.09954
G1 X106.367 Y136.587 E-.09952
G1 X106.133 Y136.47 E-.0995
G1 X105.918 Y136.32 E-.09954
G1 X105.841 Y136.246 E-.04059
; WIPE_END
G1 E-.04 F1800
G1 X111.306 Y130.918 Z1.2 F9000
G1 X115.647 Y126.686 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X115.817 Y126.924 E.0094
G3 X113.8 Y125.912 I-1.803 J1.078 E.34789
G3 X115.407 Y126.429 I.2 J2.13 E.05577
G3 X115.611 Y126.638 I-1.393 J1.573 E.00941
M204 S250
G1 X115.329 Y126.909 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X113.845 Y126.302 I-1.313 J1.092 E.26998
G3 X114.706 Y126.439 I.178 J1.652 E.02628
G3 X115.29 Y126.864 I-.691 J1.562 E.02167
; WIPE_START
G1 X115.477 Y127.126 E-.12232
G1 X115.593 Y127.361 E-.0995
G1 X115.672 Y127.61 E-.09953
G1 X115.712 Y127.869 E-.09953
G1 X115.712 Y128.131 E-.0995
G1 X115.672 Y128.39 E-.09953
G1 X115.593 Y128.64 E-.09955
G1 X115.546 Y128.735 E-.04055
; WIPE_END
G1 E-.04 F1800
G1 X110.917 Y122.667 Z1.2 F9000
G1 X108.595 Y119.623 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X108.772 Y119.857 E.00944
G3 X106.846 Y118.902 I-1.765 J1.14 E.35192
G3 X107.672 Y119.01 I.126 J2.248 E.02697
G1 X107.793 Y119.049 E.00407
G3 X108.556 Y119.577 I-.786 J1.948 E.03008
M204 S250
G1 X108.283 Y119.863 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X106.876 Y119.294 I-1.275 J1.131 E.27222
G3 X107.554 Y119.384 I.103 J1.831 E.0205
G1 X107.646 Y119.413 E.00288
G3 X108.242 Y119.819 I-.639 J1.581 E.02163
; WIPE_START
G1 X108.443 Y120.07 E-.12219
G1 X108.568 Y120.3 E-.09954
G1 X108.656 Y120.547 E-.09953
G1 X108.706 Y120.804 E-.09951
G1 X108.716 Y121.065 E-.09949
G1 X108.686 Y121.326 E-.09955
G1 X108.617 Y121.578 E-.09952
G1 X108.573 Y121.676 E-.04067
; WIPE_END
G1 E-.04 F1800
G1 X104.446 Y126.609 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X104.621 Y126.322 E.01082
G3 X106.451 Y125.133 I2.388 J1.674 E.07192
G1 X106.627 Y125.113 E.00571
G3 X109.26 Y126.142 I.394 J2.873 E.09495
G1 X109.517 Y126.508 E.01438
G3 X104.393 Y126.706 I-2.508 J1.488 E.38781
G1 X104.417 Y126.662 E.00162
G1 X104.796 Y126.817 F9000
G1 F5895.652
G1 X104.961 Y126.561 E.0098
G3 X106.674 Y125.517 I2.053 J1.442 E.06636
G3 X108.945 Y126.402 I.345 J2.471 E.08188
G3 X104.765 Y126.89 I-1.931 J1.601 E.34634
G1 X104.772 Y126.872 E.00062
G1 X105.146 Y127.025 F9000
G1 F5895.652
G1 X105.29 Y126.793 E.0088
G3 X106.721 Y125.921 I1.716 J1.208 E.05539
G3 X107.968 Y126.135 I.284 J2.089 E.04135
G3 X105.12 Y127.079 I-.962 J1.866 E.31664
M204 S250
G1 X105.483 Y127.226 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X105.615 Y127.021 E.00725
G3 X106.765 Y126.311 I1.399 J.979 E.0414
G3 X107.706 Y126.439 I.254 J1.653 E.02868
G3 X105.465 Y127.282 I-.692 J1.562 E.24063
; WIPE_START
G1 X105.615 Y127.021 E-.11415
G1 X105.774 Y126.814 E-.0993
G1 X105.97 Y126.64 E-.09951
G1 X106.19 Y126.497 E-.09953
G1 X106.428 Y126.39 E-.09949
G1 X106.765 Y126.311 E-.13155
G1 X106.941 Y126.291 E-.06724
G1 X107.071 Y126.296 E-.04922
; WIPE_END
G1 E-.04 F1800
G1 X104.327 Y119.847 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G2 X109.682 Y119.833 I2.68 J1.15 E.37113
G1 X110.38 Y120.108 E.02413
G3 X115.165 Y125.322 I-3.405 J7.928 E.23451
G2 X111.319 Y126.88 I-1.151 J2.685 E.14839
G2 X115.165 Y130.678 I2.694 J1.119 E.22237
G1 X115.071 Y130.93 E.00868
G3 X109.682 Y136.167 I-8.124 J-2.97 E.24994
G2 X104.208 Y134.195 I-2.673 J-1.164 E.30666
G2 X104.327 Y136.153 I2.846 J.81 E.0643
G3 X98.856 Y130.681 I2.688 J-8.157 E.25812
G2 X98.856 Y125.319 I1.147 J-2.681 E.37033
G3 X104.27 Y119.866 I8.158 J2.685 E.25619
; WIPE_START
G1 X104.191 Y120.226 E-.14023
G1 X104.106 Y120.665 E-.16996
G1 X104.088 Y121.112 E-.16987
G1 X104.14 Y121.556 E-.16989
G1 X104.217 Y121.835 E-.11005
; WIPE_END
G1 E-.04 F1800
G1 X108.924 Y119.383 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
G1 F5895.652
G1 X109.02 Y119.238 E.0056
G3 X115.827 Y126.238 I-2.037 J8.79 E.33173
G1 X115.372 Y125.891 E.01838
G1 X115.234 Y125.816 E.00508
G2 X115.372 Y130.109 I-1.224 J2.188 E.34078
G1 X115.827 Y129.762 E.01838
G3 X109.02 Y136.762 I-8.843 J-1.79 E.33173
G1 X108.924 Y136.617 E.0056
G2 X104.898 Y136.366 I-1.92 J-1.616 E.3563
G1 X105.24 Y136.814 E.01815
G3 X98.196 Y129.769 I1.773 J-8.817 E.33955
G1 X98.641 Y130.109 E.01802
G2 X98.516 Y125.987 I1.365 J-2.104 E.35116
G1 X98.196 Y126.231 E.01295
G3 X105.24 Y119.186 I8.817 J1.771 E.33956
G1 X104.898 Y119.634 E.01815
G1 X104.823 Y119.773 E.00508
G2 X108.962 Y119.43 I2.186 J1.226 E.34885
; WIPE_START
G1 X109.02 Y119.238 E-.07596
G1 X109.528 Y119.37 E-.19937
G1 X110.039 Y119.537 E-.20437
G1 X110.54 Y119.733 E-.20437
G1 X110.721 Y119.817 E-.07593
; WIPE_END
G1 E-.04 F1800
G1 X105.351 Y125.24 Z1.2 F9000
G1 X102.02 Y128.605 Z1.2
G1 Z.8
G1 E.8 F1800
G1 F5895.652
G1 X102.016 Y128.636 E.00101
G3 X99.961 Y125.903 I-2.003 J-.634 E.29589
G3 X101.523 Y126.541 I.037 J2.139 E.05577
G3 X102.09 Y128.322 I-1.509 J1.461 E.06228
G1 X102.034 Y128.546 E.00745
M204 S250
G1 X101.638 Y128.515 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X101.644 Y128.518 E.0002
G3 X99.976 Y126.294 I-1.628 J-.516 E.22297
G3 X100.824 Y126.497 I.051 J1.661 E.02628
G3 X101.704 Y128.262 I-.808 J1.505 E.06262
G1 X101.653 Y128.457 E.00601
; WIPE_START
G1 X101.644 Y128.518 E-.02335
G1 X101.54 Y128.759 E-.09977
G1 X101.406 Y128.984 E-.09951
G1 X101.239 Y129.186 E-.09952
G1 X101.044 Y129.36 E-.09951
G1 X100.824 Y129.503 E-.09953
G1 X100.585 Y129.61 E-.0995
G1 X100.332 Y129.679 E-.09952
G1 X100.228 Y129.691 E-.03978
; WIPE_END
G1 E-.04 F1800
G1 X103.903 Y123.002 Z1.2 F9000
G1 X106.305 Y118.631 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G3 X107.057 Y118.606 I.684 J9.328 E.02423
G3 X103.056 Y119.473 I-.059 J9.395 E1.76559
G3 X106.245 Y118.636 I3.933 J8.486 E.10657
M204 S250
G1 X106.276 Y118.237 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X107.063 Y118.214 E.02346
G3 X102.891 Y119.117 I-.066 J9.787 E1.70362
M73 P48 R10
G3 X106.218 Y118.244 I4.097 J8.84 E.10299
G1 X106.047 Y118.883 F9000
; FEATURE: Gap infill
; LINE_WIDTH: 0.117478
G1 X105.922 Y118.919 E.00077
; LINE_WIDTH: 0.161197
G1 X105.782 Y118.96 E.00136
; LINE_WIDTH: 0.192068
G1 X105.758 Y118.97 E.00031
; LINE_WIDTH: 0.172908
G1 X105.64 Y119.084 E.00168
; LINE_WIDTH: 0.122969
G1 X105.522 Y119.197 E.00103
; LINE_WIDTH: 0.0970487
G1 X105.501 Y119.221 E.00014
; WIPE_START
G1 X105.522 Y119.197 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.958 Y118.878 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.116544
G1 F9000
G1 X108.087 Y118.917 E.00078
; LINE_WIDTH: 0.155808
G1 X108.216 Y118.957 E.0012
; LINE_WIDTH: 0.177528
G1 X108.822 Y119.169 E.00683
G1 X108.797 Y119.206
; LINE_WIDTH: 0.353186
G1 F7735.31
G1 X108.096 Y118.874 E.01902
; WIPE_START
G1 X108.797 Y119.206 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X102.514 Y123.539 Z1.2 F9000
G1 X98.228 Y126.494 Z1.2
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.097088
G1 F9000
G1 X98.204 Y126.516 E.00014
; LINE_WIDTH: 0.122731
G1 X98.091 Y126.632 E.00102
; LINE_WIDTH: 0.17522
G1 X97.979 Y126.749 E.00169
G1 X97.963 Y126.791 E.00047
; LINE_WIDTH: 0.157757
G1 X97.926 Y126.908 E.00111
; LINE_WIDTH: 0.11786
G1 X97.888 Y127.044 E.00083
; WIPE_START
G1 X97.926 Y126.908 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X97.888 Y128.956 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.117842
G1 F9000
G1 X97.926 Y129.092 E.00083
; LINE_WIDTH: 0.157729
G1 X97.963 Y129.209 E.00111
; LINE_WIDTH: 0.175238
G1 X97.979 Y129.251 E.00047
G1 X98.092 Y129.368 E.00169
; LINE_WIDTH: 0.122742
G1 X98.204 Y129.484 E.00102
; LINE_WIDTH: 0.0970945
G1 X98.228 Y129.506 E.00014
; WIPE_START
G1 X98.204 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.601 Y134.88 Z1.2 F9000
G1 X105.501 Y136.779 Z1.2
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.0970598
G1 F9000
G1 X105.522 Y136.803 E.00014
; LINE_WIDTH: 0.122976
G1 X105.64 Y136.916 E.00103
; LINE_WIDTH: 0.172899
G1 X105.758 Y137.03 E.00168
; LINE_WIDTH: 0.192047
G1 X105.782 Y137.04 E.00031
; LINE_WIDTH: 0.161171
G1 X105.922 Y137.081 E.00136
; LINE_WIDTH: 0.117474
G1 X106.047 Y137.117 E.00077
; WIPE_START
G1 X105.922 Y137.081 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.958 Y137.122 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.116552
G1 F9000
G1 X108.087 Y137.083 E.00078
; LINE_WIDTH: 0.155822
G1 X108.216 Y137.043 E.0012
; LINE_WIDTH: 0.177544
G1 X108.822 Y136.832 E.00683
G1 X108.797 Y136.794
; LINE_WIDTH: 0.353128
G1 F7736.755
G1 X108.095 Y137.126 E.01903
; WIPE_START
G1 X108.797 Y136.794 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.503 Y131.264 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.371252
G1 F7309.676
G1 X110.277 Y131.499 E.00846
G1 X110.748 Y131.987 E.01758
; LINE_WIDTH: 0.41453
G1 F6458.384
G1 X110.906 Y132.176 E.00725
; LINE_WIDTH: 0.46159
G1 F5732.439
G1 X111.064 Y132.365 E.00817
; LINE_WIDTH: 0.50865
G1 F5153.2
G1 X111.223 Y132.555 E.00908
; LINE_WIDTH: 0.549498
G1 F4737.677
G1 X111.422 Y132.92 E.01666
G2 X111.927 Y132.416 I-3.612 J-4.123 E.02858
G1 X111.561 Y132.216 E.01669
; LINE_WIDTH: 0.509319
G1 F5145.816
G1 X111.384 Y132.069 E.00848
; LINE_WIDTH: 0.463595
G1 F5705.117
G1 X111.207 Y131.922 E.00765
; LINE_WIDTH: 0.417872
G1 F6400.825
G1 X111.03 Y131.775 E.00682
; LINE_WIDTH: 0.375585
G1 F7214.481
G3 X110.545 Y131.307 I4.417 J-5.067 E.01771
G1 X109.732 Y131.499 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G3 X110.859 Y132.79 I-2.892 J3.662 E.05134
G3 X111.238 Y133.645 I-5.302 J2.862 E.02788
G2 X112.657 Y132.228 I-4.646 J-6.07 E.05987
G1 X112.011 Y131.966 E.02074
G1 X111.395 Y131.593 E.02146
G1 X110.877 Y131.152 E.02025
G1 X110.523 Y130.746 E.01606
G3 X109.777 Y131.459 I-4.885 J-4.359 E.03076
G1 X109.063 Y131.501 F9000
G1 F6364.866
G3 X110.195 Y132.479 I-2.183 J3.676 E.04479
G3 X111.005 Y134.267 I-3.185 J2.519 E.05906
G2 X113.271 Y132.002 I-3.992 J-6.261 E.0962
G3 X111.6 Y131.276 I.99 J-4.566 E.05462
G3 X110.51 Y130.06 I2.745 J-3.556 E.04891
G1 X110.188 Y130.53 E.01698
G3 X109.114 Y131.47 I-3.642 J-3.079 E.04268
G1 X109.184 Y130.969 F9000
G1 F6364.866
G3 X108.161 Y131.497 I-2.177 J-2.965 E.03443
G3 X110.694 Y134.885 I-1.203 J3.54 E.13393
G2 X113.893 Y131.687 I-3.676 J-6.876 E.13671
G3 X112.32 Y131.278 I.228 J-4.104 E.04872
G1 X111.805 Y130.96 E.01803
G3 X110.503 Y129.154 I2.21 J-2.967 E.06734
G3 X109.23 Y130.93 I-3.472 J-1.146 E.06608
; WIPE_START
G1 X109.593 Y130.621 E-.1814
G1 X109.961 Y130.198 E-.21296
G1 X110.276 Y129.693 E-.22627
G1 X110.419 Y129.354 E-.13937
; WIPE_END
G1 E-.04 F1800
G1 X105.847 Y131.499 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
G1 F6364.866
G3 X103.507 Y129.163 I1.148 J-3.49 E.10216
G3 X100.12 Y131.687 I-3.532 J-1.205 E.13372
G2 X103.252 Y134.851 I6.933 J-3.731 E.13444
G1 X103.319 Y134.872 E.00208
G3 X105.792 Y131.521 I3.693 J.137 E.13176
; WIPE_START
G1 X105.31 Y131.727 E-.19909
G1 X104.849 Y132.008 E-.205
G1 X104.418 Y132.372 E-.21459
G1 X104.174 Y132.653 E-.14131
; WIPE_END
G1 E-.04 F1800
G1 X103.742 Y131.497 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.371386
G1 F7306.711
G1 X103.507 Y131.268 E.00851
G1 X103.02 Y131.741 E.01761
; LINE_WIDTH: 0.414525
G1 F6458.471
G1 X102.831 Y131.899 E.00725
; LINE_WIDTH: 0.461575
G1 F5732.644
G1 X102.642 Y132.058 E.00816
; LINE_WIDTH: 0.508625
G1 F5153.477
G1 X102.452 Y132.216 E.00908
; LINE_WIDTH: 0.549719
G1 F4735.61
G1 X102.086 Y132.416 E.01671
G1 X102.48 Y132.819 E.02257
G1 X102.594 Y132.912 E.0059
G1 X102.791 Y132.554 E.01634
; LINE_WIDTH: 0.509295
G1 F5146.074
G1 X102.938 Y132.377 E.00848
; LINE_WIDTH: 0.463585
G1 F5705.252
G1 X103.085 Y132.2 E.00765
; LINE_WIDTH: 0.417875
G1 F6400.768
G1 X103.232 Y132.023 E.00682
; LINE_WIDTH: 0.375632
G1 F7213.454
G3 X103.698 Y131.538 I5.379 J4.711 E.01769
G1 X103.507 Y130.727 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G3 X102.217 Y131.853 I-3.658 J-2.889 E.05129
G1 X101.603 Y132.145 E.02025
G1 X101.357 Y132.228 E.00773
G2 X102.779 Y133.649 I5.469 J-4.051 E.06008
G1 X103.001 Y133.094 E.01779
G1 X103.414 Y132.388 E.02437
G1 X103.855 Y131.871 E.02025
G3 X104.277 Y131.503 I6.16 J6.637 E.01668
G3 X103.546 Y130.772 I2.372 J-3.101 E.03087
G1 X103.507 Y130.054 F9000
G1 F6364.866
G1 X103.29 Y130.397 E.01211
G3 X100.74 Y131.998 I-3.281 J-2.395 E.09185
G2 X103.009 Y134.267 I6.242 J-3.971 E.09634
G1 X103.157 Y133.694 E.01764
G3 X104.609 Y131.717 I3.85 J1.306 E.07422
G1 X104.949 Y131.502 E.01198
G3 X103.539 Y130.105 I1.936 J-3.364 E.05981
; WIPE_START
G1 X103.724 Y130.397 E-.13164
G1 X104.111 Y130.855 E-.22772
G1 X104.485 Y131.189 E-.1906
G1 X104.943 Y131.498 E-.21004
; WIPE_END
G1 E-.04 F1800
G1 X103.694 Y127.986 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.42344
G1 F6307.168
G1 X103.72 Y127.477 E.01532
G3 X105.007 Y125.359 I3.497 J.675 E.07609
G3 X110.235 Y127.259 I1.999 J2.643 E.19844
G3 X107.871 Y131.198 I-3.229 J.741 E.15258
G1 X107.373 Y131.304 E.0153
G3 X103.844 Y128.986 I-.321 J-3.356 E.13712
G1 X103.713 Y128.495 E.01527
G1 X103.697 Y128.046 E.01352
G1 X103.319 Y127.986 F9000
; LINE_WIDTH: 0.420812
G1 F6351.027
G1 X103.301 Y128.493 E.01515
G3 X102.026 Y130.626 I-3.521 J-.657 E.07574
G3 X99.497 Y131.267 I-2.006 J-2.605 E.08008
G2 X103.74 Y135.507 I7.532 J-3.292 E.18329
G1 X103.696 Y134.888 E.01855
G3 X110.273 Y135.51 I3.307 J.112 E.3223
G2 X114.508 Y131.268 I-3.282 J-7.512 E.18317
G1 X113.894 Y131.311 E.01837
G3 X114.514 Y124.733 I.112 J-3.307 E.32222
G2 X110.276 Y120.502 I-7.491 J3.266 E.18304
G1 X110.317 Y121.112 E.01826
G3 X103.74 Y120.493 I-3.307 J-.112 E.32222
G2 X99.511 Y124.731 I3.267 J7.489 E.18298
G1 X100.039 Y124.692 E.0158
G1 X100.623 Y124.745 E.0175
G3 X103.16 Y126.987 I-.663 J3.307 E.10587
G1 X103.293 Y127.477 E.01515
G1 X103.316 Y127.926 E.01342
; WIPE_START
G1 X103.293 Y127.477 E-.17084
G1 X103.16 Y126.987 E-.1929
G1 X102.969 Y126.517 E-.19274
G1 X102.708 Y126.082 E-.1927
G1 X102.689 Y126.06 E-.01081
; WIPE_END
G1 E-.04 F1800
G1 X103.507 Y125.946 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X103.724 Y125.603 E.01211
G3 X104.949 Y124.498 I3.467 J2.614 E.04944
G3 X103.009 Y121.733 I2.092 J-3.532 E.1037
G2 X100.74 Y124.002 I4.026 J6.293 E.09633
G3 X103.475 Y125.896 I-.722 J3.963 E.10212
G1 X103.507 Y125.273 F9000
G1 F6364.866
G3 X104.277 Y124.497 I4.21 J3.407 E.03262
G3 X103.154 Y123.21 I2.891 J-3.654 E.05116
G1 X102.862 Y122.596 E.02025
G1 X102.779 Y122.351 E.00771
G2 X101.357 Y123.772 I4.302 J5.726 E.06005
G1 X102.039 Y124.051 E.02196
G1 X102.618 Y124.407 E.02025
G1 X103.136 Y124.848 E.02025
G1 X103.467 Y125.228 E.01502
G1 X103.742 Y124.503 F9000
; LINE_WIDTH: 0.3762
G1 F7201.152
G1 X103.266 Y124.013 E.01798
; LINE_WIDTH: 0.414534
G1 F6458.326
G1 X103.107 Y123.824 E.00725
; LINE_WIDTH: 0.46158
G1 F5732.576
G1 X102.949 Y123.635 E.00816
; LINE_WIDTH: 0.508627
G1 F5153.458
G1 X102.791 Y123.446 E.00908
; LINE_WIDTH: 0.549659
G1 F4736.171
G1 X102.581 Y123.085 E.01669
G2 X102.086 Y123.584 I5.602 J6.056 E.02813
G1 X102.452 Y123.784 E.01671
; LINE_WIDTH: 0.508627
G1 F5153.458
G1 X102.642 Y123.942 E.00908
; LINE_WIDTH: 0.46158
G1 F5732.576
G1 X102.831 Y124.101 E.00816
; LINE_WIDTH: 0.414534
G1 F6458.326
G1 X103.02 Y124.259 E.00725
; LINE_WIDTH: 0.369523
G1 F7348.39
G3 X103.507 Y124.732 I-3.718 J4.311 E.01752
G1 X103.699 Y124.545 E.00691
; WIPE_START
G1 X103.507 Y124.732 E-.21508
G1 X103.02 Y124.259 E-.54492
; WIPE_END
G1 E-.04 F1800
G1 X105.847 Y124.501 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G3 X103.323 Y121.184 I1.159 J-3.501 E.13194
G1 X103.304 Y121.119 E.00202
G2 X100.12 Y124.313 I3.76 J6.932 E.13623
G3 X103.507 Y126.837 I-.113 J3.685 E.13396
G3 X105.79 Y124.519 I3.494 J1.158 E.10039
; WIPE_START
G1 X105.283 Y124.739 E-.21009
G1 X104.797 Y125.045 E-.21814
G1 X104.369 Y125.421 E-.21641
G1 X104.174 Y125.653 E-.11536
; WIPE_END
G1 E-.04 F1800
G1 X109.184 Y125.031 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
G1 F6364.866
G3 X110.503 Y126.846 I-2.179 J2.97 E.06789
G3 X113.893 Y124.313 I3.531 J1.192 E.13403
G2 X112.406 Y122.352 I-6.94 J3.716 E.07359
G2 X110.694 Y121.115 I-5.56 J5.892 E.06312
G3 X110.268 Y122.724 I-4.122 J-.23 E.04993
G3 X108.161 Y124.503 I-3.361 J-1.843 E.08402
G3 X109.133 Y125 I-1.081 J3.317 E.03264
G1 X109.732 Y124.501 F9000
G1 F6364.866
G3 X110.497 Y125.253 I-2.948 J3.762 E.032
G3 X112.657 Y123.772 I3.72 J3.11 E.07899
G2 X111.238 Y122.355 I-5.459 J4.048 E.05992
G1 X110.956 Y123.033 E.02186
M73 P49 R10
G1 X110.599 Y123.611 E.02025
G1 X110.159 Y124.129 E.02025
G1 X109.778 Y124.462 E.01506
G1 X110.503 Y124.736 F9000
; LINE_WIDTH: 0.376105
G1 F7203.205
G1 X110.993 Y124.259 E.018
; LINE_WIDTH: 0.414539
G1 F6458.239
G1 X111.183 Y124.101 E.00725
; LINE_WIDTH: 0.461595
G1 F5732.37
G1 X111.372 Y123.942 E.00816
; LINE_WIDTH: 0.508652
G1 F5153.182
G1 X111.561 Y123.784 E.00908
; LINE_WIDTH: 0.549498
G1 F4737.677
G1 X111.927 Y123.584 E.01669
G2 X111.422 Y123.08 I-3.764 J3.265 E.02858
G1 X111.223 Y123.445 E.01667
; LINE_WIDTH: 0.508652
G1 F5153.182
G1 X111.064 Y123.635 E.00908
; LINE_WIDTH: 0.461595
G1 F5732.37
G1 X110.906 Y123.824 E.00816
; LINE_WIDTH: 0.414539
G1 F6458.239
G1 X110.748 Y124.013 E.00725
; LINE_WIDTH: 0.369631
G1 F7345.94
G2 X110.287 Y124.511 I4.859 J4.957 E.01751
G1 X110.462 Y124.693 E.0065
; WIPE_START
G1 X110.287 Y124.511 E-.20578
G1 X110.748 Y124.013 E-.55422
; WIPE_END
G1 E-.04 F1800
G1 X110.372 Y125.731 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X110.51 Y125.94 E.00746
G3 X112.531 Y124.214 I3.499 J2.051 E.08063
G3 X113.272 Y123.998 I2.025 J5.558 E.02301
G2 X111.005 Y121.733 I-6.307 J4.044 E.0962
G1 X110.871 Y122.254 E.01604
G1 X110.612 Y122.878 E.02012
G3 X109.404 Y124.283 I-3.991 J-2.21 E.05556
G1 X109.063 Y124.499 E.01203
G1 X109.657 Y124.918 E.02166
G3 X110.335 Y125.684 I-2.713 J3.085 E.03055
; WIPE_START
G1 X110.014 Y125.272 E-.19835
G1 X109.657 Y124.918 E-.19115
G1 X109.063 Y124.499 E-.27636
G1 X109.272 Y124.366 E-.09413
; WIPE_END
G1 E-.04 F1800
G1 X115.786 Y126.494 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.097072
G1 F9000
G1 X115.81 Y126.516 E.00014
; LINE_WIDTH: 0.122819
G1 X115.922 Y126.633 E.00102
; LINE_WIDTH: 0.172349
G1 X116.035 Y126.749 E.00166
; LINE_WIDTH: 0.188873
G1 X116.047 Y126.781 E.00039
; LINE_WIDTH: 0.158068
G1 X116.088 Y126.916 E.00129
; LINE_WIDTH: 0.116757
G1 X116.125 Y127.041 E.00076
; WIPE_START
G1 X116.088 Y126.916 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.125 Y128.958 Z1.2 F9000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.116753
G1 F9000
G1 X116.088 Y129.084 E.00076
; LINE_WIDTH: 0.158084
G1 X116.047 Y129.219 E.00129
; LINE_WIDTH: 0.188889
G1 X116.035 Y129.251 E.00039
; LINE_WIDTH: 0.172367
G1 X115.922 Y129.367 E.00166
; LINE_WIDTH: 0.122857
G1 X115.81 Y129.484 E.00102
; LINE_WIDTH: 0.0971031
G1 X115.786 Y129.506 E.00014
; CHANGE_LAYER
; Z_HEIGHT: 1
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F9000
G1 X115.81 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 118
M625
; layer num/total_layer_count: 5/23
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
M106 S132.6
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G17
G3 Z1.2 I.213 J1.198 P1  F9000
G1 X123.092 Y128.188 Z1.2
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G2 X123.092 Y127.812 I-1.218 J-.188 E.01213
G1 X123.276 Y127.753 E.00621
G1 X123.424 Y128 E.00926
G1 X123.276 Y128.247 E.00926
G1 X123.149 Y128.206 E.00428
; WIPE_START
G1 X123.106 Y128 E-.12303
G1 X123.092 Y127.812 E-.11006
G1 X123.276 Y127.753 E-.11279
G1 X123.424 Y128 E-.16818
G1 X123.276 Y128.247 E-.16819
G1 X123.149 Y128.206 E-.07775
; WIPE_END
G1 E-.04 F1800
G1 X128.17 Y123.117 Z1.4 F9000
G1 Z1
G1 E.8 F1800
G1 F5895.652
G1 X127.715 Y123.431 E.01778
G1 X127.28 Y123.205 E.01576
G1 X127.355 Y123.003 E.00693
G1 X127.681 Y123.079 E.01078
G1 X128.11 Y123.112 E.01383
; WIPE_START
G1 X127.715 Y123.431 E-.19497
G1 X127.28 Y123.205 E-.1883
G1 X127.355 Y123.003 E-.08279
G1 X127.681 Y123.079 E-.12877
G1 X128.11 Y123.112 E-.16516
; WIPE_END
G1 E-.04 F1800
G1 X133.672 Y128.339 Z1.4 F9000
G1 X136.161 Y130.678 Z1.4
G1 Z1
G1 E.8 F1800
G1 F5895.652
G1 X136.045 Y130.987 E.01061
G3 X130.677 Y136.167 I-8.107 J-3.03 E.248
G2 X130.256 Y133.152 I-2.648 J-1.167 E.10306
G1 X130.356 Y133.002 E.0058
G1 X131.234 Y133.092 E.02837
G1 X131.526 Y132.26 E.02837
G1 X132.399 Y132.129 E.02837
G1 X132.475 Y131.25 E.02837
G1 X133.287 Y130.905 E.02838
G1 X133.185 Y130.292 E.01998
G1 X133.607 Y130.566 E.01616
G2 X136.106 Y130.701 I1.392 J-2.558 E.08317
; WIPE_START
G1 X136.045 Y130.987 E-.11088
G1 X135.735 Y131.724 E-.30391
G1 X135.499 Y132.18 E-.19532
G1 X135.296 Y132.519 E-.14989
; WIPE_END
G1 E-.04 F1800
G1 X136.822 Y129.762 Z1.4 F9000
G1 Z1
G1 E.8 F1800
G1 F5895.652
G3 X130.016 Y136.762 I-8.843 J-1.79 E.33173
G1 X129.919 Y136.617 E.0056
G2 X129.742 Y133.188 I-1.915 J-1.62 E.12159
G1 X130.154 Y132.572 E.02381
G1 X130.956 Y132.655 E.02593
G1 X131.223 Y131.894 E.02593
G1 X132.021 Y131.774 E.02593
G1 X132.09 Y130.97 E.02593
G1 X132.833 Y130.656 E.02594
G1 X132.701 Y129.86 E.02593
G1 X133.062 Y129.584 E.01462
G1 X133.192 Y129.742 E.00657
G2 X136.368 Y130.109 I1.81 J-1.742 E.11141
G1 X136.775 Y129.798 E.01645
; WIPE_START
G1 X136.669 Y130.392 E-.229
G1 X136.51 Y130.906 E-.20437
G1 X136.321 Y131.41 E-.20453
G1 X136.19 Y131.703 E-.1221
; WIPE_END
G1 E-.04 F1800
G1 X132.975 Y124.781 Z1.4 F9000
G1 X130.677 Y119.833 Z1.4
G1 Z1
G1 E.8 F1800
G1 F5895.652
G1 X131.376 Y120.108 E.02413
G3 X136.161 Y125.322 I-3.405 J7.927 E.23451
G2 X134.68 Y125.106 I-1.125 J2.528 E.04874
G2 X133.185 Y125.708 I.308 J2.923 E.05247
G1 X133.287 Y125.095 E.01998
G1 X132.475 Y124.75 E.02838
G1 X132.399 Y123.872 E.02837
G1 X131.526 Y123.74 E.02837
G1 X131.234 Y122.908 E.02838
G1 X130.356 Y122.998 E.02837
G1 X130.256 Y122.848 E.0058
G1 X130.325 Y122.77 E.00333
G2 X130.7 Y119.889 I-2.378 J-1.775 E.09765
G1 X129.919 Y119.383 F9000
G1 F5895.652
G1 X130.016 Y119.238 E.0056
G1 X130.523 Y119.37 E.01687
G3 X136.822 Y126.238 I-2.548 J8.66 E.31487
G1 X136.368 Y125.891 E.01838
G1 X136.209 Y125.805 E.00581
G2 X133.062 Y126.416 I-1.208 J2.188 E.11189
G1 X132.701 Y126.14 E.01462
G1 X132.833 Y125.344 E.02593
G1 X132.09 Y125.03 E.02594
G1 X132.021 Y124.226 E.02593
G1 X131.223 Y124.106 E.02593
G1 X130.956 Y123.345 E.02594
G1 X130.154 Y123.428 E.02593
G1 X129.742 Y122.812 E.02381
G2 X129.957 Y119.43 I-1.738 J-1.809 E.11966
G1 X129.59 Y119.623 F9000
G1 F5895.652
G1 X129.764 Y119.859 E.00941
G3 X128.374 Y123.067 I-1.767 J1.14 E.13276
G1 X128.86 Y123.503 E.02099
G1 X129.546 Y123.25 E.0235
G1 X129.952 Y123.858 E.02349
G1 X130.678 Y123.783 E.0235
G1 X130.921 Y124.472 E.0235
G1 X131.643 Y124.581 E.02349
G1 X131.706 Y125.309 E.02349
G1 X132.379 Y125.594 E.0235
G1 X132.259 Y126.315 E.02349
G1 X132.84 Y126.758 E.02349
G1 X132.544 Y127.426 E.0235
G1 X132.882 Y127.855 E.01754
G3 X133.117 Y127.067 I2.667 J.366 E.02655
G3 X133.052 Y128.773 I1.885 J.926 E.36777
G1 X132.996 Y128.635 E.00481
G1 X132.882 Y128.145 E.01616
G1 X132.544 Y128.574 E.01754
G1 X132.84 Y129.242 E.0235
G1 X132.259 Y129.685 E.02349
G1 X132.379 Y130.406 E.02349
G1 X131.706 Y130.691 E.0235
G1 X131.643 Y131.419 E.02349
G1 X130.92 Y131.528 E.02349
G1 X130.678 Y132.217 E.0235
G1 X129.952 Y132.142 E.02349
G1 X129.546 Y132.75 E.0235
G1 X128.86 Y132.497 E.0235
G1 X128.374 Y132.933 E.02099
G3 X126.676 Y133.374 I-.368 J2.068 E.36616
G1 X126.792 Y133.279 E.00481
G1 X127.187 Y133.044 E.01477
G1 X126.588 Y132.354 E.0294
G1 X125.876 Y132.519 E.0235
G1 X125.549 Y131.865 E.02349
G1 X124.819 Y131.848 E.02349
G1 X124.665 Y131.134 E.02349
G1 X123.962 Y130.936 E.02349
G1 X123.99 Y130.205 E.0235
G1 X123.359 Y129.838 E.02349
G1 X123.568 Y129.139 E.02349
G1 X123.022 Y128.601 E.02465
G1 X122.888 Y128.934 E.01154
G3 X123.022 Y127.399 I-1.882 J-.937 E.37408
G1 X123.568 Y126.861 E.02465
G1 X123.359 Y126.161 E.02349
G1 X123.99 Y125.794 E.02349
G1 X123.962 Y125.064 E.0235
G1 X124.665 Y124.866 E.02349
G1 X124.819 Y124.152 E.02349
G1 X125.549 Y124.135 E.02349
G1 X125.876 Y123.481 E.02349
G1 X126.587 Y123.646 E.02349
G1 X127.187 Y122.956 E.0294
G1 X126.792 Y122.721 E.01477
G3 X125.917 Y121.229 I1.248 J-1.734 E.05725
G3 X127.841 Y118.902 I2.095 J-.226 E.10823
G3 X129.549 Y119.58 I.156 J2.097 E.06114
; WIPE_START
G1 X129.764 Y119.859 E-.13386
G1 X129.922 Y120.139 E-.12226
G1 X130.031 Y120.443 E-.12238
G1 X130.092 Y120.759 E-.12241
G1 X130.105 Y121.081 E-.12237
G1 X130.068 Y121.401 E-.1224
G1 X130.058 Y121.437 E-.01433
; WIPE_END
G1 E-.04 F1800
G1 X126.479 Y127.225 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
G1 X126.61 Y127.021 E.00723
G3 X127.715 Y126.316 I1.401 J.978 E.04006
G3 X128.198 Y126.301 I.292 J1.556 E.01445
G3 X126.461 Y127.281 I-.187 J1.698 E.25625
; WIPE_START
G1 X126.61 Y127.021 E-.11397
G1 X126.77 Y126.814 E-.09931
G1 X126.965 Y126.64 E-.09954
G1 X127.185 Y126.497 E-.09953
G1 X127.424 Y126.39 E-.09947
G1 X127.715 Y126.316 E-.11421
G1 X127.937 Y126.291 E-.08471
G1 X128.066 Y126.296 E-.04926
; WIPE_END
G1 E-.04 F1800
G1 X122.638 Y128.494 Z1.4 F9000
G1 Z1
G1 E.8 F1800
M73 P50 R10
G1 F6364.704
G1 X122.637 Y128.517 E.00071
G3 X120.948 Y126.295 I-1.628 J-.516 E.22223
G3 X122.039 Y126.64 I.049 J1.745 E.03472
G3 X122.697 Y128.262 I-1.03 J1.362 E.05475
G1 X122.653 Y128.435 E.00534
; WIPE_START
G1 X122.637 Y128.517 E-.03169
G1 X122.535 Y128.759 E-.09968
G1 X122.401 Y128.984 E-.09951
G1 X122.235 Y129.186 E-.09952
G1 X122.039 Y129.36 E-.0995
G1 X121.819 Y129.503 E-.09955
G1 X121.58 Y129.61 E-.09949
G1 X121.328 Y129.679 E-.09952
G1 X121.246 Y129.689 E-.03152
; WIPE_END
G1 E-.04 F1800
G1 X126.076 Y123.78 Z1.4 F9000
G1 X129.279 Y119.862 Z1.4
G1 Z1
G1 E.8 F1800
G1 F6364.704
G3 X127.871 Y119.294 I-1.276 J1.135 E.27278
G3 X128.528 Y119.377 I.103 J1.825 E.01982
G1 X128.642 Y119.413 E.00356
G3 X129.238 Y119.818 I-.639 J1.584 E.02163
; WIPE_START
G1 X129.438 Y120.07 E-.12222
G1 X129.563 Y120.3 E-.09953
G1 X129.652 Y120.547 E-.09951
G1 X129.702 Y120.804 E-.09952
G1 X129.712 Y121.065 E-.09949
G1 X129.682 Y121.326 E-.09955
G1 X129.612 Y121.578 E-.09951
G1 X129.568 Y121.676 E-.04067
; WIPE_END
G1 E-.04 F1800
G1 X135.6 Y126.353 Z1.4 F9000
G1 X136.323 Y126.914 Z1.4
G1 Z1
G1 E.8 F1800
G1 F6364.704
G1 X136.469 Y127.128 E.00771
G3 X134.818 Y126.304 I-1.467 J.874 E.26162
G3 X135.827 Y126.507 I.184 J1.697 E.03114
G3 X136.283 Y126.873 I-.825 J1.495 E.01749
; WIPE_START
G1 X136.469 Y127.128 E-.12007
G1 X136.589 Y127.361 E-.09938
G1 X136.668 Y127.61 E-.09952
G1 X136.708 Y127.869 E-.09954
G1 X136.708 Y128.131 E-.0995
G1 X136.668 Y128.39 E-.09954
G1 X136.589 Y128.639 E-.09952
G1 X136.539 Y128.741 E-.04293
; WIPE_END
G1 E-.04 F1800
G1 X131.124 Y134.119 Z1.4 F9000
G1 X128.639 Y136.588 Z1.4
G1 Z1
G1 E.8 F1800
G1 F6364.704
G1 X128.392 Y136.667 E.00771
G3 X127.883 Y133.299 I-.383 J-1.665 E.16758
G3 X128.986 Y133.601 I.116 J1.742 E.03471
G3 X128.694 Y136.567 I-.977 J1.401 E.10787
; WIPE_START
G1 X128.392 Y136.667 E-.12083
G1 X128.133 Y136.706 E-.09957
G1 X127.871 Y136.706 E-.0995
G1 X127.612 Y136.666 E-.09954
G1 X127.363 Y136.587 E-.09952
G1 X127.128 Y136.47 E-.0995
G1 X126.914 Y136.32 E-.09952
G1 X126.834 Y136.243 E-.04202
; WIPE_END
G1 E-.04 F1800
G1 X126.133 Y128.643 Z1.4 F9000
G1 X125.323 Y119.847 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X125.186 Y120.226 E.01296
G2 X125.477 Y122.458 I2.869 J.761 E.07422
G1 X125.04 Y123.332 E.03144
G1 X124.158 Y123.353 E.02837
G1 X123.972 Y124.215 E.02837
G1 X123.123 Y124.455 E.02837
G1 X123.158 Y125.337 E.02837
G1 X122.677 Y125.616 E.01786
G2 X119.852 Y125.319 I-1.682 J2.42 E.09532
G3 X125.266 Y119.866 I8.164 J2.69 E.25617
; WIPE_START
G1 X125.186 Y120.226 E-.14023
G1 X125.101 Y120.665 E-.16994
G1 X125.084 Y121.112 E-.16983
G1 X125.135 Y121.556 E-.16993
G1 X125.212 Y121.835 E-.11008
; WIPE_END
G1 E-.04 F1800
G1 X126.236 Y119.186 Z1.4 F9000
G1 Z1
G1 E.8 F1800
G1 F5895.652
G1 X125.894 Y119.634 E.01815
G1 X125.807 Y119.793 E.00581
G2 X126.512 Y123.017 I2.202 J1.208 E.11578
G1 X126.426 Y123.191 E.00622
G1 X125.655 Y123.012 E.02544
G1 X125.295 Y123.733 E.02593
G1 X124.488 Y123.752 E.02593
G1 X124.319 Y124.541 E.02593
G1 X123.542 Y124.76 E.02593
G1 X123.574 Y125.566 E.02594
G1 X122.877 Y125.971 E.02593
G1 X122.92 Y126.116 E.00489
G1 X122.765 Y126.215 E.00594
G2 X119.637 Y125.891 I-1.765 J1.78 E.1093
G1 X119.191 Y126.231 E.01802
G3 X126.177 Y119.198 I8.805 J1.759 E.3377
; WIPE_START
G1 X125.894 Y119.634 E-.19786
G1 X125.807 Y119.793 E-.06871
G1 X125.71 Y119.972 E-.07744
G1 X125.58 Y120.334 E-.14616
G1 X125.507 Y120.712 E-.14616
G1 X125.494 Y121.037 E-.12369
; WIPE_END
G1 E-.04 F1800
G1 X123.292 Y128.345 Z1.4 F9000
G1 X122.677 Y130.384 Z1.4
G1 Z1
G1 E.8 F1800
G1 F5895.652
G1 X123.158 Y130.663 E.01786
G1 X123.123 Y131.545 E.02837
G1 X123.972 Y131.784 E.02837
G1 X124.158 Y132.647 E.02837
G1 X125.04 Y132.668 E.02837
G1 X125.477 Y133.542 E.03144
G1 X125.437 Y133.605 E.00239
G2 X125.323 Y136.153 I2.642 J1.395 E.08475
G3 X119.852 Y130.681 I2.669 J-8.139 E.25817
G2 X122.628 Y130.419 I1.151 J-2.644 E.09359
G1 X122.764 Y129.785 F9000
G1 F5895.652
G1 X122.92 Y129.884 E.00594
G1 X122.877 Y130.029 E.00489
G1 X123.574 Y130.434 E.02593
G1 X123.542 Y131.24 E.02593
G1 X124.319 Y131.459 E.02593
G1 X124.488 Y132.248 E.02593
G1 X125.295 Y132.267 E.02593
G1 X125.655 Y132.988 E.02593
G1 X126.426 Y132.809 E.02544
G1 X126.511 Y132.983 E.00622
G1 X126.417 Y133.06 E.00391
G2 X125.894 Y136.365 I1.577 J1.944 E.11786
G1 X126.236 Y136.814 E.01815
G3 X119.191 Y129.769 I1.775 J-8.82 E.33953
G1 X119.637 Y130.109 E.01802
G2 X122.721 Y129.826 I1.36 J-2.132 E.10719
; WIPE_START
G1 X122.92 Y129.884 E-.07879
G1 X122.877 Y130.029 E-.05773
G1 X123.574 Y130.434 E-.30645
G1 X123.542 Y131.24 E-.30647
G1 X123.569 Y131.248 E-.01056
; WIPE_END
G1 E-.04 F1800
G1 X125.734 Y123.929 Z1.4 F9000
G1 X127.3 Y118.633 Z1.4
G1 Z1
G1 E.8 F1800
G1 F5895.652
M73 P50 R9
G3 X128.113 Y118.607 I.712 J9.459 E.02615
G3 X124.052 Y119.473 I-.12 J9.395 E1.76369
G3 X127.241 Y118.638 I3.961 J8.62 E.10654
; WIPE_START
G1 X128.113 Y118.607 E-.33166
G1 X128.984 Y118.654 E-.33171
G1 X129.236 Y118.688 E-.09663
; WIPE_END
G1 E-.04 F1800
G1 X128.664 Y126.299 Z1.4 F9000
G1 X128.169 Y132.883 Z1.4
G1 Z1
G1 E.8 F1800
G1 F5895.652
G2 X127.355 Y132.997 I-.039 J2.693 E.02656
G1 X127.28 Y132.795 E.00693
G1 X127.715 Y132.569 E.01576
G1 X128.12 Y132.849 E.01584
; WIPE_START
G1 X127.681 Y132.921 E-.17085
G1 X127.355 Y132.997 E-.12881
G1 X127.28 Y132.795 E-.08281
G1 X127.715 Y132.569 E-.1883
G1 X128.12 Y132.849 E-.18924
; WIPE_END
G1 E-.04 F1800
G1 X127.677 Y125.23 Z1.4 F9000
G1 X127.271 Y118.237 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
G1 X128.119 Y118.215 E.02525
G3 X123.363 Y119.379 I-.125 J9.787 E1.68437
G3 X127.214 Y118.245 I4.622 J8.586 E.12044
; WIPE_START
G1 X128.119 Y118.215 E-.34393
G1 X128.441 Y118.22 E-.12264
G1 X129.026 Y118.264 E-.22261
G1 X129.21 Y118.289 E-.07082
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.4 I1.217 J0 P1  F9000
; stop printing object, unique label id: 82
M625
; object ids of layer 5 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.4
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z1.4 F4000
            G39.3 S1
            G0 Z1.4 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END


; object ids of this layer5 end: 82,118
M625
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X129.091 Y118.874 F9000
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.353135
G1 F7736.574
G1 X129.793 Y119.206 E.01904
G1 X129.818 Y119.168 F9000
; LINE_WIDTH: 0.177553
G1 X129.211 Y118.957 E.00683
; LINE_WIDTH: 0.155808
G1 X129.082 Y118.917 E.0012
; LINE_WIDTH: 0.116544
G1 X128.953 Y118.878 E.00078
; WIPE_START
G1 X129.082 Y118.917 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.042 Y118.883 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.117481
G1 F9000
G1 X126.917 Y118.919 E.00077
; LINE_WIDTH: 0.161195
G1 X126.778 Y118.96 E.00136
; LINE_WIDTH: 0.192058
G1 X126.754 Y118.97 E.00031
; LINE_WIDTH: 0.172911
G1 X126.636 Y119.083 E.00168
; LINE_WIDTH: 0.123
G1 X126.518 Y119.197 E.00103
; LINE_WIDTH: 0.0970693
G1 X126.496 Y119.221 E.00014
; WIPE_START
G1 X126.518 Y119.197 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.823 Y122.976 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.120954
G1 F9000
G1 X126.676 Y123.198 E.00164
; WIPE_START
G1 X126.823 Y122.976 E-.76
; WIPE_END
M73 P51 R9
G1 E-.04 F1800
G1 X128.846 Y123.217 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.196018
G1 F9000
G1 X129.224 Y123.056 E.00498
; LINE_WIDTH: 0.239493
G1 X129.384 Y122.979 E.00276
; LINE_WIDTH: 0.267911
G2 X129.547 Y122.886 I-1.145 J-2.198 E.00333
; WIPE_START
G1 X129.384 Y122.979 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X130.189 Y124.057 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S500
G1 X130.728 Y124.596 E.02269
G1 X130.814 Y124.681
G1 X131.487 Y125.354 E.02834
; WIPE_START
M204 S750
G1 X130.814 Y124.681 E-.39411
G1 X130.728 Y124.596 E-.05032
G1 X130.189 Y124.057 E-.31557
; WIPE_END
G1 E-.04 F1800
G1 X132.523 Y126.924 Z1.4 F9000
G1 Z1
G1 E.8 F1800
G1 F6364.704
M204 S500
G1 X129.21 Y123.611 E.13956
G1 X128.821 Y123.755
G1 X132.36 Y127.294 E.14908
G1 X132.634 Y128.101
G1 X128.022 Y123.489 E.19427
G1 X127.644 Y123.645
G1 X132.399 Y128.399 E.20027
G1 X132.508 Y129.042
G1 X126.989 Y123.523 E.23248
G1 X126.741 Y123.808
G1 X132.304 Y129.371 E.23433
G1 X132.023 Y129.624
G1 X129.828 Y127.428 E.09248
G1 X129.915 Y128.049
G1 X132.13 Y130.263 E.09328
G1 X131.76 Y130.427
G1 X129.846 Y128.513 E.0806
G1 X129.694 Y128.894
G1 X131.483 Y130.684 E.07537
G1 X131.441 Y131.174
G1 X129.484 Y129.218 E.08241
G1 X129.215 Y129.481
G1 X131.021 Y131.287 E.07608
G1 X130.696 Y131.496
G1 X128.893 Y129.693 E.07594
G1 X128.515 Y129.848
G1 X130.557 Y131.89 E.08602
G1 X130.064 Y131.93
G1 X128.046 Y129.913 E.08499
G1 X127.426 Y129.825
G1 X129.707 Y132.107 E.09612
; WIPE_START
M204 S750
G1 X128.293 Y130.693 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128.571 Y126.172 Z1.4 F9000
G1 Z1
G1 E.8 F1800
G1 F6364.704
M204 S500
G1 X126.179 Y123.78 E.10076
G1 X125.866 Y123.999
G1 X127.95 Y126.084 E.08781
G1 X127.49 Y126.157
G1 X125.687 Y124.354 E.07595
G1 X125.166 Y124.366
G1 X127.105 Y126.306 E.0817
G1 X126.787 Y126.521
G1 X124.935 Y124.668 E.07802
G1 X124.794 Y125.061
G1 X126.522 Y126.788 E.07278
G1 X126.307 Y127.107
G1 X124.378 Y125.178 E.08127
G1 X124.203 Y125.536
G1 X126.157 Y127.49 E.08231
G1 X126.087 Y127.954
G1 X124.114 Y125.98 E.08313
G1 X123.776 Y126.176
G1 X126.171 Y128.571 E.10088
; WIPE_START
M204 S750
G1 X124.757 Y127.157 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X123.745 Y126.678 Z1.4 F9000
G1 Z1
G1 E.8 F1800
G1 F6364.704
M204 S500
G1 X129.494 Y132.427 E.24215
G1 X128.793 Y132.259
G1 X123.638 Y127.104 E.21713
G1 X123.37 Y127.369
G1 X128.511 Y132.511 E.21659
G1 X127.88 Y132.413
G1 X123.602 Y128.135 E.18021
G1 X123.402 Y128.468
G1 X127.41 Y132.476 E.16885
G1 X126.538 Y132.137
G1 X123.74 Y129.339 E.11786
G1 X124.208 Y130.34
G1 X124.812 Y130.944 E.02544
G1 X124.863 Y130.995
G1 X125.509 Y131.642 E.02725
; WIPE_START
M204 S750
G1 X124.863 Y130.995 E-.34762
G1 X124.812 Y130.944 E-.02736
G1 X124.208 Y130.34 E-.32456
G1 X124.14 Y130.196 E-.06046
; WIPE_END
G1 E-.04 F1800
G1 X130.874 Y126.602 Z1.4 F9000
G1 X132.115 Y125.94 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.382138
G1 F7075.111
G1 X131.989 Y125.855 E.00407
; LINE_WIDTH: 0.339229
G1 F8099.671
G1 X131.863 Y125.771 E.00355
; LINE_WIDTH: 0.29632
G1 F9000
G1 X131.737 Y125.686 E.00304
; LINE_WIDTH: 0.253411
G1 X131.611 Y125.601 E.00252
; LINE_WIDTH: 0.205419
G3 X131.454 Y125.487 I.303 J-.585 E.0025
; LINE_WIDTH: 0.166408
G1 X131.483 Y125.358 E.00129
; WIPE_START
G1 X131.454 Y125.487 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.541 Y123.646 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.0996263
G1 F9000
G1 X129.429 Y123.51 E.00079
G1 X128.757 Y123.818
; LINE_WIDTH: 0.221198
G1 X128.232 Y123.321 E.01018
G1 X127.583 Y123.706
; LINE_WIDTH: 0.197174
G1 X127.438 Y123.6 E.00219
; LINE_WIDTH: 0.153571
G1 X127.292 Y123.493 E.00157
; LINE_WIDTH: 0.109968
G1 X127.147 Y123.387 E.00095
; WIPE_START
G1 X127.292 Y123.493 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X125.013 Y124.351 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.138631
G1 F9000
G1 X124.996 Y124.535 E.0014
G1 X125.068 Y124.535 E.00054
; WIPE_START
G1 X124.996 Y124.535 E-.2125
G1 X125.013 Y124.351 E-.5475
; WIPE_END
G1 E-.04 F1800
G1 X123.654 Y127.948 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.0938916
G1 F9000
G3 X123.648 Y128.062 I-.034 J.055 E.00056
; WIPE_START
G1 X123.692 Y128.002 E-.40215
G1 X123.654 Y127.948 E-.35785
; WIPE_END
G1 E-.04 F1800
G1 X126.15 Y132.246 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.297317
G1 F9000
G1 X126.041 Y132.096 E.00373
; LINE_WIDTH: 0.249974
G1 X125.933 Y131.946 E.00303
; LINE_WIDTH: 0.202632
G1 X125.825 Y131.795 E.00234
; LINE_WIDTH: 0.153381
G2 X125.579 Y131.572 I-.347 J.136 E.003
; WIPE_START
G1 X125.716 Y131.645 E-.3463
G1 X125.825 Y131.795 E-.4137
; WIPE_END
G1 E-.04 F1800
G1 X129.937 Y128.337 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.0983383
G1 F9000
G3 X129.855 Y128.48 I-1.918 J-.999 E.00072
; WIPE_START
G1 X129.937 Y128.337 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.891 Y127.365 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.193132
G1 F9000
G1 X129.827 Y127.259 E.00147
; LINE_WIDTH: 0.158658
G1 X129.735 Y127.132 E.00143
; LINE_WIDTH: 0.111661
G1 X129.644 Y127.005 E.00085
G1 X129.007 Y126.368
; LINE_WIDTH: 0.104512
G1 X128.906 Y126.293 E.00061
; LINE_WIDTH: 0.148261
G2 X128.64 Y126.104 I-2.566 J3.328 E.00272
; WIPE_START
G1 X128.906 Y126.293 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.103 Y127.938 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.0941325
G1 F9000
G1 X126.016 Y128.148 E.00092
G1 X126.382 Y129.02
; LINE_WIDTH: 0.123006
G3 X126.101 Y128.641 I4.818 J-3.871 E.00299
; WIPE_START
G1 X126.382 Y129.02 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.36 Y129.892 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.179914
G1 F9000
G1 X127.22 Y129.796 E.00183
; LINE_WIDTH: 0.132711
G1 X127.077 Y129.697 E.00124
; LINE_WIDTH: 0.0984303
G1 X126.983 Y129.621 E.00053
; WIPE_START
G1 X127.077 Y129.697 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.675 Y132.802 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.12105
G1 F9000
G1 X126.823 Y133.024 E.00165
; WIPE_START
G1 X126.675 Y132.802 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128.846 Y132.783 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.195998
G1 F9000
G1 X129.224 Y132.944 E.00498
; LINE_WIDTH: 0.239455
G1 X129.384 Y133.021 E.00275
; LINE_WIDTH: 0.267872
G3 X129.547 Y133.114 I-1.141 J2.19 E.00333
; WIPE_START
G1 X129.384 Y133.021 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.793 Y136.794 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.353115
G1 F7737.078
G1 X129.09 Y137.126 E.01904
G1 X129.082 Y137.083 F9000
; LINE_WIDTH: 0.116556
G1 X128.953 Y137.122 E.00078
G1 X129.082 Y137.083
; LINE_WIDTH: 0.155831
G1 X129.211 Y137.043 E.0012
; LINE_WIDTH: 0.177563
G1 X129.818 Y136.832 E.00683
; WIPE_START
G1 X129.211 Y137.043 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.042 Y137.117 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.11748
G1 F9000
G1 X126.917 Y137.081 E.00077
; LINE_WIDTH: 0.161183
G1 X126.778 Y137.04 E.00136
; LINE_WIDTH: 0.192064
G1 X126.754 Y137.03 E.00031
; LINE_WIDTH: 0.172924
G1 X126.636 Y136.917 E.00168
; LINE_WIDTH: 0.123032
G1 X126.518 Y136.803 E.00103
; LINE_WIDTH: 0.0970927
G1 X126.496 Y136.779 E.00014
; WIPE_START
G1 X126.518 Y136.803 E-.76
; WIPE_END
G1 E-.04 F1800
M73 P52 R9
G1 X121.924 Y132.076 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.65031
G1 F3951.333
G1 X122.191 Y132.45 E.02205
; WIPE_START
G1 X121.924 Y132.076 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X123.639 Y132.098 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.873
G1 X122.862 Y131.879 E.02403
G1 X122.737 Y131.765 E.00504
G1 X122.755 Y130.932 E.02481
G2 X122.638 Y130.857 I-.08 J-.003 E.00497
G1 X122.144 Y131.109 E.01652
G3 X120.493 Y131.267 I-1.122 J-3.018 E.04996
G2 X124.735 Y135.507 I7.526 J-3.286 E.1829
G1 X124.692 Y134.888 E.01851
G3 X125.041 Y133.547 I3.081 J.087 E.04162
G1 X124.795 Y133.054 E.01641
G1 X123.988 Y133.035 E.02403
G1 X123.86 Y132.981 E.00415
G3 X123.651 Y132.156 I3.902 J-1.428 E.02537
G1 X123.318 Y132.399 F9000
; LINE_WIDTH: 0.41999
G1 F6364.871
G1 X122.76 Y132.242 E.01727
G1 X122.52 Y132.104 E.00824
G1 X122.385 Y131.9 E.00729
G1 X122.315 Y131.445 E.01371
G1 X121.793 Y131.6 E.01621
G1 X121.116 Y131.687 E.02035
G2 X124.248 Y134.851 I6.932 J-3.73 E.13444
G1 X124.314 Y134.872 E.00208
G3 X124.622 Y133.551 I3.489 J.115 E.04065
G1 X124.559 Y133.426 E.00418
G1 X123.979 Y133.412 E.01727
G1 X123.69 Y133.324 E.00901
G1 X123.522 Y133.16 E.007
G3 X123.33 Y132.458 I3.491 J-1.329 E.02172
G1 X122.966 Y132.729 F9000
; LINE_WIDTH: 0.512344
G1 F5112.651
G1 X122.781 Y132.672 E.00719
; LINE_WIDTH: 0.550932
G1 F4724.305
G1 X122.596 Y132.614 E.00778
; LINE_WIDTH: 0.589519
G1 F4390.79
G1 X122.411 Y132.557 E.00837
; LINE_WIDTH: 0.628107
G1 F4101.259
G1 X122.226 Y132.499 E.00896
G1 X122.288 Y132.604 E.00566
; LINE_WIDTH: 0.589519
G1 F4390.79
G1 X122.351 Y132.709 E.00528
; LINE_WIDTH: 0.550932
G1 F4724.305
G1 X122.414 Y132.814 E.00491
; LINE_WIDTH: 0.512344
G1 F5112.651
G1 X122.477 Y132.919 E.00454
; LINE_WIDTH: 0.472745
G1 F5583.668
G1 X122.613 Y133.081 E.00719
; LINE_WIDTH: 0.432135
G1 F6166.258
G1 X122.75 Y133.243 E.00651
; LINE_WIDTH: 0.391525
G1 F6884.584
G1 X122.887 Y133.404 E.00583
; LINE_WIDTH: 0.395662
G1 F6803.84
G1 X122.962 Y133.441 E.00232
; LINE_WIDTH: 0.444546
G1 F5975.709
G1 X123.036 Y133.477 E.00264
; LINE_WIDTH: 0.49343
G1 F5327.296
G1 X123.111 Y133.513 E.00296
; LINE_WIDTH: 0.542314
G1 F4805.825
G1 X123.186 Y133.55 E.00328
; LINE_WIDTH: 0.591198
G1 F4377.342
G1 X123.261 Y133.586 E.0036
; LINE_WIDTH: 0.595725
G1 F4341.495
G1 X123.233 Y133.521 E.0031
; LINE_WIDTH: 0.555895
G1 F4678.591
G1 X123.205 Y133.456 E.00288
; LINE_WIDTH: 0.516065
G1 F5072.441
G1 X123.177 Y133.39 E.00266
; LINE_WIDTH: 0.475329
G1 F5550.309
G1 X123.169 Y133.333 E.00199
; LINE_WIDTH: 0.433685
G1 F6141.799
G1 X123.161 Y133.275 E.0018
; LINE_WIDTH: 0.392042
G1 F6874.394
G1 X123.153 Y133.217 E.00161
; LINE_WIDTH: 0.391525
G1 F6884.584
G1 X123.1 Y133.099 E.00357
; LINE_WIDTH: 0.432135
G1 F6166.258
G1 X123.047 Y132.98 E.00399
; LINE_WIDTH: 0.480218
G1 F5488.247
G3 X122.978 Y132.788 I.423 J-.259 E.0071
G1 X123.261 Y133.586 F9000
; LINE_WIDTH: 0.62952
G1 F4091.374
G1 X123.468 Y133.75 E.01224
G1 X124.128 Y133.791 F9000
; LINE_WIDTH: 0.438569
G1 F6065.983
G1 X124.006 Y133.79 E.00383
; LINE_WIDTH: 0.484087
G1 F5440.117
G1 X123.883 Y133.789 E.00427
; LINE_WIDTH: 0.529605
G1 F4931.321
G1 X123.761 Y133.788 E.00471
; LINE_WIDTH: 0.575123
G1 F4509.557
G1 X123.638 Y133.788 E.00515
; LINE_WIDTH: 0.620641
G1 F4154.254
G1 X123.516 Y133.787 E.00559
G1 X123.569 Y133.854 E.00393
; LINE_WIDTH: 0.575123
G1 F4509.557
G1 X123.623 Y133.922 E.00362
; LINE_WIDTH: 0.529605
G1 F4931.321
G1 X123.676 Y133.989 E.00331
; LINE_WIDTH: 0.484087
G1 F5440.117
G1 X123.73 Y134.057 E.003
; LINE_WIDTH: 0.418298
G1 F6393.561
G1 X123.783 Y134.124 E.00255
G1 X124.006 Y134.271 E.0079
G1 X124.113 Y133.849 E.01292
; WIPE_START
G1 X124.006 Y134.271 E-.42011
G1 X123.783 Y134.124 E-.25682
G1 X123.73 Y134.057 E-.08307
; WIPE_END
G1 E-.04 F1800
G1 X119.223 Y129.506 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970951
G1 F9000
G1 X119.199 Y129.484 E.00014
; LINE_WIDTH: 0.122751
G1 X119.087 Y129.368 E.00102
; LINE_WIDTH: 0.175243
G1 X118.975 Y129.251 E.00169
G1 X118.958 Y129.209 E.00047
; LINE_WIDTH: 0.157749
G1 X118.922 Y129.092 E.00111
; LINE_WIDTH: 0.117842
G1 X118.883 Y128.956 E.00083
; WIPE_START
G1 X118.922 Y129.092 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.883 Y127.044 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.117859
G1 F9000
G1 X118.922 Y126.908 E.00083
; LINE_WIDTH: 0.157746
G1 X118.958 Y126.791 E.00111
; LINE_WIDTH: 0.175229
G1 X118.975 Y126.749 E.00047
G1 X119.087 Y126.632 E.00169
; LINE_WIDTH: 0.122752
G1 X119.199 Y126.516 E.00102
; LINE_WIDTH: 0.0970896
G1 X119.223 Y126.494 E.00014
; WIPE_START
G1 X119.199 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.924 Y123.924 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.64819
G1 F3965.173
G1 X122.173 Y123.568 E.02076
; WIPE_START
G1 X121.924 Y123.924 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X123.639 Y123.902 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X123.808 Y123.114 E.02403
G1 X123.892 Y122.994 E.00434
G3 X124.795 Y122.946 I.989 J10.014 E.02694
G1 X125.041 Y122.453 E.0164
G1 X124.935 Y122.231 E.00734
G1 X124.753 Y121.645 E.01827
G3 X124.735 Y120.493 I3.709 J-.634 E.03446
G2 X121.221 Y123.408 I3.258 J7.505 E.13784
G2 X120.507 Y124.731 I8.078 J5.214 E.04483
G1 X121.035 Y124.692 E.01578
G1 X121.619 Y124.745 E.01746
G1 X122.108 Y124.878 E.01511
G1 X122.638 Y125.143 E.01764
G2 X122.755 Y125.068 I.036 J-.072 E.00497
G1 X122.725 Y124.31 E.02259
G1 X122.787 Y124.163 E.00477
G1 X123.581 Y123.92 E.02473
G1 X123.318 Y123.601 F9000
G1 F6364.866
G1 X123.44 Y123.034 E.01726
G1 X123.558 Y122.792 E.00804
G1 X123.69 Y122.676 E.00523
G1 X123.979 Y122.588 E.00901
G1 X124.559 Y122.574 E.01727
G1 X124.622 Y122.449 E.00417
G1 X124.427 Y121.883 E.01783
G1 X124.299 Y121.119 E.02305
G2 X121.116 Y124.313 I3.763 J6.935 E.13622
G3 X122.358 Y124.577 I-.24 J4.182 E.03798
G1 X122.385 Y124.1 E.01423
G1 X122.535 Y123.882 E.00788
G1 X122.76 Y123.758 E.00765
G1 X123.26 Y123.617 E.01548
G1 X122.966 Y123.27 F9000
; LINE_WIDTH: 0.510174
G1 F5136.4
G1 X123.022 Y123.041 E.00872
; LINE_WIDTH: 0.54444
G1 F4785.453
G1 X123.079 Y122.812 E.00936
; LINE_WIDTH: 0.578707
G1 F4479.395
G1 X123.135 Y122.582 E.01
; LINE_WIDTH: 0.61619
G1 F4186.509
G1 X123.185 Y122.481 E.00511
; LINE_WIDTH: 0.612624
G1 F4212.719
G1 X123.04 Y122.583 E.00798
; LINE_WIDTH: 0.56479
G1 F4598.847
G1 X122.895 Y122.686 E.00731
; LINE_WIDTH: 0.499539
G1 F5256.025
G1 X122.751 Y122.788 E.00639
G1 X122.426 Y123.135 E.01713
; LINE_WIDTH: 0.511808
G1 F5118.499
G1 X122.372 Y123.231 E.00409
; LINE_WIDTH: 0.549343
G1 F4739.126
G1 X122.317 Y123.327 E.00442
; LINE_WIDTH: 0.586878
G1 F4412.11
G1 X122.262 Y123.423 E.00475
; LINE_WIDTH: 0.624413
G1 F4127.31
G1 X122.208 Y123.519 E.00508
G1 X122.365 Y123.466 E.00761
; LINE_WIDTH: 0.586878
G1 F4412.11
G1 X122.522 Y123.413 E.00712
; LINE_WIDTH: 0.549343
G1 F4739.126
G1 X122.679 Y123.36 E.00663
; LINE_WIDTH: 0.505932
G1 F5183.452
G3 X122.908 Y123.287 I.835 J2.214 E.00882
G1 X123.185 Y122.481 F9000
; LINE_WIDTH: 0.63361
G1 F4063.045
G1 X123.386 Y122.307 E.0124
G1 X124.128 Y122.209 F9000
; LINE_WIDTH: 0.41578
G1 F6436.733
G1 X124.006 Y121.729 E.0146
G1 X123.716 Y121.92 E.01021
; LINE_WIDTH: 0.43727
G1 F6085.964
G1 X123.659 Y121.99 E.0028
; LINE_WIDTH: 0.48025
G1 F5487.847
G1 X123.602 Y122.06 E.00311
; LINE_WIDTH: 0.52323
G1 F4996.773
G1 X123.546 Y122.129 E.00341
; LINE_WIDTH: 0.56621
G1 F4586.367
G1 X123.489 Y122.199 E.00372
; LINE_WIDTH: 0.60919
G1 F4238.261
G1 X123.432 Y122.268 E.00402
G1 X123.539 Y122.257 E.00485
; LINE_WIDTH: 0.56621
G1 F4586.367
G1 X123.647 Y122.246 E.00448
; LINE_WIDTH: 0.52323
G1 F4996.773
G1 X123.755 Y122.235 E.00411
; LINE_WIDTH: 0.48025
G1 F5487.847
G1 X123.863 Y122.224 E.00374
; LINE_WIDTH: 0.427074
G1 F6247.492
G3 X124.068 Y122.211 I.188 J1.299 E.00626
; WIPE_START
G1 X123.863 Y122.224 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.379 Y123.549 Z1.4 F9000
G1 X133.592 Y123.938 Z1.4
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.49447
G1 F5315.026
G1 X133.881 Y124.061 E.0112
G1 X134.209 Y123.975 E.01209
G1 X133.865 Y123.492 E.02115
; LINE_WIDTH: 0.518745
G1 F5043.871
G1 X133.74 Y123.377 E.00639
; LINE_WIDTH: 0.567295
G1 F4576.878
G1 X133.614 Y123.263 E.00704
; LINE_WIDTH: 0.615845
G1 F4189.03
G1 X133.488 Y123.149 E.00769
G1 X133.519 Y123.367 E.00997
; LINE_WIDTH: 0.567295
G1 F4576.878
G1 X133.55 Y123.585 E.00912
; LINE_WIDTH: 0.512522
G1 F5110.711
G3 X133.587 Y123.879 I-2.695 J.492 E.01099
G1 X133.331 Y122.962 F9000
; LINE_WIDTH: 0.63108
G1 F4080.523
G1 X133.45 Y123.103 E.00856
; WIPE_START
G1 X133.331 Y122.962 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X132.406 Y122.676 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.498205
G1 F5271.423
G1 X133.009 Y122.805 E.02216
; LINE_WIDTH: 0.522765
G1 F5001.615
G1 X133.116 Y122.857 E.00452
; LINE_WIDTH: 0.562475
G1 F4619.338
G1 X133.224 Y122.909 E.0049
; LINE_WIDTH: 0.602185
G1 F4291.347
G1 X133.331 Y122.962 E.00527
G1 X133.257 Y122.859 E.00559
; LINE_WIDTH: 0.562475
G1 F4619.338
G1 X133.184 Y122.756 E.00519
; LINE_WIDTH: 0.503506
G1 F5210.753
G1 X133.11 Y122.653 E.0046
G2 X132.431 Y122.086 I-3.473 J3.471 E.03224
; LINE_WIDTH: 0.53692
G1 F4858.299
G1 X132.327 Y122.039 E.00445
; LINE_WIDTH: 0.5794
G1 F4473.606
G1 X132.223 Y121.992 E.00483
; LINE_WIDTH: 0.62188
G1 F4145.364
G1 X132.119 Y121.945 E.00521
; LINE_WIDTH: 0.618184
G1 F4172.003
G1 X132.2 Y122.146 E.00985
; LINE_WIDTH: 0.56831
G1 F4568.036
G1 X132.281 Y122.347 E.009
; LINE_WIDTH: 0.511989
G1 F5116.523
G3 X132.387 Y122.62 I-3.067 J1.346 E.01084
G1 X132.099 Y123.049 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X132.672 Y123.135 E.01726
G1 X132.83 Y123.183 E.00493
G1 X133.071 Y123.401 E.00969
G1 X133.151 Y123.645 E.00765
G1 X133.201 Y124.223 E.01726
G1 X133.735 Y124.449 E.01727
G1 X133.829 Y124.505 E.00326
G3 X134.888 Y124.313 I1.146 J3.309 E.03219
G2 X131.689 Y121.115 I-6.89 J3.693 E.1367
G3 X131.502 Y122.157 I-3.538 J-.098 E.03165
G1 X131.773 Y122.29 E.00901
G1 X131.906 Y122.501 E.00745
G1 X132.079 Y122.992 E.01549
G1 X131.818 Y123.388 F9000
; LINE_WIDTH: 0.41999
G1 F6364.878
G1 X132.616 Y123.508 E.02402
G1 X132.749 Y123.596 E.00477
G1 X132.845 Y124.481 E.02652
G1 X133.588 Y124.796 E.02403
G1 X133.654 Y124.843 E.0024
G1 X133.691 Y124.967 E.00387
G1 X134.357 Y124.751 E.02088
G3 X135.51 Y124.733 I.634 J3.709 E.03446
G2 X131.271 Y120.502 I-7.445 J3.22 E.18271
G1 X131.313 Y121.112 E.01822
G3 X130.93 Y122.545 I-3.683 J-.216 E.04446
G1 X131.393 Y122.501 E.01384
G1 X131.541 Y122.603 E.00534
G1 X131.798 Y123.331 E.023
; WIPE_START
G1 X131.541 Y122.603 E-.29341
G1 X131.393 Y122.501 E-.06807
G1 X130.93 Y122.545 E-.17661
G1 X131.125 Y122.106 E-.18222
G1 X131.152 Y122.005 E-.03968
; WIPE_END
G1 E-.04 F1800
G1 X136.781 Y126.494 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970899
G1 F9000
G1 X136.805 Y126.516 E.00014
; LINE_WIDTH: 0.122851
G1 X136.918 Y126.633 E.00102
; LINE_WIDTH: 0.172364
G1 X137.03 Y126.749 E.00166
; LINE_WIDTH: 0.188867
G1 X137.042 Y126.781 E.00039
; LINE_WIDTH: 0.158055
G1 X137.083 Y126.916 E.00128
; LINE_WIDTH: 0.116753
G1 X137.121 Y127.041 E.00076
; WIPE_START
G1 X137.083 Y126.916 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.121 Y128.959 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.116746
G1 F9000
G1 X137.083 Y129.084 E.00076
; LINE_WIDTH: 0.158063
G1 X137.042 Y129.219 E.00128
; LINE_WIDTH: 0.188871
G1 X137.03 Y129.251 E.00039
; LINE_WIDTH: 0.172341
G1 X136.918 Y129.367 E.00166
; LINE_WIDTH: 0.122808
G1 X136.805 Y129.484 E.00102
; LINE_WIDTH: 0.0970694
G1 X136.781 Y129.506 E.00014
; WIPE_START
G1 X136.805 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.592 Y132.062 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.49447
G1 F5315.026
G1 X133.524 Y132.595 E.01917
; LINE_WIDTH: 0.516109
G1 F5071.976
G1 X133.475 Y132.726 E.00523
; LINE_WIDTH: 0.559385
G1 F4646.975
G1 X133.427 Y132.857 E.00571
; LINE_WIDTH: 0.602662
G1 F4287.692
G1 X133.378 Y132.989 E.00619
G1 X133.492 Y132.891 E.00662
; LINE_WIDTH: 0.559385
G1 F4646.975
G1 X133.606 Y132.794 E.00611
; LINE_WIDTH: 0.496531
G1 F5290.886
G1 X133.72 Y132.696 E.00537
G2 X134.209 Y132.025 I-6.868 J-5.521 E.02977
G1 X133.881 Y131.939 E.01214
G1 X133.648 Y132.038 E.0091
; WIPE_START
G1 X133.881 Y131.939 E-.12274
G1 X134.209 Y132.025 E-.16367
G1 X133.72 Y132.696 E-.40123
G1 X133.606 Y132.794 E-.07237
; WIPE_END
G1 E-.04 F1800
G1 X133.198 Y133.162 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.63105
G1 F4080.731
G1 X133.335 Y133.03 E.00885
G1 X132.406 Y133.324 F9000
; LINE_WIDTH: 0.49351
G1 F5326.35
G1 X132.245 Y133.756 E.01643
G1 X131.99 Y134.057 E.01405
G1 X132.026 Y134.208 E.00552
G2 X132.872 Y133.568 I-3.618 J-5.659 E.03778
; LINE_WIDTH: 0.517559
G1 F5056.482
G1 X132.981 Y133.433 E.00651
; LINE_WIDTH: 0.565655
G1 F4591.236
G1 X133.089 Y133.298 E.00717
; LINE_WIDTH: 0.613752
G1 F4204.392
G1 X133.198 Y133.162 E.00783
G1 X133.007 Y133.205 E.00881
; LINE_WIDTH: 0.565655
G1 F4591.236
G1 X132.817 Y133.248 E.00807
; LINE_WIDTH: 0.506662
G1 F5175.295
G3 X132.466 Y133.315 I-.642 J-2.417 E.01309
G1 X132.098 Y132.951 F9000
; LINE_WIDTH: 0.41999
G1 F6364.873
G1 X131.906 Y133.498 E.01727
G1 X131.75 Y133.733 E.00839
G1 X131.502 Y133.843 E.00809
G3 X131.689 Y134.885 I-3.351 J1.14 E.03165
G2 X134.888 Y131.687 I-3.675 J-6.875 E.13671
G3 X133.829 Y131.495 I.102 J-3.586 E.03219
G1 X133.201 Y131.777 E.0205
G1 X133.151 Y132.355 E.01727
G1 X133.016 Y132.676 E.01037
G1 X132.83 Y132.817 E.00695
G1 X132.157 Y132.941 E.02037
G1 X131.818 Y132.612 F9000
; LINE_WIDTH: 0.41999
G1 F6364.875
G1 X131.551 Y133.374 E.02403
G1 X131.498 Y133.452 E.0028
G1 X131.353 Y133.499 E.00454
G1 X130.93 Y133.455 E.01267
G3 X131.269 Y135.51 I-3.036 J1.555 E.06303
G2 X135.504 Y131.268 I-3.282 J-7.512 E.18278
G1 X134.89 Y131.311 E.01833
G3 X133.691 Y131.033 I.203 J-3.601 E.03685
G1 X133.633 Y131.177 E.00463
G1 X132.845 Y131.519 E.02557
G1 X132.775 Y132.322 E.02403
G1 X132.697 Y132.459 E.00471
G1 X131.877 Y132.602 E.02479
; OBJECT_ID: 118
; WIPE_START
G1 X132.697 Y132.459 E-.31625
G1 X132.775 Y132.322 E-.06006
G1 X132.845 Y131.519 E-.30652
G1 X133.031 Y131.438 E-.07716
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X125.441 Y130.64 Z1.4 F9000
G1 X102.096 Y128.188 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G2 X102.096 Y127.812 I-1.218 J-.188 E.01213
G1 X102.28 Y127.753 E.00621
G1 X102.429 Y128 E.00926
G1 X102.28 Y128.247 E.00926
G1 X102.153 Y128.206 E.00428
; WIPE_START
G1 X102.111 Y128 E-.12303
G1 X102.096 Y127.812 E-.11006
G1 X102.28 Y127.753 E-.11279
G1 X102.429 Y128 E-.16818
G1 X102.28 Y128.247 E-.16819
G1 X102.153 Y128.206 E-.07775
; WIPE_END
G1 E-.04 F1800
G1 X107.174 Y123.117 Z1.4 F9000
G1 Z1
G1 E.8 F1800
G1 F5895.652
G1 X106.719 Y123.431 E.01778
G1 X106.284 Y123.205 E.01576
G1 X106.359 Y123.003 E.00693
G1 X106.686 Y123.079 E.01078
G1 X107.114 Y123.112 E.01383
; WIPE_START
G1 X106.719 Y123.431 E-.19497
G1 X106.284 Y123.205 E-.1883
G1 X106.359 Y123.003 E-.08279
G1 X106.686 Y123.079 E-.12877
G1 X107.114 Y123.112 E-.16516
; WIPE_END
G1 E-.04 F1800
G1 X112.676 Y128.339 Z1.4 F9000
G1 X115.165 Y130.678 Z1.4
G1 Z1
G1 E.8 F1800
G1 F5895.652
G1 X115.05 Y130.987 E.01061
G3 X109.682 Y136.167 I-8.107 J-3.03 E.248
G2 X109.26 Y133.152 I-2.648 J-1.167 E.10306
G1 X109.361 Y133.002 E.0058
G1 X110.238 Y133.092 E.02837
G1 X110.531 Y132.26 E.02837
G1 X111.403 Y132.129 E.02837
G1 X111.479 Y131.25 E.02837
G1 X112.292 Y130.905 E.02838
G1 X112.19 Y130.292 E.01998
G1 X112.612 Y130.566 E.01616
G2 X115.11 Y130.701 I1.392 J-2.558 E.08317
; WIPE_START
G1 X115.05 Y130.987 E-.11088
G1 X114.74 Y131.724 E-.30391
G1 X114.503 Y132.18 E-.19532
G1 X114.301 Y132.519 E-.14989
; WIPE_END
G1 E-.04 F1800
G1 X115.827 Y129.762 Z1.4 F9000
G1 Z1
G1 E.8 F1800
G1 F5895.652
G3 X109.02 Y136.762 I-8.843 J-1.79 E.33173
G1 X108.924 Y136.617 E.0056
G2 X108.747 Y133.188 I-1.915 J-1.62 E.12159
G1 X109.158 Y132.572 E.02381
G1 X109.961 Y132.655 E.02593
G1 X110.228 Y131.894 E.02593
G1 X111.025 Y131.774 E.02593
G1 X111.095 Y130.97 E.02593
G1 X111.838 Y130.656 E.02594
G1 X111.705 Y129.86 E.02593
G1 X112.067 Y129.584 E.01462
G1 X112.197 Y129.742 E.00657
G2 X115.372 Y130.109 I1.81 J-1.742 E.11141
G1 X115.779 Y129.798 E.01645
; WIPE_START
G1 X115.673 Y130.392 E-.229
G1 X115.515 Y130.906 E-.20437
G1 X115.326 Y131.41 E-.20453
G1 X115.195 Y131.703 E-.1221
; WIPE_END
G1 E-.04 F1800
G1 X111.98 Y124.781 Z1.4 F9000
G1 X109.682 Y119.833 Z1.4
G1 Z1
G1 E.8 F1800
G1 F5895.652
G1 X110.38 Y120.108 E.02413
G3 X115.165 Y125.322 I-3.405 J7.927 E.23451
G2 X113.684 Y125.106 I-1.125 J2.528 E.04874
G2 X112.19 Y125.708 I.308 J2.923 E.05247
G1 X112.292 Y125.095 E.01998
G1 X111.479 Y124.75 E.02838
G1 X111.403 Y123.872 E.02837
M73 P53 R9
G1 X110.531 Y123.74 E.02837
G1 X110.238 Y122.908 E.02838
G1 X109.361 Y122.998 E.02837
G1 X109.26 Y122.848 E.0058
G1 X109.329 Y122.77 E.00333
G2 X109.705 Y119.889 I-2.378 J-1.775 E.09765
G1 X108.924 Y119.383 F9000
G1 F5895.652
G1 X109.02 Y119.238 E.0056
G1 X109.528 Y119.37 E.01687
G3 X115.827 Y126.238 I-2.548 J8.66 E.31487
G1 X115.372 Y125.891 E.01838
G1 X115.213 Y125.805 E.00581
G2 X112.067 Y126.416 I-1.208 J2.188 E.11189
G1 X111.705 Y126.14 E.01462
G1 X111.838 Y125.344 E.02593
G1 X111.095 Y125.03 E.02594
G1 X111.025 Y124.226 E.02593
G1 X110.228 Y124.106 E.02593
G1 X109.961 Y123.345 E.02594
G1 X109.158 Y123.428 E.02593
G1 X108.747 Y122.812 E.02381
G2 X108.962 Y119.43 I-1.738 J-1.809 E.11966
G1 X108.595 Y119.623 F9000
G1 F5895.652
G1 X108.768 Y119.859 E.00941
G3 X107.378 Y123.067 I-1.767 J1.14 E.13276
G1 X107.865 Y123.503 E.02099
G1 X108.55 Y123.25 E.0235
G1 X108.956 Y123.858 E.02349
G1 X109.683 Y123.783 E.0235
G1 X109.925 Y124.472 E.0235
G1 X110.647 Y124.581 E.02349
G1 X110.711 Y125.309 E.02349
G1 X111.383 Y125.594 E.0235
G1 X111.263 Y126.315 E.02349
G1 X111.844 Y126.758 E.02349
G1 X111.549 Y127.426 E.0235
G1 X111.886 Y127.855 E.01754
G3 X112.121 Y127.067 I2.667 J.366 E.02655
G3 X112.057 Y128.773 I1.885 J.926 E.36777
G1 X112.001 Y128.635 E.00481
G1 X111.886 Y128.145 E.01616
G1 X111.549 Y128.574 E.01754
G1 X111.844 Y129.242 E.0235
G1 X111.263 Y129.685 E.02349
G1 X111.383 Y130.406 E.02349
G1 X110.711 Y130.691 E.0235
G1 X110.647 Y131.419 E.02349
G1 X109.925 Y131.528 E.02349
G1 X109.683 Y132.217 E.0235
G1 X108.956 Y132.142 E.02349
G1 X108.55 Y132.75 E.0235
G1 X107.865 Y132.497 E.0235
G1 X107.378 Y132.933 E.02099
G3 X105.681 Y133.374 I-.368 J2.068 E.36616
G1 X105.796 Y133.279 E.00481
G1 X106.191 Y133.044 E.01477
G1 X105.592 Y132.354 E.0294
G1 X104.88 Y132.519 E.0235
G1 X104.554 Y131.865 E.02349
G1 X103.823 Y131.848 E.02349
G1 X103.669 Y131.134 E.02349
G1 X102.966 Y130.936 E.02349
G1 X102.995 Y130.205 E.0235
G1 X102.363 Y129.838 E.02349
G1 X102.572 Y129.139 E.02349
G1 X102.026 Y128.601 E.02465
G1 X101.892 Y128.934 E.01154
G3 X102.026 Y127.399 I-1.882 J-.937 E.37408
G1 X102.572 Y126.861 E.02465
G1 X102.363 Y126.161 E.02349
G1 X102.995 Y125.794 E.02349
G1 X102.966 Y125.064 E.0235
G1 X103.669 Y124.866 E.02349
G1 X103.823 Y124.152 E.02349
G1 X104.554 Y124.135 E.02349
G1 X104.88 Y123.481 E.02349
G1 X105.592 Y123.646 E.02349
G1 X106.191 Y122.956 E.0294
G1 X105.796 Y122.721 E.01477
G3 X104.922 Y121.229 I1.248 J-1.734 E.05725
G3 X106.846 Y118.902 I2.095 J-.226 E.10823
G3 X108.553 Y119.58 I.156 J2.097 E.06114
; WIPE_START
G1 X108.768 Y119.859 E-.13386
G1 X108.926 Y120.139 E-.12226
G1 X109.035 Y120.443 E-.12238
G1 X109.097 Y120.759 E-.12241
G1 X109.109 Y121.081 E-.12237
G1 X109.072 Y121.401 E-.1224
G1 X109.062 Y121.437 E-.01433
; WIPE_END
G1 E-.04 F1800
G1 X105.483 Y127.225 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
G1 X105.615 Y127.021 E.00723
G3 X106.72 Y126.316 I1.401 J.978 E.04006
G3 X107.203 Y126.301 I.292 J1.556 E.01445
G3 X105.465 Y127.281 I-.187 J1.698 E.25625
; WIPE_START
G1 X105.615 Y127.021 E-.11397
G1 X105.774 Y126.814 E-.09931
G1 X105.97 Y126.64 E-.09954
G1 X106.19 Y126.497 E-.09953
G1 X106.428 Y126.39 E-.09947
G1 X106.72 Y126.316 E-.11421
G1 X106.941 Y126.291 E-.08471
G1 X107.071 Y126.296 E-.04926
; WIPE_END
G1 E-.04 F1800
G1 X101.643 Y128.494 Z1.4 F9000
G1 Z1
G1 E.8 F1800
G1 F6364.704
G1 X101.642 Y128.517 E.00071
G3 X99.953 Y126.295 I-1.628 J-.516 E.22223
G3 X101.044 Y126.64 I.049 J1.745 E.03472
G3 X101.701 Y128.262 I-1.03 J1.362 E.05475
G1 X101.658 Y128.435 E.00534
; WIPE_START
G1 X101.642 Y128.517 E-.03169
G1 X101.54 Y128.759 E-.09968
G1 X101.406 Y128.984 E-.09951
G1 X101.239 Y129.186 E-.09952
G1 X101.044 Y129.36 E-.0995
G1 X100.824 Y129.503 E-.09955
G1 X100.585 Y129.61 E-.09949
G1 X100.332 Y129.679 E-.09952
G1 X100.25 Y129.689 E-.03152
; WIPE_END
G1 E-.04 F1800
G1 X105.081 Y123.78 Z1.4 F9000
G1 X108.283 Y119.862 Z1.4
G1 Z1
G1 E.8 F1800
G1 F6364.704
G3 X106.876 Y119.294 I-1.276 J1.135 E.27278
G3 X107.532 Y119.377 I.103 J1.825 E.01982
G1 X107.646 Y119.413 E.00356
G3 X108.243 Y119.818 I-.639 J1.584 E.02163
; WIPE_START
G1 X108.443 Y120.07 E-.12222
G1 X108.568 Y120.3 E-.09953
G1 X108.656 Y120.547 E-.09951
G1 X108.706 Y120.804 E-.09952
G1 X108.716 Y121.065 E-.09949
G1 X108.686 Y121.326 E-.09955
G1 X108.617 Y121.578 E-.09951
G1 X108.573 Y121.676 E-.04067
; WIPE_END
G1 E-.04 F1800
G1 X114.604 Y126.353 Z1.4 F9000
G1 X115.328 Y126.914 Z1.4
G1 Z1
G1 E.8 F1800
G1 F6364.704
G1 X115.473 Y127.128 E.00771
G3 X113.823 Y126.304 I-1.467 J.874 E.26162
G3 X114.832 Y126.507 I.184 J1.697 E.03114
G3 X115.287 Y126.873 I-.825 J1.495 E.01749
; WIPE_START
G1 X115.473 Y127.128 E-.12007
G1 X115.593 Y127.361 E-.09938
G1 X115.672 Y127.61 E-.09952
G1 X115.712 Y127.869 E-.09954
G1 X115.712 Y128.131 E-.0995
G1 X115.672 Y128.39 E-.09954
G1 X115.593 Y128.639 E-.09952
G1 X115.543 Y128.741 E-.04293
; WIPE_END
G1 E-.04 F1800
G1 X110.128 Y134.119 Z1.4 F9000
G1 X107.643 Y136.588 Z1.4
G1 Z1
G1 E.8 F1800
G1 F6364.704
G1 X107.397 Y136.667 E.00771
G3 X106.888 Y133.299 I-.383 J-1.665 E.16758
G3 X107.991 Y133.601 I.116 J1.742 E.03471
G3 X107.699 Y136.567 I-.977 J1.401 E.10787
; WIPE_START
G1 X107.397 Y136.667 E-.12083
G1 X107.138 Y136.706 E-.09957
G1 X106.876 Y136.706 E-.0995
G1 X106.617 Y136.666 E-.09954
G1 X106.367 Y136.587 E-.09952
G1 X106.133 Y136.47 E-.0995
G1 X105.918 Y136.32 E-.09952
G1 X105.839 Y136.243 E-.04202
; WIPE_END
G1 E-.04 F1800
G1 X105.138 Y128.643 Z1.4 F9000
G1 X104.327 Y119.847 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X104.191 Y120.226 E.01296
G2 X104.482 Y122.458 I2.869 J.761 E.07422
G1 X104.044 Y123.332 E.03144
G1 X103.162 Y123.353 E.02837
G1 X102.977 Y124.215 E.02837
G1 X102.128 Y124.455 E.02837
G1 X102.162 Y125.337 E.02837
G1 X101.682 Y125.616 E.01786
G2 X98.856 Y125.319 I-1.682 J2.42 E.09532
G3 X104.27 Y119.866 I8.163 J2.69 E.25617
; WIPE_START
G1 X104.191 Y120.226 E-.14023
G1 X104.106 Y120.665 E-.16994
G1 X104.088 Y121.112 E-.16983
G1 X104.14 Y121.556 E-.16993
G1 X104.217 Y121.835 E-.11008
; WIPE_END
G1 E-.04 F1800
G1 X105.24 Y119.186 Z1.4 F9000
G1 Z1
G1 E.8 F1800
G1 F5895.652
G1 X104.898 Y119.634 E.01815
G1 X104.812 Y119.793 E.00581
G2 X105.516 Y123.017 I2.202 J1.208 E.11578
G1 X105.43 Y123.191 E.00622
G1 X104.66 Y123.012 E.02544
G1 X104.299 Y123.733 E.02593
G1 X103.493 Y123.752 E.02593
G1 X103.323 Y124.541 E.02593
G1 X102.547 Y124.76 E.02593
G1 X102.578 Y125.566 E.02594
G1 X101.881 Y125.971 E.02593
G1 X101.925 Y126.116 E.00489
G1 X101.769 Y126.215 E.00594
G2 X98.641 Y125.891 I-1.765 J1.78 E.1093
G1 X98.196 Y126.231 E.01802
G3 X105.181 Y119.198 I8.805 J1.759 E.3377
; WIPE_START
G1 X104.898 Y119.634 E-.19786
G1 X104.812 Y119.793 E-.06871
G1 X104.714 Y119.972 E-.07744
G1 X104.584 Y120.334 E-.14616
G1 X104.511 Y120.712 E-.14616
G1 X104.499 Y121.037 E-.12369
; WIPE_END
G1 E-.04 F1800
G1 X102.296 Y128.345 Z1.4 F9000
G1 X101.682 Y130.384 Z1.4
G1 Z1
G1 E.8 F1800
G1 F5895.652
G1 X102.162 Y130.663 E.01786
G1 X102.128 Y131.545 E.02837
G1 X102.977 Y131.784 E.02837
G1 X103.162 Y132.647 E.02837
G1 X104.044 Y132.668 E.02837
G1 X104.482 Y133.542 E.03144
G1 X104.441 Y133.605 E.00239
G2 X104.327 Y136.153 I2.642 J1.395 E.08475
G3 X98.856 Y130.681 I2.669 J-8.139 E.25817
G2 X101.633 Y130.419 I1.151 J-2.644 E.09359
G1 X101.769 Y129.785 F9000
G1 F5895.652
G1 X101.925 Y129.884 E.00594
G1 X101.881 Y130.029 E.00489
G1 X102.578 Y130.434 E.02593
G1 X102.547 Y131.24 E.02593
G1 X103.323 Y131.459 E.02593
G1 X103.493 Y132.248 E.02593
G1 X104.299 Y132.267 E.02593
G1 X104.66 Y132.988 E.02593
G1 X105.43 Y132.809 E.02544
G1 X105.516 Y132.983 E.00622
G1 X105.422 Y133.06 E.00391
G2 X104.898 Y136.365 I1.577 J1.944 E.11786
G1 X105.24 Y136.814 E.01815
G3 X98.196 Y129.769 I1.775 J-8.82 E.33953
G1 X98.641 Y130.109 E.01802
G2 X101.726 Y129.826 I1.36 J-2.132 E.10719
; WIPE_START
G1 X101.925 Y129.884 E-.07879
G1 X101.881 Y130.029 E-.05773
G1 X102.578 Y130.434 E-.30645
G1 X102.547 Y131.24 E-.30647
G1 X102.574 Y131.248 E-.01056
; WIPE_END
G1 E-.04 F1800
G1 X104.739 Y123.929 Z1.4 F9000
G1 X106.305 Y118.633 Z1.4
G1 Z1
M73 P54 R9
G1 E.8 F1800
G1 F5895.652
G3 X107.117 Y118.607 I.712 J9.459 E.02615
G3 X103.056 Y119.473 I-.12 J9.395 E1.76369
G3 X106.245 Y118.638 I3.961 J8.62 E.10654
; WIPE_START
G1 X107.117 Y118.607 E-.33166
G1 X107.989 Y118.654 E-.33171
G1 X108.241 Y118.688 E-.09663
; WIPE_END
G1 E-.04 F1800
G1 X107.669 Y126.299 Z1.4 F9000
G1 X107.174 Y132.883 Z1.4
G1 Z1
G1 E.8 F1800
G1 F5895.652
G2 X106.359 Y132.997 I-.039 J2.693 E.02656
G1 X106.284 Y132.795 E.00693
G1 X106.719 Y132.569 E.01576
G1 X107.124 Y132.849 E.01584
; WIPE_START
G1 X106.686 Y132.921 E-.17085
G1 X106.359 Y132.997 E-.12881
G1 X106.284 Y132.795 E-.08281
G1 X106.719 Y132.569 E-.1883
G1 X107.124 Y132.849 E-.18924
; WIPE_END
G1 E-.04 F1800
G1 X106.682 Y125.23 Z1.4 F9000
G1 X106.276 Y118.237 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
G1 X107.123 Y118.215 E.02525
G3 X102.368 Y119.379 I-.125 J9.787 E1.68437
G3 X106.219 Y118.245 I4.622 J8.586 E.12044
G1 X106.047 Y118.883 F9000
; FEATURE: Gap infill
; LINE_WIDTH: 0.117481
G1 X105.922 Y118.919 E.00077
; LINE_WIDTH: 0.161195
G1 X105.782 Y118.96 E.00136
; LINE_WIDTH: 0.192058
G1 X105.758 Y118.97 E.00031
; LINE_WIDTH: 0.172911
G1 X105.64 Y119.083 E.00168
; LINE_WIDTH: 0.123
G1 X105.522 Y119.197 E.00103
; LINE_WIDTH: 0.0970693
G1 X105.501 Y119.221 E.00014
; WIPE_START
G1 X105.522 Y119.197 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.958 Y118.878 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.116544
G1 F9000
G1 X108.087 Y118.917 E.00078
; LINE_WIDTH: 0.155808
G1 X108.216 Y118.957 E.0012
; LINE_WIDTH: 0.177553
G1 X108.822 Y119.168 E.00683
G1 X108.797 Y119.206
; LINE_WIDTH: 0.353135
G1 F7736.574
G1 X108.095 Y118.874 E.01904
; WIPE_START
G1 X108.797 Y119.206 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.552 Y122.886 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.267911
G1 F9000
G3 X108.389 Y122.979 I-1.308 J-2.106 E.00333
; LINE_WIDTH: 0.239493
G1 X108.229 Y123.056 E.00276
; LINE_WIDTH: 0.196018
G1 X107.85 Y123.217 E.00498
; WIPE_START
G1 X108.229 Y123.056 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X109.194 Y124.057 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S500
G1 X109.732 Y124.596 E.02269
G1 X109.818 Y124.681
G1 X110.491 Y125.354 E.02834
; WIPE_START
M204 S750
G1 X109.818 Y124.681 E-.39411
G1 X109.732 Y124.596 E-.05032
G1 X109.194 Y124.057 E-.31557
; WIPE_END
G1 E-.04 F1800
G1 X111.528 Y126.924 Z1.4 F9000
G1 Z1
G1 E.8 F1800
G1 F6364.704
M204 S500
G1 X108.215 Y123.611 E.13956
G1 X107.825 Y123.755
G1 X111.364 Y127.294 E.14908
G1 X111.638 Y128.101
G1 X107.026 Y123.489 E.19427
G1 X106.649 Y123.645
G1 X111.403 Y128.399 E.20027
G1 X111.512 Y129.042
G1 X105.993 Y123.523 E.23248
G1 X105.746 Y123.808
G1 X111.308 Y129.371 E.23433
G1 X111.028 Y129.624
G1 X108.832 Y127.428 E.09248
G1 X108.92 Y128.049
G1 X111.134 Y130.263 E.09328
G1 X110.764 Y130.427
G1 X108.851 Y128.513 E.0806
G1 X108.699 Y128.894
G1 X110.488 Y130.684 E.07537
G1 X110.445 Y131.174
G1 X108.489 Y129.218 E.08241
G1 X108.219 Y129.481
G1 X110.025 Y131.287 E.07608
G1 X109.7 Y131.496
G1 X107.898 Y129.693 E.07594
G1 X107.52 Y129.848
G1 X109.562 Y131.89 E.08602
G1 X109.068 Y131.93
G1 X107.051 Y129.913 E.08499
G1 X106.43 Y129.825
G1 X108.712 Y132.107 E.09612
; WIPE_START
M204 S750
G1 X107.298 Y130.693 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.576 Y126.172 Z1.4 F9000
G1 Z1
G1 E.8 F1800
G1 F6364.704
M204 S500
G1 X105.184 Y123.78 E.10076
G1 X104.87 Y123.999
G1 X106.954 Y126.084 E.08781
G1 X106.494 Y126.157
G1 X104.691 Y124.354 E.07595
G1 X104.17 Y124.366
G1 X106.11 Y126.306 E.0817
G1 X105.792 Y126.521
G1 X103.94 Y124.668 E.07802
G1 X103.799 Y125.061
G1 X105.526 Y126.788 E.07278
G1 X105.312 Y127.107
G1 X103.383 Y125.178 E.08127
G1 X103.207 Y125.536
G1 X105.161 Y127.49 E.08231
G1 X105.092 Y127.954
G1 X103.118 Y125.98 E.08313
G1 X102.781 Y126.176
G1 X105.176 Y128.571 E.10088
; WIPE_START
M204 S750
G1 X103.761 Y127.157 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X102.75 Y126.678 Z1.4 F9000
G1 Z1
G1 E.8 F1800
G1 F6364.704
M204 S500
G1 X108.498 Y132.427 E.24215
G1 X107.797 Y132.259
G1 X102.643 Y127.104 E.21713
G1 X102.374 Y127.369
G1 X107.516 Y132.511 E.21659
G1 X106.885 Y132.413
G1 X102.607 Y128.135 E.18021
G1 X102.407 Y128.468
G1 X106.415 Y132.476 E.16885
G1 X105.542 Y132.137
G1 X102.745 Y129.339 E.11786
G1 X103.212 Y130.34
G1 X103.816 Y130.944 E.02544
G1 X103.867 Y130.995
G1 X104.514 Y131.642 E.02725
; WIPE_START
M204 S750
G1 X103.867 Y130.995 E-.34762
G1 X103.816 Y130.944 E-.02736
G1 X103.212 Y130.34 E-.32456
G1 X103.145 Y130.196 E-.06046
; WIPE_END
G1 E-.04 F1800
G1 X109.878 Y126.602 Z1.4 F9000
G1 X111.119 Y125.94 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.382138
G1 F7075.111
G1 X110.993 Y125.855 E.00407
; LINE_WIDTH: 0.339229
G1 F8099.671
G1 X110.867 Y125.771 E.00355
; LINE_WIDTH: 0.29632
G1 F9000
G1 X110.742 Y125.686 E.00304
; LINE_WIDTH: 0.253411
G1 X110.616 Y125.601 E.00252
; LINE_WIDTH: 0.205419
G3 X110.459 Y125.487 I.303 J-.585 E.0025
; LINE_WIDTH: 0.166408
G1 X110.487 Y125.358 E.00129
; WIPE_START
G1 X110.459 Y125.487 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.545 Y123.646 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.0996263
G1 F9000
G1 X108.434 Y123.51 E.00079
G1 X107.762 Y123.818
; LINE_WIDTH: 0.221198
G1 X107.237 Y123.321 E.01018
G1 X106.587 Y123.706
; LINE_WIDTH: 0.197174
G1 X106.442 Y123.6 E.00219
; LINE_WIDTH: 0.153571
G1 X106.297 Y123.493 E.00157
; LINE_WIDTH: 0.109968
G1 X106.152 Y123.387 E.00095
; WIPE_START
G1 X106.297 Y123.493 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.017 Y124.351 Z1.4 F9000
G1 Z1
M73 P55 R9
G1 E.8 F1800
; LINE_WIDTH: 0.138631
G1 F9000
G1 X104.001 Y124.535 E.0014
G1 X104.073 Y124.535 E.00054
; WIPE_START
G1 X104.001 Y124.535 E-.2125
G1 X104.017 Y124.351 E-.5475
; WIPE_END
G1 E-.04 F1800
G1 X102.658 Y127.948 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.0938916
G1 F9000
G3 X102.652 Y128.062 I-.034 J.055 E.00056
; WIPE_START
G1 X102.697 Y128.002 E-.40215
G1 X102.658 Y127.948 E-.35785
; WIPE_END
G1 E-.04 F1800
G1 X105.154 Y132.246 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.297317
G1 F9000
G1 X105.046 Y132.096 E.00373
; LINE_WIDTH: 0.249974
G1 X104.937 Y131.946 E.00303
; LINE_WIDTH: 0.202632
G1 X104.829 Y131.795 E.00234
; LINE_WIDTH: 0.153381
G2 X104.583 Y131.572 I-.347 J.136 E.003
; WIPE_START
G1 X104.721 Y131.645 E-.3463
G1 X104.829 Y131.795 E-.4137
; WIPE_END
G1 E-.04 F1800
G1 X108.941 Y128.337 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.0983383
G1 F9000
G3 X108.86 Y128.48 I-1.918 J-.999 E.00072
; WIPE_START
G1 X108.941 Y128.337 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.896 Y127.365 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.193132
G1 F9000
G1 X108.831 Y127.259 E.00147
; LINE_WIDTH: 0.158658
G1 X108.74 Y127.132 E.00143
; LINE_WIDTH: 0.111661
G1 X108.649 Y127.005 E.00085
G1 X108.011 Y126.368
; LINE_WIDTH: 0.104512
G1 X107.911 Y126.293 E.00061
; LINE_WIDTH: 0.148261
G2 X107.644 Y126.104 I-2.566 J3.328 E.00272
; WIPE_START
G1 X107.911 Y126.293 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.107 Y127.938 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.0941325
G1 F9000
G1 X105.02 Y128.148 E.00092
G1 X105.387 Y129.02
; LINE_WIDTH: 0.123006
G3 X105.105 Y128.641 I4.818 J-3.871 E.00299
; WIPE_START
G1 X105.387 Y129.02 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X106.364 Y129.892 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.179914
G1 F9000
G1 X106.225 Y129.796 E.00183
; LINE_WIDTH: 0.132711
G1 X106.081 Y129.697 E.00124
; LINE_WIDTH: 0.0984303
G1 X105.988 Y129.621 E.00053
; WIPE_START
G1 X106.081 Y129.697 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.68 Y132.802 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.12105
G1 F9000
G1 X105.828 Y133.024 E.00165
; WIPE_START
G1 X105.68 Y132.802 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.85 Y132.783 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.195998
G1 F9000
G1 X108.229 Y132.944 E.00498
; LINE_WIDTH: 0.239455
G1 X108.389 Y133.021 E.00275
; LINE_WIDTH: 0.267872
G3 X108.552 Y133.114 I-1.141 J2.19 E.00333
; WIPE_START
G1 X108.389 Y133.021 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.797 Y136.794 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.353115
G1 F7737.078
G1 X108.095 Y137.126 E.01904
G1 X108.087 Y137.083 F9000
; LINE_WIDTH: 0.116556
G1 X107.958 Y137.122 E.00078
G1 X108.087 Y137.083
; LINE_WIDTH: 0.155831
G1 X108.216 Y137.043 E.0012
; LINE_WIDTH: 0.177563
G1 X108.822 Y136.832 E.00683
; WIPE_START
G1 X108.216 Y137.043 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X106.047 Y137.117 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.11748
G1 F9000
G1 X105.922 Y137.081 E.00077
; LINE_WIDTH: 0.161183
G1 X105.782 Y137.04 E.00136
; LINE_WIDTH: 0.192064
G1 X105.758 Y137.03 E.00031
; LINE_WIDTH: 0.172924
G1 X105.64 Y136.917 E.00168
; LINE_WIDTH: 0.123032
G1 X105.522 Y136.803 E.00103
; LINE_WIDTH: 0.0970927
G1 X105.501 Y136.779 E.00014
; WIPE_START
G1 X105.522 Y136.803 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.929 Y132.076 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.65031
G1 F3951.333
G1 X101.195 Y132.45 E.02205
; WIPE_START
G1 X100.929 Y132.076 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X102.643 Y132.098 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.873
G1 X101.867 Y131.879 E.02403
G1 X101.742 Y131.765 E.00504
G1 X101.759 Y130.932 E.02481
G2 X101.643 Y130.857 I-.08 J-.003 E.00497
G1 X101.148 Y131.109 E.01652
G3 X99.497 Y131.267 I-1.122 J-3.018 E.04996
G2 X103.74 Y135.507 I7.526 J-3.286 E.1829
G1 X103.696 Y134.888 E.01851
G3 X104.045 Y133.547 I3.081 J.087 E.04162
G1 X103.799 Y133.054 E.01641
G1 X102.993 Y133.035 E.02403
G1 X102.865 Y132.981 E.00415
G3 X102.656 Y132.156 I3.902 J-1.428 E.02537
G1 X102.322 Y132.399 F9000
; LINE_WIDTH: 0.41999
G1 F6364.871
G1 X101.764 Y132.242 E.01727
G1 X101.525 Y132.104 E.00824
G1 X101.39 Y131.9 E.00729
G1 X101.319 Y131.445 E.01371
G1 X100.798 Y131.6 E.01621
G1 X100.12 Y131.687 E.02035
G2 X103.252 Y134.851 I6.932 J-3.73 E.13444
G1 X103.319 Y134.872 E.00208
G3 X103.626 Y133.551 I3.489 J.115 E.04065
G1 X103.563 Y133.426 E.00418
G1 X102.984 Y133.412 E.01727
G1 X102.694 Y133.324 E.00901
G1 X102.526 Y133.16 E.007
G3 X102.335 Y132.458 I3.491 J-1.329 E.02172
G1 X101.97 Y132.729 F9000
; LINE_WIDTH: 0.512344
G1 F5112.651
G1 X101.785 Y132.672 E.00719
; LINE_WIDTH: 0.550932
G1 F4724.305
G1 X101.6 Y132.614 E.00778
; LINE_WIDTH: 0.589519
G1 F4390.79
G1 X101.415 Y132.557 E.00837
; LINE_WIDTH: 0.628107
G1 F4101.259
G1 X101.23 Y132.499 E.00896
G1 X101.293 Y132.604 E.00566
; LINE_WIDTH: 0.589519
G1 F4390.79
G1 X101.356 Y132.709 E.00528
; LINE_WIDTH: 0.550932
G1 F4724.305
G1 X101.418 Y132.814 E.00491
; LINE_WIDTH: 0.512344
G1 F5112.651
G1 X101.481 Y132.919 E.00454
; LINE_WIDTH: 0.472745
G1 F5583.668
G1 X101.618 Y133.081 E.00719
; LINE_WIDTH: 0.432135
G1 F6166.258
G1 X101.755 Y133.243 E.00651
; LINE_WIDTH: 0.391525
G1 F6884.584
G1 X101.891 Y133.404 E.00583
; LINE_WIDTH: 0.395662
G1 F6803.84
G1 X101.966 Y133.441 E.00232
; LINE_WIDTH: 0.444546
G1 F5975.709
G1 X102.041 Y133.477 E.00264
; LINE_WIDTH: 0.49343
G1 F5327.296
G1 X102.116 Y133.513 E.00296
; LINE_WIDTH: 0.542314
G1 F4805.825
G1 X102.191 Y133.55 E.00328
; LINE_WIDTH: 0.591198
G1 F4377.342
G1 X102.265 Y133.586 E.0036
; LINE_WIDTH: 0.595725
G1 F4341.495
G1 X102.237 Y133.521 E.0031
; LINE_WIDTH: 0.555895
G1 F4678.591
G1 X102.209 Y133.456 E.00288
; LINE_WIDTH: 0.516065
G1 F5072.441
G1 X102.181 Y133.39 E.00266
; LINE_WIDTH: 0.475329
G1 F5550.309
G1 X102.173 Y133.333 E.00199
; LINE_WIDTH: 0.433685
G1 F6141.799
G1 X102.165 Y133.275 E.0018
; LINE_WIDTH: 0.392042
G1 F6874.394
G1 X102.157 Y133.217 E.00161
; LINE_WIDTH: 0.391525
G1 F6884.584
G1 X102.104 Y133.099 E.00357
; LINE_WIDTH: 0.432135
G1 F6166.258
G1 X102.052 Y132.98 E.00399
; LINE_WIDTH: 0.480218
G1 F5488.247
G3 X101.983 Y132.788 I.423 J-.259 E.0071
G1 X102.265 Y133.586 F9000
; LINE_WIDTH: 0.62952
G1 F4091.374
G1 X102.473 Y133.75 E.01224
G1 X103.133 Y133.791 F9000
; LINE_WIDTH: 0.438569
G1 F6065.983
G1 X103.01 Y133.79 E.00383
; LINE_WIDTH: 0.484087
G1 F5440.117
G1 X102.888 Y133.789 E.00427
; LINE_WIDTH: 0.529605
G1 F4931.321
G1 X102.765 Y133.788 E.00471
; LINE_WIDTH: 0.575123
G1 F4509.557
G1 X102.643 Y133.788 E.00515
; LINE_WIDTH: 0.620641
G1 F4154.254
G1 X102.52 Y133.787 E.00559
G1 X102.574 Y133.854 E.00393
; LINE_WIDTH: 0.575123
G1 F4509.557
G1 X102.627 Y133.922 E.00362
; LINE_WIDTH: 0.529605
G1 F4931.321
G1 X102.681 Y133.989 E.00331
; LINE_WIDTH: 0.484087
G1 F5440.117
G1 X102.734 Y134.057 E.003
; LINE_WIDTH: 0.418298
G1 F6393.561
G1 X102.788 Y134.124 E.00255
G1 X103.01 Y134.271 E.0079
G1 X103.118 Y133.849 E.01292
; WIPE_START
G1 X103.01 Y134.271 E-.42011
G1 X102.788 Y134.124 E-.25682
G1 X102.734 Y134.057 E-.08307
; WIPE_END
G1 E-.04 F1800
G1 X98.228 Y129.506 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970951
G1 F9000
G1 X98.204 Y129.484 E.00014
; LINE_WIDTH: 0.122751
G1 X98.091 Y129.368 E.00102
; LINE_WIDTH: 0.175243
G1 X97.979 Y129.251 E.00169
G1 X97.963 Y129.209 E.00047
; LINE_WIDTH: 0.157749
G1 X97.926 Y129.092 E.00111
; LINE_WIDTH: 0.117842
G1 X97.888 Y128.956 E.00083
; WIPE_START
G1 X97.926 Y129.092 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X97.888 Y127.044 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.117859
G1 F9000
G1 X97.926 Y126.908 E.00083
; LINE_WIDTH: 0.157746
G1 X97.963 Y126.791 E.00111
; LINE_WIDTH: 0.175229
G1 X97.979 Y126.749 E.00047
G1 X98.091 Y126.632 E.00169
; LINE_WIDTH: 0.122752
G1 X98.204 Y126.516 E.00102
; LINE_WIDTH: 0.0970896
G1 X98.228 Y126.494 E.00014
; WIPE_START
G1 X98.204 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.929 Y123.924 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.64819
G1 F3965.173
G1 X101.178 Y123.568 E.02076
; WIPE_START
G1 X100.929 Y123.924 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X102.643 Y123.902 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X102.813 Y123.114 E.02403
G1 X102.896 Y122.994 E.00434
G3 X103.799 Y122.946 I.989 J10.014 E.02694
G1 X104.045 Y122.453 E.0164
G1 X103.94 Y122.231 E.00734
G1 X103.758 Y121.645 E.01827
G3 X103.74 Y120.493 I3.709 J-.634 E.03446
G2 X100.225 Y123.408 I3.258 J7.505 E.13784
M73 P55 R8
G2 X99.511 Y124.731 I8.078 J5.214 E.04483
G1 X100.039 Y124.692 E.01578
G1 X100.623 Y124.745 E.01746
G1 X101.113 Y124.878 E.01511
G1 X101.643 Y125.143 E.01764
G2 X101.759 Y125.068 I.036 J-.072 E.00497
G1 X101.729 Y124.31 E.02259
G1 X101.792 Y124.163 E.00477
G1 X102.586 Y123.92 E.02473
G1 X102.322 Y123.601 F9000
G1 F6364.866
G1 X102.444 Y123.034 E.01726
G1 X102.562 Y122.792 E.00804
G1 X102.694 Y122.676 E.00523
G1 X102.984 Y122.588 E.00901
G1 X103.563 Y122.574 E.01727
G1 X103.626 Y122.449 E.00417
G1 X103.432 Y121.883 E.01783
G1 X103.304 Y121.119 E.02305
G2 X100.12 Y124.313 I3.763 J6.935 E.13622
G3 X101.363 Y124.577 I-.24 J4.182 E.03798
G1 X101.39 Y124.1 E.01423
G1 X101.539 Y123.882 E.00788
G1 X101.764 Y123.758 E.00765
G1 X102.265 Y123.617 E.01548
G1 X101.97 Y123.27 F9000
; LINE_WIDTH: 0.510174
G1 F5136.4
G1 X102.027 Y123.041 E.00872
; LINE_WIDTH: 0.54444
G1 F4785.453
G1 X102.083 Y122.812 E.00936
; LINE_WIDTH: 0.578707
G1 F4479.395
G1 X102.139 Y122.582 E.01
; LINE_WIDTH: 0.61619
G1 F4186.509
G1 X102.189 Y122.481 E.00511
; LINE_WIDTH: 0.612624
G1 F4212.719
G1 X102.045 Y122.583 E.00798
; LINE_WIDTH: 0.56479
G1 F4598.847
G1 X101.9 Y122.686 E.00731
; LINE_WIDTH: 0.499539
G1 F5256.025
G1 X101.755 Y122.788 E.00639
G1 X101.431 Y123.135 E.01713
; LINE_WIDTH: 0.511808
G1 F5118.499
G1 X101.376 Y123.231 E.00409
; LINE_WIDTH: 0.549343
G1 F4739.126
G1 X101.322 Y123.327 E.00442
; LINE_WIDTH: 0.586878
G1 F4412.11
G1 X101.267 Y123.423 E.00475
; LINE_WIDTH: 0.624413
G1 F4127.31
G1 X101.212 Y123.519 E.00508
G1 X101.369 Y123.466 E.00761
; LINE_WIDTH: 0.586878
G1 F4412.11
G1 X101.526 Y123.413 E.00712
; LINE_WIDTH: 0.549343
G1 F4739.126
G1 X101.683 Y123.36 E.00663
; LINE_WIDTH: 0.505932
G1 F5183.452
G3 X101.913 Y123.287 I.835 J2.214 E.00882
G1 X102.189 Y122.481 F9000
; LINE_WIDTH: 0.63361
G1 F4063.045
G1 X102.391 Y122.307 E.0124
G1 X103.133 Y122.209 F9000
; LINE_WIDTH: 0.41578
G1 F6436.733
G1 X103.01 Y121.729 E.0146
G1 X102.721 Y121.92 E.01021
; LINE_WIDTH: 0.43727
G1 F6085.964
G1 X102.664 Y121.99 E.0028
; LINE_WIDTH: 0.48025
G1 F5487.847
G1 X102.607 Y122.06 E.00311
; LINE_WIDTH: 0.52323
G1 F4996.773
G1 X102.55 Y122.129 E.00341
; LINE_WIDTH: 0.56621
G1 F4586.367
G1 X102.493 Y122.199 E.00372
; LINE_WIDTH: 0.60919
G1 F4238.261
G1 X102.436 Y122.268 E.00402
G1 X102.544 Y122.257 E.00485
; LINE_WIDTH: 0.56621
G1 F4586.367
G1 X102.652 Y122.246 E.00448
; LINE_WIDTH: 0.52323
G1 F4996.773
G1 X102.759 Y122.235 E.00411
; LINE_WIDTH: 0.48025
G1 F5487.847
G1 X102.867 Y122.224 E.00374
; LINE_WIDTH: 0.427074
G1 F6247.492
G3 X103.073 Y122.211 I.188 J1.299 E.00626
; WIPE_START
G1 X102.867 Y122.224 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.68 Y123.198 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.120954
G1 F9000
G1 X105.828 Y122.976 E.00164
; WIPE_START
G1 X105.68 Y123.198 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.597 Y123.938 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.49447
G1 F5315.026
G1 X112.886 Y124.061 E.0112
G1 X113.214 Y123.975 E.01209
G1 X112.87 Y123.492 E.02115
; LINE_WIDTH: 0.518745
G1 F5043.871
G1 X112.744 Y123.377 E.00639
; LINE_WIDTH: 0.567295
G1 F4576.878
G1 X112.618 Y123.263 E.00704
; LINE_WIDTH: 0.615845
G1 F4189.03
G1 X112.493 Y123.149 E.00769
G1 X112.523 Y123.367 E.00997
; LINE_WIDTH: 0.567295
G1 F4576.878
G1 X112.554 Y123.585 E.00912
; LINE_WIDTH: 0.512522
G1 F5110.711
G3 X112.592 Y123.879 I-2.695 J.492 E.01099
G1 X112.336 Y122.962 F9000
; LINE_WIDTH: 0.63108
G1 F4080.523
G1 X112.454 Y123.103 E.00856
; WIPE_START
G1 X112.336 Y122.962 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.411 Y122.676 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.498205
G1 F5271.423
G1 X112.014 Y122.805 E.02216
; LINE_WIDTH: 0.522765
G1 F5001.615
G1 X112.121 Y122.857 E.00452
; LINE_WIDTH: 0.562475
G1 F4619.338
G1 X112.228 Y122.909 E.0049
; LINE_WIDTH: 0.602185
G1 F4291.347
G1 X112.336 Y122.962 E.00527
G1 X112.262 Y122.859 E.00559
; LINE_WIDTH: 0.562475
G1 F4619.338
G1 X112.188 Y122.756 E.00519
; LINE_WIDTH: 0.503506
G1 F5210.753
G1 X112.115 Y122.653 E.0046
G2 X111.435 Y122.086 I-3.473 J3.471 E.03224
; LINE_WIDTH: 0.53692
G1 F4858.299
G1 X111.332 Y122.039 E.00445
; LINE_WIDTH: 0.5794
G1 F4473.606
G1 X111.228 Y121.992 E.00483
; LINE_WIDTH: 0.62188
G1 F4145.364
G1 X111.124 Y121.945 E.00521
; LINE_WIDTH: 0.618184
G1 F4172.003
G1 X111.205 Y122.146 E.00985
; LINE_WIDTH: 0.56831
G1 F4568.036
G1 X111.285 Y122.347 E.009
; LINE_WIDTH: 0.511989
G1 F5116.523
G3 X111.391 Y122.62 I-3.067 J1.346 E.01084
G1 X111.103 Y123.049 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X111.676 Y123.135 E.01726
G1 X111.834 Y123.183 E.00493
G1 X112.076 Y123.401 E.00969
G1 X112.156 Y123.645 E.00765
G1 X112.206 Y124.223 E.01726
G1 X112.74 Y124.449 E.01727
G1 X112.833 Y124.505 E.00326
G3 X113.893 Y124.313 I1.146 J3.309 E.03219
G2 X110.694 Y121.115 I-6.89 J3.693 E.1367
G3 X110.506 Y122.157 I-3.538 J-.098 E.03165
G1 X110.778 Y122.29 E.00901
G1 X110.911 Y122.501 E.00745
G1 X111.083 Y122.992 E.01549
G1 X110.822 Y123.388 F9000
; LINE_WIDTH: 0.41999
G1 F6364.878
G1 X111.62 Y123.508 E.02402
G1 X111.753 Y123.596 E.00477
G1 X111.849 Y124.481 E.02652
G1 X112.593 Y124.796 E.02403
G1 X112.658 Y124.843 E.0024
G1 X112.695 Y124.967 E.00387
G1 X113.362 Y124.751 E.02088
G3 X114.514 Y124.733 I.634 J3.709 E.03446
G2 X110.276 Y120.502 I-7.445 J3.22 E.18271
G1 X110.317 Y121.112 E.01822
G3 X109.935 Y122.545 I-3.683 J-.216 E.04446
G1 X110.398 Y122.501 E.01384
G1 X110.545 Y122.603 E.00534
G1 X110.802 Y123.331 E.023
; WIPE_START
G1 X110.545 Y122.603 E-.29341
G1 X110.398 Y122.501 E-.06807
G1 X109.935 Y122.545 E-.17661
G1 X110.129 Y122.106 E-.18222
G1 X110.156 Y122.005 E-.03968
; WIPE_END
G1 E-.04 F1800
G1 X115.786 Y126.494 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970899
G1 F9000
G1 X115.81 Y126.516 E.00014
; LINE_WIDTH: 0.122851
G1 X115.922 Y126.633 E.00102
; LINE_WIDTH: 0.172364
G1 X116.035 Y126.749 E.00166
; LINE_WIDTH: 0.188867
G1 X116.047 Y126.781 E.00039
; LINE_WIDTH: 0.158055
G1 X116.088 Y126.916 E.00128
; LINE_WIDTH: 0.116753
G1 X116.125 Y127.041 E.00076
; WIPE_START
G1 X116.088 Y126.916 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.125 Y128.959 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.116746
G1 F9000
G1 X116.088 Y129.084 E.00076
; LINE_WIDTH: 0.158063
G1 X116.047 Y129.219 E.00128
; LINE_WIDTH: 0.188871
G1 X116.035 Y129.251 E.00039
; LINE_WIDTH: 0.172341
G1 X115.922 Y129.367 E.00166
; LINE_WIDTH: 0.122808
G1 X115.81 Y129.484 E.00102
; LINE_WIDTH: 0.0970694
G1 X115.786 Y129.506 E.00014
; WIPE_START
G1 X115.81 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X112.597 Y132.062 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.49447
G1 F5315.026
G1 X112.528 Y132.595 E.01917
; LINE_WIDTH: 0.516109
G1 F5071.976
G1 X112.48 Y132.726 E.00523
; LINE_WIDTH: 0.559385
G1 F4646.975
G1 X112.431 Y132.857 E.00571
; LINE_WIDTH: 0.602662
G1 F4287.692
G1 X112.383 Y132.989 E.00619
G1 X112.497 Y132.891 E.00662
; LINE_WIDTH: 0.559385
G1 F4646.975
G1 X112.611 Y132.794 E.00611
; LINE_WIDTH: 0.496531
G1 F5290.886
G1 X112.724 Y132.696 E.00537
G2 X113.214 Y132.025 I-6.868 J-5.521 E.02977
G1 X112.886 Y131.939 E.01214
G1 X112.652 Y132.038 E.0091
; WIPE_START
G1 X112.886 Y131.939 E-.12274
G1 X113.214 Y132.025 E-.16367
G1 X112.724 Y132.696 E-.40123
G1 X112.611 Y132.794 E-.07237
; WIPE_END
G1 E-.04 F1800
G1 X112.202 Y133.162 Z1.4 F9000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.63105
G1 F4080.731
G1 X112.34 Y133.03 E.00885
G1 X111.411 Y133.324 F9000
; LINE_WIDTH: 0.49351
G1 F5326.35
G1 X111.25 Y133.756 E.01643
G1 X110.994 Y134.057 E.01405
G1 X111.031 Y134.208 E.00552
G2 X111.876 Y133.568 I-3.618 J-5.659 E.03778
; LINE_WIDTH: 0.517559
G1 F5056.482
G1 X111.985 Y133.433 E.00651
; LINE_WIDTH: 0.565655
G1 F4591.236
G1 X112.094 Y133.298 E.00717
; LINE_WIDTH: 0.613752
G1 F4204.392
G1 X112.202 Y133.162 E.00783
G1 X112.012 Y133.205 E.00881
; LINE_WIDTH: 0.565655
G1 F4591.236
G1 X111.821 Y133.248 E.00807
; LINE_WIDTH: 0.506662
G1 F5175.295
G3 X111.47 Y133.315 I-.642 J-2.417 E.01309
G1 X111.103 Y132.951 F9000
; LINE_WIDTH: 0.41999
G1 F6364.873
G1 X110.911 Y133.498 E.01727
G1 X110.754 Y133.733 E.00839
G1 X110.506 Y133.843 E.00809
G3 X110.693 Y134.885 I-3.351 J1.14 E.03165
G2 X113.893 Y131.687 I-3.675 J-6.875 E.13671
G3 X112.833 Y131.495 I.102 J-3.586 E.03219
G1 X112.206 Y131.777 E.0205
G1 X112.156 Y132.355 E.01727
G1 X112.02 Y132.676 E.01037
G1 X111.834 Y132.817 E.00695
G1 X111.162 Y132.941 E.02037
G1 X110.822 Y132.612 F9000
; LINE_WIDTH: 0.41999
G1 F6364.875
G1 X110.555 Y133.374 E.02403
G1 X110.503 Y133.452 E.0028
G1 X110.358 Y133.499 E.00454
G1 X109.935 Y133.455 E.01267
G3 X110.273 Y135.51 I-3.036 J1.555 E.06303
G2 X114.508 Y131.268 I-3.282 J-7.512 E.18278
G1 X113.894 Y131.311 E.01833
G3 X112.695 Y131.033 I.203 J-3.601 E.03685
G1 X112.637 Y131.177 E.00463
G1 X111.849 Y131.519 E.02557
G1 X111.78 Y132.322 E.02403
G1 X111.701 Y132.459 E.00471
G1 X110.882 Y132.602 E.02479
; CHANGE_LAYER
; Z_HEIGHT: 1.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6364.875
G1 X111.701 Y132.459 E-.31625
G1 X111.78 Y132.322 E-.06006
G1 X111.849 Y131.519 E-.30652
G1 X112.036 Y131.438 E-.07716
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 118
M625
; layer num/total_layer_count: 6/23
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
M106 S165.75
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G17
G3 Z1.4 I.477 J1.12 P1  F9000
G1 X124.56 Y126.108 Z1.4
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X124.536 Y125.481 E.02016
G1 X125.139 Y125.311 E.02016
G1 X125.271 Y124.698 E.02016
G1 X125.898 Y124.684 E.02016
G1 X126.178 Y124.123 E.02015
G1 X126.788 Y124.264 E.02016
G1 X127.199 Y123.791 E.02016
G1 X127.756 Y124.08 E.02016
G1 X128.271 Y123.724 E.02016
G1 X128.738 Y124.142 E.02016
G1 X129.326 Y123.925 E.02016
G1 X129.675 Y124.446 E.02016
G1 X130.298 Y124.382 E.02016
M73 P56 R8
G1 X130.506 Y124.974 E.02016
G1 X131.126 Y125.067 E.02016
G1 X131.18 Y125.691 E.02016
G1 X131.757 Y125.936 E.02016
G1 X131.654 Y126.554 E.02016
G1 X132.153 Y126.934 E.02016
G1 X131.899 Y127.508 E.02016
G1 X132.287 Y128 E.02016
G1 X131.899 Y128.492 E.02016
G1 X132.153 Y129.066 E.02016
G1 X131.654 Y129.446 E.02016
G1 X131.757 Y130.064 E.02016
G1 X131.18 Y130.309 E.02016
G1 X131.126 Y130.933 E.02016
G1 X130.506 Y131.026 E.02016
G1 X130.298 Y131.618 E.02016
G1 X129.675 Y131.554 E.02016
G1 X129.326 Y132.075 E.02016
G1 X128.738 Y131.858 E.02016
G1 X128.271 Y132.277 E.02016
G1 X127.756 Y131.92 E.02016
G1 X127.199 Y132.209 E.02016
G1 X126.788 Y131.736 E.02016
G1 X126.178 Y131.877 E.02016
G1 X125.898 Y131.316 E.02016
G1 X125.271 Y131.302 E.02016
G1 X125.139 Y130.689 E.02016
G1 X124.536 Y130.519 E.02016
G1 X124.56 Y129.892 E.02016
G1 X124.018 Y129.577 E.02016
G1 X124.198 Y128.977 E.02016
G1 X123.751 Y128.537 E.02016
G1 X124.074 Y128 E.02016
G1 X123.751 Y127.463 E.02016
G1 X124.198 Y127.023 E.02016
G1 X124.018 Y126.423 E.02016
G1 X124.508 Y126.138 E.01823
G1 X124.977 Y126.337 F9000
G1 F5895.652
G1 X124.955 Y125.786 E.01772
G1 X125.485 Y125.636 E.01772
G1 X125.601 Y125.098 E.01772
G1 X126.152 Y125.085 E.01772
G1 X126.398 Y124.592 E.01772
G1 X126.935 Y124.716 E.01772
G1 X127.296 Y124.3 E.01772
G1 X127.785 Y124.554 E.01772
G1 X128.239 Y124.241 E.01772
G1 X128.649 Y124.608 E.01772
G1 X129.166 Y124.418 E.01772
G1 X129.472 Y124.876 E.01772
G1 X130.02 Y124.82 E.01772
G1 X130.203 Y125.34 E.01772
G1 X130.748 Y125.422 E.01772
G1 X130.796 Y125.971 E.01772
G1 X131.303 Y126.185 E.01772
G1 X131.213 Y126.729 E.01772
G1 X131.651 Y127.063 E.01772
G1 X131.428 Y127.567 E.01772
G1 X131.769 Y128 E.01772
G1 X131.428 Y128.433 E.01772
G1 X131.651 Y128.937 E.01772
G1 X131.213 Y129.271 E.01772
G1 X131.303 Y129.815 E.01772
G1 X130.796 Y130.029 E.01772
G1 X130.748 Y130.578 E.01772
G1 X130.203 Y130.66 E.01772
G1 X130.02 Y131.18 E.01772
G1 X129.472 Y131.124 E.01772
G1 X129.166 Y131.582 E.01772
G1 X128.649 Y131.392 E.01772
G1 X128.239 Y131.759 E.01772
G1 X127.785 Y131.446 E.01772
G1 X127.296 Y131.7 E.01772
G1 X126.935 Y131.284 E.01772
G1 X126.398 Y131.408 E.01772
G1 X126.152 Y130.915 E.01772
G1 X125.601 Y130.902 E.01772
G1 X125.485 Y130.364 E.01772
G1 X124.955 Y130.214 E.01772
G1 X124.977 Y129.663 E.01772
G1 X124.5 Y129.387 E.01772
G1 X124.658 Y128.859 E.01772
G1 X124.265 Y128.472 E.01772
G1 X124.55 Y128 E.01772
G1 X124.265 Y127.528 E.01772
G1 X124.658 Y127.141 E.01772
G1 X124.5 Y126.613 E.01772
G1 X124.925 Y126.367 E.01579
M204 S250
G1 X125.378 Y126.557 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X125.359 Y126.079 E.01424
G1 X125.819 Y125.95 E.01424
G1 X125.92 Y125.482 E.01424
G1 X126.397 Y125.471 E.01424
G1 X126.611 Y125.044 E.01424
G1 X127.077 Y125.151 E.01424
G1 X127.39 Y124.79 E.01424
G1 X127.814 Y125.011 E.01424
G1 X128.207 Y124.739 E.01424
G1 X128.563 Y125.058 E.01424
G1 X129.012 Y124.893 E.01424
G1 X129.277 Y125.29 E.01424
G1 X129.753 Y125.241 E.01424
G1 X129.911 Y125.692 E.01424
G1 X130.384 Y125.763 E.01424
G1 X130.425 Y126.24 E.01424
G1 X130.865 Y126.426 E.01424
G1 X130.787 Y126.897 E.01424
G1 X131.167 Y127.187 E.01424
G1 X130.974 Y127.625 E.01424
G1 X131.27 Y128 E.01424
G1 X130.974 Y128.375 E.01424
G1 X131.167 Y128.813 E.01424
G1 X130.787 Y129.103 E.01424
G1 X130.865 Y129.574 E.01424
G1 X130.425 Y129.76 E.01424
G1 X130.384 Y130.237 E.01424
G1 X129.911 Y130.308 E.01424
G1 X129.753 Y130.759 E.01424
G1 X129.277 Y130.71 E.01424
G1 X129.012 Y131.107 E.01424
G1 X128.563 Y130.942 E.01424
G1 X128.207 Y131.261 E.01424
G1 X127.814 Y130.989 E.01424
G1 X127.39 Y131.21 E.01424
G1 X127.077 Y130.849 E.01424
G1 X126.611 Y130.956 E.01424
G1 X126.397 Y130.529 E.01424
G1 X125.92 Y130.518 E.01424
G1 X125.819 Y130.05 E.01424
G1 X125.359 Y129.921 E.01424
G1 X125.378 Y129.443 E.01424
G1 X124.964 Y129.203 E.01424
G1 X125.101 Y128.745 E.01424
G1 X124.761 Y128.41 E.01424
G1 X125.007 Y128 E.01424
G1 X124.761 Y127.59 E.01424
G1 X125.101 Y127.255 E.01424
G1 X124.964 Y126.797 E.01424
G1 X125.326 Y126.587 E.01245
; WIPE_START
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18163
G1 X125.92 Y125.482 E-.18164
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02174
; WIPE_END
G1 E-.04 F1800
G1 X125.323 Y119.847 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X125.186 Y120.226 E.01296
G2 X125.111 Y121.345 I3.024 J.766 E.03627
G2 X126.702 Y123.614 I2.916 J-.352 E.09279
G1 X126.624 Y123.808 E.00673
G1 X125.957 Y123.654 E.022
G1 X125.643 Y124.282 E.02259
G1 X124.941 Y124.299 E.02259
G1 X124.793 Y124.986 E.02259
G1 X124.116 Y125.177 E.0226
G1 X124.144 Y125.879 E.0226
G1 X123.389 Y126.317 E.02808
G2 X119.852 Y125.319 I-2.393 J1.713 E.12764
G3 X125.266 Y119.866 I8.165 J2.691 E.25617
; WIPE_START
G1 X125.186 Y120.226 E-.14025
G1 X125.101 Y120.665 E-.1699
G1 X125.084 Y121.112 E-.16982
G1 X125.111 Y121.345 E-.08942
G1 X125.111 Y121.345 E0
G1 X125.135 Y121.556 E-.08059
G1 X125.212 Y121.835 E-.11002
; WIPE_END
G1 E-.04 F1800
G1 X130.677 Y119.833 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
G1 F5895.652
G1 X131.376 Y120.108 E.02412
G3 X136.161 Y125.322 I-3.404 J7.927 E.23451
G2 X132.428 Y126.632 I-1.151 J2.694 E.13966
G1 X132.096 Y126.379 E.01342
G1 X132.211 Y125.686 E.0226
G1 X131.564 Y125.412 E.0226
G1 X131.504 Y124.712 E.02259
G1 X130.809 Y124.607 E.0226
G1 X130.576 Y123.944 E.0226
G1 X129.877 Y124.016 E.0226
G1 X129.522 Y123.484 E.02057
G1 X129.682 Y123.389 E.00601
G2 X130.896 Y121.323 I-1.66 J-2.365 E.07945
G2 X130.701 Y119.888 I-2.761 J-.355 E.04708
; WIPE_START
G1 X131.376 Y120.108 E-.26951
G1 X131.842 Y120.324 E-.19533
G1 X132.294 Y120.567 E-.19492
G1 X132.518 Y120.705 E-.10024
; WIPE_END
G1 E-.04 F1800
G1 X135.137 Y127.874 Z1.6 F9000
G1 X136.161 Y130.678 Z1.6
G1 Z1.2
G1 E.8 F1800
G1 F5895.652
G3 X130.677 Y136.167 I-8.236 J-2.744 E.25865
G2 X129.522 Y132.516 I-2.655 J-1.168 E.13449
G1 X129.877 Y131.984 E.02057
G1 X130.576 Y132.056 E.02259
G1 X130.809 Y131.393 E.0226
G1 X131.504 Y131.288 E.0226
G1 X131.564 Y130.588 E.0226
G1 X132.211 Y130.314 E.0226
G1 X132.096 Y129.621 E.0226
G1 X132.428 Y129.368 E.01342
G1 X132.614 Y129.68 E.01169
G2 X136.105 Y130.701 I2.395 J-1.712 E.1261
; WIPE_START
G1 X135.944 Y131.255 E-.21944
G1 X135.736 Y131.724 E-.19495
G1 X135.499 Y132.18 E-.19537
G1 X135.296 Y132.52 E-.15024
; WIPE_END
G1 E-.04 F1800
G1 X127.669 Y132.231 Z1.6 F9000
G1 X126.623 Y132.192 Z1.6
G1 Z1.2
G1 E.8 F1800
G1 F5895.652
G1 X126.701 Y132.386 E.00673
G2 X125.323 Y136.153 I1.297 J2.611 E.14228
G3 X119.852 Y130.681 I2.693 J-8.162 E.2581
G2 X123.389 Y129.683 I1.144 J-2.711 E.12764
G1 X124.144 Y130.121 E.02808
G1 X124.116 Y130.823 E.0226
G1 X124.793 Y131.014 E.0226
G1 X124.941 Y131.701 E.02259
G1 X125.643 Y131.718 E.0226
G1 X125.957 Y132.346 E.0226
G1 X126.565 Y132.205 E.02006
; WIPE_START
G1 X126.701 Y132.386 E-.08599
G1 X126.322 Y132.611 E-.16768
G1 X125.977 Y132.896 E-.16995
G1 X125.68 Y133.23 E-.16983
G1 X125.441 Y133.597 E-.16655
; WIPE_END
G1 E-.04 F1800
G1 X127.735 Y126.318 Z1.6 F9000
G1 X129.919 Y119.383 Z1.6
G1 Z1.2
G1 E.8 F1800
G1 F5895.652
G1 X130.016 Y119.238 E.0056
G3 X136.822 Y126.238 I-2.037 J8.79 E.33173
G1 X136.368 Y125.891 E.01838
G1 X136.189 Y125.794 E.00656
G2 X136.368 Y130.109 I-1.186 J2.21 E.33957
G1 X136.822 Y129.762 E.01838
G3 X130.016 Y136.762 I-8.843 J-1.79 E.33173
G1 X129.919 Y136.617 E.0056
G2 X125.894 Y136.366 I-1.92 J-1.614 E.35608
G1 X126.236 Y136.814 E.01815
G3 X119.191 Y129.769 I1.776 J-8.82 E.33953
G1 X119.637 Y130.109 E.01802
G2 X119.637 Y125.891 I1.361 J-2.109 E.34601
G1 X119.191 Y126.231 E.01802
G3 X126.236 Y119.186 I8.805 J1.759 E.33963
G1 X125.894 Y119.634 E.01814
G1 X125.796 Y119.814 E.00656
G2 X125.515 Y121.299 I2.207 J1.187 E.04938
G2 X128.033 Y123.51 I2.495 J-.303 E.11792
G1 X128.292 Y123.49 E.00836
G2 X128.76 Y123.395 I-.072 J-1.561 E.01542
G2 X130.492 Y121.276 I-.753 J-2.382 E.09313
G2 X129.958 Y119.429 I-2.423 J-.3 E.06353
G1 X129.552 Y119.58 F9000
G1 F5895.652
G1 X129.574 Y119.6 E.00095
G3 X125.92 Y121.252 I-1.569 J1.397 E.25315
G3 X127.841 Y118.902 I2.093 J-.249 E.10897
G3 X129.341 Y119.376 I.164 J2.094 E.05185
G1 X129.509 Y119.538 E.00748
M204 S250
G1 X129.279 Y119.862 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X127.871 Y119.294 I-1.276 J1.135 E.27283
G3 X128.506 Y119.37 I.103 J1.83 E.01914
G1 X128.642 Y119.413 E.00424
G3 X129.238 Y119.818 I-.639 J1.584 E.02164
; WIPE_START
G1 X129.438 Y120.07 E-.1222
M73 P57 R8
G1 X129.563 Y120.3 E-.09952
G1 X129.652 Y120.547 E-.09954
G1 X129.702 Y120.804 E-.09951
G1 X129.712 Y121.065 E-.09949
G1 X129.682 Y121.326 E-.09955
G1 X129.612 Y121.578 E-.09951
G1 X129.568 Y121.676 E-.04069
; WIPE_END
G1 E-.04 F1800
G1 X135.796 Y126.088 Z1.6 F9000
G1 X136.646 Y126.69 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X136.808 Y126.926 E.00921
G3 X133.052 Y127.226 I-1.804 J1.076 E.2741
G3 X134.75 Y125.917 I1.922 J.737 E.07251
G3 X136.607 Y126.645 I.254 J2.085 E.06681
M204 S250
G1 X136.325 Y126.916 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X136.398 Y127.004 E.00341
G3 X134.795 Y126.307 I-1.387 J.997 E.26504
G3 X135.702 Y126.439 I.223 J1.649 E.02765
G3 X136.29 Y126.869 I-.691 J1.562 E.02187
; WIPE_START
G1 X136.398 Y127.004 E-.06569
G1 X136.473 Y127.126 E-.05428
G1 X136.589 Y127.361 E-.0995
G1 X136.668 Y127.61 E-.09953
G1 X136.708 Y127.869 E-.09953
G1 X136.708 Y128.131 E-.0995
G1 X136.668 Y128.39 E-.09954
G1 X136.589 Y128.639 E-.09952
G1 X136.539 Y128.741 E-.04291
; WIPE_END
G1 E-.04 F1800
G1 X131.291 Y134.283 Z1.6 F9000
G1 X128.754 Y136.962 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X128.648 Y137.004 E.00363
G3 X127.83 Y132.909 I-.639 J-2.001 E.22735
G3 X129.461 Y133.484 I.186 J2.074 E.05734
G3 X128.811 Y136.944 I-1.452 J1.518 E.13424
M204 S250
G1 X128.635 Y136.589 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X128.53 Y136.629 E.00336
G3 X127.86 Y133.3 I-.519 J-1.628 E.17103
G3 X128.761 Y133.467 I.159 J1.657 E.02765
G3 X128.691 Y136.569 I-.75 J1.535 E.1159
; WIPE_START
G1 X128.53 Y136.629 E-.06543
G1 X128.392 Y136.666 E-.05419
G1 X128.133 Y136.706 E-.09953
G1 X127.871 Y136.706 E-.0995
G1 X127.612 Y136.666 E-.09953
G1 X127.363 Y136.587 E-.09952
G1 X127.128 Y136.47 E-.09949
G1 X126.914 Y136.32 E-.09952
G1 X126.832 Y136.241 E-.04328
; WIPE_END
G1 E-.04 F1800
G1 X123.443 Y129.402 Z1.6 F9000
G1 X123.025 Y128.56 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X123.011 Y128.636 E.00247
G3 X120.91 Y125.904 I-2.002 J-.634 E.29431
G3 X122.518 Y126.541 I.084 J2.135 E.05725
G3 X123.085 Y128.322 I-1.509 J1.461 E.06227
G1 X123.04 Y128.502 E.00598
M204 S250
G1 X122.644 Y128.471 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X122.64 Y128.518 E.00141
G3 X120.925 Y126.296 I-1.628 J-.516 E.2216
G3 X121.819 Y126.497 I.096 J1.661 E.02765
G3 X122.7 Y128.262 I-.808 J1.505 E.06263
G1 X122.659 Y128.413 E.00465
; WIPE_START
G1 X122.64 Y128.518 E-.04065
G1 X122.535 Y128.759 E-.09976
G1 X122.401 Y128.984 E-.09952
G1 X122.235 Y129.186 E-.09952
G1 X122.039 Y129.36 E-.09952
G1 X121.819 Y129.503 E-.09953
G1 X121.58 Y129.61 E-.0995
G1 X121.328 Y129.679 E-.09952
G1 X121.269 Y129.686 E-.02248
; WIPE_END
G1 E-.04 F1800
G1 X124.924 Y122.986 Z1.6 F9000
G1 X127.3 Y118.631 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G3 X128.173 Y118.608 I.684 J9.326 E.02807
G3 X124.052 Y119.473 I-.18 J9.394 E1.76172
G3 X127.24 Y118.636 I3.932 J8.484 E.10657
M204 S250
G1 X127.271 Y118.237 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X127.856 Y118.215 E.01743
G3 X128.179 Y118.216 I.145 J9.786 E.00961
G3 X137.174 Y124.59 I-.177 J9.784 E.34884
G3 X127.215 Y118.246 I-9.173 J3.412 E1.45424
; WIPE_START
G1 X127.856 Y118.215 E-.24364
G1 X128.179 Y118.216 E-.1226
G1 X129.026 Y118.264 E-.32239
G1 X129.212 Y118.289 E-.07137
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.6 I1.217 J0 P1  F9000
; stop printing object, unique label id: 82
M625
; object ids of layer 6 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.6
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z1.6 F4000
            G39.3 S1
            G0 Z1.6 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END


; object ids of this layer6 end: 82,118
M625
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X129.091 Y118.874 F9000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.353121
G1 F7736.924
G1 X129.793 Y119.206 E.01903
G1 X129.818 Y119.168 F9000
; LINE_WIDTH: 0.177556
G1 X129.211 Y118.957 E.00683
; LINE_WIDTH: 0.155821
G1 X129.082 Y118.917 E.0012
; LINE_WIDTH: 0.116549
G1 X128.953 Y118.878 E.00078
; WIPE_START
G1 X129.082 Y118.917 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.042 Y118.883 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.117481
G1 F9000
G1 X126.917 Y118.919 E.00077
; LINE_WIDTH: 0.1612
G1 X126.778 Y118.96 E.00136
; LINE_WIDTH: 0.192069
G1 X126.754 Y118.97 E.00031
; LINE_WIDTH: 0.172937
G1 X126.636 Y119.083 E.00168
; LINE_WIDTH: 0.123026
G1 X126.518 Y119.197 E.00103
; LINE_WIDTH: 0.0970809
G1 X126.496 Y119.221 E.00014
; WIPE_START
G1 X126.518 Y119.197 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.043 Y123.533 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.163246
G1 F9000
G1 X126.948 Y123.69 E.00174
; LINE_WIDTH: 0.119031
G1 X126.852 Y123.846 E.0011
G1 X127.49 Y123.686
; LINE_WIDTH: 0.112263
G2 X127.811 Y123.794 I1.532 J-4.001 E.00186
G1 X128.651 Y123.79
; LINE_WIDTH: 0.332804
G1 F8279.187
G2 X129.321 Y123.55 I-1.286 J-4.642 E.01631
G1 X129.829 Y123.578 F9000
; LINE_WIDTH: 0.103372
G1 X129.934 Y123.477 E.00069
; WIPE_START
G1 X129.829 Y123.578 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X132.397 Y122.981 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.413235
G1 F6480.969
G1 X132.635 Y123.176 E.009
; LINE_WIDTH: 0.35802
G1 F7616.644
G3 X133.046 Y123.574 I-.897 J1.338 E.01431
; WIPE_START
G1 X132.873 Y123.371 E-.35245
G1 X132.635 Y123.176 E-.40755
; WIPE_END
G1 E-.04 F1800
G1 X131.941 Y123.239 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X132.238 Y123.333 E.00928
G1 X132.633 Y123.608 E.01435
G3 X132.955 Y124.058 I-1.895 J1.698 E.0165
G1 X133.652 Y123.772 E.02245
G2 X132.234 Y122.355 I-6.311 J4.901 E.05985
G3 X131.896 Y123.14 I-6.835 J-2.484 E.02546
G1 X131.916 Y123.185 E.00147
G1 X131.662 Y123.577 F9000
G1 F6364.866
G1 X132.082 Y123.676 E.01287
G1 X132.403 Y123.914 E.0119
G1 X132.567 Y124.183 E.0094
G1 X132.626 Y124.42 E.00727
G1 X132.815 Y124.452 E.00568
G1 X133.124 Y124.395 E.00937
G3 X134.267 Y123.998 I1.95 J3.774 E.03617
G2 X132 Y121.733 I-6.302 J4.04 E.0962
G1 X131.866 Y122.254 E.01604
G1 X131.607 Y122.878 E.02013
G1 X131.435 Y123.164 E.00994
G3 X131.641 Y123.52 I-.433 J.488 E.01246
G1 X131.381 Y123.916 F9000
G1 F6364.866
G1 X131.926 Y124.019 E.01653
G1 X132.119 Y124.162 E.00714
G1 X132.243 Y124.404 E.0081
G1 X132.286 Y124.834 E.01286
G1 X132.53 Y124.784 E.0074
G1 X132.733 Y124.853 E.00641
G1 X133.061 Y124.819 E.00981
G1 X133.097 Y124.853 E.00145
G1 X133.681 Y124.559 E.01948
G1 X134.258 Y124.387 E.01793
G3 X134.888 Y124.313 I.984 J5.655 E.01892
G2 X133.054 Y122.039 I-7.221 J3.947 E.08748
G1 X132.323 Y121.49 E.02723
G2 X131.689 Y121.115 I-4.42 J6.736 E.02196
G3 X131.263 Y122.724 I-4.121 J-.229 E.04993
G1 X130.962 Y123.202 E.01682
G1 X131.248 Y123.538 E.01317
G1 X131.361 Y123.859 E.01013
G1 X131.101 Y124.255 F9000
G1 F6364.866
G1 X131.721 Y124.348 E.01868
G1 X131.85 Y124.431 E.00458
G3 X131.935 Y125.143 I-8.733 J1.396 E.02136
G1 X132.258 Y125.269 E.01035
G1 X132.33 Y125.183 E.00333
G1 X132.504 Y125.167 E.00523
G1 X132.696 Y125.246 E.00618
G1 X133.008 Y125.193 E.00942
G1 X133.118 Y125.296 E.00449
G1 X133.432 Y125.083 E.01131
G3 X135.51 Y124.733 I1.581 J3.041 E.06378
G2 X131.271 Y120.502 I-7.541 J3.316 E.18257
G1 X131.313 Y121.112 E.01822
G3 X130.335 Y123.329 I-3.236 J-.104 E.07396
G1 X130.425 Y123.434 E.00414
G1 X130.403 Y123.568 E.00405
G1 X130.799 Y123.557 E.0118
G1 X130.893 Y123.663 E.00423
G1 X131.081 Y124.198 E.01689
; WIPE_START
G1 X130.893 Y123.663 E-.2155
G1 X130.799 Y123.557 E-.05396
G1 X130.403 Y123.568 E-.1505
G1 X130.425 Y123.434 E-.05161
G1 X130.335 Y123.329 E-.05276
G1 X130.645 Y122.997 E-.17275
G1 X130.735 Y122.857 E-.06292
; WIPE_END
G1 E-.04 F1800
G1 X132.394 Y125.827 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.233205
G1 F9000
M73 P58 R8
G1 X132.847 Y125.734 E.00694
G1 X132.616 Y125.637
; LINE_WIDTH: 0.157639
G2 X132.345 Y126.313 I8.451 J3.787 E.00661
G1 X132.455 Y126.909
; LINE_WIDTH: 0.173585
G2 X132.347 Y127.165 I3.348 J1.559 E.00287
; LINE_WIDTH: 0.192554
G1 X132.278 Y127.369 E.00255
; LINE_WIDTH: 0.221839
G1 X132.21 Y127.573 E.00304
G1 X132.21 Y128.426
; LINE_WIDTH: 0.221841
G1 X132.278 Y128.631 E.00304
; LINE_WIDTH: 0.192551
G1 X132.347 Y128.835 E.00255
; LINE_WIDTH: 0.173583
G2 X132.455 Y129.091 I3.37 J-1.267 E.00287
G1 X132.345 Y129.687
; LINE_WIDTH: 0.157629
G2 X132.616 Y130.364 I9.04 J-3.227 E.00661
G1 X132.847 Y130.266
; LINE_WIDTH: 0.233225
G1 X132.394 Y130.173 E.00694
; WIPE_START
G1 X132.847 Y130.266 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X132.397 Y133.019 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42455
G1 F6288.814
G1 X132.459 Y132.975 E.00229
; LINE_WIDTH: 0.39909
G1 F6738.356
G1 X132.521 Y132.931 E.00214
G1 X131.941 Y132.761 F9000
; LINE_WIDTH: 0.424386
G1 F6291.53
G1 X131.895 Y132.86 E.0033
G3 X132.234 Y133.645 I-4.254 J2.299 E.02578
G2 X132.895 Y133.055 I-1.934 J-2.829 E.02678
; LINE_WIDTH: 0.485427
G1 F5423.647
G1 X133.025 Y132.888 E.00738
; LINE_WIDTH: 0.52236
G1 F5005.84
G1 X133.156 Y132.722 E.008
; LINE_WIDTH: 0.574311
G1 F4516.453
G3 X133.521 Y132.27 I12.471 J9.671 E.02441
G1 X132.967 Y132.034 E.02524
G1 X132.732 Y132.395 E.01807
; LINE_WIDTH: 0.5507
G1 F4726.456
G1 X132.637 Y132.453 E.00447
; LINE_WIDTH: 0.51204
G1 F5115.961
G1 X132.542 Y132.511 E.00413
; LINE_WIDTH: 0.47338
G1 F5575.431
G1 X132.447 Y132.569 E.00379
; LINE_WIDTH: 0.43702
G1 F6089.825
G1 X131.997 Y132.739 E.01498
G1 X131.662 Y132.423 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X131.532 Y132.745 E.01032
G1 X131.435 Y132.836 E.00395
G3 X132 Y134.267 I-3.861 J2.352 E.04607
G2 X134.267 Y132.002 I-4.061 J-6.331 E.09619
G3 X133.124 Y131.605 I.806 J-4.169 E.03617
G1 X132.768 Y131.539 E.01077
G1 X132.627 Y131.579 E.00439
G1 X132.563 Y131.828 E.00763
G1 X132.364 Y132.127 E.01071
G1 X132.082 Y132.324 E.01025
G1 X131.72 Y132.41 E.01108
G1 X131.381 Y132.084 F9000
; LINE_WIDTH: 0.41999
G1 F6364.875
G1 X131.205 Y132.557 E.01501
G1 X130.962 Y132.798 E.01021
G3 X131.689 Y134.885 I-3.204 J2.286 E.06672
G2 X134.888 Y131.687 I-3.691 J-6.891 E.1367
G3 X133.097 Y131.147 I.102 J-3.584 E.05638
G1 X132.965 Y131.186 E.00408
G1 X132.733 Y131.147 E.00703
G1 X132.529 Y131.216 E.0064
G1 X132.286 Y131.166 E.00739
G1 X132.217 Y131.676 E.01533
G1 X132.096 Y131.862 E.00663
G1 X131.85 Y132.009 E.00851
G1 X131.44 Y132.075 E.01236
G1 X131.101 Y131.745 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X130.893 Y132.337 E.01868
G1 X130.766 Y132.456 E.00517
G1 X130.403 Y132.432 E.01086
G1 X130.425 Y132.566 E.00404
G1 X130.334 Y132.671 E.00413
G1 X130.645 Y133.003 E.01355
G3 X131.269 Y135.51 I-2.622 J1.983 E.07906
G2 X135.504 Y131.268 I-3.282 J-7.512 E.18278
G1 X134.89 Y131.311 E.01833
G3 X133.118 Y130.704 I.098 J-3.176 E.05663
G1 X132.976 Y130.809 E.00526
G1 X132.696 Y130.754 E.00849
G1 X132.464 Y130.845 E.00742
G3 X132.245 Y130.726 I-.028 J-.21 E.00794
G1 X131.935 Y130.857 E.01004
G1 X131.88 Y131.482 E.01868
G1 X131.799 Y131.621 E.00481
G1 X131.16 Y131.735 E.01934
; WIPE_START
G1 X131.799 Y131.621 E-.24677
G1 X131.88 Y131.482 E-.06136
G1 X131.935 Y130.857 E-.23829
G1 X132.245 Y130.726 E-.12811
G1 X132.328 Y130.817 E-.04704
G1 X132.428 Y130.837 E-.03844
; WIPE_END
G1 E-.04 F1800
G1 X129.933 Y132.522 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.10334
G1 F9000
G1 X129.829 Y132.422 E.00069
G1 X129.321 Y132.45
; LINE_WIDTH: 0.332795
G1 F8279.447
G2 X128.651 Y132.21 I-1.954 J4.398 E.01631
G1 X127.81 Y132.205 F9000
; LINE_WIDTH: 0.11225
G2 X127.49 Y132.314 I1.278 J4.291 E.00185
G1 X127.043 Y132.467
; LINE_WIDTH: 0.163406
G1 X126.947 Y132.31 E.00175
; LINE_WIDTH: 0.119084
G1 X126.852 Y132.153 E.0011
; WIPE_START
G1 X126.947 Y132.31 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X123.743 Y130.342 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X123.48 Y130.189 E.00906
G1 X123.022 Y130.626 E.01885
G3 X120.493 Y131.267 I-2.006 J-2.604 E.07991
G2 X124.735 Y135.507 I7.531 J-3.291 E.18289
G1 X124.692 Y134.888 E.01851
G3 X125.675 Y132.667 I3.235 J.104 E.07416
G1 X125.398 Y132.104 E.01868
G1 X124.771 Y132.089 E.01868
G1 X124.632 Y132.024 E.00456
G1 X124.459 Y131.327 E.02137
G1 X123.855 Y131.157 E.01868
G1 X123.759 Y131.093 E.00345
G1 X123.719 Y130.955 E.00429
G1 X123.74 Y130.402 E.01649
; WIPE_START
G1 X123.719 Y130.955 E-.21034
G1 X123.759 Y131.093 E-.05479
G1 X123.855 Y131.157 E-.04397
G1 X124.459 Y131.327 E-.2383
G1 X124.594 Y131.87 E-.2126
; WIPE_END
G1 E-.04 F1800
G1 X124.138 Y131.629 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
G1 F6364.866
G1 X123.595 Y131.448 E.01704
G1 X123.464 Y131.328 E.00531
G1 X123.341 Y130.953 E.01173
G1 X123.346 Y130.842 E.00332
G1 X122.802 Y131.22 E.01971
G3 X121.116 Y131.687 I-1.8 J-3.219 E.05263
G2 X124.248 Y134.851 I6.933 J-3.731 E.13444
G1 X124.314 Y134.872 E.00208
G3 X125.223 Y132.597 I3.631 J.131 E.07442
G1 X125.162 Y132.476 E.00404
G1 X124.762 Y132.466 E.01192
G1 X124.472 Y132.378 E.00903
G1 X124.272 Y132.158 E.00885
G1 X124.153 Y131.687 E.01448
G1 X123.817 Y131.93 F9000
G1 F6364.866
G1 X123.387 Y131.762 E.01375
G1 X123.169 Y131.563 E.00881
G1 X123.127 Y131.459 E.00334
G3 X121.736 Y131.998 I-2.248 J-3.734 E.04467
G2 X123.011 Y133.511 I6.551 J-4.225 E.0591
G2 X124.004 Y134.267 I5.275 J-5.901 E.03722
G3 X124.588 Y132.806 I4.422 J.921 E.0471
G1 X124.269 Y132.696 E.01005
G1 X124.061 Y132.515 E.00823
G1 X123.878 Y132.189 E.01115
G1 X123.831 Y131.988 E.00613
G1 X123.499 Y132.229 F9000
G1 F6364.866
G1 X123.179 Y132.077 E.01053
G1 X123.023 Y131.954 E.00592
G1 X122.353 Y132.228 E.02157
G1 X122.678 Y132.634 E.01549
G1 X123.271 Y133.239 E.02524
G2 X123.774 Y133.649 I4.834 J-5.414 E.01933
G1 X124.041 Y132.994 E.02107
G1 X123.775 Y132.761 E.01054
G1 X123.55 Y132.39 E.01292
G1 X123.517 Y132.286 E.00324
G1 X123.163 Y132.545 F9000
; LINE_WIDTH: 0.476577
G1 F5534.332
G1 X123.279 Y132.693 E.00644
; LINE_WIDTH: 0.43021
G1 F6196.907
G1 X123.395 Y132.84 E.00575
; LINE_WIDTH: 0.383844
G1 F7039.707
G1 X123.511 Y132.988 E.00506
; LINE_WIDTH: 0.35205
G1 F7763.724
G1 X123.581 Y133.054 E.00234
; WIPE_START
G1 X123.511 Y132.988 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.496 Y136.779 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970879
G1 F9000
G1 X126.518 Y136.803 E.00014
; LINE_WIDTH: 0.123027
G1 X126.636 Y136.917 E.00103
; LINE_WIDTH: 0.172933
G1 X126.754 Y137.03 E.00168
; LINE_WIDTH: 0.192081
G1 X126.778 Y137.04 E.00031
; LINE_WIDTH: 0.161195
G1 X126.917 Y137.081 E.00136
; LINE_WIDTH: 0.11748
G1 X127.042 Y137.117 E.00077
; WIPE_START
G1 X126.917 Y137.081 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128.953 Y137.122 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.116547
G1 F9000
G1 X129.082 Y137.083 E.00078
; LINE_WIDTH: 0.155813
G1 X129.211 Y137.043 E.0012
; LINE_WIDTH: 0.177556
G1 X129.818 Y136.832 E.00683
G1 X129.793 Y136.794
; LINE_WIDTH: 0.353121
G1 F7736.922
G1 X129.091 Y137.126 E.01903
; WIPE_START
G1 X129.793 Y136.794 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X125.414 Y130.542 Z1.6 F9000
G1 X123.731 Y128.14 Z1.6
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.151087
G1 F9000
G2 X123.731 Y127.86 I-.216 J-.14 E.00254
; WIPE_START
G1 X123.773 Y128 E-.37998
G1 X123.731 Y128.14 E-.38002
; WIPE_END
G1 E-.04 F1800
G1 X123.743 Y125.658 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X123.718 Y125.032 E.01868
G1 X123.779 Y124.886 E.0047
G1 X124.459 Y124.673 E.02123
G1 X124.591 Y124.06 E.01868
G1 X124.674 Y123.94 E.00433
G1 X125.398 Y123.896 E.02159
G1 X125.675 Y123.333 E.01868
G1 X125.301 Y122.907 E.01687
G3 X124.735 Y120.493 I2.615 J-1.887 E.07583
G2 X120.507 Y124.731 I3.269 J7.49 E.18257
G1 X121.035 Y124.692 E.01578
G1 X121.619 Y124.745 E.01745
G3 X123.48 Y125.811 I-.682 J3.349 E.06498
G1 X123.691 Y125.689 E.00728
; WIPE_START
G1 X123.48 Y125.811 E-.09286
G1 X123.379 Y125.693 E-.05915
G1 X122.999 Y125.357 E-.19267
G1 X122.572 Y125.083 E-.19274
G1 X122.108 Y124.878 E-.1927
G1 X122.032 Y124.857 E-.02989
; WIPE_END
G1 E-.04 F1800
G1 X124.138 Y124.371 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
G1 F6364.866
G1 X124.272 Y123.842 E.01627
G1 X124.472 Y123.622 E.00885
G1 X124.762 Y123.534 E.00904
G1 X125.162 Y123.524 E.01192
G1 X125.223 Y123.403 E.00404
G3 X124.318 Y121.184 I2.771 J-2.423 E.07269
G1 X124.299 Y121.119 E.00201
G2 X121.116 Y124.313 I3.76 J6.932 E.13622
G3 X123.346 Y125.158 I-.176 J3.829 E.07223
G1 X123.343 Y124.973 E.00552
G1 X123.523 Y124.609 E.01209
G3 X124.08 Y124.388 I.74 J1.052 E.01803
G1 X123.817 Y124.07 F9000
G1 F6364.866
G1 X123.936 Y123.67 E.01243
G1 X124.121 Y123.42 E.00926
G1 X124.397 Y123.236 E.00988
G1 X124.588 Y123.194 E.00584
G1 X124.278 Y122.612 E.01963
G3 X124.004 Y121.733 I4.57 J-1.904 E.02748
G2 X121.736 Y124.002 I4.028 J6.294 E.09633
G3 X123.127 Y124.541 I-.955 J4.527 E.04464
G1 X123.267 Y124.332 E.00751
G1 X123.563 Y124.147 E.01039
G1 X123.76 Y124.087 E.00613
G1 X123.499 Y123.771 F9000
G1 F6364.866
G1 X123.6 Y123.498 E.00866
G1 X123.86 Y123.149 E.01296
G1 X124.041 Y123.006 E.00688
G3 X123.774 Y122.351 I2.797 J-1.523 E.02111
G2 X122.353 Y123.772 I4.3 J5.724 E.06005
G1 X123.023 Y124.046 E.02157
G1 X123.341 Y123.832 E.01142
G1 X123.443 Y123.792 E.00324
G1 X123.163 Y123.455 F9000
; LINE_WIDTH: 0.476584
G1 F5534.247
G1 X123.279 Y123.307 E.00644
; LINE_WIDTH: 0.43023
G1 F6196.587
G1 X123.395 Y123.16 E.00575
; LINE_WIDTH: 0.383877
G1 F7039.018
G1 X123.511 Y123.012 E.00506
; LINE_WIDTH: 0.35208
G1 F7762.971
G1 X123.581 Y122.946 E.00235
; WIPE_START
G1 X123.511 Y123.012 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.223 Y126.494 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970827
G1 F9000
G1 X119.199 Y126.516 E.00014
; LINE_WIDTH: 0.12274
G1 X119.087 Y126.632 E.00102
; LINE_WIDTH: 0.175226
G1 X118.975 Y126.749 E.00169
G1 X118.958 Y126.791 E.00047
; LINE_WIDTH: 0.157757
G1 X118.922 Y126.908 E.00111
; LINE_WIDTH: 0.117867
G1 X118.883 Y127.044 E.00083
; WIPE_START
G1 X118.922 Y126.908 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.883 Y128.956 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.117871
G1 F9000
G1 X118.922 Y129.092 E.00083
; LINE_WIDTH: 0.157766
G1 X118.958 Y129.209 E.00111
; LINE_WIDTH: 0.175241
G1 X118.975 Y129.251 E.00047
G1 X119.087 Y129.368 E.00169
; LINE_WIDTH: 0.122742
G1 X119.199 Y129.484 E.00102
; LINE_WIDTH: 0.0970891
G1 X119.223 Y129.506 E.00014
; WIPE_START
G1 X119.199 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.832 Y129.494 Z1.6 F9000
G1 X136.781 Y129.506 Z1.6
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.0970978
G1 F9000
G1 X136.805 Y129.484 E.00014
; LINE_WIDTH: 0.122861
G1 X136.918 Y129.367 E.00102
; LINE_WIDTH: 0.172377
G1 X137.03 Y129.251 E.00166
; LINE_WIDTH: 0.188901
G1 X137.042 Y129.219 E.00039
; LINE_WIDTH: 0.158079
G1 X137.083 Y129.084 E.00129
; LINE_WIDTH: 0.11675
G1 X137.121 Y128.958 E.00076
; WIPE_START
G1 X137.083 Y129.084 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.121 Y127.041 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.116755
G1 F9000
G1 X137.083 Y126.916 E.00076
; LINE_WIDTH: 0.158063
G1 X137.042 Y126.781 E.00129
; LINE_WIDTH: 0.188872
G1 X137.03 Y126.749 E.00039
; LINE_WIDTH: 0.17235
G1 X136.918 Y126.633 E.00166
; LINE_WIDTH: 0.122858
G1 X136.805 Y126.516 E.00102
; LINE_WIDTH: 0.0971076
G1 X136.781 Y126.494 E.00014
; OBJECT_ID: 118
; WIPE_START
G1 X136.805 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X129.174 Y126.422 Z1.6 F9000
G1 X103.565 Y126.108 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X103.54 Y125.481 E.02016
G1 X104.143 Y125.311 E.02016
G1 X104.275 Y124.698 E.02016
G1 X104.902 Y124.684 E.02016
G1 X105.182 Y124.123 E.02015
G1 X105.793 Y124.264 E.02016
G1 X106.204 Y123.791 E.02016
G1 X106.76 Y124.08 E.02016
G1 X107.276 Y123.724 E.02016
G1 X107.743 Y124.142 E.02016
G1 X108.331 Y123.925 E.02016
G1 X108.679 Y124.446 E.02016
G1 X109.303 Y124.382 E.02016
G1 X109.51 Y124.974 E.02016
G1 X110.13 Y125.067 E.02016
G1 X110.184 Y125.691 E.02016
G1 X110.762 Y125.936 E.02016
G1 X110.659 Y126.554 E.02016
G1 X111.157 Y126.934 E.02016
G1 X110.904 Y127.508 E.02016
G1 X111.292 Y128 E.02016
G1 X110.904 Y128.492 E.02016
G1 X111.157 Y129.066 E.02016
G1 X110.659 Y129.446 E.02016
G1 X110.762 Y130.064 E.02016
G1 X110.184 Y130.309 E.02016
G1 X110.13 Y130.933 E.02016
G1 X109.51 Y131.026 E.02016
G1 X109.303 Y131.618 E.02016
G1 X108.679 Y131.554 E.02016
G1 X108.331 Y132.075 E.02016
G1 X107.743 Y131.858 E.02016
G1 X107.276 Y132.277 E.02016
G1 X106.76 Y131.92 E.02016
G1 X106.204 Y132.209 E.02016
G1 X105.793 Y131.736 E.02016
G1 X105.182 Y131.877 E.02016
G1 X104.902 Y131.316 E.02016
G1 X104.275 Y131.302 E.02016
G1 X104.143 Y130.689 E.02016
G1 X103.54 Y130.519 E.02016
G1 X103.565 Y129.892 E.02016
G1 X103.023 Y129.577 E.02016
G1 X103.202 Y128.977 E.02016
G1 X102.756 Y128.537 E.02016
G1 X103.079 Y128 E.02016
G1 X102.756 Y127.463 E.02016
G1 X103.202 Y127.023 E.02016
G1 X103.023 Y126.423 E.02016
G1 X103.513 Y126.138 E.01823
G1 X103.981 Y126.337 F9000
G1 F5895.652
G1 X103.959 Y125.786 E.01772
G1 X104.49 Y125.636 E.01772
G1 X104.606 Y125.098 E.01772
G1 X105.157 Y125.085 E.01772
G1 X105.403 Y124.592 E.01772
G1 X105.94 Y124.716 E.01772
G1 X106.301 Y124.3 E.01772
G1 X106.79 Y124.554 E.01772
G1 X107.243 Y124.241 E.01772
G1 X107.654 Y124.608 E.01772
G1 X108.171 Y124.418 E.01772
G1 X108.477 Y124.876 E.01772
G1 X109.025 Y124.82 E.01772
G1 X109.208 Y125.34 E.01772
G1 X109.752 Y125.422 E.01772
G1 X109.8 Y125.971 E.01772
G1 X110.307 Y126.185 E.01772
G1 X110.217 Y126.729 E.01772
G1 X110.655 Y127.063 E.01772
G1 X110.432 Y127.567 E.01772
G1 X110.773 Y128 E.01772
G1 X110.432 Y128.433 E.01772
G1 X110.655 Y128.937 E.01772
G1 X110.217 Y129.271 E.01772
G1 X110.307 Y129.815 E.01772
G1 X109.8 Y130.029 E.01772
G1 X109.752 Y130.578 E.01772
G1 X109.208 Y130.66 E.01772
G1 X109.025 Y131.18 E.01772
G1 X108.477 Y131.124 E.01772
G1 X108.171 Y131.582 E.01772
G1 X107.654 Y131.392 E.01772
G1 X107.243 Y131.759 E.01772
G1 X106.79 Y131.446 E.01772
G1 X106.301 Y131.7 E.01772
G1 X105.94 Y131.284 E.01772
G1 X105.403 Y131.408 E.01772
G1 X105.157 Y130.915 E.01772
G1 X104.606 Y130.902 E.01772
G1 X104.49 Y130.364 E.01772
G1 X103.959 Y130.214 E.01772
G1 X103.981 Y129.663 E.01772
G1 X103.505 Y129.387 E.01772
G1 X103.662 Y128.859 E.01772
G1 X103.27 Y128.472 E.01772
G1 X103.554 Y128 E.01772
G1 X103.27 Y127.528 E.01772
G1 X103.662 Y127.141 E.01772
G1 X103.505 Y126.613 E.01772
G1 X103.929 Y126.367 E.01579
M204 S250
G1 X104.382 Y126.557 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X104.363 Y126.079 E.01424
G1 X104.823 Y125.95 E.01424
G1 X104.924 Y125.482 E.01424
G1 X105.402 Y125.471 E.01424
G1 X105.616 Y125.044 E.01424
G1 X106.081 Y125.151 E.01424
G1 X106.394 Y124.79 E.01424
G1 X106.819 Y125.011 E.01424
G1 X107.212 Y124.739 E.01424
G1 X107.568 Y125.058 E.01424
G1 X108.016 Y124.893 E.01424
G1 X108.282 Y125.29 E.01424
G1 X108.757 Y125.241 E.01424
G1 X108.916 Y125.692 E.01424
G1 X109.389 Y125.763 E.01424
G1 X109.43 Y126.24 E.01424
G1 X109.87 Y126.426 E.01424
G1 X109.792 Y126.897 E.01424
G1 X110.171 Y127.187 E.01424
G1 X109.978 Y127.625 E.01424
G1 X110.274 Y128 E.01424
G1 X109.978 Y128.375 E.01424
G1 X110.171 Y128.813 E.01424
G1 X109.792 Y129.103 E.01424
G1 X109.87 Y129.574 E.01424
G1 X109.43 Y129.76 E.01424
G1 X109.389 Y130.237 E.01424
G1 X108.916 Y130.308 E.01424
G1 X108.757 Y130.759 E.01424
G1 X108.282 Y130.71 E.01424
G1 X108.016 Y131.107 E.01424
G1 X107.568 Y130.942 E.01424
G1 X107.212 Y131.261 E.01424
G1 X106.819 Y130.989 E.01424
G1 X106.394 Y131.21 E.01424
G1 X106.081 Y130.849 E.01424
G1 X105.616 Y130.956 E.01424
G1 X105.402 Y130.529 E.01424
G1 X104.924 Y130.518 E.01424
G1 X104.823 Y130.05 E.01424
G1 X104.363 Y129.921 E.01424
G1 X104.382 Y129.443 E.01424
G1 X103.969 Y129.203 E.01424
G1 X104.106 Y128.745 E.01424
G1 X103.765 Y128.41 E.01424
G1 X104.012 Y128 E.01424
G1 X103.765 Y127.59 E.01424
G1 X104.106 Y127.255 E.01424
G1 X103.969 Y126.797 E.01424
G1 X104.33 Y126.587 E.01245
; WIPE_START
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18163
G1 X104.924 Y125.482 E-.18164
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02174
; WIPE_END
G1 E-.04 F1800
G1 X104.327 Y119.847 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X104.191 Y120.226 E.01296
G2 X104.115 Y121.345 I3.024 J.766 E.03627
G2 X105.706 Y123.614 I2.916 J-.352 E.09279
G1 X105.628 Y123.808 E.00673
G1 X104.962 Y123.654 E.022
G1 X104.647 Y124.282 E.02259
G1 X103.945 Y124.299 E.02259
G1 X103.797 Y124.986 E.02259
G1 X103.121 Y125.177 E.0226
G1 X103.148 Y125.879 E.0226
G1 X102.393 Y126.317 E.02808
G2 X98.856 Y125.319 I-2.393 J1.713 E.12764
G3 X104.27 Y119.866 I8.165 J2.691 E.25617
; WIPE_START
G1 X104.191 Y120.226 E-.14025
G1 X104.106 Y120.665 E-.1699
G1 X104.088 Y121.112 E-.16982
G1 X104.115 Y121.345 E-.08942
G1 X104.115 Y121.345 E0
G1 X104.14 Y121.556 E-.08059
G1 X104.217 Y121.835 E-.11002
; WIPE_END
G1 E-.04 F1800
G1 X109.682 Y119.833 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
G1 F5895.652
G1 X110.38 Y120.108 E.02412
G3 X115.165 Y125.322 I-3.404 J7.927 E.23451
G2 X111.432 Y126.632 I-1.151 J2.694 E.13966
G1 X111.101 Y126.379 E.01342
G1 X111.216 Y125.686 E.0226
G1 X110.569 Y125.412 E.0226
G1 X110.508 Y124.712 E.02259
G1 X109.813 Y124.607 E.0226
G1 X109.58 Y123.944 E.0226
G1 X108.881 Y124.016 E.0226
G1 X108.526 Y123.484 E.02057
G1 X108.687 Y123.389 E.00601
G2 X109.901 Y121.323 I-1.66 J-2.365 E.07945
G2 X109.705 Y119.888 I-2.761 J-.355 E.04708
; WIPE_START
G1 X110.38 Y120.108 E-.26951
G1 X110.846 Y120.324 E-.19533
G1 X111.298 Y120.567 E-.19492
G1 X111.523 Y120.705 E-.10024
; WIPE_END
G1 E-.04 F1800
G1 X114.141 Y127.874 Z1.6 F9000
G1 X115.165 Y130.678 Z1.6
G1 Z1.2
G1 E.8 F1800
G1 F5895.652
G3 X109.682 Y136.167 I-8.236 J-2.744 E.25865
G2 X108.526 Y132.516 I-2.655 J-1.168 E.13449
G1 X108.881 Y131.984 E.02057
G1 X109.58 Y132.056 E.02259
G1 X109.813 Y131.393 E.0226
G1 X110.508 Y131.288 E.0226
G1 X110.569 Y130.588 E.0226
G1 X111.216 Y130.314 E.0226
G1 X111.101 Y129.621 E.0226
G1 X111.432 Y129.368 E.01342
G1 X111.618 Y129.68 E.01169
G2 X115.11 Y130.701 I2.395 J-1.712 E.1261
; WIPE_START
G1 X114.949 Y131.255 E-.21944
G1 X114.74 Y131.724 E-.19495
G1 X114.503 Y132.18 E-.19537
G1 X114.3 Y132.52 E-.15024
; WIPE_END
G1 E-.04 F1800
G1 X106.673 Y132.231 Z1.6 F9000
G1 X105.628 Y132.192 Z1.6
G1 Z1.2
G1 E.8 F1800
G1 F5895.652
G1 X105.706 Y132.386 E.00673
G2 X104.327 Y136.153 I1.297 J2.611 E.14228
G3 X98.856 Y130.681 I2.693 J-8.162 E.2581
G2 X102.393 Y129.683 I1.144 J-2.711 E.12764
G1 X103.148 Y130.121 E.02808
G1 X103.121 Y130.823 E.0226
G1 X103.797 Y131.014 E.0226
G1 X103.945 Y131.701 E.02259
G1 X104.647 Y131.718 E.0226
G1 X104.962 Y132.346 E.0226
G1 X105.569 Y132.205 E.02006
; WIPE_START
G1 X105.706 Y132.386 E-.08599
G1 X105.327 Y132.611 E-.16768
M73 P59 R8
G1 X104.982 Y132.896 E-.16995
G1 X104.684 Y133.23 E-.16983
G1 X104.446 Y133.597 E-.16655
; WIPE_END
G1 E-.04 F1800
G1 X106.739 Y126.318 Z1.6 F9000
G1 X108.924 Y119.383 Z1.6
G1 Z1.2
G1 E.8 F1800
G1 F5895.652
G1 X109.02 Y119.238 E.0056
G3 X115.827 Y126.238 I-2.037 J8.79 E.33173
G1 X115.372 Y125.891 E.01838
G1 X115.193 Y125.794 E.00656
G2 X115.372 Y130.109 I-1.186 J2.21 E.33957
G1 X115.827 Y129.762 E.01838
G3 X109.02 Y136.762 I-8.843 J-1.79 E.33173
G1 X108.924 Y136.617 E.0056
G2 X104.898 Y136.366 I-1.92 J-1.614 E.35608
G1 X105.24 Y136.814 E.01815
G3 X98.196 Y129.769 I1.776 J-8.82 E.33953
G1 X98.641 Y130.109 E.01802
G2 X98.641 Y125.891 I1.361 J-2.109 E.34601
G1 X98.196 Y126.231 E.01802
G3 X105.24 Y119.186 I8.805 J1.759 E.33963
G1 X104.898 Y119.634 E.01814
G1 X104.801 Y119.814 E.00656
G2 X104.52 Y121.299 I2.207 J1.187 E.04938
G2 X107.037 Y123.51 I2.495 J-.303 E.11792
G1 X107.296 Y123.49 E.00836
G2 X107.765 Y123.395 I-.072 J-1.561 E.01542
G2 X109.496 Y121.276 I-.753 J-2.382 E.09313
G2 X108.962 Y119.429 I-2.423 J-.3 E.06353
G1 X108.556 Y119.58 F9000
G1 F5895.652
G1 X108.578 Y119.6 E.00095
G3 X104.924 Y121.252 I-1.569 J1.397 E.25315
G3 X106.846 Y118.902 I2.093 J-.249 E.10897
G3 X108.346 Y119.376 I.164 J2.094 E.05185
G1 X108.513 Y119.538 E.00748
M204 S250
G1 X108.283 Y119.862 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X106.876 Y119.294 I-1.276 J1.135 E.27283
G3 X107.51 Y119.37 I.103 J1.83 E.01914
G1 X107.646 Y119.413 E.00424
G3 X108.243 Y119.818 I-.639 J1.584 E.02164
; WIPE_START
G1 X108.443 Y120.07 E-.1222
G1 X108.568 Y120.3 E-.09952
G1 X108.656 Y120.547 E-.09954
G1 X108.706 Y120.804 E-.09951
G1 X108.716 Y121.065 E-.09949
G1 X108.686 Y121.326 E-.09955
G1 X108.617 Y121.578 E-.09951
G1 X108.573 Y121.676 E-.04069
; WIPE_END
G1 E-.04 F1800
G1 X114.801 Y126.088 Z1.6 F9000
G1 X115.65 Y126.69 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X115.813 Y126.926 E.00921
G3 X112.057 Y127.226 I-1.804 J1.076 E.2741
G3 X113.755 Y125.917 I1.922 J.737 E.07251
G3 X115.611 Y126.645 I.254 J2.085 E.06681
M204 S250
G1 X115.33 Y126.916 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X115.403 Y127.004 E.00341
G3 X113.8 Y126.307 I-1.387 J.997 E.26504
G3 X114.706 Y126.439 I.223 J1.649 E.02765
G3 X115.295 Y126.869 I-.691 J1.562 E.02187
; WIPE_START
G1 X115.403 Y127.004 E-.06569
G1 X115.477 Y127.126 E-.05428
G1 X115.593 Y127.361 E-.0995
G1 X115.672 Y127.61 E-.09953
G1 X115.712 Y127.869 E-.09953
G1 X115.712 Y128.131 E-.0995
G1 X115.672 Y128.39 E-.09954
G1 X115.593 Y128.639 E-.09952
G1 X115.543 Y128.741 E-.04291
; WIPE_END
G1 E-.04 F1800
G1 X110.295 Y134.283 Z1.6 F9000
G1 X107.758 Y136.962 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X107.653 Y137.004 E.00363
G3 X106.835 Y132.909 I-.639 J-2.001 E.22735
G3 X108.466 Y133.484 I.186 J2.074 E.05734
G3 X107.815 Y136.944 I-1.452 J1.518 E.13424
M204 S250
G1 X107.64 Y136.589 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X107.534 Y136.629 E.00336
G3 X106.865 Y133.3 I-.519 J-1.628 E.17103
G3 X107.766 Y133.467 I.159 J1.657 E.02765
G3 X107.696 Y136.569 I-.75 J1.535 E.1159
; WIPE_START
G1 X107.534 Y136.629 E-.06543
G1 X107.397 Y136.666 E-.05419
G1 X107.138 Y136.706 E-.09953
G1 X106.876 Y136.706 E-.0995
G1 X106.617 Y136.666 E-.09953
G1 X106.367 Y136.587 E-.09952
G1 X106.133 Y136.47 E-.09949
G1 X105.918 Y136.32 E-.09952
G1 X105.836 Y136.241 E-.04328
; WIPE_END
G1 E-.04 F1800
G1 X102.447 Y129.402 Z1.6 F9000
G1 X102.03 Y128.56 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X102.016 Y128.636 E.00247
G3 X99.915 Y125.904 I-2.002 J-.634 E.29431
G3 X101.523 Y126.541 I.084 J2.135 E.05725
G3 X102.089 Y128.322 I-1.509 J1.461 E.06227
G1 X102.044 Y128.502 E.00598
M204 S250
G1 X101.648 Y128.471 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X101.644 Y128.518 E.00141
G3 X99.93 Y126.296 I-1.628 J-.516 E.2216
G3 X100.824 Y126.497 I.096 J1.661 E.02765
G3 X101.704 Y128.262 I-.808 J1.505 E.06263
G1 X101.664 Y128.413 E.00465
; WIPE_START
G1 X101.644 Y128.518 E-.04065
G1 X101.54 Y128.759 E-.09976
G1 X101.406 Y128.984 E-.09952
G1 X101.239 Y129.186 E-.09952
G1 X101.044 Y129.36 E-.09952
G1 X100.824 Y129.503 E-.09953
G1 X100.585 Y129.61 E-.0995
G1 X100.332 Y129.679 E-.09952
G1 X100.274 Y129.686 E-.02248
; WIPE_END
G1 E-.04 F1800
G1 X103.929 Y122.986 Z1.6 F9000
G1 X106.305 Y118.631 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G3 X107.177 Y118.608 I.684 J9.326 E.02807
G3 X103.056 Y119.473 I-.18 J9.394 E1.76172
G3 X106.245 Y118.636 I3.932 J8.484 E.10657
M204 S250
G1 X106.275 Y118.237 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X106.86 Y118.215 E.01743
G3 X107.183 Y118.216 I.145 J9.786 E.00961
G3 X116.179 Y124.59 I-.177 J9.784 E.34884
G3 X106.22 Y118.246 I-9.173 J3.412 E1.45424
G1 X106.047 Y118.883 F9000
; FEATURE: Gap infill
; LINE_WIDTH: 0.117481
G1 X105.922 Y118.919 E.00077
; LINE_WIDTH: 0.1612
G1 X105.782 Y118.96 E.00136
; LINE_WIDTH: 0.192069
G1 X105.758 Y118.97 E.00031
; LINE_WIDTH: 0.172937
G1 X105.64 Y119.083 E.00168
; LINE_WIDTH: 0.123026
G1 X105.522 Y119.197 E.00103
; LINE_WIDTH: 0.0970809
G1 X105.501 Y119.221 E.00014
; WIPE_START
G1 X105.522 Y119.197 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.958 Y118.878 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.116549
G1 F9000
G1 X108.087 Y118.917 E.00078
; LINE_WIDTH: 0.155821
G1 X108.216 Y118.957 E.0012
; LINE_WIDTH: 0.177556
G1 X108.822 Y119.168 E.00683
G1 X108.797 Y119.206
; LINE_WIDTH: 0.353121
G1 F7736.924
G1 X108.095 Y118.874 E.01903
; WIPE_START
G1 X108.797 Y119.206 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.938 Y123.477 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.103372
G1 F9000
G1 X108.834 Y123.578 E.00069
G1 X108.325 Y123.55
; LINE_WIDTH: 0.332804
G1 F8279.187
G3 X107.655 Y123.79 I-1.956 J-4.401 E.01631
G1 X106.815 Y123.794 F9000
; LINE_WIDTH: 0.112263
G3 X106.494 Y123.686 I1.211 J-4.109 E.00186
G1 X106.048 Y123.533
; LINE_WIDTH: 0.163246
G1 X105.952 Y123.69 E.00174
; LINE_WIDTH: 0.119031
G1 X105.857 Y123.846 E.0011
; WIPE_START
G1 X105.952 Y123.69 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X102.747 Y125.658 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X102.723 Y125.032 E.01868
G1 X102.783 Y124.886 E.0047
G1 X103.464 Y124.673 E.02123
G1 X103.596 Y124.06 E.01868
G1 X103.679 Y123.94 E.00433
G1 X104.402 Y123.896 E.02159
G1 X104.679 Y123.333 E.01868
G1 X104.306 Y122.907 E.01687
G3 X103.74 Y120.493 I2.615 J-1.887 E.07583
G2 X99.511 Y124.731 I3.269 J7.49 E.18257
G1 X100.039 Y124.692 E.01578
G1 X100.623 Y124.745 E.01745
G3 X102.484 Y125.811 I-.682 J3.349 E.06498
G1 X102.695 Y125.689 E.00728
; WIPE_START
G1 X102.484 Y125.811 E-.09286
G1 X102.383 Y125.693 E-.05915
G1 X102.003 Y125.357 E-.19267
G1 X101.577 Y125.083 E-.19274
G1 X101.113 Y124.878 E-.1927
G1 X101.037 Y124.857 E-.02989
; WIPE_END
G1 E-.04 F1800
G1 X103.143 Y124.371 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
G1 F6364.866
G1 X103.276 Y123.842 E.01627
G1 X103.476 Y123.622 E.00885
G1 X103.766 Y123.534 E.00904
G1 X104.166 Y123.524 E.01192
G1 X104.227 Y123.403 E.00404
G3 X103.323 Y121.184 I2.771 J-2.423 E.07269
G1 X103.304 Y121.119 E.00201
G2 X100.12 Y124.313 I3.76 J6.932 E.13622
G3 X102.35 Y125.158 I-.176 J3.829 E.07223
G1 X102.348 Y124.973 E.00552
G1 X102.527 Y124.609 E.01209
G3 X103.085 Y124.388 I.74 J1.052 E.01803
G1 X102.822 Y124.07 F9000
G1 F6364.866
G1 X102.941 Y123.67 E.01243
G1 X103.126 Y123.42 E.00926
G1 X103.401 Y123.236 E.00988
G1 X103.593 Y123.194 E.00584
G1 X103.282 Y122.612 E.01963
G3 X103.009 Y121.733 I4.57 J-1.904 E.02748
G2 X100.74 Y124.002 I4.028 J6.294 E.09633
G3 X102.132 Y124.541 I-.955 J4.527 E.04464
G1 X102.272 Y124.332 E.00751
G1 X102.567 Y124.147 E.01039
G1 X102.764 Y124.087 E.00613
G1 X102.503 Y123.771 F9000
G1 F6364.866
G1 X102.605 Y123.498 E.00866
G1 X102.864 Y123.149 E.01296
G1 X103.046 Y123.006 E.00688
G3 X102.779 Y122.351 I2.797 J-1.523 E.02111
G2 X101.357 Y123.772 I4.3 J5.724 E.06005
G1 X102.027 Y124.046 E.02157
M73 P60 R8
G1 X102.346 Y123.832 E.01142
G1 X102.447 Y123.792 E.00324
G1 X102.167 Y123.455 F9000
; LINE_WIDTH: 0.476584
G1 F5534.247
G1 X102.283 Y123.307 E.00644
; LINE_WIDTH: 0.43023
G1 F6196.587
G1 X102.4 Y123.16 E.00575
; LINE_WIDTH: 0.383877
G1 F7039.018
G1 X102.516 Y123.012 E.00506
; LINE_WIDTH: 0.35208
G1 F7762.971
G1 X102.586 Y122.946 E.00235
; WIPE_START
G1 X102.516 Y123.012 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X102.736 Y127.86 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.151087
G1 F9000
G3 X102.736 Y128.14 I-.215 J.14 E.00254
; WIPE_START
G1 X102.778 Y128 E-.38002
G1 X102.736 Y127.86 E-.37998
; WIPE_END
G1 E-.04 F1800
G1 X102.747 Y130.342 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X102.484 Y130.189 E.00906
G1 X102.026 Y130.626 E.01885
G3 X99.497 Y131.267 I-2.006 J-2.604 E.07991
G2 X103.74 Y135.507 I7.531 J-3.291 E.18289
G1 X103.696 Y134.888 E.01851
G3 X104.679 Y132.667 I3.235 J.104 E.07416
G1 X104.402 Y132.104 E.01868
G1 X103.775 Y132.089 E.01868
G1 X103.637 Y132.024 E.00456
G1 X103.463 Y131.327 E.02137
G1 X102.86 Y131.157 E.01868
G1 X102.764 Y131.093 E.00345
G1 X102.723 Y130.955 E.00429
G1 X102.745 Y130.402 E.01649
; WIPE_START
G1 X102.723 Y130.955 E-.21034
G1 X102.764 Y131.093 E-.05479
G1 X102.86 Y131.157 E-.04397
G1 X103.463 Y131.327 E-.2383
G1 X103.599 Y131.87 E-.2126
; WIPE_END
G1 E-.04 F1800
G1 X103.143 Y131.629 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
G1 F6364.866
G1 X102.6 Y131.448 E.01704
G1 X102.468 Y131.328 E.00531
G1 X102.346 Y130.953 E.01173
G1 X102.35 Y130.842 E.00332
G1 X101.807 Y131.22 E.01971
G3 X100.12 Y131.687 I-1.8 J-3.219 E.05263
G2 X103.252 Y134.851 I6.933 J-3.731 E.13444
G1 X103.319 Y134.872 E.00208
G3 X104.227 Y132.597 I3.631 J.131 E.07442
G1 X104.166 Y132.476 E.00404
G1 X103.766 Y132.466 E.01192
G1 X103.476 Y132.378 E.00903
G1 X103.276 Y132.158 E.00885
G1 X103.157 Y131.687 E.01448
G1 X102.822 Y131.93 F9000
G1 F6364.866
G1 X102.392 Y131.762 E.01375
G1 X102.173 Y131.563 E.00881
G1 X102.132 Y131.459 E.00334
G3 X100.74 Y131.998 I-2.248 J-3.734 E.04467
G2 X102.015 Y133.511 I6.551 J-4.225 E.0591
G2 X103.009 Y134.267 I5.275 J-5.901 E.03722
G3 X103.593 Y132.806 I4.422 J.921 E.0471
G1 X103.274 Y132.696 E.01005
G1 X103.065 Y132.515 E.00823
G1 X102.882 Y132.189 E.01115
G1 X102.835 Y131.988 E.00613
G1 X102.503 Y132.229 F9000
G1 F6364.866
G1 X102.184 Y132.077 E.01053
G1 X102.027 Y131.954 E.00592
G1 X101.357 Y132.228 E.02157
G1 X101.682 Y132.634 E.01549
G1 X102.276 Y133.239 E.02524
G2 X102.779 Y133.649 I4.834 J-5.414 E.01933
G1 X103.046 Y132.994 E.02107
G1 X102.779 Y132.761 E.01054
G1 X102.554 Y132.39 E.01292
G1 X102.521 Y132.286 E.00324
G1 X102.167 Y132.545 F9000
; LINE_WIDTH: 0.476577
G1 F5534.332
G1 X102.283 Y132.693 E.00644
; LINE_WIDTH: 0.43021
G1 F6196.907
G1 X102.4 Y132.84 E.00575
; LINE_WIDTH: 0.383844
G1 F7039.707
G1 X102.516 Y132.988 E.00506
; LINE_WIDTH: 0.35205
G1 F7763.724
G1 X102.586 Y133.054 E.00234
; WIPE_START
G1 X102.516 Y132.988 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.856 Y132.153 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.119084
G1 F9000
G1 X105.952 Y132.31 E.0011
; LINE_WIDTH: 0.163406
G1 X106.048 Y132.467 E.00175
G1 X106.494 Y132.314
; LINE_WIDTH: 0.11225
G3 X106.815 Y132.205 I1.599 J4.182 E.00185
G1 X107.655 Y132.21
; LINE_WIDTH: 0.332795
G1 F8279.447
G3 X108.325 Y132.45 I-1.285 J4.638 E.01631
G1 X108.834 Y132.422 F9000
; LINE_WIDTH: 0.10334
G1 X108.938 Y132.522 E.00069
; WIPE_START
G1 X108.834 Y132.422 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.402 Y133.019 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42455
G1 F6288.814
G1 X111.464 Y132.975 E.00229
; LINE_WIDTH: 0.39909
G1 F6738.356
G1 X111.526 Y132.931 E.00214
G1 X110.945 Y132.761 F9000
; LINE_WIDTH: 0.424386
G1 F6291.53
G1 X110.9 Y132.86 E.0033
G3 X111.238 Y133.645 I-4.254 J2.299 E.02578
G2 X111.899 Y133.055 I-1.934 J-2.829 E.02678
; LINE_WIDTH: 0.485427
G1 F5423.647
G1 X112.03 Y132.888 E.00738
; LINE_WIDTH: 0.52236
G1 F5005.84
G1 X112.16 Y132.722 E.008
; LINE_WIDTH: 0.574311
G1 F4516.453
G3 X112.525 Y132.27 I12.471 J9.671 E.02441
G1 X111.972 Y132.034 E.02524
G1 X111.737 Y132.395 E.01807
; LINE_WIDTH: 0.5507
G1 F4726.456
G1 X111.642 Y132.453 E.00447
; LINE_WIDTH: 0.51204
G1 F5115.961
G1 X111.546 Y132.511 E.00413
; LINE_WIDTH: 0.47338
G1 F5575.431
G1 X111.451 Y132.569 E.00379
; LINE_WIDTH: 0.43702
G1 F6089.825
G1 X111.001 Y132.739 E.01498
G1 X110.666 Y132.423 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X110.536 Y132.745 E.01032
G1 X110.44 Y132.836 E.00395
G3 X111.005 Y134.267 I-3.861 J2.352 E.04607
G2 X113.272 Y132.002 I-4.061 J-6.331 E.09619
G3 X112.128 Y131.605 I.806 J-4.169 E.03617
G1 X111.773 Y131.539 E.01077
G1 X111.631 Y131.579 E.00439
G1 X111.567 Y131.828 E.00763
G1 X111.369 Y132.127 E.01071
G1 X111.086 Y132.324 E.01025
G1 X110.724 Y132.41 E.01108
G1 X110.386 Y132.084 F9000
; LINE_WIDTH: 0.41999
G1 F6364.875
G1 X110.209 Y132.557 E.01501
G1 X109.966 Y132.798 E.01021
G3 X110.694 Y134.885 I-3.204 J2.286 E.06672
G2 X113.893 Y131.687 I-3.691 J-6.891 E.1367
G3 X112.101 Y131.147 I.102 J-3.584 E.05638
G1 X111.97 Y131.186 E.00408
G1 X111.737 Y131.147 E.00703
G1 X111.534 Y131.216 E.0064
G1 X111.291 Y131.166 E.00739
G1 X111.222 Y131.676 E.01533
G1 X111.1 Y131.862 E.00663
G1 X110.855 Y132.009 E.00851
G1 X110.445 Y132.075 E.01236
G1 X110.105 Y131.745 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X109.897 Y132.337 E.01868
G1 X109.771 Y132.456 E.00517
G1 X109.407 Y132.432 E.01086
G1 X109.429 Y132.566 E.00404
G1 X109.339 Y132.671 E.00413
G1 X109.65 Y133.003 E.01355
G3 X110.273 Y135.51 I-2.622 J1.983 E.07906
G2 X114.508 Y131.268 I-3.282 J-7.512 E.18278
G1 X113.894 Y131.311 E.01833
G3 X112.122 Y130.704 I.098 J-3.176 E.05663
G1 X111.981 Y130.809 E.00526
G1 X111.701 Y130.754 E.00849
G1 X111.469 Y130.845 E.00742
G3 X111.249 Y130.726 I-.028 J-.21 E.00794
G1 X110.939 Y130.857 E.01004
G1 X110.885 Y131.482 E.01868
G1 X110.803 Y131.621 E.00481
G1 X110.164 Y131.735 E.01934
; WIPE_START
G1 X110.803 Y131.621 E-.24677
G1 X110.885 Y131.482 E-.06136
G1 X110.939 Y130.857 E-.23829
G1 X111.249 Y130.726 E-.12811
G1 X111.333 Y130.817 E-.04704
M73 P60 R7
G1 X111.432 Y130.837 E-.03844
; WIPE_END
G1 E-.04 F1800
G1 X111.399 Y130.173 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.233225
G1 F9000
G1 X111.851 Y130.266 E.00694
G1 X111.62 Y130.364
; LINE_WIDTH: 0.157629
G3 X111.349 Y129.687 I8.769 J-3.903 E.00661
G1 X111.459 Y129.091
; LINE_WIDTH: 0.173583
G3 X111.351 Y128.835 I3.262 J-1.523 E.00287
; LINE_WIDTH: 0.192551
G1 X111.283 Y128.631 E.00255
; LINE_WIDTH: 0.221841
G1 X111.215 Y128.426 E.00304
G1 X111.215 Y127.573
; LINE_WIDTH: 0.221839
G1 X111.283 Y127.369 E.00304
; LINE_WIDTH: 0.192554
G1 X111.351 Y127.165 E.00255
; LINE_WIDTH: 0.173585
G3 X111.459 Y126.909 I3.456 J1.303 E.00287
G1 X111.349 Y126.313
; LINE_WIDTH: 0.157639
G3 X111.621 Y125.637 I8.722 J3.111 E.00661
G1 X111.851 Y125.734
; LINE_WIDTH: 0.233205
G1 X111.399 Y125.827 E.00694
; WIPE_START
G1 X111.851 Y125.734 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.402 Y122.981 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.413235
G1 F6480.969
G1 X111.64 Y123.176 E.009
; LINE_WIDTH: 0.35802
G1 F7616.644
G3 X112.051 Y123.574 I-.897 J1.338 E.01431
; WIPE_START
G1 X111.878 Y123.371 E-.35245
G1 X111.64 Y123.176 E-.40755
; WIPE_END
G1 E-.04 F1800
G1 X110.945 Y123.239 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X111.242 Y123.333 E.00928
G1 X111.637 Y123.608 E.01435
G3 X111.959 Y124.058 I-1.895 J1.698 E.0165
G1 X112.657 Y123.772 E.02245
G2 X111.238 Y122.355 I-6.311 J4.901 E.05985
G3 X110.9 Y123.14 I-6.835 J-2.484 E.02546
G1 X110.92 Y123.185 E.00147
G1 X110.666 Y123.577 F9000
G1 F6364.866
G1 X111.086 Y123.676 E.01287
G1 X111.407 Y123.914 E.0119
G1 X111.572 Y124.183 E.0094
G1 X111.631 Y124.42 E.00727
G1 X111.819 Y124.452 E.00568
G1 X112.128 Y124.395 E.00937
G3 X113.272 Y123.998 I1.95 J3.774 E.03617
G2 X111.005 Y121.733 I-6.302 J4.04 E.0962
G1 X110.871 Y122.254 E.01604
G1 X110.612 Y122.878 E.02013
G1 X110.44 Y123.164 E.00994
G3 X110.646 Y123.52 I-.433 J.488 E.01246
G1 X110.386 Y123.916 F9000
G1 F6364.866
G1 X110.931 Y124.019 E.01653
G1 X111.123 Y124.162 E.00714
G1 X111.248 Y124.404 E.0081
G1 X111.291 Y124.834 E.01286
G1 X111.534 Y124.784 E.0074
G1 X111.738 Y124.853 E.00641
G1 X112.066 Y124.819 E.00981
G1 X112.101 Y124.853 E.00145
G1 X112.685 Y124.559 E.01948
G1 X113.262 Y124.387 E.01793
G3 X113.893 Y124.313 I.983 J5.655 E.01892
G2 X112.059 Y122.039 I-7.221 J3.947 E.08748
G1 X111.328 Y121.49 E.02723
G2 X110.694 Y121.115 I-4.42 J6.736 E.02196
G3 X110.268 Y122.724 I-4.121 J-.229 E.04993
G1 X109.966 Y123.202 E.01682
G1 X110.253 Y123.538 E.01317
G1 X110.366 Y123.859 E.01013
G1 X110.105 Y124.255 F9000
G1 F6364.866
G1 X110.725 Y124.348 E.01868
G1 X110.855 Y124.431 E.00458
G3 X110.939 Y125.143 I-8.733 J1.396 E.02136
G1 X111.263 Y125.269 E.01035
G1 X111.334 Y125.183 E.00333
G1 X111.509 Y125.167 E.00523
G1 X111.701 Y125.246 E.00618
G1 X112.013 Y125.193 E.00942
G1 X112.122 Y125.296 E.00449
G1 X112.437 Y125.083 E.01131
G3 X114.514 Y124.733 I1.581 J3.041 E.06378
G2 X110.276 Y120.502 I-7.541 J3.316 E.18257
G1 X110.317 Y121.112 E.01822
G3 X109.339 Y123.329 I-3.236 J-.104 E.07396
G1 X109.43 Y123.434 E.00414
G1 X109.407 Y123.568 E.00405
G1 X109.803 Y123.557 E.0118
G1 X109.897 Y123.663 E.00423
G1 X110.085 Y124.198 E.01689
; WIPE_START
G1 X109.897 Y123.663 E-.2155
G1 X109.803 Y123.557 E-.05396
G1 X109.407 Y123.568 E-.1505
G1 X109.43 Y123.434 E-.05161
G1 X109.339 Y123.329 E-.05276
G1 X109.65 Y122.997 E-.17275
G1 X109.739 Y122.857 E-.06292
; WIPE_END
G1 E-.04 F1800
G1 X115.786 Y126.494 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0971076
G1 F9000
G1 X115.81 Y126.516 E.00014
; LINE_WIDTH: 0.122858
G1 X115.922 Y126.633 E.00102
; LINE_WIDTH: 0.17235
G1 X116.035 Y126.749 E.00166
; LINE_WIDTH: 0.188872
G1 X116.047 Y126.781 E.00039
; LINE_WIDTH: 0.158063
G1 X116.088 Y126.916 E.00129
; LINE_WIDTH: 0.116755
G1 X116.125 Y127.041 E.00076
; WIPE_START
G1 X116.088 Y126.916 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.125 Y128.958 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.11675
G1 F9000
G1 X116.088 Y129.084 E.00076
; LINE_WIDTH: 0.158079
G1 X116.047 Y129.219 E.00129
; LINE_WIDTH: 0.188901
G1 X116.035 Y129.251 E.00039
; LINE_WIDTH: 0.172377
G1 X115.922 Y129.367 E.00166
; LINE_WIDTH: 0.122861
G1 X115.81 Y129.484 E.00102
; LINE_WIDTH: 0.0970978
G1 X115.786 Y129.506 E.00014
; WIPE_START
G1 X115.81 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.526 Y134.992 Z1.6 F9000
G1 X108.797 Y136.794 Z1.6
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.353121
G1 F7736.922
G1 X108.095 Y137.126 E.01903
G1 X108.087 Y137.083 F9000
; LINE_WIDTH: 0.116547
G1 X107.958 Y137.122 E.00078
G1 X108.087 Y137.083
; LINE_WIDTH: 0.155813
G1 X108.216 Y137.043 E.0012
; LINE_WIDTH: 0.177556
G1 X108.822 Y136.832 E.00683
; WIPE_START
G1 X108.216 Y137.043 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X106.047 Y137.117 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.11748
G1 F9000
G1 X105.922 Y137.081 E.00077
; LINE_WIDTH: 0.161195
G1 X105.782 Y137.04 E.00136
; LINE_WIDTH: 0.192081
G1 X105.758 Y137.03 E.00031
; LINE_WIDTH: 0.172933
G1 X105.64 Y136.917 E.00168
; LINE_WIDTH: 0.123027
G1 X105.522 Y136.803 E.00103
; LINE_WIDTH: 0.0970879
G1 X105.501 Y136.779 E.00014
; WIPE_START
G1 X105.522 Y136.803 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.126 Y131.405 Z1.6 F9000
G1 X98.228 Y129.506 Z1.6
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.0970891
G1 F9000
G1 X98.204 Y129.484 E.00014
; LINE_WIDTH: 0.122742
G1 X98.091 Y129.368 E.00102
; LINE_WIDTH: 0.175241
G1 X97.979 Y129.251 E.00169
G1 X97.963 Y129.209 E.00047
; LINE_WIDTH: 0.157766
G1 X97.926 Y129.092 E.00111
; LINE_WIDTH: 0.117871
G1 X97.888 Y128.956 E.00083
; WIPE_START
G1 X97.926 Y129.092 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X97.888 Y127.044 Z1.6 F9000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.117867
G1 F9000
G1 X97.926 Y126.908 E.00083
; LINE_WIDTH: 0.157757
G1 X97.963 Y126.791 E.00111
; LINE_WIDTH: 0.175226
G1 X97.979 Y126.749 E.00047
G1 X98.092 Y126.632 E.00169
; LINE_WIDTH: 0.12274
G1 X98.204 Y126.516 E.00102
; LINE_WIDTH: 0.0970827
G1 X98.228 Y126.494 E.00014
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F9000
G1 X98.204 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 118
M625
; layer num/total_layer_count: 7/23
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G17
G3 Z1.6 I.019 J1.217 P1  F9000
G1 X124.56 Y126.108 Z1.6
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X124.536 Y125.481 E.02016
G1 X125.139 Y125.311 E.02016
G1 X125.271 Y124.698 E.02016
G1 X125.898 Y124.684 E.02016
G1 X126.178 Y124.123 E.02016
G1 X126.788 Y124.264 E.02016
G1 X127.199 Y123.791 E.02016
G1 X127.756 Y124.08 E.02016
G1 X128.271 Y123.724 E.02016
G1 X128.738 Y124.142 E.02016
G1 X129.326 Y123.925 E.02016
G1 X129.675 Y124.446 E.02016
G1 X130.298 Y124.382 E.02016
G1 X130.506 Y124.974 E.02016
G1 X131.126 Y125.067 E.02016
G1 X131.18 Y125.691 E.02016
G1 X131.757 Y125.936 E.02016
G1 X131.654 Y126.554 E.02016
G1 X132.153 Y126.934 E.02016
G1 X131.899 Y127.508 E.02016
G1 X132.287 Y128 E.02016
G1 X131.899 Y128.492 E.02016
G1 X132.153 Y129.066 E.02016
G1 X131.654 Y129.446 E.02016
G1 X131.757 Y130.064 E.02016
G1 X131.18 Y130.309 E.02016
G1 X131.126 Y130.933 E.02016
G1 X130.506 Y131.026 E.02016
G1 X130.298 Y131.618 E.02016
G1 X129.675 Y131.554 E.02016
G1 X129.326 Y132.075 E.02016
G1 X128.738 Y131.858 E.02016
G1 X128.271 Y132.276 E.02016
G1 X127.756 Y131.92 E.02016
G1 X127.199 Y132.209 E.02016
G1 X126.788 Y131.736 E.02016
G1 X126.178 Y131.877 E.02016
G1 X125.898 Y131.316 E.02016
G1 X125.271 Y131.302 E.02016
G1 X125.139 Y130.689 E.02016
G1 X124.536 Y130.519 E.02016
G1 X124.56 Y129.892 E.02016
G1 X124.018 Y129.577 E.02016
G1 X124.198 Y128.977 E.02016
G1 X123.751 Y128.537 E.02016
G1 X124.074 Y128 E.02016
G1 X123.751 Y127.463 E.02016
G1 X124.198 Y127.023 E.02016
G1 X124.018 Y126.423 E.02016
M73 P61 R7
G1 X124.508 Y126.138 E.01823
G1 X124.977 Y126.337 F9000
G1 F5895.652
G1 X124.955 Y125.786 E.01772
G1 X125.485 Y125.636 E.01772
G1 X125.601 Y125.098 E.01772
G1 X126.152 Y125.085 E.01772
G1 X126.398 Y124.592 E.01772
G1 X126.935 Y124.716 E.01772
G1 X127.296 Y124.3 E.01772
G1 X127.785 Y124.554 E.01772
G1 X128.239 Y124.241 E.01772
G1 X128.649 Y124.608 E.01772
G1 X129.166 Y124.418 E.01772
G1 X129.472 Y124.876 E.01772
G1 X130.021 Y124.82 E.01772
G1 X130.203 Y125.34 E.01772
G1 X130.748 Y125.422 E.01772
G1 X130.796 Y125.971 E.01772
G1 X131.303 Y126.185 E.01772
G1 X131.213 Y126.729 E.01772
G1 X131.651 Y127.063 E.01772
G1 X131.428 Y127.567 E.01772
G1 X131.769 Y128 E.01772
G1 X131.428 Y128.433 E.01772
G1 X131.651 Y128.937 E.01772
G1 X131.213 Y129.271 E.01772
G1 X131.303 Y129.815 E.01772
G1 X130.796 Y130.029 E.01772
G1 X130.748 Y130.578 E.01772
G1 X130.203 Y130.66 E.01772
G1 X130.021 Y131.18 E.01772
G1 X129.472 Y131.124 E.01772
G1 X129.166 Y131.582 E.01772
G1 X128.649 Y131.392 E.01772
G1 X128.239 Y131.759 E.01772
G1 X127.785 Y131.446 E.01772
G1 X127.296 Y131.7 E.01772
G1 X126.935 Y131.284 E.01772
G1 X126.398 Y131.408 E.01772
G1 X126.152 Y130.915 E.01772
G1 X125.601 Y130.902 E.01772
G1 X125.485 Y130.364 E.01772
G1 X124.955 Y130.214 E.01772
G1 X124.977 Y129.663 E.01772
G1 X124.5 Y129.387 E.01772
G1 X124.658 Y128.859 E.01772
G1 X124.265 Y128.472 E.01772
G1 X124.549 Y128 E.01772
G1 X124.265 Y127.528 E.01772
G1 X124.658 Y127.141 E.01772
G1 X124.5 Y126.613 E.01772
G1 X124.925 Y126.367 E.01579
M204 S250
G1 X125.378 Y126.557 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X125.359 Y126.079 E.01424
G1 X125.819 Y125.95 E.01424
G1 X125.92 Y125.482 E.01424
G1 X126.397 Y125.471 E.01424
G1 X126.611 Y125.044 E.01424
G1 X127.077 Y125.151 E.01424
G1 X127.39 Y124.79 E.01424
G1 X127.814 Y125.011 E.01424
G1 X128.207 Y124.739 E.01424
G1 X128.563 Y125.058 E.01424
G1 X129.012 Y124.893 E.01424
G1 X129.277 Y125.29 E.01424
G1 X129.753 Y125.241 E.01424
G1 X129.911 Y125.692 E.01424
G1 X130.384 Y125.763 E.01424
G1 X130.425 Y126.24 E.01424
G1 X130.865 Y126.426 E.01424
G1 X130.787 Y126.897 E.01424
G1 X131.167 Y127.187 E.01424
G1 X130.974 Y127.625 E.01424
G1 X131.27 Y128 E.01424
G1 X130.974 Y128.375 E.01424
G1 X131.167 Y128.813 E.01424
G1 X130.787 Y129.103 E.01424
G1 X130.865 Y129.574 E.01424
G1 X130.425 Y129.76 E.01424
G1 X130.384 Y130.237 E.01424
G1 X129.911 Y130.308 E.01424
G1 X129.753 Y130.759 E.01424
G1 X129.277 Y130.71 E.01424
G1 X129.012 Y131.107 E.01424
G1 X128.563 Y130.942 E.01424
G1 X128.207 Y131.261 E.01424
G1 X127.814 Y130.989 E.01424
G1 X127.39 Y131.21 E.01424
G1 X127.077 Y130.849 E.01424
G1 X126.611 Y130.956 E.01424
G1 X126.397 Y130.529 E.01424
G1 X125.92 Y130.518 E.01424
G1 X125.819 Y130.05 E.01424
G1 X125.359 Y129.921 E.01424
G1 X125.378 Y129.443 E.01424
G1 X124.964 Y129.203 E.01424
G1 X125.101 Y128.745 E.01424
G1 X124.761 Y128.41 E.01424
G1 X125.007 Y128 E.01424
G1 X124.761 Y127.59 E.01424
G1 X125.101 Y127.255 E.01424
G1 X124.964 Y126.797 E.01424
G1 X125.326 Y126.587 E.01245
; WIPE_START
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18163
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02174
; WIPE_END
G1 E-.04 F1800
G1 X125.323 Y119.847 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X125.186 Y120.226 E.01296
G2 X126.702 Y123.614 I2.85 J.758 E.12909
G1 X126.624 Y123.808 E.00673
G1 X125.957 Y123.654 E.022
G1 X125.643 Y124.282 E.02259
G1 X124.941 Y124.299 E.0226
G1 X124.793 Y124.986 E.02259
G1 X124.116 Y125.177 E.0226
G1 X124.144 Y125.879 E.0226
G1 X123.389 Y126.317 E.02808
G2 X119.852 Y125.319 I-2.394 J1.717 E.12761
G3 X125.266 Y119.866 I8.14 J2.667 E.25624
; WIPE_START
G1 X125.186 Y120.226 E-.14024
G1 X125.101 Y120.665 E-.16997
G1 X125.084 Y121.112 E-.16988
G1 X125.135 Y121.556 E-.16982
G1 X125.212 Y121.835 E-.11009
; WIPE_END
G1 E-.04 F1800
G1 X130.677 Y119.833 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
G1 F5895.652
G1 X131.376 Y120.108 E.02413
G3 X136.161 Y125.322 I-3.406 J7.929 E.23451
G2 X132.428 Y126.632 I-1.151 J2.696 E.13966
G1 X132.096 Y126.379 E.01342
G1 X132.211 Y125.686 E.0226
G1 X131.564 Y125.412 E.0226
G1 X131.504 Y124.712 E.02259
G1 X130.809 Y124.607 E.0226
G1 X130.576 Y123.944 E.0226
G1 X129.877 Y124.016 E.0226
G1 X129.522 Y123.484 E.02057
G1 X129.682 Y123.389 E.00601
G2 X130.7 Y119.889 I-1.713 J-2.396 E.12637
; WIPE_START
G1 X131.376 Y120.108 E-.26978
G1 X131.842 Y120.324 E-.19533
G1 X132.294 Y120.567 E-.19492
G1 X132.517 Y120.705 E-.09997
; WIPE_END
G1 E-.04 F1800
G1 X135.137 Y127.874 Z1.8 F9000
G1 X136.161 Y130.678 Z1.8
G1 Z1.4
G1 E.8 F1800
G1 F5895.652
G1 X136.003 Y131.098 E.01445
G3 X130.677 Y136.167 I-8.066 J-3.144 E.24416
G2 X129.522 Y132.516 I-2.679 J-1.16 E.1343
G1 X129.877 Y131.984 E.02057
G1 X130.576 Y132.056 E.0226
G1 X130.809 Y131.393 E.0226
G1 X131.504 Y131.288 E.02259
G1 X131.564 Y130.588 E.02259
G1 X132.211 Y130.314 E.0226
G1 X132.096 Y129.621 E.0226
G1 X132.428 Y129.368 E.01342
G1 X132.614 Y129.68 E.01169
G2 X136.105 Y130.701 I2.395 J-1.712 E.1261
; WIPE_START
G1 X136.003 Y131.098 E-.1561
G1 X135.735 Y131.724 E-.2585
G1 X135.499 Y132.18 E-.19532
G1 X135.296 Y132.519 E-.15008
; WIPE_END
G1 E-.04 F1800
G1 X127.669 Y132.231 Z1.8 F9000
G1 X126.624 Y132.192 Z1.8
G1 Z1.4
G1 E.8 F1800
G1 F5895.652
G1 X126.702 Y132.386 E.00673
G2 X125.323 Y136.153 I1.324 J2.621 E.14203
G3 X119.852 Y130.681 I2.688 J-8.158 E.25811
G2 X123.389 Y129.683 I1.144 J-2.711 E.12764
G1 X124.144 Y130.121 E.02808
G1 X124.116 Y130.823 E.0226
G1 X124.793 Y131.014 E.0226
G1 X124.941 Y131.701 E.02259
G1 X125.643 Y131.718 E.0226
G1 X125.957 Y132.346 E.02259
G1 X126.565 Y132.205 E.02007
; WIPE_START
G1 X126.702 Y132.386 E-.08599
G1 X126.322 Y132.611 E-.16776
G1 X125.977 Y132.896 E-.1699
G1 X125.68 Y133.23 E-.16991
G1 X125.442 Y133.597 E-.16645
; WIPE_END
G1 E-.04 F1800
G1 X127.735 Y126.317 Z1.8 F9000
G1 X129.919 Y119.383 Z1.8
G1 Z1.4
G1 E.8 F1800
G1 F5895.652
G1 X130.016 Y119.238 E.0056
G3 X136.822 Y126.238 I-2.037 J8.79 E.33173
G1 X136.368 Y125.891 E.01838
G1 X136.168 Y125.783 E.00729
G2 X136.368 Y130.109 I-1.164 J2.221 E.33857
G1 X136.822 Y129.762 E.01838
G3 X130.016 Y136.762 I-8.843 J-1.79 E.33173
G1 X129.919 Y136.617 E.0056
G2 X128.033 Y132.49 I-1.922 J-1.616 E.18214
G2 X125.894 Y136.365 I-.021 J2.517 E.17393
G1 X126.236 Y136.814 E.01815
G3 X119.191 Y129.769 I1.772 J-8.816 E.33955
G1 X119.637 Y130.109 E.01801
G2 X119.456 Y126.029 I1.363 J-2.104 E.35306
G1 X119.191 Y126.232 E.01074
G3 X126.236 Y119.186 I8.805 J1.759 E.33964
G1 X125.894 Y119.635 E.01815
G1 X125.785 Y119.834 E.00729
G2 X128.76 Y123.395 I2.218 J1.17 E.19056
G2 X129.957 Y119.43 I-.757 J-2.392 E.1567
G1 X129.551 Y119.579 F9000
G1 F5895.652
G1 X129.572 Y119.601 E.00097
G3 X127.841 Y118.902 I-1.57 J1.396 E.3622
G3 X128.602 Y118.99 I.125 J2.266 E.02475
G1 X128.789 Y119.049 E.00629
G3 X129.34 Y119.377 I-.786 J1.948 E.02073
G1 X129.508 Y119.538 E.00746
M204 S250
G1 X129.279 Y119.862 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X127.871 Y119.294 I-1.276 J1.135 E.27281
G3 X128.484 Y119.363 I.102 J1.85 E.01845
G1 X128.642 Y119.413 E.00493
G3 X129.238 Y119.818 I-.639 J1.584 E.02164
; WIPE_START
G1 X129.438 Y120.07 E-.12219
G1 X129.563 Y120.3 E-.09953
G1 X129.652 Y120.547 E-.09953
G1 X129.702 Y120.804 E-.09951
G1 X129.712 Y121.065 E-.09949
G1 X129.682 Y121.326 E-.09954
G1 X129.612 Y121.578 E-.09953
G1 X129.568 Y121.676 E-.04068
; WIPE_END
G1 E-.04 F1800
G1 X135.796 Y126.089 Z1.8 F9000
G1 X136.647 Y126.693 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X136.806 Y126.927 E.00912
G3 X134.727 Y125.92 I-1.805 J1.076 E.34581
G3 X135.974 Y126.141 I.274 J2.086 E.04135
G3 X136.607 Y126.648 I-.972 J1.862 E.02626
M204 S250
G1 X136.327 Y126.918 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X136.476 Y127.124 E.00757
G3 X134.772 Y126.31 I-1.466 J.878 E.26014
G3 X135.702 Y126.439 I.244 J1.651 E.02834
G3 X136.291 Y126.871 I-.691 J1.562 E.02193
; WIPE_START
M73 P62 R7
G1 X136.476 Y127.124 E-.11901
G1 X136.589 Y127.361 E-.09967
G1 X136.668 Y127.61 E-.09951
G1 X136.708 Y127.869 E-.09953
G1 X136.708 Y128.131 E-.0995
G1 X136.668 Y128.39 E-.09954
G1 X136.589 Y128.639 E-.09953
G1 X136.538 Y128.743 E-.04371
; WIPE_END
G1 E-.04 F1800
G1 X131.289 Y134.284 Z1.8 F9000
G1 X128.75 Y136.963 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X128.482 Y137.048 E.00906
G3 X127.807 Y132.911 I-.48 J-2.045 E.22155
G3 X129.045 Y133.179 I.194 J2.095 E.04135
G3 X128.807 Y136.943 I-1.043 J1.824 E.15057
M204 S250
G1 X128.632 Y136.59 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X128.392 Y136.665 E.00749
G3 X127.837 Y133.302 I-.381 J-1.664 E.16604
G3 X128.761 Y133.467 I.18 J1.66 E.02834
G3 X128.688 Y136.568 I-.75 J1.534 E.11589
; WIPE_START
G1 X128.392 Y136.665 E-.11829
G1 X128.133 Y136.706 E-.09951
G1 X127.871 Y136.706 E-.0995
G1 X127.612 Y136.666 E-.09953
G1 X127.363 Y136.587 E-.09953
G1 X127.128 Y136.47 E-.0995
G1 X126.914 Y136.32 E-.09952
G1 X126.829 Y136.238 E-.04462
; WIPE_END
G1 E-.04 F1800
G1 X123.452 Y129.394 Z1.8 F9000
G1 X123.03 Y128.539 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X123.013 Y128.637 E.00319
G3 X120.887 Y125.905 I-2.003 J-.634 E.2937
G3 X122.278 Y126.327 I.109 J2.145 E.04765
G3 X123.087 Y128.322 I-1.267 J1.676 E.07269
G1 X123.046 Y128.481 E.00528
M204 S250
G1 X122.644 Y128.438 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X122.607 Y128.609 E.00521
G3 X120.902 Y126.297 I-1.597 J-.608 E.21806
G3 X121.819 Y126.497 I.117 J1.665 E.02834
G3 X122.699 Y128.262 I-.809 J1.505 E.06261
G1 X122.661 Y128.381 E.00372
; WIPE_START
G1 X122.607 Y128.609 E-.08914
G1 X122.535 Y128.759 E-.06306
G1 X122.401 Y128.984 E-.09953
G1 X122.235 Y129.186 E-.09953
G1 X122.039 Y129.36 E-.09951
G1 X121.819 Y129.503 E-.09953
G1 X121.487 Y129.635 E-.13586
G1 X121.328 Y129.679 E-.06285
G1 X121.299 Y129.683 E-.01098
; WIPE_END
G1 E-.04 F1800
G1 X124.942 Y122.976 Z1.8 F9000
G1 X127.3 Y118.633 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G3 X128.232 Y118.609 I.712 J9.481 E.02999
G3 X124.569 Y119.252 I-.24 J9.392 E1.77791
G3 X127.241 Y118.638 I3.444 J8.862 E.08846
M204 S250
G1 X127.271 Y118.237 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X127.271 Y118.241 E.00012
G3 X128.238 Y118.217 I.731 J9.758 E.02883
G3 X137.195 Y124.646 I-.238 J9.785 E.34884
G3 X126.689 Y118.303 I-9.193 J3.354 E1.43631
G1 X127.211 Y118.244 E.01566
; WIPE_START
G1 X127.271 Y118.241 E-.02282
G1 X127.856 Y118.211 E-.22251
G1 X128.238 Y118.217 E-.14538
G1 X129.026 Y118.264 E-.29967
G1 X129.207 Y118.288 E-.06963
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.8 I1.217 J0 P1  F9000
; stop printing object, unique label id: 82
M625
; object ids of layer 7 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.8
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z1.8 F4000
            G39.3 S1
            G0 Z1.8 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END


; object ids of this layer7 end: 82,118
M625
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X129.091 Y118.874 F9000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.353121
G1 F7736.933
G1 X129.793 Y119.206 E.01903
G1 X129.818 Y119.168 F9000
; LINE_WIDTH: 0.177556
G1 X129.211 Y118.957 E.00683
; LINE_WIDTH: 0.155821
G1 X129.082 Y118.917 E.0012
; LINE_WIDTH: 0.116549
G1 X128.953 Y118.878 E.00078
; WIPE_START
G1 X129.082 Y118.917 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.042 Y118.883 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.117505
G1 F9000
G1 X126.917 Y118.919 E.00077
; LINE_WIDTH: 0.161221
G1 X126.778 Y118.96 E.00136
; LINE_WIDTH: 0.192078
G1 X126.754 Y118.97 E.00031
; LINE_WIDTH: 0.172941
G1 X126.636 Y119.083 E.00168
; LINE_WIDTH: 0.12303
G1 X126.518 Y119.197 E.00103
; LINE_WIDTH: 0.0970818
G1 X126.496 Y119.221 E.00014
; WIPE_START
G1 X126.518 Y119.197 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.043 Y123.533 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.163281
G1 F9000
G1 X126.948 Y123.69 E.00174
; LINE_WIDTH: 0.119042
G1 X126.852 Y123.846 E.0011
G1 X127.49 Y123.686
; LINE_WIDTH: 0.112264
G2 X127.811 Y123.794 I1.533 J-4.004 E.00186
G1 X128.651 Y123.79
; LINE_WIDTH: 0.332807
G1 F8279.093
G2 X129.321 Y123.55 I-1.288 J-4.647 E.01631
G1 X129.829 Y123.578 F9000
; LINE_WIDTH: 0.103381
G1 X129.934 Y123.477 E.00069
; WIPE_START
G1 X129.829 Y123.578 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X132.397 Y122.981 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.413235
G1 F6480.969
G1 X132.635 Y123.176 E.009
; LINE_WIDTH: 0.35802
G1 F7616.64
G3 X133.046 Y123.574 I-.897 J1.338 E.01431
; WIPE_START
G1 X132.873 Y123.371 E-.35244
G1 X132.635 Y123.176 E-.40756
; WIPE_END
G1 E-.04 F1800
G1 X131.941 Y123.239 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X132.238 Y123.333 E.00928
G1 X132.633 Y123.608 E.01435
G3 X132.955 Y124.057 I-1.928 J1.724 E.0165
G1 X133.652 Y123.772 E.02243
G2 X132.234 Y122.355 I-6.311 J4.901 E.05986
G3 X131.896 Y123.14 I-6.814 J-2.474 E.02546
G1 X131.916 Y123.185 E.00148
G1 X131.662 Y123.577 F9000
G1 F6364.866
G1 X132.082 Y123.676 E.01287
G1 X132.403 Y123.914 E.0119
G1 X132.567 Y124.183 E.00939
G1 X132.627 Y124.42 E.00729
G1 X132.814 Y124.452 E.00565
G1 X133.124 Y124.395 E.0094
G3 X134.267 Y123.998 I1.951 J3.775 E.03617
G2 X132 Y121.733 I-6.302 J4.04 E.0962
G1 X131.866 Y122.254 E.01604
G1 X131.607 Y122.878 E.02012
G1 X131.435 Y123.164 E.00995
G3 X131.641 Y123.52 I-.433 J.488 E.01246
G1 X131.381 Y123.916 F9000
G1 F6364.866
G1 X131.926 Y124.019 E.01653
G1 X132.119 Y124.162 E.00714
G1 X132.243 Y124.405 E.00812
G1 X132.286 Y124.834 E.01284
G1 X132.529 Y124.784 E.00739
G1 X132.733 Y124.853 E.0064
G1 X133.061 Y124.819 E.00984
G1 X133.097 Y124.853 E.00145
G1 X133.681 Y124.559 E.01947
G1 X134.258 Y124.387 E.01793
G3 X134.888 Y124.313 I.98 J5.63 E.01892
G2 X133.054 Y122.039 I-7.221 J3.947 E.08747
G1 X132.323 Y121.49 E.02724
G2 X131.689 Y121.115 I-4.423 J6.743 E.02196
G3 X131.263 Y122.724 I-4.122 J-.23 E.04992
G1 X130.962 Y123.202 E.01683
G1 X131.249 Y123.538 E.01317
G1 X131.361 Y123.859 E.01013
G1 X131.101 Y124.255 F9000
G1 F6364.866
G1 X131.721 Y124.348 E.01868
G1 X131.85 Y124.431 E.00458
G3 X131.935 Y125.143 I-8.728 J1.395 E.02136
G1 X132.257 Y125.269 E.01033
G1 X132.329 Y125.183 E.00334
G1 X132.503 Y125.166 E.00522
G1 X132.696 Y125.245 E.0062
G1 X133.008 Y125.193 E.00943
G1 X133.118 Y125.296 E.0045
G1 X133.432 Y125.083 E.01131
G3 X135.51 Y124.733 I1.581 J3.041 E.06378
G2 X131.271 Y120.502 I-7.541 J3.316 E.18257
G1 X131.313 Y121.112 E.01822
G3 X130.335 Y123.329 I-3.236 J-.104 E.07395
G1 X130.425 Y123.434 E.00414
G1 X130.403 Y123.568 E.00405
G1 X130.799 Y123.557 E.01179
G1 X130.893 Y123.663 E.00423
G1 X131.081 Y124.198 E.01689
; WIPE_START
G1 X130.893 Y123.663 E-.21549
G1 X130.799 Y123.557 E-.05396
G1 X130.403 Y123.568 E-.15047
G1 X130.425 Y123.434 E-.05163
G1 X130.335 Y123.329 E-.05278
G1 X130.645 Y122.997 E-.17272
G1 X130.735 Y122.857 E-.06295
; WIPE_END
G1 E-.04 F1800
G1 X132.394 Y125.827 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.23345
G1 F9000
G1 X132.847 Y125.734 E.00695
G1 X132.616 Y125.636
; LINE_WIDTH: 0.157693
G2 X132.345 Y126.313 I8.633 J3.854 E.00661
G1 X132.455 Y126.909
; LINE_WIDTH: 0.173535
G2 X132.347 Y127.165 I3.339 J1.556 E.00287
; LINE_WIDTH: 0.192506
G1 X132.279 Y127.369 E.00255
; LINE_WIDTH: 0.221822
G1 X132.21 Y127.574 E.00304
G1 X132.21 Y128.426
; LINE_WIDTH: 0.2218
G1 X132.279 Y128.631 E.00304
; LINE_WIDTH: 0.192489
G1 X132.347 Y128.835 E.00254
; LINE_WIDTH: 0.173499
G2 X132.455 Y129.091 I3.396 J-1.278 E.00287
G1 X132.345 Y129.687
; LINE_WIDTH: 0.157653
G2 X132.616 Y130.364 I9.052 J-3.232 E.00661
G1 X132.847 Y130.266
; LINE_WIDTH: 0.233232
G1 X132.394 Y130.173 E.00694
; WIPE_START
G1 X132.847 Y130.266 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X132.397 Y133.019 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42456
G1 F6288.649
G1 X132.459 Y132.975 E.00229
; LINE_WIDTH: 0.39912
G1 F6737.788
G1 X132.521 Y132.931 E.00214
G1 X131.941 Y132.761 F9000
; LINE_WIDTH: 0.424387
G1 F6291.5
G1 X131.896 Y132.86 E.0033
G3 X132.234 Y133.645 I-4.255 J2.3 E.02578
G2 X132.895 Y133.055 I-1.934 J-2.829 E.02678
; LINE_WIDTH: 0.485444
G1 F5423.443
G1 X133.025 Y132.888 E.00738
; LINE_WIDTH: 0.52237
G1 F5005.736
G1 X133.156 Y132.722 E.008
; LINE_WIDTH: 0.574311
G1 F4516.449
G3 X133.521 Y132.27 I12.457 J9.66 E.02441
G1 X132.967 Y132.034 E.02524
G1 X132.732 Y132.395 E.01808
; LINE_WIDTH: 0.550705
G1 F4726.41
G1 X132.637 Y132.453 E.00447
; LINE_WIDTH: 0.512055
G1 F5115.799
G1 X132.542 Y132.511 E.00413
; LINE_WIDTH: 0.473405
G1 F5575.107
G1 X132.447 Y132.569 E.00379
; LINE_WIDTH: 0.437035
G1 F6089.593
G1 X131.997 Y132.739 E.01498
G1 X131.662 Y132.423 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X131.532 Y132.745 E.01032
G1 X131.435 Y132.836 E.00396
G3 X132 Y134.267 I-3.86 J2.351 E.04607
G2 X134.267 Y132.002 I-4.06 J-6.33 E.09619
G3 X133.124 Y131.605 I.806 J-4.168 E.03617
G1 X132.768 Y131.539 E.01078
G1 X132.627 Y131.58 E.00439
G1 X132.563 Y131.828 E.00763
G1 X132.364 Y132.127 E.0107
G1 X132.082 Y132.324 E.01025
G1 X131.72 Y132.41 E.01108
G1 X131.381 Y132.084 F9000
G1 F6364.866
G1 X131.205 Y132.556 E.01501
G1 X130.962 Y132.798 E.01022
G3 X131.689 Y134.885 I-3.204 J2.287 E.06672
G2 X134.888 Y131.687 I-3.691 J-6.891 E.1367
G3 X133.097 Y131.147 I.102 J-3.583 E.05638
G1 X132.965 Y131.186 E.00408
G1 X132.733 Y131.147 E.00703
G1 X132.529 Y131.216 E.0064
G1 X132.286 Y131.166 E.00739
G1 X132.217 Y131.676 E.01533
G1 X132.096 Y131.862 E.00663
G1 X131.85 Y132.009 E.00851
G1 X131.44 Y132.075 E.01236
G1 X131.101 Y131.745 F9000
; LINE_WIDTH: 0.41999
G1 F6364.876
G1 X130.893 Y132.337 E.01868
G1 X130.766 Y132.456 E.00517
G1 X130.403 Y132.432 E.01086
G1 X130.425 Y132.566 E.00404
G1 X130.334 Y132.671 E.00413
G1 X130.645 Y133.003 E.01356
G3 X131.269 Y135.51 I-2.622 J1.983 E.07906
G2 X135.504 Y131.268 I-3.282 J-7.512 E.18278
G1 X134.89 Y131.311 E.01833
G3 X133.118 Y130.704 I.097 J-3.175 E.05663
G1 X132.976 Y130.809 E.00526
G1 X132.696 Y130.754 E.00849
G1 X132.464 Y130.845 E.00742
G3 X132.245 Y130.726 I-.028 J-.21 E.00794
G1 X131.935 Y130.857 E.01004
G1 X131.88 Y131.482 E.01868
G1 X131.799 Y131.621 E.00481
G1 X131.16 Y131.735 E.01934
; WIPE_START
G1 X131.799 Y131.621 E-.24675
G1 X131.88 Y131.482 E-.06136
G1 X131.935 Y130.857 E-.23828
G1 X132.245 Y130.726 E-.12811
G1 X132.328 Y130.817 E-.04705
G1 X132.428 Y130.837 E-.03845
; WIPE_END
G1 E-.04 F1800
G1 X129.933 Y132.522 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.103325
G1 F9000
G1 X129.829 Y132.422 E.00069
G1 X129.321 Y132.45
; LINE_WIDTH: 0.332836
G1 F8278.275
G2 X128.651 Y132.21 I-1.959 J4.41 E.01631
G1 X127.81 Y132.205 F9000
; LINE_WIDTH: 0.112269
G2 X127.49 Y132.314 I1.287 J4.317 E.00186
G1 X127.043 Y132.467
; LINE_WIDTH: 0.16328
G1 X126.948 Y132.31 E.00174
; LINE_WIDTH: 0.119043
G1 X126.852 Y132.154 E.0011
; WIPE_START
G1 X126.948 Y132.31 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X123.743 Y130.342 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X123.48 Y130.189 E.00906
M73 P63 R7
G1 X123.022 Y130.626 E.01885
G3 X120.493 Y131.267 I-2.006 J-2.604 E.07991
G2 X124.735 Y135.507 I7.531 J-3.292 E.18289
G1 X124.692 Y134.888 E.01851
G3 X125.675 Y132.667 I3.236 J.104 E.07416
G1 X125.398 Y132.104 E.01868
G1 X124.771 Y132.089 E.01868
G1 X124.632 Y132.024 E.00456
G1 X124.459 Y131.327 E.02137
G1 X123.855 Y131.157 E.01868
G1 X123.759 Y131.093 E.00345
G1 X123.719 Y130.955 E.00429
G1 X123.74 Y130.402 E.01649
; WIPE_START
G1 X123.719 Y130.955 E-.21031
G1 X123.759 Y131.093 E-.05479
G1 X123.855 Y131.157 E-.04397
G1 X124.459 Y131.327 E-.2383
G1 X124.594 Y131.87 E-.21262
; WIPE_END
G1 E-.04 F1800
G1 X124.138 Y131.629 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
G1 F6364.866
G1 X123.595 Y131.448 E.01704
G1 X123.464 Y131.328 E.00531
G1 X123.341 Y130.953 E.01173
G1 X123.346 Y130.842 E.00332
G1 X122.802 Y131.22 E.01971
G3 X121.116 Y131.687 I-1.8 J-3.219 E.05263
G2 X124.248 Y134.851 I6.933 J-3.731 E.13444
G1 X124.314 Y134.872 E.00208
G3 X125.223 Y132.597 I3.631 J.13 E.07442
G1 X125.162 Y132.476 E.00404
G1 X124.762 Y132.466 E.01192
G1 X124.472 Y132.378 E.00904
G1 X124.272 Y132.158 E.00885
G1 X124.153 Y131.687 E.01448
G1 X123.817 Y131.93 F9000
G1 F6364.866
G1 X123.387 Y131.762 E.01375
G1 X123.169 Y131.563 E.00881
G1 X123.127 Y131.459 E.00334
G3 X121.736 Y131.998 I-2.247 J-3.733 E.04467
G2 X123.011 Y133.511 I6.552 J-4.225 E.0591
G2 X124.004 Y134.267 I5.276 J-5.903 E.03722
G3 X124.588 Y132.806 I4.423 J.921 E.0471
G1 X124.269 Y132.696 E.01005
G1 X124.061 Y132.515 E.00822
G1 X123.878 Y132.189 E.01115
G1 X123.831 Y131.988 E.00613
G1 X123.499 Y132.229 F9000
G1 F6364.866
G1 X123.18 Y132.077 E.01053
G1 X123.023 Y131.954 E.00592
G1 X122.353 Y132.228 E.02157
G1 X122.678 Y132.634 E.01549
G1 X123.271 Y133.239 E.02524
G2 X123.774 Y133.649 I4.838 J-5.419 E.01933
G1 X124.041 Y132.994 E.02107
G1 X123.775 Y132.761 E.01054
G1 X123.55 Y132.39 E.01292
G1 X123.517 Y132.286 E.00325
G1 X123.163 Y132.545 F9000
; LINE_WIDTH: 0.476597
G1 F5534.077
G1 X123.279 Y132.692 E.00644
; LINE_WIDTH: 0.43023
G1 F6196.587
G1 X123.395 Y132.84 E.00575
; LINE_WIDTH: 0.383864
G1 F7039.293
G1 X123.511 Y132.988 E.00506
; LINE_WIDTH: 0.35206
G1 F7763.473
G1 X123.581 Y133.054 E.00234
; WIPE_START
G1 X123.511 Y132.988 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.496 Y136.779 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970886
G1 F9000
G1 X126.518 Y136.803 E.00014
; LINE_WIDTH: 0.123033
G1 X126.636 Y136.917 E.00103
; LINE_WIDTH: 0.172926
G1 X126.754 Y137.03 E.00168
; LINE_WIDTH: 0.192065
G1 X126.778 Y137.04 E.00031
; LINE_WIDTH: 0.161184
G1 X126.917 Y137.081 E.00136
; LINE_WIDTH: 0.117479
G1 X127.042 Y137.117 E.00077
; WIPE_START
G1 X126.917 Y137.081 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128.953 Y137.122 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.116553
G1 F9000
G1 X129.082 Y137.083 E.00078
; LINE_WIDTH: 0.155827
G1 X129.211 Y137.043 E.0012
; LINE_WIDTH: 0.177565
G1 X129.818 Y136.832 E.00683
G1 X129.793 Y136.794
; LINE_WIDTH: 0.353145
G1 F7736.338
G1 X129.091 Y137.126 E.01903
; WIPE_START
G1 X129.793 Y136.794 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X125.414 Y130.542 Z1.8 F9000
G1 X123.731 Y128.14 Z1.8
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.151067
G1 F9000
G2 X123.731 Y127.86 I-.214 J-.14 E.00254
; WIPE_START
G1 X123.773 Y128 E-.37999
G1 X123.731 Y128.14 E-.38001
; WIPE_END
G1 E-.04 F1800
G1 X123.743 Y125.658 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X123.718 Y125.032 E.01868
G1 X123.779 Y124.886 E.00471
G1 X124.459 Y124.673 E.02123
G1 X124.591 Y124.06 E.01868
G1 X124.674 Y123.94 E.00433
G1 X125.398 Y123.896 E.02159
G1 X125.675 Y123.333 E.01868
G1 X125.301 Y122.907 E.01688
G3 X124.735 Y120.493 I2.614 J-1.887 E.07583
G2 X120.507 Y124.731 I3.269 J7.49 E.18258
G1 X121.035 Y124.692 E.01578
G1 X121.619 Y124.745 E.01745
G3 X123.48 Y125.811 I-.682 J3.349 E.06498
G1 X123.691 Y125.689 E.00728
; WIPE_START
G1 X123.48 Y125.811 E-.09285
G1 X123.379 Y125.693 E-.05914
G1 X122.999 Y125.357 E-.19269
G1 X122.572 Y125.083 E-.19278
G1 X122.108 Y124.878 E-.19265
G1 X122.032 Y124.857 E-.02988
; WIPE_END
G1 E-.04 F1800
G1 X124.138 Y124.371 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
G1 F6364.866
G1 X124.272 Y123.842 E.01627
G1 X124.472 Y123.622 E.00885
G1 X124.762 Y123.534 E.00903
G1 X125.162 Y123.524 E.01192
G1 X125.223 Y123.403 E.00404
G3 X124.318 Y121.185 I2.772 J-2.424 E.07268
G1 X124.299 Y121.119 E.00202
G2 X121.116 Y124.313 I3.779 J6.951 E.13621
G3 X123.346 Y125.158 I-.176 J3.83 E.07223
G1 X123.343 Y124.973 E.00552
G1 X123.523 Y124.609 E.01209
G3 X124.08 Y124.388 I.74 J1.053 E.01803
G1 X123.817 Y124.07 F9000
G1 F6364.866
G1 X123.936 Y123.67 E.01243
G1 X124.121 Y123.42 E.00925
G1 X124.397 Y123.236 E.00988
G1 X124.588 Y123.194 E.00584
G1 X124.278 Y122.612 E.01963
G3 X124.004 Y121.733 I4.57 J-1.904 E.02747
G2 X121.736 Y124.002 I4.028 J6.294 E.09633
G3 X123.127 Y124.542 I-.954 J4.526 E.04464
G1 X123.267 Y124.332 E.00751
G1 X123.563 Y124.147 E.01039
G1 X123.76 Y124.087 E.00613
G1 X123.499 Y123.771 F9000
G1 F6364.866
G1 X123.6 Y123.498 E.00867
G1 X123.86 Y123.149 E.01296
G1 X124.041 Y123.006 E.00688
G3 X123.774 Y122.351 I2.791 J-1.52 E.02111
G2 X122.353 Y123.772 I4.301 J5.725 E.06005
G1 X123.023 Y124.046 E.02157
G1 X123.341 Y123.832 E.01142
G1 X123.443 Y123.793 E.00324
G1 X123.163 Y123.455 F9000
; LINE_WIDTH: 0.476587
G1 F5534.204
G1 X123.279 Y123.308 E.00643
; LINE_WIDTH: 0.43024
G1 F6196.427
G1 X123.395 Y123.16 E.00575
; LINE_WIDTH: 0.383894
G1 F7038.675
G1 X123.511 Y123.012 E.00506
; LINE_WIDTH: 0.35209
G1 F7762.72
G1 X123.581 Y122.946 E.00235
; WIPE_START
G1 X123.511 Y123.012 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.219 Y126.495 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.121723
G1 F9000
G1 X119.097 Y126.623 E.0011
; LINE_WIDTH: 0.174282
G1 X118.974 Y126.75 E.00183
G1 X118.958 Y126.791 E.00046
; LINE_WIDTH: 0.157757
G1 X118.922 Y126.908 E.00111
; LINE_WIDTH: 0.11786
G1 X118.883 Y127.044 E.00083
; WIPE_START
G1 X118.922 Y126.908 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.883 Y128.956 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.117862
G1 F9000
G1 X118.922 Y129.092 E.00083
; LINE_WIDTH: 0.157762
G1 X118.958 Y129.209 E.00111
; LINE_WIDTH: 0.175233
G1 X118.975 Y129.251 E.00047
G1 X119.087 Y129.368 E.00169
; LINE_WIDTH: 0.122744
G1 X119.199 Y129.484 E.00102
; LINE_WIDTH: 0.097082
G1 X119.223 Y129.506 E.00014
; WIPE_START
G1 X119.199 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.832 Y129.494 Z1.8 F9000
G1 X136.781 Y129.506 Z1.8
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.0970648
G1 F9000
G1 X136.805 Y129.484 E.00014
; LINE_WIDTH: 0.122793
G1 X136.918 Y129.367 E.00102
; LINE_WIDTH: 0.172319
G1 X137.03 Y129.251 E.00166
; LINE_WIDTH: 0.188858
G1 X137.042 Y129.219 E.00039
; LINE_WIDTH: 0.158046
G1 X137.083 Y129.084 E.00128
; LINE_WIDTH: 0.116739
G1 X137.121 Y128.959 E.00076
; WIPE_START
G1 X137.083 Y129.084 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.121 Y127.042 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.116767
G1 F9000
G1 X137.083 Y126.916 E.00076
; LINE_WIDTH: 0.158096
G1 X137.042 Y126.781 E.00129
; LINE_WIDTH: 0.188884
G1 X137.03 Y126.749 E.00039
; LINE_WIDTH: 0.17235
G1 X136.918 Y126.633 E.00166
; LINE_WIDTH: 0.122839
G1 X136.805 Y126.516 E.00102
; LINE_WIDTH: 0.0970909
G1 X136.781 Y126.494 E.00014
; OBJECT_ID: 118
; WIPE_START
G1 X136.805 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X129.174 Y126.422 Z1.8 F9000
G1 X103.565 Y126.108 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X103.54 Y125.481 E.02016
G1 X104.143 Y125.311 E.02016
G1 X104.275 Y124.698 E.02016
G1 X104.902 Y124.684 E.02016
G1 X105.182 Y124.123 E.02016
G1 X105.793 Y124.264 E.02016
G1 X106.204 Y123.791 E.02016
G1 X106.76 Y124.08 E.02016
G1 X107.276 Y123.724 E.02016
G1 X107.743 Y124.142 E.02016
G1 X108.331 Y123.925 E.02016
G1 X108.679 Y124.446 E.02016
G1 X109.303 Y124.382 E.02016
G1 X109.51 Y124.974 E.02016
G1 X110.13 Y125.067 E.02016
G1 X110.184 Y125.691 E.02016
G1 X110.762 Y125.936 E.02016
G1 X110.659 Y126.554 E.02016
G1 X111.157 Y126.934 E.02016
G1 X110.904 Y127.508 E.02016
G1 X111.292 Y128 E.02016
G1 X110.904 Y128.492 E.02016
G1 X111.157 Y129.066 E.02016
G1 X110.659 Y129.446 E.02016
G1 X110.762 Y130.064 E.02016
G1 X110.184 Y130.309 E.02016
G1 X110.13 Y130.933 E.02016
G1 X109.51 Y131.026 E.02016
G1 X109.303 Y131.618 E.02016
G1 X108.679 Y131.554 E.02016
G1 X108.331 Y132.075 E.02016
G1 X107.743 Y131.858 E.02016
G1 X107.276 Y132.276 E.02016
G1 X106.76 Y131.92 E.02016
G1 X106.204 Y132.209 E.02016
G1 X105.793 Y131.736 E.02016
G1 X105.182 Y131.877 E.02016
G1 X104.902 Y131.316 E.02016
G1 X104.275 Y131.302 E.02016
G1 X104.143 Y130.689 E.02016
G1 X103.54 Y130.519 E.02016
G1 X103.565 Y129.892 E.02016
G1 X103.023 Y129.577 E.02016
G1 X103.202 Y128.977 E.02016
G1 X102.756 Y128.537 E.02016
G1 X103.079 Y128 E.02016
G1 X102.756 Y127.463 E.02016
G1 X103.202 Y127.023 E.02016
G1 X103.023 Y126.423 E.02016
G1 X103.513 Y126.138 E.01823
G1 X103.981 Y126.337 F9000
G1 F5895.652
G1 X103.959 Y125.786 E.01772
G1 X104.49 Y125.636 E.01772
G1 X104.606 Y125.098 E.01772
G1 X105.157 Y125.085 E.01772
G1 X105.403 Y124.592 E.01772
G1 X105.94 Y124.716 E.01772
G1 X106.301 Y124.3 E.01772
G1 X106.79 Y124.554 E.01772
G1 X107.243 Y124.241 E.01772
G1 X107.654 Y124.608 E.01772
G1 X108.171 Y124.418 E.01772
G1 X108.477 Y124.876 E.01772
G1 X109.025 Y124.82 E.01772
G1 X109.208 Y125.34 E.01772
G1 X109.752 Y125.422 E.01772
G1 X109.8 Y125.971 E.01772
G1 X110.307 Y126.185 E.01772
G1 X110.217 Y126.729 E.01772
G1 X110.655 Y127.063 E.01772
G1 X110.432 Y127.567 E.01772
G1 X110.773 Y128 E.01772
G1 X110.432 Y128.433 E.01772
G1 X110.655 Y128.937 E.01772
G1 X110.217 Y129.271 E.01772
G1 X110.307 Y129.815 E.01772
G1 X109.8 Y130.029 E.01772
G1 X109.752 Y130.578 E.01772
G1 X109.208 Y130.66 E.01772
G1 X109.025 Y131.18 E.01772
G1 X108.477 Y131.124 E.01772
G1 X108.171 Y131.582 E.01772
G1 X107.654 Y131.392 E.01772
G1 X107.243 Y131.759 E.01772
G1 X106.79 Y131.446 E.01772
G1 X106.301 Y131.7 E.01772
G1 X105.94 Y131.284 E.01772
G1 X105.403 Y131.408 E.01772
G1 X105.157 Y130.915 E.01772
G1 X104.606 Y130.902 E.01772
G1 X104.49 Y130.364 E.01772
G1 X103.959 Y130.214 E.01772
G1 X103.981 Y129.663 E.01772
G1 X103.505 Y129.387 E.01772
G1 X103.662 Y128.859 E.01772
G1 X103.27 Y128.472 E.01772
G1 X103.554 Y128 E.01772
G1 X103.27 Y127.528 E.01772
G1 X103.662 Y127.141 E.01772
G1 X103.505 Y126.613 E.01772
G1 X103.929 Y126.367 E.01579
M204 S250
G1 X104.382 Y126.557 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X104.363 Y126.079 E.01424
G1 X104.823 Y125.95 E.01424
G1 X104.924 Y125.482 E.01424
G1 X105.402 Y125.471 E.01424
G1 X105.616 Y125.044 E.01424
G1 X106.081 Y125.151 E.01424
G1 X106.394 Y124.79 E.01424
G1 X106.819 Y125.011 E.01424
G1 X107.212 Y124.739 E.01424
G1 X107.568 Y125.058 E.01424
G1 X108.016 Y124.893 E.01424
G1 X108.282 Y125.29 E.01424
G1 X108.757 Y125.241 E.01424
G1 X108.916 Y125.692 E.01424
G1 X109.389 Y125.763 E.01424
G1 X109.43 Y126.24 E.01424
G1 X109.87 Y126.426 E.01424
G1 X109.792 Y126.897 E.01424
G1 X110.171 Y127.187 E.01424
G1 X109.978 Y127.625 E.01424
G1 X110.274 Y128 E.01424
G1 X109.978 Y128.375 E.01424
G1 X110.171 Y128.813 E.01424
G1 X109.792 Y129.103 E.01424
G1 X109.87 Y129.574 E.01424
G1 X109.43 Y129.76 E.01424
G1 X109.389 Y130.237 E.01424
G1 X108.916 Y130.308 E.01424
G1 X108.757 Y130.759 E.01424
G1 X108.282 Y130.71 E.01424
G1 X108.016 Y131.107 E.01424
G1 X107.568 Y130.942 E.01424
G1 X107.212 Y131.261 E.01424
G1 X106.819 Y130.989 E.01424
G1 X106.394 Y131.21 E.01424
G1 X106.081 Y130.849 E.01424
G1 X105.616 Y130.956 E.01424
G1 X105.402 Y130.529 E.01424
G1 X104.924 Y130.518 E.01424
G1 X104.823 Y130.05 E.01424
G1 X104.363 Y129.921 E.01424
G1 X104.382 Y129.443 E.01424
G1 X103.969 Y129.203 E.01424
G1 X104.106 Y128.745 E.01424
G1 X103.765 Y128.41 E.01424
G1 X104.012 Y128 E.01424
G1 X103.765 Y127.59 E.01424
G1 X104.106 Y127.255 E.01424
G1 X103.969 Y126.797 E.01424
G1 X104.33 Y126.587 E.01245
; WIPE_START
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18163
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02174
; WIPE_END
G1 E-.04 F1800
G1 X104.327 Y119.847 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X104.191 Y120.226 E.01296
G2 X105.706 Y123.614 I2.85 J.758 E.12909
G1 X105.628 Y123.808 E.00673
G1 X104.962 Y123.654 E.022
G1 X104.647 Y124.282 E.02259
G1 X103.945 Y124.299 E.0226
G1 X103.797 Y124.986 E.02259
G1 X103.121 Y125.177 E.0226
G1 X103.148 Y125.879 E.0226
G1 X102.393 Y126.317 E.02808
G2 X98.856 Y125.319 I-2.394 J1.717 E.12761
G3 X104.27 Y119.866 I8.14 J2.667 E.25624
; WIPE_START
G1 X104.191 Y120.226 E-.14024
G1 X104.106 Y120.665 E-.16997
G1 X104.088 Y121.112 E-.16988
G1 X104.14 Y121.556 E-.16982
G1 X104.217 Y121.835 E-.11009
; WIPE_END
G1 E-.04 F1800
G1 X109.682 Y119.833 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
G1 F5895.652
G1 X110.38 Y120.108 E.02413
G3 X115.166 Y125.322 I-3.406 J7.929 E.23451
G2 X111.432 Y126.632 I-1.151 J2.696 E.13966
G1 X111.101 Y126.379 E.01342
G1 X111.216 Y125.686 E.0226
G1 X110.569 Y125.412 E.0226
G1 X110.508 Y124.712 E.02259
G1 X109.813 Y124.607 E.0226
G1 X109.58 Y123.944 E.0226
G1 X108.881 Y124.016 E.0226
G1 X108.526 Y123.484 E.02057
G1 X108.687 Y123.389 E.00601
G2 X109.705 Y119.889 I-1.713 J-2.396 E.12637
; WIPE_START
G1 X110.38 Y120.108 E-.26978
G1 X110.846 Y120.324 E-.19533
G1 X111.298 Y120.567 E-.19492
G1 X111.522 Y120.705 E-.09997
; WIPE_END
G1 E-.04 F1800
G1 X114.141 Y127.874 Z1.8 F9000
G1 X115.165 Y130.678 Z1.8
G1 Z1.4
G1 E.8 F1800
G1 F5895.652
G1 X115.007 Y131.098 E.01445
G3 X109.682 Y136.167 I-8.066 J-3.144 E.24416
G2 X108.526 Y132.516 I-2.679 J-1.16 E.1343
G1 X108.881 Y131.984 E.02057
G1 X109.58 Y132.056 E.0226
G1 X109.813 Y131.393 E.0226
G1 X110.508 Y131.288 E.02259
G1 X110.569 Y130.588 E.02259
G1 X111.216 Y130.314 E.0226
G1 X111.101 Y129.621 E.0226
G1 X111.432 Y129.368 E.01342
G1 X111.618 Y129.68 E.01169
G2 X115.11 Y130.701 I2.395 J-1.712 E.1261
; WIPE_START
G1 X115.007 Y131.098 E-.1561
G1 X114.74 Y131.724 E-.2585
G1 X114.503 Y132.18 E-.19532
G1 X114.301 Y132.519 E-.15008
; WIPE_END
G1 E-.04 F1800
G1 X106.674 Y132.231 Z1.8 F9000
G1 X105.628 Y132.192 Z1.8
G1 Z1.4
G1 E.8 F1800
G1 F5895.652
G1 X105.706 Y132.386 E.00673
G2 X104.327 Y136.153 I1.324 J2.621 E.14203
G3 X98.856 Y130.681 I2.688 J-8.158 E.25811
G2 X102.393 Y129.683 I1.144 J-2.711 E.12764
G1 X103.148 Y130.121 E.02808
G1 X103.121 Y130.823 E.0226
G1 X103.797 Y131.014 E.0226
G1 X103.945 Y131.701 E.02259
G1 X104.647 Y131.718 E.0226
G1 X104.962 Y132.346 E.02259
G1 X105.57 Y132.205 E.02007
; WIPE_START
G1 X105.706 Y132.386 E-.08599
G1 X105.327 Y132.611 E-.16776
G1 X104.982 Y132.896 E-.1699
G1 X104.684 Y133.23 E-.16991
G1 X104.446 Y133.597 E-.16645
; WIPE_END
G1 E-.04 F1800
G1 X106.739 Y126.317 Z1.8 F9000
G1 X108.924 Y119.383 Z1.8
G1 Z1.4
G1 E.8 F1800
G1 F5895.652
G1 X109.02 Y119.238 E.0056
G3 X115.827 Y126.238 I-2.037 J8.79 E.33173
G1 X115.372 Y125.891 E.01838
G1 X115.173 Y125.783 E.00729
G2 X115.372 Y130.109 I-1.164 J2.221 E.33857
G1 X115.827 Y129.762 E.01838
G3 X109.02 Y136.762 I-8.843 J-1.79 E.33173
G1 X108.924 Y136.617 E.0056
G2 X107.037 Y132.49 I-1.922 J-1.616 E.18214
G2 X104.898 Y136.365 I-.021 J2.517 E.17393
G1 X105.24 Y136.814 E.01815
G3 X98.196 Y129.769 I1.772 J-8.816 E.33955
G1 X98.641 Y130.109 E.01801
G2 X98.461 Y126.029 I1.363 J-2.104 E.35306
G1 X98.195 Y126.232 E.01074
G3 X105.24 Y119.186 I8.805 J1.759 E.33964
G1 X104.898 Y119.635 E.01815
G1 X104.79 Y119.834 E.00729
G2 X107.765 Y123.395 I2.218 J1.17 E.19056
G2 X108.962 Y119.43 I-.757 J-2.392 E.1567
G1 X108.556 Y119.579 F9000
M73 P64 R7
G1 F5895.652
G1 X108.577 Y119.601 E.00097
G3 X106.846 Y118.902 I-1.57 J1.396 E.3622
G3 X107.607 Y118.99 I.125 J2.266 E.02475
G1 X107.793 Y119.049 E.00629
G3 X108.345 Y119.377 I-.786 J1.948 E.02073
G1 X108.512 Y119.538 E.00746
M204 S250
G1 X108.283 Y119.862 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X106.876 Y119.294 I-1.276 J1.135 E.27281
G3 X107.488 Y119.363 I.102 J1.85 E.01845
G1 X107.646 Y119.413 E.00493
G3 X108.243 Y119.818 I-.639 J1.584 E.02164
; WIPE_START
G1 X108.443 Y120.07 E-.12219
G1 X108.568 Y120.3 E-.09953
G1 X108.656 Y120.547 E-.09953
G1 X108.706 Y120.804 E-.09951
G1 X108.716 Y121.065 E-.09949
G1 X108.686 Y121.326 E-.09954
G1 X108.617 Y121.578 E-.09953
G1 X108.573 Y121.676 E-.04068
; WIPE_END
G1 E-.04 F1800
G1 X114.8 Y126.089 Z1.8 F9000
G1 X115.652 Y126.693 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X115.811 Y126.927 E.00912
G3 X113.732 Y125.92 I-1.805 J1.076 E.34581
G3 X114.979 Y126.141 I.274 J2.086 E.04135
G3 X115.612 Y126.648 I-.972 J1.862 E.02626
M204 S250
G1 X115.331 Y126.918 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X115.481 Y127.124 E.00757
G3 X113.777 Y126.31 I-1.466 J.878 E.26014
G3 X114.706 Y126.439 I.244 J1.651 E.02834
G3 X115.296 Y126.871 I-.691 J1.562 E.02193
; WIPE_START
G1 X115.481 Y127.124 E-.11901
G1 X115.593 Y127.361 E-.09967
G1 X115.672 Y127.61 E-.09951
G1 X115.712 Y127.869 E-.09953
G1 X115.712 Y128.131 E-.0995
G1 X115.672 Y128.39 E-.09954
G1 X115.593 Y128.639 E-.09953
G1 X115.542 Y128.743 E-.04371
; WIPE_END
G1 E-.04 F1800
G1 X110.293 Y134.284 Z1.8 F9000
G1 X107.755 Y136.963 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X107.486 Y137.048 E.00906
G3 X106.812 Y132.911 I-.48 J-2.045 E.22155
G3 X108.049 Y133.179 I.194 J2.095 E.04135
G3 X107.811 Y136.943 I-1.043 J1.824 E.15057
M204 S250
G1 X107.636 Y136.59 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X107.396 Y136.665 E.00749
G3 X106.842 Y133.302 I-.381 J-1.664 E.16604
G3 X107.766 Y133.467 I.18 J1.66 E.02834
G3 X107.692 Y136.568 I-.75 J1.534 E.11589
; WIPE_START
G1 X107.396 Y136.665 E-.11829
G1 X107.138 Y136.706 E-.09951
G1 X106.876 Y136.706 E-.0995
G1 X106.617 Y136.666 E-.09953
G1 X106.367 Y136.587 E-.09953
G1 X106.133 Y136.47 E-.0995
G1 X105.918 Y136.32 E-.09952
G1 X105.834 Y136.238 E-.04462
; WIPE_END
G1 E-.04 F1800
G1 X102.457 Y129.394 Z1.8 F9000
G1 X102.035 Y128.539 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X102.018 Y128.637 E.00319
G3 X99.892 Y125.905 I-2.003 J-.634 E.2937
G3 X101.282 Y126.327 I.109 J2.145 E.04765
G3 X102.091 Y128.322 I-1.267 J1.676 E.07269
G1 X102.05 Y128.481 E.00528
M204 S250
G1 X101.648 Y128.438 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X101.612 Y128.609 E.00521
G3 X99.907 Y126.297 I-1.597 J-.608 E.21806
G3 X100.824 Y126.497 I.117 J1.665 E.02834
G3 X101.703 Y128.262 I-.809 J1.505 E.06261
G1 X101.666 Y128.381 E.00372
; WIPE_START
G1 X101.612 Y128.609 E-.08914
G1 X101.54 Y128.759 E-.06306
G1 X101.406 Y128.984 E-.09953
G1 X101.239 Y129.186 E-.09953
G1 X101.044 Y129.36 E-.09951
G1 X100.824 Y129.503 E-.09953
G1 X100.492 Y129.635 E-.13586
G1 X100.332 Y129.679 E-.06285
G1 X100.304 Y129.683 E-.01098
; WIPE_END
G1 E-.04 F1800
G1 X103.946 Y122.976 Z1.8 F9000
G1 X106.305 Y118.633 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G3 X107.237 Y118.609 I.712 J9.481 E.02999
G3 X103.573 Y119.252 I-.24 J9.392 E1.77791
G3 X106.245 Y118.638 I3.444 J8.862 E.08846
M204 S250
G1 X106.275 Y118.237 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X106.276 Y118.241 E.00012
G3 X107.243 Y118.217 I.731 J9.758 E.02883
G3 X116.2 Y124.646 I-.238 J9.785 E.34884
G3 X105.693 Y118.303 I-9.193 J3.354 E1.43631
G1 X106.216 Y118.244 E.01566
G1 X106.047 Y118.883 F9000
; FEATURE: Gap infill
; LINE_WIDTH: 0.117505
G1 X105.922 Y118.919 E.00077
; LINE_WIDTH: 0.161221
G1 X105.782 Y118.96 E.00136
; LINE_WIDTH: 0.192078
G1 X105.758 Y118.97 E.00031
; LINE_WIDTH: 0.172941
G1 X105.64 Y119.083 E.00168
; LINE_WIDTH: 0.12303
G1 X105.522 Y119.197 E.00103
; LINE_WIDTH: 0.0970818
G1 X105.501 Y119.221 E.00014
; WIPE_START
G1 X105.522 Y119.197 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.958 Y118.878 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.116549
G1 F9000
G1 X108.087 Y118.917 E.00078
; LINE_WIDTH: 0.155821
G1 X108.216 Y118.957 E.0012
; LINE_WIDTH: 0.177556
G1 X108.822 Y119.168 E.00683
G1 X108.797 Y119.206
; LINE_WIDTH: 0.353121
G1 F7736.933
G1 X108.095 Y118.874 E.01903
; WIPE_START
G1 X108.797 Y119.206 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.938 Y123.477 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.103381
G1 F9000
G1 X108.834 Y123.578 E.00069
G1 X108.325 Y123.55
; LINE_WIDTH: 0.332807
G1 F8279.093
G3 X107.655 Y123.79 I-1.958 J-4.407 E.01631
G1 X106.815 Y123.794 F9000
; LINE_WIDTH: 0.112264
G3 X106.494 Y123.686 I1.212 J-4.113 E.00186
G1 X106.048 Y123.533
; LINE_WIDTH: 0.163281
G1 X105.952 Y123.69 E.00174
; LINE_WIDTH: 0.119042
G1 X105.857 Y123.846 E.0011
; WIPE_START
G1 X105.952 Y123.69 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X102.747 Y125.658 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X102.723 Y125.032 E.01868
G1 X102.783 Y124.886 E.00471
G1 X103.463 Y124.673 E.02123
G1 X103.595 Y124.06 E.01868
G1 X103.679 Y123.94 E.00433
G1 X104.402 Y123.896 E.02159
G1 X104.679 Y123.333 E.01868
G1 X104.306 Y122.907 E.01688
G3 X103.74 Y120.493 I2.614 J-1.887 E.07583
G2 X99.511 Y124.731 I3.269 J7.49 E.18258
G1 X100.039 Y124.692 E.01578
G1 X100.623 Y124.745 E.01745
G3 X102.484 Y125.811 I-.682 J3.349 E.06498
G1 X102.695 Y125.689 E.00728
; WIPE_START
G1 X102.484 Y125.811 E-.09285
G1 X102.383 Y125.693 E-.05914
G1 X102.003 Y125.357 E-.19269
G1 X101.576 Y125.083 E-.19278
G1 X101.113 Y124.878 E-.19265
G1 X101.037 Y124.857 E-.02988
; WIPE_END
G1 E-.04 F1800
G1 X103.143 Y124.371 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
G1 F6364.866
G1 X103.276 Y123.842 E.01627
G1 X103.476 Y123.622 E.00885
G1 X103.766 Y123.534 E.00903
G1 X104.166 Y123.524 E.01192
G1 X104.227 Y123.403 E.00404
G3 X103.323 Y121.185 I2.772 J-2.424 E.07268
G1 X103.304 Y121.119 E.00202
G2 X100.12 Y124.313 I3.779 J6.951 E.13621
G3 X102.35 Y125.158 I-.176 J3.83 E.07223
G1 X102.348 Y124.973 E.00552
G1 X102.527 Y124.609 E.01209
G3 X103.085 Y124.388 I.74 J1.053 E.01803
G1 X102.822 Y124.07 F9000
G1 F6364.866
G1 X102.941 Y123.67 E.01243
G1 X103.126 Y123.42 E.00925
G1 X103.401 Y123.236 E.00988
G1 X103.593 Y123.194 E.00584
G1 X103.282 Y122.612 E.01963
G3 X103.009 Y121.733 I4.57 J-1.904 E.02747
G2 X100.74 Y124.002 I4.028 J6.294 E.09633
G3 X102.132 Y124.542 I-.954 J4.526 E.04464
G1 X102.272 Y124.332 E.00751
G1 X102.567 Y124.147 E.01039
G1 X102.764 Y124.087 E.00613
G1 X102.503 Y123.771 F9000
G1 F6364.866
G1 X102.605 Y123.498 E.00867
G1 X102.864 Y123.149 E.01296
G1 X103.046 Y123.006 E.00688
G3 X102.779 Y122.351 I2.791 J-1.52 E.02111
G2 X101.357 Y123.772 I4.301 J5.725 E.06005
G1 X102.027 Y124.046 E.02157
G1 X102.346 Y123.832 E.01142
G1 X102.447 Y123.793 E.00324
G1 X102.167 Y123.455 F9000
; LINE_WIDTH: 0.476587
G1 F5534.204
G1 X102.283 Y123.308 E.00643
; LINE_WIDTH: 0.43024
G1 F6196.427
G1 X102.399 Y123.16 E.00575
; LINE_WIDTH: 0.383894
G1 F7038.675
G1 X102.516 Y123.012 E.00506
; LINE_WIDTH: 0.35209
G1 F7762.72
G1 X102.586 Y122.946 E.00235
; WIPE_START
G1 X102.516 Y123.012 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X102.736 Y127.86 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.151067
G1 F9000
G3 X102.736 Y128.14 I-.213 J.14 E.00254
; WIPE_START
G1 X102.778 Y128 E-.38001
G1 X102.736 Y127.86 E-.37999
; WIPE_END
G1 E-.04 F1800
G1 X102.747 Y130.342 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X102.484 Y130.189 E.00906
G1 X102.026 Y130.626 E.01885
G3 X99.497 Y131.267 I-2.006 J-2.604 E.07991
G2 X103.74 Y135.507 I7.531 J-3.292 E.18289
G1 X103.696 Y134.888 E.01851
G3 X104.679 Y132.667 I3.236 J.104 E.07416
G1 X104.402 Y132.104 E.01868
G1 X103.775 Y132.089 E.01868
G1 X103.637 Y132.024 E.00456
G1 X103.463 Y131.327 E.02137
G1 X102.86 Y131.157 E.01868
G1 X102.764 Y131.093 E.00345
G1 X102.723 Y130.955 E.00429
G1 X102.745 Y130.402 E.01649
; WIPE_START
G1 X102.723 Y130.955 E-.21031
G1 X102.764 Y131.093 E-.05479
G1 X102.86 Y131.157 E-.04397
G1 X103.463 Y131.327 E-.2383
G1 X103.599 Y131.87 E-.21262
; WIPE_END
G1 E-.04 F1800
G1 X103.143 Y131.629 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
G1 F6364.866
G1 X102.6 Y131.448 E.01704
G1 X102.468 Y131.328 E.00531
G1 X102.346 Y130.953 E.01173
G1 X102.35 Y130.842 E.00332
G1 X101.807 Y131.22 E.01971
G3 X100.12 Y131.687 I-1.8 J-3.219 E.05263
G2 X103.252 Y134.851 I6.933 J-3.731 E.13444
G1 X103.319 Y134.872 E.00208
G3 X104.227 Y132.597 I3.631 J.13 E.07442
M73 P65 R7
G1 X104.166 Y132.476 E.00404
G1 X103.766 Y132.466 E.01192
G1 X103.476 Y132.378 E.00904
G1 X103.276 Y132.158 E.00885
G1 X103.157 Y131.687 E.01448
G1 X102.822 Y131.93 F9000
G1 F6364.866
G1 X102.392 Y131.762 E.01375
G1 X102.173 Y131.563 E.00881
G1 X102.132 Y131.459 E.00334
G3 X100.74 Y131.998 I-2.247 J-3.733 E.04467
G2 X102.015 Y133.511 I6.552 J-4.225 E.0591
G2 X103.009 Y134.267 I5.276 J-5.903 E.03722
G3 X103.593 Y132.806 I4.423 J.921 E.0471
G1 X103.274 Y132.696 E.01005
G1 X103.065 Y132.515 E.00822
G1 X102.882 Y132.189 E.01115
G1 X102.835 Y131.988 E.00613
G1 X102.503 Y132.229 F9000
G1 F6364.866
G1 X102.184 Y132.077 E.01053
G1 X102.028 Y131.954 E.00592
G1 X101.357 Y132.228 E.02157
G1 X101.682 Y132.634 E.01549
G1 X102.276 Y133.239 E.02524
G2 X102.779 Y133.649 I4.838 J-5.419 E.01933
G1 X103.046 Y132.994 E.02107
G1 X102.779 Y132.761 E.01054
G1 X102.554 Y132.39 E.01292
G1 X102.521 Y132.286 E.00325
G1 X102.167 Y132.545 F9000
; LINE_WIDTH: 0.476597
G1 F5534.077
G1 X102.283 Y132.692 E.00644
; LINE_WIDTH: 0.43023
G1 F6196.587
G1 X102.4 Y132.84 E.00575
; LINE_WIDTH: 0.383864
G1 F7039.293
G1 X102.516 Y132.988 E.00506
; LINE_WIDTH: 0.35206
G1 F7763.473
G1 X102.586 Y133.054 E.00234
; WIPE_START
G1 X102.516 Y132.988 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.857 Y132.154 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.119043
G1 F9000
G1 X105.952 Y132.31 E.0011
; LINE_WIDTH: 0.16328
G1 X106.048 Y132.467 E.00174
G1 X106.494 Y132.314
; LINE_WIDTH: 0.112269
G3 X106.815 Y132.205 I1.608 J4.208 E.00186
G1 X107.655 Y132.21
; LINE_WIDTH: 0.332836
G1 F8278.275
G3 X108.325 Y132.45 I-1.289 J4.65 E.01631
G1 X108.834 Y132.422 F9000
; LINE_WIDTH: 0.103325
G1 X108.938 Y132.522 E.00069
; WIPE_START
G1 X108.834 Y132.422 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.402 Y133.019 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42456
G1 F6288.649
G1 X111.464 Y132.975 E.00229
; LINE_WIDTH: 0.39912
G1 F6737.788
G1 X111.526 Y132.931 E.00214
G1 X110.945 Y132.761 F9000
; LINE_WIDTH: 0.424387
G1 F6291.5
G1 X110.9 Y132.86 E.0033
G3 X111.238 Y133.645 I-4.255 J2.3 E.02578
G2 X111.899 Y133.055 I-1.934 J-2.829 E.02678
; LINE_WIDTH: 0.485444
G1 F5423.443
G1 X112.03 Y132.888 E.00738
; LINE_WIDTH: 0.52237
G1 F5005.736
G1 X112.16 Y132.722 E.008
; LINE_WIDTH: 0.574311
G1 F4516.449
G3 X112.525 Y132.27 I12.457 J9.66 E.02441
G1 X111.972 Y132.034 E.02524
G1 X111.737 Y132.395 E.01808
; LINE_WIDTH: 0.550705
G1 F4726.41
G1 X111.642 Y132.453 E.00447
; LINE_WIDTH: 0.512055
G1 F5115.799
G1 X111.546 Y132.511 E.00413
; LINE_WIDTH: 0.473405
G1 F5575.107
G1 X111.451 Y132.569 E.00379
; LINE_WIDTH: 0.437035
G1 F6089.593
G1 X111.001 Y132.739 E.01498
G1 X110.666 Y132.423 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X110.536 Y132.745 E.01032
G1 X110.44 Y132.836 E.00396
G3 X111.005 Y134.267 I-3.86 J2.351 E.04607
G2 X113.272 Y132.002 I-4.06 J-6.33 E.09619
G3 X112.129 Y131.605 I.806 J-4.168 E.03617
G1 X111.773 Y131.539 E.01078
G1 X111.631 Y131.58 E.00439
G1 X111.567 Y131.828 E.00763
G1 X111.369 Y132.127 E.0107
G1 X111.086 Y132.324 E.01025
G1 X110.725 Y132.41 E.01108
G1 X110.386 Y132.084 F9000
G1 F6364.866
G1 X110.21 Y132.556 E.01501
G1 X109.966 Y132.798 E.01022
G3 X110.694 Y134.885 I-3.204 J2.287 E.06672
G2 X113.893 Y131.687 I-3.691 J-6.891 E.1367
G3 X112.101 Y131.147 I.102 J-3.583 E.05638
G1 X111.97 Y131.186 E.00408
G1 X111.737 Y131.147 E.00703
G1 X111.534 Y131.216 E.0064
G1 X111.291 Y131.166 E.00739
G1 X111.222 Y131.676 E.01533
G1 X111.1 Y131.862 E.00663
G1 X110.855 Y132.009 E.00851
G1 X110.445 Y132.075 E.01236
G1 X110.105 Y131.745 F9000
; LINE_WIDTH: 0.41999
G1 F6364.876
G1 X109.897 Y132.337 E.01868
G1 X109.771 Y132.456 E.00517
G1 X109.407 Y132.432 E.01086
G1 X109.429 Y132.566 E.00404
G1 X109.339 Y132.671 E.00413
G1 X109.65 Y133.003 E.01356
G3 X110.273 Y135.51 I-2.622 J1.983 E.07906
G2 X114.508 Y131.268 I-3.282 J-7.512 E.18278
G1 X113.894 Y131.311 E.01833
G3 X112.122 Y130.704 I.097 J-3.175 E.05663
G1 X111.981 Y130.809 E.00526
G1 X111.701 Y130.754 E.00849
G1 X111.469 Y130.845 E.00742
G3 X111.249 Y130.726 I-.028 J-.21 E.00794
G1 X110.939 Y130.857 E.01004
G1 X110.885 Y131.482 E.01868
G1 X110.803 Y131.621 E.00481
G1 X110.164 Y131.735 E.01934
; WIPE_START
G1 X110.803 Y131.621 E-.24675
G1 X110.885 Y131.482 E-.06136
G1 X110.939 Y130.857 E-.23828
G1 X111.249 Y130.726 E-.12811
G1 X111.333 Y130.817 E-.04705
G1 X111.432 Y130.837 E-.03845
; WIPE_END
G1 E-.04 F1800
G1 X111.399 Y130.173 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.233232
G1 F9000
G1 X111.851 Y130.266 E.00694
G1 X111.62 Y130.364
; LINE_WIDTH: 0.157653
G3 X111.349 Y129.687 I8.781 J-3.908 E.00661
G1 X111.459 Y129.091
; LINE_WIDTH: 0.173499
G3 X111.351 Y128.835 I3.288 J-1.534 E.00287
; LINE_WIDTH: 0.192489
G1 X111.283 Y128.631 E.00254
; LINE_WIDTH: 0.2218
G1 X111.215 Y128.426 E.00304
G1 X111.215 Y127.574
; LINE_WIDTH: 0.221822
G1 X111.283 Y127.369 E.00304
; LINE_WIDTH: 0.192506
G1 X111.351 Y127.165 E.00255
; LINE_WIDTH: 0.173535
G3 X111.459 Y126.909 I3.447 J1.3 E.00287
G1 X111.349 Y126.313
; LINE_WIDTH: 0.157693
G3 X111.621 Y125.636 I8.904 J3.177 E.00661
G1 X111.851 Y125.734
; LINE_WIDTH: 0.23345
G1 X111.399 Y125.827 E.00695
; WIPE_START
G1 X111.851 Y125.734 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.402 Y122.981 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.413235
G1 F6480.969
G1 X111.64 Y123.176 E.009
; LINE_WIDTH: 0.35802
G1 F7616.64
G3 X112.051 Y123.574 I-.897 J1.338 E.01431
; WIPE_START
G1 X111.878 Y123.371 E-.35244
G1 X111.64 Y123.176 E-.40756
; WIPE_END
M73 P65 R6
G1 E-.04 F1800
G1 X110.945 Y123.239 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X111.242 Y123.333 E.00928
G1 X111.637 Y123.608 E.01435
G3 X111.96 Y124.057 I-1.928 J1.724 E.0165
G1 X112.657 Y123.772 E.02243
G2 X111.238 Y122.355 I-6.311 J4.901 E.05986
G3 X110.9 Y123.14 I-6.814 J-2.474 E.02546
G1 X110.92 Y123.185 E.00148
G1 X110.666 Y123.577 F9000
G1 F6364.866
G1 X111.086 Y123.676 E.01287
G1 X111.407 Y123.914 E.0119
G1 X111.572 Y124.183 E.00939
G1 X111.631 Y124.42 E.00729
G1 X111.818 Y124.452 E.00565
G1 X112.128 Y124.395 E.0094
G3 X113.272 Y123.998 I1.951 J3.775 E.03617
G2 X111.005 Y121.733 I-6.302 J4.04 E.0962
G1 X110.871 Y122.254 E.01604
G1 X110.612 Y122.878 E.02012
G1 X110.44 Y123.164 E.00995
G3 X110.646 Y123.52 I-.433 J.488 E.01246
G1 X110.386 Y123.916 F9000
G1 F6364.866
G1 X110.931 Y124.019 E.01653
G1 X111.123 Y124.162 E.00714
G1 X111.248 Y124.405 E.00812
G1 X111.291 Y124.834 E.01284
G1 X111.534 Y124.784 E.00739
G1 X111.737 Y124.853 E.0064
G1 X112.066 Y124.819 E.00984
G1 X112.101 Y124.853 E.00145
G1 X112.685 Y124.559 E.01947
G1 X113.262 Y124.387 E.01793
G3 X113.893 Y124.313 I.98 J5.63 E.01892
G2 X112.059 Y122.039 I-7.221 J3.947 E.08747
G1 X111.328 Y121.49 E.02724
G2 X110.694 Y121.115 I-4.423 J6.743 E.02196
G3 X110.268 Y122.724 I-4.122 J-.23 E.04992
G1 X109.966 Y123.202 E.01683
G1 X110.253 Y123.538 E.01317
G1 X110.366 Y123.859 E.01013
G1 X110.105 Y124.255 F9000
G1 F6364.866
G1 X110.725 Y124.348 E.01868
G1 X110.855 Y124.431 E.00458
G3 X110.939 Y125.143 I-8.728 J1.395 E.02136
G1 X111.262 Y125.269 E.01033
G1 X111.333 Y125.183 E.00334
G1 X111.508 Y125.166 E.00522
G1 X111.701 Y125.245 E.0062
G1 X112.013 Y125.193 E.00943
G1 X112.123 Y125.296 E.0045
G1 X112.437 Y125.083 E.01131
G3 X114.514 Y124.733 I1.581 J3.041 E.06378
G2 X110.276 Y120.502 I-7.541 J3.316 E.18257
G1 X110.317 Y121.112 E.01822
G3 X109.339 Y123.329 I-3.236 J-.104 E.07395
G1 X109.43 Y123.434 E.00414
G1 X109.407 Y123.568 E.00405
G1 X109.803 Y123.557 E.01179
G1 X109.897 Y123.663 E.00423
G1 X110.085 Y124.198 E.01689
; WIPE_START
G1 X109.897 Y123.663 E-.21549
G1 X109.803 Y123.557 E-.05396
G1 X109.407 Y123.568 E-.15047
G1 X109.43 Y123.434 E-.05163
G1 X109.339 Y123.329 E-.05278
G1 X109.65 Y122.997 E-.17272
G1 X109.739 Y122.857 E-.06295
; WIPE_END
G1 E-.04 F1800
G1 X115.786 Y126.494 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970909
G1 F9000
G1 X115.81 Y126.516 E.00014
; LINE_WIDTH: 0.122839
G1 X115.922 Y126.633 E.00102
; LINE_WIDTH: 0.17235
G1 X116.035 Y126.749 E.00166
; LINE_WIDTH: 0.188884
G1 X116.047 Y126.781 E.00039
; LINE_WIDTH: 0.158096
G1 X116.088 Y126.916 E.00129
; LINE_WIDTH: 0.116767
G1 X116.125 Y127.042 E.00076
; WIPE_START
G1 X116.088 Y126.916 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.125 Y128.959 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.116739
G1 F9000
G1 X116.088 Y129.084 E.00076
; LINE_WIDTH: 0.158046
G1 X116.047 Y129.219 E.00128
; LINE_WIDTH: 0.188858
G1 X116.035 Y129.251 E.00039
; LINE_WIDTH: 0.172319
G1 X115.922 Y129.367 E.00166
; LINE_WIDTH: 0.122793
G1 X115.81 Y129.484 E.00102
; LINE_WIDTH: 0.0970648
G1 X115.786 Y129.506 E.00014
; WIPE_START
G1 X115.81 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.526 Y134.992 Z1.8 F9000
G1 X108.797 Y136.794 Z1.8
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.353145
G1 F7736.338
G1 X108.095 Y137.126 E.01903
G1 X108.087 Y137.083 F9000
; LINE_WIDTH: 0.116553
G1 X107.958 Y137.122 E.00078
G1 X108.087 Y137.083
; LINE_WIDTH: 0.155827
G1 X108.216 Y137.043 E.0012
; LINE_WIDTH: 0.177565
G1 X108.822 Y136.832 E.00683
; WIPE_START
G1 X108.216 Y137.043 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X106.047 Y137.117 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.117479
G1 F9000
G1 X105.922 Y137.081 E.00077
; LINE_WIDTH: 0.161184
G1 X105.782 Y137.04 E.00136
; LINE_WIDTH: 0.192065
G1 X105.758 Y137.03 E.00031
; LINE_WIDTH: 0.172926
G1 X105.64 Y136.917 E.00168
; LINE_WIDTH: 0.123033
G1 X105.522 Y136.803 E.00103
; LINE_WIDTH: 0.0970886
G1 X105.501 Y136.779 E.00014
; WIPE_START
G1 X105.522 Y136.803 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.126 Y131.405 Z1.8 F9000
G1 X98.228 Y129.506 Z1.8
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.097082
G1 F9000
G1 X98.204 Y129.484 E.00014
; LINE_WIDTH: 0.122744
G1 X98.092 Y129.368 E.00102
; LINE_WIDTH: 0.175233
G1 X97.979 Y129.251 E.00169
G1 X97.963 Y129.209 E.00047
; LINE_WIDTH: 0.157762
G1 X97.926 Y129.092 E.00111
; LINE_WIDTH: 0.117862
G1 X97.888 Y128.956 E.00083
; WIPE_START
G1 X97.926 Y129.092 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X97.888 Y127.044 Z1.8 F9000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.11786
G1 F9000
G1 X97.926 Y126.908 E.00083
; LINE_WIDTH: 0.157757
G1 X97.963 Y126.791 E.00111
; LINE_WIDTH: 0.174282
G1 X97.979 Y126.75 E.00046
G1 X98.101 Y126.623 E.00183
; LINE_WIDTH: 0.121723
G1 X98.224 Y126.495 E.0011
; CHANGE_LAYER
; Z_HEIGHT: 1.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F9000
G1 X98.101 Y126.623 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 118
M625
; layer num/total_layer_count: 8/23
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
M106 S163.2
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G17
G3 Z1.8 I-.388 J1.153 P1  F9000
G1 X128.784 Y136.94 Z1.8
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X128.691 Y136.986 E.00333
G3 X127.784 Y132.913 I-.681 J-1.986 E.22715
G3 X129.213 Y133.279 I.212 J2.14 E.04839
G3 X129.077 Y136.808 I-1.203 J1.721 E.13493
G1 X128.839 Y136.916 E.00841
M204 S250
G1 X128.624 Y136.585 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X128.573 Y136.614 E.00175
G3 X127.814 Y133.304 I-.564 J-1.613 E.1712
G3 X128.761 Y133.467 I.201 J1.665 E.02903
G3 X128.878 Y136.473 I-.752 J1.534 E.10956
G1 X128.679 Y136.561 E.00647
; WIPE_START
G1 X128.573 Y136.614 E-.04502
G1 X128.392 Y136.666 E-.07168
G1 X128.133 Y136.706 E-.0995
G1 X127.871 Y136.706 E-.09955
G1 X127.613 Y136.666 E-.09948
G1 X127.363 Y136.587 E-.09956
G1 X127.128 Y136.47 E-.0995
G1 X126.914 Y136.32 E-.09954
G1 X126.826 Y136.235 E-.04618
; WIPE_END
G1 E-.04 F1800
G1 X132.301 Y130.918 Z2 F9000
G1 X136.649 Y126.695 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X136.805 Y126.928 E.00904
G3 X134.819 Y130.09 I-1.804 J1.072 E.14806
G3 X134.705 Y125.923 I.184 J-2.09 E.19643
G3 X136.608 Y126.65 I.297 J2.077 E.06843
M204 S250
G1 X136.328 Y126.92 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X136.476 Y127.124 E.00749
G3 X134.75 Y126.312 I-1.466 J.876 E.25942
G3 X135.702 Y126.439 I.264 J1.655 E.02903
G3 X136.292 Y126.873 I-.693 J1.562 E.022
; WIPE_START
G1 X136.476 Y127.124 E-.11814
G1 X136.589 Y127.361 E-.09963
G1 X136.668 Y127.61 E-.09951
G1 X136.708 Y127.869 E-.09954
G1 X136.708 Y128.131 E-.09952
G1 X136.646 Y128.46 E-.1272
G1 X136.589 Y128.639 E-.07159
G1 X136.536 Y128.745 E-.04487
; WIPE_END
G1 E-.04 F1800
G1 X131.91 Y122.675 Z2 F9000
G1 X129.551 Y119.579 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X129.572 Y119.601 E.00098
G3 X127.841 Y118.902 I-1.57 J1.396 E.36224
G3 X128.58 Y118.983 I.124 J2.3 E.02402
G1 X128.789 Y119.049 E.00703
G3 X129.341 Y119.377 I-.786 J1.948 E.02073
G1 X129.508 Y119.538 E.00745
M204 S250
G1 X129.279 Y119.862 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X129.279 Y119.862 E.00002
G3 X127.871 Y119.294 I-1.276 J1.135 E.27283
G3 X128.462 Y119.357 I.099 J1.894 E.01777
G1 X128.642 Y119.413 E.00561
G3 X129.09 Y119.681 I-.639 J1.584 E.01561
G1 X129.236 Y119.82 E.006
; WIPE_START
G1 X129.279 Y119.862 E-.02293
G1 X129.438 Y120.07 E-.09949
G1 X129.563 Y120.3 E-.09952
G1 X129.652 Y120.547 E-.09952
G1 X129.702 Y120.804 E-.09952
G1 X129.712 Y121.065 E-.09949
G1 X129.682 Y121.326 E-.09955
G1 X129.612 Y121.578 E-.09951
G1 X129.569 Y121.675 E-.04047
; WIPE_END
G1 E-.04 F1800
G1 X124.56 Y126.108 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X124.536 Y125.481 E.02016
G1 X125.139 Y125.311 E.02016
G1 X125.271 Y124.698 E.02015
G1 X125.898 Y124.684 E.02016
G1 X126.178 Y124.123 E.02016
G1 X126.788 Y124.264 E.02016
M73 P66 R6
G1 X127.199 Y123.791 E.02016
G1 X127.756 Y124.08 E.02016
G1 X128.271 Y123.724 E.02016
G1 X128.738 Y124.142 E.02016
G1 X129.326 Y123.925 E.02016
G1 X129.675 Y124.446 E.02016
G1 X130.298 Y124.382 E.02016
G1 X130.506 Y124.974 E.02016
G1 X131.126 Y125.067 E.02016
G1 X131.18 Y125.691 E.02016
G1 X131.757 Y125.936 E.02016
G1 X131.654 Y126.554 E.02016
G1 X132.153 Y126.934 E.02016
G1 X131.899 Y127.508 E.02016
G1 X132.287 Y128 E.02016
G1 X131.899 Y128.492 E.02016
G1 X132.153 Y129.066 E.02016
G1 X131.654 Y129.446 E.02016
G1 X131.757 Y130.064 E.02016
G1 X131.18 Y130.309 E.02016
G1 X131.126 Y130.933 E.02016
G1 X130.506 Y131.026 E.02016
G1 X130.298 Y131.618 E.02015
G1 X129.675 Y131.554 E.02016
G1 X129.326 Y132.075 E.02016
G1 X128.738 Y131.858 E.02016
G1 X128.271 Y132.277 E.02016
G1 X127.756 Y131.92 E.02016
G1 X127.199 Y132.209 E.02016
G1 X126.788 Y131.736 E.02016
G1 X126.178 Y131.877 E.02016
G1 X125.898 Y131.316 E.02016
G1 X125.271 Y131.302 E.02016
G1 X125.139 Y130.689 E.02016
G1 X124.536 Y130.519 E.02016
G1 X124.56 Y129.892 E.02016
G1 X124.018 Y129.577 E.02016
G1 X124.198 Y128.977 E.02016
G1 X123.751 Y128.537 E.02016
G1 X124.074 Y128 E.02016
G1 X123.751 Y127.463 E.02016
G1 X124.198 Y127.023 E.02016
G1 X124.018 Y126.423 E.02016
G1 X124.508 Y126.138 E.01823
G1 X124.977 Y126.337 F9000
G1 F5895.652
G1 X124.955 Y125.786 E.01772
G1 X125.485 Y125.636 E.01772
G1 X125.601 Y125.098 E.01772
G1 X126.152 Y125.085 E.01772
G1 X126.398 Y124.592 E.01772
G1 X126.935 Y124.716 E.01772
G1 X127.296 Y124.3 E.01772
G1 X127.785 Y124.554 E.01772
G1 X128.239 Y124.241 E.01772
G1 X128.649 Y124.608 E.01772
G1 X129.166 Y124.418 E.01772
G1 X129.472 Y124.876 E.01772
G1 X130.021 Y124.82 E.01772
G1 X130.203 Y125.34 E.01772
G1 X130.748 Y125.422 E.01772
G1 X130.796 Y125.971 E.01772
G1 X131.303 Y126.185 E.01772
G1 X131.213 Y126.729 E.01772
G1 X131.651 Y127.063 E.01772
G1 X131.428 Y127.567 E.01772
G1 X131.769 Y128 E.01772
G1 X131.428 Y128.433 E.01772
G1 X131.651 Y128.937 E.01772
G1 X131.213 Y129.271 E.01772
G1 X131.303 Y129.815 E.01772
G1 X130.796 Y130.029 E.01772
G1 X130.748 Y130.578 E.01772
G1 X130.203 Y130.66 E.01772
G1 X130.021 Y131.18 E.01772
G1 X129.472 Y131.124 E.01772
G1 X129.166 Y131.582 E.01772
G1 X128.649 Y131.392 E.01772
G1 X128.239 Y131.759 E.01772
G1 X127.785 Y131.446 E.01772
G1 X127.296 Y131.7 E.01772
G1 X126.935 Y131.284 E.01772
G1 X126.398 Y131.408 E.01772
G1 X126.152 Y130.915 E.01772
G1 X125.601 Y130.902 E.01772
G1 X125.485 Y130.364 E.01772
G1 X124.955 Y130.214 E.01772
G1 X124.977 Y129.663 E.01772
G1 X124.5 Y129.387 E.01772
G1 X124.658 Y128.859 E.01772
G1 X124.265 Y128.472 E.01772
G1 X124.55 Y128 E.01772
G1 X124.265 Y127.528 E.01772
G1 X124.658 Y127.141 E.01772
G1 X124.5 Y126.613 E.01772
G1 X124.925 Y126.367 E.01579
M204 S250
G1 X125.378 Y126.557 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X125.359 Y126.079 E.01424
G1 X125.819 Y125.95 E.01424
G1 X125.92 Y125.482 E.01424
G1 X126.397 Y125.471 E.01424
G1 X126.611 Y125.044 E.01424
G1 X127.077 Y125.151 E.01424
G1 X127.39 Y124.79 E.01424
G1 X127.814 Y125.011 E.01424
G1 X128.207 Y124.739 E.01424
G1 X128.563 Y125.058 E.01424
G1 X129.012 Y124.893 E.01424
G1 X129.277 Y125.29 E.01424
G1 X129.753 Y125.241 E.01424
G1 X129.911 Y125.692 E.01424
G1 X130.384 Y125.763 E.01424
G1 X130.425 Y126.24 E.01424
G1 X130.865 Y126.426 E.01424
G1 X130.787 Y126.897 E.01424
G1 X131.167 Y127.187 E.01424
G1 X130.974 Y127.625 E.01424
G1 X131.27 Y128 E.01424
G1 X130.974 Y128.375 E.01424
G1 X131.167 Y128.813 E.01424
G1 X130.787 Y129.103 E.01424
G1 X130.865 Y129.574 E.01424
G1 X130.425 Y129.76 E.01424
G1 X130.384 Y130.237 E.01424
G1 X129.911 Y130.308 E.01424
G1 X129.753 Y130.759 E.01424
G1 X129.277 Y130.71 E.01424
G1 X129.012 Y131.107 E.01424
G1 X128.563 Y130.942 E.01424
G1 X128.207 Y131.261 E.01424
G1 X127.814 Y130.989 E.01424
G1 X127.39 Y131.21 E.01424
G1 X127.077 Y130.849 E.01424
G1 X126.611 Y130.956 E.01424
G1 X126.397 Y130.529 E.01424
G1 X125.92 Y130.518 E.01424
G1 X125.819 Y130.05 E.01424
G1 X125.359 Y129.921 E.01424
G1 X125.378 Y129.443 E.01424
G1 X124.964 Y129.203 E.01424
G1 X125.101 Y128.745 E.01424
G1 X124.761 Y128.41 E.01424
G1 X125.007 Y128 E.01424
G1 X124.761 Y127.59 E.01424
G1 X125.101 Y127.255 E.01424
G1 X124.964 Y126.797 E.01424
G1 X125.326 Y126.587 E.01245
; WIPE_START
G1 X125.359 Y126.079 E-.19337
G1 X125.819 Y125.95 E-.18163
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X125.323 Y119.847 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X125.186 Y120.226 E.01296
G2 X125.116 Y121.391 I3.033 J.767 E.03775
G1 X125.135 Y121.556 E.00534
G2 X126.702 Y123.614 I2.865 J-.556 E.08616
G1 X126.624 Y123.808 E.00673
G1 X125.957 Y123.654 E.022
G1 X125.643 Y124.282 E.02259
G1 X124.941 Y124.299 E.0226
G1 X124.793 Y124.986 E.02259
G1 X124.116 Y125.177 E.0226
G1 X124.144 Y125.879 E.0226
G1 X123.389 Y126.317 E.02808
G1 X123.106 Y125.975 E.01428
G2 X119.852 Y125.319 I-2.108 J2.057 E.11341
G3 X125.266 Y119.866 I8.163 J2.69 E.25617
; WIPE_START
G1 X125.186 Y120.226 E-.14022
G1 X125.101 Y120.665 E-.16994
G1 X125.084 Y121.112 E-.1698
G1 X125.116 Y121.391 E-.10689
G1 X125.135 Y121.556 E-.06313
G1 X125.212 Y121.835 E-.11001
; WIPE_END
G1 E-.04 F1800
G1 X130.677 Y119.833 Z2 F9000
G1 Z1.6
G1 E.8 F1800
G1 F5895.652
G1 X131.376 Y120.108 E.02413
G3 X136.161 Y125.322 I-3.417 J7.939 E.23448
G2 X132.428 Y126.632 I-1.151 J2.694 E.13966
G1 X132.096 Y126.379 E.01342
G1 X132.211 Y125.686 E.0226
G1 X131.564 Y125.412 E.0226
G1 X131.504 Y124.712 E.02259
G1 X130.809 Y124.607 E.02259
G1 X130.576 Y123.944 E.0226
G1 X129.877 Y124.016 E.0226
G1 X129.522 Y123.484 E.02057
G1 X129.682 Y123.389 E.00602
G2 X130.7 Y119.889 I-1.713 J-2.396 E.12637
; WIPE_START
G1 X131.376 Y120.108 E-.26984
G1 X131.842 Y120.323 E-.19511
G1 X132.294 Y120.567 E-.19511
G1 X132.517 Y120.705 E-.09993
; WIPE_END
G1 E-.04 F1800
G1 X135.137 Y127.874 Z2 F9000
G1 X136.161 Y130.678 Z2
G1 Z1.6
G1 E.8 F1800
G1 F5895.652
G1 X135.982 Y131.155 E.01638
G3 X130.677 Y136.167 I-8.066 J-3.224 E.24219
G2 X129.522 Y132.516 I-2.655 J-1.168 E.13449
G1 X129.877 Y131.984 E.02057
G1 X130.576 Y132.055 E.0226
G1 X130.809 Y131.393 E.02259
G1 X131.504 Y131.288 E.0226
G1 X131.564 Y130.588 E.0226
G1 X132.211 Y130.314 E.02259
G1 X132.096 Y129.621 E.02259
G1 X132.428 Y129.368 E.01342
G1 X132.614 Y129.68 E.01169
G2 X134.725 Y130.899 I2.368 J-1.662 E.08094
G1 X134.891 Y130.918 E.00535
G2 X136.105 Y130.7 I.046 J-3.234 E.03992
; WIPE_START
G1 X135.982 Y131.155 E-.17899
G1 X135.735 Y131.724 E-.23575
G1 X135.499 Y132.18 E-.19529
G1 X135.296 Y132.519 E-.14997
; WIPE_END
G1 E-.04 F1800
G1 X127.669 Y132.231 Z2 F9000
G1 X126.624 Y132.192 Z2
G1 Z1.6
G1 E.8 F1800
G1 F5895.652
G1 X126.702 Y132.386 E.00673
G2 X125.323 Y136.153 I1.326 J2.621 E.14201
G3 X119.852 Y130.681 I2.694 J-8.164 E.2581
G2 X123.389 Y129.683 I1.144 J-2.711 E.12764
G1 X124.144 Y130.121 E.02808
G1 X124.116 Y130.823 E.0226
G1 X124.793 Y131.014 E.0226
G1 X124.941 Y131.701 E.02259
G1 X125.643 Y131.718 E.0226
G1 X125.957 Y132.346 E.02259
G1 X126.565 Y132.205 E.02007
; WIPE_START
G1 X126.702 Y132.386 E-.08599
G1 X126.322 Y132.611 E-.16777
G1 X125.977 Y132.896 E-.16996
G1 X125.68 Y133.23 E-.16983
G1 X125.442 Y133.597 E-.16645
; WIPE_END
G1 E-.04 F1800
G1 X127.735 Y126.317 Z2 F9000
G1 X129.919 Y119.383 Z2
G1 Z1.6
G1 E.8 F1800
G1 F5895.652
G1 X130.016 Y119.238 E.0056
G3 X136.822 Y126.238 I-2.031 J8.784 E.33176
G1 X136.368 Y125.891 E.01838
G1 X136.148 Y125.772 E.00803
G2 X134.772 Y130.495 I-1.146 J2.228 E.28397
G2 X136.368 Y130.109 I.249 J-2.46 E.05382
G1 X136.822 Y129.762 E.01838
G3 X130.016 Y136.762 I-8.859 J-1.805 E.33165
G1 X129.919 Y136.617 E.0056
G2 X128.292 Y132.51 I-1.908 J-1.62 E.17402
G2 X125.894 Y136.365 I-.286 J2.496 E.18231
G1 X126.236 Y136.814 E.01815
G3 X119.191 Y129.769 I1.776 J-8.821 E.33953
G1 X119.637 Y130.109 E.01802
G2 X121.232 Y125.505 I1.364 J-2.105 E.29233
G2 X119.637 Y125.891 I-.224 J2.563 E.05373
G1 X119.191 Y126.231 E.01802
G3 X126.236 Y119.186 I8.813 J1.767 E.33958
G1 X125.894 Y119.634 E.01815
G1 X125.774 Y119.854 E.00803
G2 X128.033 Y123.51 I2.232 J1.147 E.16589
G2 X129.957 Y119.43 I-.037 J-2.512 E.18015
; WIPE_START
G1 X130.016 Y119.238 E-.076
G1 X130.523 Y119.37 E-.19936
G1 X131.035 Y119.537 E-.20437
G1 X131.536 Y119.733 E-.20443
G1 X131.717 Y119.817 E-.07584
; WIPE_END
G1 E-.04 F1800
G1 X126.325 Y125.219 Z2 F9000
G1 X123.037 Y128.512 Z2
G1 Z1.6
G1 E.8 F1800
G1 F5895.652
G1 X123.004 Y128.634 E.00403
G3 X120.761 Y125.91 I-2.002 J-.637 E.28975
G3 X121.186 Y125.91 I.214 J1.376 E.01371
G1 X121.403 Y125.935 E.00703
G3 X123.078 Y128.321 I-.4 J2.062 E.10361
G1 X123.049 Y128.454 E.00438
M204 S250
G1 X122.655 Y128.423 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X122.63 Y128.515 E.00284
M73 P67 R6
G3 X120.806 Y126.301 I-1.628 J-.518 E.21823
G3 X121.141 Y126.299 I.173 J1.084 E.01001
G1 X121.328 Y126.321 E.00561
G3 X122.69 Y128.261 I-.326 J1.677 E.07803
G1 X122.668 Y128.365 E.00316
; WIPE_START
G1 X122.63 Y128.515 E-.05897
G1 X122.535 Y128.759 E-.09947
G1 X122.401 Y128.984 E-.09952
G1 X122.235 Y129.186 E-.09952
G1 X122.039 Y129.36 E-.0995
G1 X121.819 Y129.503 E-.09956
G1 X121.58 Y129.61 E-.09949
G1 X121.328 Y129.679 E-.09952
G1 X121.316 Y129.681 E-.00446
; WIPE_END
G1 E-.04 F1800
G1 X124.95 Y122.969 Z2 F9000
G1 X127.3 Y118.629 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G3 X127.862 Y118.603 I.702 J9.369 E.01808
G1 X128.424 Y118.612 E.01808
G3 X127.24 Y118.633 I-.422 J9.386 E1.86023
M204 S250
G1 X127.271 Y118.237 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X128.441 Y118.22 I.73 J9.76 E.03489
G3 X137.216 Y124.702 I-.451 J9.792 E.34461
G3 X127.211 Y118.242 I-9.216 J3.295 E1.45034
; WIPE_START
G1 X127.856 Y118.211 E-.24533
G1 X128.441 Y118.22 E-.22254
G1 X129.026 Y118.264 E-.22261
G1 X129.207 Y118.288 E-.06952
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2 I1.217 J0 P1  F9000
; stop printing object, unique label id: 82
M625
; object ids of layer 8 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z2 F4000
            G39.3 S1
            G0 Z2 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END


; object ids of this layer8 end: 82,118
M625
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X129.09 Y118.874 F9000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.353127
G1 F7736.79
G1 X129.793 Y119.206 E.01904
G1 X129.818 Y119.168 F9000
; LINE_WIDTH: 0.177553
G1 X129.211 Y118.957 E.00683
; LINE_WIDTH: 0.155808
G1 X129.082 Y118.917 E.0012
; LINE_WIDTH: 0.116544
G1 X128.953 Y118.878 E.00078
; WIPE_START
G1 X129.082 Y118.917 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.042 Y118.883 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.11749
G1 F9000
G1 X126.917 Y118.919 E.00077
; LINE_WIDTH: 0.161201
G1 X126.778 Y118.96 E.00136
; LINE_WIDTH: 0.192067
G1 X126.754 Y118.97 E.00031
; LINE_WIDTH: 0.172926
G1 X126.636 Y119.084 E.00168
; LINE_WIDTH: 0.123007
G1 X126.518 Y119.197 E.00103
; LINE_WIDTH: 0.0970702
G1 X126.496 Y119.221 E.00014
; WIPE_START
G1 X126.518 Y119.197 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.043 Y123.533 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.1633
G1 F9000
G1 X126.948 Y123.69 E.00174
; LINE_WIDTH: 0.119048
G1 X126.852 Y123.846 E.0011
G1 X127.49 Y123.686
; LINE_WIDTH: 0.112264
G2 X127.81 Y123.795 I1.606 J-4.203 E.00186
G1 X128.651 Y123.79
; LINE_WIDTH: 0.332832
G1 F8278.383
G2 X129.321 Y123.55 I-1.284 J-4.637 E.01631
G1 X129.829 Y123.578 F9000
; LINE_WIDTH: 0.103372
G1 X129.934 Y123.477 E.00069
; WIPE_START
G1 X129.829 Y123.578 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X132.397 Y122.981 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41325
G1 F6480.707
G1 X132.635 Y123.176 E.009
; LINE_WIDTH: 0.358023
G1 F7616.577
G3 X133.046 Y123.574 I-.897 J1.338 E.01431
; WIPE_START
G1 X132.873 Y123.371 E-.35245
G1 X132.635 Y123.176 E-.40755
; WIPE_END
G1 E-.04 F1800
G1 X131.941 Y123.239 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X132.238 Y123.333 E.00927
G1 X132.633 Y123.608 E.01435
G3 X132.955 Y124.058 I-1.893 J1.696 E.0165
G1 X133.652 Y123.772 E.02245
G2 X132.234 Y122.355 I-6.309 J4.9 E.05985
G3 X131.896 Y123.14 I-6.84 J-2.486 E.02546
G1 X131.916 Y123.185 E.00148
G1 X131.662 Y123.577 F9000
G1 F6364.866
G1 X132.082 Y123.676 E.01286
G1 X132.403 Y123.914 E.0119
G1 X132.567 Y124.183 E.0094
G1 X132.627 Y124.42 E.00728
G1 X132.814 Y124.452 E.00567
G1 X133.124 Y124.395 E.00937
G3 X134.267 Y123.998 I1.95 J3.773 E.03617
G2 X132 Y121.733 I-6.302 J4.039 E.0962
G1 X131.866 Y122.254 E.01604
G1 X131.607 Y122.878 E.02012
G1 X131.435 Y123.164 E.00994
G3 X131.641 Y123.52 I-.433 J.488 E.01246
G1 X131.381 Y123.916 F9000
G1 F6364.866
G1 X131.926 Y124.019 E.01653
G1 X132.119 Y124.162 E.00714
G1 X132.243 Y124.404 E.00811
G1 X132.286 Y124.834 E.01285
G1 X132.53 Y124.784 E.0074
G1 X132.733 Y124.853 E.00641
G1 X133.061 Y124.819 E.00981
G1 X133.097 Y124.853 E.00145
G1 X133.681 Y124.559 E.01948
G1 X134.257 Y124.387 E.01792
G3 X134.888 Y124.313 I.983 J5.644 E.01893
G2 X133.054 Y122.039 I-7.221 J3.947 E.08747
G1 X132.323 Y121.49 E.02723
G2 X131.689 Y121.115 I-4.429 J6.754 E.02196
G3 X131.263 Y122.724 I-4.122 J-.23 E.04992
G1 X130.962 Y123.202 E.01682
G1 X131.249 Y123.538 E.01317
G1 X131.361 Y123.859 E.01013
G1 X131.101 Y124.255 F9000
G1 F6364.866
G1 X131.721 Y124.348 E.01868
G1 X131.85 Y124.431 E.00458
G3 X131.935 Y125.143 I-8.733 J1.396 E.02136
G1 X132.258 Y125.269 E.01035
G1 X132.33 Y125.183 E.00333
G1 X132.504 Y125.167 E.00523
G1 X132.696 Y125.246 E.00619
G1 X133.008 Y125.193 E.00941
G1 X133.118 Y125.296 E.00449
G1 X133.432 Y125.083 E.01132
G3 X135.51 Y124.733 I1.581 J3.041 E.06378
G2 X131.271 Y120.502 I-7.541 J3.316 E.18257
G1 X131.313 Y121.112 E.01822
G3 X130.335 Y123.329 I-3.236 J-.104 E.07396
G1 X130.425 Y123.434 E.00414
G1 X130.403 Y123.568 E.00405
G1 X130.799 Y123.557 E.0118
G1 X130.893 Y123.663 E.00423
G1 X131.081 Y124.198 E.01689
; WIPE_START
G1 X130.893 Y123.663 E-.21548
G1 X130.799 Y123.557 E-.05399
G1 X130.403 Y123.568 E-.15052
G1 X130.425 Y123.434 E-.05161
G1 X130.335 Y123.329 E-.05275
G1 X130.645 Y122.997 E-.17274
G1 X130.735 Y122.857 E-.0629
; WIPE_END
G1 E-.04 F1800
G1 X132.394 Y125.827 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.233106
G1 F9000
G1 X132.847 Y125.734 E.00694
G1 X132.616 Y125.637
; LINE_WIDTH: 0.157671
G2 X132.345 Y126.313 I8.445 J3.785 E.00661
G1 X132.455 Y126.909
; LINE_WIDTH: 0.173567
G2 X132.347 Y127.165 I3.256 J1.521 E.00287
; LINE_WIDTH: 0.192543
G1 X132.279 Y127.369 E.00255
; LINE_WIDTH: 0.221844
G1 X132.21 Y127.573 E.00304
G1 X132.21 Y128.427
; LINE_WIDTH: 0.221839
G1 X132.279 Y128.631 E.00304
; LINE_WIDTH: 0.192535
G1 X132.347 Y128.835 E.00254
; LINE_WIDTH: 0.173563
G2 X132.455 Y129.091 I3.338 J-1.254 E.00287
G1 X132.345 Y129.687
; LINE_WIDTH: 0.157679
G2 X132.616 Y130.363 I8.7 J-3.102 E.00661
G1 X132.847 Y130.266
; LINE_WIDTH: 0.232959
G1 X132.394 Y130.173 E.00693
; WIPE_START
G1 X132.847 Y130.266 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X132.397 Y133.019 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42453
G1 F6289.144
G1 X132.459 Y132.975 E.00228
; LINE_WIDTH: 0.39915
G1 F6737.221
G1 X132.521 Y132.932 E.00213
G1 X131.941 Y132.761 F9000
; LINE_WIDTH: 0.424402
G1 F6291.264
G1 X131.896 Y132.86 E.0033
G3 X132.234 Y133.645 I-4.261 J2.302 E.02578
G2 X132.895 Y133.055 I-1.929 J-2.823 E.02678
; LINE_WIDTH: 0.485575
G1 F5421.829
G1 X133.025 Y132.888 E.00739
; LINE_WIDTH: 0.522445
G1 F5004.953
G1 X133.156 Y132.722 E.008
; LINE_WIDTH: 0.574305
G1 F4516.506
G3 X133.521 Y132.27 I12.642 J9.809 E.02441
G1 X132.967 Y132.034 E.02524
G1 X132.732 Y132.395 E.01807
; LINE_WIDTH: 0.550724
G1 F4726.239
G1 X132.637 Y132.453 E.00447
; LINE_WIDTH: 0.51213
G1 F5114.98
G1 X132.542 Y132.511 E.00413
; LINE_WIDTH: 0.473537
G1 F5573.403
G1 X132.447 Y132.569 E.00379
; LINE_WIDTH: 0.437115
G1 F6088.357
G1 X131.997 Y132.739 E.01498
G1 X131.662 Y132.423 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X131.532 Y132.745 E.01032
G1 X131.435 Y132.836 E.00395
G3 X132 Y134.267 I-3.862 J2.352 E.04607
G2 X134.267 Y132.002 I-4.075 J-6.345 E.09619
G3 X133.124 Y131.605 I.805 J-4.165 E.03618
G1 X132.769 Y131.539 E.01074
G1 X132.627 Y131.58 E.00442
G1 X132.563 Y131.827 E.00762
G1 X132.364 Y132.127 E.01071
G1 X132.082 Y132.324 E.01025
G1 X131.72 Y132.41 E.01108
G1 X131.381 Y132.084 F9000
; LINE_WIDTH: 0.41999
G1 F6364.875
G1 X131.205 Y132.556 E.01501
G1 X130.962 Y132.798 E.01022
G3 X131.689 Y134.885 I-3.203 J2.286 E.06672
G2 X134.888 Y131.687 I-3.691 J-6.891 E.1367
G3 X133.096 Y131.147 I.102 J-3.582 E.0564
G1 X132.965 Y131.186 E.00407
G1 X132.733 Y131.147 E.007
G1 X132.53 Y131.216 E.00641
G1 X132.286 Y131.166 E.0074
G1 X132.218 Y131.676 E.01532
G1 X132.096 Y131.862 E.00664
G1 X131.85 Y132.009 E.00851
G1 X131.44 Y132.075 E.01236
G1 X131.101 Y131.745 F9000
; LINE_WIDTH: 0.41999
G1 F6364.876
G1 X130.893 Y132.337 E.01868
G1 X130.766 Y132.456 E.00517
G1 X130.402 Y132.432 E.01086
G1 X130.425 Y132.566 E.00404
G1 X130.334 Y132.671 E.00413
G1 X130.645 Y133.003 E.01356
G3 X131.269 Y135.51 I-2.621 J1.983 E.07907
G2 X135.504 Y131.268 I-3.282 J-7.512 E.18278
G1 X134.89 Y131.311 E.01833
G3 X133.118 Y130.704 I.097 J-3.175 E.05664
G1 X132.976 Y130.809 E.00525
G1 X132.697 Y130.754 E.00848
G1 X132.465 Y130.845 E.00741
G3 X132.245 Y130.725 I-.027 J-.212 E.00795
G1 X131.935 Y130.857 E.01005
G1 X131.88 Y131.482 E.01868
G1 X131.799 Y131.621 E.00481
G1 X131.16 Y131.735 E.01934
; WIPE_START
G1 X131.799 Y131.621 E-.24675
G1 X131.88 Y131.482 E-.06136
G1 X131.935 Y130.857 E-.23833
G1 X132.245 Y130.725 E-.12826
G1 X132.33 Y130.817 E-.04725
G1 X132.428 Y130.837 E-.03805
; WIPE_END
G1 E-.04 F1800
G1 X129.933 Y132.522 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.103331
G1 F9000
G1 X129.829 Y132.422 E.00069
G1 X129.321 Y132.45
; LINE_WIDTH: 0.332822
G1 F8278.676
G2 X128.651 Y132.21 I-1.958 J4.407 E.01631
G1 X127.811 Y132.206 F9000
; LINE_WIDTH: 0.112209
G2 X127.49 Y132.314 I1.212 J4.113 E.00185
G1 X127.043 Y132.467
; LINE_WIDTH: 0.163259
G1 X126.948 Y132.31 E.00174
; LINE_WIDTH: 0.119034
G1 X126.852 Y132.154 E.0011
; WIPE_START
G1 X126.948 Y132.31 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X123.743 Y130.342 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X123.48 Y130.189 E.00907
G1 X123.022 Y130.626 E.01885
G3 X120.493 Y131.267 I-2.006 J-2.605 E.07991
G2 X124.735 Y135.507 I7.531 J-3.292 E.18289
G1 X124.692 Y134.888 E.01851
G3 X125.675 Y132.667 I3.236 J.104 E.07416
G1 X125.398 Y132.104 E.01868
G1 X124.771 Y132.089 E.01868
G1 X124.632 Y132.024 E.00456
G1 X124.459 Y131.327 E.02137
G1 X123.855 Y131.157 E.01868
G1 X123.759 Y131.093 E.00345
G1 X123.719 Y130.955 E.0043
G1 X123.741 Y130.402 E.01648
; WIPE_START
G1 X123.719 Y130.955 E-.21029
G1 X123.759 Y131.093 E-.05482
G1 X123.855 Y131.157 E-.04397
G1 X124.459 Y131.327 E-.23829
G1 X124.594 Y131.87 E-.21263
; WIPE_END
G1 E-.04 F1800
G1 X124.138 Y131.629 Z2 F9000
G1 Z1.6
G1 E.8 F1800
G1 F6364.866
G1 X123.595 Y131.448 E.01704
G1 X123.464 Y131.328 E.0053
G1 X123.341 Y130.953 E.01173
G1 X123.346 Y130.842 E.00332
G1 X122.802 Y131.22 E.01972
G3 X121.116 Y131.687 I-1.799 J-3.217 E.05263
G2 X124.248 Y134.851 I6.933 J-3.731 E.13444
G1 X124.314 Y134.872 E.00208
G3 X125.223 Y132.597 I3.631 J.13 E.07442
G1 X125.162 Y132.476 E.00404
G1 X124.762 Y132.466 E.01192
G1 X124.472 Y132.378 E.00903
G1 X124.272 Y132.158 E.00885
G1 X124.153 Y131.687 E.01448
G1 X123.817 Y131.93 F9000
G1 F6364.866
G1 X123.387 Y131.762 E.01375
G1 X123.169 Y131.563 E.00881
G1 X123.127 Y131.458 E.00334
G3 X121.736 Y131.998 I-2.247 J-3.732 E.04467
G2 X124.004 Y134.267 I6.295 J-4.024 E.09633
G3 X124.588 Y132.806 I4.423 J.921 E.0471
G1 X124.269 Y132.696 E.01004
G1 X124.061 Y132.515 E.00823
G1 X123.878 Y132.189 E.01115
G1 X123.831 Y131.988 E.00613
G1 X123.499 Y132.229 F9000
G1 F6364.866
G1 X123.179 Y132.077 E.01053
G1 X123.023 Y131.954 E.00592
G1 X122.353 Y132.228 E.02157
G1 X122.678 Y132.634 E.01549
G1 X123.271 Y133.239 E.02524
G2 X123.774 Y133.649 I4.831 J-5.41 E.01933
G1 X124.041 Y132.994 E.02107
G1 X123.775 Y132.761 E.01054
G1 X123.55 Y132.39 E.01292
G1 X123.517 Y132.286 E.00324
G1 X123.163 Y132.545 F9000
; LINE_WIDTH: 0.476577
G1 F5534.332
G1 X123.279 Y132.693 E.00644
; LINE_WIDTH: 0.43021
G1 F6196.907
G1 X123.395 Y132.84 E.00575
; LINE_WIDTH: 0.383844
G1 F7039.707
G1 X123.511 Y132.988 E.00506
; LINE_WIDTH: 0.35205
G1 F7763.724
G1 X123.581 Y133.054 E.00234
; WIPE_START
G1 X123.511 Y132.988 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.496 Y136.779 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970913
M73 P68 R6
G1 F9000
G1 X126.518 Y136.803 E.00014
; LINE_WIDTH: 0.123041
G1 X126.636 Y136.916 E.00103
; LINE_WIDTH: 0.172952
G1 X126.753 Y137.03 E.00168
; LINE_WIDTH: 0.192077
G1 X126.778 Y137.04 E.00031
; LINE_WIDTH: 0.161176
G1 X126.917 Y137.081 E.00136
; LINE_WIDTH: 0.117473
G1 X127.042 Y137.117 E.00077
; WIPE_START
G1 X126.917 Y137.081 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128.953 Y137.122 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.116547
G1 F9000
G1 X129.082 Y137.083 E.00078
; LINE_WIDTH: 0.155813
G1 X129.211 Y137.043 E.0012
; LINE_WIDTH: 0.177558
G1 X129.817 Y136.831 E.00683
G1 X129.793 Y136.794
; LINE_WIDTH: 0.353146
G1 F7736.31
G1 X129.091 Y137.126 E.01903
; WIPE_START
G1 X129.793 Y136.794 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X125.414 Y130.542 Z2 F9000
G1 X123.731 Y128.14 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.151085
G1 F9000
G2 X123.731 Y127.86 I-.215 J-.14 E.00254
; WIPE_START
G1 X123.773 Y128 E-.37999
G1 X123.731 Y128.14 E-.38001
; WIPE_END
G1 E-.04 F1800
G1 X123.743 Y125.658 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X123.718 Y125.032 E.01868
G1 X123.779 Y124.886 E.0047
G1 X124.459 Y124.673 E.02123
G1 X124.591 Y124.06 E.01868
G1 X124.674 Y123.94 E.00433
G1 X125.398 Y123.896 E.02159
G1 X125.675 Y123.333 E.01868
G1 X125.301 Y122.907 E.01688
G3 X124.735 Y120.493 I2.614 J-1.887 E.07583
G2 X120.507 Y124.731 I3.269 J7.49 E.18257
G1 X121.035 Y124.692 E.01578
G1 X121.619 Y124.745 E.01746
G3 X123.48 Y125.811 I-.682 J3.349 E.06498
G1 X123.691 Y125.689 E.00728
; WIPE_START
G1 X123.48 Y125.811 E-.09286
G1 X123.379 Y125.692 E-.05923
G1 X122.999 Y125.357 E-.1926
G1 X122.572 Y125.083 E-.19273
G1 X122.108 Y124.878 E-.19277
G1 X122.033 Y124.857 E-.02982
; WIPE_END
G1 E-.04 F1800
G1 X124.138 Y124.371 Z2 F9000
G1 Z1.6
G1 E.8 F1800
G1 F6364.866
G1 X124.272 Y123.842 E.01627
G1 X124.472 Y123.622 E.00885
G1 X124.762 Y123.534 E.00903
G1 X125.162 Y123.524 E.01192
G1 X125.223 Y123.403 E.00404
G3 X124.318 Y121.184 I2.772 J-2.424 E.07269
G1 X124.299 Y121.119 E.00201
G2 X121.116 Y124.313 I3.78 J6.951 E.13621
G3 X123.346 Y125.158 I-.176 J3.83 E.07223
G1 X123.343 Y124.973 E.00552
G1 X123.523 Y124.609 E.01209
G3 X124.08 Y124.388 I.74 J1.052 E.01803
G1 X123.817 Y124.07 F9000
G1 F6364.866
G1 X123.936 Y123.67 E.01243
G1 X124.121 Y123.42 E.00925
G1 X124.397 Y123.236 E.00988
G1 X124.588 Y123.194 E.00584
G1 X124.278 Y122.612 E.01963
G3 X124.004 Y121.733 I4.567 J-1.903 E.02748
G2 X121.736 Y124.002 I4.027 J6.294 E.09633
G3 X123.127 Y124.541 I-.955 J4.528 E.04464
G1 X123.267 Y124.332 E.00751
G1 X123.563 Y124.146 E.0104
G1 X123.76 Y124.087 E.00613
G1 X123.499 Y123.771 F9000
G1 F6364.866
G1 X123.6 Y123.498 E.00866
G1 X123.86 Y123.149 E.01296
G1 X124.041 Y123.006 E.00688
G3 X123.774 Y122.351 I2.792 J-1.521 E.02112
G2 X122.353 Y123.772 I4.301 J5.726 E.06005
G1 X123.023 Y124.046 E.02157
G1 X123.341 Y123.832 E.01142
G1 X123.443 Y123.792 E.00324
G1 X123.163 Y123.455 F9000
; LINE_WIDTH: 0.47659
G1 F5534.162
G1 X123.279 Y123.308 E.00643
; LINE_WIDTH: 0.43025
G1 F6196.267
G1 X123.395 Y123.16 E.00575
; LINE_WIDTH: 0.38391
G1 F7038.33
G1 X123.511 Y123.012 E.00506
; LINE_WIDTH: 0.3521
G1 F7762.468
G1 X123.581 Y122.946 E.00235
; WIPE_START
G1 X123.511 Y123.012 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.223 Y126.494 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970875
G1 F9000
G1 X119.199 Y126.516 E.00014
; LINE_WIDTH: 0.122752
G1 X119.087 Y126.632 E.00102
; LINE_WIDTH: 0.175229
G1 X118.975 Y126.749 E.00169
G1 X118.958 Y126.791 E.00047
; LINE_WIDTH: 0.157757
G1 X118.922 Y126.908 E.00111
; LINE_WIDTH: 0.117864
G1 X118.883 Y127.044 E.00083
; WIPE_START
G1 X118.922 Y126.908 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.883 Y128.956 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.117862
G1 F9000
G1 X118.922 Y129.092 E.00083
; LINE_WIDTH: 0.157764
G1 X118.958 Y129.209 E.00111
; LINE_WIDTH: 0.175216
G1 X118.975 Y129.251 E.00047
G1 X119.087 Y129.368 E.00169
; LINE_WIDTH: 0.122712
G1 X119.199 Y129.484 E.00102
; LINE_WIDTH: 0.0970686
G1 X119.223 Y129.506 E.00014
; WIPE_START
G1 X119.199 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.831 Y129.494 Z2 F9000
G1 X136.781 Y129.506 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0970931
G1 F9000
G1 X136.805 Y129.484 E.00014
; LINE_WIDTH: 0.12286
G1 X136.918 Y129.367 E.00102
; LINE_WIDTH: 0.172376
G1 X137.03 Y129.251 E.00166
; LINE_WIDTH: 0.188902
G1 X137.042 Y129.219 E.00039
; LINE_WIDTH: 0.158083
G1 X137.083 Y129.084 E.00129
; LINE_WIDTH: 0.116752
G1 X137.121 Y128.958 E.00076
; WIPE_START
G1 X137.083 Y129.084 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.121 Y127.041 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.116753
G1 F9000
G1 X137.083 Y126.916 E.00076
; LINE_WIDTH: 0.15806
G1 X137.042 Y126.781 E.00129
; LINE_WIDTH: 0.188866
G1 X137.03 Y126.749 E.00039
; LINE_WIDTH: 0.172333
G1 X136.918 Y126.633 E.00166
; LINE_WIDTH: 0.12282
G1 X136.805 Y126.516 E.00102
; LINE_WIDTH: 0.0970932
G1 X136.781 Y126.494 E.00014
; OBJECT_ID: 118
; WIPE_START
G1 X136.805 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X129.622 Y129.096 Z2 F9000
G1 X107.789 Y136.94 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X107.696 Y136.986 E.00333
G3 X106.789 Y132.913 I-.681 J-1.986 E.22715
G3 X108.217 Y133.279 I.212 J2.14 E.04839
G3 X108.082 Y136.808 I-1.203 J1.721 E.13493
G1 X107.843 Y136.916 E.00841
M204 S250
G1 X107.629 Y136.585 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X107.578 Y136.614 E.00175
G3 X106.819 Y133.304 I-.564 J-1.613 E.1712
G3 X107.766 Y133.467 I.201 J1.665 E.02903
G3 X107.882 Y136.473 I-.752 J1.534 E.10956
G1 X107.684 Y136.561 E.00647
; WIPE_START
G1 X107.578 Y136.614 E-.04502
G1 X107.396 Y136.666 E-.07168
G1 X107.138 Y136.706 E-.0995
G1 X106.876 Y136.706 E-.09955
G1 X106.617 Y136.666 E-.09948
G1 X106.367 Y136.587 E-.09956
G1 X106.133 Y136.47 E-.0995
G1 X105.918 Y136.32 E-.09954
G1 X105.831 Y136.235 E-.04618
; WIPE_END
G1 E-.04 F1800
G1 X111.306 Y130.918 Z2 F9000
G1 X115.653 Y126.695 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X115.81 Y126.928 E.00904
G3 X113.823 Y130.09 I-1.804 J1.072 E.14806
G3 X113.709 Y125.923 I.184 J-2.09 E.19643
G3 X115.613 Y126.65 I.297 J2.077 E.06843
M204 S250
G1 X115.333 Y126.92 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X115.48 Y127.124 E.00749
G3 X113.754 Y126.312 I-1.466 J.876 E.25942
G3 X114.706 Y126.439 I.264 J1.655 E.02903
G3 X115.297 Y126.873 I-.693 J1.562 E.022
; WIPE_START
G1 X115.48 Y127.124 E-.11814
G1 X115.593 Y127.361 E-.09963
G1 X115.672 Y127.61 E-.09951
G1 X115.712 Y127.869 E-.09954
G1 X115.712 Y128.131 E-.09952
G1 X115.65 Y128.46 E-.1272
G1 X115.593 Y128.639 E-.07159
G1 X115.541 Y128.745 E-.04487
; WIPE_END
G1 E-.04 F1800
G1 X110.915 Y122.675 Z2 F9000
G1 X108.555 Y119.579 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X108.577 Y119.601 E.00098
G3 X106.846 Y118.902 I-1.57 J1.396 E.36224
G3 X107.585 Y118.983 I.124 J2.3 E.02402
G1 X107.793 Y119.049 E.00703
G3 X108.345 Y119.377 I-.786 J1.948 E.02073
G1 X108.512 Y119.538 E.00745
M204 S250
G1 X108.284 Y119.862 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X108.283 Y119.862 E.00002
G3 X106.876 Y119.294 I-1.276 J1.135 E.27283
G3 X107.467 Y119.357 I.099 J1.894 E.01777
G1 X107.646 Y119.413 E.00561
G3 X108.095 Y119.681 I-.639 J1.584 E.01561
G1 X108.24 Y119.82 E.006
; WIPE_START
G1 X108.283 Y119.862 E-.02293
G1 X108.443 Y120.07 E-.09949
G1 X108.568 Y120.3 E-.09952
G1 X108.656 Y120.547 E-.09952
G1 X108.706 Y120.804 E-.09952
G1 X108.716 Y121.065 E-.09949
G1 X108.686 Y121.326 E-.09955
G1 X108.617 Y121.578 E-.09951
G1 X108.573 Y121.675 E-.04047
; WIPE_END
G1 E-.04 F1800
G1 X103.565 Y126.108 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X103.54 Y125.481 E.02016
G1 X104.143 Y125.311 E.02016
G1 X104.275 Y124.698 E.02015
G1 X104.902 Y124.684 E.02016
G1 X105.182 Y124.123 E.02016
G1 X105.793 Y124.264 E.02016
G1 X106.204 Y123.791 E.02016
G1 X106.76 Y124.08 E.02016
G1 X107.276 Y123.724 E.02016
G1 X107.743 Y124.142 E.02016
G1 X108.331 Y123.925 E.02016
G1 X108.679 Y124.446 E.02016
G1 X109.303 Y124.382 E.02016
G1 X109.51 Y124.974 E.02016
G1 X110.13 Y125.067 E.02016
G1 X110.184 Y125.691 E.02016
G1 X110.762 Y125.936 E.02016
G1 X110.659 Y126.554 E.02016
G1 X111.157 Y126.934 E.02016
G1 X110.904 Y127.508 E.02016
G1 X111.292 Y128 E.02016
G1 X110.904 Y128.492 E.02016
G1 X111.157 Y129.066 E.02016
G1 X110.659 Y129.446 E.02016
G1 X110.762 Y130.064 E.02016
G1 X110.184 Y130.309 E.02016
G1 X110.13 Y130.933 E.02016
G1 X109.51 Y131.026 E.02016
G1 X109.303 Y131.618 E.02015
G1 X108.679 Y131.554 E.02016
G1 X108.331 Y132.075 E.02016
G1 X107.743 Y131.858 E.02016
G1 X107.276 Y132.277 E.02016
G1 X106.76 Y131.92 E.02016
G1 X106.204 Y132.209 E.02016
G1 X105.793 Y131.736 E.02016
G1 X105.182 Y131.877 E.02016
G1 X104.902 Y131.316 E.02016
G1 X104.275 Y131.302 E.02016
G1 X104.143 Y130.689 E.02016
G1 X103.54 Y130.519 E.02016
G1 X103.565 Y129.892 E.02016
G1 X103.023 Y129.577 E.02016
G1 X103.202 Y128.977 E.02016
G1 X102.756 Y128.537 E.02016
G1 X103.079 Y128 E.02016
G1 X102.756 Y127.463 E.02016
G1 X103.202 Y127.023 E.02016
G1 X103.023 Y126.423 E.02016
G1 X103.513 Y126.138 E.01823
G1 X103.981 Y126.337 F9000
G1 F5895.652
G1 X103.959 Y125.786 E.01772
G1 X104.49 Y125.636 E.01772
G1 X104.606 Y125.098 E.01772
G1 X105.157 Y125.085 E.01772
G1 X105.403 Y124.592 E.01772
G1 X105.94 Y124.716 E.01772
G1 X106.301 Y124.3 E.01772
G1 X106.79 Y124.554 E.01772
G1 X107.243 Y124.241 E.01772
G1 X107.654 Y124.608 E.01772
G1 X108.171 Y124.418 E.01772
G1 X108.477 Y124.876 E.01772
G1 X109.025 Y124.82 E.01772
G1 X109.208 Y125.34 E.01772
G1 X109.752 Y125.422 E.01772
G1 X109.8 Y125.971 E.01772
G1 X110.307 Y126.185 E.01772
G1 X110.217 Y126.729 E.01772
G1 X110.655 Y127.063 E.01772
G1 X110.432 Y127.567 E.01772
G1 X110.773 Y128 E.01772
G1 X110.432 Y128.433 E.01772
G1 X110.655 Y128.937 E.01772
G1 X110.217 Y129.271 E.01772
G1 X110.307 Y129.815 E.01772
G1 X109.8 Y130.029 E.01772
G1 X109.752 Y130.578 E.01772
G1 X109.208 Y130.66 E.01772
G1 X109.025 Y131.18 E.01772
G1 X108.477 Y131.124 E.01772
G1 X108.171 Y131.582 E.01772
G1 X107.654 Y131.392 E.01772
G1 X107.243 Y131.759 E.01772
G1 X106.79 Y131.446 E.01772
G1 X106.301 Y131.7 E.01772
G1 X105.94 Y131.284 E.01772
G1 X105.403 Y131.408 E.01772
G1 X105.157 Y130.915 E.01772
G1 X104.606 Y130.902 E.01772
G1 X104.49 Y130.364 E.01772
G1 X103.959 Y130.214 E.01772
G1 X103.981 Y129.663 E.01772
G1 X103.505 Y129.387 E.01772
G1 X103.662 Y128.859 E.01772
G1 X103.27 Y128.472 E.01772
G1 X103.554 Y128 E.01772
G1 X103.27 Y127.528 E.01772
G1 X103.662 Y127.141 E.01772
G1 X103.505 Y126.613 E.01772
G1 X103.929 Y126.367 E.01579
M204 S250
G1 X104.382 Y126.557 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X104.363 Y126.079 E.01424
G1 X104.823 Y125.95 E.01424
G1 X104.924 Y125.482 E.01424
G1 X105.402 Y125.471 E.01424
G1 X105.616 Y125.044 E.01424
G1 X106.081 Y125.151 E.01424
G1 X106.394 Y124.79 E.01424
G1 X106.819 Y125.011 E.01424
G1 X107.212 Y124.739 E.01424
G1 X107.568 Y125.058 E.01424
G1 X108.016 Y124.893 E.01424
G1 X108.282 Y125.29 E.01424
G1 X108.757 Y125.241 E.01424
G1 X108.916 Y125.692 E.01424
G1 X109.389 Y125.763 E.01424
G1 X109.43 Y126.24 E.01424
G1 X109.87 Y126.426 E.01424
G1 X109.792 Y126.897 E.01424
G1 X110.171 Y127.187 E.01424
G1 X109.978 Y127.625 E.01424
G1 X110.274 Y128 E.01424
G1 X109.978 Y128.375 E.01424
G1 X110.171 Y128.813 E.01424
G1 X109.792 Y129.103 E.01424
G1 X109.87 Y129.574 E.01424
G1 X109.43 Y129.76 E.01424
G1 X109.389 Y130.237 E.01424
G1 X108.916 Y130.308 E.01424
G1 X108.757 Y130.759 E.01424
G1 X108.282 Y130.71 E.01424
G1 X108.016 Y131.107 E.01424
G1 X107.568 Y130.942 E.01424
G1 X107.212 Y131.261 E.01424
G1 X106.819 Y130.989 E.01424
G1 X106.394 Y131.21 E.01424
G1 X106.081 Y130.849 E.01424
G1 X105.616 Y130.956 E.01424
G1 X105.402 Y130.529 E.01424
G1 X104.924 Y130.518 E.01424
G1 X104.823 Y130.05 E.01424
G1 X104.363 Y129.921 E.01424
G1 X104.382 Y129.443 E.01424
G1 X103.969 Y129.203 E.01424
G1 X104.106 Y128.745 E.01424
G1 X103.765 Y128.41 E.01424
G1 X104.012 Y128 E.01424
G1 X103.765 Y127.59 E.01424
G1 X104.106 Y127.255 E.01424
G1 X103.969 Y126.797 E.01424
G1 X104.33 Y126.587 E.01245
; WIPE_START
G1 X104.363 Y126.079 E-.19337
G1 X104.823 Y125.95 E-.18163
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X104.327 Y119.847 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X104.191 Y120.226 E.01296
G2 X104.121 Y121.391 I3.033 J.767 E.03775
G1 X104.14 Y121.556 E.00534
G2 X105.706 Y123.614 I2.865 J-.556 E.08616
G1 X105.628 Y123.808 E.00673
G1 X104.962 Y123.654 E.022
G1 X104.647 Y124.282 E.02259
G1 X103.945 Y124.299 E.0226
G1 X103.797 Y124.986 E.02259
G1 X103.121 Y125.177 E.0226
G1 X103.148 Y125.879 E.0226
G1 X102.393 Y126.317 E.02808
G1 X102.111 Y125.975 E.01428
G2 X98.856 Y125.319 I-2.108 J2.057 E.11341
G3 X104.27 Y119.866 I8.163 J2.69 E.25617
; WIPE_START
G1 X104.191 Y120.226 E-.14022
G1 X104.106 Y120.665 E-.16994
G1 X104.088 Y121.112 E-.1698
G1 X104.121 Y121.391 E-.10689
G1 X104.14 Y121.556 E-.06313
G1 X104.217 Y121.835 E-.11001
; WIPE_END
G1 E-.04 F1800
G1 X109.682 Y119.833 Z2 F9000
G1 Z1.6
G1 E.8 F1800
G1 F5895.652
G1 X110.38 Y120.108 E.02413
G3 X115.165 Y125.322 I-3.417 J7.939 E.23448
G2 X111.432 Y126.632 I-1.151 J2.694 E.13966
G1 X111.101 Y126.379 E.01342
G1 X111.216 Y125.686 E.0226
G1 X110.569 Y125.412 E.0226
G1 X110.508 Y124.712 E.02259
G1 X109.813 Y124.607 E.02259
G1 X109.581 Y123.944 E.0226
G1 X108.881 Y124.016 E.0226
G1 X108.526 Y123.484 E.02057
G1 X108.687 Y123.389 E.00602
G2 X109.705 Y119.889 I-1.713 J-2.396 E.12637
; WIPE_START
G1 X110.38 Y120.108 E-.26984
G1 X110.846 Y120.323 E-.19511
G1 X111.298 Y120.567 E-.19511
G1 X111.522 Y120.705 E-.09993
; WIPE_END
G1 E-.04 F1800
G1 X114.141 Y127.874 Z2 F9000
G1 X115.165 Y130.678 Z2
M73 P69 R6
G1 Z1.6
G1 E.8 F1800
G1 F5895.652
G1 X114.986 Y131.155 E.01638
G3 X109.682 Y136.167 I-8.066 J-3.224 E.24219
G2 X108.526 Y132.516 I-2.655 J-1.168 E.13449
G1 X108.881 Y131.984 E.02057
G1 X109.581 Y132.055 E.0226
G1 X109.813 Y131.393 E.02259
G1 X110.508 Y131.288 E.0226
G1 X110.569 Y130.588 E.0226
G1 X111.216 Y130.314 E.02259
G1 X111.101 Y129.621 E.02259
G1 X111.432 Y129.368 E.01342
G1 X111.618 Y129.68 E.01169
G2 X113.73 Y130.899 I2.368 J-1.662 E.08094
G1 X113.895 Y130.918 E.00535
G2 X115.11 Y130.7 I.046 J-3.234 E.03992
; WIPE_START
G1 X114.986 Y131.155 E-.17899
G1 X114.74 Y131.724 E-.23575
G1 X114.503 Y132.18 E-.19529
G1 X114.301 Y132.519 E-.14997
; WIPE_END
G1 E-.04 F1800
G1 X106.674 Y132.231 Z2 F9000
G1 X105.628 Y132.192 Z2
G1 Z1.6
G1 E.8 F1800
G1 F5895.652
G1 X105.706 Y132.386 E.00673
G2 X104.327 Y136.153 I1.326 J2.621 E.14201
G3 X98.856 Y130.681 I2.694 J-8.164 E.2581
G2 X102.393 Y129.683 I1.144 J-2.711 E.12764
G1 X103.148 Y130.121 E.02808
G1 X103.121 Y130.823 E.0226
G1 X103.797 Y131.014 E.0226
G1 X103.945 Y131.701 E.02259
G1 X104.647 Y131.718 E.0226
G1 X104.962 Y132.346 E.02259
G1 X105.57 Y132.205 E.02007
; WIPE_START
G1 X105.706 Y132.386 E-.08599
G1 X105.327 Y132.611 E-.16777
G1 X104.982 Y132.896 E-.16996
G1 X104.684 Y133.23 E-.16983
G1 X104.446 Y133.597 E-.16645
; WIPE_END
G1 E-.04 F1800
G1 X106.739 Y126.317 Z2 F9000
G1 X108.924 Y119.383 Z2
G1 Z1.6
G1 E.8 F1800
G1 F5895.652
G1 X109.02 Y119.238 E.0056
G3 X115.827 Y126.238 I-2.031 J8.784 E.33176
G1 X115.372 Y125.891 E.01838
G1 X115.153 Y125.772 E.00803
G2 X113.777 Y130.495 I-1.146 J2.228 E.28397
G2 X115.372 Y130.109 I.249 J-2.46 E.05382
G1 X115.827 Y129.762 E.01838
G3 X109.02 Y136.762 I-8.859 J-1.805 E.33165
G1 X108.924 Y136.617 E.0056
G2 X107.296 Y132.51 I-1.908 J-1.62 E.17402
G2 X104.898 Y136.365 I-.286 J2.496 E.18231
G1 X105.24 Y136.814 E.01815
G3 X98.196 Y129.769 I1.776 J-8.821 E.33953
G1 X98.641 Y130.109 E.01802
G2 X100.237 Y125.505 I1.364 J-2.105 E.29233
G2 X98.641 Y125.891 I-.224 J2.563 E.05373
G1 X98.196 Y126.231 E.01802
G3 X105.24 Y119.186 I8.813 J1.767 E.33958
G1 X104.898 Y119.634 E.01815
G1 X104.779 Y119.854 E.00803
G2 X107.037 Y123.51 I2.232 J1.147 E.16589
G2 X108.962 Y119.43 I-.037 J-2.512 E.18015
; WIPE_START
G1 X109.02 Y119.238 E-.076
G1 X109.528 Y119.37 E-.19936
G1 X110.039 Y119.537 E-.20437
G1 X110.54 Y119.733 E-.20443
G1 X110.721 Y119.817 E-.07584
; WIPE_END
G1 E-.04 F1800
G1 X105.329 Y125.219 Z2 F9000
G1 X102.041 Y128.512 Z2
G1 Z1.6
G1 E.8 F1800
G1 F5895.652
G1 X102.009 Y128.634 E.00403
G3 X99.765 Y125.91 I-2.002 J-.637 E.28975
G3 X100.19 Y125.91 I.214 J1.376 E.01371
G1 X100.407 Y125.935 E.00703
G3 X102.083 Y128.321 I-.4 J2.062 E.10361
G1 X102.054 Y128.454 E.00438
M204 S250
G1 X101.659 Y128.423 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X101.635 Y128.515 E.00284
G3 X99.811 Y126.301 I-1.628 J-.518 E.21823
G3 X100.145 Y126.299 I.173 J1.084 E.01001
G1 X100.332 Y126.321 E.00561
G3 X101.695 Y128.261 I-.326 J1.677 E.07803
G1 X101.672 Y128.365 E.00316
; WIPE_START
G1 X101.635 Y128.515 E-.05897
G1 X101.54 Y128.759 E-.09947
G1 X101.406 Y128.984 E-.09952
G1 X101.239 Y129.186 E-.09952
G1 X101.044 Y129.36 E-.0995
G1 X100.824 Y129.503 E-.09956
G1 X100.585 Y129.61 E-.09949
G1 X100.332 Y129.679 E-.09952
G1 X100.321 Y129.681 E-.00446
; WIPE_END
G1 E-.04 F1800
G1 X103.955 Y122.969 Z2 F9000
G1 X106.305 Y118.629 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G3 X106.866 Y118.603 I.702 J9.369 E.01808
G1 X107.428 Y118.612 E.01808
G3 X106.245 Y118.633 I-.422 J9.386 E1.86023
M204 S250
G1 X106.275 Y118.237 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X107.446 Y118.22 I.73 J9.76 E.03489
G3 X116.221 Y124.702 I-.451 J9.792 E.34461
G3 X106.215 Y118.242 I-9.216 J3.295 E1.45034
G1 X106.047 Y118.883 F9000
; FEATURE: Gap infill
; LINE_WIDTH: 0.11749
G1 X105.922 Y118.919 E.00077
; LINE_WIDTH: 0.161201
G1 X105.782 Y118.96 E.00136
; LINE_WIDTH: 0.192067
G1 X105.758 Y118.97 E.00031
; LINE_WIDTH: 0.172926
G1 X105.64 Y119.084 E.00168
; LINE_WIDTH: 0.123007
G1 X105.522 Y119.197 E.00103
; LINE_WIDTH: 0.0970702
G1 X105.501 Y119.221 E.00014
; WIPE_START
G1 X105.522 Y119.197 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.958 Y118.878 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.116544
G1 F9000
G1 X108.087 Y118.917 E.00078
; LINE_WIDTH: 0.155808
G1 X108.216 Y118.957 E.0012
; LINE_WIDTH: 0.177553
G1 X108.822 Y119.168 E.00683
G1 X108.797 Y119.206
; LINE_WIDTH: 0.353127
G1 F7736.79
G1 X108.095 Y118.874 E.01904
; WIPE_START
G1 X108.797 Y119.206 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.938 Y123.477 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.103372
G1 F9000
G1 X108.834 Y123.578 E.00069
G1 X108.325 Y123.55
; LINE_WIDTH: 0.332832
G1 F8278.383
G3 X107.655 Y123.79 I-1.954 J-4.397 E.01631
G1 X106.815 Y123.795 F9000
; LINE_WIDTH: 0.112264
G3 X106.494 Y123.686 I1.285 J-4.312 E.00186
G1 X106.048 Y123.533
; LINE_WIDTH: 0.1633
G1 X105.952 Y123.69 E.00174
; LINE_WIDTH: 0.119048
G1 X105.857 Y123.846 E.0011
; WIPE_START
G1 X105.952 Y123.69 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X102.747 Y125.658 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X102.723 Y125.032 E.01868
G1 X102.783 Y124.886 E.0047
G1 X103.464 Y124.673 E.02123
G1 X103.596 Y124.06 E.01868
G1 X103.679 Y123.94 E.00433
G1 X104.402 Y123.896 E.02159
G1 X104.679 Y123.333 E.01868
G1 X104.306 Y122.907 E.01688
G3 X103.74 Y120.493 I2.614 J-1.887 E.07583
G2 X99.511 Y124.731 I3.269 J7.49 E.18257
G1 X100.039 Y124.692 E.01578
G1 X100.623 Y124.745 E.01746
G3 X102.484 Y125.811 I-.682 J3.349 E.06498
G1 X102.695 Y125.689 E.00728
; WIPE_START
G1 X102.484 Y125.811 E-.09286
G1 X102.383 Y125.692 E-.05923
G1 X102.003 Y125.357 E-.1926
G1 X101.577 Y125.083 E-.19273
G1 X101.113 Y124.878 E-.19277
G1 X101.037 Y124.857 E-.02982
; WIPE_END
G1 E-.04 F1800
G1 X103.143 Y124.371 Z2 F9000
G1 Z1.6
G1 E.8 F1800
G1 F6364.866
G1 X103.276 Y123.842 E.01627
G1 X103.476 Y123.622 E.00885
G1 X103.766 Y123.534 E.00903
G1 X104.166 Y123.524 E.01192
G1 X104.227 Y123.403 E.00404
G3 X103.323 Y121.184 I2.772 J-2.424 E.07269
G1 X103.304 Y121.119 E.00201
G2 X100.12 Y124.313 I3.78 J6.951 E.13621
G3 X102.35 Y125.158 I-.176 J3.83 E.07223
G1 X102.348 Y124.973 E.00552
G1 X102.527 Y124.609 E.01209
G3 X103.085 Y124.388 I.74 J1.052 E.01803
G1 X102.822 Y124.07 F9000
G1 F6364.866
G1 X102.941 Y123.67 E.01243
G1 X103.126 Y123.42 E.00925
G1 X103.401 Y123.236 E.00988
G1 X103.593 Y123.194 E.00584
G1 X103.282 Y122.612 E.01963
G3 X103.009 Y121.733 I4.567 J-1.903 E.02748
G2 X100.74 Y124.002 I4.027 J6.294 E.09633
G3 X102.132 Y124.541 I-.955 J4.528 E.04464
G1 X102.272 Y124.332 E.00751
G1 X102.567 Y124.146 E.0104
G1 X102.764 Y124.087 E.00613
G1 X102.503 Y123.771 F9000
G1 F6364.866
G1 X102.605 Y123.498 E.00866
G1 X102.864 Y123.149 E.01296
G1 X103.046 Y123.006 E.00688
G3 X102.779 Y122.351 I2.792 J-1.521 E.02112
G2 X101.357 Y123.772 I4.301 J5.726 E.06005
G1 X102.027 Y124.046 E.02157
G1 X102.346 Y123.832 E.01142
G1 X102.447 Y123.792 E.00324
G1 X102.167 Y123.455 F9000
; LINE_WIDTH: 0.47659
G1 F5534.162
G1 X102.283 Y123.308 E.00643
; LINE_WIDTH: 0.43025
G1 F6196.267
G1 X102.399 Y123.16 E.00575
; LINE_WIDTH: 0.38391
G1 F7038.33
G1 X102.516 Y123.012 E.00506
; LINE_WIDTH: 0.3521
G1 F7762.468
G1 X102.586 Y122.946 E.00235
; WIPE_START
G1 X102.516 Y123.012 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X102.736 Y127.86 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.151085
G1 F9000
G3 X102.736 Y128.14 I-.215 J.14 E.00254
; WIPE_START
G1 X102.778 Y128 E-.38001
G1 X102.736 Y127.86 E-.37999
; WIPE_END
G1 E-.04 F1800
G1 X102.747 Y130.342 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X102.484 Y130.189 E.00907
G1 X102.026 Y130.626 E.01885
M73 P70 R6
G3 X99.497 Y131.267 I-2.006 J-2.605 E.07991
G2 X103.74 Y135.507 I7.531 J-3.292 E.18289
G1 X103.696 Y134.888 E.01851
G3 X104.679 Y132.667 I3.236 J.104 E.07416
G1 X104.402 Y132.104 E.01868
G1 X103.775 Y132.089 E.01868
G1 X103.637 Y132.024 E.00456
G1 X103.463 Y131.327 E.02137
G1 X102.86 Y131.157 E.01868
G1 X102.764 Y131.093 E.00345
G1 X102.723 Y130.955 E.0043
G1 X102.745 Y130.402 E.01648
; WIPE_START
G1 X102.723 Y130.955 E-.21029
G1 X102.764 Y131.093 E-.05482
G1 X102.86 Y131.157 E-.04397
G1 X103.463 Y131.327 E-.23829
G1 X103.599 Y131.87 E-.21263
; WIPE_END
G1 E-.04 F1800
G1 X103.143 Y131.629 Z2 F9000
G1 Z1.6
G1 E.8 F1800
G1 F6364.866
G1 X102.6 Y131.448 E.01704
G1 X102.469 Y131.328 E.0053
G1 X102.346 Y130.953 E.01173
G1 X102.35 Y130.842 E.00332
G1 X101.807 Y131.22 E.01972
G3 X100.12 Y131.687 I-1.799 J-3.217 E.05263
G2 X103.252 Y134.851 I6.933 J-3.731 E.13444
G1 X103.319 Y134.872 E.00208
G3 X104.227 Y132.597 I3.631 J.13 E.07442
G1 X104.166 Y132.476 E.00404
G1 X103.766 Y132.466 E.01192
G1 X103.476 Y132.378 E.00903
G1 X103.276 Y132.158 E.00885
G1 X103.157 Y131.687 E.01448
G1 X102.822 Y131.93 F9000
G1 F6364.866
G1 X102.392 Y131.762 E.01375
G1 X102.173 Y131.563 E.00881
G1 X102.132 Y131.458 E.00334
G3 X100.74 Y131.998 I-2.247 J-3.732 E.04467
G2 X103.009 Y134.267 I6.295 J-4.024 E.09633
G3 X103.593 Y132.806 I4.423 J.921 E.0471
G1 X103.274 Y132.696 E.01004
G1 X103.065 Y132.515 E.00823
G1 X102.882 Y132.189 E.01115
G1 X102.835 Y131.988 E.00613
G1 X102.503 Y132.229 F9000
G1 F6364.866
G1 X102.184 Y132.077 E.01053
G1 X102.027 Y131.954 E.00592
G1 X101.357 Y132.228 E.02157
G1 X101.682 Y132.634 E.01549
G1 X102.276 Y133.239 E.02524
G2 X102.779 Y133.649 I4.831 J-5.41 E.01933
G1 X103.046 Y132.994 E.02107
G1 X102.779 Y132.761 E.01054
G1 X102.554 Y132.39 E.01292
G1 X102.521 Y132.286 E.00324
G1 X102.167 Y132.545 F9000
; LINE_WIDTH: 0.476577
G1 F5534.332
G1 X102.283 Y132.693 E.00644
; LINE_WIDTH: 0.43021
G1 F6196.907
G1 X102.4 Y132.84 E.00575
; LINE_WIDTH: 0.383844
G1 F7039.707
G1 X102.516 Y132.988 E.00506
; LINE_WIDTH: 0.35205
G1 F7763.724
G1 X102.586 Y133.054 E.00234
; WIPE_START
G1 X102.516 Y132.988 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.857 Y132.154 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.119034
G1 F9000
G1 X105.952 Y132.31 E.0011
; LINE_WIDTH: 0.163259
G1 X106.048 Y132.467 E.00174
G1 X106.494 Y132.314
; LINE_WIDTH: 0.112209
G3 X106.815 Y132.206 I1.533 J4.004 E.00185
G1 X107.655 Y132.21
; LINE_WIDTH: 0.332822
G1 F8278.676
G3 X108.325 Y132.45 I-1.288 J4.647 E.01631
G1 X108.834 Y132.422 F9000
; LINE_WIDTH: 0.103331
G1 X108.938 Y132.522 E.00069
; WIPE_START
G1 X108.834 Y132.422 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.402 Y133.019 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42453
G1 F6289.144
G1 X111.463 Y132.975 E.00228
; LINE_WIDTH: 0.39915
G1 F6737.221
G1 X111.525 Y132.932 E.00213
G1 X110.945 Y132.761 F9000
; LINE_WIDTH: 0.424402
G1 F6291.264
G1 X110.9 Y132.86 E.0033
G3 X111.238 Y133.645 I-4.261 J2.302 E.02578
G2 X111.899 Y133.055 I-1.929 J-2.823 E.02678
; LINE_WIDTH: 0.485575
G1 F5421.829
G1 X112.03 Y132.888 E.00739
; LINE_WIDTH: 0.522445
G1 F5004.953
G1 X112.16 Y132.722 E.008
; LINE_WIDTH: 0.574305
G1 F4516.506
G3 X112.525 Y132.27 I12.642 J9.809 E.02441
G1 X111.972 Y132.034 E.02524
G1 X111.737 Y132.395 E.01807
; LINE_WIDTH: 0.550724
G1 F4726.239
G1 X111.642 Y132.453 E.00447
; LINE_WIDTH: 0.51213
G1 F5114.98
G1 X111.546 Y132.511 E.00413
; LINE_WIDTH: 0.473537
G1 F5573.403
G1 X111.451 Y132.569 E.00379
; LINE_WIDTH: 0.437115
G1 F6088.357
G1 X111.001 Y132.739 E.01498
G1 X110.666 Y132.423 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X110.536 Y132.745 E.01032
G1 X110.44 Y132.836 E.00395
G3 X111.005 Y134.267 I-3.862 J2.352 E.04607
G2 X113.272 Y132.002 I-4.075 J-6.345 E.09619
G3 X112.128 Y131.605 I.805 J-4.165 E.03618
G1 X111.774 Y131.539 E.01074
G1 X111.631 Y131.58 E.00442
G1 X111.568 Y131.827 E.00762
G1 X111.369 Y132.127 E.01071
G1 X111.086 Y132.324 E.01025
G1 X110.725 Y132.41 E.01108
G1 X110.386 Y132.084 F9000
; LINE_WIDTH: 0.41999
G1 F6364.875
G1 X110.21 Y132.556 E.01501
G1 X109.966 Y132.798 E.01022
G3 X110.693 Y134.885 I-3.203 J2.286 E.06672
G2 X113.893 Y131.687 I-3.691 J-6.891 E.1367
G3 X112.101 Y131.147 I.102 J-3.582 E.0564
G1 X111.97 Y131.186 E.00407
G1 X111.738 Y131.147 E.007
G1 X111.534 Y131.216 E.00641
G1 X111.291 Y131.166 E.0074
G1 X111.222 Y131.676 E.01532
G1 X111.1 Y131.862 E.00664
G1 X110.855 Y132.009 E.00851
G1 X110.445 Y132.075 E.01236
G1 X110.105 Y131.745 F9000
; LINE_WIDTH: 0.41999
G1 F6364.876
G1 X109.897 Y132.337 E.01868
G1 X109.771 Y132.456 E.00517
G1 X109.407 Y132.432 E.01086
G1 X109.429 Y132.566 E.00404
G1 X109.339 Y132.671 E.00413
G1 X109.65 Y133.003 E.01356
G3 X110.273 Y135.51 I-2.621 J1.983 E.07907
G2 X114.508 Y131.268 I-3.282 J-7.512 E.18278
G1 X113.895 Y131.311 E.01833
G3 X112.122 Y130.704 I.097 J-3.175 E.05664
G1 X111.981 Y130.809 E.00525
G1 X111.701 Y130.754 E.00848
G1 X111.469 Y130.845 E.00741
G3 X111.25 Y130.725 I-.027 J-.212 E.00795
M73 P70 R5
G1 X110.939 Y130.857 E.01005
G1 X110.885 Y131.482 E.01868
G1 X110.803 Y131.621 E.00481
G1 X110.164 Y131.735 E.01934
; WIPE_START
G1 X110.803 Y131.621 E-.24675
G1 X110.885 Y131.482 E-.06136
G1 X110.939 Y130.857 E-.23833
G1 X111.25 Y130.725 E-.12826
G1 X111.334 Y130.817 E-.04725
G1 X111.432 Y130.837 E-.03805
; WIPE_END
G1 E-.04 F1800
G1 X111.399 Y130.173 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.232959
G1 F9000
G1 X111.851 Y130.266 E.00693
G1 X111.621 Y130.363
; LINE_WIDTH: 0.157679
G3 X111.349 Y129.687 I8.428 J-3.778 E.00661
G1 X111.459 Y129.091
; LINE_WIDTH: 0.173563
G3 X111.351 Y128.835 I3.23 J-1.51 E.00287
; LINE_WIDTH: 0.192535
G1 X111.283 Y128.631 E.00254
; LINE_WIDTH: 0.221839
G1 X111.215 Y128.427 E.00304
G1 X111.215 Y127.573
; LINE_WIDTH: 0.221844
G1 X111.283 Y127.369 E.00304
; LINE_WIDTH: 0.192543
G1 X111.351 Y127.165 E.00255
; LINE_WIDTH: 0.173567
G3 X111.459 Y126.909 I3.363 J1.264 E.00287
G1 X111.349 Y126.313
; LINE_WIDTH: 0.157671
G3 X111.621 Y125.637 I8.717 J3.109 E.00661
G1 X111.851 Y125.734
; LINE_WIDTH: 0.233106
G1 X111.399 Y125.827 E.00694
; WIPE_START
G1 X111.851 Y125.734 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.402 Y122.981 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41325
G1 F6480.707
G1 X111.64 Y123.176 E.009
; LINE_WIDTH: 0.358023
G1 F7616.577
G3 X112.051 Y123.574 I-.897 J1.338 E.01431
; WIPE_START
G1 X111.878 Y123.371 E-.35245
G1 X111.64 Y123.176 E-.40755
; WIPE_END
G1 E-.04 F1800
G1 X110.945 Y123.239 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X111.242 Y123.333 E.00927
G1 X111.637 Y123.608 E.01435
G3 X111.959 Y124.058 I-1.893 J1.696 E.0165
G1 X112.657 Y123.772 E.02245
G2 X111.238 Y122.355 I-6.309 J4.9 E.05985
G3 X110.9 Y123.14 I-6.84 J-2.486 E.02546
G1 X110.92 Y123.185 E.00148
G1 X110.666 Y123.577 F9000
G1 F6364.866
G1 X111.086 Y123.676 E.01286
G1 X111.407 Y123.914 E.0119
G1 X111.572 Y124.183 E.0094
G1 X111.631 Y124.42 E.00728
G1 X111.819 Y124.452 E.00567
G1 X112.128 Y124.395 E.00937
G3 X113.272 Y123.998 I1.95 J3.773 E.03617
G2 X111.005 Y121.733 I-6.302 J4.039 E.0962
G1 X110.871 Y122.254 E.01604
G1 X110.612 Y122.878 E.02012
G1 X110.44 Y123.164 E.00994
G3 X110.646 Y123.52 I-.433 J.488 E.01246
G1 X110.386 Y123.916 F9000
G1 F6364.866
G1 X110.931 Y124.019 E.01653
G1 X111.123 Y124.162 E.00714
G1 X111.248 Y124.404 E.00811
G1 X111.291 Y124.834 E.01285
G1 X111.534 Y124.784 E.0074
G1 X111.738 Y124.853 E.00641
G1 X112.065 Y124.819 E.00981
G1 X112.101 Y124.853 E.00145
G1 X112.685 Y124.559 E.01948
G1 X113.262 Y124.387 E.01792
G3 X113.893 Y124.313 I.983 J5.644 E.01893
G2 X112.059 Y122.039 I-7.221 J3.947 E.08747
G1 X111.328 Y121.49 E.02723
G2 X110.694 Y121.115 I-4.429 J6.754 E.02196
G3 X110.268 Y122.724 I-4.122 J-.23 E.04992
G1 X109.966 Y123.202 E.01682
G1 X110.253 Y123.538 E.01317
G1 X110.366 Y123.859 E.01013
G1 X110.105 Y124.255 F9000
G1 F6364.866
G1 X110.725 Y124.348 E.01868
G1 X110.855 Y124.431 E.00458
G3 X110.939 Y125.143 I-8.733 J1.396 E.02136
G1 X111.263 Y125.269 E.01035
G1 X111.334 Y125.183 E.00333
G1 X111.509 Y125.167 E.00523
G1 X111.701 Y125.246 E.00619
G1 X112.012 Y125.193 E.00941
G1 X112.122 Y125.296 E.00449
G1 X112.437 Y125.083 E.01132
G3 X114.514 Y124.733 I1.581 J3.041 E.06378
G2 X110.276 Y120.502 I-7.541 J3.316 E.18257
G1 X110.317 Y121.112 E.01822
G3 X109.339 Y123.329 I-3.236 J-.104 E.07396
G1 X109.43 Y123.434 E.00414
G1 X109.407 Y123.568 E.00405
G1 X109.803 Y123.557 E.0118
G1 X109.897 Y123.663 E.00423
G1 X110.085 Y124.198 E.01689
; WIPE_START
G1 X109.897 Y123.663 E-.21548
G1 X109.803 Y123.557 E-.05399
G1 X109.407 Y123.568 E-.15052
G1 X109.43 Y123.434 E-.05161
G1 X109.339 Y123.329 E-.05275
G1 X109.65 Y122.997 E-.17274
G1 X109.739 Y122.857 E-.0629
; WIPE_END
G1 E-.04 F1800
G1 X115.786 Y126.494 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970932
G1 F9000
G1 X115.81 Y126.516 E.00014
; LINE_WIDTH: 0.12282
G1 X115.922 Y126.633 E.00102
; LINE_WIDTH: 0.172333
G1 X116.035 Y126.749 E.00166
; LINE_WIDTH: 0.188866
G1 X116.047 Y126.781 E.00039
; LINE_WIDTH: 0.15806
G1 X116.088 Y126.916 E.00129
; LINE_WIDTH: 0.116753
G1 X116.125 Y127.041 E.00076
; WIPE_START
G1 X116.088 Y126.916 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.125 Y128.958 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.116752
G1 F9000
G1 X116.088 Y129.084 E.00076
; LINE_WIDTH: 0.158083
G1 X116.047 Y129.219 E.00129
; LINE_WIDTH: 0.188902
G1 X116.035 Y129.251 E.00039
; LINE_WIDTH: 0.172376
G1 X115.922 Y129.367 E.00166
; LINE_WIDTH: 0.12286
G1 X115.81 Y129.484 E.00102
; LINE_WIDTH: 0.0970931
G1 X115.786 Y129.506 E.00014
; WIPE_START
G1 X115.81 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.526 Y134.992 Z2 F9000
G1 X108.797 Y136.794 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.353146
G1 F7736.31
G1 X108.095 Y137.126 E.01903
G1 X108.087 Y137.083 F9000
; LINE_WIDTH: 0.116547
G1 X107.958 Y137.122 E.00078
G1 X108.087 Y137.083
; LINE_WIDTH: 0.155813
G1 X108.216 Y137.043 E.0012
; LINE_WIDTH: 0.177558
G1 X108.822 Y136.831 E.00683
; WIPE_START
G1 X108.216 Y137.043 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X106.047 Y137.117 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.117473
G1 F9000
G1 X105.922 Y137.081 E.00077
; LINE_WIDTH: 0.161176
G1 X105.782 Y137.04 E.00136
; LINE_WIDTH: 0.192077
G1 X105.758 Y137.03 E.00031
; LINE_WIDTH: 0.172952
G1 X105.64 Y136.916 E.00168
; LINE_WIDTH: 0.123041
G1 X105.522 Y136.803 E.00103
; LINE_WIDTH: 0.0970913
G1 X105.501 Y136.779 E.00014
; WIPE_START
G1 X105.522 Y136.803 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.126 Y131.405 Z2 F9000
G1 X98.227 Y129.506 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0970686
G1 F9000
G1 X98.204 Y129.484 E.00014
; LINE_WIDTH: 0.122712
G1 X98.091 Y129.368 E.00102
; LINE_WIDTH: 0.175216
G1 X97.979 Y129.251 E.00169
G1 X97.963 Y129.209 E.00047
; LINE_WIDTH: 0.157764
G1 X97.926 Y129.092 E.00111
; LINE_WIDTH: 0.117862
G1 X97.888 Y128.956 E.00083
; WIPE_START
G1 X97.926 Y129.092 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X97.888 Y127.044 Z2 F9000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.117864
G1 F9000
G1 X97.926 Y126.908 E.00083
; LINE_WIDTH: 0.157757
G1 X97.963 Y126.791 E.00111
; LINE_WIDTH: 0.175229
G1 X97.979 Y126.749 E.00047
G1 X98.091 Y126.632 E.00169
; LINE_WIDTH: 0.122752
G1 X98.204 Y126.516 E.00102
; LINE_WIDTH: 0.0970875
G1 X98.228 Y126.494 E.00014
; CHANGE_LAYER
; Z_HEIGHT: 1.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F9000
G1 X98.204 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 118
M625
; layer num/total_layer_count: 9/23
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
M106 S165.75
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G17
G3 Z2 I.019 J1.217 P1  F9000
G1 X124.56 Y126.108 Z2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X124.536 Y125.481 E.02016
G1 X125.139 Y125.311 E.02016
G1 X125.271 Y124.698 E.02016
G1 X125.898 Y124.684 E.02016
G1 X126.178 Y124.123 E.02016
G1 X126.788 Y124.264 E.02016
G1 X127.199 Y123.791 E.02016
G1 X127.756 Y124.08 E.02016
G1 X128.271 Y123.724 E.02016
G1 X128.738 Y124.142 E.02016
G1 X129.326 Y123.925 E.02016
G1 X129.675 Y124.446 E.02016
G1 X130.298 Y124.382 E.02016
G1 X130.506 Y124.974 E.02016
G1 X131.126 Y125.067 E.02016
G1 X131.18 Y125.691 E.02016
G1 X131.757 Y125.936 E.02016
G1 X131.654 Y126.554 E.02016
G1 X132.153 Y126.934 E.02016
G1 X131.899 Y127.508 E.02016
G1 X132.287 Y128 E.02016
G1 X131.899 Y128.492 E.02016
G1 X132.153 Y129.066 E.02016
G1 X131.654 Y129.446 E.02016
G1 X131.757 Y130.064 E.02016
G1 X131.18 Y130.309 E.02016
G1 X131.126 Y130.933 E.02016
G1 X130.506 Y131.027 E.02016
G1 X130.298 Y131.618 E.02016
G1 X129.675 Y131.554 E.02016
G1 X129.326 Y132.075 E.02016
G1 X128.738 Y131.858 E.02016
G1 X128.271 Y132.276 E.02016
G1 X127.756 Y131.92 E.02016
G1 X127.199 Y132.209 E.02016
G1 X126.788 Y131.736 E.02016
G1 X126.178 Y131.877 E.02016
G1 X125.898 Y131.316 E.02016
G1 X125.271 Y131.302 E.02016
G1 X125.139 Y130.689 E.02016
G1 X124.536 Y130.519 E.02016
G1 X124.56 Y129.892 E.02016
G1 X124.018 Y129.577 E.02016
G1 X124.198 Y128.977 E.02016
G1 X123.751 Y128.537 E.02016
G1 X124.074 Y128 E.02016
G1 X123.751 Y127.463 E.02016
G1 X124.198 Y127.023 E.02016
G1 X124.018 Y126.423 E.02016
G1 X124.508 Y126.138 E.01823
G1 X124.977 Y126.337 F9000
G1 F5895.652
G1 X124.955 Y125.786 E.01772
G1 X125.485 Y125.636 E.01772
G1 X125.601 Y125.098 E.01772
G1 X126.152 Y125.085 E.01772
G1 X126.398 Y124.592 E.01772
G1 X126.935 Y124.716 E.01772
G1 X127.296 Y124.3 E.01772
G1 X127.785 Y124.554 E.01772
G1 X128.239 Y124.241 E.01772
G1 X128.649 Y124.608 E.01772
G1 X129.166 Y124.418 E.01772
G1 X129.472 Y124.876 E.01772
G1 X130.021 Y124.82 E.01772
G1 X130.203 Y125.34 E.01772
G1 X130.748 Y125.422 E.01772
G1 X130.796 Y125.971 E.01772
G1 X131.303 Y126.185 E.01772
G1 X131.213 Y126.729 E.01772
G1 X131.651 Y127.063 E.01772
G1 X131.428 Y127.567 E.01772
G1 X131.769 Y128 E.01772
M73 P71 R5
G1 X131.428 Y128.433 E.01772
G1 X131.651 Y128.937 E.01772
G1 X131.212 Y129.271 E.01772
G1 X131.303 Y129.815 E.01772
G1 X130.796 Y130.029 E.01772
G1 X130.748 Y130.578 E.01772
G1 X130.203 Y130.66 E.01772
G1 X130.021 Y131.18 E.01772
G1 X129.472 Y131.124 E.01772
G1 X129.166 Y131.582 E.01772
G1 X128.649 Y131.392 E.01772
G1 X128.239 Y131.759 E.01772
G1 X127.785 Y131.446 E.01772
G1 X127.296 Y131.7 E.01772
G1 X126.935 Y131.284 E.01772
G1 X126.398 Y131.408 E.01772
G1 X126.152 Y130.915 E.01772
G1 X125.601 Y130.902 E.01772
G1 X125.485 Y130.364 E.01772
G1 X124.955 Y130.214 E.01772
G1 X124.977 Y129.663 E.01772
G1 X124.5 Y129.387 E.01772
G1 X124.658 Y128.859 E.01772
G1 X124.265 Y128.472 E.01772
G1 X124.549 Y128 E.01772
G1 X124.265 Y127.528 E.01772
G1 X124.658 Y127.141 E.01772
G1 X124.5 Y126.613 E.01772
G1 X124.925 Y126.367 E.01579
M204 S250
G1 X125.378 Y126.557 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X125.359 Y126.079 E.01424
G1 X125.819 Y125.95 E.01424
G1 X125.92 Y125.482 E.01424
G1 X126.397 Y125.471 E.01424
G1 X126.611 Y125.044 E.01424
G1 X127.077 Y125.151 E.01424
G1 X127.39 Y124.79 E.01424
G1 X127.814 Y125.011 E.01424
G1 X128.207 Y124.739 E.01424
G1 X128.563 Y125.058 E.01424
G1 X129.012 Y124.893 E.01424
G1 X129.277 Y125.29 E.01424
G1 X129.753 Y125.241 E.01424
G1 X129.911 Y125.692 E.01424
G1 X130.384 Y125.763 E.01424
G1 X130.425 Y126.24 E.01424
G1 X130.865 Y126.426 E.01424
G1 X130.787 Y126.897 E.01424
G1 X131.167 Y127.187 E.01424
G1 X130.974 Y127.625 E.01424
G1 X131.27 Y128 E.01424
G1 X130.974 Y128.375 E.01424
G1 X131.167 Y128.813 E.01424
G1 X130.787 Y129.103 E.01424
G1 X130.865 Y129.574 E.01424
G1 X130.425 Y129.76 E.01424
G1 X130.384 Y130.237 E.01424
G1 X129.911 Y130.308 E.01424
G1 X129.753 Y130.759 E.01424
G1 X129.277 Y130.71 E.01424
G1 X129.012 Y131.107 E.01424
G1 X128.563 Y130.942 E.01424
G1 X128.207 Y131.261 E.01424
G1 X127.814 Y130.989 E.01424
G1 X127.39 Y131.21 E.01424
G1 X127.077 Y130.849 E.01424
G1 X126.611 Y130.956 E.01424
G1 X126.397 Y130.529 E.01424
G1 X125.92 Y130.518 E.01424
G1 X125.819 Y130.05 E.01424
G1 X125.359 Y129.921 E.01424
G1 X125.378 Y129.443 E.01424
G1 X124.964 Y129.203 E.01424
G1 X125.101 Y128.745 E.01424
G1 X124.761 Y128.409 E.01424
G1 X125.007 Y128 E.01424
G1 X124.761 Y127.59 E.01424
G1 X125.101 Y127.255 E.01424
G1 X124.964 Y126.797 E.01424
G1 X125.326 Y126.587 E.01245
; WIPE_START
G1 X125.359 Y126.079 E-.19337
G1 X125.819 Y125.95 E-.18163
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X125.323 Y119.847 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X125.186 Y120.226 E.01296
G2 X126.702 Y123.614 I2.85 J.758 E.12909
G1 X126.624 Y123.808 E.00673
G1 X125.957 Y123.654 E.022
G1 X125.643 Y124.282 E.02259
G1 X124.941 Y124.299 E.02259
G1 X124.793 Y124.986 E.02259
G1 X124.116 Y125.177 E.0226
G1 X124.144 Y125.879 E.0226
G1 X123.389 Y126.317 E.02808
G2 X119.852 Y125.319 I-2.393 J1.712 E.12764
G3 X125.266 Y119.866 I8.165 J2.691 E.25617
; WIPE_START
G1 X125.186 Y120.226 E-.14023
G1 X125.101 Y120.665 E-.16994
G1 X125.084 Y121.112 E-.16984
G1 X125.135 Y121.556 E-.17001
G1 X125.212 Y121.835 E-.10997
; WIPE_END
G1 E-.04 F1800
G1 X130.677 Y119.833 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
G1 F5895.652
G1 X131.376 Y120.108 E.02413
G3 X136.161 Y125.322 I-3.417 J7.939 E.23448
G2 X132.428 Y126.632 I-1.151 J2.694 E.13966
G1 X132.096 Y126.379 E.01342
G1 X132.211 Y125.686 E.02259
G1 X131.564 Y125.412 E.0226
G1 X131.504 Y124.712 E.02259
G1 X130.809 Y124.607 E.0226
G1 X130.576 Y123.944 E.0226
G1 X129.877 Y124.016 E.0226
G1 X129.522 Y123.484 E.02057
G1 X129.682 Y123.389 E.00601
G2 X130.7 Y119.889 I-1.71 J-2.395 E.12639
; WIPE_START
G1 X131.376 Y120.108 E-.26983
G1 X131.842 Y120.323 E-.19511
G1 X132.294 Y120.567 E-.19511
G1 X132.517 Y120.705 E-.09994
; WIPE_END
G1 E-.04 F1800
G1 X135.137 Y127.874 Z2.2 F9000
G1 X136.161 Y130.678 Z2.2
G1 Z1.8
G1 E.8 F1800
G1 F5895.652
G1 X135.961 Y131.211 E.0183
G3 X130.677 Y136.167 I-8.028 J-3.265 E.24033
G2 X129.522 Y132.516 I-2.655 J-1.168 E.13449
G1 X129.877 Y131.984 E.02057
G1 X130.576 Y132.056 E.0226
G1 X130.809 Y131.393 E.02259
G1 X131.504 Y131.288 E.02259
G1 X131.564 Y130.588 E.0226
G1 X132.211 Y130.314 E.02259
G1 X132.096 Y129.621 E.0226
G1 X132.428 Y129.368 E.01342
G1 X132.614 Y129.68 E.01169
G2 X136.105 Y130.701 I2.395 J-1.709 E.12612
; WIPE_START
G1 X135.961 Y131.211 E-.20141
G1 X135.735 Y131.724 E-.21317
G1 X135.499 Y132.18 E-.1951
G1 X135.296 Y132.519 E-.15032
; WIPE_END
G1 E-.04 F1800
G1 X127.669 Y132.231 Z2.2 F9000
G1 X126.624 Y132.192 Z2.2
G1 Z1.8
G1 E.8 F1800
G1 F5895.652
G1 X126.702 Y132.386 E.00673
G2 X125.323 Y136.153 I1.297 J2.611 E.14228
G3 X119.984 Y131.06 I2.687 J-8.16 E.24524
G3 X119.852 Y130.681 I3.088 J-1.292 E.01291
G2 X123.389 Y129.683 I1.144 J-2.711 E.12764
G1 X124.144 Y130.121 E.02808
G1 X124.116 Y130.823 E.0226
G1 X124.793 Y131.014 E.0226
G1 X124.941 Y131.701 E.02259
G1 X125.643 Y131.718 E.0226
G1 X125.957 Y132.346 E.02259
G1 X126.565 Y132.205 E.02007
; WIPE_START
G1 X126.702 Y132.386 E-.08599
G1 X126.322 Y132.611 E-.16779
G1 X125.977 Y132.896 E-.16988
G1 X125.68 Y133.23 E-.16989
G1 X125.442 Y133.597 E-.16645
; WIPE_END
G1 E-.04 F1800
G1 X127.735 Y126.317 Z2.2 F9000
G1 X129.919 Y119.383 Z2.2
G1 Z1.8
G1 E.8 F1800
G1 F5895.652
G1 X130.016 Y119.238 E.0056
G3 X136.822 Y126.238 I-2.037 J8.79 E.33173
G1 X136.368 Y125.891 E.01838
G2 X136.368 Y130.109 I-1.361 J2.109 E.34599
G1 X136.822 Y129.762 E.01838
G3 X130.016 Y136.762 I-8.843 J-1.79 E.33173
G1 X129.919 Y136.617 E.0056
G2 X128.033 Y132.49 I-1.924 J-1.615 E.18207
G2 X125.894 Y136.366 I-.021 J2.517 E.17393
G1 X126.236 Y136.814 E.01814
G3 X119.191 Y129.769 I1.77 J-8.815 E.33957
G1 X119.637 Y130.109 E.01802
G2 X119.637 Y125.891 I1.361 J-2.109 E.34606
G1 X119.191 Y126.231 E.01802
G3 X126.236 Y119.186 I8.812 J1.766 E.33959
G1 X125.894 Y119.634 E.01815
G2 X128.76 Y123.395 I2.118 J1.359 E.19769
G2 X129.957 Y119.43 I-.763 J-2.394 E.15659
G1 X129.551 Y119.579 F9000
G1 F5895.652
G1 X129.572 Y119.601 E.00099
G3 X125.928 Y121.321 I-1.57 J1.396 E.25078
G3 X127.841 Y118.902 I2.086 J-.316 E.1112
G3 X129.34 Y119.377 I.161 J2.094 E.05184
G1 X129.507 Y119.537 E.00743
M204 S250
G1 X129.279 Y119.861 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X129.279 Y119.862 E.00003
G3 X127.871 Y119.294 I-1.277 J1.136 E.27299
G1 X128.133 Y119.294 E.0078
G3 X129.09 Y119.681 I-.131 J1.704 E.03123
G1 X129.235 Y119.82 E.00599
; WIPE_START
G1 X129.279 Y119.862 E-.02307
G1 X129.438 Y120.07 E-.09951
G1 X129.563 Y120.3 E-.09952
G1 X129.652 Y120.547 E-.09952
G1 X129.702 Y120.804 E-.09952
G1 X129.712 Y121.065 E-.09949
G1 X129.682 Y121.326 E-.09954
G1 X129.591 Y121.624 E-.11854
G1 X129.569 Y121.675 E-.0213
; WIPE_END
G1 E-.04 F1800
G1 X135.794 Y126.091 Z2.2 F9000
G1 X136.651 Y126.698 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X136.814 Y126.923 E.00893
G3 X134.682 Y125.925 I-1.804 J1.078 E.34416
G3 X135.863 Y126.08 I.333 J2.039 E.03886
G3 X136.618 Y126.648 I-.852 J1.92 E.03064
M204 S250
G1 X136.326 Y126.926 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X136.356 Y126.949 E.00114
G3 X134.727 Y126.315 I-1.347 J1.05 E.2649
G3 X135.455 Y126.351 I.275 J1.845 E.02187
G3 X136.142 Y126.721 I-.446 J1.648 E.02345
G1 X136.286 Y126.881 E.00641
; WIPE_START
G1 X136.356 Y126.949 E-.03715
G1 X136.473 Y127.126 E-.08045
G1 X136.589 Y127.361 E-.09954
G1 X136.668 Y127.61 E-.09948
G1 X136.708 Y127.869 E-.09956
G1 X136.708 Y128.131 E-.09949
G1 X136.668 Y128.39 E-.09955
G1 X136.589 Y128.639 E-.09952
G1 X136.536 Y128.746 E-.04526
; WIPE_END
G1 E-.04 F1800
G1 X131.285 Y134.285 Z2.2 F9000
G1 X128.744 Y136.965 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X128.482 Y137.048 E.00885
G3 X127.762 Y132.915 I-.471 J-2.048 E.21952
G3 X128.936 Y133.115 I.255 J2.05 E.03885
G3 X128.801 Y136.947 I-.925 J1.886 E.15537
M204 S250
G1 X128.626 Y136.592 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X128.392 Y136.663 E.0073
G3 X127.792 Y133.306 I-.382 J-1.664 E.16475
G3 X128.518 Y133.369 I.204 J1.854 E.02187
G3 X128.681 Y136.569 I-.509 J1.63 E.12384
; WIPE_START
G1 X128.392 Y136.663 E-.1158
M73 P72 R5
G1 X128.133 Y136.706 E-.09948
G1 X127.871 Y136.706 E-.0995
G1 X127.612 Y136.666 E-.09954
G1 X127.363 Y136.587 E-.09952
G1 X127.128 Y136.47 E-.09949
G1 X126.914 Y136.32 E-.09954
G1 X126.825 Y136.234 E-.04713
; WIPE_END
G1 E-.04 F1800
G1 X123.476 Y129.375 Z2.2 F9000
G1 X123.042 Y128.488 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X123.012 Y128.636 E.00487
G3 X120.842 Y125.907 I-2.002 J-.636 E.29204
G3 X122.007 Y126.152 I.176 J2.058 E.03886
G3 X123.086 Y128.322 I-.997 J1.849 E.08306
G1 X123.058 Y128.43 E.00358
M204 S250
G1 X122.661 Y128.398 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X122.638 Y128.518 E.00362
G3 X120.857 Y126.299 I-1.629 J-.517 E.21963
G3 X121.58 Y126.39 I.133 J1.861 E.02188
G3 X122.698 Y128.262 I-.571 J1.61 E.07042
G1 X122.677 Y128.34 E.00242
; WIPE_START
G1 X122.638 Y128.518 E-.06893
G1 X122.535 Y128.759 E-.09969
G1 X122.401 Y128.984 E-.09953
G1 X122.235 Y129.186 E-.09949
G1 X122.039 Y129.36 E-.09954
G1 X121.819 Y129.503 E-.09955
G1 X121.58 Y129.61 E-.09948
G1 X121.342 Y129.675 E-.09379
; WIPE_END
G1 E-.04 F1800
G1 X124.966 Y122.958 Z2.2 F9000
G1 X127.3 Y118.629 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G3 X128.352 Y118.611 I.687 J9.279 E.03385
G3 X126.186 Y118.779 I-.358 J9.389 E1.82836
G3 X127.24 Y118.634 I1.801 J9.128 E.03424
M204 S250
G1 X127.271 Y118.241 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X128.358 Y118.219 I.742 J9.793 E.0324
G3 X137.237 Y124.758 I-.363 J9.792 E.34887
G3 X121.835 Y120.4 I-9.235 J3.241 E1.27338
G3 X127.211 Y118.245 I6.179 J7.634 E.17513
; WIPE_START
G1 X127.856 Y118.211 E-.2453
G1 X128.358 Y118.219 E-.19085
G1 X129.026 Y118.264 E-.25425
G1 X129.207 Y118.288 E-.0696
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2.2 I1.217 J0 P1  F9000
; stop printing object, unique label id: 82
M625
; object ids of layer 9 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.2
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z2.2 F4000
            G39.3 S1
            G0 Z2.2 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END


; object ids of this layer9 end: 82,118
M625
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X129.091 Y118.874 F9000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.353135
G1 F7736.574
G1 X129.793 Y119.206 E.01903
G1 X129.818 Y119.168 F9000
; LINE_WIDTH: 0.177554
G1 X129.211 Y118.957 E.00683
; LINE_WIDTH: 0.155808
G1 X129.082 Y118.917 E.0012
; LINE_WIDTH: 0.116544
G1 X128.953 Y118.878 E.00078
; WIPE_START
G1 X129.082 Y118.917 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.042 Y118.883 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.117484
G1 F9000
G1 X126.917 Y118.919 E.00077
; LINE_WIDTH: 0.161201
G1 X126.778 Y118.96 E.00136
; LINE_WIDTH: 0.192071
G1 X126.754 Y118.97 E.00031
; LINE_WIDTH: 0.17293
G1 X126.636 Y119.083 E.00168
; LINE_WIDTH: 0.123008
G1 X126.518 Y119.197 E.00103
; LINE_WIDTH: 0.0970675
G1 X126.496 Y119.221 E.00014
; WIPE_START
G1 X126.518 Y119.197 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.047 Y123.585 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.160678
G1 F9000
G1 X127.006 Y123.595 E.0004
; LINE_WIDTH: 0.163321
G1 X126.929 Y123.721 E.0014
; LINE_WIDTH: 0.119057
G1 X126.852 Y123.846 E.00088
G1 X127.49 Y123.686
; LINE_WIDTH: 0.112227
G2 X127.81 Y123.795 I1.6 J-4.186 E.00185
G1 X128.651 Y123.79
; LINE_WIDTH: 0.332814
G1 F8278.902
G2 X129.321 Y123.55 I-1.284 J-4.638 E.01631
G1 X129.829 Y123.578 F9000
; LINE_WIDTH: 0.103382
G1 X129.934 Y123.477 E.00069
; WIPE_START
G1 X129.829 Y123.578 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X132.397 Y122.981 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41323
G1 F6481.057
G1 X132.635 Y123.176 E.009
; LINE_WIDTH: 0.358008
G1 F7616.94
G3 X133.046 Y123.574 I-.896 J1.337 E.01431
; WIPE_START
G1 X132.873 Y123.371 E-.35243
G1 X132.635 Y123.176 E-.40757
; WIPE_END
G1 E-.04 F1800
G1 X131.941 Y123.239 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X132.238 Y123.333 E.00927
G1 X132.633 Y123.608 E.01435
G3 X132.955 Y124.058 I-1.904 J1.705 E.0165
G1 X133.652 Y123.772 E.02245
G2 X132.234 Y122.355 I-6.327 J4.915 E.05987
G3 X131.896 Y123.14 I-6.759 J-2.447 E.02547
G1 X131.916 Y123.185 E.00148
G1 X131.662 Y123.577 F9000
G1 F6364.866
G1 X132.082 Y123.676 E.01287
G1 X132.403 Y123.914 E.0119
G1 X132.567 Y124.183 E.0094
G1 X132.627 Y124.421 E.00728
G1 X132.814 Y124.452 E.00565
G1 X133.124 Y124.395 E.0094
G3 X134.267 Y123.998 I1.95 J3.773 E.03617
G2 X132 Y121.733 I-6.301 J4.039 E.0962
G1 X131.866 Y122.254 E.01602
G1 X131.607 Y122.878 E.02014
G1 X131.435 Y123.164 E.00995
G3 X131.641 Y123.52 I-.433 J.488 E.01246
G1 X131.381 Y123.916 F9000
G1 F6364.866
G1 X131.926 Y124.019 E.01653
G1 X132.119 Y124.162 E.00714
G1 X132.243 Y124.405 E.00812
G1 X132.286 Y124.834 E.01283
G1 X132.529 Y124.784 E.00739
G1 X132.733 Y124.853 E.0064
G1 X133.061 Y124.819 E.00984
G1 X133.097 Y124.853 E.00145
G1 X133.681 Y124.559 E.01948
G1 X134.257 Y124.387 E.01792
G3 X134.888 Y124.313 I.983 J5.64 E.01893
G2 X133.055 Y122.04 I-7.221 J3.948 E.08746
G1 X132.323 Y121.491 E.02723
G2 X131.689 Y121.115 I-4.437 J6.767 E.02197
G3 X131.263 Y122.724 I-4.12 J-.229 E.04992
G1 X130.962 Y123.201 E.01682
G1 X131.249 Y123.538 E.01317
G1 X131.361 Y123.859 E.01013
G1 X131.101 Y124.255 F9000
G1 F6364.866
G1 X131.721 Y124.348 E.01868
G1 X131.85 Y124.431 E.00458
G3 X131.935 Y125.143 I-8.738 J1.396 E.02136
G1 X132.257 Y125.27 E.01032
G1 X132.328 Y125.183 E.00334
G1 X132.503 Y125.166 E.00522
G1 X132.696 Y125.246 E.00622
G1 X133.008 Y125.193 E.00943
G1 X133.118 Y125.296 E.00449
G1 X133.433 Y125.083 E.01131
G3 X135.51 Y124.733 I1.581 J3.041 E.06378
G2 X131.271 Y120.502 I-7.541 J3.316 E.18257
G1 X131.313 Y121.112 E.01822
G3 X130.335 Y123.329 I-3.235 J-.104 E.07395
G1 X130.425 Y123.434 E.00414
G1 X130.403 Y123.568 E.00405
G1 X130.799 Y123.557 E.0118
G1 X130.893 Y123.663 E.00423
G1 X131.081 Y124.198 E.01689
; WIPE_START
G1 X130.893 Y123.663 E-.21549
G1 X130.799 Y123.557 E-.05396
G1 X130.403 Y123.568 E-.15048
G1 X130.425 Y123.434 E-.05164
G1 X130.335 Y123.329 E-.05277
G1 X130.645 Y122.997 E-.17276
G1 X130.735 Y122.857 E-.0629
; WIPE_END
G1 E-.04 F1800
G1 X132.394 Y125.827 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.233419
G1 F9000
G1 X132.847 Y125.734 E.00695
G1 X132.616 Y125.636
; LINE_WIDTH: 0.157662
G2 X132.345 Y126.313 I8.774 J3.905 E.00661
G1 X132.455 Y126.909
; LINE_WIDTH: 0.173579
G2 X132.347 Y127.165 I3.265 J1.524 E.00287
; LINE_WIDTH: 0.19254
G1 X132.279 Y127.369 E.00254
; LINE_WIDTH: 0.221835
G1 X132.21 Y127.573 E.00304
G1 X132.21 Y128.426
; LINE_WIDTH: 0.221824
G1 X132.279 Y128.631 E.00304
; LINE_WIDTH: 0.192527
G1 X132.347 Y128.835 E.00255
; LINE_WIDTH: 0.173552
G2 X132.455 Y129.091 I3.37 J-1.267 E.00287
G1 X132.345 Y129.687
; LINE_WIDTH: 0.157733
G2 X132.616 Y130.364 I8.897 J-3.174 E.00661
G1 X132.847 Y130.266
; LINE_WIDTH: 0.233244
G1 X132.394 Y130.173 E.00694
; WIPE_START
G1 X132.847 Y130.266 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X132.397 Y133.019 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42456
G1 F6288.649
G1 X132.459 Y132.975 E.00227
; LINE_WIDTH: 0.39924
G1 F6735.519
G1 X132.52 Y132.932 E.00212
G1 X131.941 Y132.761 F9000
; LINE_WIDTH: 0.42442
G1 F6290.962
G1 X131.896 Y132.86 E.0033
G3 X132.234 Y133.645 I-4.298 J2.319 E.02578
G2 X132.894 Y133.055 I-1.916 J-2.809 E.02677
; LINE_WIDTH: 0.485724
G1 F5420.014
G1 X133.025 Y132.888 E.00739
; LINE_WIDTH: 0.52253
G1 F5004.066
G1 X133.156 Y132.722 E.00801
; LINE_WIDTH: 0.5743
G1 F4516.544
G3 X133.521 Y132.269 I12.669 J9.833 E.02441
G1 X132.967 Y132.034 E.02524
G1 X132.732 Y132.395 E.01807
; LINE_WIDTH: 0.550739
G1 F4726.1
G1 X132.637 Y132.453 E.00448
; LINE_WIDTH: 0.512175
G1 F5114.49
G1 X132.542 Y132.511 E.00414
; LINE_WIDTH: 0.473612
G1 F5572.432
G1 X132.447 Y132.57 E.0038
; LINE_WIDTH: 0.43716
G1 F6087.662
G1 X131.997 Y132.739 E.01497
G1 X131.662 Y132.423 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X131.532 Y132.745 E.01032
G1 X131.435 Y132.836 E.00396
G3 X132 Y134.267 I-3.859 J2.351 E.04607
G2 X134.267 Y132.002 I-4.066 J-6.336 E.09619
G3 X133.124 Y131.605 I.807 J-4.171 E.03617
G1 X132.769 Y131.539 E.01077
G1 X132.627 Y131.58 E.0044
G1 X132.563 Y131.828 E.00763
G1 X132.364 Y132.127 E.0107
G1 X132.082 Y132.324 E.01025
G1 X131.72 Y132.41 E.01108
G1 X131.381 Y132.084 F9000
; LINE_WIDTH: 0.41999
G1 F6364.875
G1 X131.205 Y132.557 E.01501
G1 X130.962 Y132.798 E.01022
G3 X131.689 Y134.885 I-3.203 J2.286 E.06672
G2 X134.888 Y131.687 I-3.691 J-6.891 E.1367
G3 X133.097 Y131.147 I.102 J-3.582 E.05638
G1 X132.965 Y131.186 E.00408
G1 X132.733 Y131.147 E.00702
G1 X132.529 Y131.216 E.0064
G1 X132.286 Y131.166 E.00739
G1 X132.217 Y131.676 E.01533
G1 X132.096 Y131.862 E.00663
G1 X131.85 Y132.009 E.00851
G1 X131.44 Y132.075 E.01236
G1 X131.101 Y131.745 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X130.893 Y132.337 E.01868
G1 X130.766 Y132.456 E.00517
G1 X130.403 Y132.432 E.01086
G1 X130.425 Y132.566 E.00404
G1 X130.334 Y132.671 E.00413
G1 X130.645 Y133.003 E.01355
G3 X131.269 Y135.51 I-2.622 J1.983 E.07906
G2 X135.504 Y131.268 I-3.282 J-7.512 E.18278
G1 X134.89 Y131.311 E.01833
G3 X133.118 Y130.704 I.097 J-3.174 E.05663
G1 X132.976 Y130.809 E.00526
G1 X132.696 Y130.754 E.00849
G1 X132.464 Y130.845 E.00741
G3 X132.245 Y130.726 I-.027 J-.211 E.00795
G1 X131.935 Y130.857 E.01004
G1 X131.88 Y131.482 E.01868
G1 X131.799 Y131.621 E.00481
G1 X131.16 Y131.735 E.01934
; WIPE_START
G1 X131.799 Y131.621 E-.24674
G1 X131.88 Y131.482 E-.06137
G1 X131.935 Y130.857 E-.23832
G1 X132.245 Y130.726 E-.12814
G1 X132.329 Y130.817 E-.04713
G1 X132.428 Y130.837 E-.0383
; WIPE_END
G1 E-.04 F1800
G1 X129.934 Y132.522 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.103344
G1 F9000
G1 X129.829 Y132.422 E.00069
G1 X129.321 Y132.45
; LINE_WIDTH: 0.332822
G1 F8278.658
G2 X128.651 Y132.21 I-1.958 J4.409 E.01631
G1 X127.81 Y132.205 F9000
; LINE_WIDTH: 0.112235
G2 X127.49 Y132.314 I1.278 J4.289 E.00185
G1 X127.043 Y132.467
; LINE_WIDTH: 0.16331
G1 X126.948 Y132.31 E.00174
; LINE_WIDTH: 0.119053
G1 X126.852 Y132.154 E.0011
; WIPE_START
G1 X126.948 Y132.31 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X123.743 Y130.342 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X123.48 Y130.189 E.00907
G1 X123.022 Y130.626 E.01885
G3 X120.493 Y131.267 I-2.006 J-2.605 E.07991
G2 X124.735 Y135.507 I7.531 J-3.292 E.18289
G1 X124.692 Y134.888 E.01851
G3 X125.675 Y132.667 I3.236 J.104 E.07416
G1 X125.398 Y132.104 E.01868
G1 X124.771 Y132.089 E.01868
G1 X124.632 Y132.024 E.00456
G1 X124.459 Y131.327 E.02137
G1 X123.855 Y131.157 E.01868
G1 X123.759 Y131.093 E.00345
G1 X123.719 Y130.955 E.0043
G1 X123.74 Y130.402 E.01648
; WIPE_START
G1 X123.719 Y130.955 E-.21028
G1 X123.759 Y131.093 E-.05484
G1 X123.855 Y131.157 E-.04396
G1 X124.459 Y131.327 E-.2383
G1 X124.594 Y131.87 E-.21261
; WIPE_END
G1 E-.04 F1800
G1 X124.138 Y131.629 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
G1 F6364.866
G1 X123.595 Y131.448 E.01704
G1 X123.464 Y131.328 E.0053
G1 X123.341 Y130.953 E.01173
G1 X123.346 Y130.842 E.00332
G1 X122.802 Y131.22 E.01972
G3 X121.116 Y131.687 I-1.799 J-3.217 E.05263
G2 X124.248 Y134.851 I6.933 J-3.731 E.13444
G1 X124.314 Y134.872 E.00208
G3 X125.223 Y132.597 I3.63 J.13 E.07443
G1 X125.162 Y132.476 E.00404
G1 X124.762 Y132.466 E.01192
G1 X124.472 Y132.378 E.00903
G1 X124.272 Y132.158 E.00885
G1 X124.153 Y131.687 E.01448
G1 X123.817 Y131.93 F9000
G1 F6364.866
G1 X123.387 Y131.762 E.01375
G1 X123.169 Y131.563 E.00881
G1 X123.127 Y131.458 E.00334
G3 X121.736 Y131.998 I-2.247 J-3.731 E.04467
G2 X124.004 Y134.267 I6.295 J-4.024 E.09632
G3 X124.588 Y132.806 I4.422 J.921 E.0471
G1 X124.269 Y132.696 E.01005
G1 X124.061 Y132.515 E.00822
G1 X123.878 Y132.189 E.01115
G1 X123.831 Y131.988 E.00613
G1 X123.499 Y132.229 F9000
G1 F6364.866
G1 X123.179 Y132.077 E.01053
G1 X123.023 Y131.954 E.00592
M73 P73 R5
G1 X122.353 Y132.228 E.02157
G1 X122.678 Y132.634 E.01549
G1 X123.271 Y133.239 E.02524
G2 X123.774 Y133.649 I4.835 J-5.415 E.01933
G1 X124.041 Y132.994 E.02107
G1 X123.775 Y132.761 E.01054
G1 X123.55 Y132.39 E.01292
G1 X123.517 Y132.286 E.00324
G1 X123.163 Y132.545 F9000
; LINE_WIDTH: 0.476577
G1 F5534.332
G1 X123.279 Y132.693 E.00644
; LINE_WIDTH: 0.43021
G1 F6196.907
G1 X123.395 Y132.84 E.00575
; LINE_WIDTH: 0.383844
G1 F7039.707
G1 X123.511 Y132.988 E.00506
; LINE_WIDTH: 0.35205
G1 F7763.724
G1 X123.581 Y133.054 E.00234
; WIPE_START
G1 X123.511 Y132.988 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.496 Y136.779 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970867
G1 F9000
G1 X126.518 Y136.803 E.00014
; LINE_WIDTH: 0.123012
G1 X126.636 Y136.917 E.00103
; LINE_WIDTH: 0.172919
G1 X126.754 Y137.03 E.00168
; LINE_WIDTH: 0.192066
G1 X126.778 Y137.04 E.00031
; LINE_WIDTH: 0.161187
G1 X126.917 Y137.081 E.00136
; LINE_WIDTH: 0.117479
G1 X127.042 Y137.117 E.00077
; WIPE_START
G1 X126.917 Y137.081 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128.953 Y137.122 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.116566
G1 F9000
G1 X129.082 Y137.083 E.00078
; LINE_WIDTH: 0.155863
G1 X129.211 Y137.043 E.0012
; LINE_WIDTH: 0.177617
G1 X129.817 Y136.831 E.00683
G1 X129.793 Y136.794
; LINE_WIDTH: 0.353132
G1 F7736.643
G1 X129.091 Y137.126 E.01903
; WIPE_START
G1 X129.793 Y136.794 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X125.414 Y130.542 Z2.2 F9000
G1 X123.731 Y128.14 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.151066
G1 F9000
G2 X123.731 Y127.86 I-.214 J-.14 E.00254
; WIPE_START
G1 X123.773 Y128 E-.38
G1 X123.731 Y128.14 E-.38
; WIPE_END
G1 E-.04 F1800
G1 X123.743 Y125.658 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X123.718 Y125.032 E.01868
G1 X123.779 Y124.886 E.0047
G1 X124.459 Y124.673 E.02123
G1 X124.591 Y124.06 E.01868
G1 X124.674 Y123.94 E.00433
G1 X125.398 Y123.896 E.02159
G1 X125.675 Y123.333 E.01868
G1 X125.301 Y122.907 E.01687
G3 X124.735 Y120.493 I2.614 J-1.887 E.07583
G2 X120.507 Y124.731 I3.269 J7.49 E.18258
G1 X121.035 Y124.692 E.01578
G1 X121.619 Y124.745 E.01746
G3 X123.48 Y125.811 I-.682 J3.349 E.06498
G1 X123.691 Y125.689 E.00728
; WIPE_START
G1 X123.48 Y125.811 E-.09285
G1 X123.379 Y125.693 E-.05919
G1 X122.999 Y125.357 E-.19266
G1 X122.572 Y125.083 E-.19277
G1 X122.108 Y124.878 E-.19264
G1 X122.032 Y124.857 E-.0299
; WIPE_END
G1 E-.04 F1800
G1 X124.138 Y124.371 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
G1 F6364.866
G1 X124.272 Y123.842 E.01626
G1 X124.472 Y123.622 E.00885
G1 X124.762 Y123.534 E.00903
G1 X125.162 Y123.524 E.01192
G1 X125.223 Y123.403 E.00405
G3 X124.318 Y121.184 I2.771 J-2.423 E.07268
G1 X124.3 Y121.119 E.00202
G2 X121.116 Y124.313 I3.76 J6.932 E.13623
G3 X123.346 Y125.158 I-.176 J3.83 E.07223
G1 X123.343 Y124.973 E.00552
G1 X123.523 Y124.609 E.01209
G3 X124.08 Y124.388 I.74 J1.053 E.01803
G1 X123.817 Y124.07 F9000
G1 F6364.866
G1 X123.936 Y123.67 E.01242
G1 X124.121 Y123.42 E.00926
G1 X124.397 Y123.236 E.00988
G1 X124.588 Y123.194 E.00584
G1 X124.278 Y122.612 E.01963
G3 X124.004 Y121.733 I4.568 J-1.903 E.02747
G2 X121.736 Y124.002 I4.027 J6.293 E.09633
G3 X123.127 Y124.541 I-.954 J4.526 E.04464
G1 X123.267 Y124.332 E.00751
G1 X123.563 Y124.146 E.01039
G1 X123.76 Y124.087 E.00613
G1 X123.499 Y123.771 F9000
G1 F6364.866
G1 X123.6 Y123.498 E.00866
G1 X123.86 Y123.149 E.01296
G1 X124.041 Y123.006 E.00688
G3 X123.774 Y122.351 I2.789 J-1.52 E.02111
G2 X122.353 Y123.772 I4.3 J5.725 E.06005
G1 X123.023 Y124.046 E.02157
G1 X123.341 Y123.832 E.01142
G1 X123.443 Y123.792 E.00325
G1 X123.163 Y123.455 F9000
; LINE_WIDTH: 0.47658
G1 F5534.289
G1 X123.279 Y123.307 E.00644
; LINE_WIDTH: 0.43022
G1 F6196.747
G1 X123.395 Y123.16 E.00575
; LINE_WIDTH: 0.38386
G1 F7039.362
G1 X123.511 Y123.012 E.00506
; LINE_WIDTH: 0.35206
G1 F7763.473
G1 X123.581 Y122.946 E.00235
; WIPE_START
G1 X123.511 Y123.012 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.223 Y126.494 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0971038
G1 F9000
G1 X119.199 Y126.516 E.00014
; LINE_WIDTH: 0.122777
G1 X119.087 Y126.632 E.00102
; LINE_WIDTH: 0.175273
G1 X118.975 Y126.749 E.00169
G1 X118.958 Y126.791 E.00047
; LINE_WIDTH: 0.157768
G1 X118.922 Y126.908 E.00112
; LINE_WIDTH: 0.11786
G1 X118.883 Y127.044 E.00083
; WIPE_START
G1 X118.922 Y126.908 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.883 Y128.956 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.117871
G1 F9000
G1 X118.922 Y129.092 E.00083
; LINE_WIDTH: 0.157765
G1 X118.958 Y129.209 E.00111
; LINE_WIDTH: 0.175213
G1 X118.975 Y129.251 E.00047
G1 X119.087 Y129.368 E.00169
; LINE_WIDTH: 0.122726
G1 X119.199 Y129.484 E.00102
; LINE_WIDTH: 0.0970777
G1 X119.223 Y129.506 E.00014
; WIPE_START
G1 X119.199 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.832 Y129.494 Z2.2 F9000
G1 X136.781 Y129.506 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.0970898
G1 F9000
G1 X136.805 Y129.484 E.00014
; LINE_WIDTH: 0.122842
G1 X136.918 Y129.367 E.00102
; LINE_WIDTH: 0.172353
G1 X137.03 Y129.251 E.00166
; LINE_WIDTH: 0.188884
G1 X137.042 Y129.219 E.00039
; LINE_WIDTH: 0.158099
G1 X137.083 Y129.084 E.00129
; LINE_WIDTH: 0.116756
G1 X137.121 Y128.958 E.00076
; WIPE_START
G1 X137.083 Y129.084 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.121 Y127.041 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.116757
G1 F9000
G1 X137.083 Y126.916 E.00076
; LINE_WIDTH: 0.158073
G1 X137.042 Y126.781 E.00129
; LINE_WIDTH: 0.188879
G1 X137.03 Y126.749 E.00039
; LINE_WIDTH: 0.172344
G1 X136.918 Y126.633 E.00166
; LINE_WIDTH: 0.122829
G1 X136.805 Y126.516 E.00102
; LINE_WIDTH: 0.0970917
G1 X136.781 Y126.494 E.00014
; OBJECT_ID: 118
; WIPE_START
G1 X136.805 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X129.173 Y126.422 Z2.2 F9000
G1 X103.565 Y126.108 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X103.54 Y125.481 E.02016
G1 X104.143 Y125.311 E.02016
G1 X104.275 Y124.698 E.02016
G1 X104.902 Y124.684 E.02016
G1 X105.182 Y124.123 E.02016
G1 X105.793 Y124.264 E.02016
G1 X106.204 Y123.791 E.02016
G1 X106.76 Y124.08 E.02016
G1 X107.276 Y123.724 E.02016
G1 X107.743 Y124.142 E.02016
G1 X108.331 Y123.925 E.02016
G1 X108.679 Y124.446 E.02016
G1 X109.303 Y124.382 E.02016
G1 X109.51 Y124.974 E.02016
G1 X110.13 Y125.067 E.02016
G1 X110.184 Y125.691 E.02016
G1 X110.762 Y125.936 E.02016
G1 X110.659 Y126.554 E.02016
G1 X111.157 Y126.934 E.02016
G1 X110.904 Y127.508 E.02016
G1 X111.292 Y128 E.02016
G1 X110.904 Y128.492 E.02016
G1 X111.157 Y129.066 E.02016
G1 X110.659 Y129.446 E.02016
G1 X110.762 Y130.064 E.02016
G1 X110.184 Y130.309 E.02016
G1 X110.13 Y130.933 E.02016
G1 X109.51 Y131.027 E.02016
G1 X109.303 Y131.618 E.02016
G1 X108.679 Y131.554 E.02016
G1 X108.331 Y132.075 E.02016
G1 X107.743 Y131.858 E.02016
G1 X107.276 Y132.276 E.02016
G1 X106.76 Y131.92 E.02016
G1 X106.204 Y132.209 E.02016
G1 X105.793 Y131.736 E.02016
G1 X105.182 Y131.877 E.02016
G1 X104.902 Y131.316 E.02016
G1 X104.275 Y131.302 E.02016
G1 X104.143 Y130.689 E.02016
G1 X103.54 Y130.519 E.02016
G1 X103.565 Y129.892 E.02016
G1 X103.023 Y129.577 E.02016
G1 X103.202 Y128.977 E.02016
G1 X102.756 Y128.537 E.02016
G1 X103.079 Y128 E.02016
G1 X102.756 Y127.463 E.02016
G1 X103.202 Y127.023 E.02016
G1 X103.023 Y126.423 E.02016
G1 X103.513 Y126.138 E.01823
G1 X103.981 Y126.337 F9000
G1 F5895.652
G1 X103.959 Y125.786 E.01772
G1 X104.49 Y125.636 E.01772
G1 X104.606 Y125.098 E.01772
G1 X105.157 Y125.085 E.01772
G1 X105.403 Y124.592 E.01772
G1 X105.94 Y124.716 E.01772
G1 X106.301 Y124.3 E.01772
G1 X106.79 Y124.554 E.01772
G1 X107.243 Y124.241 E.01772
G1 X107.654 Y124.608 E.01772
G1 X108.171 Y124.418 E.01772
G1 X108.477 Y124.876 E.01772
G1 X109.025 Y124.82 E.01772
G1 X109.208 Y125.34 E.01772
G1 X109.752 Y125.422 E.01772
G1 X109.8 Y125.971 E.01772
G1 X110.307 Y126.185 E.01772
G1 X110.217 Y126.729 E.01772
G1 X110.655 Y127.063 E.01772
G1 X110.432 Y127.567 E.01772
G1 X110.773 Y128 E.01772
G1 X110.432 Y128.433 E.01772
G1 X110.655 Y128.937 E.01772
G1 X110.217 Y129.271 E.01772
G1 X110.307 Y129.815 E.01772
G1 X109.8 Y130.029 E.01772
G1 X109.752 Y130.578 E.01772
G1 X109.208 Y130.66 E.01772
G1 X109.025 Y131.18 E.01772
G1 X108.477 Y131.124 E.01772
G1 X108.171 Y131.582 E.01772
G1 X107.654 Y131.392 E.01772
G1 X107.243 Y131.759 E.01772
G1 X106.79 Y131.446 E.01772
G1 X106.301 Y131.7 E.01772
G1 X105.94 Y131.284 E.01772
G1 X105.403 Y131.408 E.01772
G1 X105.157 Y130.915 E.01772
G1 X104.606 Y130.902 E.01772
G1 X104.49 Y130.364 E.01772
G1 X103.959 Y130.214 E.01772
G1 X103.981 Y129.663 E.01772
G1 X103.505 Y129.387 E.01772
G1 X103.662 Y128.859 E.01772
G1 X103.27 Y128.472 E.01772
G1 X103.554 Y128 E.01772
G1 X103.27 Y127.528 E.01772
G1 X103.662 Y127.141 E.01772
G1 X103.505 Y126.613 E.01772
G1 X103.929 Y126.367 E.01579
M204 S250
G1 X104.382 Y126.557 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X104.363 Y126.079 E.01424
G1 X104.823 Y125.95 E.01424
G1 X104.924 Y125.482 E.01424
G1 X105.402 Y125.471 E.01424
G1 X105.616 Y125.044 E.01424
G1 X106.081 Y125.151 E.01424
G1 X106.394 Y124.79 E.01424
G1 X106.819 Y125.011 E.01424
G1 X107.212 Y124.739 E.01424
G1 X107.568 Y125.058 E.01424
G1 X108.016 Y124.893 E.01424
G1 X108.282 Y125.29 E.01424
G1 X108.757 Y125.241 E.01424
G1 X108.916 Y125.692 E.01424
G1 X109.389 Y125.763 E.01424
G1 X109.43 Y126.24 E.01424
G1 X109.87 Y126.426 E.01424
G1 X109.791 Y126.897 E.01424
G1 X110.171 Y127.187 E.01424
G1 X109.978 Y127.625 E.01424
G1 X110.274 Y128 E.01424
G1 X109.978 Y128.375 E.01424
G1 X110.171 Y128.813 E.01424
G1 X109.792 Y129.103 E.01424
G1 X109.87 Y129.574 E.01424
G1 X109.43 Y129.76 E.01424
G1 X109.389 Y130.237 E.01424
G1 X108.916 Y130.308 E.01424
G1 X108.757 Y130.759 E.01424
G1 X108.282 Y130.71 E.01424
G1 X108.016 Y131.107 E.01424
G1 X107.568 Y130.942 E.01424
G1 X107.212 Y131.261 E.01424
G1 X106.819 Y130.989 E.01424
G1 X106.394 Y131.21 E.01424
G1 X106.081 Y130.849 E.01424
G1 X105.616 Y130.956 E.01424
G1 X105.402 Y130.529 E.01424
G1 X104.924 Y130.518 E.01424
G1 X104.823 Y130.05 E.01424
G1 X104.363 Y129.921 E.01424
G1 X104.382 Y129.443 E.01424
G1 X103.969 Y129.203 E.01424
G1 X104.106 Y128.745 E.01424
G1 X103.765 Y128.409 E.01424
G1 X104.012 Y128 E.01424
G1 X103.765 Y127.59 E.01424
G1 X104.106 Y127.255 E.01424
G1 X103.969 Y126.797 E.01424
G1 X104.33 Y126.587 E.01245
; WIPE_START
G1 X104.363 Y126.079 E-.19337
G1 X104.823 Y125.95 E-.18163
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X104.327 Y119.847 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X104.191 Y120.226 E.01296
G2 X105.706 Y123.614 I2.85 J.758 E.12909
G1 X105.628 Y123.808 E.00673
G1 X104.962 Y123.654 E.022
G1 X104.647 Y124.282 E.02259
G1 X103.945 Y124.299 E.02259
G1 X103.797 Y124.986 E.02259
G1 X103.121 Y125.177 E.0226
G1 X103.148 Y125.879 E.0226
G1 X102.393 Y126.317 E.02808
G2 X98.856 Y125.319 I-2.393 J1.712 E.12764
G3 X104.27 Y119.866 I8.165 J2.691 E.25617
; WIPE_START
G1 X104.191 Y120.226 E-.14023
G1 X104.106 Y120.665 E-.16994
G1 X104.088 Y121.112 E-.16984
G1 X104.14 Y121.556 E-.17001
G1 X104.217 Y121.835 E-.10997
; WIPE_END
G1 E-.04 F1800
G1 X109.682 Y119.833 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
G1 F5895.652
G1 X110.38 Y120.108 E.02413
G3 X115.165 Y125.322 I-3.417 J7.939 E.23448
G2 X111.432 Y126.632 I-1.151 J2.694 E.13966
G1 X111.101 Y126.379 E.01342
G1 X111.216 Y125.686 E.02259
G1 X110.569 Y125.412 E.0226
G1 X110.508 Y124.712 E.02259
G1 X109.813 Y124.607 E.0226
G1 X109.58 Y123.944 E.0226
G1 X108.881 Y124.016 E.0226
G1 X108.526 Y123.484 E.02057
G1 X108.687 Y123.389 E.00601
G2 X109.705 Y119.889 I-1.71 J-2.395 E.12639
; WIPE_START
G1 X110.38 Y120.108 E-.26983
G1 X110.846 Y120.323 E-.19511
G1 X111.298 Y120.567 E-.19511
G1 X111.522 Y120.705 E-.09994
; WIPE_END
G1 E-.04 F1800
G1 X114.141 Y127.874 Z2.2 F9000
G1 X115.165 Y130.678 Z2.2
G1 Z1.8
G1 E.8 F1800
G1 F5895.652
G1 X114.965 Y131.211 E.0183
G3 X109.682 Y136.167 I-8.028 J-3.265 E.24033
G2 X108.526 Y132.516 I-2.655 J-1.168 E.13449
G1 X108.881 Y131.984 E.02057
G1 X109.58 Y132.056 E.0226
G1 X109.813 Y131.393 E.02259
G1 X110.508 Y131.288 E.02259
G1 X110.569 Y130.588 E.0226
G1 X111.216 Y130.314 E.02259
G1 X111.101 Y129.621 E.0226
G1 X111.432 Y129.368 E.01342
G1 X111.618 Y129.68 E.01169
G2 X115.11 Y130.701 I2.395 J-1.709 E.12612
; WIPE_START
G1 X114.965 Y131.211 E-.20141
G1 X114.74 Y131.724 E-.21317
G1 X114.503 Y132.18 E-.1951
G1 X114.3 Y132.519 E-.15032
; WIPE_END
G1 E-.04 F1800
G1 X106.673 Y132.231 Z2.2 F9000
G1 X105.628 Y132.192 Z2.2
G1 Z1.8
G1 E.8 F1800
G1 F5895.652
G1 X105.706 Y132.386 E.00673
G2 X104.327 Y136.153 I1.297 J2.611 E.14228
G3 X98.989 Y131.06 I2.687 J-8.16 E.24524
G3 X98.856 Y130.681 I3.088 J-1.292 E.01291
G2 X102.393 Y129.683 I1.144 J-2.711 E.12764
G1 X103.148 Y130.121 E.02808
G1 X103.121 Y130.823 E.0226
G1 X103.797 Y131.014 E.0226
G1 X103.945 Y131.701 E.02259
G1 X104.647 Y131.718 E.0226
G1 X104.962 Y132.346 E.02259
G1 X105.57 Y132.205 E.02007
; WIPE_START
G1 X105.706 Y132.386 E-.08599
G1 X105.327 Y132.611 E-.16779
G1 X104.982 Y132.896 E-.16988
G1 X104.684 Y133.23 E-.16989
G1 X104.446 Y133.597 E-.16645
; WIPE_END
G1 E-.04 F1800
G1 X106.739 Y126.317 Z2.2 F9000
G1 X108.924 Y119.383 Z2.2
G1 Z1.8
G1 E.8 F1800
G1 F5895.652
G1 X109.02 Y119.238 E.0056
G3 X115.827 Y126.238 I-2.037 J8.79 E.33173
G1 X115.372 Y125.891 E.01838
G2 X115.372 Y130.109 I-1.361 J2.109 E.34599
G1 X115.827 Y129.762 E.01838
G3 X109.02 Y136.762 I-8.843 J-1.79 E.33173
G1 X108.924 Y136.617 E.0056
G2 X107.037 Y132.49 I-1.924 J-1.615 E.18207
G2 X104.898 Y136.366 I-.021 J2.517 E.17393
G1 X105.24 Y136.814 E.01814
G3 X98.196 Y129.769 I1.77 J-8.815 E.33957
G1 X98.641 Y130.109 E.01802
G2 X98.641 Y125.891 I1.361 J-2.109 E.34606
G1 X98.196 Y126.231 E.01802
G3 X105.24 Y119.186 I8.812 J1.766 E.33959
G1 X104.898 Y119.634 E.01815
G2 X107.765 Y123.395 I2.118 J1.359 E.19769
G2 X108.962 Y119.43 I-.763 J-2.394 E.15659
G1 X108.555 Y119.579 F9000
G1 F5895.652
G1 X108.577 Y119.601 E.00099
G3 X104.932 Y121.321 I-1.57 J1.396 E.25078
G3 X106.846 Y118.902 I2.086 J-.316 E.1112
G3 X108.345 Y119.377 I.161 J2.094 E.05184
G1 X108.512 Y119.537 E.00743
M204 S250
G1 X108.283 Y119.861 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X108.283 Y119.862 E.00003
G3 X106.876 Y119.294 I-1.277 J1.136 E.27299
G1 X107.138 Y119.294 E.0078
G3 X108.095 Y119.681 I-.131 J1.704 E.03123
G1 X108.24 Y119.82 E.00599
; WIPE_START
G1 X108.283 Y119.862 E-.02307
G1 X108.443 Y120.07 E-.09951
G1 X108.568 Y120.3 E-.09952
G1 X108.656 Y120.547 E-.09952
G1 X108.706 Y120.804 E-.09952
G1 X108.716 Y121.065 E-.09949
G1 X108.686 Y121.326 E-.09954
G1 X108.596 Y121.624 E-.11854
G1 X108.573 Y121.675 E-.0213
; WIPE_END
G1 E-.04 F1800
M73 P74 R5
G1 X114.799 Y126.091 Z2.2 F9000
G1 X115.655 Y126.698 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X115.819 Y126.923 E.00893
G3 X113.686 Y125.925 I-1.804 J1.078 E.34416
G3 X114.867 Y126.08 I.333 J2.039 E.03886
G3 X115.623 Y126.648 I-.852 J1.92 E.03064
M204 S250
G1 X115.331 Y126.926 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X115.361 Y126.949 E.00114
G3 X113.731 Y126.315 I-1.347 J1.05 E.2649
G3 X114.46 Y126.351 I.275 J1.845 E.02187
G3 X115.147 Y126.721 I-.446 J1.648 E.02345
G1 X115.29 Y126.881 E.00641
; WIPE_START
G1 X115.361 Y126.949 E-.03715
G1 X115.477 Y127.126 E-.08045
G1 X115.593 Y127.361 E-.09954
G1 X115.672 Y127.61 E-.09948
G1 X115.712 Y127.869 E-.09956
G1 X115.712 Y128.131 E-.09949
G1 X115.672 Y128.39 E-.09955
G1 X115.593 Y128.639 E-.09952
G1 X115.54 Y128.746 E-.04526
; WIPE_END
G1 E-.04 F1800
G1 X110.289 Y134.285 Z2.2 F9000
G1 X107.749 Y136.965 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X107.486 Y137.048 E.00885
G3 X106.766 Y132.915 I-.471 J-2.048 E.21952
G3 X107.94 Y133.115 I.255 J2.05 E.03885
G3 X107.806 Y136.947 I-.925 J1.886 E.15537
M204 S250
G1 X107.63 Y136.592 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X107.396 Y136.663 E.0073
G3 X106.796 Y133.306 I-.382 J-1.664 E.16475
G3 X107.523 Y133.369 I.204 J1.854 E.02187
G3 X107.686 Y136.569 I-.509 J1.63 E.12384
; WIPE_START
G1 X107.396 Y136.663 E-.1158
G1 X107.138 Y136.706 E-.09948
G1 X106.876 Y136.706 E-.0995
G1 X106.617 Y136.666 E-.09954
G1 X106.367 Y136.587 E-.09952
G1 X106.133 Y136.47 E-.09949
G1 X105.918 Y136.32 E-.09954
G1 X105.829 Y136.234 E-.04713
; WIPE_END
G1 E-.04 F1800
G1 X102.48 Y129.375 Z2.2 F9000
G1 X102.047 Y128.488 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G1 X102.017 Y128.636 E.00487
G3 X99.846 Y125.907 I-2.002 J-.636 E.29204
G3 X101.012 Y126.152 I.176 J2.058 E.03886
G3 X102.09 Y128.322 I-.997 J1.849 E.08306
G1 X102.062 Y128.43 E.00358
M204 S250
G1 X101.665 Y128.398 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G1 X101.643 Y128.518 E.00362
G3 X99.861 Y126.299 I-1.629 J-.517 E.21963
G3 X100.585 Y126.39 I.133 J1.861 E.02188
G3 X101.703 Y128.262 I-.571 J1.61 E.07042
G1 X101.681 Y128.34 E.00242
; WIPE_START
G1 X101.643 Y128.518 E-.06893
G1 X101.54 Y128.759 E-.09969
G1 X101.406 Y128.984 E-.09953
G1 X101.239 Y129.186 E-.09949
G1 X101.044 Y129.36 E-.09954
G1 X100.824 Y129.503 E-.09955
G1 X100.585 Y129.61 E-.09948
G1 X100.347 Y129.675 E-.09379
; WIPE_END
G1 E-.04 F1800
G1 X103.97 Y122.958 Z2.2 F9000
G1 X106.305 Y118.629 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
G3 X107.357 Y118.611 I.687 J9.279 E.03385
G3 X105.191 Y118.779 I-.358 J9.389 E1.82836
G3 X106.245 Y118.634 I1.801 J9.128 E.03424
M204 S250
G1 X106.276 Y118.241 F9000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S750
G3 X107.362 Y118.219 I.742 J9.793 E.0324
G3 X116.242 Y124.758 I-.363 J9.792 E.34887
G3 X100.839 Y120.4 I-9.235 J3.241 E1.27338
G3 X106.216 Y118.245 I6.179 J7.634 E.17513
G1 X106.047 Y118.883 F9000
; FEATURE: Gap infill
; LINE_WIDTH: 0.117484
G1 X105.922 Y118.919 E.00077
; LINE_WIDTH: 0.161201
G1 X105.782 Y118.96 E.00136
; LINE_WIDTH: 0.192071
G1 X105.758 Y118.97 E.00031
; LINE_WIDTH: 0.17293
G1 X105.64 Y119.083 E.00168
; LINE_WIDTH: 0.123008
G1 X105.522 Y119.197 E.00103
; LINE_WIDTH: 0.0970675
G1 X105.501 Y119.221 E.00014
; WIPE_START
G1 X105.522 Y119.197 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.958 Y118.878 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.116544
G1 F9000
G1 X108.087 Y118.917 E.00078
; LINE_WIDTH: 0.155808
G1 X108.216 Y118.957 E.0012
; LINE_WIDTH: 0.177554
G1 X108.822 Y119.168 E.00683
G1 X108.797 Y119.206
; LINE_WIDTH: 0.353135
G1 F7736.574
G1 X108.095 Y118.874 E.01903
; WIPE_START
G1 X108.797 Y119.206 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.938 Y123.477 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.103382
G1 F9000
G1 X108.834 Y123.578 E.00069
G1 X108.325 Y123.55
; LINE_WIDTH: 0.332814
G1 F8278.902
G3 X107.655 Y123.79 I-1.954 J-4.398 E.01631
G1 X106.815 Y123.795 F9000
; LINE_WIDTH: 0.112227
G3 X106.494 Y123.686 I1.28 J-4.295 E.00185
G1 X106.051 Y123.585
; LINE_WIDTH: 0.160678
G1 X106.01 Y123.595 E.0004
; LINE_WIDTH: 0.163321
G1 X105.933 Y123.721 E.0014
; LINE_WIDTH: 0.119057
G1 X105.857 Y123.846 E.00088
; WIPE_START
G1 X105.933 Y123.721 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X102.747 Y125.658 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X102.723 Y125.032 E.01868
G1 X102.783 Y124.886 E.0047
G1 X103.464 Y124.673 E.02123
G1 X103.596 Y124.06 E.01868
G1 X103.679 Y123.94 E.00433
G1 X104.402 Y123.896 E.02159
G1 X104.679 Y123.333 E.01868
G1 X104.306 Y122.907 E.01687
G3 X103.74 Y120.493 I2.614 J-1.887 E.07583
G2 X99.511 Y124.731 I3.269 J7.49 E.18258
G1 X100.039 Y124.692 E.01578
G1 X100.623 Y124.745 E.01746
G3 X102.484 Y125.811 I-.682 J3.349 E.06498
G1 X102.695 Y125.689 E.00728
; WIPE_START
G1 X102.484 Y125.811 E-.09285
G1 X102.383 Y125.693 E-.05919
G1 X102.003 Y125.357 E-.19266
G1 X101.576 Y125.083 E-.19277
G1 X101.113 Y124.878 E-.19264
G1 X101.037 Y124.857 E-.0299
; WIPE_END
G1 E-.04 F1800
G1 X103.143 Y124.371 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
G1 F6364.866
G1 X103.276 Y123.842 E.01626
G1 X103.476 Y123.622 E.00885
G1 X103.766 Y123.534 E.00903
G1 X104.166 Y123.524 E.01192
G1 X104.227 Y123.403 E.00405
G3 X103.323 Y121.184 I2.771 J-2.423 E.07268
G1 X103.304 Y121.119 E.00202
G2 X100.12 Y124.313 I3.76 J6.932 E.13623
G3 X102.35 Y125.158 I-.176 J3.83 E.07223
G1 X102.348 Y124.973 E.00552
G1 X102.527 Y124.609 E.01209
G3 X103.085 Y124.388 I.74 J1.053 E.01803
G1 X102.822 Y124.07 F9000
G1 F6364.866
G1 X102.941 Y123.67 E.01242
G1 X103.126 Y123.42 E.00926
G1 X103.401 Y123.236 E.00988
G1 X103.593 Y123.194 E.00584
G1 X103.282 Y122.612 E.01963
G3 X103.009 Y121.733 I4.568 J-1.903 E.02747
G2 X100.74 Y124.002 I4.027 J6.293 E.09633
G3 X102.132 Y124.541 I-.954 J4.526 E.04464
G1 X102.272 Y124.332 E.00751
G1 X102.567 Y124.146 E.01039
G1 X102.764 Y124.087 E.00613
G1 X102.503 Y123.771 F9000
G1 F6364.866
G1 X102.605 Y123.498 E.00866
G1 X102.864 Y123.149 E.01296
G1 X103.046 Y123.006 E.00688
G3 X102.778 Y122.351 I2.789 J-1.52 E.02111
G2 X101.357 Y123.772 I4.3 J5.725 E.06005
G1 X102.027 Y124.046 E.02157
G1 X102.346 Y123.832 E.01142
G1 X102.447 Y123.792 E.00325
G1 X102.167 Y123.455 F9000
; LINE_WIDTH: 0.47658
G1 F5534.289
G1 X102.283 Y123.307 E.00644
; LINE_WIDTH: 0.43022
G1 F6196.747
G1 X102.4 Y123.16 E.00575
; LINE_WIDTH: 0.38386
G1 F7039.362
G1 X102.516 Y123.012 E.00506
; LINE_WIDTH: 0.35206
G1 F7763.473
G1 X102.586 Y122.946 E.00235
; WIPE_START
G1 X102.516 Y123.012 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X102.736 Y127.86 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.151066
G1 F9000
G3 X102.736 Y128.14 I-.214 J.14 E.00254
; WIPE_START
G1 X102.778 Y128 E-.38
G1 X102.736 Y127.86 E-.38
; WIPE_END
G1 E-.04 F1800
G1 X102.747 Y130.342 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X102.484 Y130.189 E.00907
G1 X102.026 Y130.626 E.01885
G3 X99.497 Y131.267 I-2.006 J-2.605 E.07991
G2 X103.74 Y135.507 I7.531 J-3.292 E.18289
G1 X103.696 Y134.888 E.01851
G3 X104.679 Y132.667 I3.236 J.104 E.07416
G1 X104.402 Y132.104 E.01868
G1 X103.775 Y132.089 E.01868
G1 X103.637 Y132.024 E.00456
G1 X103.463 Y131.327 E.02137
G1 X102.86 Y131.157 E.01868
G1 X102.764 Y131.093 E.00345
G1 X102.723 Y130.955 E.0043
G1 X102.745 Y130.402 E.01648
; WIPE_START
G1 X102.723 Y130.955 E-.21028
G1 X102.764 Y131.093 E-.05484
G1 X102.86 Y131.157 E-.04396
G1 X103.463 Y131.327 E-.2383
G1 X103.599 Y131.87 E-.21261
; WIPE_END
G1 E-.04 F1800
G1 X103.143 Y131.629 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
G1 F6364.866
G1 X102.6 Y131.448 E.01704
G1 X102.469 Y131.328 E.0053
G1 X102.346 Y130.953 E.01173
G1 X102.35 Y130.842 E.00332
G1 X101.807 Y131.22 E.01972
G3 X100.12 Y131.687 I-1.799 J-3.217 E.05263
G2 X103.252 Y134.851 I6.933 J-3.731 E.13444
G1 X103.319 Y134.872 E.00208
G3 X104.227 Y132.597 I3.63 J.13 E.07443
G1 X104.166 Y132.476 E.00404
G1 X103.766 Y132.466 E.01192
G1 X103.476 Y132.378 E.00903
G1 X103.276 Y132.158 E.00885
G1 X103.157 Y131.687 E.01448
G1 X102.822 Y131.93 F9000
G1 F6364.866
G1 X102.392 Y131.762 E.01375
G1 X102.174 Y131.563 E.00881
G1 X102.132 Y131.458 E.00334
G3 X100.74 Y131.998 I-2.247 J-3.731 E.04467
G2 X103.009 Y134.267 I6.295 J-4.024 E.09632
G3 X103.593 Y132.806 I4.422 J.921 E.0471
G1 X103.274 Y132.696 E.01005
G1 X103.065 Y132.515 E.00822
G1 X102.882 Y132.189 E.01115
G1 X102.835 Y131.988 E.00613
G1 X102.503 Y132.229 F9000
G1 F6364.866
G1 X102.184 Y132.077 E.01053
G1 X102.027 Y131.954 E.00592
G1 X101.357 Y132.228 E.02157
G1 X101.682 Y132.634 E.01549
G1 X102.276 Y133.239 E.02524
G2 X102.778 Y133.649 I4.835 J-5.415 E.01933
G1 X103.046 Y132.994 E.02107
G1 X102.779 Y132.761 E.01054
G1 X102.554 Y132.39 E.01292
M73 P75 R5
G1 X102.521 Y132.286 E.00324
G1 X102.167 Y132.545 F9000
; LINE_WIDTH: 0.476577
G1 F5534.332
G1 X102.283 Y132.693 E.00644
; LINE_WIDTH: 0.43021
G1 F6196.907
G1 X102.4 Y132.84 E.00575
; LINE_WIDTH: 0.383844
G1 F7039.707
G1 X102.516 Y132.988 E.00506
; LINE_WIDTH: 0.35205
G1 F7763.724
G1 X102.586 Y133.054 E.00234
; WIPE_START
G1 X102.516 Y132.988 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.857 Y132.154 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.119053
G1 F9000
G1 X105.952 Y132.31 E.0011
; LINE_WIDTH: 0.16331
G1 X106.048 Y132.467 E.00174
G1 X106.494 Y132.314
; LINE_WIDTH: 0.112235
G3 X106.815 Y132.205 I1.598 J4.18 E.00185
G1 X107.655 Y132.21
; LINE_WIDTH: 0.332822
G1 F8278.658
G3 X108.325 Y132.45 I-1.289 J4.649 E.01631
G1 X108.834 Y132.422 F9000
; LINE_WIDTH: 0.103344
G1 X108.938 Y132.522 E.00069
; WIPE_START
G1 X108.834 Y132.422 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.402 Y133.019 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42456
G1 F6288.649
G1 X111.463 Y132.975 E.00227
; LINE_WIDTH: 0.39924
G1 F6735.519
G1 X111.525 Y132.932 E.00212
G1 X110.945 Y132.761 F9000
; LINE_WIDTH: 0.42442
G1 F6290.962
G1 X110.9 Y132.86 E.0033
G3 X111.238 Y133.645 I-4.298 J2.319 E.02578
G2 X111.899 Y133.055 I-1.916 J-2.809 E.02677
; LINE_WIDTH: 0.485724
G1 F5420.014
G1 X112.03 Y132.888 E.00739
; LINE_WIDTH: 0.52253
G1 F5004.066
G1 X112.16 Y132.722 E.00801
; LINE_WIDTH: 0.5743
G1 F4516.544
G3 X112.525 Y132.269 I12.669 J9.833 E.02441
G1 X111.972 Y132.034 E.02524
G1 X111.737 Y132.395 E.01807
; LINE_WIDTH: 0.550739
G1 F4726.1
G1 X111.642 Y132.453 E.00448
; LINE_WIDTH: 0.512175
G1 F5114.49
G1 X111.546 Y132.511 E.00414
; LINE_WIDTH: 0.473612
G1 F5572.432
G1 X111.451 Y132.57 E.0038
; LINE_WIDTH: 0.43716
G1 F6087.662
G1 X111.001 Y132.739 E.01497
G1 X110.666 Y132.423 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X110.536 Y132.745 E.01032
G1 X110.44 Y132.836 E.00396
G3 X111.005 Y134.267 I-3.859 J2.351 E.04607
G2 X113.272 Y132.002 I-4.066 J-6.336 E.09619
G3 X112.129 Y131.605 I.807 J-4.171 E.03617
G1 X111.773 Y131.539 E.01077
G1 X111.631 Y131.58 E.0044
G1 X111.567 Y131.828 E.00763
G1 X111.369 Y132.127 E.0107
G1 X111.086 Y132.324 E.01025
G1 X110.724 Y132.41 E.01108
G1 X110.386 Y132.084 F9000
; LINE_WIDTH: 0.41999
G1 F6364.875
G1 X110.21 Y132.557 E.01501
G1 X109.966 Y132.798 E.01022
G3 X110.694 Y134.885 I-3.203 J2.286 E.06672
G2 X113.893 Y131.687 I-3.691 J-6.891 E.1367
G3 X112.101 Y131.147 I.102 J-3.582 E.05638
G1 X111.97 Y131.186 E.00408
G1 X111.737 Y131.147 E.00702
G1 X111.534 Y131.216 E.0064
G1 X111.291 Y131.166 E.00739
G1 X111.222 Y131.676 E.01533
G1 X111.1 Y131.862 E.00663
G1 X110.855 Y132.009 E.00851
G1 X110.445 Y132.075 E.01236
G1 X110.105 Y131.745 F9000
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X109.897 Y132.337 E.01868
G1 X109.771 Y132.456 E.00517
G1 X109.407 Y132.432 E.01086
G1 X109.429 Y132.566 E.00404
G1 X109.339 Y132.671 E.00413
G1 X109.65 Y133.003 E.01355
G3 X110.273 Y135.51 I-2.622 J1.983 E.07906
G2 X114.508 Y131.268 I-3.282 J-7.512 E.18278
G1 X113.894 Y131.311 E.01833
G3 X112.122 Y130.704 I.097 J-3.174 E.05663
G1 X111.981 Y130.809 E.00526
G1 X111.701 Y130.754 E.00849
G1 X111.469 Y130.845 E.00741
G3 X111.25 Y130.726 I-.027 J-.211 E.00795
G1 X110.939 Y130.857 E.01004
G1 X110.885 Y131.482 E.01868
G1 X110.803 Y131.621 E.00481
G1 X110.164 Y131.735 E.01934
; WIPE_START
G1 X110.803 Y131.621 E-.24674
G1 X110.885 Y131.482 E-.06137
G1 X110.939 Y130.857 E-.23832
G1 X111.25 Y130.726 E-.12814
G1 X111.333 Y130.817 E-.04713
G1 X111.432 Y130.837 E-.0383
; WIPE_END
G1 E-.04 F1800
G1 X111.399 Y130.173 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.233244
G1 F9000
G1 X111.851 Y130.266 E.00694
G1 X111.621 Y130.364
; LINE_WIDTH: 0.157733
G3 X111.349 Y129.687 I8.626 J-3.851 E.00661
G1 X111.459 Y129.091
; LINE_WIDTH: 0.173552
G3 X111.351 Y128.835 I3.263 J-1.523 E.00287
; LINE_WIDTH: 0.192527
G1 X111.283 Y128.631 E.00255
; LINE_WIDTH: 0.221824
G1 X111.215 Y128.426 E.00304
G1 X111.215 Y127.573
; LINE_WIDTH: 0.221835
G1 X111.283 Y127.369 E.00304
; LINE_WIDTH: 0.19254
G1 X111.351 Y127.165 E.00254
; LINE_WIDTH: 0.173579
G3 X111.459 Y126.909 I3.373 J1.268 E.00287
G1 X111.349 Y126.313
; LINE_WIDTH: 0.157662
G3 X111.62 Y125.636 I9.045 J3.229 E.00661
G1 X111.851 Y125.734
; LINE_WIDTH: 0.233419
G1 X111.399 Y125.827 E.00695
; WIPE_START
G1 X111.851 Y125.734 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X111.402 Y122.981 Z2.2 F9000
G1 Z1.8
M73 P75 R4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41323
G1 F6481.057
G1 X111.64 Y123.176 E.009
; LINE_WIDTH: 0.358008
G1 F7616.94
G3 X112.051 Y123.574 I-.896 J1.337 E.01431
; WIPE_START
G1 X111.878 Y123.371 E-.35243
G1 X111.64 Y123.176 E-.40757
; WIPE_END
G1 E-.04 F1800
G1 X110.945 Y123.239 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
G1 X111.242 Y123.333 E.00927
G1 X111.637 Y123.608 E.01435
G3 X111.959 Y124.058 I-1.904 J1.705 E.0165
G1 X112.657 Y123.772 E.02245
G2 X111.238 Y122.355 I-6.327 J4.915 E.05987
G3 X110.9 Y123.14 I-6.759 J-2.447 E.02547
G1 X110.92 Y123.185 E.00148
G1 X110.666 Y123.577 F9000
G1 F6364.866
G1 X111.086 Y123.676 E.01287
G1 X111.407 Y123.914 E.0119
G1 X111.572 Y124.183 E.0094
G1 X111.631 Y124.421 E.00728
G1 X111.818 Y124.452 E.00565
G1 X112.128 Y124.395 E.0094
G3 X113.272 Y123.998 I1.95 J3.773 E.03617
G2 X111.005 Y121.733 I-6.301 J4.039 E.0962
G1 X110.871 Y122.254 E.01602
G1 X110.612 Y122.878 E.02014
G1 X110.44 Y123.164 E.00995
G3 X110.646 Y123.52 I-.433 J.488 E.01246
G1 X110.386 Y123.916 F9000
G1 F6364.866
G1 X110.931 Y124.019 E.01653
G1 X111.123 Y124.162 E.00714
G1 X111.248 Y124.405 E.00812
G1 X111.291 Y124.834 E.01283
G1 X111.534 Y124.784 E.00739
G1 X111.737 Y124.853 E.0064
G1 X112.066 Y124.819 E.00984
G1 X112.101 Y124.853 E.00145
G1 X112.685 Y124.559 E.01948
G1 X113.262 Y124.387 E.01792
G3 X113.893 Y124.313 I.983 J5.64 E.01893
G2 X112.059 Y122.04 I-7.221 J3.948 E.08746
G1 X111.328 Y121.491 E.02723
G2 X110.693 Y121.115 I-4.437 J6.767 E.02197
G3 X110.268 Y122.724 I-4.12 J-.229 E.04992
G1 X109.966 Y123.201 E.01682
G1 X110.253 Y123.538 E.01317
G1 X110.366 Y123.859 E.01013
G1 X110.105 Y124.255 F9000
G1 F6364.866
G1 X110.725 Y124.348 E.01868
G1 X110.855 Y124.431 E.00458
G3 X110.939 Y125.143 I-8.738 J1.396 E.02136
G1 X111.261 Y125.27 E.01032
G1 X111.333 Y125.183 E.00334
G1 X111.507 Y125.166 E.00522
G1 X111.701 Y125.246 E.00622
G1 X112.013 Y125.193 E.00943
G1 X112.122 Y125.296 E.00449
G1 X112.437 Y125.083 E.01131
G3 X114.514 Y124.733 I1.581 J3.041 E.06378
G2 X110.276 Y120.502 I-7.541 J3.316 E.18257
G1 X110.317 Y121.112 E.01822
G3 X109.339 Y123.329 I-3.235 J-.104 E.07395
G1 X109.43 Y123.434 E.00414
G1 X109.407 Y123.568 E.00405
G1 X109.803 Y123.557 E.0118
G1 X109.897 Y123.663 E.00423
G1 X110.085 Y124.198 E.01689
; WIPE_START
G1 X109.897 Y123.663 E-.21549
G1 X109.803 Y123.557 E-.05396
G1 X109.407 Y123.568 E-.15048
G1 X109.43 Y123.434 E-.05164
G1 X109.339 Y123.329 E-.05277
G1 X109.65 Y122.997 E-.17276
G1 X109.739 Y122.857 E-.0629
; WIPE_END
G1 E-.04 F1800
G1 X115.786 Y126.494 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970917
G1 F9000
G1 X115.81 Y126.516 E.00014
; LINE_WIDTH: 0.122829
G1 X115.922 Y126.633 E.00102
; LINE_WIDTH: 0.172344
G1 X116.035 Y126.749 E.00166
; LINE_WIDTH: 0.188879
G1 X116.047 Y126.781 E.00039
; LINE_WIDTH: 0.158073
G1 X116.088 Y126.916 E.00129
; LINE_WIDTH: 0.116757
G1 X116.125 Y127.041 E.00076
; WIPE_START
G1 X116.088 Y126.916 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.125 Y128.958 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.116756
G1 F9000
G1 X116.088 Y129.084 E.00076
; LINE_WIDTH: 0.158099
G1 X116.047 Y129.219 E.00129
; LINE_WIDTH: 0.188884
G1 X116.035 Y129.251 E.00039
; LINE_WIDTH: 0.172353
G1 X115.922 Y129.367 E.00166
; LINE_WIDTH: 0.122842
G1 X115.81 Y129.484 E.00102
; LINE_WIDTH: 0.0970898
G1 X115.786 Y129.506 E.00014
; WIPE_START
G1 X115.81 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.526 Y134.992 Z2.2 F9000
G1 X108.797 Y136.794 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.353132
G1 F7736.643
G1 X108.095 Y137.126 E.01903
G1 X108.087 Y137.083 F9000
; LINE_WIDTH: 0.116566
G1 X107.958 Y137.122 E.00078
G1 X108.087 Y137.083
; LINE_WIDTH: 0.155863
G1 X108.216 Y137.043 E.0012
; LINE_WIDTH: 0.177617
G1 X108.822 Y136.831 E.00683
; WIPE_START
G1 X108.216 Y137.043 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X106.047 Y137.117 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.117479
G1 F9000
G1 X105.922 Y137.081 E.00077
; LINE_WIDTH: 0.161187
G1 X105.782 Y137.04 E.00136
; LINE_WIDTH: 0.192066
G1 X105.758 Y137.03 E.00031
; LINE_WIDTH: 0.172919
G1 X105.64 Y136.917 E.00168
; LINE_WIDTH: 0.123012
G1 X105.522 Y136.803 E.00103
; LINE_WIDTH: 0.0970867
G1 X105.501 Y136.779 E.00014
; WIPE_START
G1 X105.522 Y136.803 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.126 Y131.405 Z2.2 F9000
G1 X98.228 Y129.506 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.0970777
G1 F9000
G1 X98.204 Y129.484 E.00014
; LINE_WIDTH: 0.122726
G1 X98.092 Y129.368 E.00102
; LINE_WIDTH: 0.175213
G1 X97.979 Y129.251 E.00169
G1 X97.963 Y129.209 E.00047
; LINE_WIDTH: 0.157765
G1 X97.926 Y129.092 E.00111
; LINE_WIDTH: 0.117871
G1 X97.888 Y128.956 E.00083
; WIPE_START
G1 X97.926 Y129.092 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X97.888 Y127.044 Z2.2 F9000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.11786
G1 F9000
G1 X97.926 Y126.908 E.00083
; LINE_WIDTH: 0.157768
G1 X97.963 Y126.791 E.00112
; LINE_WIDTH: 0.175273
G1 X97.979 Y126.749 E.00047
G1 X98.091 Y126.632 E.00169
; LINE_WIDTH: 0.122777
G1 X98.204 Y126.516 E.00102
; LINE_WIDTH: 0.0971038
G1 X98.228 Y126.494 E.00014
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F9000
G1 X98.204 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 118
M625
; layer num/total_layer_count: 10/23
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
M106 S147.9
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G17
G3 Z2.2 I-.002 J1.217 P1  F9000
G1 X125.378 Y126.557 Z2.2
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
G1 X125.359 Y126.079 E.01424
G1 X125.819 Y125.95 E.01424
G1 X125.92 Y125.482 E.01424
G1 X126.397 Y125.471 E.01424
G1 X126.611 Y125.044 E.01424
G1 X127.077 Y125.151 E.01424
G1 X127.39 Y124.79 E.01424
G1 X127.814 Y125.011 E.01424
G1 X128.207 Y124.739 E.01424
G1 X128.563 Y125.058 E.01424
G1 X129.012 Y124.893 E.01424
G1 X129.277 Y125.29 E.01424
G1 X129.753 Y125.241 E.01424
G1 X129.911 Y125.692 E.01424
G1 X130.384 Y125.763 E.01424
G1 X130.425 Y126.24 E.01424
G1 X130.865 Y126.426 E.01424
G1 X130.787 Y126.897 E.01424
G1 X131.167 Y127.187 E.01424
G1 X130.974 Y127.625 E.01424
G1 X131.27 Y128 E.01424
G1 X130.974 Y128.375 E.01424
G1 X131.167 Y128.813 E.01424
G1 X130.787 Y129.103 E.01424
G1 X130.865 Y129.574 E.01424
G1 X130.425 Y129.76 E.01424
G1 X130.384 Y130.237 E.01424
G1 X129.911 Y130.308 E.01424
G1 X129.753 Y130.759 E.01424
G1 X129.277 Y130.71 E.01424
G1 X129.012 Y131.107 E.01424
G1 X128.563 Y130.942 E.01424
G1 X128.207 Y131.261 E.01424
G1 X127.814 Y130.989 E.01424
G1 X127.39 Y131.21 E.01424
G1 X127.077 Y130.849 E.01424
G1 X126.611 Y130.956 E.01424
G1 X126.397 Y130.529 E.01424
G1 X125.92 Y130.518 E.01424
G1 X125.819 Y130.05 E.01424
G1 X125.359 Y129.921 E.01424
G1 X125.378 Y129.443 E.01424
G1 X124.964 Y129.203 E.01424
G1 X125.101 Y128.745 E.01424
G1 X124.761 Y128.41 E.01424
G1 X125.007 Y128 E.01424
G1 X124.761 Y127.59 E.01424
G1 X125.101 Y127.255 E.01424
G1 X124.964 Y126.797 E.01424
G1 X125.326 Y126.587 E.01245
; WIPE_START
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18163
G1 X125.92 Y125.482 E-.18164
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X129.28 Y119.863 Z2.4 F9000
G1 Z2
G1 E.8 F1800
G1 F6364.704
G1 X129.438 Y120.07 E.00777
G3 X127.871 Y119.294 I-1.435 J.928 E.26517
G1 X128.134 Y119.294 E.00782
G3 X129.239 Y119.819 I-.131 J1.704 E.03727
; WIPE_START
G1 X129.438 Y120.07 E-.12179
G1 X129.563 Y120.3 E-.09951
G1 X129.652 Y120.547 E-.0995
G1 X129.702 Y120.804 E-.09953
G1 X129.712 Y121.065 E-.09949
G1 X129.682 Y121.326 E-.09956
G1 X129.612 Y121.578 E-.09952
G1 X129.568 Y121.677 E-.04111
; WIPE_END
G1 E-.04 F1800
G1 X135.598 Y126.356 Z2.4 F9000
G1 X136.331 Y126.924 Z2.4
G1 Z2
G1 E.8 F1800
G1 F6364.704
G1 X136.476 Y127.124 E.00737
G3 X134.689 Y126.319 I-1.468 J.875 E.25765
G1 X134.937 Y126.291 E.00744
G3 X136.297 Y126.875 I.071 J1.707 E.0456
; WIPE_START
G1 X136.476 Y127.124 E-.11646
G1 X136.589 Y127.361 E-.09965
G1 X136.668 Y127.61 E-.09951
G1 X136.708 Y127.869 E-.09953
G1 X136.708 Y128.132 E-.09981
G1 X136.664 Y128.401 E-.10383
G1 X136.589 Y128.639 E-.09487
G1 X136.535 Y128.749 E-.04634
; WIPE_END
G1 E-.04 F1800
G1 X131.115 Y134.122 Z2.4 F9000
G1 X128.623 Y136.592 Z2.4
G1 Z2
G1 E.8 F1800
G1 F6364.704
G1 X128.391 Y136.663 E.00722
G3 X127.753 Y133.308 I-.383 J-1.665 E.16377
G1 X128.002 Y133.289 E.00744
G3 X128.679 Y136.569 I.006 J1.709 E.13953
; WIPE_START
G1 X128.391 Y136.663 E-.11479
G1 X128.133 Y136.706 E-.09945
G1 X127.871 Y136.706 E-.0995
G1 X127.612 Y136.666 E-.09956
G1 X127.363 Y136.587 E-.0995
G1 X127.128 Y136.47 E-.09949
G1 X126.914 Y136.32 E-.09954
G1 X126.823 Y136.232 E-.04818
; WIPE_END
G1 E-.04 F1800
G1 X123.254 Y129.485 Z2.4 F9000
G1 X122.667 Y128.373 Z2.4
G1 Z2
G1 E.8 F1800
G1 F6364.704
G1 X122.636 Y128.517 E.00438
G3 X120.818 Y126.3 I-1.628 J-.519 E.21844
G1 X121.068 Y126.291 E.00743
G3 X122.696 Y128.262 I-.059 J1.707 E.08605
G1 X122.682 Y128.315 E.00165
; WIPE_START
G1 X122.636 Y128.517 E-.07871
M73 P76 R4
G1 X122.535 Y128.759 E-.09962
G1 X122.401 Y128.984 E-.09951
G1 X122.235 Y129.186 E-.09952
G1 X122.039 Y129.361 E-.09983
G1 X121.808 Y129.508 E-.10383
G1 X121.58 Y129.61 E-.09487
G1 X121.367 Y129.669 E-.08411
; WIPE_END
G1 E-.04 F1800
G1 X124.869 Y122.887 Z2.4 F9000
G1 X127.271 Y118.237 Z2.4
G1 Z2
G1 E.8 F1800
G1 F6364.704
G3 X128.412 Y118.219 I.72 J9.507 E.03401
G3 X127.211 Y118.242 I-.417 J9.779 E1.79598
; WIPE_START
G1 X127.856 Y118.211 E-.24533
G1 X128.412 Y118.219 E-.21131
G1 X129.026 Y118.264 E-.23391
G1 X129.207 Y118.288 E-.06945
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2.4 I1.217 J0 P1  F9000
; stop printing object, unique label id: 82
M625
; object ids of layer 10 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.4
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z2.4 F4000
            G39.3 S1
            G0 Z2.4 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END


; object ids of this layer10 end: 82,118
M625
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X136.332 Y132.733 F9000
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
G1 F6364.704
M204 S500
G1 X132.738 Y136.327 E.1514
G1 X131.689 Y136.842
G1 X136.843 Y131.689 E.21711
G1 X137.146 Y130.852
G1 X130.854 Y137.145 E.26506
G1 X130.12 Y137.345
G1 X137.344 Y130.121 E.3043
G1 X137.472 Y129.46
G1 X129.464 Y137.468 E.33732
G1 X128.858 Y137.541
G1 X137.547 Y128.852 E.36602
G1 X137.58 Y128.285
G1 X128.29 Y137.575 E.39134
G1 X128.475 Y136.857
G1 X127.755 Y137.577 E.03032
G1 X127.247 Y137.552
G1 X127.886 Y136.913 E.0269
G1 X127.438 Y136.828
G1 X126.765 Y137.501 E.02835
G1 X126.305 Y137.427
G1 X127.063 Y136.669 E.03193
G1 X126.75 Y136.449
G1 X125.863 Y137.336 E.03735
G1 X125.437 Y137.229
G1 X126.492 Y136.174 E.04444
G1 X126.286 Y135.846
G1 X125.025 Y137.108 E.05314
G1 X124.632 Y136.967
G1 X126.142 Y135.457 E.06361
G1 X126.087 Y134.979
G1 X124.252 Y136.814 E.07729
G1 X123.884 Y136.648
G1 X126.209 Y134.324 E.09793
; WIPE_START
M204 S750
G1 X124.795 Y135.738 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.859 Y135.473 Z2.4 F9000
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S500
G1 X135.475 Y129.857 E.23656
G1 X134.886 Y129.912
G1 X129.915 Y134.884 E.20944
G1 X129.831 Y134.435
G1 X134.437 Y129.829 E.19403
G1 X134.062 Y129.67
G1 X129.672 Y134.06 E.18491
G1 X129.449 Y133.75
G1 X133.751 Y129.448 E.18123
G1 X133.491 Y129.174
G1 X129.177 Y133.489 E.18175
G1 X128.852 Y133.28
G1 X133.282 Y128.85 E.18661
G1 X133.144 Y128.455
G1 X128.457 Y133.142 E.19743
G1 X127.983 Y133.083
G1 X133.085 Y127.981 E.21492
G1 X133.215 Y127.318
G1 X131.059 Y129.474 E.0908
; WIPE_START
M204 S750
G1 X132.473 Y128.059 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.58 Y127.752 Z2.4 F9000
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S500
G1 X136.859 Y128.473 E.03038
G1 X136.915 Y127.883
G1 X137.552 Y127.246 E.02684
G1 X137.501 Y126.765
G1 X136.83 Y127.435 E.02826
G1 X136.672 Y127.06
G1 X137.429 Y126.303 E.0319
G1 X137.339 Y125.86
G1 X136.452 Y126.747 E.03739
G1 X136.176 Y126.489
G1 X137.234 Y125.432 E.04454
G1 X137.107 Y125.026
G1 X135.849 Y126.283 E.05297
G1 X135.459 Y126.14
G1 X136.968 Y124.631 E.06357
G1 X136.817 Y124.249
G1 X134.981 Y126.085 E.07733
G1 X134.326 Y126.207
G1 X136.653 Y123.88 E.09801
G1 X136.472 Y123.527
G1 X131.33 Y128.669 E.2166
G1 X131.504 Y127.962
G1 X136.282 Y123.184 E.20129
G1 X136.083 Y122.85
G1 X131.269 Y127.664 E.20279
G1 X131.341 Y127.059
G1 X135.867 Y122.533 E.19068
G1 X135.643 Y122.223
G1 X131.038 Y126.828 E.19398
G1 X131.053 Y126.28
G1 X135.41 Y121.923 E.18356
G1 X135.162 Y121.638
G1 X130.678 Y126.121 E.18888
G1 X130.585 Y125.681
G1 X134.906 Y121.36 E.18203
G1 X134.642 Y121.092
G1 X130.206 Y125.527 E.18684
G1 X129.969 Y125.231
G1 X134.362 Y120.838 E.18505
G1 X134.075 Y120.592
G1 X129.62 Y125.046 E.18763
G1 X129.253 Y124.88
G1 X133.777 Y120.356 E.19057
M73 P77 R4
G1 X133.467 Y120.133
G1 X128.88 Y124.72 E.19321
G1 X128.418 Y124.649
G1 X133.147 Y119.92 E.19922
G1 X132.818 Y119.716
G1 X127.776 Y124.757 E.21236
G1 X127.425 Y124.575
G1 X132.472 Y119.528 E.21259
G1 X132.117 Y119.35
G1 X129.799 Y121.668 E.09764
G1 X129.917 Y121.017
G1 X131.752 Y119.182 E.07728
G1 X131.369 Y119.032
G1 X129.862 Y120.539 E.0635
G1 X129.718 Y120.15
G1 X130.973 Y118.894 E.0529
G1 X130.565 Y118.77
G1 X129.511 Y119.823 E.04439
G1 X129.253 Y119.548
G1 X130.141 Y118.66 E.03744
G1 X129.696 Y118.571
G1 X128.939 Y119.329 E.03191
G1 X128.563 Y119.171
G1 X129.233 Y118.501 E.02822
G1 X128.749 Y118.452
G1 X128.114 Y119.087 E.02676
G1 X127.523 Y119.145
G1 X128.244 Y118.424 E.03037
; WIPE_START
M204 S750
G1 X127.523 Y119.145 E-.38742
G1 X128.114 Y119.087 E-.22588
G1 X128.387 Y118.814 E-.14671
; WIPE_END
G1 E-.04 F1800
G1 X128.676 Y122.791 Z2.4 F9000
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S500
G1 X126.632 Y124.835 E.08613
; WIPE_START
M204 S750
G1 X128.046 Y123.421 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.573 Y130.899 Z2.4 F9000
G1 X129.583 Y130.95 Z2.4
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S500
G1 X127.32 Y133.212 E.09531
; WIPE_START
M204 S750
G1 X128.734 Y131.798 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128.763 Y131.237 Z2.4 F9000
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S500
G1 X123.528 Y136.471 E.22051
G1 X123.187 Y136.28
G1 X128.057 Y131.409 E.20517
G1 X127.597 Y131.335
G1 X122.854 Y136.079 E.1998
G1 X122.533 Y135.867
G1 X127.15 Y131.249 E.19449
G1 X126.723 Y131.143
G1 X122.226 Y135.64 E.18944
G1 X121.927 Y135.406
G1 X126.378 Y130.955 E.18752
G1 X126.071 Y130.729
G1 X121.638 Y135.162 E.18674
G1 X121.363 Y134.904
G1 X125.715 Y130.552 E.18332
G1 X125.545 Y130.188
G1 X121.095 Y134.638 E.18743
G1 X120.839 Y134.361
G1 X125.146 Y130.054 E.18145
G1 X125.129 Y129.538
G1 X120.595 Y134.072 E.19099
G1 X120.359 Y133.775
G1 X124.791 Y129.342 E.18672
G1 X124.831 Y128.77
G1 X120.134 Y133.466 E.19784
G1 X119.923 Y133.144
G1 X124.562 Y128.505 E.19543
G1 X124.678 Y127.856
G1 X119.72 Y132.814 E.20886
G1 X119.529 Y132.471
G1 X124.853 Y127.148 E.22426
G1 X124.73 Y126.737
G1 X122.793 Y128.674 E.08159
G1 X122.92 Y128.014
G1 X128.016 Y122.917 E.2147
G1 X127.544 Y122.856
G1 X122.86 Y127.541 E.19734
G1 X122.719 Y127.148
G1 X127.149 Y122.718 E.18661
G1 X126.825 Y122.509
G1 X122.511 Y126.823 E.18173
G1 X122.251 Y126.55
G1 X126.552 Y122.248 E.18121
G1 X126.33 Y121.937
G1 X121.94 Y126.328 E.18495
G1 X121.564 Y126.17
G1 X126.173 Y121.561 E.19415
G1 X126.089 Y121.112
G1 X121.114 Y126.087 E.20959
G1 X120.524 Y126.144
G1 X126.146 Y120.522 E.23685
; WIPE_START
M204 S750
G1 X124.732 Y121.936 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.962 Y129.048 Z2.4 F9000
G1 X121.67 Y129.797 Z2.4
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S500
G1 X119.353 Y132.114 E.09763
G1 X119.187 Y131.747
G1 X121.019 Y129.915 E.07719
G1 X120.541 Y129.859
G1 X119.033 Y131.368 E.06355
G1 X118.896 Y130.971
G1 X120.152 Y129.715 E.05291
G1 X119.826 Y129.509
G1 X118.773 Y130.561 E.04435
G1 X118.664 Y130.137
G1 X119.551 Y129.25 E.03733
G1 X119.331 Y128.936
G1 X118.572 Y129.696 E.032
G1 X118.502 Y129.233
G1 X119.173 Y128.561 E.02829
G1 X119.089 Y128.112
G1 X118.453 Y128.748 E.02681
G1 X118.428 Y128.24
G1 X119.148 Y127.52 E.03032
G1 X118.429 Y127.706
G1 X127.709 Y118.425 E.39095
G1 X127.142 Y118.46
G1 X118.463 Y127.138 E.3656
G1 X118.537 Y126.531
G1 X126.534 Y118.535 E.33684
M73 P78 R4
G1 X125.873 Y118.661
G1 X118.662 Y125.873 E.30377
G1 X118.856 Y125.146
G1 X125.146 Y118.856 E.26496
G1 X124.304 Y119.164
G1 X119.167 Y124.302 E.21642
G1 X119.683 Y123.252
G1 X123.253 Y119.682 E.15038
; WIPE_START
M204 S750
G1 X121.839 Y121.096 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.933 Y125.691 Z2.4 F9000
G1 X136.6 Y132.225 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.110658
G1 F9000
G1 X136.491 Y132.374 E.00099
; LINE_WIDTH: 0.155613
G1 X136.382 Y132.524 E.00165
; LINE_WIDTH: 0.200569
G1 X136.272 Y132.673 E.0023
G1 X135.805 Y133.556
; LINE_WIDTH: 0.094634
G1 X135.746 Y133.626 E.00038
; LINE_WIDTH: 0.11929
G1 X135.557 Y133.841 E.00173
; LINE_WIDTH: 0.1557
G1 X135.368 Y134.056 E.00255
; LINE_WIDTH: 0.203041
G3 X134.164 Y135.269 I-15.796 J-14.474 E.02162
; LINE_WIDTH: 0.170691
G1 X133.951 Y135.46 E.00289
; LINE_WIDTH: 0.138609
G1 X133.737 Y135.65 E.00216
; LINE_WIDTH: 0.10536
G1 X133.567 Y135.794 E.0011
; WIPE_START
G1 X133.737 Y135.65 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.153 Y134.796 Z2.4 F9000
G1 X126.018 Y134.781 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.100633
G1 F9000
G1 X126.101 Y134.993 E.00104
; WIPE_START
G1 X126.018 Y134.781 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.578 Y133.719 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0915321
G1 F9000
G1 X126.47 Y133.833 E.0006
; LINE_WIDTH: 0.110696
G1 X126.378 Y133.947 E.00079
; LINE_WIDTH: 0.142558
G1 X126.28 Y134.069 E.00123
; LINE_WIDTH: 0.17299
G1 X126.214 Y134.165 E.0012
; LINE_WIDTH: 0.199745
G1 X126.147 Y134.262 E.00145
; WIPE_START
G1 X126.214 Y134.165 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.254 Y133.146 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.181643
G1 F9000
G1 X127.124 Y133.239 E.00175
; LINE_WIDTH: 0.161694
G1 X127.009 Y133.329 E.00138
; LINE_WIDTH: 0.124684
G1 X126.889 Y133.422 E.00098
; LINE_WIDTH: 0.0972015
G1 X126.733 Y133.564 E.00091
; WIPE_START
G1 X126.889 Y133.422 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.989 Y135.076 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0894748
G1 F9000
G1 X129.914 Y134.904 E.00069
G1 X129.932 Y135.546
; LINE_WIDTH: 0.103662
G3 X129.715 Y135.856 I-3.968 J-2.543 E.00182
G1 X129.907 Y135.691
; LINE_WIDTH: 0.0958324
G1 X129.846 Y135.46 E.001
; WIPE_START
G1 X129.907 Y135.691 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128.863 Y136.709 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.122389
G1 F9000
G3 X128.601 Y136.889 I-2.408 J-3.217 E.002
G1 X128.213 Y137.575
; LINE_WIDTH: 0.101751
G1 X128.044 Y137.555 E.00079
; WIPE_START
G1 X128.213 Y137.575 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X122.776 Y132.219 Z2.4 F9000
G1 X118.447 Y127.954 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.103216
G1 F9000
G1 X118.427 Y127.778 E.00085
; WIPE_START
G1 X118.447 Y127.954 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.298 Y127.13 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.112262
G1 F9000
G1 X119.198 Y127.269 E.00094
; LINE_WIDTH: 0.137842
G1 X119.115 Y127.395 E.00113
; WIPE_START
G1 X119.198 Y127.269 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X120.451 Y126.072 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.106359
G1 F9000
G2 X120.136 Y126.293 I2.576 J4.013 E.00193
; WIPE_START
G1 X120.451 Y126.072 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X122.86 Y128.741 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.178255
G1 F9000
G1 X122.762 Y128.877 E.00179
; LINE_WIDTH: 0.158344
G1 X122.672 Y128.993 E.00134
; LINE_WIDTH: 0.121389
G1 X122.579 Y129.112 E.00094
; LINE_WIDTH: 0.0955663
G1 X122.46 Y129.243 E.00074
G1 X122.232 Y129.471
; LINE_WIDTH: 0.0900968
G1 X122.166 Y129.533 E.00034
; LINE_WIDTH: 0.108928
G1 X122.048 Y129.628 E.00079
; LINE_WIDTH: 0.142955
G1 X121.922 Y129.728 E.00127
; LINE_WIDTH: 0.174056
G1 X121.827 Y129.794 E.00119
; LINE_WIDTH: 0.200106
G1 X121.732 Y129.859 E.00143
G1 X121.217 Y129.984
; LINE_WIDTH: 0.102575
G1 X121.005 Y129.901 E.00107
; WIPE_START
G1 X121.217 Y129.984 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X122.155 Y122.409 Z2.4 F9000
G1 X122.427 Y120.211 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.105052
G1 F9000
G1 X122.239 Y120.374 E.00122
; LINE_WIDTH: 0.138806
G1 X122.051 Y120.538 E.00189
; LINE_WIDTH: 0.179181
G1 X121.631 Y120.924 E.00614
; LINE_WIDTH: 0.2069
G2 X120.829 Y121.733 I13.126 J13.831 E.01476
; LINE_WIDTH: 0.180225
G1 X120.637 Y121.944 E.0031
; LINE_WIDTH: 0.152437
G1 X120.445 Y122.156 E.00247
; LINE_WIDTH: 0.125936
G1 X120.333 Y122.287 E.00113
; LINE_WIDTH: 0.100763
G1 X120.221 Y122.417 E.00078
; WIPE_START
G1 X120.333 Y122.287 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X123.764 Y119.41 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.105177
G1 F9000
G1 X123.672 Y119.477 E.00056
; LINE_WIDTH: 0.139182
G1 X123.58 Y119.543 E.00086
; LINE_WIDTH: 0.173186
G1 X123.487 Y119.61 E.00117
; LINE_WIDTH: 0.206858
G1 X123.314 Y119.743 E.00283
; WIPE_START
G1 X123.487 Y119.61 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.358 Y124.559 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0815106
G1 F9000
G1 X127.349 Y124.532 E.00009
; LINE_WIDTH: 0.111701
G1 X127.311 Y124.525 E.00021
; LINE_WIDTH: 0.14753
G1 X127.292 Y124.525 E.00015
; LINE_WIDTH: 0.177165
G1 X126.922 Y124.922 E.00575
G1 X126.61 Y124.822
; LINE_WIDTH: 0.139696
G1 X126.499 Y124.776 E.00093
G1 X126.465 Y124.805 E.00034
; LINE_WIDTH: 0.164321
G1 X126.349 Y124.966 E.00191
; LINE_WIDTH: 0.212029
G1 X126.232 Y125.128 E.00266
; LINE_WIDTH: 0.259737
G1 X126.116 Y125.289 E.00341
; WIPE_START
G1 X126.232 Y125.128 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X125.177 Y126.261 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.308161
G1 F9000
G1 X124.916 Y126.462 E.0069
; LINE_WIDTH: 0.258462
G1 X124.655 Y126.663 E.00561
; WIPE_START
G1 X124.916 Y126.462 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.055 Y129.719 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.107638
G1 F9000
G1 X130.939 Y129.797 E.00071
; LINE_WIDTH: 0.146565
G1 X130.823 Y129.875 E.00114
; LINE_WIDTH: 0.185492
G1 X130.707 Y129.953 E.00157
; LINE_WIDTH: 0.224419
G1 X130.591 Y130.031 E.002
; WIPE_START
G1 X130.707 Y129.953 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.136 Y129.1 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0964658
G1 F9000
G1 X130.998 Y129.221 E.00078
; WIPE_START
G1 X131.136 Y129.1 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.264 Y126.145 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.199759
G1 F9000
G1 X134.167 Y126.211 E.00145
; LINE_WIDTH: 0.171977
G1 X134.064 Y126.283 E.00129
; LINE_WIDTH: 0.141702
G1 X133.95 Y126.375 E.00114
; LINE_WIDTH: 0.101325
G1 X133.73 Y126.567 E.00135
G1 X133.566 Y126.731
; LINE_WIDTH: 0.097406
G1 X133.421 Y126.891 E.00093
; LINE_WIDTH: 0.125265
G1 X133.331 Y127.006 E.00095
; LINE_WIDTH: 0.172069
G2 X133.148 Y127.251 I3.132 J2.528 E.00312
; WIPE_START
G1 X133.331 Y127.006 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X135.694 Y129.905 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0958414
G1 F9000
G1 X135.462 Y129.844 E.001
G1 X135.858 Y129.713
; LINE_WIDTH: 0.103671
G3 X135.548 Y129.93 I-2.982 J-3.923 E.00182
; WIPE_START
G1 X135.858 Y129.713 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.253 Y130.502 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0958473
G1 F9000
G1 X137.088 Y130.795 E.00141
; WIPE_START
G1 X137.253 Y130.502 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.929 Y128.542 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.124483
G1 F9000
G3 X136.711 Y128.861 I-4.239 J-2.667 E.00249
; WIPE_START
G1 X136.929 Y128.542 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.529 Y123.148 Z2.4 F9000
G1 X127.453 Y119.076 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.13784
G1 F9000
G1 X127.271 Y119.196 E.00163
; LINE_WIDTH: 0.112262
G1 X127.132 Y119.296 E.00094
; WIPE_START
G1 X127.271 Y119.196 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.099 Y120.303 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0910057
G1 F9000
G1 X126.16 Y120.535 E.00091
G1 X126.295 Y120.134
; LINE_WIDTH: 0.103289
G2 X126.074 Y120.449 I4.208 J3.194 E.00184
; WIPE_START
G1 X126.295 Y120.134 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.245 Y122.458 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0958483
G1 F9000
G1 X129.109 Y122.581 E.00077
; LINE_WIDTH: 0.123427
G1 X128.989 Y122.674 E.00097
; LINE_WIDTH: 0.173024
G3 X128.743 Y122.857 I-2.633 J-3.287 E.00315
; WIPE_START
G1 X128.989 Y122.674 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.861 Y121.73 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.198908
G1 F9000
G1 X129.792 Y121.83 E.0015
; LINE_WIDTH: 0.169457
G1 X129.718 Y121.938 E.0013
; LINE_WIDTH: 0.138398
G1 X129.626 Y122.051 E.0011
; LINE_WIDTH: 0.100989
G1 X129.473 Y122.23 E.00108
; OBJECT_ID: 118
; WIPE_START
G1 X129.626 Y122.051 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X122.112 Y123.392 Z2.4 F9000
G1 X104.382 Y126.557 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
G1 X104.363 Y126.079 E.01424
G1 X104.823 Y125.95 E.01424
G1 X104.924 Y125.482 E.01424
G1 X105.402 Y125.471 E.01424
G1 X105.616 Y125.044 E.01424
G1 X106.081 Y125.151 E.01424
G1 X106.394 Y124.79 E.01424
G1 X106.819 Y125.011 E.01424
G1 X107.212 Y124.739 E.01424
G1 X107.568 Y125.058 E.01424
G1 X108.016 Y124.893 E.01424
G1 X108.282 Y125.29 E.01424
G1 X108.757 Y125.241 E.01424
G1 X108.916 Y125.692 E.01424
G1 X109.389 Y125.763 E.01424
G1 X109.43 Y126.24 E.01424
G1 X109.87 Y126.426 E.01424
G1 X109.791 Y126.897 E.01424
G1 X110.171 Y127.187 E.01424
G1 X109.978 Y127.625 E.01424
G1 X110.274 Y128 E.01424
G1 X109.978 Y128.375 E.01424
G1 X110.171 Y128.813 E.01424
G1 X109.792 Y129.103 E.01424
G1 X109.87 Y129.574 E.01424
G1 X109.43 Y129.76 E.01424
G1 X109.389 Y130.237 E.01424
G1 X108.916 Y130.308 E.01424
G1 X108.757 Y130.759 E.01424
G1 X108.282 Y130.71 E.01424
G1 X108.016 Y131.107 E.01424
G1 X107.568 Y130.942 E.01424
G1 X107.212 Y131.261 E.01424
G1 X106.819 Y130.989 E.01424
G1 X106.394 Y131.21 E.01424
G1 X106.081 Y130.849 E.01424
G1 X105.616 Y130.956 E.01424
G1 X105.402 Y130.529 E.01424
G1 X104.924 Y130.518 E.01424
M73 P79 R4
G1 X104.823 Y130.05 E.01424
G1 X104.363 Y129.921 E.01424
G1 X104.382 Y129.443 E.01424
G1 X103.969 Y129.203 E.01424
G1 X104.106 Y128.745 E.01424
G1 X103.765 Y128.41 E.01424
G1 X104.012 Y128 E.01424
G1 X103.765 Y127.59 E.01424
G1 X104.106 Y127.255 E.01424
G1 X103.969 Y126.797 E.01424
G1 X104.33 Y126.587 E.01245
; WIPE_START
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18163
G1 X104.924 Y125.482 E-.18164
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X108.284 Y119.863 Z2.4 F9000
G1 Z2
G1 E.8 F1800
G1 F6364.704
G1 X108.442 Y120.07 E.00777
G3 X106.876 Y119.294 I-1.435 J.928 E.26517
G1 X107.138 Y119.294 E.00782
G3 X108.244 Y119.819 I-.131 J1.704 E.03727
; WIPE_START
G1 X108.442 Y120.07 E-.12179
G1 X108.568 Y120.3 E-.09951
G1 X108.656 Y120.547 E-.0995
G1 X108.706 Y120.804 E-.09953
G1 X108.716 Y121.065 E-.09949
G1 X108.686 Y121.326 E-.09956
G1 X108.617 Y121.578 E-.09952
G1 X108.572 Y121.677 E-.04111
; WIPE_END
G1 E-.04 F1800
G1 X114.603 Y126.356 Z2.4 F9000
G1 X115.335 Y126.924 Z2.4
G1 Z2
G1 E.8 F1800
G1 F6364.704
G1 X115.481 Y127.124 E.00737
G3 X113.693 Y126.319 I-1.468 J.875 E.25765
G1 X113.941 Y126.291 E.00744
G3 X115.301 Y126.875 I.071 J1.707 E.0456
; WIPE_START
G1 X115.481 Y127.124 E-.11646
G1 X115.593 Y127.361 E-.09965
G1 X115.672 Y127.61 E-.09951
G1 X115.712 Y127.869 E-.09953
G1 X115.712 Y128.132 E-.09981
G1 X115.669 Y128.401 E-.10383
G1 X115.593 Y128.639 E-.09487
G1 X115.539 Y128.749 E-.04634
; WIPE_END
G1 E-.04 F1800
G1 X110.119 Y134.122 Z2.4 F9000
G1 X107.628 Y136.592 Z2.4
G1 Z2
G1 E.8 F1800
G1 F6364.704
G1 X107.396 Y136.663 E.00722
G3 X106.758 Y133.308 I-.383 J-1.665 E.16377
G1 X107.007 Y133.289 E.00744
G3 X107.683 Y136.569 I.006 J1.709 E.13953
; WIPE_START
G1 X107.396 Y136.663 E-.11479
G1 X107.138 Y136.706 E-.09945
G1 X106.876 Y136.706 E-.0995
G1 X106.617 Y136.666 E-.09956
G1 X106.367 Y136.587 E-.0995
G1 X106.133 Y136.47 E-.09949
G1 X105.918 Y136.32 E-.09954
G1 X105.827 Y136.232 E-.04818
; WIPE_END
G1 E-.04 F1800
G1 X102.259 Y129.485 Z2.4 F9000
G1 X101.671 Y128.373 Z2.4
G1 Z2
G1 E.8 F1800
G1 F6364.704
G1 X101.641 Y128.517 E.00438
G3 X99.823 Y126.3 I-1.628 J-.519 E.21844
G1 X100.072 Y126.291 E.00743
G3 X101.701 Y128.262 I-.059 J1.707 E.08605
G1 X101.687 Y128.315 E.00165
; WIPE_START
G1 X101.641 Y128.517 E-.07871
G1 X101.54 Y128.759 E-.09962
G1 X101.406 Y128.984 E-.09951
G1 X101.239 Y129.186 E-.09952
G1 X101.043 Y129.361 E-.09983
G1 X100.813 Y129.508 E-.10383
G1 X100.585 Y129.61 E-.09487
G1 X100.371 Y129.669 E-.08411
; WIPE_END
G1 E-.04 F1800
G1 X103.874 Y122.887 Z2.4 F9000
G1 X106.275 Y118.237 Z2.4
G1 Z2
G1 E.8 F1800
G1 F6364.704
G3 X107.416 Y118.219 I.72 J9.507 E.03401
G3 X106.215 Y118.242 I-.417 J9.779 E1.79598
; WIPE_START
G1 X106.86 Y118.211 E-.24533
G1 X107.416 Y118.219 E-.21131
G1 X108.03 Y118.264 E-.23391
G1 X108.211 Y118.288 E-.06945
; WIPE_END
G1 E-.04 F1800
G1 X111.588 Y125.133 Z2.4 F9000
G1 X115.337 Y132.733 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
G1 F6364.704
M204 S500
G1 X111.742 Y136.327 E.1514
G1 X110.694 Y136.842
G1 X115.847 Y131.689 E.21711
G1 X116.15 Y130.852
G1 X109.858 Y137.145 E.26506
G1 X109.124 Y137.345
G1 X116.348 Y130.121 E.3043
G1 X116.476 Y129.46
G1 X108.469 Y137.468 E.33732
G1 X107.862 Y137.541
G1 X116.551 Y128.852 E.36602
G1 X116.585 Y128.285
G1 X107.295 Y137.575 E.39134
G1 X107.48 Y136.857
G1 X106.76 Y137.577 E.03032
G1 X106.252 Y137.552
G1 X106.89 Y136.913 E.0269
G1 X106.442 Y136.828
G1 X105.769 Y137.501 E.02835
G1 X105.309 Y137.427
G1 X106.067 Y136.669 E.03193
G1 X105.754 Y136.449
G1 X104.867 Y137.336 E.03735
G1 X104.441 Y137.229
G1 X105.496 Y136.174 E.04444
G1 X105.291 Y135.846
G1 X104.029 Y137.108 E.05314
G1 X103.637 Y136.967
G1 X105.147 Y135.457 E.06361
G1 X105.092 Y134.979
G1 X103.257 Y136.814 E.07729
G1 X102.889 Y136.648
G1 X105.214 Y134.324 E.09793
; WIPE_START
M204 S750
G1 X103.799 Y135.738 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.864 Y135.473 Z2.4 F9000
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S500
G1 X114.48 Y129.857 E.23656
G1 X113.891 Y129.912
G1 X108.919 Y134.884 E.20944
G1 X108.835 Y134.435
G1 X113.441 Y129.829 E.19403
G1 X113.066 Y129.67
G1 X108.677 Y134.06 E.18491
G1 X108.454 Y133.75
G1 X112.756 Y129.448 E.18123
G1 X112.496 Y129.174
G1 X108.181 Y133.489 E.18175
G1 X107.857 Y133.28
G1 X112.287 Y128.85 E.18661
G1 X112.149 Y128.455
G1 X107.462 Y133.142 E.19743
G1 X106.987 Y133.083
G1 X112.089 Y127.981 E.21492
G1 X112.219 Y127.318
G1 X110.063 Y129.474 E.0908
; WIPE_START
M204 S750
G1 X111.478 Y128.059 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.585 Y127.752 Z2.4 F9000
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S500
G1 X115.864 Y128.473 E.03038
G1 X115.92 Y127.883
G1 X116.557 Y127.246 E.02684
G1 X116.505 Y126.765
G1 X115.835 Y127.435 E.02826
G1 X115.676 Y127.06
G1 X116.433 Y126.303 E.0319
G1 X116.344 Y125.86
G1 X115.456 Y126.747 E.03739
G1 X115.181 Y126.489
G1 X116.238 Y125.432 E.04454
G1 X116.111 Y125.026
G1 X114.854 Y126.283 E.05297
G1 X114.464 Y126.14
G1 X115.973 Y124.631 E.06357
G1 X115.821 Y124.249
G1 X113.986 Y126.085 E.07733
G1 X113.33 Y126.207
G1 X115.657 Y123.88 E.09801
G1 X115.477 Y123.527
G1 X110.335 Y128.669 E.2166
G1 X110.508 Y127.962
G1 X115.287 Y123.184 E.20129
G1 X115.087 Y122.85
G1 X110.273 Y127.664 E.20279
G1 X110.345 Y127.059
G1 X114.872 Y122.533 E.19068
G1 X114.648 Y122.223
G1 X110.043 Y126.828 E.19398
G1 X110.057 Y126.28
G1 X114.415 Y121.923 E.18356
G1 X114.167 Y121.638
G1 X109.683 Y126.121 E.18888
G1 X109.59 Y125.681
G1 X113.911 Y121.36 E.18203
G1 X113.646 Y121.092
G1 X109.211 Y125.527 E.18684
G1 X108.974 Y125.231
G1 X113.367 Y120.838 E.18505
G1 X113.079 Y120.592
G1 X108.625 Y125.046 E.18763
G1 X108.258 Y124.88
G1 X112.782 Y120.356 E.19057
G1 X112.471 Y120.133
G1 X107.885 Y124.72 E.19321
G1 X107.422 Y124.649
M73 P80 R4
G1 X112.152 Y119.92 E.19922
G1 X111.822 Y119.716
G1 X106.781 Y124.757 E.21236
G1 X106.43 Y124.575
G1 X111.477 Y119.528 E.21259
G1 X111.122 Y119.35
G1 X108.804 Y121.668 E.09764
G1 X108.922 Y121.017
G1 X110.756 Y119.182 E.07728
G1 X110.373 Y119.032
G1 X108.866 Y120.539 E.0635
G1 X108.722 Y120.15
G1 X109.978 Y118.894 E.0529
G1 X109.569 Y118.77
G1 X108.515 Y119.823 E.04439
G1 X108.257 Y119.548
G1 X109.146 Y118.66 E.03744
G1 X108.701 Y118.571
G1 X107.943 Y119.329 E.03191
G1 X107.568 Y119.171
G1 X108.238 Y118.501 E.02822
G1 X107.754 Y118.452
G1 X107.119 Y119.087 E.02676
G1 X106.527 Y119.145
G1 X107.248 Y118.424 E.03037
; WIPE_START
M204 S750
G1 X106.527 Y119.145 E-.38742
G1 X107.119 Y119.087 E-.22588
G1 X107.392 Y118.814 E-.14671
; WIPE_END
G1 E-.04 F1800
G1 X107.681 Y122.791 Z2.4 F9000
G1 Z2
M73 P80 R3
G1 E.8 F1800
G1 F6364.704
M204 S500
G1 X105.636 Y124.835 E.08613
; WIPE_START
M204 S750
G1 X107.05 Y123.421 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.577 Y130.899 Z2.4 F9000
G1 X108.587 Y130.95 Z2.4
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S500
G1 X106.325 Y133.212 E.09531
; WIPE_START
M204 S750
G1 X107.739 Y131.798 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.767 Y131.237 Z2.4 F9000
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S500
G1 X102.533 Y136.471 E.22051
G1 X102.191 Y136.28
G1 X107.061 Y131.409 E.20517
G1 X106.602 Y131.335
G1 X101.859 Y136.079 E.1998
G1 X101.538 Y135.867
G1 X106.155 Y131.249 E.19449
G1 X105.727 Y131.143
G1 X101.23 Y135.64 E.18944
G1 X100.931 Y135.406
G1 X105.383 Y130.955 E.18752
G1 X105.076 Y130.729
G1 X100.643 Y135.162 E.18674
G1 X100.367 Y134.904
G1 X104.719 Y130.552 E.18332
G1 X104.549 Y130.188
G1 X100.1 Y134.638 E.18743
G1 X99.843 Y134.361
G1 X104.151 Y130.054 E.18145
G1 X104.133 Y129.538
G1 X99.599 Y134.072 E.19099
G1 X99.363 Y133.775
G1 X103.796 Y129.342 E.18672
G1 X103.835 Y128.77
G1 X99.139 Y133.466 E.19784
G1 X98.927 Y133.144
G1 X103.566 Y128.505 E.19543
G1 X103.683 Y127.856
G1 X98.724 Y132.814 E.20886
G1 X98.534 Y132.471
G1 X103.857 Y127.148 E.22426
G1 X103.734 Y126.737
G1 X101.797 Y128.674 E.08159
G1 X101.924 Y128.014
G1 X107.021 Y122.917 E.2147
G1 X106.549 Y122.856
G1 X101.864 Y127.541 E.19734
G1 X101.724 Y127.148
G1 X106.154 Y122.718 E.18661
G1 X105.83 Y122.509
G1 X101.516 Y126.823 E.18173
G1 X101.255 Y126.55
G1 X105.557 Y122.248 E.18121
G1 X105.335 Y121.937
G1 X100.944 Y126.328 E.18495
G1 X100.568 Y126.17
G1 X105.178 Y121.561 E.19415
G1 X105.094 Y121.112
G1 X100.118 Y126.087 E.20959
G1 X99.528 Y126.144
G1 X105.151 Y120.522 E.23685
; WIPE_START
M204 S750
G1 X103.737 Y121.936 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X100.967 Y129.048 Z2.4 F9000
G1 X100.675 Y129.797 Z2.4
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S500
G1 X98.357 Y132.114 E.09763
G1 X98.191 Y131.747
G1 X100.024 Y129.915 E.07719
G1 X99.546 Y129.859
G1 X98.037 Y131.368 E.06355
G1 X97.901 Y130.971
G1 X99.157 Y129.715 E.05291
G1 X98.83 Y129.509
G1 X97.777 Y130.561 E.04435
G1 X97.669 Y130.137
G1 X98.555 Y129.25 E.03733
G1 X98.336 Y128.936
G1 X97.576 Y129.696 E.032
G1 X97.506 Y129.233
G1 X98.178 Y128.561 E.02829
G1 X98.094 Y128.112
G1 X97.457 Y128.748 E.02681
G1 X97.432 Y128.24
G1 X98.152 Y127.52 E.03032
G1 X97.433 Y127.706
G1 X106.714 Y118.425 E.39095
G1 X106.146 Y118.46
G1 X97.467 Y127.138 E.3656
G1 X97.542 Y126.531
G1 X105.538 Y118.535 E.33684
G1 X104.878 Y118.661
M73 P81 R3
G1 X97.667 Y125.873 E.30377
G1 X97.86 Y125.146
G1 X104.15 Y118.856 E.26496
G1 X103.309 Y119.164
G1 X98.171 Y124.302 E.21642
G1 X98.688 Y123.252
G1 X102.258 Y119.682 E.15038
; WIPE_START
M204 S750
G1 X100.843 Y121.096 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X106.938 Y125.691 Z2.4 F9000
G1 X115.605 Y132.225 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.110658
G1 F9000
G1 X115.496 Y132.374 E.00099
; LINE_WIDTH: 0.155613
G1 X115.386 Y132.524 E.00165
; LINE_WIDTH: 0.200569
G1 X115.277 Y132.673 E.0023
G1 X114.809 Y133.556
; LINE_WIDTH: 0.094634
G1 X114.751 Y133.626 E.00038
; LINE_WIDTH: 0.11929
G1 X114.562 Y133.841 E.00173
; LINE_WIDTH: 0.1557
G1 X114.372 Y134.056 E.00255
; LINE_WIDTH: 0.203041
G3 X113.169 Y135.269 I-15.796 J-14.474 E.02162
; LINE_WIDTH: 0.170691
G1 X112.955 Y135.46 E.00289
; LINE_WIDTH: 0.138609
G1 X112.742 Y135.65 E.00216
; LINE_WIDTH: 0.10536
G1 X112.571 Y135.794 E.0011
; WIPE_START
G1 X112.742 Y135.65 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.157 Y134.796 Z2.4 F9000
G1 X105.023 Y134.781 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.100633
G1 F9000
G1 X105.106 Y134.993 E.00104
; WIPE_START
G1 X105.023 Y134.781 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.583 Y133.719 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0915321
G1 F9000
G1 X105.475 Y133.833 E.0006
; LINE_WIDTH: 0.110696
G1 X105.382 Y133.947 E.00079
; LINE_WIDTH: 0.142558
G1 X105.285 Y134.069 E.00123
; LINE_WIDTH: 0.17299
G1 X105.218 Y134.165 E.0012
; LINE_WIDTH: 0.199745
G1 X105.152 Y134.262 E.00145
; WIPE_START
G1 X105.218 Y134.165 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X106.258 Y133.146 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.181643
G1 F9000
G1 X106.129 Y133.239 E.00175
; LINE_WIDTH: 0.161694
G1 X106.013 Y133.329 E.00138
; LINE_WIDTH: 0.124684
G1 X105.894 Y133.422 E.00098
; LINE_WIDTH: 0.0972015
G1 X105.737 Y133.564 E.00091
; WIPE_START
G1 X105.894 Y133.422 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.993 Y135.076 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0894748
G1 F9000
G1 X108.918 Y134.904 E.00069
G1 X108.936 Y135.546
; LINE_WIDTH: 0.103662
G3 X108.719 Y135.856 I-3.968 J-2.543 E.00182
G1 X108.911 Y135.691
; LINE_WIDTH: 0.0958324
G1 X108.851 Y135.46 E.001
; WIPE_START
G1 X108.911 Y135.691 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X107.868 Y136.709 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.122389
G1 F9000
G3 X107.605 Y136.889 I-2.408 J-3.217 E.002
G1 X107.218 Y137.575
; LINE_WIDTH: 0.101751
G1 X107.048 Y137.555 E.00079
; WIPE_START
G1 X107.218 Y137.575 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.78 Y132.219 Z2.4 F9000
G1 X97.451 Y127.954 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.103216
G1 F9000
G1 X97.432 Y127.778 E.00085
; WIPE_START
G1 X97.451 Y127.954 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X98.303 Y127.13 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.112262
G1 F9000
G1 X98.203 Y127.269 E.00094
; LINE_WIDTH: 0.137842
G1 X98.12 Y127.395 E.00113
; WIPE_START
G1 X98.203 Y127.269 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X99.456 Y126.072 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.106359
G1 F9000
G2 X99.14 Y126.293 I2.576 J4.013 E.00193
; WIPE_START
G1 X99.456 Y126.072 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.864 Y128.741 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.178255
G1 F9000
G1 X101.767 Y128.877 E.00179
; LINE_WIDTH: 0.158344
G1 X101.677 Y128.993 E.00134
; LINE_WIDTH: 0.121389
G1 X101.584 Y129.112 E.00094
; LINE_WIDTH: 0.0955663
G1 X101.465 Y129.243 E.00074
G1 X101.237 Y129.471
; LINE_WIDTH: 0.0900968
G1 X101.171 Y129.533 E.00034
; LINE_WIDTH: 0.108928
G1 X101.052 Y129.628 E.00079
; LINE_WIDTH: 0.142955
G1 X100.927 Y129.728 E.00127
; LINE_WIDTH: 0.174056
G1 X100.832 Y129.794 E.00119
; LINE_WIDTH: 0.200106
G1 X100.737 Y129.859 E.00143
G1 X100.221 Y129.984
; LINE_WIDTH: 0.102575
G1 X100.01 Y129.901 E.00107
; WIPE_START
G1 X100.221 Y129.984 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X101.16 Y122.409 Z2.4 F9000
G1 X101.432 Y120.211 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.105052
G1 F9000
G1 X101.244 Y120.374 E.00122
; LINE_WIDTH: 0.138806
G1 X101.056 Y120.538 E.00189
; LINE_WIDTH: 0.179181
G1 X100.636 Y120.924 E.00614
; LINE_WIDTH: 0.2069
G2 X99.833 Y121.733 I13.126 J13.831 E.01476
; LINE_WIDTH: 0.180225
G1 X99.641 Y121.944 E.0031
; LINE_WIDTH: 0.152437
G1 X99.449 Y122.156 E.00247
; LINE_WIDTH: 0.125936
G1 X99.338 Y122.287 E.00113
; LINE_WIDTH: 0.100763
G1 X99.226 Y122.417 E.00078
; WIPE_START
G1 X99.338 Y122.287 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X102.769 Y119.41 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.105177
G1 F9000
G1 X102.677 Y119.477 E.00056
; LINE_WIDTH: 0.139182
G1 X102.584 Y119.543 E.00086
; LINE_WIDTH: 0.173186
G1 X102.492 Y119.61 E.00117
; LINE_WIDTH: 0.206858
G1 X102.319 Y119.743 E.00283
; WIPE_START
G1 X102.492 Y119.61 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X106.362 Y124.559 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0815106
G1 F9000
G1 X106.354 Y124.532 E.00009
; LINE_WIDTH: 0.111701
G1 X106.315 Y124.525 E.00021
; LINE_WIDTH: 0.14753
G1 X106.297 Y124.525 E.00015
; LINE_WIDTH: 0.177165
G1 X105.927 Y124.922 E.00575
G1 X105.615 Y124.822
; LINE_WIDTH: 0.139696
G1 X105.503 Y124.776 E.00093
G1 X105.47 Y124.805 E.00034
; LINE_WIDTH: 0.164321
G1 X105.353 Y124.966 E.00191
; LINE_WIDTH: 0.212029
G1 X105.237 Y125.128 E.00266
; LINE_WIDTH: 0.259737
G1 X105.12 Y125.289 E.00341
; WIPE_START
G1 X105.237 Y125.128 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.182 Y126.261 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.308161
G1 F9000
G1 X103.921 Y126.462 E.0069
; LINE_WIDTH: 0.258462
G1 X103.66 Y126.663 E.00561
; WIPE_START
G1 X103.921 Y126.462 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.059 Y129.719 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.107638
G1 F9000
G1 X109.943 Y129.797 E.00071
; LINE_WIDTH: 0.146565
G1 X109.827 Y129.875 E.00114
; LINE_WIDTH: 0.185492
G1 X109.711 Y129.953 E.00157
; LINE_WIDTH: 0.224419
G1 X109.596 Y130.031 E.002
; WIPE_START
G1 X109.711 Y129.953 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.141 Y129.1 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0964658
G1 F9000
G1 X110.002 Y129.221 E.00078
; WIPE_START
G1 X110.141 Y129.1 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.268 Y126.145 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.199759
G1 F9000
G1 X113.172 Y126.211 E.00145
; LINE_WIDTH: 0.171977
G1 X113.068 Y126.283 E.00129
; LINE_WIDTH: 0.141702
G1 X112.955 Y126.375 E.00114
; LINE_WIDTH: 0.101325
G1 X112.735 Y126.567 E.00135
G1 X112.57 Y126.731
; LINE_WIDTH: 0.097406
G1 X112.425 Y126.891 E.00093
; LINE_WIDTH: 0.125265
G1 X112.335 Y127.006 E.00095
; LINE_WIDTH: 0.172069
G2 X112.152 Y127.251 I3.132 J2.528 E.00312
; WIPE_START
G1 X112.335 Y127.006 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X114.698 Y129.905 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0958414
G1 F9000
G1 X114.467 Y129.844 E.001
G1 X114.863 Y129.713
; LINE_WIDTH: 0.103671
G3 X114.553 Y129.93 I-2.982 J-3.923 E.00182
; WIPE_START
G1 X114.863 Y129.713 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.258 Y130.502 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0958473
G1 F9000
G1 X116.093 Y130.795 E.00141
; WIPE_START
G1 X116.258 Y130.502 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.933 Y128.542 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.124483
G1 F9000
G3 X115.715 Y128.861 I-4.239 J-2.667 E.00249
; WIPE_START
G1 X115.933 Y128.542 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.534 Y123.148 Z2.4 F9000
G1 X106.458 Y119.076 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.13784
G1 F9000
G1 X106.276 Y119.196 E.00163
; LINE_WIDTH: 0.112262
G1 X106.137 Y119.296 E.00094
; WIPE_START
G1 X106.276 Y119.196 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.103 Y120.303 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0910057
G1 F9000
G1 X105.164 Y120.535 E.00091
G1 X105.3 Y120.134
; LINE_WIDTH: 0.103289
G2 X105.078 Y120.449 I4.208 J3.194 E.00184
; WIPE_START
G1 X105.3 Y120.134 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.25 Y122.458 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0958483
G1 F9000
G1 X108.114 Y122.581 E.00077
; LINE_WIDTH: 0.123427
G1 X107.993 Y122.674 E.00097
; LINE_WIDTH: 0.173024
G3 X107.747 Y122.857 I-2.633 J-3.287 E.00315
; WIPE_START
G1 X107.993 Y122.674 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.866 Y121.73 Z2.4 F9000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.198908
G1 F9000
G1 X108.797 Y121.83 E.0015
; LINE_WIDTH: 0.169457
G1 X108.722 Y121.938 E.0013
; LINE_WIDTH: 0.138398
G1 X108.63 Y122.051 E.0011
; LINE_WIDTH: 0.100989
G1 X108.477 Y122.23 E.00108
; CHANGE_LAYER
; Z_HEIGHT: 2.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F9000
G1 X108.63 Y122.051 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 118
M625
; layer num/total_layer_count: 11/23
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
M106 S226.95
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G17
G3 Z2.4 I-.316 J1.175 P1  F9000
G1 X125.378 Y126.557 Z2.4
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1356
G1 X125.359 Y126.079 E.01424
G1 X125.819 Y125.95 E.01424
G1 X125.92 Y125.482 E.01424
G1 X126.397 Y125.471 E.01424
G1 X126.611 Y125.044 E.01424
G1 X127.077 Y125.151 E.01424
G1 X127.39 Y124.79 E.01424
G1 X127.824 Y125.004 E.0144
G1 X128.207 Y124.739 E.01389
G1 X128.563 Y125.058 E.01424
G1 X129.012 Y124.893 E.01424
G1 X129.277 Y125.29 E.01424
G1 X129.753 Y125.241 E.01424
G1 X129.911 Y125.692 E.01424
G1 X130.384 Y125.763 E.01424
G1 X130.425 Y126.24 E.01424
G1 X130.865 Y126.426 E.01424
G1 X130.787 Y126.897 E.01424
G1 X131.167 Y127.187 E.01424
G1 X130.974 Y127.625 E.01424
G1 X131.27 Y128 E.01424
G1 X130.974 Y128.375 E.01424
G1 X131.167 Y128.813 E.01424
G1 X130.787 Y129.103 E.01424
G1 X130.865 Y129.574 E.01424
G1 X130.425 Y129.76 E.01424
G1 X130.384 Y130.237 E.01424
G1 X129.911 Y130.308 E.01424
G1 X129.753 Y130.759 E.01424
G1 X129.277 Y130.71 E.01424
G1 X129.012 Y131.107 E.01424
G1 X128.563 Y130.942 E.01424
G1 X128.207 Y131.261 E.01424
G1 X127.814 Y130.989 E.01424
G1 X127.39 Y131.21 E.01424
G1 X127.077 Y130.849 E.01424
G1 X126.611 Y130.956 E.01424
G1 X126.397 Y130.529 E.01424
G1 X125.92 Y130.518 E.01424
G1 X125.819 Y130.05 E.01424
M73 P82 R3
G1 X125.359 Y129.921 E.01424
G1 X125.378 Y129.443 E.01424
G1 X124.964 Y129.203 E.01424
G1 X125.101 Y128.745 E.01424
G1 X124.761 Y128.41 E.01424
G1 X125.007 Y128 E.01424
G1 X124.761 Y127.59 E.01424
G1 X125.101 Y127.255 E.01424
G1 X124.964 Y126.797 E.01424
G1 X125.326 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18164
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X126.935 Y124.716 Z2.6 F9000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1356
G1 X126.459 Y124.606 E.01571
G1 X126.447 Y124.425 E.00583
G3 X127.159 Y124.194 I1.64 J3.836 E.02409
G1 X127.256 Y124.347 E.00583
G1 X126.975 Y124.671 E.01378
G1 X127.352 Y124.329 F9000
G1 F1356
G1 X127.378 Y124.156 E.00561
G3 X128.13 Y124.108 I.638 J4.029 E.02428
G1 X128.183 Y124.279 E.00577
G1 X127.785 Y124.554 E.01556
G1 X127.405 Y124.357 E.01378
G1 X128.288 Y124.285 F9000
G1 F1356
G1 X128.358 Y124.123 E.00567
G1 X128.525 Y124.138 E.00541
G3 X129.096 Y124.263 I-.409 J3.233 E.01882
G1 X129.104 Y124.441 E.00572
G1 X128.649 Y124.608 E.01558
G1 X128.332 Y124.325 E.01368
G1 X129.203 Y124.473 F9000
G1 F1356
G1 X129.314 Y124.334 E.00572
G1 X129.534 Y124.416 E.00757
G3 X129.993 Y124.654 I-1.093 J2.672 E.01666
G1 X129.955 Y124.826 E.00567
G1 X129.472 Y124.876 E.01561
G1 X129.237 Y124.523 E.01365
; WIPE_START
G1 F5895.652
G1 X129.314 Y124.334 E-.07771
G1 X129.534 Y124.416 E-.0894
G1 X129.993 Y124.654 E-.1966
G1 X129.955 Y124.826 E-.06699
G1 X129.472 Y124.876 E-.18447
G1 X129.261 Y124.559 E-.14483
; WIPE_END
G1 E-.04 F1800
G1 X130.203 Y125.34 Z2.6 F9000
G1 Z2.2
G1 E.8 F1800
G1 F1356
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.532 J2.019 E.01456
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
G1 X130.796 Y125.971 F9000
G1 F1356
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01378
G1 X131.213 Y126.729 F9000
G1 F1356
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00562
G1 X131.513 Y126.308 E.00327
G3 X131.745 Y126.92 I-3.418 J1.646 E.02106
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
G1 X131.428 Y127.567 F9000
G1 F1356
G1 X131.624 Y127.123 E.01561
G1 X131.799 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.845 J.869 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
G1 X131.428 Y128.433 F9000
G1 F1356
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.8 Y128.86 I-3.943 J-.123 E.0242
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
G1 X131.212 Y129.271 F9000
G1 F1356
G1 X131.598 Y128.977 E.01561
G1 X131.745 Y129.08 E.00578
G3 X131.465 Y129.781 I-4.024 J-1.201 E.02431
G1 X131.293 Y129.753 E.00562
G1 X131.222 Y129.33 E.01378
G1 X130.796 Y130.029 F9000
G1 F1356
G1 X131.246 Y129.839 E.01571
G1 X131.362 Y129.978 E.00583
G3 X130.922 Y130.584 I-3.582 J-2.14 E.02409
G1 X130.753 Y130.516 E.00583
G1 X130.79 Y130.089 E.01378
; WIPE_START
G1 F5895.652
G1 X131.246 Y129.839 E-.19741
G1 X131.362 Y129.978 E-.06891
G1 X131.155 Y130.291 E-.14226
G1 X130.922 Y130.584 E-.14232
G1 X130.753 Y130.516 E-.06891
G1 X130.785 Y130.149 E-.1402
; WIPE_END
G1 E-.04 F1800
G1 X130.12 Y130.897 Z2.6 F9000
G1 Z2.2
G1 E.8 F1800
G1 F1356
G1 X130.203 Y130.66 E.00805
G1 X130.686 Y130.588 E.01571
G1 X130.766 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.958 J-2.963 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.1 Y130.953 E.00563
G1 X129.741 Y131.152 F9000
G1 F1356
G1 X129.955 Y131.174 E.00694
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.085 J-3.54 E.0242
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00674
G1 X128.81 Y131.451 F9000
G1 F1356
G1 X129.104 Y131.559 E.01005
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.101 J-3.786 E.0242
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.0036
G1 X127.785 Y131.446 F9000
G1 F1356
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.186 E.02431
G1 X127.352 Y131.671 E.00561
G1 X127.732 Y131.474 E.01378
G1 X126.935 Y131.284 F9000
G1 F1356
G1 X127.256 Y131.653 E.01571
G1 X127.159 Y131.806 E.00583
G3 X126.449 Y131.574 I.887 J-3.915 E.02405
G1 X126.461 Y131.394 E.00582
G1 X126.877 Y131.297 E.01372
G1 X126.152 Y130.915 F9000
G1 F1356
G1 X126.37 Y131.352 E.01571
G1 X126.248 Y131.477 E.00562
G3 X125.609 Y131.074 I1.906 J-3.732 E.02431
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
G1 X125.485 Y130.364 F9000
G1 F1356
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.599 J-2.961 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
G1 X124.977 Y129.663 F9000
G1 F1356
G1 X124.958 Y130.146 E.01554
G1 X124.786 Y130.194 E.00573
G3 X124.425 Y129.536 I3.211 J-2.191 E.02416
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
G1 X124.658 Y128.859 F9000
G1 F1356
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G3 X124.154 Y128.594 I3.957 J-1.393 E.02431
G1 X124.31 Y128.516 E.00562
G1 X124.615 Y128.817 E.01378
G1 X124.549 Y128 F9000
G1 F1356
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
G1 X124.658 Y127.141 F9000
G1 F1356
G1 X124.31 Y127.484 E.01571
G1 X124.154 Y127.406 E.00561
G3 X124.339 Y126.674 I4.131 J.658 E.02431
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
G1 X124.977 Y126.337 F9000
G1 F1356
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.621 J1.558 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
G1 X125.485 Y125.636 F9000
G1 F1356
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.116 J2.416 E.0242
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
G1 X126.152 Y125.085 F9000
G1 F1356
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.523 I2.55 J3.337 E.0243
G1 X126.37 Y124.648 E.00562
G1 X126.179 Y125.031 E.01378
; WIPE_START
G1 F5895.652
G1 X125.667 Y125.096 E-.19618
G1 X125.609 Y124.926 E-.06827
G1 X125.855 Y124.747 E-.11548
G1 X126.248 Y124.523 E-.17176
G1 X126.37 Y124.648 E-.06637
G1 X126.204 Y124.982 E-.14194
; WIPE_END
G1 E-.04 F1800
G1 X123.725 Y128.385 Z2.6 F9000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1356
G3 X127.809 Y123.715 I4.27 J-.387 E.20661
G1 X128.21 Y123.716 E.01194
G3 X123.731 Y128.445 I-.215 J4.282 E.58207
; OBJECT_ID: 118
; WIPE_START
G1 F6364.704
G1 X123.712 Y128 E-.16908
G1 X123.73 Y127.615 E-.14626
G1 X123.781 Y127.234 E-.14628
G1 X123.867 Y126.859 E-.14627
G1 X123.986 Y126.493 E-.1463
G1 X123.992 Y126.479 E-.00582
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X116.36 Y126.509 Z2.6 F9000
G1 X104.382 Y126.557 Z2.6
G1 Z2.2
G1 E.8 F1800
G1 F1356
G1 X104.363 Y126.079 E.01424
G1 X104.823 Y125.95 E.01424
G1 X104.924 Y125.482 E.01424
G1 X105.402 Y125.471 E.01424
G1 X105.616 Y125.044 E.01424
G1 X106.081 Y125.151 E.01424
G1 X106.394 Y124.79 E.01424
G1 X106.828 Y125.004 E.0144
G1 X107.212 Y124.739 E.01389
G1 X107.568 Y125.058 E.01424
G1 X108.016 Y124.893 E.01424
G1 X108.282 Y125.29 E.01424
G1 X108.757 Y125.241 E.01424
G1 X108.916 Y125.692 E.01424
G1 X109.389 Y125.763 E.01424
G1 X109.43 Y126.24 E.01424
G1 X109.87 Y126.426 E.01424
G1 X109.792 Y126.897 E.01424
G1 X110.171 Y127.187 E.01424
G1 X109.978 Y127.625 E.01424
G1 X110.274 Y128 E.01424
G1 X109.978 Y128.375 E.01424
G1 X110.171 Y128.813 E.01424
G1 X109.792 Y129.103 E.01424
G1 X109.87 Y129.574 E.01424
G1 X109.43 Y129.76 E.01424
G1 X109.389 Y130.237 E.01424
G1 X108.916 Y130.308 E.01424
G1 X108.757 Y130.759 E.01424
G1 X108.282 Y130.71 E.01424
G1 X108.016 Y131.107 E.01424
G1 X107.568 Y130.942 E.01424
G1 X107.212 Y131.261 E.01424
G1 X106.819 Y130.989 E.01424
G1 X106.394 Y131.21 E.01424
G1 X106.081 Y130.849 E.01424
G1 X105.616 Y130.956 E.01424
G1 X105.402 Y130.529 E.01424
G1 X104.924 Y130.518 E.01424
G1 X104.823 Y130.05 E.01424
G1 X104.363 Y129.921 E.01424
G1 X104.382 Y129.443 E.01424
G1 X103.969 Y129.203 E.01424
G1 X104.106 Y128.745 E.01424
G1 X103.765 Y128.41 E.01424
G1 X104.012 Y128 E.01424
G1 X103.765 Y127.59 E.01424
G1 X104.106 Y127.255 E.01424
G1 X103.969 Y126.797 E.01424
G1 X104.33 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18164
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X105.94 Y124.716 Z2.6 F9000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1356
G1 X105.464 Y124.606 E.01571
G1 X105.452 Y124.425 E.00583
G3 X106.163 Y124.194 I1.64 J3.836 E.02409
G1 X106.26 Y124.347 E.00583
G1 X105.979 Y124.671 E.01378
G1 X106.356 Y124.329 F9000
G1 F1356
G1 X106.383 Y124.156 E.00561
G3 X107.135 Y124.108 I.638 J4.029 E.02428
G1 X107.188 Y124.279 E.00577
G1 X106.79 Y124.554 E.01556
G1 X106.41 Y124.357 E.01378
G1 X107.292 Y124.285 F9000
G1 F1356
G1 X107.362 Y124.123 E.00567
G1 X107.53 Y124.138 E.00541
G3 X108.101 Y124.263 I-.409 J3.233 E.01882
G1 X108.108 Y124.441 E.00572
G1 X107.654 Y124.608 E.01558
G1 X107.337 Y124.325 E.01368
G1 X108.208 Y124.473 F9000
G1 F1356
G1 X108.318 Y124.334 E.00572
G1 X108.539 Y124.416 E.00757
G3 X108.998 Y124.654 I-1.093 J2.672 E.01666
G1 X108.96 Y124.826 E.00567
G1 X108.477 Y124.876 E.01561
G1 X108.241 Y124.523 E.01365
; WIPE_START
G1 F5895.652
G1 X108.318 Y124.334 E-.07771
G1 X108.539 Y124.416 E-.0894
G1 X108.998 Y124.654 E-.1966
G1 X108.96 Y124.826 E-.06699
G1 X108.477 Y124.876 E-.18447
G1 X108.265 Y124.559 E-.14483
; WIPE_END
G1 E-.04 F1800
G1 X109.208 Y125.34 Z2.6 F9000
G1 Z2.2
G1 E.8 F1800
G1 F1356
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.532 J2.019 E.01456
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
G1 X109.8 Y125.971 F9000
G1 F1356
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01378
G1 X110.217 Y126.729 F9000
G1 F1356
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00562
G1 X110.518 Y126.308 E.00327
G3 X110.749 Y126.92 I-3.418 J1.646 E.02106
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
G1 X110.432 Y127.567 F9000
G1 F1356
G1 X110.628 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.845 J.869 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
G1 X110.432 Y128.433 F9000
G1 F1356
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.943 J-.123 E.0242
G1 X110.629 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
G1 X110.217 Y129.271 F9000
G1 F1356
G1 X110.603 Y128.977 E.01561
G1 X110.749 Y129.08 E.00578
G3 X110.469 Y129.781 I-4.024 J-1.201 E.02431
G1 X110.297 Y129.753 E.00562
G1 X110.227 Y129.33 E.01378
G1 X109.8 Y130.029 F9000
G1 F1356
G1 X110.25 Y129.839 E.01571
G1 X110.366 Y129.978 E.00583
G3 X109.926 Y130.584 I-3.582 J-2.14 E.02409
G1 X109.758 Y130.516 E.00583
G1 X109.795 Y130.089 E.01378
; WIPE_START
G1 F5895.652
G1 X110.25 Y129.839 E-.19741
G1 X110.366 Y129.978 E-.06891
G1 X110.16 Y130.291 E-.14226
G1 X109.926 Y130.584 E-.14232
G1 X109.758 Y130.516 E-.06891
M73 P83 R3
G1 X109.79 Y130.149 E-.1402
; WIPE_END
G1 E-.04 F1800
G1 X109.125 Y130.897 Z2.6 F9000
G1 Z2.2
G1 E.8 F1800
G1 F1356
G1 X109.208 Y130.66 E.00805
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.958 J-2.963 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.105 Y130.953 E.00563
G1 X108.745 Y131.152 F9000
G1 F1356
G1 X108.96 Y131.174 E.00694
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.085 J-3.54 E.0242
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.685 Y131.145 E.00674
G1 X107.815 Y131.451 F9000
G1 F1356
G1 X108.108 Y131.559 E.01005
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.101 J-3.786 E.0242
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.759 Y131.43 E.0036
G1 X106.79 Y131.446 F9000
G1 F1356
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.186 E.02431
G1 X106.356 Y131.671 E.00561
G1 X106.737 Y131.474 E.01378
G1 X105.94 Y131.284 F9000
G1 F1356
G1 X106.26 Y131.653 E.01571
G1 X106.163 Y131.806 E.00583
G3 X105.454 Y131.574 I.887 J-3.915 E.02405
G1 X105.466 Y131.394 E.00582
G1 X105.881 Y131.297 E.01372
G1 X105.157 Y130.915 F9000
G1 F1356
G1 X105.375 Y131.352 E.01571
G1 X105.252 Y131.477 E.00562
G3 X104.614 Y131.074 I1.906 J-3.732 E.02431
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
G1 X104.49 Y130.364 F9000
G1 F1356
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.599 J-2.961 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
G1 X103.981 Y129.663 F9000
G1 F1356
G1 X103.962 Y130.146 E.01554
G1 X103.79 Y130.194 E.00573
G3 X103.429 Y129.536 I3.211 J-2.191 E.02416
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
G1 X103.662 Y128.859 F9000
G1 F1356
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G3 X103.158 Y128.594 I3.957 J-1.393 E.02431
G1 X103.314 Y128.516 E.00562
G1 X103.62 Y128.817 E.01378
G1 X103.554 Y128 F9000
G1 F1356
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
G1 X103.662 Y127.141 F9000
G1 F1356
G1 X103.314 Y127.484 E.01571
G1 X103.158 Y127.406 E.00561
G3 X103.344 Y126.674 I4.131 J.658 E.02431
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
G1 X103.981 Y126.337 F9000
G1 F1356
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.621 J1.558 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
G1 X104.49 Y125.636 F9000
G1 F1356
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.116 J2.416 E.0242
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
G1 X105.157 Y125.085 F9000
G1 F1356
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.523 I2.55 J3.337 E.0243
G1 X105.375 Y124.648 E.00562
G1 X105.183 Y125.031 E.01378
; WIPE_START
G1 F5895.652
G1 X104.671 Y125.096 E-.19618
G1 X104.614 Y124.926 E-.06827
G1 X104.86 Y124.747 E-.11548
G1 X105.252 Y124.523 E-.17176
G1 X105.375 Y124.648 E-.06637
G1 X105.208 Y124.982 E-.14194
; WIPE_END
G1 E-.04 F1800
G1 X102.73 Y128.385 Z2.6 F9000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1356
G3 X106.814 Y123.715 I4.27 J-.387 E.20661
G1 X107.215 Y123.716 E.01194
G3 X102.735 Y128.445 I-.215 J4.282 E.58207
; WIPE_START
G1 F6364.704
G1 X102.717 Y128 E-.16908
G1 X102.734 Y127.615 E-.14626
G1 X102.786 Y127.234 E-.14627
G1 X102.872 Y126.859 E-.14627
G1 X102.99 Y126.493 E-.1463
G1 X102.997 Y126.479 E-.00582
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2.6 I1.217 J0 P1  F9000
; stop printing object, unique label id: 118
M625
; object ids of layer 11 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.6
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z2.6 F4000
            G39.3 S1
            G0 Z2.6 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END


; object ids of this layer11 end: 82,118
M625
; CHANGE_LAYER
; Z_HEIGHT: 2.4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 12/23
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F9000
G1 Z2.4
G1 E.8 F1800
G1 F1463
G1 X125.359 Y126.079 E.01424
G1 X125.819 Y125.95 E.01424
G1 X125.92 Y125.482 E.01424
G1 X126.397 Y125.471 E.01424
G1 X126.611 Y125.044 E.01424
G1 X127.077 Y125.151 E.01424
G1 X127.39 Y124.79 E.01424
G1 X127.814 Y125.011 E.01424
G1 X127.844 Y124.99 E.00109
G1 X128.207 Y124.739 E.01315
G1 X128.563 Y125.058 E.01424
G1 X129.012 Y124.893 E.01424
G1 X129.277 Y125.29 E.01424
G1 X129.753 Y125.241 E.01424
G1 X129.911 Y125.692 E.01424
G1 X130.384 Y125.763 E.01424
G1 X130.425 Y126.24 E.01424
G1 X130.865 Y126.426 E.01424
G1 X130.787 Y126.897 E.01424
G1 X131.167 Y127.187 E.01424
G1 X130.974 Y127.625 E.01424
G1 X131.27 Y128 E.01424
G1 X130.974 Y128.375 E.01424
G1 X131.167 Y128.813 E.01424
G1 X130.787 Y129.103 E.01424
G1 X130.865 Y129.574 E.01424
G1 X130.425 Y129.76 E.01424
G1 X130.384 Y130.237 E.01424
G1 X129.911 Y130.308 E.01424
G1 X129.753 Y130.759 E.01424
G1 X129.277 Y130.71 E.01424
G1 X129.012 Y131.107 E.01424
G1 X128.563 Y130.942 E.01424
G1 X128.207 Y131.261 E.01424
G1 X127.814 Y130.989 E.01424
G1 X127.39 Y131.21 E.01424
G1 X127.077 Y130.849 E.01424
G1 X126.611 Y130.956 E.01424
G1 X126.397 Y130.529 E.01424
G1 X125.92 Y130.518 E.01424
G1 X125.819 Y130.05 E.01424
G1 X125.359 Y129.921 E.01424
G1 X125.378 Y129.443 E.01424
G1 X124.964 Y129.203 E.01424
G1 X125.101 Y128.745 E.01424
G1 X124.761 Y128.41 E.01424
G1 X125.007 Y128 E.01424
G1 X124.761 Y127.59 E.01424
G1 X125.101 Y127.255 E.01424
G1 X124.964 Y126.797 E.01424
G1 X125.326 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X125.359 Y126.079 E-.19337
G1 X125.819 Y125.95 E-.18163
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X127.785 Y124.554 Z2.8 F9000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1463
G1 X127.352 Y124.329 E.01571
G1 X127.378 Y124.156 E.00562
G3 X128.131 Y124.107 I.651 J4.142 E.02431
G1 X128.185 Y124.278 E.00578
G1 X127.835 Y124.52 E.01368
G1 X128.288 Y124.285 F9000
G1 F1463
G1 X128.358 Y124.123 E.00567
G1 X128.525 Y124.138 E.00541
G3 X129.096 Y124.263 I-.409 J3.235 E.01882
G1 X129.104 Y124.441 E.00572
G1 X128.649 Y124.608 E.01558
G1 X128.332 Y124.325 E.01368
G1 X129.203 Y124.473 F9000
G1 F1463
G1 X129.314 Y124.334 E.00572
G1 X129.534 Y124.416 E.00756
G3 X129.993 Y124.654 I-1.095 J2.676 E.01666
G1 X129.955 Y124.826 E.00567
G1 X129.472 Y124.876 E.01561
G1 X129.237 Y124.523 E.01365
; WIPE_START
G1 F5895.652
G1 X129.314 Y124.334 E-.07771
G1 X129.534 Y124.416 E-.08934
G1 X129.993 Y124.654 E-.19667
G1 X129.955 Y124.826 E-.06699
G1 X129.472 Y124.876 E-.18448
G1 X129.261 Y124.559 E-.14481
; WIPE_END
G1 E-.04 F1800
G1 X130.203 Y125.34 Z2.8 F9000
G1 Z2.4
G1 E.8 F1800
G1 F1463
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.532 J2.019 E.01455
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
G1 X130.796 Y125.971 F9000
G1 F1463
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01378
G1 X131.213 Y126.729 F9000
G1 F1463
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00562
G1 X131.514 Y126.309 E.0033
G3 X131.745 Y126.92 I-3.278 J1.591 E.02103
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
G1 X131.428 Y127.567 F9000
G1 F1463
G1 X131.624 Y127.123 E.01561
G1 X131.799 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.847 J.869 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
G1 X131.428 Y128.433 F9000
G1 F1463
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.8 Y128.86 I-3.942 J-.123 E.0242
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
G1 X131.213 Y129.271 F9000
G1 F1463
G1 X131.598 Y128.977 E.01561
G1 X131.745 Y129.08 E.00578
G3 X131.465 Y129.781 I-4.018 J-1.199 E.02431
G1 X131.293 Y129.753 E.00562
G1 X131.222 Y129.33 E.01378
G1 X130.796 Y130.029 F9000
G1 F1463
G1 X131.246 Y129.839 E.01571
G1 X131.362 Y129.978 E.00583
G3 X130.922 Y130.584 I-3.585 J-2.142 E.02409
G1 X130.753 Y130.516 E.00583
G1 X130.79 Y130.089 E.01378
; WIPE_START
G1 F5895.652
G1 X131.246 Y129.839 E-.1974
G1 X131.362 Y129.978 E-.06891
G1 X131.155 Y130.291 E-.14233
G1 X130.922 Y130.584 E-.14224
G1 X130.753 Y130.516 E-.06891
G1 X130.785 Y130.149 E-.14021
; WIPE_END
G1 E-.04 F1800
G1 X130.131 Y130.864 Z2.8 F9000
G1 Z2.4
G1 E.8 F1800
G1 F1463
G1 X130.203 Y130.66 E.00695
G1 X130.686 Y130.588 E.01571
G1 X130.767 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.965 J-2.973 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.112 Y130.921 E.00673
G1 X129.741 Y131.152 F9000
G1 F1463
G1 X129.955 Y131.174 E.00694
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.013 J-3.386 E.0242
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00675
G1 X128.81 Y131.451 F9000
G1 F1463
G1 X129.104 Y131.559 E.01005
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.1 J-3.781 E.0242
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.00359
G1 X127.785 Y131.446 F9000
G1 F1463
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.194 E.02431
G1 X127.352 Y131.671 E.00562
G1 X127.732 Y131.474 E.01378
G1 X126.935 Y131.284 F9000
G1 F1463
G1 X127.256 Y131.653 E.01572
G1 X127.159 Y131.806 E.00583
G3 X126.447 Y131.575 I.928 J-4.067 E.02409
G1 X126.459 Y131.394 E.00583
G1 X126.877 Y131.297 E.01379
G1 X126.152 Y130.915 F9000
G1 F1463
G1 X126.37 Y131.352 E.01571
G1 X126.248 Y131.477 E.00562
G3 X125.609 Y131.074 I1.907 J-3.732 E.02431
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
G1 X125.485 Y130.364 F9000
G1 F1463
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.599 J-2.961 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
G1 X124.977 Y129.663 F9000
G1 F1463
G1 X124.958 Y130.147 E.01558
G1 X124.786 Y130.195 E.00572
G3 X124.425 Y129.536 I3.258 J-2.215 E.0242
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
G1 X124.658 Y128.859 F9000
G1 F1463
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G3 X124.154 Y128.594 I3.947 J-1.39 E.02431
G1 X124.31 Y128.516 E.00561
G1 X124.615 Y128.817 E.01378
G1 X124.549 Y128 F9000
G1 F1463
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
G1 X124.658 Y127.141 F9000
G1 F1463
G1 X124.31 Y127.484 E.01571
G1 X124.154 Y127.406 E.00561
G3 X124.339 Y126.674 I4.128 J.657 E.02431
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
G1 X124.977 Y126.337 F9000
G1 F1463
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.62 J1.557 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
G1 X125.485 Y125.636 F9000
G1 F1463
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.114 J2.414 E.0242
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
G1 X126.152 Y125.085 F9000
G1 F1463
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.523 I2.548 J3.335 E.02431
G1 X126.37 Y124.648 E.00562
G1 X126.179 Y125.031 E.01378
G1 X126.935 Y124.716 F9000
G1 F1463
G1 X126.459 Y124.606 E.01572
G1 X126.447 Y124.425 E.00583
G3 X127.159 Y124.194 I1.641 J3.839 E.02409
G1 X127.256 Y124.347 E.00583
G1 X126.975 Y124.671 E.01379
; WIPE_START
G1 F5895.652
G1 X126.459 Y124.606 E-.19741
G1 X126.447 Y124.425 E-.06891
G1 X126.798 Y124.293 E-.1423
G1 X127.159 Y124.194 E-.14231
G1 X127.256 Y124.347 E-.06892
G1 X127.014 Y124.626 E-.14015
; WIPE_END
G1 E-.04 F1800
G1 X123.723 Y128.385 Z2.8 F9000
G1 Z2.4
M73 P84 R3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1463
G3 X127.426 Y123.749 I4.271 J-.386 E.19518
G3 X128.234 Y123.718 I.61 J5.358 E.02408
G3 X123.729 Y128.445 I-.24 J4.281 E.58144
; OBJECT_ID: 118
; WIPE_START
G1 F6364.704
G1 X123.712 Y128 E-.16911
G1 X123.73 Y127.615 E-.14626
G1 X123.781 Y127.234 E-.14627
G1 X123.867 Y126.859 E-.1463
G1 X123.986 Y126.493 E-.14627
G1 X123.992 Y126.479 E-.00579
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X116.36 Y126.509 Z2.8 F9000
G1 X104.382 Y126.557 Z2.8
G1 Z2.4
G1 E.8 F1800
G1 F1463
G1 X104.363 Y126.079 E.01424
G1 X104.823 Y125.95 E.01424
G1 X104.924 Y125.482 E.01424
G1 X105.402 Y125.471 E.01424
G1 X105.616 Y125.044 E.01424
G1 X106.081 Y125.151 E.01424
G1 X106.394 Y124.79 E.01424
G1 X106.819 Y125.011 E.01424
G1 X106.849 Y124.99 E.00109
G1 X107.212 Y124.739 E.01315
G1 X107.568 Y125.058 E.01424
G1 X108.016 Y124.893 E.01424
G1 X108.282 Y125.29 E.01424
G1 X108.757 Y125.241 E.01424
G1 X108.916 Y125.692 E.01424
G1 X109.389 Y125.763 E.01424
G1 X109.43 Y126.24 E.01424
G1 X109.87 Y126.426 E.01424
G1 X109.792 Y126.897 E.01424
G1 X110.171 Y127.187 E.01424
G1 X109.978 Y127.625 E.01424
G1 X110.274 Y128 E.01424
G1 X109.978 Y128.375 E.01424
G1 X110.171 Y128.813 E.01424
G1 X109.792 Y129.103 E.01424
G1 X109.87 Y129.574 E.01424
G1 X109.43 Y129.76 E.01424
G1 X109.389 Y130.237 E.01424
G1 X108.916 Y130.308 E.01424
G1 X108.757 Y130.759 E.01424
G1 X108.282 Y130.71 E.01424
G1 X108.016 Y131.107 E.01424
G1 X107.568 Y130.942 E.01424
G1 X107.212 Y131.261 E.01424
G1 X106.819 Y130.989 E.01424
G1 X106.394 Y131.21 E.01424
G1 X106.081 Y130.849 E.01424
G1 X105.616 Y130.956 E.01424
G1 X105.402 Y130.529 E.01424
G1 X104.924 Y130.518 E.01424
G1 X104.823 Y130.05 E.01424
G1 X104.363 Y129.921 E.01424
G1 X104.382 Y129.443 E.01424
G1 X103.969 Y129.203 E.01424
G1 X104.106 Y128.745 E.01424
G1 X103.765 Y128.41 E.01424
G1 X104.012 Y128 E.01424
G1 X103.765 Y127.59 E.01424
G1 X104.106 Y127.255 E.01424
G1 X103.969 Y126.797 E.01424
G1 X104.33 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X104.363 Y126.079 E-.19337
G1 X104.823 Y125.95 E-.18163
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X106.79 Y124.554 Z2.8 F9000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1463
G1 X106.356 Y124.329 E.01571
G1 X106.383 Y124.156 E.00562
G3 X107.136 Y124.107 I.651 J4.142 E.02431
G1 X107.189 Y124.278 E.00578
G1 X106.839 Y124.52 E.01368
G1 X107.292 Y124.285 F9000
G1 F1463
G1 X107.362 Y124.123 E.00567
G1 X107.53 Y124.138 E.00541
G3 X108.101 Y124.263 I-.409 J3.235 E.01882
G1 X108.108 Y124.441 E.00572
G1 X107.654 Y124.608 E.01558
G1 X107.337 Y124.325 E.01368
G1 X108.208 Y124.473 F9000
G1 F1463
G1 X108.318 Y124.334 E.00572
G1 X108.538 Y124.416 E.00756
G3 X108.998 Y124.654 I-1.095 J2.676 E.01666
G1 X108.96 Y124.826 E.00567
G1 X108.477 Y124.876 E.01561
G1 X108.241 Y124.523 E.01365
; WIPE_START
G1 F5895.652
G1 X108.318 Y124.334 E-.07771
G1 X108.538 Y124.416 E-.08934
G1 X108.998 Y124.654 E-.19667
G1 X108.96 Y124.826 E-.06699
G1 X108.477 Y124.876 E-.18448
G1 X108.265 Y124.559 E-.14481
; WIPE_END
G1 E-.04 F1800
G1 X109.208 Y125.34 Z2.8 F9000
G1 Z2.4
G1 E.8 F1800
G1 F1463
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.532 J2.019 E.01455
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
G1 X109.8 Y125.971 F9000
G1 F1463
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01378
G1 X110.217 Y126.729 F9000
G1 F1463
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00562
G1 X110.518 Y126.309 E.0033
G3 X110.749 Y126.92 I-3.278 J1.591 E.02103
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
G1 X110.432 Y127.567 F9000
G1 F1463
G1 X110.628 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.847 J.869 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
G1 X110.432 Y128.433 F9000
G1 F1463
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.942 J-.123 E.0242
G1 X110.629 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
G1 X110.217 Y129.271 F9000
G1 F1463
G1 X110.603 Y128.977 E.01561
G1 X110.749 Y129.08 E.00578
G3 X110.469 Y129.781 I-4.018 J-1.199 E.02431
G1 X110.297 Y129.753 E.00562
G1 X110.227 Y129.33 E.01378
G1 X109.8 Y130.029 F9000
G1 F1463
G1 X110.25 Y129.839 E.01571
G1 X110.366 Y129.978 E.00583
G3 X109.926 Y130.584 I-3.585 J-2.142 E.02409
G1 X109.758 Y130.516 E.00583
G1 X109.795 Y130.089 E.01378
; WIPE_START
G1 F5895.652
G1 X110.25 Y129.839 E-.1974
G1 X110.366 Y129.978 E-.06891
G1 X110.16 Y130.291 E-.14233
G1 X109.926 Y130.584 E-.14224
G1 X109.758 Y130.516 E-.06891
G1 X109.79 Y130.149 E-.14021
; WIPE_END
G1 E-.04 F1800
G1 X109.136 Y130.864 Z2.8 F9000
G1 Z2.4
G1 E.8 F1800
G1 F1463
G1 X109.208 Y130.66 E.00695
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.965 J-2.973 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.116 Y130.921 E.00673
G1 X108.745 Y131.152 F9000
G1 F1463
G1 X108.96 Y131.174 E.00694
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.013 J-3.386 E.0242
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.686 Y131.145 E.00675
G1 X107.815 Y131.451 F9000
G1 F1463
G1 X108.108 Y131.559 E.01005
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.1 J-3.781 E.0242
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.759 Y131.43 E.00359
G1 X106.79 Y131.446 F9000
G1 F1463
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.194 E.02431
G1 X106.356 Y131.671 E.00562
G1 X106.737 Y131.474 E.01378
G1 X105.94 Y131.284 F9000
G1 F1463
G1 X106.26 Y131.653 E.01572
G1 X106.163 Y131.806 E.00583
G3 X105.452 Y131.575 I.928 J-4.067 E.02409
G1 X105.464 Y131.394 E.00583
G1 X105.881 Y131.297 E.01379
G1 X105.157 Y130.915 F9000
G1 F1463
G1 X105.375 Y131.352 E.01571
G1 X105.252 Y131.477 E.00562
G3 X104.614 Y131.074 I1.907 J-3.732 E.02431
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
G1 X104.49 Y130.364 F9000
G1 F1463
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.599 J-2.961 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
G1 X103.981 Y129.663 F9000
G1 F1463
G1 X103.962 Y130.147 E.01558
G1 X103.791 Y130.195 E.00572
G3 X103.429 Y129.536 I3.258 J-2.215 E.0242
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
G1 X103.662 Y128.859 F9000
G1 F1463
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G3 X103.158 Y128.594 I3.947 J-1.39 E.02431
G1 X103.314 Y128.516 E.00561
G1 X103.62 Y128.817 E.01378
G1 X103.554 Y128 F9000
G1 F1463
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
G1 X103.662 Y127.141 F9000
G1 F1463
G1 X103.314 Y127.484 E.01571
G1 X103.158 Y127.406 E.00561
G3 X103.344 Y126.674 I4.128 J.657 E.02431
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
G1 X103.981 Y126.337 F9000
G1 F1463
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.62 J1.557 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
G1 X104.49 Y125.636 F9000
G1 F1463
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.114 J2.414 E.0242
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
G1 X105.157 Y125.085 F9000
G1 F1463
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.523 I2.548 J3.335 E.02431
G1 X105.375 Y124.648 E.00562
G1 X105.183 Y125.031 E.01378
G1 X105.94 Y124.716 F9000
G1 F1463
G1 X105.464 Y124.606 E.01572
G1 X105.452 Y124.425 E.00583
G3 X106.163 Y124.194 I1.641 J3.839 E.02409
G1 X106.26 Y124.347 E.00583
G1 X105.979 Y124.671 E.01379
; WIPE_START
G1 F5895.652
G1 X105.464 Y124.606 E-.19741
G1 X105.452 Y124.425 E-.06891
G1 X105.802 Y124.293 E-.1423
G1 X106.163 Y124.194 E-.14231
G1 X106.26 Y124.347 E-.06892
G1 X106.018 Y124.626 E-.14015
; WIPE_END
G1 E-.04 F1800
G1 X102.728 Y128.385 Z2.8 F9000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1463
G3 X106.431 Y123.749 I4.271 J-.386 E.19518
G3 X107.238 Y123.718 I.61 J5.358 E.02408
G3 X102.734 Y128.445 I-.24 J4.281 E.58144
; WIPE_START
G1 F6364.704
G1 X102.717 Y128 E-.16911
G1 X102.734 Y127.615 E-.14626
G1 X102.786 Y127.234 E-.14627
G1 X102.872 Y126.859 E-.14629
G1 X102.99 Y126.493 E-.14627
G1 X102.996 Y126.479 E-.00579
; WIPE_END
G1 E-.04 F1800
G17
G3 Z2.8 I1.217 J0 P1  F9000
; stop printing object, unique label id: 118
M625
; object ids of layer 12 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.8
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z2.8 F4000
            G39.3 S1
            G0 Z2.8 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END


; object ids of this layer12 end: 82,118
M625
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 13/23
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F9000
G1 Z2.6
G1 E.8 F1800
G1 F1433
G1 X125.359 Y126.079 E.01424
G1 X125.819 Y125.95 E.01424
G1 X125.92 Y125.482 E.01424
G1 X126.397 Y125.471 E.01424
G1 X126.611 Y125.044 E.01424
G1 X127.077 Y125.151 E.01424
G1 X127.39 Y124.79 E.01424
G1 X127.814 Y125.011 E.01424
G1 X127.865 Y124.976 E.00184
G1 X128.207 Y124.739 E.0124
G1 X128.563 Y125.058 E.01424
G1 X129.012 Y124.893 E.01424
G1 X129.277 Y125.29 E.01424
G1 X129.753 Y125.241 E.01424
G1 X129.911 Y125.692 E.01424
G1 X130.384 Y125.763 E.01424
G1 X130.425 Y126.24 E.01424
G1 X130.865 Y126.426 E.01424
G1 X130.787 Y126.897 E.01424
G1 X131.167 Y127.187 E.01424
G1 X130.974 Y127.625 E.01424
G1 X131.27 Y128 E.01424
G1 X130.974 Y128.375 E.01424
G1 X131.167 Y128.813 E.01424
G1 X130.787 Y129.103 E.01424
G1 X130.865 Y129.574 E.01424
G1 X130.425 Y129.76 E.01424
G1 X130.384 Y130.237 E.01424
G1 X129.911 Y130.308 E.01424
G1 X129.753 Y130.759 E.01424
G1 X129.277 Y130.71 E.01424
G1 X129.012 Y131.107 E.01424
G1 X128.563 Y130.942 E.01424
G1 X128.207 Y131.261 E.01424
G1 X127.814 Y130.989 E.01424
G1 X127.39 Y131.21 E.01424
G1 X127.077 Y130.849 E.01424
G1 X126.611 Y130.956 E.01424
G1 X126.397 Y130.529 E.01424
G1 X125.92 Y130.518 E.01424
G1 X125.819 Y130.05 E.01424
G1 X125.359 Y129.921 E.01424
G1 X125.378 Y129.443 E.01424
G1 X124.964 Y129.203 E.01424
G1 X125.101 Y128.745 E.01424
G1 X124.761 Y128.41 E.01424
G1 X125.007 Y128 E.01424
G1 X124.761 Y127.59 E.01424
G1 X125.101 Y127.255 E.01424
G1 X124.964 Y126.797 E.01424
G1 X125.326 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18164
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X127.785 Y124.554 Z3 F9000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1433
G1 X127.352 Y124.329 E.01571
G1 X127.378 Y124.156 E.00562
G3 X128.131 Y124.107 I.651 J4.139 E.02431
G1 X128.185 Y124.278 E.00578
G1 X127.835 Y124.52 E.01368
G1 X128.288 Y124.285 F9000
G1 F1433
G1 X128.358 Y124.123 E.00567
G1 X128.525 Y124.138 E.00541
G3 X129.096 Y124.263 I-.409 J3.234 E.01882
G1 X129.104 Y124.441 E.00572
G1 X128.649 Y124.608 E.01558
G1 X128.332 Y124.325 E.01368
G1 X129.22 Y124.499 F9000
G1 F1433
G1 X129.203 Y124.473 E.00099
G1 X129.314 Y124.334 E.00572
G1 X129.534 Y124.416 E.00757
G3 X129.993 Y124.654 I-1.091 J2.669 E.01666
G1 X129.955 Y124.826 E.00567
G1 X129.472 Y124.876 E.01561
G1 X129.254 Y124.549 E.01266
; WIPE_START
G1 F5895.652
G1 X129.203 Y124.473 E-.03453
G1 X129.314 Y124.334 E-.06763
G1 X129.534 Y124.416 E-.08941
G1 X129.993 Y124.654 E-.1966
G1 X129.955 Y124.826 E-.06699
G1 X129.472 Y124.876 E-.18447
G1 X129.296 Y124.612 E-.12039
; WIPE_END
G1 E-.04 F1800
G1 X130.203 Y125.34 Z3 F9000
G1 Z2.6
G1 E.8 F1800
G1 F1433
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.527 J2.014 E.01456
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
G1 X130.796 Y125.971 F9000
G1 F1433
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01378
G1 X131.212 Y126.729 F9000
G1 F1433
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00562
G1 X131.514 Y126.309 E.0033
G1 X131.535 Y126.358 E.00173
G3 X131.745 Y126.92 I-3.015 J1.449 E.0193
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
G1 X131.428 Y127.567 F9000
G1 F1433
G1 X131.624 Y127.123 E.01561
G1 X131.799 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.846 J.869 E.0242
M73 P85 R3
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
G1 X131.428 Y128.433 F9000
G1 F1433
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.8 Y128.86 I-3.942 J-.123 E.0242
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
G1 X131.213 Y129.271 F9000
G1 F1433
G1 X131.598 Y128.977 E.01561
G1 X131.745 Y129.08 E.00578
G3 X131.465 Y129.781 I-4.023 J-1.201 E.0243
G1 X131.293 Y129.753 E.00562
G1 X131.222 Y129.33 E.01378
G1 X130.796 Y130.029 F9000
G1 F1433
G1 X131.246 Y129.839 E.01571
G1 X131.362 Y129.978 E.00583
G3 X130.922 Y130.584 I-3.582 J-2.14 E.02409
G1 X130.753 Y130.516 E.00583
G1 X130.79 Y130.089 E.01378
G1 X130.143 Y130.831 F9000
G1 F1433
G1 X130.203 Y130.66 E.00583
G1 X130.686 Y130.588 E.01571
G1 X130.767 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.962 J-2.968 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.123 Y130.888 E.00785
G1 X129.741 Y131.152 F9000
G1 F1433
G1 X129.955 Y131.174 E.00694
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.015 J-3.39 E.0242
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00674
G1 X128.81 Y131.451 F9000
G1 F1433
G1 X129.104 Y131.559 E.01005
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.101 J-3.785 E.0242
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.00359
G1 X127.785 Y131.446 F9000
G1 F1433
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.186 E.02431
G1 X127.352 Y131.671 E.00561
G1 X127.732 Y131.474 E.01378
G1 X126.935 Y131.284 F9000
G1 F1433
G1 X127.256 Y131.653 E.01571
G1 X127.159 Y131.806 E.00583
G3 X126.447 Y131.575 I.929 J-4.069 E.02409
G1 X126.459 Y131.394 E.00583
G1 X126.877 Y131.297 E.01379
G1 X126.152 Y130.915 F9000
G1 F1433
G1 X126.37 Y131.352 E.0157
G1 X126.248 Y131.476 E.00561
G3 X125.609 Y131.074 I1.902 J-3.725 E.02431
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
G1 X125.485 Y130.364 F9000
G1 F1433
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.599 J-2.961 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
G1 X124.977 Y129.663 F9000
G1 F1433
G1 X124.958 Y130.147 E.01558
G1 X124.786 Y130.195 E.00572
G3 X124.425 Y129.536 I3.258 J-2.216 E.0242
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
G1 X124.658 Y128.859 F9000
G1 F1433
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G3 X124.154 Y128.594 I3.954 J-1.392 E.02431
G1 X124.31 Y128.516 E.00562
G1 X124.615 Y128.817 E.01378
G1 X124.549 Y128 F9000
G1 F1433
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
G1 X124.658 Y127.141 F9000
G1 F1433
G1 X124.31 Y127.484 E.01571
G1 X124.154 Y127.406 E.00561
G3 X124.339 Y126.674 I4.131 J.658 E.02431
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
G1 X124.977 Y126.337 F9000
G1 F1433
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.619 J1.557 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
G1 X125.485 Y125.636 F9000
G1 F1433
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.114 J2.414 E.0242
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
G1 X126.152 Y125.085 F9000
G1 F1433
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.523 I2.548 J3.335 E.02431
G1 X126.37 Y124.648 E.00562
G1 X126.179 Y125.031 E.01378
G1 X126.935 Y124.716 F9000
G1 F1433
G1 X126.459 Y124.606 E.01571
G1 X126.447 Y124.425 E.00583
G3 X127.159 Y124.194 I1.64 J3.838 E.02409
G1 X127.256 Y124.347 E.00583
G1 X126.975 Y124.671 E.01379
; WIPE_START
G1 F5895.652
G1 X126.459 Y124.606 E-.19741
G1 X126.447 Y124.425 E-.06891
G1 X126.798 Y124.293 E-.14229
G1 X127.159 Y124.194 E-.14232
G1 X127.256 Y124.347 E-.06891
G1 X127.014 Y124.626 E-.14016
; WIPE_END
G1 E-.04 F1800
G1 X123.733 Y128.384 Z3 F9000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1433
G3 X128.266 Y123.721 I4.273 J-.381 E.21984
G3 X123.772 Y128.695 I-.264 J4.278 E.57298
G3 X123.738 Y128.444 I4.234 J-.692 E.00756
; OBJECT_ID: 118
; WIPE_START
G1 F6364.704
M73 P85 R2
G1 X123.712 Y128 E-.16895
G1 X123.73 Y127.615 E-.14627
G1 X123.781 Y127.234 E-.14628
G1 X123.867 Y126.859 E-.14627
G1 X123.986 Y126.493 E-.14627
G1 X123.992 Y126.478 E-.00597
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X116.36 Y126.509 Z3 F9000
G1 X104.382 Y126.557 Z3
G1 Z2.6
G1 E.8 F1800
G1 F1433
G1 X104.363 Y126.079 E.01424
G1 X104.823 Y125.95 E.01424
G1 X104.924 Y125.482 E.01424
G1 X105.402 Y125.471 E.01424
G1 X105.616 Y125.044 E.01424
G1 X106.081 Y125.151 E.01424
G1 X106.394 Y124.79 E.01424
G1 X106.819 Y125.011 E.01424
G1 X106.869 Y124.976 E.00184
G1 X107.212 Y124.739 E.0124
G1 X107.568 Y125.058 E.01424
G1 X108.016 Y124.893 E.01424
G1 X108.282 Y125.29 E.01424
G1 X108.757 Y125.241 E.01424
G1 X108.916 Y125.692 E.01424
G1 X109.389 Y125.763 E.01424
G1 X109.43 Y126.24 E.01424
G1 X109.87 Y126.426 E.01424
G1 X109.792 Y126.897 E.01424
G1 X110.171 Y127.187 E.01424
G1 X109.978 Y127.625 E.01424
G1 X110.274 Y128 E.01424
G1 X109.978 Y128.375 E.01424
G1 X110.171 Y128.813 E.01424
G1 X109.792 Y129.103 E.01424
G1 X109.87 Y129.574 E.01424
G1 X109.43 Y129.76 E.01424
G1 X109.389 Y130.237 E.01424
G1 X108.916 Y130.308 E.01424
G1 X108.757 Y130.759 E.01424
G1 X108.282 Y130.71 E.01424
G1 X108.016 Y131.107 E.01424
G1 X107.568 Y130.942 E.01424
G1 X107.212 Y131.261 E.01424
G1 X106.819 Y130.989 E.01424
G1 X106.394 Y131.21 E.01424
G1 X106.081 Y130.849 E.01424
G1 X105.616 Y130.956 E.01424
G1 X105.402 Y130.529 E.01424
G1 X104.924 Y130.518 E.01424
G1 X104.823 Y130.05 E.01424
G1 X104.363 Y129.921 E.01424
G1 X104.382 Y129.443 E.01424
G1 X103.969 Y129.203 E.01424
G1 X104.106 Y128.745 E.01424
G1 X103.765 Y128.41 E.01424
G1 X104.012 Y128 E.01424
G1 X103.765 Y127.59 E.01424
G1 X104.106 Y127.255 E.01424
G1 X103.969 Y126.797 E.01424
G1 X104.33 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18164
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X106.79 Y124.554 Z3 F9000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1433
G1 X106.356 Y124.329 E.01571
G1 X106.383 Y124.156 E.00562
G3 X107.136 Y124.107 I.651 J4.139 E.02431
G1 X107.189 Y124.278 E.00578
G1 X106.839 Y124.52 E.01368
G1 X107.292 Y124.285 F9000
G1 F1433
G1 X107.362 Y124.123 E.00567
G1 X107.53 Y124.138 E.00541
G3 X108.101 Y124.263 I-.409 J3.234 E.01882
G1 X108.108 Y124.441 E.00572
G1 X107.654 Y124.608 E.01558
G1 X107.337 Y124.325 E.01368
G1 X108.225 Y124.499 F9000
G1 F1433
G1 X108.208 Y124.473 E.00099
G1 X108.318 Y124.334 E.00572
G1 X108.539 Y124.416 E.00757
G3 X108.998 Y124.654 I-1.091 J2.669 E.01666
G1 X108.96 Y124.826 E.00567
G1 X108.477 Y124.876 E.01561
G1 X108.258 Y124.549 E.01266
; WIPE_START
G1 F5895.652
G1 X108.208 Y124.473 E-.03453
G1 X108.318 Y124.334 E-.06763
G1 X108.539 Y124.416 E-.08941
G1 X108.998 Y124.654 E-.1966
G1 X108.96 Y124.826 E-.06699
G1 X108.477 Y124.876 E-.18447
G1 X108.301 Y124.612 E-.12039
; WIPE_END
G1 E-.04 F1800
G1 X109.208 Y125.34 Z3 F9000
G1 Z2.6
G1 E.8 F1800
G1 F1433
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.527 J2.014 E.01456
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
G1 X109.8 Y125.971 F9000
G1 F1433
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01378
G1 X110.217 Y126.729 F9000
G1 F1433
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00562
G1 X110.518 Y126.309 E.0033
G1 X110.539 Y126.358 E.00173
G3 X110.749 Y126.92 I-3.015 J1.449 E.0193
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
G1 X110.432 Y127.567 F9000
G1 F1433
G1 X110.628 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.846 J.869 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
G1 X110.432 Y128.433 F9000
G1 F1433
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.942 J-.123 E.0242
G1 X110.629 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
G1 X110.217 Y129.271 F9000
G1 F1433
G1 X110.603 Y128.977 E.01561
G1 X110.749 Y129.08 E.00578
G3 X110.469 Y129.781 I-4.023 J-1.201 E.0243
G1 X110.297 Y129.753 E.00562
G1 X110.227 Y129.33 E.01378
G1 X109.8 Y130.029 F9000
G1 F1433
G1 X110.25 Y129.839 E.01571
G1 X110.366 Y129.978 E.00583
G3 X109.926 Y130.584 I-3.582 J-2.14 E.02409
G1 X109.758 Y130.516 E.00583
G1 X109.795 Y130.089 E.01378
G1 X109.147 Y130.831 F9000
G1 F1433
G1 X109.208 Y130.66 E.00583
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.962 J-2.968 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.128 Y130.888 E.00785
G1 X108.745 Y131.152 F9000
G1 F1433
G1 X108.96 Y131.174 E.00694
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.015 J-3.39 E.0242
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.685 Y131.145 E.00674
G1 X107.815 Y131.451 F9000
G1 F1433
G1 X108.108 Y131.559 E.01005
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.101 J-3.785 E.0242
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.759 Y131.43 E.00359
G1 X106.79 Y131.446 F9000
G1 F1433
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.186 E.02431
G1 X106.357 Y131.671 E.00561
G1 X106.737 Y131.474 E.01378
G1 X105.94 Y131.284 F9000
G1 F1433
G1 X106.26 Y131.653 E.01571
G1 X106.163 Y131.806 E.00583
G3 X105.452 Y131.575 I.929 J-4.069 E.02409
G1 X105.464 Y131.394 E.00583
G1 X105.881 Y131.297 E.01379
G1 X105.157 Y130.915 F9000
G1 F1433
G1 X105.375 Y131.352 E.0157
G1 X105.252 Y131.476 E.00561
G3 X104.614 Y131.074 I1.902 J-3.725 E.02431
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
G1 X104.49 Y130.364 F9000
G1 F1433
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.599 J-2.961 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
G1 X103.981 Y129.663 F9000
G1 F1433
G1 X103.962 Y130.147 E.01558
G1 X103.791 Y130.195 E.00572
G3 X103.429 Y129.536 I3.258 J-2.216 E.0242
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
G1 X103.662 Y128.859 F9000
G1 F1433
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G3 X103.158 Y128.594 I3.954 J-1.392 E.02431
G1 X103.314 Y128.516 E.00562
G1 X103.62 Y128.817 E.01378
G1 X103.554 Y128 F9000
G1 F1433
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
G1 X103.662 Y127.141 F9000
G1 F1433
G1 X103.314 Y127.484 E.01571
G1 X103.158 Y127.406 E.00561
G3 X103.344 Y126.674 I4.131 J.658 E.02431
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
G1 X103.981 Y126.337 F9000
G1 F1433
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.619 J1.557 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
G1 X104.49 Y125.636 F9000
G1 F1433
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.114 J2.414 E.0242
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
G1 X105.157 Y125.085 F9000
G1 F1433
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.523 I2.548 J3.335 E.02431
G1 X105.375 Y124.648 E.00562
G1 X105.183 Y125.031 E.01378
G1 X105.94 Y124.716 F9000
G1 F1433
G1 X105.464 Y124.606 E.01571
G1 X105.452 Y124.425 E.00583
G3 X106.163 Y124.194 I1.64 J3.838 E.02409
G1 X106.26 Y124.347 E.00583
G1 X105.979 Y124.671 E.01379
; WIPE_START
G1 F5895.652
G1 X105.464 Y124.606 E-.19741
G1 X105.452 Y124.425 E-.06891
G1 X105.802 Y124.293 E-.14229
G1 X106.163 Y124.194 E-.14232
G1 X106.26 Y124.347 E-.06891
G1 X106.018 Y124.626 E-.14016
; WIPE_END
G1 E-.04 F1800
G1 X102.737 Y128.384 Z3 F9000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1433
G3 X107.27 Y123.721 I4.273 J-.381 E.21984
G3 X102.776 Y128.695 I-.264 J4.278 E.57298
G3 X102.743 Y128.444 I4.234 J-.692 E.00756
; WIPE_START
G1 F6364.704
G1 X102.717 Y128 E-.16895
G1 X102.734 Y127.615 E-.14626
G1 X102.786 Y127.234 E-.14627
G1 X102.872 Y126.859 E-.14627
G1 X102.99 Y126.493 E-.14627
G1 X102.997 Y126.478 E-.00597
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3 I1.217 J0 P1  F9000
; stop printing object, unique label id: 118
M625
; object ids of layer 13 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3 F4000
            G39.3 S1
            G0 Z3 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END


; object ids of this layer13 end: 82,118
M625
; CHANGE_LAYER
; Z_HEIGHT: 2.8
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 14/23
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F9000
G1 Z2.8
G1 E.8 F1800
G1 F1435
G1 X125.359 Y126.079 E.01424
G1 X125.819 Y125.95 E.01424
G1 X125.92 Y125.482 E.01424
G1 X126.397 Y125.471 E.01424
G1 X126.611 Y125.044 E.01424
G1 X127.077 Y125.151 E.01424
G1 X127.39 Y124.79 E.01424
G1 X127.814 Y125.011 E.01424
G1 X127.886 Y124.961 E.00258
G1 X128.207 Y124.739 E.01165
G1 X128.563 Y125.058 E.01424
G1 X129.012 Y124.893 E.01424
G1 X129.277 Y125.29 E.01424
G1 X129.753 Y125.241 E.01424
G1 X129.911 Y125.692 E.01424
G1 X130.384 Y125.763 E.01424
G1 X130.425 Y126.24 E.01424
G1 X130.865 Y126.426 E.01424
G1 X130.787 Y126.897 E.01424
G1 X131.167 Y127.187 E.01424
G1 X130.974 Y127.625 E.01424
G1 X131.27 Y128 E.01424
G1 X130.974 Y128.375 E.01424
G1 X131.167 Y128.813 E.01424
G1 X130.787 Y129.103 E.01424
G1 X130.865 Y129.574 E.01424
G1 X130.425 Y129.76 E.01424
G1 X130.384 Y130.237 E.01424
G1 X129.911 Y130.308 E.01424
G1 X129.753 Y130.759 E.01424
G1 X129.277 Y130.71 E.01424
G1 X129.012 Y131.107 E.01424
G1 X128.563 Y130.942 E.01424
G1 X128.207 Y131.261 E.01424
G1 X127.814 Y130.989 E.01424
G1 X127.39 Y131.21 E.01424
G1 X127.077 Y130.849 E.01424
G1 X126.611 Y130.956 E.01424
G1 X126.397 Y130.529 E.01424
G1 X125.92 Y130.518 E.01424
G1 X125.819 Y130.05 E.01424
G1 X125.359 Y129.921 E.01424
G1 X125.378 Y129.443 E.01424
G1 X124.964 Y129.203 E.01424
G1 X125.101 Y128.745 E.01424
M73 P86 R2
G1 X124.761 Y128.41 E.01424
G1 X125.007 Y128 E.01424
G1 X124.761 Y127.59 E.01424
G1 X125.101 Y127.255 E.01424
G1 X124.964 Y126.797 E.01424
G1 X125.326 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X125.359 Y126.079 E-.19337
G1 X125.819 Y125.95 E-.18163
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X127.785 Y124.554 Z3.2 F9000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1435
G1 X127.352 Y124.329 E.01571
G1 X127.378 Y124.156 E.00561
G3 X128.131 Y124.107 I.651 J4.137 E.02431
G1 X128.185 Y124.278 E.00578
G1 X127.835 Y124.52 E.01368
G1 X128.288 Y124.285 F9000
G1 F1435
G1 X128.358 Y124.123 E.00567
G1 X128.525 Y124.138 E.00541
G3 X129.096 Y124.263 I-.409 J3.235 E.01882
G1 X129.104 Y124.441 E.00572
G1 X128.649 Y124.608 E.01558
G1 X128.332 Y124.325 E.01368
G1 X129.239 Y124.527 F9000
G1 F1435
G1 X129.203 Y124.473 E.00207
G1 X129.314 Y124.334 E.00572
G1 X129.534 Y124.416 E.00756
G3 X129.993 Y124.654 I-1.093 J2.673 E.01666
G1 X129.955 Y124.826 E.00567
G1 X129.472 Y124.876 E.01561
G1 X129.272 Y124.577 E.01157
; WIPE_START
G1 F5895.652
G1 X129.203 Y124.473 E-.04731
G1 X129.314 Y124.334 E-.06763
G1 X129.534 Y124.416 E-.08937
G1 X129.993 Y124.654 E-.19665
G1 X129.955 Y124.826 E-.06699
G1 X129.472 Y124.876 E-.18447
G1 X129.315 Y124.64 E-.10758
; WIPE_END
G1 E-.04 F1800
G1 X130.203 Y125.34 Z3.2 F9000
G1 Z2.8
G1 E.8 F1800
G1 F1435
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.532 J2.019 E.01456
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
G1 X130.796 Y125.971 F9000
G1 F1435
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01378
G1 X131.213 Y126.729 F9000
G1 F1435
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00562
G1 X131.514 Y126.309 E.0033
G1 X131.547 Y126.388 E.00277
G3 X131.745 Y126.92 I-2.855 J1.363 E.01826
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
G1 X131.428 Y127.567 F9000
G1 F1435
G1 X131.624 Y127.123 E.01561
G1 X131.8 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.847 J.869 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
G1 X131.428 Y128.433 F9000
G1 F1435
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.8 Y128.86 I-3.941 J-.123 E.0242
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
G1 X131.213 Y129.271 F9000
G1 F1435
G1 X131.598 Y128.977 E.01561
G1 X131.745 Y129.08 E.00578
G3 X131.465 Y129.781 I-4.024 J-1.201 E.0243
G1 X131.293 Y129.753 E.00562
G1 X131.222 Y129.33 E.01378
G1 X130.796 Y130.029 F9000
G1 F1435
G1 X131.246 Y129.839 E.01571
G1 X131.362 Y129.978 E.00583
G3 X130.922 Y130.584 I-3.582 J-2.14 E.02409
G1 X130.753 Y130.516 E.00583
G1 X130.79 Y130.089 E.01378
G1 X130.154 Y130.799 F9000
G1 F1435
G1 X130.203 Y130.66 E.00473
G1 X130.686 Y130.588 E.01571
G1 X130.767 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.965 J-2.973 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.135 Y130.856 E.00895
G1 X129.741 Y131.152 F9000
G1 F1435
G1 X129.955 Y131.174 E.00693
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.444 J-4.3 E.02419
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00675
G1 X128.81 Y131.451 F9000
G1 F1435
G1 X129.104 Y131.559 E.01005
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.101 J-3.786 E.02421
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.0036
G1 X127.785 Y131.446 F9000
G1 F1435
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.187 E.02431
G1 X127.352 Y131.671 E.00561
G1 X127.732 Y131.474 E.01378
G1 X126.935 Y131.284 F9000
G1 F1435
G1 X127.256 Y131.653 E.01571
G1 X127.159 Y131.806 E.00583
G3 X126.447 Y131.575 I.928 J-4.068 E.02409
G1 X126.459 Y131.394 E.00583
G1 X126.877 Y131.297 E.01379
G1 X126.152 Y130.915 F9000
G1 F1435
G1 X126.37 Y131.352 E.0157
G1 X126.248 Y131.476 E.00562
G3 X125.609 Y131.074 I2.533 J-4.727 E.02429
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
G1 X125.485 Y130.364 F9000
G1 F1435
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.6 J-2.962 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
G1 X124.977 Y129.663 F9000
G1 F1435
G1 X124.958 Y130.147 E.01558
G1 X124.786 Y130.195 E.00572
G3 X124.425 Y129.536 I3.261 J-2.217 E.0242
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
G1 X124.658 Y128.859 F9000
G1 F1435
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G3 X124.154 Y128.594 I3.954 J-1.392 E.02431
G1 X124.31 Y128.516 E.00562
G1 X124.615 Y128.817 E.01378
G1 X124.549 Y128 F9000
G1 F1435
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
G1 X124.658 Y127.141 F9000
G1 F1435
G1 X124.31 Y127.484 E.01571
G1 X124.154 Y127.406 E.00562
G3 X124.339 Y126.674 I4.137 J.659 E.02431
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
G1 X124.977 Y126.337 F9000
G1 F1435
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.62 J1.557 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
G1 X125.485 Y125.636 F9000
G1 F1435
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.114 J2.414 E.0242
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
G1 X126.152 Y125.085 F9000
G1 F1435
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.524 I2.54 J3.322 E.02431
G1 X126.37 Y124.648 E.00561
G1 X126.179 Y125.031 E.01377
G1 X126.935 Y124.716 F9000
G1 F1435
G1 X126.459 Y124.606 E.01571
G1 X126.447 Y124.425 E.00583
G3 X127.159 Y124.194 I1.64 J3.836 E.02409
G1 X127.256 Y124.347 E.00583
G1 X126.975 Y124.671 E.01378
; WIPE_START
G1 F5895.652
G1 X126.459 Y124.606 E-.19741
G1 X126.447 Y124.425 E-.06891
G1 X126.798 Y124.293 E-.14233
G1 X127.159 Y124.194 E-.14227
G1 X127.256 Y124.347 E-.06891
G1 X127.014 Y124.626 E-.14017
; WIPE_END
G1 E-.04 F1800
G1 X123.723 Y128.385 Z3.2 F9000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1435
G3 X126.677 Y123.92 I4.271 J-.384 E.17222
G3 X128.298 Y123.724 I1.333 J4.215 E.04892
G3 X123.729 Y128.445 I-.305 J4.277 E.57954
; OBJECT_ID: 118
; WIPE_START
G1 F6364.704
G1 X123.712 Y128 E-.16908
G1 X123.73 Y127.615 E-.14626
G1 X123.781 Y127.234 E-.14628
G1 X123.867 Y126.859 E-.14628
G1 X123.986 Y126.493 E-.14624
G1 X123.992 Y126.479 E-.00586
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X116.36 Y126.509 Z3.2 F9000
G1 X104.382 Y126.557 Z3.2
G1 Z2.8
G1 E.8 F1800
G1 F1435
G1 X104.363 Y126.079 E.01424
G1 X104.823 Y125.95 E.01424
G1 X104.924 Y125.482 E.01424
G1 X105.402 Y125.471 E.01424
G1 X105.616 Y125.044 E.01424
G1 X106.081 Y125.151 E.01424
G1 X106.394 Y124.79 E.01424
G1 X106.819 Y125.011 E.01424
G1 X106.89 Y124.961 E.00258
G1 X107.212 Y124.739 E.01165
G1 X107.568 Y125.058 E.01424
G1 X108.016 Y124.893 E.01424
G1 X108.282 Y125.29 E.01424
G1 X108.757 Y125.241 E.01424
G1 X108.916 Y125.692 E.01424
G1 X109.389 Y125.763 E.01424
G1 X109.43 Y126.24 E.01424
G1 X109.87 Y126.426 E.01424
G1 X109.792 Y126.897 E.01424
G1 X110.171 Y127.187 E.01424
G1 X109.978 Y127.625 E.01424
G1 X110.274 Y128 E.01424
G1 X109.978 Y128.375 E.01424
G1 X110.171 Y128.813 E.01424
G1 X109.792 Y129.103 E.01424
G1 X109.87 Y129.574 E.01424
G1 X109.43 Y129.76 E.01424
G1 X109.389 Y130.237 E.01424
G1 X108.916 Y130.308 E.01424
G1 X108.757 Y130.759 E.01424
G1 X108.282 Y130.71 E.01424
G1 X108.016 Y131.107 E.01424
G1 X107.568 Y130.942 E.01424
G1 X107.212 Y131.261 E.01424
G1 X106.819 Y130.989 E.01424
G1 X106.394 Y131.21 E.01424
G1 X106.081 Y130.849 E.01424
G1 X105.616 Y130.956 E.01424
G1 X105.402 Y130.529 E.01424
G1 X104.924 Y130.518 E.01424
G1 X104.823 Y130.05 E.01424
G1 X104.363 Y129.921 E.01424
G1 X104.382 Y129.443 E.01424
G1 X103.969 Y129.203 E.01424
G1 X104.106 Y128.745 E.01424
G1 X103.765 Y128.41 E.01424
G1 X104.012 Y128 E.01424
G1 X103.765 Y127.59 E.01424
G1 X104.106 Y127.255 E.01424
G1 X103.969 Y126.797 E.01424
G1 X104.33 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X104.363 Y126.079 E-.19337
G1 X104.823 Y125.95 E-.18163
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X106.79 Y124.554 Z3.2 F9000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1435
G1 X106.356 Y124.329 E.01571
G1 X106.383 Y124.156 E.00561
G3 X107.136 Y124.107 I.651 J4.137 E.02431
G1 X107.189 Y124.278 E.00578
G1 X106.839 Y124.52 E.01368
G1 X107.292 Y124.285 F9000
G1 F1435
G1 X107.362 Y124.123 E.00567
G1 X107.53 Y124.138 E.00541
G3 X108.101 Y124.263 I-.409 J3.235 E.01882
G1 X108.108 Y124.441 E.00572
G1 X107.654 Y124.608 E.01558
G1 X107.337 Y124.325 E.01368
G1 X108.244 Y124.527 F9000
G1 F1435
G1 X108.208 Y124.473 E.00207
G1 X108.318 Y124.334 E.00572
G1 X108.538 Y124.416 E.00756
G3 X108.998 Y124.654 I-1.093 J2.673 E.01666
G1 X108.96 Y124.826 E.00567
G1 X108.477 Y124.876 E.01561
G1 X108.277 Y124.577 E.01157
; WIPE_START
G1 F5895.652
G1 X108.208 Y124.473 E-.04731
G1 X108.318 Y124.334 E-.06763
G1 X108.538 Y124.416 E-.08937
G1 X108.998 Y124.654 E-.19665
G1 X108.96 Y124.826 E-.06699
G1 X108.477 Y124.876 E-.18447
G1 X108.32 Y124.64 E-.10758
; WIPE_END
G1 E-.04 F1800
G1 X109.208 Y125.34 Z3.2 F9000
G1 Z2.8
G1 E.8 F1800
G1 F1435
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.532 J2.019 E.01456
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
G1 X109.8 Y125.971 F9000
G1 F1435
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01378
G1 X110.217 Y126.729 F9000
G1 F1435
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00562
G1 X110.518 Y126.309 E.0033
G1 X110.552 Y126.388 E.00277
G3 X110.749 Y126.92 I-2.855 J1.363 E.01826
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
G1 X110.432 Y127.567 F9000
G1 F1435
G1 X110.629 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.847 J.869 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
G1 X110.432 Y128.433 F9000
G1 F1435
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.941 J-.123 E.0242
G1 X110.629 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
G1 X110.217 Y129.271 F9000
G1 F1435
G1 X110.603 Y128.977 E.01561
G1 X110.749 Y129.08 E.00578
G3 X110.469 Y129.781 I-4.024 J-1.201 E.0243
G1 X110.297 Y129.753 E.00562
G1 X110.227 Y129.33 E.01378
G1 X109.8 Y130.029 F9000
G1 F1435
G1 X110.25 Y129.839 E.01571
G1 X110.366 Y129.978 E.00583
G3 X109.926 Y130.584 I-3.582 J-2.14 E.02409
G1 X109.758 Y130.516 E.00583
G1 X109.795 Y130.089 E.01378
G1 X109.159 Y130.799 F9000
G1 F1435
G1 X109.208 Y130.66 E.00473
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.965 J-2.973 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.139 Y130.856 E.00895
G1 X108.745 Y131.152 F9000
G1 F1435
G1 X108.96 Y131.174 E.00693
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.444 J-4.3 E.02419
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.686 Y131.145 E.00675
G1 X107.815 Y131.451 F9000
G1 F1435
G1 X108.108 Y131.559 E.01005
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.101 J-3.786 E.02421
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.759 Y131.43 E.0036
G1 X106.79 Y131.446 F9000
G1 F1435
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.187 E.02431
G1 X106.356 Y131.671 E.00561
G1 X106.737 Y131.474 E.01378
G1 X105.94 Y131.284 F9000
G1 F1435
G1 X106.26 Y131.653 E.01571
G1 X106.163 Y131.806 E.00583
G3 X105.452 Y131.575 I.928 J-4.068 E.02409
G1 X105.464 Y131.394 E.00583
G1 X105.881 Y131.297 E.01379
G1 X105.157 Y130.915 F9000
G1 F1435
G1 X105.375 Y131.352 E.0157
G1 X105.252 Y131.476 E.00562
G3 X104.614 Y131.074 I2.533 J-4.727 E.02429
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
G1 X104.49 Y130.364 F9000
G1 F1435
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.6 J-2.962 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
G1 X103.981 Y129.663 F9000
G1 F1435
G1 X103.962 Y130.147 E.01558
G1 X103.791 Y130.195 E.00572
G3 X103.429 Y129.536 I3.261 J-2.217 E.0242
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
G1 X103.662 Y128.859 F9000
G1 F1435
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G3 X103.158 Y128.594 I3.954 J-1.392 E.02431
G1 X103.314 Y128.516 E.00562
G1 X103.62 Y128.817 E.01378
G1 X103.554 Y128 F9000
G1 F1435
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
G1 X103.662 Y127.141 F9000
G1 F1435
G1 X103.314 Y127.484 E.01571
G1 X103.158 Y127.406 E.00562
G3 X103.344 Y126.674 I4.137 J.659 E.02431
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
G1 X103.981 Y126.337 F9000
G1 F1435
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.62 J1.557 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
G1 X104.49 Y125.636 F9000
G1 F1435
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.114 J2.414 E.0242
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
G1 X105.157 Y125.085 F9000
G1 F1435
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.524 I2.54 J3.322 E.02431
G1 X105.375 Y124.648 E.00561
G1 X105.183 Y125.031 E.01377
G1 X105.94 Y124.716 F9000
G1 F1435
G1 X105.464 Y124.606 E.01571
G1 X105.452 Y124.425 E.00583
G3 X106.163 Y124.194 I1.64 J3.836 E.02409
G1 X106.26 Y124.347 E.00583
G1 X105.979 Y124.671 E.01378
; WIPE_START
G1 F5895.652
G1 X105.464 Y124.606 E-.19741
G1 X105.452 Y124.425 E-.06891
G1 X105.802 Y124.293 E-.14233
G1 X106.163 Y124.194 E-.14227
G1 X106.26 Y124.347 E-.06891
G1 X106.018 Y124.626 E-.14017
; WIPE_END
G1 E-.04 F1800
G1 X102.727 Y128.385 Z3.2 F9000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1435
G3 X105.681 Y123.92 I4.271 J-.384 E.17222
G3 X107.302 Y123.724 I1.333 J4.215 E.04892
G3 X102.733 Y128.445 I-.305 J4.277 E.57954
; WIPE_START
G1 F6364.704
G1 X102.717 Y128 E-.16908
G1 X102.734 Y127.615 E-.14626
G1 X102.786 Y127.234 E-.14628
G1 X102.872 Y126.859 E-.14628
G1 X102.99 Y126.493 E-.14624
G1 X102.997 Y126.479 E-.00586
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3.2 I1.217 J0 P1  F9000
; stop printing object, unique label id: 118
M625
; object ids of layer 14 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.2
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3.2 F4000
            G39.3 S1
            G0 Z3.2 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END


; object ids of this layer14 end: 82,118
M625
; CHANGE_LAYER
; Z_HEIGHT: 3
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 15/23
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F9000
G1 Z3
G1 E.8 F1800
G1 F1435
G1 X125.359 Y126.079 E.01424
G1 X125.819 Y125.95 E.01424
G1 X125.92 Y125.482 E.01424
G1 X126.397 Y125.471 E.01424
G1 X126.611 Y125.044 E.01424
G1 X127.077 Y125.151 E.01424
G1 X127.39 Y124.79 E.01424
G1 X127.814 Y125.011 E.01424
G1 X127.906 Y124.947 E.00333
G1 X128.207 Y124.739 E.01091
G1 X128.563 Y125.058 E.01424
G1 X129.012 Y124.893 E.01424
G1 X129.277 Y125.29 E.01424
G1 X129.753 Y125.241 E.01424
G1 X129.911 Y125.692 E.01424
G1 X130.384 Y125.763 E.01424
G1 X130.425 Y126.24 E.01424
G1 X130.865 Y126.426 E.01424
G1 X130.787 Y126.897 E.01424
G1 X131.167 Y127.187 E.01424
G1 X130.974 Y127.625 E.01424
G1 X131.27 Y128 E.01424
G1 X130.974 Y128.375 E.01424
G1 X131.167 Y128.813 E.01424
G1 X130.787 Y129.103 E.01424
G1 X130.865 Y129.574 E.01424
G1 X130.425 Y129.76 E.01424
G1 X130.384 Y130.237 E.01424
G1 X129.911 Y130.308 E.01424
G1 X129.753 Y130.759 E.01424
G1 X129.277 Y130.71 E.01424
M73 P87 R2
G1 X129.012 Y131.107 E.01424
G1 X128.563 Y130.942 E.01424
G1 X128.207 Y131.261 E.01424
G1 X127.814 Y130.989 E.01424
G1 X127.39 Y131.21 E.01424
G1 X127.077 Y130.849 E.01424
G1 X126.611 Y130.956 E.01424
G1 X126.397 Y130.529 E.01424
G1 X125.92 Y130.518 E.01424
G1 X125.819 Y130.05 E.01424
G1 X125.359 Y129.921 E.01424
G1 X125.378 Y129.443 E.01424
G1 X124.964 Y129.203 E.01424
G1 X125.101 Y128.745 E.01424
G1 X124.761 Y128.41 E.01424
G1 X125.007 Y128 E.01424
G1 X124.761 Y127.59 E.01424
G1 X125.101 Y127.255 E.01424
G1 X124.964 Y126.797 E.01424
G1 X125.326 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18164
G1 X125.92 Y125.482 E-.18164
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X127.785 Y124.554 Z3.4 F9000
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1435
G1 X127.352 Y124.329 E.01571
G1 X127.378 Y124.156 E.00562
G3 X128.131 Y124.107 I.651 J4.145 E.02431
G1 X128.185 Y124.278 E.00578
G1 X127.835 Y124.52 E.01368
G1 X128.288 Y124.285 F9000
G1 F1435
G1 X128.358 Y124.123 E.00567
G1 X128.525 Y124.138 E.00541
G3 X129.096 Y124.263 I-.409 J3.233 E.01882
G1 X129.104 Y124.441 E.00572
G1 X128.649 Y124.608 E.01558
G1 X128.332 Y124.325 E.01368
G1 X129.257 Y124.554 F9000
G1 F1435
G1 X129.203 Y124.473 E.00314
G1 X129.314 Y124.334 E.00572
G1 X129.534 Y124.416 E.00756
G3 X129.993 Y124.654 I-1.093 J2.673 E.01666
G1 X129.955 Y124.826 E.00567
G1 X129.472 Y124.876 E.01561
G1 X129.291 Y124.604 E.01051
; WIPE_START
G1 F5895.652
G1 X129.203 Y124.473 E-.05989
G1 X129.314 Y124.334 E-.06763
G1 X129.534 Y124.416 E-.08935
G1 X129.993 Y124.654 E-.19666
G1 X129.955 Y124.826 E-.06699
G1 X129.472 Y124.876 E-.18447
G1 X129.333 Y124.668 E-.09502
; WIPE_END
G1 E-.04 F1800
G1 X130.203 Y125.34 Z3.4 F9000
G1 Z3
G1 E.8 F1800
G1 F1435
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.532 J2.019 E.01455
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
G1 X130.796 Y125.971 F9000
G1 F1435
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01378
G1 X131.213 Y126.729 F9000
G1 F1435
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00562
G1 X131.514 Y126.309 E.0033
G1 X131.56 Y126.418 E.00381
G3 X131.745 Y126.92 I-2.696 J1.278 E.01722
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
G1 X131.428 Y127.567 F9000
G1 F1435
G1 X131.624 Y127.123 E.01561
G1 X131.8 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.847 J.869 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
G1 X131.428 Y128.433 F9000
G1 F1435
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.799 Y128.86 I-3.94 J-.123 E.0242
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
G1 X131.213 Y129.271 F9000
G1 F1435
G1 X131.598 Y128.977 E.01561
G1 X131.745 Y129.08 E.00578
G3 X131.465 Y129.781 I-4.028 J-1.202 E.0243
G1 X131.293 Y129.753 E.00562
G1 X131.222 Y129.33 E.01378
G1 X130.796 Y130.029 F9000
G1 F1435
G1 X131.246 Y129.839 E.01571
G1 X131.362 Y129.978 E.00583
G3 X130.922 Y130.584 I-3.582 J-2.14 E.02409
G1 X130.753 Y130.516 E.00583
G1 X130.79 Y130.089 E.01378
G1 X130.166 Y130.767 F9000
G1 F1435
G1 X130.203 Y130.66 E.00363
G1 X130.686 Y130.588 E.01571
G1 X130.767 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.965 J-2.973 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.146 Y130.824 E.01005
G1 X129.741 Y131.152 F9000
G1 F1435
G1 X129.955 Y131.174 E.00694
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.647 J-4.731 E.02418
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00674
G1 X128.81 Y131.451 F9000
G1 F1435
G1 X129.104 Y131.559 E.01005
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.1 J-3.784 E.0242
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.0036
G1 X127.785 Y131.446 F9000
G1 F1435
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.186 E.02431
G1 X127.352 Y131.671 E.00561
G1 X127.732 Y131.474 E.01378
G1 X126.935 Y131.284 F9000
G1 F1435
G1 X127.256 Y131.653 E.01571
G1 X127.159 Y131.806 E.00583
G3 X126.447 Y131.575 I.929 J-4.069 E.02409
G1 X126.459 Y131.394 E.00583
G1 X126.877 Y131.297 E.01379
G1 X126.152 Y130.915 F9000
G1 F1435
G1 X126.37 Y131.352 E.0157
G1 X126.248 Y131.476 E.00562
G3 X125.609 Y131.074 I1.906 J-3.731 E.02431
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
G1 X125.485 Y130.364 F9000
G1 F1435
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.598 J-2.96 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
G1 X124.977 Y129.663 F9000
G1 F1435
G1 X124.958 Y130.147 E.01558
G1 X124.786 Y130.195 E.00572
G3 X124.425 Y129.536 I3.26 J-2.217 E.0242
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
G1 X124.658 Y128.859 F9000
G1 F1435
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G3 X124.154 Y128.594 I3.949 J-1.391 E.02431
G1 X124.31 Y128.516 E.00561
G1 X124.615 Y128.817 E.01378
G1 X124.549 Y128 F9000
G1 F1435
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
G1 X124.658 Y127.141 F9000
G1 F1435
G1 X124.31 Y127.484 E.0157
G1 X124.154 Y127.406 E.00561
G3 X124.339 Y126.674 I5.789 J1.078 E.02429
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
G1 X124.977 Y126.337 F9000
G1 F1435
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.62 J1.557 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
G1 X125.485 Y125.636 F9000
G1 F1435
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.114 J2.414 E.0242
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
G1 X126.152 Y125.085 F9000
G1 F1435
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.524 I2.544 J3.328 E.02431
G1 X126.37 Y124.648 E.00561
G1 X126.179 Y125.031 E.01377
G1 X126.935 Y124.716 F9000
G1 F1435
G1 X126.459 Y124.606 E.01572
G1 X126.447 Y124.425 E.00583
G3 X127.159 Y124.194 I1.64 J3.838 E.02409
G1 X127.256 Y124.347 E.00583
G1 X126.975 Y124.671 E.01378
; WIPE_START
G1 F5895.652
G1 X126.459 Y124.606 E-.19741
G1 X126.447 Y124.425 E-.06891
G1 X126.798 Y124.293 E-.14229
G1 X127.159 Y124.194 E-.14232
G1 X127.256 Y124.347 E-.06891
G1 X127.014 Y124.626 E-.14016
; WIPE_END
G1 E-.04 F1800
G1 X123.724 Y128.385 Z3.4 F9000
G1 Z3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1435
G3 X126.316 Y124.055 I4.269 J-.385 E.16071
G3 X128.33 Y123.727 I1.671 J3.905 E.06138
G3 X123.73 Y128.445 I-.336 J4.274 E.57843
; OBJECT_ID: 118
; WIPE_START
G1 F6364.704
G1 X123.712 Y128 E-.1691
G1 X123.73 Y127.615 E-.14626
G1 X123.781 Y127.234 E-.14628
G1 X123.867 Y126.859 E-.14629
G1 X123.986 Y126.493 E-.14621
G1 X123.992 Y126.479 E-.00586
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X116.36 Y126.509 Z3.4 F9000
G1 X104.382 Y126.557 Z3.4
G1 Z3
G1 E.8 F1800
G1 F1435
G1 X104.363 Y126.079 E.01424
G1 X104.823 Y125.95 E.01424
G1 X104.924 Y125.482 E.01424
G1 X105.402 Y125.471 E.01424
G1 X105.616 Y125.044 E.01424
G1 X106.081 Y125.151 E.01424
G1 X106.394 Y124.79 E.01424
G1 X106.819 Y125.011 E.01424
G1 X106.911 Y124.947 E.00333
G1 X107.212 Y124.739 E.01091
G1 X107.568 Y125.058 E.01424
G1 X108.016 Y124.893 E.01424
G1 X108.282 Y125.29 E.01424
G1 X108.757 Y125.241 E.01424
G1 X108.916 Y125.692 E.01424
G1 X109.389 Y125.763 E.01424
G1 X109.43 Y126.24 E.01424
G1 X109.87 Y126.426 E.01424
G1 X109.792 Y126.897 E.01424
G1 X110.171 Y127.187 E.01424
G1 X109.978 Y127.625 E.01424
G1 X110.274 Y128 E.01424
G1 X109.978 Y128.375 E.01424
G1 X110.171 Y128.813 E.01424
G1 X109.792 Y129.103 E.01424
G1 X109.87 Y129.574 E.01424
G1 X109.43 Y129.76 E.01424
G1 X109.389 Y130.237 E.01424
G1 X108.916 Y130.308 E.01424
G1 X108.757 Y130.759 E.01424
G1 X108.282 Y130.71 E.01424
G1 X108.016 Y131.107 E.01424
G1 X107.568 Y130.942 E.01424
G1 X107.212 Y131.261 E.01424
G1 X106.819 Y130.989 E.01424
G1 X106.394 Y131.21 E.01424
G1 X106.081 Y130.849 E.01424
G1 X105.616 Y130.956 E.01424
G1 X105.402 Y130.529 E.01424
G1 X104.924 Y130.518 E.01424
G1 X104.823 Y130.05 E.01424
G1 X104.363 Y129.921 E.01424
G1 X104.382 Y129.443 E.01424
G1 X103.969 Y129.203 E.01424
G1 X104.106 Y128.745 E.01424
G1 X103.765 Y128.41 E.01424
G1 X104.012 Y128 E.01424
G1 X103.765 Y127.59 E.01424
G1 X104.106 Y127.255 E.01424
G1 X103.969 Y126.797 E.01424
G1 X104.33 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18164
G1 X104.924 Y125.482 E-.18164
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X106.79 Y124.554 Z3.4 F9000
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1435
G1 X106.357 Y124.329 E.01571
G1 X106.383 Y124.156 E.00562
G3 X107.136 Y124.107 I.651 J4.145 E.02431
G1 X107.189 Y124.278 E.00578
G1 X106.839 Y124.52 E.01368
G1 X107.292 Y124.285 F9000
G1 F1435
G1 X107.362 Y124.123 E.00567
G1 X107.53 Y124.138 E.00541
G3 X108.101 Y124.263 I-.409 J3.233 E.01882
G1 X108.108 Y124.441 E.00572
G1 X107.654 Y124.608 E.01558
G1 X107.337 Y124.325 E.01368
G1 X108.262 Y124.554 F9000
G1 F1435
G1 X108.208 Y124.473 E.00314
G1 X108.318 Y124.334 E.00572
G1 X108.538 Y124.416 E.00756
G3 X108.998 Y124.654 I-1.093 J2.673 E.01666
G1 X108.96 Y124.826 E.00567
G1 X108.477 Y124.876 E.01561
G1 X108.295 Y124.604 E.01051
; WIPE_START
G1 F5895.652
G1 X108.208 Y124.473 E-.05989
G1 X108.318 Y124.334 E-.06763
G1 X108.538 Y124.416 E-.08935
G1 X108.998 Y124.654 E-.19666
G1 X108.96 Y124.826 E-.06699
G1 X108.477 Y124.876 E-.18447
G1 X108.338 Y124.668 E-.09502
; WIPE_END
G1 E-.04 F1800
G1 X109.208 Y125.34 Z3.4 F9000
G1 Z3
G1 E.8 F1800
G1 F1435
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.532 J2.019 E.01455
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
G1 X109.8 Y125.971 F9000
G1 F1435
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01378
G1 X110.217 Y126.729 F9000
G1 F1435
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00562
G1 X110.518 Y126.309 E.0033
G1 X110.565 Y126.418 E.00381
G3 X110.749 Y126.92 I-2.696 J1.278 E.01722
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
G1 X110.432 Y127.567 F9000
G1 F1435
G1 X110.629 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.847 J.869 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
G1 X110.432 Y128.433 F9000
G1 F1435
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.94 J-.123 E.0242
G1 X110.628 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
G1 X110.217 Y129.271 F9000
G1 F1435
G1 X110.603 Y128.977 E.01561
G1 X110.749 Y129.08 E.00578
G3 X110.47 Y129.781 I-4.028 J-1.202 E.0243
G1 X110.297 Y129.753 E.00562
G1 X110.227 Y129.33 E.01378
G1 X109.8 Y130.029 F9000
G1 F1435
G1 X110.25 Y129.839 E.01571
G1 X110.366 Y129.978 E.00583
G3 X109.926 Y130.584 I-3.582 J-2.14 E.02409
G1 X109.758 Y130.516 E.00583
G1 X109.795 Y130.089 E.01378
G1 X109.17 Y130.767 F9000
G1 F1435
G1 X109.208 Y130.66 E.00363
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.965 J-2.973 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.15 Y130.824 E.01005
G1 X108.745 Y131.152 F9000
G1 F1435
G1 X108.96 Y131.174 E.00694
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.647 J-4.731 E.02418
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.685 Y131.145 E.00674
G1 X107.815 Y131.451 F9000
G1 F1435
G1 X108.108 Y131.559 E.01005
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.1 J-3.784 E.0242
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.759 Y131.43 E.0036
G1 X106.79 Y131.446 F9000
G1 F1435
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.186 E.02431
G1 X106.357 Y131.671 E.00561
G1 X106.737 Y131.474 E.01378
G1 X105.94 Y131.284 F9000
G1 F1435
G1 X106.26 Y131.653 E.01571
G1 X106.163 Y131.806 E.00583
G3 X105.452 Y131.575 I.929 J-4.069 E.02409
G1 X105.464 Y131.394 E.00583
G1 X105.881 Y131.297 E.01379
G1 X105.157 Y130.915 F9000
G1 F1435
G1 X105.375 Y131.352 E.0157
G1 X105.252 Y131.476 E.00562
G3 X104.614 Y131.074 I1.906 J-3.731 E.02431
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
G1 X104.49 Y130.364 F9000
G1 F1435
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.598 J-2.96 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
G1 X103.981 Y129.663 F9000
G1 F1435
G1 X103.962 Y130.147 E.01558
G1 X103.791 Y130.195 E.00572
G3 X103.429 Y129.536 I3.26 J-2.217 E.0242
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
G1 X103.662 Y128.859 F9000
G1 F1435
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G3 X103.158 Y128.594 I3.949 J-1.391 E.02431
G1 X103.314 Y128.516 E.00561
G1 X103.62 Y128.817 E.01378
G1 X103.554 Y128 F9000
G1 F1435
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
G1 X103.662 Y127.141 F9000
G1 F1435
G1 X103.314 Y127.484 E.0157
G1 X103.158 Y127.406 E.00561
G3 X103.344 Y126.674 I5.789 J1.078 E.02429
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
G1 X103.981 Y126.337 F9000
G1 F1435
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.62 J1.557 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
M73 P88 R2
G1 X104.49 Y125.636 F9000
G1 F1435
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.114 J2.414 E.0242
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
G1 X105.157 Y125.085 F9000
G1 F1435
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.524 I2.544 J3.328 E.02431
G1 X105.375 Y124.648 E.00561
G1 X105.183 Y125.031 E.01377
G1 X105.94 Y124.716 F9000
G1 F1435
G1 X105.464 Y124.606 E.01572
G1 X105.452 Y124.425 E.00583
G3 X106.163 Y124.194 I1.64 J3.838 E.02409
G1 X106.26 Y124.347 E.00583
G1 X105.979 Y124.671 E.01378
; WIPE_START
G1 F5895.652
G1 X105.464 Y124.606 E-.19741
G1 X105.452 Y124.425 E-.06891
G1 X105.802 Y124.293 E-.14229
G1 X106.163 Y124.194 E-.14232
G1 X106.26 Y124.347 E-.06891
G1 X106.018 Y124.626 E-.14016
; WIPE_END
G1 E-.04 F1800
G1 X102.729 Y128.385 Z3.4 F9000
G1 Z3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1435
G3 X105.321 Y124.055 I4.269 J-.385 E.16071
G3 X107.335 Y123.727 I1.671 J3.905 E.06138
G3 X102.735 Y128.445 I-.336 J4.274 E.57843
; WIPE_START
G1 F6364.704
G1 X102.717 Y128 E-.1691
G1 X102.734 Y127.615 E-.14626
G1 X102.786 Y127.234 E-.14628
G1 X102.872 Y126.859 E-.14629
G1 X102.99 Y126.493 E-.14621
G1 X102.997 Y126.479 E-.00586
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3.4 I1.217 J0 P1  F9000
; stop printing object, unique label id: 118
M625
; object ids of layer 15 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.4
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3.4 F4000
            G39.3 S1
            G0 Z3.4 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END


; object ids of this layer15 end: 82,118
M625
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 16/23
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F9000
G1 Z3.2
G1 E.8 F1800
G1 F1435
G1 X125.359 Y126.079 E.01424
G1 X125.819 Y125.95 E.01424
G1 X125.92 Y125.482 E.01424
G1 X126.397 Y125.471 E.01424
G1 X126.611 Y125.044 E.01424
G1 X127.077 Y125.151 E.01424
G1 X127.39 Y124.79 E.01424
G1 X127.814 Y125.011 E.01424
G1 X127.927 Y124.933 E.00408
G1 X128.207 Y124.739 E.01016
G1 X128.563 Y125.058 E.01424
G1 X129.012 Y124.893 E.01424
G1 X129.277 Y125.29 E.01424
G1 X129.753 Y125.241 E.01424
G1 X129.911 Y125.692 E.01424
G1 X130.384 Y125.763 E.01424
G1 X130.425 Y126.24 E.01424
G1 X130.865 Y126.426 E.01424
G1 X130.787 Y126.897 E.01424
G1 X131.167 Y127.187 E.01424
G1 X130.974 Y127.625 E.01424
G1 X131.27 Y128 E.01424
G1 X130.974 Y128.375 E.01424
G1 X131.167 Y128.813 E.01424
G1 X130.787 Y129.103 E.01424
G1 X130.865 Y129.574 E.01424
G1 X130.425 Y129.76 E.01424
G1 X130.384 Y130.237 E.01424
G1 X129.911 Y130.308 E.01424
G1 X129.753 Y130.759 E.01424
G1 X129.277 Y130.71 E.01424
G1 X129.012 Y131.107 E.01424
G1 X128.563 Y130.942 E.01424
G1 X128.207 Y131.261 E.01424
G1 X127.814 Y130.989 E.01424
G1 X127.39 Y131.21 E.01424
G1 X127.077 Y130.849 E.01424
G1 X126.611 Y130.956 E.01424
G1 X126.397 Y130.529 E.01424
G1 X125.92 Y130.518 E.01424
G1 X125.819 Y130.05 E.01424
G1 X125.359 Y129.921 E.01424
G1 X125.378 Y129.443 E.01424
G1 X124.964 Y129.203 E.01424
G1 X125.101 Y128.745 E.01424
G1 X124.761 Y128.41 E.01424
G1 X125.007 Y128 E.01424
G1 X124.761 Y127.59 E.01424
G1 X125.101 Y127.255 E.01424
G1 X124.964 Y126.797 E.01424
G1 X125.326 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18164
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X127.785 Y124.554 Z3.6 F9000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1435
G1 X127.352 Y124.329 E.0157
G1 X127.378 Y124.156 E.00561
G3 X128.131 Y124.107 I.651 J4.134 E.02431
G1 X128.185 Y124.278 E.00578
G1 X127.835 Y124.52 E.01368
G1 X128.288 Y124.285 F9000
G1 F1435
G1 X128.358 Y124.123 E.00567
G1 X128.525 Y124.138 E.00541
G3 X129.096 Y124.263 I-.409 J3.235 E.01882
G1 X129.104 Y124.441 E.00572
G1 X128.649 Y124.608 E.01558
G1 X128.332 Y124.325 E.01368
G1 X129.276 Y124.581 F9000
G1 F1435
G1 X129.203 Y124.473 E.00419
G1 X129.314 Y124.334 E.00572
G1 X129.534 Y124.416 E.00756
G3 X129.993 Y124.654 I-1.093 J2.673 E.01666
G1 X129.955 Y124.826 E.00567
G1 X129.472 Y124.876 E.01561
G1 X129.309 Y124.631 E.00946
; WIPE_START
G1 F5895.652
G1 X129.203 Y124.473 E-.07227
G1 X129.314 Y124.334 E-.06763
G1 X129.534 Y124.416 E-.08937
G1 X129.993 Y124.654 E-.19665
G1 X129.955 Y124.826 E-.06699
G1 X129.472 Y124.876 E-.18448
G1 X129.352 Y124.695 E-.08262
; WIPE_END
G1 E-.04 F1800
G1 X130.203 Y125.34 Z3.6 F9000
G1 Z3.2
G1 E.8 F1800
G1 F1435
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.532 J2.019 E.01456
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
G1 X130.796 Y125.971 F9000
G1 F1435
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01378
G1 X131.213 Y126.729 F9000
G1 F1435
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00562
G1 X131.514 Y126.309 E.0033
G3 X131.745 Y126.92 I-4.01 J1.869 E.02102
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
G1 X131.428 Y127.567 F9000
G1 F1435
G1 X131.624 Y127.123 E.01561
G1 X131.8 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.847 J.869 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
G1 X131.428 Y128.433 F9000
G1 F1435
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.8 Y128.86 I-3.944 J-.123 E.0242
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
G1 X131.212 Y129.271 F9000
G1 F1435
G1 X131.598 Y128.977 E.01561
G1 X131.745 Y129.08 E.00578
G3 X131.465 Y129.781 I-4.03 J-1.203 E.02431
G1 X131.293 Y129.753 E.00562
G1 X131.222 Y129.33 E.01378
G1 X130.796 Y130.029 F9000
G1 F1435
G1 X131.246 Y129.839 E.01571
G1 X131.362 Y129.978 E.00583
G3 X130.922 Y130.584 I-3.582 J-2.14 E.02409
G1 X130.753 Y130.516 E.00583
G1 X130.79 Y130.089 E.01378
G1 X130.177 Y130.736 F9000
G1 F1435
G1 X130.203 Y130.66 E.00256
G1 X130.686 Y130.588 E.01571
G1 X130.767 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.966 J-2.973 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.157 Y130.792 E.01112
G1 X129.741 Y131.152 F9000
G1 F1435
G1 X129.955 Y131.174 E.00693
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.014 J-3.387 E.0242
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00675
G1 X128.81 Y131.451 F9000
G1 F1435
G1 X129.104 Y131.559 E.01005
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.101 J-3.786 E.0242
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.0036
G1 X127.785 Y131.446 F9000
G1 F1435
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.196 E.02431
G1 X127.352 Y131.671 E.00562
G1 X127.732 Y131.474 E.01378
G1 X126.935 Y131.284 F9000
G1 F1435
G1 X127.256 Y131.653 E.01571
G1 X127.159 Y131.806 E.00583
G3 X126.447 Y131.575 I.929 J-4.068 E.02409
G1 X126.459 Y131.394 E.00583
G1 X126.877 Y131.297 E.01379
G1 X126.152 Y130.915 F9000
G1 F1435
G1 X126.37 Y131.352 E.0157
G1 X126.248 Y131.476 E.00561
G3 X125.609 Y131.074 I1.901 J-3.724 E.02431
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
G1 X125.485 Y130.364 F9000
G1 F1435
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.599 J-2.961 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
G1 X124.977 Y129.663 F9000
G1 F1435
G1 X124.958 Y130.147 E.01558
G1 X124.786 Y130.195 E.00572
G3 X124.425 Y129.536 I3.261 J-2.217 E.0242
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
G1 X124.658 Y128.859 F9000
G1 F1435
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G1 X124.307 Y129.226 E.00337
G3 X124.154 Y128.594 I3.809 J-1.257 E.02093
G1 X124.31 Y128.516 E.00561
G1 X124.615 Y128.817 E.01378
G1 X124.549 Y128 F9000
G1 F1435
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
G1 X124.658 Y127.141 F9000
G1 F1435
G1 X124.31 Y127.484 E.01571
G1 X124.154 Y127.406 E.00562
G3 X124.339 Y126.674 I4.143 J.661 E.02431
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
G1 X124.977 Y126.337 F9000
G1 F1435
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.619 J1.557 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
G1 X125.485 Y125.636 F9000
G1 F1435
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.114 J2.414 E.0242
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
G1 X126.152 Y125.085 F9000
G1 F1435
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.523 I2.544 J3.328 E.02431
G1 X126.371 Y124.648 E.00562
G1 X126.179 Y125.031 E.01378
G1 X126.935 Y124.716 F9000
G1 F1435
G1 X126.459 Y124.606 E.01571
G1 X126.447 Y124.425 E.00583
G3 X127.159 Y124.194 I1.64 J3.836 E.02409
G1 X127.256 Y124.347 E.00583
G1 X126.975 Y124.671 E.01378
; WIPE_START
G1 F5895.652
G1 X126.459 Y124.606 E-.19741
G1 X126.447 Y124.425 E-.06891
G1 X126.798 Y124.293 E-.14227
G1 X127.159 Y124.194 E-.14233
G1 X127.256 Y124.347 E-.06891
G1 X127.014 Y124.626 E-.14017
; WIPE_END
G1 E-.04 F1800
G1 X123.734 Y128.384 Z3.6 F9000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1435
G3 X128.362 Y123.73 I4.268 J-.384 E.22271
G3 X132.07 Y126.653 I-.344 J4.25 E.14905
G3 X123.74 Y128.444 I-4.068 J1.347 E.42861
; OBJECT_ID: 118
; WIPE_START
G1 F6364.704
G1 X123.712 Y128 E-.16897
G1 X123.73 Y127.615 E-.14626
G1 X123.781 Y127.234 E-.14628
G1 X123.867 Y126.859 E-.14628
G1 X123.986 Y126.493 E-.14627
G1 X123.992 Y126.478 E-.00595
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X116.36 Y126.509 Z3.6 F9000
G1 X104.382 Y126.557 Z3.6
G1 Z3.2
G1 E.8 F1800
G1 F1435
G1 X104.363 Y126.079 E.01424
G1 X104.823 Y125.95 E.01424
G1 X104.924 Y125.482 E.01424
G1 X105.402 Y125.471 E.01424
G1 X105.616 Y125.044 E.01424
G1 X106.081 Y125.151 E.01424
G1 X106.394 Y124.79 E.01424
G1 X106.819 Y125.011 E.01424
G1 X106.931 Y124.933 E.00408
G1 X107.212 Y124.739 E.01016
G1 X107.568 Y125.058 E.01424
G1 X108.016 Y124.893 E.01424
G1 X108.282 Y125.29 E.01424
G1 X108.757 Y125.241 E.01424
G1 X108.916 Y125.692 E.01424
G1 X109.389 Y125.763 E.01424
G1 X109.43 Y126.24 E.01424
G1 X109.87 Y126.426 E.01424
G1 X109.792 Y126.897 E.01424
G1 X110.171 Y127.187 E.01424
G1 X109.978 Y127.625 E.01424
G1 X110.274 Y128 E.01424
G1 X109.978 Y128.375 E.01424
G1 X110.171 Y128.813 E.01424
G1 X109.792 Y129.103 E.01424
G1 X109.87 Y129.574 E.01424
G1 X109.43 Y129.76 E.01424
G1 X109.389 Y130.237 E.01424
G1 X108.916 Y130.308 E.01424
G1 X108.757 Y130.759 E.01424
G1 X108.282 Y130.71 E.01424
G1 X108.016 Y131.107 E.01424
G1 X107.568 Y130.942 E.01424
G1 X107.212 Y131.261 E.01424
G1 X106.819 Y130.989 E.01424
G1 X106.394 Y131.21 E.01424
G1 X106.081 Y130.849 E.01424
G1 X105.616 Y130.956 E.01424
G1 X105.402 Y130.529 E.01424
G1 X104.924 Y130.518 E.01424
G1 X104.823 Y130.05 E.01424
G1 X104.363 Y129.921 E.01424
G1 X104.382 Y129.443 E.01424
G1 X103.969 Y129.203 E.01424
G1 X104.106 Y128.745 E.01424
G1 X103.765 Y128.41 E.01424
G1 X104.012 Y128 E.01424
G1 X103.765 Y127.59 E.01424
G1 X104.106 Y127.255 E.01424
G1 X103.969 Y126.797 E.01424
G1 X104.33 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18164
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X106.79 Y124.554 Z3.6 F9000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1435
G1 X106.357 Y124.329 E.0157
G1 X106.383 Y124.156 E.00561
G3 X107.136 Y124.107 I.651 J4.134 E.02431
G1 X107.189 Y124.278 E.00578
G1 X106.839 Y124.52 E.01368
G1 X107.292 Y124.285 F9000
G1 F1435
G1 X107.362 Y124.123 E.00567
G1 X107.53 Y124.138 E.00541
G3 X108.101 Y124.263 I-.409 J3.235 E.01882
G1 X108.108 Y124.441 E.00572
G1 X107.654 Y124.608 E.01558
G1 X107.337 Y124.325 E.01368
G1 X108.28 Y124.581 F9000
G1 F1435
G1 X108.208 Y124.473 E.00419
G1 X108.318 Y124.334 E.00572
G1 X108.538 Y124.416 E.00756
G3 X108.998 Y124.654 I-1.093 J2.673 E.01666
G1 X108.96 Y124.826 E.00567
G1 X108.477 Y124.876 E.01561
G1 X108.313 Y124.631 E.00946
; WIPE_START
G1 F5895.652
G1 X108.208 Y124.473 E-.07227
G1 X108.318 Y124.334 E-.06763
G1 X108.538 Y124.416 E-.08937
G1 X108.998 Y124.654 E-.19665
G1 X108.96 Y124.826 E-.06699
G1 X108.477 Y124.876 E-.18448
G1 X108.356 Y124.695 E-.08262
; WIPE_END
G1 E-.04 F1800
G1 X109.208 Y125.34 Z3.6 F9000
G1 Z3.2
G1 E.8 F1800
G1 F1435
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.532 J2.019 E.01456
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
G1 X109.8 Y125.971 F9000
G1 F1435
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01378
G1 X110.217 Y126.729 F9000
M73 P89 R2
G1 F1435
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00562
G1 X110.518 Y126.309 E.0033
G3 X110.749 Y126.92 I-4.01 J1.869 E.02102
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
G1 X110.432 Y127.567 F9000
G1 F1435
G1 X110.629 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.847 J.869 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
G1 X110.432 Y128.433 F9000
G1 F1435
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.944 J-.123 E.0242
G1 X110.629 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
G1 X110.217 Y129.271 F9000
G1 F1435
G1 X110.603 Y128.977 E.01561
G1 X110.749 Y129.08 E.00578
G3 X110.469 Y129.781 I-4.03 J-1.203 E.02431
G1 X110.297 Y129.753 E.00562
G1 X110.227 Y129.33 E.01378
G1 X109.8 Y130.029 F9000
G1 F1435
G1 X110.25 Y129.839 E.01571
G1 X110.366 Y129.978 E.00583
G3 X109.926 Y130.584 I-3.582 J-2.14 E.02409
G1 X109.758 Y130.516 E.00583
G1 X109.795 Y130.089 E.01378
G1 X109.181 Y130.736 F9000
G1 F1435
G1 X109.208 Y130.66 E.00256
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.966 J-2.973 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.161 Y130.792 E.01112
G1 X108.745 Y131.152 F9000
G1 F1435
G1 X108.96 Y131.174 E.00693
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.014 J-3.387 E.0242
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.686 Y131.145 E.00675
G1 X107.815 Y131.451 F9000
G1 F1435
G1 X108.108 Y131.559 E.01005
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.101 J-3.786 E.0242
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.759 Y131.43 E.0036
G1 X106.79 Y131.446 F9000
G1 F1435
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.196 E.02431
G1 X106.356 Y131.671 E.00562
G1 X106.737 Y131.474 E.01378
G1 X105.94 Y131.284 F9000
G1 F1435
G1 X106.26 Y131.653 E.01571
G1 X106.163 Y131.806 E.00583
G3 X105.452 Y131.575 I.929 J-4.068 E.02409
G1 X105.464 Y131.394 E.00583
G1 X105.881 Y131.297 E.01379
G1 X105.157 Y130.915 F9000
G1 F1435
G1 X105.375 Y131.352 E.0157
G1 X105.252 Y131.476 E.00561
G3 X104.614 Y131.074 I1.901 J-3.724 E.02431
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
G1 X104.49 Y130.364 F9000
G1 F1435
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.599 J-2.961 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
G1 X103.981 Y129.663 F9000
G1 F1435
G1 X103.962 Y130.147 E.01558
G1 X103.791 Y130.195 E.00572
G3 X103.429 Y129.536 I3.261 J-2.217 E.0242
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
G1 X103.662 Y128.859 F9000
G1 F1435
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G1 X103.311 Y129.226 E.00337
G3 X103.158 Y128.594 I3.809 J-1.257 E.02093
G1 X103.314 Y128.516 E.00561
G1 X103.62 Y128.817 E.01378
G1 X103.554 Y128 F9000
G1 F1435
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
G1 X103.662 Y127.141 F9000
G1 F1435
G1 X103.314 Y127.484 E.01571
G1 X103.158 Y127.406 E.00562
G3 X103.344 Y126.674 I4.143 J.661 E.02431
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
G1 X103.981 Y126.337 F9000
G1 F1435
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.619 J1.557 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
G1 X104.49 Y125.636 F9000
G1 F1435
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.114 J2.414 E.0242
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
G1 X105.157 Y125.085 F9000
G1 F1435
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.523 I2.544 J3.328 E.02431
G1 X105.375 Y124.648 E.00562
G1 X105.183 Y125.031 E.01378
G1 X105.94 Y124.716 F9000
G1 F1435
G1 X105.464 Y124.606 E.01571
G1 X105.452 Y124.425 E.00583
G3 X106.163 Y124.194 I1.64 J3.836 E.02409
G1 X106.26 Y124.347 E.00583
G1 X105.979 Y124.671 E.01378
; WIPE_START
G1 F5895.652
G1 X105.464 Y124.606 E-.19741
G1 X105.452 Y124.425 E-.06891
G1 X105.802 Y124.293 E-.14227
G1 X106.163 Y124.194 E-.14233
G1 X106.26 Y124.347 E-.06891
G1 X106.018 Y124.626 E-.14017
; WIPE_END
G1 E-.04 F1800
G1 X102.738 Y128.384 Z3.6 F9000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1435
G3 X107.367 Y123.73 I4.268 J-.384 E.22271
G3 X111.075 Y126.653 I-.344 J4.25 E.14905
G3 X102.744 Y128.444 I-4.068 J1.347 E.42861
; WIPE_START
G1 F6364.704
G1 X102.717 Y128 E-.16897
G1 X102.734 Y127.615 E-.14626
G1 X102.786 Y127.234 E-.14628
G1 X102.872 Y126.859 E-.14628
G1 X102.99 Y126.493 E-.14627
G1 X102.997 Y126.478 E-.00595
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3.6 I1.217 J0 P1  F9000
; stop printing object, unique label id: 118
M625
; object ids of layer 16 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.6
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3.6 F4000
            G39.3 S1
            G0 Z3.6 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END


; object ids of this layer16 end: 82,118
M625
; CHANGE_LAYER
; Z_HEIGHT: 3.4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 17/23
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F9000
G1 Z3.4
G1 E.8 F1800
G1 F1462
G1 X125.359 Y126.079 E.01424
G1 X125.819 Y125.95 E.01424
G1 X125.92 Y125.482 E.01424
G1 X126.397 Y125.471 E.01424
G1 X126.611 Y125.044 E.01424
G1 X127.077 Y125.151 E.01424
G1 X127.39 Y124.79 E.01424
G1 X127.814 Y125.011 E.01424
G1 X127.947 Y124.919 E.00483
G1 X128.207 Y124.739 E.00941
G1 X128.563 Y125.058 E.01424
G1 X129.012 Y124.893 E.01424
G1 X129.277 Y125.29 E.01424
G1 X129.753 Y125.241 E.01424
G1 X129.911 Y125.692 E.01424
G1 X130.384 Y125.763 E.01424
G1 X130.425 Y126.24 E.01424
G1 X130.865 Y126.426 E.01424
G1 X130.787 Y126.897 E.01424
G1 X131.167 Y127.187 E.01424
G1 X130.974 Y127.625 E.01424
G1 X131.27 Y128 E.01424
G1 X130.974 Y128.375 E.01424
G1 X131.167 Y128.813 E.01424
G1 X130.787 Y129.103 E.01424
G1 X130.865 Y129.574 E.01424
G1 X130.425 Y129.76 E.01424
G1 X130.384 Y130.237 E.01424
G1 X129.911 Y130.308 E.01424
G1 X129.753 Y130.759 E.01424
G1 X129.277 Y130.71 E.01424
G1 X129.012 Y131.107 E.01424
G1 X128.563 Y130.942 E.01424
G1 X128.207 Y131.261 E.01424
G1 X127.814 Y130.989 E.01424
G1 X127.39 Y131.21 E.01424
G1 X127.077 Y130.849 E.01424
G1 X126.611 Y130.956 E.01424
G1 X126.397 Y130.529 E.01424
G1 X125.92 Y130.518 E.01424
G1 X125.819 Y130.05 E.01424
G1 X125.359 Y129.921 E.01424
G1 X125.378 Y129.443 E.01424
G1 X124.964 Y129.203 E.01424
G1 X125.101 Y128.745 E.01424
G1 X124.761 Y128.409 E.01424
G1 X125.007 Y128 E.01424
G1 X124.761 Y127.59 E.01424
G1 X125.101 Y127.255 E.01424
G1 X124.964 Y126.797 E.01424
G1 X125.326 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X125.359 Y126.079 E-.19337
G1 X125.819 Y125.95 E-.18163
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X127.785 Y124.554 Z3.8 F9000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1462
G1 X127.352 Y124.329 E.01571
G1 X127.378 Y124.156 E.00562
G3 X128.131 Y124.107 I.652 J4.148 E.02431
G1 X128.185 Y124.278 E.00578
G1 X127.835 Y124.52 E.01368
G1 X128.288 Y124.285 F9000
G1 F1462
G1 X128.358 Y124.123 E.00567
G1 X128.525 Y124.138 E.00541
G3 X129.096 Y124.263 I-.409 J3.234 E.01882
G1 X129.104 Y124.441 E.00572
G1 X128.649 Y124.608 E.01558
G1 X128.332 Y124.325 E.01368
; WIPE_START
G1 F5895.652
G1 X128.358 Y124.123 E-.07726
G1 X128.525 Y124.138 E-.06391
G1 X128.869 Y124.2 E-.1329
G1 X129.096 Y124.263 E-.08939
G1 X129.104 Y124.441 E-.06763
G1 X128.649 Y124.608 E-.18409
G1 X128.365 Y124.354 E-.14481
; WIPE_END
G1 E-.04 F1800
G1 X129.293 Y124.608 Z3.8 F9000
G1 Z3.4
G1 E.8 F1800
G1 F1462
G1 X129.203 Y124.473 E.00521
G1 X129.314 Y124.334 E.00572
G1 X129.534 Y124.416 E.00757
G3 X129.993 Y124.654 I-1.092 J2.67 E.01666
G1 X129.955 Y124.826 E.00567
G1 X129.472 Y124.876 E.01561
G1 X129.327 Y124.658 E.00844
; WIPE_START
G1 F5895.652
G1 X129.203 Y124.473 E-.08436
G1 X129.314 Y124.334 E-.06763
G1 X129.534 Y124.416 E-.0894
G1 X129.993 Y124.654 E-.19661
G1 X129.955 Y124.826 E-.06699
G1 X129.472 Y124.876 E-.18448
G1 X129.369 Y124.722 E-.07053
; WIPE_END
G1 E-.04 F1800
G1 X130.203 Y125.34 Z3.8 F9000
G1 Z3.4
G1 E.8 F1800
G1 F1462
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.532 J2.019 E.01456
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
G1 X130.796 Y125.971 F9000
G1 F1462
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01378
G1 X131.213 Y126.729 F9000
G1 F1462
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00562
G1 X131.514 Y126.309 E.0033
G3 X131.745 Y126.92 I-4.17 J1.929 E.02102
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
G1 X131.428 Y127.567 F9000
G1 F1462
G1 X131.624 Y127.123 E.01561
G1 X131.8 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.847 J.869 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
G1 X131.428 Y128.433 F9000
G1 F1462
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.799 Y128.86 I-3.941 J-.123 E.0242
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
G1 X131.213 Y129.271 F9000
G1 F1462
G1 X131.598 Y128.977 E.01561
G1 X131.745 Y129.08 E.00578
G1 X131.703 Y129.211 E.00441
G3 X131.465 Y129.781 I-3.821 J-1.257 E.01989
G1 X131.293 Y129.753 E.00562
G1 X131.222 Y129.33 E.01378
G1 X130.796 Y130.029 F9000
G1 F1462
G1 X131.246 Y129.839 E.01571
G1 X131.362 Y129.978 E.00583
G3 X130.922 Y130.584 I-3.583 J-2.141 E.02409
G1 X130.753 Y130.516 E.00583
G1 X130.79 Y130.089 E.01379
G1 X130.187 Y130.705 F9000
G1 F1462
G1 X130.203 Y130.66 E.00151
G1 X130.686 Y130.588 E.01571
G1 X130.767 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.958 J-2.963 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.168 Y130.761 E.01217
G1 X129.741 Y131.152 F9000
G1 F1462
G1 X129.955 Y131.174 E.00694
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.014 J-3.389 E.0242
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00674
G1 X128.81 Y131.451 F9000
G1 F1462
G1 X129.104 Y131.559 E.01005
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.101 J-3.784 E.0242
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.0036
G1 X127.785 Y131.446 F9000
G1 F1462
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.196 E.02431
G1 X127.352 Y131.671 E.00562
G1 X127.732 Y131.474 E.01378
G1 X126.935 Y131.284 F9000
G1 F1462
G1 X127.256 Y131.653 E.01572
G1 X127.159 Y131.806 E.00583
G3 X126.447 Y131.575 I.929 J-4.07 E.02409
G1 X126.459 Y131.394 E.00583
G1 X126.877 Y131.297 E.01379
G1 X126.152 Y130.915 F9000
G1 F1462
G1 X126.37 Y131.352 E.0157
G1 X126.248 Y131.476 E.00562
G3 X125.609 Y131.074 I1.906 J-3.731 E.02431
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
G1 X125.485 Y130.364 F9000
G1 F1462
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.599 J-2.961 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
G1 X124.977 Y129.663 F9000
G1 F1462
G1 X124.958 Y130.147 E.01558
G1 X124.786 Y130.195 E.00572
G3 X124.425 Y129.536 I3.26 J-2.216 E.0242
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
G1 X124.658 Y128.859 F9000
G1 F1462
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G3 X124.154 Y128.594 I3.954 J-1.392 E.02431
G1 X124.31 Y128.516 E.00562
G1 X124.615 Y128.817 E.01378
G1 X124.549 Y128 F9000
G1 F1462
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
G1 X124.658 Y127.141 F9000
G1 F1462
G1 X124.31 Y127.484 E.01571
G1 X124.154 Y127.406 E.00562
G3 X124.339 Y126.674 I4.137 J.659 E.02431
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
G1 X124.977 Y126.337 F9000
G1 F1462
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.619 J1.557 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
G1 X125.485 Y125.636 F9000
G1 F1462
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.114 J2.414 E.0242
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
G1 X126.152 Y125.085 F9000
G1 F1462
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.523 I2.548 J3.335 E.02431
G1 X126.371 Y124.648 E.00562
G1 X126.179 Y125.031 E.01378
G1 X126.935 Y124.716 F9000
G1 F1462
G1 X126.459 Y124.606 E.01571
G1 X126.447 Y124.425 E.00583
G3 X127.159 Y124.194 I1.64 J3.836 E.02409
G1 X127.256 Y124.347 E.00583
G1 X126.975 Y124.671 E.01378
; WIPE_START
G1 F5895.652
G1 X126.459 Y124.606 E-.1974
G1 X126.447 Y124.425 E-.06891
G1 X126.798 Y124.293 E-.14224
G1 X127.159 Y124.194 E-.14234
G1 X127.256 Y124.347 E-.06891
G1 X127.014 Y124.626 E-.14019
; WIPE_END
G1 E-.04 F1800
G1 X123.741 Y128.383 Z3.8 F9000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1462
G3 X128.394 Y123.732 I4.265 J-.386 E.22348
G3 X132.075 Y129.332 I-.383 J4.261 E.22931
G3 X123.747 Y128.443 I-4.069 J-1.334 E.34705
; OBJECT_ID: 118
; WIPE_START
G1 F6364.704
G1 X123.712 Y128 E-.16888
G1 X123.73 Y127.615 E-.14626
G1 X123.781 Y127.234 E-.14628
G1 X123.867 Y126.859 E-.14628
G1 X123.986 Y126.493 E-.14626
G1 X123.992 Y126.478 E-.00604
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X116.36 Y126.509 Z3.8 F9000
G1 X104.382 Y126.557 Z3.8
G1 Z3.4
G1 E.8 F1800
G1 F1462
G1 X104.363 Y126.079 E.01424
G1 X104.823 Y125.95 E.01424
G1 X104.924 Y125.482 E.01424
G1 X105.402 Y125.471 E.01424
G1 X105.616 Y125.044 E.01424
G1 X106.081 Y125.151 E.01424
G1 X106.394 Y124.79 E.01424
G1 X106.819 Y125.011 E.01424
G1 X106.952 Y124.919 E.00483
G1 X107.212 Y124.739 E.00941
G1 X107.568 Y125.058 E.01424
G1 X108.016 Y124.893 E.01424
G1 X108.282 Y125.29 E.01424
G1 X108.757 Y125.241 E.01424
G1 X108.916 Y125.692 E.01424
G1 X109.389 Y125.763 E.01424
G1 X109.43 Y126.24 E.01424
G1 X109.87 Y126.426 E.01424
G1 X109.792 Y126.897 E.01424
G1 X110.171 Y127.187 E.01424
G1 X109.978 Y127.625 E.01424
G1 X110.274 Y128 E.01424
G1 X109.978 Y128.375 E.01424
G1 X110.171 Y128.813 E.01424
G1 X109.792 Y129.103 E.01424
G1 X109.87 Y129.574 E.01424
G1 X109.43 Y129.76 E.01424
G1 X109.389 Y130.237 E.01424
G1 X108.916 Y130.308 E.01424
G1 X108.757 Y130.759 E.01424
G1 X108.282 Y130.71 E.01424
G1 X108.016 Y131.107 E.01424
G1 X107.568 Y130.942 E.01424
G1 X107.212 Y131.261 E.01424
G1 X106.819 Y130.989 E.01424
G1 X106.394 Y131.21 E.01424
G1 X106.081 Y130.849 E.01424
G1 X105.616 Y130.956 E.01424
G1 X105.402 Y130.529 E.01424
G1 X104.924 Y130.518 E.01424
M73 P90 R2
G1 X104.823 Y130.05 E.01424
G1 X104.363 Y129.921 E.01424
G1 X104.382 Y129.443 E.01424
G1 X103.969 Y129.203 E.01424
G1 X104.106 Y128.745 E.01424
G1 X103.765 Y128.409 E.01424
G1 X104.012 Y128 E.01424
G1 X103.765 Y127.59 E.01424
G1 X104.106 Y127.255 E.01424
G1 X103.969 Y126.797 E.01424
G1 X104.33 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X104.363 Y126.079 E-.19337
G1 X104.823 Y125.95 E-.18163
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X106.79 Y124.554 Z3.8 F9000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1462
G1 X106.356 Y124.329 E.01571
G1 X106.383 Y124.156 E.00562
G3 X107.136 Y124.107 I.652 J4.148 E.02431
G1 X107.189 Y124.278 E.00578
G1 X106.839 Y124.52 E.01368
G1 X107.292 Y124.285 F9000
G1 F1462
G1 X107.362 Y124.123 E.00567
G1 X107.53 Y124.138 E.00541
G3 X108.101 Y124.263 I-.409 J3.234 E.01882
G1 X108.108 Y124.441 E.00572
G1 X107.654 Y124.608 E.01558
G1 X107.337 Y124.325 E.01368
; WIPE_START
G1 F5895.652
G1 X107.362 Y124.123 E-.07726
G1 X107.53 Y124.138 E-.06391
G1 X107.874 Y124.2 E-.1329
G1 X108.101 Y124.263 E-.08939
G1 X108.108 Y124.441 E-.06763
G1 X107.654 Y124.608 E-.18409
G1 X107.37 Y124.354 E-.14481
; WIPE_END
G1 E-.04 F1800
G1 X108.298 Y124.608 Z3.8 F9000
M73 P90 R1
G1 Z3.4
G1 E.8 F1800
G1 F1462
G1 X108.208 Y124.473 E.00521
G1 X108.318 Y124.334 E.00572
G1 X108.539 Y124.416 E.00757
G3 X108.998 Y124.654 I-1.092 J2.67 E.01666
G1 X108.96 Y124.826 E.00567
G1 X108.477 Y124.876 E.01561
G1 X108.331 Y124.658 E.00844
; WIPE_START
G1 F5895.652
G1 X108.208 Y124.473 E-.08436
G1 X108.318 Y124.334 E-.06763
G1 X108.539 Y124.416 E-.0894
G1 X108.998 Y124.654 E-.19661
G1 X108.96 Y124.826 E-.06699
G1 X108.477 Y124.876 E-.18448
G1 X108.374 Y124.722 E-.07053
; WIPE_END
G1 E-.04 F1800
G1 X109.208 Y125.34 Z3.8 F9000
G1 Z3.4
G1 E.8 F1800
G1 F1462
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.532 J2.019 E.01456
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
G1 X109.8 Y125.971 F9000
G1 F1462
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01378
G1 X110.217 Y126.729 F9000
G1 F1462
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00562
G1 X110.518 Y126.309 E.0033
G3 X110.749 Y126.92 I-4.17 J1.929 E.02102
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
G1 X110.432 Y127.567 F9000
G1 F1462
G1 X110.629 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.847 J.869 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
G1 X110.432 Y128.433 F9000
G1 F1462
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.941 J-.123 E.0242
G1 X110.628 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
G1 X110.217 Y129.271 F9000
G1 F1462
G1 X110.603 Y128.977 E.01561
G1 X110.749 Y129.08 E.00578
G1 X110.707 Y129.211 E.00441
G3 X110.469 Y129.781 I-3.821 J-1.257 E.01989
G1 X110.297 Y129.753 E.00562
G1 X110.227 Y129.33 E.01378
G1 X109.8 Y130.029 F9000
G1 F1462
G1 X110.25 Y129.839 E.01571
G1 X110.366 Y129.978 E.00583
G3 X109.926 Y130.584 I-3.583 J-2.141 E.02409
G1 X109.758 Y130.516 E.00583
G1 X109.795 Y130.089 E.01379
G1 X109.192 Y130.705 F9000
G1 F1462
G1 X109.208 Y130.66 E.00151
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.958 J-2.963 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.172 Y130.761 E.01217
G1 X108.745 Y131.152 F9000
G1 F1462
G1 X108.96 Y131.174 E.00694
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.014 J-3.389 E.0242
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.685 Y131.145 E.00674
G1 X107.815 Y131.451 F9000
G1 F1462
G1 X108.108 Y131.559 E.01005
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.101 J-3.784 E.0242
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.759 Y131.43 E.0036
G1 X106.79 Y131.446 F9000
G1 F1462
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.196 E.02431
G1 X106.356 Y131.671 E.00562
G1 X106.737 Y131.474 E.01378
G1 X105.94 Y131.284 F9000
G1 F1462
G1 X106.26 Y131.653 E.01572
G1 X106.163 Y131.806 E.00583
G3 X105.452 Y131.575 I.929 J-4.07 E.02409
G1 X105.464 Y131.394 E.00583
G1 X105.881 Y131.297 E.01379
G1 X105.157 Y130.915 F9000
G1 F1462
G1 X105.375 Y131.352 E.0157
G1 X105.252 Y131.476 E.00562
G3 X104.614 Y131.074 I1.906 J-3.731 E.02431
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
G1 X104.49 Y130.364 F9000
G1 F1462
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.599 J-2.961 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
G1 X103.981 Y129.663 F9000
G1 F1462
G1 X103.962 Y130.147 E.01558
G1 X103.791 Y130.195 E.00572
G3 X103.429 Y129.536 I3.26 J-2.216 E.0242
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
G1 X103.662 Y128.859 F9000
G1 F1462
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G3 X103.158 Y128.594 I3.954 J-1.392 E.02431
G1 X103.314 Y128.516 E.00562
G1 X103.62 Y128.817 E.01378
G1 X103.554 Y128 F9000
G1 F1462
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
G1 X103.662 Y127.141 F9000
G1 F1462
G1 X103.314 Y127.484 E.01571
G1 X103.158 Y127.406 E.00562
G3 X103.344 Y126.674 I4.137 J.659 E.02431
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
G1 X103.981 Y126.337 F9000
G1 F1462
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.619 J1.557 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
G1 X104.49 Y125.636 F9000
G1 F1462
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.114 J2.414 E.0242
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
G1 X105.157 Y125.085 F9000
G1 F1462
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.523 I2.548 J3.335 E.02431
G1 X105.375 Y124.648 E.00562
G1 X105.183 Y125.031 E.01378
G1 X105.94 Y124.716 F9000
G1 F1462
G1 X105.464 Y124.606 E.01571
G1 X105.452 Y124.425 E.00583
G3 X106.163 Y124.194 I1.64 J3.836 E.02409
G1 X106.26 Y124.347 E.00583
G1 X105.979 Y124.671 E.01378
; WIPE_START
G1 F5895.652
G1 X105.464 Y124.606 E-.1974
G1 X105.452 Y124.425 E-.06891
G1 X105.802 Y124.293 E-.14224
G1 X106.163 Y124.194 E-.14234
G1 X106.26 Y124.347 E-.06891
G1 X106.018 Y124.626 E-.14019
; WIPE_END
G1 E-.04 F1800
G1 X102.745 Y128.383 Z3.8 F9000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1462
G3 X107.399 Y123.732 I4.265 J-.386 E.22348
G3 X111.08 Y129.332 I-.383 J4.261 E.22931
G3 X102.751 Y128.443 I-4.069 J-1.334 E.34705
; WIPE_START
G1 F6364.704
G1 X102.717 Y128 E-.16888
G1 X102.734 Y127.615 E-.14626
G1 X102.786 Y127.234 E-.14628
G1 X102.872 Y126.859 E-.14628
G1 X102.99 Y126.493 E-.14626
G1 X102.997 Y126.478 E-.00604
; WIPE_END
G1 E-.04 F1800
G17
G3 Z3.8 I1.217 J0 P1  F9000
; stop printing object, unique label id: 118
M625
; object ids of layer 17 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.8
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3.8 F4000
            G39.3 S1
            G0 Z3.8 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END


; object ids of this layer17 end: 82,118
M625
; CHANGE_LAYER
; Z_HEIGHT: 3.6
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 18/23
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F9000
G1 Z3.6
G1 E.8 F1800
G1 F1463
G1 X125.359 Y126.079 E.01424
G1 X125.819 Y125.95 E.01424
G1 X125.92 Y125.482 E.01424
G1 X126.397 Y125.471 E.01424
G1 X126.611 Y125.044 E.01424
G1 X127.077 Y125.151 E.01424
G1 X127.39 Y124.79 E.01424
G1 X127.814 Y125.011 E.01424
G1 X127.968 Y124.904 E.00557
G1 X128.207 Y124.739 E.00867
G1 X128.563 Y125.058 E.01424
G1 X129.012 Y124.893 E.01424
G1 X129.277 Y125.29 E.01424
G1 X129.753 Y125.241 E.01424
G1 X129.911 Y125.692 E.01424
G1 X130.384 Y125.763 E.01424
G1 X130.425 Y126.24 E.01424
G1 X130.865 Y126.426 E.01424
G1 X130.787 Y126.897 E.01424
G1 X131.167 Y127.187 E.01424
G1 X130.974 Y127.625 E.01424
G1 X131.27 Y128 E.01424
G1 X130.974 Y128.375 E.01424
G1 X131.167 Y128.813 E.01424
G1 X130.787 Y129.103 E.01424
G1 X130.865 Y129.574 E.01424
G1 X130.425 Y129.76 E.01424
G1 X130.384 Y130.237 E.01424
G1 X129.911 Y130.308 E.01424
G1 X129.753 Y130.759 E.01424
G1 X129.277 Y130.71 E.01424
G1 X129.012 Y131.107 E.01424
G1 X128.563 Y130.942 E.01424
G1 X128.207 Y131.261 E.01424
G1 X127.814 Y130.989 E.01424
G1 X127.39 Y131.21 E.01424
G1 X127.077 Y130.849 E.01424
G1 X126.611 Y130.956 E.01424
G1 X126.397 Y130.529 E.01424
G1 X125.92 Y130.518 E.01424
G1 X125.819 Y130.05 E.01424
G1 X125.359 Y129.921 E.01424
G1 X125.378 Y129.443 E.01424
G1 X124.964 Y129.203 E.01424
G1 X125.101 Y128.745 E.01424
G1 X124.761 Y128.41 E.01424
G1 X125.007 Y128 E.01424
G1 X124.761 Y127.59 E.01424
G1 X125.101 Y127.255 E.01424
G1 X124.964 Y126.797 E.01424
G1 X125.326 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18164
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X127.785 Y124.554 Z4 F9000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1463
G1 X127.352 Y124.329 E.0157
G1 X127.378 Y124.156 E.00561
G3 X128.131 Y124.107 I.651 J4.134 E.02431
G1 X128.185 Y124.278 E.00578
G1 X127.835 Y124.52 E.01368
G1 X128.288 Y124.285 F9000
G1 F1463
G1 X128.358 Y124.123 E.00567
G1 X128.525 Y124.138 E.00541
G3 X129.096 Y124.263 I-.409 J3.235 E.01882
G1 X129.104 Y124.441 E.00572
G1 X128.649 Y124.608 E.01558
G1 X128.332 Y124.325 E.01368
; WIPE_START
G1 F5895.652
G1 X128.358 Y124.123 E-.07726
G1 X128.525 Y124.138 E-.0639
G1 X128.869 Y124.2 E-.13292
G1 X129.096 Y124.263 E-.08939
G1 X129.104 Y124.441 E-.06763
G1 X128.649 Y124.608 E-.18409
G1 X128.365 Y124.354 E-.1448
; WIPE_END
G1 E-.04 F1800
G1 X129.31 Y124.633 Z4 F9000
G1 Z3.6
G1 E.8 F1800
G1 F1463
G1 X129.203 Y124.473 E.0062
G1 X129.314 Y124.334 E.00572
G1 X129.534 Y124.416 E.00756
G3 X129.993 Y124.654 I-1.093 J2.673 E.01666
G1 X129.955 Y124.826 E.00567
G1 X129.472 Y124.876 E.01561
G1 X129.344 Y124.683 E.00745
; WIPE_START
G1 F5895.652
G1 X129.203 Y124.473 E-.09607
G1 X129.314 Y124.334 E-.06763
G1 X129.534 Y124.416 E-.08937
G1 X129.993 Y124.654 E-.19665
G1 X129.955 Y124.826 E-.06699
G1 X129.472 Y124.876 E-.18447
G1 X129.386 Y124.747 E-.05883
; WIPE_END
G1 E-.04 F1800
G1 X130.203 Y125.34 Z4 F9000
G1 Z3.6
G1 E.8 F1800
G1 F1463
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.532 J2.019 E.01456
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
G1 X130.796 Y125.971 F9000
G1 F1463
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01378
G1 X131.213 Y126.729 F9000
G1 F1463
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00562
G1 X131.514 Y126.309 E.0033
G1 X131.598 Y126.507 E.00692
G3 X131.745 Y126.92 I-2.221 J1.022 E.0141
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
G1 X131.428 Y127.567 F9000
G1 F1463
G1 X131.624 Y127.123 E.01561
G1 X131.8 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.847 J.869 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
G1 X131.428 Y128.433 F9000
G1 F1463
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.799 Y128.86 I-3.941 J-.123 E.0242
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
G1 X131.213 Y129.271 F9000
G1 F1463
G1 X131.598 Y128.977 E.01561
G1 X131.745 Y129.08 E.00578
G1 X131.693 Y129.241 E.00545
G3 X131.465 Y129.781 I-3.853 J-1.307 E.01886
G1 X131.293 Y129.753 E.00562
G1 X131.222 Y129.33 E.01378
G1 X130.796 Y130.029 F9000
G1 F1463
G1 X131.246 Y129.839 E.01571
G1 X131.362 Y129.978 E.00583
G3 X130.922 Y130.584 I-3.582 J-2.14 E.02409
G1 X130.753 Y130.516 E.00583
G1 X130.79 Y130.089 E.01378
G1 X130.198 Y130.675 F9000
G1 F1463
G1 X130.203 Y130.66 E.00049
G1 X130.686 Y130.588 E.01571
G1 X130.767 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.957 J-2.963 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.178 Y130.731 E.01319
G1 X129.741 Y131.152 F9000
G1 F1463
G1 X129.955 Y131.174 E.00693
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.015 J-3.39 E.0242
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00675
G1 X128.81 Y131.451 F9000
G1 F1463
G1 X129.104 Y131.559 E.01005
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.101 J-3.786 E.0242
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.0036
G1 X127.785 Y131.446 F9000
G1 F1463
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.186 E.02431
G1 X127.352 Y131.671 E.00561
G1 X127.732 Y131.474 E.01378
G1 X126.935 Y131.284 F9000
G1 F1463
G1 X127.256 Y131.653 E.01571
G1 X127.159 Y131.806 E.00583
G3 X126.447 Y131.575 I.929 J-4.069 E.02409
G1 X126.459 Y131.394 E.00583
G1 X126.877 Y131.297 E.01379
G1 X126.152 Y130.915 F9000
G1 F1463
G1 X126.37 Y131.352 E.0157
G1 X126.248 Y131.476 E.00562
G3 X125.609 Y131.074 I1.906 J-3.731 E.02431
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
G1 X125.485 Y130.364 F9000
G1 F1463
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.598 J-2.961 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
M73 P91 R1
G1 X124.977 Y129.663 F9000
G1 F1463
G1 X124.958 Y130.147 E.01558
G1 X124.786 Y130.195 E.00572
G3 X124.425 Y129.536 I3.259 J-2.216 E.0242
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
G1 X124.658 Y128.859 F9000
G1 F1463
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G3 X124.154 Y128.594 I3.949 J-1.39 E.02431
G1 X124.31 Y128.516 E.00561
G1 X124.615 Y128.817 E.01378
G1 X124.549 Y128 F9000
G1 F1463
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
G1 X124.658 Y127.141 F9000
G1 F1463
G1 X124.31 Y127.484 E.01571
G1 X124.154 Y127.406 E.00562
G3 X124.339 Y126.674 I4.144 J.661 E.02431
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
G1 X124.977 Y126.337 F9000
G1 F1463
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.62 J1.557 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
G1 X125.485 Y125.636 F9000
G1 F1463
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.114 J2.414 E.0242
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
G1 X126.152 Y125.085 F9000
G1 F1463
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.523 I2.548 J3.335 E.02431
G1 X126.37 Y124.648 E.00562
G1 X126.179 Y125.031 E.01378
G1 X126.935 Y124.716 F9000
G1 F1463
G1 X126.459 Y124.606 E.01571
G1 X126.447 Y124.425 E.00583
G3 X127.159 Y124.194 I1.64 J3.836 E.02409
G1 X127.256 Y124.347 E.00583
G1 X126.975 Y124.671 E.01378
; WIPE_START
G1 F5895.652
G1 X126.459 Y124.606 E-.19741
G1 X126.447 Y124.425 E-.06891
G1 X126.798 Y124.293 E-.14227
G1 X127.159 Y124.194 E-.14233
G1 X127.256 Y124.347 E-.06891
G1 X127.014 Y124.626 E-.14016
; WIPE_END
G1 E-.04 F1800
G1 X123.724 Y128.385 Z4 F9000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1463
G3 X126.316 Y124.055 I4.269 J-.385 E.16071
G3 X128.427 Y123.735 I1.672 J3.907 E.06426
G3 X123.73 Y128.445 I-.433 J4.265 E.57554
; OBJECT_ID: 118
; WIPE_START
G1 F6364.704
G1 X123.712 Y128 E-.1691
G1 X123.73 Y127.615 E-.14626
G1 X123.781 Y127.234 E-.14628
G1 X123.867 Y126.859 E-.14628
G1 X123.986 Y126.493 E-.14622
G1 X123.992 Y126.479 E-.00586
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X116.36 Y126.509 Z4 F9000
G1 X104.382 Y126.557 Z4
G1 Z3.6
G1 E.8 F1800
G1 F1463
G1 X104.363 Y126.079 E.01424
G1 X104.823 Y125.95 E.01424
G1 X104.924 Y125.482 E.01424
G1 X105.402 Y125.471 E.01424
G1 X105.616 Y125.044 E.01424
G1 X106.081 Y125.151 E.01424
G1 X106.394 Y124.79 E.01424
G1 X106.819 Y125.011 E.01424
G1 X106.973 Y124.904 E.00557
G1 X107.212 Y124.739 E.00867
G1 X107.568 Y125.058 E.01424
G1 X108.016 Y124.893 E.01424
G1 X108.282 Y125.29 E.01424
G1 X108.757 Y125.241 E.01424
G1 X108.916 Y125.692 E.01424
G1 X109.389 Y125.763 E.01424
G1 X109.43 Y126.24 E.01424
G1 X109.87 Y126.426 E.01424
G1 X109.792 Y126.897 E.01424
G1 X110.171 Y127.187 E.01424
G1 X109.978 Y127.625 E.01424
G1 X110.274 Y128 E.01424
G1 X109.978 Y128.375 E.01424
G1 X110.171 Y128.813 E.01424
G1 X109.792 Y129.103 E.01424
G1 X109.87 Y129.574 E.01424
G1 X109.43 Y129.76 E.01424
G1 X109.389 Y130.237 E.01424
G1 X108.916 Y130.308 E.01424
G1 X108.757 Y130.759 E.01424
G1 X108.282 Y130.71 E.01424
G1 X108.016 Y131.107 E.01424
G1 X107.568 Y130.942 E.01424
G1 X107.212 Y131.261 E.01424
G1 X106.819 Y130.989 E.01424
G1 X106.394 Y131.21 E.01424
G1 X106.081 Y130.849 E.01424
G1 X105.616 Y130.956 E.01424
G1 X105.402 Y130.529 E.01424
G1 X104.924 Y130.518 E.01424
G1 X104.823 Y130.05 E.01424
G1 X104.363 Y129.921 E.01424
G1 X104.382 Y129.443 E.01424
G1 X103.969 Y129.203 E.01424
G1 X104.106 Y128.745 E.01424
G1 X103.765 Y128.41 E.01424
G1 X104.012 Y128 E.01424
G1 X103.765 Y127.59 E.01424
G1 X104.106 Y127.255 E.01424
G1 X103.969 Y126.797 E.01424
G1 X104.33 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18164
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X106.79 Y124.554 Z4 F9000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1463
G1 X106.357 Y124.329 E.0157
G1 X106.383 Y124.156 E.00561
G3 X107.136 Y124.107 I.651 J4.134 E.02431
G1 X107.189 Y124.278 E.00578
G1 X106.839 Y124.52 E.01368
G1 X107.292 Y124.285 F9000
G1 F1463
G1 X107.362 Y124.123 E.00567
G1 X107.53 Y124.138 E.00541
G3 X108.101 Y124.263 I-.409 J3.235 E.01882
G1 X108.108 Y124.441 E.00572
G1 X107.654 Y124.608 E.01558
G1 X107.337 Y124.325 E.01368
; WIPE_START
G1 F5895.652
G1 X107.362 Y124.123 E-.07726
G1 X107.53 Y124.138 E-.0639
G1 X107.874 Y124.2 E-.13292
G1 X108.101 Y124.263 E-.08939
G1 X108.108 Y124.441 E-.06763
G1 X107.654 Y124.608 E-.18409
G1 X107.37 Y124.354 E-.1448
; WIPE_END
G1 E-.04 F1800
G1 X108.315 Y124.633 Z4 F9000
G1 Z3.6
G1 E.8 F1800
G1 F1463
G1 X108.208 Y124.473 E.0062
G1 X108.318 Y124.334 E.00572
G1 X108.538 Y124.416 E.00756
G3 X108.998 Y124.654 I-1.093 J2.673 E.01666
G1 X108.96 Y124.826 E.00567
G1 X108.477 Y124.876 E.01561
G1 X108.348 Y124.683 E.00745
; WIPE_START
G1 F5895.652
G1 X108.208 Y124.473 E-.09607
G1 X108.318 Y124.334 E-.06763
G1 X108.538 Y124.416 E-.08937
G1 X108.998 Y124.654 E-.19665
G1 X108.96 Y124.826 E-.06699
G1 X108.477 Y124.876 E-.18447
G1 X108.391 Y124.747 E-.05883
; WIPE_END
G1 E-.04 F1800
G1 X109.208 Y125.34 Z4 F9000
G1 Z3.6
G1 E.8 F1800
G1 F1463
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.532 J2.019 E.01456
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
G1 X109.8 Y125.971 F9000
G1 F1463
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01378
G1 X110.217 Y126.729 F9000
G1 F1463
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00562
G1 X110.518 Y126.309 E.0033
G1 X110.603 Y126.507 E.00692
G3 X110.749 Y126.92 I-2.221 J1.022 E.0141
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
G1 X110.432 Y127.567 F9000
G1 F1463
G1 X110.629 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.847 J.869 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
G1 X110.432 Y128.433 F9000
G1 F1463
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.941 J-.123 E.0242
G1 X110.628 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
G1 X110.217 Y129.271 F9000
G1 F1463
G1 X110.603 Y128.977 E.01561
G1 X110.749 Y129.08 E.00578
G1 X110.697 Y129.241 E.00545
G3 X110.469 Y129.781 I-3.853 J-1.307 E.01886
G1 X110.297 Y129.753 E.00562
G1 X110.227 Y129.33 E.01378
G1 X109.8 Y130.029 F9000
G1 F1463
G1 X110.25 Y129.839 E.01571
G1 X110.366 Y129.978 E.00583
G3 X109.926 Y130.584 I-3.582 J-2.14 E.02409
G1 X109.758 Y130.516 E.00583
G1 X109.795 Y130.089 E.01378
G1 X109.203 Y130.675 F9000
G1 F1463
G1 X109.208 Y130.66 E.00049
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.957 J-2.963 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.183 Y130.731 E.01319
G1 X108.745 Y131.152 F9000
G1 F1463
G1 X108.96 Y131.174 E.00693
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.015 J-3.39 E.0242
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.686 Y131.145 E.00675
G1 X107.815 Y131.451 F9000
G1 F1463
G1 X108.108 Y131.559 E.01005
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.101 J-3.786 E.0242
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.759 Y131.43 E.0036
G1 X106.79 Y131.446 F9000
G1 F1463
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.186 E.02431
G1 X106.357 Y131.671 E.00561
G1 X106.737 Y131.474 E.01378
G1 X105.94 Y131.284 F9000
G1 F1463
G1 X106.26 Y131.653 E.01571
G1 X106.163 Y131.806 E.00583
G3 X105.452 Y131.575 I.929 J-4.069 E.02409
G1 X105.464 Y131.394 E.00583
G1 X105.881 Y131.297 E.01379
G1 X105.157 Y130.915 F9000
G1 F1463
G1 X105.375 Y131.352 E.0157
G1 X105.252 Y131.476 E.00562
G3 X104.614 Y131.074 I1.906 J-3.731 E.02431
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
G1 X104.49 Y130.364 F9000
G1 F1463
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.598 J-2.961 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
G1 X103.981 Y129.663 F9000
G1 F1463
G1 X103.962 Y130.147 E.01558
G1 X103.791 Y130.195 E.00572
G3 X103.429 Y129.536 I3.259 J-2.216 E.0242
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
G1 X103.662 Y128.859 F9000
G1 F1463
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G3 X103.158 Y128.594 I3.949 J-1.39 E.02431
G1 X103.314 Y128.516 E.00561
G1 X103.62 Y128.817 E.01378
G1 X103.554 Y128 F9000
G1 F1463
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
G1 X103.662 Y127.141 F9000
G1 F1463
G1 X103.314 Y127.484 E.01571
G1 X103.158 Y127.406 E.00562
G3 X103.344 Y126.674 I4.144 J.661 E.02431
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
G1 X103.981 Y126.337 F9000
G1 F1463
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.62 J1.557 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
G1 X104.49 Y125.636 F9000
G1 F1463
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.114 J2.414 E.0242
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
G1 X105.157 Y125.085 F9000
G1 F1463
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.523 I2.548 J3.335 E.02431
G1 X105.375 Y124.648 E.00562
G1 X105.183 Y125.031 E.01378
G1 X105.94 Y124.716 F9000
G1 F1463
G1 X105.464 Y124.606 E.01571
G1 X105.452 Y124.425 E.00583
G3 X106.163 Y124.194 I1.64 J3.836 E.02409
G1 X106.26 Y124.347 E.00583
G1 X105.979 Y124.671 E.01378
; WIPE_START
G1 F5895.652
G1 X105.464 Y124.606 E-.19741
G1 X105.452 Y124.425 E-.06891
G1 X105.802 Y124.293 E-.14227
G1 X106.163 Y124.194 E-.14233
G1 X106.26 Y124.347 E-.06891
G1 X106.018 Y124.626 E-.14016
; WIPE_END
G1 E-.04 F1800
G1 X102.729 Y128.385 Z4 F9000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1463
G3 X105.321 Y124.055 I4.269 J-.385 E.16071
G3 X107.431 Y123.735 I1.672 J3.907 E.06426
G3 X102.735 Y128.445 I-.433 J4.265 E.57554
; WIPE_START
G1 F6364.704
G1 X102.717 Y128 E-.1691
G1 X102.734 Y127.615 E-.14626
G1 X102.786 Y127.234 E-.14628
G1 X102.872 Y126.859 E-.14628
G1 X102.99 Y126.493 E-.14622
G1 X102.997 Y126.479 E-.00586
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4 I1.217 J0 P1  F9000
; stop printing object, unique label id: 118
M625
; object ids of layer 18 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4 F4000
            G39.3 S1
            G0 Z4 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END


; object ids of this layer18 end: 82,118
M625
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 19/23
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F9000
G1 Z3.8
G1 E.8 F1800
G1 F1463
G1 X125.359 Y126.079 E.01424
G1 X125.819 Y125.95 E.01424
G1 X125.92 Y125.482 E.01424
G1 X126.397 Y125.471 E.01424
G1 X126.611 Y125.044 E.01424
G1 X127.077 Y125.151 E.01424
G1 X127.39 Y124.79 E.01424
G1 X127.814 Y125.011 E.01424
G1 X127.989 Y124.89 E.00632
G1 X128.207 Y124.739 E.00792
G1 X128.563 Y125.058 E.01424
G1 X129.012 Y124.893 E.01424
G1 X129.277 Y125.29 E.01424
G1 X129.753 Y125.241 E.01424
G1 X129.911 Y125.692 E.01424
G1 X130.384 Y125.763 E.01424
G1 X130.425 Y126.24 E.01424
G1 X130.865 Y126.426 E.01424
G1 X130.787 Y126.897 E.01424
G1 X131.167 Y127.187 E.01424
G1 X130.974 Y127.625 E.01424
G1 X131.27 Y128 E.01424
G1 X130.974 Y128.375 E.01424
G1 X131.167 Y128.813 E.01424
G1 X130.787 Y129.103 E.01424
G1 X130.865 Y129.574 E.01424
G1 X130.425 Y129.76 E.01424
G1 X130.384 Y130.237 E.01424
G1 X129.911 Y130.308 E.01424
G1 X129.753 Y130.759 E.01424
G1 X129.277 Y130.71 E.01424
G1 X129.012 Y131.107 E.01424
G1 X128.563 Y130.942 E.01424
G1 X128.207 Y131.261 E.01424
G1 X127.814 Y130.989 E.01424
G1 X127.39 Y131.21 E.01424
G1 X127.077 Y130.849 E.01424
G1 X126.611 Y130.956 E.01424
G1 X126.397 Y130.529 E.01424
G1 X125.92 Y130.518 E.01424
G1 X125.819 Y130.05 E.01424
G1 X125.359 Y129.921 E.01424
G1 X125.378 Y129.443 E.01424
G1 X124.964 Y129.203 E.01424
G1 X125.101 Y128.745 E.01424
G1 X124.761 Y128.41 E.01424
G1 X125.007 Y128 E.01424
G1 X124.761 Y127.59 E.01424
G1 X125.101 Y127.255 E.01424
G1 X124.964 Y126.797 E.01424
G1 X125.326 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18164
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X127.785 Y124.554 Z4.2 F9000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1463
G1 X127.352 Y124.329 E.01571
G1 X127.378 Y124.156 E.00562
G3 X128.131 Y124.107 I.651 J4.145 E.02431
G1 X128.185 Y124.278 E.00578
G1 X127.835 Y124.52 E.01368
G1 X128.288 Y124.285 F9000
G1 F1463
G1 X128.358 Y124.123 E.00567
M73 P92 R1
G1 X128.525 Y124.138 E.00541
G3 X129.096 Y124.263 I-.409 J3.235 E.01882
G1 X129.104 Y124.441 E.00572
G1 X128.649 Y124.608 E.01558
G1 X128.332 Y124.325 E.01368
; WIPE_START
G1 F5895.652
G1 X128.358 Y124.123 E-.07726
G1 X128.525 Y124.138 E-.0639
G1 X128.869 Y124.2 E-.13293
G1 X129.096 Y124.263 E-.08939
G1 X129.104 Y124.441 E-.06763
G1 X128.649 Y124.608 E-.18408
G1 X128.365 Y124.354 E-.14482
; WIPE_END
G1 E-.04 F1800
G1 X129.327 Y124.658 Z4.2 F9000
G1 Z3.8
G1 E.8 F1800
G1 F1463
G1 X129.203 Y124.473 E.00716
G1 X129.314 Y124.334 E.00572
G1 X129.534 Y124.416 E.00757
G3 X129.993 Y124.654 I-1.092 J2.67 E.01666
G1 X129.955 Y124.826 E.00567
G1 X129.472 Y124.876 E.01561
G1 X129.36 Y124.708 E.00649
; WIPE_START
G1 F5895.652
G1 X129.203 Y124.473 E-.10739
G1 X129.314 Y124.334 E-.06763
G1 X129.534 Y124.416 E-.0894
G1 X129.993 Y124.654 E-.19661
G1 X129.955 Y124.826 E-.06699
G1 X129.472 Y124.876 E-.18448
G1 X129.403 Y124.772 E-.0475
; WIPE_END
G1 E-.04 F1800
G1 X130.203 Y125.34 Z4.2 F9000
G1 Z3.8
G1 E.8 F1800
G1 F1463
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.532 J2.019 E.01456
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
G1 X130.796 Y125.971 F9000
G1 F1463
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01378
G1 X131.213 Y126.729 F9000
G1 F1463
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00562
G1 X131.514 Y126.309 E.0033
G1 X131.611 Y126.537 E.00796
G3 X131.745 Y126.92 I-2.064 J.937 E.01307
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
G1 X131.428 Y127.567 F9000
G1 F1463
G1 X131.624 Y127.123 E.01561
G1 X131.799 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.845 J.868 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
G1 X131.428 Y128.433 F9000
G1 F1463
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.8 Y128.86 I-3.944 J-.123 E.0242
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
G1 X131.212 Y129.271 F9000
G1 F1463
G1 X131.598 Y128.977 E.01561
G1 X131.745 Y129.08 E.00578
G3 X131.465 Y129.781 I-4.014 J-1.197 E.02431
G1 X131.293 Y129.753 E.00561
G1 X131.222 Y129.33 E.01378
G1 X130.796 Y130.029 F9000
G1 F1463
G1 X131.246 Y129.839 E.01571
G1 X131.362 Y129.978 E.00583
G3 X130.922 Y130.584 I-3.583 J-2.141 E.02409
G1 X130.753 Y130.516 E.00583
G1 X130.79 Y130.089 E.01379
G1 X130.203 Y130.66 F9000
G1 F1463
G1 X130.686 Y130.588 E.01571
G1 X130.767 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.958 J-2.964 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.183 Y130.717 E.01368
G1 X129.741 Y131.152 F9000
G1 F1463
G1 X129.955 Y131.174 E.00694
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.015 J-3.39 E.0242
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00675
G1 X128.81 Y131.451 F9000
G1 F1463
G1 X129.104 Y131.559 E.01005
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.101 J-3.787 E.0242
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.00359
G1 X127.785 Y131.446 F9000
G1 F1463
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.196 E.02431
G1 X127.352 Y131.671 E.00562
G1 X127.732 Y131.474 E.01378
G1 X126.935 Y131.284 F9000
G1 F1463
G1 X127.256 Y131.653 E.01571
G1 X127.159 Y131.806 E.00583
G3 X126.447 Y131.575 I.929 J-4.07 E.02409
G1 X126.459 Y131.394 E.00583
G1 X126.877 Y131.297 E.01379
G1 X126.152 Y130.915 F9000
G1 F1463
G1 X126.37 Y131.352 E.0157
G1 X126.248 Y131.476 E.00562
G3 X125.609 Y131.074 I1.906 J-3.731 E.02431
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
G1 X125.485 Y130.364 F9000
G1 F1463
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.599 J-2.962 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
G1 X124.977 Y129.663 F9000
G1 F1463
G1 X124.958 Y130.147 E.01558
G1 X124.786 Y130.195 E.00572
G3 X124.425 Y129.536 I3.262 J-2.218 E.0242
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
G1 X124.658 Y128.859 F9000
G1 F1463
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G3 X124.154 Y128.594 I3.955 J-1.392 E.02431
G1 X124.31 Y128.516 E.00562
G1 X124.615 Y128.817 E.01378
G1 X124.549 Y128 F9000
G1 F1463
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
G1 X124.658 Y127.141 F9000
G1 F1463
G1 X124.31 Y127.484 E.01571
G1 X124.154 Y127.406 E.00562
G3 X124.339 Y126.674 I4.145 J.662 E.02431
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
G1 X124.977 Y126.337 F9000
G1 F1463
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.619 J1.556 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
G1 X125.485 Y125.636 F9000
G1 F1463
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.114 J2.414 E.0242
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
G1 X126.152 Y125.085 F9000
G1 F1463
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.524 I2.544 J3.329 E.02431
G1 X126.37 Y124.648 E.00562
G1 X126.179 Y125.031 E.01378
G1 X126.935 Y124.716 F9000
G1 F1463
G1 X126.459 Y124.606 E.01572
G1 X126.447 Y124.425 E.00583
G3 X127.159 Y124.194 I1.64 J3.837 E.02409
G1 X127.256 Y124.347 E.00583
G1 X126.975 Y124.671 E.01379
; WIPE_START
G1 F5895.652
G1 X126.459 Y124.606 E-.19742
G1 X126.447 Y124.425 E-.06891
G1 X126.798 Y124.293 E-.14226
G1 X127.159 Y124.194 E-.14236
G1 X127.256 Y124.347 E-.06891
G1 X127.014 Y124.626 E-.14014
; WIPE_END
G1 E-.04 F1800
G1 X123.73 Y128.381 Z4.2 F9000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1463
G1 X123.706 Y128 E.01138
G3 X126.677 Y123.92 I4.287 J0 E.16072
G3 X128.459 Y123.738 I1.328 J4.189 E.05374
G3 X123.729 Y128.438 I-.465 J4.262 E.57481
; OBJECT_ID: 118
; WIPE_START
G1 F6364.704
G1 X123.706 Y128 E-.16653
G1 X123.73 Y127.615 E-.14639
G1 X123.781 Y127.234 E-.14628
G1 X123.867 Y126.859 E-.14628
G1 X123.986 Y126.493 E-.14622
G1 X123.995 Y126.473 E-.00831
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X116.362 Y126.506 Z4.2 F9000
G1 X104.382 Y126.557 Z4.2
G1 Z3.8
G1 E.8 F1800
G1 F1463
G1 X104.363 Y126.079 E.01424
G1 X104.823 Y125.95 E.01424
G1 X104.924 Y125.482 E.01424
G1 X105.402 Y125.471 E.01424
G1 X105.616 Y125.044 E.01424
G1 X106.081 Y125.151 E.01424
G1 X106.394 Y124.79 E.01424
G1 X106.819 Y125.011 E.01424
G1 X106.993 Y124.89 E.00632
G1 X107.212 Y124.739 E.00792
G1 X107.568 Y125.058 E.01424
G1 X108.016 Y124.893 E.01424
G1 X108.282 Y125.29 E.01424
G1 X108.757 Y125.241 E.01424
G1 X108.916 Y125.692 E.01424
G1 X109.389 Y125.763 E.01424
G1 X109.43 Y126.24 E.01424
G1 X109.87 Y126.426 E.01424
G1 X109.792 Y126.897 E.01424
G1 X110.171 Y127.187 E.01424
G1 X109.978 Y127.625 E.01424
G1 X110.274 Y128 E.01424
G1 X109.978 Y128.375 E.01424
G1 X110.171 Y128.813 E.01424
G1 X109.792 Y129.103 E.01424
G1 X109.87 Y129.574 E.01424
G1 X109.43 Y129.76 E.01424
G1 X109.389 Y130.237 E.01424
G1 X108.916 Y130.308 E.01424
G1 X108.757 Y130.759 E.01424
G1 X108.282 Y130.71 E.01424
G1 X108.016 Y131.107 E.01424
G1 X107.568 Y130.942 E.01424
G1 X107.212 Y131.261 E.01424
G1 X106.819 Y130.989 E.01424
G1 X106.394 Y131.21 E.01424
G1 X106.081 Y130.849 E.01424
G1 X105.616 Y130.956 E.01424
G1 X105.402 Y130.529 E.01424
G1 X104.924 Y130.518 E.01424
G1 X104.823 Y130.05 E.01424
G1 X104.363 Y129.921 E.01424
G1 X104.382 Y129.443 E.01424
G1 X103.969 Y129.203 E.01424
G1 X104.106 Y128.745 E.01424
G1 X103.765 Y128.41 E.01424
G1 X104.012 Y128 E.01424
G1 X103.765 Y127.59 E.01424
G1 X104.106 Y127.255 E.01424
G1 X103.969 Y126.797 E.01424
G1 X104.33 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18164
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X106.79 Y124.554 Z4.2 F9000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1463
G1 X106.356 Y124.329 E.01571
G1 X106.383 Y124.156 E.00562
G3 X107.136 Y124.107 I.651 J4.145 E.02431
G1 X107.189 Y124.278 E.00578
G1 X106.839 Y124.52 E.01368
G1 X107.292 Y124.285 F9000
G1 F1463
G1 X107.362 Y124.123 E.00567
G1 X107.53 Y124.138 E.00541
G3 X108.101 Y124.263 I-.409 J3.235 E.01882
G1 X108.108 Y124.441 E.00572
G1 X107.654 Y124.608 E.01558
G1 X107.337 Y124.325 E.01368
; WIPE_START
G1 F5895.652
G1 X107.362 Y124.123 E-.07726
G1 X107.53 Y124.138 E-.0639
G1 X107.874 Y124.2 E-.13293
G1 X108.101 Y124.263 E-.08939
G1 X108.108 Y124.441 E-.06763
G1 X107.654 Y124.608 E-.18408
G1 X107.37 Y124.354 E-.14482
; WIPE_END
G1 E-.04 F1800
G1 X108.331 Y124.658 Z4.2 F9000
G1 Z3.8
G1 E.8 F1800
G1 F1463
G1 X108.208 Y124.473 E.00716
G1 X108.318 Y124.334 E.00572
G1 X108.539 Y124.416 E.00757
G3 X108.998 Y124.654 I-1.092 J2.67 E.01666
G1 X108.96 Y124.826 E.00567
G1 X108.477 Y124.876 E.01561
G1 X108.365 Y124.708 E.00649
; WIPE_START
G1 F5895.652
G1 X108.208 Y124.473 E-.10739
G1 X108.318 Y124.334 E-.06763
G1 X108.539 Y124.416 E-.0894
G1 X108.998 Y124.654 E-.19661
G1 X108.96 Y124.826 E-.06699
G1 X108.477 Y124.876 E-.18448
G1 X108.407 Y124.772 E-.0475
; WIPE_END
G1 E-.04 F1800
G1 X109.208 Y125.34 Z4.2 F9000
G1 Z3.8
G1 E.8 F1800
G1 F1463
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.532 J2.019 E.01456
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
G1 X109.8 Y125.971 F9000
G1 F1463
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01378
G1 X110.217 Y126.729 F9000
G1 F1463
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00562
G1 X110.518 Y126.309 E.0033
G1 X110.615 Y126.537 E.00796
G3 X110.749 Y126.92 I-2.064 J.937 E.01307
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
G1 X110.432 Y127.567 F9000
G1 F1463
G1 X110.628 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.845 J.868 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
G1 X110.432 Y128.433 F9000
G1 F1463
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.944 J-.123 E.0242
G1 X110.629 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
G1 X110.217 Y129.271 F9000
G1 F1463
G1 X110.603 Y128.977 E.01561
G1 X110.749 Y129.08 E.00578
G3 X110.469 Y129.781 I-4.014 J-1.197 E.02431
G1 X110.297 Y129.753 E.00561
G1 X110.227 Y129.33 E.01378
G1 X109.8 Y130.029 F9000
G1 F1463
G1 X110.25 Y129.839 E.01571
G1 X110.366 Y129.978 E.00583
G3 X109.926 Y130.584 I-3.583 J-2.141 E.02409
G1 X109.758 Y130.516 E.00583
G1 X109.795 Y130.089 E.01379
G1 X109.208 Y130.66 F9000
G1 F1463
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.958 J-2.964 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.188 Y130.717 E.01368
G1 X108.745 Y131.152 F9000
G1 F1463
G1 X108.96 Y131.174 E.00694
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.015 J-3.39 E.0242
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.685 Y131.145 E.00675
G1 X107.815 Y131.451 F9000
G1 F1463
G1 X108.108 Y131.559 E.01005
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.101 J-3.787 E.0242
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.759 Y131.43 E.00359
G1 X106.79 Y131.446 F9000
G1 F1463
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.196 E.02431
G1 X106.356 Y131.671 E.00562
G1 X106.737 Y131.474 E.01378
G1 X105.94 Y131.284 F9000
G1 F1463
G1 X106.26 Y131.653 E.01571
G1 X106.163 Y131.806 E.00583
G3 X105.452 Y131.575 I.929 J-4.07 E.02409
G1 X105.464 Y131.394 E.00583
G1 X105.881 Y131.297 E.01379
G1 X105.157 Y130.915 F9000
G1 F1463
G1 X105.375 Y131.352 E.0157
G1 X105.252 Y131.476 E.00562
G3 X104.614 Y131.074 I1.906 J-3.731 E.02431
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
G1 X104.49 Y130.364 F9000
G1 F1463
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.599 J-2.962 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
G1 X103.981 Y129.663 F9000
G1 F1463
G1 X103.962 Y130.147 E.01558
G1 X103.791 Y130.195 E.00572
G3 X103.429 Y129.536 I3.262 J-2.218 E.0242
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
G1 X103.662 Y128.859 F9000
G1 F1463
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G3 X103.158 Y128.594 I3.955 J-1.392 E.02431
G1 X103.314 Y128.516 E.00562
G1 X103.62 Y128.817 E.01378
G1 X103.554 Y128 F9000
G1 F1463
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
G1 X103.662 Y127.141 F9000
G1 F1463
G1 X103.314 Y127.484 E.01571
G1 X103.158 Y127.406 E.00562
G3 X103.344 Y126.674 I4.145 J.662 E.02431
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
G1 X103.981 Y126.337 F9000
G1 F1463
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.619 J1.556 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
G1 X104.49 Y125.636 F9000
G1 F1463
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.114 J2.414 E.0242
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
G1 X105.157 Y125.085 F9000
G1 F1463
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.524 I2.544 J3.329 E.02431
G1 X105.375 Y124.648 E.00562
G1 X105.183 Y125.031 E.01378
G1 X105.94 Y124.716 F9000
G1 F1463
G1 X105.464 Y124.606 E.01572
G1 X105.452 Y124.425 E.00583
G3 X106.163 Y124.194 I1.64 J3.837 E.02409
G1 X106.26 Y124.347 E.00583
G1 X105.979 Y124.671 E.01379
; WIPE_START
G1 F5895.652
G1 X105.464 Y124.606 E-.19742
G1 X105.452 Y124.425 E-.06891
G1 X105.802 Y124.293 E-.14226
G1 X106.163 Y124.194 E-.14236
G1 X106.26 Y124.347 E-.06891
G1 X106.018 Y124.626 E-.14014
; WIPE_END
G1 E-.04 F1800
G1 X102.734 Y128.381 Z4.2 F9000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1463
G1 X102.711 Y128 E.01138
G3 X105.681 Y123.92 I4.287 J0 E.16072
G3 X107.463 Y123.738 I1.328 J4.189 E.05374
G3 X102.733 Y128.438 I-.465 J4.262 E.57481
; WIPE_START
G1 F6364.704
G1 X102.711 Y128 E-.16653
G1 X102.734 Y127.615 E-.14639
G1 X102.786 Y127.234 E-.14628
G1 X102.872 Y126.859 E-.14628
G1 X102.99 Y126.493 E-.14622
G1 X102.999 Y126.473 E-.00831
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.2 I1.217 J0 P1  F9000
; stop printing object, unique label id: 118
M625
; object ids of layer 19 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.2
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4.2 F4000
            G39.3 S1
            G0 Z4.2 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END


; object ids of this layer19 end: 82,118
M625
; CHANGE_LAYER
; Z_HEIGHT: 4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 20/23
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F9000
G1 Z4
G1 E.8 F1800
G1 F1463
G1 X125.359 Y126.079 E.01424
G1 X125.819 Y125.95 E.01424
G1 X125.92 Y125.482 E.01424
G1 X126.397 Y125.471 E.01424
G1 X126.611 Y125.044 E.01424
G1 X127.077 Y125.151 E.01424
G1 X127.39 Y124.79 E.01424
G1 X127.814 Y125.011 E.01424
G1 X128.009 Y124.876 E.00707
G1 X128.207 Y124.739 E.00717
G1 X128.563 Y125.058 E.01424
G1 X129.012 Y124.893 E.01424
G1 X129.277 Y125.29 E.01424
G1 X129.753 Y125.241 E.01424
G1 X129.911 Y125.692 E.01424
G1 X130.384 Y125.763 E.01424
G1 X130.425 Y126.24 E.01424
G1 X130.865 Y126.426 E.01424
G1 X130.787 Y126.897 E.01424
G1 X131.167 Y127.187 E.01424
G1 X130.974 Y127.625 E.01424
G1 X131.27 Y128 E.01424
G1 X130.974 Y128.375 E.01424
G1 X131.167 Y128.813 E.01424
G1 X130.787 Y129.103 E.01424
G1 X130.865 Y129.574 E.01424
G1 X130.425 Y129.76 E.01424
G1 X130.384 Y130.237 E.01424
G1 X129.911 Y130.308 E.01424
G1 X129.753 Y130.759 E.01424
G1 X129.277 Y130.71 E.01424
G1 X129.012 Y131.107 E.01424
G1 X128.563 Y130.942 E.01424
G1 X128.207 Y131.261 E.01424
G1 X127.814 Y130.989 E.01424
G1 X127.39 Y131.21 E.01424
G1 X127.077 Y130.849 E.01424
G1 X126.611 Y130.956 E.01424
G1 X126.397 Y130.529 E.01424
G1 X125.92 Y130.518 E.01424
G1 X125.819 Y130.05 E.01424
G1 X125.359 Y129.921 E.01424
G1 X125.378 Y129.443 E.01424
G1 X124.964 Y129.203 E.01424
G1 X125.101 Y128.745 E.01424
G1 X124.761 Y128.409 E.01424
G1 X125.007 Y128 E.01424
G1 X124.761 Y127.59 E.01424
G1 X125.101 Y127.255 E.01424
G1 X124.964 Y126.797 E.01424
G1 X125.326 Y126.587 E.01245
; WIPE_START
G1 F6364.704
M73 P93 R1
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18164
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X127.785 Y124.554 Z4.4 F9000
G1 Z4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1463
G1 X127.352 Y124.329 E.01571
G1 X127.378 Y124.156 E.00562
G3 X128.131 Y124.107 I.652 J4.148 E.02431
G1 X128.185 Y124.278 E.00578
G1 X127.835 Y124.52 E.01368
G1 X128.288 Y124.285 F9000
G1 F1463
G1 X128.358 Y124.123 E.00567
G1 X128.456 Y124.132 E.00316
G3 X129.096 Y124.263 I-.53 J4.214 E.02104
G1 X129.104 Y124.441 E.00572
G1 X128.649 Y124.608 E.01558
G1 X128.332 Y124.325 E.01368
; WIPE_START
G1 F5895.652
G1 X128.358 Y124.123 E-.07727
G1 X128.456 Y124.132 E-.03739
G1 X128.869 Y124.2 E-.15933
G1 X129.096 Y124.263 E-.08939
G1 X129.104 Y124.441 E-.06763
G1 X128.649 Y124.608 E-.18409
G1 X128.365 Y124.354 E-.14491
; WIPE_END
G1 E-.04 F1800
G1 X129.343 Y124.682 Z4.4 F9000
G1 Z4
G1 E.8 F1800
G1 F1463
G1 X129.203 Y124.473 E.00807
G1 X129.314 Y124.334 E.00572
G1 X129.534 Y124.416 E.00756
G3 X129.993 Y124.654 I-1.093 J2.672 E.01666
G1 X129.955 Y124.826 E.00567
G1 X129.472 Y124.876 E.01561
G1 X129.376 Y124.732 E.00558
; WIPE_START
G1 F5895.652
G1 X129.203 Y124.473 E-.11818
G1 X129.314 Y124.334 E-.06763
G1 X129.534 Y124.416 E-.08938
G1 X129.993 Y124.654 E-.19661
G1 X129.955 Y124.826 E-.06699
G1 X129.472 Y124.876 E-.18447
G1 X129.419 Y124.795 E-.03674
; WIPE_END
G1 E-.04 F1800
G1 X130.203 Y125.34 Z4.4 F9000
G1 Z4
G1 E.8 F1800
G1 F1463
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.531 J2.019 E.01455
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
G1 X130.796 Y125.971 F9000
G1 F1463
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01378
G1 X131.213 Y126.729 F9000
G1 F1463
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00562
G1 X131.514 Y126.309 E.0033
G1 X131.624 Y126.566 E.00899
G3 X131.745 Y126.92 I-1.908 J.853 E.01203
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
G1 X131.428 Y127.567 F9000
G1 F1463
G1 X131.624 Y127.123 E.01561
G1 X131.799 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.845 J.868 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
G1 X131.428 Y128.433 F9000
G1 F1463
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.8 Y128.86 I-3.944 J-.123 E.0242
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
G1 X131.213 Y129.271 F9000
G1 F1463
G1 X131.598 Y128.977 E.01561
G1 X131.745 Y129.08 E.00578
G3 X131.465 Y129.781 I-4.017 J-1.198 E.02431
G1 X131.293 Y129.753 E.00562
G1 X131.222 Y129.33 E.01378
G1 X130.796 Y130.029 F9000
G1 F1463
G1 X131.246 Y129.839 E.01571
G1 X131.362 Y129.978 E.00583
G3 X130.922 Y130.584 I-3.583 J-2.141 E.02409
G1 X130.753 Y130.516 E.00583
G1 X130.79 Y130.089 E.01378
G1 X130.203 Y130.66 F9000
G1 F1463
G1 X130.686 Y130.588 E.01571
G1 X130.767 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.958 J-2.964 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.183 Y130.717 E.01368
G1 X129.741 Y131.152 F9000
G1 F1463
G1 X129.955 Y131.174 E.00694
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.015 J-3.389 E.0242
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00674
G1 X128.81 Y131.451 F9000
G1 F1463
G1 X129.104 Y131.559 E.01006
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.101 J-3.786 E.0242
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.00359
G1 X127.785 Y131.446 F9000
G1 F1463
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.196 E.02431
G1 X127.352 Y131.671 E.00562
G1 X127.732 Y131.474 E.01378
G1 X126.935 Y131.284 F9000
G1 F1463
G1 X127.256 Y131.653 E.01572
G1 X127.159 Y131.806 E.00583
G3 X126.447 Y131.575 I.929 J-4.07 E.02409
G1 X126.459 Y131.394 E.00583
G1 X126.877 Y131.297 E.01379
G1 X126.152 Y130.915 F9000
G1 F1463
G1 X126.37 Y131.352 E.0157
G1 X126.248 Y131.476 E.00562
G3 X125.609 Y131.074 I1.906 J-3.731 E.02431
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
G1 X125.485 Y130.364 F9000
G1 F1463
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.599 J-2.961 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
G1 X124.977 Y129.663 F9000
G1 F1463
G1 X124.958 Y130.147 E.01558
G1 X124.786 Y130.195 E.00572
G3 X124.425 Y129.536 I3.259 J-2.216 E.0242
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
G1 X124.658 Y128.859 F9000
G1 F1463
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G3 X124.154 Y128.594 I3.956 J-1.392 E.02431
G1 X124.31 Y128.516 E.00562
G1 X124.615 Y128.817 E.01378
G1 X124.549 Y128 F9000
G1 F1463
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
G1 X124.658 Y127.141 F9000
G1 F1463
G1 X124.31 Y127.484 E.01571
G1 X124.154 Y127.406 E.00562
G3 X124.339 Y126.674 I4.143 J.661 E.02431
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
G1 X124.977 Y126.337 F9000
G1 F1463
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.619 J1.556 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
G1 X125.485 Y125.636 F9000
G1 F1463
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.115 J2.415 E.0242
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
G1 X126.152 Y125.085 F9000
G1 F1463
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.524 I2.544 J3.329 E.02431
G1 X126.37 Y124.648 E.00562
G1 X126.179 Y125.031 E.01378
G1 X126.935 Y124.716 F9000
G1 F1463
G1 X126.459 Y124.606 E.01572
G1 X126.447 Y124.425 E.00583
G3 X127.159 Y124.194 I1.64 J3.838 E.02409
G1 X127.256 Y124.347 E.00583
G1 X126.975 Y124.671 E.01379
; WIPE_START
G1 F5895.652
G1 X126.459 Y124.606 E-.19742
G1 X126.447 Y124.425 E-.06891
G1 X126.798 Y124.293 E-.14227
G1 X127.159 Y124.194 E-.14235
G1 X127.256 Y124.347 E-.06891
G1 X127.014 Y124.626 E-.14014
; WIPE_END
G1 E-.04 F1800
G1 X123.729 Y128.376 Z4.4 F9000
G1 Z4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1463
G1 X123.715 Y128 E.0112
G3 X123.959 Y126.576 I4.287 J0 E.04324
G3 X128.491 Y123.741 I4.036 J1.412 E.172
G3 X131.984 Y126.412 I-.494 J4.266 E.13751
G3 X123.738 Y128.435 I-3.982 J1.588 E.43662
; OBJECT_ID: 118
; WIPE_START
G1 F6364.704
G1 X123.715 Y128 E-.16543
G1 X123.73 Y127.615 E-.14622
G1 X123.781 Y127.234 E-.14628
G1 X123.867 Y126.859 E-.14628
G1 X123.959 Y126.576 E-.11303
G1 X123.959 Y126.576 E0
G1 X124.001 Y126.472 E-.04276
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X116.369 Y126.505 Z4.4 F9000
G1 X104.382 Y126.557 Z4.4
G1 Z4
G1 E.8 F1800
G1 F1463
G1 X104.363 Y126.079 E.01424
G1 X104.823 Y125.95 E.01424
G1 X104.924 Y125.482 E.01424
G1 X105.402 Y125.471 E.01424
G1 X105.616 Y125.044 E.01424
G1 X106.081 Y125.151 E.01424
G1 X106.394 Y124.79 E.01424
G1 X106.819 Y125.011 E.01424
G1 X107.014 Y124.876 E.00707
G1 X107.212 Y124.739 E.00717
G1 X107.568 Y125.058 E.01424
G1 X108.016 Y124.893 E.01424
G1 X108.282 Y125.29 E.01424
G1 X108.757 Y125.241 E.01424
G1 X108.916 Y125.692 E.01424
G1 X109.389 Y125.763 E.01424
G1 X109.43 Y126.24 E.01424
G1 X109.87 Y126.426 E.01424
G1 X109.792 Y126.897 E.01424
G1 X110.171 Y127.187 E.01424
G1 X109.978 Y127.625 E.01424
G1 X110.274 Y128 E.01424
G1 X109.978 Y128.375 E.01424
G1 X110.171 Y128.813 E.01424
G1 X109.792 Y129.103 E.01424
G1 X109.87 Y129.574 E.01424
G1 X109.43 Y129.76 E.01424
G1 X109.389 Y130.237 E.01424
G1 X108.916 Y130.308 E.01424
G1 X108.757 Y130.759 E.01424
G1 X108.282 Y130.71 E.01424
G1 X108.016 Y131.107 E.01424
G1 X107.568 Y130.942 E.01424
G1 X107.212 Y131.261 E.01424
G1 X106.819 Y130.989 E.01424
G1 X106.394 Y131.21 E.01424
G1 X106.081 Y130.849 E.01424
G1 X105.616 Y130.956 E.01424
G1 X105.402 Y130.529 E.01424
G1 X104.924 Y130.518 E.01424
G1 X104.823 Y130.05 E.01424
G1 X104.363 Y129.921 E.01424
G1 X104.382 Y129.443 E.01424
G1 X103.969 Y129.203 E.01424
G1 X104.106 Y128.745 E.01424
G1 X103.765 Y128.409 E.01424
G1 X104.012 Y128 E.01424
G1 X103.765 Y127.59 E.01424
G1 X104.106 Y127.255 E.01424
G1 X103.969 Y126.797 E.01424
G1 X104.33 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18164
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X106.79 Y124.554 Z4.4 F9000
G1 Z4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1463
G1 X106.356 Y124.329 E.01571
G1 X106.383 Y124.156 E.00562
G3 X107.136 Y124.107 I.652 J4.148 E.02431
G1 X107.189 Y124.278 E.00578
G1 X106.839 Y124.52 E.01368
G1 X107.292 Y124.285 F9000
G1 F1463
G1 X107.362 Y124.123 E.00567
G1 X107.46 Y124.132 E.00316
G3 X108.101 Y124.263 I-.53 J4.214 E.02104
G1 X108.108 Y124.441 E.00572
G1 X107.654 Y124.608 E.01558
G1 X107.337 Y124.325 E.01368
; WIPE_START
G1 F5895.652
G1 X107.362 Y124.123 E-.07727
G1 X107.46 Y124.132 E-.03739
G1 X107.874 Y124.2 E-.15933
G1 X108.101 Y124.263 E-.08939
G1 X108.108 Y124.441 E-.06763
G1 X107.654 Y124.608 E-.18409
G1 X107.37 Y124.354 E-.14491
; WIPE_END
G1 E-.04 F1800
G1 X108.347 Y124.682 Z4.4 F9000
G1 Z4
G1 E.8 F1800
G1 F1463
G1 X108.208 Y124.473 E.00807
G1 X108.318 Y124.334 E.00572
G1 X108.538 Y124.416 E.00756
G3 X108.998 Y124.654 I-1.093 J2.672 E.01666
G1 X108.96 Y124.826 E.00567
G1 X108.477 Y124.876 E.01561
G1 X108.38 Y124.732 E.00558
; WIPE_START
G1 F5895.652
G1 X108.208 Y124.473 E-.11818
G1 X108.318 Y124.334 E-.06763
G1 X108.538 Y124.416 E-.08938
G1 X108.998 Y124.654 E-.19661
G1 X108.96 Y124.826 E-.06699
G1 X108.477 Y124.876 E-.18447
G1 X108.423 Y124.795 E-.03674
; WIPE_END
G1 E-.04 F1800
G1 X109.208 Y125.34 Z4.4 F9000
G1 Z4
G1 E.8 F1800
G1 F1463
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.531 J2.019 E.01455
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
G1 X109.8 Y125.971 F9000
G1 F1463
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01378
G1 X110.217 Y126.729 F9000
G1 F1463
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00562
G1 X110.518 Y126.309 E.0033
G1 X110.628 Y126.566 E.00899
G3 X110.749 Y126.92 I-1.908 J.853 E.01203
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
G1 X110.432 Y127.567 F9000
G1 F1463
G1 X110.628 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.845 J.868 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
G1 X110.432 Y128.433 F9000
G1 F1463
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.944 J-.123 E.0242
G1 X110.629 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
G1 X110.217 Y129.271 F9000
G1 F1463
G1 X110.603 Y128.977 E.01561
G1 X110.749 Y129.08 E.00578
G3 X110.469 Y129.781 I-4.017 J-1.198 E.02431
G1 X110.297 Y129.753 E.00562
G1 X110.227 Y129.33 E.01378
G1 X109.8 Y130.029 F9000
G1 F1463
G1 X110.25 Y129.839 E.01571
G1 X110.366 Y129.978 E.00583
G3 X109.926 Y130.584 I-3.583 J-2.141 E.02409
G1 X109.758 Y130.516 E.00583
G1 X109.795 Y130.089 E.01378
G1 X109.208 Y130.66 F9000
G1 F1463
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.958 J-2.964 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.188 Y130.717 E.01368
G1 X108.745 Y131.152 F9000
G1 F1463
G1 X108.96 Y131.174 E.00694
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.015 J-3.389 E.0242
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.685 Y131.145 E.00674
G1 X107.815 Y131.451 F9000
G1 F1463
G1 X108.108 Y131.559 E.01006
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.101 J-3.786 E.0242
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.758 Y131.43 E.00359
G1 X106.79 Y131.446 F9000
G1 F1463
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.196 E.02431
G1 X106.356 Y131.671 E.00562
G1 X106.737 Y131.474 E.01378
G1 X105.94 Y131.284 F9000
G1 F1463
G1 X106.26 Y131.653 E.01572
G1 X106.163 Y131.806 E.00583
G3 X105.452 Y131.575 I.929 J-4.07 E.02409
G1 X105.464 Y131.394 E.00583
G1 X105.881 Y131.297 E.01379
G1 X105.157 Y130.915 F9000
G1 F1463
G1 X105.375 Y131.352 E.0157
G1 X105.252 Y131.476 E.00562
G3 X104.614 Y131.074 I1.906 J-3.731 E.02431
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
G1 X104.49 Y130.364 F9000
G1 F1463
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.599 J-2.961 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
G1 X103.981 Y129.663 F9000
G1 F1463
G1 X103.962 Y130.147 E.01558
G1 X103.791 Y130.195 E.00572
G3 X103.429 Y129.536 I3.259 J-2.216 E.0242
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
G1 X103.662 Y128.859 F9000
G1 F1463
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G3 X103.158 Y128.594 I3.956 J-1.392 E.02431
G1 X103.314 Y128.516 E.00562
G1 X103.62 Y128.817 E.01378
G1 X103.554 Y128 F9000
G1 F1463
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
G1 X103.662 Y127.141 F9000
G1 F1463
G1 X103.314 Y127.484 E.01571
G1 X103.158 Y127.406 E.00562
G3 X103.344 Y126.674 I4.143 J.661 E.02431
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
G1 X103.981 Y126.337 F9000
G1 F1463
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.619 J1.556 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
G1 X104.49 Y125.636 F9000
G1 F1463
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.115 J2.415 E.0242
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
G1 X105.157 Y125.085 F9000
G1 F1463
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.524 I2.544 J3.329 E.02431
G1 X105.375 Y124.648 E.00562
G1 X105.183 Y125.031 E.01378
G1 X105.94 Y124.716 F9000
G1 F1463
G1 X105.464 Y124.606 E.01572
G1 X105.452 Y124.425 E.00583
G3 X106.163 Y124.194 I1.64 J3.838 E.02409
G1 X106.26 Y124.347 E.00583
G1 X105.979 Y124.671 E.01379
; WIPE_START
G1 F5895.652
G1 X105.464 Y124.606 E-.19742
G1 X105.452 Y124.425 E-.06891
G1 X105.802 Y124.293 E-.14227
G1 X106.163 Y124.194 E-.14235
G1 X106.26 Y124.347 E-.06891
G1 X106.018 Y124.626 E-.14014
; WIPE_END
G1 E-.04 F1800
G1 X102.734 Y128.376 Z4.4 F9000
G1 Z4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1463
G1 X102.72 Y128 E.0112
G3 X102.963 Y126.576 I4.287 J0 E.04324
G3 X107.495 Y123.741 I4.036 J1.412 E.172
G3 X110.989 Y126.412 I-.494 J4.266 E.13751
G3 X102.742 Y128.435 I-3.982 J1.588 E.43662
; WIPE_START
G1 F6364.704
G1 X102.72 Y128 E-.16543
G1 X102.734 Y127.615 E-.14622
G1 X102.786 Y127.234 E-.14628
G1 X102.872 Y126.859 E-.14628
G1 X102.963 Y126.576 E-.11303
G1 X102.963 Y126.576 E0
G1 X103.006 Y126.472 E-.04277
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.4 I1.217 J0 P1  F9000
; stop printing object, unique label id: 118
M625
; object ids of layer 20 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.4
M73 P94 R1
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4.4 F4000
            G39.3 S1
            G0 Z4.4 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END


; object ids of this layer20 end: 82,118
M625
; CHANGE_LAYER
; Z_HEIGHT: 4.2
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 21/23
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F9000
G1 Z4.2
G1 E.8 F1800
G1 F1463
G1 X125.359 Y126.079 E.01424
G1 X125.819 Y125.95 E.01424
G1 X125.92 Y125.482 E.01424
G1 X126.397 Y125.471 E.01424
G1 X126.611 Y125.044 E.01424
G1 X127.077 Y125.151 E.01424
G1 X127.39 Y124.79 E.01424
G1 X127.814 Y125.011 E.01424
G1 X128.03 Y124.862 E.00781
G1 X128.207 Y124.739 E.00642
G1 X128.563 Y125.058 E.01424
G1 X129.012 Y124.893 E.01424
G1 X129.277 Y125.29 E.01424
G1 X129.753 Y125.241 E.01424
G1 X129.911 Y125.692 E.01424
G1 X130.384 Y125.763 E.01424
G1 X130.425 Y126.24 E.01424
G1 X130.865 Y126.426 E.01424
G1 X130.787 Y126.897 E.01424
G1 X131.167 Y127.187 E.01424
G1 X130.974 Y127.625 E.01424
G1 X131.27 Y128 E.01424
G1 X130.974 Y128.375 E.01424
G1 X131.167 Y128.813 E.01424
G1 X130.787 Y129.103 E.01424
G1 X130.865 Y129.574 E.01424
G1 X130.425 Y129.76 E.01424
G1 X130.384 Y130.237 E.01424
G1 X129.911 Y130.308 E.01424
G1 X129.753 Y130.759 E.01424
G1 X129.277 Y130.71 E.01424
G1 X129.012 Y131.107 E.01424
G1 X128.563 Y130.942 E.01424
G1 X128.207 Y131.261 E.01424
G1 X127.814 Y130.989 E.01424
G1 X127.39 Y131.21 E.01424
G1 X127.077 Y130.849 E.01424
G1 X126.611 Y130.956 E.01424
G1 X126.397 Y130.529 E.01424
G1 X125.92 Y130.518 E.01424
G1 X125.819 Y130.05 E.01424
G1 X125.359 Y129.921 E.01424
G1 X125.378 Y129.443 E.01424
G1 X124.964 Y129.203 E.01424
G1 X125.101 Y128.745 E.01424
G1 X124.761 Y128.409 E.01424
G1 X125.007 Y128 E.01424
G1 X124.761 Y127.59 E.01424
G1 X125.101 Y127.255 E.01424
G1 X124.964 Y126.797 E.01424
G1 X125.326 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18164
G1 X125.92 Y125.482 E-.18164
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02174
; WIPE_END
G1 E-.04 F1800
G1 X127.785 Y124.554 Z4.6 F9000
G1 Z4.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1463
G1 X127.352 Y124.329 E.01571
G1 X127.378 Y124.156 E.00562
G3 X128.131 Y124.107 I.652 J4.147 E.02431
G1 X128.185 Y124.278 E.00578
G1 X127.835 Y124.52 E.01368
G1 X128.288 Y124.285 F9000
G1 F1463
G1 X128.358 Y124.123 E.00567
G1 X128.488 Y124.135 E.0042
G3 X129.096 Y124.263 I-.648 J4.575 E.02
G1 X129.104 Y124.441 E.00572
G1 X128.649 Y124.608 E.01558
G1 X128.332 Y124.325 E.01368
; WIPE_START
G1 F5895.652
G1 X128.358 Y124.123 E-.07726
G1 X128.488 Y124.135 E-.04966
G1 X128.869 Y124.2 E-.1471
G1 X129.096 Y124.263 E-.08939
G1 X129.104 Y124.441 E-.06763
G1 X128.649 Y124.608 E-.18409
G1 X128.365 Y124.354 E-.14487
; WIPE_END
G1 E-.04 F1800
G1 X129.358 Y124.704 Z4.6 F9000
G1 Z4.2
G1 E.8 F1800
G1 F1463
G1 X129.203 Y124.473 E.00895
G1 X129.314 Y124.334 E.00572
G1 X129.534 Y124.416 E.00756
G3 X129.993 Y124.654 I-1.094 J2.674 E.01666
G1 X129.955 Y124.826 E.00567
G1 X129.472 Y124.876 E.01561
G1 X129.391 Y124.754 E.0047
; WIPE_START
G1 F5895.652
G1 X129.203 Y124.473 E-.12853
G1 X129.314 Y124.334 E-.06763
G1 X129.534 Y124.416 E-.08936
G1 X129.993 Y124.654 E-.19665
G1 X129.955 Y124.826 E-.06699
G1 X129.472 Y124.876 E-.18447
G1 X129.434 Y124.818 E-.02637
; WIPE_END
G1 E-.04 F1800
G1 X130.203 Y125.34 Z4.6 F9000
G1 Z4.2
G1 E.8 F1800
G1 F1463
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.533 J2.02 E.01456
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
G1 X130.796 Y125.971 F9000
G1 F1463
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01379
G1 X131.212 Y126.729 F9000
G1 F1463
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00561
G1 X131.514 Y126.309 E.0033
G3 X131.745 Y126.92 I-3.278 J1.591 E.02103
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
G1 X131.428 Y127.567 F9000
G1 F1463
G1 X131.624 Y127.123 E.01561
G1 X131.799 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.845 J.868 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
G1 X131.428 Y128.433 F9000
G1 F1463
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.799 Y128.86 I-3.943 J-.123 E.02421
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
G1 X131.212 Y129.271 F9000
G1 F1463
G1 X131.598 Y128.976 E.01561
G1 X131.745 Y129.08 E.00578
G3 X131.465 Y129.781 I-4.02 J-1.199 E.02431
G1 X131.293 Y129.753 E.00562
G1 X131.222 Y129.33 E.01378
G1 X130.796 Y130.029 F9000
G1 F1463
G1 X131.246 Y129.839 E.01571
G1 X131.362 Y129.978 E.00583
G3 X130.922 Y130.584 I-3.582 J-2.14 E.02409
G1 X130.753 Y130.516 E.00583
G1 X130.79 Y130.089 E.01379
G1 X130.203 Y130.66 F9000
G1 F1463
G1 X130.686 Y130.588 E.01571
G1 X130.767 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.958 J-2.963 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.183 Y130.717 E.01368
G1 X129.741 Y131.152 F9000
G1 F1463
G1 X129.955 Y131.174 E.00694
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.014 J-3.389 E.02421
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00674
G1 X128.81 Y131.451 F9000
G1 F1463
G1 X129.104 Y131.559 E.01006
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.101 J-3.786 E.02421
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.00359
G1 X127.785 Y131.446 F9000
G1 F1463
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.196 E.02431
G1 X127.352 Y131.671 E.00562
G1 X127.732 Y131.474 E.01378
G1 X126.935 Y131.284 F9000
G1 F1463
G1 X127.256 Y131.653 E.01571
G1 X127.159 Y131.806 E.00583
G3 X126.447 Y131.575 I.929 J-4.069 E.02409
G1 X126.459 Y131.394 E.00583
G1 X126.877 Y131.297 E.01379
G1 X126.152 Y130.915 F9000
G1 F1463
G1 X126.37 Y131.352 E.0157
G1 X126.248 Y131.477 E.00562
G3 X125.609 Y131.074 I1.907 J-3.734 E.02431
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
G1 X125.485 Y130.364 F9000
G1 F1463
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.6 J-2.962 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
G1 X124.977 Y129.663 F9000
G1 F1463
G1 X124.958 Y130.147 E.01558
G1 X124.786 Y130.195 E.00572
G3 X124.425 Y129.536 I3.259 J-2.216 E.0242
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
G1 X124.658 Y128.859 F9000
G1 F1463
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G3 X124.154 Y128.594 I3.95 J-1.391 E.02431
G1 X124.31 Y128.516 E.00562
G1 X124.615 Y128.817 E.01378
G1 X124.549 Y128 F9000
G1 F1463
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
G1 X124.658 Y127.141 F9000
G1 F1463
G1 X124.31 Y127.484 E.01571
G1 X124.154 Y127.406 E.00562
G3 X124.339 Y126.674 I4.14 J.66 E.02431
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
G1 X124.977 Y126.337 F9000
G1 F1463
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.621 J1.557 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
G1 X125.485 Y125.636 F9000
G1 F1463
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.113 J2.413 E.02421
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
G1 X126.152 Y125.085 F9000
G1 F1463
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.523 I2.546 J3.33 E.02431
G1 X126.371 Y124.648 E.00562
G1 X126.179 Y125.031 E.01378
G1 X126.935 Y124.716 F9000
G1 F1463
G1 X126.459 Y124.606 E.01571
G1 X126.447 Y124.425 E.00583
G3 X127.159 Y124.194 I1.64 J3.837 E.02409
G1 X127.256 Y124.347 E.00583
G1 X126.975 Y124.671 E.01379
; WIPE_START
G1 F5895.652
G1 X126.459 Y124.606 E-.1974
G1 X126.447 Y124.425 E-.06891
G1 X126.798 Y124.293 E-.14233
G1 X127.159 Y124.194 E-.14228
G1 X127.256 Y124.347 E-.06891
G1 X127.014 Y124.626 E-.14018
; WIPE_END
G1 E-.04 F1800
G1 X123.729 Y128.37 Z4.6 F9000
G1 Z4.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1463
G1 X123.706 Y128 E.01105
G3 X127.426 Y123.749 I4.288 J-.001 E.1837
G3 X128.523 Y123.744 I.569 J4.681 E.03274
G3 X123.728 Y128.429 I-.529 J4.255 E.57325
; OBJECT_ID: 118
; WIPE_START
G1 F6364.704
G1 X123.706 Y128 E-.16323
G1 X123.73 Y127.616 E-.14635
G1 X123.781 Y127.234 E-.14636
G1 X123.867 Y126.859 E-.14624
G1 X123.986 Y126.493 E-.14627
G1 X123.998 Y126.465 E-.01156
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X116.366 Y126.501 Z4.6 F9000
G1 X104.382 Y126.557 Z4.6
G1 Z4.2
G1 E.8 F1800
G1 F1463
G1 X104.363 Y126.079 E.01424
G1 X104.823 Y125.95 E.01424
G1 X104.924 Y125.482 E.01424
G1 X105.402 Y125.471 E.01424
G1 X105.616 Y125.044 E.01424
G1 X106.081 Y125.151 E.01424
G1 X106.394 Y124.79 E.01424
G1 X106.819 Y125.011 E.01424
G1 X107.034 Y124.862 E.00781
G1 X107.212 Y124.739 E.00642
G1 X107.568 Y125.058 E.01424
G1 X108.016 Y124.893 E.01424
G1 X108.282 Y125.29 E.01424
G1 X108.757 Y125.241 E.01424
G1 X108.916 Y125.692 E.01424
G1 X109.389 Y125.763 E.01424
G1 X109.43 Y126.24 E.01424
G1 X109.87 Y126.426 E.01424
G1 X109.792 Y126.897 E.01424
G1 X110.171 Y127.187 E.01424
G1 X109.978 Y127.625 E.01424
G1 X110.274 Y128 E.01424
G1 X109.978 Y128.375 E.01424
G1 X110.171 Y128.813 E.01424
G1 X109.791 Y129.103 E.01424
G1 X109.87 Y129.574 E.01424
G1 X109.43 Y129.76 E.01424
G1 X109.389 Y130.237 E.01424
G1 X108.916 Y130.308 E.01424
G1 X108.757 Y130.759 E.01424
G1 X108.282 Y130.71 E.01424
G1 X108.016 Y131.107 E.01424
G1 X107.568 Y130.942 E.01424
G1 X107.212 Y131.261 E.01424
G1 X106.819 Y130.989 E.01424
G1 X106.394 Y131.21 E.01424
G1 X106.081 Y130.849 E.01424
G1 X105.616 Y130.956 E.01424
G1 X105.402 Y130.529 E.01424
G1 X104.924 Y130.518 E.01424
G1 X104.823 Y130.05 E.01424
G1 X104.363 Y129.921 E.01424
G1 X104.382 Y129.443 E.01424
G1 X103.969 Y129.203 E.01424
G1 X104.106 Y128.745 E.01424
G1 X103.765 Y128.409 E.01424
G1 X104.012 Y128 E.01424
G1 X103.765 Y127.59 E.01424
G1 X104.106 Y127.255 E.01424
G1 X103.969 Y126.797 E.01424
G1 X104.33 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18164
G1 X104.924 Y125.482 E-.18164
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02174
; WIPE_END
G1 E-.04 F1800
G1 X106.79 Y124.554 Z4.6 F9000
G1 Z4.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1463
G1 X106.356 Y124.329 E.01571
G1 X106.383 Y124.156 E.00562
G3 X107.136 Y124.107 I.652 J4.147 E.02431
G1 X107.189 Y124.278 E.00578
G1 X106.839 Y124.52 E.01368
G1 X107.292 Y124.285 F9000
G1 F1463
G1 X107.362 Y124.123 E.00567
G1 X107.493 Y124.135 E.0042
G3 X108.101 Y124.263 I-.648 J4.575 E.02
G1 X108.108 Y124.441 E.00572
G1 X107.654 Y124.608 E.01558
G1 X107.337 Y124.325 E.01368
; WIPE_START
G1 F5895.652
G1 X107.362 Y124.123 E-.07726
G1 X107.493 Y124.135 E-.04966
G1 X107.874 Y124.2 E-.1471
G1 X108.101 Y124.263 E-.08939
G1 X108.108 Y124.441 E-.06763
G1 X107.654 Y124.608 E-.18409
G1 X107.37 Y124.354 E-.14487
; WIPE_END
G1 E-.04 F1800
G1 X108.362 Y124.704 Z4.6 F9000
G1 Z4.2
G1 E.8 F1800
G1 F1463
G1 X108.208 Y124.473 E.00895
G1 X108.318 Y124.334 E.00572
G1 X108.538 Y124.416 E.00756
G3 X108.998 Y124.654 I-1.094 J2.674 E.01666
G1 X108.96 Y124.826 E.00567
G1 X108.477 Y124.876 E.01561
G1 X108.396 Y124.754 E.0047
; WIPE_START
G1 F5895.652
G1 X108.208 Y124.473 E-.12853
G1 X108.318 Y124.334 E-.06763
G1 X108.538 Y124.416 E-.08936
G1 X108.998 Y124.654 E-.19665
G1 X108.96 Y124.826 E-.06699
G1 X108.477 Y124.876 E-.18447
G1 X108.438 Y124.818 E-.02637
; WIPE_END
G1 E-.04 F1800
G1 X109.208 Y125.34 Z4.6 F9000
G1 Z4.2
G1 E.8 F1800
G1 F1463
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.533 J2.02 E.01456
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
G1 X109.8 Y125.971 F9000
G1 F1463
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01379
G1 X110.217 Y126.729 F9000
G1 F1463
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00561
G1 X110.518 Y126.309 E.0033
G3 X110.749 Y126.92 I-3.278 J1.591 E.02103
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
G1 X110.432 Y127.567 F9000
G1 F1463
G1 X110.628 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.845 J.868 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
G1 X110.432 Y128.433 F9000
G1 F1463
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.943 J-.123 E.02421
G1 X110.628 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
G1 X110.217 Y129.271 F9000
G1 F1463
G1 X110.603 Y128.976 E.01561
G1 X110.749 Y129.08 E.00578
G3 X110.469 Y129.781 I-4.02 J-1.199 E.02431
G1 X110.297 Y129.753 E.00562
G1 X110.227 Y129.33 E.01378
G1 X109.8 Y130.029 F9000
G1 F1463
G1 X110.25 Y129.839 E.01571
G1 X110.366 Y129.978 E.00583
G3 X109.926 Y130.584 I-3.582 J-2.14 E.02409
G1 X109.758 Y130.516 E.00583
G1 X109.795 Y130.089 E.01379
G1 X109.208 Y130.66 F9000
G1 F1463
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.958 J-2.963 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.188 Y130.717 E.01368
G1 X108.745 Y131.152 F9000
G1 F1463
G1 X108.96 Y131.174 E.00694
M73 P95 R1
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.014 J-3.389 E.02421
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.685 Y131.145 E.00674
G1 X107.815 Y131.451 F9000
G1 F1463
G1 X108.108 Y131.559 E.01006
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.101 J-3.786 E.02421
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.758 Y131.43 E.00359
G1 X106.79 Y131.446 F9000
G1 F1463
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.196 E.02431
G1 X106.356 Y131.671 E.00562
G1 X106.737 Y131.474 E.01378
G1 X105.94 Y131.284 F9000
G1 F1463
G1 X106.26 Y131.653 E.01571
G1 X106.163 Y131.806 E.00583
G3 X105.452 Y131.575 I.929 J-4.069 E.02409
G1 X105.464 Y131.394 E.00583
G1 X105.881 Y131.297 E.01379
G1 X105.157 Y130.915 F9000
G1 F1463
G1 X105.375 Y131.352 E.0157
G1 X105.252 Y131.477 E.00562
G3 X104.614 Y131.074 I1.907 J-3.734 E.02431
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
G1 X104.49 Y130.364 F9000
G1 F1463
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.6 J-2.962 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
G1 X103.981 Y129.663 F9000
G1 F1463
G1 X103.962 Y130.147 E.01558
G1 X103.791 Y130.195 E.00572
G3 X103.429 Y129.536 I3.259 J-2.216 E.0242
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
G1 X103.662 Y128.859 F9000
G1 F1463
M73 P95 R0
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G3 X103.158 Y128.594 I3.95 J-1.391 E.02431
G1 X103.314 Y128.516 E.00562
G1 X103.62 Y128.817 E.01378
G1 X103.554 Y128 F9000
G1 F1463
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
G1 X103.662 Y127.141 F9000
G1 F1463
G1 X103.314 Y127.484 E.01571
G1 X103.158 Y127.406 E.00562
G3 X103.344 Y126.674 I4.14 J.66 E.02431
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
G1 X103.981 Y126.337 F9000
G1 F1463
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.621 J1.557 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
G1 X104.49 Y125.636 F9000
G1 F1463
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.113 J2.413 E.02421
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
G1 X105.157 Y125.085 F9000
G1 F1463
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.523 I2.546 J3.33 E.02431
G1 X105.375 Y124.648 E.00562
G1 X105.183 Y125.031 E.01378
G1 X105.94 Y124.716 F9000
G1 F1463
G1 X105.464 Y124.606 E.01571
G1 X105.452 Y124.425 E.00583
G3 X106.163 Y124.194 I1.64 J3.837 E.02409
G1 X106.26 Y124.347 E.00583
G1 X105.979 Y124.671 E.01379
; WIPE_START
G1 F5895.652
G1 X105.464 Y124.606 E-.1974
G1 X105.452 Y124.425 E-.06891
G1 X105.802 Y124.293 E-.14233
G1 X106.163 Y124.194 E-.14228
G1 X106.26 Y124.347 E-.06891
G1 X106.018 Y124.626 E-.14018
; WIPE_END
G1 E-.04 F1800
G1 X102.734 Y128.37 Z4.6 F9000
G1 Z4.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1463
G1 X102.71 Y128 E.01105
G3 X106.431 Y123.749 I4.288 J-.001 E.1837
G3 X107.528 Y123.744 I.569 J4.681 E.03274
G3 X102.732 Y128.429 I-.529 J4.255 E.57325
; WIPE_START
G1 F6364.704
G1 X102.71 Y128 E-.16323
G1 X102.734 Y127.616 E-.14635
G1 X102.786 Y127.234 E-.14636
G1 X102.872 Y126.859 E-.14624
G1 X102.99 Y126.493 E-.14627
G1 X103.002 Y126.465 E-.01156
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.6 I1.217 J0 P1  F9000
; stop printing object, unique label id: 118
M625
; object ids of layer 21 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.6
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4.6 F4000
            G39.3 S1
            G0 Z4.6 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END


; object ids of this layer21 end: 82,118
M625
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 22/23
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F9000
G1 Z4.4
G1 E.8 F1800
G1 F1435
G1 X125.359 Y126.079 E.01424
G1 X125.819 Y125.95 E.01424
G1 X125.92 Y125.482 E.01424
G1 X126.397 Y125.471 E.01424
G1 X126.611 Y125.044 E.01424
G1 X127.077 Y125.151 E.01424
G1 X127.39 Y124.79 E.01424
G1 X127.814 Y125.011 E.01424
G1 X128.207 Y124.739 E.01424
G1 X128.563 Y125.058 E.01424
G1 X129.012 Y124.893 E.01424
G1 X129.277 Y125.29 E.01424
G1 X129.753 Y125.241 E.01424
G1 X129.911 Y125.692 E.01424
G1 X130.384 Y125.763 E.01424
G1 X130.425 Y126.24 E.01424
G1 X130.865 Y126.426 E.01424
G1 X130.787 Y126.897 E.01424
G1 X131.167 Y127.187 E.01424
G1 X130.974 Y127.625 E.01424
G1 X131.27 Y128 E.01424
G1 X130.974 Y128.375 E.01424
G1 X131.167 Y128.813 E.01424
G1 X130.787 Y129.103 E.01424
G1 X130.865 Y129.574 E.01424
G1 X130.425 Y129.76 E.01424
G1 X130.384 Y130.237 E.01424
G1 X129.911 Y130.308 E.01424
G1 X129.753 Y130.759 E.01424
G1 X129.277 Y130.71 E.01424
G1 X129.012 Y131.107 E.01424
G1 X128.563 Y130.942 E.01424
G1 X128.207 Y131.261 E.01424
G1 X127.814 Y130.989 E.01424
G1 X127.39 Y131.21 E.01424
G1 X127.077 Y130.849 E.01424
G1 X126.611 Y130.956 E.01424
G1 X126.397 Y130.529 E.01424
G1 X125.92 Y130.518 E.01424
G1 X125.819 Y130.05 E.01424
G1 X125.359 Y129.921 E.01424
G1 X125.378 Y129.443 E.01424
G1 X124.964 Y129.203 E.01424
G1 X125.101 Y128.745 E.01424
G1 X124.761 Y128.409 E.01424
G1 X125.007 Y128 E.01424
G1 X124.761 Y127.59 E.01424
G1 X125.101 Y127.255 E.01424
G1 X124.964 Y126.797 E.01424
G1 X125.326 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18164
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X127.785 Y124.554 Z4.8 F9000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1435
G1 X127.352 Y124.329 E.0157
G1 X127.378 Y124.156 E.00561
G3 X128.131 Y124.107 I.651 J4.133 E.02431
G1 X128.185 Y124.278 E.00578
G1 X127.835 Y124.52 E.01368
G1 X128.288 Y124.285 F9000
G1 F1435
G1 X128.358 Y124.123 E.00567
G1 X128.525 Y124.138 E.00541
G3 X129.096 Y124.263 I-.409 J3.231 E.01881
G1 X129.104 Y124.441 E.00572
G1 X128.649 Y124.608 E.01558
G1 X128.332 Y124.325 E.01368
; WIPE_START
G1 F5895.652
G1 X128.358 Y124.123 E-.07726
G1 X128.525 Y124.138 E-.06395
G1 X128.869 Y124.2 E-.13284
G1 X129.096 Y124.263 E-.08941
G1 X129.104 Y124.441 E-.06762
G1 X128.649 Y124.608 E-.18409
G1 X128.365 Y124.354 E-.14482
; WIPE_END
G1 E-.04 F1800
G1 X129.372 Y124.725 Z4.8 F9000
G1 Z4.4
G1 E.8 F1800
G1 F1435
G1 X129.203 Y124.473 E.00976
G1 X129.314 Y124.334 E.00572
G1 X129.534 Y124.416 E.00756
G3 X129.993 Y124.654 I-1.092 J2.671 E.01666
G1 X129.955 Y124.826 E.00567
G1 X129.472 Y124.876 E.01561
G1 X129.405 Y124.775 E.00389
G1 X130.203 Y125.34 F9000
G1 F1435
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.53 J2.017 E.01456
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
G1 X130.796 Y125.971 F9000
G1 F1435
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01378
G1 X131.213 Y126.729 F9000
G1 F1435
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00562
G1 X131.514 Y126.309 E.0033
G3 X131.745 Y126.92 I-3.276 J1.59 E.02103
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
G1 X131.428 Y127.567 F9000
G1 F1435
G1 X131.624 Y127.123 E.01561
G1 X131.8 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.847 J.869 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
G1 X131.428 Y128.433 F9000
G1 F1435
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.8 Y128.86 I-3.942 J-.123 E.0242
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
G1 X131.213 Y129.271 F9000
G1 F1435
G1 X131.598 Y128.977 E.01561
G1 X131.745 Y129.08 E.00578
G3 X131.465 Y129.781 I-4.024 J-1.201 E.0243
G1 X131.293 Y129.753 E.00562
G1 X131.222 Y129.33 E.01378
G1 X130.796 Y130.029 F9000
G1 F1435
G1 X131.245 Y129.839 E.01571
G1 X131.361 Y129.978 E.00583
G3 X130.922 Y130.584 I-3.582 J-2.14 E.02409
G1 X130.753 Y130.516 E.00583
G1 X130.79 Y130.089 E.01378
G1 X130.203 Y130.66 F9000
G1 F1435
G1 X130.686 Y130.588 E.01571
G1 X130.767 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.958 J-2.963 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.183 Y130.717 E.01368
G1 X129.741 Y131.152 F9000
G1 F1435
G1 X129.955 Y131.174 E.00694
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.014 J-3.389 E.0242
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00674
G1 X128.81 Y131.451 F9000
G1 F1435
G1 X129.104 Y131.559 E.01006
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.1 J-3.784 E.0242
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.00359
G1 X127.785 Y131.446 F9000
G1 F1435
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.191 E.02431
G1 X127.352 Y131.671 E.00562
G1 X127.732 Y131.474 E.01378
G1 X126.935 Y131.284 F9000
G1 F1435
G1 X127.256 Y131.653 E.01571
G1 X127.159 Y131.806 E.00583
G3 X126.447 Y131.575 I.928 J-4.068 E.02409
G1 X126.459 Y131.394 E.00583
G1 X126.877 Y131.297 E.01379
G1 X126.152 Y130.915 F9000
G1 F1435
G1 X126.37 Y131.352 E.01571
G1 X126.248 Y131.477 E.00562
G3 X125.609 Y131.074 I1.91 J-3.738 E.0243
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
G1 X125.485 Y130.364 F9000
G1 F1435
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.599 J-2.961 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
G1 X124.977 Y129.663 F9000
G1 F1435
G1 X124.958 Y130.147 E.01558
G1 X124.786 Y130.195 E.00572
G3 X124.425 Y129.536 I3.259 J-2.216 E.0242
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
G1 X124.658 Y128.859 F9000
G1 F1435
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G3 X124.154 Y128.594 I3.958 J-1.393 E.02431
G1 X124.31 Y128.516 E.00562
G1 X124.615 Y128.817 E.01378
G1 X124.549 Y128 F9000
G1 F1435
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
G1 X124.658 Y127.141 F9000
G1 F1435
G1 X124.31 Y127.484 E.01571
G1 X124.154 Y127.406 E.00562
G3 X124.339 Y126.674 I4.139 J.66 E.02431
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
G1 X124.977 Y126.337 F9000
G1 F1435
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.619 J1.556 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
G1 X125.485 Y125.636 F9000
G1 F1435
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.114 J2.414 E.0242
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
G1 X126.152 Y125.085 F9000
G1 F1435
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.524 I2.544 J3.328 E.02431
G1 X126.37 Y124.648 E.00562
G1 X126.179 Y125.031 E.01378
G1 X126.935 Y124.716 F9000
G1 F1435
G1 X126.459 Y124.606 E.01571
G1 X126.447 Y124.425 E.00583
G3 X127.159 Y124.194 I1.64 J3.835 E.02409
G1 X127.256 Y124.347 E.00583
G1 X126.975 Y124.671 E.01379
; WIPE_START
G1 F5895.652
G1 X126.459 Y124.606 E-.19739
G1 X126.447 Y124.425 E-.06891
G1 X126.798 Y124.293 E-.14226
G1 X127.159 Y124.194 E-.14233
G1 X127.256 Y124.347 E-.06891
G1 X127.014 Y124.626 E-.1402
; WIPE_END
G1 E-.04 F1800
G1 X123.729 Y128.365 Z4.8 F9000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1435
G1 X123.709 Y128 E.0109
G3 X127.81 Y123.715 I4.288 J-.002 E.1951
G3 X128.555 Y123.747 I.192 J4.157 E.02226
G3 X123.731 Y128.425 I-.559 J4.251 E.5724
; OBJECT_ID: 118
; WIPE_START
G1 F6364.704
G1 X123.709 Y128 E-.1617
G1 X123.73 Y127.616 E-.14628
G1 X123.781 Y127.234 E-.14636
G1 X123.867 Y126.859 E-.14624
G1 X123.986 Y126.493 E-.14624
G1 X124 Y126.461 E-.01319
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X116.367 Y126.498 Z4.8 F9000
G1 X104.382 Y126.557 Z4.8
G1 Z4.4
G1 E.8 F1800
G1 F1435
G1 X104.363 Y126.079 E.01424
G1 X104.823 Y125.95 E.01424
G1 X104.924 Y125.482 E.01424
G1 X105.402 Y125.471 E.01424
G1 X105.616 Y125.044 E.01424
G1 X106.081 Y125.151 E.01424
G1 X106.394 Y124.79 E.01424
G1 X106.819 Y125.011 E.01424
G1 X107.212 Y124.739 E.01424
G1 X107.568 Y125.058 E.01424
G1 X108.016 Y124.893 E.01424
G1 X108.282 Y125.29 E.01424
G1 X108.757 Y125.241 E.01424
G1 X108.916 Y125.692 E.01424
G1 X109.389 Y125.763 E.01424
G1 X109.43 Y126.24 E.01424
G1 X109.87 Y126.426 E.01424
G1 X109.792 Y126.897 E.01424
G1 X110.171 Y127.187 E.01424
G1 X109.978 Y127.625 E.01424
G1 X110.274 Y128 E.01424
G1 X109.978 Y128.375 E.01424
G1 X110.171 Y128.813 E.01424
G1 X109.792 Y129.103 E.01424
G1 X109.87 Y129.574 E.01424
G1 X109.43 Y129.76 E.01424
G1 X109.389 Y130.237 E.01424
G1 X108.916 Y130.308 E.01424
G1 X108.757 Y130.759 E.01424
G1 X108.282 Y130.71 E.01424
G1 X108.016 Y131.107 E.01424
G1 X107.568 Y130.942 E.01424
G1 X107.212 Y131.261 E.01424
G1 X106.819 Y130.989 E.01424
G1 X106.394 Y131.21 E.01424
G1 X106.081 Y130.849 E.01424
G1 X105.616 Y130.956 E.01424
G1 X105.402 Y130.529 E.01424
G1 X104.924 Y130.518 E.01424
G1 X104.823 Y130.05 E.01424
G1 X104.363 Y129.921 E.01424
G1 X104.382 Y129.443 E.01424
G1 X103.969 Y129.203 E.01424
G1 X104.106 Y128.745 E.01424
G1 X103.765 Y128.409 E.01424
G1 X104.012 Y128 E.01424
G1 X103.765 Y127.59 E.01424
G1 X104.106 Y127.255 E.01424
G1 X103.969 Y126.797 E.01424
G1 X104.33 Y126.587 E.01245
; WIPE_START
G1 F6364.704
M73 P96 R0
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18164
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X106.79 Y124.554 Z4.8 F9000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1435
G1 X106.357 Y124.329 E.0157
G1 X106.383 Y124.156 E.00561
G3 X107.136 Y124.107 I.651 J4.133 E.02431
G1 X107.189 Y124.278 E.00578
G1 X106.839 Y124.52 E.01368
G1 X107.292 Y124.285 F9000
G1 F1435
G1 X107.362 Y124.123 E.00567
G1 X107.53 Y124.138 E.00541
G3 X108.101 Y124.263 I-.409 J3.231 E.01881
G1 X108.108 Y124.441 E.00572
G1 X107.654 Y124.608 E.01558
G1 X107.337 Y124.325 E.01368
; WIPE_START
G1 F5895.652
G1 X107.362 Y124.123 E-.07726
G1 X107.53 Y124.138 E-.06395
G1 X107.874 Y124.2 E-.13284
G1 X108.101 Y124.263 E-.08941
G1 X108.108 Y124.441 E-.06762
G1 X107.654 Y124.608 E-.18409
G1 X107.37 Y124.354 E-.14482
; WIPE_END
G1 E-.04 F1800
G1 X108.376 Y124.725 Z4.8 F9000
G1 Z4.4
G1 E.8 F1800
G1 F1435
G1 X108.208 Y124.473 E.00976
G1 X108.318 Y124.334 E.00572
G1 X108.538 Y124.416 E.00756
G3 X108.998 Y124.654 I-1.092 J2.671 E.01666
G1 X108.96 Y124.826 E.00567
G1 X108.477 Y124.876 E.01561
G1 X108.41 Y124.775 E.00389
G1 X109.208 Y125.34 F9000
G1 F1435
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.53 J2.017 E.01456
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
G1 X109.8 Y125.971 F9000
G1 F1435
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01378
G1 X110.217 Y126.729 F9000
G1 F1435
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00562
G1 X110.518 Y126.309 E.0033
G3 X110.749 Y126.92 I-3.276 J1.59 E.02103
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
G1 X110.432 Y127.567 F9000
G1 F1435
G1 X110.629 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.847 J.869 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
G1 X110.432 Y128.433 F9000
G1 F1435
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.942 J-.123 E.0242
G1 X110.629 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
G1 X110.217 Y129.271 F9000
G1 F1435
G1 X110.603 Y128.977 E.01561
G1 X110.749 Y129.08 E.00578
G3 X110.47 Y129.781 I-4.024 J-1.201 E.0243
G1 X110.297 Y129.753 E.00562
G1 X110.227 Y129.33 E.01378
G1 X109.8 Y130.029 F9000
G1 F1435
G1 X110.25 Y129.839 E.01571
G1 X110.366 Y129.978 E.00583
G3 X109.926 Y130.584 I-3.582 J-2.14 E.02409
G1 X109.758 Y130.516 E.00583
G1 X109.795 Y130.089 E.01378
G1 X109.208 Y130.66 F9000
G1 F1435
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.958 J-2.963 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.188 Y130.717 E.01368
G1 X108.745 Y131.152 F9000
G1 F1435
G1 X108.96 Y131.174 E.00694
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.014 J-3.389 E.0242
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.685 Y131.145 E.00674
G1 X107.815 Y131.451 F9000
G1 F1435
G1 X108.108 Y131.559 E.01006
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.1 J-3.784 E.0242
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.758 Y131.43 E.00359
G1 X106.79 Y131.446 F9000
G1 F1435
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.191 E.02431
G1 X106.356 Y131.671 E.00562
G1 X106.737 Y131.474 E.01378
G1 X105.94 Y131.284 F9000
G1 F1435
G1 X106.26 Y131.653 E.01571
G1 X106.163 Y131.806 E.00583
G3 X105.452 Y131.575 I.928 J-4.068 E.02409
G1 X105.464 Y131.394 E.00583
G1 X105.881 Y131.297 E.01379
G1 X105.157 Y130.915 F9000
G1 F1435
G1 X105.375 Y131.352 E.01571
G1 X105.252 Y131.477 E.00562
G3 X104.614 Y131.074 I1.91 J-3.738 E.0243
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
G1 X104.49 Y130.364 F9000
G1 F1435
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.599 J-2.961 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
G1 X103.981 Y129.663 F9000
G1 F1435
G1 X103.962 Y130.147 E.01558
G1 X103.791 Y130.195 E.00572
G3 X103.429 Y129.536 I3.259 J-2.216 E.0242
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
G1 X103.662 Y128.859 F9000
G1 F1435
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G3 X103.158 Y128.594 I3.958 J-1.393 E.02431
G1 X103.314 Y128.516 E.00562
G1 X103.62 Y128.817 E.01378
G1 X103.554 Y128 F9000
G1 F1435
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
G1 X103.662 Y127.141 F9000
G1 F1435
G1 X103.314 Y127.484 E.01571
G1 X103.158 Y127.406 E.00562
G3 X103.344 Y126.674 I4.139 J.66 E.02431
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
G1 X103.981 Y126.337 F9000
G1 F1435
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.619 J1.556 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
G1 X104.49 Y125.636 F9000
G1 F1435
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.114 J2.414 E.0242
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
G1 X105.157 Y125.085 F9000
G1 F1435
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.524 I2.544 J3.328 E.02431
G1 X105.375 Y124.648 E.00562
G1 X105.183 Y125.031 E.01378
G1 X105.94 Y124.716 F9000
G1 F1435
G1 X105.464 Y124.606 E.01571
G1 X105.452 Y124.425 E.00583
G3 X106.163 Y124.194 I1.64 J3.835 E.02409
G1 X106.26 Y124.347 E.00583
G1 X105.979 Y124.671 E.01379
; WIPE_START
G1 F5895.652
G1 X105.464 Y124.606 E-.19739
G1 X105.452 Y124.425 E-.06891
G1 X105.802 Y124.293 E-.14226
G1 X106.163 Y124.194 E-.14233
G1 X106.26 Y124.347 E-.06891
G1 X106.018 Y124.626 E-.1402
; WIPE_END
G1 E-.04 F1800
G1 X102.733 Y128.365 Z4.8 F9000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1435
G1 X102.714 Y128 E.0109
G3 X106.814 Y123.715 I4.288 J-.002 E.1951
G3 X107.56 Y123.747 I.192 J4.157 E.02226
G3 X102.735 Y128.425 I-.559 J4.251 E.5724
; WIPE_START
G1 F6364.704
G1 X102.714 Y128 E-.1617
G1 X102.734 Y127.616 E-.14628
G1 X102.786 Y127.234 E-.14636
G1 X102.872 Y126.859 E-.14624
G1 X102.99 Y126.493 E-.14624
G1 X103.004 Y126.461 E-.01319
; WIPE_END
G1 E-.04 F1800
G17
G3 Z4.8 I1.217 J0 P1  F9000
; stop printing object, unique label id: 118
M625
; object ids of layer 22 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.8
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4.8 F4000
            G39.3 S1
            G0 Z4.8 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END


; object ids of this layer22 end: 82,118
M625
; CHANGE_LAYER
; Z_HEIGHT: 4.6
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 23/23
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
; OBJECT_ID: 82
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F9000
G1 Z4.6
G1 E.8 F1800
G1 F2312
G1 X125.359 Y126.079 E.01424
G1 X125.819 Y125.95 E.01424
G1 X125.92 Y125.482 E.01424
G1 X126.397 Y125.471 E.01424
G1 X126.611 Y125.044 E.01424
G1 X127.077 Y125.151 E.01424
G1 X127.39 Y124.79 E.01424
G1 X127.814 Y125.011 E.01424
G1 X128.207 Y124.739 E.01424
G1 X128.563 Y125.058 E.01424
G1 X129.012 Y124.893 E.01424
G1 X129.277 Y125.29 E.01424
G1 X129.753 Y125.241 E.01424
G1 X129.911 Y125.692 E.01424
G1 X130.384 Y125.763 E.01424
G1 X130.425 Y126.24 E.01424
G1 X130.865 Y126.426 E.01424
G1 X130.787 Y126.897 E.01424
G1 X131.167 Y127.187 E.01424
G1 X130.974 Y127.625 E.01424
G1 X131.27 Y128 E.01424
G1 X130.974 Y128.375 E.01424
G1 X131.167 Y128.813 E.01424
G1 X130.787 Y129.103 E.01424
G1 X130.865 Y129.574 E.01424
G1 X130.425 Y129.76 E.01424
G1 X130.384 Y130.237 E.01424
G1 X129.911 Y130.308 E.01424
G1 X129.753 Y130.759 E.01424
G1 X129.277 Y130.71 E.01424
G1 X129.012 Y131.107 E.01424
G1 X128.563 Y130.942 E.01424
G1 X128.207 Y131.261 E.01424
G1 X127.814 Y130.989 E.01424
G1 X127.39 Y131.21 E.01424
G1 X127.077 Y130.849 E.01424
G1 X126.611 Y130.956 E.01424
G1 X126.397 Y130.529 E.01424
G1 X125.92 Y130.518 E.01424
G1 X125.819 Y130.05 E.01424
G1 X125.359 Y129.921 E.01424
G1 X125.378 Y129.443 E.01424
G1 X124.964 Y129.203 E.01424
G1 X125.101 Y128.745 E.01424
G1 X124.761 Y128.409 E.01424
G1 X125.007 Y128 E.01424
G1 X124.761 Y127.59 E.01424
G1 X125.101 Y127.255 E.01424
G1 X124.964 Y126.797 E.01424
G1 X125.326 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18164
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18164
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X123.729 Y128.361 Z5 F9000
G1 Z4.6
G1 E.8 F1800
G1 F2312
G1 X123.717 Y128 E.01075
G3 X128.578 Y123.749 I4.289 J0 E.21778
G3 X128.957 Y132.182 I-.581 J4.251 E.35532
G3 X123.737 Y128.42 I-.951 J-4.182 E.21671
; WIPE_START
G1 F6364.704
G1 X123.717 Y128 E-.15975
G1 X123.73 Y127.616 E-.14615
G1 X123.781 Y127.234 E-.14637
G1 X123.867 Y126.859 E-.1462
G1 X123.986 Y126.493 E-.14628
G1 X124.002 Y126.456 E-.01525
; WIPE_END
G1 E-.04 F1800
G17
G3 Z5 I1.217 J0 P1  F9000
; stop printing object, unique label id: 82
M625
; object ids of layer 23 start: 82,118
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5
G1 X0 Y128 F18000 ; move to safe pos
G1 X-48.2 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z5 F4000
            G39.3 S1
            G0 Z5 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END


; object ids of this layer23 end: 82,118
M625
; start printing object, unique label id: 82
M624 AQAAAAAAAAA=
G1 X131.917 Y126.851 F9000
G1 Z4.6
G1 E.8 F1800
; FEATURE: Top surface
G1 F2312
M204 S500
G1 X129.153 Y124.087 E.11643
G1 X129.583 Y125.05
G1 X128.481 Y123.949 E.04641
G1 X127.921 Y123.922
G1 X128.763 Y124.763 E.03545
G1 X128.057 Y124.591
G1 X127.426 Y123.96 E.02658
G1 X126.983 Y124.051
G1 X127.597 Y124.664 E.02586
G1 X127.15 Y124.751
G1 X126.578 Y124.179 E.02409
G1 X126.205 Y124.339
G1 X126.723 Y124.857 E.02181
G1 X126.378 Y125.045
G1 X125.862 Y124.528 E.02177
G1 X125.545 Y124.745
G1 X126.071 Y125.271 E.02219
G1 X125.715 Y125.448
G1 X125.253 Y124.987 E.01945
G1 X124.986 Y125.253
G1 X125.545 Y125.812 E.02352
G1 X125.146 Y125.946
G1 X124.744 Y125.544 E.01692
G1 X124.528 Y125.861
G1 X125.129 Y126.462 E.02531
G1 X124.791 Y126.658
G1 X124.338 Y126.204 E.01911
G1 X124.177 Y126.577
G1 X124.831 Y127.23 E.02755
G1 X124.562 Y127.495
G1 X124.051 Y126.984 E.02152
G1 X123.964 Y127.43
G1 X124.678 Y128.144 E.03008
G1 X124.853 Y128.852
G1 X123.923 Y127.923 E.03914
G1 X123.953 Y128.485
G1 X124.73 Y129.263 E.03274
; WIPE_START
G1 F6364.704
M204 S750
G1 X123.953 Y128.485 E-.41771
G1 X123.923 Y127.923 E-.21402
G1 X124.162 Y128.162 E-.12827
; WIPE_END
G1 E-.04 F1800
G1 X131.059 Y126.526 Z5 F9000
G1 Z4.6
G1 E.8 F1800
G1 F2312
M204 S500
G1 X132.053 Y127.52 E.04185
G1 X132.081 Y128.081
G1 X131.33 Y127.331 E.03162
G1 X131.504 Y128.038
G1 X132.04 Y128.574 E.02258
G1 X131.952 Y129.02
G1 X131.269 Y128.336 E.0288
G1 X131.341 Y128.941
G1 X131.827 Y129.427 E.02047
G1 X131.665 Y129.799
G1 X131.038 Y129.172 E.02642
G1 X131.053 Y129.72
G1 X131.475 Y130.142 E.01777
G1 X131.258 Y130.458
G1 X130.678 Y129.879 E.02442
M73 P97 R0
G1 X130.585 Y130.319
G1 X131.016 Y130.749 E.01814
G1 X130.749 Y131.016
G1 X130.206 Y130.473 E.02285
G1 X129.969 Y130.769
G1 X130.457 Y131.257 E.02056
G1 X130.14 Y131.473
G1 X129.62 Y130.954 E.02189
G1 X129.253 Y131.12
G1 X129.796 Y131.662 E.02287
G1 X129.423 Y131.823
G1 X128.88 Y131.28 E.02286
G1 X128.418 Y131.351
G1 X129.017 Y131.95 E.02526
G1 X128.575 Y132.041
G1 X127.776 Y131.243 E.03363
G1 X127.425 Y131.425
G1 X128.079 Y132.078 E.02752
G1 X127.518 Y132.051
G1 X126.632 Y131.164 E.03734
G1 X126.845 Y131.911
G1 X124.09 Y129.156 E.11607
; WIPE_START
G1 F6364.704
M204 S750
G1 X125.504 Y130.57 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.949 Y129.046 Z5 F9000
G1 Z4.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0936596
G1 F2312
G1 X131.865 Y129.198 E.0007
; WIPE_START
G1 F9000
G1 X131.949 Y129.046 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.136 Y126.9 Z5 F9000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.0964822
G1 F2312
G1 X130.998 Y126.779 E.00078
G1 X131.055 Y126.281 F9000
; LINE_WIDTH: 0.107633
G1 F2312
G1 X130.939 Y126.203 E.00071
; LINE_WIDTH: 0.146567
G1 X130.823 Y126.125 E.00114
; LINE_WIDTH: 0.1855
G1 X130.707 Y126.047 E.00157
; LINE_WIDTH: 0.224433
G1 X130.591 Y125.969 E.002
; WIPE_START
G1 F9000
G1 X130.707 Y126.047 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.801 Y125.002 Z5 F9000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.103368
G1 F2312
G1 X129.644 Y125.044 E.00078
; WIPE_START
G1 F9000
G1 X129.801 Y125.002 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.75 Y126.392 Z5 F9000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.103008
G1 F2312
G1 X131.7 Y126.318 E.00043
; LINE_WIDTH: 0.1327
G1 X131.65 Y126.243 E.00064
; LINE_WIDTH: 0.165237
G1 X131.577 Y126.146 E.00117
; LINE_WIDTH: 0.200592
G1 X131.505 Y126.048 E.00151
; LINE_WIDTH: 0.235946
G1 X131.432 Y125.951 E.00185
; LINE_WIDTH: 0.271668
G1 X131.319 Y125.812 E.00324
; LINE_WIDTH: 0.307801
G1 X131.206 Y125.673 E.00375
; LINE_WIDTH: 0.359046
G2 X130.463 Y124.914 I-6.702 J5.81 E.02653
; LINE_WIDTH: 0.335843
G1 X130.328 Y124.798 E.00412
; LINE_WIDTH: 0.307884
G1 X130.192 Y124.682 E.00373
; LINE_WIDTH: 0.27165
G1 X130.05 Y124.571 E.00326
; LINE_WIDTH: 0.227162
G1 X129.907 Y124.46 E.00263
; LINE_WIDTH: 0.185456
G1 X129.806 Y124.388 E.00139
; LINE_WIDTH: 0.146538
G1 X129.705 Y124.317 E.00101
; LINE_WIDTH: 0.10762
G1 X129.605 Y124.245 E.00063
; WIPE_START
G1 F9000
G1 X129.705 Y124.317 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.351 Y125.099 Z5 F9000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.105851
G1 F2312
G1 X126.273 Y125.207 E.00066
; LINE_WIDTH: 0.155352
G3 X126.205 Y125.225 I-.042 J-.018 E.00073
G1 X126.203 Y125.14 E.00076
; WIPE_START
G1 F9000
G1 X126.205 Y125.225 E-.39485
G1 X126.246 Y125.232 E-.19279
G1 X126.273 Y125.207 E-.17237
; WIPE_END
G1 E-.04 F1800
G1 X124.139 Y126.805 Z5 F9000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.0947563
G1 F2312
G1 X124.055 Y126.957 E.00071
; WIPE_START
G1 F9000
G1 X124.139 Y126.805 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X124.666 Y127.837 Z5 F9000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.102917
G1 F2312
G1 X124.568 Y127.712 E.00075
; LINE_WIDTH: 0.132401
G1 X124.47 Y127.587 E.00112
; WIPE_START
G1 F9000
G1 X124.568 Y127.712 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X125.177 Y129.739 Z5 F9000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.308191
G1 F2312
G1 X124.916 Y129.538 E.0069
; LINE_WIDTH: 0.258497
G1 X124.655 Y129.337 E.00561
; WIPE_START
G1 F9000
G1 X124.916 Y129.538 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.475 Y131.209 Z5 F9000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.175525
G1 F2312
G1 X126.355 Y131.043 E.00215
; LINE_WIDTH: 0.218757
G1 X126.236 Y130.877 E.00284
; LINE_WIDTH: 0.261989
G1 X126.116 Y130.711 E.00354
; WIPE_START
G1 F9000
G1 X126.236 Y130.877 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.391 Y131.75 Z5 F9000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.107069
G1 F2312
G1 X126.293 Y131.681 E.00061
; LINE_WIDTH: 0.144885
G1 X126.195 Y131.611 E.00097
; LINE_WIDTH: 0.1827
G1 X126.096 Y131.541 E.00133
; LINE_WIDTH: 0.223848
G1 X125.954 Y131.43 E.00258
; LINE_WIDTH: 0.268341
G1 X125.811 Y131.319 E.00322
; LINE_WIDTH: 0.304588
G1 X125.676 Y131.203 E.00368
; LINE_WIDTH: 0.332561
G1 X125.54 Y131.088 E.00408
; LINE_WIDTH: 0.355797
G3 X124.798 Y130.328 I5.958 J-6.568 E.02627
; LINE_WIDTH: 0.304552
G1 X124.684 Y130.189 E.00371
; LINE_WIDTH: 0.268386
G1 X124.571 Y130.05 E.0032
; LINE_WIDTH: 0.232622
G1 X124.498 Y129.953 E.00182
; LINE_WIDTH: 0.197267
G1 X124.426 Y129.855 E.00148
; LINE_WIDTH: 0.161913
G1 X124.353 Y129.757 E.00114
; LINE_WIDTH: 0.130207
G1 X124.305 Y129.687 E.00059
; LINE_WIDTH: 0.102176
G1 X124.258 Y129.616 E.0004
; WIPE_START
G1 F9000
G1 X124.305 Y129.687 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.358 Y131.441 Z5 F9000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.0814947
G1 F2312
G1 X127.349 Y131.468 E.00009
; LINE_WIDTH: 0.111686
G1 X127.311 Y131.475 E.00021
; LINE_WIDTH: 0.147534
G1 X127.292 Y131.474 E.00015
; LINE_WIDTH: 0.177181
G1 X126.922 Y131.078 E.00575
; OBJECT_ID: 118
; WIPE_START
G1 F9000
G1 X127.292 Y131.474 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 82
M625
; start printing object, unique label id: 118
M624 AgAAAAAAAAA=
G1 X119.83 Y129.873 Z5 F9000
G1 X104.382 Y126.557 Z5
G1 Z4.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2312
G1 X104.363 Y126.079 E.01424
G1 X104.823 Y125.95 E.01424
G1 X104.924 Y125.482 E.01424
G1 X105.402 Y125.471 E.01424
G1 X105.616 Y125.044 E.01424
G1 X106.081 Y125.151 E.01424
G1 X106.394 Y124.79 E.01424
G1 X106.819 Y125.011 E.01424
G1 X107.212 Y124.739 E.01424
G1 X107.568 Y125.058 E.01424
G1 X108.016 Y124.893 E.01424
G1 X108.282 Y125.29 E.01424
G1 X108.757 Y125.241 E.01424
G1 X108.916 Y125.692 E.01424
G1 X109.389 Y125.763 E.01424
G1 X109.43 Y126.24 E.01424
G1 X109.87 Y126.426 E.01424
G1 X109.791 Y126.897 E.01424
G1 X110.171 Y127.187 E.01424
G1 X109.978 Y127.625 E.01424
G1 X110.274 Y128 E.01424
G1 X109.978 Y128.375 E.01424
G1 X110.171 Y128.813 E.01424
G1 X109.791 Y129.103 E.01424
G1 X109.87 Y129.574 E.01424
G1 X109.43 Y129.76 E.01424
G1 X109.389 Y130.237 E.01424
G1 X108.916 Y130.308 E.01424
G1 X108.757 Y130.759 E.01424
G1 X108.282 Y130.71 E.01424
G1 X108.016 Y131.107 E.01424
G1 X107.568 Y130.942 E.01424
G1 X107.212 Y131.261 E.01424
G1 X106.819 Y130.989 E.01424
G1 X106.394 Y131.21 E.01424
G1 X106.081 Y130.849 E.01424
G1 X105.616 Y130.956 E.01424
G1 X105.402 Y130.529 E.01424
G1 X104.924 Y130.518 E.01424
G1 X104.823 Y130.05 E.01424
G1 X104.363 Y129.921 E.01424
G1 X104.382 Y129.443 E.01424
G1 X103.969 Y129.203 E.01424
G1 X104.106 Y128.745 E.01424
G1 X103.765 Y128.409 E.01424
G1 X104.012 Y128 E.01424
G1 X103.765 Y127.59 E.01424
G1 X104.106 Y127.255 E.01424
G1 X103.969 Y126.797 E.01424
G1 X104.33 Y126.587 E.01245
; WIPE_START
G1 F6364.704
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18164
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18164
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
G1 X102.733 Y128.361 Z5 F9000
G1 Z4.6
G1 E.8 F1800
G1 F2312
G1 X102.721 Y128 E.01075
G3 X107.583 Y123.749 I4.289 J0 E.21778
G3 X107.961 Y132.182 I-.581 J4.251 E.35532
G3 X102.742 Y128.42 I-.951 J-4.182 E.21671
; WIPE_START
G1 F6364.704
G1 X102.721 Y128 E-.15975
G1 X102.734 Y127.616 E-.14615
G1 X102.786 Y127.234 E-.14637
G1 X102.872 Y126.859 E-.1462
G1 X102.99 Y126.493 E-.14628
G1 X103.006 Y126.456 E-.01525
; WIPE_END
G1 E-.04 F1800
G1 X110.629 Y126.836 Z5 F9000
G1 X110.921 Y126.851 Z5
G1 Z4.6
G1 E.8 F1800
; FEATURE: Top surface
G1 F2312
M204 S500
G1 X108.157 Y124.087 E.11643
G1 X108.587 Y125.05
G1 X107.486 Y123.949 E.04641
G1 X106.926 Y123.922
G1 X107.767 Y124.763 E.03545
G1 X107.061 Y124.591
G1 X106.43 Y123.96 E.02658
G1 X105.988 Y124.051
G1 X106.602 Y124.664 E.02586
G1 X106.155 Y124.751
G1 X105.583 Y124.179 E.02409
G1 X105.21 Y124.339
G1 X105.727 Y124.857 E.02181
G1 X105.383 Y125.045
G1 X104.866 Y124.528 E.02177
G1 X104.549 Y124.745
G1 X105.076 Y125.271 E.02219
G1 X104.719 Y125.448
G1 X104.258 Y124.987 E.01945
G1 X103.991 Y125.253
G1 X104.549 Y125.812 E.02352
G1 X104.151 Y125.946
G1 X103.749 Y125.544 E.01692
G1 X103.532 Y125.861
G1 X104.133 Y126.462 E.02531
G1 X103.796 Y126.658
G1 X103.342 Y126.204 E.01911
G1 X103.181 Y126.577
G1 X103.835 Y127.23 E.02755
G1 X103.567 Y127.495
G1 X103.056 Y126.984 E.02152
G1 X102.969 Y127.43
G1 X103.683 Y128.144 E.03008
G1 X103.857 Y128.852
G1 X102.928 Y127.923 E.03914
G1 X102.957 Y128.485
G1 X103.734 Y129.263 E.03274
; WIPE_START
G1 F6364.704
M204 S750
G1 X102.957 Y128.485 E-.41771
G1 X102.928 Y127.923 E-.21402
G1 X103.167 Y128.162 E-.12827
; WIPE_END
G1 E-.04 F1800
G1 X110.063 Y126.526 Z5 F9000
G1 Z4.6
G1 E.8 F1800
G1 F2312
M204 S500
G1 X111.057 Y127.52 E.04185
G1 X111.085 Y128.081
G1 X110.335 Y127.331 E.03162
G1 X110.508 Y128.038
G1 X111.044 Y128.574 E.02258
G1 X110.957 Y129.02
G1 X110.273 Y128.336 E.0288
G1 X110.345 Y128.941
G1 X110.831 Y129.427 E.02047
G1 X110.67 Y129.799
G1 X110.043 Y129.172 E.02642
G1 X110.057 Y129.72
G1 X110.479 Y130.142 E.01777
G1 X110.262 Y130.458
G1 X109.683 Y129.879 E.02442
G1 X109.59 Y130.319
G1 X110.02 Y130.749 E.01814
G1 X109.753 Y131.016
G1 X109.211 Y130.473 E.02285
G1 X108.974 Y130.769
G1 X109.462 Y131.257 E.02056
G1 X109.145 Y131.473
G1 X108.625 Y130.954 E.02189
G1 X108.258 Y131.12
G1 X108.801 Y131.662 E.02287
G1 X108.427 Y131.823
G1 X107.885 Y131.28 E.02286
G1 X107.422 Y131.351
G1 X108.022 Y131.95 E.02526
G1 X107.579 Y132.041
G1 X106.781 Y131.243 E.03363
G1 X106.43 Y131.425
G1 X107.083 Y132.078 E.02752
G1 X106.523 Y132.051
G1 X105.636 Y131.164 E.03734
M73 P98 R0
G1 X105.85 Y131.911
G1 X103.094 Y129.156 E.11607
; WIPE_START
G1 F6364.704
M204 S750
G1 X104.509 Y130.57 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.953 Y129.046 Z5 F9000
G1 Z4.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0936596
G1 F2312
G1 X110.869 Y129.198 E.0007
; WIPE_START
G1 F9000
G1 X110.953 Y129.046 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.141 Y126.9 Z5 F9000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.0964822
G1 F2312
G1 X110.002 Y126.779 E.00078
G1 X110.059 Y126.281 F9000
; LINE_WIDTH: 0.107633
G1 F2312
G1 X109.943 Y126.203 E.00071
; LINE_WIDTH: 0.146567
G1 X109.827 Y126.125 E.00114
; LINE_WIDTH: 0.1855
G1 X109.711 Y126.047 E.00157
; LINE_WIDTH: 0.224433
G1 X109.596 Y125.969 E.002
; WIPE_START
G1 F9000
G1 X109.711 Y126.047 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X108.805 Y125.002 Z5 F9000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.103368
G1 F2312
G1 X108.649 Y125.044 E.00078
; WIPE_START
G1 F9000
G1 X108.805 Y125.002 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X110.755 Y126.392 Z5 F9000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.103008
G1 F2312
G1 X110.705 Y126.318 E.00043
; LINE_WIDTH: 0.1327
G1 X110.654 Y126.243 E.00064
; LINE_WIDTH: 0.165237
G1 X110.582 Y126.146 E.00117
; LINE_WIDTH: 0.200592
G1 X110.509 Y126.048 E.00151
; LINE_WIDTH: 0.235946
G1 X110.437 Y125.951 E.00185
; LINE_WIDTH: 0.271668
G1 X110.323 Y125.812 E.00324
; LINE_WIDTH: 0.307801
G1 X110.21 Y125.673 E.00375
; LINE_WIDTH: 0.359046
G2 X109.468 Y124.914 I-6.702 J5.81 E.02653
; LINE_WIDTH: 0.335843
G1 X109.332 Y124.798 E.00412
; LINE_WIDTH: 0.307884
G1 X109.197 Y124.682 E.00373
; LINE_WIDTH: 0.27165
G1 X109.054 Y124.571 E.00326
; LINE_WIDTH: 0.227162
G1 X108.912 Y124.46 E.00263
; LINE_WIDTH: 0.185456
G1 X108.811 Y124.388 E.00139
; LINE_WIDTH: 0.146538
G1 X108.71 Y124.317 E.00101
; LINE_WIDTH: 0.10762
G1 X108.609 Y124.245 E.00063
; WIPE_START
G1 F9000
G1 X108.71 Y124.317 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.356 Y125.099 Z5 F9000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.105851
G1 F2312
G1 X105.278 Y125.207 E.00066
; LINE_WIDTH: 0.155352
G3 X105.209 Y125.225 I-.042 J-.018 E.00073
G1 X105.207 Y125.14 E.00076
; WIPE_START
G1 F9000
G1 X105.209 Y125.225 E-.39485
G1 X105.25 Y125.232 E-.19279
G1 X105.278 Y125.207 E-.17237
; WIPE_END
G1 E-.04 F1800
G1 X103.143 Y126.805 Z5 F9000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.0947563
G1 F2312
G1 X103.059 Y126.957 E.00071
; WIPE_START
G1 F9000
G1 X103.143 Y126.805 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X103.67 Y127.837 Z5 F9000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.102917
G1 F2312
G1 X103.573 Y127.712 E.00075
; LINE_WIDTH: 0.132401
G1 X103.475 Y127.587 E.00112
; WIPE_START
G1 F9000
G1 X103.573 Y127.712 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X104.182 Y129.739 Z5 F9000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.308191
G1 F2312
G1 X103.921 Y129.538 E.0069
; LINE_WIDTH: 0.258497
G1 X103.66 Y129.337 E.00561
; WIPE_START
G1 F9000
G1 X103.921 Y129.538 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.48 Y131.209 Z5 F9000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.175525
G1 F2312
G1 X105.36 Y131.043 E.00215
; LINE_WIDTH: 0.218757
G1 X105.24 Y130.877 E.00284
; LINE_WIDTH: 0.261989
G1 X105.12 Y130.711 E.00354
; WIPE_START
G1 F9000
G1 X105.24 Y130.877 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X105.395 Y131.75 Z5 F9000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.107069
G1 F2312
G1 X105.297 Y131.681 E.00061
; LINE_WIDTH: 0.144885
G1 X105.199 Y131.611 E.00097
; LINE_WIDTH: 0.1827
G1 X105.101 Y131.541 E.00133
; LINE_WIDTH: 0.223848
G1 X104.958 Y131.43 E.00258
; LINE_WIDTH: 0.268341
G1 X104.816 Y131.319 E.00322
; LINE_WIDTH: 0.304588
G1 X104.68 Y131.203 E.00368
; LINE_WIDTH: 0.332561
G1 X104.545 Y131.088 E.00408
; LINE_WIDTH: 0.355797
G3 X103.802 Y130.328 I5.958 J-6.568 E.02627
; LINE_WIDTH: 0.304552
G1 X103.689 Y130.189 E.00371
; LINE_WIDTH: 0.268386
G1 X103.575 Y130.05 E.0032
; LINE_WIDTH: 0.232622
G1 X103.503 Y129.953 E.00182
; LINE_WIDTH: 0.197267
G1 X103.43 Y129.855 E.00148
; LINE_WIDTH: 0.161913
G1 X103.358 Y129.757 E.00114
; LINE_WIDTH: 0.130207
G1 X103.31 Y129.687 E.00059
; LINE_WIDTH: 0.102176
G1 X103.262 Y129.616 E.0004
; WIPE_START
G1 F9000
G1 X103.31 Y129.687 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X106.362 Y131.441 Z5 F9000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.0814947
G1 F2312
G1 X106.354 Y131.468 E.00009
; LINE_WIDTH: 0.111686
G1 X106.315 Y131.475 E.00021
; LINE_WIDTH: 0.147534
G1 X106.297 Y131.474 E.00015
; LINE_WIDTH: 0.177181
G1 X105.927 Y131.078 E.00575
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F9000
G1 X106.297 Y131.474 E-.76
; WIPE_END
G1 E-.04 F1800
G17
G3 Z5 I1.217 J0 P1  F9000
; stop printing object, unique label id: 118
M625
M106 S0
M981 S0 P20000 ; close spaghetti detector
; FEATURE: Custom
; MACHINE_END_GCODE_START
; filament end gcode 

;===== date: 20260513 =====================
G392 S0 ;turn off nozzle clog detect

M400 ; wait for buffer to clear
G92 E0 ; zero the extruder
G90
G1 Z5 F900 ; lower z a little
G1 X0 Y128 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos

M1002 judge_flag timelapse_record_flag
M622 J1
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M991 S0 P-1 ;end timelapse at safe pos
M623


M140 S0 ; turn off bed
M106 S0 ; turn off fan
M106 P2 S0 ; turn off remote part cooling fan
M106 P3 S0 ; turn off chamber cooling fan

;G1 X27 F15000 ; wipe

; pull back filament to AMS
M620 S255
G1 X267 F15000
T255
G1 X-28.5 F18000
G1 X-48.2 F3000
G1 X-28.5 F18000
G1 X-48.2 F3000
M621 S255

M104 S0 ; turn off hotend

M400 ; wait all motion done
M17 S
M17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom

    G1 Z104.6 F600
    G1 Z102.6

M400 P100
M17 R ; restore z current

G90
G1 X-48 Y180 F3600

M220 S100  ; Reset feedrate magnitude
M201.2 K1.0 ; Reset acc magnitude
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 0

;=====printer finish  sound=========
M17
M400 S1
M1006 S1
M1006 A0 B20 L100 C37 D20 M40 E42 F20 N60
M1006 A0 B10 L100 C44 D10 M60 E44 F10 N60
M1006 A0 B10 L100 C46 D10 M80 E46 F10 N80
M1006 A44 B20 L100 C39 D20 M60 E48 F20 N60
M1006 A0 B10 L100 C44 D10 M60 E44 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A0 B10 L100 C39 D10 M60 E39 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A0 B10 L100 C44 D10 M60 E44 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A0 B10 L100 C39 D10 M60 E39 F10 N60
M1006 A0 B10 L100 C0 D10 M60 E0 F10 N60
M1006 A0 B10 L100 C48 D10 M60 E44 F10 N80
M1006 A0 B10 L100 C0 D10 M60 E0 F10  N80
M1006 A44 B20 L100 C49 D20 M80 E41 F20 N80
M1006 A0 B20 L100 C0 D20 M60 E0 F20 N80
M1006 A0 B20 L100 C37 D20 M30 E37 F20 N60
M1006 W
;=====printer finish  sound=========

;M17 X0.8 Y0.8 Z0.5 ; lower motor current to 45% power
M400
M18 X Y Z

M73 P100 R0
; EXECUTABLE_BLOCK_END

