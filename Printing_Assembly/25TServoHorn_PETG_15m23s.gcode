; HEADER_BLOCK_START
; BambuStudio 02.08.02.60
; model printing time: 9m 2s; total estimated time: 15m 23s
; total layer number: 23
; total filament length [mm] : 503.46
; total filament volume [cm^3] : 1210.96
; total filament weight [g] : 1.54
; model label id: 78,114
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
; default_acceleration = 6000
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
; different_settings_to_system = ;eng_plate_temp;eng_plate_temp_initial_layer;nozzle_temperature;nozzle_temperature_initial_layer;nozzle_temperature_range_high;supertack_plate_temp;supertack_plate_temp_initial_layer;
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
; extruder_ams_count = 1#0|4#0;
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
; gap_infill_speed = 250
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
; initial_layer_travel_acceleration = 6000
; inner_wall_acceleration = 0
; inner_wall_jerk = 9
; inner_wall_line_width = 0.45
; inner_wall_speed = 300
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
; internal_solid_infill_speed = 250
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
; outer_wall_acceleration = 5000
; outer_wall_jerk = 9
; outer_wall_line_width = 0.42
; outer_wall_speed = 200
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
; sparse_infill_speed = 270
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
; top_surface_acceleration = 2000
; top_surface_density = 100%
; top_surface_jerk = 9
; top_surface_line_width = 0.42
; top_surface_pattern = monotonicline
; top_surface_speed = 200
; top_z_overrides_xy_distance = 0
; travel_acceleration = 10000
; travel_jerk = 9
; travel_short_distance_acceleration = 250
; travel_speed = 700
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
; wall_loops = 2
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
M73 P0 R15
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
M73 P3 R14
G1 E-0.5 F300

G1 X-28.5 F30000
M73 P5 R14
G1 X-48.2 F3000
M73 P6 R14
G1 X-28.5 F30000 ;wipe and shake
M73 P7 R14
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
M73 P9 R14
    G1 X-28.5 F12000 ;wipe and shake
M73 P9 R13
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
        G1 X-28.5 F18000 ;wipe and shake
        G1 X-48.2 F3000
        G1 X-28.5 F12000 ;wipe and shake
        M400
        M106 P1 S0
    M623
    
M73 P10 R13
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
M73 P38 R9
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
M73 P39 R9
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
M73 P40 R9
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
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X128.686 Y136.691 F42000
M204 S6000
G1 Z.4
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.5
G1 F3000
M204 S500
G1 X128.418 Y136.773 E.0101
G3 X127.723 Y133.195 I-.423 J-1.774 E.2124
G1 X127.99 Y133.175 E.00964
G3 X128.739 Y136.664 I.006 J1.824 E.17945
; WIPE_START
G1 X128.418 Y136.773 E-.12864
G1 X128.142 Y136.821 E-.10656
G1 X127.862 Y136.821 E-.10622
G1 X127.586 Y136.778 E-.10623
G1 X127.32 Y136.694 E-.10624
G1 X127.069 Y136.57 E-.10621
G1 X126.854 Y136.418 E-.0999
; WIPE_END
M73 P41 R9
G1 E-.04 F1800
M204 S6000
G1 X132.241 Y131.011 Z.6 F42000
G1 X136.404 Y126.831 Z.6
G1 Z.2
G1 E.8 F1800
G1 F3000
M204 S500
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
M204 S6000
G1 X131.839 Y122.776 Z.6 F42000
G1 X129.369 Y119.79 Z.6
G1 Z.2
G1 E.8 F1800
G1 F3000
M204 S500
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
M204 S6000
G1 X125.986 Y126.935 Z.6 F42000
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
M204 S500
G1 X126.142 Y126.691 E.01046
G3 X127.832 Y125.727 I1.868 J1.31 E.0726
G3 X129.244 Y126.083 I.158 J2.351 E.05343
G3 X125.964 Y126.991 I-1.234 J1.919 E.37884
M204 S6000
G1 X126.378 Y127.169 F42000
; FEATURE: Outer wall
G1 F3000
M204 S500
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
M204 S6000
G1 X129.678 Y119.452 Z.6 F42000
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
M204 S500
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
M204 S6000
G1 X125.621 Y125.041 Z.6 F42000
G1 X122.712 Y128.629 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X122.631 Y128.806 E.00704
G3 X120.793 Y126.186 I-1.635 J-.808 E.27275
M73 P41 R8
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
M204 S6000
G1 X124.825 Y123.04 Z.6 F42000
G1 X127.279 Y118.357 Z.6
G1 Z.2
G1 E.8 F1800
G1 F3000
M204 S500
G3 X128.162 Y118.331 I.728 J9.696 E.03189
G3 X123.444 Y119.467 I-.167 J9.67 E2.01698
G3 X127.22 Y118.362 I4.564 J8.586 E.14303
; WIPE_START
G1 X128.162 Y118.331 E-.35827
G1 X129.014 Y118.378 E-.32415
G1 X129.216 Y118.406 E-.07758
; WIPE_END
G1 E-.04 F1800
M204 S6000
G17
G3 Z.6 I1.217 J0 P1  F42000
; stop printing object, unique label id: 78
M625
; object ids of layer 1 start: 78,114
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


; object ids of this layer1 end: 78,114
M625
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X128.817 Y118.86 F42000
G1 Z.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.513125
G1 F3000
M204 S500
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
M204 S6000
G1 X126.211 Y119.215 F42000
; LINE_WIDTH: 0.113854
G1 F3000
M204 S500
M73 P42 R8
G2 X126.087 Y119.33 I.065 J.194 E.00097
; WIPE_START
G1 X126.148 Y119.249 E-.4478
G1 X126.211 Y119.215 E-.3122
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X128.817 Y118.86 Z.6 F42000
G1 Z.2
G1 E.8 F1800
; LINE_WIDTH: 0.504558
G1 F3000
M204 S500
G1 X128.825 Y118.876 E.00066
; LINE_WIDTH: 0.476208
G1 X128.889 Y119.022 E.00543
; LINE_WIDTH: 0.445885
G1 X128.952 Y119.167 E.00505
M204 S6000
G1 X129.795 Y119.218 F42000
; LINE_WIDTH: 0.113799
G1 F3000
M204 S500
G3 X129.918 Y119.33 I-.058 J.186 E.00096
; WIPE_START
G1 X129.856 Y119.249 E-.45317
G1 X129.795 Y119.218 E-.30683
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X135.196 Y124.611 Z.6 F42000
G1 X136.672 Y126.084 Z.6
G1 Z.2
G1 E.8 F1800
; LINE_WIDTH: 0.114358
G1 F3000
M204 S500
G3 X136.787 Y126.21 I-.073 J.183 E.00099
M204 S6000
G1 X137.105 Y126.947 F42000
; LINE_WIDTH: 0.546301
G1 F3000
M204 S500
G1 X137.162 Y127.204 E.01047
; LINE_WIDTH: 0.528989
G1 X137.186 Y127.333 E.00504
; LINE_WIDTH: 0.491614
G3 X137.216 Y127.497 I-2.02 J.449 E.00589
; LINE_WIDTH: 0.450282
G3 X137.211 Y128.534 I-3.944 J.501 E.03347
; LINE_WIDTH: 0.495365
G1 X137.186 Y128.669 E.0049
; LINE_WIDTH: 0.53029
G1 X137.161 Y128.804 E.00528
G1 X137.374 Y129.146 E.01553
M204 S6000
G1 X136.787 Y129.79 F42000
; LINE_WIDTH: 0.114377
G1 F3000
M204 S500
G3 X136.672 Y129.916 I-.189 J-.057 E.001
M204 S6000
G1 X136.11 Y130.198 F42000
; FEATURE: Bottom surface
; LINE_WIDTH: 0.50734
G1 F5167.737
M204 S500
G1 X136.454 Y130.542 E.01781
G3 X136.289 Y131.034 I-4.197 J-1.124 E.01906
G1 X135.801 Y130.546 E.02534
G1 X135.715 Y130.578 E.00337
G1 X135.257 Y130.658 E.01707
G1 X136.102 Y131.504 E.04387
G3 X135.894 Y131.952 I-3.845 J-1.516 E.01815
G1 X134.3 Y130.359 E.08267
; WIPE_START
G1 X135.715 Y131.773 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X133.869 Y124.367 Z.6 F42000
G1 X132.88 Y120.4 Z.6
G1 Z.2
G1 E.8 F1800
G1 F5167.737
M204 S500
G3 X134.474 Y121.995 I-106.416 J107.986 E.08275
G3 X135.918 Y124.095 I-6.711 J6.161 E.09382
G1 X131.905 Y120.082 E.20821
G2 X130.794 Y119.628 I-4.099 J8.442 E.04406
G1 X136.377 Y125.211 E.28964
G1 X136.513 Y125.652 E.01694
G1 X136.441 Y125.747 E.00439
G1 X136.054 Y125.545 E.01599
G1 X130.457 Y119.948 E.29039
G3 X130.663 Y120.81 I-2.753 J1.113 E.03266
G1 X135.192 Y125.339 E.23497
G2 X134.563 Y125.367 I-.221 J2.155 E.02319
G1 X130.635 Y121.439 E.20376
G1 X130.495 Y121.956 E.01964
G1 X134.046 Y125.507 E.18421
G2 X133.609 Y125.726 I.491 J1.526 E.01802
G1 X130.276 Y122.394 E.17289
G3 X129.996 Y122.77 I-1.359 J-.719 E.01729
G1 X133.232 Y126.006 E.16789
G2 X132.912 Y126.344 I.931 J1.203 E.01711
G1 X129.659 Y123.09 E.16881
G3 X129.264 Y123.352 I-1.045 J-1.147 E.01745
G1 X132.65 Y126.739 E.17571
G1 X132.453 Y127.198 E.01835
G1 X128.805 Y123.55 E.18926
G3 X128.253 Y123.655 I-.614 J-1.736 E.0207
G1 X132.347 Y127.749 E.21242
G2 X132.362 Y128.42 I3.726 J.256 E.02466
G1 X127.306 Y123.364 E.26233
; WIPE_START
G1 X128.72 Y124.778 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X125.804 Y119.892 Z.6 F42000
G1 Z.2
G1 E.8 F1800
G1 F5167.737
M204 S500
G1 X125.461 Y119.549 E.01781
G2 X124.968 Y119.713 I1.122 J4.189 E.01906
G1 X125.456 Y120.201 E.02533
G1 X125.424 Y120.291 E.00352
G1 X125.344 Y120.745 E.01691
G1 X124.499 Y119.9 E.04385
G2 X124.051 Y120.109 I1.522 J3.848 E.01814
G1 X125.643 Y121.702 E.08263
; WIPE_START
G1 X124.229 Y120.288 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X123.473 Y120.188 Z.6 F42000
G1 Z.2
G1 E.8 F1800
G1 F5167.737
M204 S500
G1 X128.711 Y125.422 E.27163
G3 X130.574 Y127.289 I-.739 J2.6 E.10109
G1 X135.665 Y132.38 E.26416
G3 X135.418 Y132.79 I-3.527 J-1.854 E.01756
G1 X130.668 Y128.04 E.2464
G3 X130.6 Y128.629 I-3.617 J-.124 E.02175
G1 X135.151 Y133.18 E.23614
G3 X134.865 Y133.551 I-3.258 J-2.216 E.01719
G1 X130.427 Y129.112 E.23029
G3 X130.187 Y129.529 I-1.469 J-.569 E.01771
G1 X134.562 Y133.905 E.22702
G3 X134.242 Y134.241 I-2.965 J-2.502 E.01705
G1 X129.887 Y129.886 E.22593
G3 X129.531 Y130.187 I-1.151 J-1.002 E.01717
G1 X133.905 Y134.561 E.22691
G3 X133.55 Y134.863 I-2.7 J-2.804 E.0171
G1 X129.116 Y130.429 E.23004
G1 X128.625 Y130.595 E.01901
G1 X133.178 Y135.148 E.23621
G3 X132.789 Y135.416 I-2.537 J-3.269 E.01733
G1 X127.831 Y130.457 E.25726
; WIPE_START
G1 X129.245 Y131.871 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X128.175 Y125.547 Z.6 F42000
G1 Z.2
G1 E.8 F1800
G1 F5167.737
M204 S500
G1 X123.214 Y120.586 E.25737
G2 X122.824 Y120.853 I2.024 J3.386 E.01735
G1 X127.378 Y125.407 E.23627
G2 X126.891 Y125.576 I.306 J1.66 E.01899
G1 X122.451 Y121.137 E.23034
M73 P43 R8
G1 X122.096 Y121.438 E.0171
G1 X126.472 Y125.814 E.22706
G2 X126.113 Y126.112 I.784 J1.31 E.01718
G1 X121.76 Y121.759 E.22586
G2 X121.441 Y122.097 I2.666 J2.835 E.01705
G1 X125.812 Y126.467 E.22676
G1 X125.576 Y126.888 E.0177
G1 X121.139 Y122.452 E.23018
G2 X120.855 Y122.824 I2.966 J2.562 E.0172
G1 X125.409 Y127.379 E.23631
G2 X125.331 Y127.958 I1.835 J.542 E.02151
G1 X120.588 Y123.214 E.24612
G2 X120.339 Y123.622 I3.283 J2.278 E.01754
G1 X125.431 Y128.714 E.26418
G1 X125.453 Y128.807 E.00349
G2 X127.285 Y130.568 I2.565 J-.835 E.09707
G1 X132.382 Y135.665 E.26444
G1 X131.955 Y135.895 E.01779
G1 X130.637 Y134.577 E.06835
G3 X130.66 Y135.257 I-2.187 J.415 E.02506
G1 X131.506 Y136.103 E.04387
G3 X131.036 Y136.29 I-1.8 J-3.842 E.01856
G1 X130.547 Y135.801 E.02535
G3 X130.351 Y136.261 I-1.591 J-.406 E.01844
G1 X130.706 Y136.616 E.01839
; WIPE_START
G1 X130.351 Y136.261 E-.19046
G1 X130.442 Y136.094 E-.07247
G1 X130.547 Y135.801 E-.11828
G1 X131.036 Y136.29 E-.2626
G1 X131.32 Y136.177 E-.11619
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X128.695 Y132.635 Z.6 F42000
G1 Z.2
G1 E.8 F1800
G1 F5167.737
M204 S500
G1 X123.645 Y127.588 E.26196
G3 X123.657 Y128.253 I-2.151 J.373 E.02453
G1 X127.749 Y132.345 E.2123
G2 X127.197 Y132.45 I.063 J1.839 E.02069
G1 X123.552 Y128.805 E.1891
G1 X123.353 Y129.263 E.01831
G1 X126.739 Y132.649 E.17567
G2 X126.344 Y132.911 I.694 J1.473 E.01744
G1 X123.091 Y129.658 E.1688
G3 X122.771 Y129.995 I-1.251 J-.867 E.01711
G1 X126.007 Y133.231 E.1679
G2 X125.727 Y133.608 I1.08 J1.095 E.01729
G1 X122.394 Y130.275 E.17292
G3 X121.957 Y130.494 I-.928 J-1.308 E.01803
G1 X125.508 Y134.046 E.18427
G1 X125.369 Y134.563 E.01966
G1 X121.439 Y130.633 E.20387
G3 X120.81 Y130.661 I-.403 J-2.022 E.02321
G1 X125.341 Y135.192 E.23511
G1 X125.346 Y135.307 E.00419
G2 X125.549 Y136.057 I2.531 J-.282 E.02861
G1 X119.946 Y130.453 E.2907
G1 X119.591 Y130.268 E.0147
G1 X119.509 Y130.396 E.00558
G2 X119.632 Y130.796 I3.404 J-.828 E.01539
G1 X125.208 Y136.373 E.28932
G3 X124.088 Y135.91 I2.942 J-8.698 E.0445
G1 X120.093 Y131.914 E.20728
G2 X121.646 Y134.124 I7.694 J-3.757 E.09949
G1 X123.119 Y135.597 E.07645
; WIPE_START
G1 X121.705 Y134.183 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X121.701 Y126.551 Z.6 F42000
G1 X121.7 Y125.64 Z.6
G1 Z.2
G1 E.8 F1800
G1 F5167.737
M204 S500
G1 X120.11 Y124.05 E.08252
G2 X119.9 Y124.497 I3.63 J1.97 E.01814
G1 X120.745 Y125.342 E.04382
G1 X120.294 Y125.422 E.01681
G1 X120.201 Y125.455 E.00361
G1 X119.714 Y124.967 E.02528
G2 X119.549 Y125.459 I3.84 J1.565 E.01903
G1 X119.892 Y125.803 E.01784
M204 S6000
G1 X119.332 Y126.084 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.11365
G1 F3000
M204 S500
G2 X119.22 Y126.206 I.076 J.183 E.00095
M204 S6000
G1 X119.17 Y127.049 F42000
; LINE_WIDTH: 0.451678
G1 F3000
M204 S500
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
M204 S6000
G1 X119.22 Y129.794 F42000
; LINE_WIDTH: 0.112752
G1 F3000
M204 S500
G2 X119.307 Y129.899 I.156 J-.041 E.00077
G1 X119.349 Y129.926 E.00027
; WIPE_START
G1 X119.307 Y129.899 E-.19982
G1 X119.255 Y129.859 E-.26376
G1 X119.22 Y129.794 E-.29641
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X124.613 Y135.195 Z.6 F42000
G1 X126.087 Y136.67 Z.6
G1 Z.2
G1 E.8 F1800
; LINE_WIDTH: 0.113851
G1 F3000
M204 S500
G2 X126.211 Y136.785 I.189 J-.08 E.00097
M204 S6000
G1 X127.054 Y136.834 F42000
; LINE_WIDTH: 0.420774
G1 F3000
M204 S500
G1 X127.112 Y136.971 E.00445
; LINE_WIDTH: 0.451023
G1 X127.17 Y137.108 E.0048
; LINE_WIDTH: 0.485873
G1 X127.181 Y137.132 E.00094
; LINE_WIDTH: 0.525316
G1 X127.193 Y137.156 E.00102
; LINE_WIDTH: 0.532524
G1 X127.314 Y137.182 E.0048
; LINE_WIDTH: 0.499656
G1 X127.468 Y137.209 E.00563
; LINE_WIDTH: 0.448217
G2 X128.416 Y137.224 I.529 J-3.416 E.03046
; LINE_WIDTH: 0.48911
M73 P44 R8
G2 X128.8 Y137.158 I-.276 J-2.724 E.01372
; LINE_WIDTH: 0.529309
G1 X129.059 Y137.107 E.01017
M204 S6000
G1 X129.795 Y136.782 F42000
; LINE_WIDTH: 0.113837
G1 F3000
M204 S500
G2 X129.918 Y136.67 I-.058 J-.187 E.00096
; OBJECT_ID: 114
; WIPE_START
G1 X129.856 Y136.751 E-.45315
G1 X129.795 Y136.782 E-.30685
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S6000
G1 X122.163 Y136.751 Z.6 F42000
G1 X107.691 Y136.691 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.5
G1 F3000
M204 S500
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
M204 S6000
G1 X111.245 Y131.011 Z.6 F42000
G1 X115.409 Y126.831 Z.6
G1 Z.2
G1 E.8 F1800
G1 F3000
M204 S500
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
M204 S6000
G1 X110.844 Y122.776 Z.6 F42000
G1 X108.373 Y119.79 Z.6
G1 Z.2
G1 E.8 F1800
G1 F3000
M204 S500
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
M204 S6000
G1 X104.99 Y126.935 Z.6 F42000
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
M204 S500
G1 X105.146 Y126.691 E.01046
G3 X106.837 Y125.727 I1.868 J1.31 E.0726
G3 X108.248 Y126.083 I.158 J2.351 E.05343
G3 X104.969 Y126.991 I-1.234 J1.919 E.37884
M204 S6000
G1 X105.383 Y127.169 F42000
; FEATURE: Outer wall
G1 F3000
M204 S500
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
M204 S6000
G1 X108.683 Y119.452 Z.6 F42000
G1 Z.2
G1 E.8 F1800
; FEATURE: Inner wall
G1 F3000
M204 S500
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
M204 S6000
G1 X104.626 Y125.041 Z.6 F42000
G1 X101.716 Y128.629 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Outer wall
G1 F3000
M204 S500
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
M204 S6000
G1 X103.829 Y123.04 Z.6 F42000
G1 X106.284 Y118.357 Z.6
G1 Z.2
G1 E.8 F1800
G1 F3000
M204 S500
G3 X107.166 Y118.331 I.728 J9.696 E.03189
G3 X102.449 Y119.467 I-.167 J9.67 E2.01698
G3 X106.224 Y118.362 I4.564 J8.586 E.14303
M204 S6000
G1 X106.318 Y118.818 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.501307
G1 F3000
M204 S500
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
M204 S6000
G1 X108.8 Y119.218 F42000
; LINE_WIDTH: 0.113799
G1 F3000
M204 S500
G3 X108.922 Y119.33 I-.058 J.186 E.00096
; WIPE_START
G1 X108.861 Y119.249 E-.45317
G1 X108.8 Y119.218 E-.30683
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X106.318 Y118.818 Z.6 F42000
G1 Z.2
G1 E.8 F1800
; LINE_WIDTH: 0.532457
G1 F3000
M204 S500
G1 X106.199 Y118.843 E.00468
; LINE_WIDTH: 0.523748
G1 X106.187 Y118.869 E.00108
; LINE_WIDTH: 0.48196
G1 X106.175 Y118.895 E.00098
; LINE_WIDTH: 0.44607
G1 X106.118 Y119.03 E.00468
; LINE_WIDTH: 0.416064
G1 X106.061 Y119.165 E.00433
M204 S6000
G1 X105.215 Y119.215 F42000
; LINE_WIDTH: 0.113854
G1 F3000
M204 S500
G2 X105.091 Y119.33 I.065 J.194 E.00097
; WIPE_START
G1 X105.153 Y119.249 E-.4478
G1 X105.215 Y119.215 E-.3122
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X111.595 Y123.405 Z.6 F42000
G1 X115.677 Y126.084 Z.6
G1 Z.2
G1 E.8 F1800
; LINE_WIDTH: 0.114358
G1 F3000
M204 S500
G3 X115.792 Y126.21 I-.073 J.183 E.00099
M204 S6000
G1 X116.11 Y126.947 F42000
; LINE_WIDTH: 0.546301
G1 F3000
M204 S500
G1 X116.166 Y127.204 E.01047
; LINE_WIDTH: 0.528989
G1 X116.191 Y127.333 E.00504
; LINE_WIDTH: 0.491614
G3 X116.22 Y127.497 I-2.02 J.449 E.00589
; LINE_WIDTH: 0.450282
G3 X116.215 Y128.534 I-3.944 J.501 E.03347
; LINE_WIDTH: 0.495365
G1 X116.19 Y128.669 E.0049
; LINE_WIDTH: 0.53029
G1 X116.166 Y128.804 E.00528
G1 X116.379 Y129.146 E.01553
M204 S6000
G1 X115.792 Y129.79 F42000
; LINE_WIDTH: 0.114377
G1 F3000
M204 S500
G3 X115.677 Y129.916 I-.189 J-.057 E.001
M204 S6000
G1 X115.115 Y130.198 F42000
; FEATURE: Bottom surface
; LINE_WIDTH: 0.50734
G1 F5167.737
M204 S500
G1 X115.458 Y130.542 E.01781
G3 X115.294 Y131.034 I-4.197 J-1.124 E.01906
G1 X114.806 Y130.546 E.02534
G1 X114.719 Y130.578 E.00337
G1 X114.261 Y130.658 E.01707
G1 X115.107 Y131.504 E.04387
G3 X114.898 Y131.952 I-3.845 J-1.516 E.01815
G1 X113.305 Y130.359 E.08267
; WIPE_START
G1 X114.719 Y131.773 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X112.873 Y124.367 Z.6 F42000
G1 X111.884 Y120.4 Z.6
G1 Z.2
G1 E.8 F1800
G1 F5167.737
M204 S500
G3 X113.479 Y121.995 I-106.416 J107.986 E.08275
G3 X114.923 Y124.095 I-6.711 J6.161 E.09382
M73 P45 R8
G1 X110.91 Y120.082 E.20821
G2 X109.799 Y119.628 I-4.099 J8.442 E.04406
G1 X115.382 Y125.211 E.28964
G1 X115.518 Y125.652 E.01694
G1 X115.445 Y125.747 E.00439
G1 X115.059 Y125.545 E.01599
G1 X109.462 Y119.948 E.29039
G3 X109.668 Y120.81 I-2.753 J1.113 E.03266
G1 X114.196 Y125.339 E.23497
G2 X113.567 Y125.367 I-.221 J2.155 E.02319
G1 X109.64 Y121.439 E.20376
G1 X109.5 Y121.956 E.01964
G1 X113.05 Y125.507 E.18421
G2 X112.613 Y125.726 I.491 J1.526 E.01802
G1 X109.281 Y122.394 E.17289
G3 X109 Y122.77 I-1.359 J-.719 E.01729
G1 X112.236 Y126.006 E.16789
G2 X111.917 Y126.344 I.931 J1.203 E.01711
G1 X108.663 Y123.09 E.16881
G3 X108.268 Y123.352 I-1.045 J-1.147 E.01745
G1 X111.655 Y126.739 E.17571
G1 X111.458 Y127.198 E.01835
G1 X107.81 Y123.55 E.18926
G3 X107.258 Y123.655 I-.614 J-1.736 E.0207
G1 X111.352 Y127.749 E.21242
G2 X111.366 Y128.42 I3.726 J.256 E.02466
G1 X106.31 Y123.364 E.26233
; WIPE_START
G1 X107.724 Y124.778 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X104.808 Y119.892 Z.6 F42000
G1 Z.2
G1 E.8 F1800
G1 F5167.737
M204 S500
G1 X104.465 Y119.549 E.01781
G2 X103.972 Y119.713 I1.122 J4.189 E.01906
G1 X104.461 Y120.201 E.02533
G1 X104.428 Y120.291 E.00352
G1 X104.348 Y120.745 E.01691
G1 X103.503 Y119.9 E.04385
G2 X103.055 Y120.109 I1.522 J3.848 E.01814
G1 X104.648 Y121.702 E.08263
; WIPE_START
G1 X103.234 Y120.288 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X102.477 Y120.188 Z.6 F42000
G1 Z.2
G1 E.8 F1800
G1 F5167.737
M204 S500
G1 X107.715 Y125.422 E.27163
G3 X109.578 Y127.289 I-.739 J2.6 E.10109
G1 X114.67 Y132.38 E.26416
G3 X114.422 Y132.79 I-3.527 J-1.854 E.01756
G1 X109.673 Y128.04 E.2464
G3 X109.604 Y128.629 I-3.617 J-.124 E.02175
G1 X114.156 Y133.18 E.23614
G3 X113.87 Y133.551 I-3.258 J-2.216 E.01719
G1 X109.431 Y129.112 E.23029
G3 X109.191 Y129.529 I-1.469 J-.569 E.01771
G1 X113.567 Y133.905 E.22702
G3 X113.246 Y134.241 I-2.965 J-2.502 E.01705
G1 X108.892 Y129.886 E.22593
G3 X108.536 Y130.187 I-1.151 J-1.002 E.01717
G1 X112.909 Y134.561 E.22691
G3 X112.555 Y134.863 I-2.7 J-2.804 E.0171
G1 X108.121 Y130.429 E.23004
G1 X107.63 Y130.595 E.01901
G1 X112.183 Y135.148 E.23621
G3 X111.794 Y135.416 I-2.537 J-3.269 E.01733
G1 X106.835 Y130.457 E.25726
; WIPE_START
G1 X108.249 Y131.871 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X107.18 Y125.547 Z.6 F42000
G1 Z.2
G1 E.8 F1800
G1 F5167.737
M204 S500
G1 X102.219 Y120.586 E.25737
G2 X101.828 Y120.853 I2.024 J3.386 E.01735
G1 X106.382 Y125.407 E.23627
G2 X105.895 Y125.576 I.306 J1.66 E.01899
G1 X101.456 Y121.137 E.23034
G1 X101.1 Y121.438 E.0171
G1 X105.477 Y125.814 E.22706
G2 X105.118 Y126.112 I.784 J1.31 E.01718
G1 X100.764 Y121.759 E.22586
G2 X100.445 Y122.097 I2.666 J2.835 E.01705
G1 X104.816 Y126.467 E.22676
G1 X104.58 Y126.888 E.0177
G1 X100.144 Y122.452 E.23018
G2 X99.859 Y122.824 I2.966 J2.562 E.0172
G1 X104.414 Y127.379 E.23631
G2 X104.336 Y127.958 I1.835 J.542 E.02151
G1 X99.592 Y123.214 E.24612
G2 X99.344 Y123.622 I3.283 J2.278 E.01754
G1 X104.436 Y128.714 E.26418
G1 X104.457 Y128.807 E.00349
G2 X106.289 Y130.568 I2.565 J-.835 E.09707
G1 X111.386 Y135.665 E.26444
G1 X110.959 Y135.895 E.01779
G1 X109.642 Y134.577 E.06835
G3 X109.665 Y135.257 I-2.187 J.415 E.02506
G1 X110.511 Y136.103 E.04387
G3 X110.041 Y136.29 I-1.8 J-3.842 E.01856
G1 X109.552 Y135.801 E.02535
G3 X109.356 Y136.261 I-1.591 J-.406 E.01844
G1 X109.71 Y136.616 E.01839
; WIPE_START
G1 X109.356 Y136.261 E-.19046
G1 X109.447 Y136.094 E-.07247
G1 X109.552 Y135.801 E-.11828
G1 X110.041 Y136.29 E-.2626
G1 X110.325 Y136.177 E-.11619
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X107.7 Y132.635 Z.6 F42000
G1 Z.2
G1 E.8 F1800
M73 P46 R8
G1 F5167.737
M204 S500
G1 X102.649 Y127.588 E.26196
G3 X102.661 Y128.253 I-2.151 J.373 E.02453
G1 X106.753 Y132.345 E.2123
G2 X106.201 Y132.45 I.063 J1.839 E.02069
G1 X102.556 Y128.805 E.1891
G1 X102.357 Y129.263 E.01831
G1 X105.743 Y132.649 E.17567
G2 X105.349 Y132.911 I.694 J1.473 E.01744
G1 X102.095 Y129.658 E.1688
G3 X101.776 Y129.995 I-1.251 J-.867 E.01711
G1 X105.012 Y133.231 E.1679
G2 X104.732 Y133.608 I1.08 J1.095 E.01729
G1 X101.399 Y130.275 E.17292
G3 X100.961 Y130.494 I-.928 J-1.308 E.01803
G1 X104.513 Y134.046 E.18427
G1 X104.373 Y134.563 E.01966
G1 X100.444 Y130.633 E.20387
G3 X99.814 Y130.661 I-.403 J-2.022 E.02321
G1 X104.346 Y135.192 E.23511
G1 X104.35 Y135.307 E.00419
G2 X104.553 Y136.057 I2.531 J-.282 E.02861
G1 X98.95 Y130.453 E.2907
G1 X98.595 Y130.268 E.0147
G1 X98.513 Y130.396 E.00558
G2 X98.636 Y130.796 I3.404 J-.828 E.01539
G1 X104.213 Y136.373 E.28932
G3 X103.093 Y135.91 I2.942 J-8.698 E.0445
G1 X99.097 Y131.914 E.20728
G2 X100.65 Y134.124 I7.694 J-3.757 E.09949
G1 X102.124 Y135.597 E.07645
; WIPE_START
G1 X100.71 Y134.183 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X100.705 Y126.551 Z.6 F42000
G1 X100.705 Y125.64 Z.6
G1 Z.2
G1 E.8 F1800
G1 F5167.737
M204 S500
G1 X99.114 Y124.05 E.08252
G2 X98.905 Y124.497 I3.63 J1.97 E.01814
G1 X99.75 Y125.342 E.04382
G1 X99.298 Y125.422 E.01681
G1 X99.206 Y125.455 E.00361
G1 X98.718 Y124.967 E.02528
G2 X98.553 Y125.459 I3.84 J1.565 E.01903
G1 X98.897 Y125.803 E.01784
M204 S6000
G1 X98.337 Y126.084 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.11365
G1 F3000
M204 S500
G2 X98.225 Y126.206 I.076 J.183 E.00095
M204 S6000
G1 X98.174 Y127.049 F42000
; LINE_WIDTH: 0.451678
G1 F3000
M204 S500
G1 X98.027 Y127.112 E.00519
; LINE_WIDTH: 0.482673
G1 X97.879 Y127.176 E.00558
; LINE_WIDTH: 0.518408
G1 X97.852 Y127.189 E.00115
G1 X97.805 Y127.421 E.00887
; LINE_WIDTH: 0.482768
G1 X97.793 Y127.499 E.00275
; LINE_WIDTH: 0.449639
G2 X97.796 Y128.535 I3.831 J.504 E.03338
; LINE_WIDTH: 0.484588
G1 X97.799 Y128.552 E.0006
; LINE_WIDTH: 0.50133
G1 X97.825 Y128.682 E.00481
; LINE_WIDTH: 0.524265
G1 X97.851 Y128.812 E.00505
G1 X97.896 Y128.833 E.00186
; LINE_WIDTH: 0.457451
G1 X98.035 Y128.893 E.00498
; LINE_WIDTH: 0.427006
G1 X98.175 Y128.953 E.00461
M204 S6000
G1 X98.225 Y129.794 F42000
; LINE_WIDTH: 0.112752
G1 F3000
M204 S500
G2 X98.311 Y129.899 I.156 J-.041 E.00077
G1 X98.353 Y129.926 E.00027
; WIPE_START
G1 X98.311 Y129.899 E-.19982
G1 X98.259 Y129.859 E-.26376
G1 X98.225 Y129.794 E-.29641
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X103.618 Y135.195 Z.6 F42000
G1 X105.091 Y136.67 Z.6
G1 Z.2
G1 E.8 F1800
; LINE_WIDTH: 0.113851
G1 F3000
M204 S500
G2 X105.215 Y136.785 I.189 J-.08 E.00097
M204 S6000
G1 X106.058 Y136.834 F42000
; LINE_WIDTH: 0.420774
G1 F3000
M204 S500
G1 X106.116 Y136.971 E.00445
; LINE_WIDTH: 0.451023
G1 X106.175 Y137.108 E.0048
; LINE_WIDTH: 0.485873
G1 X106.186 Y137.132 E.00094
; LINE_WIDTH: 0.525316
G1 X106.197 Y137.156 E.00102
; LINE_WIDTH: 0.532524
G1 X106.319 Y137.182 E.0048
; LINE_WIDTH: 0.499656
G1 X106.473 Y137.209 E.00563
; LINE_WIDTH: 0.448217
G2 X107.421 Y137.224 I.529 J-3.416 E.03046
; LINE_WIDTH: 0.48911
G2 X107.804 Y137.158 I-.276 J-2.724 E.01372
; LINE_WIDTH: 0.529309
G1 X108.064 Y137.107 E.01017
M204 S6000
G1 X108.8 Y136.782 F42000
; LINE_WIDTH: 0.113837
G1 F3000
M204 S500
G2 X108.922 Y136.67 I-.058 J-.187 E.00096
; CHANGE_LAYER
; Z_HEIGHT: 0.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F3000
G1 X108.861 Y136.751 E-.45315
G1 X108.8 Y136.782 E-.30685
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 114
M625
; layer num/total_layer_count: 2/23
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
; open powerlost recovery
M1003 S1
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z.6 I.597 J1.061 P1  F42000
G1 X126.141 Y127.026 Z.6
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X126.285 Y126.792 E.00885
G3 X127.807 Y125.911 I1.717 J1.211 E.05837
G3 X129.045 Y126.179 I.193 J2.1 E.04135
G3 X126.114 Y127.08 I-1.043 J1.824 E.31398
M204 S250
G1 X126.478 Y127.227 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X126.611 Y127.022 E.00729
G3 X127.852 Y126.3 I1.399 J.98 E.04412
G3 X128.702 Y126.439 I.166 J1.654 E.02594
G3 X126.461 Y127.283 I-.691 J1.562 E.24069
; WIPE_START
M204 S6000
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
M204 S10000
G1 X122.978 Y128.709 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X122.89 Y128.935 E.00779
G3 X121.002 Y125.901 I-1.88 J-.934 E.2868
G3 X122.278 Y126.327 I-.015 J2.168 E.04397
G3 X123.011 Y128.636 I-1.268 J1.674 E.08304
G1 X123.003 Y128.654 E.00066
M204 S250
G1 X122.614 Y128.563 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X122.541 Y128.762 E.00632
G3 X121.017 Y126.293 I-1.529 J-.761 E.21644
G3 X121.58 Y126.39 I-.053 J1.98 E.01709
G3 X122.642 Y128.51 I-.569 J1.611 E.07804
; WIPE_START
M204 S6000
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
M204 S10000
G1 X126.042 Y123.82 Z.8 F42000
G1 X129.553 Y119.581 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X129.573 Y119.6 E.00089
G3 X127.841 Y118.902 I-1.57 J1.398 E.3626
G3 X128.712 Y119.024 I.125 J2.276 E.02845
G1 X128.789 Y119.049 E.0026
G3 X129.341 Y119.377 I-.786 J1.95 E.02073
G1 X129.51 Y119.54 E.00754
M204 S250
G1 X129.279 Y119.862 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X127.871 Y119.294 I-1.277 J1.136 E.273
G1 X128.133 Y119.294 E.0078
G3 X129.238 Y119.818 I-.131 J1.704 E.03725
; WIPE_START
M204 S6000
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
M204 S10000
G1 X135.805 Y126.076 Z.8 F42000
G1 X136.604 Y126.64 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X136.627 Y126.66 E.00098
G3 X134.842 Y125.907 I-1.617 J1.34 E.35948
G3 X136.146 Y126.234 I.151 J2.163 E.04396
G3 X136.403 Y126.429 I-1.136 J1.766 E.01037
G1 X136.563 Y126.596 E.00746
M204 S250
G1 X136.326 Y126.909 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X134.886 Y126.296 I-1.314 J1.091 E.2713
G3 X135.455 Y126.351 I.099 J1.978 E.01708
G3 X136.287 Y126.863 I-.444 J1.649 E.0295
; WIPE_START
M204 S6000
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
M204 S10000
G1 X131.31 Y134.293 Z.8 F42000
G1 X128.827 Y136.931 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X128.786 Y136.946 E.00138
G3 X127.922 Y132.902 I-.784 J-1.946 E.23524
G3 X129.143 Y133.238 I.071 J2.131 E.04136
G3 X129.143 Y136.761 I-1.141 J1.761 E.13444
G1 X128.88 Y136.903 E.00961
M204 S250
G1 X128.643 Y136.586 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X128.642 Y136.588 E.00006
G3 X127.952 Y133.293 I-.631 J-1.587 E.1773
G3 X128.518 Y133.369 I.023 J1.979 E.01709
G3 X128.921 Y136.446 I-.507 J1.631 E.11596
G1 X128.696 Y136.559 E.00748
; WIPE_START
M204 S6000
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
M204 S10000
G1 X127.038 Y128.617 Z.8 F42000
G1 X127.3 Y118.633 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X127.933 Y118.604 I.752 J9.805 E.02038
G3 X125.638 Y118.905 I.061 J9.395 E1.82356
G3 X127.24 Y118.637 I2.414 J9.533 E.0523
M204 S250
G1 X127.272 Y118.237 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X127.939 Y118.212 E.01989
G3 X125.539 Y118.525 I.054 J9.788 E1.75959
G3 X127.215 Y118.246 I2.511 J9.911 E.05067
; WIPE_START
M204 S6000
G1 X127.939 Y118.212 E-.27535
G1 X128.441 Y118.22 E-.19085
G1 X129.026 Y118.264 E-.22261
G1 X129.211 Y118.289 E-.0712
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z.8 I1.217 J0 P1  F42000
; stop printing object, unique label id: 78
M625
; object ids of layer 2 start: 78,114
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


; object ids of this layer2 end: 78,114
M625
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X129.091 Y118.874 F42000
G1 Z.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.3531
G1 F7737.446
M204 S6000
G1 X129.793 Y119.206 E.01903
M204 S10000
G1 X129.818 Y119.168 F42000
; LINE_WIDTH: 0.177555
G1 F15000
M204 S6000
G1 X129.211 Y118.957 E.00683
; LINE_WIDTH: 0.155808
G1 X129.082 Y118.917 E.0012
; LINE_WIDTH: 0.116544
M73 P47 R8
G1 X128.953 Y118.878 E.00078
; WIPE_START
G1 X129.082 Y118.917 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.042 Y118.883 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.117479
G1 F15000
M204 S6000
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
M204 S10000
G1 X123.534 Y123.464 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.43876
G1 F6063.056
M204 S6000
G1 X123.46 Y123.507 E.00268
G1 X123.525 Y123.545 E.00235
; WIPE_START
G1 X123.46 Y123.507 E-.35515
G1 X123.534 Y123.464 E-.40485
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.782 Y124.502 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.425781
G1 F6268.603
M204 S6000
G1 X124.327 Y124.039 E.01965
G1 X123.917 Y123.435 E.02208
G1 X123.633 Y122.87 E.01913
G2 X122.871 Y123.63 I4.157 J4.926 E.03258
G3 X124.502 Y124.78 I-1.817 J4.31 E.06082
G1 X124.739 Y124.545 E.0101
M204 S10000
G1 X124.898 Y124.909 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X125.369 Y124.498 E.01861
G3 X124.234 Y123.23 I2.899 J-3.736 E.05099
G1 X123.938 Y122.629 E.01996
G1 X123.809 Y122.25 E.01191
G2 X122.253 Y123.806 I4.046 J5.599 E.06582
G3 X124.49 Y125.353 I-1.301 J4.273 E.0823
G1 X124.857 Y124.953 E.01616
; WIPE_START
G1 X124.49 Y125.353 E-.2062
G1 X124.045 Y124.851 E-.2548
G1 X123.657 Y124.514 E-.19518
G1 X123.43 Y124.363 E-.10381
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.502 Y126.064 Z.8 F42000
G1 Z.4
G1 E.8 F1800
G1 F6364.866
M204 S6000
G3 X126.063 Y124.498 I3.474 J1.903 E.06673
G3 X124.049 Y121.634 I2.003 J-3.549 E.1078
G2 X121.629 Y124.057 I3.98 J6.392 E.10289
G1 X122.232 Y124.192 E.01839
G3 X124.47 Y126.013 I-1.322 J3.909 E.0878
; WIPE_START
G1 X124.199 Y125.593 E-.19007
G1 X123.794 Y125.133 E-.23289
G1 X123.324 Y124.74 E-.23278
G1 X123.089 Y124.599 E-.10426
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.496 Y127.105 Z.8 F42000
G1 Z.4
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X124.667 Y126.589 E.01618
G1 X124.98 Y125.998 E.01993
G3 X127.079 Y124.499 I3.096 J2.115 E.07842
G1 X126.485 Y124.292 E.01873
G3 X124.385 Y121.24 I1.581 J-3.336 E.11561
G1 X124.356 Y121.024 E.00648
G2 X121.464 Y123.616 I3.833 J7.186 E.11682
G1 X121.014 Y124.373 E.02621
G1 X121.788 Y124.461 E.02322
G3 X124.295 Y126.482 I-.787 J3.541 E.09938
G1 X124.478 Y127.048 E.0177
; WIPE_START
G1 X124.295 Y126.482 E-.22579
G1 X124.024 Y125.998 E-.21085
G1 X123.683 Y125.56 E-.21094
G1 X123.468 Y125.357 E-.11242
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.287 Y128.075 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.503135
G1 F5214.954
M204 S6000
G1 X124.268 Y128.439 E.01323
; LINE_WIDTH: 0.48938
G1 F5375.622
G1 X124.173 Y128.744 E.01128
; LINE_WIDTH: 0.420452
G1 F6357.082
G3 X122.914 Y130.627 I-3.36 J-.884 E.06881
G1 X122.33 Y130.96 E.02005
G1 X121.731 Y131.164 E.01887
G1 X121.199 Y131.243 E.01604
G1 X120.571 Y131.221 E.01873
G1 X120.395 Y131.187 E.00534
G2 X124.816 Y135.607 I7.606 J-3.186 E.19121
G1 X124.754 Y134.948 E.01974
G1 X124.8 Y134.452 E.01484
G3 X125.183 Y133.385 I6.091 J1.585 E.03387
G1 X125.463 Y132.974 E.01484
G1 X125.859 Y132.567 E.01693
G1 X126.432 Y132.162 E.02092
G1 X126.954 Y131.925 E.01708
; LINE_WIDTH: 0.438183
G1 F6071.915
G1 X127.301 Y131.833 E.01123
; LINE_WIDTH: 0.489389
G1 F5375.516
G1 X127.649 Y131.74 E.01269
G1 X128.314 Y131.735 E.02345
; LINE_WIDTH: 0.481543
G1 F5471.676
G1 X128.614 Y131.808 E.0107
; LINE_WIDTH: 0.420377
G1 F6358.348
G3 X131.206 Y135.505 I-.625 J3.196 E.14877
G1 X131.178 Y135.613 E.00334
G2 X133.742 Y133.926 I-3.476 J-8.071 E.09199
G2 X135.611 Y131.186 I-5.873 J-6.016 E.09955
G1 X134.95 Y131.248 E.0198
G1 X134.404 Y131.195 E.01637
G3 X133.387 Y130.819 I1.678 J-6.097 E.03235
G3 X131.867 Y128.838 I1.726 J-2.899 E.07628
; LINE_WIDTH: 0.43585
G1 F6107.958
G1 X131.805 Y128.591 E.0079
; LINE_WIDTH: 0.475599
G1 F5546.843
G1 X131.743 Y128.344 E.0087
G1 X131.726 Y127.84 E.01721
G1 X131.791 Y127.43 E.0142
; LINE_WIDTH: 0.420435
G1 F6357.373
G1 X131.953 Y126.888 E.01688
G1 X132.247 Y126.287 E.01993
G1 X132.612 Y125.8 E.01817
G1 X133.032 Y125.414 E.017
G3 X134.526 Y124.792 I2.058 J2.836 E.04869
G1 X135.228 Y124.765 E.02096
G1 X135.611 Y124.814 E.01152
G1 X135.216 Y123.996 E.02708
G2 X131.188 Y120.391 I-7.341 J4.149 E.1641
G1 X131.245 Y120.909 E.01556
G1 X131.204 Y121.547 E.01906
G3 X129.379 Y123.943 I-3.259 J-.591 E.09323
G1 X128.78 Y124.15 E.0189
; LINE_WIDTH: 0.442615
G1 F6004.579
G1 X128.605 Y124.208 E.00582
; LINE_WIDTH: 0.497413
G1 F5280.614
G1 X128.43 Y124.266 E.00661
G1 X127.854 Y124.275 E.02069
; LINE_WIDTH: 0.472828
G1 F5582.597
G1 X127.564 Y124.212 E.01008
; LINE_WIDTH: 0.420306
G1 F6359.536
G3 X126.818 Y124.02 I1.084 J-5.754 E.02297
G3 X125.463 Y123.026 I1.422 J-3.36 E.05055
G1 X125.156 Y122.569 E.01643
G1 X124.921 Y122.03 E.01752
G3 X124.816 Y120.393 I3.32 J-1.036 E.04937
G2 X120.395 Y124.813 I3.166 J7.587 E.19117
G1 X120.773 Y124.765 E.01134
G1 X121.474 Y124.791 E.02093
G1 X122.032 Y124.919 E.01706
G1 X122.557 Y125.145 E.01704
G1 X123.029 Y125.461 E.01691
G3 X124.122 Y127.172 I-1.935 J2.441 E.06166
; LINE_WIDTH: 0.443838
G1 F5986.269
G1 X124.196 Y127.37 E.00671
; LINE_WIDTH: 0.500373
G1 F5246.443
G1 X124.27 Y127.569 E.00766
G1 X124.285 Y128.015 E.01613
M204 S10000
G1 X123.876 Y127.99 F42000
; LINE_WIDTH: 0.41999
G1 F6364.871
M204 S6000
G3 X122.709 Y130.31 I-2.887 J.001 E.08023
G1 X122.175 Y130.616 E.01831
G1 X121.631 Y130.8 E.01713
G1 X121.069 Y130.871 E.01687
G3 X119.78 Y130.609 I.035 J-3.474 E.03941
G2 X125.399 Y136.214 I8.196 J-2.598 E.24572
G1 X125.222 Y135.721 E.01561
G3 X125.205 Y134.368 I3.029 J-.715 E.04064
G1 X125.44 Y133.709 E.02083
G1 X125.717 Y133.258 E.01576
G1 X126.076 Y132.875 E.01566
G1 X126.649 Y132.471 E.02089
G1 X127.113 Y132.268 E.01508
G1 X127.649 Y132.153 E.01633
G1 X128.351 Y132.153 E.0209
G1 X128.854 Y132.256 E.01531
G1 X129.315 Y132.446 E.01485
G1 X129.83 Y132.792 E.01848
G1 X130.26 Y133.224 E.01817
G3 X130.828 Y135.461 I-2.306 J1.776 E.07068
G1 X130.684 Y136.009 E.01689
G1 X130.579 Y136.231 E.0073
G1 X131.369 Y135.943 E.02506
G2 X133.917 Y134.28 I-3.738 J-8.505 E.09103
G2 X136.219 Y130.607 I-5.915 J-6.265 E.13051
G1 X135.721 Y130.781 E.01569
G3 X134.372 Y130.798 I-.713 J-2.985 E.04052
G1 X133.712 Y130.562 E.0209
G1 X133.261 Y130.286 E.01576
G3 X132.387 Y129.18 I2.03 J-2.502 E.0423
G1 X132.189 Y128.559 E.01942
G1 X132.13 Y128.043 E.01547
G1 X132.171 Y127.519 E.01567
G1 X132.303 Y127.029 E.01512
G1 X132.571 Y126.48 E.01818
G1 X132.903 Y126.04 E.01643
G1 X133.296 Y125.69 E.01567
G1 X133.668 Y125.456 E.0131
G3 X134.541 Y125.169 I1.377 J2.713 E.02746
G1 X135.242 Y125.141 E.02092
G1 X135.805 Y125.242 E.01702
G1 X136.219 Y125.393 E.01311
G2 X130.569 Y119.766 I-8.196 J2.579 E.24699
G1 X130.782 Y120.278 E.01652
G1 X130.868 Y120.924 E.01942
G1 X130.83 Y121.504 E.01732
G1 X130.69 Y122.012 E.01567
G3 X129.238 Y123.593 I-2.777 J-1.093 E.06542
G1 X128.694 Y123.782 E.01716
G1 X128.046 Y123.872 E.01949
G3 X127.097 Y123.726 I.687 J-7.631 E.02859
G1 X126.554 Y123.474 E.01786
G1 X126.042 Y123.099 E.01889
G1 X125.692 Y122.707 E.01567
G1 X125.427 Y122.264 E.01536
G1 X125.231 Y121.733 E.01687
G1 X125.134 Y121.153 E.0175
G1 X125.154 Y120.628 E.01566
G3 X125.393 Y119.778 I3.281 J.463 E.02636
G2 X119.791 Y125.399 I2.55 J8.143 E.24583
G1 X120.283 Y125.219 E.0156
G1 X120.759 Y125.142 E.01435
G1 X121.46 Y125.168 E.02091
G1 X121.961 Y125.291 E.01535
G3 X123.61 Y126.805 I-1.025 J2.772 E.06837
G1 X123.822 Y127.473 E.0209
G1 X123.87 Y127.93 E.01369
M204 S10000
G1 X123.498 Y128.014 F42000
; LINE_WIDTH: 0.41999
G1 F6364.867
M204 S6000
G3 X122.021 Y130.272 I-2.516 J-.034 E.0848
G1 X121.531 Y130.437 E.01541
G3 X119.402 Y129.896 I-.527 J-2.385 E.06787
G1 X119.311 Y129.988 E.00384
G1 X119.225 Y130.002 E.0026
G2 X126.021 Y136.781 I8.788 J-2.014 E.30149
G1 X126.046 Y136.654 E.00384
G1 X126.107 Y136.601 E.0024
G3 X125.56 Y134.495 I1.827 J-1.598 E.0672
G1 X125.795 Y133.837 E.02083
G3 X126.295 Y133.182 I2.12 J1.099 E.02465
G1 X126.867 Y132.779 E.02083
G1 X127.377 Y132.589 E.01621
G1 X127.704 Y132.53 E.00992
G1 X128.351 Y132.53 E.01927
G1 X128.769 Y132.625 E.01276
G1 X129.294 Y132.871 E.01727
G1 X129.723 Y133.192 E.01594
G1 X129.996 Y133.498 E.01224
G1 X130.315 Y134.073 E.01957
G1 X130.455 Y134.539 E.0145
G3 X130.319 Y135.913 I-2.79 J.417 E.04156
G1 X130.051 Y136.393 E.01636
G1 X130.202 Y136.729 E.01098
G2 X136.778 Y129.981 I-2.208 J-8.73 E.29536
G1 X136.656 Y129.955 E.00371
G1 X136.603 Y129.895 E.00239
G1 X136.325 Y130.115 E.01055
G1 X135.92 Y130.316 E.01348
G1 X135.303 Y130.478 E.019
G1 X134.892 Y130.494 E.01224
G1 X134.396 Y130.406 E.015
G1 X133.839 Y130.207 E.01764
G3 X132.935 Y129.395 I1.299 J-2.355 E.0365
G1 X132.653 Y128.83 E.01881
G1 X132.527 Y128.284 E.01671
G1 X132.527 Y127.716 E.0169
G1 X132.653 Y127.17 E.01671
G1 X132.895 Y126.673 E.01647
G1 X133.204 Y126.268 E.01517
G3 X134.555 Y125.546 I1.859 J1.854 E.04631
G1 X135.257 Y125.518 E.0209
G3 X136.492 Y126.013 I-.284 J2.501 E.04012
G1 X136.603 Y126.105 E.00428
G3 X136.78 Y126 I.161 J.07 E.00653
G2 X130.202 Y119.271 I-8.778 J2.001 E.29494
G1 X130.063 Y119.596 E.01053
G1 X130.371 Y120.246 E.02141
G1 X130.483 Y120.728 E.01475
G1 X130.483 Y121.218 E.0146
G1 X130.356 Y121.83 E.01861
G3 X129.978 Y122.525 I-2.354 J-.83 E.02365
G1 X129.52 Y122.975 E.01914
G1 X129.097 Y123.243 E.01493
G1 X128.608 Y123.415 E.01544
G1 X128.017 Y123.496 E.01777
G1 X127.388 Y123.405 E.01892
G1 X126.908 Y123.243 E.0151
G1 X126.418 Y122.921 E.01745
G1 X126.026 Y122.525 E.0166
G1 X125.771 Y122.11 E.0145
G1 X125.594 Y121.633 E.01515
G1 X125.509 Y121.11 E.01578
G3 X125.731 Y119.965 I2.783 J-.054 E.03499
G1 X126.018 Y119.509 E.01605
G1 X126.11 Y119.402 E.0042
G3 X126.005 Y119.231 I.067 J-.159 E.00636
G2 X119.572 Y124.833 I1.962 J8.747 E.26479
G1 X119.272 Y125.8 E.03015
G1 X119.223 Y126.019 E.00669
G1 X119.348 Y126.045 E.0038
G1 X119.396 Y126.098 E.00212
G1 X119.953 Y125.737 E.01977
G3 X120.745 Y125.519 I1.023 J2.168 E.02459
G1 X121.446 Y125.545 E.0209
G1 X122.021 Y125.728 E.01799
G1 X122.504 Y126.006 E.01659
G3 X123.25 Y126.919 I-1.701 J2.153 E.03539
G1 X123.463 Y127.588 E.0209
G1 X123.493 Y127.955 E.01097
; WIPE_START
G1 X123.463 Y127.588 E-.13998
G1 X123.25 Y126.919 E-.26665
G1 X123.052 Y126.576 E-.15046
G1 X122.811 Y126.28 E-.14523
G1 X122.697 Y126.179 E-.05767
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.523 Y127.781 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.872
M204 S6000
G1 X125.617 Y127.268 E.01553
G3 X126.194 Y126.28 I2.641 J.879 E.03435
G1 X126.633 Y125.921 E.01689
G1 X127.145 Y125.656 E.01717
G1 X127.541 Y125.547 E.01224
G1 X128.055 Y125.51 E.01535
G1 X128.65 Y125.589 E.01786
G1 X129.216 Y125.827 E.01829
G1 X129.646 Y126.122 E.01554
G1 X130.043 Y126.578 E.01799
G1 X130.308 Y127.047 E.01605
G1 X130.448 Y127.525 E.01484
G1 X130.492 Y128.092 E.01694
G1 X130.407 Y128.655 E.01696
G1 X130.176 Y129.22 E.01818
G1 X129.919 Y129.599 E.01366
G1 X129.507 Y129.983 E.01676
G1 X129.036 Y130.272 E.01645
G1 X128.434 Y130.452 E.01872
G1 X127.921 Y130.495 E.01534
G1 X127.315 Y130.392 E.0183
G1 X126.83 Y130.203 E.01553
G3 X125.524 Y127.841 I1.183 J-2.196 E.08492
; WIPE_START
G1 X125.533 Y128.356 E-.19544
G1 X125.618 Y128.739 E-.14937
G1 X125.759 Y129.095 E-.14522
G1 X125.952 Y129.424 E-.1452
G1 X126.16 Y129.679 E-.12477
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.515 Y124.725 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G3 X130.413 Y125.29 I-1.661 J3.637 E.0317
G1 X130.903 Y125.843 E.022
G3 X131.503 Y127.061 I-3.878 J2.668 E.0406
G1 X131.71 Y126.482 E.01831
G3 X134.213 Y124.462 I3.292 J1.518 E.09929
G3 X134.999 Y124.396 I.898 J6.044 E.0235
G2 X131.648 Y121.025 I-7.015 J3.621 E.14382
G3 X130.588 Y123.541 I-3.921 J-.171 E.08307
G3 X128.944 Y124.498 I-2.57 J-2.524 E.05736
G1 X129.459 Y124.703 E.01652
; WIPE_START
G1 X128.944 Y124.498 E-.21077
G1 X129.192 Y124.424 E-.09846
G1 X129.701 Y124.203 E-.21091
G1 X130.17 Y123.906 E-.21085
G1 X130.227 Y123.856 E-.029
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X130.1 Y126.064 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.88
M204 S6000
G1 X130.407 Y126.442 E.0145
G1 X130.682 Y126.967 E.01764
G1 X130.821 Y127.467 E.01547
G1 X130.869 Y128 E.01594
G1 X130.821 Y128.533 E.01594
G1 X130.682 Y129.033 E.01547
G1 X130.449 Y129.505 E.01567
G1 X130.19 Y129.861 E.01309
G1 X129.736 Y130.283 E.01848
G1 X129.217 Y130.603 E.01817
G1 X128.721 Y130.781 E.01567
G1 X128.289 Y130.858 E.01309
G3 X125.903 Y129.96 I-.24 J-2.98 E.07843
G3 X125.146 Y127.788 I2.157 J-1.97 E.07043
G1 X125.246 Y127.198 E.01783
G1 X125.448 Y126.687 E.01636
G3 X126.296 Y125.69 I2.724 J1.458 E.03928
G1 X126.801 Y125.397 E.01741
G1 X127.308 Y125.218 E.016
G1 X127.849 Y125.132 E.01633
G1 X128.351 Y125.148 E.01495
G1 X128.894 Y125.279 E.01664
G3 X130.057 Y126.022 I-.997 J2.841 E.04148
; WIPE_START
G1 X129.787 Y125.761 E-.14272
G1 X129.364 Y125.48 E-.19286
G1 X128.894 Y125.279 E-.19439
G1 X128.351 Y125.148 E-.21232
G1 X128.304 Y125.146 E-.01772
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.496 Y126.075 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G3 X134.372 Y124.052 I3.533 J1.967 E.10836
G2 X131.954 Y121.634 I-6.321 J3.903 E.10277
G3 X130.48 Y124.139 I-4.085 J-.718 E.08844
G1 X129.934 Y124.503 E.01956
G3 X131.463 Y126.024 I-1.933 J3.474 E.06508
M204 S10000
G1 X131.476 Y125.353 F42000
G1 F6364.866
M204 S6000
G1 X131.515 Y125.353 E.00115
G3 X132.772 Y124.232 I3.702 J2.888 E.05046
G1 X133.374 Y123.935 E.01996
G1 X133.754 Y123.806 E.01198
G2 X132.196 Y122.25 I-5.753 J4.204 E.06585
G1 X131.922 Y122.951 E.02242
G1 X131.578 Y123.526 E.01997
G1 X131.151 Y124.043 E.01996
G3 X130.624 Y124.506 I-4.019 J-4.043 E.02092
G1 X131.076 Y124.886 E.01759
G1 X131.437 Y125.307 E.01653
M204 S10000
G1 X131.492 Y124.789 F42000
; LINE_WIDTH: 0.425782
G1 F6268.59
M204 S6000
G1 X131.963 Y124.324 E.02001
G1 X132.567 Y123.915 E.02207
G1 X133.133 Y123.63 E.01916
G2 X132.373 Y122.867 I-5.47 J4.69 E.0326
G3 X131.223 Y124.5 I-4.313 J-1.817 E.06086
G1 X131.451 Y124.745 E.01014
; WIPE_START
G1 X131.223 Y124.5 E-.12739
G1 X131.435 Y124.296 E-.11178
G1 X131.793 Y123.887 E-.20644
G1 X132.087 Y123.435 E-.20502
G1 X132.217 Y123.178 E-.10936
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.519 Y123.465 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.43812
G1 F6072.875
M204 S6000
G1 X132.445 Y123.508 E.00267
G1 X132.51 Y123.545 E.00234
; WIPE_START
G1 X132.445 Y123.508 E-.35489
G1 X132.519 Y123.465 E-.40511
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P48 R8
G1 X132.519 Y131.097 Z.8 F42000
G1 X132.519 Y132.45 Z.8
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.43802
G1 F6074.411
M204 S6000
G1 X132.445 Y132.492 E.00267
G1 X132.51 Y132.53 E.00234
; WIPE_START
G1 X132.445 Y132.492 E-.3548
G1 X132.519 Y132.45 E-.4052
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.501 Y131.22 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.426656
G1 F6254.303
M204 S6000
G1 X131.225 Y131.5 E.01194
G1 X131.678 Y131.961 E.01958
G1 X132.087 Y132.565 E.02213
G1 X132.373 Y133.133 E.01926
G2 X133.141 Y132.36 I-4.724 J-5.468 E.03306
G3 X131.543 Y131.263 I1.553 J-3.975 E.0593
M204 S10000
G1 X130.65 Y131.483 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X130.63 Y131.498 E.00074
G3 X131.771 Y132.77 I-2.869 J3.717 E.05118
G3 X132.196 Y133.75 I-3.902 J2.277 E.03189
G2 X133.76 Y132.183 I-4.271 J-5.827 E.0662
G3 X131.525 Y130.66 I1.2 J-4.162 E.08195
G1 X131.488 Y130.648 E.00113
G3 X130.696 Y131.443 I-3.341 J-2.539 E.03355
M204 S10000
G1 X129.937 Y131.499 F42000
G1 F6364.866
M204 S6000
G3 X131.953 Y134.365 I-1.99 J3.542 E.10791
G2 X133.477 Y133.119 I-4.678 J-7.28 E.05874
G1 X134.06 Y132.415 E.02722
G1 X134.368 Y131.952 E.01656
G3 X132.978 Y131.452 I1.363 J-5.97 E.04413
G1 X132.512 Y131.135 E.01676
G1 X132.033 Y130.683 E.01963
G1 X131.656 Y130.195 E.01837
G1 X131.503 Y129.938 E.0089
G3 X129.987 Y131.466 I-3.454 J-1.911 E.06494
M204 S10000
G1 X129.392 Y131.348 F42000
G1 F6364.866
M204 S6000
G1 X128.944 Y131.502 E.01413
G1 X129.52 Y131.708 E.01822
G3 X131.62 Y134.76 I-1.581 J3.336 E.11562
G1 X131.638 Y134.969 E.00624
G2 X134.977 Y131.645 I-3.564 J-6.92 E.14258
G1 X134.412 Y131.577 E.01698
G1 X133.623 Y131.331 E.02461
G3 X132.755 Y130.846 I.927 J-2.68 E.02976
G3 X131.503 Y128.939 I2.43 J-2.959 E.06901
G3 X129.446 Y131.321 I-3.483 J-.928 E.09702
; WIPE_START
G1 X129.887 Y131.097 E-.18811
M73 P48 R7
G1 X130.338 Y130.773 E-.21084
G1 X130.736 Y130.381 E-.21219
G1 X130.97 Y130.067 E-.14886
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.185 Y131.135 Z.8 F42000
G1 Z.4
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X126.621 Y130.931 E.01785
G1 X126.091 Y130.627 E.01822
G1 X125.684 Y130.278 E.01596
G1 X125.304 Y129.81 E.01796
G1 X125.06 Y129.376 E.01482
; LINE_WIDTH: 0.432788
G1 F6155.938
G1 X124.919 Y128.975 E.01311
; LINE_WIDTH: 0.458383
G1 F5776.695
G1 X124.779 Y128.573 E.01397
; LINE_WIDTH: 0.49942
G1 F5257.401
G1 X124.735 Y128.369 E.0075
G3 X124.739 Y127.593 I8.574 J-.35 E.02803
; LINE_WIDTH: 0.491053
G1 F5355.559
G1 X124.833 Y127.272 E.01183
; LINE_WIDTH: 0.422065
G1 F6330.04
G3 X127.455 Y124.798 I3.203 J.768 E.11424
; LINE_WIDTH: 0.435613
G1 F6111.652
G1 X127.703 Y124.759 E.00779
; LINE_WIDTH: 0.482637
G1 F5458.065
G1 X127.951 Y124.721 E.00873
G1 X128.454 Y124.743 E.01747
; LINE_WIDTH: 0.478918
G1 F5504.619
G1 X128.719 Y124.826 E.00957
; LINE_WIDTH: 0.421526
G1 F6339.05
G3 X130.254 Y125.665 I-.97 J3.6 E.05282
G1 X130.628 Y126.101 E.01718
G1 X130.97 Y126.684 E.02022
G1 X131.148 Y127.19 E.01603
; LINE_WIDTH: 0.440848
G1 F6031.249
G1 X131.212 Y127.431 E.00786
; LINE_WIDTH: 0.49175
G1 F5347.238
G1 X131.276 Y127.673 E.00886
G1 X131.281 Y128.177 E.01786
; LINE_WIDTH: 0.471898
G1 F5594.699
G1 X131.231 Y128.423 E.00852
; LINE_WIDTH: 0.422506
G1 F6322.682
G1 X131.181 Y128.67 E.00754
G1 X130.988 Y129.281 E.01923
G3 X130.462 Y130.122 I-3.112 J-1.361 E.02984
G1 X129.965 Y130.583 E.02034
G3 X128.58 Y131.204 I-2.271 J-3.207 E.04579
; LINE_WIDTH: 0.458103
G1 F5780.59
G1 X128.442 Y131.24 E.00467
; LINE_WIDTH: 0.500006
G1 F5250.653
G1 X128.305 Y131.276 E.00514
G1 X127.743 Y131.276 E.02027
; LINE_WIDTH: 0.483253
G1 F5450.426
G1 X127.493 Y131.213 E.00897
; LINE_WIDTH: 0.441078
G1 F6027.766
G1 X127.243 Y131.15 E.00811
M204 S10000
G1 X126.481 Y131.282 F42000
; LINE_WIDTH: 0.41999
G1 F6364.871
M204 S6000
G1 X125.886 Y130.943 E.0204
G3 X124.502 Y128.935 I2.256 J-3.035 E.07396
G1 X124.295 Y129.517 E.01842
G3 X121.242 Y131.617 I-3.336 J-1.581 E.11562
G1 X121.026 Y131.648 E.00651
G2 X124.356 Y134.976 I7.012 J-3.687 E.14238
G1 X124.423 Y134.426 E.01649
G3 X124.827 Y133.246 I6.636 J1.608 E.03722
G3 X125.908 Y132.071 I2.871 J1.556 E.04804
G1 X126.423 Y131.734 E.01831
G1 X127.078 Y131.497 E.02077
G1 X126.538 Y131.302 E.01713
M204 S10000
G1 X126.073 Y131.503 F42000
; LINE_WIDTH: 0.419989
G1 F6364.881
M204 S6000
G1 X125.474 Y131.102 E.02145
G3 X124.502 Y129.936 I3.08 J-3.555 E.04541
G3 X121.636 Y131.952 I-3.544 J-1.994 E.1079
G2 X124.049 Y134.366 I6.366 J-3.95 E.10254
G3 X124.499 Y133.059 I6.944 J1.664 E.04125
G3 X125.691 Y131.762 I3.195 J1.74 E.05296
G1 X126.023 Y131.536 E.01197
M204 S10000
G1 X125.391 Y131.512 F42000
; LINE_WIDTH: 0.419989
G1 F6364.886
M204 S6000
G1 X124.96 Y131.149 E.0168
G1 X124.502 Y130.63 E.0206
G3 X123.232 Y131.768 I-3.769 J-2.928 E.05108
G1 X122.631 Y132.064 E.01996
G1 X122.253 Y132.194 E.01189
G2 X123.821 Y133.759 I5.572 J-4.013 E.06628
G3 X125.342 Y131.546 I3.987 J1.112 E.08145
M204 S10000
G1 X124.785 Y131.5 F42000
; LINE_WIDTH: 0.426673
G1 F6254.029
M204 S6000
G1 X124.502 Y131.22 E.01205
G1 X124.041 Y131.675 E.01964
G1 X123.437 Y132.085 E.02213
G3 X122.871 Y132.37 I-3.021 J-5.291 E.01922
G2 X123.642 Y133.139 I4.923 J-4.17 E.03304
G3 X124.741 Y131.541 I3.952 J1.542 E.05929
; WIPE_START
G1 X124.569 Y131.704 E-.08993
G1 X124.207 Y132.11 E-.20663
G1 X123.916 Y132.568 E-.20634
G1 X123.642 Y133.139 E-.24046
G1 X123.61 Y133.109 E-.01664
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.534 Y132.45 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.43862
G1 F6065.201
M204 S6000
G1 X123.46 Y132.493 E.00268
G1 X123.525 Y132.531 E.00235
; WIPE_START
G1 X123.46 Y132.493 E-.35507
G1 X123.534 Y132.45 E-.40493
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.496 Y136.779 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.097089
G1 F15000
M204 S6000
G1 X126.518 Y136.803 E.00014
; LINE_WIDTH: 0.12304
G1 X126.636 Y136.917 E.00103
; LINE_WIDTH: 0.172947
G1 X126.754 Y137.03 E.00168
; LINE_WIDTH: 0.192079
G1 X126.778 Y137.04 E.00031
; LINE_WIDTH: 0.161211
G1 X126.917 Y137.081 E.00136
; LINE_WIDTH: 0.117491
G1 X127.042 Y137.117 E.00077
; WIPE_START
G1 X126.917 Y137.081 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.953 Y137.122 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.116545
G1 F15000
M204 S6000
G1 X129.082 Y137.083 E.00078
; LINE_WIDTH: 0.155797
G1 X129.211 Y137.043 E.0012
; LINE_WIDTH: 0.177519
G1 X129.818 Y136.832 E.00683
M204 S10000
G1 X129.793 Y136.794 F42000
; LINE_WIDTH: 0.353151
G1 F7736.185
M204 S6000
G1 X129.091 Y137.126 E.01903
; WIPE_START
G1 X129.793 Y136.794 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.075 Y131.285 Z.8 F42000
G1 X136.782 Y129.506 Z.8
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.0970554
G1 F15000
M204 S6000
G1 X136.805 Y129.484 E.00014
; LINE_WIDTH: 0.122772
G1 X136.918 Y129.367 E.00102
; LINE_WIDTH: 0.172289
G1 X137.03 Y129.25 E.00166
; LINE_WIDTH: 0.188856
G1 X137.042 Y129.219 E.00039
; LINE_WIDTH: 0.158083
G1 X137.083 Y129.084 E.00129
; LINE_WIDTH: 0.116752
G1 X137.121 Y128.959 E.00076
; WIPE_START
G1 X137.083 Y129.084 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.12 Y127.041 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.116755
G1 F15000
M204 S6000
G1 X137.083 Y126.916 E.00076
; LINE_WIDTH: 0.15806
G1 X137.042 Y126.781 E.00128
; LINE_WIDTH: 0.188856
G1 X137.03 Y126.749 E.00039
; LINE_WIDTH: 0.172326
G1 X136.918 Y126.633 E.00166
; LINE_WIDTH: 0.122804
G1 X136.805 Y126.516 E.00102
; LINE_WIDTH: 0.0970654
G1 X136.781 Y126.494 E.00014
; WIPE_START
G1 X136.805 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.173 Y126.506 Z.8 F42000
G1 X119.223 Y126.494 Z.8
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.0970684
G1 F15000
M204 S6000
G1 X119.199 Y126.516 E.00014
; LINE_WIDTH: 0.122719
G1 X119.087 Y126.632 E.00102
; LINE_WIDTH: 0.175218
G1 X118.975 Y126.749 E.00169
G1 X118.958 Y126.791 E.00047
; LINE_WIDTH: 0.157736
G1 X118.922 Y126.908 E.00111
; LINE_WIDTH: 0.117847
G1 X118.883 Y127.044 E.00083
; WIPE_START
G1 X118.922 Y126.908 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X118.883 Y128.956 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.117852
G1 F15000
M204 S6000
G1 X118.922 Y129.092 E.00083
; LINE_WIDTH: 0.157741
G1 X118.958 Y129.209 E.00111
; LINE_WIDTH: 0.175227
G1 X118.975 Y129.251 E.00047
G1 X119.087 Y129.368 E.00169
; LINE_WIDTH: 0.122741
G1 X119.199 Y129.484 E.00102
; LINE_WIDTH: 0.0970835
G1 X119.223 Y129.506 E.00014
; OBJECT_ID: 114
; WIPE_START
G1 X119.199 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S10000
G1 X111.681 Y128.169 Z.8 F42000
G1 X105.145 Y127.026 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X105.289 Y126.792 E.00885
G3 X106.812 Y125.911 I1.717 J1.211 E.05837
G3 X108.049 Y126.179 I.193 J2.1 E.04135
G3 X105.119 Y127.08 I-1.043 J1.824 E.31398
M204 S250
G1 X105.482 Y127.227 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X105.616 Y127.022 E.00729
G3 X106.857 Y126.3 I1.399 J.98 E.04412
G3 X107.706 Y126.439 I.166 J1.654 E.02594
G3 X105.466 Y127.283 I-.691 J1.562 E.24069
; WIPE_START
M204 S6000
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
M204 S10000
G1 X101.983 Y128.709 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X101.895 Y128.935 E.00779
G3 X100.007 Y125.901 I-1.88 J-.934 E.2868
G3 X101.282 Y126.327 I-.015 J2.168 E.04397
G3 X102.016 Y128.636 I-1.268 J1.674 E.08304
G1 X102.007 Y128.654 E.00066
M204 S250
G1 X101.619 Y128.563 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X101.545 Y128.762 E.00632
G3 X100.022 Y126.293 I-1.529 J-.761 E.21644
G3 X100.585 Y126.39 I-.053 J1.98 E.01709
G3 X101.647 Y128.51 I-.569 J1.611 E.07804
; WIPE_START
M204 S6000
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
M204 S10000
G1 X105.046 Y123.82 Z.8 F42000
G1 X108.557 Y119.581 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X108.577 Y119.6 E.00089
G3 X106.846 Y118.902 I-1.57 J1.398 E.3626
G3 X107.716 Y119.024 I.125 J2.276 E.02845
G1 X107.793 Y119.049 E.0026
G3 X108.345 Y119.377 I-.786 J1.95 E.02073
G1 X108.514 Y119.54 E.00754
M204 S250
G1 X108.283 Y119.862 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X106.876 Y119.294 I-1.277 J1.136 E.273
G1 X107.138 Y119.294 E.0078
G3 X108.243 Y119.818 I-.131 J1.704 E.03725
; WIPE_START
M204 S6000
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
M204 S10000
G1 X114.809 Y126.076 Z.8 F42000
G1 X115.609 Y126.64 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X115.631 Y126.66 E.00098
G3 X113.846 Y125.907 I-1.617 J1.34 E.35948
G3 X115.15 Y126.234 I.151 J2.163 E.04396
G3 X115.407 Y126.429 I-1.136 J1.766 E.01037
G1 X115.567 Y126.596 E.00746
M204 S250
G1 X115.33 Y126.909 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X113.891 Y126.296 I-1.314 J1.091 E.2713
G3 X114.46 Y126.351 I.099 J1.978 E.01708
G3 X115.291 Y126.863 I-.444 J1.649 E.0295
; WIPE_START
M204 S6000
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
M204 S10000
G1 X110.315 Y134.293 Z.8 F42000
G1 X107.831 Y136.931 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X107.791 Y136.946 E.00138
G3 X106.926 Y132.902 I-.784 J-1.946 E.23524
G3 X108.148 Y133.238 I.071 J2.131 E.04136
G3 X108.147 Y136.761 I-1.141 J1.761 E.13444
G1 X107.884 Y136.903 E.00961
M204 S250
G1 X107.647 Y136.586 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X107.647 Y136.588 E.00006
G3 X106.956 Y133.293 I-.631 J-1.587 E.1773
G3 X107.523 Y133.369 I.023 J1.979 E.01709
G3 X107.925 Y136.446 I-.507 J1.631 E.11596
G1 X107.701 Y136.559 E.00748
; WIPE_START
M204 S6000
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
M204 S10000
G1 X106.043 Y128.617 Z.8 F42000
G1 X106.305 Y118.633 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X106.938 Y118.604 I.752 J9.805 E.02038
G3 X104.642 Y118.905 I.061 J9.395 E1.82356
G3 X106.245 Y118.637 I2.414 J9.533 E.0523
M204 S250
G1 X106.276 Y118.237 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X106.944 Y118.212 E.01989
G3 X104.544 Y118.525 I.054 J9.788 E1.75959
G3 X106.22 Y118.246 I2.511 J9.911 E.05067
M204 S10000
G1 X106.047 Y118.883 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.117479
G1 F15000
M204 S6000
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
M204 S10000
G1 X107.958 Y118.878 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.116544
G1 F15000
M204 S6000
G1 X108.087 Y118.917 E.00078
; LINE_WIDTH: 0.155808
G1 X108.216 Y118.957 E.0012
; LINE_WIDTH: 0.177555
G1 X108.822 Y119.168 E.00683
M204 S10000
G1 X108.797 Y119.206 F42000
; LINE_WIDTH: 0.3531
G1 F7737.446
M204 S6000
G1 X108.095 Y118.874 E.01903
; WIPE_START
G1 X108.797 Y119.206 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.538 Y123.464 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.43876
G1 F6063.056
M204 S6000
G1 X102.464 Y123.507 E.00268
G1 X102.529 Y123.545 E.00235
; WIPE_START
G1 X102.464 Y123.507 E-.35515
G1 X102.538 Y123.464 E-.40485
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.786 Y124.502 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.425781
G1 F6268.603
M204 S6000
G1 X103.331 Y124.039 E.01965
G1 X102.922 Y123.435 E.02208
G1 X102.637 Y122.87 E.01913
G2 X101.875 Y123.63 I4.157 J4.926 E.03258
G3 X103.507 Y124.78 I-1.817 J4.31 E.06082
G1 X103.744 Y124.545 E.0101
M204 S10000
G1 X103.902 Y124.909 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X104.373 Y124.498 E.01861
G3 X103.238 Y123.23 I2.899 J-3.736 E.05099
G1 X102.942 Y122.629 E.01996
G1 X102.813 Y122.25 E.01191
G2 X101.258 Y123.806 I4.046 J5.599 E.06582
G3 X103.494 Y125.353 I-1.301 J4.273 E.0823
G1 X103.861 Y124.953 E.01616
; WIPE_START
G1 X103.494 Y125.353 E-.2062
G1 X103.049 Y124.851 E-.2548
G1 X102.662 Y124.514 E-.19518
G1 X102.434 Y124.363 E-.10381
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.507 Y126.064 Z.8 F42000
G1 Z.4
G1 E.8 F1800
G1 F6364.866
M204 S6000
G3 X105.067 Y124.498 I3.474 J1.903 E.06673
G3 X103.053 Y121.634 I2.003 J-3.549 E.1078
G2 X100.634 Y124.057 I3.98 J6.392 E.10289
G1 X101.237 Y124.192 E.01839
G3 X103.474 Y126.013 I-1.322 J3.909 E.0878
; WIPE_START
G1 X103.204 Y125.593 E-.19007
G1 X102.798 Y125.133 E-.23289
G1 X102.328 Y124.74 E-.23278
G1 X102.093 Y124.599 E-.10426
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.501 Y127.105 Z.8 F42000
G1 Z.4
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X103.671 Y126.589 E.01618
G1 X103.984 Y125.998 E.01993
G3 X106.083 Y124.499 I3.096 J2.115 E.07842
G1 X105.489 Y124.292 E.01873
G3 X103.389 Y121.24 I1.581 J-3.336 E.11561
G1 X103.36 Y121.024 E.00648
G2 X100.468 Y123.616 I3.833 J7.186 E.11682
G1 X100.018 Y124.373 E.02621
G1 X100.793 Y124.461 E.02322
G3 X103.299 Y126.482 I-.787 J3.541 E.09938
G1 X103.482 Y127.048 E.0177
; WIPE_START
G1 X103.299 Y126.482 E-.22579
G1 X103.029 Y125.998 E-.21085
G1 X102.688 Y125.56 E-.21094
G1 X102.473 Y125.357 E-.11242
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.291 Y128.075 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.503135
G1 F5214.954
M204 S6000
G1 X103.273 Y128.439 E.01323
; LINE_WIDTH: 0.48938
G1 F5375.622
G1 X103.177 Y128.744 E.01128
; LINE_WIDTH: 0.420452
G1 F6357.082
G3 X101.918 Y130.627 I-3.36 J-.884 E.06881
G1 X101.334 Y130.96 E.02005
G1 X100.735 Y131.164 E.01887
G1 X100.203 Y131.243 E.01604
G1 X99.576 Y131.221 E.01873
G1 X99.4 Y131.187 E.00534
G2 X103.82 Y135.607 I7.606 J-3.186 E.19121
G1 X103.758 Y134.948 E.01974
G1 X103.805 Y134.452 E.01484
G3 X104.188 Y133.385 I6.091 J1.585 E.03387
G1 X104.468 Y132.974 E.01484
G1 X104.863 Y132.567 E.01693
G1 X105.437 Y132.162 E.02092
G1 X105.958 Y131.925 E.01708
; LINE_WIDTH: 0.438183
G1 F6071.915
G1 X106.306 Y131.833 E.01123
; LINE_WIDTH: 0.489389
G1 F5375.516
G1 X106.653 Y131.74 E.01269
G1 X107.318 Y131.735 E.02345
; LINE_WIDTH: 0.481543
G1 F5471.676
G1 X107.618 Y131.808 E.0107
; LINE_WIDTH: 0.420377
G1 F6358.348
G3 X110.211 Y135.505 I-.625 J3.196 E.14877
G1 X110.182 Y135.613 E.00334
G2 X112.746 Y133.926 I-3.476 J-8.071 E.09199
G2 X114.616 Y131.186 I-5.873 J-6.016 E.09955
G1 X113.955 Y131.248 E.0198
G1 X113.408 Y131.195 E.01637
G3 X112.392 Y130.819 I1.678 J-6.097 E.03235
G3 X110.871 Y128.838 I1.726 J-2.899 E.07628
; LINE_WIDTH: 0.43585
G1 F6107.958
G1 X110.81 Y128.591 E.0079
; LINE_WIDTH: 0.475599
G1 F5546.843
G1 X110.748 Y128.344 E.0087
G1 X110.731 Y127.84 E.01721
G1 X110.795 Y127.43 E.0142
; LINE_WIDTH: 0.420435
G1 F6357.373
G1 X110.958 Y126.888 E.01688
G1 X111.251 Y126.287 E.01993
G1 X111.617 Y125.8 E.01817
G1 X112.037 Y125.414 E.017
G3 X113.53 Y124.792 I2.058 J2.836 E.04869
G1 X114.233 Y124.765 E.02096
G1 X114.616 Y124.814 E.01152
G1 X114.221 Y123.996 E.02708
G2 X110.193 Y120.391 I-7.341 J4.149 E.1641
G1 X110.25 Y120.909 E.01556
G1 X110.209 Y121.547 E.01906
M73 P49 R7
G3 X108.383 Y123.943 I-3.259 J-.591 E.09323
G1 X107.784 Y124.15 E.0189
; LINE_WIDTH: 0.442615
G1 F6004.579
G1 X107.609 Y124.208 E.00582
; LINE_WIDTH: 0.497413
G1 F5280.614
G1 X107.435 Y124.266 E.00661
G1 X106.858 Y124.275 E.02069
; LINE_WIDTH: 0.472828
G1 F5582.597
G1 X106.568 Y124.212 E.01008
; LINE_WIDTH: 0.420306
G1 F6359.536
G3 X105.823 Y124.02 I1.084 J-5.754 E.02297
G3 X104.468 Y123.026 I1.422 J-3.36 E.05055
G1 X104.16 Y122.569 E.01643
G1 X103.926 Y122.03 E.01752
G3 X103.82 Y120.393 I3.32 J-1.036 E.04937
G2 X99.4 Y124.813 I3.166 J7.587 E.19117
G1 X99.777 Y124.765 E.01134
G1 X100.479 Y124.791 E.02093
G1 X101.037 Y124.919 E.01706
G1 X101.562 Y125.145 E.01704
G1 X102.033 Y125.461 E.01691
G3 X103.126 Y127.172 I-1.935 J2.441 E.06166
; LINE_WIDTH: 0.443838
G1 F5986.269
G1 X103.201 Y127.37 E.00671
; LINE_WIDTH: 0.500373
G1 F5246.443
G1 X103.275 Y127.569 E.00766
G1 X103.289 Y128.015 E.01613
M204 S10000
G1 X102.88 Y127.99 F42000
; LINE_WIDTH: 0.41999
G1 F6364.871
M204 S6000
G3 X101.713 Y130.31 I-2.887 J.001 E.08023
G1 X101.18 Y130.616 E.01831
G1 X100.635 Y130.8 E.01713
G1 X100.073 Y130.871 E.01687
G3 X98.784 Y130.609 I.035 J-3.474 E.03941
G2 X104.404 Y136.214 I8.196 J-2.598 E.24572
G1 X104.226 Y135.721 E.01561
G3 X104.209 Y134.368 I3.029 J-.715 E.04064
G1 X104.445 Y133.709 E.02083
G1 X104.721 Y133.258 E.01576
G1 X105.08 Y132.875 E.01566
G1 X105.654 Y132.471 E.02089
G1 X106.118 Y132.268 E.01508
G1 X106.654 Y132.153 E.01633
G1 X107.355 Y132.153 E.0209
G1 X107.859 Y132.256 E.01531
G1 X108.32 Y132.446 E.01485
G1 X108.835 Y132.792 E.01848
G1 X109.264 Y133.224 E.01817
G3 X109.833 Y135.461 I-2.306 J1.776 E.07068
G1 X109.688 Y136.009 E.01689
G1 X109.583 Y136.231 E.0073
G1 X110.374 Y135.943 E.02506
G2 X112.921 Y134.28 I-3.738 J-8.505 E.09103
G2 X115.223 Y130.607 I-5.915 J-6.265 E.13051
G1 X114.726 Y130.781 E.01569
G3 X113.377 Y130.798 I-.713 J-2.985 E.04052
G1 X112.716 Y130.562 E.0209
G1 X112.265 Y130.286 E.01576
G3 X111.392 Y129.18 I2.03 J-2.502 E.0423
G1 X111.193 Y128.559 E.01942
G1 X111.135 Y128.043 E.01547
G1 X111.175 Y127.519 E.01567
G1 X111.307 Y127.029 E.01512
G1 X111.575 Y126.48 E.01818
G1 X111.907 Y126.04 E.01643
G1 X112.3 Y125.69 E.01567
G1 X112.673 Y125.456 E.0131
G3 X113.545 Y125.169 I1.377 J2.713 E.02746
G1 X114.247 Y125.141 E.02092
G1 X114.81 Y125.242 E.01702
G1 X115.223 Y125.393 E.01311
G2 X109.573 Y119.766 I-8.196 J2.579 E.24699
G1 X109.787 Y120.278 E.01652
G1 X109.873 Y120.924 E.01942
G1 X109.834 Y121.504 E.01732
G1 X109.695 Y122.012 E.01567
G3 X108.242 Y123.593 I-2.777 J-1.093 E.06542
G1 X107.698 Y123.782 E.01716
G1 X107.05 Y123.872 E.01949
G3 X106.102 Y123.726 I.687 J-7.631 E.02859
G1 X105.558 Y123.474 E.01786
G1 X105.046 Y123.099 E.01889
G1 X104.697 Y122.707 E.01567
G1 X104.432 Y122.264 E.01536
G1 X104.235 Y121.733 E.01687
G1 X104.139 Y121.153 E.0175
G1 X104.159 Y120.628 E.01566
G3 X104.397 Y119.778 I3.281 J.463 E.02636
G2 X98.796 Y125.399 I2.55 J8.143 E.24583
G1 X99.287 Y125.219 E.0156
G1 X99.763 Y125.142 E.01435
G1 X100.465 Y125.168 E.02091
G1 X100.965 Y125.291 E.01535
G3 X102.614 Y126.805 I-1.025 J2.772 E.06837
G1 X102.826 Y127.473 E.0209
G1 X102.874 Y127.93 E.01369
M204 S10000
G1 X102.503 Y128.014 F42000
; LINE_WIDTH: 0.41999
G1 F6364.867
M204 S6000
G3 X101.026 Y130.272 I-2.516 J-.034 E.0848
G1 X100.535 Y130.437 E.01541
G3 X98.406 Y129.896 I-.527 J-2.385 E.06787
G1 X98.316 Y129.988 E.00384
G1 X98.23 Y130.002 E.0026
G2 X105.025 Y136.781 I8.788 J-2.014 E.30149
G1 X105.051 Y136.654 E.00384
G1 X105.111 Y136.601 E.0024
G3 X104.564 Y134.495 I1.827 J-1.598 E.0672
G1 X104.8 Y133.837 E.02083
G3 X105.299 Y133.182 I2.12 J1.099 E.02465
G1 X105.871 Y132.779 E.02083
G1 X106.381 Y132.589 E.01621
G1 X106.709 Y132.53 E.00992
G1 X107.356 Y132.53 E.01927
G1 X107.774 Y132.625 E.01276
G1 X108.298 Y132.871 E.01727
G1 X108.727 Y133.192 E.01594
G1 X109 Y133.498 E.01224
G1 X109.319 Y134.073 E.01957
G1 X109.46 Y134.539 E.0145
G3 X109.323 Y135.913 I-2.79 J.417 E.04156
G1 X109.055 Y136.393 E.01636
G1 X109.206 Y136.729 E.01098
G2 X115.783 Y129.981 I-2.208 J-8.73 E.29536
G1 X115.661 Y129.955 E.00371
G1 X115.608 Y129.895 E.00239
G1 X115.33 Y130.115 E.01055
G1 X114.924 Y130.316 E.01348
G1 X114.307 Y130.478 E.019
G1 X113.897 Y130.494 E.01224
G1 X113.401 Y130.406 E.015
G1 X112.843 Y130.207 E.01764
G3 X111.94 Y129.395 I1.299 J-2.355 E.0365
G1 X111.657 Y128.83 E.01881
G1 X111.531 Y128.284 E.01671
G1 X111.531 Y127.716 E.0169
G1 X111.657 Y127.17 E.01671
G1 X111.899 Y126.673 E.01647
G1 X112.209 Y126.268 E.01517
G3 X113.56 Y125.546 I1.859 J1.854 E.04631
G1 X114.261 Y125.518 E.0209
G3 X115.497 Y126.013 I-.284 J2.501 E.04012
G1 X115.608 Y126.105 E.00428
G3 X115.784 Y126 I.161 J.07 E.00653
G2 X109.206 Y119.271 I-8.778 J2.001 E.29494
G1 X109.067 Y119.596 E.01053
G1 X109.376 Y120.246 E.02141
G1 X109.488 Y120.728 E.01475
G1 X109.488 Y121.218 E.0146
G1 X109.361 Y121.83 E.01861
G3 X108.983 Y122.525 I-2.354 J-.83 E.02365
G1 X108.525 Y122.975 E.01914
G1 X108.101 Y123.243 E.01493
G1 X107.612 Y123.415 E.01544
G1 X107.021 Y123.496 E.01777
G1 X106.393 Y123.405 E.01892
G1 X105.912 Y123.243 E.0151
G1 X105.423 Y122.921 E.01745
G1 X105.031 Y122.525 E.0166
G1 X104.776 Y122.11 E.0145
G1 X104.599 Y121.633 E.01515
G1 X104.513 Y121.11 E.01578
G3 X104.735 Y119.965 I2.783 J-.054 E.03499
G1 X105.023 Y119.509 E.01605
G1 X105.114 Y119.402 E.0042
G3 X105.009 Y119.231 I.067 J-.159 E.00636
G2 X98.577 Y124.833 I1.962 J8.747 E.26479
G1 X98.276 Y125.8 E.03015
G1 X98.228 Y126.019 E.00669
G1 X98.353 Y126.045 E.0038
G1 X98.4 Y126.098 E.00212
G1 X98.957 Y125.737 E.01977
G3 X99.749 Y125.519 I1.023 J2.168 E.02459
G1 X100.45 Y125.545 E.0209
G1 X101.026 Y125.728 E.01799
G1 X101.508 Y126.006 E.01659
G3 X102.255 Y126.919 I-1.701 J2.153 E.03539
G1 X102.467 Y127.588 E.0209
G1 X102.498 Y127.955 E.01097
; WIPE_START
G1 X102.467 Y127.588 E-.13998
G1 X102.255 Y126.919 E-.26665
G1 X102.057 Y126.576 E-.15046
G1 X101.815 Y126.28 E-.14523
G1 X101.702 Y126.179 E-.05767
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.527 Y127.781 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.872
M204 S6000
G1 X104.621 Y127.268 E.01553
G3 X105.198 Y126.28 I2.641 J.879 E.03435
G1 X105.637 Y125.921 E.01689
G1 X106.149 Y125.656 E.01717
G1 X106.546 Y125.547 E.01224
G1 X107.06 Y125.51 E.01535
G1 X107.654 Y125.589 E.01786
G1 X108.22 Y125.827 E.01829
G1 X108.65 Y126.122 E.01554
G1 X109.047 Y126.578 E.01799
G1 X109.313 Y127.047 E.01605
G1 X109.453 Y127.525 E.01484
G1 X109.496 Y128.092 E.01694
G1 X109.411 Y128.655 E.01696
G1 X109.181 Y129.22 E.01818
G1 X108.923 Y129.599 E.01366
G1 X108.512 Y129.983 E.01676
G1 X108.041 Y130.272 E.01645
G1 X107.439 Y130.452 E.01872
G1 X106.926 Y130.495 E.01534
G1 X106.32 Y130.392 E.0183
G1 X105.834 Y130.203 E.01553
G3 X104.528 Y127.841 I1.183 J-2.196 E.08492
; WIPE_START
G1 X104.537 Y128.356 E-.19544
G1 X104.623 Y128.739 E-.14937
G1 X104.764 Y129.095 E-.14522
G1 X104.957 Y129.424 E-.1452
G1 X105.164 Y129.679 E-.12477
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.52 Y124.725 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G3 X109.418 Y125.29 I-1.661 J3.637 E.0317
G1 X109.907 Y125.843 E.022
G3 X110.508 Y127.061 I-3.878 J2.668 E.0406
G1 X110.714 Y126.482 E.01831
G3 X113.218 Y124.462 I3.292 J1.518 E.09929
G3 X114.003 Y124.396 I.898 J6.044 E.0235
G2 X110.653 Y121.025 I-7.015 J3.621 E.14382
G3 X109.592 Y123.541 I-3.921 J-.171 E.08307
G3 X107.948 Y124.498 I-2.57 J-2.524 E.05736
G1 X108.464 Y124.703 E.01652
; WIPE_START
G1 X107.948 Y124.498 E-.21077
G1 X108.196 Y124.424 E-.09846
G1 X108.705 Y124.203 E-.21091
G1 X109.174 Y123.906 E-.21085
G1 X109.232 Y123.856 E-.029
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.104 Y126.064 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.88
M204 S6000
G1 X109.411 Y126.442 E.0145
G1 X109.687 Y126.967 E.01764
G1 X109.825 Y127.467 E.01547
G1 X109.874 Y128 E.01594
G1 X109.825 Y128.533 E.01594
G1 X109.687 Y129.033 E.01547
G1 X109.453 Y129.505 E.01567
G1 X109.195 Y129.861 E.01309
G1 X108.74 Y130.283 E.01848
G1 X108.221 Y130.603 E.01817
G1 X107.726 Y130.781 E.01567
G1 X107.293 Y130.858 E.01309
G3 X104.907 Y129.96 I-.24 J-2.98 E.07843
G3 X104.15 Y127.788 I2.157 J-1.97 E.07043
G1 X104.251 Y127.198 E.01783
G1 X104.452 Y126.687 E.01636
G3 X105.3 Y125.69 I2.724 J1.458 E.03928
G1 X105.806 Y125.397 E.01741
G1 X106.312 Y125.218 E.016
G1 X106.854 Y125.132 E.01633
G1 X107.355 Y125.148 E.01495
G1 X107.898 Y125.279 E.01664
G3 X109.061 Y126.022 I-.997 J2.841 E.04148
; WIPE_START
G1 X108.791 Y125.761 E-.14272
G1 X108.369 Y125.48 E-.19286
G1 X107.898 Y125.279 E-.19439
G1 X107.355 Y125.148 E-.21232
G1 X107.309 Y125.146 E-.01772
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.5 Y126.075 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G3 X113.376 Y124.052 I3.533 J1.967 E.10836
G2 X110.958 Y121.634 I-6.321 J3.903 E.10277
G3 X109.484 Y124.139 I-4.085 J-.718 E.08844
G1 X108.938 Y124.503 E.01956
G3 X110.468 Y126.024 I-1.933 J3.474 E.06508
M204 S10000
G1 X110.481 Y125.353 F42000
G1 F6364.866
M204 S6000
G1 X110.519 Y125.353 E.00115
G3 X111.777 Y124.232 I3.702 J2.888 E.05046
G1 X112.378 Y123.935 E.01996
G1 X112.759 Y123.806 E.01198
G2 X111.201 Y122.25 I-5.753 J4.204 E.06585
G1 X110.927 Y122.951 E.02242
G1 X110.583 Y123.526 E.01997
G1 X110.156 Y124.043 E.01996
G3 X109.628 Y124.506 I-4.019 J-4.043 E.02092
G1 X110.08 Y124.886 E.01759
G1 X110.442 Y125.307 E.01653
M204 S10000
G1 X110.497 Y124.789 F42000
; LINE_WIDTH: 0.425782
G1 F6268.59
M204 S6000
G1 X110.968 Y124.324 E.02001
G1 X111.572 Y123.915 E.02207
G1 X112.137 Y123.63 E.01916
G2 X111.377 Y122.867 I-5.47 J4.69 E.0326
G3 X110.228 Y124.5 I-4.313 J-1.817 E.06086
G1 X110.456 Y124.745 E.01014
; WIPE_START
G1 X110.228 Y124.5 E-.12739
G1 X110.44 Y124.296 E-.11178
G1 X110.798 Y123.887 E-.20644
G1 X111.092 Y123.435 E-.20502
G1 X111.221 Y123.178 E-.10936
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X111.524 Y123.465 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.43812
G1 F6072.875
M204 S6000
G1 X111.45 Y123.508 E.00267
G1 X111.514 Y123.545 E.00234
; WIPE_START
G1 X111.45 Y123.508 E-.35489
G1 X111.524 Y123.465 E-.40511
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X111.524 Y131.097 Z.8 F42000
G1 X111.524 Y132.45 Z.8
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.43802
G1 F6074.411
M204 S6000
G1 X111.45 Y132.492 E.00267
G1 X111.514 Y132.53 E.00234
; WIPE_START
G1 X111.45 Y132.492 E-.3548
G1 X111.524 Y132.45 E-.4052
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.506 Y131.22 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.426656
G1 F6254.303
M204 S6000
G1 X110.229 Y131.5 E.01194
G1 X110.682 Y131.961 E.01958
G1 X111.092 Y132.565 E.02213
G1 X111.377 Y133.133 E.01926
G2 X112.146 Y132.36 I-4.724 J-5.468 E.03306
G3 X110.547 Y131.263 I1.553 J-3.975 E.0593
M204 S10000
G1 X109.655 Y131.483 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X109.635 Y131.498 E.00074
G3 X110.775 Y132.77 I-2.869 J3.717 E.05118
G3 X111.201 Y133.75 I-3.902 J2.277 E.03189
G2 X112.765 Y132.183 I-4.271 J-5.827 E.0662
G3 X110.529 Y130.66 I1.2 J-4.162 E.08195
G1 X110.493 Y130.648 E.00113
G3 X109.7 Y131.443 I-3.341 J-2.539 E.03355
M204 S10000
G1 X108.941 Y131.499 F42000
G1 F6364.866
M204 S6000
G3 X110.958 Y134.365 I-1.99 J3.542 E.10791
G2 X112.482 Y133.119 I-4.678 J-7.28 E.05874
G1 X113.065 Y132.415 E.02722
G1 X113.373 Y131.952 E.01656
G3 X111.982 Y131.452 I1.363 J-5.97 E.04413
G1 X111.517 Y131.135 E.01676
G1 X111.037 Y130.683 E.01963
G1 X110.66 Y130.195 E.01837
G1 X110.508 Y129.938 E.0089
G3 X108.992 Y131.466 I-3.454 J-1.911 E.06494
M204 S10000
G1 X108.397 Y131.348 F42000
G1 F6364.866
M204 S6000
G1 X107.948 Y131.502 E.01413
G1 X108.524 Y131.708 E.01822
G3 X110.624 Y134.76 I-1.581 J3.336 E.11562
G1 X110.642 Y134.969 E.00624
G2 X113.982 Y131.645 I-3.564 J-6.92 E.14258
G1 X113.416 Y131.577 E.01698
G1 X112.627 Y131.331 E.02461
G3 X111.759 Y130.846 I.927 J-2.68 E.02976
G3 X110.508 Y128.939 I2.43 J-2.959 E.06901
G3 X108.45 Y131.321 I-3.483 J-.928 E.09702
; WIPE_START
G1 X108.892 Y131.097 E-.18811
G1 X109.342 Y130.773 E-.21084
G1 X109.74 Y130.381 E-.21219
G1 X109.974 Y130.067 E-.14886
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.189 Y131.135 Z.8 F42000
G1 Z.4
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X105.626 Y130.931 E.01785
G1 X105.095 Y130.627 E.01822
G1 X104.688 Y130.278 E.01596
G1 X104.309 Y129.81 E.01796
G1 X104.064 Y129.376 E.01482
; LINE_WIDTH: 0.432788
G1 F6155.938
G1 X103.924 Y128.975 E.01311
; LINE_WIDTH: 0.458383
G1 F5776.695
G1 X103.783 Y128.573 E.01397
; LINE_WIDTH: 0.49942
G1 F5257.401
G1 X103.74 Y128.369 E.0075
G3 X103.743 Y127.593 I8.574 J-.35 E.02803
; LINE_WIDTH: 0.491053
G1 F5355.559
G1 X103.838 Y127.272 E.01183
; LINE_WIDTH: 0.422065
G1 F6330.04
G3 X106.459 Y124.798 I3.203 J.768 E.11424
; LINE_WIDTH: 0.435613
G1 F6111.652
G1 X106.708 Y124.759 E.00779
; LINE_WIDTH: 0.482637
G1 F5458.065
G1 X106.956 Y124.721 E.00873
G1 X107.458 Y124.743 E.01747
; LINE_WIDTH: 0.478918
G1 F5504.619
G1 X107.724 Y124.826 E.00957
; LINE_WIDTH: 0.421526
G1 F6339.05
G3 X109.259 Y125.665 I-.97 J3.6 E.05282
G1 X109.632 Y126.101 E.01718
G1 X109.974 Y126.684 E.02022
G1 X110.153 Y127.19 E.01603
; LINE_WIDTH: 0.440848
G1 F6031.249
G1 X110.217 Y127.431 E.00786
; LINE_WIDTH: 0.49175
G1 F5347.238
G1 X110.281 Y127.673 E.00886
G1 X110.285 Y128.177 E.01786
; LINE_WIDTH: 0.471898
G1 F5594.699
G1 X110.235 Y128.423 E.00852
; LINE_WIDTH: 0.422506
G1 F6322.682
G1 X110.186 Y128.67 E.00754
G1 X109.992 Y129.281 E.01923
G3 X109.467 Y130.122 I-3.112 J-1.361 E.02984
G1 X108.969 Y130.583 E.02034
G3 X107.585 Y131.204 I-2.271 J-3.207 E.04579
; LINE_WIDTH: 0.458103
G1 F5780.59
G1 X107.447 Y131.24 E.00467
; LINE_WIDTH: 0.500006
G1 F5250.653
G1 X107.309 Y131.276 E.00514
G1 X106.748 Y131.276 E.02027
; LINE_WIDTH: 0.483253
G1 F5450.426
G1 X106.498 Y131.213 E.00897
; LINE_WIDTH: 0.441078
G1 F6027.766
G1 X106.247 Y131.15 E.00811
M204 S10000
G1 X105.486 Y131.282 F42000
; LINE_WIDTH: 0.41999
G1 F6364.871
M204 S6000
G1 X104.89 Y130.943 E.0204
G3 X103.507 Y128.935 I2.256 J-3.035 E.07396
G1 X103.299 Y129.517 E.01842
G3 X100.246 Y131.617 I-3.336 J-1.581 E.11562
G1 X100.03 Y131.648 E.00651
G2 X103.36 Y134.976 I7.012 J-3.687 E.14238
G1 X103.428 Y134.426 E.01649
G3 X103.831 Y133.246 I6.636 J1.608 E.03722
G3 X104.912 Y132.071 I2.871 J1.556 E.04804
G1 X105.427 Y131.734 E.01831
G1 X106.083 Y131.497 E.02077
G1 X105.542 Y131.302 E.01713
M204 S10000
G1 X105.077 Y131.503 F42000
; LINE_WIDTH: 0.419989
G1 F6364.881
M204 S6000
G1 X104.479 Y131.102 E.02145
G3 X103.507 Y129.936 I3.08 J-3.555 E.04541
G3 X100.641 Y131.952 I-3.544 J-1.994 E.1079
G2 X103.053 Y134.366 I6.366 J-3.95 E.10254
G3 X103.504 Y133.059 I6.944 J1.664 E.04125
G3 X104.695 Y131.762 I3.195 J1.74 E.05296
G1 X105.028 Y131.536 E.01197
M204 S10000
G1 X104.396 Y131.512 F42000
; LINE_WIDTH: 0.419989
G1 F6364.886
M204 S6000
G1 X103.964 Y131.149 E.0168
G1 X103.507 Y130.63 E.0206
G3 X102.236 Y131.768 I-3.769 J-2.928 E.05108
G1 X101.635 Y132.064 E.01996
G1 X101.258 Y132.194 E.01189
G2 X102.825 Y133.759 I5.572 J-4.013 E.06628
G3 X104.347 Y131.546 I3.987 J1.112 E.08145
M204 S10000
G1 X103.789 Y131.5 F42000
; LINE_WIDTH: 0.426673
G1 F6254.029
M204 S6000
G1 X103.507 Y131.22 E.01205
G1 X103.046 Y131.675 E.01964
G1 X102.441 Y132.085 E.02213
G3 X101.875 Y132.37 I-3.021 J-5.291 E.01922
G2 X102.647 Y133.139 I4.923 J-4.17 E.03304
G3 X103.746 Y131.541 I3.952 J1.542 E.05929
; WIPE_START
G1 X103.574 Y131.704 E-.08993
G1 X103.212 Y132.11 E-.20663
G1 X102.92 Y132.568 E-.20634
G1 X102.647 Y133.139 E-.24046
G1 X102.614 Y133.109 E-.01664
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.538 Y132.45 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.43862
G1 F6065.201
M204 S6000
G1 X102.464 Y132.493 E.00268
G1 X102.529 Y132.531 E.00235
; WIPE_START
G1 X102.464 Y132.493 E-.35507
G1 X102.538 Y132.45 E-.40493
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.501 Y136.779 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.097089
G1 F15000
M204 S6000
G1 X105.522 Y136.803 E.00014
; LINE_WIDTH: 0.12304
G1 X105.64 Y136.917 E.00103
; LINE_WIDTH: 0.172947
G1 X105.758 Y137.03 E.00168
; LINE_WIDTH: 0.192079
G1 X105.782 Y137.04 E.00031
; LINE_WIDTH: 0.161211
G1 X105.922 Y137.081 E.00136
; LINE_WIDTH: 0.117491
G1 X106.047 Y137.117 E.00077
; WIPE_START
G1 X105.922 Y137.081 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.958 Y137.122 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.116545
G1 F15000
M204 S6000
G1 X108.087 Y137.083 E.00078
; LINE_WIDTH: 0.155797
G1 X108.215 Y137.043 E.0012
; LINE_WIDTH: 0.177519
G1 X108.822 Y136.832 E.00683
M204 S10000
G1 X108.797 Y136.794 F42000
; LINE_WIDTH: 0.353151
G1 F7736.185
M204 S6000
G1 X108.095 Y137.126 E.01903
; WIPE_START
G1 X108.797 Y136.794 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.08 Y131.285 Z.8 F42000
G1 X115.786 Y129.506 Z.8
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.0970554
G1 F15000
M204 S6000
G1 X115.81 Y129.484 E.00014
; LINE_WIDTH: 0.122772
G1 X115.922 Y129.367 E.00102
; LINE_WIDTH: 0.172289
G1 X116.035 Y129.25 E.00166
; LINE_WIDTH: 0.188856
G1 X116.047 Y129.219 E.00039
; LINE_WIDTH: 0.158083
G1 X116.088 Y129.084 E.00129
; LINE_WIDTH: 0.116752
G1 X116.125 Y128.959 E.00076
; WIPE_START
G1 X116.088 Y129.084 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X116.125 Y127.041 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.116755
G1 F15000
M204 S6000
G1 X116.088 Y126.916 E.00076
; LINE_WIDTH: 0.15806
G1 X116.047 Y126.781 E.00128
; LINE_WIDTH: 0.188856
G1 X116.035 Y126.749 E.00039
; LINE_WIDTH: 0.172326
G1 X115.922 Y126.633 E.00166
; LINE_WIDTH: 0.122804
G1 X115.81 Y126.516 E.00102
; LINE_WIDTH: 0.0970654
G1 X115.786 Y126.494 E.00014
; WIPE_START
G1 X115.81 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.177 Y126.506 Z.8 F42000
G1 X98.228 Y126.494 Z.8
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.0970684
G1 F15000
M204 S6000
G1 X98.204 Y126.516 E.00014
; LINE_WIDTH: 0.122719
G1 X98.091 Y126.632 E.00102
; LINE_WIDTH: 0.175218
G1 X97.979 Y126.749 E.00169
G1 X97.963 Y126.791 E.00047
; LINE_WIDTH: 0.157736
G1 X97.926 Y126.908 E.00111
; LINE_WIDTH: 0.117847
G1 X97.888 Y127.044 E.00083
; WIPE_START
G1 X97.926 Y126.908 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.888 Y128.956 Z.8 F42000
G1 Z.4
G1 E.8 F1800
; LINE_WIDTH: 0.117852
G1 F15000
M204 S6000
G1 X97.926 Y129.092 E.00083
; LINE_WIDTH: 0.157741
G1 X97.963 Y129.209 E.00111
; LINE_WIDTH: 0.175227
G1 X97.979 Y129.251 E.00047
G1 X98.091 Y129.368 E.00169
; LINE_WIDTH: 0.122741
G1 X98.204 Y129.484 E.00102
; LINE_WIDTH: 0.0970835
G1 X98.228 Y129.506 E.00014
; CHANGE_LAYER
; Z_HEIGHT: 0.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X98.204 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 114
M625
; layer num/total_layer_count: 3/23
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z.8 I.107 J1.212 P1  F42000
G1 X126.141 Y127.026 Z.8
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X126.29 Y126.796 E.00881
G3 X127.762 Y125.916 I1.719 J1.206 E.05679
G3 X129.402 Y126.429 I.236 J2.124 E.05688
G3 X126.121 Y127.082 I-1.392 J1.572 E.29991
M204 S250
G1 X126.478 Y127.226 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X126.606 Y127.018 E.00728
G3 X127.807 Y126.306 I1.396 J.985 E.04284
G3 X128.817 Y126.502 I.196 J1.694 E.03114
G3 X126.454 Y127.281 I-.815 J1.501 E.23663
; WIPE_START
M204 S6000
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
M204 S10000
G1 X128.601 Y133.909 Z1 F42000
G1 X128.815 Y136.938 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X128.789 Y136.952 E.00096
G3 X127.899 Y132.904 I-.779 J-1.951 E.23426
G3 X129.213 Y133.279 I.095 J2.155 E.0447
G3 X129.078 Y136.81 I-1.202 J1.722 E.135
G1 X128.869 Y136.912 E.00747
M204 S250
G1 X128.642 Y136.587 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X127.929 Y133.295 I-.631 J-1.586 E.17662
G3 X128.761 Y133.467 I.09 J1.663 E.0256
G3 X128.697 Y136.564 I-.751 J1.534 E.11557
; WIPE_START
M204 S6000
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
M204 S10000
G1 X132.279 Y130.894 Z1 F42000
G1 X136.605 Y126.641 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X136.627 Y126.66 E.00093
G3 X134.819 Y125.91 I-1.617 J1.341 E.35889
G3 X136.146 Y126.234 I.177 J2.15 E.0447
G3 X136.403 Y126.429 I-1.135 J1.767 E.01037
G1 X136.564 Y126.597 E.00751
M204 S250
M73 P50 R7
G1 X136.324 Y126.91 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X134.864 Y126.299 I-1.314 J1.091 E.2706
G3 X135.702 Y126.439 I.154 J1.658 E.0256
G3 X136.285 Y126.864 I-.692 J1.562 E.02166
; WIPE_START
M204 S6000
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
M204 S10000
G1 X131.91 Y122.669 Z1 F42000
G1 X129.553 Y119.581 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X129.573 Y119.6 E.00091
G3 X125.912 Y121.184 I-1.569 J1.397 E.25538
G3 X127.841 Y118.902 I2.098 J-.182 E.1068
G3 X129.341 Y119.376 I.163 J2.095 E.05185
G1 X129.51 Y119.539 E.00753
M204 S250
G1 X129.279 Y119.862 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X127.871 Y119.294 I-1.277 J1.137 E.27308
G3 X128.572 Y119.391 I.102 J1.844 E.02119
G1 X128.642 Y119.413 E.00219
G3 X129.238 Y119.818 I-.639 J1.585 E.02164
; WIPE_START
M204 S6000
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
M204 S10000
G1 X124.344 Y127.24 Z1 F42000
G1 X122.988 Y128.684 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X122.891 Y128.935 E.00868
G3 X120.051 Y126.13 I-1.881 J-.937 E.25511
G3 X120.761 Y125.91 I1.027 J2.061 E.02402
G3 X121.403 Y125.935 I.241 J2.089 E.02073
G3 X123.014 Y128.63 I-.392 J2.064 E.11404
M204 S250
G1 X122.625 Y128.537 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X122.532 Y128.757 E.00712
G3 X120.806 Y126.301 I-1.53 J-.76 E.21044
G1 X121.068 Y126.291 E.0078
G3 X122.641 Y128.479 I-.066 J1.707 E.09252
; WIPE_START
M204 S6000
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
M204 S10000
G1 X124.885 Y123.007 Z1 F42000
G1 X127.3 Y118.63 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X127.993 Y118.605 I.681 J9.295 E.0223
G3 X125.098 Y119.062 I-.001 J9.396 E1.80374
G3 X127.24 Y118.635 I2.882 J8.863 E.0704
M204 S250
G1 X127.272 Y118.237 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X127.999 Y118.213 E.02167
G3 X137.216 Y131.298 I.001 J9.788 E.55817
G3 X127.215 Y118.245 I-9.214 J-3.299 E1.24993
; WIPE_START
M204 S6000
G1 X127.999 Y118.213 E-.29833
G1 X128.441 Y118.22 E-.16811
G1 X129.026 Y118.264 E-.22261
G1 X129.211 Y118.289 E-.07094
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1 I1.217 J0 P1  F42000
; stop printing object, unique label id: 78
M625
; object ids of layer 3 start: 78,114
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
; object ids of this layer3 end: 78,114
M625
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X129.091 Y118.874 F42000
G1 Z.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.353126
G1 F7736.802
M204 S6000
G1 X129.793 Y119.206 E.01903
M204 S10000
G1 X129.818 Y119.168 F42000
; LINE_WIDTH: 0.177582
G1 F15000
M204 S6000
G1 X129.211 Y118.957 E.00683
; LINE_WIDTH: 0.155828
G1 X129.082 Y118.917 E.0012
; LINE_WIDTH: 0.116551
G1 X128.953 Y118.878 E.00078
; WIPE_START
G1 X129.082 Y118.917 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.042 Y118.883 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.117475
G1 F15000
M204 S6000
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
M204 S10000
G1 X121.122 Y124.595 Z1 F42000
G1 X119.223 Y126.494 Z1
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.0970641
G1 F15000
M204 S6000
G1 X119.199 Y126.516 E.00014
; LINE_WIDTH: 0.122719
G1 X119.087 Y126.632 E.00102
; LINE_WIDTH: 0.175216
G1 X118.975 Y126.749 E.00169
G1 X118.958 Y126.791 E.00047
; LINE_WIDTH: 0.157748
G1 X118.922 Y126.908 E.00111
; LINE_WIDTH: 0.117855
G1 X118.883 Y127.044 E.00083
; WIPE_START
G1 X118.922 Y126.908 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X118.883 Y128.956 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.117853
G1 F15000
M204 S6000
G1 X118.922 Y129.092 E.00083
; LINE_WIDTH: 0.157741
G1 X118.958 Y129.209 E.00111
; LINE_WIDTH: 0.175257
G1 X118.975 Y129.251 E.00047
G1 X119.087 Y129.368 E.00169
; LINE_WIDTH: 0.12276
G1 X119.199 Y129.484 E.00102
; LINE_WIDTH: 0.0971035
G1 X119.223 Y129.506 E.00014
; WIPE_START
G1 X119.199 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.534 Y132.45 Z1 F42000
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.43858
G1 F6065.814
M204 S6000
G1 X123.46 Y132.493 E.00268
G1 X123.525 Y132.531 E.00235
; WIPE_START
G1 X123.46 Y132.493 E-.35507
G1 X123.534 Y132.45 E-.40493
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.593 Y130.703 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G3 X124.502 Y128.935 I2.567 J-2.804 E.06269
G1 X124.295 Y129.517 E.01842
G3 X121.242 Y131.617 I-3.336 J-1.581 E.11562
G1 X121.026 Y131.648 E.00651
G2 X124.356 Y134.976 I7.012 J-3.688 E.14237
G1 X124.423 Y134.426 E.0165
G3 X124.827 Y133.246 I6.629 J1.605 E.03721
G3 X127.071 Y131.499 I3.16 J1.745 E.08706
G1 X126.493 Y131.292 E.01829
G3 X125.641 Y130.74 I1.414 J-3.117 E.03035
; WIPE_START
G1 X126.018 Y131.029 E-.18067
G1 X126.493 Y131.292 E-.20619
G1 X127.071 Y131.499 E-.23334
G1 X126.813 Y131.575 E-.10229
G1 X126.722 Y131.615 E-.03751
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.782 Y131.498 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.426676
G1 F6253.983
M204 S6000
G1 X124.502 Y131.22 E.01194
G1 X124.041 Y131.676 E.01965
G1 X123.437 Y132.085 E.02212
G3 X122.871 Y132.37 I-3.022 J-5.292 E.01922
G2 X123.642 Y133.138 I4.922 J-4.169 E.03304
G3 X124.739 Y131.539 I4.018 J1.58 E.05928
M204 S10000
G1 X124.502 Y130.63 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G3 X123.232 Y131.768 I-3.77 J-2.928 E.05108
G1 X122.631 Y132.065 E.01996
G1 X122.253 Y132.194 E.01189
G2 X123.821 Y133.759 I5.572 J-4.012 E.06628
G3 X124.853 Y131.957 I4.096 J1.151 E.06248
G1 X125.355 Y131.512 E.01998
G3 X124.54 Y130.676 I3.685 J-4.407 E.03483
M204 S10000
G1 X124.502 Y129.936 F42000
G1 F6364.866
M204 S6000
G3 X121.636 Y131.952 I-3.545 J-1.994 E.1079
G2 X124.049 Y134.366 I6.367 J-3.951 E.10254
G3 X124.499 Y133.059 I6.928 J1.658 E.04124
G3 X126.063 Y131.502 I3.476 J1.927 E.0666
G3 X124.535 Y129.987 I1.863 J-3.408 E.06494
; WIPE_START
G1 X124.805 Y130.407 E-.19007
G1 X125.16 Y130.82 E-.2067
G1 X125.582 Y131.19 E-.21329
G1 X125.913 Y131.405 E-.14994
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.498 Y128.014 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.867
M204 S6000
G3 X122.021 Y130.272 I-2.516 J-.035 E.0848
G1 X121.531 Y130.437 E.01541
G3 X120.314 Y130.398 I-.525 J-2.624 E.03659
G1 X119.674 Y130.112 E.02088
G1 X119.402 Y129.896 E.01034
G1 X119.312 Y129.988 E.00385
G1 X119.225 Y130.002 E.0026
G2 X126.021 Y136.781 I8.788 J-2.014 E.30148
G1 X126.046 Y136.655 E.00381
G1 X126.107 Y136.601 E.00243
G3 X125.714 Y135.994 I1.344 J-1.3 E.02166
G1 X125.528 Y135.319 E.02088
G3 X125.56 Y134.494 I2.364 J-.321 E.0247
G1 X125.795 Y133.837 E.02079
G1 X126.026 Y133.475 E.01278
G1 X126.418 Y133.079 E.0166
G1 X126.882 Y132.77 E.01661
G1 X127.472 Y132.567 E.0186
G3 X128.394 Y132.535 I.65 J5.361 E.02749
G1 X128.964 Y132.703 E.0177
G1 X129.426 Y132.95 E.01562
G3 X129.996 Y133.498 I-1.423 J2.049 E.02364
G1 X130.315 Y134.073 E.01957
G1 X130.455 Y134.539 E.0145
G1 X130.491 Y135.062 E.01561
G1 X130.466 Y135.355 E.00877
G1 X130.327 Y135.891 E.01648
G1 X130.05 Y136.392 E.01706
G1 X130.202 Y136.729 E.011
G2 X136.778 Y129.981 I-2.183 J-8.706 E.29545
G1 X136.656 Y129.956 E.00371
G1 X136.603 Y129.896 E.0024
G1 X136.334 Y130.109 E.01022
G1 X135.695 Y130.397 E.02088
G1 X135.183 Y130.485 E.01547
G1 X134.541 Y130.453 E.01914
G3 X132.754 Y129.081 I.472 J-2.465 E.06959
G1 X132.542 Y128.413 E.02088
G1 X132.513 Y127.901 E.01529
G1 X132.601 Y127.334 E.01709
G1 X132.772 Y126.88 E.01446
G3 X134.555 Y125.546 I2.255 J1.156 E.06868
G1 X135.256 Y125.518 E.02089
G3 X136.493 Y126.014 I-.284 J2.502 E.04017
G1 X136.604 Y126.105 E.00427
G3 X136.78 Y126.001 I.16 J.07 E.00651
G2 X130.202 Y119.271 I-8.778 J2.001 E.29495
G1 X130.063 Y119.596 E.01053
G1 X130.371 Y120.246 E.02142
G1 X130.483 Y120.728 E.01474
G1 X130.483 Y121.218 E.0146
G1 X130.356 Y121.83 E.01861
G3 X129.591 Y122.917 I-2.457 J-.917 E.04004
G1 X129.123 Y123.23 E.01677
G1 X128.608 Y123.415 E.01629
G1 X128.017 Y123.496 E.01777
G1 X127.388 Y123.405 E.01892
G1 X126.908 Y123.243 E.0151
G1 X126.418 Y122.921 E.01745
G1 X126.026 Y122.525 E.0166
G1 X125.771 Y122.11 E.0145
G1 X125.572 Y121.552 E.01765
G1 X125.52 Y120.747 E.02404
G3 X126.015 Y119.51 I2.502 J.284 E.04014
G1 X126.107 Y119.399 E.0043
G3 X126.003 Y119.223 I.07 J-.16 E.00649
G2 X123.041 Y120.495 I1.968 J8.67 E.09656
G2 X119.23 Y126.02 I4.903 J7.458 E.20494
G3 X119.401 Y126.104 I.028 J.158 E.00609
G1 X119.67 Y125.891 E.01023
G1 X120.31 Y125.603 E.02088
G1 X120.73 Y125.519 E.01278
G1 X121.334 Y125.532 E.01799
G1 X121.832 Y125.646 E.01523
G3 X123.494 Y127.955 I-.828 J2.348 E.09017
M204 S10000
G1 X123.874 Y128.043 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G3 X122.709 Y130.31 I-2.872 J-.043 E.07866
G1 X122.175 Y130.616 E.01831
G1 X121.631 Y130.8 E.01713
G1 X121.069 Y130.871 E.01687
G3 X119.765 Y130.565 I-.082 J-2.581 E.04035
G2 X125.399 Y136.214 I8.208 J-2.552 E.24713
G3 X125.144 Y135.29 I7.108 J-2.458 E.02857
G3 X125.205 Y134.367 I2.718 J-.285 E.02768
G1 X125.44 Y133.71 E.02079
G1 X125.717 Y133.258 E.01578
G1 X126.178 Y132.788 E.01962
G1 X126.689 Y132.445 E.01832
G1 X127.177 Y132.249 E.01567
G1 X127.649 Y132.153 E.01435
G1 X128.35 Y132.153 E.02088
G1 X128.854 Y132.256 E.01533
G1 X129.315 Y132.446 E.01485
G1 X129.83 Y132.792 E.01848
M73 P51 R7
G1 X130.26 Y133.225 E.01816
G3 X130.83 Y134.496 I-2.56 J1.911 E.04183
G1 X130.868 Y135.076 E.01733
G1 X130.831 Y135.45 E.01119
G1 X130.692 Y135.985 E.01648
G1 X130.574 Y136.233 E.00816
G2 X136.236 Y130.567 I-2.562 J-8.222 E.24814
G1 X135.725 Y130.78 E.01648
G3 X133.592 Y130.502 I-.707 J-2.901 E.06554
G3 X132.395 Y129.196 I1.395 J-2.48 E.05369
G1 X132.183 Y128.528 E.02088
G1 X132.129 Y128 E.01579
G1 X132.189 Y127.441 E.01675
G3 X134.54 Y125.169 I2.818 J.564 E.1036
G1 X135.242 Y125.141 E.02092
G1 X135.805 Y125.242 E.01703
G1 X136.219 Y125.393 E.01311
G2 X130.569 Y119.766 I-8.196 J2.579 E.24699
G1 X130.782 Y120.277 E.0165
G1 X130.868 Y120.924 E.01944
G1 X130.83 Y121.504 E.01732
G1 X130.69 Y122.012 E.01567
G3 X129.831 Y123.208 I-2.841 J-1.134 E.04432
G1 X129.315 Y123.554 E.01849
G1 X128.827 Y123.751 E.01567
G1 X128.264 Y123.855 E.01706
G1 X127.873 Y123.86 E.01166
G1 X127.224 Y123.761 E.01955
G1 X126.719 Y123.571 E.01606
G1 X126.178 Y123.212 E.01934
G1 X125.745 Y122.776 E.01832
G1 X125.459 Y122.334 E.01568
G3 X125.171 Y121.462 I2.415 J-1.279 E.02748
G1 X125.144 Y120.761 E.02088
G1 X125.244 Y120.197 E.01707
G1 X125.393 Y119.778 E.01326
G2 X123.92 Y120.399 I2.924 J8.987 E.04766
G2 X121.504 Y122.323 I4.237 J7.796 E.09247
G2 X119.765 Y125.435 I6.644 J5.757 E.10692
G1 X120.279 Y125.22 E.0166
G1 X120.716 Y125.142 E.01321
G1 X121.377 Y125.157 E.01971
G1 X121.932 Y125.283 E.01695
G1 X122.412 Y125.498 E.01566
G3 X123.87 Y127.983 I-1.453 J2.523 E.0898
M204 S10000
G1 X124.282 Y128.075 F42000
; LINE_WIDTH: 0.49842
G1 F5268.935
M204 S6000
G1 X124.268 Y128.439 E.0131
; LINE_WIDTH: 0.48938
G1 F5375.622
G1 X124.173 Y128.744 E.01128
; LINE_WIDTH: 0.420666
G1 F6353.49
G3 X122.914 Y130.627 I-3.36 J-.884 E.06885
G1 X122.33 Y130.96 E.02006
G1 X121.731 Y131.164 E.01888
G1 X121.199 Y131.243 E.01605
G1 X120.571 Y131.221 E.01874
G1 X120.395 Y131.187 E.00534
G2 X124.826 Y135.612 I7.607 J-3.186 E.19167
G1 X124.768 Y135.305 E.00933
G1 X124.759 Y134.804 E.01495
G1 X124.849 Y134.243 E.01693
G1 X125.085 Y133.583 E.02092
G1 X125.375 Y133.088 E.01712
G3 X126.626 Y132.057 I2.823 J2.15 E.04879
G1 X127.299 Y131.828 E.02123
; LINE_WIDTH: 0.44934
G1 F5905.222
G1 X127.474 Y131.78 E.00581
; LINE_WIDTH: 0.500636
G1 F5243.428
G1 X127.649 Y131.733 E.00654
G1 X128.314 Y131.735 E.02405
; LINE_WIDTH: 0.481498
G1 F5472.237
G1 X128.614 Y131.808 E.01069
; LINE_WIDTH: 0.420372
G1 F6358.438
G3 X131.204 Y134.452 I-.628 J3.207 E.11735
G1 X131.245 Y135.091 E.01906
G1 X131.178 Y135.613 E.01571
G2 X135.611 Y131.186 I-3.189 J-7.626 E.19158
G1 X134.95 Y131.248 E.0198
G1 X134.404 Y131.195 E.01636
G1 X133.845 Y131.036 E.01731
G3 X132.036 Y129.31 I1.227 J-3.098 E.07645
G1 X131.823 Y128.642 E.0209
; LINE_WIDTH: 0.439123
G1 F6057.508
G1 X131.777 Y128.459 E.00589
; LINE_WIDTH: 0.494711
G1 F5312.198
G1 X131.732 Y128.276 E.00672
G1 X131.733 Y127.656 E.02216
; LINE_WIDTH: 0.482555
G1 F5459.075
G1 X131.8 Y127.409 E.00888
; LINE_WIDTH: 0.42032
G1 F6359.307
G3 X132.06 Y126.623 I5.041 J1.23 E.02469
G1 X132.387 Y126.072 E.01911
G3 X133.514 Y125.112 I2.879 J2.238 E.04444
G1 X134.066 Y124.893 E.01771
G1 X134.526 Y124.792 E.01402
G1 X135.228 Y124.764 E.02097
G1 X135.611 Y124.814 E.01151
G1 X135.216 Y123.996 E.02708
G2 X131.188 Y120.391 I-7.341 J4.149 E.16405
G1 X131.245 Y120.909 E.01555
G1 X131.204 Y121.547 E.01906
G3 X130.202 Y123.39 I-3.197 J-.545 E.06368
G1 X129.679 Y123.777 E.0194
G1 X129.051 Y124.075 E.02072
; LINE_WIDTH: 0.439633
G1 F6049.722
G1 X128.761 Y124.165 E.00951
; LINE_WIDTH: 0.486161
G1 F5414.665
G1 X128.471 Y124.256 E.01063
G1 X127.968 Y124.281 E.01766
; LINE_WIDTH: 0.466858
G1 F5661.212
G1 X127.717 Y124.23 E.00857
; LINE_WIDTH: 0.421419
G1 F6340.838
G1 X126.957 Y124.076 E.02318
G1 X126.496 Y123.879 E.01499
G1 X125.938 Y123.503 E.02011
G1 X125.463 Y123.027 E.02012
G1 X125.156 Y122.569 E.01648
G1 X124.921 Y122.03 E.01758
G1 X124.795 Y121.477 E.01697
G1 X124.767 Y120.776 E.02096
G1 X124.816 Y120.393 E.01156
G2 X123.434 Y121.138 I2.763 J6.771 E.04702
G2 X120.395 Y124.813 I4.656 J6.945 E.14459
G1 X121.03 Y124.753 E.01906
G3 X123.945 Y126.624 I-.026 J3.246 E.10924
G1 X124.224 Y127.427 E.02544
; LINE_WIDTH: 0.495752
G1 F5299.987
G1 X124.269 Y127.572 E.00541
G1 X124.281 Y128.015 E.01583
M204 S10000
G1 X124.502 Y127.065 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X124.71 Y126.483 E.01842
G3 X127.079 Y124.499 I3.28 J1.51 E.0951
G1 X126.485 Y124.292 E.01873
G3 X124.464 Y121.789 I1.518 J-3.292 E.09928
G3 X124.398 Y121.003 I7.587 J-1.028 E.02351
G2 X122.706 Y122.175 I4.328 J8.055 E.06145
G2 X121.13 Y124.164 I5.438 J5.928 E.07591
G1 X121.04 Y124.375 E.00682
G3 X124.485 Y127.008 I-.067 J3.658 E.13823
M204 S10000
G1 X124.502 Y126.064 F42000
; LINE_WIDTH: 0.41999
G1 F6364.873
M204 S6000
G3 X126.063 Y124.498 I3.474 J1.903 E.06673
G3 X124.061 Y121.639 I1.957 J-3.5 E.10756
G2 X121.636 Y124.048 I3.828 J6.279 E.10276
G3 X124.47 Y126.013 I-.637 J3.943 E.1062
; WIPE_START
G1 X124.199 Y125.592 E-.19011
G1 X123.794 Y125.133 E-.23287
G1 X123.324 Y124.74 E-.23271
G1 X123.089 Y124.599 E-.1043
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.898 Y124.909 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.876
M204 S6000
G1 X125.369 Y124.498 E.01861
G3 X124.234 Y123.23 I2.899 J-3.736 E.05098
G1 X123.938 Y122.629 E.01996
G1 X123.81 Y122.255 E.01177
G2 X122.253 Y123.806 I3.852 J5.422 E.06577
G3 X124.49 Y125.353 I-1.301 J4.273 E.0823
G1 X124.857 Y124.953 E.01616
M204 S10000
G1 X124.782 Y124.502 F42000
; LINE_WIDTH: 0.425781
G1 F6268.607
M204 S6000
G1 X124.327 Y124.039 E.01964
G1 X123.917 Y123.435 E.02207
G1 X123.633 Y122.87 E.01914
G2 X122.871 Y123.63 I4.153 J4.922 E.03258
G3 X124.502 Y124.78 I-1.817 J4.311 E.06082
G1 X124.739 Y124.545 E.0101
; WIPE_START
G1 X124.502 Y124.78 E-.12689
G1 X124.298 Y124.567 E-.11204
G1 X123.89 Y124.209 E-.20643
G1 X123.437 Y123.915 E-.20504
G1 X123.179 Y123.785 E-.1096
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.534 Y123.464 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.43876
G1 F6063.056
M204 S6000
G1 X123.46 Y123.507 E.00268
G1 X123.525 Y123.545 E.00235
; WIPE_START
G1 X123.46 Y123.507 E-.35515
G1 X123.534 Y123.464 E-.40485
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.095 Y125.86 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.875
M204 S6000
G1 X126.592 Y125.498 E.01833
G1 X127.072 Y125.283 E.01567
G1 X127.498 Y125.172 E.0131
G1 X128.07 Y125.134 E.01706
G1 X128.721 Y125.219 E.01958
G1 X129.216 Y125.397 E.01567
G1 X129.736 Y125.717 E.01816
G1 X129.965 Y125.906 E.00886
G1 X130.311 Y126.305 E.01574
G1 X130.636 Y126.861 E.01917
G1 X130.808 Y127.388 E.01652
G3 X130.75 Y128.809 I-3.075 J.585 E.04274
G1 X130.505 Y129.404 E.01917
G3 X129.736 Y130.283 I-2.727 J-1.611 E.035
G1 X129.217 Y130.603 E.01816
G1 X128.721 Y130.781 E.01567
G1 X128.289 Y130.858 E.01309
G1 X127.723 Y130.854 E.01684
G1 X127.206 Y130.754 E.0157
G1 X126.668 Y130.544 E.01718
G1 X126.227 Y130.258 E.01567
G3 X126.054 Y125.904 I1.785 J-2.251 E.14731
M204 S10000
G1 X126.346 Y126.141 F42000
; LINE_WIDTH: 0.419989
G1 F6364.882
M204 S6000
G1 X126.797 Y125.814 E.01661
G3 X128.055 Y125.51 I1.228 J2.328 E.03894
G1 X128.65 Y125.589 E.01786
G1 X129.172 Y125.802 E.01681
G1 X129.652 Y126.127 E.01726
G1 X130.027 Y126.552 E.01688
G1 X130.307 Y127.045 E.01688
G1 X130.448 Y127.525 E.01489
G1 X130.492 Y128.092 E.01694
G1 X130.381 Y128.733 E.01938
G1 X130.159 Y129.254 E.01689
G1 X129.73 Y129.795 E.02054
G1 X129.347 Y130.103 E.01466
G1 X128.812 Y130.354 E.0176
G1 X128.303 Y130.478 E.01562
G1 X127.766 Y130.479 E.01598
G1 X127.172 Y130.354 E.01809
G1 X126.633 Y130.079 E.01802
G1 X126.214 Y129.741 E.01604
G3 X126.305 Y126.186 I1.779 J-1.733 E.11808
; WIPE_START
G1 X125.969 Y126.552 E-.189
G1 X125.772 Y126.879 E-.14514
G1 X125.627 Y127.233 E-.14532
G1 X125.538 Y127.605 E-.14515
G1 X125.508 Y127.96 E-.13539
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.934 Y123.84 Z1 F42000
G1 X132.519 Y123.465 Z1
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.43812
G1 F6072.875
M204 S6000
G1 X132.445 Y123.508 E.00267
G1 X132.51 Y123.545 E.00234
; WIPE_START
G1 X132.445 Y123.508 E-.35489
G1 X132.519 Y123.465 E-.40511
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.493 Y124.788 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.425784
G1 F6268.545
M204 S6000
G1 X131.963 Y124.324 E.01998
G1 X132.567 Y123.915 E.02206
G1 X133.133 Y123.63 E.01917
G2 X132.373 Y122.867 I-5.471 J4.691 E.0326
G3 X131.223 Y124.5 I-4.312 J-1.817 E.06086
G1 X131.452 Y124.745 E.01014
M204 S10000
G1 X131.45 Y125.316 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X131.498 Y125.376 E.00229
G1 X131.864 Y124.942 E.01694
G1 X132.347 Y124.514 E.0192
G1 X132.772 Y124.232 E.01519
G1 X133.374 Y123.935 E.01997
G1 X133.754 Y123.806 E.01198
G2 X132.196 Y122.25 I-5.753 J4.203 E.06585
G1 X131.922 Y122.951 E.02242
G1 X131.579 Y123.526 E.01996
G1 X131.151 Y124.043 E.01996
G1 X130.649 Y124.488 E.01998
G3 X131.411 Y125.271 I-3.375 J4.043 E.03259
M204 S10000
G1 X131.494 Y126.077 F42000
G1 F6364.866
M204 S6000
G3 X134.372 Y124.052 I3.535 J1.965 E.10845
G2 X131.954 Y121.634 I-6.32 J3.903 E.10277
G3 X129.937 Y124.501 I-3.949 J-.635 E.10809
G3 X131.462 Y126.027 I-1.861 J3.385 E.06512
M204 S10000
G1 X131.183 Y126.294 F42000
G1 F6364.866
M204 S6000
G1 X131.422 Y126.804 E.01679
G1 X131.503 Y127.061 E.00803
G1 X131.71 Y126.482 E.01831
G1 X131.953 Y126.043 E.01498
G1 X132.321 Y125.56 E.01807
G3 X134.213 Y124.462 I2.681 J2.441 E.06619
G3 X134.999 Y124.396 I.9 J6.059 E.0235
G2 X131.648 Y121.025 I-7.015 J3.621 E.14381
G3 X130.588 Y123.541 I-3.921 J-.17 E.08307
G3 X128.944 Y124.498 I-2.57 J-2.523 E.05736
G1 X129.508 Y124.7 E.01785
G3 X130.881 Y125.811 I-1.633 J3.422 E.05308
G1 X131.151 Y126.243 E.01519
; WIPE_START
G1 X130.881 Y125.811 E-.19375
G1 X130.413 Y125.29 E-.26597
G1 X129.983 Y124.961 E-.20585
G1 X129.765 Y124.841 E-.09444
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.163 Y128.676 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.42154
G1 F6338.816
M204 S6000
G3 X130.462 Y130.122 I-3.071 J-.595 E.04861
G1 X129.964 Y130.583 E.0203
G3 X128.58 Y131.204 I-2.27 J-3.206 E.04568
; LINE_WIDTH: 0.458035
G1 F5781.531
G1 X128.442 Y131.24 E.00466
; LINE_WIDTH: 0.491268
G1 F5352.989
G1 X128.305 Y131.276 E.00503
G1 X127.801 Y131.282 E.01783
G1 X127.41 Y131.218 E.01404
; LINE_WIDTH: 0.423492
G1 F6306.307
G3 X126.036 Y130.588 I1.04 J-4.088 E.0457
G1 X125.612 Y130.2 E.01727
G3 X125.06 Y129.376 I2.39 J-2.2 E.02994
; LINE_WIDTH: 0.432785
G1 F6155.978
G1 X124.919 Y128.975 E.01311
; LINE_WIDTH: 0.458375
G1 F5776.799
G1 X124.779 Y128.573 E.01397
; LINE_WIDTH: 0.496898
G1 F5286.608
G1 X124.736 Y128.428 E.00542
G3 X124.736 Y127.572 I6.56 J-.428 E.03071
; LINE_WIDTH: 0.488578
G1 F5385.302
G1 X124.81 Y127.33 E.0089
; LINE_WIDTH: 0.421481
G1 F6339.807
G3 X125.387 Y126.072 I4.131 J1.134 E.04158
G1 X125.844 Y125.578 E.02012
G1 X126.387 Y125.181 E.02012
G1 X126.929 Y124.932 E.01782
G1 X127.455 Y124.798 E.01624
; LINE_WIDTH: 0.435613
G1 F6111.652
G1 X127.703 Y124.759 E.00779
; LINE_WIDTH: 0.482638
G1 F5458.054
G1 X127.951 Y124.721 E.00873
G1 X128.454 Y124.743 E.01747
; LINE_WIDTH: 0.478918
G1 F5504.619
G1 X128.761 Y124.84 E.01107
; LINE_WIDTH: 0.42179
G1 F6334.639
G3 X130.596 Y126.058 I-.886 J3.327 E.06711
G1 X130.965 Y126.676 E.02155
G1 X131.148 Y127.19 E.01631
; LINE_WIDTH: 0.440845
G1 F6031.287
G1 X131.212 Y127.431 E.00786
; LINE_WIDTH: 0.491744
G1 F5347.318
G1 X131.276 Y127.673 E.00886
G1 X131.281 Y128.177 E.01785
; LINE_WIDTH: 0.471898
G1 F5594.699
G1 X131.229 Y128.397 E.00768
; LINE_WIDTH: 0.437293
G1 F6085.617
G1 X131.176 Y128.618 E.00706
M204 S10000
G1 X131.326 Y129.406 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X131.066 Y129.939 E.01765
G3 X128.944 Y131.502 I-3.164 J-2.073 E.08018
G1 X129.52 Y131.708 E.01822
G3 X131.62 Y134.76 I-1.581 J3.336 E.11561
G1 X131.648 Y134.975 E.00646
G2 X134.977 Y131.645 I-3.664 J-6.993 E.14242
G3 X132.461 Y130.586 I.168 J-3.916 E.08306
G3 X131.614 Y129.229 I2.341 J-2.404 E.0481
G1 X131.505 Y128.884 E.01079
G1 X131.345 Y129.349 E.01465
; WIPE_START
G1 X131.505 Y128.884 E-.18689
G1 X131.614 Y129.229 E-.13761
G1 X131.8 Y129.699 E-.19172
G1 X132.107 Y130.18 E-.21695
G1 X132.153 Y130.233 E-.02683
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.937 Y131.499 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.873
M204 S6000
G3 X131.954 Y134.366 I-1.991 J3.544 E.10796
G2 X134.368 Y131.952 I-3.936 J-6.351 E.10259
G1 X133.866 Y131.834 E.01536
G1 X133.206 Y131.576 E.02112
G3 X131.501 Y129.935 I1.789 J-3.564 E.07156
G3 X129.987 Y131.466 I-3.419 J-1.865 E.065
M204 S10000
G1 X130.65 Y131.483 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X130.63 Y131.498 E.00073
G3 X131.771 Y132.77 I-2.868 J3.717 E.05117
G3 X132.196 Y133.75 I-3.902 J2.277 E.0319
G2 X133.754 Y132.194 I-4.211 J-5.776 E.06585
G1 X133.051 Y131.92 E.02248
G1 X132.476 Y131.576 E.01997
G1 X131.96 Y131.149 E.01996
G1 X131.525 Y130.66 E.01949
G1 X131.488 Y130.648 E.00113
G3 X130.695 Y131.444 I-3.344 J-2.542 E.03355
M204 S10000
G1 X131.501 Y131.22 F42000
; LINE_WIDTH: 0.426668
G1 F6254.107
M204 S6000
G1 X131.225 Y131.5 E.01194
G1 X131.678 Y131.961 E.01959
G1 X132.087 Y132.565 E.02212
G1 X132.373 Y133.133 E.01926
G2 X133.133 Y132.37 I-4.71 J-5.453 E.03267
G3 X132.112 Y131.795 I2.352 J-5.37 E.03558
G3 X131.543 Y131.263 I3.192 J-3.986 E.02364
; WIPE_START
G1 X131.706 Y131.433 E-.08971
G1 X132.112 Y131.795 E-.20656
G1 X132.567 Y132.085 E-.20517
G1 X133.133 Y132.37 E-.24066
G1 X133.101 Y132.404 E-.0179
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.519 Y132.449 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.43814
G1 F6072.568
M204 S6000
G1 X132.445 Y132.492 E.00267
G1 X132.51 Y132.53 E.00234
; WIPE_START
G1 X132.445 Y132.492 E-.35487
G1 X132.519 Y132.449 E-.40513
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.781 Y129.506 Z1 F42000
G1 Z.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970972
G1 F15000
M204 S6000
G1 X136.805 Y129.484 E.00014
; LINE_WIDTH: 0.122861
G1 X136.918 Y129.367 E.00102
; LINE_WIDTH: 0.172378
G1 X137.03 Y129.251 E.00166
; LINE_WIDTH: 0.188896
G1 X137.042 Y129.219 E.00039
; LINE_WIDTH: 0.158083
G1 X137.083 Y129.084 E.00129
; LINE_WIDTH: 0.116752
G1 X137.121 Y128.958 E.00076
; WIPE_START
G1 X137.083 Y129.084 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.12 Y127.041 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.116755
G1 F15000
M204 S6000
G1 X137.083 Y126.916 E.00076
; LINE_WIDTH: 0.158058
G1 X137.042 Y126.781 E.00128
; LINE_WIDTH: 0.188876
G1 X137.03 Y126.749 E.00039
; LINE_WIDTH: 0.172371
G1 X136.918 Y126.633 E.00166
; LINE_WIDTH: 0.122851
G1 X136.805 Y126.516 E.00102
; LINE_WIDTH: 0.0970898
G1 X136.781 Y126.494 E.00014
; WIPE_START
G1 X136.805 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.317 Y132.689 Z1 F42000
G1 X129.091 Y137.126 Z1
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.353137
G1 F7736.518
M204 S6000
G1 X129.793 Y136.794 E.01903
M204 S10000
G1 X129.818 Y136.832 F42000
; LINE_WIDTH: 0.17754
G1 F15000
M204 S6000
G1 X129.211 Y137.043 E.00683
; LINE_WIDTH: 0.155815
G1 X129.082 Y137.083 E.0012
; LINE_WIDTH: 0.116551
G1 X128.953 Y137.122 E.00078
; WIPE_START
G1 X129.082 Y137.083 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.042 Y137.117 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.117491
G1 F15000
M204 S6000
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
; OBJECT_ID: 114
; WIPE_START
G1 X126.518 Y136.803 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S10000
G1 X119.577 Y133.628 Z1 F42000
G1 X105.146 Y127.026 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X105.295 Y126.796 E.00881
G3 X106.766 Y125.916 I1.719 J1.206 E.05679
G3 X108.406 Y126.429 I.236 J2.124 E.05688
G3 X105.126 Y127.082 I-1.392 J1.572 E.29991
M204 S250
G1 X105.483 Y127.226 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X105.611 Y127.018 E.00728
G3 X106.811 Y126.306 I1.396 J.985 E.04284
G3 X107.822 Y126.502 I.196 J1.694 E.03114
G3 X105.458 Y127.281 I-.815 J1.501 E.23663
; WIPE_START
M204 S6000
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
M204 S10000
G1 X107.605 Y133.909 Z1 F42000
G1 X107.82 Y136.938 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X107.794 Y136.952 E.00096
G3 X106.903 Y132.904 I-.779 J-1.951 E.23426
G3 X108.217 Y133.279 I.095 J2.155 E.0447
G3 X108.083 Y136.81 I-1.202 J1.722 E.135
G1 X107.874 Y136.912 E.00747
M204 S250
G1 X107.646 Y136.587 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X106.933 Y133.295 I-.631 J-1.586 E.17662
G3 X107.766 Y133.467 I.09 J1.663 E.0256
G3 X107.702 Y136.564 I-.751 J1.534 E.11557
; WIPE_START
M204 S6000
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
M204 S10000
G1 X111.284 Y130.894 Z1 F42000
G1 X115.61 Y126.641 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X115.631 Y126.66 E.00093
G3 X113.823 Y125.91 I-1.617 J1.341 E.35889
G3 X115.15 Y126.234 I.177 J2.15 E.0447
G3 X115.407 Y126.429 I-1.135 J1.767 E.01037
G1 X115.568 Y126.597 E.00751
M204 S250
G1 X115.329 Y126.91 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X113.868 Y126.299 I-1.314 J1.091 E.2706
G3 X114.706 Y126.439 I.154 J1.658 E.0256
G3 X115.29 Y126.864 I-.692 J1.562 E.02166
; WIPE_START
M204 S6000
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
M204 S10000
G1 X110.914 Y122.669 Z1 F42000
G1 X108.557 Y119.581 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X108.578 Y119.6 E.00091
G3 X104.916 Y121.184 I-1.569 J1.397 E.25538
G3 X106.846 Y118.902 I2.098 J-.182 E.1068
G3 X108.346 Y119.376 I.163 J2.095 E.05185
G1 X108.514 Y119.539 E.00753
M204 S250
G1 X108.284 Y119.862 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X106.876 Y119.294 I-1.277 J1.137 E.27308
G3 X107.576 Y119.391 I.102 J1.844 E.02119
G1 X107.646 Y119.413 E.00219
G3 X108.243 Y119.818 I-.639 J1.585 E.02164
; WIPE_START
M204 S6000
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
M204 S10000
G1 X103.348 Y127.24 Z1 F42000
G1 X101.993 Y128.684 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X101.896 Y128.935 E.00868
G3 X99.055 Y126.13 I-1.881 J-.937 E.25511
G3 X99.765 Y125.91 I1.027 J2.061 E.02402
G3 X100.407 Y125.935 I.241 J2.089 E.02073
G3 X102.019 Y128.63 I-.392 J2.064 E.11404
M204 S250
G1 X101.629 Y128.537 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X101.536 Y128.757 E.00712
G3 X99.811 Y126.301 I-1.53 J-.76 E.21044
G1 X100.072 Y126.291 E.0078
G3 X101.645 Y128.479 I-.066 J1.707 E.09252
; WIPE_START
M204 S6000
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
M204 S10000
G1 X103.889 Y123.007 Z1 F42000
G1 X106.305 Y118.63 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X106.998 Y118.605 I.681 J9.295 E.0223
G3 X104.103 Y119.062 I-.001 J9.396 E1.80374
G3 X106.245 Y118.635 I2.882 J8.863 E.0704
M204 S250
G1 X106.276 Y118.237 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X107.004 Y118.213 E.02167
G3 X116.221 Y131.298 I.001 J9.788 E.55817
G3 X106.219 Y118.245 I-9.214 J-3.299 E1.24993
M204 S10000
G1 X106.047 Y118.883 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.117475
G1 F15000
M204 S6000
G1 X105.922 Y118.919 E.00077
; LINE_WIDTH: 0.161186
G1 X105.782 Y118.96 E.00136
; LINE_WIDTH: 0.192069
M73 P52 R7
G1 X105.758 Y118.97 E.00031
; LINE_WIDTH: 0.172929
G1 X105.64 Y119.083 E.00168
; LINE_WIDTH: 0.123021
G1 X105.522 Y119.197 E.00103
; LINE_WIDTH: 0.0970886
G1 X105.501 Y119.221 E.00014
; WIPE_START
G1 X105.522 Y119.197 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.958 Y118.878 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.116551
G1 F15000
M204 S6000
G1 X108.087 Y118.917 E.00078
; LINE_WIDTH: 0.155828
G1 X108.216 Y118.957 E.0012
; LINE_WIDTH: 0.177582
G1 X108.822 Y119.168 E.00683
M204 S10000
G1 X108.797 Y119.206 F42000
; LINE_WIDTH: 0.353126
G1 F7736.802
M204 S6000
G1 X108.095 Y118.874 E.01903
; WIPE_START
G1 X108.797 Y119.206 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.08 Y124.715 Z1 F42000
G1 X115.786 Y126.494 Z1
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.0970898
G1 F15000
M204 S6000
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
M204 S10000
G1 X116.125 Y128.958 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.116752
G1 F15000
M204 S6000
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
M204 S10000
G1 X110.526 Y134.992 Z1 F42000
G1 X108.797 Y136.794 Z1
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.353137
G1 F7736.518
M204 S6000
G1 X108.095 Y137.126 E.01903
M204 S10000
G1 X108.087 Y137.083 F42000
; LINE_WIDTH: 0.116551
G1 F15000
M204 S6000
G1 X107.958 Y137.122 E.00078
M204 S10000
G1 X108.087 Y137.083 F42000
; LINE_WIDTH: 0.155815
G1 F15000
M204 S6000
G1 X108.216 Y137.043 E.0012
; LINE_WIDTH: 0.17754
G1 X108.822 Y136.832 E.00683
; WIPE_START
G1 X108.216 Y137.043 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.047 Y137.117 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.117491
G1 F15000
M204 S6000
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
M204 S10000
G1 X102.538 Y132.45 Z1 F42000
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.43858
G1 F6065.814
M204 S6000
G1 X102.464 Y132.493 E.00268
G1 X102.529 Y132.531 E.00235
; WIPE_START
G1 X102.464 Y132.493 E-.35507
G1 X102.538 Y132.45 E-.40493
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.598 Y130.703 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G3 X103.507 Y128.935 I2.567 J-2.804 E.06269
G1 X103.299 Y129.517 E.01842
G3 X100.246 Y131.617 I-3.336 J-1.581 E.11562
G1 X100.03 Y131.648 E.00651
G2 X103.36 Y134.976 I7.012 J-3.688 E.14237
G1 X103.428 Y134.426 E.0165
G3 X103.831 Y133.246 I6.629 J1.605 E.03721
G3 X106.075 Y131.499 I3.16 J1.745 E.08706
G1 X105.497 Y131.292 E.01829
G3 X104.645 Y130.74 I1.414 J-3.117 E.03035
; WIPE_START
G1 X105.023 Y131.029 E-.18067
G1 X105.497 Y131.292 E-.20619
G1 X106.075 Y131.499 E-.23334
G1 X105.817 Y131.575 E-.10229
G1 X105.727 Y131.615 E-.03751
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.786 Y131.498 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.426676
G1 F6253.983
M204 S6000
G1 X103.507 Y131.22 E.01194
G1 X103.046 Y131.676 E.01965
G1 X102.442 Y132.085 E.02212
G3 X101.875 Y132.37 I-3.022 J-5.292 E.01922
G2 X102.647 Y133.138 I4.922 J-4.169 E.03304
G3 X103.743 Y131.539 I4.018 J1.58 E.05928
M204 S10000
G1 X103.507 Y130.63 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G3 X102.237 Y131.768 I-3.77 J-2.928 E.05108
G1 X101.635 Y132.065 E.01996
G1 X101.258 Y132.194 E.01189
G2 X102.825 Y133.759 I5.572 J-4.012 E.06628
G3 X103.858 Y131.957 I4.096 J1.151 E.06248
G1 X104.36 Y131.512 E.01998
G3 X103.545 Y130.676 I3.685 J-4.407 E.03483
M204 S10000
G1 X103.507 Y129.936 F42000
G1 F6364.866
M204 S6000
G3 X100.641 Y131.952 I-3.545 J-1.994 E.1079
G2 X103.053 Y134.366 I6.367 J-3.951 E.10254
G3 X103.504 Y133.059 I6.928 J1.658 E.04124
G3 X105.067 Y131.502 I3.476 J1.927 E.0666
G3 X103.539 Y129.987 I1.863 J-3.408 E.06494
; WIPE_START
G1 X103.81 Y130.407 E-.19007
G1 X104.164 Y130.82 E-.2067
G1 X104.586 Y131.19 E-.21329
G1 X104.917 Y131.405 E-.14994
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.503 Y128.014 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.867
M204 S6000
G3 X101.026 Y130.272 I-2.516 J-.035 E.0848
G1 X100.535 Y130.437 E.01541
G3 X99.318 Y130.398 I-.525 J-2.624 E.03659
G1 X98.678 Y130.112 E.02088
G1 X98.406 Y129.896 E.01034
G1 X98.316 Y129.988 E.00385
G1 X98.23 Y130.002 E.0026
G2 X105.025 Y136.781 I8.788 J-2.014 E.30148
G1 X105.051 Y136.655 E.00381
G1 X105.111 Y136.601 E.00243
G3 X104.719 Y135.994 I1.344 J-1.3 E.02166
G1 X104.532 Y135.319 E.02088
G3 X104.564 Y134.494 I2.364 J-.321 E.0247
G1 X104.8 Y133.837 E.02079
G1 X105.03 Y133.475 E.01278
G1 X105.423 Y133.079 E.0166
G1 X105.886 Y132.77 E.01661
G1 X106.477 Y132.567 E.0186
G3 X107.398 Y132.535 I.65 J5.361 E.02749
G1 X107.968 Y132.703 E.0177
G1 X108.431 Y132.95 E.01562
G3 X109 Y133.498 I-1.423 J2.049 E.02364
G1 X109.319 Y134.073 E.01957
G1 X109.46 Y134.539 E.0145
G1 X109.496 Y135.062 E.01561
G1 X109.471 Y135.355 E.00877
G1 X109.332 Y135.891 E.01648
G1 X109.055 Y136.392 E.01706
G1 X109.206 Y136.729 E.011
G2 X115.783 Y129.981 I-2.183 J-8.706 E.29545
G1 X115.661 Y129.956 E.00371
G1 X115.607 Y129.896 E.0024
G1 X115.339 Y130.109 E.01022
G1 X114.699 Y130.397 E.02088
G1 X114.188 Y130.485 E.01547
G1 X113.546 Y130.453 E.01914
G3 X111.759 Y129.081 I.472 J-2.465 E.06959
G1 X111.546 Y128.413 E.02088
G1 X111.517 Y127.901 E.01529
G1 X111.606 Y127.334 E.01709
G1 X111.776 Y126.88 E.01446
G3 X113.56 Y125.546 I2.255 J1.156 E.06868
G1 X114.261 Y125.518 E.02089
G3 X115.498 Y126.014 I-.284 J2.502 E.04017
G1 X115.608 Y126.105 E.00427
G3 X115.784 Y126.001 I.16 J.07 E.00651
G2 X109.206 Y119.271 I-8.778 J2.001 E.29495
G1 X109.067 Y119.596 E.01053
G1 X109.376 Y120.246 E.02142
G1 X109.488 Y120.728 E.01474
G1 X109.488 Y121.218 E.0146
G1 X109.361 Y121.83 E.01861
G3 X108.595 Y122.917 I-2.457 J-.917 E.04004
G1 X108.127 Y123.23 E.01677
G1 X107.612 Y123.415 E.01629
G1 X107.021 Y123.496 E.01777
G1 X106.392 Y123.405 E.01892
G1 X105.912 Y123.243 E.0151
G1 X105.423 Y122.921 E.01745
G1 X105.031 Y122.525 E.0166
G1 X104.776 Y122.11 E.0145
G1 X104.576 Y121.552 E.01765
G1 X104.525 Y120.747 E.02404
G3 X105.019 Y119.51 I2.502 J.284 E.04014
G1 X105.111 Y119.399 E.0043
G3 X105.007 Y119.223 I.07 J-.16 E.00649
G2 X102.045 Y120.495 I1.968 J8.67 E.09656
G2 X98.235 Y126.02 I4.903 J7.458 E.20494
G3 X98.406 Y126.104 I.028 J.158 E.00609
G1 X98.675 Y125.891 E.01023
G1 X99.314 Y125.603 E.02088
G1 X99.735 Y125.519 E.01278
G1 X100.338 Y125.532 E.01799
G1 X100.837 Y125.646 E.01523
G3 X102.498 Y127.955 I-.828 J2.348 E.09017
M204 S10000
G1 X102.879 Y128.043 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G3 X101.713 Y130.31 I-2.872 J-.043 E.07866
G1 X101.18 Y130.616 E.01831
G1 X100.635 Y130.8 E.01713
G1 X100.073 Y130.871 E.01687
G3 X98.769 Y130.565 I-.082 J-2.581 E.04035
G2 X104.404 Y136.214 I8.208 J-2.552 E.24713
G3 X104.149 Y135.29 I7.108 J-2.458 E.02857
G3 X104.209 Y134.367 I2.718 J-.285 E.02768
G1 X104.445 Y133.71 E.02079
G1 X104.721 Y133.258 E.01578
G1 X105.183 Y132.788 E.01962
G1 X105.694 Y132.445 E.01832
G1 X106.181 Y132.249 E.01567
G1 X106.654 Y132.153 E.01435
G1 X107.355 Y132.153 E.02088
G1 X107.859 Y132.256 E.01533
G1 X108.32 Y132.446 E.01485
G1 X108.835 Y132.792 E.01848
G1 X109.264 Y133.225 E.01816
G3 X109.834 Y134.496 I-2.56 J1.911 E.04183
G1 X109.873 Y135.076 E.01733
G1 X109.836 Y135.45 E.01119
G1 X109.696 Y135.985 E.01648
G1 X109.578 Y136.233 E.00816
G2 X115.24 Y130.567 I-2.562 J-8.222 E.24814
G1 X114.73 Y130.78 E.01648
G3 X112.597 Y130.502 I-.707 J-2.901 E.06554
G3 X111.399 Y129.196 I1.395 J-2.48 E.05369
G1 X111.187 Y128.528 E.02088
G1 X111.133 Y128 E.01579
G1 X111.193 Y127.441 E.01675
G3 X113.545 Y125.169 I2.818 J.564 E.1036
G1 X114.247 Y125.141 E.02092
G1 X114.81 Y125.242 E.01703
G1 X115.223 Y125.393 E.01311
G2 X109.573 Y119.766 I-8.196 J2.579 E.24699
G1 X109.787 Y120.277 E.0165
G1 X109.873 Y120.924 E.01944
G1 X109.834 Y121.504 E.01732
G1 X109.695 Y122.012 E.01567
G3 X108.835 Y123.208 I-2.841 J-1.134 E.04432
G1 X108.32 Y123.554 E.01849
G1 X107.832 Y123.751 E.01567
G1 X107.269 Y123.855 E.01706
G1 X106.877 Y123.86 E.01166
G1 X106.228 Y123.761 E.01955
G1 X105.724 Y123.571 E.01606
G1 X105.183 Y123.212 E.01934
G1 X104.749 Y122.776 E.01832
G1 X104.463 Y122.334 E.01568
G3 X104.176 Y121.462 I2.415 J-1.279 E.02748
G1 X104.148 Y120.761 E.02088
G1 X104.249 Y120.197 E.01707
G1 X104.397 Y119.778 E.01326
G2 X102.925 Y120.399 I2.924 J8.987 E.04766
G2 X100.509 Y122.323 I4.237 J7.796 E.09247
G2 X98.769 Y125.435 I6.644 J5.757 E.10692
G1 X99.284 Y125.22 E.0166
G1 X99.72 Y125.142 E.01321
G1 X100.382 Y125.157 E.01971
G1 X100.937 Y125.283 E.01695
G1 X101.417 Y125.498 E.01566
G3 X102.875 Y127.983 I-1.453 J2.523 E.0898
M204 S10000
G1 X103.287 Y128.075 F42000
; LINE_WIDTH: 0.49842
G1 F5268.935
M204 S6000
G1 X103.273 Y128.439 E.0131
; LINE_WIDTH: 0.48938
G1 F5375.622
G1 X103.177 Y128.744 E.01128
; LINE_WIDTH: 0.420666
G1 F6353.49
G3 X101.918 Y130.627 I-3.36 J-.884 E.06885
G1 X101.334 Y130.96 E.02006
G1 X100.735 Y131.164 E.01888
G1 X100.203 Y131.243 E.01605
G1 X99.576 Y131.221 E.01874
G1 X99.4 Y131.187 E.00534
G2 X103.831 Y135.612 I7.607 J-3.186 E.19167
G1 X103.772 Y135.305 E.00933
G1 X103.764 Y134.804 E.01495
G1 X103.853 Y134.243 E.01693
G1 X104.089 Y133.583 E.02092
G1 X104.38 Y133.088 E.01712
G3 X105.63 Y132.057 I2.823 J2.15 E.04879
G1 X106.304 Y131.828 E.02123
; LINE_WIDTH: 0.44934
G1 F5905.222
G1 X106.479 Y131.78 E.00581
; LINE_WIDTH: 0.500636
G1 F5243.428
G1 X106.653 Y131.733 E.00654
G1 X107.318 Y131.735 E.02405
; LINE_WIDTH: 0.481498
G1 F5472.237
G1 X107.618 Y131.808 E.01069
; LINE_WIDTH: 0.420372
G1 F6358.438
G3 X110.209 Y134.452 I-.628 J3.207 E.11735
G1 X110.25 Y135.091 E.01906
G1 X110.183 Y135.613 E.01571
G2 X114.616 Y131.186 I-3.189 J-7.626 E.19158
G1 X113.955 Y131.248 E.0198
G1 X113.408 Y131.195 E.01636
G1 X112.85 Y131.036 E.01731
G3 X111.04 Y129.31 I1.227 J-3.098 E.07645
G1 X110.828 Y128.642 E.0209
; LINE_WIDTH: 0.439123
G1 F6057.508
G1 X110.782 Y128.459 E.00589
; LINE_WIDTH: 0.494711
G1 F5312.198
G1 X110.736 Y128.276 E.00672
G1 X110.738 Y127.656 E.02216
; LINE_WIDTH: 0.482555
G1 F5459.075
G1 X110.805 Y127.409 E.00888
; LINE_WIDTH: 0.42032
G1 F6359.307
G3 X111.064 Y126.623 I5.041 J1.23 E.02469
G1 X111.392 Y126.072 E.01911
G3 X112.519 Y125.112 I2.879 J2.238 E.04444
G1 X113.071 Y124.893 E.01771
G1 X113.53 Y124.792 E.01402
G1 X114.233 Y124.764 E.02097
G1 X114.616 Y124.814 E.01151
G1 X114.221 Y123.996 E.02708
G2 X110.193 Y120.391 I-7.341 J4.149 E.16405
G1 X110.25 Y120.909 E.01555
G1 X110.209 Y121.547 E.01906
G3 X109.207 Y123.39 I-3.197 J-.545 E.06368
G1 X108.684 Y123.777 E.0194
G1 X108.055 Y124.075 E.02072
; LINE_WIDTH: 0.439633
G1 F6049.722
G1 X107.766 Y124.165 E.00951
; LINE_WIDTH: 0.486161
G1 F5414.665
G1 X107.476 Y124.256 E.01063
G1 X106.972 Y124.281 E.01766
; LINE_WIDTH: 0.466858
G1 F5661.212
G1 X106.721 Y124.23 E.00857
; LINE_WIDTH: 0.421419
G1 F6340.838
G1 X105.962 Y124.076 E.02318
G1 X105.501 Y123.879 E.01499
G1 X104.943 Y123.503 E.02011
G1 X104.468 Y123.027 E.02012
G1 X104.16 Y122.569 E.01648
G1 X103.926 Y122.03 E.01758
G1 X103.799 Y121.477 E.01697
G1 X103.771 Y120.776 E.02096
G1 X103.82 Y120.393 E.01156
G2 X102.439 Y121.138 I2.763 J6.771 E.04702
G2 X99.4 Y124.813 I4.656 J6.945 E.14459
G1 X100.034 Y124.753 E.01906
G3 X102.949 Y126.624 I-.026 J3.246 E.10924
G1 X103.229 Y127.427 E.02544
; LINE_WIDTH: 0.495752
G1 F5299.987
G1 X103.273 Y127.572 E.00541
G1 X103.285 Y128.015 E.01583
M204 S10000
G1 X103.507 Y127.065 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X103.714 Y126.483 E.01842
G3 X106.083 Y124.499 I3.28 J1.51 E.0951
G1 X105.489 Y124.292 E.01873
G3 X103.468 Y121.789 I1.518 J-3.292 E.09928
G3 X103.403 Y121.003 I7.587 J-1.028 E.02351
G2 X101.711 Y122.175 I4.328 J8.055 E.06145
G2 X100.134 Y124.164 I5.438 J5.928 E.07591
G1 X100.044 Y124.375 E.00682
G3 X103.49 Y127.008 I-.067 J3.658 E.13823
M204 S10000
G1 X103.507 Y126.064 F42000
; LINE_WIDTH: 0.41999
G1 F6364.873
M204 S6000
G3 X105.067 Y124.498 I3.474 J1.903 E.06673
G3 X103.066 Y121.639 I1.957 J-3.5 E.10756
G2 X100.641 Y124.048 I3.828 J6.279 E.10276
G3 X103.474 Y126.013 I-.637 J3.943 E.1062
; WIPE_START
G1 X103.203 Y125.592 E-.19011
G1 X102.798 Y125.133 E-.23287
G1 X102.328 Y124.74 E-.23271
G1 X102.093 Y124.599 E-.1043
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.902 Y124.909 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.876
M204 S6000
G1 X104.373 Y124.498 E.01861
G3 X103.238 Y123.23 I2.899 J-3.736 E.05098
G1 X102.942 Y122.629 E.01996
G1 X102.814 Y122.255 E.01177
G2 X101.258 Y123.806 I3.852 J5.422 E.06577
G3 X103.494 Y125.353 I-1.301 J4.273 E.0823
G1 X103.861 Y124.953 E.01616
M204 S10000
G1 X103.786 Y124.502 F42000
; LINE_WIDTH: 0.425781
G1 F6268.607
M204 S6000
G1 X103.331 Y124.039 E.01964
G1 X102.922 Y123.435 E.02207
G1 X102.637 Y122.87 E.01914
G2 X101.875 Y123.63 I4.153 J4.922 E.03258
G3 X103.507 Y124.78 I-1.817 J4.311 E.06082
G1 X103.744 Y124.545 E.0101
; WIPE_START
G1 X103.507 Y124.78 E-.12689
G1 X103.302 Y124.567 E-.11204
G1 X102.894 Y124.209 E-.20643
G1 X102.441 Y123.915 E-.20504
G1 X102.184 Y123.785 E-.1096
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.538 Y123.464 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.43876
G1 F6063.056
M204 S6000
G1 X102.464 Y123.507 E.00268
G1 X102.529 Y123.545 E.00235
; WIPE_START
G1 X102.464 Y123.507 E-.35515
G1 X102.538 Y123.464 E-.40485
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.099 Y125.86 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.875
M204 S6000
G1 X105.597 Y125.498 E.01833
G1 X106.077 Y125.283 E.01567
G1 X106.502 Y125.172 E.0131
G1 X107.074 Y125.134 E.01706
G1 X107.726 Y125.219 E.01958
G1 X108.221 Y125.397 E.01567
G1 X108.74 Y125.717 E.01816
G1 X108.969 Y125.906 E.00886
G1 X109.316 Y126.305 E.01574
G1 X109.641 Y126.861 E.01917
G1 X109.813 Y127.388 E.01652
G3 X109.755 Y128.809 I-3.075 J.585 E.04274
G1 X109.51 Y129.404 E.01917
G3 X108.74 Y130.283 I-2.727 J-1.611 E.035
G1 X108.221 Y130.603 E.01816
G1 X107.726 Y130.781 E.01567
G1 X107.293 Y130.858 E.01309
G1 X106.728 Y130.854 E.01684
G1 X106.21 Y130.754 E.0157
G1 X105.673 Y130.544 E.01718
G1 X105.231 Y130.258 E.01567
G3 X105.059 Y125.904 I1.785 J-2.251 E.14731
M204 S10000
G1 X105.35 Y126.141 F42000
; LINE_WIDTH: 0.419989
G1 F6364.882
M204 S6000
G1 X105.802 Y125.814 E.01661
G3 X107.06 Y125.51 I1.228 J2.328 E.03894
G1 X107.654 Y125.589 E.01786
G1 X108.177 Y125.802 E.01681
G1 X108.657 Y126.127 E.01726
G1 X109.031 Y126.552 E.01688
G1 X109.312 Y127.045 E.01688
G1 X109.453 Y127.525 E.01489
G1 X109.496 Y128.092 E.01694
G1 X109.385 Y128.733 E.01938
G1 X109.164 Y129.254 E.01689
G1 X108.735 Y129.795 E.02054
G1 X108.351 Y130.103 E.01466
G1 X107.817 Y130.354 E.0176
G1 X107.307 Y130.478 E.01562
G1 X106.771 Y130.479 E.01598
G1 X106.177 Y130.354 E.01809
G1 X105.638 Y130.079 E.01802
G1 X105.218 Y129.741 E.01604
G3 X105.31 Y126.186 I1.779 J-1.733 E.11808
; WIPE_START
G1 X104.974 Y126.552 E-.189
G1 X104.776 Y126.879 E-.14514
G1 X104.631 Y127.233 E-.14532
G1 X104.542 Y127.605 E-.14515
G1 X104.513 Y127.96 E-.13539
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.938 Y123.84 Z1 F42000
G1 X111.524 Y123.465 Z1
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.43812
G1 F6072.875
M204 S6000
G1 X111.45 Y123.508 E.00267
G1 X111.514 Y123.545 E.00234
; WIPE_START
G1 X111.45 Y123.508 E-.35489
G1 X111.524 Y123.465 E-.40511
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.498 Y124.788 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.425784
G1 F6268.545
M204 S6000
G1 X110.968 Y124.324 E.01998
G1 X111.572 Y123.915 E.02206
G1 X112.137 Y123.63 E.01917
G2 X111.377 Y122.867 I-5.471 J4.691 E.0326
G3 X110.228 Y124.5 I-4.312 J-1.817 E.06086
G1 X110.457 Y124.745 E.01014
M204 S10000
G1 X110.455 Y125.316 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X110.502 Y125.376 E.00229
G1 X110.869 Y124.942 E.01694
G1 X111.352 Y124.514 E.0192
G1 X111.777 Y124.232 E.01519
G1 X112.378 Y123.935 E.01997
G1 X112.759 Y123.806 E.01198
G2 X111.201 Y122.25 I-5.753 J4.203 E.06585
G1 X110.927 Y122.951 E.02242
G1 X110.583 Y123.526 E.01996
G1 X110.156 Y124.043 E.01996
G1 X109.654 Y124.488 E.01998
G3 X110.415 Y125.271 I-3.375 J4.043 E.03259
M204 S10000
G1 X110.499 Y126.077 F42000
G1 F6364.866
M204 S6000
G3 X113.376 Y124.052 I3.535 J1.965 E.10845
G2 X110.958 Y121.634 I-6.32 J3.903 E.10277
G3 X108.941 Y124.501 I-3.949 J-.635 E.10809
G3 X110.466 Y126.027 I-1.861 J3.385 E.06512
M204 S10000
G1 X110.187 Y126.294 F42000
G1 F6364.866
M204 S6000
G1 X110.426 Y126.804 E.01679
G1 X110.508 Y127.061 E.00803
G1 X110.714 Y126.482 E.01831
G1 X110.958 Y126.043 E.01498
G1 X111.326 Y125.56 E.01807
G3 X113.218 Y124.462 I2.681 J2.441 E.06619
G3 X114.003 Y124.396 I.9 J6.059 E.0235
G2 X110.653 Y121.025 I-7.015 J3.621 E.14381
G3 X109.592 Y123.541 I-3.921 J-.17 E.08307
G3 X107.948 Y124.498 I-2.57 J-2.523 E.05736
G1 X108.513 Y124.7 E.01785
G3 X109.885 Y125.811 I-1.633 J3.422 E.05308
G1 X110.156 Y126.243 E.01519
; WIPE_START
G1 X109.885 Y125.811 E-.19375
G1 X109.418 Y125.29 E-.26597
G1 X108.987 Y124.961 E-.20585
G1 X108.77 Y124.841 E-.09444
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.167 Y128.676 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.42154
G1 F6338.816
M204 S6000
G3 X109.467 Y130.122 I-3.071 J-.595 E.04861
G1 X108.969 Y130.583 E.0203
G3 X107.584 Y131.204 I-2.27 J-3.206 E.04568
; LINE_WIDTH: 0.458035
G1 F5781.531
G1 X107.447 Y131.24 E.00466
; LINE_WIDTH: 0.491268
G1 F5352.989
G1 X107.309 Y131.276 E.00503
G1 X106.806 Y131.282 E.01783
G1 X106.415 Y131.218 E.01404
; LINE_WIDTH: 0.423492
G1 F6306.307
G3 X105.04 Y130.588 I1.04 J-4.088 E.0457
G1 X104.617 Y130.2 E.01727
M73 P53 R7
G3 X104.064 Y129.376 I2.39 J-2.2 E.02994
; LINE_WIDTH: 0.432785
G1 F6155.978
G1 X103.924 Y128.975 E.01311
; LINE_WIDTH: 0.458375
G1 F5776.799
G1 X103.783 Y128.573 E.01397
; LINE_WIDTH: 0.496898
G1 F5286.608
G1 X103.74 Y128.428 E.00542
G3 X103.74 Y127.572 I6.56 J-.428 E.03071
; LINE_WIDTH: 0.488578
G1 F5385.302
G1 X103.814 Y127.33 E.0089
; LINE_WIDTH: 0.421481
G1 F6339.807
G3 X104.392 Y126.072 I4.131 J1.134 E.04158
G1 X104.848 Y125.578 E.02012
G1 X105.392 Y125.181 E.02012
G1 X105.933 Y124.932 E.01782
G1 X106.459 Y124.798 E.01624
; LINE_WIDTH: 0.435613
G1 F6111.652
G1 X106.708 Y124.759 E.00779
; LINE_WIDTH: 0.482638
G1 F5458.054
G1 X106.956 Y124.721 E.00873
G1 X107.458 Y124.743 E.01747
; LINE_WIDTH: 0.478918
G1 F5504.619
G1 X107.765 Y124.84 E.01107
; LINE_WIDTH: 0.42179
G1 F6334.639
G3 X109.601 Y126.058 I-.886 J3.327 E.06711
G1 X109.97 Y126.676 E.02155
G1 X110.153 Y127.19 E.01631
; LINE_WIDTH: 0.440845
G1 F6031.287
G1 X110.217 Y127.431 E.00786
; LINE_WIDTH: 0.491744
G1 F5347.318
G1 X110.281 Y127.673 E.00886
G1 X110.285 Y128.177 E.01785
; LINE_WIDTH: 0.471898
G1 F5594.699
G1 X110.233 Y128.397 E.00768
; LINE_WIDTH: 0.437293
G1 F6085.617
G1 X110.181 Y128.618 E.00706
M204 S10000
G1 X110.331 Y129.406 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X110.07 Y129.939 E.01765
G3 X107.948 Y131.502 I-3.164 J-2.073 E.08018
G1 X108.524 Y131.708 E.01822
G3 X110.624 Y134.76 I-1.581 J3.336 E.11561
G1 X110.653 Y134.975 E.00646
G2 X113.982 Y131.645 I-3.664 J-6.993 E.14242
G3 X111.466 Y130.586 I.168 J-3.916 E.08306
G3 X110.619 Y129.229 I2.341 J-2.404 E.0481
G1 X110.509 Y128.884 E.01079
G1 X110.35 Y129.349 E.01465
; WIPE_START
G1 X110.509 Y128.884 E-.18689
G1 X110.619 Y129.229 E-.13761
G1 X110.804 Y129.699 E-.19172
G1 X111.111 Y130.18 E-.21695
G1 X111.157 Y130.233 E-.02683
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.941 Y131.499 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.873
M204 S6000
G3 X110.958 Y134.366 I-1.991 J3.544 E.10796
G2 X113.373 Y131.952 I-3.936 J-6.351 E.10259
G1 X112.871 Y131.834 E.01536
G1 X112.21 Y131.576 E.02112
G3 X110.506 Y129.935 I1.789 J-3.564 E.07156
G3 X108.992 Y131.466 I-3.419 J-1.865 E.065
M204 S10000
G1 X109.655 Y131.483 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X109.635 Y131.498 E.00073
G3 X110.775 Y132.77 I-2.868 J3.717 E.05117
G3 X111.201 Y133.75 I-3.902 J2.277 E.0319
G2 X112.759 Y132.194 I-4.211 J-5.776 E.06585
G1 X112.056 Y131.92 E.02248
G1 X111.48 Y131.576 E.01997
G1 X110.964 Y131.149 E.01996
G1 X110.529 Y130.66 E.01949
G1 X110.493 Y130.648 E.00113
G3 X109.7 Y131.444 I-3.344 J-2.542 E.03355
M204 S10000
G1 X110.506 Y131.22 F42000
; LINE_WIDTH: 0.426668
G1 F6254.107
M204 S6000
G1 X110.229 Y131.5 E.01194
G1 X110.682 Y131.961 E.01959
G1 X111.092 Y132.565 E.02212
G1 X111.377 Y133.133 E.01926
G2 X112.137 Y132.37 I-4.71 J-5.453 E.03267
G3 X111.117 Y131.795 I2.352 J-5.37 E.03558
G3 X110.547 Y131.263 I3.192 J-3.986 E.02364
; WIPE_START
G1 X110.711 Y131.433 E-.08971
G1 X111.117 Y131.795 E-.20656
G1 X111.572 Y132.085 E-.20517
G1 X112.137 Y132.37 E-.24066
G1 X112.106 Y132.404 E-.0179
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X111.524 Y132.449 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.43814
G1 F6072.568
M204 S6000
G1 X111.45 Y132.492 E.00267
G1 X111.514 Y132.53 E.00234
; WIPE_START
G1 X111.45 Y132.492 E-.35487
G1 X111.524 Y132.449 E-.40513
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.072 Y130.8 Z1 F42000
G1 X98.228 Y129.506 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0971035
G1 F15000
M204 S6000
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
M204 S10000
G1 X97.888 Y127.044 Z1 F42000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.117855
G1 F15000
M204 S6000
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
G1 F15000
G1 X98.204 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 114
M625
; layer num/total_layer_count: 4/23
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
M106 S221.85
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z1 I-.022 J1.217 P1  F42000
G1 X126.141 Y127.025 Z1
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X126.286 Y126.793 E.0088
G3 X127.716 Y125.921 I1.716 J1.208 E.05539
G3 X128.964 Y126.135 I.284 J2.089 E.04135
G3 X126.116 Y127.079 I-.962 J1.866 E.31664
M204 S250
G1 X126.478 Y127.226 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X126.611 Y127.021 E.00725
G3 X127.761 Y126.311 I1.399 J.979 E.0414
G3 X128.702 Y126.439 I.254 J1.653 E.02868
G3 X126.461 Y127.282 I-.692 J1.562 E.24063
; WIPE_START
M204 S6000
G1 X126.611 Y127.021 E-.11415
G1 X126.77 Y126.814 E-.0993
G1 X126.965 Y126.64 E-.09951
G1 X127.185 Y126.497 E-.09953
G1 X127.424 Y126.39 E-.09949
G1 X127.761 Y126.311 E-.13155
G1 X127.937 Y126.291 E-.06724
G1 X128.066 Y126.296 E-.04922
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.015 Y128.605 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X123.012 Y128.636 E.00101
G3 X120.956 Y125.903 I-2.003 J-.634 E.29589
G3 X122.518 Y126.541 I.037 J2.139 E.05577
G3 X123.085 Y128.322 I-1.509 J1.461 E.06228
G1 X123.029 Y128.546 E.00745
M204 S250
G1 X122.633 Y128.515 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X122.64 Y128.518 E.0002
G3 X120.971 Y126.294 I-1.628 J-.516 E.22297
G3 X121.819 Y126.497 I.051 J1.661 E.02628
G3 X122.699 Y128.262 I-.808 J1.505 E.06262
G1 X122.648 Y128.457 E.00601
; WIPE_START
M204 S6000
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
M204 S10000
G1 X126.102 Y123.821 Z1.2 F42000
G1 X129.59 Y119.623 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X129.767 Y119.857 E.00944
G3 X127.841 Y118.902 I-1.765 J1.14 E.35192
G3 X128.668 Y119.01 I.126 J2.248 E.02697
G1 X128.789 Y119.049 E.00407
G3 X129.551 Y119.577 I-.786 J1.948 E.03008
M204 S250
G1 X129.278 Y119.863 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X127.871 Y119.294 I-1.275 J1.131 E.27222
G3 X128.55 Y119.384 I.103 J1.831 E.0205
G1 X128.642 Y119.413 E.00288
G3 X129.238 Y119.819 I-.639 J1.581 E.02163
; WIPE_START
M204 S6000
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
M204 S10000
G1 X135.797 Y126.087 Z1.2 F42000
G1 X136.643 Y126.686 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X136.812 Y126.924 E.0094
G3 X134.796 Y125.912 I-1.803 J1.078 E.34789
G3 X136.402 Y126.429 I.2 J2.13 E.05577
G3 X136.607 Y126.638 I-1.393 J1.573 E.00941
M204 S250
G1 X136.325 Y126.909 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X134.841 Y126.302 I-1.313 J1.092 E.26998
G3 X135.702 Y126.439 I.178 J1.652 E.02628
G3 X136.286 Y126.864 I-.691 J1.562 E.02167
; WIPE_START
M204 S6000
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
M204 S10000
G1 X131.296 Y134.28 Z1.2 F42000
G1 X128.76 Y136.96 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X128.482 Y137.049 E.00941
G3 X127.876 Y132.906 I-.473 J-2.047 E.22328
G3 X129.461 Y133.484 I.14 J2.077 E.05586
G3 X128.817 Y136.942 I-1.452 J1.518 E.13401
M204 S250
G1 X128.643 Y136.589 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X127.906 Y133.297 I-.631 J-1.587 E.17598
G3 X128.761 Y133.467 I.115 J1.658 E.02628
G3 X128.698 Y136.566 I-.75 J1.535 E.11567
; WIPE_START
M204 S6000
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
M204 S10000
G1 X127.038 Y128.616 Z1.2 F42000
G1 X127.3 Y118.631 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X128.053 Y118.606 I.684 J9.328 E.02423
G3 X124.052 Y119.473 I-.059 J9.395 E1.76559
G3 X127.24 Y118.636 I3.933 J8.486 E.10657
M204 S250
G1 X127.272 Y118.237 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X128.059 Y118.214 E.02346
G3 X123.887 Y119.117 I-.066 J9.787 E1.70362
G3 X127.214 Y118.244 I4.097 J8.84 E.10299
; WIPE_START
M204 S6000
G1 X128.059 Y118.214 E-.32133
G1 X128.441 Y118.22 E-.14537
G1 X129.026 Y118.264 E-.22261
G1 X129.21 Y118.289 E-.07069
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.2 I1.217 J0 P1  F42000
; stop printing object, unique label id: 78
M625
; object ids of layer 4 start: 78,114
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


; object ids of this layer4 end: 78,114
M625
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X129.091 Y118.874 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.353186
G1 F7735.31
M204 S6000
G1 X129.793 Y119.206 E.01902
M204 S10000
G1 X129.817 Y119.169 F42000
; LINE_WIDTH: 0.177528
G1 F15000
M204 S6000
G1 X129.211 Y118.957 E.00683
; LINE_WIDTH: 0.155808
G1 X129.082 Y118.917 E.0012
; LINE_WIDTH: 0.116544
G1 X128.953 Y118.878 E.00078
; WIPE_START
G1 X129.082 Y118.917 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.042 Y118.883 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.117478
G1 F15000
M204 S6000
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
M204 S10000
G1 X120.562 Y122.852 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X121.604 Y121.604 I12.531 J9.396 E.05231
G1 X124.752 Y124.752 E.14317
G3 X125.05 Y124.207 I.494 J-.083 E.02152
G1 X125.587 Y124.195 E.01729
G1 X125.828 Y123.714 E.01728
G1 X126.086 Y123.592 E.00918
G1 X126.609 Y123.714 E.01729
G1 X126.962 Y123.308 E.01729
G1 X127.113 Y123.279 E.00495
G3 X125.967 Y122.357 I.892 J-2.282 E.04803
G1 X122.359 Y125.965 E.16407
G2 X120.815 Y125.559 I-1.492 J2.538 E.05198
; WIPE_START
G1 X121.469 Y125.592 E-.24877
G1 X121.832 Y125.691 E-.14278
G1 X122.359 Y125.965 E-.22587
G1 X122.625 Y125.699 E-.14258
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X119.223 Y126.494 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.097088
G1 F15000
M204 S6000
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
M204 S10000
G1 X118.883 Y128.956 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.117842
G1 F15000
M204 S6000
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
M204 S10000
G1 X120.815 Y130.441 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G2 X122.359 Y130.035 I.18 J-2.457 E.05227
G1 X125.967 Y133.643 E.16407
G3 X127.113 Y132.721 I2.038 J1.36 E.04803
G1 X126.962 Y132.692 E.00495
G1 X126.61 Y132.286 E.01729
G1 X126.086 Y132.408 E.01729
G1 X125.828 Y132.286 E.00918
G1 X125.587 Y131.805 E.01729
G1 X125.05 Y131.793 E.01729
G3 X124.752 Y131.248 I.196 J-.461 E.02152
G1 X121.604 Y134.396 E.14317
G2 X122.852 Y135.438 I10.579 J-11.405 E.05231
; WIPE_START
G1 X121.604 Y134.396 E-.6179
G1 X121.868 Y134.132 E-.1421
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.496 Y136.779 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970598
G1 F15000
M204 S6000
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
M204 S10000
G1 X128.953 Y137.122 Z1.2 F42000
M73 P54 R7
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.116552
G1 F15000
M204 S6000
G1 X129.082 Y137.083 E.00078
; LINE_WIDTH: 0.155822
G1 X129.211 Y137.043 E.0012
; LINE_WIDTH: 0.177544
G1 X129.818 Y136.832 E.00683
M204 S10000
G1 X129.793 Y136.794 F42000
; LINE_WIDTH: 0.353128
G1 F7736.755
M204 S6000
G1 X129.091 Y137.126 E.01903
; WIPE_START
G1 X129.793 Y136.794 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X130.443 Y135.184 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G2 X130.036 Y133.64 I-2.955 J-.046 E.05197
G1 X133.642 Y130.033 E.16402
G3 X132.933 Y129.306 I2.593 J-3.237 E.03277
G1 X132.659 Y129.465 E.01018
G1 X132.501 Y129.424 E.00526
G1 X132.193 Y129.659 E.01248
G1 X132.281 Y130.189 E.01729
G1 X132.144 Y130.44 E.00918
G1 X131.648 Y130.649 E.01729
G1 X131.602 Y131.185 E.01729
G1 X131.395 Y131.395 E.00949
G1 X134.397 Y134.397 E.13655
G2 X135.439 Y133.149 I-10.041 J-9.441 E.05231
; WIPE_START
G1 X134.397 Y134.397 E-.61786
G1 X134.133 Y134.133 E-.14215
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.781 Y129.506 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0971031
G1 F15000
M204 S6000
G1 X136.805 Y129.484 E.00014
; LINE_WIDTH: 0.122857
G1 X136.918 Y129.367 E.00102
; LINE_WIDTH: 0.172367
G1 X137.03 Y129.251 E.00166
; LINE_WIDTH: 0.188889
G1 X137.042 Y129.219 E.00039
; LINE_WIDTH: 0.158084
G1 X137.083 Y129.084 E.00129
; LINE_WIDTH: 0.116753
G1 X137.121 Y128.958 E.00076
; WIPE_START
G1 X137.083 Y129.084 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.121 Y127.041 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.116757
G1 F15000
M204 S6000
G1 X137.083 Y126.916 E.00076
; LINE_WIDTH: 0.158068
G1 X137.042 Y126.781 E.00129
; LINE_WIDTH: 0.188873
G1 X137.03 Y126.749 E.00039
; LINE_WIDTH: 0.172349
G1 X136.918 Y126.633 E.00166
; LINE_WIDTH: 0.122819
G1 X136.805 Y126.516 E.00102
; LINE_WIDTH: 0.097072
G1 X136.781 Y126.494 E.00014
; WIPE_START
G1 X136.805 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.439 Y122.851 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G2 X134.397 Y121.603 I-11.024 J8.143 E.05231
G1 X131.395 Y124.605 E.13655
G1 X131.602 Y124.815 E.00949
G1 X131.648 Y125.351 E.01729
G1 X132.144 Y125.56 E.01729
G1 X132.281 Y125.811 E.00918
G1 X132.193 Y126.341 E.01729
G1 X132.501 Y126.576 E.01247
G1 X132.66 Y126.535 E.00527
G1 X132.933 Y126.694 E.01018
G3 X133.642 Y125.967 I2.045 J1.284 E.03293
G1 X130.036 Y122.36 E.16402
G2 X130.443 Y120.816 I-2.05 J-1.366 E.05227
; WIPE_START
G1 X130.41 Y121.467 E-.24755
G1 X130.311 Y121.829 E-.14281
G1 X130.036 Y122.36 E-.22707
G1 X130.301 Y122.625 E-.14258
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.281 Y128.177 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.506201
G1 F5180.448
M204 S6000
G3 X131.092 Y129.163 I-3.28 J-.117 E.0369
G1 X131.393 Y128.773 E.01803
G1 X131.75 Y128.5 E.01647
G3 X131.75 Y127.5 I4.055 J-.5 E.03669
G1 X131.279 Y127.126 E.022
; LINE_WIDTH: 0.51526
G1 F5081.092
G1 X131.125 Y126.922 E.00956
G1 X131.273 Y127.639 E.0273
G1 X131.28 Y128.117 E.01784
; WIPE_START
G1 X131.273 Y127.639 E-.24786
G1 X131.125 Y126.922 E-.37932
G1 X131.279 Y127.126 E-.13282
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.092 Y129.163 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.545165
G1 F4778.544
M204 S6000
G1 X131.003 Y129.401 E.01007
; LINE_WIDTH: 0.57346
G1 F4523.695
G1 X130.914 Y129.639 E.01064
G1 X130.599 Y130.042 E.02146
; LINE_WIDTH: 0.554135
G1 F4694.698
G1 X130.52 Y130.167 E.00594
; LINE_WIDTH: 0.587525
G1 F4406.869
G1 X130.442 Y130.291 E.00633
G1 X129.969 Y130.657 E.02571
; LINE_WIDTH: 0.55673
G1 F4670.988
G1 X129.859 Y130.75 E.00585
; LINE_WIDTH: 0.568948
G1 F4562.501
G1 X129.75 Y130.844 E.00599
G1 X129.29 Y131.043 E.02081
; LINE_WIDTH: 0.54474
G1 F4782.592
G1 X129.125 Y131.117 E.00716
; LINE_WIDTH: 0.564687
G1 F4599.759
G1 X128.961 Y131.191 E.00745
G1 X128.457 Y131.275 E.02103
; LINE_WIDTH: 0.558445
G1 F4655.449
G1 X128.335 Y131.308 E.00516
; LINE_WIDTH: 0.58628
G1 F4416.967
G1 X128.212 Y131.341 E.00544
G1 X127.63 Y131.283 E.02513
; LINE_WIDTH: 0.560505
G1 F4636.92
G1 X127.502 Y131.287 E.00522
; LINE_WIDTH: 0.58248
G1 F4448.07
G1 X127.375 Y131.291 E.00544
G1 X126.812 Y131.086 E.02551
; LINE_WIDTH: 0.56008
G1 F4640.73
G1 X126.695 Y131.057 E.00494
; LINE_WIDTH: 0.587754
G1 F4405.018
G1 X126.577 Y131.028 E.00521
G1 X126.057 Y130.679 E.02698
; LINE_WIDTH: 0.56421
G1 F4603.963
G1 X125.963 Y130.629 E.00439
; LINE_WIDTH: 0.614064
G1 F4202.098
G1 X125.868 Y130.58 E.00481
G1 X125.315 Y129.987 E.03657
; LINE_WIDTH: 0.58697
G1 F4411.36
G1 X125.197 Y129.76 E.01101
; LINE_WIDTH: 0.54599
G1 F4770.708
G1 X125.078 Y129.533 E.01018
; LINE_WIDTH: 0.55049
G1 F4728.412
G1 X124.984 Y129.382 E.00711
; LINE_WIDTH: 0.592428
G1 F4367.543
G1 X124.891 Y129.232 E.0077
G1 X124.752 Y128.641 E.02636
; WIPE_START
G1 X124.891 Y129.232 E-.58824
G1 X124.984 Y129.382 E-.17176
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.891 Y131.561 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X127.074 Y131.661 E.00619
G1 X127.265 Y131.868 E.00839
G1 X127.555 Y131.735 E.0095
G1 X127.876 Y131.733 E.00957
G3 X128.249 Y131.93 I-.265 J.958 E.01266
G1 X128.511 Y131.722 E.00993
G1 X128.825 Y131.647 E.00962
G3 X129.219 Y131.745 I-.045 J1.024 E.01219
G1 X129.383 Y131.515 E.00841
G1 X129.63 Y131.357 E.00875
G1 X129.929 Y131.306 E.00902
G1 X130.112 Y131.324 E.00549
G1 X130.245 Y131.011 E.01015
G1 X130.485 Y130.796 E.00959
G1 X130.872 Y130.695 E.01192
G1 X130.929 Y130.344 E.0106
G1 X131.114 Y130.079 E.00962
G1 X131.453 Y129.897 E.01145
G1 X131.415 Y129.617 E.0084
G1 X131.489 Y129.326 E.00895
G1 X131.67 Y129.091 E.00882
G1 X132.081 Y128.777 E.01543
G1 X132.243 Y128.727 E.00504
G1 X132.146 Y128.245 E.01467
G1 X132.151 Y127.688 E.01659
G1 X132.243 Y127.272 E.01268
G1 X132.081 Y127.223 E.00502
G1 X131.67 Y126.909 E.01542
G1 X131.487 Y126.668 E.00902
G1 X131.415 Y126.383 E.00875
G1 X131.453 Y126.103 E.0084
G1 X131.114 Y125.921 E.01146
G1 X130.929 Y125.656 E.00962
G1 X130.872 Y125.305 E.01059
G1 X130.485 Y125.204 E.01191
G1 X130.215 Y124.941 E.01125
G1 X130.112 Y124.675 E.00847
G1 X129.735 Y124.681 E.01124
G1 X129.551 Y124.606 E.00592
G1 X129.321 Y124.408 E.00901
G1 X129.219 Y124.255 E.00549
G1 X128.934 Y124.348 E.00891
G1 X128.591 Y124.31 E.0103
G3 X128.249 Y124.07 I.393 J-.922 E.01251
G1 X128.012 Y124.224 E.00841
G1 X127.724 Y124.28 E.00875
G1 X127.428 Y124.217 E.00902
G1 X127.265 Y124.132 E.00549
G1 X127.034 Y124.369 E.00982
G1 X126.734 Y124.484 E.00959
G3 X126.326 Y124.437 I-.09 J-1.012 E.01233
G1 X126.152 Y124.735 E.01026
G1 X125.884 Y124.917 E.00964
G1 X125.492 Y124.966 E.01176
G1 X125.425 Y125.24 E.00841
G1 X125.208 Y125.521 E.01056
G3 X124.817 Y125.686 I-.57 J-.808 E.01274
G1 X124.806 Y126.037 E.01048
G1 X124.657 Y126.323 E.0096
G1 X124.341 Y126.551 E.01159
G1 X124.417 Y126.909 E.01093
G1 X124.339 Y127.222 E.00962
G1 X124.038 Y127.561 E.01349
G1 X123.852 Y127.665 E.00636
G3 X123.852 Y128.332 I-2.553 J.334 E.0199
G1 X124.213 Y128.609 E.01355
G1 X124.339 Y128.778 E.00627
G1 X124.417 Y129.091 E.00962
G1 X124.341 Y129.449 E.01093
G1 X124.657 Y129.676 E.01159
G1 X124.805 Y129.963 E.0096
G1 X124.817 Y130.314 E.01048
G1 X125.099 Y130.406 E.00885
G1 X125.344 Y130.622 E.00973
G3 X125.492 Y131.034 I-.811 J.524 E.01315
G1 X125.885 Y131.083 E.01178
G1 X126.152 Y131.265 E.00962
G1 X126.326 Y131.563 E.01026
G1 X126.603 Y131.507 E.00841
G1 X126.832 Y131.55 E.00695
; WIPE_START
G1 X126.603 Y131.507 E-.08872
G1 X126.326 Y131.563 E-.10734
G1 X126.152 Y131.265 E-.13094
G1 X125.885 Y131.083 E-.12276
G1 X125.492 Y131.034 E-.15026
G1 X125.454 Y130.854 E-.06999
G1 X125.353 Y130.64 E-.09
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.013 Y128.979 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X124.033 Y129.165 E.00557
G1 X123.908 Y129.634 E.01445
G1 X124.363 Y129.913 E.0159
G1 X124.447 Y130.115 E.00653
G1 X124.443 Y130.601 E.01445
G1 X124.927 Y130.741 E.015
G1 X125.075 Y130.902 E.00652
G1 X125.185 Y131.395 E.01506
G1 X125.7 Y131.419 E.01538
G1 X125.889 Y131.538 E.00666
G1 X126.117 Y131.989 E.01506
G1 X126.623 Y131.884 E.01538
G1 X126.836 Y131.953 E.00666
G1 X127.169 Y132.333 E.01505
G1 X127.632 Y132.105 E.01537
G1 X127.855 Y132.119 E.00666
G1 X128.273 Y132.404 E.01506
G1 X128.664 Y132.068 E.01538
G1 X128.884 Y132.026 E.00666
G1 X129.359 Y132.198 E.01506
G1 X129.655 Y131.775 E.01538
G1 X129.858 Y131.68 E.00666
G1 X130.361 Y131.729 E.01505
G1 X130.542 Y131.246 E.01537
G1 X130.714 Y131.103 E.00666
G1 X131.214 Y131.025 E.01506
G1 X131.27 Y130.512 E.01538
G1 X131.401 Y130.331 E.00666
G1 X131.865 Y130.131 E.01506
G1 X131.792 Y129.621 E.01537
G1 X131.873 Y129.414 E.00662
G1 X132.31 Y129.076 E.01644
G1 X132.562 Y129.051 E.00754
G2 X132.689 Y128.901 I-.041 J-.163 E.00625
G1 X132.539 Y128.402 E.01552
G3 X132.682 Y127.116 I2.486 J-.375 E.03898
G1 X132.634 Y126.991 E.00398
G1 X132.566 Y126.949 E.00237
G1 X132.313 Y126.926 E.00757
G1 X131.898 Y126.609 E.01555
G1 X131.802 Y126.438 E.00587
G1 X131.871 Y125.887 E.01653
G1 X131.401 Y125.669 E.01543
G1 X131.27 Y125.488 E.00666
G1 X131.223 Y124.985 E.01506
G1 X130.714 Y124.897 E.01538
G1 X130.543 Y124.755 E.00664
G1 X130.372 Y124.278 E.01508
G1 X129.857 Y124.32 E.0154
G1 X129.655 Y124.225 E.00664
G1 X129.372 Y123.806 E.01506
G1 X128.884 Y123.974 E.01538
G1 X128.664 Y123.932 E.00665
G1 X128.286 Y123.597 E.01505
G1 X127.855 Y123.881 E.01538
G1 X127.632 Y123.895 E.00666
G1 X127.182 Y123.665 E.01505
G1 X126.836 Y124.047 E.01537
G1 X126.623 Y124.116 E.00666
G1 X126.13 Y124.005 E.01506
G1 X125.889 Y124.462 E.01538
G1 X125.7 Y124.581 E.00665
G1 X125.195 Y124.596 E.01506
G1 X125.075 Y125.098 E.01537
G1 X124.922 Y125.261 E.00666
G1 X124.437 Y125.401 E.01505
G1 X124.446 Y125.917 E.01537
G1 X124.338 Y126.113 E.00666
G1 X123.902 Y126.369 E.01506
G1 X124.039 Y126.867 E.01538
G1 X123.985 Y127.082 E.0066
G1 X123.728 Y127.311 E.01026
G1 X123.419 Y127.41 E.00965
G1 X123.498 Y127.986 E.01731
G1 X123.425 Y128.574 E.01768
G1 X123.777 Y128.722 E.01138
G1 X123.972 Y128.935 E.0086
; WIPE_START
G1 X123.777 Y128.722 E-.10976
G1 X123.425 Y128.574 E-.14518
G1 X123.498 Y127.986 E-.2255
G1 X123.419 Y127.41 E-.22085
G1 X123.566 Y127.363 E-.05871
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.724 Y128.074 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.495955
G1 F5297.604
M204 S6000
G1 X124.736 Y127.572 E.01798
; LINE_WIDTH: 0.517835
G1 F5053.534
G1 X124.755 Y127.369 E.00766
G1 X124.513 Y127.668 E.01442
; LINE_WIDTH: 0.480941
G1 F5479.189
G1 X124.28 Y127.926 E.01201
G1 X124.308 Y128.143 E.00758
; LINE_WIDTH: 0.499478
G1 F5256.731
G1 X124.523 Y128.363 E.01109
; LINE_WIDTH: 0.525375
G1 F4974.56
G1 X124.738 Y128.582 E.01172
G1 X124.726 Y128.134 E.01708
M204 S10000
G1 X124.755 Y127.369 F42000
; LINE_WIDTH: 0.564645
G1 F4600.125
M204 S6000
G1 X124.823 Y127.068 E.01269
; LINE_WIDTH: 0.597371
G1 F4328.61
G1 X124.891 Y126.768 E.01349
G2 X125.315 Y126.013 I-11.501 J-6.959 E.03795
; LINE_WIDTH: 0.587935
G1 F4403.549
G1 X125.495 Y125.834 E.01094
; LINE_WIDTH: 0.556861
G1 F4669.801
G2 X125.917 Y125.395 I-5.2 J-5.425 E.02472
; LINE_WIDTH: 0.58012
G1 F4467.61
G1 X126.137 Y125.264 E.01085
; LINE_WIDTH: 0.5488
G1 F4744.208
G1 X126.357 Y125.134 E.01021
; LINE_WIDTH: 0.556095
G1 F4676.767
G1 X126.467 Y125.053 E.00555
; LINE_WIDTH: 0.600427
G1 F4304.883
G1 X126.577 Y124.972 E.00603
G1 X127.445 Y124.714 E.03988
; LINE_WIDTH: 0.575945
G1 F4502.603
G1 X127.699 Y124.704 E.01069
; LINE_WIDTH: 0.548555
G1 F4746.507
G1 X127.952 Y124.694 E.01014
; LINE_WIDTH: 0.55728
G1 F4665.993
G1 X128.082 Y124.677 E.00533
; LINE_WIDTH: 0.585843
G1 F4420.52
G1 X128.212 Y124.659 E.00563
G1 X128.805 Y124.79 E.02601
; LINE_WIDTH: 0.561595
G1 F4627.175
G1 X128.92 Y124.804 E.00478
; LINE_WIDTH: 0.586154
G1 F4417.992
G1 X129.036 Y124.817 E.00501
G1 X129.546 Y125.079 E.02459
; LINE_WIDTH: 0.56354
G1 F4609.888
G1 X129.669 Y125.13 E.00546
; LINE_WIDTH: 0.61318
G1 F4208.607
G1 X129.792 Y125.18 E.00598
; LINE_WIDTH: 0.620364
G1 F4156.252
G1 X129.936 Y125.304 E.00867
; LINE_WIDTH: 0.58509
G1 F4426.656
G1 X130.08 Y125.428 E.00814
; LINE_WIDTH: 0.549817
G1 F4734.693
G1 X130.224 Y125.552 E.00761
; LINE_WIDTH: 0.555455
G1 F4682.607
G1 X130.333 Y125.63 E.00544
; LINE_WIDTH: 0.587994
G1 F4403.071
G1 X130.442 Y125.709 E.00578
G1 X130.794 Y126.222 E.02679
; LINE_WIDTH: 0.564155
G1 F4604.449
G1 X130.865 Y126.305 E.00449
; LINE_WIDTH: 0.583914
G1 F4436.283
G1 X130.936 Y126.387 E.00466
G1 X131.105 Y126.865 E.02167
; WIPE_START
G1 X130.936 Y126.387 E-.62555
G1 X130.865 Y126.305 E-.13445
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.336 Y126.947 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X125.628 Y126.383 E.01894
G1 X125.963 Y125.977 E.01567
G1 X126.432 Y125.601 E.01792
G1 X126.991 Y125.312 E.01873
G1 X127.498 Y125.172 E.01567
G1 X127.936 Y125.129 E.0131
G1 X128.492 Y125.175 E.01663
G3 X129.828 Y125.791 I-.655 J3.179 E.04421
G1 X130.19 Y126.139 E.01497
G1 X130.493 Y126.57 E.01567
G1 X130.71 Y127.053 E.01579
G1 X130.857 Y127.703 E.01984
G1 X130.866 Y128.231 E.01575
G3 X130.343 Y129.655 I-3.127 J-.342 E.04562
G1 X129.945 Y130.115 E.01812
G1 X129.527 Y130.434 E.01567
G1 X129.137 Y130.638 E.0131
G1 X128.581 Y130.808 E.01732
G1 X127.936 Y130.871 E.01932
G1 X127.413 Y130.811 E.01567
G1 X126.773 Y130.591 E.02015
G1 X126.296 Y130.31 E.0165
G1 X125.903 Y129.96 E.01567
G1 X125.575 Y129.527 E.01617
G1 X125.336 Y129.053 E.01584
G1 X125.171 Y128.481 E.01771
G1 X125.129 Y128.012 E.01405
G1 X125.182 Y127.469 E.01624
G1 X125.319 Y127.005 E.0144
M204 S10000
G1 X125.584 Y127.406 F42000
; LINE_WIDTH: 0.41999
G1 F6364.87
M204 S6000
G1 X125.759 Y126.905 E.01581
G3 X126.637 Y125.918 I2.336 J1.192 E.0398
G1 X127.145 Y125.656 E.01701
G1 X127.541 Y125.547 E.01224
G1 X128.18 Y125.515 E.01904
G1 X128.685 Y125.6 E.01526
G1 X129.152 Y125.791 E.01505
G1 X129.618 Y126.104 E.0167
G1 X129.976 Y126.478 E.01542
G3 X130.35 Y127.167 I-1.83 J1.441 E.02348
G1 X130.484 Y127.76 E.01812
G3 X130.295 Y128.981 I-2.647 J.214 E.03712
G1 X130.035 Y129.438 E.01568
G1 X129.674 Y129.854 E.0164
G1 X129.347 Y130.103 E.01224
G1 X128.747 Y130.378 E.01965
G1 X128.18 Y130.485 E.01721
G1 X127.541 Y130.453 E.01903
G1 X127.145 Y130.344 E.01224
G1 X126.637 Y130.082 E.01701
G1 X126.222 Y129.749 E.01586
G1 X125.899 Y129.335 E.01564
G1 X125.627 Y128.767 E.01876
G3 X125.576 Y127.466 I2.407 J-.745 E.03922
; OBJECT_ID: 114
; WIPE_START
G1 X125.506 Y128.004 E-.20615
G1 X125.533 Y128.367 E-.13832
G1 X125.627 Y128.767 E-.1561
G1 X125.899 Y129.335 E-.23938
G1 X125.932 Y129.376 E-.02006
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S10000
G1 X118.348 Y128.518 Z1.2 F42000
G1 X105.146 Y127.025 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X105.29 Y126.793 E.0088
G3 X106.721 Y125.921 I1.716 J1.208 E.05539
G3 X107.968 Y126.135 I.284 J2.089 E.04135
G3 X105.12 Y127.079 I-.962 J1.866 E.31664
M204 S250
G1 X105.483 Y127.226 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X105.615 Y127.021 E.00725
G3 X106.765 Y126.311 I1.399 J.979 E.0414
G3 X107.706 Y126.439 I.254 J1.653 E.02868
G3 X105.465 Y127.282 I-.692 J1.562 E.24063
; WIPE_START
M204 S6000
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
M204 S10000
M73 P54 R6
G1 X102.02 Y128.605 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X102.016 Y128.636 E.00101
G3 X99.961 Y125.903 I-2.003 J-.634 E.29589
G3 X101.523 Y126.541 I.037 J2.139 E.05577
G3 X102.09 Y128.322 I-1.509 J1.461 E.06228
G1 X102.034 Y128.546 E.00745
M204 S250
G1 X101.638 Y128.515 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X101.644 Y128.518 E.0002
G3 X99.976 Y126.294 I-1.628 J-.516 E.22297
G3 X100.824 Y126.497 I.051 J1.661 E.02628
G3 X101.704 Y128.262 I-.808 J1.505 E.06262
G1 X101.653 Y128.457 E.00601
; WIPE_START
M204 S6000
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
M204 S10000
G1 X105.106 Y123.821 Z1.2 F42000
G1 X108.595 Y119.623 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X108.772 Y119.857 E.00944
G3 X106.846 Y118.902 I-1.765 J1.14 E.35192
G3 X107.672 Y119.01 I.126 J2.248 E.02697
G1 X107.793 Y119.049 E.00407
G3 X108.556 Y119.577 I-.786 J1.948 E.03008
M204 S250
G1 X108.283 Y119.863 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X106.876 Y119.294 I-1.275 J1.131 E.27222
G3 X107.554 Y119.384 I.103 J1.831 E.0205
G1 X107.646 Y119.413 E.00288
G3 X108.242 Y119.819 I-.639 J1.581 E.02163
; WIPE_START
M204 S6000
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
M204 S10000
G1 X114.801 Y126.087 Z1.2 F42000
G1 X115.647 Y126.686 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X115.817 Y126.924 E.0094
G3 X113.8 Y125.912 I-1.803 J1.078 E.34789
G3 X115.407 Y126.429 I.2 J2.13 E.05577
G3 X115.611 Y126.638 I-1.393 J1.573 E.00941
M204 S250
G1 X115.329 Y126.909 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X113.845 Y126.302 I-1.313 J1.092 E.26998
G3 X114.706 Y126.439 I.178 J1.652 E.02628
G3 X115.29 Y126.864 I-.691 J1.562 E.02167
; WIPE_START
M204 S6000
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
M204 S10000
G1 X110.301 Y134.28 Z1.2 F42000
G1 X107.765 Y136.96 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X107.486 Y137.049 E.00941
G3 X106.881 Y132.906 I-.473 J-2.047 E.22328
G3 X108.466 Y133.484 I.14 J2.077 E.05586
G3 X107.822 Y136.942 I-1.452 J1.518 E.13401
M204 S250
G1 X107.647 Y136.589 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X106.911 Y133.297 I-.631 J-1.587 E.17598
G3 X107.766 Y133.467 I.115 J1.658 E.02628
G3 X107.702 Y136.566 I-.75 J1.535 E.11567
; WIPE_START
M204 S6000
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
M204 S10000
G1 X106.042 Y128.616 Z1.2 F42000
G1 X106.305 Y118.631 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X107.057 Y118.606 I.684 J9.328 E.02423
G3 X103.056 Y119.473 I-.059 J9.395 E1.76559
G3 X106.245 Y118.636 I3.933 J8.486 E.10657
M204 S250
G1 X106.276 Y118.237 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X107.063 Y118.214 E.02346
G3 X102.891 Y119.117 I-.066 J9.787 E1.70362
G3 X106.218 Y118.244 I4.097 J8.84 E.10299
M204 S10000
G1 X106.047 Y118.883 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.117478
G1 F15000
M204 S6000
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
M204 S10000
G1 X107.958 Y118.878 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.116544
G1 F15000
M204 S6000
G1 X108.087 Y118.917 E.00078
; LINE_WIDTH: 0.155808
G1 X108.216 Y118.957 E.0012
; LINE_WIDTH: 0.177528
G1 X108.822 Y119.169 E.00683
M204 S10000
G1 X108.797 Y119.206 F42000
; LINE_WIDTH: 0.353186
G1 F7735.31
M204 S6000
G1 X108.096 Y118.874 E.01902
; WIPE_START
G1 X108.797 Y119.206 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.443 Y122.851 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G2 X113.402 Y121.603 I-11.024 J8.143 E.05231
G1 X110.399 Y124.605 E.13655
G1 X110.607 Y124.815 E.00949
M73 P55 R6
G1 X110.653 Y125.351 E.01729
G1 X111.148 Y125.56 E.01729
G1 X111.286 Y125.811 E.00918
G1 X111.197 Y126.341 E.01729
G1 X111.506 Y126.576 E.01247
G1 X111.664 Y126.535 E.00527
G1 X111.937 Y126.694 E.01018
G3 X112.647 Y125.967 I2.045 J1.284 E.03293
G1 X109.04 Y122.36 E.16402
G2 X109.447 Y120.816 I-2.05 J-1.366 E.05227
; WIPE_START
G1 X109.415 Y121.467 E-.24755
G1 X109.315 Y121.829 E-.14281
G1 X109.04 Y122.36 E-.22707
G1 X109.305 Y122.625 E-.14258
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.285 Y128.177 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.506201
G1 F5180.448
M204 S6000
G3 X110.096 Y129.163 I-3.28 J-.117 E.0369
G1 X110.397 Y128.773 E.01803
G1 X110.755 Y128.5 E.01647
G3 X110.755 Y127.5 I4.055 J-.5 E.03669
G1 X110.284 Y127.126 E.022
; LINE_WIDTH: 0.51526
G1 F5081.092
G1 X110.129 Y126.922 E.00956
G1 X110.277 Y127.639 E.0273
G1 X110.284 Y128.117 E.01784
; WIPE_START
G1 X110.277 Y127.639 E-.24786
G1 X110.129 Y126.922 E-.37932
G1 X110.284 Y127.126 E-.13282
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.096 Y129.163 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.545165
G1 F4778.544
M204 S6000
G1 X110.007 Y129.401 E.01007
; LINE_WIDTH: 0.57346
G1 F4523.695
G1 X109.918 Y129.639 E.01064
G1 X109.604 Y130.042 E.02146
; LINE_WIDTH: 0.554135
G1 F4694.698
G1 X109.525 Y130.167 E.00594
; LINE_WIDTH: 0.587525
G1 F4406.869
G1 X109.446 Y130.291 E.00633
G1 X108.974 Y130.657 E.02571
; LINE_WIDTH: 0.55673
G1 F4670.988
G1 X108.864 Y130.75 E.00585
; LINE_WIDTH: 0.568948
G1 F4562.501
G1 X108.754 Y130.844 E.00599
G1 X108.295 Y131.043 E.02081
; LINE_WIDTH: 0.54474
G1 F4782.592
G1 X108.13 Y131.117 E.00716
; LINE_WIDTH: 0.564687
G1 F4599.759
G1 X107.965 Y131.191 E.00745
G1 X107.462 Y131.275 E.02103
; LINE_WIDTH: 0.558445
G1 F4655.449
G1 X107.339 Y131.308 E.00516
; LINE_WIDTH: 0.58628
G1 F4416.967
G1 X107.217 Y131.341 E.00544
G1 X106.634 Y131.283 E.02513
; LINE_WIDTH: 0.560505
G1 F4636.92
G1 X106.507 Y131.287 E.00522
; LINE_WIDTH: 0.58248
G1 F4448.07
G1 X106.379 Y131.291 E.00544
G1 X105.817 Y131.086 E.02551
; LINE_WIDTH: 0.56008
G1 F4640.73
G1 X105.699 Y131.057 E.00494
; LINE_WIDTH: 0.587754
G1 F4405.018
G1 X105.582 Y131.028 E.00521
G1 X105.061 Y130.679 E.02698
; LINE_WIDTH: 0.56421
G1 F4603.963
G1 X104.967 Y130.629 E.00439
; LINE_WIDTH: 0.614064
G1 F4202.098
G1 X104.873 Y130.58 E.00481
G1 X104.319 Y129.987 E.03657
; LINE_WIDTH: 0.58697
G1 F4411.36
G1 X104.201 Y129.76 E.01101
; LINE_WIDTH: 0.54599
G1 F4770.708
G1 X104.083 Y129.533 E.01018
; LINE_WIDTH: 0.55049
G1 F4728.412
G1 X103.989 Y129.382 E.00711
; LINE_WIDTH: 0.592428
G1 F4367.543
G1 X103.895 Y129.232 E.0077
G1 X103.756 Y128.641 E.02636
; WIPE_START
G1 X103.895 Y129.232 E-.58824
G1 X103.989 Y129.382 E-.17176
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.896 Y131.561 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X106.078 Y131.661 E.00619
G1 X106.269 Y131.868 E.00839
G1 X106.559 Y131.735 E.0095
G1 X106.88 Y131.733 E.00957
G3 X107.254 Y131.93 I-.265 J.958 E.01266
G1 X107.515 Y131.722 E.00993
G1 X107.829 Y131.647 E.00962
G3 X108.223 Y131.745 I-.045 J1.024 E.01219
G1 X108.387 Y131.515 E.00841
G1 X108.635 Y131.357 E.00875
G1 X108.933 Y131.306 E.00902
G1 X109.117 Y131.324 E.00549
G1 X109.25 Y131.011 E.01015
G1 X109.49 Y130.796 E.00959
G1 X109.877 Y130.695 E.01192
G1 X109.934 Y130.344 E.0106
G1 X110.119 Y130.079 E.00962
G1 X110.457 Y129.897 E.01145
G1 X110.419 Y129.617 E.0084
G1 X110.494 Y129.326 E.00895
G1 X110.674 Y129.091 E.00882
G1 X111.086 Y128.777 E.01543
G1 X111.248 Y128.727 E.00504
G1 X111.15 Y128.245 E.01467
G1 X111.155 Y127.688 E.01659
G1 X111.247 Y127.272 E.01268
G1 X111.086 Y127.223 E.00502
G1 X110.674 Y126.909 E.01542
G1 X110.491 Y126.668 E.00902
G1 X110.419 Y126.383 E.00875
G1 X110.457 Y126.103 E.0084
G1 X110.119 Y125.921 E.01146
G1 X109.934 Y125.656 E.00962
G1 X109.877 Y125.305 E.01059
G1 X109.49 Y125.204 E.01191
G1 X109.219 Y124.941 E.01125
G1 X109.117 Y124.675 E.00847
G1 X108.739 Y124.681 E.01124
G1 X108.555 Y124.606 E.00592
G1 X108.326 Y124.408 E.00901
G1 X108.223 Y124.255 E.00549
G1 X107.939 Y124.348 E.00891
G1 X107.595 Y124.31 E.0103
G3 X107.254 Y124.07 I.393 J-.922 E.01251
G1 X107.017 Y124.224 E.00841
G1 X106.729 Y124.28 E.00875
G1 X106.432 Y124.217 E.00902
G1 X106.269 Y124.132 E.00549
G1 X106.039 Y124.369 E.00982
G1 X105.739 Y124.484 E.00959
G3 X105.33 Y124.437 I-.09 J-1.012 E.01233
G1 X105.156 Y124.735 E.01026
G1 X104.889 Y124.917 E.00964
G1 X104.497 Y124.966 E.01176
G1 X104.429 Y125.24 E.00841
G1 X104.213 Y125.521 E.01056
G3 X103.821 Y125.686 I-.57 J-.808 E.01274
G1 X103.81 Y126.037 E.01048
G1 X103.662 Y126.323 E.0096
G1 X103.346 Y126.551 E.01159
G1 X103.422 Y126.909 E.01093
G1 X103.343 Y127.222 E.00962
G1 X103.043 Y127.561 E.01349
G1 X102.856 Y127.665 E.00636
G3 X102.857 Y128.332 I-2.553 J.334 E.0199
G1 X103.217 Y128.609 E.01355
G1 X103.343 Y128.778 E.00627
G1 X103.422 Y129.091 E.00962
G1 X103.346 Y129.449 E.01093
G1 X103.662 Y129.676 E.01159
G1 X103.81 Y129.963 E.0096
G1 X103.821 Y130.314 E.01048
G1 X104.104 Y130.406 E.00885
G1 X104.349 Y130.622 E.00973
G3 X104.497 Y131.034 I-.811 J.524 E.01315
G1 X104.889 Y131.083 E.01178
G1 X105.156 Y131.265 E.00962
G1 X105.33 Y131.563 E.01026
G1 X105.607 Y131.507 E.00841
G1 X105.837 Y131.55 E.00695
; WIPE_START
G1 X105.607 Y131.507 E-.08872
G1 X105.33 Y131.563 E-.10734
G1 X105.156 Y131.265 E-.13094
G1 X104.889 Y131.083 E-.12276
G1 X104.497 Y131.034 E-.15026
G1 X104.458 Y130.854 E-.06999
G1 X104.357 Y130.64 E-.09
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.017 Y128.979 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X103.037 Y129.165 E.00557
G1 X102.913 Y129.634 E.01445
G1 X103.368 Y129.913 E.0159
G1 X103.452 Y130.115 E.00653
G1 X103.448 Y130.601 E.01445
G1 X103.931 Y130.741 E.015
G1 X104.08 Y130.902 E.00652
G1 X104.189 Y131.395 E.01506
G1 X104.705 Y131.419 E.01538
G1 X104.893 Y131.538 E.00666
G1 X105.122 Y131.989 E.01506
G1 X105.627 Y131.884 E.01538
G1 X105.84 Y131.953 E.00666
G1 X106.173 Y132.333 E.01505
G1 X106.636 Y132.105 E.01537
G1 X106.86 Y132.119 E.00666
G1 X107.277 Y132.404 E.01506
G1 X107.669 Y132.068 E.01538
G1 X107.888 Y132.026 E.00666
G1 X108.364 Y132.198 E.01506
G1 X108.66 Y131.775 E.01538
G1 X108.862 Y131.68 E.00666
G1 X109.365 Y131.729 E.01505
G1 X109.547 Y131.246 E.01537
G1 X109.719 Y131.103 E.00666
G1 X110.218 Y131.025 E.01506
G1 X110.274 Y130.512 E.01538
G1 X110.406 Y130.331 E.00666
G1 X110.87 Y130.131 E.01506
G1 X110.796 Y129.621 E.01537
G1 X110.878 Y129.414 E.00662
G1 X111.315 Y129.076 E.01644
G1 X111.566 Y129.051 E.00754
G2 X111.693 Y128.901 I-.041 J-.163 E.00625
G1 X111.544 Y128.402 E.01552
G3 X111.686 Y127.116 I2.486 J-.375 E.03898
G1 X111.639 Y126.991 E.00398
G1 X111.571 Y126.949 E.00237
G1 X111.318 Y126.926 E.00757
G1 X110.903 Y126.609 E.01555
G1 X110.806 Y126.438 E.00587
G1 X110.875 Y125.887 E.01653
G1 X110.406 Y125.669 E.01543
G1 X110.274 Y125.488 E.00666
G1 X110.228 Y124.985 E.01506
G1 X109.719 Y124.897 E.01538
G1 X109.547 Y124.755 E.00664
G1 X109.377 Y124.278 E.01508
G1 X108.861 Y124.32 E.0154
G1 X108.66 Y124.225 E.00664
G1 X108.377 Y123.806 E.01506
G1 X107.888 Y123.974 E.01538
G1 X107.669 Y123.932 E.00665
G1 X107.291 Y123.597 E.01505
G1 X106.86 Y123.881 E.01538
G1 X106.636 Y123.895 E.00666
G1 X106.187 Y123.665 E.01505
G1 X105.84 Y124.047 E.01537
G1 X105.627 Y124.116 E.00666
G1 X105.134 Y124.005 E.01506
G1 X104.893 Y124.462 E.01538
G1 X104.705 Y124.581 E.00665
G1 X104.199 Y124.596 E.01506
G1 X104.08 Y125.098 E.01537
G1 X103.927 Y125.261 E.00666
G1 X103.441 Y125.401 E.01505
G1 X103.45 Y125.917 E.01537
G1 X103.343 Y126.113 E.00666
G1 X102.907 Y126.369 E.01506
G1 X103.044 Y126.867 E.01538
G1 X102.99 Y127.082 E.0066
G1 X102.732 Y127.311 E.01026
G1 X102.424 Y127.41 E.00965
G1 X102.503 Y127.986 E.01731
G1 X102.429 Y128.574 E.01768
G1 X102.782 Y128.722 E.01138
G1 X102.977 Y128.935 E.0086
; WIPE_START
G1 X102.782 Y128.722 E-.10976
G1 X102.429 Y128.574 E-.14518
G1 X102.503 Y127.986 E-.2255
G1 X102.424 Y127.41 E-.22085
G1 X102.571 Y127.363 E-.05871
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.728 Y128.074 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.495955
G1 F5297.604
M204 S6000
G1 X103.741 Y127.572 E.01798
; LINE_WIDTH: 0.517835
G1 F5053.534
G1 X103.759 Y127.369 E.00766
G1 X103.517 Y127.668 E.01442
; LINE_WIDTH: 0.480941
G1 F5479.189
G1 X103.285 Y127.926 E.01201
G1 X103.312 Y128.143 E.00758
; LINE_WIDTH: 0.499478
G1 F5256.731
G1 X103.527 Y128.363 E.01109
; LINE_WIDTH: 0.525375
G1 F4974.56
G1 X103.742 Y128.582 E.01172
G1 X103.73 Y128.134 E.01708
M204 S10000
G1 X103.759 Y127.369 F42000
; LINE_WIDTH: 0.564645
G1 F4600.125
M204 S6000
G1 X103.827 Y127.068 E.01269
; LINE_WIDTH: 0.597371
G1 F4328.61
G1 X103.895 Y126.768 E.01349
G2 X104.319 Y126.013 I-11.501 J-6.959 E.03795
; LINE_WIDTH: 0.587935
G1 F4403.549
G1 X104.5 Y125.834 E.01094
; LINE_WIDTH: 0.556861
G1 F4669.801
G2 X104.922 Y125.395 I-5.2 J-5.425 E.02472
; LINE_WIDTH: 0.58012
G1 F4467.61
G1 X105.141 Y125.264 E.01085
; LINE_WIDTH: 0.5488
G1 F4744.208
G1 X105.361 Y125.134 E.01021
; LINE_WIDTH: 0.556095
G1 F4676.767
G1 X105.471 Y125.053 E.00555
; LINE_WIDTH: 0.600427
G1 F4304.883
G1 X105.582 Y124.972 E.00603
G1 X106.45 Y124.714 E.03988
; LINE_WIDTH: 0.575945
G1 F4502.603
G1 X106.703 Y124.704 E.01069
; LINE_WIDTH: 0.548555
G1 F4746.507
G1 X106.957 Y124.694 E.01014
; LINE_WIDTH: 0.55728
G1 F4665.993
G1 X107.087 Y124.677 E.00533
; LINE_WIDTH: 0.585843
G1 F4420.52
G1 X107.217 Y124.659 E.00563
G1 X107.809 Y124.79 E.02601
; LINE_WIDTH: 0.561595
G1 F4627.175
G1 X107.925 Y124.804 E.00478
; LINE_WIDTH: 0.586154
G1 F4417.992
G1 X108.041 Y124.817 E.00501
G1 X108.55 Y125.079 E.02459
; LINE_WIDTH: 0.56354
G1 F4609.888
G1 X108.673 Y125.13 E.00546
; LINE_WIDTH: 0.61318
G1 F4208.607
G1 X108.796 Y125.18 E.00598
; LINE_WIDTH: 0.620364
G1 F4156.252
G1 X108.94 Y125.304 E.00867
; LINE_WIDTH: 0.58509
G1 F4426.656
G1 X109.085 Y125.428 E.00814
; LINE_WIDTH: 0.549817
G1 F4734.693
G1 X109.229 Y125.552 E.00761
; LINE_WIDTH: 0.555455
G1 F4682.607
G1 X109.338 Y125.63 E.00544
; LINE_WIDTH: 0.587994
G1 F4403.071
G1 X109.446 Y125.709 E.00578
G1 X109.798 Y126.222 E.02679
; LINE_WIDTH: 0.564155
G1 F4604.449
G1 X109.87 Y126.305 E.00449
; LINE_WIDTH: 0.583914
G1 F4436.283
G1 X109.941 Y126.387 E.00466
G1 X110.109 Y126.865 E.02167
; WIPE_START
G1 X109.941 Y126.387 E-.62555
G1 X109.87 Y126.305 E-.13445
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.34 Y126.947 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X104.633 Y126.383 E.01894
G1 X104.967 Y125.977 E.01567
G1 X105.437 Y125.601 E.01792
G1 X105.995 Y125.312 E.01873
G1 X106.503 Y125.172 E.01567
G1 X106.94 Y125.129 E.0131
G1 X107.497 Y125.175 E.01663
G3 X108.833 Y125.791 I-.655 J3.179 E.04421
G1 X109.195 Y126.139 E.01497
G1 X109.497 Y126.57 E.01567
G1 X109.714 Y127.053 E.01579
G1 X109.862 Y127.703 E.01984
G1 X109.871 Y128.231 E.01575
G3 X109.348 Y129.655 I-3.127 J-.342 E.04562
G1 X108.95 Y130.115 E.01812
G1 X108.531 Y130.434 E.01567
G1 X108.142 Y130.638 E.0131
G1 X107.586 Y130.808 E.01732
G1 X106.94 Y130.871 E.01932
G1 X106.418 Y130.811 E.01567
G1 X105.778 Y130.591 E.02015
G1 X105.3 Y130.31 E.0165
G1 X104.907 Y129.96 E.01567
G1 X104.58 Y129.527 E.01617
G1 X104.34 Y129.053 E.01584
G1 X104.175 Y128.481 E.01771
G1 X104.133 Y128.012 E.01405
G1 X104.187 Y127.469 E.01624
G1 X104.323 Y127.005 E.0144
M204 S10000
G1 X104.589 Y127.406 F42000
; LINE_WIDTH: 0.41999
G1 F6364.87
M204 S6000
G1 X104.764 Y126.905 E.01581
G3 X105.642 Y125.918 I2.336 J1.192 E.0398
G1 X106.149 Y125.656 E.01701
G1 X106.546 Y125.547 E.01224
G1 X107.184 Y125.515 E.01904
G1 X107.689 Y125.6 E.01526
G1 X108.157 Y125.791 E.01505
G1 X108.622 Y126.104 E.0167
G1 X108.98 Y126.478 E.01542
G3 X109.355 Y127.167 I-1.83 J1.441 E.02348
G1 X109.489 Y127.76 E.01812
G3 X109.299 Y128.981 I-2.647 J.214 E.03712
G1 X109.039 Y129.438 E.01568
G1 X108.678 Y129.854 E.0164
G1 X108.351 Y130.103 E.01224
G1 X107.752 Y130.378 E.01965
G1 X107.184 Y130.485 E.01721
G1 X106.546 Y130.453 E.01903
G1 X106.149 Y130.344 E.01224
G1 X105.642 Y130.082 E.01701
G1 X105.227 Y129.749 E.01586
G1 X104.904 Y129.335 E.01564
G1 X104.631 Y128.767 E.01876
G3 X104.581 Y127.466 I2.407 J-.745 E.03922
; WIPE_START
G1 X104.51 Y128.004 E-.20615
G1 X104.538 Y128.367 E-.13831
G1 X104.631 Y128.767 E-.1561
G1 X104.904 Y129.335 E-.23938
G1 X104.936 Y129.376 E-.02006
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X99.82 Y130.441 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G2 X101.364 Y130.035 I.18 J-2.457 E.05227
G1 X104.972 Y133.643 E.16407
G3 X106.118 Y132.721 I2.038 J1.36 E.04803
G1 X105.966 Y132.692 E.00495
G1 X105.614 Y132.286 E.01729
G1 X105.09 Y132.408 E.01729
G1 X104.832 Y132.286 E.00918
G1 X104.592 Y131.805 E.01729
G1 X104.054 Y131.793 E.01729
G3 X103.756 Y131.248 I.196 J-.461 E.02152
G1 X100.608 Y134.396 E.14317
G2 X101.856 Y135.438 I10.579 J-11.405 E.05231
; WIPE_START
G1 X100.608 Y134.396 E-.6179
G1 X100.872 Y134.132 E-.1421
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.501 Y136.779 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970598
G1 F15000
M204 S6000
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
M204 S10000
G1 X107.958 Y137.122 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.116552
G1 F15000
M204 S6000
G1 X108.087 Y137.083 E.00078
; LINE_WIDTH: 0.155822
G1 X108.216 Y137.043 E.0012
; LINE_WIDTH: 0.177544
G1 X108.822 Y136.832 E.00683
M204 S10000
G1 X108.797 Y136.794 F42000
; LINE_WIDTH: 0.353128
G1 F7736.755
M204 S6000
G1 X108.095 Y137.126 E.01903
; WIPE_START
G1 X108.797 Y136.794 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.447 Y135.184 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G2 X109.04 Y133.64 I-2.955 J-.046 E.05197
G1 X112.647 Y130.033 E.16402
G3 X111.937 Y129.306 I2.593 J-3.237 E.03277
G1 X111.664 Y129.465 E.01018
G1 X111.506 Y129.424 E.00526
G1 X111.197 Y129.659 E.01248
G1 X111.286 Y130.189 E.01729
G1 X111.148 Y130.44 E.00918
G1 X110.653 Y130.649 E.01729
G1 X110.607 Y131.185 E.01729
G1 X110.399 Y131.395 E.00949
G1 X113.402 Y134.397 E.13655
G2 X114.444 Y133.149 I-10.041 J-9.441 E.05231
; WIPE_START
G1 X113.402 Y134.397 E-.61786
G1 X113.137 Y134.133 E-.14215
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X115.786 Y129.506 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0971031
G1 F15000
M204 S6000
G1 X115.81 Y129.484 E.00014
; LINE_WIDTH: 0.122857
G1 X115.922 Y129.367 E.00102
; LINE_WIDTH: 0.172367
G1 X116.035 Y129.251 E.00166
; LINE_WIDTH: 0.188889
G1 X116.047 Y129.219 E.00039
; LINE_WIDTH: 0.158084
G1 X116.088 Y129.084 E.00129
; LINE_WIDTH: 0.116753
G1 X116.125 Y128.958 E.00076
; WIPE_START
G1 X116.088 Y129.084 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X116.125 Y127.041 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.116757
G1 F15000
M204 S6000
G1 X116.088 Y126.916 E.00076
; LINE_WIDTH: 0.158068
G1 X116.047 Y126.781 E.00129
; LINE_WIDTH: 0.188873
G1 X116.035 Y126.749 E.00039
; LINE_WIDTH: 0.172349
G1 X115.922 Y126.633 E.00166
; LINE_WIDTH: 0.122819
G1 X115.81 Y126.516 E.00102
; LINE_WIDTH: 0.097072
G1 X115.786 Y126.494 E.00014
; WIPE_START
G1 X115.81 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.364 Y124.836 Z1.2 F42000
G1 X99.566 Y122.852 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X100.608 Y121.604 I12.531 J9.396 E.05231
G1 X103.756 Y124.752 E.14317
G3 X104.054 Y124.207 I.494 J-.083 E.02152
G1 X104.592 Y124.195 E.01729
G1 X104.832 Y123.714 E.01728
G1 X105.09 Y123.592 E.00918
G1 X105.614 Y123.714 E.01729
G1 X105.966 Y123.308 E.01729
G1 X106.118 Y123.279 E.00495
G3 X104.972 Y122.357 I.892 J-2.282 E.04803
G1 X101.364 Y125.965 E.16407
G2 X99.82 Y125.559 I-1.492 J2.538 E.05198
; WIPE_START
G1 X100.474 Y125.592 E-.24877
G1 X100.836 Y125.691 E-.14278
G1 X101.364 Y125.965 E-.22587
G1 X101.629 Y125.699 E-.14258
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X98.228 Y126.494 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.097088
G1 F15000
M204 S6000
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
M204 S10000
G1 X97.888 Y128.956 Z1.2 F42000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.117842
G1 F15000
M204 S6000
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
; CHANGE_LAYER
; Z_HEIGHT: 1
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X98.204 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 114
M625
; layer num/total_layer_count: 5/23
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
M106 S196.35
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z1.2 I.232 J1.195 P1  F42000
G1 X128.277 Y123.636 Z1.2
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X128.753 Y124.063 E.02057
G1 X129.353 Y123.842 E.02057
G1 X129.709 Y124.373 E.02057
G1 X130.345 Y124.308 E.02057
G1 X130.557 Y124.912 E.02057
G1 X131.19 Y125.007 E.02057
G1 X131.245 Y125.644 E.02057
G1 X131.834 Y125.894 E.02057
G1 X131.729 Y126.525 E.02057
G1 X132.237 Y126.913 E.02057
G1 X131.979 Y127.498 E.02057
G1 X132.375 Y128 E.02057
G1 X131.979 Y128.502 E.02057
G1 X132.237 Y129.087 E.02057
G1 X131.729 Y129.475 E.02057
G1 X131.834 Y130.106 E.02057
G1 X131.245 Y130.356 E.02057
G1 X131.189 Y130.993 E.02057
G1 X130.557 Y131.088 E.02057
G1 X130.345 Y131.692 E.02057
G1 X129.709 Y131.627 E.02057
G1 X129.353 Y132.158 E.02057
G1 X128.753 Y131.937 E.02057
G1 X128.277 Y132.364 E.02057
G1 X127.751 Y132 E.02057
G1 X127.183 Y132.295 E.02057
G1 X126.764 Y131.812 E.02057
G1 X126.141 Y131.956 E.02057
G1 X125.855 Y131.384 E.02057
G1 X125.215 Y131.369 E.02057
G1 X125.081 Y130.744 E.02057
G1 X124.465 Y130.57 E.02057
G1 X124.49 Y129.931 E.02057
G1 X123.937 Y129.61 E.02057
G1 X124.12 Y128.997 E.02057
G1 X123.664 Y128.548 E.02057
G1 X123.994 Y128 E.02057
G1 X123.664 Y127.452 E.02057
G1 X124.12 Y127.003 E.02057
G1 X123.937 Y126.39 E.02057
G1 X124.49 Y126.069 E.02057
G1 X124.465 Y125.43 E.02057
G1 X125.081 Y125.256 E.02057
G1 X125.215 Y124.631 E.02057
G1 X125.855 Y124.616 E.02057
G1 X126.141 Y124.044 E.02057
G1 X126.764 Y124.188 E.02057
G1 X127.183 Y123.705 E.02057
G1 X127.751 Y124 E.02057
G1 X128.227 Y123.67 E.01864
; WIPE_START
G1 X128.753 Y124.063 E-.24934
G1 X129.353 Y123.842 E-.24308
G1 X129.709 Y124.373 E-.24306
G1 X129.773 Y124.367 E-.02452
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.479 Y127.225 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X126.61 Y127.021 E.00723
G3 X127.715 Y126.316 I1.401 J.978 E.04006
G3 X128.198 Y126.301 I.292 J1.556 E.01445
G3 X126.461 Y127.281 I-.187 J1.698 E.25625
; WIPE_START
M204 S6000
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
M204 S10000
G1 X129.59 Y119.623 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X129.768 Y119.857 E.00942
G3 X125.917 Y121.229 I-1.764 J1.139 E.24328
G3 X127.841 Y118.902 I2.095 J-.226 E.10823
G3 X129.552 Y119.577 I.162 J2.093 E.06121
M204 S250
G1 X129.279 Y119.862 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X127.871 Y119.294 I-1.276 J1.135 E.27278
G3 X128.528 Y119.377 I.103 J1.825 E.01982
G1 X128.642 Y119.413 E.00356
G3 X129.238 Y119.818 I-.639 J1.584 E.02163
; WIPE_START
M204 S6000
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
M204 S10000
G1 X124.317 Y127.215 Z1.4 F42000
G1 X123.02 Y128.583 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X123.012 Y128.636 E.00173
G3 X120.933 Y125.903 I-2.003 J-.633 E.29521
G3 X122.518 Y126.541 I.084 J2.08 E.0566
G3 X123.086 Y128.322 I-1.509 J1.462 E.06228
G1 X123.035 Y128.525 E.00673
M204 S250
G1 X122.638 Y128.494 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X122.637 Y128.517 E.00071
G3 X120.948 Y126.295 I-1.628 J-.516 E.22223
G3 X122.039 Y126.64 I.049 J1.745 E.03472
G3 X122.697 Y128.262 I-1.03 J1.362 E.05475
G1 X122.653 Y128.435 E.00534
; WIPE_START
M204 S6000
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
M204 S10000
G1 X126.729 Y134.998 Z1.4 F42000
G1 X128.757 Y136.961 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X128.481 Y137.047 E.00928
G3 X127.853 Y132.908 I-.472 J-2.046 E.22238
G3 X129.461 Y133.484 I.163 J2.075 E.0566
G3 X128.813 Y136.941 I-1.451 J1.517 E.13407
M204 S250
G1 X128.639 Y136.588 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X128.392 Y136.667 E.00771
G3 X127.883 Y133.299 I-.383 J-1.665 E.16758
G3 X128.986 Y133.601 I.116 J1.742 E.03471
G3 X128.694 Y136.567 I-.977 J1.401 E.10787
; WIPE_START
M204 S6000
G1 X128.392 Y136.667 E-.12083
G1 X128.133 Y136.706 E-.09957
G1 X127.871 Y136.706 E-.0995
G1 X127.612 Y136.666 E-.09954
M73 P56 R6
G1 X127.363 Y136.587 E-.09952
G1 X127.128 Y136.47 E-.0995
G1 X126.914 Y136.32 E-.09952
G1 X126.834 Y136.243 E-.04202
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X132.302 Y130.918 Z1.4 F42000
G1 X136.644 Y126.688 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X136.809 Y126.926 E.0093
G3 X133.052 Y128.773 I-1.803 J1.076 E.22307
G3 X134.773 Y125.915 I1.95 J-.773 E.12405
G3 X136.606 Y126.642 I.232 J2.087 E.066
M204 S250
G1 X136.323 Y126.914 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X136.469 Y127.128 E.00771
G3 X134.818 Y126.304 I-1.467 J.874 E.26162
G3 X135.827 Y126.507 I.184 J1.697 E.03114
G3 X136.283 Y126.873 I-.825 J1.495 E.01749
; WIPE_START
M204 S6000
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
M204 S10000
G1 X131.389 Y123.107 Z1.4 F42000
G1 X127.3 Y118.633 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X128.113 Y118.607 I.712 J9.459 E.02615
G3 X124.052 Y119.473 I-.12 J9.395 E1.76369
G3 X127.241 Y118.638 I3.961 J8.62 E.10654
M204 S250
G1 X127.271 Y118.237 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X128.119 Y118.215 E.02525
G3 X123.363 Y119.379 I-.125 J9.787 E1.68437
G3 X127.214 Y118.245 I4.622 J8.586 E.12044
; WIPE_START
M204 S6000
G1 X128.119 Y118.215 E-.34393
G1 X128.441 Y118.22 E-.12264
G1 X129.026 Y118.264 E-.22261
G1 X129.21 Y118.289 E-.07082
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.4 I1.217 J0 P1  F42000
; stop printing object, unique label id: 78
M625
; object ids of layer 5 start: 78,114
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


; object ids of this layer5 end: 78,114
M625
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X129.091 Y118.874 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.353135
G1 F7736.574
M204 S6000
G1 X129.793 Y119.206 E.01904
M204 S10000
G1 X129.818 Y119.168 F42000
; LINE_WIDTH: 0.177553
G1 F15000
M204 S6000
G1 X129.211 Y118.957 E.00683
; LINE_WIDTH: 0.155808
G1 X129.082 Y118.917 E.0012
; LINE_WIDTH: 0.116544
G1 X128.953 Y118.878 E.00078
; WIPE_START
G1 X129.082 Y118.917 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.042 Y118.883 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.117481
G1 F15000
M204 S6000
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
M204 S10000
G1 X132.879 Y120.833 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X134.131 Y121.869 I-4.453 J6.65 E.05236
G1 X131.325 Y124.675 E.12759
G1 X130.816 Y124.599 E.01654
G1 X130.583 Y123.934 E.02266
G1 X129.882 Y124.006 E.02266
G1 X129.49 Y123.42 E.02265
G1 X129.401 Y123.453 E.00307
G2 X130.308 Y122.632 I-2.664 J-3.859 E.03946
G1 X133.37 Y125.694 E.13922
G3 X134.888 Y125.171 I1.691 J2.448 E.05229
; WIPE_START
G1 X134.045 Y125.335 E-.32637
G1 X133.37 Y125.694 E-.29059
G1 X133.104 Y125.428 E-.14304
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X136.781 Y126.494 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970899
G1 F15000
M204 S6000
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
M204 S10000
G1 X137.121 Y128.959 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.116746
G1 F15000
M204 S6000
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
M204 S10000
G1 X134.888 Y130.829 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X133.37 Y130.306 I.441 J-3.748 E.05204
G1 X130.308 Y133.368 E.13922
G2 X129.401 Y132.547 I-3.57 J3.038 E.03946
G1 X129.49 Y132.58 E.00308
G1 X129.882 Y131.994 E.02266
G1 X130.583 Y132.066 E.02265
G1 X130.816 Y131.401 E.02266
G1 X131.325 Y131.325 E.01654
G1 X134.131 Y134.131 E.12759
G3 X132.879 Y135.168 I-8.811 J-9.362 E.05231
; WIPE_START
G1 X133.609 Y134.615 E-.34806
G1 X134.131 Y134.131 E-.27045
G1 X133.867 Y133.867 E-.14149
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.818 Y136.832 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.177563
G1 F15000
M204 S6000
G1 X129.211 Y137.043 E.00683
; LINE_WIDTH: 0.155831
G1 X129.082 Y137.083 E.0012
; LINE_WIDTH: 0.116556
G1 X128.953 Y137.122 E.00078
M204 S10000
G1 X129.09 Y137.126 F42000
; LINE_WIDTH: 0.353115
G1 F7737.078
M204 S6000
G1 X129.793 Y136.794 E.01904
; WIPE_START
G1 X129.09 Y137.126 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.042 Y137.117 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.11748
G1 F15000
M204 S6000
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
M204 S10000
G1 X123.123 Y135.166 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X121.87 Y134.13 I7.92 J-10.855 E.05231
G1 X124.819 Y131.181 E.13407
G1 X124.933 Y131.711 E.01741
G1 X125.637 Y131.727 E.02265
G1 X125.952 Y132.357 E.02265
G1 X126.638 Y132.198 E.02266
G1 X126.836 Y132.426 E.0097
G2 X125.694 Y133.37 I1.852 J3.401 E.04793
G1 X122.632 Y130.308 E.13926
G3 X121.113 Y130.829 I-1.957 J-3.23 E.05204
; WIPE_START
G1 X121.959 Y130.665 E-.32762
G1 X122.632 Y130.308 E-.28933
G1 X122.898 Y130.574 E-.14304
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X119.223 Y129.506 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970951
G1 F15000
M204 S6000
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
M204 S10000
G1 X118.883 Y127.044 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.117859
G1 F15000
M204 S6000
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
M204 S10000
G1 X121.113 Y125.171 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X122.632 Y125.692 I-.438 J3.751 E.05204
G1 X125.694 Y122.63 E.13926
G2 X126.836 Y123.574 I2.355 J-1.685 E.04817
G1 X126.638 Y123.802 E.0097
G1 X125.952 Y123.643 E.02265
G1 X125.637 Y124.273 E.02265
G1 X124.933 Y124.289 E.02265
G1 X124.819 Y124.819 E.01741
G1 X121.87 Y121.87 E.13408
G2 X120.833 Y123.122 I6.687 J6.6 E.05235
; WIPE_START
G1 X121.87 Y121.87 E-.61786
G1 X122.135 Y122.135 E-.14214
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.296 Y127.109 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383575
G1 F3000;_EXTRUDE_SET_SPEED
M204 S6000
G1 X123.026 Y126.591 E.0157
G2 X121.452 Y125.576 I-2.07 J1.483 E.05162
G1 X120.936 Y125.542 E.01392
G1 X120.369 Y125.618 E.0154
G1 X119.983 Y125.755 E.01103
G3 X119.4 Y126.119 I-3.525 J-4.992 E.01849
G1 X119.219 Y125.998 E.00586
G3 X120.535 Y122.915 I7.956 J1.572 E.09088
G3 X125.759 Y119.254 I7.448 J5.072 E.17545
G1 X125.933 Y119.233 E.00471
G3 X126.086 Y119.444 I-.14 J.263 E.00726
G1 X125.757 Y119.98 E.01692
G2 X125.557 Y121.254 I2.376 J1.027 E.03507
G1 X125.675 Y121.814 E.0154
G1 X125.846 Y122.195 E.01123
G1 X126.148 Y122.615 E.01392
G1 X126.567 Y123.004 E.0154
G2 X127.893 Y123.452 I1.389 J-1.925 E.03821
G1 X128.335 Y123.331 E.01233
G1 X128.555 Y123.393 E.00617
G1 X129.086 Y123.216 E.01505
G2 X130.045 Y119.617 I-1.104 J-2.221 E.11336
G1 X130.198 Y119.264 E.01037
G3 X131.553 Y119.692 I-1.246 J6.298 E.03833
G3 X136.797 Y125.998 I-3.521 J8.262 E.22919
G1 X136.605 Y126.123 E.00616
G1 X136.188 Y125.845 E.01348
G1 X135.667 Y125.625 E.01521
G1 X135.265 Y125.549 E.01101
G1 X134.748 Y125.554 E.01392
G1 X134.188 Y125.673 E.0154
G2 X133.498 Y126.046 I.766 J2.244 E.02122
G1 X133.069 Y126.477 E.01636
G1 X132.929 Y126.69 E.00685
; Slow Down End
M204 S10000
G1 X132.402 Y127.044 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.384845
G1 F7019.095
M204 S6000
G1 X132.712 Y128.226 E.03301
M204 S10000
G1 X132.712 Y127.774 F42000
; LINE_WIDTH: 0.384836
G1 F7019.282
M204 S6000
G1 X132.401 Y128.955 E.03298
M204 S10000
G1 X132.896 Y129.26 F42000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383631
G1 F7044.111
M204 S6000
G1 X133.225 Y129.695 E.01468
G2 X136.151 Y130.17 I1.768 J-1.638 E.08592
G1 X136.611 Y129.889 E.01452
G1 X136.782 Y130.009 E.00562
G3 X136.362 Y131.426 I-6.441 J-1.136 E.03988
G3 X130.534 Y136.668 I-8.368 J-3.443 E.21817
G1 X130.198 Y136.736 E.00925
G1 X130.045 Y136.383 E.01037
G2 X129.086 Y132.784 I-2.062 J-1.378 E.11338
G1 X128.555 Y132.607 E.01505
G1 X128.263 Y132.666 E.00802
G1 X127.893 Y132.548 E.01047
G1 X127.307 Y132.636 E.01595
G2 X125.827 Y133.84 I.738 J2.418 E.05263
G1 X125.639 Y134.322 E.01392
G1 X125.54 Y134.885 E.0154
G2 X126.079 Y136.538 I2.616 J.061 E.04771
G3 X125.922 Y136.767 I-.288 J-.03 E.00779
G3 X122.373 Y135.067 I1.804 J-8.321 E.10689
G3 X119.219 Y130.076 I5.579 J-7.017 E.16192
G3 X119.45 Y129.919 I.304 J.2 E.00771
G1 X119.679 Y130.08 E.00753
G1 X120.145 Y130.305 E.01392
G1 X120.699 Y130.446 E.0154
G2 X123.268 Y128.945 I.309 J-2.419 E.08613
M204 S10000
G1 X123.358 Y128.531 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.450978
G1 F5881.522
M204 S6000
G1 X123.516 Y128 E.01788
G1 X123.357 Y127.469 E.01788
; WIPE_START
G1 X123.516 Y128 E-.37998
G1 X123.358 Y128.531 E-.38002
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.002 Y128.505 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F7058.823
M204 S6000
G1 X124.395 Y128.892 E.01481
G1 X124.412 Y128.956 E.00177
G1 X124.268 Y129.436 E.01346
G1 X124.297 Y129.509 E.00212
G1 X124.73 Y129.761 E.01346
G1 X124.762 Y129.819 E.00177
G1 X124.742 Y130.32 E.01346
G1 X124.789 Y130.383 E.00212
G1 X125.271 Y130.52 E.01346
G1 X125.316 Y130.567 E.00177
G1 X125.422 Y131.057 E.01346
G1 X125.483 Y131.108 E.00212
G1 X125.983 Y131.12 E.01346
G1 X126.039 Y131.155 E.00177
G1 X126.263 Y131.603 E.01346
G1 X126.335 Y131.637 E.00212
G1 X126.823 Y131.524 E.01346
G1 X126.885 Y131.544 E.00177
G1 X127.214 Y131.922 E.01346
G1 X127.291 Y131.937 E.00212
G1 X127.736 Y131.706 E.01346
G1 X127.802 Y131.71 E.00177
G1 X128.214 Y131.995 E.01346
G1 X128.293 Y131.99 E.00212
G1 X128.666 Y131.656 E.01346
G1 X128.731 Y131.644 E.00177
G1 X129.201 Y131.817 E.01346
G1 X129.276 Y131.793 E.00212
G1 X129.554 Y131.376 E.01346
G1 X129.614 Y131.348 E.00177
G1 X130.113 Y131.399 E.01346
G1 X130.179 Y131.357 E.00212
G1 X130.345 Y130.884 E.01346
G1 X130.396 Y130.842 E.00177
G1 X130.892 Y130.767 E.01346
G1 X130.946 Y130.71 E.00212
G1 X130.989 Y130.211 E.01346
G1 X131.028 Y130.157 E.00177
G1 X131.489 Y129.962 E.01346
G1 X131.527 Y129.893 E.00212
G1 X131.445 Y129.398 E.01346
G1 X131.469 Y129.337 E.00177
G1 X131.867 Y129.033 E.01346
G2 X131.849 Y128.87 I-.113 J-.07 E.00475
M204 S10000
G1 X131.763 Y128.398 F42000
G1 F7058.823
M204 S6000
G1 X131.699 Y128.435 E.00198
G1 X131.748 Y128.463 E.00151
M204 S10000
G1 X132.07 Y127.963 F42000
G1 F7058.823
M204 S6000
G1 X132.006 Y128 E.00198
G1 X132.055 Y128.028 E.00151
M204 S10000
M73 P57 R6
G1 X131.784 Y127.565 F42000
G1 F7058.823
M204 S6000
G1 X131.72 Y127.602 E.00198
G1 X131.72 Y127.528 E.00198
G1 X131.763 Y127.528 E.00114
G3 X131.898 Y127 I1.368 J.068 E.01475
G1 X131.469 Y126.663 E.01465
G1 X131.445 Y126.602 E.00177
G1 X131.527 Y126.107 E.01346
G1 X131.489 Y126.038 E.00212
G1 X131.028 Y125.843 E.01346
G1 X130.989 Y125.789 E.00177
G1 X130.946 Y125.29 E.01346
G1 X130.892 Y125.233 E.00212
G1 X130.396 Y125.158 E.01346
G1 X130.345 Y125.116 E.00177
G1 X130.179 Y124.643 E.01346
G1 X130.113 Y124.601 E.00212
G1 X129.614 Y124.652 E.01346
G1 X129.554 Y124.624 E.00177
G1 X129.276 Y124.207 E.01346
G1 X129.201 Y124.183 E.00212
G1 X128.731 Y124.356 E.01346
G1 X128.666 Y124.344 E.00177
G1 X128.293 Y124.01 E.01346
G1 X128.214 Y124.005 E.00212
G1 X127.802 Y124.29 E.01346
G1 X127.736 Y124.294 E.00177
G1 X127.291 Y124.063 E.01346
G1 X127.214 Y124.078 E.00212
G1 X126.885 Y124.456 E.01346
G1 X126.823 Y124.476 E.00177
G1 X126.335 Y124.363 E.01346
G1 X126.263 Y124.397 E.00212
G1 X126.039 Y124.845 E.01346
G1 X125.984 Y124.88 E.00177
G1 X125.483 Y124.892 E.01346
G1 X125.422 Y124.943 E.00212
G1 X125.316 Y125.432 E.01346
G1 X125.271 Y125.48 E.00177
G1 X124.789 Y125.616 E.01346
G1 X124.742 Y125.68 E.00212
G1 X124.762 Y126.181 E.01346
G1 X124.73 Y126.239 E.00177
G1 X124.297 Y126.491 E.01346
G1 X124.268 Y126.564 E.00212
G1 X124.412 Y127.044 E.01346
G1 X124.395 Y127.108 E.00177
G1 X124.045 Y127.453 E.0132
; WIPE_START
G1 X124.395 Y127.108 E-.18673
G1 X124.412 Y127.044 E-.02501
G1 X124.268 Y126.564 E-.19042
G1 X124.297 Y126.491 E-.03002
G1 X124.73 Y126.239 E-.19042
G1 X124.762 Y126.181 E-.02501
G1 X124.75 Y125.886 E-.1124
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X130.911 Y125.845 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S2000
G1 X129.783 Y124.718 E.0475
G1 X128.911 Y124.378
G1 X131.729 Y127.197 E.11873
G1 X131.978 Y127.979
G1 X128.149 Y124.15 E.1613
G1 X127.834 Y124.368
G1 X131.781 Y128.315 E.16629
G1 X131.723 Y128.791
G1 X127.178 Y124.245 E.19148
G1 X126.93 Y124.53
G1 X128.571 Y126.172 E.06914
G1 X127.95 Y126.084
G1 X126.325 Y124.458 E.06847
G1 X126.147 Y124.814
G1 X127.49 Y126.157 E.05657
G1 X127.105 Y126.306
G1 X125.768 Y124.968 E.05635
G1 X125.453 Y125.187
G1 X126.787 Y126.521 E.05618
G1 X126.522 Y126.788
G1 X125.293 Y125.56 E.05175
G1 X124.877 Y125.677
G1 X126.307 Y127.107 E.06024
G1 X126.157 Y127.49
G1 X124.844 Y126.178 E.05528
G1 X124.564 Y126.431
G1 X126.087 Y127.954 E.06415
G1 X126.171 Y128.571
G1 X124.435 Y126.835 E.07313
; WIPE_START
M204 S6000
G1 X125.849 Y128.249 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.828 Y127.428 Z1.4 F42000
G1 Z1
G1 E.8 F1800
G1 F6364.704
M204 S2000
G1 X131.562 Y129.162 E.07306
G1 X131.38 Y129.514
G1 X129.915 Y128.049 E.06172
G1 X129.846 Y128.513
G1 X131.29 Y129.957 E.06081
G1 X130.915 Y130.115
G1 X129.694 Y128.894 E.05144
G1 X129.484 Y129.218
G1 X130.872 Y130.605 E.05845
G1 X130.479 Y130.746
G1 X129.215 Y129.481 E.05328
G1 X128.893 Y129.693
G1 X130.213 Y131.013 E.05559
G1 X129.968 Y131.301
G1 X128.515 Y129.848 E.06121
G1 X128.046 Y129.913
G1 X129.477 Y131.343 E.06027
G1 X129.263 Y131.663
G1 X127.426 Y129.825 E.07741
; WIPE_START
M204 S6000
G1 X128.84 Y131.24 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.638 Y131.571 Z1.4 F42000
G1 Z1
G1 E.8 F1800
G1 F6364.704
M204 S2000
G1 X124.342 Y127.275 E.18094
G1 X124.074 Y127.54
G1 X128.356 Y131.823 E.18041
G1 X127.656 Y131.655
G1 X124.194 Y128.193 E.14582
G1 X124.48 Y129.013
G1 X127.305 Y131.837 E.11897
; WIPE_START
M204 S6000
G1 X125.89 Y130.423 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.971 Y131.037 Z1.4 F42000
G1 Z1
G1 E.8 F1800
G1 F6364.704
M204 S2000
G1 X124.841 Y129.907 E.04758
; WIPE_START
M204 S6000
G1 X125.971 Y131.037 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.457 Y129.857 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.173133
G1 F15000
M204 S6000
G1 X131.314 Y129.58 E.0032
; WIPE_START
G1 X131.457 Y129.857 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.492 Y131.535 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.316998
G1 F8756.645
M204 S6000
G1 X126.401 Y131.408 E.0034
; LINE_WIDTH: 0.279439
G1 F10147.185
G1 X126.309 Y131.28 E.00293
; LINE_WIDTH: 0.24188
G1 F12062.73
G1 X126.217 Y131.153 E.00247
; LINE_WIDTH: 0.200885
G1 F15000
G2 X126.104 Y131.002 I-.718 J.421 E.00236
; LINE_WIDTH: 0.159558
G1 X125.979 Y131.029 E.00118
; WIPE_START
G1 X126.104 Y131.002 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.913 Y129.836 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.146542
G1 F15000
M204 S6000
G2 X124.85 Y129.708 I-.271 J.055 E.00117
; LINE_WIDTH: 0.148155
G1 X124.688 Y129.584 E.0017
; LINE_WIDTH: 0.191074
G1 X124.526 Y129.46 E.00239
; LINE_WIDTH: 0.233992
G1 F12560.722
G1 X124.365 Y129.335 E.00308
; WIPE_START
G1 X124.526 Y129.46 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.272 Y128.005 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.0933345
G1 F15000
M204 S6000
G1 X124.286 Y128.06 E.00022
G1 X124.239 Y128.12 E.0003
; WIPE_START
G1 X124.286 Y128.06 E-.43577
G1 X124.272 Y128.005 E-.32423
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.495 Y126.472 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.105521
G1 F15000
M204 S6000
G2 X124.384 Y126.568 I.147 J.283 E.00073
; LINE_WIDTH: 0.13879
G1 X124.472 Y126.798 E.00187
; WIPE_START
G1 X124.384 Y126.568 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.382 Y129.02 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.123006
G1 F15000
M204 S6000
G3 X126.101 Y128.641 I4.818 J-3.871 E.00299
; WIPE_START
G1 X126.382 Y129.02 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.36 Y129.892 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.179925
G1 F15000
M204 S6000
G1 X127.22 Y129.796 E.00183
; LINE_WIDTH: 0.132714
G1 X127.077 Y129.697 E.00124
; LINE_WIDTH: 0.0984303
G1 X126.983 Y129.621 E.00053
; WIPE_START
G1 X127.077 Y129.697 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.989 Y127.975 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.111452
G1 F15000
M204 S6000
G2 X129.902 Y127.792 I-2.31 J.981 E.0011
M204 S10000
G1 X129.891 Y127.365 F42000
; LINE_WIDTH: 0.193132
G1 F15000
M204 S6000
G1 X129.827 Y127.259 E.00147
; LINE_WIDTH: 0.158658
G1 X129.735 Y127.132 E.00143
; LINE_WIDTH: 0.111661
G1 X129.644 Y127.005 E.00085
M204 S10000
G1 X129.007 Y126.368 F42000
; LINE_WIDTH: 0.104516
G1 F15000
M204 S6000
G1 X128.906 Y126.293 E.00061
; LINE_WIDTH: 0.148267
G2 X128.64 Y126.103 I-2.63 J3.414 E.00272
; WIPE_START
G1 X128.906 Y126.293 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.75 Y124.452 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.14511
G1 F15000
M204 S6000
G1 X127.616 Y124.353 E.00134
; LINE_WIDTH: 0.107149
G1 X127.482 Y124.255 E.00084
; OBJECT_ID: 114
; WIPE_START
G1 X127.616 Y124.353 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S10000
G1 X119.988 Y124.084 Z1.4 F42000
G1 X107.281 Y123.636 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X107.758 Y124.063 E.02057
G1 X108.358 Y123.842 E.02057
G1 X108.713 Y124.373 E.02057
G1 X109.35 Y124.308 E.02057
G1 X109.562 Y124.912 E.02057
G1 X110.194 Y125.007 E.02057
G1 X110.249 Y125.644 E.02057
G1 X110.838 Y125.894 E.02057
G1 X110.733 Y126.525 E.02057
G1 X111.242 Y126.913 E.02057
G1 X110.983 Y127.498 E.02057
G1 X111.379 Y128 E.02057
G1 X110.983 Y128.502 E.02057
G1 X111.242 Y129.087 E.02057
G1 X110.733 Y129.475 E.02057
G1 X110.838 Y130.106 E.02057
G1 X110.249 Y130.356 E.02057
G1 X110.194 Y130.993 E.02057
G1 X109.562 Y131.088 E.02057
G1 X109.35 Y131.692 E.02057
G1 X108.713 Y131.627 E.02057
G1 X108.358 Y132.158 E.02057
G1 X107.758 Y131.937 E.02057
G1 X107.281 Y132.364 E.02057
G1 X106.755 Y132 E.02057
G1 X106.188 Y132.295 E.02057
G1 X105.768 Y131.812 E.02057
G1 X105.145 Y131.956 E.02057
G1 X104.859 Y131.384 E.02057
G1 X104.22 Y131.369 E.02057
G1 X104.085 Y130.744 E.02057
G1 X103.469 Y130.57 E.02057
G1 X103.494 Y129.931 E.02057
G1 X102.941 Y129.61 E.02057
G1 X103.125 Y128.997 E.02057
G1 X102.669 Y128.548 E.02057
G1 X102.999 Y128 E.02057
G1 X102.669 Y127.452 E.02057
G1 X103.125 Y127.003 E.02057
G1 X102.941 Y126.39 E.02057
G1 X103.494 Y126.069 E.02057
G1 X103.469 Y125.43 E.02057
G1 X104.085 Y125.256 E.02057
G1 X104.22 Y124.631 E.02057
G1 X104.859 Y124.616 E.02057
G1 X105.145 Y124.044 E.02057
G1 X105.768 Y124.188 E.02057
G1 X106.188 Y123.705 E.02057
G1 X106.755 Y124 E.02057
G1 X107.232 Y123.67 E.01864
; WIPE_START
G1 X107.758 Y124.063 E-.24934
G1 X108.358 Y123.842 E-.24308
G1 X108.713 Y124.373 E-.24306
G1 X108.777 Y124.367 E-.02452
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.483 Y127.225 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X105.615 Y127.021 E.00723
G3 X106.72 Y126.316 I1.401 J.978 E.04006
G3 X107.203 Y126.301 I.292 J1.556 E.01445
G3 X105.465 Y127.281 I-.187 J1.698 E.25625
; WIPE_START
M204 S6000
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
M204 S10000
G1 X108.595 Y119.623 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X108.772 Y119.857 E.00942
G3 X104.922 Y121.229 I-1.764 J1.139 E.24328
G3 X106.846 Y118.902 I2.095 J-.226 E.10823
G3 X108.556 Y119.577 I.162 J2.093 E.06121
M204 S250
G1 X108.283 Y119.862 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X106.876 Y119.294 I-1.276 J1.135 E.27278
G3 X107.532 Y119.377 I.103 J1.825 E.01982
G1 X107.646 Y119.413 E.00356
G3 X108.243 Y119.818 I-.639 J1.584 E.02163
; WIPE_START
M204 S6000
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
M204 S10000
G1 X103.322 Y127.215 Z1.4 F42000
G1 X102.025 Y128.583 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X102.017 Y128.636 E.00173
G3 X99.938 Y125.903 I-2.003 J-.633 E.29521
G3 X101.523 Y126.541 I.084 J2.08 E.0566
G3 X102.09 Y128.322 I-1.509 J1.462 E.06228
G1 X102.039 Y128.525 E.00673
M204 S250
G1 X101.643 Y128.494 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X101.642 Y128.517 E.00071
G3 X99.953 Y126.295 I-1.628 J-.516 E.22223
G3 X101.044 Y126.64 I.049 J1.745 E.03472
G3 X101.701 Y128.262 I-1.03 J1.362 E.05475
G1 X101.658 Y128.435 E.00534
; WIPE_START
M204 S6000
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
M204 S10000
G1 X105.733 Y134.998 Z1.4 F42000
G1 X107.761 Y136.961 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X107.486 Y137.047 E.00928
G3 X106.858 Y132.908 I-.472 J-2.046 E.22238
G3 X108.466 Y133.484 I.163 J2.075 E.0566
G3 X107.818 Y136.941 I-1.451 J1.517 E.13407
M204 S250
G1 X107.643 Y136.588 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X107.397 Y136.667 E.00771
G3 X106.888 Y133.299 I-.383 J-1.665 E.16758
G3 X107.991 Y133.601 I.116 J1.742 E.03471
G3 X107.699 Y136.567 I-.977 J1.401 E.10787
; WIPE_START
M204 S6000
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
M204 S10000
G1 X111.306 Y130.918 Z1.4 F42000
G1 X115.649 Y126.688 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X115.813 Y126.926 E.0093
G3 X112.057 Y128.773 I-1.803 J1.076 E.22307
G3 X113.778 Y125.915 I1.95 J-.773 E.12405
G3 X115.61 Y126.642 I.232 J2.087 E.066
M204 S250
G1 X115.328 Y126.914 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X115.473 Y127.128 E.00771
G3 X113.823 Y126.304 I-1.467 J.874 E.26162
G3 X114.832 Y126.507 I.184 J1.697 E.03114
G3 X115.287 Y126.873 I-.825 J1.495 E.01749
; WIPE_START
M204 S6000
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
M204 S10000
G1 X110.394 Y123.107 Z1.4 F42000
G1 X106.305 Y118.633 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X107.117 Y118.607 I.712 J9.459 E.02615
G3 X103.056 Y119.473 I-.12 J9.395 E1.76369
G3 X106.245 Y118.638 I3.961 J8.62 E.10654
M204 S250
G1 X106.276 Y118.237 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X107.123 Y118.215 E.02525
G3 X102.368 Y119.379 I-.125 J9.787 E1.68437
G3 X106.219 Y118.245 I4.622 J8.586 E.12044
M204 S10000
G1 X106.047 Y118.883 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.117481
G1 F15000
M204 S6000
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
M204 S10000
G1 X107.958 Y118.878 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.116544
G1 F15000
M204 S6000
G1 X108.087 Y118.917 E.00078
; LINE_WIDTH: 0.155808
G1 X108.216 Y118.957 E.0012
; LINE_WIDTH: 0.177553
G1 X108.822 Y119.168 E.00683
M204 S10000
G1 X108.797 Y119.206 F42000
; LINE_WIDTH: 0.353135
G1 F7736.574
M204 S6000
G1 X108.095 Y118.874 E.01904
; WIPE_START
G1 X108.797 Y119.206 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X111.883 Y120.833 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X113.135 Y121.869 I-4.453 J6.65 E.05236
G1 X110.329 Y124.675 E.12759
G1 X109.821 Y124.599 E.01654
G1 X109.587 Y123.934 E.02266
M73 P58 R6
G1 X108.886 Y124.006 E.02266
G1 X108.495 Y123.42 E.02265
G1 X108.405 Y123.453 E.00307
G2 X109.313 Y122.632 I-2.664 J-3.859 E.03946
G1 X112.374 Y125.694 E.13922
G3 X113.893 Y125.171 I1.691 J2.448 E.05229
; WIPE_START
G1 X113.05 Y125.335 E-.32637
G1 X112.374 Y125.694 E-.29059
G1 X112.108 Y125.428 E-.14304
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X115.786 Y126.494 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970899
G1 F15000
M204 S6000
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
M204 S10000
G1 X116.125 Y128.959 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.116746
G1 F15000
M204 S6000
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
M204 S10000
G1 X113.893 Y130.829 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X112.374 Y130.306 I.441 J-3.748 E.05204
G1 X109.313 Y133.368 E.13922
G2 X108.405 Y132.547 I-3.57 J3.038 E.03946
G1 X108.495 Y132.58 E.00308
G1 X108.886 Y131.994 E.02266
G1 X109.587 Y132.066 E.02265
G1 X109.821 Y131.401 E.02266
G1 X110.329 Y131.325 E.01654
G1 X113.135 Y134.131 E.12759
G3 X111.883 Y135.168 I-8.811 J-9.362 E.05231
; WIPE_START
G1 X112.614 Y134.615 E-.34806
G1 X113.135 Y134.131 E-.27045
G1 X112.872 Y133.867 E-.14149
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.822 Y136.832 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.177563
G1 F15000
M204 S6000
G1 X108.216 Y137.043 E.00683
; LINE_WIDTH: 0.155831
G1 X108.087 Y137.083 E.0012
; LINE_WIDTH: 0.116556
G1 X107.958 Y137.122 E.00078
M204 S10000
G1 X108.095 Y137.126 F42000
; LINE_WIDTH: 0.353115
G1 F7737.078
M204 S6000
G1 X108.797 Y136.794 E.01904
; WIPE_START
G1 X108.095 Y137.126 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.047 Y137.117 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.11748
G1 F15000
M204 S6000
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
M204 S10000
G1 X102.128 Y135.166 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X100.875 Y134.13 I7.92 J-10.855 E.05231
G1 X103.823 Y131.181 E.13407
G1 X103.937 Y131.711 E.01741
G1 X104.641 Y131.727 E.02265
G1 X104.956 Y132.357 E.02265
G1 X105.643 Y132.198 E.02266
G1 X105.84 Y132.426 E.0097
G2 X104.699 Y133.37 I1.852 J3.401 E.04793
G1 X101.636 Y130.308 E.13926
G3 X100.117 Y130.829 I-1.957 J-3.23 E.05204
; WIPE_START
G1 X100.964 Y130.665 E-.32762
G1 X101.636 Y130.308 E-.28933
G1 X101.903 Y130.574 E-.14304
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X98.228 Y129.506 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970951
G1 F15000
M204 S6000
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
M204 S10000
G1 X97.888 Y127.044 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.117859
G1 F15000
M204 S6000
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
M204 S10000
G1 X100.117 Y125.171 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X101.636 Y125.692 I-.438 J3.751 E.05204
G1 X104.699 Y122.63 E.13926
G2 X105.84 Y123.574 I2.355 J-1.685 E.04817
G1 X105.643 Y123.802 E.0097
G1 X104.956 Y123.643 E.02265
G1 X104.641 Y124.273 E.02265
G1 X103.937 Y124.289 E.02265
G1 X103.823 Y124.819 E.01741
G1 X100.875 Y121.87 E.13408
G2 X99.837 Y123.122 I6.687 J6.6 E.05235
; WIPE_START
G1 X100.875 Y121.87 E-.61786
G1 X101.139 Y122.135 E-.14214
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.3 Y127.109 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383575
G1 F3000;_EXTRUDE_SET_SPEED
M204 S6000
G1 X102.031 Y126.591 E.0157
G2 X100.457 Y125.576 I-2.07 J1.483 E.05162
G1 X99.94 Y125.542 E.01392
G1 X99.373 Y125.618 E.0154
G1 X98.987 Y125.755 E.01103
G3 X98.405 Y126.119 I-3.525 J-4.992 E.01849
G1 X98.223 Y125.998 E.00586
G3 X99.539 Y122.915 I7.956 J1.572 E.09088
G3 X104.763 Y119.254 I7.448 J5.072 E.17545
G1 X104.937 Y119.233 E.00471
G3 X105.09 Y119.444 I-.14 J.263 E.00726
G1 X104.761 Y119.98 E.01692
G2 X104.561 Y121.254 I2.376 J1.027 E.03507
G1 X104.68 Y121.814 E.0154
G1 X104.85 Y122.195 E.01123
G1 X105.153 Y122.615 E.01392
G1 X105.572 Y123.004 E.0154
G2 X106.897 Y123.452 I1.389 J-1.925 E.03821
G1 X107.339 Y123.331 E.01233
G1 X107.56 Y123.393 E.00617
G1 X108.09 Y123.216 E.01505
G2 X109.049 Y119.617 I-1.104 J-2.221 E.11336
G1 X109.202 Y119.264 E.01037
G3 X110.558 Y119.692 I-1.246 J6.298 E.03833
G3 X115.802 Y125.998 I-3.521 J8.262 E.22919
G1 X115.609 Y126.123 E.00616
G1 X115.193 Y125.845 E.01348
G1 X114.672 Y125.625 E.01521
G1 X114.27 Y125.549 E.01101
G1 X113.753 Y125.554 E.01392
G1 X113.193 Y125.673 E.0154
G2 X112.502 Y126.046 I.766 J2.244 E.02122
G1 X112.074 Y126.477 E.01636
G1 X111.933 Y126.69 E.00685
; Slow Down End
M204 S10000
G1 X111.406 Y127.044 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.384845
G1 F7019.095
M204 S6000
G1 X111.716 Y128.226 E.03301
M204 S10000
G1 X111.716 Y127.774 F42000
; LINE_WIDTH: 0.384836
G1 F7019.282
M204 S6000
G1 X111.406 Y128.955 E.03298
M204 S10000
G1 X111.9 Y129.26 F42000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.383631
G1 F7044.111
M204 S6000
G1 X112.23 Y129.695 E.01468
G2 X115.155 Y130.17 I1.768 J-1.638 E.08592
G1 X115.616 Y129.889 E.01452
G1 X115.786 Y130.009 E.00562
G3 X115.367 Y131.426 I-6.441 J-1.136 E.03988
G3 X109.539 Y136.668 I-8.368 J-3.443 E.21817
G1 X109.202 Y136.736 E.00925
G1 X109.049 Y136.383 E.01037
G2 X108.09 Y132.784 I-2.062 J-1.378 E.11338
G1 X107.56 Y132.607 E.01505
G1 X107.268 Y132.666 E.00802
G1 X106.897 Y132.548 E.01047
G1 X106.311 Y132.636 E.01595
G2 X104.832 Y133.84 I.738 J2.418 E.05263
G1 X104.643 Y134.322 E.01392
G1 X104.544 Y134.885 E.0154
G2 X105.084 Y136.538 I2.616 J.061 E.04771
G3 X104.927 Y136.767 I-.288 J-.03 E.00779
G3 X101.378 Y135.067 I1.804 J-8.321 E.10689
G3 X98.224 Y130.076 I5.579 J-7.017 E.16192
G3 X98.455 Y129.919 I.304 J.2 E.00771
G1 X98.683 Y130.08 E.00753
G1 X99.149 Y130.305 E.01392
G1 X99.704 Y130.446 E.0154
G2 X102.273 Y128.945 I.309 J-2.419 E.08613
M204 S10000
G1 X102.362 Y128.531 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.450978
G1 F5881.522
M204 S6000
G1 X102.521 Y128 E.01788
G1 X102.362 Y127.469 E.01788
; WIPE_START
G1 X102.521 Y128 E-.37998
G1 X102.362 Y128.531 E-.38002
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.007 Y128.505 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38292
G1 F7058.823
M204 S6000
G1 X103.4 Y128.892 E.01481
G1 X103.416 Y128.956 E.00177
G1 X103.272 Y129.436 E.01346
G1 X103.302 Y129.509 E.00212
G1 X103.735 Y129.761 E.01346
G1 X103.767 Y129.819 E.00177
G1 X103.747 Y130.32 E.01346
G1 X103.793 Y130.383 E.00212
G1 X104.276 Y130.52 E.01346
G1 X104.321 Y130.567 E.00177
G1 X104.426 Y131.057 E.01346
G1 X104.487 Y131.108 E.00212
G1 X104.988 Y131.12 E.01346
G1 X105.044 Y131.155 E.00177
G1 X105.268 Y131.603 E.01346
G1 X105.339 Y131.637 E.00212
G1 X105.827 Y131.524 E.01346
G1 X105.89 Y131.544 E.00177
G1 X106.218 Y131.922 E.01346
G1 X106.296 Y131.937 E.00212
G1 X106.741 Y131.706 E.01346
G1 X106.806 Y131.71 E.00177
G1 X107.218 Y131.995 E.01346
G1 X107.297 Y131.99 E.00212
G1 X107.671 Y131.656 E.01346
G1 X107.735 Y131.644 E.00177
G1 X108.205 Y131.817 E.01346
G1 X108.281 Y131.793 E.00212
G1 X108.559 Y131.376 E.01346
G1 X108.619 Y131.348 E.00177
G1 X109.117 Y131.399 E.01346
G1 X109.184 Y131.357 E.00212
G1 X109.35 Y130.884 E.01346
G1 X109.401 Y130.842 E.00177
G1 X109.896 Y130.767 E.01346
G1 X109.95 Y130.71 E.00212
G1 X109.993 Y130.211 E.01346
G1 X110.032 Y130.157 E.00177
G1 X110.494 Y129.962 E.01346
G1 X110.532 Y129.893 E.00212
G1 X110.449 Y129.398 E.01346
G1 X110.474 Y129.337 E.00177
G1 X110.872 Y129.033 E.01346
G2 X110.853 Y128.87 I-.113 J-.07 E.00475
M204 S10000
G1 X110.767 Y128.398 F42000
G1 F7058.823
M204 S6000
G1 X110.704 Y128.435 E.00198
G1 X110.752 Y128.463 E.00151
M204 S10000
G1 X111.075 Y127.963 F42000
G1 F7058.823
M204 S6000
G1 X111.011 Y128 E.00198
G1 X111.06 Y128.028 E.00151
M204 S10000
G1 X110.789 Y127.565 F42000
G1 F7058.823
M204 S6000
G1 X110.725 Y127.602 E.00198
G1 X110.725 Y127.528 E.00198
G1 X110.767 Y127.528 E.00114
G3 X110.902 Y127 I1.368 J.068 E.01475
G1 X110.474 Y126.663 E.01465
G1 X110.449 Y126.602 E.00177
G1 X110.532 Y126.107 E.01346
G1 X110.494 Y126.038 E.00212
G1 X110.032 Y125.843 E.01346
G1 X109.993 Y125.789 E.00177
G1 X109.95 Y125.29 E.01346
G1 X109.896 Y125.233 E.00212
G1 X109.401 Y125.158 E.01346
G1 X109.35 Y125.116 E.00177
G1 X109.184 Y124.643 E.01346
G1 X109.117 Y124.601 E.00212
G1 X108.619 Y124.652 E.01346
G1 X108.559 Y124.624 E.00177
G1 X108.281 Y124.207 E.01346
G1 X108.205 Y124.183 E.00212
G1 X107.735 Y124.356 E.01346
G1 X107.671 Y124.344 E.00177
G1 X107.297 Y124.01 E.01346
G1 X107.219 Y124.005 E.00212
G1 X106.806 Y124.29 E.01346
G1 X106.741 Y124.294 E.00177
G1 X106.296 Y124.063 E.01346
G1 X106.218 Y124.078 E.00212
G1 X105.89 Y124.456 E.01346
G1 X105.827 Y124.476 E.00177
G1 X105.339 Y124.363 E.01346
G1 X105.268 Y124.397 E.00212
G1 X105.044 Y124.845 E.01346
G1 X104.988 Y124.88 E.00177
G1 X104.487 Y124.892 E.01346
G1 X104.426 Y124.943 E.00212
G1 X104.321 Y125.432 E.01346
G1 X104.276 Y125.48 E.00177
G1 X103.793 Y125.616 E.01346
G1 X103.747 Y125.68 E.00212
G1 X103.767 Y126.181 E.01346
G1 X103.735 Y126.239 E.00177
G1 X103.302 Y126.491 E.01346
G1 X103.272 Y126.564 E.00212
G1 X103.416 Y127.044 E.01346
G1 X103.4 Y127.108 E.00177
G1 X103.049 Y127.453 E.0132
; WIPE_START
G1 X103.4 Y127.108 E-.18673
G1 X103.416 Y127.044 E-.02501
G1 X103.272 Y126.564 E-.19042
G1 X103.302 Y126.491 E-.03002
G1 X103.735 Y126.239 E-.19042
G1 X103.767 Y126.181 E-.02501
G1 X103.755 Y125.886 E-.1124
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.915 Y125.845 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S2000
G1 X108.788 Y124.718 E.0475
G1 X107.915 Y124.378
G1 X110.734 Y127.197 E.11873
G1 X110.983 Y127.979
G1 X107.154 Y124.15 E.1613
G1 X106.838 Y124.368
G1 X110.786 Y128.315 E.16629
G1 X110.728 Y128.791
G1 X106.182 Y124.245 E.19148
G1 X105.935 Y124.53
G1 X107.576 Y126.172 E.06914
G1 X106.954 Y126.084
G1 X105.329 Y124.458 E.06847
G1 X105.151 Y124.814
G1 X106.494 Y126.157 E.05657
G1 X106.11 Y126.306
G1 X104.772 Y124.968 E.05635
G1 X104.458 Y125.187
G1 X105.792 Y126.521 E.05618
G1 X105.526 Y126.788
G1 X104.298 Y125.56 E.05175
G1 X103.882 Y125.677
G1 X105.312 Y127.107 E.06024
G1 X105.161 Y127.49
G1 X103.849 Y126.178 E.05528
G1 X103.569 Y126.431
G1 X105.092 Y127.954 E.06415
G1 X105.176 Y128.571
G1 X103.439 Y126.835 E.07313
; WIPE_START
M204 S6000
G1 X104.854 Y128.249 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.832 Y127.428 Z1.4 F42000
G1 Z1
G1 E.8 F1800
G1 F6364.704
M204 S2000
G1 X110.567 Y129.162 E.07306
G1 X110.385 Y129.514
G1 X108.92 Y128.049 E.06172
G1 X108.851 Y128.513
G1 X110.294 Y129.957 E.06081
G1 X109.92 Y130.115
G1 X108.699 Y128.894 E.05144
G1 X108.489 Y129.218
G1 X109.876 Y130.605 E.05845
G1 X109.484 Y130.746
G1 X108.219 Y129.481 E.05328
G1 X107.898 Y129.693
G1 X109.217 Y131.013 E.05559
G1 X108.973 Y131.301
G1 X107.52 Y129.848 E.06121
G1 X107.051 Y129.913
G1 X108.482 Y131.343 E.06027
G1 X108.268 Y131.663
G1 X106.43 Y129.825 E.07741
; WIPE_START
M204 S6000
G1 X107.844 Y131.24 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.642 Y131.571 Z1.4 F42000
G1 Z1
G1 E.8 F1800
G1 F6364.704
M204 S2000
G1 X103.347 Y127.275 E.18094
G1 X103.078 Y127.54
G1 X107.361 Y131.823 E.18041
G1 X106.66 Y131.655
G1 X103.198 Y128.193 E.14582
G1 X103.485 Y129.013
G1 X106.309 Y131.837 E.11897
; WIPE_START
M204 S6000
G1 X104.895 Y130.423 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.975 Y131.037 Z1.4 F42000
G1 Z1
G1 E.8 F1800
G1 F6364.704
M204 S2000
G1 X103.846 Y129.907 E.04758
; WIPE_START
M204 S6000
G1 X104.975 Y131.037 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.461 Y129.857 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.173133
G1 F15000
M204 S6000
G1 X110.319 Y129.58 E.0032
; WIPE_START
G1 X110.461 Y129.857 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.497 Y131.535 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.316998
G1 F8756.645
M204 S6000
G1 X105.405 Y131.408 E.0034
; LINE_WIDTH: 0.279439
G1 F10147.185
G1 X105.313 Y131.28 E.00293
; LINE_WIDTH: 0.24188
G1 F12062.73
G1 X105.222 Y131.153 E.00247
; LINE_WIDTH: 0.200885
G1 F15000
G2 X105.108 Y131.002 I-.718 J.421 E.00236
; LINE_WIDTH: 0.159558
G1 X104.983 Y131.029 E.00118
; WIPE_START
G1 X105.108 Y131.002 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.917 Y129.836 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.146542
G1 F15000
M204 S6000
G2 X103.854 Y129.708 I-.271 J.055 E.00117
; LINE_WIDTH: 0.148155
G1 X103.692 Y129.584 E.0017
; LINE_WIDTH: 0.191074
G1 X103.531 Y129.46 E.00239
; LINE_WIDTH: 0.233992
G1 F12560.722
G1 X103.369 Y129.335 E.00308
; WIPE_START
G1 X103.531 Y129.46 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.277 Y128.005 Z1.4 F42000
G1 Z1
M73 P59 R6
G1 E.8 F1800
; LINE_WIDTH: 0.0933345
G1 F15000
M204 S6000
G1 X103.29 Y128.06 E.00022
G1 X103.244 Y128.12 E.0003
; WIPE_START
G1 X103.29 Y128.06 E-.43577
G1 X103.277 Y128.005 E-.32423
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.5 Y126.472 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.105521
G1 F15000
M204 S6000
G2 X103.389 Y126.568 I.147 J.283 E.00073
; LINE_WIDTH: 0.13879
G1 X103.476 Y126.798 E.00187
; WIPE_START
G1 X103.389 Y126.568 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.387 Y129.02 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.123006
G1 F15000
M204 S6000
G3 X105.105 Y128.641 I4.818 J-3.871 E.00299
; WIPE_START
G1 X105.387 Y129.02 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.364 Y129.892 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.179925
G1 F15000
M204 S6000
G1 X106.225 Y129.796 E.00183
; LINE_WIDTH: 0.132714
G1 X106.081 Y129.697 E.00124
; LINE_WIDTH: 0.0984303
G1 X105.988 Y129.621 E.00053
; WIPE_START
G1 X106.081 Y129.697 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.994 Y127.975 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.111452
G1 F15000
M204 S6000
G2 X108.907 Y127.792 I-2.31 J.981 E.0011
M204 S10000
G1 X108.896 Y127.365 F42000
; LINE_WIDTH: 0.193132
G1 F15000
M204 S6000
G1 X108.831 Y127.259 E.00147
; LINE_WIDTH: 0.158658
G1 X108.74 Y127.132 E.00143
; LINE_WIDTH: 0.111661
G1 X108.649 Y127.005 E.00085
M204 S10000
G1 X108.011 Y126.368 F42000
; LINE_WIDTH: 0.104516
G1 F15000
M204 S6000
G1 X107.911 Y126.293 E.00061
; LINE_WIDTH: 0.148267
G2 X107.644 Y126.103 I-2.63 J3.414 E.00272
; WIPE_START
G1 X107.911 Y126.293 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.755 Y124.452 Z1.4 F42000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.14511
G1 F15000
M204 S6000
G1 X106.62 Y124.353 E.00134
; LINE_WIDTH: 0.107149
G1 X106.486 Y124.255 E.00084
; CHANGE_LAYER
; Z_HEIGHT: 1.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X106.62 Y124.353 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 114
M625
; layer num/total_layer_count: 6/23
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
M106 S150.45
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z1.4 I-.131 J1.21 P1  F42000
G1 X124.977 Y126.337 Z1.4
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
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
G1 X125.378 Y126.557 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
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
M204 S6000
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18163
G1 X125.92 Y125.482 E-.18164
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02174
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.552 Y119.58 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X129.574 Y119.6 E.00095
G3 X125.92 Y121.252 I-1.569 J1.397 E.25315
G3 X127.841 Y118.902 I2.093 J-.249 E.10897
G3 X129.341 Y119.376 I.164 J2.094 E.05185
G1 X129.509 Y119.538 E.00748
M204 S250
G1 X129.279 Y119.862 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X127.871 Y119.294 I-1.276 J1.135 E.27283
G3 X128.506 Y119.37 I.103 J1.83 E.01914
G1 X128.642 Y119.413 E.00424
G3 X129.238 Y119.818 I-.639 J1.584 E.02164
; WIPE_START
M204 S6000
G1 X129.438 Y120.07 E-.1222
G1 X129.563 Y120.3 E-.09952
G1 X129.652 Y120.547 E-.09954
G1 X129.702 Y120.804 E-.09951
G1 X129.712 Y121.065 E-.09949
G1 X129.682 Y121.326 E-.09955
G1 X129.612 Y121.578 E-.09951
G1 X129.568 Y121.676 E-.04069
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.796 Y126.088 Z1.6 F42000
G1 X136.646 Y126.69 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X136.808 Y126.926 E.00921
G3 X133.052 Y127.226 I-1.804 J1.076 E.2741
G3 X134.75 Y125.917 I1.922 J.737 E.07251
G3 X136.607 Y126.645 I.254 J2.085 E.06681
M204 S250
G1 X136.325 Y126.916 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X136.398 Y127.004 E.00341
G3 X134.795 Y126.307 I-1.387 J.997 E.26504
G3 X135.702 Y126.439 I.223 J1.649 E.02765
G3 X136.29 Y126.869 I-.691 J1.562 E.02187
; WIPE_START
M204 S6000
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
M204 S10000
G1 X131.291 Y134.283 Z1.6 F42000
G1 X128.754 Y136.962 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X128.648 Y137.004 E.00363
G3 X127.83 Y132.909 I-.639 J-2.001 E.22735
G3 X129.461 Y133.484 I.186 J2.074 E.05734
G3 X128.811 Y136.944 I-1.452 J1.518 E.13424
M204 S250
G1 X128.635 Y136.589 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X128.53 Y136.629 E.00336
G3 X127.86 Y133.3 I-.519 J-1.628 E.17103
G3 X128.761 Y133.467 I.159 J1.657 E.02765
G3 X128.691 Y136.569 I-.75 J1.535 E.1159
; WIPE_START
M204 S6000
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
M204 S10000
G1 X123.443 Y129.402 Z1.6 F42000
G1 X123.025 Y128.56 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X123.011 Y128.636 E.00247
G3 X120.91 Y125.904 I-2.002 J-.634 E.29431
G3 X122.518 Y126.541 I.084 J2.135 E.05725
G3 X123.085 Y128.322 I-1.509 J1.461 E.06227
G1 X123.04 Y128.502 E.00598
M204 S250
G1 X122.644 Y128.471 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X122.64 Y128.518 E.00141
G3 X120.925 Y126.296 I-1.628 J-.516 E.2216
G3 X121.819 Y126.497 I.096 J1.661 E.02765
G3 X122.7 Y128.262 I-.808 J1.505 E.06263
G1 X122.659 Y128.413 E.00465
; WIPE_START
M204 S6000
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
M204 S10000
G1 X124.924 Y122.986 Z1.6 F42000
G1 X127.3 Y118.631 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X128.173 Y118.608 I.684 J9.326 E.02807
G3 X124.052 Y119.473 I-.18 J9.394 E1.76172
G3 X127.24 Y118.636 I3.932 J8.484 E.10657
M204 S250
G1 X127.271 Y118.237 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X127.856 Y118.215 E.01743
G3 X128.179 Y118.216 I.145 J9.786 E.00961
G3 X137.174 Y124.59 I-.177 J9.784 E.34884
G3 X127.215 Y118.246 I-9.173 J3.412 E1.45424
; WIPE_START
M204 S6000
G1 X127.856 Y118.215 E-.24364
G1 X128.179 Y118.216 E-.1226
G1 X129.026 Y118.264 E-.32239
G1 X129.212 Y118.289 E-.07137
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.6 I1.217 J0 P1  F42000
; stop printing object, unique label id: 78
M625
; object ids of layer 6 start: 78,114
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


; object ids of this layer6 end: 78,114
M625
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X129.091 Y118.874 F42000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.353121
G1 F7736.924
M204 S6000
G1 X129.793 Y119.206 E.01903
M204 S10000
G1 X129.818 Y119.168 F42000
; LINE_WIDTH: 0.177556
G1 F15000
M204 S6000
G1 X129.211 Y118.957 E.00683
; LINE_WIDTH: 0.155821
G1 X129.082 Y118.917 E.0012
; LINE_WIDTH: 0.116549
G1 X128.953 Y118.878 E.00078
; WIPE_START
G1 X129.082 Y118.917 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X130.361 Y119.08 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.40129
; LAYER_HEIGHT: 0.4
M106 S229.5
G1 F3000
M204 S6000
G1 X130.179 Y119.268 E.01304
G1 X130.05 Y119.601 E.01783
G1 X130.206 Y119.888 E.01635
G1 X130.693 Y119.386 E.03492
G3 X131.165 Y119.547 I-1.111 J4.022 E.02494
G1 X130.389 Y120.348 E.05568
G3 X130.468 Y120.915 I-2.871 J.689 E.02864
G1 X131.617 Y119.729 E.08245
G3 X132.05 Y119.931 I-1.474 J3.737 E.02388
G1 X130.028 Y122.017 E.14512
M106 S150.45
; WIPE_START
G1 X131.42 Y120.581 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.042 Y118.883 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.117481
; LAYER_HEIGHT: 0.2
G1 F15000
M204 S6000
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
M204 S10000
G1 X126.181 Y119.082 F42000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.38292
G1 F7058.823
M204 S6000
G1 X126.16 Y119.119 E.00114
G1 X126.096 Y119.082 E.00198
G1 X126.108 Y119.075 E.00037
; WIPE_START
G1 X126.096 Y119.082 E-.07974
G1 X126.16 Y119.119 E-.43126
G1 X126.181 Y119.082 E-.249
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X122.85 Y120.346 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.40129
; LAYER_HEIGHT: 0.4
M106 S229.5
G1 F3000
M204 S6000
G1 X121.544 Y121.694 E.09374
G2 X119.889 Y124.05 I6.32 J6.198 E.14447
G1 X123.803 Y120.011 E.28097
G3 X124.902 Y119.525 I4.355 J8.373 E.06004
G1 X119.445 Y125.157 E.39171
G2 X119.254 Y125.817 I4.033 J1.523 E.03439
G1 X119.225 Y125.939 E.00626
G1 X119.268 Y125.988 E.00322
G1 X125.8 Y119.247 E.46889
G1 X125.87 Y119.231 E.00357
G1 X126.049 Y119.492 E.01582
G2 X125.876 Y119.744 I.731 J.686 E.01534
M73 P60 R6
G1 X125.787 Y119.909 E.00937
G1 X120.212 Y125.662 E.40018
G3 X120.896 Y125.535 I.794 J2.363 E.03489
G1 X120.966 Y125.532 E.0035
G1 X125.54 Y120.812 E.32833
G2 X125.552 Y121.294 I1.569 J.202 E.02418
G1 X125.568 Y121.432 E.00691
G1 X121.54 Y125.589 E.28918
G3 X122.013 Y125.749 I-.7 J2.847 E.02498
G1 X125.715 Y121.929 E.26572
G2 X125.936 Y122.349 I2.202 J-.893 E.02376
G1 X122.419 Y125.978 E.25244
G3 X122.638 Y126.153 I-.457 J.797 E.01405
G1 X122.767 Y126.268 E.00862
G1 X126.218 Y122.707 E.24772
G2 X126.556 Y123.006 I1.138 J-.945 E.02266
G1 X123.053 Y126.621 E.25148
G3 X123.276 Y127.04 I-1.244 J.93 E.02378
G1 X126.958 Y123.24 E.26436
G2 X127.431 Y123.4 I.756 J-1.447 E.02503
G1 X126.599 Y124.259 E.05972
G1 X126.802 Y124.306 E.0104
G1 X127.208 Y123.838 E.03097
G1 X127.493 Y123.985 E.01601
G1 X127.988 Y123.474 E.0356
G1 X128.194 Y123.489 E.01027
G1 X128.721 Y123.366 E.02708
G1 X128.301 Y123.8 E.0302
G1 X128.637 Y124.101 E.02256
G1 X132.463 Y120.153 E.27463
G3 X132.859 Y120.393 I-1.804 J3.417 E.02313
G1 X129.345 Y124.019 E.25223
G1 X129.601 Y124.403 E.02306
G1 X133.238 Y120.65 E.26105
G3 X133.602 Y120.924 I-2.096 J3.169 E.02273
G1 X130.205 Y124.429 E.24385
G1 X130.273 Y124.422 E.00342
G1 X130.424 Y124.852 E.02274
G1 X133.95 Y121.213 E.25313
G3 X134.283 Y121.517 I-2.38 J2.936 E.02257
G1 X130.848 Y125.063 E.2466
G1 X131.091 Y125.099 E.01231
G1 X131.12 Y125.43 E.01659
G1 X134.6 Y121.839 E.2498
G3 X134.899 Y122.179 I-2.699 J2.678 E.02263
G1 X131.376 Y125.815 E.25291
G1 X131.716 Y125.959 E.01844
G1 X131.685 Y126.144 E.00941
G1 X135.183 Y122.534 E.2511
G3 X135.451 Y122.906 I-2.974 J2.427 E.02291
G1 X131.779 Y126.696 E.2636
G1 X132.106 Y126.946 E.02061
G1 X132.058 Y127.056 E.006
G1 X135.703 Y123.295 E.26163
G3 X135.938 Y123.701 I-7.341 J4.519 E.02344
G1 X132.22 Y127.538 E.2669
M106 S150.45
M204 S10000
G1 X132.351 Y127.938 F42000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.61688
; LAYER_HEIGHT: 0.2
G1 F4181.476
M204 S6000
G2 X132.357 Y128.052 I-.032 J.059 E.0129
M204 S10000
G1 X132.698 Y128.341 F42000
; FEATURE: Bridge
; LINE_WIDTH: 0.40129
; LAYER_HEIGHT: 0.4
M106 S229.5
G1 F3000
M204 S6000
G1 X131.443 Y129.636 E.09009
M106 S150.45
; WIPE_START
G1 X132.698 Y128.341 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X134.558 Y125.773 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
M106 S229.5
G1 F3000
M204 S6000
G1 X136.155 Y124.125 E.11463
G1 X136.353 Y124.57 E.0243
G1 X135.391 Y125.562 E.06903
G3 X135.675 Y125.62 I-.032 J.88 E.01456
G1 X135.889 Y125.697 E.01133
G1 X136.528 Y125.037 E.04591
G3 X136.682 Y125.526 I-4.006 J1.53 E.02565
G1 X136.169 Y126.056 E.03687
M106 S150.45
M204 S10000
G1 X136.781 Y126.494 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0971076
; LAYER_HEIGHT: 0.2
G1 F15000
M204 S6000
G1 X136.805 Y126.516 E.00014
; LINE_WIDTH: 0.122858
G1 X136.918 Y126.633 E.00102
; LINE_WIDTH: 0.17235
G1 X137.03 Y126.749 E.00166
; LINE_WIDTH: 0.188872
G1 X137.042 Y126.781 E.00039
; LINE_WIDTH: 0.158063
G1 X137.083 Y126.916 E.00129
; LINE_WIDTH: 0.116755
G1 X137.121 Y127.041 E.00076
; WIPE_START
G1 X137.083 Y126.916 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.121 Y128.958 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.11675
G1 F15000
M204 S6000
G1 X137.083 Y129.084 E.00076
; LINE_WIDTH: 0.158079
G1 X137.042 Y129.219 E.00129
; LINE_WIDTH: 0.188901
G1 X137.03 Y129.251 E.00039
; LINE_WIDTH: 0.172377
G1 X136.918 Y129.367 E.00166
; LINE_WIDTH: 0.122861
G1 X136.805 Y129.484 E.00102
; LINE_WIDTH: 0.0970978
G1 X136.781 Y129.506 E.00014
; WIPE_START
G1 X136.805 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X133.142 Y135.665 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.40129
; LAYER_HEIGHT: 0.4
M106 S229.5
G1 F3000
M204 S6000
G1 X134.628 Y134.131 E.1067
G2 X136.125 Y131.938 I-7.543 J-6.756 E.13302
G1 X132.2 Y135.988 E.28176
G3 X131.095 Y136.48 I-4.481 J-8.584 E.06044
G1 X136.574 Y130.827 E.39325
G2 X136.787 Y130.063 I-8.393 J-2.761 E.03961
G1 X136.735 Y130.011 E.00367
G1 X130.188 Y136.755 E.46954
G1 X130.05 Y136.4 E.01907
G1 X130.221 Y136.086 E.01785
G1 X135.789 Y130.339 E.39973
G3 X135.036 Y130.468 I-.797 J-2.392 E.03832
G1 X130.464 Y135.185 E.32816
G1 X130.469 Y135.067 E.00593
G2 X130.436 Y134.566 I-1.636 J-.144 E.02516
G1 X134.463 Y130.411 E.28907
G3 X133.99 Y130.25 I.283 J-1.61 E.02505
G1 X130.289 Y134.069 E.26566
G2 X130.067 Y133.65 I-1.469 J.508 E.0238
G1 X133.584 Y130.021 E.25241
G3 X133.236 Y129.731 I1.15 J-1.732 E.02265
G1 X129.785 Y133.292 E.24771
G2 X129.447 Y132.993 I-1.138 J.947 E.02266
G1 X132.951 Y129.377 E.25151
G3 X132.728 Y128.958 I1.504 J-1.067 E.02376
G1 X129.044 Y132.76 E.26443
G2 X128.572 Y132.599 I-.757 J1.452 E.02504
G1 X129.173 Y131.979 E.04315
G1 X128.73 Y131.816 E.02357
G2 X128.016 Y132.524 I4.649 J5.399 E.05031
G1 X127.79 Y132.542 E.01132
G2 X127.28 Y132.635 I.215 J2.615 E.02592
G1 X127.912 Y131.983 E.04536
G1 X127.758 Y131.877 E.00933
G1 X127.208 Y132.162 E.03096
G1 X127.162 Y132.109 E.00355
G1 X123.542 Y135.844 E.25985
G3 X123.144 Y135.606 I1.793 J-3.435 E.02316
G1 X126.865 Y131.767 E.26705
G1 X126.802 Y131.694 E.00479
G1 X126.198 Y131.834 E.03097
G1 X126.189 Y131.816 E.00103
G1 X122.763 Y135.35 E.24588
G1 X122.399 Y135.078 E.02272
G1 X125.975 Y131.388 E.25666
G1 X125.921 Y131.28 E.00604
G1 X125.462 Y131.269 E.02294
G1 X122.053 Y134.787 E.2447
G3 X121.722 Y134.48 I2.401 J-2.924 E.02256
G1 X125.217 Y130.873 E.25088
G1 X125.171 Y130.659 E.01094
G1 X124.876 Y130.576 E.01527
G1 X121.406 Y134.157 E.24913
G1 X121.39 Y134.14 E.00117
G3 X121.105 Y133.82 I2.534 J-2.538 E.02145
G1 X124.584 Y130.229 E.24977
G1 X124.598 Y129.871 E.01788
G1 X124.409 Y129.761 E.01094
G1 X120.819 Y133.466 E.25768
G1 X120.55 Y133.095 E.02288
G1 X124.101 Y129.431 E.2549
G1 X124.24 Y128.966 E.02423
G1 X124.078 Y128.806 E.01137
G1 X120.3 Y132.705 E.27118
G3 X120.067 Y132.297 I3.945 J-2.529 E.02348
G1 X123.897 Y128.344 E.27496
M106 S150.45
M204 S10000
G1 X123.259 Y127.705 F42000
M106 S229.5
G1 F3000
M204 S6000
G1 X124.324 Y126.607 E.0764
M106 S150.45
; WIPE_START
G1 X123.259 Y127.705 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X119.223 Y126.494 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970827
; LAYER_HEIGHT: 0.2
G1 F15000
M204 S6000
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
M204 S10000
G1 X118.883 Y128.956 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.117871
G1 F15000
M204 S6000
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
M204 S10000
G1 X119.129 Y129.866 F42000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.38292
G1 F7058.823
M204 S6000
G1 X119.108 Y129.903 E.00114
G1 X119.044 Y129.866 E.00198
G1 X119.056 Y129.859 E.00037
M204 S10000
G1 X119.159 Y130.639 F42000
; FEATURE: Bridge
; LINE_WIDTH: 0.40129
; LAYER_HEIGHT: 0.4
M106 S229.5
G1 F3000
M204 S6000
G1 X119.688 Y130.094 E.03793
G2 X120.114 Y130.303 I.89 J-1.277 E.0238
G1 X119.477 Y130.959 E.04568
G2 X119.654 Y131.426 I3.98 J-1.241 E.02492
G1 X120.612 Y130.438 E.06873
G2 X121.22 Y130.459 I.385 J-2.319 E.03047
G1 X119.701 Y132.026 E.10902
M106 S150.45
; WIPE_START
G1 X121.093 Y130.59 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.978 Y133.979 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
M106 S229.5
G1 F3000
M204 S6000
G1 X123.956 Y136.066 E.14517
G2 X124.39 Y136.265 I1.491 J-2.671 E.02393
G1 X125.536 Y135.083 E.08225
G2 X125.615 Y135.65 I1.877 J.028 E.02872
G1 X124.842 Y136.448 E.05552
G2 X125.249 Y136.585 I1.057 J-2.477 E.02151
G1 X125.317 Y136.606 E.00353
G1 X125.797 Y136.11 E.0345
G2 X126.045 Y136.503 I1.973 J-.972 E.02324
G1 X125.641 Y136.921 E.02907
M106 S150.45
M204 S10000
G1 X126.192 Y136.912 F42000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.38292
; LAYER_HEIGHT: 0.2
G1 F7058.823
M204 S6000
G1 X126.17 Y136.949 E.00114
G1 X126.107 Y136.912 E.00198
G1 X126.118 Y136.905 E.00037
M204 S10000
G1 X126.496 Y136.779 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970879
G1 F15000
M204 S6000
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
M204 S10000
G1 X128.953 Y137.122 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.116547
G1 F15000
M204 S6000
G1 X129.082 Y137.083 E.00078
; LINE_WIDTH: 0.155813
G1 X129.211 Y137.043 E.0012
; LINE_WIDTH: 0.177556
G1 X129.818 Y136.832 E.00683
M204 S10000
G1 X129.793 Y136.794 F42000
; LINE_WIDTH: 0.353121
G1 F7736.922
M204 S6000
G1 X129.091 Y137.126 E.01903
; OBJECT_ID: 114
; WIPE_START
G1 X129.793 Y136.794 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S10000
G1 X122.719 Y133.928 Z1.6 F42000
G1 X103.981 Y126.337 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
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
M73 P61 R6
G1 X103.27 Y128.472 E.01772
G1 X103.554 Y128 E.01772
G1 X103.27 Y127.528 E.01772
G1 X103.662 Y127.141 E.01772
G1 X103.505 Y126.613 E.01772
G1 X103.929 Y126.367 E.01579
M204 S250
G1 X104.382 Y126.557 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
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
M73 P61 R5
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
M204 S6000
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18163
G1 X104.924 Y125.482 E-.18164
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02174
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.556 Y119.58 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X108.578 Y119.6 E.00095
G3 X104.924 Y121.252 I-1.569 J1.397 E.25315
G3 X106.846 Y118.902 I2.093 J-.249 E.10897
G3 X108.346 Y119.376 I.164 J2.094 E.05185
G1 X108.513 Y119.538 E.00748
M204 S250
G1 X108.283 Y119.862 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X106.876 Y119.294 I-1.276 J1.135 E.27283
G3 X107.51 Y119.37 I.103 J1.83 E.01914
G1 X107.646 Y119.413 E.00424
G3 X108.243 Y119.818 I-.639 J1.584 E.02164
; WIPE_START
M204 S6000
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
M204 S10000
G1 X114.801 Y126.088 Z1.6 F42000
G1 X115.65 Y126.69 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X115.813 Y126.926 E.00921
G3 X112.057 Y127.226 I-1.804 J1.076 E.2741
G3 X113.755 Y125.917 I1.922 J.737 E.07251
G3 X115.611 Y126.645 I.254 J2.085 E.06681
M204 S250
G1 X115.33 Y126.916 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X115.403 Y127.004 E.00341
G3 X113.8 Y126.307 I-1.387 J.997 E.26504
G3 X114.706 Y126.439 I.223 J1.649 E.02765
G3 X115.295 Y126.869 I-.691 J1.562 E.02187
; WIPE_START
M204 S6000
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
M204 S10000
G1 X110.295 Y134.283 Z1.6 F42000
G1 X107.758 Y136.962 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X107.653 Y137.004 E.00363
G3 X106.835 Y132.909 I-.639 J-2.001 E.22735
G3 X108.466 Y133.484 I.186 J2.074 E.05734
G3 X107.815 Y136.944 I-1.452 J1.518 E.13424
M204 S250
G1 X107.64 Y136.589 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X107.534 Y136.629 E.00336
G3 X106.865 Y133.3 I-.519 J-1.628 E.17103
G3 X107.766 Y133.467 I.159 J1.657 E.02765
G3 X107.696 Y136.569 I-.75 J1.535 E.1159
; WIPE_START
M204 S6000
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
M204 S10000
G1 X102.447 Y129.402 Z1.6 F42000
G1 X102.03 Y128.56 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X102.016 Y128.636 E.00247
G3 X99.915 Y125.904 I-2.002 J-.634 E.29431
G3 X101.523 Y126.541 I.084 J2.135 E.05725
G3 X102.089 Y128.322 I-1.509 J1.461 E.06227
G1 X102.044 Y128.502 E.00598
M204 S250
G1 X101.648 Y128.471 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X101.644 Y128.518 E.00141
G3 X99.93 Y126.296 I-1.628 J-.516 E.2216
G3 X100.824 Y126.497 I.096 J1.661 E.02765
G3 X101.704 Y128.262 I-.808 J1.505 E.06263
G1 X101.664 Y128.413 E.00465
; WIPE_START
M204 S6000
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
M204 S10000
G1 X103.929 Y122.986 Z1.6 F42000
G1 X106.305 Y118.631 Z1.6
G1 Z1.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X107.177 Y118.608 I.684 J9.326 E.02807
G3 X103.056 Y119.473 I-.18 J9.394 E1.76172
G3 X106.245 Y118.636 I3.932 J8.484 E.10657
M204 S250
G1 X106.275 Y118.237 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X106.86 Y118.215 E.01743
G3 X107.183 Y118.216 I.145 J9.786 E.00961
G3 X116.179 Y124.59 I-.177 J9.784 E.34884
G3 X106.22 Y118.246 I-9.173 J3.412 E1.45424
M204 S10000
G1 X106.047 Y118.883 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.117481
G1 F15000
M204 S6000
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
M204 S10000
G1 X105.186 Y119.082 F42000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.38292
G1 F7058.823
M204 S6000
G1 X105.164 Y119.119 E.00114
G1 X105.101 Y119.082 E.00198
G1 X105.112 Y119.075 E.00037
; WIPE_START
G1 X105.101 Y119.082 E-.07974
G1 X105.164 Y119.119 E-.43126
G1 X105.186 Y119.082 E-.249
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.958 Y118.878 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.116549
G1 F15000
M204 S6000
G1 X108.087 Y118.917 E.00078
; LINE_WIDTH: 0.155821
G1 X108.216 Y118.957 E.0012
; LINE_WIDTH: 0.177556
G1 X108.822 Y119.168 E.00683
M204 S10000
G1 X108.797 Y119.206 F42000
; LINE_WIDTH: 0.353121
G1 F7736.924
M204 S6000
G1 X108.095 Y118.874 E.01903
; WIPE_START
G1 X108.797 Y119.206 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.365 Y119.08 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.40129
; LAYER_HEIGHT: 0.4
M106 S229.5
G1 F3000
M204 S6000
G1 X109.183 Y119.268 E.01304
G1 X109.054 Y119.601 E.01783
G1 X109.211 Y119.888 E.01635
G1 X109.697 Y119.386 E.03492
G3 X110.169 Y119.547 I-1.111 J4.022 E.02494
G1 X109.394 Y120.348 E.05568
G3 X109.473 Y120.915 I-2.871 J.689 E.02864
G1 X110.621 Y119.729 E.08245
G3 X111.054 Y119.931 I-1.474 J3.737 E.02388
G1 X109.033 Y122.017 E.14512
M106 S150.45
; WIPE_START
G1 X110.425 Y120.581 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X113.562 Y125.773 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
M106 S229.5
G1 F3000
M204 S6000
G1 X115.159 Y124.125 E.11463
G1 X115.357 Y124.57 E.0243
G1 X114.396 Y125.562 E.06903
G3 X114.68 Y125.62 I-.032 J.88 E.01456
G1 X114.893 Y125.697 E.01133
G1 X115.533 Y125.037 E.04591
G3 X115.687 Y125.526 I-4.006 J1.53 E.02565
G1 X115.173 Y126.056 E.03687
M106 S150.45
M204 S10000
G1 X115.786 Y126.494 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0971076
; LAYER_HEIGHT: 0.2
G1 F15000
M204 S6000
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
M204 S10000
G1 X116.125 Y128.958 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.11675
G1 F15000
M204 S6000
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
M204 S10000
G1 X111.702 Y128.341 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.40129
; LAYER_HEIGHT: 0.4
M106 S229.5
G1 F3000
M204 S6000
G1 X110.447 Y129.636 E.09009
M106 S150.45
; WIPE_START
G1 X111.702 Y128.341 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X111.355 Y127.938 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.61688
; LAYER_HEIGHT: 0.2
G1 F4181.476
M204 S6000
G2 X111.361 Y128.052 I-.032 J.059 E.0129
M204 S10000
G1 X111.224 Y127.538 F42000
; FEATURE: Bridge
; LINE_WIDTH: 0.40129
; LAYER_HEIGHT: 0.4
M106 S229.5
G1 F3000
M204 S6000
G1 X114.942 Y123.701 E.2669
G2 X114.707 Y123.295 I-7.576 J4.113 E.02344
G1 X111.062 Y127.056 E.26163
G1 X111.111 Y126.946 E.006
G1 X110.783 Y126.696 E.02061
G1 X114.455 Y122.906 E.2636
G2 X114.187 Y122.534 I-3.242 J2.055 E.02291
G1 X110.689 Y126.144 E.2511
G1 X110.72 Y125.959 E.00941
G1 X110.38 Y125.815 E.01844
G1 X113.903 Y122.179 E.25291
G2 X113.604 Y121.839 I-2.998 J2.338 E.02263
G1 X110.124 Y125.43 E.2498
G1 X110.096 Y125.099 E.01659
G1 X109.852 Y125.063 E.01231
G1 X113.288 Y121.517 E.2466
G2 X112.954 Y121.213 I-2.713 J2.631 E.02257
G1 X109.428 Y124.852 E.25313
G1 X109.277 Y124.422 E.02274
G1 X109.209 Y124.429 E.00342
G1 X112.606 Y120.924 E.24385
G2 X112.242 Y120.65 I-2.46 J2.895 E.02273
G1 X108.606 Y124.403 E.26105
G1 X108.349 Y124.019 E.02306
G1 X111.863 Y120.393 E.25223
G2 X111.468 Y120.153 I-2.2 J3.177 E.02313
G1 X107.642 Y124.101 E.27463
G1 X107.305 Y123.8 E.02256
G1 X107.726 Y123.366 E.0302
G1 X107.198 Y123.489 E.02708
G1 X106.993 Y123.474 E.01027
G1 X106.497 Y123.985 E.0356
G1 X106.213 Y123.838 E.01601
G1 X105.806 Y124.306 E.03097
G1 X105.604 Y124.259 E.0104
G1 X106.435 Y123.4 E.05972
G3 X105.963 Y123.24 I.284 J-1.608 E.02503
G1 X102.28 Y127.04 E.26436
G2 X102.058 Y126.621 I-1.467 J.511 E.02378
G1 X105.561 Y123.006 E.25148
G3 X105.223 Y122.707 I.799 J-1.245 E.02266
G1 X101.772 Y126.268 E.24772
G1 X101.643 Y126.153 E.00862
G2 X101.424 Y125.978 I-.676 J.622 E.01405
G1 X104.941 Y122.349 E.25244
G3 X104.719 Y121.929 I1.98 J-1.313 E.02376
G1 X101.017 Y125.749 E.26572
G2 X100.544 Y125.589 I-1.173 J2.686 E.02498
G1 X104.573 Y121.432 E.28918
G1 X104.557 Y121.294 E.00691
G3 X104.545 Y120.812 I1.556 J-.28 E.02418
G1 X99.971 Y125.532 E.32833
G1 X99.901 Y125.535 E.0035
G2 X99.216 Y125.662 I.109 J2.49 E.03489
G1 X104.791 Y119.909 E.40018
G1 X104.881 Y119.744 E.00937
G3 X105.054 Y119.492 I.903 J.433 E.01534
G1 X104.874 Y119.231 E.01582
G1 X104.805 Y119.247 E.00357
G1 X98.273 Y125.988 E.46889
G1 X98.23 Y125.939 E.00322
G1 X98.258 Y125.817 E.00626
G3 X98.449 Y125.157 I4.224 J.862 E.03439
G1 X103.906 Y119.525 E.39171
G2 X102.808 Y120.011 I3.256 J8.858 E.06004
G1 X98.893 Y124.05 E.28097
G3 X100.548 Y121.694 I7.975 J3.842 E.14447
G1 X101.854 Y120.346 E.09374
M106 S150.45
; WIPE_START
G1 X100.548 Y121.694 E-.71306
G1 X100.464 Y121.784 E-.04694
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.328 Y126.607 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
M106 S229.5
G1 F3000
M204 S6000
G1 X102.264 Y127.705 E.0764
M106 S150.45
M204 S10000
G1 X102.902 Y128.344 F42000
M106 S229.5
G1 F3000
M204 S6000
G1 X99.071 Y132.297 E.27496
G2 X99.304 Y132.705 I4.178 J-2.121 E.02348
G1 X103.082 Y128.806 E.27118
G1 X103.244 Y128.966 E.01137
G1 X103.106 Y129.431 E.02423
G1 X99.555 Y133.095 E.2549
G1 X99.824 Y133.466 E.02288
G1 X103.414 Y129.761 E.25768
G1 X103.603 Y129.871 E.01094
G1 X103.589 Y130.229 E.01788
G1 X100.109 Y133.82 E.24977
G2 X100.394 Y134.14 I2.819 J-2.217 E.02145
G1 X100.41 Y134.157 E.00117
G1 X103.881 Y130.576 E.24913
G1 X104.175 Y130.659 E.01527
G1 X104.221 Y130.873 E.01094
G1 X100.726 Y134.48 E.25088
G2 X101.058 Y134.787 I2.732 J-2.618 E.02256
G1 X104.466 Y131.269 E.2447
G1 X104.925 Y131.28 E.02294
M73 P62 R5
G1 X104.979 Y131.388 E.00604
G1 X101.404 Y135.078 E.25666
G1 X101.768 Y135.35 E.02272
G1 X105.193 Y131.816 E.24588
G1 X105.203 Y131.834 E.00103
G1 X105.806 Y131.694 E.03097
G1 X105.869 Y131.767 E.00479
G1 X102.149 Y135.606 E.26705
G2 X102.546 Y135.844 I2.19 J-3.196 E.02316
G1 X106.166 Y132.109 E.25985
G1 X106.213 Y132.162 E.00355
G1 X106.763 Y131.877 E.03096
G1 X106.917 Y131.983 E.00933
G1 X106.285 Y132.635 E.04536
G3 X106.794 Y132.542 I.725 J2.521 E.02592
G1 X107.02 Y132.524 E.01132
G3 X107.735 Y131.816 I5.363 J4.69 E.05031
G1 X108.177 Y131.979 E.02357
G1 X107.576 Y132.599 E.04315
G3 X108.049 Y132.76 I-.284 J1.613 E.02504
G1 X111.733 Y128.958 E.26443
G2 X111.955 Y129.377 I1.726 J-.648 E.02376
G1 X108.451 Y132.993 E.25151
G3 X108.79 Y133.292 I-.799 J1.246 E.02266
G1 X112.241 Y129.731 E.24771
G2 X112.588 Y130.021 I1.498 J-1.442 E.02265
G1 X109.072 Y133.65 E.25241
G3 X109.294 Y134.069 I-1.248 J.927 E.0238
G1 X112.995 Y130.25 E.26566
G2 X113.467 Y130.411 I.756 J-1.45 E.02505
G1 X109.44 Y134.566 E.28907
G3 X109.473 Y135.067 I-1.603 J.357 E.02516
G1 X109.469 Y135.185 E.00593
G1 X114.04 Y130.468 E.32816
G2 X114.794 Y130.339 I-.043 J-2.52 E.03832
G1 X109.225 Y136.086 E.39973
G1 X109.054 Y136.4 E.01785
G1 X109.192 Y136.755 E.01907
G1 X115.74 Y130.011 E.46954
G1 X115.792 Y130.063 E.00367
G3 X115.578 Y130.827 I-8.607 J-1.997 E.03961
G1 X110.1 Y136.48 E.39325
G2 X111.204 Y135.988 I-3.376 J-9.076 E.06044
G1 X115.13 Y131.938 E.28176
G3 X113.633 Y134.131 I-9.04 J-4.562 E.13302
G1 X112.146 Y135.665 E.1067
M106 S150.45
; WIPE_START
G1 X113.538 Y134.229 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.822 Y136.832 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.177556
; LAYER_HEIGHT: 0.2
G1 F15000
M204 S6000
G1 X108.216 Y137.043 E.00683
; LINE_WIDTH: 0.155813
G1 X108.087 Y137.083 E.0012
; LINE_WIDTH: 0.116547
G1 X107.958 Y137.122 E.00078
M204 S10000
G1 X108.095 Y137.126 F42000
; LINE_WIDTH: 0.353121
G1 F7736.922
M204 S6000
G1 X108.797 Y136.794 E.01903
; WIPE_START
G1 X108.095 Y137.126 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.047 Y137.117 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.11748
G1 F15000
M204 S6000
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
M204 S10000
G1 X105.196 Y136.912 F42000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.38292
G1 F7058.823
M204 S6000
G1 X105.175 Y136.949 E.00114
G1 X105.111 Y136.912 E.00198
G1 X105.123 Y136.905 E.00037
M204 S10000
G1 X104.645 Y136.921 F42000
; FEATURE: Bridge
; LINE_WIDTH: 0.40129
; LAYER_HEIGHT: 0.4
M106 S229.5
G1 F3000
M204 S6000
G1 X105.05 Y136.503 E.02907
G3 X104.802 Y136.11 I1.725 J-1.364 E.02324
G1 X104.321 Y136.606 E.0345
G1 X104.254 Y136.585 E.00353
G3 X103.846 Y136.448 I.649 J-2.614 E.02151
G1 X104.619 Y135.65 E.05552
G3 X104.541 Y135.083 I1.798 J-.539 E.02872
G1 X103.395 Y136.265 E.08225
G3 X102.96 Y136.066 I1.056 J-2.87 E.02393
G1 X104.983 Y133.979 E.14517
M106 S150.45
; WIPE_START
G1 X103.591 Y135.415 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X98.705 Y132.026 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
M106 S229.5
G1 F3000
M204 S6000
G1 X100.224 Y130.459 E.10902
G3 X99.616 Y130.438 I-.223 J-2.34 E.03047
G1 X98.659 Y131.426 E.06873
G3 X98.482 Y130.959 I3.804 J-1.707 E.02492
G1 X99.118 Y130.303 E.04568
G3 X98.692 Y130.094 I.464 J-1.486 E.0238
G1 X98.164 Y130.639 E.03793
M106 S150.45
M204 S10000
G1 X98.133 Y129.866 F42000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.38292
; LAYER_HEIGHT: 0.2
G1 F7058.823
M204 S6000
G1 X98.112 Y129.903 E.00114
G1 X98.048 Y129.866 E.00198
G1 X98.06 Y129.859 E.00037
M204 S10000
G1 X98.228 Y129.506 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970891
G1 F15000
M204 S6000
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
M204 S10000
G1 X97.888 Y127.044 Z1.6 F42000
G1 Z1.2
G1 E.8 F1800
; LINE_WIDTH: 0.117867
G1 F15000
M204 S6000
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
G1 F15000
G1 X98.204 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 114
M625
; layer num/total_layer_count: 7/23
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
M106 S191.25
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z1.6 I.008 J1.217 P1  F42000
G1 X124.977 Y126.337 Z1.6
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
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
G1 X125.378 Y126.557 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
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
M204 S6000
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18163
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02174
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.551 Y119.579 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X129.572 Y119.601 E.00097
G3 X127.841 Y118.902 I-1.57 J1.396 E.3622
G3 X128.602 Y118.99 I.125 J2.266 E.02475
G1 X128.789 Y119.049 E.00629
G3 X129.34 Y119.377 I-.786 J1.948 E.02073
G1 X129.508 Y119.538 E.00746
M204 S250
G1 X129.279 Y119.862 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X127.871 Y119.294 I-1.276 J1.135 E.27281
G3 X128.484 Y119.363 I.102 J1.85 E.01845
G1 X128.642 Y119.413 E.00493
G3 X129.238 Y119.818 I-.639 J1.584 E.02164
; WIPE_START
M204 S6000
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
M204 S10000
G1 X135.796 Y126.089 Z1.8 F42000
G1 X136.647 Y126.693 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X136.806 Y126.927 E.00912
G3 X134.727 Y125.92 I-1.805 J1.076 E.34581
G3 X135.974 Y126.141 I.274 J2.086 E.04135
G3 X136.607 Y126.648 I-.972 J1.862 E.02626
M204 S250
G1 X136.327 Y126.918 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X136.476 Y127.124 E.00757
G3 X134.772 Y126.31 I-1.466 J.878 E.26014
G3 X135.702 Y126.439 I.244 J1.651 E.02834
G3 X136.291 Y126.871 I-.691 J1.562 E.02193
; WIPE_START
M204 S6000
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
M204 S10000
G1 X131.289 Y134.284 Z1.8 F42000
G1 X128.75 Y136.963 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X128.482 Y137.048 E.00906
G3 X127.807 Y132.911 I-.48 J-2.045 E.22155
G3 X129.045 Y133.179 I.194 J2.095 E.04135
G3 X128.807 Y136.943 I-1.043 J1.824 E.15057
M204 S250
G1 X128.632 Y136.59 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X128.392 Y136.665 E.00749
G3 X127.837 Y133.302 I-.381 J-1.664 E.16604
G3 X128.761 Y133.467 I.18 J1.66 E.02834
G3 X128.688 Y136.568 I-.75 J1.534 E.11589
; WIPE_START
M204 S6000
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
M204 S10000
G1 X123.452 Y129.394 Z1.8 F42000
G1 X123.03 Y128.539 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X123.013 Y128.637 E.00319
G3 X120.887 Y125.905 I-2.003 J-.634 E.2937
G3 X122.278 Y126.327 I.109 J2.145 E.04765
G3 X123.087 Y128.322 I-1.267 J1.676 E.07269
G1 X123.046 Y128.481 E.00528
M204 S250
G1 X122.644 Y128.438 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X122.607 Y128.609 E.00521
G3 X120.902 Y126.297 I-1.597 J-.608 E.21806
G3 X121.819 Y126.497 I.117 J1.665 E.02834
G3 X122.699 Y128.262 I-.809 J1.505 E.06261
G1 X122.661 Y128.381 E.00372
; WIPE_START
M204 S6000
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
M204 S10000
G1 X124.942 Y122.976 Z1.8 F42000
G1 X127.3 Y118.633 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X128.232 Y118.609 I.712 J9.481 E.02999
G3 X124.569 Y119.252 I-.24 J9.392 E1.77791
G3 X127.241 Y118.638 I3.444 J8.862 E.08846
M204 S250
G1 X127.271 Y118.237 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X127.271 Y118.241 E.00012
G3 X128.238 Y118.217 I.731 J9.758 E.02883
G3 X137.195 Y124.646 I-.238 J9.785 E.34884
G3 X126.689 Y118.303 I-9.193 J3.354 E1.43631
G1 X127.211 Y118.244 E.01566
; WIPE_START
M204 S6000
G1 X127.271 Y118.241 E-.02282
G1 X127.856 Y118.211 E-.22251
G1 X128.238 Y118.217 E-.14538
G1 X129.026 Y118.264 E-.29967
G1 X129.207 Y118.288 E-.06963
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z1.8 I1.217 J0 P1  F42000
; stop printing object, unique label id: 78
M625
; object ids of layer 7 start: 78,114
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


; object ids of this layer7 end: 78,114
M625
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X129.091 Y118.874 F42000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.353121
G1 F7736.933
M204 S6000
G1 X129.793 Y119.206 E.01903
M204 S10000
G1 X129.818 Y119.168 F42000
; LINE_WIDTH: 0.177556
G1 F15000
M204 S6000
G1 X129.211 Y118.957 E.00683
; LINE_WIDTH: 0.155821
G1 X129.082 Y118.917 E.0012
; LINE_WIDTH: 0.116549
M73 P63 R5
G1 X128.953 Y118.878 E.00078
; WIPE_START
G1 X129.082 Y118.917 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.042 Y118.883 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.117505
G1 F15000
M204 S6000
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
M204 S10000
G1 X132.21 Y123.175 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.370126
G1 F7334.842
M204 S6000
G1 X132.663 Y123.544 E.0151
G1 X132.867 Y123.782 E.00811
G1 X133.179 Y123.64 E.00886
G1 X132.681 Y123.113 E.01874
G1 X132.361 Y122.845 E.0108
G1 X132.235 Y123.12 E.00783
M204 S10000
G1 X131.861 Y123.388 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X132.24 Y123.63 E.01339
G1 X132.566 Y123.961 E.01383
G1 X132.752 Y124.249 E.01022
G1 X133.374 Y123.935 E.02072
G1 X133.756 Y123.808 E.012
G2 X132.196 Y122.25 I-5.864 J4.311 E.06591
G1 X131.946 Y122.898 E.02071
G1 X131.745 Y123.269 E.01257
G1 X131.819 Y123.345 E.00315
M204 S10000
G1 X131.58 Y123.675 F42000
G1 F6364.866
M204 S6000
G1 X132.003 Y123.924 E.01461
G3 X132.46 Y124.496 I-1.066 J1.32 E.02197
G1 X132.574 Y124.723 E.00757
G1 X132.643 Y124.79 E.00286
G3 X133.528 Y124.28 I1.899 J2.271 E.03059
G1 X134.375 Y124.058 E.0261
G2 X131.954 Y121.634 I-6.376 J3.949 E.10296
G1 X131.81 Y122.23 E.01826
G1 X131.602 Y122.744 E.01653
G1 X131.266 Y123.315 E.01974
G1 X131.54 Y123.63 E.01244
M204 S10000
G1 X131.321 Y123.989 F42000
G1 F6364.866
M204 S6000
G1 X131.668 Y124.145 E.01135
G1 X131.974 Y124.427 E.01238
G3 X132.244 Y124.95 I-2.301 J1.52 E.01757
G1 X132.552 Y125.226 E.0123
G1 X132.601 Y125.299 E.00262
G1 X133.12 Y124.907 E.01938
G1 X133.682 Y124.624 E.01875
G1 X134.358 Y124.443 E.02084
G1 X134.997 Y124.392 E.01909
G2 X131.837 Y121.126 I-7.005 J3.616 E.13731
G1 X131.627 Y121.038 E.00678
G3 X130.703 Y123.411 I-3.75 J-.093 E.07741
G1 X131.016 Y123.597 E.01081
G1 X131.295 Y123.934 E.01306
M204 S10000
G1 X131.077 Y124.312 F42000
G1 F6364.866
M204 S6000
G1 X131.412 Y124.43 E.01059
G1 X131.677 Y124.661 E.01046
G1 X131.849 Y125.004 E.01143
G1 X131.898 Y125.192 E.0058
G1 X132.11 Y125.317 E.00734
G1 X132.366 Y125.625 E.01194
G1 X132.456 Y125.995 E.01132
G1 X132.889 Y125.544 E.0186
G1 X133.343 Y125.212 E.01677
G1 X133.836 Y124.968 E.0164
G1 X134.442 Y124.811 E.01863
G1 X135.224 Y124.765 E.02333
G1 X135.611 Y124.814 E.01164
G1 X135.216 Y123.996 E.02706
G2 X131.188 Y120.391 I-7.327 J4.133 E.16391
G1 X131.245 Y120.909 E.01554
G1 X131.204 Y121.547 E.01904
G3 X129.961 Y123.574 I-3.134 J-.529 E.07258
G1 X130.087 Y123.661 E.00459
G1 X130.423 Y123.696 E.01006
G1 X130.771 Y123.884 E.01177
G3 X131.048 Y124.26 I-.795 J.875 E.014
; WIPE_START
G1 X130.96 Y124.104 E-.0678
G1 X130.771 Y123.884 E-.11048
G1 X130.423 Y123.696 E-.1502
G1 X130.087 Y123.661 E-.12829
G1 X129.961 Y123.574 E-.0585
G1 X130.17 Y123.416 E-.09961
G1 X130.434 Y123.139 E-.14512
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.855 Y124.064 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.419669
G1 F6370.302
M204 S6000
G1 X130.208 Y124.037 E.01055
G1 X130.456 Y124.12 E.00778
G1 X130.64 Y124.303 E.00772
G1 X130.775 Y124.648 E.01103
G1 X131.189 Y124.738 E.0126
G1 X131.381 Y124.894 E.00737
G1 X131.484 Y125.1 E.00685
G1 X131.522 Y125.443 E.01026
G1 X131.878 Y125.615 E.01177
G1 X132.032 Y125.8 E.00716
G1 X132.088 Y126.153 E.01066
G1 X132.047 Y126.398 E.00739
G1 X132.374 Y126.688 E.01301
G1 X132.413 Y126.758 E.00235
G1 X132.694 Y126.293 E.01616
G1 X133.111 Y125.849 E.01815
G1 X133.566 Y125.516 E.01676
G1 X134.096 Y125.276 E.01733
G1 X134.693 Y125.152 E.01815
G1 X135.256 Y125.142 E.01675
G1 X135.805 Y125.242 E.0166
G1 X136.219 Y125.393 E.0131
G2 X130.598 Y119.775 I-8.194 J2.578 E.24588
G1 X130.783 Y120.281 E.01603
G1 X130.868 Y120.924 E.01931
G1 X130.83 Y121.504 E.01731
G1 X130.69 Y122.012 E.01566
G3 X129.943 Y123.115 I-2.937 J-1.185 E.03995
G1 X129.449 Y123.472 E.01815
G1 X129.054 Y123.649 E.01289
G1 X129.454 Y123.645 E.01193
G1 X129.717 Y123.857 E.01003
G1 X129.821 Y124.014 E.00561
; WIPE_START
G1 X129.717 Y123.857 E-.0716
G1 X129.454 Y123.645 E-.12806
G1 X129.054 Y123.649 E-.15233
G1 X129.449 Y123.472 E-.16455
G1 X129.943 Y123.115 E-.23175
G1 X129.964 Y123.092 E-.01172
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.815 Y123.741 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.39859
G1 F6747.828
M204 S6000
G1 X128.998 Y123.67 E.00551
; WIPE_START
G1 X128.815 Y123.741 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.387 Y123.572 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.38686
G1 F6977.973
M204 S6000
G1 X123.779 Y123.129 E.01606
G1 X123.642 Y122.828 E.00898
G2 X122.857 Y123.633 I4.228 J4.906 E.03058
G1 X123.165 Y123.773 E.00918
G1 X123.343 Y123.612 E.00652
M204 S10000
G1 X123.626 Y123.89 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X123.95 Y123.451 E.01627
G1 X124.225 Y123.215 E.01079
G1 X123.938 Y122.629 E.01946
G1 X123.809 Y122.25 E.01191
G2 X122.253 Y123.806 I4.045 J5.598 E.06582
G3 X123.223 Y124.226 I-1.383 J4.525 E.03154
G1 X123.58 Y123.929 E.01385
M204 S10000
G1 X123.921 Y124.135 F42000
G1 F6364.866
M204 S6000
G1 X124.221 Y123.714 E.01539
G3 X124.76 Y123.344 I1.185 J1.148 E.01961
G3 X124.049 Y121.634 I3.377 J-2.407 E.05563
G2 X121.631 Y124.055 I3.98 J6.393 E.10282
G1 X122.232 Y124.192 E.01837
G1 X122.764 Y124.409 E.01712
G1 X123.31 Y124.731 E.01889
G1 X123.595 Y124.386 E.01332
G1 X123.873 Y124.172 E.01047
M204 S10000
G1 X124.21 Y124.439 F42000
G1 F6364.866
M204 S6000
G1 X124.373 Y124.116 E.01077
G1 X124.674 Y123.821 E.01257
G1 X125.079 Y123.628 E.01336
G1 X125.209 Y123.599 E.00397
G1 X125.337 Y123.452 E.0058
G3 X124.377 Y121.038 I2.788 J-2.507 E.07903
G1 X124.269 Y121.068 E.00333
G2 X121.507 Y123.55 I3.855 J7.067 E.11162
G1 X121.014 Y124.373 E.02858
G3 X123.467 Y125.347 I-.07 J3.753 E.08034
G1 X123.621 Y124.943 E.01286
G1 X123.934 Y124.593 E.01401
G1 X124.158 Y124.468 E.00762
; WIPE_START
G1 X123.934 Y124.593 E-.09722
G1 X123.621 Y124.943 E-.17869
G1 X123.467 Y125.347 E-.16403
G1 X123.119 Y125.057 E-.17219
G1 X122.785 Y124.857 E-.14787
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.803 Y125.671 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X123.876 Y125.269 E.01217
G1 X124.106 Y124.941 E.01193
G3 X124.515 Y124.7 I.864 J.997 E.01421
G1 X124.677 Y124.34 E.01176
G1 X124.892 Y124.128 E.00898
G1 X125.232 Y123.978 E.01107
G1 X125.445 Y123.936 E.00647
G1 X125.674 Y123.642 E.01111
G1 X125.936 Y123.501 E.00886
G1 X125.519 Y123.089 E.01748
G1 X125.183 Y122.615 E.01729
G1 X124.95 Y122.118 E.01635
G1 X124.8 Y121.547 E.01758
G1 X124.754 Y121.052 E.01481
G1 X124.816 Y120.393 E.01972
G2 X120.392 Y124.821 I3.188 J7.609 E.19123
G1 X120.934 Y124.761 E.01624
G1 X121.496 Y124.793 E.01677
G1 X122.032 Y124.919 E.01641
G1 X122.548 Y125.141 E.01673
G1 X123.029 Y125.461 E.01719
G3 X123.522 Y125.957 I-1.634 J2.119 E.0209
G3 X123.758 Y125.71 I1.008 J.724 E.01021
M204 S10000
G1 X124.19 Y125.904 F42000
G1 F6364.866
M204 S6000
G1 X124.185 Y125.556 E.01036
G1 X124.263 Y125.338 E.00691
G1 X124.46 Y125.145 E.00819
G1 X124.831 Y125.022 E.01165
G1 X124.961 Y124.591 E.01341
G1 X125.11 Y124.436 E.00638
G1 X125.356 Y124.338 E.00791
G1 X125.671 Y124.327 E.00938
G1 X125.841 Y124.011 E.01067
G1 X125.99 Y123.877 E.00598
G1 X126.275 Y123.792 E.00888
G1 X126.658 Y123.862 E.01158
G1 X126.88 Y123.638 E.00939
G1 X126.385 Y123.374 E.0167
G1 X125.979 Y123.039 E.01567
G1 X125.692 Y122.707 E.01309
G1 X125.428 Y122.265 E.01534
G1 X125.231 Y121.733 E.0169
G1 X125.134 Y121.153 E.0175
G1 X125.154 Y120.628 E.01566
G3 X125.393 Y119.778 I3.299 J.467 E.02638
G2 X119.775 Y125.406 I2.61 J8.223 E.24618
G1 X120.307 Y125.215 E.01686
G1 X120.912 Y125.137 E.01816
G1 X121.474 Y125.17 E.01677
G3 X123.102 Y126.04 I-.46 J2.818 E.05597
; LINE_WIDTH: 0.44076
G1 F6032.575
G1 X123.271 Y126.245 E.00836
; LINE_WIDTH: 0.4823
G1 F5462.242
G1 X123.441 Y126.45 E.00924
; LINE_WIDTH: 0.52384
G1 F4990.435
G1 X123.61 Y126.655 E.01011
; LINE_WIDTH: 0.555465
G1 F4682.516
G1 X123.647 Y126.701 E.00239
; LINE_WIDTH: 0.541932
G1 F4809.507
G1 X123.672 Y126.582 E.00479
; LINE_WIDTH: 0.493155
G1 F5330.549
G1 X123.696 Y126.463 E.00432
; LINE_WIDTH: 0.424103
G1 F6296.195
G1 X123.721 Y126.344 E.00366
G1 X123.881 Y126.098 E.00885
G1 X124.139 Y125.936 E.00917
; WIPE_START
G1 X123.881 Y126.098 E-.3216
G1 X123.721 Y126.344 E-.31024
G1 X123.696 Y126.463 E-.12816
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.717 Y126.9 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.55596
G1 F4677.998
M204 S6000
G1 X123.667 Y126.758 E.00611
M204 S10000
G1 X124.215 Y127.028 F42000
; LINE_WIDTH: 0.423377
G1 F6308.207
M204 S6000
G1 X124.074 Y126.555 E.01481
G3 X124.164 Y126.355 I.185 J-.037 E.00704
G1 X124.576 Y126.116 E.01429
G1 X124.559 Y125.608 E.01528
G1 X124.65 Y125.471 E.00495
G1 X125.152 Y125.323 E.01572
G1 X125.268 Y124.813 E.01571
G1 X125.395 Y124.714 E.00486
G1 X125.907 Y124.698 E.01539
G1 X126.139 Y124.242 E.01539
G1 X126.284 Y124.169 E.00488
G1 X126.794 Y124.281 E.01569
G1 X127.197 Y123.842 E.01791
G1 X127.331 Y123.852 E.00404
; LINE_WIDTH: 0.477535
G1 F5522.129
G1 X127.542 Y123.946 E.00794
; LINE_WIDTH: 0.504385
G1 F5200.828
G1 X127.753 Y124.04 E.00843
; LINE_WIDTH: 0.500507
G1 F5244.908
G1 X127.885 Y123.97 E.00541
; LINE_WIDTH: 0.4659
G1 F5674.027
G1 X128.017 Y123.9 E.005
; LINE_WIDTH: 0.419332
G1 F6376.002
G1 X128.15 Y123.83 E.00445
G1 X128.344 Y123.824 E.00578
G1 X128.735 Y124.159 E.01531
G1 X129.181 Y123.994 E.01414
G1 X129.35 Y124.014 E.00506
G1 X129.667 Y124.462 E.01632
G1 X130.176 Y124.413 E.01519
G1 X130.309 Y124.487 E.00454
G1 X130.495 Y124.987 E.01586
G1 X131.004 Y125.068 E.01535
G1 X131.114 Y125.18 E.00465
G1 X131.166 Y125.702 E.01559
G1 X131.632 Y125.902 E.01509
G1 X131.697 Y125.974 E.00288
G1 X131.704 Y126.166 E.00573
G1 X131.638 Y126.56 E.01189
G1 X132.059 Y126.895 E.016
; LINE_WIDTH: 0.444723
G1 F5973.084
G1 X132.095 Y126.979 E.00288
; LINE_WIDTH: 0.494188
G1 F5318.354
G1 X132.131 Y127.062 E.00324
; LINE_WIDTH: 0.53284
G1 F4898.759
G1 X131.955 Y127.501 E.01828
; LINE_WIDTH: 0.526575
G1 F4962.215
G1 X132.03 Y127.628 E.00562
; LINE_WIDTH: 0.486205
G1 F5414.124
G1 X132.104 Y127.755 E.00515
; LINE_WIDTH: 0.433384
G1 F6146.546
G1 X132.178 Y127.882 E.00454
G1 X132.178 Y128.118 E.00731
; LINE_WIDTH: 0.446095
G1 F5952.75
G1 X132.104 Y128.245 E.00468
; LINE_WIDTH: 0.486985
G1 F5404.615
G1 X132.03 Y128.372 E.00516
; LINE_WIDTH: 0.537237
G1 F4855.191
G1 X131.956 Y128.499 E.00574
G1 X132.144 Y128.973 E.01992
; LINE_WIDTH: 0.512957
G1 F5105.985
G1 X132.102 Y129.033 E.00271
; LINE_WIDTH: 0.47577
G1 F5544.646
G1 X132.059 Y129.092 E.0025
; LINE_WIDTH: 0.420244
G1 F6360.583
G1 X132.016 Y129.151 E.00218
G1 X131.638 Y129.439 E.01417
G1 X131.709 Y129.999 E.0168
G1 X131.604 Y130.113 E.00464
G1 X131.166 Y130.298 E.01417
G1 X131.119 Y130.803 E.01511
G1 X131.021 Y130.924 E.00464
G1 X130.495 Y131.013 E.01591
G1 X130.319 Y131.499 E.01539
G1 X130.184 Y131.586 E.00481
G1 X129.667 Y131.538 E.01547
G1 X129.384 Y131.957 E.01508
G1 X129.244 Y132.017 E.00453
G1 X128.735 Y131.841 E.01606
; LINE_WIDTH: 0.412299
G1 F6497.391
G1 X128.343 Y132.175 E.01502
G1 X128.147 Y132.175 E.00574
; LINE_WIDTH: 0.447688
G1 F5929.33
G1 X127.95 Y132.067 E.00717
; LINE_WIDTH: 0.491935
G1 F5345.036
G1 X127.753 Y131.96 E.00795
G1 X127.287 Y132.161 E.01802
; LINE_WIDTH: 0.422102
G1 F6329.427
G1 X127.198 Y132.154 E.00267
G1 X126.794 Y131.719 E.01777
G1 X126.229 Y131.822 E.01719
G1 X126.119 Y131.727 E.00435
G1 X125.907 Y131.302 E.01424
G1 X125.395 Y131.286 E.01534
G1 X125.268 Y131.187 E.00484
G1 X125.152 Y130.677 E.01566
G1 X124.65 Y130.529 E.01566
G1 X124.559 Y130.392 E.00493
G1 X124.576 Y129.884 E.01523
G1 X124.133 Y129.622 E.0154
G1 X124.077 Y129.529 E.00325
G1 X124.215 Y128.972 E.01719
G1 X123.876 Y128.639 E.01424
G1 X123.832 Y128.443 E.00602
; LINE_WIDTH: 0.438668
G1 F6064.474
G1 X123.937 Y128.221 E.00766
; LINE_WIDTH: 0.466897
G1 F5660.695
G1 X124.042 Y128 E.00821
G1 X123.826 Y127.529 E.01735
; LINE_WIDTH: 0.418869
G1 F6383.845
G1 X123.896 Y127.341 E.00597
G1 X124.172 Y127.07 E.01149
; WIPE_START
G1 X123.896 Y127.341 E-.50024
G1 X123.826 Y127.529 E-.25976
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.536 Y128.017 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.477073
G1 F5528.012
M204 S6000
G1 X123.448 Y128.397 E.01335
; LINE_WIDTH: 0.420899
G1 F6349.559
G1 X123.36 Y128.776 E.01163
G1 X123.057 Y129.415 E.0211
G3 X121.678 Y130.396 I-2.065 J-1.444 E.05155
G1 X121.123 Y130.492 E.01681
G1 X120.694 Y130.476 E.01283
G1 X120.176 Y130.348 E.01591
G1 X119.667 Y130.108 E.01681
G1 X119.401 Y129.895 E.01016
G1 X119.311 Y129.987 E.00384
G1 X119.225 Y130.001 E.0026
G2 X126.021 Y136.781 I8.787 J-2.013 E.30223
G1 X126.047 Y136.654 E.00385
G1 X126.107 Y136.601 E.0024
G3 X125.51 Y134.882 I1.816 J-1.594 E.05571
G1 X125.593 Y134.373 E.01539
G1 X125.798 Y133.83 E.01733
G1 X126.043 Y133.458 E.01331
G1 X126.406 Y133.09 E.01542
G1 X126.873 Y132.775 E.01681
G1 X127.365 Y132.575 E.01586
; LINE_WIDTH: 0.47993
G1 F5491.866
G1 X127.796 Y132.482 E.01524
; LINE_WIDTH: 0.479454
G1 F5497.862
G1 X127.966 Y132.502 E.0059
; LINE_WIDTH: 0.44574
G1 F5957.996
G1 X128.136 Y132.522 E.00544
; LINE_WIDTH: 0.41963
G1 F6370.96
G3 X128.769 Y132.625 I-.559 J5.438 E.0191
G1 X129.123 Y132.77 E.01137
G1 X129.552 Y133.051 E.01527
G1 X129.978 Y133.475 E.01791
G1 X130.251 Y133.932 E.01581
G1 X130.447 Y134.5 E.0179
G1 X130.491 Y135.062 E.01676
G1 X130.413 Y135.647 E.01759
G3 X130.053 Y136.395 I-2.017 J-.51 E.02485
G1 X130.202 Y136.729 E.01087
G2 X136.778 Y129.981 I-2.188 J-8.712 E.29516
G1 X136.657 Y129.956 E.0037
G1 X136.603 Y129.895 E.00239
G1 X136.325 Y130.115 E.01054
G1 X135.92 Y130.316 E.01345
G1 X135.303 Y130.478 E.01899
G1 X134.892 Y130.494 E.01222
G1 X134.266 Y130.38 E.01895
G1 X133.797 Y130.186 E.01509
G3 X132.909 Y129.344 I1.297 J-2.258 E.03674
; LINE_WIDTH: 0.438584
G1 F6065.763
G1 X132.813 Y129.189 E.00572
; LINE_WIDTH: 0.47577
G1 F5544.646
G1 X132.717 Y129.033 E.00626
; LINE_WIDTH: 0.52445
G1 F4984.118
G1 X132.621 Y128.877 E.00697
G1 X132.49 Y128.421 E.01805
; LINE_WIDTH: 0.501354
G1 F5235.221
G1 X132.502 Y128.276 E.00525
; LINE_WIDTH: 0.45162
G1 F5872.278
G1 X132.515 Y128.132 E.00468
; LINE_WIDTH: 0.401887
G1 F6685.857
G1 X132.528 Y127.987 E.00411
; LINE_WIDTH: 0.398238
G1 F6754.522
G1 X132.519 Y127.871 E.00328
; LINE_WIDTH: 0.440673
G1 F6033.903
G1 X132.51 Y127.754 E.00367
; LINE_WIDTH: 0.483108
G1 F5452.222
G1 X132.501 Y127.638 E.00406
; LINE_WIDTH: 0.530884
G1 F4918.396
G1 X132.492 Y127.521 E.0045
G1 X132.581 Y127.215 E.0123
; LINE_WIDTH: 0.494188
G1 F5318.354
G1 X132.736 Y126.947 E.01102
; LINE_WIDTH: 0.420379
G1 F6358.309
G1 X132.891 Y126.68 E.00922
G1 X133.305 Y126.179 E.01939
G1 X133.788 Y125.82 E.01793
G1 X134.185 Y125.643 E.01295
G1 X134.701 Y125.529 E.01574
G1 X135.263 Y125.519 E.01678
G3 X136.492 Y126.013 I-.293 J2.504 E.03995
G1 X136.603 Y126.104 E.00429
G3 X136.78 Y126 I.16 J.07 E.00654
G2 X130.202 Y119.271 I-8.778 J2.001 E.29524
G1 X130.053 Y119.605 E.0109
G1 X130.286 Y119.992 E.01346
G1 X130.459 Y120.593 E.01866
G1 X130.496 Y121.11 E.01544
G3 X130.315 Y121.927 I-2.364 J-.094 E.02509
G1 X129.996 Y122.502 E.01959
G1 X129.716 Y122.814 E.01249
G1 X129.288 Y123.131 E.01589
G1 X128.779 Y123.371 E.01679
; LINE_WIDTH: 0.41036
G1 F6531.679
G1 X128.368 Y123.459 E.01219
; LINE_WIDTH: 0.420244
G1 F6360.593
G1 X128.163 Y123.482 E.00614
; LINE_WIDTH: 0.45927
G1 F5764.381
G1 X127.959 Y123.504 E.00678
; LINE_WIDTH: 0.495891
G1 F5298.355
G1 X127.754 Y123.527 E.00737
G1 X127.257 Y123.409 E.01827
; LINE_WIDTH: 0.45902
G1 F5767.844
G1 X127 Y123.279 E.00948
; LINE_WIDTH: 0.420084
G1 F6363.292
G1 X126.743 Y123.148 E.00859
G1 X126.282 Y122.808 E.01706
G3 X125.594 Y121.633 I1.977 J-1.945 E.041
G1 X125.509 Y121.11 E.01578
G3 X125.731 Y119.966 I2.785 J-.053 E.03498
G1 X126.015 Y119.51 E.01601
G1 X126.107 Y119.399 E.0043
G3 X126.003 Y119.223 I.07 J-.16 E.00649
G2 X119.227 Y126.029 I1.998 J8.765 E.30185
G3 X119.385 Y126.111 I.017 J.161 E.00561
G1 X119.932 Y125.75 E.01952
G1 X120.363 Y125.588 E.01371
G1 X120.89 Y125.514 E.01587
G1 X121.452 Y125.546 E.01677
G1 X122.021 Y125.728 E.01779
G1 X122.504 Y126.006 E.01659
G3 X123.309 Y127.064 I-1.614 J2.065 E.04006
G1 X123.464 Y127.605 E.01676
; LINE_WIDTH: 0.434105
G1 F6135.205
G1 X123.495 Y127.782 E.00554
; LINE_WIDTH: 0.475455
G1 F5548.684
G1 X123.526 Y127.958 E.00612
; WIPE_START
G1 X123.495 Y127.782 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.19 Y130.096 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X123.881 Y129.902 E.01086
G1 X123.712 Y129.625 E.00969
; LINE_WIDTH: 0.440934
G1 F6029.949
G1 X123.711 Y129.456 E.0053
; LINE_WIDTH: 0.48282
G1 F5455.786
G1 X123.71 Y129.288 E.00586
; LINE_WIDTH: 0.525896
G1 F4969.196
G1 X123.713 Y129.11 E.00676
; LINE_WIDTH: 0.527232
G1 F4955.486
G1 X123.606 Y129.27 E.00734
; LINE_WIDTH: 0.484335
G1 F5437.06
G1 X123.499 Y129.429 E.00669
; LINE_WIDTH: 0.420185
G1 F6361.586
G3 X122.709 Y130.31 I-3.008 J-1.903 E.03543
G3 X120.638 Y130.849 I-1.744 J-2.453 E.06521
G1 X120.125 Y130.727 E.01571
G1 X119.767 Y130.572 E.01163
M73 P64 R5
G1 X120.092 Y131.442 E.02768
G2 X125.399 Y136.214 I7.891 J-3.437 E.21932
G1 X125.222 Y135.721 E.01562
G3 X125.229 Y134.272 I3.053 J-.709 E.04359
G1 X125.446 Y133.696 E.01833
G1 X125.761 Y133.206 E.01736
G1 X126.195 Y132.778 E.01817
G1 X126.662 Y132.463 E.01677
G1 X126.88 Y132.361 E.00717
G1 X126.658 Y132.138 E.0094
G3 X126.112 Y132.18 I-.349 J-.957 E.01652
G1 X125.841 Y131.989 E.00988
G1 X125.671 Y131.673 E.01068
G1 X125.307 Y131.653 E.01086
G1 X125.064 Y131.528 E.00813
G1 X124.931 Y131.356 E.00648
G1 X124.831 Y130.978 E.01166
G1 X124.415 Y130.826 E.0132
G1 X124.263 Y130.662 E.00665
G3 X124.188 Y130.156 I.677 J-.359 E.01556
M204 S10000
G1 X123.786 Y130.297 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G3 X123.522 Y130.043 I.294 J-.569 E.01106
G3 X121.993 Y131.086 I-2.421 J-1.906 E.056
G3 X121.03 Y131.247 I-1.251 J-4.515 E.02913
G1 X120.518 Y131.209 E.0153
G1 X120.392 Y131.179 E.00384
G2 X121.821 Y133.463 I7.759 J-3.264 E.08058
G2 X124.081 Y135.259 I6.355 J-5.677 E.08641
G2 X124.816 Y135.607 I3.238 J-5.888 E.02423
G1 X124.754 Y134.948 E.01972
G1 X124.843 Y134.274 E.02024
G1 X125.094 Y133.562 E.0225
G1 X125.376 Y133.088 E.01641
G1 X125.836 Y132.589 E.02023
G1 X125.931 Y132.51 E.00368
G1 X125.818 Y132.46 E.00368
G1 X125.5 Y132.16 E.013
G1 X125.414 Y132.044 E.00431
G1 X125.046 Y131.96 E.01125
G1 X124.761 Y131.76 E.01036
G3 X124.489 Y131.274 I.922 J-.834 E.01674
G1 X124.166 Y131.11 E.0108
G1 X123.942 Y130.86 E.01
G1 X123.812 Y130.495 E.01152
G1 X123.793 Y130.357 E.00417
; WIPE_START
G1 X123.812 Y130.495 E-.05322
G1 X123.942 Y130.86 E-.14697
G1 X124.166 Y131.11 E-.12761
G1 X124.489 Y131.274 E-.13779
G1 X124.594 Y131.526 E-.10379
G1 X124.761 Y131.76 E-.10926
G1 X124.936 Y131.883 E-.08136
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.21 Y131.561 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X123.934 Y131.407 E.00941
G1 X123.621 Y131.057 E.014
G1 X123.467 Y130.654 E.01285
G1 X123.119 Y130.943 E.01349
G1 X122.627 Y131.24 E.0171
G1 X122.154 Y131.428 E.01515
G3 X121.026 Y131.648 I-2.249 J-8.504 E.03428
G1 X121.477 Y132.405 E.02624
G2 X124.378 Y134.987 I6.583 J-4.475 E.11686
G3 X125.059 Y132.883 I4.026 J.141 E.06672
G1 X125.353 Y132.545 E.01335
G1 X125.135 Y132.387 E.00801
G1 X124.674 Y132.179 E.01506
G1 X124.362 Y131.869 E.0131
G1 X124.237 Y131.615 E.00846
M204 S10000
G1 X123.889 Y131.831 F42000
G1 F6364.866
M204 S6000
G1 X123.493 Y131.512 E.01514
G1 X123.31 Y131.269 E.00906
G1 X122.776 Y131.586 E.0185
G1 X122.293 Y131.778 E.01548
G1 X121.625 Y131.936 E.02046
G2 X124.062 Y134.376 I6.68 J-4.234 E.10356
G3 X124.743 Y132.678 I4.379 J.77 E.05486
G1 X124.321 Y132.381 E.01538
G1 X123.999 Y132.004 E.01476
G1 X123.921 Y131.882 E.00432
M204 S10000
G1 X123.626 Y132.11 F42000
G1 F6364.866
M204 S6000
G1 X123.223 Y131.774 E.01563
G3 X122.247 Y132.185 I-2.319 J-4.147 E.03161
G1 X122.632 Y132.674 E.01856
G1 X123.228 Y133.28 E.02531
G2 X123.814 Y133.754 I6.169 J-7.035 E.02245
G3 X124.225 Y132.785 I4.659 J1.408 E.03142
G1 X123.951 Y132.55 E.01077
G1 X123.662 Y132.158 E.0145
M204 S10000
G1 X123.367 Y132.4 F42000
; LINE_WIDTH: 0.385671
G1 F7002.182
M204 S6000
G1 X123.165 Y132.221 E.00731
G1 X122.843 Y132.357 E.00947
G2 X123.652 Y133.181 I5.52 J-4.613 E.03129
G1 X123.78 Y132.871 E.00908
G1 X123.407 Y132.445 E.01532
; WIPE_START
G1 X123.78 Y132.871 E-.21495
G1 X123.652 Y133.181 E-.1274
G1 X123.185 Y132.738 E-.24455
G1 X122.881 Y132.399 E-.1731
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.131 Y132.373 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.39851
G1 F6749.346
M204 S6000
G1 X128.871 Y132.279 E.00775
; WIPE_START
G1 X129.131 Y132.373 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.855 Y131.936 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.419595
G1 F6371.546
M204 S6000
G1 X129.596 Y132.273 E.01263
G1 X129.24 Y132.388 E.01112
G1 X129.131 Y132.373 E.00329
G1 X129.619 Y132.626 E.01636
G1 X130.025 Y132.961 E.01565
G1 X130.326 Y133.315 E.01381
G1 X130.596 Y133.779 E.016
G1 X130.804 Y134.38 E.01891
G1 X130.874 Y134.933 E.0166
G1 X130.83 Y135.479 E.01627
G3 X130.598 Y136.225 I-3.031 J-.533 E.02332
G2 X136.219 Y130.607 I-2.585 J-8.208 E.2458
G1 X135.721 Y130.781 E.01568
G3 X133.592 Y130.502 I-.703 J-2.901 E.06536
G3 X132.409 Y129.209 I1.422 J-2.489 E.05303
G1 X132.185 Y129.496 E.01085
G1 X132.047 Y129.602 E.00515
G1 X132.095 Y129.913 E.00937
G1 X132.034 Y130.197 E.00865
G1 X131.835 Y130.416 E.0088
G1 X131.522 Y130.557 E.01022
G1 X131.469 Y130.948 E.01173
G1 X131.34 Y131.153 E.00721
G1 X131.141 Y131.283 E.00709
G1 X130.775 Y131.352 E.01106
G1 X130.609 Y131.742 E.01263
G1 X130.456 Y131.88 E.00612
G1 X130.233 Y131.96 E.00706
G1 X129.914 Y131.94 E.00949
M204 S10000
G1 X130.03 Y132.353 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X129.975 Y132.423 E.00265
G1 X130.306 Y132.71 E.01305
G1 X130.651 Y133.124 E.01603
G1 X130.935 Y133.614 E.01688
G1 X131.161 Y134.259 E.02037
G1 X131.245 Y134.804 E.0164
G1 X131.22 Y135.444 E.01909
G1 X131.188 Y135.609 E.00501
G2 X135.611 Y131.186 I-3.188 J-7.611 E.19109
G1 X134.95 Y131.248 E.01978
G1 X134.404 Y131.195 E.01635
G1 X133.845 Y131.036 E.01729
G3 X132.456 Y130.011 I1.148 J-3.01 E.05208
G1 X132.369 Y130.368 E.01096
G1 X132.108 Y130.684 E.0122
G1 X131.876 Y130.837 E.00828
G1 X131.758 Y131.219 E.01191
G1 X131.529 Y131.489 E.01054
G3 X131.049 Y131.711 I-.785 J-1.068 E.01587
G1 X130.909 Y131.971 E.0088
G1 X130.654 Y132.201 E.01021
G1 X130.282 Y132.334 E.01178
G1 X130.09 Y132.348 E.00573
; WIPE_START
G1 X130.282 Y132.334 E-.0731
G1 X130.654 Y132.201 E-.15027
G1 X130.909 Y131.971 E-.13031
G1 X131.049 Y131.711 E-.11221
G1 X131.277 Y131.635 E-.09125
G1 X131.529 Y131.489 E-.11082
G1 X131.686 Y131.304 E-.09205
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.321 Y132.011 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X131.208 Y132.2 E.00655
G1 X130.97 Y132.441 E.01008
G1 X130.703 Y132.588 E.00908
G1 X130.976 Y132.933 E.01308
G1 X131.274 Y133.448 E.01774
G1 X131.518 Y134.139 E.02181
G3 X131.648 Y134.975 I-9.336 J1.876 E.02523
G2 X134.977 Y131.645 I-3.665 J-6.993 E.14242
G3 X132.592 Y130.702 I.166 J-3.909 E.07783
G3 X132.214 Y131.089 I-1.682 J-1.268 E.01616
G1 X132.028 Y131.498 E.01337
G1 X131.766 Y131.783 E.01153
G1 X131.379 Y131.996 E.01317
M204 S10000
G1 X131.58 Y132.325 F42000
G1 F6364.866
M204 S6000
G1 X131.264 Y132.685 E.01427
G1 X131.551 Y133.168 E.01675
G3 X131.954 Y134.366 I-4.968 J2.336 E.03772
G2 X134.368 Y131.952 I-3.946 J-6.361 E.10258
G3 X133.278 Y131.608 I.725 J-4.196 E.03415
G1 X132.634 Y131.224 E.02235
G1 X132.533 Y131.331 E.00439
G1 X132.27 Y131.806 E.01616
G1 X131.908 Y132.148 E.01483
G1 X131.633 Y132.296 E.00931
M204 S10000
G1 X131.808 Y132.658 F42000
G1 F6364.866
M204 S6000
G1 X131.736 Y132.737 E.00319
G1 X132.023 Y133.282 E.01835
G1 X132.186 Y133.757 E.01497
G2 X133.754 Y132.194 I-4.198 J-5.781 E.06622
G3 X132.743 Y131.776 I2.558 J-7.611 E.03263
G1 X132.414 Y132.211 E.01625
G3 X131.858 Y132.626 I-2.378 J-2.609 E.02069
M204 S10000
G1 X132.202 Y132.83 F42000
; LINE_WIDTH: 0.369955
G1 F7338.677
M204 S6000
G1 X132.375 Y133.158 E.00958
G2 X133.179 Y132.36 I-3.908 J-4.739 E.02931
G1 X132.867 Y132.218 E.00884
G1 X132.461 Y132.644 E.0152
G1 X132.251 Y132.795 E.00669
; WIPE_START
G1 X132.461 Y132.644 E-.09838
G1 X132.867 Y132.218 E-.22356
G1 X133.179 Y132.36 E-.13005
G1 X132.891 Y132.681 E-.16385
G1 X132.612 Y132.938 E-.14416
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.793 Y136.794 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.353145
G1 F7736.338
M204 S6000
G1 X129.091 Y137.126 E.01903
M204 S10000
G1 X129.082 Y137.083 F42000
; LINE_WIDTH: 0.116553
G1 F15000
M204 S6000
G1 X128.953 Y137.122 E.00078
M204 S10000
G1 X129.082 Y137.083 F42000
; LINE_WIDTH: 0.155827
G1 F15000
M204 S6000
G1 X129.211 Y137.043 E.0012
; LINE_WIDTH: 0.177565
G1 X129.818 Y136.832 E.00683
; WIPE_START
G1 X129.211 Y137.043 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.042 Y137.117 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.117479
G1 F15000
M204 S6000
G1 X126.917 Y137.081 E.00077
; LINE_WIDTH: 0.161184
G1 X126.778 Y137.04 E.00136
; LINE_WIDTH: 0.192065
G1 X126.754 Y137.03 E.00031
; LINE_WIDTH: 0.172926
G1 X126.636 Y136.917 E.00168
; LINE_WIDTH: 0.123033
G1 X126.518 Y136.803 E.00103
; LINE_WIDTH: 0.0970886
G1 X126.496 Y136.779 E.00014
; WIPE_START
G1 X126.518 Y136.803 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.122 Y131.405 Z1.8 F42000
G1 X119.223 Y129.506 Z1.8
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.097082
G1 F15000
M204 S6000
G1 X119.199 Y129.484 E.00014
; LINE_WIDTH: 0.122744
G1 X119.087 Y129.368 E.00102
; LINE_WIDTH: 0.175233
G1 X118.975 Y129.251 E.00169
G1 X118.958 Y129.209 E.00047
; LINE_WIDTH: 0.157762
G1 X118.922 Y129.092 E.00111
; LINE_WIDTH: 0.117862
G1 X118.883 Y128.956 E.00083
; WIPE_START
G1 X118.922 Y129.092 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X118.883 Y127.044 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.11786
G1 F15000
M204 S6000
G1 X118.922 Y126.908 E.00083
; LINE_WIDTH: 0.157757
G1 X118.958 Y126.791 E.00111
; LINE_WIDTH: 0.174282
G1 X118.974 Y126.75 E.00046
G1 X119.097 Y126.623 E.00183
; LINE_WIDTH: 0.121723
G1 X119.219 Y126.495 E.0011
; WIPE_START
G1 X119.097 Y126.623 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.729 Y126.567 Z1.8 F42000
G1 X136.781 Y126.494 Z1.8
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.0970909
G1 F15000
M204 S6000
G1 X136.805 Y126.516 E.00014
; LINE_WIDTH: 0.122839
G1 X136.918 Y126.633 E.00102
; LINE_WIDTH: 0.17235
G1 X137.03 Y126.749 E.00166
; LINE_WIDTH: 0.188884
G1 X137.042 Y126.781 E.00039
; LINE_WIDTH: 0.158096
G1 X137.083 Y126.916 E.00129
; LINE_WIDTH: 0.116767
G1 X137.121 Y127.042 E.00076
; WIPE_START
G1 X137.083 Y126.916 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.121 Y128.959 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.116739
G1 F15000
M204 S6000
G1 X137.083 Y129.084 E.00076
; LINE_WIDTH: 0.158046
G1 X137.042 Y129.219 E.00128
; LINE_WIDTH: 0.188858
G1 X137.03 Y129.251 E.00039
; LINE_WIDTH: 0.172319
G1 X136.918 Y129.367 E.00166
; LINE_WIDTH: 0.122793
G1 X136.805 Y129.484 E.00102
; LINE_WIDTH: 0.0970648
G1 X136.781 Y129.506 E.00014
; OBJECT_ID: 114
; WIPE_START
G1 X136.805 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S10000
G1 X129.208 Y128.756 Z1.8 F42000
G1 X103.981 Y126.337 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
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
G1 X104.382 Y126.557 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
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
M204 S6000
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18163
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02174
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.556 Y119.579 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X108.577 Y119.601 E.00097
G3 X106.846 Y118.902 I-1.57 J1.396 E.3622
G3 X107.607 Y118.99 I.125 J2.266 E.02475
G1 X107.793 Y119.049 E.00629
G3 X108.345 Y119.377 I-.786 J1.948 E.02073
G1 X108.512 Y119.538 E.00746
M204 S250
G1 X108.283 Y119.862 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X106.876 Y119.294 I-1.276 J1.135 E.27281
G3 X107.488 Y119.363 I.102 J1.85 E.01845
G1 X107.646 Y119.413 E.00493
G3 X108.243 Y119.818 I-.639 J1.584 E.02164
; WIPE_START
M204 S6000
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
M204 S10000
G1 X114.8 Y126.089 Z1.8 F42000
G1 X115.652 Y126.693 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X115.811 Y126.927 E.00912
G3 X113.732 Y125.92 I-1.805 J1.076 E.34581
G3 X114.979 Y126.141 I.274 J2.086 E.04135
G3 X115.612 Y126.648 I-.972 J1.862 E.02626
M204 S250
G1 X115.331 Y126.918 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X115.481 Y127.124 E.00757
G3 X113.777 Y126.31 I-1.466 J.878 E.26014
G3 X114.706 Y126.439 I.244 J1.651 E.02834
G3 X115.296 Y126.871 I-.691 J1.562 E.02193
; WIPE_START
M204 S6000
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
M204 S10000
G1 X110.293 Y134.284 Z1.8 F42000
G1 X107.755 Y136.963 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X107.486 Y137.048 E.00906
G3 X106.812 Y132.911 I-.48 J-2.045 E.22155
G3 X108.049 Y133.179 I.194 J2.095 E.04135
G3 X107.811 Y136.943 I-1.043 J1.824 E.15057
M204 S250
G1 X107.636 Y136.59 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X107.396 Y136.665 E.00749
G3 X106.842 Y133.302 I-.381 J-1.664 E.16604
G3 X107.766 Y133.467 I.18 J1.66 E.02834
G3 X107.692 Y136.568 I-.75 J1.534 E.11589
; WIPE_START
M204 S6000
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
M204 S10000
G1 X102.457 Y129.394 Z1.8 F42000
G1 X102.035 Y128.539 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X102.018 Y128.637 E.00319
G3 X99.892 Y125.905 I-2.003 J-.634 E.2937
G3 X101.282 Y126.327 I.109 J2.145 E.04765
G3 X102.091 Y128.322 I-1.267 J1.676 E.07269
G1 X102.05 Y128.481 E.00528
M204 S250
G1 X101.648 Y128.438 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X101.612 Y128.609 E.00521
G3 X99.907 Y126.297 I-1.597 J-.608 E.21806
G3 X100.824 Y126.497 I.117 J1.665 E.02834
G3 X101.703 Y128.262 I-.809 J1.505 E.06261
G1 X101.666 Y128.381 E.00372
; WIPE_START
M204 S6000
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
M204 S10000
G1 X103.946 Y122.976 Z1.8 F42000
G1 X106.305 Y118.633 Z1.8
G1 Z1.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X107.237 Y118.609 I.712 J9.481 E.02999
G3 X103.573 Y119.252 I-.24 J9.392 E1.77791
G3 X106.245 Y118.638 I3.444 J8.862 E.08846
M204 S250
G1 X106.275 Y118.237 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X106.276 Y118.241 E.00012
G3 X107.243 Y118.217 I.731 J9.758 E.02883
G3 X116.2 Y124.646 I-.238 J9.785 E.34884
G3 X105.693 Y118.303 I-9.193 J3.354 E1.43631
G1 X106.216 Y118.244 E.01566
M204 S10000
G1 X106.047 Y118.883 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.117505
G1 F15000
M204 S6000
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
M204 S10000
G1 X107.958 Y118.878 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.116549
G1 F15000
M204 S6000
G1 X108.087 Y118.917 E.00078
; LINE_WIDTH: 0.155821
G1 X108.216 Y118.957 E.0012
; LINE_WIDTH: 0.177556
G1 X108.822 Y119.168 E.00683
M204 S10000
G1 X108.797 Y119.206 F42000
; LINE_WIDTH: 0.353121
G1 F7736.933
M204 S6000
G1 X108.095 Y118.874 E.01903
; WIPE_START
G1 X108.797 Y119.206 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X111.215 Y123.175 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.370126
G1 F7334.842
M204 S6000
G1 X111.667 Y123.544 E.0151
G1 X111.872 Y123.782 E.00811
G1 X112.183 Y123.64 E.00886
G1 X111.686 Y123.113 E.01874
G1 X111.365 Y122.845 E.0108
G1 X111.24 Y123.12 E.00783
M204 S10000
G1 X110.866 Y123.388 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X111.244 Y123.63 E.01339
M73 P65 R5
G1 X111.57 Y123.961 E.01383
G1 X111.757 Y124.249 E.01022
G1 X112.378 Y123.935 E.02072
G1 X112.76 Y123.808 E.012
G2 X111.201 Y122.25 I-5.864 J4.311 E.06591
G1 X110.95 Y122.898 E.02071
G1 X110.749 Y123.269 E.01257
G1 X110.824 Y123.345 E.00315
M204 S10000
G1 X110.584 Y123.675 F42000
G1 F6364.866
M204 S6000
G1 X111.007 Y123.924 E.01461
G3 X111.464 Y124.496 I-1.066 J1.32 E.02197
G1 X111.578 Y124.723 E.00757
G1 X111.647 Y124.79 E.00286
G3 X112.532 Y124.28 I1.899 J2.271 E.03059
G1 X113.38 Y124.058 E.0261
G2 X110.958 Y121.634 I-6.376 J3.949 E.10296
G1 X110.815 Y122.23 E.01826
G1 X110.606 Y122.744 E.01653
G1 X110.27 Y123.315 E.01974
G1 X110.545 Y123.63 E.01244
M204 S10000
G1 X110.325 Y123.989 F42000
G1 F6364.866
M204 S6000
G1 X110.672 Y124.145 E.01135
G1 X110.978 Y124.427 E.01238
G3 X111.248 Y124.95 I-2.301 J1.52 E.01757
G1 X111.557 Y125.226 E.0123
G1 X111.605 Y125.299 E.00262
G1 X112.125 Y124.907 E.01938
G1 X112.687 Y124.624 E.01875
G1 X113.363 Y124.443 E.02084
G1 X114.001 Y124.392 E.01909
G2 X110.841 Y121.126 I-7.005 J3.616 E.13731
G1 X110.632 Y121.038 E.00678
G3 X109.708 Y123.411 I-3.75 J-.093 E.07741
G1 X110.02 Y123.597 E.01081
G1 X110.299 Y123.934 E.01306
M204 S10000
G1 X110.082 Y124.312 F42000
G1 F6364.866
M204 S6000
G1 X110.417 Y124.43 E.01059
G1 X110.682 Y124.661 E.01046
G1 X110.853 Y125.004 E.01143
G1 X110.902 Y125.192 E.0058
G1 X111.114 Y125.317 E.00734
G1 X111.371 Y125.625 E.01194
G1 X111.461 Y125.995 E.01132
G1 X111.893 Y125.544 E.0186
G1 X112.347 Y125.212 E.01677
G1 X112.841 Y124.968 E.0164
G1 X113.446 Y124.811 E.01863
G1 X114.228 Y124.765 E.02333
G1 X114.616 Y124.814 E.01164
G1 X114.221 Y123.996 E.02706
G2 X110.193 Y120.391 I-7.327 J4.133 E.16391
G1 X110.25 Y120.909 E.01554
G1 X110.209 Y121.547 E.01904
G3 X108.965 Y123.574 I-3.134 J-.529 E.07258
G1 X109.092 Y123.661 E.00459
G1 X109.428 Y123.696 E.01006
G1 X109.775 Y123.884 E.01177
G3 X110.052 Y124.26 I-.795 J.875 E.014
; WIPE_START
G1 X109.965 Y124.104 E-.0678
G1 X109.775 Y123.884 E-.11048
G1 X109.428 Y123.696 E-.1502
G1 X109.092 Y123.661 E-.12829
G1 X108.965 Y123.574 E-.0585
G1 X109.174 Y123.416 E-.09961
G1 X109.438 Y123.139 E-.14512
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.859 Y124.064 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.419669
G1 F6370.302
M204 S6000
G1 X109.213 Y124.037 E.01055
G1 X109.461 Y124.12 E.00778
G1 X109.645 Y124.303 E.00772
G1 X109.78 Y124.648 E.01103
G1 X110.193 Y124.738 E.0126
G1 X110.386 Y124.894 E.00737
G1 X110.488 Y125.1 E.00685
G1 X110.526 Y125.443 E.01026
G1 X110.883 Y125.615 E.01177
G1 X111.036 Y125.8 E.00716
G1 X111.093 Y126.153 E.01066
G1 X111.052 Y126.398 E.00739
G1 X111.379 Y126.688 E.01301
G1 X111.417 Y126.758 E.00235
G1 X111.699 Y126.293 E.01616
G1 X112.116 Y125.849 E.01815
G1 X112.57 Y125.516 E.01676
G1 X113.101 Y125.276 E.01733
G1 X113.698 Y125.152 E.01815
G1 X114.261 Y125.142 E.01675
G1 X114.809 Y125.242 E.0166
G1 X115.223 Y125.393 E.0131
G2 X109.602 Y119.775 I-8.194 J2.578 E.24588
G1 X109.787 Y120.281 E.01603
G1 X109.873 Y120.924 E.01931
G1 X109.834 Y121.504 E.01731
G1 X109.695 Y122.012 E.01566
G3 X108.948 Y123.115 I-2.937 J-1.185 E.03995
G1 X108.453 Y123.472 E.01815
G1 X108.058 Y123.649 E.01289
G1 X108.459 Y123.645 E.01193
G1 X108.721 Y123.857 E.01003
G1 X108.826 Y124.014 E.00561
; WIPE_START
G1 X108.721 Y123.857 E-.0716
G1 X108.459 Y123.645 E-.12806
G1 X108.058 Y123.649 E-.15233
G1 X108.453 Y123.472 E-.16455
G1 X108.948 Y123.115 E-.23175
G1 X108.969 Y123.092 E-.01172
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.819 Y123.741 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.39859
G1 F6747.828
M204 S6000
G1 X108.002 Y123.67 E.00551
; WIPE_START
G1 X107.819 Y123.741 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.392 Y123.572 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.38686
G1 F6977.973
M204 S6000
G1 X102.783 Y123.129 E.01606
G1 X102.647 Y122.828 E.00898
G2 X101.862 Y123.633 I4.228 J4.906 E.03058
G1 X102.169 Y123.773 E.00918
G1 X102.347 Y123.612 E.00652
M204 S10000
G1 X102.631 Y123.89 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X102.955 Y123.451 E.01627
G1 X103.23 Y123.215 E.01079
G1 X102.942 Y122.629 E.01946
G1 X102.813 Y122.25 E.01191
G2 X101.258 Y123.806 I4.045 J5.598 E.06582
G3 X102.227 Y124.226 I-1.383 J4.525 E.03154
G1 X102.584 Y123.929 E.01385
M204 S10000
G1 X102.925 Y124.135 F42000
G1 F6364.866
M204 S6000
G1 X103.225 Y123.714 E.01539
G3 X103.764 Y123.344 I1.185 J1.148 E.01961
G3 X103.053 Y121.634 I3.377 J-2.407 E.05563
G2 X100.635 Y124.055 I3.98 J6.393 E.10282
G1 X101.237 Y124.192 E.01837
G1 X101.769 Y124.409 E.01712
G1 X102.315 Y124.731 E.01889
G1 X102.599 Y124.386 E.01332
G1 X102.878 Y124.172 E.01047
M204 S10000
G1 X103.214 Y124.439 F42000
G1 F6364.866
M204 S6000
G1 X103.377 Y124.116 E.01077
G1 X103.679 Y123.821 E.01257
G1 X104.083 Y123.628 E.01336
G1 X104.214 Y123.599 E.00397
G1 X104.342 Y123.452 E.0058
G3 X103.382 Y121.038 I2.788 J-2.507 E.07903
G1 X103.274 Y121.068 E.00333
G2 X100.512 Y123.55 I3.855 J7.067 E.11162
G1 X100.018 Y124.373 E.02858
G3 X102.472 Y125.347 I-.07 J3.753 E.08034
G1 X102.625 Y124.943 E.01286
G1 X102.939 Y124.593 E.01401
G1 X103.162 Y124.468 E.00762
; WIPE_START
G1 X102.939 Y124.593 E-.09722
G1 X102.625 Y124.943 E-.17869
G1 X102.472 Y125.347 E-.16403
G1 X102.123 Y125.057 E-.17219
G1 X101.789 Y124.857 E-.14787
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.808 Y125.671 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X102.881 Y125.269 E.01217
G1 X103.111 Y124.941 E.01193
G3 X103.519 Y124.7 I.864 J.997 E.01421
G1 X103.681 Y124.34 E.01176
G1 X103.896 Y124.128 E.00898
G1 X104.236 Y123.978 E.01107
G1 X104.449 Y123.936 E.00647
G1 X104.679 Y123.642 E.01111
G1 X104.941 Y123.501 E.00886
G1 X104.523 Y123.089 E.01748
G1 X104.188 Y122.615 E.01729
G1 X103.955 Y122.118 E.01635
G1 X103.805 Y121.547 E.01758
G1 X103.758 Y121.052 E.01481
G1 X103.82 Y120.393 E.01972
G2 X99.396 Y124.821 I3.188 J7.609 E.19123
G1 X99.938 Y124.761 E.01624
G1 X100.5 Y124.793 E.01677
G1 X101.037 Y124.919 E.01641
G1 X101.553 Y125.141 E.01673
G1 X102.033 Y125.461 E.01719
G3 X102.527 Y125.957 I-1.634 J2.119 E.0209
G3 X102.762 Y125.71 I1.008 J.724 E.01021
M204 S10000
G1 X103.194 Y125.904 F42000
G1 F6364.866
M204 S6000
G1 X103.19 Y125.556 E.01036
G1 X103.268 Y125.338 E.00691
G1 X103.464 Y125.145 E.00819
G1 X103.835 Y125.022 E.01165
G1 X103.966 Y124.591 E.01341
G1 X104.114 Y124.436 E.00638
G1 X104.361 Y124.338 E.00791
G1 X104.676 Y124.327 E.00938
G1 X104.845 Y124.011 E.01067
G1 X104.994 Y123.877 E.00598
G1 X105.28 Y123.792 E.00888
G1 X105.662 Y123.862 E.01158
G1 X105.884 Y123.638 E.00939
G1 X105.39 Y123.374 E.0167
G1 X104.984 Y123.039 E.01567
G1 X104.697 Y122.707 E.01309
G1 X104.432 Y122.265 E.01534
G1 X104.235 Y121.733 E.0169
G1 X104.139 Y121.153 E.0175
G1 X104.159 Y120.628 E.01566
G3 X104.397 Y119.778 I3.299 J.467 E.02638
G2 X98.779 Y125.406 I2.61 J8.223 E.24618
G1 X99.312 Y125.215 E.01686
G1 X99.917 Y125.137 E.01816
G1 X100.479 Y125.17 E.01677
G3 X102.106 Y126.04 I-.46 J2.818 E.05597
; LINE_WIDTH: 0.44076
G1 F6032.575
G1 X102.276 Y126.245 E.00836
; LINE_WIDTH: 0.4823
G1 F5462.242
G1 X102.445 Y126.45 E.00924
; LINE_WIDTH: 0.52384
G1 F4990.435
G1 X102.615 Y126.655 E.01011
; LINE_WIDTH: 0.555465
G1 F4682.516
G1 X102.652 Y126.701 E.00239
; LINE_WIDTH: 0.541932
G1 F4809.507
G1 X102.676 Y126.582 E.00479
; LINE_WIDTH: 0.493155
G1 F5330.549
G1 X102.701 Y126.463 E.00432
; LINE_WIDTH: 0.424103
G1 F6296.195
G1 X102.725 Y126.344 E.00366
G1 X102.885 Y126.098 E.00885
G1 X103.144 Y125.936 E.00917
; WIPE_START
G1 X102.885 Y126.098 E-.3216
G1 X102.725 Y126.344 E-.31024
G1 X102.701 Y126.463 E-.12816
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.722 Y126.9 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.55596
G1 F4677.998
M204 S6000
G1 X102.672 Y126.758 E.00611
M204 S10000
G1 X103.219 Y127.028 F42000
; LINE_WIDTH: 0.423377
G1 F6308.207
M204 S6000
G1 X103.079 Y126.555 E.01481
G3 X103.169 Y126.355 I.185 J-.037 E.00704
G1 X103.58 Y126.116 E.01429
G1 X103.563 Y125.608 E.01528
G1 X103.655 Y125.471 E.00495
G1 X104.156 Y125.323 E.01572
G1 X104.272 Y124.813 E.01571
G1 X104.4 Y124.714 E.00486
G1 X104.911 Y124.698 E.01539
G1 X105.144 Y124.242 E.01539
G1 X105.288 Y124.169 E.00488
G1 X105.798 Y124.281 E.01569
G1 X106.201 Y123.842 E.01791
G1 X106.335 Y123.852 E.00404
; LINE_WIDTH: 0.477535
G1 F5522.129
G1 X106.546 Y123.946 E.00794
; LINE_WIDTH: 0.504385
G1 F5200.828
G1 X106.758 Y124.04 E.00843
; LINE_WIDTH: 0.500507
G1 F5244.908
G1 X106.89 Y123.97 E.00541
; LINE_WIDTH: 0.4659
G1 F5674.027
G1 X107.022 Y123.9 E.005
; LINE_WIDTH: 0.419332
G1 F6376.002
G1 X107.154 Y123.83 E.00445
G1 X107.348 Y123.824 E.00578
G1 X107.739 Y124.159 E.01531
G1 X108.186 Y123.994 E.01414
G1 X108.354 Y124.014 E.00506
G1 X108.672 Y124.462 E.01632
G1 X109.18 Y124.413 E.01519
G1 X109.314 Y124.487 E.00454
G1 X109.499 Y124.987 E.01586
G1 X110.009 Y125.068 E.01535
G1 X110.119 Y125.18 E.00465
G1 X110.17 Y125.702 E.01559
G1 X110.637 Y125.902 E.01509
G1 X110.702 Y125.974 E.00288
G1 X110.708 Y126.166 E.00573
G1 X110.642 Y126.56 E.01189
G1 X111.064 Y126.895 E.016
; LINE_WIDTH: 0.444723
G1 F5973.084
G1 X111.1 Y126.979 E.00288
; LINE_WIDTH: 0.494188
G1 F5318.354
G1 X111.135 Y127.062 E.00324
; LINE_WIDTH: 0.53284
G1 F4898.759
G1 X110.96 Y127.501 E.01828
; LINE_WIDTH: 0.526575
G1 F4962.215
G1 X111.034 Y127.628 E.00562
; LINE_WIDTH: 0.486205
G1 F5414.124
G1 X111.108 Y127.755 E.00515
; LINE_WIDTH: 0.433384
G1 F6146.546
G1 X111.183 Y127.882 E.00454
G1 X111.183 Y128.118 E.00731
; LINE_WIDTH: 0.446095
G1 F5952.75
G1 X111.109 Y128.245 E.00468
; LINE_WIDTH: 0.486985
G1 F5404.615
G1 X111.035 Y128.372 E.00516
; LINE_WIDTH: 0.537237
G1 F4855.191
G1 X110.961 Y128.499 E.00574
G1 X111.149 Y128.973 E.01992
; LINE_WIDTH: 0.512957
G1 F5105.985
G1 X111.106 Y129.033 E.00271
; LINE_WIDTH: 0.47577
G1 F5544.646
G1 X111.063 Y129.092 E.0025
; LINE_WIDTH: 0.420244
G1 F6360.583
G1 X111.02 Y129.151 E.00218
G1 X110.642 Y129.439 E.01417
G1 X110.714 Y129.999 E.0168
G1 X110.608 Y130.113 E.00464
G1 X110.17 Y130.298 E.01417
G1 X110.124 Y130.803 E.01511
G1 X110.026 Y130.924 E.00464
G1 X109.499 Y131.013 E.01591
G1 X109.324 Y131.499 E.01539
G1 X109.188 Y131.586 E.00481
G1 X108.672 Y131.538 E.01547
G1 X108.389 Y131.957 E.01508
G1 X108.249 Y132.017 E.00453
G1 X107.739 Y131.841 E.01606
; LINE_WIDTH: 0.412299
G1 F6497.391
G1 X107.348 Y132.175 E.01502
G1 X107.151 Y132.175 E.00574
; LINE_WIDTH: 0.447688
G1 F5929.33
G1 X106.954 Y132.067 E.00717
; LINE_WIDTH: 0.491935
G1 F5345.036
G1 X106.758 Y131.96 E.00795
G1 X106.291 Y132.161 E.01802
; LINE_WIDTH: 0.422102
G1 F6329.427
G1 X106.202 Y132.154 E.00267
G1 X105.798 Y131.719 E.01777
G1 X105.234 Y131.822 E.01719
G1 X105.124 Y131.727 E.00435
G1 X104.911 Y131.302 E.01424
G1 X104.4 Y131.286 E.01534
G1 X104.272 Y131.187 E.00484
G1 X104.156 Y130.677 E.01566
G1 X103.655 Y130.529 E.01566
G1 X103.563 Y130.392 E.00493
G1 X103.58 Y129.884 E.01523
G1 X103.138 Y129.622 E.0154
G1 X103.081 Y129.529 E.00325
G1 X103.219 Y128.972 E.01719
G1 X102.88 Y128.639 E.01424
G1 X102.836 Y128.443 E.00602
; LINE_WIDTH: 0.438668
G1 F6064.474
G1 X102.942 Y128.221 E.00766
; LINE_WIDTH: 0.466897
G1 F5660.695
G1 X103.047 Y128 E.00821
G1 X102.831 Y127.529 E.01735
; LINE_WIDTH: 0.418869
G1 F6383.845
G1 X102.901 Y127.341 E.00597
G1 X103.176 Y127.07 E.01149
; WIPE_START
G1 X102.901 Y127.341 E-.50024
G1 X102.831 Y127.529 E-.25976
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.541 Y128.017 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.477073
G1 F5528.012
M204 S6000
G1 X102.453 Y128.397 E.01335
; LINE_WIDTH: 0.420899
G1 F6349.559
G1 X102.364 Y128.776 E.01163
G1 X102.062 Y129.415 E.0211
G3 X100.682 Y130.396 I-2.065 J-1.444 E.05155
G1 X100.127 Y130.492 E.01681
G1 X99.698 Y130.476 E.01283
G1 X99.181 Y130.348 E.01591
G1 X98.672 Y130.108 E.01681
G1 X98.406 Y129.895 E.01016
G1 X98.316 Y129.987 E.00384
G1 X98.23 Y130.001 E.0026
G2 X105.025 Y136.781 I8.787 J-2.013 E.30223
G1 X105.051 Y136.654 E.00385
G1 X105.111 Y136.601 E.0024
G3 X104.514 Y134.882 I1.816 J-1.594 E.05571
G1 X104.597 Y134.373 E.01539
G1 X104.803 Y133.83 E.01733
G1 X105.048 Y133.458 E.01331
G1 X105.411 Y133.09 E.01542
G1 X105.877 Y132.775 E.01681
G1 X106.369 Y132.575 E.01586
; LINE_WIDTH: 0.47993
G1 F5491.866
G1 X106.801 Y132.482 E.01524
; LINE_WIDTH: 0.479454
G1 F5497.862
G1 X106.971 Y132.502 E.0059
; LINE_WIDTH: 0.44574
G1 F5957.996
G1 X107.14 Y132.522 E.00544
; LINE_WIDTH: 0.41963
G1 F6370.96
G3 X107.774 Y132.625 I-.559 J5.438 E.0191
G1 X108.127 Y132.77 E.01137
G1 X108.556 Y133.051 E.01527
G1 X108.983 Y133.475 E.01791
G1 X109.255 Y133.932 E.01581
G1 X109.451 Y134.5 E.0179
G1 X109.496 Y135.062 E.01676
G1 X109.417 Y135.647 E.01759
G3 X109.058 Y136.395 I-2.017 J-.51 E.02485
G1 X109.206 Y136.729 E.01087
G2 X115.783 Y129.981 I-2.188 J-8.712 E.29516
G1 X115.661 Y129.956 E.0037
G1 X115.608 Y129.895 E.00239
G1 X115.329 Y130.115 E.01054
G1 X114.925 Y130.316 E.01345
G1 X114.307 Y130.478 E.01899
G1 X113.897 Y130.494 E.01222
G1 X113.27 Y130.38 E.01895
G1 X112.802 Y130.186 E.01509
G3 X111.914 Y129.344 I1.297 J-2.258 E.03674
; LINE_WIDTH: 0.438584
G1 F6065.763
G1 X111.818 Y129.189 E.00572
; LINE_WIDTH: 0.47577
G1 F5544.646
G1 X111.722 Y129.033 E.00626
; LINE_WIDTH: 0.52445
G1 F4984.118
G1 X111.626 Y128.877 E.00697
G1 X111.494 Y128.421 E.01805
; LINE_WIDTH: 0.501354
G1 F5235.221
G1 X111.507 Y128.276 E.00525
; LINE_WIDTH: 0.45162
G1 F5872.278
G1 X111.519 Y128.132 E.00468
; LINE_WIDTH: 0.401887
G1 F6685.857
G1 X111.532 Y127.987 E.00411
; LINE_WIDTH: 0.398238
G1 F6754.522
G1 X111.523 Y127.871 E.00328
; LINE_WIDTH: 0.440673
G1 F6033.903
G1 X111.514 Y127.754 E.00367
; LINE_WIDTH: 0.483108
G1 F5452.222
G1 X111.506 Y127.638 E.00406
; LINE_WIDTH: 0.530884
G1 F4918.396
G1 X111.497 Y127.521 E.0045
G1 X111.586 Y127.215 E.0123
; LINE_WIDTH: 0.494188
G1 F5318.354
G1 X111.74 Y126.947 E.01102
; LINE_WIDTH: 0.420379
G1 F6358.309
G1 X111.895 Y126.68 E.00922
G1 X112.31 Y126.179 E.01939
G1 X112.793 Y125.82 E.01793
G1 X113.189 Y125.643 E.01295
G1 X113.705 Y125.529 E.01574
G1 X114.268 Y125.519 E.01678
G3 X115.497 Y126.013 I-.293 J2.504 E.03995
G1 X115.607 Y126.104 E.00429
G3 X115.784 Y126 I.16 J.07 E.00654
G2 X109.206 Y119.271 I-8.778 J2.001 E.29524
G1 X109.058 Y119.605 E.0109
G1 X109.29 Y119.992 E.01346
G1 X109.464 Y120.593 E.01866
G1 X109.5 Y121.11 E.01544
G3 X109.319 Y121.927 I-2.364 J-.094 E.02509
G1 X109 Y122.502 E.01959
G1 X108.721 Y122.814 E.01249
G1 X108.293 Y123.131 E.01589
G1 X107.783 Y123.371 E.01679
; LINE_WIDTH: 0.41036
G1 F6531.679
G1 X107.373 Y123.459 E.01219
; LINE_WIDTH: 0.420244
G1 F6360.593
G1 X107.168 Y123.482 E.00614
; LINE_WIDTH: 0.45927
G1 F5764.381
G1 X106.963 Y123.504 E.00678
; LINE_WIDTH: 0.495891
G1 F5298.355
G1 X106.758 Y123.527 E.00737
G1 X106.261 Y123.409 E.01827
; LINE_WIDTH: 0.45902
G1 F5767.844
G1 X106.004 Y123.279 E.00948
; LINE_WIDTH: 0.420084
G1 F6363.292
G1 X105.747 Y123.148 E.00859
G1 X105.286 Y122.808 E.01706
G3 X104.599 Y121.633 I1.977 J-1.945 E.041
G1 X104.513 Y121.11 E.01578
G3 X104.735 Y119.966 I2.785 J-.053 E.03498
G1 X105.02 Y119.51 E.01601
G1 X105.111 Y119.399 E.0043
G3 X105.007 Y119.223 I.07 J-.16 E.00649
G2 X98.232 Y126.029 I1.998 J8.765 E.30185
G3 X98.39 Y126.111 I.017 J.161 E.00561
G1 X98.937 Y125.75 E.01952
G1 X99.367 Y125.588 E.01371
G1 X99.895 Y125.514 E.01587
G1 X100.457 Y125.546 E.01677
G1 X101.026 Y125.728 E.01779
G1 X101.508 Y126.006 E.01659
G3 X102.314 Y127.064 I-1.614 J2.065 E.04006
G1 X102.468 Y127.605 E.01676
; LINE_WIDTH: 0.434105
G1 F6135.205
G1 X102.499 Y127.782 E.00554
; LINE_WIDTH: 0.475455
G1 F5548.684
G1 X102.53 Y127.958 E.00612
; WIPE_START
G1 X102.499 Y127.782 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.194 Y130.096 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X102.885 Y129.902 E.01086
G1 X102.716 Y129.625 E.00969
; LINE_WIDTH: 0.440934
G1 F6029.949
G1 X102.715 Y129.456 E.0053
; LINE_WIDTH: 0.48282
G1 F5455.786
G1 X102.715 Y129.288 E.00586
; LINE_WIDTH: 0.525896
G1 F4969.196
G1 X102.717 Y129.11 E.00676
; LINE_WIDTH: 0.527232
G1 F4955.486
G1 X102.61 Y129.27 E.00734
; LINE_WIDTH: 0.484335
G1 F5437.06
G1 X102.503 Y129.429 E.00669
; LINE_WIDTH: 0.420185
G1 F6361.586
G3 X101.713 Y130.31 I-3.008 J-1.903 E.03543
G3 X99.642 Y130.849 I-1.744 J-2.453 E.06521
G1 X99.129 Y130.727 E.01571
G1 X98.772 Y130.572 E.01163
G1 X99.097 Y131.442 E.02768
G2 X104.404 Y136.214 I7.891 J-3.437 E.21932
G1 X104.226 Y135.721 E.01562
G3 X104.234 Y134.272 I3.053 J-.709 E.04359
G1 X104.451 Y133.696 E.01833
G1 X104.766 Y133.206 E.01736
G1 X105.2 Y132.778 E.01817
G1 X105.666 Y132.463 E.01677
G1 X105.884 Y132.361 E.00717
G1 X105.662 Y132.138 E.0094
G3 X105.116 Y132.18 I-.349 J-.957 E.01652
G1 X104.845 Y131.989 E.00988
G1 X104.676 Y131.673 E.01068
G1 X104.312 Y131.653 E.01086
G1 X104.069 Y131.528 E.00813
G1 X103.935 Y131.356 E.00648
G1 X103.835 Y130.978 E.01166
G1 X103.42 Y130.826 E.0132
G1 X103.268 Y130.662 E.00665
G3 X103.193 Y130.156 I.677 J-.359 E.01556
M204 S10000
G1 X102.79 Y130.297 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G3 X102.527 Y130.043 I.294 J-.569 E.01106
G3 X100.997 Y131.086 I-2.421 J-1.906 E.056
G3 X100.034 Y131.247 I-1.251 J-4.515 E.02913
G1 X99.522 Y131.209 E.0153
G1 X99.397 Y131.179 E.00384
G2 X100.825 Y133.463 I7.759 J-3.264 E.08058
G2 X103.085 Y135.259 I6.355 J-5.677 E.08641
G2 X103.82 Y135.607 I3.238 J-5.888 E.02423
G1 X103.758 Y134.948 E.01972
G1 X103.848 Y134.274 E.02024
G1 X104.098 Y133.562 E.0225
G1 X104.38 Y133.088 E.01641
G1 X104.84 Y132.589 E.02023
G1 X104.935 Y132.51 E.00368
G1 X104.822 Y132.46 E.00368
G1 X104.505 Y132.16 E.013
G1 X104.418 Y132.044 E.00431
G1 X104.05 Y131.96 E.01125
G1 X103.766 Y131.76 E.01036
G3 X103.494 Y131.274 I.922 J-.834 E.01674
G1 X103.17 Y131.11 E.0108
G1 X102.946 Y130.86 E.01
G1 X102.816 Y130.495 E.01152
G1 X102.798 Y130.357 E.00417
; WIPE_START
G1 X102.816 Y130.495 E-.05322
G1 X102.946 Y130.86 E-.14697
G1 X103.17 Y131.11 E-.12761
G1 X103.494 Y131.274 E-.13779
G1 X103.599 Y131.526 E-.10379
G1 X103.766 Y131.76 E-.10926
G1 X103.941 Y131.883 E-.08136
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.214 Y131.561 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X102.939 Y131.407 E.00941
G1 X102.625 Y131.057 E.014
G1 X102.472 Y130.654 E.01285
G1 X102.123 Y130.943 E.01349
G1 X101.632 Y131.24 E.0171
G1 X101.159 Y131.428 E.01515
G3 X100.03 Y131.648 I-2.249 J-8.504 E.03428
G1 X100.482 Y132.405 E.02624
G2 X103.383 Y134.987 I6.583 J-4.475 E.11686
G3 X104.064 Y132.883 I4.026 J.141 E.06672
G1 X104.357 Y132.545 E.01335
G1 X104.14 Y132.387 E.00801
G1 X103.679 Y132.179 E.01506
G1 X103.367 Y131.869 E.0131
G1 X103.241 Y131.615 E.00846
M204 S10000
G1 X102.893 Y131.831 F42000
G1 F6364.866
M204 S6000
G1 X102.498 Y131.512 E.01514
G1 X102.315 Y131.269 E.00906
G1 X101.781 Y131.586 E.0185
G1 X101.298 Y131.778 E.01548
G1 X100.629 Y131.936 E.02046
G2 X103.067 Y134.376 I6.68 J-4.234 E.10356
G3 X103.747 Y132.678 I4.379 J.77 E.05486
G1 X103.325 Y132.381 E.01538
G1 X103.003 Y132.004 E.01476
G1 X102.925 Y131.882 E.00432
M204 S10000
G1 X102.631 Y132.11 F42000
G1 F6364.866
M204 S6000
G1 X102.227 Y131.774 E.01563
G3 X101.251 Y132.185 I-2.319 J-4.147 E.03161
G1 X101.637 Y132.674 E.01856
G1 X102.232 Y133.28 E.02531
G2 X102.818 Y133.754 I6.169 J-7.035 E.02245
G3 X103.23 Y132.785 I4.659 J1.408 E.03142
G1 X102.956 Y132.55 E.01077
G1 X102.666 Y132.158 E.0145
M204 S10000
G1 X102.372 Y132.4 F42000
; LINE_WIDTH: 0.385671
G1 F7002.182
M204 S6000
G1 X102.17 Y132.221 E.00731
G1 X101.848 Y132.357 E.00947
G2 X102.657 Y133.181 I5.52 J-4.613 E.03129
G1 X102.784 Y132.871 E.00908
G1 X102.411 Y132.445 E.01532
; WIPE_START
G1 X102.784 Y132.871 E-.21495
G1 X102.657 Y133.181 E-.1274
G1 X102.19 Y132.738 E-.24455
G1 X101.886 Y132.399 E-.1731
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.135 Y132.373 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.39851
G1 F6749.346
M204 S6000
G1 X107.876 Y132.279 E.00775
; WIPE_START
G1 X108.135 Y132.373 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.859 Y131.936 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.419595
G1 F6371.546
M204 S6000
G1 X108.601 Y132.273 E.01263
G1 X108.245 Y132.388 E.01112
G1 X108.135 Y132.373 E.00329
G1 X108.624 Y132.626 E.01636
G1 X109.029 Y132.961 E.01565
G1 X109.33 Y133.315 E.01381
G1 X109.601 Y133.779 E.016
G1 X109.808 Y134.38 E.01891
G1 X109.878 Y134.933 E.0166
G1 X109.834 Y135.479 E.01627
G3 X109.602 Y136.225 I-3.031 J-.533 E.02332
G2 X115.223 Y130.607 I-2.585 J-8.208 E.2458
G1 X114.726 Y130.781 E.01568
G3 X112.597 Y130.502 I-.703 J-2.901 E.06536
G3 X111.413 Y129.209 I1.422 J-2.489 E.05303
G1 X111.189 Y129.496 E.01085
G1 X111.052 Y129.602 E.00515
G1 X111.1 Y129.913 E.00937
G1 X111.038 Y130.197 E.00865
G1 X110.839 Y130.416 E.0088
G1 X110.526 Y130.557 E.01022
G1 X110.473 Y130.948 E.01173
G1 X110.344 Y131.153 E.00721
G1 X110.145 Y131.283 E.00709
G1 X109.78 Y131.352 E.01106
G1 X109.613 Y131.742 E.01263
G1 X109.461 Y131.88 E.00612
G1 X109.237 Y131.96 E.00706
G1 X108.919 Y131.94 E.00949
M204 S10000
G1 X109.035 Y132.353 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X108.98 Y132.423 E.00265
G1 X109.311 Y132.71 E.01305
G1 X109.655 Y133.124 E.01603
G1 X109.94 Y133.614 E.01688
G1 X110.166 Y134.259 E.02037
G1 X110.249 Y134.804 E.0164
G1 X110.225 Y135.444 E.01909
G1 X110.193 Y135.609 E.00501
G2 X114.616 Y131.186 I-3.188 J-7.611 E.19109
G1 X113.955 Y131.248 E.01978
G1 X113.408 Y131.195 E.01635
G1 X112.85 Y131.036 E.01729
G3 X111.46 Y130.011 I1.148 J-3.01 E.05208
G1 X111.374 Y130.368 E.01096
G1 X111.113 Y130.684 E.0122
G1 X110.881 Y130.837 E.00828
G1 X110.762 Y131.219 E.01191
G1 X110.534 Y131.489 E.01054
G3 X110.053 Y131.711 I-.785 J-1.068 E.01587
G1 X109.913 Y131.971 E.0088
G1 X109.659 Y132.201 E.01021
G1 X109.286 Y132.334 E.01178
G1 X109.094 Y132.348 E.00573
; WIPE_START
G1 X109.286 Y132.334 E-.0731
G1 X109.659 Y132.201 E-.15027
G1 X109.913 Y131.971 E-.13031
G1 X110.053 Y131.711 E-.11221
G1 X110.281 Y131.635 E-.09125
G1 X110.534 Y131.489 E-.11082
G1 X110.69 Y131.304 E-.09205
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.325 Y132.011 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X110.213 Y132.2 E.00655
G1 X109.974 Y132.441 E.01008
G1 X109.708 Y132.588 E.00908
G1 X109.98 Y132.933 E.01308
G1 X110.279 Y133.448 E.01774
G1 X110.523 Y134.139 E.02181
G3 X110.653 Y134.975 I-9.336 J1.876 E.02523
G2 X113.982 Y131.645 I-3.665 J-6.993 E.14242
G3 X111.597 Y130.702 I.166 J-3.909 E.07783
G3 X111.218 Y131.089 I-1.682 J-1.268 E.01616
G1 X111.033 Y131.498 E.01337
G1 X110.77 Y131.783 E.01153
G1 X110.383 Y131.996 E.01317
M204 S10000
G1 X110.584 Y132.325 F42000
G1 F6364.866
M204 S6000
G1 X110.269 Y132.685 E.01427
G1 X110.556 Y133.168 E.01675
G3 X110.958 Y134.366 I-4.968 J2.336 E.03772
G2 X113.373 Y131.952 I-3.946 J-6.361 E.10258
G3 X112.282 Y131.608 I.725 J-4.196 E.03415
G1 X111.638 Y131.224 E.02235
G1 X111.538 Y131.331 E.00439
G1 X111.274 Y131.806 E.01616
G1 X110.912 Y132.148 E.01483
G1 X110.637 Y132.296 E.00931
M204 S10000
G1 X110.812 Y132.658 F42000
G1 F6364.866
M204 S6000
G1 X110.74 Y132.737 E.00319
G1 X111.028 Y133.282 E.01835
G1 X111.19 Y133.757 E.01497
G2 X112.759 Y132.194 I-4.198 J-5.781 E.06622
G3 X111.747 Y131.776 I2.558 J-7.611 E.03263
G1 X111.419 Y132.211 E.01625
G3 X110.863 Y132.626 I-2.378 J-2.609 E.02069
M204 S10000
G1 X111.207 Y132.83 F42000
; LINE_WIDTH: 0.369955
G1 F7338.677
M204 S6000
G1 X111.379 Y133.158 E.00958
G2 X112.183 Y132.36 I-3.908 J-4.739 E.02931
G1 X111.872 Y132.218 E.00884
G1 X111.466 Y132.644 E.0152
G1 X111.255 Y132.795 E.00669
; WIPE_START
G1 X111.466 Y132.644 E-.09838
G1 X111.872 Y132.218 E-.22356
G1 X112.183 Y132.36 E-.13005
G1 X111.895 Y132.681 E-.16385
G1 X111.617 Y132.938 E-.14416
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.095 Y137.126 Z1.8 F42000
G1 Z1.4
M73 P66 R5
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.353145
G1 F7736.338
M204 S6000
G1 X108.797 Y136.794 E.01903
M204 S10000
G1 X108.822 Y136.832 F42000
; LINE_WIDTH: 0.177565
G1 F15000
M204 S6000
G1 X108.216 Y137.043 E.00683
; LINE_WIDTH: 0.155827
G1 X108.087 Y137.083 E.0012
; LINE_WIDTH: 0.116553
G1 X107.958 Y137.122 E.00078
; WIPE_START
G1 X108.087 Y137.083 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.047 Y137.117 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.117479
G1 F15000
M204 S6000
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
M204 S10000
G1 X100.126 Y131.405 Z1.8 F42000
G1 X98.228 Y129.506 Z1.8
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.097082
G1 F15000
M204 S6000
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
M204 S10000
G1 X97.888 Y127.044 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.11786
G1 F15000
M204 S6000
G1 X97.926 Y126.908 E.00083
; LINE_WIDTH: 0.157757
G1 X97.963 Y126.791 E.00111
; LINE_WIDTH: 0.174282
G1 X97.979 Y126.75 E.00046
G1 X98.101 Y126.623 E.00183
; LINE_WIDTH: 0.121723
G1 X98.224 Y126.495 E.0011
; WIPE_START
G1 X98.101 Y126.623 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.734 Y126.567 Z1.8 F42000
G1 X115.786 Y126.494 Z1.8
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.0970909
G1 F15000
M204 S6000
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
M204 S10000
G1 X116.125 Y128.959 Z1.8 F42000
G1 Z1.4
G1 E.8 F1800
; LINE_WIDTH: 0.116739
G1 F15000
M204 S6000
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
; CHANGE_LAYER
; Z_HEIGHT: 1.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X115.81 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 114
M625
; layer num/total_layer_count: 8/23
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
M106 S188.7
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z1.8 I.395 J1.151 P1  F42000
G1 X124.977 Y126.337 Z1.8
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
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
G1 X125.378 Y126.557 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
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
M204 S6000
G1 X125.359 Y126.079 E-.19337
G1 X125.819 Y125.95 E-.18163
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.551 Y119.579 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X129.572 Y119.601 E.00098
G3 X127.841 Y118.902 I-1.57 J1.396 E.36224
G3 X128.58 Y118.983 I.124 J2.3 E.02402
G1 X128.789 Y119.049 E.00703
G3 X129.341 Y119.377 I-.786 J1.948 E.02073
G1 X129.508 Y119.538 E.00745
M204 S250
G1 X129.279 Y119.862 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X129.279 Y119.862 E.00002
G3 X127.871 Y119.294 I-1.276 J1.135 E.27283
G3 X128.462 Y119.357 I.099 J1.894 E.01777
G1 X128.642 Y119.413 E.00561
G3 X129.09 Y119.681 I-.639 J1.584 E.01561
G1 X129.236 Y119.82 E.006
; WIPE_START
M204 S6000
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
M204 S10000
G1 X135.795 Y126.09 Z2 F42000
G1 X136.649 Y126.695 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X136.805 Y126.928 E.00904
G3 X134.819 Y130.09 I-1.804 J1.072 E.14806
G3 X134.705 Y125.923 I.184 J-2.09 E.19643
G3 X136.608 Y126.65 I.297 J2.077 E.06843
M204 S250
G1 X136.328 Y126.92 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X136.476 Y127.124 E.00749
G3 X134.75 Y126.312 I-1.466 J.876 E.25942
G3 X135.702 Y126.439 I.264 J1.655 E.02903
G3 X136.292 Y126.873 I-.693 J1.562 E.022
; WIPE_START
M204 S6000
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
M204 S10000
G1 X131.291 Y134.29 Z2 F42000
G1 X128.784 Y136.94 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X128.691 Y136.986 E.00333
G3 X127.784 Y132.913 I-.681 J-1.986 E.22715
G3 X129.213 Y133.279 I.212 J2.14 E.04839
G3 X129.077 Y136.808 I-1.203 J1.721 E.13493
G1 X128.839 Y136.916 E.00841
M204 S250
G1 X128.624 Y136.585 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X128.573 Y136.614 E.00175
G3 X127.814 Y133.304 I-.564 J-1.613 E.1712
G3 X128.761 Y133.467 I.201 J1.665 E.02903
G3 X128.878 Y136.473 I-.752 J1.534 E.10956
G1 X128.679 Y136.561 E.00647
; WIPE_START
M204 S6000
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
M204 S10000
G1 X123.464 Y129.383 Z2 F42000
G1 X123.037 Y128.512 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X123.004 Y128.634 E.00403
G3 X120.761 Y125.91 I-2.002 J-.637 E.28975
G3 X121.186 Y125.91 I.214 J1.376 E.01371
G1 X121.403 Y125.935 E.00703
G3 X123.078 Y128.321 I-.4 J2.062 E.10361
G1 X123.049 Y128.454 E.00438
M204 S250
G1 X122.655 Y128.423 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X122.63 Y128.515 E.00284
G3 X120.806 Y126.301 I-1.628 J-.518 E.21823
G3 X121.141 Y126.299 I.173 J1.084 E.01001
G1 X121.328 Y126.321 E.00561
G3 X122.69 Y128.261 I-.326 J1.677 E.07803
G1 X122.668 Y128.365 E.00316
; WIPE_START
M204 S6000
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
M204 S10000
G1 X124.95 Y122.969 Z2 F42000
G1 X127.3 Y118.629 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X127.862 Y118.603 I.702 J9.369 E.01808
G1 X128.424 Y118.612 E.01808
G3 X127.24 Y118.633 I-.422 J9.386 E1.86023
M204 S250
G1 X127.271 Y118.237 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X128.441 Y118.22 I.73 J9.76 E.03489
G3 X137.216 Y124.702 I-.451 J9.792 E.34461
G3 X127.211 Y118.242 I-9.216 J3.295 E1.45034
; WIPE_START
M204 S6000
G1 X127.856 Y118.211 E-.24533
G1 X128.441 Y118.22 E-.22254
G1 X129.026 Y118.264 E-.22261
G1 X129.207 Y118.288 E-.06952
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z2 I1.217 J0 P1  F42000
; stop printing object, unique label id: 78
M625
; object ids of layer 8 start: 78,114
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


; object ids of this layer8 end: 78,114
M625
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X129.09 Y118.874 F42000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.353127
G1 F7736.79
M204 S6000
G1 X129.793 Y119.206 E.01904
M204 S10000
G1 X129.818 Y119.168 F42000
; LINE_WIDTH: 0.177553
G1 F15000
M204 S6000
G1 X129.211 Y118.957 E.00683
; LINE_WIDTH: 0.155808
G1 X129.082 Y118.917 E.0012
; LINE_WIDTH: 0.116544
G1 X128.953 Y118.878 E.00078
; WIPE_START
G1 X129.082 Y118.917 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.042 Y118.883 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.11749
G1 F15000
M204 S6000
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
M204 S10000
G1 X132.21 Y123.175 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.370128
G1 F7334.794
M204 S6000
G1 X132.663 Y123.544 E.0151
G1 X132.867 Y123.782 E.0081
G1 X133.179 Y123.64 E.00885
G1 X132.681 Y123.113 E.01874
G1 X132.361 Y122.845 E.0108
G1 X132.235 Y123.12 E.00783
M204 S10000
G1 X131.861 Y123.388 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X132.24 Y123.63 E.01339
G3 X132.772 Y124.232 I-2.064 J2.366 E.02399
G1 X133.377 Y123.934 E.02007
G1 X133.75 Y123.805 E.01176
G2 X132.196 Y122.25 I-5.738 J4.18 E.06575
G1 X131.946 Y122.898 E.02071
G1 X131.745 Y123.269 E.01256
G1 X131.819 Y123.345 E.00315
M204 S10000
G1 X131.58 Y123.675 F42000
G1 F6364.866
M204 S6000
G1 X132.003 Y123.924 E.01461
G1 X132.34 Y124.29 E.01483
G1 X132.59 Y124.736 E.01523
G1 X132.634 Y124.776 E.00176
G1 X133.099 Y124.477 E.01648
G1 X133.837 Y124.175 E.02377
G1 X134.376 Y124.058 E.01641
G2 X131.954 Y121.634 I-6.376 J3.948 E.10297
G1 X131.81 Y122.23 E.01826
G1 X131.602 Y122.744 E.01654
G1 X131.266 Y123.315 E.01974
G1 X131.541 Y123.63 E.01244
M204 S10000
G1 X131.321 Y123.989 F42000
G1 F6364.866
M204 S6000
G1 X131.668 Y124.145 E.01135
G1 X131.974 Y124.427 E.01238
G3 X132.241 Y124.949 I-2.139 J1.429 E.0175
M73 P67 R5
G1 X132.502 Y125.168 E.01014
G1 X132.592 Y125.297 E.0047
G1 X133.182 Y124.865 E.0218
G1 X133.686 Y124.622 E.01664
G1 X134.363 Y124.438 E.0209
G1 X134.998 Y124.394 E.01896
G2 X131.837 Y121.126 I-7.006 J3.615 E.13736
G1 X131.627 Y121.038 E.00678
G3 X130.703 Y123.411 I-3.749 J-.093 E.07741
G1 X131.016 Y123.596 E.01081
G1 X131.295 Y123.934 E.01306
; WIPE_START
G1 X131.016 Y123.596 E-.16665
G1 X130.703 Y123.411 E-.1379
G1 X130.945 Y123.117 E-.14496
G1 X131.234 Y122.642 E-.21098
G1 X131.335 Y122.401 E-.09952
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X130.063 Y123.663 Z2 F42000
G1 Z1.6
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X130.423 Y123.696 E.01076
G1 X130.771 Y123.883 E.01177
G3 X131.077 Y124.312 I-.91 J.974 E.01579
G1 X131.412 Y124.43 E.01059
G1 X131.677 Y124.661 E.01046
G1 X131.849 Y125.006 E.01149
G1 X131.898 Y125.192 E.00574
G1 X132.119 Y125.325 E.00768
G1 X132.369 Y125.631 E.0118
G1 X132.456 Y125.989 E.01096
G3 X134.646 Y124.78 I2.592 J2.106 E.0764
G1 X135.244 Y124.765 E.0178
G1 X135.611 Y124.814 E.01105
G1 X135.216 Y123.996 E.02705
G2 X131.188 Y120.391 I-7.327 J4.133 E.16392
G1 X131.245 Y120.909 E.01553
G1 X131.204 Y121.547 E.01905
G3 X130.542 Y123.026 I-3.543 J-.7 E.04869
G3 X129.975 Y123.577 I-2.372 J-1.87 E.0236
G1 X130.02 Y123.621 E.00187
M204 S10000
G1 X129.855 Y124.064 F42000
; LINE_WIDTH: 0.419435
G1 F6374.259
M204 S6000
G1 X130.233 Y124.04 E.01127
G1 X130.456 Y124.12 E.00706
G1 X130.64 Y124.303 E.00772
G1 X130.775 Y124.648 E.01103
G1 X131.189 Y124.738 E.01259
G1 X131.405 Y124.926 E.00851
G3 X131.522 Y125.443 I-.931 J.483 E.01593
G1 X131.884 Y125.619 E.01196
G1 X132.034 Y125.803 E.00707
G1 X132.095 Y126.087 E.00865
G1 X132.047 Y126.398 E.00936
G1 X132.245 Y126.549 E.00739
G1 X132.395 Y126.836 E.00964
G1 X132.639 Y126.366 E.01576
G3 X134.656 Y125.157 I2.414 J1.739 E.0719
G1 X135.253 Y125.142 E.01777
G1 X135.805 Y125.242 E.01669
G1 X136.219 Y125.393 E.0131
G2 X130.598 Y119.775 I-8.195 J2.578 E.24572
G1 X130.783 Y120.281 E.01602
G1 X130.868 Y120.924 E.01929
G1 X130.83 Y121.504 E.0173
G1 X130.69 Y122.012 E.01565
G3 X130.26 Y122.775 I-2.688 J-1.012 E.02618
G1 X129.792 Y123.24 E.01962
G1 X129.314 Y123.551 E.01697
G1 X129.055 Y123.653 E.00826
G1 X129.326 Y123.615 E.00815
G1 X129.66 Y123.785 E.01114
G1 X129.82 Y124.014 E.00832
; WIPE_START
G1 X129.66 Y123.785 E-.10624
G1 X129.326 Y123.615 E-.14231
G1 X129.055 Y123.653 E-.10407
G1 X129.314 Y123.551 E-.10553
G1 X129.792 Y123.24 E-.21677
G1 X129.951 Y123.082 E-.08508
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.815 Y123.741 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.39444
G1 F6827.492
M204 S6000
G1 X128.999 Y123.673 E.00545
; WIPE_START
G1 X128.815 Y123.741 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.387 Y123.572 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.38686
G1 F6977.961
M204 S6000
G1 X123.779 Y123.129 E.01606
G1 X123.642 Y122.828 E.00898
G2 X122.857 Y123.633 I4.229 J4.906 E.03058
G1 X123.165 Y123.773 E.00918
G1 X123.343 Y123.612 E.00652
M204 S10000
G1 X123.626 Y123.89 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X123.95 Y123.451 E.01626
G1 X124.225 Y123.215 E.01079
G1 X123.936 Y122.625 E.01957
G1 X123.809 Y122.252 E.01176
G2 X122.251 Y123.81 I3.993 J5.551 E.06592
G3 X123.223 Y124.226 I-1.259 J4.282 E.03157
G1 X123.58 Y123.929 E.01385
M204 S10000
G1 X123.921 Y124.135 F42000
G1 F6364.866
M204 S6000
G1 X124.221 Y123.714 E.01539
G3 X124.76 Y123.344 I1.185 J1.148 E.01961
G3 X124.072 Y121.721 I3.394 J-2.394 E.0529
G1 X124.054 Y121.628 E.00283
G2 X121.639 Y124.065 I3.832 J6.212 E.10314
G1 X122.317 Y124.217 E.02069
G3 X123.31 Y124.732 I-1.376 J3.875 E.03342
G1 X123.595 Y124.386 E.01332
G1 X123.873 Y124.172 E.01047
M204 S10000
G1 X124.21 Y124.439 F42000
G1 F6364.866
M204 S6000
G1 X124.373 Y124.116 E.01077
G1 X124.674 Y123.821 E.01257
G1 X125.079 Y123.628 E.01336
G1 X125.209 Y123.599 E.00397
G1 X125.337 Y123.452 E.0058
G3 X124.423 Y121.555 I2.635 J-2.438 E.06365
G1 X124.396 Y121.004 E.01644
G2 X121.265 Y123.955 I3.533 J6.884 E.12987
G1 X121.008 Y124.386 E.01496
G1 X121.466 Y124.414 E.01369
G1 X122.051 Y124.536 E.0178
G1 X122.61 Y124.753 E.01785
G1 X123.122 Y125.059 E.01777
G1 X123.468 Y125.358 E.01361
G1 X123.509 Y125.171 E.00569
G1 X123.771 Y124.743 E.01496
G1 X124.079 Y124.494 E.01178
G1 X124.155 Y124.462 E.00245
; WIPE_START
G1 X124.079 Y124.494 E-.03127
G1 X123.771 Y124.743 E-.15026
G1 X123.509 Y125.171 E-.1909
G1 X123.468 Y125.358 E-.07259
G1 X123.122 Y125.059 E-.17369
G1 X122.803 Y124.868 E-.1413
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.803 Y125.671 Z2 F42000
G1 Z1.6
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X123.862 Y125.303 E.01108
G1 X124.05 Y124.997 E.01069
G3 X124.515 Y124.7 I.888 J.875 E.01658
G1 X124.677 Y124.34 E.01176
G1 X124.892 Y124.128 E.00898
G1 X125.232 Y123.978 E.01107
G1 X125.445 Y123.936 E.00647
G1 X125.674 Y123.642 E.01111
G1 X125.936 Y123.501 E.00886
G1 X125.519 Y123.089 E.01748
G1 X125.183 Y122.615 E.01729
G1 X124.968 Y122.162 E.01492
G1 X124.807 Y121.548 E.01891
G1 X124.767 Y120.759 E.02356
G1 X124.816 Y120.393 E.01098
G2 X120.942 Y123.762 I3.141 J7.524 E.15557
G2 X120.395 Y124.813 I4.648 J3.083 E.03536
G1 X120.74 Y124.764 E.01038
G1 X121.39 Y124.783 E.01935
G1 X121.975 Y124.905 E.0178
G3 X123.509 Y125.948 I-1.042 J3.185 E.05599
G1 X123.76 Y125.712 E.01025
M204 S10000
G1 X124.19 Y125.904 F42000
G1 F6364.866
M204 S6000
G1 X124.181 Y125.589 E.00939
G1 X124.263 Y125.339 E.00783
G1 X124.46 Y125.145 E.00823
G1 X124.831 Y125.022 E.01165
G1 X124.961 Y124.591 E.01341
G1 X125.11 Y124.436 E.00638
G1 X125.356 Y124.338 E.00791
G1 X125.671 Y124.327 E.00938
G1 X125.841 Y124.011 E.01067
G1 X125.99 Y123.877 E.00598
G1 X126.275 Y123.792 E.00888
G1 X126.658 Y123.862 E.01158
G1 X126.88 Y123.639 E.00939
G1 X126.385 Y123.374 E.0167
G1 X125.979 Y123.039 E.01567
G1 X125.692 Y122.707 E.01309
G3 X125.159 Y121.347 I2.781 J-1.875 E.04386
G1 X125.144 Y120.749 E.0178
G1 X125.262 Y120.153 E.01811
G1 X125.429 Y119.781 E.01214
G2 X120.879 Y123.132 I2.488 J8.143 E.17156
G1 X120.34 Y124.033 E.03128
G2 X119.788 Y125.397 I7.174 J3.699 E.04389
G1 X120.283 Y125.219 E.01567
G1 X120.741 Y125.141 E.01383
G1 X121.313 Y125.152 E.01704
G1 X121.898 Y125.274 E.0178
G1 X122.371 Y125.473 E.0153
G1 X122.796 Y125.759 E.01526
G1 X123.201 Y126.163 E.01704
; LINE_WIDTH: 0.43822
G1 F6071.338
G1 X123.328 Y126.318 E.00625
; LINE_WIDTH: 0.47468
G1 F5558.644
G1 X123.455 Y126.472 E.00682
; LINE_WIDTH: 0.51114
G1 F5125.796
G1 X123.583 Y126.626 E.0074
; LINE_WIDTH: 0.547835
G1 F4753.275
G1 X123.647 Y126.701 E.00394
G1 X123.645 Y126.602 E.00394
; LINE_WIDTH: 0.51114
G1 F5125.796
G1 X123.699 Y126.461 E.00561
; LINE_WIDTH: 0.47468
G1 F5558.644
G1 X123.753 Y126.319 E.00517
; LINE_WIDTH: 0.42489
G1 F6283.226
G1 X123.807 Y126.178 E.00457
G3 X124.138 Y125.934 I.768 J.697 E.01247
; WIPE_START
G1 X123.975 Y126.029 E-.25397
G1 X123.807 Y126.178 E-.30178
G1 X123.753 Y126.319 E-.20425
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.717 Y126.9 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.55594
G1 F4678.18
M204 S6000
G1 X123.667 Y126.758 E.00611
; WIPE_START
G1 X123.717 Y126.9 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.524 Y127.997 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.491315
G1 F5352.423
M204 S6000
G1 X123.455 Y128.368 E.01337
; LINE_WIDTH: 0.420954
G1 F6348.641
G3 X122.504 Y129.994 I-2.408 J-.318 E.05776
G1 X122.021 Y130.272 E.01663
G1 X121.531 Y130.437 E.01545
G3 X119.401 Y129.895 I-.527 J-2.385 E.06808
G1 X119.311 Y129.987 E.00383
G1 X119.225 Y130.001 E.00261
G2 X126.021 Y136.781 I8.788 J-2.012 E.30231
G1 X126.047 Y136.652 E.00391
G1 X126.111 Y136.596 E.00255
G1 X125.841 Y136.235 E.01347
G1 X125.604 Y135.686 E.01784
G3 X125.594 Y134.367 I2.513 J-.678 E.03983
G1 X125.771 Y133.89 E.01519
G1 X126.049 Y133.45 E.01554
G1 X126.378 Y133.113 E.01407
G1 X126.872 Y132.776 E.01785
G1 X127.369 Y132.573 E.01603
; LINE_WIDTH: 0.48595
G1 F5417.24
G1 X127.76 Y132.478 E.01411
; LINE_WIDTH: 0.490119
G1 F5366.746
G1 X127.943 Y132.499 E.0065
; LINE_WIDTH: 0.452255
G1 F5863.168
G1 X128.126 Y132.521 E.00595
; LINE_WIDTH: 0.419652
G1 F6370.576
G3 X128.769 Y132.625 I-.536 J5.353 E.0194
G1 X129.123 Y132.77 E.01138
G1 X129.552 Y133.051 E.01527
G1 X129.978 Y133.475 E.01791
G3 X130.356 Y134.17 I-2.25 J1.673 E.02361
G1 X130.483 Y134.782 E.01859
G1 X130.48 Y135.301 E.01544
G1 X130.361 Y135.798 E.01522
G3 X130.053 Y136.395 I-2.742 J-1.037 E.02003
G1 X130.201 Y136.729 E.01087
G2 X134.223 Y134.512 I-2.231 J-8.802 E.13815
G1 X134.96 Y133.717 E.03226
G2 X136.778 Y129.982 I-6.868 J-5.653 E.12477
G1 X136.654 Y129.955 E.00376
G1 X136.602 Y129.896 E.00235
G1 X136.325 Y130.115 E.01051
G1 X135.92 Y130.316 E.01345
G1 X135.299 Y130.479 E.0191
G1 X134.769 Y130.479 E.01578
G1 X134.181 Y130.356 E.01788
G3 X132.891 Y129.321 I.799 J-2.316 E.05021
; LINE_WIDTH: 0.436825
G1 F6092.84
G1 X132.791 Y129.151 E.00612
; LINE_WIDTH: 0.470495
G1 F5613.05
G1 X132.691 Y128.982 E.00664
; LINE_WIDTH: 0.512756
G1 F5108.166
G1 X132.591 Y128.812 E.0073
G1 X132.493 Y128.406 E.01553
; LINE_WIDTH: 0.489999
G1 F5368.187
G1 X132.504 Y128.266 E.00495
; LINE_WIDTH: 0.444815
G1 F5971.709
G1 X132.516 Y128.127 E.00445
; LINE_WIDTH: 0.399632
G1 F6728.123
G1 X132.528 Y127.987 E.00395
; LINE_WIDTH: 0.39835
G1 F6752.385
G1 X132.519 Y127.873 E.00322
; LINE_WIDTH: 0.44097
G1 F6029.393
G1 X132.509 Y127.759 E.0036
; LINE_WIDTH: 0.48359
G1 F5446.252
G1 X132.5 Y127.644 E.00399
; LINE_WIDTH: 0.523483
G1 F4994.149
G1 X132.491 Y127.53 E.00435
G1 X132.639 Y127.1 E.01727
; LINE_WIDTH: 0.47855
G1 F5509.262
G1 X132.778 Y126.873 E.00917
; LINE_WIDTH: 0.420255
G1 F6360.395
G3 X133.523 Y125.992 I2.53 J1.384 E.03462
G3 X134.197 Y125.639 I1.593 J2.226 E.02276
G1 X134.773 Y125.531 E.01746
G1 X135.303 Y125.522 E.01579
G1 X135.92 Y125.684 E.01902
G1 X136.377 Y125.917 E.01529
G1 X136.603 Y126.104 E.00875
G3 X136.78 Y126 I.16 J.07 E.00653
G2 X130.202 Y119.271 I-8.778 J2.001 E.29514
G1 X130.053 Y119.605 E.01089
G1 X130.286 Y119.992 E.01346
G1 X130.459 Y120.593 E.01865
G1 X130.496 Y121.11 E.01544
G3 X130.315 Y121.927 I-2.363 J-.094 E.02509
G1 X129.996 Y122.502 E.01958
G1 X129.552 Y122.949 E.01879
G1 X129.123 Y123.23 E.01529
G1 X128.732 Y123.386 E.01255
; LINE_WIDTH: 0.404355
G1 F6640.199
G1 X128.215 Y123.465 E.01491
; LINE_WIDTH: 0.410234
G1 F6533.931
G1 X128.062 Y123.486 E.0045
; LINE_WIDTH: 0.45326
G1 F5848.808
G1 X127.908 Y123.506 E.00503
; LINE_WIDTH: 0.495235
G1 F5306.039
G1 X127.754 Y123.527 E.00555
G1 X127.257 Y123.409 E.01824
; LINE_WIDTH: 0.45902
G1 F5767.844
G1 X127 Y123.279 E.00948
; LINE_WIDTH: 0.420176
G1 F6361.728
G1 X126.743 Y123.148 E.0086
G1 X126.282 Y122.808 E.01706
G3 X125.536 Y121.337 I1.844 J-1.86 E.05
G1 X125.521 Y120.74 E.01781
G1 X125.606 Y120.307 E.01314
G1 X125.893 Y119.668 E.02089
G1 X126.107 Y119.399 E.01024
G3 X126.003 Y119.223 I.07 J-.16 E.0065
G1 X124.925 Y119.548 E.03355
G2 X120.294 Y123.375 I2.996 J8.34 E.18264
G2 X119.23 Y126.02 I6.993 J4.35 E.08538
G3 X119.401 Y126.104 I.028 J.158 E.00609
G3 X121.236 Y125.521 I1.597 J1.847 E.05896
G1 X121.821 Y125.643 E.01781
G3 X122.889 Y126.376 I-.9 J2.458 E.03902
G1 X123.226 Y126.87 E.01781
G1 X123.389 Y127.271 E.01291
; LINE_WIDTH: 0.443788
G1 F5987.016
G1 X123.451 Y127.604 E.01074
; LINE_WIDTH: 0.491503
G1 F5350.186
G1 X123.513 Y127.938 E.01202
; WIPE_START
G1 X123.451 Y127.604 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.215 Y128.972 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.419639
G1 F6370.795
M204 S6000
G1 X123.864 Y128.625 E.01469
G1 X123.834 Y128.431 E.00585
; LINE_WIDTH: 0.444118
G1 F5982.091
G1 X123.935 Y128.216 E.00754
; LINE_WIDTH: 0.475091
G1 F5553.357
G1 X124.036 Y128 E.00812
G1 X123.823 Y127.532 E.01757
; LINE_WIDTH: 0.423158
G1 F6311.843
G1 X123.894 Y127.344 E.00602
G1 X124.215 Y127.028 E.01354
G1 X124.072 Y126.544 E.01515
G1 X124.146 Y126.367 E.00574
G1 X124.576 Y126.116 E.01495
G1 X124.557 Y125.619 E.01495
G1 X124.635 Y125.481 E.00477
G1 X125.152 Y125.323 E.01622
G1 X125.268 Y124.813 E.0157
G1 X125.395 Y124.714 E.00485
G1 X125.907 Y124.698 E.01538
G1 X126.139 Y124.242 E.01538
G1 X126.284 Y124.169 E.00487
G1 X126.794 Y124.281 E.01568
G1 X127.197 Y123.842 E.0179
G1 X127.346 Y123.857 E.0045
; LINE_WIDTH: 0.480098
G1 F5489.762
G1 X127.549 Y123.949 E.00771
; LINE_WIDTH: 0.505233
G1 F5191.294
G1 X127.753 Y124.04 E.00816
; LINE_WIDTH: 0.500499
G1 F5245.004
G1 X127.885 Y123.97 E.00541
; LINE_WIDTH: 0.465895
G1 F5674.094
G1 X128.017 Y123.9 E.005
; LINE_WIDTH: 0.419325
G1 F6376.118
G1 X128.15 Y123.83 E.00445
G1 X128.344 Y123.824 E.00578
G1 X128.735 Y124.159 E.01531
G1 X129.244 Y123.983 E.01602
G1 X129.401 Y124.063 E.00523
G1 X129.667 Y124.462 E.01426
G1 X130.184 Y124.414 E.01543
G1 X130.32 Y124.502 E.0048
G1 X130.495 Y124.987 E.01535
G1 X131.005 Y125.068 E.01535
G1 X131.114 Y125.18 E.00466
G1 X131.166 Y125.702 E.01558
G1 X131.632 Y125.902 E.01508
G1 X131.709 Y126.001 E.00375
G1 X131.638 Y126.56 E.01676
G1 X132.016 Y126.849 E.01414
; LINE_WIDTH: 0.437469
G1 F6082.906
G1 X132.057 Y126.912 E.00234
; LINE_WIDTH: 0.472425
G1 F5587.828
G1 X132.098 Y126.975 E.00255
; LINE_WIDTH: 0.507382
G1 F5167.272
G1 X132.139 Y127.038 E.00276
; LINE_WIDTH: 0.53619
G1 F4865.49
G1 X131.956 Y127.501 E.0194
; LINE_WIDTH: 0.527209
G1 F4955.725
G1 X132.03 Y127.628 E.00563
; LINE_WIDTH: 0.486585
G1 F5409.487
G1 X132.104 Y127.755 E.00516
; LINE_WIDTH: 0.433434
G1 F6145.755
G1 X132.178 Y127.882 E.00454
G1 X132.178 Y128.118 E.00731
; LINE_WIDTH: 0.445845
G1 F5956.443
G1 X132.104 Y128.245 E.00468
; LINE_WIDTH: 0.486215
G1 F5414.002
G1 X132.03 Y128.372 E.00515
; LINE_WIDTH: 0.532191
G1 F4905.265
G1 X131.955 Y128.499 E.00569
G1 X132.135 Y128.952 E.01881
; LINE_WIDTH: 0.504165
G1 F5203.309
G1 X132.096 Y129.018 E.00283
; LINE_WIDTH: 0.470495
G1 F5613.05
G1 X132.056 Y129.085 E.00262
; LINE_WIDTH: 0.420235
G1 F6360.741
G1 X132.016 Y129.151 E.00231
G1 X131.638 Y129.44 E.01417
G1 X131.709 Y129.999 E.0168
G1 X131.604 Y130.113 E.00464
G1 X131.166 Y130.298 E.01417
G1 X131.119 Y130.803 E.01512
G1 X131.021 Y130.925 E.00465
G1 X130.495 Y131.013 E.0159
G1 X130.32 Y131.498 E.01538
G1 X130.184 Y131.586 E.00482
G1 X129.667 Y131.538 E.01546
G1 X129.384 Y131.957 E.01508
G1 X129.244 Y132.017 E.00453
G1 X128.735 Y131.841 E.01606
; LINE_WIDTH: 0.412466
G1 F6494.468
G1 X128.343 Y132.175 E.01502
G1 X128.146 Y132.175 E.00575
; LINE_WIDTH: 0.448398
G1 F5918.947
G1 X127.95 Y132.067 E.00718
; LINE_WIDTH: 0.491712
G1 F5347.69
G1 X127.753 Y131.96 E.00795
G1 X127.288 Y132.161 E.01796
; LINE_WIDTH: 0.42243
G1 F6323.947
G1 X127.2 Y132.154 E.00266
G1 X126.794 Y131.719 E.01783
G1 X126.331 Y131.826 E.01425
G1 X126.187 Y131.802 E.00436
G1 X125.907 Y131.302 E.01719
M73 P67 R4
G1 X125.395 Y131.286 E.01535
G1 X125.268 Y131.187 E.00484
G1 X125.152 Y130.677 E.01568
G1 X124.65 Y130.529 E.01568
G1 X124.559 Y130.392 E.00494
G1 X124.576 Y129.884 E.01525
G1 X124.133 Y129.622 E.01541
G1 X124.08 Y129.54 E.00294
G3 X124.198 Y129.03 I2.496 J.308 E.01572
M204 S10000
G1 X123.645 Y129.305 F42000
; LINE_WIDTH: 0.55653
G1 F4672.806
M204 S6000
G1 X123.697 Y129.157 E.00639
; WIPE_START
G1 X123.645 Y129.305 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.19 Y130.096 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X123.881 Y129.902 E.01086
G1 X123.721 Y129.656 E.00876
; LINE_WIDTH: 0.444562
G1 F5975.476
G1 X123.696 Y129.539 E.00379
; LINE_WIDTH: 0.493705
G1 F5324.046
G1 X123.67 Y129.422 E.00426
; LINE_WIDTH: 0.542849
G1 F4800.688
G1 X123.645 Y129.305 E.00472
G1 X123.464 Y129.523 E.0112
; LINE_WIDTH: 0.493705
G1 F5324.046
G1 X123.283 Y129.742 E.0101
; LINE_WIDTH: 0.420326
G1 F6359.211
G1 X123.102 Y129.96 E.00846
G1 X122.709 Y130.31 E.01568
G1 X122.175 Y130.616 E.01833
G1 X121.631 Y130.8 E.01715
G1 X121.069 Y130.871 E.01689
G3 X119.78 Y130.61 I.036 J-3.478 E.03944
G2 X125.429 Y136.233 I8.24 J-2.629 E.24696
G1 X125.222 Y135.721 E.01647
G3 X125.231 Y134.267 I2.983 J-.709 E.04376
G1 X125.427 Y133.736 E.01688
G1 X125.694 Y133.29 E.01549
G1 X126.077 Y132.877 E.01679
G1 X126.563 Y132.53 E.01782
G1 X126.88 Y132.361 E.0107
G1 X126.658 Y132.138 E.0094
G1 X126.416 Y132.194 E.00741
G1 X126.09 Y132.172 E.00975
G1 X125.841 Y131.989 E.00921
G1 X125.671 Y131.673 E.01068
G1 X125.305 Y131.652 E.01094
G1 X125.043 Y131.508 E.0089
G1 X124.931 Y131.356 E.00563
G1 X124.831 Y130.978 E.01166
G1 X124.415 Y130.826 E.0132
G1 X124.263 Y130.662 E.00665
G3 X124.188 Y130.156 I.677 J-.359 E.01556
M204 S10000
G1 X123.786 Y130.297 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G3 X123.522 Y130.043 I.294 J-.569 E.01106
G3 X121.03 Y131.247 I-2.551 J-2.098 E.08507
G1 X120.395 Y131.187 E.01899
G2 X121.821 Y133.463 I7.757 J-3.273 E.08034
G2 X124.816 Y135.607 I6.226 J-5.533 E.11063
G1 X124.754 Y134.948 E.01972
G1 X124.828 Y134.311 E.0191
G3 X125.489 Y132.945 I3.481 J.842 E.04556
G1 X125.929 Y132.511 E.01839
G1 X125.783 Y132.439 E.00483
G3 X125.414 Y132.044 I1.096 J-1.397 E.01616
G1 X125.047 Y131.961 E.01119
G1 X124.761 Y131.76 E.01043
G3 X124.489 Y131.274 I.922 J-.834 E.01672
G1 X124.155 Y131.101 E.0112
G1 X123.942 Y130.86 E.0096
G1 X123.812 Y130.495 E.01152
G1 X123.793 Y130.357 E.00417
; WIPE_START
G1 X123.812 Y130.495 E-.05322
G1 X123.942 Y130.86 E-.14697
G1 X124.155 Y131.101 E-.12245
G1 X124.489 Y131.274 E-.14293
G1 X124.594 Y131.526 E-.10378
G1 X124.761 Y131.76 E-.10912
G1 X124.936 Y131.883 E-.08153
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.21 Y131.561 Z2 F42000
G1 Z1.6
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X123.919 Y131.395 E.00998
G1 X123.621 Y131.057 E.01344
G1 X123.467 Y130.653 E.01286
G3 X121.04 Y131.625 I-2.52 J-2.778 E.07954
G1 X121.248 Y132.046 E.01398
G2 X124.273 Y134.935 I6.843 J-4.138 E.12606
G1 X124.377 Y134.962 E.0032
G3 X125.349 Y132.546 I3.589 J.04 E.07939
G2 X124.892 Y132.304 I-.57 J.526 E.0157
G1 X124.519 Y132.051 E.01345
G1 X124.257 Y131.695 E.01313
G1 X124.23 Y131.618 E.00245
M204 S10000
G1 X123.889 Y131.831 F42000
G1 F6364.866
M204 S6000
G1 X123.493 Y131.512 E.01514
G1 X123.31 Y131.269 E.00907
G3 X121.636 Y131.952 I-2.426 J-3.549 E.05426
G2 X124.049 Y134.366 I6.365 J-3.949 E.10254
G3 X124.745 Y132.675 I4.408 J.826 E.05484
G1 X124.256 Y132.322 E.01795
G3 X123.921 Y131.882 I1.759 J-1.69 E.01652
M204 S10000
G1 X123.626 Y132.11 F42000
G1 F6364.866
M204 S6000
G1 X123.223 Y131.774 E.01563
G1 X122.631 Y132.065 E.01964
G1 X122.253 Y132.194 E.01189
G1 X122.632 Y132.674 E.01823
G1 X123.227 Y133.279 E.02527
G2 X123.809 Y133.75 I6.002 J-6.827 E.02229
G1 X124.051 Y133.119 E.02013
G1 X124.225 Y132.785 E.01123
G1 X123.95 Y132.549 E.01079
G1 X123.662 Y132.158 E.01448
M204 S10000
G1 X123.367 Y132.4 F42000
; LINE_WIDTH: 0.385709
G1 F7001.404
M204 S6000
G1 X123.165 Y132.221 E.00731
G1 X122.85 Y132.365 E.00939
G2 X123.642 Y133.172 I5.539 J-4.645 E.03065
G1 X123.779 Y132.871 E.00895
G1 X123.407 Y132.445 E.0153
; WIPE_START
G1 X123.779 Y132.871 E-.21472
G1 X123.642 Y133.172 E-.12565
G1 X123.185 Y132.738 E-.2394
G1 X122.868 Y132.385 E-.18022
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.13 Y132.373 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.39848
G1 F6749.916
M204 S6000
G1 X128.871 Y132.279 E.00775
; WIPE_START
G1 X129.13 Y132.373 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.855 Y131.936 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.419594
G1 F6371.57
M204 S6000
G1 X129.596 Y132.273 E.01263
G1 X129.24 Y132.388 E.01112
G1 X129.13 Y132.373 E.0033
G1 X129.619 Y132.626 E.01637
G1 X130.025 Y132.961 E.01565
G3 X130.72 Y134.07 I-2.493 J2.334 E.03919
G1 X130.83 Y134.496 E.01308
G1 X130.868 Y135.076 E.01731
G1 X130.783 Y135.719 E.0193
G1 X130.598 Y136.225 E.01603
G2 X133.958 Y134.243 I-2.704 J-8.424 E.11704
G1 X134.672 Y133.473 E.03125
G2 X136.219 Y130.607 I-6.646 J-5.436 E.09749
G1 X135.721 Y130.781 E.01567
G3 X134.098 Y130.724 I-.698 J-3.284 E.04883
G3 X132.903 Y129.96 I1.069 J-2.988 E.04254
G3 X132.413 Y129.242 I2.546 J-2.265 E.02594
G3 X132.047 Y129.602 I-1.126 J-.78 E.01534
G1 X132.095 Y129.913 E.00937
G1 X132.034 Y130.197 E.00865
G1 X131.835 Y130.416 E.0088
G1 X131.522 Y130.557 E.01022
G1 X131.469 Y130.948 E.01173
G1 X131.351 Y131.141 E.00672
G1 X131.14 Y131.284 E.00761
G1 X130.775 Y131.352 E.01103
G1 X130.6 Y131.754 E.01305
G1 X130.456 Y131.88 E.00569
G1 X130.233 Y131.96 E.00706
G1 X129.914 Y131.94 E.00949
M204 S10000
G1 X130.03 Y132.353 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X129.975 Y132.423 E.00265
G3 X131.083 Y133.97 I-2.024 J2.62 E.0575
G1 X131.204 Y134.452 E.01481
G1 X131.245 Y135.091 E.01904
G1 X131.188 Y135.609 E.01554
G2 X133.743 Y133.92 I-3.102 J-7.468 E.09179
G1 X134.384 Y133.229 E.02807
G2 X135.611 Y131.186 I-6.416 J-5.244 E.07122
G1 X135.22 Y131.236 E.01176
G1 X134.615 Y131.217 E.01803
G1 X134.03 Y131.095 E.0178
G1 X133.514 Y130.888 E.01656
G1 X132.976 Y130.539 E.01909
G3 X132.456 Y130.011 I1.743 J-2.236 E.02215
G1 X132.369 Y130.369 E.01096
G1 X132.108 Y130.684 E.0122
G1 X131.876 Y130.837 E.00828
G1 X131.758 Y131.219 E.01191
G1 X131.518 Y131.498 E.01096
G3 X131.049 Y131.711 I-.78 J-1.095 E.01544
G1 X130.893 Y131.991 E.00952
G1 X130.654 Y132.201 E.00949
G1 X130.282 Y132.334 E.01178
G1 X130.09 Y132.348 E.00573
; WIPE_START
G1 X130.282 Y132.334 E-.07307
G1 X130.654 Y132.201 E-.1503
G1 X130.893 Y131.991 E-.12109
G1 X131.049 Y131.711 E-.12143
G1 X131.275 Y131.636 E-.09055
G1 X131.518 Y131.498 E-.10608
G1 X131.685 Y131.304 E-.09748
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.321 Y132.011 Z2 F42000
G1 Z1.6
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X131.187 Y132.227 E.00756
G1 X130.852 Y132.522 E.01329
G1 X130.703 Y132.588 E.00486
G1 X131.138 Y133.18 E.02186
G3 X131.62 Y134.76 I-3.57 J1.953 E.04956
G1 X131.648 Y134.975 E.00646
G2 X133.467 Y133.663 I-3.672 J-7.006 E.06703
G1 X134.096 Y132.985 E.02756
G2 X134.994 Y131.614 I-7.314 J-5.766 E.04888
G1 X134.538 Y131.586 E.0136
G1 X133.953 Y131.464 E.0178
G1 X133.428 Y131.262 E.01675
G1 X132.908 Y130.958 E.01796
G1 X132.592 Y130.702 E.01209
G3 X132.214 Y131.089 I-1.682 J-1.268 E.01615
G1 X132.028 Y131.498 E.01338
G1 X131.75 Y131.795 E.01213
G1 X131.379 Y131.996 E.01257
M204 S10000
G1 X131.58 Y132.325 F42000
G1 F6364.866
M204 S6000
G1 X131.266 Y132.685 E.01423
G1 X131.535 Y133.114 E.01509
G1 X131.809 Y133.764 E.021
G1 X131.954 Y134.366 E.01845
G2 X133.469 Y133.106 I-4.041 J-6.402 E.05887
G1 X133.826 Y132.718 E.0157
G1 X134.378 Y131.938 E.02847
G1 X133.876 Y131.833 E.01528
G1 X133.274 Y131.607 E.01917
G1 X132.634 Y131.224 E.02222
G1 X132.533 Y131.331 E.00438
G1 X132.27 Y131.806 E.01617
G1 X131.877 Y132.168 E.01592
G1 X131.633 Y132.297 E.00822
M204 S10000
G1 X131.774 Y132.7 F42000
G1 F6364.866
M204 S6000
G1 X131.745 Y132.73 E.00125
G3 X132.196 Y133.75 I-3.775 J2.28 E.0333
G1 X132.597 Y133.438 E.01514
G2 X133.756 Y132.192 I-6.814 J-7.503 E.05073
G3 X132.743 Y131.776 I2.368 J-7.2 E.03266
G1 X132.457 Y132.167 E.01442
G3 X131.822 Y132.665 I-6.415 J-7.516 E.02404
M204 S10000
G1 X132.21 Y132.825 F42000
; LINE_WIDTH: 0.366928
G1 F7407.241
M204 S6000
G1 X132.375 Y133.158 E.00951
G2 X133.179 Y132.356 I-6.38 J-7.197 E.02907
G1 X132.866 Y132.215 E.00878
G1 X132.433 Y132.668 E.01606
G1 X132.259 Y132.791 E.00544
; WIPE_START
G1 X132.433 Y132.668 E-.08076
G1 X132.866 Y132.215 E-.23839
G1 X133.179 Y132.356 E-.13029
G1 X132.94 Y132.615 E-.13362
G1 X132.604 Y132.937 E-.17695
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.793 Y136.794 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.353146
G1 F7736.31
M204 S6000
G1 X129.091 Y137.126 E.01903
M204 S10000
G1 X129.082 Y137.083 F42000
; LINE_WIDTH: 0.155813
G1 F15000
M204 S6000
G1 X129.211 Y137.043 E.0012
; LINE_WIDTH: 0.177558
G1 X129.817 Y136.831 E.00683
M204 S10000
G1 X129.082 Y137.083 F42000
; LINE_WIDTH: 0.116547
G1 F15000
M204 S6000
G1 X128.953 Y137.122 E.00078
; WIPE_START
G1 X129.082 Y137.083 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.042 Y137.117 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.117473
G1 F15000
M204 S6000
G1 X126.917 Y137.081 E.00077
; LINE_WIDTH: 0.161176
G1 X126.778 Y137.04 E.00136
; LINE_WIDTH: 0.192077
G1 X126.753 Y137.03 E.00031
; LINE_WIDTH: 0.172952
G1 X126.636 Y136.916 E.00168
; LINE_WIDTH: 0.123041
G1 X126.518 Y136.803 E.00103
; LINE_WIDTH: 0.0970913
G1 X126.496 Y136.779 E.00014
; WIPE_START
G1 X126.518 Y136.803 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.122 Y131.405 Z2 F42000
G1 X119.223 Y129.506 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0970686
G1 F15000
M204 S6000
G1 X119.199 Y129.484 E.00014
; LINE_WIDTH: 0.122712
G1 X119.087 Y129.368 E.00102
; LINE_WIDTH: 0.175216
G1 X118.975 Y129.251 E.00169
G1 X118.958 Y129.209 E.00047
; LINE_WIDTH: 0.157764
G1 X118.922 Y129.092 E.00111
; LINE_WIDTH: 0.117862
G1 X118.883 Y128.956 E.00083
; WIPE_START
G1 X118.922 Y129.092 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X118.883 Y127.044 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.117864
G1 F15000
M204 S6000
G1 X118.922 Y126.908 E.00083
; LINE_WIDTH: 0.157757
G1 X118.958 Y126.791 E.00111
; LINE_WIDTH: 0.175229
G1 X118.975 Y126.749 E.00047
G1 X119.087 Y126.632 E.00169
; LINE_WIDTH: 0.122752
G1 X119.199 Y126.516 E.00102
; LINE_WIDTH: 0.0970875
G1 X119.223 Y126.494 E.00014
; WIPE_START
G1 X119.199 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
M73 P68 R4
G1 X126.831 Y126.506 Z2 F42000
G1 X136.781 Y126.494 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0970932
G1 F15000
M204 S6000
G1 X136.805 Y126.516 E.00014
; LINE_WIDTH: 0.12282
G1 X136.918 Y126.633 E.00102
; LINE_WIDTH: 0.172333
G1 X137.03 Y126.749 E.00166
; LINE_WIDTH: 0.188866
G1 X137.042 Y126.781 E.00039
; LINE_WIDTH: 0.15806
G1 X137.083 Y126.916 E.00129
; LINE_WIDTH: 0.116753
G1 X137.121 Y127.041 E.00076
; WIPE_START
G1 X137.083 Y126.916 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.121 Y128.958 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.116752
G1 F15000
M204 S6000
G1 X137.083 Y129.084 E.00076
; LINE_WIDTH: 0.158083
G1 X137.042 Y129.219 E.00129
; LINE_WIDTH: 0.188902
G1 X137.03 Y129.251 E.00039
; LINE_WIDTH: 0.172376
G1 X136.918 Y129.367 E.00166
; LINE_WIDTH: 0.12286
G1 X136.805 Y129.484 E.00102
; LINE_WIDTH: 0.0970931
G1 X136.781 Y129.506 E.00014
; OBJECT_ID: 114
; WIPE_START
G1 X136.805 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S10000
G1 X129.208 Y128.756 Z2 F42000
G1 X103.981 Y126.337 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
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
G1 X104.382 Y126.557 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
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
M204 S6000
G1 X104.363 Y126.079 E-.19337
G1 X104.823 Y125.95 E-.18163
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.555 Y119.579 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X108.577 Y119.601 E.00098
G3 X106.846 Y118.902 I-1.57 J1.396 E.36224
G3 X107.585 Y118.983 I.124 J2.3 E.02402
G1 X107.793 Y119.049 E.00703
G3 X108.345 Y119.377 I-.786 J1.948 E.02073
G1 X108.512 Y119.538 E.00745
M204 S250
G1 X108.284 Y119.862 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X108.283 Y119.862 E.00002
G3 X106.876 Y119.294 I-1.276 J1.135 E.27283
G3 X107.467 Y119.357 I.099 J1.894 E.01777
G1 X107.646 Y119.413 E.00561
G3 X108.095 Y119.681 I-.639 J1.584 E.01561
G1 X108.24 Y119.82 E.006
; WIPE_START
M204 S6000
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
M204 S10000
G1 X114.8 Y126.09 Z2 F42000
G1 X115.653 Y126.695 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X115.81 Y126.928 E.00904
G3 X113.823 Y130.09 I-1.804 J1.072 E.14806
G3 X113.709 Y125.923 I.184 J-2.09 E.19643
G3 X115.613 Y126.65 I.297 J2.077 E.06843
M204 S250
G1 X115.333 Y126.92 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X115.48 Y127.124 E.00749
G3 X113.754 Y126.312 I-1.466 J.876 E.25942
G3 X114.706 Y126.439 I.264 J1.655 E.02903
G3 X115.297 Y126.873 I-.693 J1.562 E.022
; WIPE_START
M204 S6000
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
M204 S10000
G1 X110.296 Y134.29 Z2 F42000
G1 X107.789 Y136.94 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X107.696 Y136.986 E.00333
G3 X106.789 Y132.913 I-.681 J-1.986 E.22715
G3 X108.217 Y133.279 I.212 J2.14 E.04839
G3 X108.082 Y136.808 I-1.203 J1.721 E.13493
G1 X107.843 Y136.916 E.00841
M204 S250
G1 X107.629 Y136.585 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X107.578 Y136.614 E.00175
G3 X106.819 Y133.304 I-.564 J-1.613 E.1712
G3 X107.766 Y133.467 I.201 J1.665 E.02903
G3 X107.882 Y136.473 I-.752 J1.534 E.10956
G1 X107.684 Y136.561 E.00647
; WIPE_START
M204 S6000
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
M204 S10000
G1 X102.469 Y129.383 Z2 F42000
G1 X102.041 Y128.512 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X102.009 Y128.634 E.00403
G3 X99.765 Y125.91 I-2.002 J-.637 E.28975
G3 X100.19 Y125.91 I.214 J1.376 E.01371
G1 X100.407 Y125.935 E.00703
G3 X102.083 Y128.321 I-.4 J2.062 E.10361
G1 X102.054 Y128.454 E.00438
M204 S250
G1 X101.659 Y128.423 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X101.635 Y128.515 E.00284
G3 X99.811 Y126.301 I-1.628 J-.518 E.21823
G3 X100.145 Y126.299 I.173 J1.084 E.01001
G1 X100.332 Y126.321 E.00561
G3 X101.695 Y128.261 I-.326 J1.677 E.07803
G1 X101.672 Y128.365 E.00316
; WIPE_START
M204 S6000
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
M204 S10000
G1 X103.955 Y122.969 Z2 F42000
G1 X106.305 Y118.629 Z2
G1 Z1.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X106.866 Y118.603 I.702 J9.369 E.01808
G1 X107.428 Y118.612 E.01808
G3 X106.245 Y118.633 I-.422 J9.386 E1.86023
M204 S250
G1 X106.275 Y118.237 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X107.446 Y118.22 I.73 J9.76 E.03489
G3 X116.221 Y124.702 I-.451 J9.792 E.34461
G3 X106.215 Y118.242 I-9.216 J3.295 E1.45034
M204 S10000
G1 X106.047 Y118.883 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.11749
G1 F15000
M204 S6000
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
M204 S10000
G1 X107.958 Y118.878 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.116544
G1 F15000
M204 S6000
G1 X108.087 Y118.917 E.00078
; LINE_WIDTH: 0.155808
G1 X108.216 Y118.957 E.0012
; LINE_WIDTH: 0.177553
G1 X108.822 Y119.168 E.00683
M204 S10000
G1 X108.797 Y119.206 F42000
; LINE_WIDTH: 0.353127
G1 F7736.79
M204 S6000
G1 X108.095 Y118.874 E.01904
; WIPE_START
G1 X108.797 Y119.206 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X111.215 Y123.175 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.370128
G1 F7334.794
M204 S6000
G1 X111.667 Y123.544 E.0151
G1 X111.872 Y123.782 E.0081
G1 X112.183 Y123.64 E.00885
G1 X111.686 Y123.113 E.01874
G1 X111.365 Y122.845 E.0108
G1 X111.24 Y123.12 E.00783
M204 S10000
G1 X110.866 Y123.388 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X111.244 Y123.63 E.01339
G3 X111.777 Y124.232 I-2.064 J2.366 E.02399
G1 X112.382 Y123.934 E.02007
G1 X112.755 Y123.805 E.01176
G2 X111.201 Y122.25 I-5.738 J4.18 E.06575
G1 X110.95 Y122.898 E.02071
G1 X110.749 Y123.269 E.01256
G1 X110.824 Y123.345 E.00315
M204 S10000
G1 X110.584 Y123.675 F42000
G1 F6364.866
M204 S6000
G1 X111.007 Y123.924 E.01461
G1 X111.345 Y124.29 E.01483
G1 X111.595 Y124.736 E.01523
G1 X111.638 Y124.776 E.00176
G1 X112.103 Y124.477 E.01648
G1 X112.842 Y124.175 E.02377
G1 X113.38 Y124.058 E.01641
G2 X110.958 Y121.634 I-6.376 J3.948 E.10297
G1 X110.815 Y122.23 E.01826
G1 X110.606 Y122.744 E.01654
G1 X110.27 Y123.315 E.01974
G1 X110.545 Y123.63 E.01244
M204 S10000
G1 X110.325 Y123.989 F42000
G1 F6364.866
M204 S6000
G1 X110.673 Y124.145 E.01135
G1 X110.978 Y124.427 E.01238
G3 X111.246 Y124.949 I-2.139 J1.429 E.0175
G1 X111.507 Y125.168 E.01014
G1 X111.597 Y125.297 E.0047
G1 X112.187 Y124.865 E.0218
G1 X112.69 Y124.622 E.01664
G1 X113.367 Y124.438 E.0209
G1 X114.002 Y124.394 E.01896
G2 X110.841 Y121.126 I-7.006 J3.615 E.13736
G1 X110.632 Y121.038 E.00678
G3 X109.708 Y123.411 I-3.749 J-.093 E.07741
G1 X110.02 Y123.596 E.01081
G1 X110.299 Y123.934 E.01306
; WIPE_START
G1 X110.02 Y123.596 E-.16665
G1 X109.708 Y123.411 E-.1379
G1 X109.95 Y123.117 E-.14496
G1 X110.239 Y122.642 E-.21098
G1 X110.339 Y122.401 E-.09952
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.068 Y123.663 Z2 F42000
G1 Z1.6
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X109.428 Y123.696 E.01076
G1 X109.775 Y123.883 E.01177
G3 X110.082 Y124.312 I-.91 J.974 E.01579
G1 X110.417 Y124.43 E.01059
G1 X110.682 Y124.661 E.01046
G1 X110.854 Y125.006 E.01149
G1 X110.902 Y125.192 E.00574
G1 X111.124 Y125.325 E.00768
G1 X111.374 Y125.631 E.0118
G1 X111.46 Y125.989 E.01096
G3 X113.651 Y124.78 I2.592 J2.106 E.0764
G1 X114.248 Y124.765 E.0178
G1 X114.616 Y124.814 E.01105
G1 X114.221 Y123.996 E.02705
G2 X110.193 Y120.391 I-7.327 J4.133 E.16392
G1 X110.249 Y120.909 E.01553
G1 X110.209 Y121.547 E.01905
G3 X109.546 Y123.026 I-3.543 J-.7 E.04869
G3 X108.98 Y123.577 I-2.372 J-1.87 E.0236
G1 X109.025 Y123.621 E.00187
M204 S10000
G1 X108.859 Y124.064 F42000
; LINE_WIDTH: 0.419435
G1 F6374.259
M204 S6000
G1 X109.237 Y124.04 E.01127
G1 X109.461 Y124.12 E.00706
G1 X109.645 Y124.303 E.00772
G1 X109.78 Y124.648 E.01103
G1 X110.193 Y124.738 E.01259
G1 X110.409 Y124.926 E.00851
G3 X110.526 Y125.443 I-.931 J.483 E.01593
G1 X110.888 Y125.619 E.01196
G1 X111.038 Y125.803 E.00707
G1 X111.1 Y126.087 E.00865
G1 X111.052 Y126.398 E.00936
G1 X111.249 Y126.549 E.00739
G1 X111.399 Y126.836 E.00964
G1 X111.643 Y126.366 E.01576
G3 X113.66 Y125.157 I2.414 J1.739 E.0719
G1 X114.257 Y125.142 E.01777
G1 X114.809 Y125.242 E.01669
G1 X115.223 Y125.393 E.0131
G2 X109.602 Y119.775 I-8.195 J2.578 E.24572
G1 X109.787 Y120.281 E.01602
G1 X109.873 Y120.924 E.01929
G1 X109.834 Y121.504 E.0173
G1 X109.695 Y122.012 E.01565
G3 X109.264 Y122.775 I-2.688 J-1.012 E.02618
G1 X108.796 Y123.24 E.01962
G1 X108.318 Y123.551 E.01697
G1 X108.06 Y123.653 E.00826
G1 X108.331 Y123.615 E.00815
G1 X108.664 Y123.785 E.01114
G1 X108.825 Y124.014 E.00832
; WIPE_START
G1 X108.664 Y123.785 E-.10624
G1 X108.331 Y123.615 E-.14231
G1 X108.06 Y123.653 E-.10407
G1 X108.318 Y123.551 E-.10553
G1 X108.796 Y123.24 E-.21677
G1 X108.955 Y123.082 E-.08508
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.819 Y123.741 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.39444
G1 F6827.492
M204 S6000
G1 X108.003 Y123.673 E.00545
; WIPE_START
G1 X107.819 Y123.741 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.392 Y123.572 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.38686
G1 F6977.961
M204 S6000
G1 X102.783 Y123.129 E.01606
G1 X102.647 Y122.828 E.00898
G2 X101.862 Y123.633 I4.229 J4.906 E.03058
G1 X102.169 Y123.773 E.00918
G1 X102.347 Y123.612 E.00652
M204 S10000
G1 X102.631 Y123.89 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X102.955 Y123.451 E.01626
G1 X103.23 Y123.215 E.01079
G1 X102.941 Y122.625 E.01957
G1 X102.813 Y122.252 E.01176
G2 X101.255 Y123.81 I3.993 J5.551 E.06592
G3 X102.227 Y124.226 I-1.259 J4.282 E.03157
G1 X102.584 Y123.929 E.01385
M204 S10000
G1 X102.925 Y124.135 F42000
G1 F6364.866
M204 S6000
G1 X103.225 Y123.714 E.01539
G3 X103.764 Y123.344 I1.185 J1.148 E.01961
G3 X103.077 Y121.721 I3.394 J-2.394 E.0529
G1 X103.058 Y121.628 E.00283
G2 X100.644 Y124.065 I3.832 J6.212 E.10314
G1 X101.321 Y124.217 E.02069
G3 X102.315 Y124.732 I-1.376 J3.875 E.03342
G1 X102.599 Y124.386 E.01332
G1 X102.878 Y124.172 E.01047
M204 S10000
G1 X103.214 Y124.439 F42000
G1 F6364.866
M204 S6000
G1 X103.377 Y124.116 E.01077
G1 X103.679 Y123.821 E.01257
G1 X104.083 Y123.628 E.01336
G1 X104.214 Y123.599 E.00397
G1 X104.342 Y123.452 E.0058
G3 X103.428 Y121.555 I2.635 J-2.438 E.06365
G1 X103.4 Y121.004 E.01644
G2 X100.27 Y123.955 I3.533 J6.884 E.12987
G1 X100.012 Y124.386 E.01496
G1 X100.471 Y124.414 E.01369
G1 X101.056 Y124.536 E.0178
G1 X101.614 Y124.753 E.01785
G1 X102.127 Y125.059 E.01777
G1 X102.472 Y125.358 E.01361
G1 X102.514 Y125.171 E.00569
G1 X102.776 Y124.743 E.01496
G1 X103.084 Y124.494 E.01178
G1 X103.159 Y124.462 E.00245
; WIPE_START
G1 X103.084 Y124.494 E-.03127
G1 X102.776 Y124.743 E-.15026
G1 X102.514 Y125.171 E-.1909
G1 X102.472 Y125.358 E-.07259
G1 X102.127 Y125.059 E-.17369
G1 X101.807 Y124.868 E-.1413
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.808 Y125.671 Z2 F42000
G1 Z1.6
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X102.867 Y125.303 E.01108
G1 X103.054 Y124.997 E.01069
G3 X103.519 Y124.7 I.888 J.875 E.01658
G1 X103.681 Y124.34 E.01176
G1 X103.896 Y124.128 E.00898
G1 X104.236 Y123.978 E.01107
G1 X104.449 Y123.936 E.00647
G1 X104.679 Y123.642 E.01111
G1 X104.941 Y123.501 E.00886
G1 X104.523 Y123.089 E.01748
G1 X104.188 Y122.615 E.01729
G1 X103.973 Y122.162 E.01492
G1 X103.811 Y121.548 E.01891
G1 X103.772 Y120.759 E.02356
G1 X103.82 Y120.393 E.01098
G2 X99.946 Y123.762 I3.141 J7.524 E.15557
G2 X99.4 Y124.813 I4.648 J3.083 E.03536
G1 X99.745 Y124.764 E.01038
G1 X100.394 Y124.783 E.01935
G1 X100.979 Y124.905 E.0178
G3 X102.514 Y125.948 I-1.042 J3.185 E.05599
G1 X102.764 Y125.712 E.01025
M204 S10000
G1 X103.194 Y125.904 F42000
G1 F6364.866
M204 S6000
G1 X103.186 Y125.589 E.00939
G1 X103.267 Y125.339 E.00783
G1 X103.464 Y125.145 E.00823
G1 X103.835 Y125.022 E.01165
G1 X103.966 Y124.591 E.01341
G1 X104.114 Y124.436 E.00638
G1 X104.361 Y124.338 E.00791
G1 X104.676 Y124.327 E.00938
G1 X104.845 Y124.011 E.01067
G1 X104.994 Y123.877 E.00598
G1 X105.28 Y123.792 E.00888
G1 X105.662 Y123.862 E.01158
G1 X105.884 Y123.639 E.00939
G1 X105.39 Y123.374 E.0167
G1 X104.984 Y123.039 E.01567
G1 X104.697 Y122.707 E.01309
G3 X104.163 Y121.347 I2.781 J-1.875 E.04386
G1 X104.149 Y120.749 E.0178
G1 X104.266 Y120.153 E.01811
G1 X104.433 Y119.781 E.01214
G2 X99.883 Y123.132 I2.488 J8.143 E.17156
G1 X99.345 Y124.033 E.03128
G2 X98.792 Y125.397 I7.174 J3.699 E.04389
G1 X99.287 Y125.219 E.01567
G1 X99.745 Y125.141 E.01383
G1 X100.317 Y125.152 E.01704
G1 X100.902 Y125.274 E.0178
G1 X101.375 Y125.473 E.0153
G1 X101.801 Y125.759 E.01526
G1 X102.205 Y126.163 E.01704
; LINE_WIDTH: 0.43822
G1 F6071.338
G1 X102.332 Y126.318 E.00625
; LINE_WIDTH: 0.47468
G1 F5558.644
G1 X102.46 Y126.472 E.00682
; LINE_WIDTH: 0.51114
G1 F5125.796
G1 X102.587 Y126.626 E.0074
; LINE_WIDTH: 0.547835
G1 F4753.275
G1 X102.652 Y126.701 E.00394
G1 X102.649 Y126.602 E.00394
; LINE_WIDTH: 0.51114
G1 F5125.796
G1 X102.703 Y126.461 E.00561
; LINE_WIDTH: 0.47468
G1 F5558.644
G1 X102.758 Y126.319 E.00517
; LINE_WIDTH: 0.42489
G1 F6283.226
G1 X102.812 Y126.178 E.00457
G3 X103.143 Y125.934 I.768 J.697 E.01247
; WIPE_START
G1 X102.98 Y126.029 E-.25397
G1 X102.812 Y126.178 E-.30178
G1 X102.758 Y126.319 E-.20425
; WIPE_END
M73 P69 R4
G1 E-.04 F1800
M204 S10000
G1 X102.722 Y126.9 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.55594
G1 F4678.18
M204 S6000
G1 X102.672 Y126.758 E.00611
; WIPE_START
G1 X102.722 Y126.9 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.529 Y127.997 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.491315
G1 F5352.423
M204 S6000
G1 X102.46 Y128.368 E.01337
; LINE_WIDTH: 0.420954
G1 F6348.641
G3 X101.508 Y129.994 I-2.408 J-.318 E.05776
G1 X101.026 Y130.272 E.01663
G1 X100.535 Y130.437 E.01545
G3 X98.405 Y129.895 I-.527 J-2.385 E.06808
G1 X98.316 Y129.987 E.00383
G1 X98.23 Y130.001 E.00261
G2 X105.026 Y136.781 I8.788 J-2.012 E.30231
G1 X105.051 Y136.652 E.00391
G1 X105.115 Y136.596 E.00255
G1 X104.845 Y136.235 E.01347
G1 X104.608 Y135.686 E.01784
G3 X104.599 Y134.367 I2.513 J-.678 E.03983
G1 X104.776 Y133.89 E.01519
G1 X105.053 Y133.45 E.01554
G1 X105.383 Y133.113 E.01407
G1 X105.876 Y132.776 E.01785
G1 X106.373 Y132.573 E.01603
; LINE_WIDTH: 0.48595
G1 F5417.24
G1 X106.765 Y132.478 E.01411
; LINE_WIDTH: 0.490119
G1 F5366.746
G1 X106.948 Y132.499 E.0065
; LINE_WIDTH: 0.452255
G1 F5863.168
G1 X107.13 Y132.521 E.00595
; LINE_WIDTH: 0.419652
G1 F6370.576
G3 X107.774 Y132.625 I-.536 J5.353 E.0194
G1 X108.127 Y132.77 E.01138
G1 X108.556 Y133.051 E.01527
G1 X108.983 Y133.475 E.01791
G3 X109.361 Y134.17 I-2.25 J1.673 E.02361
G1 X109.488 Y134.782 E.01859
G1 X109.485 Y135.301 E.01544
G1 X109.366 Y135.798 E.01522
G3 X109.058 Y136.395 I-2.742 J-1.037 E.02003
G1 X109.206 Y136.729 E.01087
G2 X113.227 Y134.512 I-2.231 J-8.802 E.13815
G1 X113.965 Y133.717 E.03226
G2 X115.783 Y129.982 I-6.868 J-5.653 E.12477
G1 X115.659 Y129.955 E.00376
G1 X115.607 Y129.896 E.00235
G1 X115.329 Y130.115 E.01051
G1 X114.925 Y130.316 E.01345
G1 X114.304 Y130.479 E.0191
G1 X113.773 Y130.479 E.01578
G1 X113.185 Y130.356 E.01788
G3 X111.895 Y129.321 I.799 J-2.316 E.05021
; LINE_WIDTH: 0.436825
G1 F6092.84
G1 X111.795 Y129.151 E.00612
; LINE_WIDTH: 0.470495
G1 F5613.05
G1 X111.695 Y128.982 E.00664
; LINE_WIDTH: 0.512756
G1 F5108.166
G1 X111.595 Y128.812 E.0073
G1 X111.497 Y128.406 E.01553
; LINE_WIDTH: 0.489999
G1 F5368.187
G1 X111.509 Y128.266 E.00495
; LINE_WIDTH: 0.444815
G1 F5971.709
G1 X111.521 Y128.127 E.00445
; LINE_WIDTH: 0.399632
G1 F6728.123
G1 X111.532 Y127.987 E.00395
; LINE_WIDTH: 0.39835
G1 F6752.385
G1 X111.523 Y127.873 E.00322
; LINE_WIDTH: 0.44097
G1 F6029.393
G1 X111.514 Y127.759 E.0036
; LINE_WIDTH: 0.48359
G1 F5446.252
G1 X111.505 Y127.644 E.00399
; LINE_WIDTH: 0.523483
G1 F4994.149
G1 X111.496 Y127.53 E.00435
G1 X111.644 Y127.1 E.01727
; LINE_WIDTH: 0.47855
G1 F5509.262
G1 X111.782 Y126.873 E.00917
; LINE_WIDTH: 0.420255
G1 F6360.395
G3 X112.527 Y125.992 I2.53 J1.384 E.03462
G3 X113.202 Y125.639 I1.593 J2.226 E.02276
G1 X113.778 Y125.531 E.01746
G1 X114.307 Y125.522 E.01579
G1 X114.924 Y125.684 E.01902
G1 X115.381 Y125.917 E.01529
G1 X115.608 Y126.104 E.00875
G3 X115.784 Y126 I.16 J.07 E.00653
G2 X109.206 Y119.271 I-8.778 J2.001 E.29514
G1 X109.058 Y119.605 E.01089
G1 X109.29 Y119.992 E.01346
G1 X109.464 Y120.593 E.01865
G1 X109.5 Y121.11 E.01544
G3 X109.319 Y121.927 I-2.363 J-.094 E.02509
G1 X109 Y122.502 E.01958
G1 X108.556 Y122.949 E.01879
G1 X108.127 Y123.23 E.01529
G1 X107.736 Y123.386 E.01255
; LINE_WIDTH: 0.404355
G1 F6640.199
G1 X107.22 Y123.465 E.01491
; LINE_WIDTH: 0.410234
G1 F6533.931
G1 X107.066 Y123.486 E.0045
; LINE_WIDTH: 0.45326
G1 F5848.808
G1 X106.912 Y123.506 E.00503
; LINE_WIDTH: 0.495235
G1 F5306.039
G1 X106.758 Y123.527 E.00555
G1 X106.262 Y123.409 E.01824
; LINE_WIDTH: 0.45902
G1 F5767.844
G1 X106.004 Y123.279 E.00948
; LINE_WIDTH: 0.420176
G1 F6361.728
G1 X105.747 Y123.148 E.0086
G1 X105.286 Y122.808 E.01706
G3 X104.54 Y121.337 I1.844 J-1.86 E.05
G1 X104.526 Y120.74 E.01781
G1 X104.61 Y120.307 E.01314
G1 X104.898 Y119.668 E.02089
G1 X105.111 Y119.399 E.01024
G3 X105.007 Y119.223 I.07 J-.16 E.0065
G1 X103.929 Y119.548 E.03355
G2 X99.299 Y123.375 I2.996 J8.34 E.18264
G2 X98.235 Y126.02 I6.993 J4.35 E.08538
G3 X98.406 Y126.104 I.028 J.158 E.00609
G3 X100.24 Y125.521 I1.597 J1.847 E.05896
G1 X100.825 Y125.643 E.01781
G3 X101.894 Y126.376 I-.9 J2.458 E.03902
G1 X102.231 Y126.87 E.01781
G1 X102.394 Y127.271 E.01291
; LINE_WIDTH: 0.443788
G1 F5987.016
G1 X102.456 Y127.604 E.01074
; LINE_WIDTH: 0.491503
G1 F5350.186
G1 X102.518 Y127.938 E.01202
; WIPE_START
G1 X102.456 Y127.604 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.219 Y128.972 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.419639
G1 F6370.795
M204 S6000
G1 X102.868 Y128.625 E.01469
G1 X102.839 Y128.431 E.00585
; LINE_WIDTH: 0.444118
G1 F5982.091
G1 X102.94 Y128.216 E.00754
; LINE_WIDTH: 0.475091
G1 F5553.357
G1 X103.041 Y128 E.00812
G1 X102.828 Y127.532 E.01757
; LINE_WIDTH: 0.423158
G1 F6311.843
G1 X102.898 Y127.344 E.00602
G1 X103.219 Y127.028 E.01354
G1 X103.077 Y126.544 E.01515
G1 X103.15 Y126.367 E.00574
G1 X103.58 Y126.116 E.01495
G1 X103.562 Y125.619 E.01495
G1 X103.64 Y125.481 E.00477
G1 X104.156 Y125.323 E.01622
G1 X104.272 Y124.813 E.0157
G1 X104.4 Y124.714 E.00485
G1 X104.911 Y124.698 E.01538
G1 X105.144 Y124.242 E.01538
G1 X105.288 Y124.169 E.00487
G1 X105.798 Y124.281 E.01568
G1 X106.201 Y123.842 E.0179
G1 X106.35 Y123.857 E.0045
; LINE_WIDTH: 0.480098
G1 F5489.762
G1 X106.554 Y123.949 E.00771
; LINE_WIDTH: 0.505233
G1 F5191.294
G1 X106.758 Y124.04 E.00816
; LINE_WIDTH: 0.500499
G1 F5245.004
G1 X106.89 Y123.97 E.00541
; LINE_WIDTH: 0.465895
G1 F5674.094
G1 X107.022 Y123.9 E.005
; LINE_WIDTH: 0.419325
G1 F6376.118
G1 X107.154 Y123.83 E.00445
G1 X107.348 Y123.824 E.00578
G1 X107.739 Y124.159 E.01531
G1 X108.249 Y123.983 E.01602
G1 X108.405 Y124.063 E.00523
G1 X108.672 Y124.462 E.01426
G1 X109.188 Y124.414 E.01543
G1 X109.324 Y124.502 E.0048
G1 X109.499 Y124.987 E.01535
G1 X110.009 Y125.068 E.01535
G1 X110.119 Y125.18 E.00466
G1 X110.17 Y125.702 E.01558
G1 X110.636 Y125.902 E.01508
G1 X110.714 Y126.001 E.00375
G1 X110.642 Y126.56 E.01676
G1 X111.02 Y126.849 E.01414
; LINE_WIDTH: 0.437469
G1 F6082.906
G1 X111.062 Y126.912 E.00234
; LINE_WIDTH: 0.472425
G1 F5587.828
G1 X111.103 Y126.975 E.00255
; LINE_WIDTH: 0.507382
G1 F5167.272
G1 X111.144 Y127.038 E.00276
; LINE_WIDTH: 0.53619
G1 F4865.49
G1 X110.96 Y127.501 E.0194
; LINE_WIDTH: 0.527209
G1 F4955.725
G1 X111.034 Y127.628 E.00563
; LINE_WIDTH: 0.486585
G1 F5409.487
G1 X111.109 Y127.755 E.00516
; LINE_WIDTH: 0.433434
G1 F6145.755
G1 X111.183 Y127.882 E.00454
G1 X111.183 Y128.118 E.00731
; LINE_WIDTH: 0.445845
G1 F5956.443
G1 X111.108 Y128.245 E.00468
; LINE_WIDTH: 0.486215
G1 F5414.002
G1 X111.034 Y128.372 E.00515
; LINE_WIDTH: 0.532191
G1 F4905.265
G1 X110.96 Y128.499 E.00569
G1 X111.14 Y128.952 E.01881
; LINE_WIDTH: 0.504165
G1 F5203.309
G1 X111.1 Y129.018 E.00283
; LINE_WIDTH: 0.470495
G1 F5613.05
G1 X111.06 Y129.085 E.00262
; LINE_WIDTH: 0.420235
G1 F6360.741
G1 X111.02 Y129.151 E.00231
G1 X110.642 Y129.44 E.01417
G1 X110.714 Y129.999 E.0168
G1 X110.608 Y130.113 E.00464
G1 X110.17 Y130.298 E.01417
G1 X110.124 Y130.803 E.01512
G1 X110.025 Y130.925 E.00465
G1 X109.499 Y131.013 E.0159
G1 X109.324 Y131.498 E.01538
G1 X109.188 Y131.586 E.00482
G1 X108.672 Y131.538 E.01546
G1 X108.389 Y131.957 E.01508
G1 X108.249 Y132.017 E.00453
G1 X107.739 Y131.841 E.01606
; LINE_WIDTH: 0.412466
G1 F6494.468
G1 X107.348 Y132.175 E.01502
G1 X107.151 Y132.175 E.00575
; LINE_WIDTH: 0.448398
G1 F5918.947
G1 X106.954 Y132.067 E.00718
; LINE_WIDTH: 0.491712
G1 F5347.69
G1 X106.758 Y131.96 E.00795
G1 X106.293 Y132.161 E.01796
; LINE_WIDTH: 0.42243
G1 F6323.947
G1 X106.204 Y132.154 E.00266
G1 X105.798 Y131.719 E.01783
G1 X105.335 Y131.826 E.01425
G1 X105.192 Y131.802 E.00436
G1 X104.911 Y131.302 E.01719
G1 X104.4 Y131.286 E.01535
G1 X104.272 Y131.187 E.00484
G1 X104.156 Y130.677 E.01568
G1 X103.655 Y130.529 E.01568
G1 X103.563 Y130.392 E.00494
G1 X103.58 Y129.884 E.01525
G1 X103.138 Y129.622 E.01541
G1 X103.084 Y129.54 E.00294
G3 X103.202 Y129.03 I2.496 J.308 E.01572
M204 S10000
G1 X102.649 Y129.305 F42000
; LINE_WIDTH: 0.55653
G1 F4672.806
M204 S6000
G1 X102.702 Y129.157 E.00639
; WIPE_START
G1 X102.649 Y129.305 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.194 Y130.096 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X102.885 Y129.902 E.01086
G1 X102.725 Y129.656 E.00876
; LINE_WIDTH: 0.444562
G1 F5975.476
G1 X102.7 Y129.539 E.00379
; LINE_WIDTH: 0.493705
G1 F5324.046
G1 X102.675 Y129.422 E.00426
; LINE_WIDTH: 0.542849
G1 F4800.688
G1 X102.649 Y129.305 E.00472
G1 X102.468 Y129.523 E.0112
; LINE_WIDTH: 0.493705
G1 F5324.046
G1 X102.287 Y129.742 E.0101
; LINE_WIDTH: 0.420326
G1 F6359.211
G1 X102.106 Y129.96 E.00846
G1 X101.713 Y130.31 E.01568
G1 X101.18 Y130.616 E.01833
G1 X100.635 Y130.8 E.01715
G1 X100.073 Y130.871 E.01689
G3 X98.785 Y130.61 I.036 J-3.478 E.03944
G2 X104.434 Y136.233 I8.24 J-2.629 E.24696
G1 X104.226 Y135.721 E.01647
G3 X104.235 Y134.267 I2.983 J-.709 E.04376
G1 X104.432 Y133.736 E.01688
G1 X104.699 Y133.29 E.01549
G1 X105.081 Y132.877 E.01679
G1 X105.568 Y132.53 E.01782
G1 X105.885 Y132.361 E.0107
G1 X105.662 Y132.138 E.0094
G1 X105.42 Y132.194 E.00741
G1 X105.094 Y132.172 E.00975
G1 X104.845 Y131.989 E.00921
G1 X104.676 Y131.673 E.01068
G1 X104.309 Y131.652 E.01094
G1 X104.047 Y131.508 E.0089
G1 X103.935 Y131.356 E.00563
G1 X103.835 Y130.978 E.01166
G1 X103.42 Y130.826 E.0132
G1 X103.268 Y130.662 E.00665
G3 X103.193 Y130.156 I.677 J-.359 E.01556
M204 S10000
G1 X102.79 Y130.297 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G3 X102.527 Y130.043 I.294 J-.569 E.01106
G3 X100.034 Y131.247 I-2.551 J-2.098 E.08507
G1 X99.4 Y131.187 E.01899
G2 X100.825 Y133.463 I7.757 J-3.273 E.08034
G2 X103.82 Y135.607 I6.226 J-5.533 E.11063
G1 X103.758 Y134.948 E.01972
G1 X103.832 Y134.311 E.0191
G3 X104.493 Y132.945 I3.481 J.842 E.04556
G1 X104.933 Y132.511 E.01839
G1 X104.788 Y132.439 E.00483
G3 X104.418 Y132.044 I1.096 J-1.397 E.01616
G1 X104.052 Y131.961 E.01119
G1 X103.765 Y131.76 E.01043
G3 X103.494 Y131.274 I.922 J-.834 E.01672
G1 X103.16 Y131.101 E.0112
G1 X102.946 Y130.86 E.0096
G1 X102.816 Y130.495 E.01152
G1 X102.798 Y130.357 E.00417
; WIPE_START
G1 X102.816 Y130.495 E-.05322
G1 X102.946 Y130.86 E-.14697
G1 X103.16 Y131.101 E-.12245
G1 X103.494 Y131.274 E-.14293
G1 X103.599 Y131.526 E-.10378
G1 X103.765 Y131.76 E-.10912
G1 X103.941 Y131.883 E-.08153
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.214 Y131.561 Z2 F42000
G1 Z1.6
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X102.923 Y131.395 E.00998
G1 X102.625 Y131.057 E.01344
G1 X102.472 Y130.653 E.01286
G3 X100.044 Y131.625 I-2.52 J-2.778 E.07954
G1 X100.252 Y132.046 E.01398
G2 X103.278 Y134.935 I6.843 J-4.138 E.12606
G1 X103.382 Y134.962 E.0032
G3 X104.354 Y132.546 I3.589 J.04 E.07939
G2 X103.897 Y132.304 I-.57 J.526 E.0157
G1 X103.523 Y132.051 E.01345
G1 X103.262 Y131.695 E.01313
G1 X103.234 Y131.618 E.00245
M204 S10000
G1 X102.893 Y131.831 F42000
G1 F6364.866
M204 S6000
G1 X102.498 Y131.512 E.01514
G1 X102.315 Y131.269 E.00907
G3 X100.641 Y131.952 I-2.426 J-3.549 E.05426
G2 X103.053 Y134.366 I6.365 J-3.949 E.10254
G3 X103.749 Y132.675 I4.408 J.826 E.05484
G1 X103.261 Y132.322 E.01795
G3 X102.925 Y131.882 I1.759 J-1.69 E.01652
M204 S10000
G1 X102.631 Y132.11 F42000
G1 F6364.866
M204 S6000
G1 X102.227 Y131.774 E.01563
G1 X101.635 Y132.065 E.01964
G1 X101.258 Y132.194 E.01189
G1 X101.637 Y132.674 E.01823
G1 X102.231 Y133.279 E.02527
G2 X102.813 Y133.75 I6.002 J-6.827 E.02229
G1 X103.055 Y133.119 E.02013
G1 X103.23 Y132.785 E.01123
G1 X102.955 Y132.549 E.01079
G1 X102.666 Y132.158 E.01448
M204 S10000
G1 X102.372 Y132.4 F42000
; LINE_WIDTH: 0.385709
G1 F7001.404
M204 S6000
G1 X102.17 Y132.221 E.00731
G1 X101.854 Y132.365 E.00939
G2 X102.647 Y133.172 I5.539 J-4.645 E.03065
G1 X102.783 Y132.871 E.00895
G1 X102.411 Y132.445 E.0153
; WIPE_START
G1 X102.783 Y132.871 E-.21472
G1 X102.647 Y133.172 E-.12565
G1 X102.19 Y132.738 E-.2394
G1 X101.873 Y132.385 E-.18022
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.135 Y132.373 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.39848
G1 F6749.916
M204 S6000
G1 X107.876 Y132.279 E.00775
; WIPE_START
G1 X108.135 Y132.373 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.859 Y131.936 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.419594
G1 F6371.57
M204 S6000
G1 X108.601 Y132.273 E.01263
G1 X108.245 Y132.388 E.01112
G1 X108.135 Y132.373 E.0033
G1 X108.624 Y132.626 E.01637
G1 X109.029 Y132.961 E.01565
G3 X109.724 Y134.07 I-2.493 J2.334 E.03919
G1 X109.834 Y134.496 E.01308
G1 X109.873 Y135.076 E.01731
G1 X109.787 Y135.719 E.0193
G1 X109.602 Y136.225 E.01603
G2 X112.962 Y134.243 I-2.704 J-8.424 E.11704
G1 X113.677 Y133.473 E.03125
G2 X115.223 Y130.607 I-6.646 J-5.436 E.09749
G1 X114.726 Y130.781 E.01567
G3 X113.102 Y130.724 I-.698 J-3.284 E.04883
G3 X111.907 Y129.96 I1.069 J-2.988 E.04254
G3 X111.417 Y129.242 I2.546 J-2.265 E.02594
G3 X111.052 Y129.602 I-1.126 J-.78 E.01534
G1 X111.099 Y129.913 E.00937
G1 X111.038 Y130.197 E.00865
G1 X110.839 Y130.416 E.0088
G1 X110.526 Y130.557 E.01022
G1 X110.473 Y130.948 E.01173
G1 X110.356 Y131.141 E.00672
G1 X110.144 Y131.284 E.00761
G1 X109.78 Y131.352 E.01103
G1 X109.604 Y131.754 E.01305
G1 X109.461 Y131.88 E.00569
G1 X109.237 Y131.96 E.00706
G1 X108.919 Y131.94 E.00949
M204 S10000
G1 X109.035 Y132.353 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X108.98 Y132.423 E.00265
G3 X110.088 Y133.97 I-2.024 J2.62 E.0575
G1 X110.209 Y134.452 E.01481
G1 X110.25 Y135.091 E.01904
G1 X110.193 Y135.609 E.01554
G2 X112.748 Y133.92 I-3.102 J-7.468 E.09179
G1 X113.389 Y133.229 E.02807
G2 X114.616 Y131.186 I-6.416 J-5.244 E.07122
G1 X114.224 Y131.236 E.01176
G1 X113.619 Y131.217 E.01803
G1 X113.034 Y131.095 E.0178
G1 X112.518 Y130.888 E.01656
G1 X111.98 Y130.539 E.01909
G3 X111.46 Y130.011 I1.743 J-2.236 E.02215
G1 X111.374 Y130.369 E.01096
G1 X111.113 Y130.684 E.0122
G1 X110.881 Y130.837 E.00828
G1 X110.762 Y131.219 E.01191
G1 X110.522 Y131.498 E.01096
G3 X110.053 Y131.711 I-.78 J-1.095 E.01544
G1 X109.898 Y131.991 E.00952
G1 X109.659 Y132.201 E.00949
G1 X109.286 Y132.334 E.01178
G1 X109.094 Y132.348 E.00573
; WIPE_START
G1 X109.286 Y132.334 E-.07307
G1 X109.659 Y132.201 E-.1503
G1 X109.898 Y131.991 E-.12109
G1 X110.053 Y131.711 E-.12143
G1 X110.279 Y131.636 E-.09055
G1 X110.522 Y131.498 E-.10608
G1 X110.69 Y131.304 E-.09748
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.325 Y132.011 Z2 F42000
G1 Z1.6
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X110.191 Y132.227 E.00756
G1 X109.857 Y132.522 E.01329
G1 X109.708 Y132.588 E.00486
G1 X110.142 Y133.18 E.02186
G3 X110.624 Y134.76 I-3.57 J1.953 E.04956
G1 X110.653 Y134.975 E.00646
G2 X112.471 Y133.663 I-3.672 J-7.006 E.06703
G1 X113.101 Y132.985 E.02756
G2 X113.998 Y131.614 I-7.314 J-5.766 E.04888
G1 X113.543 Y131.586 E.0136
G1 X112.957 Y131.464 E.0178
G1 X112.433 Y131.262 E.01675
G1 X111.912 Y130.958 E.01796
G1 X111.597 Y130.702 E.01209
G3 X111.218 Y131.089 I-1.682 J-1.268 E.01615
G1 X111.033 Y131.498 E.01338
G1 X110.755 Y131.795 E.01213
G1 X110.383 Y131.996 E.01257
M204 S10000
G1 X110.584 Y132.325 F42000
G1 F6364.866
M204 S6000
G1 X110.27 Y132.685 E.01423
G1 X110.539 Y133.114 E.01509
G1 X110.813 Y133.764 E.021
G1 X110.958 Y134.366 E.01845
G2 X112.474 Y133.106 I-4.041 J-6.402 E.05887
G1 X112.83 Y132.718 E.0157
G1 X113.383 Y131.938 E.02847
G1 X112.881 Y131.833 E.01528
G1 X112.278 Y131.607 E.01917
G1 X111.638 Y131.224 E.02222
G1 X111.538 Y131.331 E.00438
G1 X111.274 Y131.806 E.01617
G1 X110.882 Y132.168 E.01592
G1 X110.637 Y132.297 E.00822
M204 S10000
G1 X110.779 Y132.7 F42000
G1 F6364.866
M204 S6000
G1 X110.749 Y132.73 E.00125
G3 X111.201 Y133.75 I-3.775 J2.28 E.0333
G1 X111.601 Y133.438 E.01514
G2 X112.76 Y132.192 I-6.814 J-7.503 E.05073
G3 X111.747 Y131.776 I2.368 J-7.2 E.03266
G1 X111.462 Y132.167 E.01442
G3 X110.827 Y132.665 I-6.415 J-7.516 E.02404
M204 S10000
G1 X111.215 Y132.825 F42000
; LINE_WIDTH: 0.366928
G1 F7407.241
M204 S6000
G1 X111.379 Y133.158 E.00951
G2 X112.183 Y132.356 I-6.38 J-7.197 E.02907
G1 X111.871 Y132.215 E.00878
G1 X111.437 Y132.668 E.01606
G1 X111.264 Y132.791 E.00544
; WIPE_START
G1 X111.437 Y132.668 E-.08076
G1 X111.871 Y132.215 E-.23839
G1 X112.183 Y132.356 E-.13029
G1 X111.944 Y132.615 E-.13362
G1 X111.609 Y132.937 E-.17695
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.095 Y137.126 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.353146
G1 F7736.31
M204 S6000
G1 X108.797 Y136.794 E.01903
M204 S10000
G1 X108.822 Y136.831 F42000
; LINE_WIDTH: 0.177558
G1 F15000
M204 S6000
G1 X108.216 Y137.043 E.00683
; LINE_WIDTH: 0.155813
G1 X108.087 Y137.083 E.0012
; LINE_WIDTH: 0.116547
G1 X107.958 Y137.122 E.00078
; WIPE_START
G1 X108.087 Y137.083 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.047 Y137.117 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.117473
G1 F15000
M204 S6000
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
M204 S10000
G1 X100.126 Y131.405 Z2 F42000
G1 X98.227 Y129.506 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0970686
G1 F15000
M204 S6000
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
M204 S10000
G1 X97.888 Y127.044 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.117864
G1 F15000
M204 S6000
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
; WIPE_START
G1 X98.204 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.836 Y126.506 Z2 F42000
G1 X115.786 Y126.494 Z2
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.0970932
G1 F15000
M204 S6000
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
M204 S10000
G1 X116.125 Y128.958 Z2 F42000
G1 Z1.6
G1 E.8 F1800
; LINE_WIDTH: 0.116752
G1 F15000
M204 S6000
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
; CHANGE_LAYER
; Z_HEIGHT: 1.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X115.81 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 114
M625
; layer num/total_layer_count: 9/23
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z2 I.395 J1.151 P1  F42000
G1 X124.977 Y126.337 Z2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
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
G1 X125.378 Y126.557 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
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
M204 S6000
G1 X125.359 Y126.079 E-.19337
G1 X125.819 Y125.95 E-.18163
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.551 Y119.579 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X129.572 Y119.601 E.00099
G3 X125.928 Y121.321 I-1.57 J1.396 E.25078
G3 X127.841 Y118.902 I2.086 J-.316 E.1112
G3 X129.34 Y119.377 I.161 J2.094 E.05184
G1 X129.507 Y119.537 E.00743
M204 S250
G1 X129.279 Y119.861 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X129.279 Y119.862 E.00003
G3 X127.871 Y119.294 I-1.277 J1.136 E.27299
G1 X128.133 Y119.294 E.0078
G3 X129.09 Y119.681 I-.131 J1.704 E.03123
G1 X129.235 Y119.82 E.00599
; WIPE_START
M204 S6000
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
M204 S10000
G1 X135.794 Y126.091 Z2.2 F42000
G1 X136.651 Y126.698 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X136.814 Y126.923 E.00893
G3 X134.682 Y125.925 I-1.804 J1.078 E.34416
M73 P70 R4
G3 X135.863 Y126.08 I.333 J2.039 E.03886
G3 X136.618 Y126.648 I-.852 J1.92 E.03064
M204 S250
G1 X136.326 Y126.926 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X136.356 Y126.949 E.00114
G3 X134.727 Y126.315 I-1.347 J1.05 E.2649
G3 X135.455 Y126.351 I.275 J1.845 E.02187
G3 X136.142 Y126.721 I-.446 J1.648 E.02345
G1 X136.286 Y126.881 E.00641
; WIPE_START
M204 S6000
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
M204 S10000
G1 X131.285 Y134.285 Z2.2 F42000
G1 X128.744 Y136.965 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X128.482 Y137.048 E.00885
G3 X127.762 Y132.915 I-.471 J-2.048 E.21952
G3 X128.936 Y133.115 I.255 J2.05 E.03885
G3 X128.801 Y136.947 I-.925 J1.886 E.15537
M204 S250
G1 X128.626 Y136.592 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X128.392 Y136.663 E.0073
G3 X127.792 Y133.306 I-.382 J-1.664 E.16475
G3 X128.518 Y133.369 I.204 J1.854 E.02187
G3 X128.681 Y136.569 I-.509 J1.63 E.12384
; WIPE_START
M204 S6000
G1 X128.392 Y136.663 E-.1158
G1 X128.133 Y136.706 E-.09948
G1 X127.871 Y136.706 E-.0995
G1 X127.612 Y136.666 E-.09954
G1 X127.363 Y136.587 E-.09952
G1 X127.128 Y136.47 E-.09949
G1 X126.914 Y136.32 E-.09954
G1 X126.825 Y136.234 E-.04713
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.476 Y129.375 Z2.2 F42000
G1 X123.042 Y128.488 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X123.012 Y128.636 E.00487
G3 X120.842 Y125.907 I-2.002 J-.636 E.29204
G3 X122.007 Y126.152 I.176 J2.058 E.03886
G3 X123.086 Y128.322 I-.997 J1.849 E.08306
G1 X123.058 Y128.43 E.00358
M204 S250
G1 X122.661 Y128.398 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X122.638 Y128.518 E.00362
G3 X120.857 Y126.299 I-1.629 J-.517 E.21963
G3 X121.58 Y126.39 I.133 J1.861 E.02188
G3 X122.698 Y128.262 I-.571 J1.61 E.07042
G1 X122.677 Y128.34 E.00242
; WIPE_START
M204 S6000
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
M204 S10000
G1 X124.966 Y122.958 Z2.2 F42000
G1 X127.3 Y118.629 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X128.352 Y118.611 I.687 J9.279 E.03385
G3 X126.186 Y118.779 I-.358 J9.389 E1.82836
G3 X127.24 Y118.634 I1.801 J9.128 E.03424
M204 S250
G1 X127.271 Y118.241 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X128.358 Y118.219 I.742 J9.793 E.0324
G3 X137.237 Y124.758 I-.363 J9.792 E.34887
G3 X121.835 Y120.4 I-9.235 J3.241 E1.27338
G3 X127.211 Y118.245 I6.179 J7.634 E.17513
; WIPE_START
M204 S6000
G1 X127.856 Y118.211 E-.2453
G1 X128.358 Y118.219 E-.19085
G1 X129.026 Y118.264 E-.25425
G1 X129.207 Y118.288 E-.0696
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z2.2 I1.217 J0 P1  F42000
; stop printing object, unique label id: 78
M625
; object ids of layer 9 start: 78,114
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


; object ids of this layer9 end: 78,114
M625
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X129.091 Y118.874 F42000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.353135
G1 F7736.574
M204 S6000
G1 X129.793 Y119.206 E.01903
M204 S10000
G1 X129.818 Y119.168 F42000
; LINE_WIDTH: 0.177554
G1 F15000
M204 S6000
G1 X129.211 Y118.957 E.00683
; LINE_WIDTH: 0.155808
G1 X129.082 Y118.917 E.0012
; LINE_WIDTH: 0.116544
G1 X128.953 Y118.878 E.00078
; WIPE_START
G1 X129.082 Y118.917 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.042 Y118.883 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.117484
G1 F15000
M204 S6000
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
M204 S10000
G1 X132.192 Y123.169 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.370845
G1 F7318.76
M204 S6000
G1 X132.461 Y123.356 E.0085
G1 X132.867 Y123.782 E.01525
G1 X133.179 Y123.64 E.00888
G1 X132.681 Y123.113 E.01878
G1 X132.361 Y122.845 E.01082
G1 X132.22 Y123.115 E.00791
M204 S10000
G1 X131.866 Y123.39 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X132.24 Y123.631 E.01322
G1 X132.566 Y123.961 E.01383
G1 X132.752 Y124.249 E.01024
G1 X133.376 Y123.934 E.02083
G1 X133.755 Y123.807 E.0119
G2 X132.19 Y122.246 I-5.859 J4.309 E.06608
G1 X131.958 Y122.855 E.01942
G1 X131.733 Y123.258 E.01374
G1 X131.824 Y123.348 E.0038
M204 S10000
G1 X131.58 Y123.675 F42000
G1 F6364.866
M204 S6000
G1 X132.003 Y123.924 E.01461
G3 X132.466 Y124.509 I-1.066 J1.321 E.02243
G1 X132.574 Y124.723 E.00713
G1 X132.642 Y124.793 E.00291
G3 X133.531 Y124.278 I1.866 J2.194 E.03075
G1 X134.247 Y124.075 E.02216
G1 X134.375 Y124.056 E.00386
G2 X131.956 Y121.637 I-6.468 J4.05 E.10277
G3 X131.264 Y123.315 I-4.414 J-.838 E.05443
G1 X131.54 Y123.63 E.01249
M204 S10000
G1 X131.321 Y123.989 F42000
G1 F6364.866
M204 S6000
G1 X131.689 Y124.16 E.0121
G1 X131.974 Y124.427 E.01163
G3 X132.244 Y124.951 I-2.318 J1.53 E.01758
G1 X132.613 Y125.286 E.01484
G1 X133.111 Y124.915 E.0185
G1 X133.685 Y124.622 E.0192
G1 X134.335 Y124.442 E.0201
G1 X134.998 Y124.395 E.01979
G2 X131.837 Y121.126 I-7.007 J3.614 E.13739
G1 X131.627 Y121.038 E.00678
G1 X131.579 Y121.594 E.01663
G3 X130.703 Y123.412 I-3.851 J-.735 E.06078
G1 X130.984 Y123.571 E.00962
G1 X131.295 Y123.935 E.01425
; WIPE_START
G1 X130.984 Y123.571 E-.18174
G1 X130.703 Y123.412 E-.12278
G1 X130.991 Y123.042 E-.17809
G1 X131.293 Y122.499 E-.23605
G1 X131.332 Y122.397 E-.04134
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X130.063 Y123.663 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X130.421 Y123.695 E.01069
G1 X130.749 Y123.865 E.011
G3 X131.077 Y124.312 I-.859 J.976 E.01665
G1 X131.359 Y124.401 E.00882
G1 X131.659 Y124.638 E.01136
G3 X131.898 Y125.193 I-.95 J.738 E.01818
G3 X132.456 Y125.992 I-.351 J.84 E.03066
G1 X132.838 Y125.588 E.01657
G1 X133.336 Y125.217 E.0185
G1 X133.839 Y124.966 E.01674
G1 X134.424 Y124.808 E.01804
G1 X135.226 Y124.765 E.02391
G1 X135.611 Y124.814 E.01158
G1 X135.216 Y123.996 E.02705
G2 X131.188 Y120.391 I-7.306 J4.109 E.16394
G1 X131.245 Y120.909 E.01553
G1 X131.204 Y121.551 E.01914
G1 X131.041 Y122.134 E.01804
G3 X130.542 Y123.026 I-5.51 J-2.498 E.03049
G1 X130.178 Y123.411 E.01576
G1 X129.966 Y123.574 E.00797
G1 X130.019 Y123.623 E.00213
M204 S10000
G1 X129.855 Y124.064 F42000
; LINE_WIDTH: 0.41965
G1 F6370.614
M204 S6000
G1 X130.214 Y124.038 E.01073
G1 X130.456 Y124.12 E.00761
G1 X130.639 Y124.301 E.00767
G1 X130.775 Y124.648 E.01108
G1 X131.19 Y124.739 E.01264
G1 X131.381 Y124.894 E.00733
G1 X131.484 Y125.1 E.00685
G1 X131.522 Y125.443 E.01026
G1 X131.878 Y125.615 E.01177
G1 X132.047 Y125.83 E.00813
G1 X132.083 Y126.181 E.01049
G1 X132.047 Y126.398 E.00657
G1 X132.374 Y126.688 E.01301
G1 X132.413 Y126.758 E.00236
G1 X132.691 Y126.296 E.01603
G1 X133.064 Y125.89 E.0164
G1 X133.562 Y125.519 E.01849
G1 X134.092 Y125.277 E.01735
G1 X134.63 Y125.159 E.0164
G1 X135.251 Y125.142 E.01848
G1 X135.805 Y125.242 E.01675
G1 X136.219 Y125.393 E.01311
G2 X130.598 Y119.775 I-8.195 J2.578 E.24587
G1 X130.783 Y120.281 E.01603
G1 X130.868 Y120.924 E.0193
G1 X130.83 Y121.507 E.01741
G1 X130.681 Y122.023 E.01597
G1 X130.332 Y122.674 E.02199
G1 X129.947 Y123.112 E.01735
G1 X129.504 Y123.44 E.0164
G1 X129.053 Y123.648 E.01476
G1 X129.502 Y123.666 E.01335
G3 X129.821 Y124.014 I-.501 J.782 E.0142
; WIPE_START
G1 X129.717 Y123.857 E-.07159
G1 X129.502 Y123.666 E-.10918
G1 X129.053 Y123.648 E-.17044
G1 X129.504 Y123.44 E-.1885
G1 X129.947 Y123.112 E-.20945
G1 X129.966 Y123.091 E-.01085
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.815 Y123.741 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.39917
G1 F6736.843
M204 S6000
G1 X128.997 Y123.67 E.00552
; WIPE_START
G1 X128.815 Y123.741 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.387 Y123.572 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.386265
G1 F6990.061
M204 S6000
G1 X123.78 Y123.129 E.01606
G1 X123.647 Y122.836 E.00875
G2 X122.857 Y123.633 I3.497 J4.251 E.03048
G1 X123.165 Y123.773 E.00916
G1 X123.343 Y123.612 E.00651
M204 S10000
G1 X123.626 Y123.89 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X123.929 Y123.473 E.01537
G1 X124.23 Y123.216 E.01177
G3 X123.804 Y122.262 I4.056 J-2.382 E.03118
G2 X122.253 Y123.806 I3.794 J5.36 E.06549
G3 X123.223 Y124.226 I-1.384 J4.528 E.03154
G1 X123.58 Y123.929 E.01385
M204 S10000
G1 X123.921 Y124.135 F42000
G1 F6364.866
M204 S6000
G1 X124.221 Y123.714 E.01542
G1 X124.55 Y123.451 E.01255
G1 X124.791 Y123.353 E.00773
G3 X124.281 Y122.471 I2.185 J-1.853 E.03051
G1 X124.053 Y121.629 E.026
G2 X122.561 Y122.848 I4.908 J7.528 E.05748
G2 X121.63 Y124.056 I6.734 J6.151 E.0455
G1 X122.232 Y124.192 E.01838
G1 X122.764 Y124.408 E.01711
G1 X123.31 Y124.731 E.01889
G1 X123.595 Y124.386 E.01332
G1 X123.873 Y124.172 E.01047
M204 S10000
G1 X124.21 Y124.439 F42000
G1 F6364.866
M204 S6000
G1 X124.373 Y124.116 E.01077
G3 X124.747 Y123.772 I1.063 J.782 E.01523
G1 X125.246 Y123.547 E.01631
G1 X125.341 Y123.447 E.00412
G1 X124.917 Y122.892 E.02081
G1 X124.625 Y122.317 E.0192
G1 X124.444 Y121.667 E.0201
G3 X124.397 Y121.004 I6.028 J-.765 E.01982
G2 X122.719 Y122.162 I4.433 J8.211 E.06084
G2 X121.507 Y123.55 I6.191 J6.631 E.05498
G1 X121.014 Y124.373 E.02858
G1 X121.791 Y124.462 E.02331
G3 X123.467 Y125.347 I-.779 J3.504 E.05713
G1 X123.621 Y124.943 E.01286
G1 X123.934 Y124.593 E.01401
G1 X124.158 Y124.468 E.00762
; WIPE_START
G1 X123.934 Y124.593 E-.09724
G1 X123.621 Y124.943 E-.17868
G1 X123.467 Y125.347 E-.16407
G1 X123.279 Y125.179 E-.09569
G1 X122.822 Y124.865 E-.21087
G1 X122.79 Y124.849 E-.01345
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.803 Y125.671 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X123.876 Y125.269 E.01217
G1 X124.106 Y124.941 E.01193
G3 X124.515 Y124.7 I.864 J.997 E.01421
G1 X124.677 Y124.34 E.01176
G1 X124.944 Y124.094 E.01081
G3 X125.445 Y123.936 I.788 J1.626 E.0157
G3 X125.945 Y123.503 I.77 J.384 E.02023
G3 X124.969 Y122.163 I2.276 J-2.685 E.04986
G1 X124.811 Y121.578 E.01804
G1 X124.767 Y120.762 E.02435
G1 X124.816 Y120.393 E.01108
G2 X123.229 Y121.274 I3.255 J7.733 E.05415
G1 X122.471 Y121.878 E.02888
G2 X120.393 Y124.819 I5.616 J6.173 E.1081
G1 X120.867 Y124.762 E.01422
G1 X121.487 Y124.793 E.0185
G1 X122.032 Y124.919 E.01666
G1 X122.548 Y125.141 E.01673
G1 X123.029 Y125.461 E.01719
G1 X123.413 Y125.824 E.01576
G1 X123.524 Y125.968 E.00541
G3 X123.758 Y125.71 I.866 J.548 E.01043
M204 S10000
G1 X124.19 Y125.904 F42000
G1 F6364.866
M204 S6000
G1 X124.185 Y125.558 E.01032
G1 X124.263 Y125.338 E.00696
G1 X124.46 Y125.145 E.00819
G1 X124.831 Y125.022 E.01165
G1 X124.961 Y124.591 E.01341
G1 X125.141 Y124.416 E.00747
G3 X125.671 Y124.327 I.43 J.941 E.0162
G1 X125.858 Y123.99 E.01147
G1 X125.944 Y123.909 E.00352
G1 X126.273 Y123.792 E.01041
G1 X126.658 Y123.862 E.01165
G1 X126.88 Y123.639 E.00939
G1 X126.383 Y123.372 E.01679
G1 X125.973 Y123.026 E.01599
G1 X125.521 Y122.441 E.02201
G1 X125.279 Y121.91 E.01737
G1 X125.161 Y121.372 E.01641
G1 X125.144 Y120.751 E.0185
G1 X125.244 Y120.197 E.01677
G1 X125.393 Y119.778 E.01326
G2 X123.043 Y120.939 I2.741 J8.497 E.07835
G1 X122.223 Y121.594 E.03126
G2 X119.779 Y125.405 I5.816 J6.419 E.13644
G1 X120.303 Y125.215 E.01661
G1 X120.849 Y125.139 E.01642
G1 X121.469 Y125.169 E.0185
G3 X123.115 Y126.055 I-.446 J2.799 E.05673
; LINE_WIDTH: 0.43336
G1 F6146.912
G1 X123.291 Y126.271 E.00859
; LINE_WIDTH: 0.4601
G1 F5752.913
G1 X123.466 Y126.487 E.00917
; LINE_WIDTH: 0.492869
G1 F5333.946
G1 X123.523 Y126.559 E.00327
; LINE_WIDTH: 0.531665
G1 F4910.536
G1 X123.579 Y126.632 E.00355
; LINE_WIDTH: 0.570462
G1 F4549.404
G1 X123.636 Y126.704 E.00383
; LINE_WIDTH: 0.568627
G1 F4565.287
G1 X123.658 Y126.613 E.00389
; LINE_WIDTH: 0.526159
G1 F4966.489
G1 X123.679 Y126.522 E.00358
; LINE_WIDTH: 0.483692
G1 F5445.001
G1 X123.701 Y126.431 E.00326
; LINE_WIDTH: 0.422893
G1 F6316.25
G1 X123.722 Y126.34 E.00281
G1 X123.921 Y126.065 E.01017
G1 X124.138 Y125.935 E.0076
; WIPE_START
G1 X123.921 Y126.065 E-.28065
G1 X123.722 Y126.34 E-.37547
G1 X123.701 Y126.431 E-.10388
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.711 Y126.898 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.57337
G1 F4524.461
M204 S6000
G1 X123.658 Y126.76 E.0062
M204 S10000
G1 X124.215 Y127.028 F42000
; LINE_WIDTH: 0.42354
G1 F6305.513
M204 S6000
G1 X124.072 Y126.497 E.01652
G1 X124.164 Y126.355 E.0051
G1 X124.576 Y126.116 E.01429
G1 X124.558 Y125.608 E.01528
G1 X124.65 Y125.471 E.00497
G1 X125.152 Y125.323 E.01572
G1 X125.268 Y124.813 E.01572
G1 X125.395 Y124.714 E.00485
G1 X125.907 Y124.698 E.01541
G1 X126.139 Y124.242 E.01541
G1 X126.283 Y124.169 E.00485
G1 X126.794 Y124.281 E.01572
G1 X127.197 Y123.842 E.01792
G1 X127.346 Y123.857 E.0045
; LINE_WIDTH: 0.48009
G1 F5489.855
G1 X127.549 Y123.949 E.00771
; LINE_WIDTH: 0.50523
G1 F5191.322
G1 X127.753 Y124.04 E.00816
; LINE_WIDTH: 0.500499
G1 F5245.004
G1 X127.885 Y123.97 E.00541
; LINE_WIDTH: 0.465895
G1 F5674.094
G1 X128.017 Y123.9 E.005
; LINE_WIDTH: 0.419332
G1 F6376.004
G1 X128.15 Y123.83 E.00445
G1 X128.344 Y123.824 E.00578
G1 X128.735 Y124.159 E.01531
G1 X129.181 Y123.994 E.01414
G1 X129.365 Y124.024 E.00553
G1 X129.667 Y124.462 E.01582
G1 X130.178 Y124.413 E.01525
G1 X130.309 Y124.486 E.00447
G1 X130.495 Y124.987 E.01588
G1 X131.005 Y125.068 E.01536
G1 X131.114 Y125.18 E.00464
G1 X131.166 Y125.702 E.01559
G1 X131.632 Y125.902 E.01509
G1 X131.702 Y125.984 E.0032
G3 X131.638 Y126.56 I-1.686 J.104 E.01734
G1 X132.059 Y126.895 E.016
; LINE_WIDTH: 0.444725
G1 F5973.047
G1 X132.095 Y126.979 E.00288
; LINE_WIDTH: 0.494195
G1 F5318.265
G1 X132.131 Y127.062 E.00324
; LINE_WIDTH: 0.53285
G1 F4898.659
G1 X131.955 Y127.501 E.01828
; LINE_WIDTH: 0.526585
G1 F4962.112
G1 X132.03 Y127.628 E.00562
; LINE_WIDTH: 0.486215
G1 F5414.002
G1 X132.104 Y127.755 E.00515
; LINE_WIDTH: 0.43339
G1 F6146.443
G1 X132.178 Y127.881 E.00454
G1 X132.178 Y128.118 E.00731
; LINE_WIDTH: 0.445835
G1 F5956.591
G1 X132.104 Y128.245 E.00468
; LINE_WIDTH: 0.486205
G1 F5414.124
G1 X132.03 Y128.372 E.00515
; LINE_WIDTH: 0.532184
G1 F4905.327
G1 X131.955 Y128.499 E.00569
G1 X132.135 Y128.951 E.01881
; LINE_WIDTH: 0.504165
G1 F5203.309
M73 P71 R4
G1 X132.096 Y129.018 E.00282
; LINE_WIDTH: 0.470495
G1 F5613.05
G1 X132.056 Y129.085 E.00262
; LINE_WIDTH: 0.420234
G1 F6360.753
G1 X132.016 Y129.151 E.00231
G1 X131.638 Y129.44 E.01417
G1 X131.709 Y129.999 E.0168
G1 X131.604 Y130.113 E.00464
G1 X131.166 Y130.298 E.01417
G1 X131.119 Y130.803 E.01512
G1 X131.021 Y130.925 E.00465
G1 X130.495 Y131.013 E.0159
G1 X130.32 Y131.498 E.01538
G1 X130.184 Y131.586 E.00482
G1 X129.667 Y131.538 E.01546
G1 X129.384 Y131.957 E.01507
G1 X129.244 Y132.017 E.00454
G1 X128.735 Y131.841 E.01606
; LINE_WIDTH: 0.412592
G1 F6492.247
G1 X128.343 Y132.175 E.01503
G1 X128.146 Y132.175 E.00576
; LINE_WIDTH: 0.44902
G1 F5909.875
G1 X127.95 Y132.068 E.00719
; LINE_WIDTH: 0.492029
G1 F5343.921
G1 X127.753 Y131.96 E.00795
G1 X127.289 Y132.16 E.01791
; LINE_WIDTH: 0.422011
G1 F6330.938
G1 X127.199 Y132.153 E.0027
G1 X126.794 Y131.719 E.0178
G1 X126.284 Y131.831 E.01564
G1 X126.139 Y131.758 E.00486
G1 X125.907 Y131.302 E.01533
G1 X125.395 Y131.286 E.01533
G1 X125.268 Y131.187 E.00484
G1 X125.152 Y130.677 E.01566
G1 X124.65 Y130.529 E.01566
G1 X124.559 Y130.392 E.00493
G1 X124.576 Y129.884 E.01523
G1 X124.133 Y129.622 E.0154
G1 X124.08 Y129.54 E.00293
G3 X124.215 Y128.972 I2.778 J.361 E.0175
G1 X123.864 Y128.625 E.01478
G1 X123.832 Y128.443 E.00555
; LINE_WIDTH: 0.43866
G1 F6064.588
G1 X123.937 Y128.221 E.00766
; LINE_WIDTH: 0.466899
G1 F5660.657
G1 X124.042 Y128 E.00821
G1 X123.826 Y127.529 E.01734
; LINE_WIDTH: 0.419018
G1 F6381.324
G1 X123.876 Y127.361 E.00521
G1 X124.172 Y127.07 E.01234
; WIPE_START
G1 X123.876 Y127.361 E-.53432
G1 X123.826 Y127.529 E-.22568
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.536 Y128.017 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.476885
G1 F5530.4
M204 S6000
G1 X123.461 Y128.378 E.01264
; LINE_WIDTH: 0.42091
G1 F6349.374
G3 X122.504 Y129.994 I-2.502 J-.391 E.05743
G1 X122.021 Y130.272 E.01663
G1 X121.531 Y130.437 E.01545
G3 X119.401 Y129.895 I-.527 J-2.385 E.06806
G1 X119.311 Y129.987 E.00384
G1 X119.225 Y130.001 E.0026
G2 X126.022 Y136.781 I8.788 J-2.013 E.30228
G1 X126.046 Y136.656 E.00381
G1 X126.111 Y136.598 E.00259
G1 X125.852 Y136.256 E.01279
G1 X125.604 Y135.687 E.01854
G3 X125.594 Y134.367 I2.512 J-.679 E.03984
G1 X125.771 Y133.89 E.0152
G1 X126.082 Y133.413 E.01699
G1 X126.554 Y132.967 E.01941
G1 X127.232 Y132.609 E.02289
; LINE_WIDTH: 0.468948
G1 F5633.439
G1 X127.483 Y132.542 E.00875
; LINE_WIDTH: 0.502003
G1 F5227.819
G1 X127.735 Y132.475 E.00943
; LINE_WIDTH: 0.497612
G1 F5278.302
G1 X127.906 Y132.498 E.00622
; LINE_WIDTH: 0.455775
G1 F5813.178
G1 X128.078 Y132.52 E.00565
; LINE_WIDTH: 0.419588
G1 F6371.661
G3 X128.764 Y132.623 I-1.93 J15.264 E.02064
G1 X129.123 Y132.77 E.01153
G1 X129.552 Y133.051 E.01526
G1 X129.979 Y133.475 E.01791
G3 X130.356 Y134.17 I-2.251 J1.674 E.0236
G1 X130.483 Y134.781 E.01859
G1 X130.48 Y135.301 E.01544
G1 X130.361 Y135.798 E.01522
G3 X130.053 Y136.395 I-2.742 J-1.037 E.02003
G1 X130.201 Y136.729 E.01087
G2 X136.778 Y129.981 I-2.188 J-8.712 E.29513
G1 X136.658 Y129.956 E.00366
G1 X136.603 Y129.895 E.00242
G1 X136.325 Y130.115 E.01055
G1 X135.92 Y130.316 E.01345
G1 X135.303 Y130.478 E.01899
G1 X134.892 Y130.494 E.01222
G1 X134.319 Y130.388 E.01735
G1 X134.054 Y130.303 E.00828
G1 X133.511 Y130 E.01848
G1 X133.194 Y129.72 E.01259
G1 X132.891 Y129.32 E.01493
; LINE_WIDTH: 0.436825
G1 F6092.84
G1 X132.791 Y129.151 E.00612
; LINE_WIDTH: 0.470495
G1 F5613.05
G1 X132.691 Y128.982 E.00664
; LINE_WIDTH: 0.51276
G1 F5108.123
G1 X132.591 Y128.812 E.0073
G1 X132.493 Y128.406 E.01552
; LINE_WIDTH: 0.490005
G1 F5368.107
G1 X132.504 Y128.266 E.00495
; LINE_WIDTH: 0.444815
G1 F5971.709
G1 X132.516 Y128.127 E.00445
; LINE_WIDTH: 0.399625
G1 F6728.249
G1 X132.528 Y127.987 E.00395
; LINE_WIDTH: 0.398248
G1 F6754.333
G1 X132.519 Y127.871 E.00328
; LINE_WIDTH: 0.440683
G1 F6033.752
G1 X132.51 Y127.754 E.00367
; LINE_WIDTH: 0.483118
G1 F5452.098
G1 X132.501 Y127.638 E.00406
; LINE_WIDTH: 0.530894
G1 F4918.298
G1 X132.492 Y127.521 E.0045
G1 X132.581 Y127.215 E.0123
; LINE_WIDTH: 0.494195
G1 F5318.265
G1 X132.736 Y126.947 E.01102
; LINE_WIDTH: 0.420379
G1 F6358.305
G1 X132.891 Y126.679 E.00922
G1 X133.26 Y126.219 E.01759
G1 X133.787 Y125.821 E.01969
G1 X134.21 Y125.636 E.01376
G1 X134.777 Y125.532 E.01718
G1 X135.303 Y125.522 E.01569
G1 X135.92 Y125.684 E.01902
G1 X136.377 Y125.917 E.0153
G1 X136.603 Y126.104 E.00875
G3 X136.78 Y126 I.161 J.07 E.00654
G2 X130.202 Y119.271 I-8.778 J2.001 E.29523
G1 X130.053 Y119.605 E.01089
G1 X130.286 Y119.992 E.01347
G1 X130.459 Y120.593 E.01866
G1 X130.496 Y121.11 E.01544
G3 X130.305 Y121.948 I-2.341 J-.092 E.02578
G1 X130.002 Y122.491 E.01852
G1 X129.716 Y122.814 E.01288
G1 X129.34 Y123.1 E.01409
G1 X128.78 Y123.37 E.01852
; LINE_WIDTH: 0.41036
G1 F6531.679
G1 X128.368 Y123.459 E.01224
; LINE_WIDTH: 0.420242
G1 F6360.621
G1 X128.163 Y123.482 E.00614
; LINE_WIDTH: 0.459265
G1 F5764.45
G1 X127.959 Y123.504 E.00678
; LINE_WIDTH: 0.495892
G1 F5298.341
G1 X127.754 Y123.527 E.00737
G1 X127.257 Y123.409 E.01827
; LINE_WIDTH: 0.459035
G1 F5767.637
G1 X127 Y123.279 E.00948
; LINE_WIDTH: 0.420305
G1 F6359.553
G3 X126.547 Y123.028 I1.343 J-2.959 E.01544
G1 X126.155 Y122.66 E.01604
G1 X125.824 Y122.215 E.01653
G1 X125.646 Y121.822 E.01288
G1 X125.538 Y121.362 E.01408
G1 X125.521 Y120.741 E.01852
G3 X126.015 Y119.51 I2.501 J.289 E.04002
G1 X126.107 Y119.399 E.00429
G3 X126.003 Y119.223 I.07 J-.16 E.00649
G2 X122.822 Y120.634 I2.009 J8.825 E.1044
G1 X121.974 Y121.31 E.0323
G2 X119.23 Y126.02 I5.959 J6.628 E.16517
G3 X119.402 Y126.091 I.022 J.189 E.0058
G1 X119.877 Y125.785 E.01687
G1 X120.363 Y125.587 E.01564
G1 X120.97 Y125.523 E.01818
G1 X121.492 Y125.552 E.01558
G1 X122.021 Y125.728 E.01664
G1 X122.504 Y126.006 E.0166
G3 X123.103 Y126.662 I-1.403 J1.882 E.02664
G1 X123.372 Y127.222 E.01852
G1 X123.482 Y127.71 E.01493
; LINE_WIDTH: 0.447145
G1 F5937.288
G1 X123.504 Y127.834 E.00402
; LINE_WIDTH: 0.479795
G1 F5493.563
G1 X123.526 Y127.958 E.00434
; WIPE_START
G1 X123.504 Y127.834 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.645 Y129.305 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.55646
G1 F4673.444
M204 S6000
G1 X123.697 Y129.157 E.00638
; WIPE_START
G1 X123.645 Y129.305 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.19 Y130.096 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X123.881 Y129.902 E.01086
G1 X123.721 Y129.656 E.00876
; LINE_WIDTH: 0.444549
G1 F5975.674
G1 X123.696 Y129.539 E.0038
; LINE_WIDTH: 0.493665
G1 F5324.519
G1 X123.67 Y129.422 E.00426
; LINE_WIDTH: 0.542782
G1 F4801.329
G1 X123.645 Y129.305 E.00472
G1 X123.464 Y129.523 E.0112
; LINE_WIDTH: 0.493665
G1 F5324.519
G1 X123.283 Y129.742 E.0101
; LINE_WIDTH: 0.420325
G1 F6359.216
G1 X123.102 Y129.96 E.00846
G1 X122.709 Y130.31 E.01568
G1 X122.176 Y130.616 E.01832
G1 X121.631 Y130.8 E.01715
G1 X121.069 Y130.871 E.01689
G3 X119.78 Y130.609 I.035 J-3.474 E.03945
G2 X125.431 Y136.234 I8.24 J-2.629 E.24702
G1 X125.222 Y135.721 E.0165
G3 X125.231 Y134.267 I2.983 J-.709 E.04376
G1 X125.427 Y133.736 E.01689
G1 X125.692 Y133.293 E.01537
G1 X126.042 Y132.901 E.01568
G1 X126.55 Y132.528 E.01878
G1 X126.88 Y132.361 E.01102
G1 X126.658 Y132.138 E.0094
G1 X126.275 Y132.208 E.01159
G1 X125.99 Y132.123 E.00888
G1 X125.815 Y131.953 E.00726
G1 X125.671 Y131.673 E.00939
G1 X125.283 Y131.646 E.0116
G1 X125.031 Y131.497 E.00874
G1 X124.931 Y131.356 E.00514
G1 X124.831 Y130.978 E.01166
G1 X124.415 Y130.826 E.0132
G1 X124.263 Y130.662 E.00665
G3 X124.188 Y130.156 I.677 J-.359 E.01556
M204 S10000
G1 X123.786 Y130.297 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G3 X123.522 Y130.043 I.295 J-.57 E.01106
G3 X121.03 Y131.247 I-2.551 J-2.098 E.08508
G1 X120.395 Y131.187 E.01898
G2 X121.821 Y133.463 I7.758 J-3.274 E.08034
G2 X124.816 Y135.607 I6.226 J-5.533 E.11063
G1 X124.754 Y134.948 E.01972
G1 X124.828 Y134.311 E.0191
G3 X125.519 Y132.911 I3.435 J.826 E.04687
G1 X125.936 Y132.499 E.01748
G1 X125.674 Y132.358 E.00885
G1 X125.414 Y132.044 E.01215
G1 X125.046 Y131.96 E.01125
G1 X124.761 Y131.76 E.01037
G3 X124.489 Y131.274 I.922 J-.834 E.01672
G1 X124.155 Y131.101 E.0112
G1 X123.942 Y130.86 E.0096
G1 X123.811 Y130.495 E.01153
G1 X123.793 Y130.357 E.00417
; WIPE_START
G1 X123.811 Y130.495 E-.05318
G1 X123.942 Y130.86 E-.14705
G1 X124.155 Y131.101 E-.12247
G1 X124.489 Y131.274 E-.14291
G1 X124.594 Y131.526 E-.10379
G1 X124.761 Y131.76 E-.10911
G1 X124.936 Y131.883 E-.0815
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.21 Y131.561 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X123.919 Y131.395 E.00998
G1 X123.621 Y131.057 E.01344
G1 X123.467 Y130.653 E.01286
G3 X121.04 Y131.625 I-2.52 J-2.778 E.07954
G1 X121.248 Y132.046 E.01398
G2 X124.273 Y134.935 I6.842 J-4.137 E.12606
G1 X124.377 Y134.962 E.0032
G3 X125.337 Y132.548 I3.748 J.092 E.07903
G1 X125.209 Y132.401 E.0058
G1 X124.889 Y132.303 E.00996
G1 X124.519 Y132.05 E.01337
G1 X124.257 Y131.695 E.01313
G1 X124.23 Y131.618 E.00245
M204 S10000
G1 X123.889 Y131.831 F42000
G1 F6364.866
M204 S6000
G1 X123.493 Y131.512 E.01514
G1 X123.31 Y131.269 E.00907
G3 X121.636 Y131.952 I-2.426 J-3.549 E.05426
G2 X124.049 Y134.366 I6.366 J-3.95 E.10254
G3 X124.743 Y132.678 I4.406 J.826 E.05473
G1 X124.256 Y132.321 E.01797
G3 X123.921 Y131.882 I1.759 J-1.689 E.01651
M204 S10000
G1 X123.626 Y132.11 F42000
G1 F6364.866
M204 S6000
G1 X123.223 Y131.774 E.01563
G1 X122.631 Y132.065 E.01965
G1 X122.253 Y132.194 E.01189
G1 X122.632 Y132.674 E.01823
G1 X123.227 Y133.279 E.02527
G2 X123.809 Y133.75 I6.002 J-6.827 E.02229
G1 X124.051 Y133.119 E.02013
G1 X124.225 Y132.785 E.01123
G1 X123.95 Y132.549 E.01079
G1 X123.662 Y132.158 E.01448
M204 S10000
G1 X123.367 Y132.4 F42000
; LINE_WIDTH: 0.385712
G1 F7001.335
M204 S6000
G1 X123.165 Y132.221 E.00731
G1 X122.85 Y132.365 E.00939
G2 X123.642 Y133.172 I5.538 J-4.644 E.03065
G1 X123.779 Y132.871 E.00895
G1 X123.407 Y132.445 E.0153
; WIPE_START
G1 X123.779 Y132.871 E-.21471
G1 X123.642 Y133.172 E-.12565
G1 X123.185 Y132.738 E-.23941
G1 X122.868 Y132.385 E-.18023
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.131 Y132.373 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.3985
G1 F6749.536
M204 S6000
G1 X128.871 Y132.279 E.00775
; WIPE_START
G1 X129.131 Y132.373 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.855 Y131.936 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.419594
G1 F6371.571
M204 S6000
G1 X129.596 Y132.273 E.01263
G1 X129.24 Y132.388 E.01113
G1 X129.131 Y132.373 E.00329
G1 X129.619 Y132.626 E.01637
G1 X130.025 Y132.961 E.01565
G3 X130.72 Y134.07 I-2.493 J2.334 E.03919
G1 X130.83 Y134.496 E.01309
G1 X130.868 Y135.076 E.01731
G1 X130.783 Y135.719 E.0193
G1 X130.598 Y136.225 E.01602
G2 X136.219 Y130.607 I-2.585 J-8.208 E.24579
G1 X135.721 Y130.781 E.01567
G3 X134.393 Y130.806 I-.722 J-3.06 E.03983
G1 X133.877 Y130.636 E.01616
G1 X133.328 Y130.33 E.01872
G1 X132.903 Y129.96 E.01675
G3 X132.413 Y129.242 I2.546 J-2.265 E.02594
G3 X132.047 Y129.602 I-1.126 J-.78 E.01534
G1 X132.095 Y129.913 E.00937
G1 X132.034 Y130.197 E.00865
G1 X131.835 Y130.416 E.0088
G1 X131.522 Y130.557 E.01022
G1 X131.458 Y130.975 E.01257
G1 X131.292 Y131.196 E.00823
G3 X130.775 Y131.352 I-.546 J-.874 E.01625
G1 X130.6 Y131.754 E.01305
G1 X130.456 Y131.88 E.00569
G1 X130.233 Y131.96 E.00706
G1 X129.914 Y131.94 E.00949
M204 S10000
G1 X130.03 Y132.353 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X129.975 Y132.423 E.00265
G3 X131.083 Y133.97 I-2.024 J2.62 E.0575
G1 X131.204 Y134.452 E.01482
G1 X131.245 Y135.091 E.01905
G1 X131.188 Y135.609 E.01553
G2 X135.611 Y131.186 I-3.182 J-7.605 E.1911
G1 X134.95 Y131.248 E.01978
G1 X134.452 Y131.202 E.01491
G1 X133.868 Y131.039 E.01804
G1 X133.144 Y130.659 E.02435
G1 X132.712 Y130.304 E.01665
G1 X132.456 Y130.011 E.01161
G1 X132.369 Y130.368 E.01096
G1 X132.108 Y130.684 E.0122
G1 X131.876 Y130.837 E.00829
G1 X131.806 Y131.121 E.0087
G1 X131.608 Y131.417 E.01062
G3 X131.049 Y131.711 I-.791 J-.827 E.01908
G1 X130.893 Y131.991 E.00952
G1 X130.654 Y132.201 E.00949
G1 X130.282 Y132.334 E.01178
G1 X130.09 Y132.348 E.00573
; WIPE_START
G1 X130.282 Y132.334 E-.07306
G1 X130.654 Y132.201 E-.15032
G1 X130.893 Y131.991 E-.12112
G1 X131.049 Y131.711 E-.1214
G1 X131.357 Y131.6 E-.12455
G1 X131.608 Y131.417 E-.11804
G1 X131.684 Y131.305 E-.05152
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.321 Y132.011 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X131.187 Y132.227 E.00756
G1 X130.852 Y132.522 E.01329
G1 X130.703 Y132.588 E.00486
G1 X131.138 Y133.18 E.02186
G3 X131.62 Y134.76 I-3.57 J1.952 E.04955
G1 X131.648 Y134.975 E.00646
G2 X134.977 Y131.645 I-3.664 J-6.993 E.14242
G1 X134.408 Y131.576 E.01707
G1 X133.757 Y131.399 E.0201
G1 X132.961 Y130.988 E.0267
G1 X132.592 Y130.702 E.01389
G3 X132.214 Y131.089 I-1.683 J-1.269 E.01616
G1 X132.154 Y131.267 E.00559
G1 X131.877 Y131.682 E.01486
G1 X131.525 Y131.937 E.01295
G1 X131.377 Y131.991 E.00468
M204 S10000
G1 X131.58 Y132.325 F42000
G1 F6364.866
M204 S6000
G1 X131.266 Y132.685 E.01423
G1 X131.535 Y133.114 E.01509
G1 X131.809 Y133.764 E.021
G1 X131.954 Y134.366 E.01845
G2 X134.365 Y131.954 I-3.927 J-6.336 E.10248
G3 X132.634 Y131.227 I.892 J-4.546 E.05632
G1 X132.533 Y131.331 E.00432
G1 X132.254 Y131.825 E.01689
G1 X131.877 Y132.168 E.01519
G1 X131.633 Y132.297 E.00821
M204 S10000
G1 X131.774 Y132.7 F42000
G1 F6364.866
M204 S6000
G1 X131.745 Y132.73 E.00125
G3 X132.196 Y133.75 I-3.774 J2.279 E.0333
G2 X133.759 Y132.189 I-4.166 J-5.732 E.06607
G1 X133.162 Y131.963 E.019
G1 X132.745 Y131.732 E.01419
G1 X132.47 Y132.152 E.01497
G3 X131.823 Y132.666 I-2.898 J-2.984 E.02465
M204 S10000
G1 X132.21 Y132.825 F42000
; LINE_WIDTH: 0.369345
G1 F7352.392
M204 S6000
G1 X132.375 Y133.158 E.00958
G2 X133.181 Y132.357 I-3.916 J-4.747 E.02935
G1 X132.868 Y132.2 E.00904
G1 X132.663 Y132.456 E.00847
G1 X132.257 Y132.787 E.01351
; WIPE_START
G1 X132.663 Y132.456 E-.19914
G1 X132.868 Y132.2 E-.12478
G1 X133.181 Y132.357 E-.1332
G1 X132.891 Y132.681 E-.16529
G1 X132.625 Y132.927 E-.13759
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.793 Y136.794 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.353132
G1 F7736.643
M204 S6000
G1 X129.091 Y137.126 E.01903
M204 S10000
G1 X129.082 Y137.083 F42000
; LINE_WIDTH: 0.155863
G1 F15000
M204 S6000
G1 X129.211 Y137.043 E.0012
; LINE_WIDTH: 0.177617
G1 X129.817 Y136.831 E.00683
M204 S10000
G1 X129.082 Y137.083 F42000
; LINE_WIDTH: 0.116566
G1 F15000
M204 S6000
G1 X128.953 Y137.122 E.00078
; WIPE_START
G1 X129.082 Y137.083 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.042 Y137.117 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.117479
G1 F15000
M204 S6000
G1 X126.917 Y137.081 E.00077
; LINE_WIDTH: 0.161187
G1 X126.778 Y137.04 E.00136
; LINE_WIDTH: 0.192066
G1 X126.754 Y137.03 E.00031
; LINE_WIDTH: 0.172919
G1 X126.636 Y136.917 E.00168
; LINE_WIDTH: 0.123012
G1 X126.518 Y136.803 E.00103
; LINE_WIDTH: 0.0970867
G1 X126.496 Y136.779 E.00014
; WIPE_START
G1 X126.518 Y136.803 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X121.122 Y131.405 Z2.2 F42000
G1 X119.223 Y129.506 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.0970777
G1 F15000
M204 S6000
G1 X119.199 Y129.484 E.00014
; LINE_WIDTH: 0.122726
G1 X119.087 Y129.368 E.00102
; LINE_WIDTH: 0.175213
G1 X118.975 Y129.251 E.00169
G1 X118.958 Y129.209 E.00047
; LINE_WIDTH: 0.157765
G1 X118.922 Y129.092 E.00111
; LINE_WIDTH: 0.117871
G1 X118.883 Y128.956 E.00083
; WIPE_START
G1 X118.922 Y129.092 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X118.883 Y127.044 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.11786
G1 F15000
M204 S6000
G1 X118.922 Y126.908 E.00083
; LINE_WIDTH: 0.157768
G1 X118.958 Y126.791 E.00112
; LINE_WIDTH: 0.175273
G1 X118.975 Y126.749 E.00047
G1 X119.087 Y126.632 E.00169
; LINE_WIDTH: 0.122777
G1 X119.199 Y126.516 E.00102
; LINE_WIDTH: 0.0971038
G1 X119.223 Y126.494 E.00014
; WIPE_START
G1 X119.199 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.831 Y126.506 Z2.2 F42000
G1 X136.781 Y126.494 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.0970917
G1 F15000
M204 S6000
G1 X136.805 Y126.516 E.00014
; LINE_WIDTH: 0.122829
G1 X136.918 Y126.633 E.00102
; LINE_WIDTH: 0.172344
G1 X137.03 Y126.749 E.00166
; LINE_WIDTH: 0.188879
G1 X137.042 Y126.781 E.00039
; LINE_WIDTH: 0.158073
G1 X137.083 Y126.916 E.00129
; LINE_WIDTH: 0.116757
G1 X137.121 Y127.041 E.00076
; WIPE_START
G1 X137.083 Y126.916 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.121 Y128.958 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.116756
G1 F15000
M204 S6000
G1 X137.083 Y129.084 E.00076
; LINE_WIDTH: 0.158099
G1 X137.042 Y129.219 E.00129
; LINE_WIDTH: 0.188884
G1 X137.03 Y129.251 E.00039
; LINE_WIDTH: 0.172353
G1 X136.918 Y129.367 E.00166
; LINE_WIDTH: 0.122842
G1 X136.805 Y129.484 E.00102
; LINE_WIDTH: 0.0970898
G1 X136.781 Y129.506 E.00014
; OBJECT_ID: 114
; WIPE_START
G1 X136.805 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S10000
G1 X129.208 Y128.756 Z2.2 F42000
G1 X103.981 Y126.337 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
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
G1 X104.382 Y126.557 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
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
M204 S6000
G1 X104.363 Y126.079 E-.19337
G1 X104.823 Y125.95 E-.18163
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.555 Y119.579 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X108.577 Y119.601 E.00099
G3 X104.932 Y121.321 I-1.57 J1.396 E.25078
G3 X106.846 Y118.902 I2.086 J-.316 E.1112
G3 X108.345 Y119.377 I.161 J2.094 E.05184
G1 X108.512 Y119.537 E.00743
M204 S250
G1 X108.283 Y119.861 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X108.283 Y119.862 E.00003
G3 X106.876 Y119.294 I-1.277 J1.136 E.27299
G1 X107.138 Y119.294 E.0078
G3 X108.095 Y119.681 I-.131 J1.704 E.03123
G1 X108.24 Y119.82 E.00599
; WIPE_START
M204 S6000
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
M204 S10000
G1 X114.799 Y126.091 Z2.2 F42000
G1 X115.655 Y126.698 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X115.819 Y126.923 E.00893
G3 X113.686 Y125.925 I-1.804 J1.078 E.34416
G3 X114.867 Y126.08 I.333 J2.039 E.03886
G3 X115.623 Y126.648 I-.852 J1.92 E.03064
M204 S250
G1 X115.331 Y126.926 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X115.361 Y126.949 E.00114
G3 X113.731 Y126.315 I-1.347 J1.05 E.2649
G3 X114.46 Y126.351 I.275 J1.845 E.02187
G3 X115.147 Y126.721 I-.446 J1.648 E.02345
G1 X115.29 Y126.881 E.00641
; WIPE_START
M204 S6000
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
M204 S10000
G1 X110.289 Y134.285 Z2.2 F42000
G1 X107.749 Y136.965 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X107.486 Y137.048 E.00885
G3 X106.766 Y132.915 I-.471 J-2.048 E.21952
G3 X107.94 Y133.115 I.255 J2.05 E.03885
G3 X107.806 Y136.947 I-.925 J1.886 E.15537
M204 S250
G1 X107.63 Y136.592 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X107.396 Y136.663 E.0073
G3 X106.796 Y133.306 I-.382 J-1.664 E.16475
G3 X107.523 Y133.369 I.204 J1.854 E.02187
G3 X107.686 Y136.569 I-.509 J1.63 E.12384
; WIPE_START
M204 S6000
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
M204 S10000
G1 X102.48 Y129.375 Z2.2 F42000
G1 X102.047 Y128.488 Z2.2
G1 Z1.8
M73 P72 R4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G1 X102.017 Y128.636 E.00487
G3 X99.846 Y125.907 I-2.002 J-.636 E.29204
G3 X101.012 Y126.152 I.176 J2.058 E.03886
G3 X102.09 Y128.322 I-.997 J1.849 E.08306
G1 X102.062 Y128.43 E.00358
M204 S250
G1 X101.665 Y128.398 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G1 X101.643 Y128.518 E.00362
G3 X99.861 Y126.299 I-1.629 J-.517 E.21963
G3 X100.585 Y126.39 I.133 J1.861 E.02188
G3 X101.703 Y128.262 I-.571 J1.61 E.07042
G1 X101.681 Y128.34 E.00242
; WIPE_START
M204 S6000
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
M204 S10000
G1 X103.97 Y122.958 Z2.2 F42000
G1 X106.305 Y118.629 Z2.2
G1 Z1.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F5895.652
M204 S6000
G3 X107.357 Y118.611 I.687 J9.279 E.03385
G3 X105.191 Y118.779 I-.358 J9.389 E1.82836
G3 X106.245 Y118.634 I1.801 J9.128 E.03424
M204 S250
G1 X106.276 Y118.241 F42000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
G3 X107.362 Y118.219 I.742 J9.793 E.0324
G3 X116.242 Y124.758 I-.363 J9.792 E.34887
G3 X100.839 Y120.4 I-9.235 J3.241 E1.27338
G3 X106.216 Y118.245 I6.179 J7.634 E.17513
M204 S10000
G1 X106.047 Y118.883 F42000
; FEATURE: Gap infill
; LINE_WIDTH: 0.117484
G1 F15000
M204 S6000
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
M204 S10000
G1 X107.958 Y118.878 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.116544
G1 F15000
M204 S6000
G1 X108.087 Y118.917 E.00078
; LINE_WIDTH: 0.155808
G1 X108.216 Y118.957 E.0012
; LINE_WIDTH: 0.177554
G1 X108.822 Y119.168 E.00683
M204 S10000
G1 X108.797 Y119.206 F42000
; LINE_WIDTH: 0.353135
G1 F7736.574
M204 S6000
G1 X108.095 Y118.874 E.01903
; WIPE_START
G1 X108.797 Y119.206 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X111.196 Y123.169 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.370845
G1 F7318.76
M204 S6000
G1 X111.466 Y123.356 E.0085
G1 X111.872 Y123.782 E.01525
G1 X112.183 Y123.64 E.00888
G1 X111.686 Y123.113 E.01878
G1 X111.366 Y122.845 E.01082
G1 X111.224 Y123.115 E.00791
M204 S10000
G1 X110.871 Y123.39 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X111.244 Y123.631 E.01322
G1 X111.57 Y123.961 E.01383
G1 X111.757 Y124.249 E.01024
G1 X112.381 Y123.934 E.02083
G1 X112.759 Y123.807 E.0119
G2 X111.195 Y122.246 I-5.859 J4.309 E.06608
G1 X110.962 Y122.855 E.01942
G1 X110.738 Y123.258 E.01374
G1 X110.828 Y123.348 E.0038
M204 S10000
G1 X110.585 Y123.675 F42000
G1 F6364.866
M204 S6000
G1 X111.007 Y123.924 E.01461
G3 X111.471 Y124.509 I-1.066 J1.321 E.02243
G1 X111.579 Y124.723 E.00713
G1 X111.647 Y124.793 E.00291
G3 X112.535 Y124.278 I1.866 J2.194 E.03075
G1 X113.251 Y124.075 E.02216
G1 X113.379 Y124.056 E.00386
G2 X110.96 Y121.637 I-6.468 J4.05 E.10277
G3 X110.268 Y123.315 I-4.414 J-.838 E.05443
G1 X110.545 Y123.63 E.01249
M204 S10000
G1 X110.325 Y123.989 F42000
G1 F6364.866
M204 S6000
G1 X110.694 Y124.16 E.0121
G1 X110.978 Y124.427 E.01163
G3 X111.249 Y124.951 I-2.318 J1.53 E.01758
G1 X111.617 Y125.286 E.01484
G1 X112.115 Y124.915 E.0185
G1 X112.69 Y124.622 E.0192
G1 X113.34 Y124.442 E.0201
G1 X114.002 Y124.395 E.01979
G2 X110.841 Y121.126 I-7.007 J3.614 E.13739
G1 X110.632 Y121.038 E.00678
G1 X110.583 Y121.594 E.01663
G3 X109.708 Y123.412 I-3.851 J-.735 E.06078
G1 X109.989 Y123.571 E.00962
G1 X110.299 Y123.935 E.01425
; WIPE_START
G1 X109.989 Y123.571 E-.18174
G1 X109.708 Y123.412 E-.12278
G1 X109.995 Y123.042 E-.17809
G1 X110.297 Y122.499 E-.23605
G1 X110.337 Y122.397 E-.04134
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.068 Y123.663 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X109.425 Y123.695 E.01069
G1 X109.753 Y123.865 E.011
G3 X110.082 Y124.312 I-.859 J.976 E.01665
G1 X110.364 Y124.401 E.00882
G1 X110.663 Y124.638 E.01136
G3 X110.902 Y125.193 I-.95 J.738 E.01818
G3 X111.461 Y125.992 I-.351 J.84 E.03066
G1 X111.843 Y125.588 E.01657
G1 X112.341 Y125.217 E.0185
G1 X112.844 Y124.966 E.01674
G1 X113.429 Y124.808 E.01804
G1 X114.23 Y124.765 E.02391
G1 X114.616 Y124.814 E.01158
G1 X114.221 Y123.996 E.02705
G2 X110.193 Y120.391 I-7.306 J4.109 E.16394
G1 X110.249 Y120.909 E.01553
G1 X110.209 Y121.551 E.01914
G1 X110.046 Y122.134 E.01804
G3 X109.546 Y123.026 I-5.51 J-2.498 E.03049
G1 X109.182 Y123.411 E.01576
G1 X108.971 Y123.574 E.00797
G1 X109.024 Y123.623 E.00213
M204 S10000
G1 X108.859 Y124.064 F42000
; LINE_WIDTH: 0.41965
G1 F6370.614
M204 S6000
G1 X109.219 Y124.038 E.01073
G1 X109.461 Y124.12 E.00761
G1 X109.644 Y124.301 E.00767
G1 X109.78 Y124.648 E.01108
G1 X110.195 Y124.739 E.01264
G1 X110.386 Y124.894 E.00733
G1 X110.488 Y125.1 E.00685
G1 X110.526 Y125.443 E.01026
G1 X110.883 Y125.615 E.01177
G1 X111.051 Y125.83 E.00813
G1 X111.088 Y126.181 E.01049
G1 X111.052 Y126.398 E.00657
G1 X111.379 Y126.688 E.01301
G1 X111.417 Y126.758 E.00236
G1 X111.695 Y126.296 E.01603
G1 X112.068 Y125.89 E.0164
G1 X112.566 Y125.519 E.01849
G1 X113.096 Y125.277 E.01735
G1 X113.635 Y125.159 E.0164
G1 X114.256 Y125.142 E.01848
G1 X114.809 Y125.242 E.01675
G1 X115.223 Y125.393 E.01311
G2 X109.602 Y119.775 I-8.195 J2.578 E.24587
G1 X109.787 Y120.281 E.01603
G1 X109.873 Y120.924 E.0193
G1 X109.834 Y121.507 E.01741
G1 X109.685 Y122.023 E.01597
G1 X109.336 Y122.674 E.02199
G1 X108.951 Y123.112 E.01735
G1 X108.508 Y123.44 E.0164
G1 X108.058 Y123.648 E.01476
G1 X108.506 Y123.666 E.01335
G3 X108.826 Y124.014 I-.501 J.782 E.0142
; WIPE_START
G1 X108.721 Y123.857 E-.07159
G1 X108.506 Y123.666 E-.10918
G1 X108.058 Y123.648 E-.17044
G1 X108.508 Y123.44 E-.1885
G1 X108.951 Y123.112 E-.20945
G1 X108.97 Y123.091 E-.01085
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.819 Y123.741 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.39917
G1 F6736.843
M204 S6000
G1 X108.002 Y123.67 E.00552
; WIPE_START
G1 X107.819 Y123.741 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.391 Y123.572 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.386265
G1 F6990.061
M204 S6000
G1 X102.785 Y123.129 E.01606
G1 X102.651 Y122.836 E.00875
G2 X101.862 Y123.633 I3.497 J4.251 E.03048
G1 X102.169 Y123.773 E.00916
G1 X102.347 Y123.612 E.00651
M204 S10000
G1 X102.631 Y123.89 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X102.934 Y123.473 E.01537
G1 X103.234 Y123.216 E.01177
G3 X102.808 Y122.262 I4.056 J-2.382 E.03118
G2 X101.258 Y123.806 I3.794 J5.36 E.06549
G3 X102.227 Y124.226 I-1.384 J4.528 E.03154
G1 X102.584 Y123.929 E.01385
M204 S10000
G1 X102.925 Y124.135 F42000
G1 F6364.866
M204 S6000
G1 X103.226 Y123.714 E.01542
G1 X103.555 Y123.451 E.01255
G1 X103.795 Y123.353 E.00773
G3 X103.285 Y122.471 I2.185 J-1.853 E.03051
G1 X103.057 Y121.629 E.026
G2 X101.566 Y122.848 I4.908 J7.528 E.05748
G2 X100.634 Y124.056 I6.734 J6.151 E.0455
G1 X101.237 Y124.192 E.01838
G1 X101.769 Y124.408 E.01711
G1 X102.315 Y124.731 E.01889
G1 X102.599 Y124.386 E.01332
G1 X102.878 Y124.172 E.01047
M204 S10000
G1 X103.214 Y124.439 F42000
G1 F6364.866
M204 S6000
G1 X103.378 Y124.116 E.01077
G3 X103.752 Y123.772 I1.063 J.782 E.01523
G1 X104.251 Y123.547 E.01631
G1 X104.346 Y123.447 E.00412
G1 X103.921 Y122.892 E.02081
G1 X103.629 Y122.317 E.0192
G1 X103.449 Y121.667 E.0201
G3 X103.401 Y121.004 I6.028 J-.765 E.01982
G2 X101.724 Y122.162 I4.433 J8.211 E.06084
G2 X100.512 Y123.55 I6.191 J6.631 E.05498
G1 X100.018 Y124.373 E.02858
G1 X100.796 Y124.462 E.02331
G3 X102.472 Y125.347 I-.779 J3.504 E.05713
G1 X102.625 Y124.943 E.01286
G1 X102.939 Y124.593 E.01401
G1 X103.162 Y124.468 E.00762
; WIPE_START
G1 X102.939 Y124.593 E-.09724
G1 X102.625 Y124.943 E-.17868
G1 X102.472 Y125.347 E-.16407
G1 X102.284 Y125.179 E-.09569
G1 X101.827 Y124.865 E-.21087
G1 X101.795 Y124.849 E-.01345
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.808 Y125.671 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X102.881 Y125.269 E.01217
G1 X103.111 Y124.941 E.01193
G3 X103.519 Y124.7 I.864 J.997 E.01421
G1 X103.681 Y124.34 E.01176
G1 X103.949 Y124.094 E.01081
G3 X104.449 Y123.936 I.788 J1.626 E.0157
G3 X104.95 Y123.503 I.77 J.384 E.02023
G3 X103.973 Y122.163 I2.276 J-2.685 E.04986
G1 X103.815 Y121.578 E.01804
G1 X103.772 Y120.762 E.02435
G1 X103.82 Y120.393 E.01108
G2 X102.234 Y121.274 I3.255 J7.733 E.05415
G1 X101.476 Y121.878 E.02888
G2 X99.398 Y124.819 I5.616 J6.173 E.1081
G1 X99.872 Y124.762 E.01422
G1 X100.492 Y124.793 E.0185
G1 X101.037 Y124.919 E.01666
G1 X101.553 Y125.141 E.01673
G1 X102.033 Y125.461 E.01719
G1 X102.417 Y125.824 E.01576
G1 X102.529 Y125.968 E.00541
G3 X102.762 Y125.71 I.866 J.548 E.01043
M204 S10000
G1 X103.194 Y125.904 F42000
G1 F6364.866
M204 S6000
G1 X103.189 Y125.558 E.01032
G1 X103.268 Y125.338 E.00696
G1 X103.464 Y125.145 E.00819
G1 X103.835 Y125.022 E.01165
G1 X103.966 Y124.591 E.01341
G1 X104.145 Y124.416 E.00747
G3 X104.676 Y124.327 I.43 J.941 E.0162
G1 X104.863 Y123.99 E.01147
G1 X104.948 Y123.909 E.00352
G1 X105.278 Y123.792 E.01041
G1 X105.662 Y123.862 E.01165
G1 X105.884 Y123.639 E.00939
G1 X105.387 Y123.372 E.01679
G1 X104.978 Y123.026 E.01599
G1 X104.526 Y122.441 E.02201
G1 X104.284 Y121.91 E.01737
G1 X104.166 Y121.372 E.01641
G1 X104.149 Y120.751 E.0185
G1 X104.249 Y120.197 E.01677
G1 X104.397 Y119.778 E.01326
G2 X102.048 Y120.939 I2.741 J8.497 E.07835
G1 X101.227 Y121.594 E.03126
G2 X98.783 Y125.405 I5.816 J6.419 E.13644
G1 X99.307 Y125.215 E.01661
G1 X99.853 Y125.139 E.01642
G1 X100.474 Y125.169 E.0185
G3 X102.119 Y126.055 I-.446 J2.799 E.05673
; LINE_WIDTH: 0.43336
G1 F6146.912
G1 X102.295 Y126.271 E.00859
; LINE_WIDTH: 0.4601
G1 F5752.913
G1 X102.471 Y126.487 E.00917
; LINE_WIDTH: 0.492869
G1 F5333.946
G1 X102.527 Y126.559 E.00327
; LINE_WIDTH: 0.531665
G1 F4910.536
G1 X102.584 Y126.632 E.00355
; LINE_WIDTH: 0.570462
G1 F4549.404
G1 X102.64 Y126.704 E.00383
; LINE_WIDTH: 0.568627
G1 F4565.287
G1 X102.662 Y126.613 E.00389
; LINE_WIDTH: 0.526159
G1 F4966.489
G1 X102.684 Y126.522 E.00358
; LINE_WIDTH: 0.483692
G1 F5445.001
G1 X102.705 Y126.431 E.00326
; LINE_WIDTH: 0.422893
G1 F6316.25
G1 X102.727 Y126.34 E.00281
G1 X102.925 Y126.065 E.01017
G1 X103.143 Y125.935 E.0076
; WIPE_START
G1 X102.925 Y126.065 E-.28065
G1 X102.727 Y126.34 E-.37547
G1 X102.705 Y126.431 E-.10388
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.716 Y126.898 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.57337
G1 F4524.461
M204 S6000
G1 X102.662 Y126.76 E.0062
M204 S10000
G1 X103.219 Y127.028 F42000
; LINE_WIDTH: 0.42354
G1 F6305.513
M204 S6000
G1 X103.076 Y126.497 E.01652
G1 X103.169 Y126.355 E.0051
G1 X103.58 Y126.116 E.01429
G1 X103.563 Y125.608 E.01528
G1 X103.655 Y125.471 E.00497
G1 X104.156 Y125.323 E.01572
G1 X104.272 Y124.813 E.01572
G1 X104.399 Y124.714 E.00485
G1 X104.911 Y124.698 E.01541
G1 X105.144 Y124.242 E.01541
G1 X105.288 Y124.169 E.00485
G1 X105.798 Y124.281 E.01572
G1 X106.201 Y123.842 E.01792
G1 X106.35 Y123.857 E.0045
; LINE_WIDTH: 0.48009
G1 F5489.855
G1 X106.554 Y123.949 E.00771
; LINE_WIDTH: 0.50523
G1 F5191.322
G1 X106.758 Y124.04 E.00816
; LINE_WIDTH: 0.500499
G1 F5245.004
G1 X106.89 Y123.97 E.00541
; LINE_WIDTH: 0.465895
G1 F5674.094
G1 X107.022 Y123.9 E.005
; LINE_WIDTH: 0.419332
G1 F6376.004
G1 X107.154 Y123.83 E.00445
G1 X107.348 Y123.824 E.00578
G1 X107.739 Y124.159 E.01531
G1 X108.186 Y123.994 E.01414
G1 X108.369 Y124.024 E.00553
G1 X108.672 Y124.462 E.01582
G1 X109.182 Y124.413 E.01525
G1 X109.314 Y124.486 E.00447
G1 X109.499 Y124.987 E.01588
G1 X110.009 Y125.068 E.01536
G1 X110.119 Y125.18 E.00464
G1 X110.17 Y125.702 E.01559
G1 X110.637 Y125.902 E.01509
G1 X110.707 Y125.984 E.0032
G3 X110.643 Y126.56 I-1.686 J.104 E.01734
G1 X111.064 Y126.895 E.016
; LINE_WIDTH: 0.444725
G1 F5973.047
G1 X111.1 Y126.979 E.00288
; LINE_WIDTH: 0.494195
G1 F5318.265
G1 X111.135 Y127.062 E.00324
; LINE_WIDTH: 0.53285
G1 F4898.659
G1 X110.96 Y127.501 E.01828
; LINE_WIDTH: 0.526585
G1 F4962.112
G1 X111.034 Y127.628 E.00562
; LINE_WIDTH: 0.486215
G1 F5414.002
G1 X111.108 Y127.755 E.00515
; LINE_WIDTH: 0.43339
G1 F6146.443
G1 X111.183 Y127.881 E.00454
G1 X111.183 Y128.118 E.00731
; LINE_WIDTH: 0.445835
G1 F5956.591
G1 X111.108 Y128.245 E.00468
; LINE_WIDTH: 0.486205
G1 F5414.124
G1 X111.034 Y128.372 E.00515
; LINE_WIDTH: 0.532184
G1 F4905.327
G1 X110.96 Y128.499 E.00569
G1 X111.14 Y128.951 E.01881
; LINE_WIDTH: 0.504165
G1 F5203.309
G1 X111.1 Y129.018 E.00282
; LINE_WIDTH: 0.470495
G1 F5613.05
G1 X111.06 Y129.085 E.00262
; LINE_WIDTH: 0.420234
G1 F6360.753
G1 X111.02 Y129.151 E.00231
G1 X110.642 Y129.44 E.01417
G1 X110.714 Y129.999 E.0168
G1 X110.608 Y130.113 E.00464
G1 X110.17 Y130.298 E.01417
G1 X110.124 Y130.803 E.01512
G1 X110.025 Y130.925 E.00465
G1 X109.499 Y131.013 E.0159
G1 X109.324 Y131.498 E.01538
G1 X109.188 Y131.586 E.00482
G1 X108.672 Y131.538 E.01546
G1 X108.389 Y131.957 E.01507
G1 X108.249 Y132.017 E.00454
G1 X107.739 Y131.841 E.01606
; LINE_WIDTH: 0.412592
G1 F6492.247
G1 X107.348 Y132.175 E.01503
G1 X107.151 Y132.175 E.00576
; LINE_WIDTH: 0.44902
G1 F5909.875
G1 X106.954 Y132.068 E.00719
; LINE_WIDTH: 0.492029
G1 F5343.921
G1 X106.758 Y131.96 E.00795
G1 X106.294 Y132.16 E.01791
; LINE_WIDTH: 0.422011
G1 F6330.938
G1 X106.204 Y132.153 E.0027
G1 X105.798 Y131.719 E.0178
G1 X105.288 Y131.831 E.01564
G1 X105.144 Y131.758 E.00486
G1 X104.911 Y131.302 E.01533
G1 X104.4 Y131.286 E.01533
G1 X104.272 Y131.187 E.00484
G1 X104.156 Y130.677 E.01566
G1 X103.655 Y130.529 E.01566
G1 X103.563 Y130.392 E.00493
G1 X103.58 Y129.884 E.01523
G1 X103.138 Y129.622 E.0154
G1 X103.084 Y129.54 E.00293
G3 X103.219 Y128.972 I2.778 J.361 E.0175
G1 X102.868 Y128.625 E.01478
G1 X102.836 Y128.443 E.00555
; LINE_WIDTH: 0.43866
G1 F6064.588
G1 X102.942 Y128.221 E.00766
; LINE_WIDTH: 0.466899
G1 F5660.657
G1 X103.047 Y128 E.00821
G1 X102.831 Y127.529 E.01734
; LINE_WIDTH: 0.419018
G1 F6381.324
G1 X102.88 Y127.361 E.00521
G1 X103.176 Y127.07 E.01234
; WIPE_START
G1 X102.88 Y127.361 E-.53432
G1 X102.831 Y127.529 E-.22568
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.541 Y128.017 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.476885
G1 F5530.4
M204 S6000
G1 X102.465 Y128.378 E.01264
; LINE_WIDTH: 0.42091
G1 F6349.374
G3 X101.508 Y129.994 I-2.502 J-.391 E.05743
G1 X101.026 Y130.272 E.01663
G1 X100.535 Y130.437 E.01545
G3 X98.406 Y129.895 I-.527 J-2.385 E.06806
G1 X98.316 Y129.987 E.00384
G1 X98.23 Y130.001 E.0026
G2 X105.026 Y136.781 I8.788 J-2.013 E.30228
G1 X105.051 Y136.656 E.00381
G1 X105.115 Y136.598 E.00259
G1 X104.857 Y136.256 E.01279
G1 X104.608 Y135.687 E.01854
G3 X104.599 Y134.367 I2.512 J-.679 E.03984
G1 X104.776 Y133.89 E.0152
G1 X105.086 Y133.413 E.01699
G1 X105.559 Y132.967 E.01941
G1 X106.237 Y132.609 E.02289
; LINE_WIDTH: 0.468948
G1 F5633.439
G1 X106.488 Y132.542 E.00875
; LINE_WIDTH: 0.502003
G1 F5227.819
G1 X106.739 Y132.475 E.00943
; LINE_WIDTH: 0.497612
G1 F5278.302
G1 X106.911 Y132.498 E.00622
; LINE_WIDTH: 0.455775
G1 F5813.178
G1 X107.082 Y132.52 E.00565
; LINE_WIDTH: 0.419588
G1 F6371.661
G3 X107.768 Y132.623 I-1.93 J15.264 E.02064
G1 X108.127 Y132.77 E.01153
G1 X108.556 Y133.051 E.01526
G1 X108.983 Y133.475 E.01791
G3 X109.361 Y134.17 I-2.251 J1.674 E.0236
G1 X109.488 Y134.781 E.01859
G1 X109.485 Y135.301 E.01544
G1 X109.366 Y135.798 E.01522
G3 X109.058 Y136.395 I-2.742 J-1.037 E.02003
G1 X109.206 Y136.729 E.01087
G2 X115.783 Y129.981 I-2.188 J-8.712 E.29513
G1 X115.662 Y129.956 E.00366
G1 X115.608 Y129.895 E.00242
G1 X115.329 Y130.115 E.01055
G1 X114.924 Y130.316 E.01345
G1 X114.307 Y130.478 E.01899
G1 X113.897 Y130.494 E.01222
G1 X113.323 Y130.388 E.01735
G1 X113.058 Y130.303 E.00828
G1 X112.516 Y130 E.01848
G1 X112.198 Y129.72 E.01259
G1 X111.895 Y129.32 E.01493
; LINE_WIDTH: 0.436825
G1 F6092.84
G1 X111.795 Y129.151 E.00612
; LINE_WIDTH: 0.470495
G1 F5613.05
G1 X111.695 Y128.982 E.00664
; LINE_WIDTH: 0.51276
G1 F5108.123
G1 X111.595 Y128.812 E.0073
G1 X111.497 Y128.406 E.01552
; LINE_WIDTH: 0.490005
G1 F5368.107
G1 X111.509 Y128.266 E.00495
; LINE_WIDTH: 0.444815
G1 F5971.709
G1 X111.521 Y128.127 E.00445
; LINE_WIDTH: 0.399625
G1 F6728.249
G1 X111.532 Y127.987 E.00395
; LINE_WIDTH: 0.398248
G1 F6754.333
G1 X111.523 Y127.871 E.00328
; LINE_WIDTH: 0.440683
G1 F6033.752
G1 X111.514 Y127.754 E.00367
; LINE_WIDTH: 0.483118
G1 F5452.098
G1 X111.506 Y127.638 E.00406
; LINE_WIDTH: 0.530894
G1 F4918.298
G1 X111.497 Y127.521 E.0045
G1 X111.586 Y127.215 E.0123
; LINE_WIDTH: 0.494195
G1 F5318.265
G1 X111.74 Y126.947 E.01102
; LINE_WIDTH: 0.420379
G1 F6358.305
G1 X111.895 Y126.679 E.00922
G1 X112.265 Y126.219 E.01759
G1 X112.791 Y125.821 E.01969
G1 X113.214 Y125.636 E.01376
G1 X113.781 Y125.532 E.01718
G1 X114.307 Y125.522 E.01569
G1 X114.924 Y125.684 E.01902
G1 X115.381 Y125.917 E.0153
G1 X115.607 Y126.104 E.00875
G3 X115.784 Y126 I.161 J.07 E.00654
G2 X109.206 Y119.271 I-8.778 J2.001 E.29523
G1 X109.058 Y119.605 E.01089
G1 X109.29 Y119.992 E.01347
G1 X109.464 Y120.593 E.01866
G1 X109.5 Y121.11 E.01544
G3 X109.309 Y121.948 I-2.341 J-.092 E.02578
G1 X109.007 Y122.491 E.01852
G1 X108.721 Y122.814 E.01288
G1 X108.344 Y123.1 E.01409
G1 X107.785 Y123.37 E.01852
; LINE_WIDTH: 0.41036
G1 F6531.679
G1 X107.373 Y123.459 E.01224
; LINE_WIDTH: 0.420242
G1 F6360.621
G1 X107.168 Y123.482 E.00614
; LINE_WIDTH: 0.459265
G1 F5764.45
G1 X106.963 Y123.504 E.00678
; LINE_WIDTH: 0.495892
G1 F5298.341
G1 X106.758 Y123.527 E.00737
G1 X106.262 Y123.409 E.01827
; LINE_WIDTH: 0.459035
G1 F5767.637
G1 X106.004 Y123.279 E.00948
; LINE_WIDTH: 0.420305
G1 F6359.553
G3 X105.552 Y123.028 I1.343 J-2.959 E.01544
G1 X105.159 Y122.66 E.01604
G1 X104.828 Y122.215 E.01653
G1 X104.65 Y121.822 E.01288
G1 X104.543 Y121.362 E.01408
G1 X104.526 Y120.741 E.01852
G3 X105.02 Y119.51 I2.501 J.289 E.04002
G1 X105.112 Y119.399 E.00429
G3 X105.008 Y119.223 I.07 J-.16 E.00649
G2 X101.826 Y120.634 I2.009 J8.825 E.1044
G1 X100.979 Y121.31 E.0323
G2 X98.234 Y126.02 I5.959 J6.628 E.16517
G3 X98.406 Y126.091 I.022 J.189 E.0058
G1 X98.882 Y125.785 E.01687
G1 X99.368 Y125.587 E.01564
G1 X99.974 Y125.523 E.01818
G1 X100.496 Y125.552 E.01558
G1 X101.026 Y125.728 E.01664
G1 X101.508 Y126.006 E.0166
G3 X102.107 Y126.662 I-1.403 J1.882 E.02664
G1 X102.377 Y127.222 E.01852
G1 X102.487 Y127.71 E.01493
; LINE_WIDTH: 0.447145
G1 F5937.288
G1 X102.509 Y127.834 E.00402
; LINE_WIDTH: 0.479795
G1 F5493.563
G1 X102.53 Y127.958 E.00434
; WIPE_START
G1 X102.509 Y127.834 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.649 Y129.305 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.55646
G1 F4673.444
M204 S6000
G1 X102.702 Y129.157 E.00638
; WIPE_START
G1 X102.649 Y129.305 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.194 Y130.096 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X102.885 Y129.902 E.01086
G1 X102.725 Y129.656 E.00876
; LINE_WIDTH: 0.444549
G1 F5975.674
G1 X102.7 Y129.539 E.0038
; LINE_WIDTH: 0.493665
G1 F5324.519
G1 X102.675 Y129.422 E.00426
; LINE_WIDTH: 0.542782
G1 F4801.329
G1 X102.649 Y129.305 E.00472
G1 X102.468 Y129.523 E.0112
; LINE_WIDTH: 0.493665
G1 F5324.519
G1 X102.287 Y129.742 E.0101
; LINE_WIDTH: 0.420325
G1 F6359.216
G1 X102.106 Y129.96 E.00846
G1 X101.713 Y130.31 E.01568
G1 X101.18 Y130.616 E.01832
G1 X100.635 Y130.8 E.01715
G1 X100.073 Y130.871 E.01689
G3 X98.784 Y130.609 I.035 J-3.474 E.03945
G2 X104.435 Y136.234 I8.24 J-2.629 E.24702
G1 X104.226 Y135.721 E.0165
G3 X104.235 Y134.267 I2.983 J-.709 E.04376
G1 X104.432 Y133.736 E.01689
G1 X104.697 Y133.293 E.01537
G1 X105.046 Y132.901 E.01568
G1 X105.555 Y132.528 E.01878
G1 X105.885 Y132.361 E.01102
G1 X105.662 Y132.138 E.0094
G1 X105.28 Y132.208 E.01159
G1 X104.994 Y132.123 E.00888
G1 X104.82 Y131.953 E.00726
G1 X104.676 Y131.673 E.00939
G1 X104.288 Y131.646 E.0116
G1 X104.035 Y131.497 E.00874
G1 X103.935 Y131.356 E.00514
G1 X103.835 Y130.978 E.01166
G1 X103.42 Y130.826 E.0132
G1 X103.268 Y130.662 E.00665
G3 X103.193 Y130.156 I.677 J-.359 E.01556
M204 S10000
G1 X102.79 Y130.297 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G3 X102.527 Y130.043 I.295 J-.57 E.01106
G3 X100.034 Y131.247 I-2.551 J-2.098 E.08508
G1 X99.4 Y131.187 E.01898
G2 X100.825 Y133.463 I7.758 J-3.274 E.08034
G2 X103.82 Y135.607 I6.226 J-5.533 E.11063
G1 X103.758 Y134.948 E.01972
G1 X103.832 Y134.311 E.0191
G3 X104.523 Y132.911 I3.435 J.826 E.04687
G1 X104.941 Y132.499 E.01748
G1 X104.679 Y132.358 E.00885
G1 X104.418 Y132.044 E.01215
G1 X104.05 Y131.96 E.01125
G1 X103.765 Y131.76 E.01037
G3 X103.494 Y131.274 I.922 J-.834 E.01672
G1 X103.16 Y131.101 E.0112
G1 X102.946 Y130.86 E.0096
G1 X102.816 Y130.495 E.01153
G1 X102.798 Y130.357 E.00417
; WIPE_START
G1 X102.816 Y130.495 E-.05318
G1 X102.946 Y130.86 E-.14705
G1 X103.16 Y131.101 E-.12247
G1 X103.494 Y131.274 E-.14291
G1 X103.599 Y131.526 E-.10379
G1 X103.765 Y131.76 E-.10911
G1 X103.941 Y131.883 E-.0815
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.214 Y131.561 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X102.923 Y131.395 E.00998
G1 X102.625 Y131.057 E.01344
G1 X102.472 Y130.653 E.01286
G3 X100.044 Y131.625 I-2.52 J-2.778 E.07954
G1 X100.252 Y132.046 E.01398
G2 X103.278 Y134.935 I6.842 J-4.137 E.12606
G1 X103.382 Y134.962 E.0032
G3 X104.342 Y132.548 I3.748 J.092 E.07903
G1 X104.214 Y132.401 E.0058
G1 X103.894 Y132.303 E.00996
G1 X103.523 Y132.05 E.01337
G1 X103.262 Y131.695 E.01313
G1 X103.234 Y131.618 E.00245
M204 S10000
G1 X102.893 Y131.831 F42000
G1 F6364.866
M204 S6000
G1 X102.498 Y131.512 E.01514
G1 X102.315 Y131.269 E.00907
G3 X100.641 Y131.952 I-2.426 J-3.549 E.05426
G2 X103.053 Y134.366 I6.366 J-3.95 E.10254
G3 X103.747 Y132.678 I4.406 J.826 E.05473
G1 X103.261 Y132.321 E.01797
M73 P73 R4
G3 X102.925 Y131.882 I1.759 J-1.689 E.01651
M204 S10000
G1 X102.631 Y132.11 F42000
G1 F6364.866
M204 S6000
G1 X102.227 Y131.774 E.01563
G1 X101.635 Y132.065 E.01965
G1 X101.258 Y132.194 E.01189
G1 X101.637 Y132.674 E.01823
G1 X102.231 Y133.279 E.02527
G2 X102.813 Y133.75 I6.002 J-6.827 E.02229
G1 X103.055 Y133.119 E.02013
G1 X103.23 Y132.785 E.01123
G1 X102.955 Y132.549 E.01079
G1 X102.666 Y132.158 E.01448
M204 S10000
G1 X102.372 Y132.4 F42000
; LINE_WIDTH: 0.385712
G1 F7001.335
M204 S6000
G1 X102.17 Y132.221 E.00731
G1 X101.854 Y132.365 E.00939
G2 X102.647 Y133.172 I5.538 J-4.644 E.03065
G1 X102.783 Y132.871 E.00895
G1 X102.411 Y132.445 E.0153
; WIPE_START
G1 X102.783 Y132.871 E-.21471
G1 X102.647 Y133.172 E-.12565
G1 X102.19 Y132.738 E-.23941
G1 X101.873 Y132.385 E-.18023
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.135 Y132.373 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.3985
G1 F6749.536
M204 S6000
G1 X107.876 Y132.279 E.00775
; WIPE_START
G1 X108.135 Y132.373 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.859 Y131.936 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.419594
G1 F6371.571
M204 S6000
G1 X108.601 Y132.273 E.01263
G1 X108.245 Y132.388 E.01113
G1 X108.135 Y132.373 E.00329
G1 X108.624 Y132.626 E.01637
G1 X109.029 Y132.961 E.01565
G3 X109.724 Y134.07 I-2.493 J2.334 E.03919
G1 X109.834 Y134.496 E.01309
G1 X109.873 Y135.076 E.01731
G1 X109.787 Y135.719 E.0193
G1 X109.602 Y136.225 E.01602
G2 X115.223 Y130.607 I-2.585 J-8.208 E.24579
G1 X114.726 Y130.781 E.01567
G3 X113.398 Y130.806 I-.722 J-3.06 E.03983
G1 X112.882 Y130.636 E.01616
G1 X112.332 Y130.33 E.01872
G1 X111.907 Y129.96 E.01675
G3 X111.417 Y129.242 I2.546 J-2.265 E.02594
G3 X111.052 Y129.602 I-1.126 J-.78 E.01534
G1 X111.1 Y129.913 E.00937
G1 X111.038 Y130.197 E.00865
G1 X110.839 Y130.416 E.0088
G1 X110.526 Y130.557 E.01022
G1 X110.463 Y130.975 E.01257
G1 X110.297 Y131.196 E.00823
G3 X109.78 Y131.352 I-.546 J-.874 E.01625
G1 X109.604 Y131.754 E.01305
G1 X109.461 Y131.88 E.00569
G1 X109.237 Y131.96 E.00706
G1 X108.919 Y131.94 E.00949
M204 S10000
G1 X109.035 Y132.353 F42000
; LINE_WIDTH: 0.41999
G1 F6364.866
M204 S6000
G1 X108.98 Y132.423 E.00265
G3 X110.088 Y133.97 I-2.024 J2.62 E.0575
G1 X110.209 Y134.452 E.01482
G1 X110.25 Y135.091 E.01905
G1 X110.193 Y135.609 E.01553
G2 X114.616 Y131.186 I-3.182 J-7.605 E.1911
G1 X113.955 Y131.248 E.01978
G1 X113.456 Y131.202 E.01491
G1 X112.873 Y131.039 E.01804
G1 X112.149 Y130.659 E.02435
G1 X111.717 Y130.304 E.01665
G1 X111.46 Y130.011 E.01161
G1 X111.374 Y130.368 E.01096
G1 X111.113 Y130.684 E.0122
G1 X110.881 Y130.837 E.00829
G1 X110.811 Y131.121 E.0087
G1 X110.613 Y131.417 E.01062
G3 X110.053 Y131.711 I-.791 J-.827 E.01908
G1 X109.898 Y131.991 E.00952
G1 X109.659 Y132.201 E.00949
G1 X109.286 Y132.334 E.01178
G1 X109.094 Y132.348 E.00573
; WIPE_START
G1 X109.286 Y132.334 E-.07306
G1 X109.659 Y132.201 E-.15032
G1 X109.898 Y131.991 E-.12112
G1 X110.053 Y131.711 E-.1214
G1 X110.361 Y131.6 E-.12455
G1 X110.613 Y131.417 E-.11804
G1 X110.688 Y131.305 E-.05152
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.325 Y132.011 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
G1 F6364.866
M204 S6000
G1 X110.192 Y132.227 E.00756
G1 X109.857 Y132.522 E.01329
G1 X109.708 Y132.588 E.00486
G1 X110.142 Y133.18 E.02186
G3 X110.624 Y134.76 I-3.57 J1.952 E.04955
G1 X110.653 Y134.975 E.00646
G2 X113.982 Y131.645 I-3.664 J-6.993 E.14242
G1 X113.413 Y131.576 E.01707
G1 X112.762 Y131.399 E.0201
G1 X111.965 Y130.988 E.0267
G1 X111.597 Y130.702 E.01389
G3 X111.218 Y131.089 I-1.683 J-1.269 E.01616
G1 X111.158 Y131.267 E.00559
G1 X110.882 Y131.682 E.01486
G1 X110.529 Y131.937 E.01295
G1 X110.382 Y131.991 E.00468
M204 S10000
G1 X110.584 Y132.325 F42000
G1 F6364.866
M204 S6000
G1 X110.27 Y132.685 E.01423
G1 X110.539 Y133.114 E.01509
G1 X110.813 Y133.764 E.021
G1 X110.958 Y134.366 E.01845
G2 X113.369 Y131.954 I-3.927 J-6.336 E.10248
G3 X111.638 Y131.227 I.892 J-4.546 E.05632
G1 X111.538 Y131.331 E.00432
G1 X111.259 Y131.825 E.01689
G1 X110.882 Y132.168 E.01519
G1 X110.637 Y132.297 E.00821
M204 S10000
G1 X110.779 Y132.7 F42000
G1 F6364.866
M204 S6000
G1 X110.749 Y132.73 E.00125
G3 X111.201 Y133.75 I-3.774 J2.279 E.0333
G2 X112.763 Y132.189 I-4.166 J-5.732 E.06607
G1 X112.166 Y131.963 E.019
G1 X111.75 Y131.732 E.01419
G1 X111.475 Y132.152 E.01497
G3 X110.828 Y132.666 I-2.898 J-2.984 E.02465
M204 S10000
G1 X111.215 Y132.825 F42000
; LINE_WIDTH: 0.369345
G1 F7352.392
M204 S6000
G1 X111.379 Y133.158 E.00958
G2 X112.186 Y132.357 I-3.916 J-4.747 E.02935
G1 X111.873 Y132.2 E.00904
G1 X111.667 Y132.456 E.00847
G1 X111.261 Y132.787 E.01351
; WIPE_START
G1 X111.667 Y132.456 E-.19914
G1 X111.873 Y132.2 E-.12478
G1 X112.186 Y132.357 E-.1332
G1 X111.895 Y132.681 E-.16529
G1 X111.63 Y132.927 E-.13759
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.095 Y137.126 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.353132
G1 F7736.643
M204 S6000
G1 X108.797 Y136.794 E.01903
M204 S10000
G1 X108.822 Y136.831 F42000
; LINE_WIDTH: 0.177617
G1 F15000
M204 S6000
G1 X108.216 Y137.043 E.00683
; LINE_WIDTH: 0.155863
G1 X108.087 Y137.083 E.0012
; LINE_WIDTH: 0.116566
G1 X107.958 Y137.122 E.00078
; WIPE_START
G1 X108.087 Y137.083 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.047 Y137.117 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.117479
G1 F15000
M204 S6000
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
M204 S10000
G1 X100.126 Y131.405 Z2.2 F42000
G1 X98.228 Y129.506 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.0970777
G1 F15000
M204 S6000
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
M204 S10000
G1 X97.888 Y127.044 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.11786
G1 F15000
M204 S6000
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
; WIPE_START
G1 X98.204 Y126.516 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.836 Y126.506 Z2.2 F42000
G1 X115.786 Y126.494 Z2.2
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.0970917
G1 F15000
M204 S6000
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
M204 S10000
G1 X116.125 Y128.958 Z2.2 F42000
G1 Z1.8
G1 E.8 F1800
; LINE_WIDTH: 0.116756
G1 F15000
M204 S6000
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
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X115.81 Y129.484 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 114
M625
; layer num/total_layer_count: 10/23
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
M106 S173.4
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z2.2 I.356 J1.164 P1  F42000
G1 X125.378 Y126.557 Z2.2
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
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
M204 S6000
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18163
G1 X125.92 Y125.482 E-.18164
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.28 Y119.863 Z2.4 F42000
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S5000
G1 X129.438 Y120.07 E.00777
G3 X127.871 Y119.294 I-1.435 J.928 E.26517
G1 X128.134 Y119.294 E.00782
G3 X129.239 Y119.819 I-.131 J1.704 E.03727
; WIPE_START
M204 S6000
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
M204 S10000
G1 X135.598 Y126.356 Z2.4 F42000
G1 X136.331 Y126.924 Z2.4
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S5000
G1 X136.476 Y127.124 E.00737
G3 X134.689 Y126.319 I-1.468 J.875 E.25765
G1 X134.937 Y126.291 E.00744
G3 X136.297 Y126.875 I.071 J1.707 E.0456
; WIPE_START
M204 S6000
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
M204 S10000
G1 X131.115 Y134.122 Z2.4 F42000
G1 X128.623 Y136.592 Z2.4
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S5000
G1 X128.391 Y136.663 E.00722
G3 X127.753 Y133.308 I-.383 J-1.665 E.16377
G1 X128.002 Y133.289 E.00744
G3 X128.679 Y136.569 I.006 J1.709 E.13953
; WIPE_START
M204 S6000
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
M204 S10000
G1 X123.254 Y129.485 Z2.4 F42000
G1 X122.667 Y128.373 Z2.4
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S5000
G1 X122.636 Y128.517 E.00438
G3 X120.818 Y126.3 I-1.628 J-.519 E.21844
G1 X121.068 Y126.291 E.00743
G3 X122.696 Y128.262 I-.059 J1.707 E.08605
G1 X122.682 Y128.315 E.00165
; WIPE_START
M204 S6000
G1 X122.636 Y128.517 E-.07871
G1 X122.535 Y128.759 E-.09962
G1 X122.401 Y128.984 E-.09951
G1 X122.235 Y129.186 E-.09952
G1 X122.039 Y129.361 E-.09983
G1 X121.808 Y129.508 E-.10383
G1 X121.58 Y129.61 E-.09487
G1 X121.367 Y129.669 E-.08411
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.869 Y122.887 Z2.4 F42000
G1 X127.271 Y118.237 Z2.4
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S5000
G3 X128.412 Y118.219 I.72 J9.507 E.03401
G3 X127.211 Y118.242 I-.417 J9.779 E1.79598
; WIPE_START
M204 S6000
G1 X127.856 Y118.211 E-.24533
G1 X128.412 Y118.219 E-.21131
G1 X129.026 Y118.264 E-.23391
G1 X129.207 Y118.288 E-.06945
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z2.4 I1.217 J0 P1  F42000
; stop printing object, unique label id: 78
M625
; object ids of layer 10 start: 78,114
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


; object ids of this layer10 end: 78,114
M625
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X127.96 Y124.387 F42000
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.15144
G1 F15000
M204 S6000
G1 X126.737 Y124.615 E.01067
M204 S10000
G1 X127.037 Y124.518 F42000
; LINE_WIDTH: 0.151431
G1 F15000
M204 S6000
G1 X125.91 Y125.053 E.0107
M204 S10000
G1 X125.788 Y125.223 F42000
; LINE_WIDTH: 0.153236
G1 F15000
M204 S6000
G1 X125.223 Y125.689 E.00638
M204 S10000
G1 X124.946 Y126.071 F42000
; LINE_WIDTH: 0.153237
G1 F15000
M204 S6000
G1 X124.677 Y126.752 E.00638
M204 S10000
G1 X124.553 Y126.921 F42000
; LINE_WIDTH: 0.151438
G1 F15000
M204 S6000
G1 X124.392 Y128.158 E.0107
M204 S10000
G1 X124.392 Y127.842 F42000
; LINE_WIDTH: 0.151438
G1 F15000
M204 S6000
G1 X124.553 Y129.08 E.0107
M204 S10000
G1 X124.677 Y129.248 F42000
; LINE_WIDTH: 0.153228
G1 F15000
M204 S6000
G1 X124.943 Y129.924 E.00633
M204 S10000
G1 X125.223 Y130.311 F42000
; LINE_WIDTH: 0.153233
G1 F15000
M204 S6000
G1 X125.788 Y130.777 E.00638
M204 S10000
G1 X125.91 Y130.947 F42000
; LINE_WIDTH: 0.151451
G1 F15000
M204 S6000
G1 X127.037 Y131.482 E.0107
M204 S10000
G1 X126.74 Y131.385 F42000
; LINE_WIDTH: 0.151444
G1 F15000
M204 S6000
G1 X127.963 Y131.614 E.01066
M204 S10000
G1 X128.161 Y131.548 F42000
; LINE_WIDTH: 0.153227
G1 F15000
M204 S6000
G1 X128.892 Y131.503 E.00638
M204 S10000
G1 X129.341 Y131.357 F42000
; LINE_WIDTH: 0.153204
G1 F15000
M204 S6000
G1 X129.959 Y130.964 E.00638
M204 S10000
G1 X130.158 Y130.9 F42000
; LINE_WIDTH: 0.151412
G1 F15000
M204 S6000
G1 X131.016 Y129.994 E.01069
M204 S10000
G1 X130.83 Y130.249 F42000
; LINE_WIDTH: 0.151417
G1 F15000
M204 S6000
G1 X131.427 Y129.154 E.01069
M204 S10000
G1 X131.426 Y128.945 F42000
; LINE_WIDTH: 0.153214
G1 F15000
M204 S6000
G1 X131.609 Y128.236 E.00638
M204 S10000
G1 X131.609 Y127.764 F42000
; LINE_WIDTH: 0.153234
G1 F15000
M204 S6000
G1 X131.426 Y127.055 E.00638
M204 S10000
G1 X131.427 Y126.846 F42000
; LINE_WIDTH: 0.151406
G1 F15000
M204 S6000
G1 X130.83 Y125.75 E.01069
M204 S10000
G1 X131.016 Y126.006 F42000
; LINE_WIDTH: 0.151446
G1 F15000
M204 S6000
G1 X130.158 Y125.1 E.0107
M204 S10000
G1 X129.959 Y125.036 F42000
; LINE_WIDTH: 0.153201
G1 F15000
M204 S6000
G1 X129.342 Y124.643 E.00638
; WIPE_START
G1 X129.959 Y125.036 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.783 Y132.447 Z2.4 F42000
G1 X132.738 Y136.327 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S2000
G1 X136.332 Y132.733 E.1514
G1 X136.843 Y131.689
G1 X131.689 Y136.842 E.21711
G1 X130.854 Y137.145
G1 X137.146 Y130.852 E.26506
G1 X137.344 Y130.121
G1 X130.12 Y137.345 E.3043
G1 X129.464 Y137.468
G1 X137.472 Y129.46 E.33732
G1 X137.547 Y128.852
G1 X128.858 Y137.541 E.36602
G1 X128.29 Y137.575
G1 X137.58 Y128.285 E.39134
G1 X136.859 Y128.473
G1 X137.58 Y127.752 E.03038
G1 X137.552 Y127.246
G1 X136.915 Y127.883 E.02684
G1 X136.83 Y127.435
G1 X137.501 Y126.765 E.02826
G1 X137.429 Y126.303
M73 P74 R4
G1 X136.672 Y127.06 E.0319
G1 X136.452 Y126.747
G1 X137.339 Y125.86 E.03739
G1 X137.234 Y125.432
G1 X136.176 Y126.489 E.04454
G1 X135.849 Y126.283
G1 X137.107 Y125.026 E.05297
G1 X136.968 Y124.631
G1 X135.459 Y126.14 E.06357
G1 X134.981 Y126.085
G1 X136.817 Y124.249 E.07733
G1 X136.653 Y123.88
G1 X134.326 Y126.207 E.09801
; WIPE_START
M204 S6000
G1 X135.74 Y124.793 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.475 Y129.857 Z2.4 F42000
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S2000
G1 X129.859 Y135.473 E.23656
G1 X129.915 Y134.884
G1 X134.886 Y129.912 E.20944
G1 X134.437 Y129.829
G1 X129.831 Y134.435 E.19403
G1 X129.672 Y134.06
G1 X134.062 Y129.67 E.18491
G1 X133.751 Y129.448
M73 P74 R3
G1 X129.449 Y133.75 E.18123
G1 X129.177 Y133.489
G1 X133.491 Y129.174 E.18175
G1 X133.282 Y128.85
G1 X128.852 Y133.28 E.18661
G1 X128.457 Y133.142
G1 X133.144 Y128.455 E.19743
G1 X133.085 Y127.981
G1 X131.001 Y130.065 E.08779
G1 X131.491 Y129.041
G1 X133.215 Y127.318 E.07259
; WIPE_START
M204 S6000
G1 X131.8 Y128.732 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.625 Y128.374 Z2.4 F42000
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S2000
G1 X136.472 Y123.527 E.20419
G1 X136.282 Y123.184
G1 X131.638 Y127.828 E.19562
G1 X131.587 Y127.346
G1 X136.083 Y122.85 E.18939
G1 X135.867 Y122.533
G1 X131.479 Y126.921 E.18484
G1 X131.333 Y126.533
G1 X135.643 Y122.223 E.18154
G1 X135.41 Y121.923
G1 X131.155 Y126.178 E.17924
G1 X130.946 Y125.853
G1 X135.162 Y121.638 E.17759
G1 X134.906 Y121.36
G1 X130.706 Y125.56 E.17693
G1 X130.439 Y125.295
G1 X134.642 Y121.092 E.17706
G1 X134.362 Y120.838
G1 X130.144 Y125.056 E.1777
G1 X129.821 Y124.846
G1 X134.075 Y120.592 E.17919
G1 X133.777 Y120.356
G1 X129.468 Y124.666 E.18152
G1 X129.079 Y124.521
G1 X133.467 Y120.133 E.18482
G1 X133.147 Y119.92
G1 X128.649 Y124.418 E.18947
G1 X128.173 Y124.361
G1 X132.818 Y119.716 E.19566
G1 X132.472 Y119.528
G1 X127.621 Y124.379 E.20434
G1 X126.954 Y124.513
G1 X128.676 Y122.791 E.07254
G1 X128.016 Y122.917
G1 X125.922 Y125.011 E.08821
; WIPE_START
M204 S6000
G1 X127.337 Y123.597 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.799 Y121.668 Z2.4 F42000
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S2000
G1 X132.117 Y119.35 E.09764
G1 X131.752 Y119.182
G1 X129.917 Y121.017 E.07728
G1 X129.862 Y120.539
G1 X131.369 Y119.032 E.0635
G1 X130.973 Y118.894
G1 X129.718 Y120.15 E.0529
G1 X129.511 Y119.823
G1 X130.565 Y118.77 E.04439
G1 X130.141 Y118.66
G1 X129.253 Y119.548 E.03744
G1 X128.939 Y119.329
G1 X129.696 Y118.571 E.03191
G1 X129.233 Y118.501
G1 X128.563 Y119.171 E.02822
G1 X128.114 Y119.087
G1 X128.749 Y118.452 E.02676
G1 X128.244 Y118.424
G1 X127.523 Y119.145 E.03037
; WIPE_START
M204 S6000
G1 X128.244 Y118.424 E-.38742
G1 X128.749 Y118.452 E-.19252
G1 X128.414 Y118.787 E-.18007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.437 Y126.35 Z2.4 F42000
G1 X130.065 Y131.001 Z2.4
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S2000
G1 X127.983 Y133.083 E.08771
G1 X127.32 Y133.212
G1 X129.044 Y131.489 E.0726
; WIPE_START
M204 S6000
G1 X127.63 Y132.903 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.755 Y137.577 Z2.4 F42000
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S2000
G1 X128.475 Y136.857 E.03032
G1 X127.886 Y136.913
G1 X127.247 Y137.552 E.0269
G1 X126.765 Y137.501
G1 X127.438 Y136.828 E.02835
G1 X127.063 Y136.669
G1 X126.305 Y137.427 E.03193
G1 X125.863 Y137.336
G1 X126.75 Y136.449 E.03735
G1 X126.492 Y136.174
G1 X125.437 Y137.229 E.04444
G1 X125.025 Y137.108
G1 X126.286 Y135.846 E.05314
G1 X126.142 Y135.457
G1 X124.632 Y136.967 E.06361
G1 X124.252 Y136.814
G1 X126.087 Y134.979 E.07729
G1 X126.209 Y134.324
G1 X123.884 Y136.648 E.09793
G1 X123.528 Y136.471
G1 X128.378 Y131.621 E.20431
G1 X127.827 Y131.639
G1 X123.187 Y136.28 E.19548
G1 X122.854 Y136.079
G1 X127.351 Y131.582 E.18944
G1 X126.922 Y131.478
G1 X122.533 Y135.867 E.18486
G1 X122.226 Y135.64
G1 X126.533 Y131.333 E.18145
G1 X126.181 Y131.152
G1 X121.927 Y135.406 E.1792
G1 X121.638 Y135.162
G1 X125.858 Y130.942 E.17776
G1 X125.563 Y130.703
G1 X121.363 Y134.904 E.17695
G1 X121.095 Y134.638
G1 X125.296 Y130.437 E.17696
G1 X125.056 Y130.144
G1 X120.839 Y134.361 E.17766
G1 X120.595 Y134.072
G1 X124.847 Y129.819 E.17914
G1 X124.669 Y129.464
G1 X120.359 Y133.775 E.18158
G1 X120.134 Y133.466
G1 X124.524 Y129.076 E.18493
G1 X124.417 Y128.65
G1 X119.923 Y133.144 E.18931
G1 X119.72 Y132.814
G1 X124.366 Y128.168 E.19571
G1 X124.38 Y127.62
G1 X119.529 Y132.471 E.20436
G1 X119.353 Y132.114
G1 X121.67 Y129.797 E.09763
G1 X121.019 Y129.915
G1 X119.187 Y131.747 E.07719
G1 X119.033 Y131.368
G1 X120.541 Y129.859 E.06355
G1 X120.152 Y129.715
G1 X118.896 Y130.971 E.05291
G1 X118.773 Y130.561
G1 X119.826 Y129.509 E.04435
G1 X119.551 Y129.25
G1 X118.664 Y130.137 E.03733
G1 X118.572 Y129.696
G1 X119.331 Y128.936 E.032
G1 X119.173 Y128.561
G1 X118.502 Y129.233 E.02829
G1 X118.453 Y128.748
G1 X119.089 Y128.112 E.02681
G1 X119.148 Y127.52
G1 X118.428 Y128.24 E.03032
; WIPE_START
M204 S6000
G1 X119.148 Y127.52 E-.38682
G1 X119.089 Y128.112 E-.22587
G1 X118.815 Y128.386 E-.14732
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X122.793 Y128.674 Z2.4 F42000
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S2000
G1 X124.515 Y126.952 E.07255
G1 X125.012 Y125.921
G1 X122.92 Y128.014 E.08816
G1 X122.86 Y127.541
M73 P75 R3
G1 X127.544 Y122.856 E.19734
G1 X127.149 Y122.718
G1 X122.719 Y127.148 E.18661
G1 X122.511 Y126.823
G1 X126.825 Y122.509 E.18173
G1 X126.552 Y122.248
G1 X122.251 Y126.55 E.18121
G1 X121.94 Y126.328
G1 X126.33 Y121.937 E.18495
G1 X126.173 Y121.561
G1 X121.564 Y126.17 E.19415
G1 X121.114 Y126.087
G1 X126.089 Y121.112 E.20959
G1 X126.146 Y120.522
G1 X120.524 Y126.144 E.23685
; WIPE_START
M204 S6000
G1 X121.938 Y124.73 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X118.429 Y127.706 Z2.4 F42000
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S2000
G1 X127.709 Y118.425 E.39095
G1 X127.142 Y118.46
G1 X118.463 Y127.138 E.3656
G1 X118.537 Y126.531
G1 X126.534 Y118.535 E.33684
G1 X125.873 Y118.661
G1 X118.662 Y125.873 E.30377
G1 X118.856 Y125.146
G1 X125.146 Y118.856 E.26496
G1 X124.304 Y119.164
G1 X119.167 Y124.302 E.21642
G1 X119.683 Y123.252
G1 X123.253 Y119.682 E.15038
; WIPE_START
M204 S6000
G1 X121.839 Y121.096 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.973 Y123.809 Z2.4 F42000
G1 X134.996 Y126.099 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.100651
G1 F15000
M204 S6000
G1 X134.783 Y126.016 E.00104
M204 S10000
G1 X134.264 Y126.145 F42000
; LINE_WIDTH: 0.199759
G1 F15000
M204 S6000
G1 X134.167 Y126.211 E.00145
; LINE_WIDTH: 0.171977
G1 X134.064 Y126.283 E.00129
; LINE_WIDTH: 0.141702
G1 X133.95 Y126.375 E.00114
; LINE_WIDTH: 0.101325
G1 X133.73 Y126.567 E.00135
M204 S10000
G1 X133.566 Y126.731 F42000
; LINE_WIDTH: 0.0974055
G1 F15000
M204 S6000
G1 X133.421 Y126.891 E.00093
; LINE_WIDTH: 0.125269
G1 X133.331 Y127.006 E.00095
; LINE_WIDTH: 0.172065
G2 X133.148 Y127.252 I3.088 J2.494 E.00312
; WIPE_START
G1 X133.331 Y127.006 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.078 Y129.987 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0894776
G1 F15000
M204 S6000
G1 X134.906 Y129.911 E.00069
M204 S10000
G1 X135.694 Y129.905 F42000
; LINE_WIDTH: 0.0958414
G1 F15000
M204 S6000
G1 X135.462 Y129.844 E.001
M204 S10000
G1 X135.858 Y129.713 F42000
; LINE_WIDTH: 0.103667
G1 F15000
M204 S6000
G3 X135.548 Y129.93 I-2.977 J-3.916 E.00182
; WIPE_START
G1 X135.858 Y129.713 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X137.579 Y128.203 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.100565
G1 F15000
M204 S6000
G1 X137.559 Y128.04 E.00075
M204 S10000
G1 X136.892 Y128.598 F42000
; LINE_WIDTH: 0.122393
G1 F15000
M204 S6000
G3 X136.711 Y128.861 I-3.498 J-2.217 E.002
; WIPE_START
G1 X136.892 Y128.598 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.519 Y123.177 Z2.4 F42000
G1 X127.453 Y119.076 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.137847
G1 F15000
M204 S6000
G1 X127.271 Y119.196 E.00163
; LINE_WIDTH: 0.112262
G1 X127.132 Y119.296 E.00094
; WIPE_START
G1 X127.271 Y119.196 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.099 Y120.303 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0910057
G1 F15000
M204 S6000
G1 X126.16 Y120.535 E.00091
M204 S10000
G1 X126.295 Y120.134 F42000
; LINE_WIDTH: 0.103289
G1 F15000
M204 S6000
G2 X126.074 Y120.449 I4.208 J3.194 E.00184
; WIPE_START
G1 X126.295 Y120.134 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.245 Y122.458 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0958483
G1 F15000
M204 S6000
G1 X129.109 Y122.581 E.00077
; LINE_WIDTH: 0.123427
G1 X128.989 Y122.674 E.00097
; LINE_WIDTH: 0.173024
G3 X128.743 Y122.857 I-2.633 J-3.287 E.00315
; WIPE_START
G1 X128.989 Y122.674 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.861 Y121.73 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.198908
G1 F15000
M204 S6000
G1 X129.792 Y121.83 E.0015
; LINE_WIDTH: 0.169457
G1 X129.718 Y121.938 E.0013
; LINE_WIDTH: 0.138398
G1 X129.626 Y122.051 E.0011
; LINE_WIDTH: 0.100989
G1 X129.473 Y122.23 E.00108
; WIPE_START
G1 X129.626 Y122.051 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.986 Y121.214 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.104212
G1 F15000
M204 S6000
G1 X129.903 Y121.003 E.0011
; WIPE_START
G1 X129.986 Y121.214 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.764 Y119.41 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.105177
G1 F15000
M204 S6000
G1 X123.672 Y119.477 E.00056
; LINE_WIDTH: 0.139182
G1 X123.58 Y119.543 E.00086
; LINE_WIDTH: 0.173186
G1 X123.487 Y119.61 E.00117
; LINE_WIDTH: 0.206858
G1 F14639.736
G1 X123.314 Y119.743 E.00283
; WIPE_START
G1 X123.487 Y119.61 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X122.427 Y120.211 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.105052
G1 F15000
M204 S6000
G1 X122.239 Y120.374 E.00122
; LINE_WIDTH: 0.138806
G1 X122.051 Y120.538 E.00189
; LINE_WIDTH: 0.179181
G1 X121.631 Y120.924 E.00614
; LINE_WIDTH: 0.2069
G1 F14635.99
G2 X120.829 Y121.733 I13.126 J13.831 E.01476
; LINE_WIDTH: 0.180225
G1 F15000
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
M204 S10000
G1 X125.862 Y124.951 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.207581
G1 F14575.427
M204 S6000
G1 X125.444 Y125.329 E.00733
G1 X125.013 Y125.788 E.00819
; LINE_WIDTH: 0.219607
G1 F13583.397
G1 X125.014 Y125.807 E.00026
; LINE_WIDTH: 0.179288
G1 F15000
G1 X125.024 Y125.932 E.00135
; WIPE_START
G1 X125.014 Y125.807 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X130.99 Y130.054 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.20535
G1 F14775.655
M204 S6000
G1 X131.001 Y130.198 E.00185
G1 X130.56 Y130.67 E.00829
G1 X130.125 Y131.061 E.0075
; WIPE_START
G1 X130.56 Y130.67 E-.323
G1 X131.001 Y130.198 E-.35729
G1 X130.99 Y130.054 E-.07971
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.375 Y129.547 Z2.4 F42000
G1 X122.232 Y129.471 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.090097
G1 F15000
M204 S6000
G1 X122.166 Y129.533 E.00034
; LINE_WIDTH: 0.108928
G1 X122.048 Y129.628 E.00079
; LINE_WIDTH: 0.142955
G1 X121.922 Y129.728 E.00127
; LINE_WIDTH: 0.174059
G1 X121.827 Y129.793 E.00119
; LINE_WIDTH: 0.200117
G1 X121.732 Y129.859 E.00143
; WIPE_START
G1 X121.827 Y129.793 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X122.86 Y128.741 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.178255
G1 F15000
M204 S6000
G1 X122.762 Y128.877 E.00179
; LINE_WIDTH: 0.158354
G1 X122.672 Y128.993 E.00134
; LINE_WIDTH: 0.121393
G1 X122.579 Y129.112 E.00094
; LINE_WIDTH: 0.0955734
G1 X122.46 Y129.243 E.00074
; WIPE_START
G1 X122.579 Y129.112 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X120.451 Y126.072 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.106359
G1 F15000
M204 S6000
G2 X120.136 Y126.293 I2.576 J4.013 E.00193
; WIPE_START
G1 X120.451 Y126.072 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X119.298 Y127.13 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.11226
G1 F15000
M204 S6000
G1 X119.198 Y127.269 E.00094
; LINE_WIDTH: 0.137841
G1 X119.078 Y127.451 E.00164
; WIPE_START
G1 X119.198 Y127.269 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X122.422 Y134.188 Z2.4 F42000
G1 X123.473 Y136.444 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0980474
G1 F15000
M204 S6000
G1 X123.369 Y136.364 E.00057
; WIPE_START
G1 X123.473 Y136.444 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X128.863 Y136.709 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.124488
G1 F15000
M204 S6000
G3 X128.544 Y136.926 I-2.901 J-3.904 E.00249
; WIPE_START
G1 X128.863 Y136.709 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.932 Y135.546 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.103664
G1 F15000
M204 S6000
G3 X129.715 Y135.856 I-3.968 J-2.543 E.00182
M204 S10000
G1 X129.907 Y135.691 F42000
; LINE_WIDTH: 0.0958372
G1 F15000
M204 S6000
G1 X129.846 Y135.46 E.001
; WIPE_START
G1 X129.907 Y135.691 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.254 Y133.146 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.181657
G1 F15000
M204 S6000
G1 X127.124 Y133.239 E.00175
; LINE_WIDTH: 0.161694
G1 X127.009 Y133.329 E.00138
; LINE_WIDTH: 0.124684
G1 X126.889 Y133.422 E.00098
; LINE_WIDTH: 0.0972015
G1 X126.733 Y133.564 E.00091
M204 S10000
G1 X126.578 Y133.719 F42000
; LINE_WIDTH: 0.0915321
G1 F15000
M204 S6000
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
M204 S10000
G1 X132.677 Y136.266 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.201477
G1 F15000
M204 S6000
G1 X132.545 Y136.364 E.00205
; LINE_WIDTH: 0.16291
G1 X132.414 Y136.462 E.00155
; LINE_WIDTH: 0.124344
G1 X132.283 Y136.56 E.00105
; LINE_WIDTH: 0.0966274
G1 X132.224 Y136.6 E.0003
; WIPE_START
G1 X132.283 Y136.56 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X135.805 Y133.556 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.094634
G1 F15000
M204 S6000
G1 X135.746 Y133.626 E.00038
; LINE_WIDTH: 0.11929
G1 X135.557 Y133.841 E.00173
; LINE_WIDTH: 0.1557
G1 X135.368 Y134.056 E.00255
; LINE_WIDTH: 0.203041
G1 F14988.664
G3 X134.164 Y135.269 I-15.796 J-14.474 E.02162
; LINE_WIDTH: 0.170691
G1 F15000
G1 X133.951 Y135.46 E.00289
; LINE_WIDTH: 0.138609
G1 X133.737 Y135.65 E.00216
; LINE_WIDTH: 0.10536
G1 X133.567 Y135.794 E.0011
; OBJECT_ID: 114
; WIPE_START
G1 X133.737 Y135.65 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S10000
G1 X126.447 Y133.392 Z2.4 F42000
G1 X104.382 Y126.557 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S5000
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
G1 X103.765 Y128.41 E.01424
G1 X104.012 Y128 E.01424
G1 X103.765 Y127.59 E.01424
G1 X104.106 Y127.255 E.01424
G1 X103.969 Y126.797 E.01424
G1 X104.33 Y126.587 E.01245
; WIPE_START
M204 S6000
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18163
G1 X104.924 Y125.482 E-.18164
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.284 Y119.863 Z2.4 F42000
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S5000
G1 X108.442 Y120.07 E.00777
G3 X106.876 Y119.294 I-1.435 J.928 E.26517
G1 X107.138 Y119.294 E.00782
G3 X108.244 Y119.819 I-.131 J1.704 E.03727
; WIPE_START
M204 S6000
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
M204 S10000
G1 X114.603 Y126.356 Z2.4 F42000
G1 X115.335 Y126.924 Z2.4
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S5000
G1 X115.481 Y127.124 E.00737
G3 X113.693 Y126.319 I-1.468 J.875 E.25765
G1 X113.941 Y126.291 E.00744
G3 X115.301 Y126.875 I.071 J1.707 E.0456
; WIPE_START
M204 S6000
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
M204 S10000
G1 X110.119 Y134.122 Z2.4 F42000
G1 X107.628 Y136.592 Z2.4
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S5000
G1 X107.396 Y136.663 E.00722
G3 X106.758 Y133.308 I-.383 J-1.665 E.16377
G1 X107.007 Y133.289 E.00744
G3 X107.683 Y136.569 I.006 J1.709 E.13953
; WIPE_START
M204 S6000
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
M204 S10000
G1 X102.259 Y129.485 Z2.4 F42000
G1 X101.671 Y128.373 Z2.4
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S5000
G1 X101.641 Y128.517 E.00438
G3 X99.823 Y126.3 I-1.628 J-.519 E.21844
G1 X100.072 Y126.291 E.00743
G3 X101.701 Y128.262 I-.059 J1.707 E.08605
G1 X101.687 Y128.315 E.00165
; WIPE_START
M204 S6000
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
M204 S10000
G1 X103.874 Y122.887 Z2.4 F42000
G1 X106.275 Y118.237 Z2.4
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S5000
G3 X107.416 Y118.219 I.72 J9.507 E.03401
G3 X106.215 Y118.242 I-.417 J9.779 E1.79598
; WIPE_START
M204 S6000
G1 X106.86 Y118.211 E-.24533
M73 P76 R3
G1 X107.416 Y118.219 E-.21131
G1 X108.03 Y118.264 E-.23391
G1 X108.211 Y118.288 E-.06945
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.965 Y124.387 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.15144
G1 F15000
M204 S6000
G1 X105.741 Y124.615 E.01067
M204 S10000
G1 X106.041 Y124.518 F42000
; LINE_WIDTH: 0.151431
G1 F15000
M204 S6000
G1 X104.914 Y125.053 E.0107
M204 S10000
G1 X104.792 Y125.223 F42000
; LINE_WIDTH: 0.153236
G1 F15000
M204 S6000
G1 X104.228 Y125.689 E.00638
M204 S10000
G1 X103.95 Y126.071 F42000
; LINE_WIDTH: 0.153237
G1 F15000
M204 S6000
G1 X103.682 Y126.752 E.00638
M204 S10000
G1 X103.558 Y126.921 F42000
; LINE_WIDTH: 0.151438
G1 F15000
M204 S6000
G1 X103.396 Y128.158 E.0107
M204 S10000
G1 X103.396 Y127.842 F42000
; LINE_WIDTH: 0.151438
G1 F15000
M204 S6000
G1 X103.558 Y129.08 E.0107
M204 S10000
G1 X103.682 Y129.248 F42000
; LINE_WIDTH: 0.153228
G1 F15000
M204 S6000
G1 X103.948 Y129.924 E.00633
M204 S10000
G1 X104.228 Y130.311 F42000
; LINE_WIDTH: 0.153233
G1 F15000
M204 S6000
G1 X104.793 Y130.777 E.00638
M204 S10000
G1 X104.914 Y130.947 F42000
; LINE_WIDTH: 0.151451
G1 F15000
M204 S6000
G1 X106.041 Y131.482 E.0107
M204 S10000
G1 X105.745 Y131.385 F42000
; LINE_WIDTH: 0.151444
G1 F15000
M204 S6000
G1 X106.967 Y131.614 E.01066
M204 S10000
G1 X107.166 Y131.548 F42000
; LINE_WIDTH: 0.153227
G1 F15000
M204 S6000
G1 X107.897 Y131.503 E.00638
M204 S10000
G1 X108.346 Y131.357 F42000
; LINE_WIDTH: 0.153204
G1 F15000
M204 S6000
G1 X108.963 Y130.964 E.00638
M204 S10000
G1 X109.163 Y130.9 F42000
; LINE_WIDTH: 0.151412
G1 F15000
M204 S6000
G1 X110.02 Y129.994 E.01069
M204 S10000
G1 X109.835 Y130.249 F42000
; LINE_WIDTH: 0.151417
G1 F15000
M204 S6000
G1 X110.432 Y129.154 E.01069
M204 S10000
G1 X110.43 Y128.945 F42000
; LINE_WIDTH: 0.153214
G1 F15000
M204 S6000
G1 X110.613 Y128.236 E.00638
M204 S10000
G1 X110.613 Y127.764 F42000
; LINE_WIDTH: 0.153234
G1 F15000
M204 S6000
G1 X110.43 Y127.055 E.00638
M204 S10000
G1 X110.431 Y126.846 F42000
; LINE_WIDTH: 0.151406
G1 F15000
M204 S6000
G1 X109.835 Y125.75 E.01069
M204 S10000
G1 X110.021 Y126.006 F42000
; LINE_WIDTH: 0.151446
G1 F15000
M204 S6000
G1 X109.163 Y125.1 E.0107
M204 S10000
G1 X108.963 Y125.036 F42000
; LINE_WIDTH: 0.153201
G1 F15000
M204 S6000
G1 X108.346 Y124.643 E.00638
; WIPE_START
G1 X108.963 Y125.036 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.787 Y132.447 Z2.4 F42000
G1 X111.742 Y136.327 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F6364.704
M204 S2000
G1 X115.337 Y132.733 E.1514
G1 X115.847 Y131.689
G1 X110.694 Y136.842 E.21711
G1 X109.858 Y137.145
G1 X116.15 Y130.852 E.26506
G1 X116.348 Y130.121
G1 X109.124 Y137.345 E.3043
G1 X108.469 Y137.468
G1 X116.476 Y129.46 E.33732
G1 X116.551 Y128.852
G1 X107.862 Y137.541 E.36602
G1 X107.295 Y137.575
G1 X116.585 Y128.285 E.39134
G1 X115.864 Y128.473
G1 X116.585 Y127.752 E.03038
G1 X116.557 Y127.246
G1 X115.92 Y127.883 E.02684
G1 X115.835 Y127.435
G1 X116.505 Y126.765 E.02826
G1 X116.433 Y126.303
G1 X115.676 Y127.06 E.0319
G1 X115.456 Y126.747
G1 X116.344 Y125.86 E.03739
G1 X116.238 Y125.432
G1 X115.181 Y126.489 E.04454
G1 X114.854 Y126.283
G1 X116.111 Y125.026 E.05297
G1 X115.973 Y124.631
G1 X114.464 Y126.14 E.06357
G1 X113.986 Y126.085
G1 X115.821 Y124.249 E.07733
G1 X115.657 Y123.88
G1 X113.33 Y126.207 E.09801
; WIPE_START
M204 S6000
G1 X114.745 Y124.793 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.48 Y129.857 Z2.4 F42000
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S2000
G1 X108.864 Y135.473 E.23656
G1 X108.919 Y134.884
G1 X113.891 Y129.912 E.20944
G1 X113.441 Y129.829
G1 X108.835 Y134.435 E.19403
G1 X108.677 Y134.06
G1 X113.066 Y129.67 E.18491
G1 X112.756 Y129.448
G1 X108.454 Y133.75 E.18123
G1 X108.181 Y133.489
G1 X112.496 Y129.174 E.18175
G1 X112.287 Y128.85
G1 X107.857 Y133.28 E.18661
G1 X107.462 Y133.142
G1 X112.149 Y128.455 E.19743
G1 X112.089 Y127.981
G1 X110.005 Y130.065 E.08779
G1 X110.496 Y129.041
G1 X112.219 Y127.318 E.07259
; WIPE_START
M204 S6000
G1 X110.805 Y128.732 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.629 Y128.374 Z2.4 F42000
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S2000
G1 X115.477 Y123.527 E.20419
G1 X115.287 Y123.184
G1 X110.643 Y127.828 E.19562
G1 X110.591 Y127.346
G1 X115.087 Y122.85 E.18939
G1 X114.872 Y122.533
G1 X110.484 Y126.921 E.18484
G1 X110.338 Y126.533
G1 X114.648 Y122.223 E.18154
G1 X114.415 Y121.923
G1 X110.16 Y126.178 E.17924
G1 X109.951 Y125.853
G1 X114.167 Y121.638 E.17759
G1 X113.911 Y121.36
G1 X109.711 Y125.56 E.17693
G1 X109.443 Y125.295
G1 X113.646 Y121.092 E.17706
G1 X113.367 Y120.838
G1 X109.148 Y125.056 E.1777
G1 X108.825 Y124.846
G1 X113.079 Y120.592 E.17919
G1 X112.782 Y120.356
G1 X108.472 Y124.666 E.18152
G1 X108.084 Y124.521
G1 X112.471 Y120.133 E.18482
G1 X112.152 Y119.92
G1 X107.654 Y124.418 E.18947
G1 X107.177 Y124.361
G1 X111.822 Y119.716 E.19566
G1 X111.477 Y119.528
G1 X106.626 Y124.379 E.20434
G1 X105.959 Y124.513
G1 X107.681 Y122.791 E.07254
G1 X107.021 Y122.917
G1 X104.927 Y125.011 E.08821
; WIPE_START
M204 S6000
G1 X106.341 Y123.597 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.804 Y121.668 Z2.4 F42000
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S2000
G1 X111.122 Y119.35 E.09764
G1 X110.756 Y119.182
G1 X108.922 Y121.017 E.07728
G1 X108.866 Y120.539
G1 X110.373 Y119.032 E.0635
G1 X109.978 Y118.894
G1 X108.722 Y120.15 E.0529
G1 X108.515 Y119.823
G1 X109.569 Y118.77 E.04439
G1 X109.146 Y118.66
G1 X108.257 Y119.548 E.03744
G1 X107.943 Y119.329
G1 X108.701 Y118.571 E.03191
G1 X108.238 Y118.501
G1 X107.568 Y119.171 E.02822
G1 X107.119 Y119.087
G1 X107.754 Y118.452 E.02676
G1 X107.248 Y118.424
G1 X106.527 Y119.145 E.03037
; WIPE_START
M204 S6000
G1 X107.248 Y118.424 E-.38742
G1 X107.754 Y118.452 E-.19252
G1 X107.419 Y118.787 E-.18007
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.441 Y126.35 Z2.4 F42000
G1 X109.07 Y131.001 Z2.4
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S2000
G1 X106.987 Y133.083 E.08771
G1 X106.325 Y133.212
G1 X108.048 Y131.489 E.0726
; WIPE_START
M204 S6000
G1 X106.634 Y132.903 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.76 Y137.577 Z2.4 F42000
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S2000
G1 X107.48 Y136.857 E.03032
G1 X106.89 Y136.913
G1 X106.252 Y137.552 E.0269
G1 X105.769 Y137.501
G1 X106.442 Y136.828 E.02835
G1 X106.067 Y136.669
G1 X105.309 Y137.427 E.03193
G1 X104.867 Y137.336
G1 X105.754 Y136.449 E.03735
G1 X105.496 Y136.174
G1 X104.441 Y137.229 E.04444
G1 X104.029 Y137.108
G1 X105.291 Y135.846 E.05314
G1 X105.147 Y135.457
G1 X103.637 Y136.967 E.06361
G1 X103.257 Y136.814
G1 X105.092 Y134.979 E.07729
G1 X105.214 Y134.324
G1 X102.889 Y136.648 E.09793
G1 X102.533 Y136.471
G1 X107.383 Y131.621 E.20431
G1 X106.831 Y131.639
G1 X102.191 Y136.28 E.19548
G1 X101.859 Y136.079
G1 X106.356 Y131.582 E.18944
G1 X105.926 Y131.478
G1 X101.538 Y135.867 E.18486
G1 X101.23 Y135.64
G1 X105.538 Y131.333 E.18145
G1 X105.185 Y131.152
G1 X100.931 Y135.406 E.1792
G1 X100.643 Y135.162
G1 X104.863 Y130.942 E.17776
G1 X104.568 Y130.703
G1 X100.367 Y134.904 E.17695
G1 X100.1 Y134.638
G1 X104.301 Y130.437 E.17696
G1 X104.061 Y130.144
G1 X99.843 Y134.361 E.17766
G1 X99.599 Y134.072
G1 X103.852 Y129.819 E.17914
G1 X103.674 Y129.464
G1 X99.363 Y133.775 E.18158
G1 X99.139 Y133.466
G1 X103.529 Y129.076 E.18493
G1 X103.421 Y128.65
G1 X98.927 Y133.144 E.18931
G1 X98.724 Y132.814
G1 X103.37 Y128.168 E.19571
G1 X103.385 Y127.62
G1 X98.534 Y132.471 E.20436
G1 X98.357 Y132.114
G1 X100.675 Y129.797 E.09763
G1 X100.024 Y129.915
M73 P77 R3
G1 X98.191 Y131.747 E.07719
G1 X98.037 Y131.368
G1 X99.546 Y129.859 E.06355
G1 X99.157 Y129.715
G1 X97.901 Y130.971 E.05291
G1 X97.777 Y130.561
G1 X98.83 Y129.509 E.04435
G1 X98.555 Y129.25
G1 X97.669 Y130.137 E.03733
G1 X97.576 Y129.696
G1 X98.336 Y128.936 E.032
G1 X98.178 Y128.561
G1 X97.506 Y129.233 E.02829
G1 X97.457 Y128.748
G1 X98.094 Y128.112 E.02681
G1 X98.152 Y127.52
G1 X97.432 Y128.24 E.03032
; WIPE_START
M204 S6000
G1 X98.152 Y127.52 E-.38682
G1 X98.094 Y128.112 E-.22587
G1 X97.82 Y128.386 E-.14732
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.797 Y128.674 Z2.4 F42000
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S2000
G1 X103.52 Y126.952 E.07255
G1 X104.017 Y125.921
G1 X101.924 Y128.014 E.08816
G1 X101.864 Y127.541
G1 X106.549 Y122.856 E.19734
G1 X106.154 Y122.718
G1 X101.724 Y127.148 E.18661
G1 X101.516 Y126.823
G1 X105.83 Y122.509 E.18173
G1 X105.557 Y122.248
G1 X101.255 Y126.55 E.18121
G1 X100.944 Y126.328
G1 X105.335 Y121.937 E.18495
G1 X105.178 Y121.561
G1 X100.568 Y126.17 E.19415
G1 X100.118 Y126.087
G1 X105.094 Y121.112 E.20959
G1 X105.151 Y120.522
G1 X99.528 Y126.144 E.23685
; WIPE_START
M204 S6000
G1 X100.942 Y124.73 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X97.433 Y127.706 Z2.4 F42000
G1 Z2
G1 E.8 F1800
G1 F6364.704
M204 S2000
G1 X106.714 Y118.425 E.39095
G1 X106.146 Y118.46
G1 X97.467 Y127.138 E.3656
G1 X97.542 Y126.531
G1 X105.538 Y118.535 E.33684
G1 X104.878 Y118.661
G1 X97.667 Y125.873 E.30377
G1 X97.86 Y125.146
G1 X104.15 Y118.856 E.26496
G1 X103.309 Y119.164
G1 X98.171 Y124.302 E.21642
G1 X98.688 Y123.252
G1 X102.258 Y119.682 E.15038
; WIPE_START
M204 S6000
G1 X100.843 Y121.096 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.977 Y123.809 Z2.4 F42000
G1 X114 Y126.099 Z2.4
G1 Z2
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.100651
G1 F15000
M204 S6000
G1 X113.788 Y126.016 E.00104
M204 S10000
G1 X113.268 Y126.145 F42000
; LINE_WIDTH: 0.199759
G1 F15000
M204 S6000
G1 X113.172 Y126.211 E.00145
; LINE_WIDTH: 0.171977
G1 X113.068 Y126.283 E.00129
; LINE_WIDTH: 0.141702
G1 X112.955 Y126.375 E.00114
; LINE_WIDTH: 0.101325
G1 X112.735 Y126.567 E.00135
M204 S10000
G1 X112.57 Y126.731 F42000
; LINE_WIDTH: 0.0974055
G1 F15000
M204 S6000
G1 X112.425 Y126.891 E.00093
; LINE_WIDTH: 0.125269
G1 X112.335 Y127.006 E.00095
; LINE_WIDTH: 0.172065
G2 X112.153 Y127.252 I3.088 J2.494 E.00312
; WIPE_START
G1 X112.335 Y127.006 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.083 Y129.987 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0894776
G1 F15000
M204 S6000
G1 X113.911 Y129.911 E.00069
M204 S10000
G1 X114.698 Y129.905 F42000
; LINE_WIDTH: 0.0958414
G1 F15000
M204 S6000
G1 X114.467 Y129.844 E.001
M204 S10000
G1 X114.863 Y129.713 F42000
; LINE_WIDTH: 0.103667
G1 F15000
M204 S6000
G3 X114.553 Y129.93 I-2.977 J-3.916 E.00182
; WIPE_START
G1 X114.863 Y129.713 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X116.584 Y128.203 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.100565
G1 F15000
M204 S6000
G1 X116.563 Y128.04 E.00075
M204 S10000
G1 X115.896 Y128.598 F42000
; LINE_WIDTH: 0.122393
G1 F15000
M204 S6000
G3 X115.715 Y128.861 I-3.498 J-2.217 E.002
; WIPE_START
G1 X115.896 Y128.598 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.523 Y123.177 Z2.4 F42000
G1 X106.458 Y119.076 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.137847
G1 F15000
M204 S6000
G1 X106.276 Y119.196 E.00163
; LINE_WIDTH: 0.112262
G1 X106.137 Y119.296 E.00094
; WIPE_START
G1 X106.276 Y119.196 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.103 Y120.303 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0910057
G1 F15000
M204 S6000
G1 X105.164 Y120.535 E.00091
M204 S10000
G1 X105.3 Y120.134 F42000
; LINE_WIDTH: 0.103289
G1 F15000
M204 S6000
G2 X105.078 Y120.449 I4.208 J3.194 E.00184
; WIPE_START
G1 X105.3 Y120.134 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.25 Y122.458 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0958483
G1 F15000
M204 S6000
G1 X108.114 Y122.581 E.00077
; LINE_WIDTH: 0.123427
G1 X107.993 Y122.674 E.00097
; LINE_WIDTH: 0.173024
G3 X107.747 Y122.857 I-2.633 J-3.287 E.00315
; WIPE_START
G1 X107.993 Y122.674 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.866 Y121.73 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.198908
G1 F15000
M204 S6000
G1 X108.797 Y121.83 E.0015
; LINE_WIDTH: 0.169457
G1 X108.722 Y121.938 E.0013
; LINE_WIDTH: 0.138398
G1 X108.63 Y122.051 E.0011
; LINE_WIDTH: 0.100989
G1 X108.477 Y122.23 E.00108
; WIPE_START
G1 X108.63 Y122.051 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.99 Y121.214 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.104212
G1 F15000
M204 S6000
G1 X108.908 Y121.003 E.0011
; WIPE_START
G1 X108.99 Y121.214 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.769 Y119.41 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.105177
G1 F15000
M204 S6000
G1 X102.677 Y119.477 E.00056
; LINE_WIDTH: 0.139182
G1 X102.584 Y119.543 E.00086
; LINE_WIDTH: 0.173186
G1 X102.492 Y119.61 E.00117
; LINE_WIDTH: 0.206858
G1 F14639.736
G1 X102.319 Y119.743 E.00283
; WIPE_START
G1 X102.492 Y119.61 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.432 Y120.211 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.105052
G1 F15000
M204 S6000
G1 X101.244 Y120.374 E.00122
; LINE_WIDTH: 0.138806
G1 X101.056 Y120.538 E.00189
; LINE_WIDTH: 0.179181
G1 X100.636 Y120.924 E.00614
; LINE_WIDTH: 0.2069
G1 F14635.99
G2 X99.833 Y121.733 I13.126 J13.831 E.01476
; LINE_WIDTH: 0.180225
G1 F15000
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
M204 S10000
G1 X104.867 Y124.951 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.207581
G1 F14575.427
M204 S6000
G1 X104.448 Y125.329 E.00733
G1 X104.018 Y125.788 E.00819
; LINE_WIDTH: 0.219607
G1 F13583.397
G1 X104.019 Y125.807 E.00026
; LINE_WIDTH: 0.179288
G1 F15000
G1 X104.028 Y125.932 E.00135
; WIPE_START
G1 X104.019 Y125.807 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.995 Y130.054 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.20535
G1 F14775.655
M204 S6000
G1 X110.006 Y130.198 E.00185
G1 X109.564 Y130.67 E.00829
G1 X109.13 Y131.061 E.0075
; WIPE_START
G1 X109.564 Y130.67 E-.323
G1 X110.006 Y130.198 E-.35729
G1 X109.995 Y130.054 E-.07971
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.379 Y129.547 Z2.4 F42000
G1 X101.237 Y129.471 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.090097
G1 F15000
M204 S6000
G1 X101.171 Y129.533 E.00034
; LINE_WIDTH: 0.108928
G1 X101.052 Y129.628 E.00079
; LINE_WIDTH: 0.142955
G1 X100.927 Y129.728 E.00127
; LINE_WIDTH: 0.174059
G1 X100.832 Y129.793 E.00119
; LINE_WIDTH: 0.200117
G1 X100.737 Y129.859 E.00143
; WIPE_START
G1 X100.832 Y129.793 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.864 Y128.741 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.178255
G1 F15000
M204 S6000
G1 X101.767 Y128.877 E.00179
; LINE_WIDTH: 0.158354
G1 X101.677 Y128.993 E.00134
; LINE_WIDTH: 0.121393
G1 X101.584 Y129.112 E.00094
; LINE_WIDTH: 0.0955734
G1 X101.465 Y129.243 E.00074
; WIPE_START
G1 X101.584 Y129.112 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X99.456 Y126.072 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.106359
G1 F15000
M204 S6000
G2 X99.14 Y126.293 I2.576 J4.013 E.00193
; WIPE_START
G1 X99.456 Y126.072 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X98.303 Y127.13 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.11226
G1 F15000
M204 S6000
G1 X98.203 Y127.269 E.00094
; LINE_WIDTH: 0.137841
G1 X98.083 Y127.451 E.00164
; WIPE_START
G1 X98.203 Y127.269 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X101.426 Y134.188 Z2.4 F42000
G1 X102.477 Y136.444 Z2.4
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.0980474
G1 F15000
M204 S6000
G1 X102.373 Y136.364 E.00057
; WIPE_START
G1 X102.477 Y136.444 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X107.868 Y136.709 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.124488
G1 F15000
M204 S6000
G3 X107.549 Y136.926 I-2.901 J-3.904 E.00249
; WIPE_START
G1 X107.868 Y136.709 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.936 Y135.546 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.103664
G1 F15000
M204 S6000
G3 X108.719 Y135.856 I-3.968 J-2.543 E.00182
M204 S10000
G1 X108.912 Y135.691 F42000
; LINE_WIDTH: 0.0958372
G1 F15000
M204 S6000
G1 X108.85 Y135.46 E.001
; WIPE_START
G1 X108.912 Y135.691 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.258 Y133.146 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.181657
G1 F15000
M204 S6000
G1 X106.129 Y133.239 E.00175
; LINE_WIDTH: 0.161694
G1 X106.013 Y133.329 E.00138
; LINE_WIDTH: 0.124684
G1 X105.894 Y133.422 E.00098
; LINE_WIDTH: 0.0972015
G1 X105.737 Y133.564 E.00091
M204 S10000
G1 X105.583 Y133.719 F42000
; LINE_WIDTH: 0.0915321
G1 F15000
M204 S6000
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
M204 S10000
G1 X111.681 Y136.266 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.201477
G1 F15000
M204 S6000
G1 X111.55 Y136.364 E.00205
; LINE_WIDTH: 0.16291
G1 X111.418 Y136.462 E.00155
; LINE_WIDTH: 0.124344
G1 X111.287 Y136.56 E.00105
; LINE_WIDTH: 0.0966274
G1 X111.229 Y136.6 E.0003
; WIPE_START
G1 X111.287 Y136.56 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X114.809 Y133.556 Z2.4 F42000
G1 Z2
G1 E.8 F1800
; LINE_WIDTH: 0.094634
G1 F15000
M204 S6000
G1 X114.751 Y133.626 E.00038
; LINE_WIDTH: 0.11929
G1 X114.562 Y133.841 E.00173
; LINE_WIDTH: 0.1557
G1 X114.372 Y134.056 E.00255
; LINE_WIDTH: 0.203041
G1 F14988.664
G3 X113.169 Y135.269 I-15.796 J-14.474 E.02162
; LINE_WIDTH: 0.170691
G1 F15000
G1 X112.955 Y135.46 E.00289
; LINE_WIDTH: 0.138609
G1 X112.742 Y135.65 E.00216
; LINE_WIDTH: 0.10536
G1 X112.571 Y135.794 E.0011
; CHANGE_LAYER
; Z_HEIGHT: 2.2
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X112.742 Y135.65 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 114
M625
; layer num/total_layer_count: 11/23
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
M106 S226.95
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z2.4 I.711 J.988 P1  F42000
G1 X125.378 Y126.557 Z2.4
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1279
M204 S5000
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
M73 P78 R3
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
M204 S6000
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18164
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.935 Y124.716 Z2.6 F42000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1279
M204 S6000
G1 X126.459 Y124.606 E.01571
G1 X126.447 Y124.425 E.00583
G3 X127.159 Y124.194 I1.64 J3.836 E.02409
G1 X127.256 Y124.347 E.00583
G1 X126.975 Y124.671 E.01378
M204 S10000
G1 X127.352 Y124.329 F42000
G1 F1279
M204 S6000
G1 X127.378 Y124.156 E.00561
G3 X128.13 Y124.108 I.638 J4.029 E.02428
G1 X128.183 Y124.279 E.00577
G1 X127.785 Y124.554 E.01556
G1 X127.405 Y124.357 E.01378
M204 S10000
G1 X128.288 Y124.285 F42000
G1 F1279
M204 S6000
G1 X128.358 Y124.123 E.00567
G1 X128.525 Y124.138 E.00541
G3 X129.096 Y124.263 I-.409 J3.233 E.01882
G1 X129.104 Y124.441 E.00572
G1 X128.649 Y124.608 E.01558
G1 X128.332 Y124.325 E.01368
M204 S10000
G1 X129.203 Y124.473 F42000
G1 F1279
M204 S6000
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
M204 S10000
G1 X130.203 Y125.34 Z2.6 F42000
G1 Z2.2
G1 E.8 F1800
G1 F1279
M204 S6000
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.532 J2.019 E.01456
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
M204 S10000
G1 X130.796 Y125.971 F42000
G1 F1279
M204 S6000
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01378
M204 S10000
G1 X131.213 Y126.729 F42000
G1 F1279
M204 S6000
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00562
G1 X131.513 Y126.308 E.00327
G3 X131.745 Y126.92 I-3.418 J1.646 E.02106
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
M204 S10000
G1 X131.428 Y127.567 F42000
G1 F1279
M204 S6000
G1 X131.624 Y127.123 E.01561
G1 X131.799 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.845 J.869 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
M204 S10000
G1 X131.428 Y128.433 F42000
G1 F1279
M204 S6000
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.8 Y128.86 I-3.943 J-.123 E.0242
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
M204 S10000
G1 X131.212 Y129.271 F42000
G1 F1279
M204 S6000
G1 X131.598 Y128.977 E.01561
G1 X131.745 Y129.08 E.00578
G3 X131.465 Y129.781 I-4.024 J-1.201 E.02431
G1 X131.293 Y129.753 E.00562
G1 X131.222 Y129.33 E.01378
M204 S10000
G1 X130.796 Y130.029 F42000
G1 F1279
M204 S6000
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
M204 S10000
G1 X130.12 Y130.897 Z2.6 F42000
G1 Z2.2
G1 E.8 F1800
G1 F1279
M204 S6000
G1 X130.203 Y130.66 E.00805
G1 X130.686 Y130.588 E.01571
G1 X130.766 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.958 J-2.963 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.1 Y130.953 E.00563
M204 S10000
G1 X129.741 Y131.152 F42000
G1 F1279
M204 S6000
G1 X129.955 Y131.174 E.00694
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.085 J-3.54 E.0242
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00674
M204 S10000
G1 X128.81 Y131.451 F42000
G1 F1279
M204 S6000
G1 X129.104 Y131.559 E.01005
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.101 J-3.786 E.0242
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.0036
M204 S10000
G1 X127.785 Y131.446 F42000
G1 F1279
M204 S6000
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.186 E.02431
G1 X127.352 Y131.671 E.00561
G1 X127.732 Y131.474 E.01378
M204 S10000
G1 X126.935 Y131.284 F42000
G1 F1279
M204 S6000
G1 X127.256 Y131.653 E.01571
G1 X127.159 Y131.806 E.00583
G3 X126.449 Y131.574 I.887 J-3.915 E.02405
G1 X126.461 Y131.394 E.00582
G1 X126.877 Y131.297 E.01372
M204 S10000
G1 X126.152 Y130.915 F42000
G1 F1279
M204 S6000
G1 X126.37 Y131.352 E.01571
G1 X126.248 Y131.477 E.00562
G3 X125.609 Y131.074 I1.906 J-3.732 E.02431
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
M204 S10000
G1 X125.485 Y130.364 F42000
G1 F1279
M204 S6000
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.599 J-2.961 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
M204 S10000
G1 X124.977 Y129.663 F42000
G1 F1279
M204 S6000
G1 X124.958 Y130.146 E.01554
G1 X124.786 Y130.194 E.00573
G3 X124.425 Y129.536 I3.211 J-2.191 E.02416
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
M204 S10000
G1 X124.658 Y128.859 F42000
G1 F1279
M204 S6000
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G3 X124.154 Y128.594 I3.957 J-1.393 E.02431
G1 X124.31 Y128.516 E.00562
G1 X124.615 Y128.817 E.01378
M204 S10000
G1 X124.549 Y128 F42000
G1 F1279
M204 S6000
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
M204 S10000
G1 X124.658 Y127.141 F42000
G1 F1279
M204 S6000
G1 X124.31 Y127.484 E.01571
G1 X124.154 Y127.406 E.00561
G3 X124.339 Y126.674 I4.131 J.658 E.02431
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
M204 S10000
G1 X124.977 Y126.337 F42000
G1 F1279
M204 S6000
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.621 J1.558 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
M204 S10000
G1 X125.485 Y125.636 F42000
G1 F1279
M204 S6000
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.116 J2.416 E.0242
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
M204 S10000
G1 X126.152 Y125.085 F42000
G1 F1279
M204 S6000
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
M204 S10000
G1 X123.725 Y128.385 Z2.6 F42000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1279
M204 S5000
G3 X127.809 Y123.715 I4.27 J-.387 E.20661
G1 X128.21 Y123.716 E.01194
G3 X123.731 Y128.445 I-.215 J4.282 E.58207
; OBJECT_ID: 114
; WIPE_START
G1 F6364.704
M204 S6000
G1 X123.712 Y128 E-.16908
G1 X123.73 Y127.615 E-.14626
G1 X123.781 Y127.234 E-.14628
G1 X123.867 Y126.859 E-.14627
G1 X123.986 Y126.493 E-.1463
G1 X123.992 Y126.479 E-.00582
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S10000
G1 X116.36 Y126.509 Z2.6 F42000
G1 X104.382 Y126.557 Z2.6
G1 Z2.2
G1 E.8 F1800
G1 F1279
M204 S5000
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
M204 S6000
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18164
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.94 Y124.716 Z2.6 F42000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1279
M204 S6000
G1 X105.464 Y124.606 E.01571
G1 X105.452 Y124.425 E.00583
G3 X106.163 Y124.194 I1.64 J3.836 E.02409
G1 X106.26 Y124.347 E.00583
G1 X105.979 Y124.671 E.01378
M204 S10000
G1 X106.356 Y124.329 F42000
G1 F1279
M204 S6000
G1 X106.383 Y124.156 E.00561
G3 X107.135 Y124.108 I.638 J4.029 E.02428
G1 X107.188 Y124.279 E.00577
G1 X106.79 Y124.554 E.01556
G1 X106.41 Y124.357 E.01378
M204 S10000
G1 X107.292 Y124.285 F42000
G1 F1279
M204 S6000
G1 X107.362 Y124.123 E.00567
G1 X107.53 Y124.138 E.00541
G3 X108.101 Y124.263 I-.409 J3.233 E.01882
G1 X108.108 Y124.441 E.00572
G1 X107.654 Y124.608 E.01558
G1 X107.337 Y124.325 E.01368
M204 S10000
G1 X108.208 Y124.473 F42000
G1 F1279
M204 S6000
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
M204 S10000
G1 X109.208 Y125.34 Z2.6 F42000
G1 Z2.2
G1 E.8 F1800
G1 F1279
M204 S6000
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.532 J2.019 E.01456
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
M204 S10000
G1 X109.8 Y125.971 F42000
G1 F1279
M204 S6000
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01378
M204 S10000
G1 X110.217 Y126.729 F42000
G1 F1279
M204 S6000
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00562
G1 X110.518 Y126.308 E.00327
G3 X110.749 Y126.92 I-3.418 J1.646 E.02106
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
M204 S10000
G1 X110.432 Y127.567 F42000
G1 F1279
M204 S6000
G1 X110.628 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.845 J.869 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
M204 S10000
G1 X110.432 Y128.433 F42000
G1 F1279
M204 S6000
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.943 J-.123 E.0242
G1 X110.629 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
M204 S10000
G1 X110.217 Y129.271 F42000
G1 F1279
M204 S6000
G1 X110.603 Y128.977 E.01561
G1 X110.749 Y129.08 E.00578
G3 X110.469 Y129.781 I-4.024 J-1.201 E.02431
G1 X110.297 Y129.753 E.00562
G1 X110.227 Y129.33 E.01378
M204 S10000
G1 X109.8 Y130.029 F42000
G1 F1279
M204 S6000
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
G1 X109.79 Y130.149 E-.1402
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X109.125 Y130.897 Z2.6 F42000
G1 Z2.2
G1 E.8 F1800
G1 F1279
M204 S6000
G1 X109.208 Y130.66 E.00805
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.958 J-2.963 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.105 Y130.953 E.00563
M204 S10000
G1 X108.745 Y131.152 F42000
G1 F1279
M204 S6000
G1 X108.96 Y131.174 E.00694
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.085 J-3.54 E.0242
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.685 Y131.145 E.00674
M204 S10000
G1 X107.815 Y131.451 F42000
G1 F1279
M204 S6000
G1 X108.108 Y131.559 E.01005
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.101 J-3.786 E.0242
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.759 Y131.43 E.0036
M204 S10000
G1 X106.79 Y131.446 F42000
G1 F1279
M204 S6000
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.186 E.02431
M73 P79 R3
G1 X106.356 Y131.671 E.00561
G1 X106.737 Y131.474 E.01378
M204 S10000
G1 X105.94 Y131.284 F42000
G1 F1279
M204 S6000
G1 X106.26 Y131.653 E.01571
G1 X106.163 Y131.806 E.00583
G3 X105.454 Y131.574 I.887 J-3.915 E.02405
G1 X105.466 Y131.394 E.00582
G1 X105.881 Y131.297 E.01372
M204 S10000
G1 X105.157 Y130.915 F42000
G1 F1279
M204 S6000
G1 X105.375 Y131.352 E.01571
G1 X105.252 Y131.477 E.00562
G3 X104.614 Y131.074 I1.906 J-3.732 E.02431
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
M204 S10000
G1 X104.49 Y130.364 F42000
G1 F1279
M204 S6000
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.599 J-2.961 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
M204 S10000
G1 X103.981 Y129.663 F42000
G1 F1279
M204 S6000
G1 X103.962 Y130.146 E.01554
G1 X103.79 Y130.194 E.00573
G3 X103.429 Y129.536 I3.211 J-2.191 E.02416
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
M204 S10000
G1 X103.662 Y128.859 F42000
G1 F1279
M204 S6000
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G3 X103.158 Y128.594 I3.957 J-1.393 E.02431
G1 X103.314 Y128.516 E.00562
G1 X103.62 Y128.817 E.01378
M204 S10000
G1 X103.554 Y128 F42000
G1 F1279
M204 S6000
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
M204 S10000
G1 X103.662 Y127.141 F42000
G1 F1279
M204 S6000
G1 X103.314 Y127.484 E.01571
G1 X103.158 Y127.406 E.00561
G3 X103.344 Y126.674 I4.131 J.658 E.02431
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
M204 S10000
G1 X103.981 Y126.337 F42000
G1 F1279
M204 S6000
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.621 J1.558 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
M204 S10000
G1 X104.49 Y125.636 F42000
G1 F1279
M204 S6000
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.116 J2.416 E.0242
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
M204 S10000
G1 X105.157 Y125.085 F42000
G1 F1279
M204 S6000
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
M204 S10000
G1 X102.73 Y128.385 Z2.6 F42000
G1 Z2.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1279
M204 S5000
G3 X106.814 Y123.715 I4.27 J-.387 E.20661
G1 X107.215 Y123.716 E.01194
G3 X102.735 Y128.445 I-.215 J4.282 E.58207
; WIPE_START
G1 F6364.704
M204 S6000
G1 X102.717 Y128 E-.16908
G1 X102.734 Y127.615 E-.14626
G1 X102.786 Y127.234 E-.14627
G1 X102.872 Y126.859 E-.14627
G1 X102.99 Y126.493 E-.1463
G1 X102.997 Y126.479 E-.00582
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z2.6 I1.217 J0 P1  F42000
; stop printing object, unique label id: 114
M625
; object ids of layer 11 start: 78,114
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


; object ids of this layer11 end: 78,114
M625
; CHANGE_LAYER
; Z_HEIGHT: 2.4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 12/23
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F42000
G1 Z2.4
G1 E.8 F1800
G1 F1299
M204 S5000
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
M204 S6000
G1 X125.359 Y126.079 E-.19337
G1 X125.819 Y125.95 E-.18163
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.785 Y124.554 Z2.8 F42000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1299
M204 S6000
G1 X127.352 Y124.329 E.01571
G1 X127.378 Y124.156 E.00562
G3 X128.131 Y124.107 I.651 J4.142 E.02431
G1 X128.185 Y124.278 E.00578
G1 X127.835 Y124.52 E.01368
M204 S10000
G1 X128.288 Y124.285 F42000
G1 F1299
M204 S6000
G1 X128.358 Y124.123 E.00567
G1 X128.525 Y124.138 E.00541
G3 X129.096 Y124.263 I-.409 J3.235 E.01882
G1 X129.104 Y124.441 E.00572
G1 X128.649 Y124.608 E.01558
G1 X128.332 Y124.325 E.01368
M204 S10000
G1 X129.203 Y124.473 F42000
G1 F1299
M204 S6000
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
M204 S10000
G1 X130.203 Y125.34 Z2.8 F42000
G1 Z2.4
G1 E.8 F1800
G1 F1299
M204 S6000
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.532 J2.019 E.01455
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
M204 S10000
G1 X130.796 Y125.971 F42000
G1 F1299
M204 S6000
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01378
M204 S10000
G1 X131.213 Y126.729 F42000
G1 F1299
M204 S6000
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00562
G1 X131.514 Y126.309 E.0033
G3 X131.745 Y126.92 I-3.278 J1.591 E.02103
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
M204 S10000
G1 X131.428 Y127.567 F42000
G1 F1299
M204 S6000
G1 X131.624 Y127.123 E.01561
G1 X131.799 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.847 J.869 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
M204 S10000
G1 X131.428 Y128.433 F42000
G1 F1299
M204 S6000
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.8 Y128.86 I-3.942 J-.123 E.0242
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
M204 S10000
G1 X131.213 Y129.271 F42000
G1 F1299
M204 S6000
G1 X131.598 Y128.977 E.01561
G1 X131.745 Y129.08 E.00578
G3 X131.465 Y129.781 I-4.018 J-1.199 E.02431
G1 X131.293 Y129.753 E.00562
G1 X131.222 Y129.33 E.01378
M204 S10000
G1 X130.796 Y130.029 F42000
G1 F1299
M204 S6000
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
M204 S10000
G1 X130.131 Y130.864 Z2.8 F42000
G1 Z2.4
G1 E.8 F1800
G1 F1299
M204 S6000
G1 X130.203 Y130.66 E.00695
G1 X130.686 Y130.588 E.01571
G1 X130.767 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.965 J-2.973 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.112 Y130.921 E.00673
M204 S10000
G1 X129.741 Y131.152 F42000
G1 F1299
M204 S6000
G1 X129.955 Y131.174 E.00694
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.013 J-3.386 E.0242
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00675
M204 S10000
G1 X128.81 Y131.451 F42000
G1 F1299
M204 S6000
G1 X129.104 Y131.559 E.01005
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.1 J-3.781 E.0242
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.00359
M204 S10000
G1 X127.785 Y131.446 F42000
G1 F1299
M204 S6000
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.194 E.02431
G1 X127.352 Y131.671 E.00562
G1 X127.732 Y131.474 E.01378
M204 S10000
G1 X126.935 Y131.284 F42000
G1 F1299
M204 S6000
G1 X127.256 Y131.653 E.01572
G1 X127.159 Y131.806 E.00583
G3 X126.447 Y131.575 I.928 J-4.067 E.02409
G1 X126.459 Y131.394 E.00583
G1 X126.877 Y131.297 E.01379
M204 S10000
G1 X126.152 Y130.915 F42000
G1 F1299
M204 S6000
G1 X126.37 Y131.352 E.01571
G1 X126.248 Y131.477 E.00562
G3 X125.609 Y131.074 I1.907 J-3.732 E.02431
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
M204 S10000
G1 X125.485 Y130.364 F42000
G1 F1299
M204 S6000
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.599 J-2.961 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
M204 S10000
G1 X124.977 Y129.663 F42000
G1 F1299
M204 S6000
G1 X124.958 Y130.147 E.01558
G1 X124.786 Y130.195 E.00572
G3 X124.425 Y129.536 I3.258 J-2.215 E.0242
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
M204 S10000
G1 X124.658 Y128.859 F42000
G1 F1299
M204 S6000
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G3 X124.154 Y128.594 I3.947 J-1.39 E.02431
G1 X124.31 Y128.516 E.00561
G1 X124.615 Y128.817 E.01378
M204 S10000
G1 X124.549 Y128 F42000
G1 F1299
M204 S6000
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
M204 S10000
G1 X124.658 Y127.141 F42000
G1 F1299
M204 S6000
G1 X124.31 Y127.484 E.01571
G1 X124.154 Y127.406 E.00561
G3 X124.339 Y126.674 I4.128 J.657 E.02431
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
M204 S10000
G1 X124.977 Y126.337 F42000
G1 F1299
M204 S6000
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.62 J1.557 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
M204 S10000
G1 X125.485 Y125.636 F42000
G1 F1299
M204 S6000
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.114 J2.414 E.0242
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
M204 S10000
G1 X126.152 Y125.085 F42000
G1 F1299
M204 S6000
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.523 I2.548 J3.335 E.02431
G1 X126.37 Y124.648 E.00562
G1 X126.179 Y125.031 E.01378
M204 S10000
G1 X126.935 Y124.716 F42000
G1 F1299
M204 S6000
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
M204 S10000
G1 X123.723 Y128.385 Z2.8 F42000
G1 Z2.4
M73 P80 R3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1299
M204 S5000
G3 X127.426 Y123.749 I4.271 J-.386 E.19518
G3 X128.234 Y123.718 I.61 J5.358 E.02408
G3 X123.729 Y128.445 I-.24 J4.281 E.58144
; OBJECT_ID: 114
; WIPE_START
G1 F6364.704
M204 S6000
G1 X123.712 Y128 E-.16911
G1 X123.73 Y127.615 E-.14626
G1 X123.781 Y127.234 E-.14627
G1 X123.867 Y126.859 E-.1463
G1 X123.986 Y126.493 E-.14627
G1 X123.992 Y126.479 E-.00579
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S10000
G1 X116.36 Y126.509 Z2.8 F42000
G1 X104.382 Y126.557 Z2.8
G1 Z2.4
G1 E.8 F1800
G1 F1299
M204 S5000
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
M204 S6000
G1 X104.363 Y126.079 E-.19337
G1 X104.823 Y125.95 E-.18163
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.79 Y124.554 Z2.8 F42000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1299
M204 S6000
G1 X106.356 Y124.329 E.01571
G1 X106.383 Y124.156 E.00562
G3 X107.136 Y124.107 I.651 J4.142 E.02431
G1 X107.189 Y124.278 E.00578
G1 X106.839 Y124.52 E.01368
M204 S10000
G1 X107.292 Y124.285 F42000
G1 F1299
M204 S6000
G1 X107.362 Y124.123 E.00567
G1 X107.53 Y124.138 E.00541
G3 X108.101 Y124.263 I-.409 J3.235 E.01882
G1 X108.108 Y124.441 E.00572
G1 X107.654 Y124.608 E.01558
G1 X107.337 Y124.325 E.01368
M204 S10000
G1 X108.208 Y124.473 F42000
G1 F1299
M204 S6000
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
M204 S10000
G1 X109.208 Y125.34 Z2.8 F42000
G1 Z2.4
G1 E.8 F1800
G1 F1299
M204 S6000
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.532 J2.019 E.01455
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
M204 S10000
G1 X109.8 Y125.971 F42000
G1 F1299
M204 S6000
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01378
M204 S10000
G1 X110.217 Y126.729 F42000
G1 F1299
M204 S6000
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00562
G1 X110.518 Y126.309 E.0033
G3 X110.749 Y126.92 I-3.278 J1.591 E.02103
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
M204 S10000
G1 X110.432 Y127.567 F42000
G1 F1299
M204 S6000
G1 X110.628 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.847 J.869 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
M204 S10000
G1 X110.432 Y128.433 F42000
G1 F1299
M204 S6000
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.942 J-.123 E.0242
G1 X110.629 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
M204 S10000
G1 X110.217 Y129.271 F42000
G1 F1299
M204 S6000
G1 X110.603 Y128.977 E.01561
G1 X110.749 Y129.08 E.00578
G3 X110.469 Y129.781 I-4.018 J-1.199 E.02431
G1 X110.297 Y129.753 E.00562
G1 X110.227 Y129.33 E.01378
M204 S10000
G1 X109.8 Y130.029 F42000
G1 F1299
M204 S6000
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
M204 S10000
G1 X109.136 Y130.864 Z2.8 F42000
G1 Z2.4
G1 E.8 F1800
G1 F1299
M204 S6000
G1 X109.208 Y130.66 E.00695
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.965 J-2.973 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.116 Y130.921 E.00673
M204 S10000
G1 X108.745 Y131.152 F42000
G1 F1299
M204 S6000
G1 X108.96 Y131.174 E.00694
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.013 J-3.386 E.0242
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.686 Y131.145 E.00675
M204 S10000
G1 X107.815 Y131.451 F42000
G1 F1299
M204 S6000
G1 X108.108 Y131.559 E.01005
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.1 J-3.781 E.0242
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.759 Y131.43 E.00359
M204 S10000
G1 X106.79 Y131.446 F42000
G1 F1299
M204 S6000
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.194 E.02431
G1 X106.356 Y131.671 E.00562
G1 X106.737 Y131.474 E.01378
M204 S10000
G1 X105.94 Y131.284 F42000
G1 F1299
M204 S6000
G1 X106.26 Y131.653 E.01572
G1 X106.163 Y131.806 E.00583
G3 X105.452 Y131.575 I.928 J-4.067 E.02409
G1 X105.464 Y131.394 E.00583
G1 X105.881 Y131.297 E.01379
M204 S10000
G1 X105.157 Y130.915 F42000
G1 F1299
M204 S6000
G1 X105.375 Y131.352 E.01571
G1 X105.252 Y131.477 E.00562
G3 X104.614 Y131.074 I1.907 J-3.732 E.02431
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
M204 S10000
M73 P80 R2
G1 X104.49 Y130.364 F42000
G1 F1299
M204 S6000
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.599 J-2.961 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
M204 S10000
G1 X103.981 Y129.663 F42000
G1 F1299
M204 S6000
G1 X103.962 Y130.147 E.01558
G1 X103.791 Y130.195 E.00572
G3 X103.429 Y129.536 I3.258 J-2.215 E.0242
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
M204 S10000
G1 X103.662 Y128.859 F42000
G1 F1299
M204 S6000
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G3 X103.158 Y128.594 I3.947 J-1.39 E.02431
G1 X103.314 Y128.516 E.00561
G1 X103.62 Y128.817 E.01378
M204 S10000
G1 X103.554 Y128 F42000
G1 F1299
M204 S6000
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
M204 S10000
G1 X103.662 Y127.141 F42000
G1 F1299
M204 S6000
G1 X103.314 Y127.484 E.01571
G1 X103.158 Y127.406 E.00561
G3 X103.344 Y126.674 I4.128 J.657 E.02431
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
M204 S10000
G1 X103.981 Y126.337 F42000
G1 F1299
M204 S6000
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.62 J1.557 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
M204 S10000
G1 X104.49 Y125.636 F42000
G1 F1299
M204 S6000
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.114 J2.414 E.0242
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
M204 S10000
G1 X105.157 Y125.085 F42000
G1 F1299
M204 S6000
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.523 I2.548 J3.335 E.02431
G1 X105.375 Y124.648 E.00562
G1 X105.183 Y125.031 E.01378
M204 S10000
G1 X105.94 Y124.716 F42000
G1 F1299
M204 S6000
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
M204 S10000
G1 X102.728 Y128.385 Z2.8 F42000
G1 Z2.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1299
M204 S5000
G3 X106.431 Y123.749 I4.271 J-.386 E.19518
G3 X107.238 Y123.718 I.61 J5.358 E.02408
G3 X102.734 Y128.445 I-.24 J4.281 E.58144
; WIPE_START
G1 F6364.704
M204 S6000
G1 X102.717 Y128 E-.16911
G1 X102.734 Y127.615 E-.14626
G1 X102.786 Y127.234 E-.14627
G1 X102.872 Y126.859 E-.14629
G1 X102.99 Y126.493 E-.14627
G1 X102.996 Y126.479 E-.00579
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z2.8 I1.217 J0 P1  F42000
; stop printing object, unique label id: 114
M625
; object ids of layer 12 start: 78,114
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


; object ids of this layer12 end: 78,114
M625
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 13/23
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F42000
G1 Z2.6
G1 E.8 F1800
G1 F1274
M204 S5000
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
M73 P81 R2
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
M204 S6000
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18164
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.785 Y124.554 Z3 F42000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1274
M204 S6000
G1 X127.352 Y124.329 E.01571
G1 X127.378 Y124.156 E.00562
G3 X128.131 Y124.107 I.651 J4.139 E.02431
G1 X128.185 Y124.278 E.00578
G1 X127.835 Y124.52 E.01368
M204 S10000
G1 X128.288 Y124.285 F42000
G1 F1274
M204 S6000
G1 X128.358 Y124.123 E.00567
G1 X128.525 Y124.138 E.00541
G3 X129.096 Y124.263 I-.409 J3.234 E.01882
G1 X129.104 Y124.441 E.00572
G1 X128.649 Y124.608 E.01558
G1 X128.332 Y124.325 E.01368
M204 S10000
G1 X129.22 Y124.499 F42000
G1 F1274
M204 S6000
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
M204 S10000
G1 X130.203 Y125.34 Z3 F42000
G1 Z2.6
G1 E.8 F1800
G1 F1274
M204 S6000
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.527 J2.014 E.01456
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
M204 S10000
G1 X130.796 Y125.971 F42000
G1 F1274
M204 S6000
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01378
M204 S10000
G1 X131.212 Y126.729 F42000
G1 F1274
M204 S6000
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00562
G1 X131.514 Y126.309 E.0033
G1 X131.535 Y126.358 E.00173
G3 X131.745 Y126.92 I-3.015 J1.449 E.0193
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
M204 S10000
G1 X131.428 Y127.567 F42000
G1 F1274
M204 S6000
G1 X131.624 Y127.123 E.01561
G1 X131.799 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.846 J.869 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
M204 S10000
G1 X131.428 Y128.433 F42000
G1 F1274
M204 S6000
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.8 Y128.86 I-3.942 J-.123 E.0242
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
M204 S10000
G1 X131.213 Y129.271 F42000
G1 F1274
M204 S6000
G1 X131.598 Y128.977 E.01561
G1 X131.745 Y129.08 E.00578
G3 X131.465 Y129.781 I-4.023 J-1.201 E.0243
G1 X131.293 Y129.753 E.00562
G1 X131.222 Y129.33 E.01378
M204 S10000
G1 X130.796 Y130.029 F42000
G1 F1274
M204 S6000
G1 X131.246 Y129.839 E.01571
G1 X131.362 Y129.978 E.00583
G3 X130.922 Y130.584 I-3.582 J-2.14 E.02409
G1 X130.753 Y130.516 E.00583
G1 X130.79 Y130.089 E.01378
M204 S10000
G1 X130.143 Y130.831 F42000
G1 F1274
M204 S6000
G1 X130.203 Y130.66 E.00583
G1 X130.686 Y130.588 E.01571
G1 X130.767 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.962 J-2.968 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.123 Y130.888 E.00785
M204 S10000
G1 X129.741 Y131.152 F42000
G1 F1274
M204 S6000
G1 X129.955 Y131.174 E.00694
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.015 J-3.39 E.0242
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00674
M204 S10000
G1 X128.81 Y131.451 F42000
G1 F1274
M204 S6000
G1 X129.104 Y131.559 E.01005
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.101 J-3.785 E.0242
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.00359
M204 S10000
G1 X127.785 Y131.446 F42000
G1 F1274
M204 S6000
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.186 E.02431
G1 X127.352 Y131.671 E.00561
G1 X127.732 Y131.474 E.01378
M204 S10000
G1 X126.935 Y131.284 F42000
G1 F1274
M204 S6000
G1 X127.256 Y131.653 E.01571
G1 X127.159 Y131.806 E.00583
G3 X126.447 Y131.575 I.929 J-4.069 E.02409
G1 X126.459 Y131.394 E.00583
G1 X126.877 Y131.297 E.01379
M204 S10000
G1 X126.152 Y130.915 F42000
G1 F1274
M204 S6000
G1 X126.37 Y131.352 E.0157
G1 X126.248 Y131.476 E.00561
G3 X125.609 Y131.074 I1.902 J-3.725 E.02431
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
M204 S10000
G1 X125.485 Y130.364 F42000
G1 F1274
M204 S6000
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.599 J-2.961 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
M204 S10000
G1 X124.977 Y129.663 F42000
G1 F1274
M204 S6000
G1 X124.958 Y130.147 E.01558
G1 X124.786 Y130.195 E.00572
G3 X124.425 Y129.536 I3.258 J-2.216 E.0242
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
M204 S10000
G1 X124.658 Y128.859 F42000
G1 F1274
M204 S6000
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G3 X124.154 Y128.594 I3.954 J-1.392 E.02431
G1 X124.31 Y128.516 E.00562
G1 X124.615 Y128.817 E.01378
M204 S10000
G1 X124.549 Y128 F42000
G1 F1274
M204 S6000
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
M204 S10000
G1 X124.658 Y127.141 F42000
G1 F1274
M204 S6000
G1 X124.31 Y127.484 E.01571
G1 X124.154 Y127.406 E.00561
G3 X124.339 Y126.674 I4.131 J.658 E.02431
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
M204 S10000
G1 X124.977 Y126.337 F42000
G1 F1274
M204 S6000
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.619 J1.557 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
M204 S10000
G1 X125.485 Y125.636 F42000
G1 F1274
M204 S6000
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.114 J2.414 E.0242
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
M204 S10000
G1 X126.152 Y125.085 F42000
G1 F1274
M204 S6000
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.523 I2.548 J3.335 E.02431
G1 X126.37 Y124.648 E.00562
G1 X126.179 Y125.031 E.01378
M204 S10000
G1 X126.935 Y124.716 F42000
G1 F1274
M204 S6000
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
M204 S10000
G1 X123.733 Y128.384 Z3 F42000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1274
M204 S5000
G3 X128.266 Y123.721 I4.273 J-.381 E.21984
G3 X123.772 Y128.695 I-.264 J4.278 E.57298
G3 X123.738 Y128.444 I4.234 J-.692 E.00756
; OBJECT_ID: 114
; WIPE_START
G1 F6364.704
M204 S6000
G1 X123.712 Y128 E-.16895
G1 X123.73 Y127.615 E-.14627
G1 X123.781 Y127.234 E-.14628
G1 X123.867 Y126.859 E-.14627
G1 X123.986 Y126.493 E-.14627
G1 X123.992 Y126.478 E-.00597
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S10000
G1 X116.36 Y126.509 Z3 F42000
G1 X104.382 Y126.557 Z3
G1 Z2.6
G1 E.8 F1800
G1 F1274
M204 S5000
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
M204 S6000
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18164
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.79 Y124.554 Z3 F42000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1274
M204 S6000
G1 X106.356 Y124.329 E.01571
G1 X106.383 Y124.156 E.00562
G3 X107.136 Y124.107 I.651 J4.139 E.02431
G1 X107.189 Y124.278 E.00578
G1 X106.839 Y124.52 E.01368
M204 S10000
G1 X107.292 Y124.285 F42000
G1 F1274
M204 S6000
G1 X107.362 Y124.123 E.00567
G1 X107.53 Y124.138 E.00541
G3 X108.101 Y124.263 I-.409 J3.234 E.01882
G1 X108.108 Y124.441 E.00572
G1 X107.654 Y124.608 E.01558
G1 X107.337 Y124.325 E.01368
M204 S10000
G1 X108.225 Y124.499 F42000
G1 F1274
M204 S6000
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
M204 S10000
G1 X109.208 Y125.34 Z3 F42000
G1 Z2.6
G1 E.8 F1800
G1 F1274
M204 S6000
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.527 J2.014 E.01456
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
M204 S10000
G1 X109.8 Y125.971 F42000
G1 F1274
M204 S6000
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01378
M204 S10000
G1 X110.217 Y126.729 F42000
G1 F1274
M204 S6000
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00562
G1 X110.518 Y126.309 E.0033
G1 X110.539 Y126.358 E.00173
G3 X110.749 Y126.92 I-3.015 J1.449 E.0193
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
M204 S10000
G1 X110.432 Y127.567 F42000
G1 F1274
M204 S6000
G1 X110.628 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.846 J.869 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
M204 S10000
G1 X110.432 Y128.433 F42000
G1 F1274
M204 S6000
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.942 J-.123 E.0242
G1 X110.629 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
M204 S10000
G1 X110.217 Y129.271 F42000
G1 F1274
M204 S6000
G1 X110.603 Y128.977 E.01561
G1 X110.749 Y129.08 E.00578
G3 X110.469 Y129.781 I-4.023 J-1.201 E.0243
G1 X110.297 Y129.753 E.00562
G1 X110.227 Y129.33 E.01378
M204 S10000
G1 X109.8 Y130.029 F42000
G1 F1274
M204 S6000
G1 X110.25 Y129.839 E.01571
G1 X110.366 Y129.978 E.00583
G3 X109.926 Y130.584 I-3.582 J-2.14 E.02409
G1 X109.758 Y130.516 E.00583
G1 X109.795 Y130.089 E.01378
M204 S10000
G1 X109.147 Y130.831 F42000
G1 F1274
M204 S6000
G1 X109.208 Y130.66 E.00583
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.962 J-2.968 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.128 Y130.888 E.00785
M204 S10000
G1 X108.745 Y131.152 F42000
G1 F1274
M204 S6000
G1 X108.96 Y131.174 E.00694
G1 X108.998 Y131.346 E.00567
M73 P82 R2
G3 X108.318 Y131.666 I-2.015 J-3.39 E.0242
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.685 Y131.145 E.00674
M204 S10000
G1 X107.815 Y131.451 F42000
G1 F1274
M204 S6000
G1 X108.108 Y131.559 E.01005
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.101 J-3.785 E.0242
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.759 Y131.43 E.00359
M204 S10000
G1 X106.79 Y131.446 F42000
G1 F1274
M204 S6000
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.186 E.02431
G1 X106.357 Y131.671 E.00561
G1 X106.737 Y131.474 E.01378
M204 S10000
G1 X105.94 Y131.284 F42000
G1 F1274
M204 S6000
G1 X106.26 Y131.653 E.01571
G1 X106.163 Y131.806 E.00583
G3 X105.452 Y131.575 I.929 J-4.069 E.02409
G1 X105.464 Y131.394 E.00583
G1 X105.881 Y131.297 E.01379
M204 S10000
G1 X105.157 Y130.915 F42000
G1 F1274
M204 S6000
G1 X105.375 Y131.352 E.0157
G1 X105.252 Y131.476 E.00561
G3 X104.614 Y131.074 I1.902 J-3.725 E.02431
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
M204 S10000
G1 X104.49 Y130.364 F42000
G1 F1274
M204 S6000
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.599 J-2.961 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
M204 S10000
G1 X103.981 Y129.663 F42000
G1 F1274
M204 S6000
G1 X103.962 Y130.147 E.01558
G1 X103.791 Y130.195 E.00572
G3 X103.429 Y129.536 I3.258 J-2.216 E.0242
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
M204 S10000
G1 X103.662 Y128.859 F42000
G1 F1274
M204 S6000
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G3 X103.158 Y128.594 I3.954 J-1.392 E.02431
G1 X103.314 Y128.516 E.00562
G1 X103.62 Y128.817 E.01378
M204 S10000
G1 X103.554 Y128 F42000
G1 F1274
M204 S6000
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
M204 S10000
G1 X103.662 Y127.141 F42000
G1 F1274
M204 S6000
G1 X103.314 Y127.484 E.01571
G1 X103.158 Y127.406 E.00561
G3 X103.344 Y126.674 I4.131 J.658 E.02431
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
M204 S10000
G1 X103.981 Y126.337 F42000
G1 F1274
M204 S6000
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.619 J1.557 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
M204 S10000
G1 X104.49 Y125.636 F42000
G1 F1274
M204 S6000
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.114 J2.414 E.0242
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
M204 S10000
G1 X105.157 Y125.085 F42000
G1 F1274
M204 S6000
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.523 I2.548 J3.335 E.02431
G1 X105.375 Y124.648 E.00562
G1 X105.183 Y125.031 E.01378
M204 S10000
G1 X105.94 Y124.716 F42000
G1 F1274
M204 S6000
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
M204 S10000
G1 X102.737 Y128.384 Z3 F42000
G1 Z2.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1274
M204 S5000
G3 X107.27 Y123.721 I4.273 J-.381 E.21984
G3 X102.776 Y128.695 I-.264 J4.278 E.57298
G3 X102.743 Y128.444 I4.234 J-.692 E.00756
; WIPE_START
G1 F6364.704
M204 S6000
G1 X102.717 Y128 E-.16895
G1 X102.734 Y127.615 E-.14626
G1 X102.786 Y127.234 E-.14627
G1 X102.872 Y126.859 E-.14627
G1 X102.99 Y126.493 E-.14627
G1 X102.997 Y126.478 E-.00597
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3 I1.217 J0 P1  F42000
; stop printing object, unique label id: 114
M625
; object ids of layer 13 start: 78,114
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


; object ids of this layer13 end: 78,114
M625
; CHANGE_LAYER
; Z_HEIGHT: 2.8
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 14/23
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F42000
G1 Z2.8
G1 E.8 F1800
G1 F1276
M204 S5000
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
G1 X124.761 Y128.41 E.01424
G1 X125.007 Y128 E.01424
G1 X124.761 Y127.59 E.01424
G1 X125.101 Y127.255 E.01424
G1 X124.964 Y126.797 E.01424
G1 X125.326 Y126.587 E.01245
; WIPE_START
G1 F6364.704
M204 S6000
G1 X125.359 Y126.079 E-.19337
G1 X125.819 Y125.95 E-.18163
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.785 Y124.554 Z3.2 F42000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1276
M204 S6000
G1 X127.352 Y124.329 E.01571
G1 X127.378 Y124.156 E.00561
G3 X128.131 Y124.107 I.651 J4.137 E.02431
G1 X128.185 Y124.278 E.00578
G1 X127.835 Y124.52 E.01368
M204 S10000
G1 X128.288 Y124.285 F42000
G1 F1276
M204 S6000
G1 X128.358 Y124.123 E.00567
G1 X128.525 Y124.138 E.00541
G3 X129.096 Y124.263 I-.409 J3.235 E.01882
G1 X129.104 Y124.441 E.00572
G1 X128.649 Y124.608 E.01558
G1 X128.332 Y124.325 E.01368
M204 S10000
G1 X129.239 Y124.527 F42000
G1 F1276
M204 S6000
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
M204 S10000
G1 X130.203 Y125.34 Z3.2 F42000
G1 Z2.8
G1 E.8 F1800
G1 F1276
M204 S6000
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.532 J2.019 E.01456
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
M204 S10000
G1 X130.796 Y125.971 F42000
G1 F1276
M204 S6000
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01378
M204 S10000
G1 X131.213 Y126.729 F42000
G1 F1276
M204 S6000
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00562
G1 X131.514 Y126.309 E.0033
G1 X131.547 Y126.388 E.00277
G3 X131.745 Y126.92 I-2.855 J1.363 E.01826
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
M204 S10000
G1 X131.428 Y127.567 F42000
G1 F1276
M204 S6000
G1 X131.624 Y127.123 E.01561
G1 X131.8 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.847 J.869 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
M204 S10000
G1 X131.428 Y128.433 F42000
G1 F1276
M204 S6000
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.8 Y128.86 I-3.941 J-.123 E.0242
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
M204 S10000
G1 X131.213 Y129.271 F42000
G1 F1276
M204 S6000
G1 X131.598 Y128.977 E.01561
G1 X131.745 Y129.08 E.00578
G3 X131.465 Y129.781 I-4.024 J-1.201 E.0243
G1 X131.293 Y129.753 E.00562
G1 X131.222 Y129.33 E.01378
M204 S10000
G1 X130.796 Y130.029 F42000
G1 F1276
M204 S6000
G1 X131.246 Y129.839 E.01571
G1 X131.362 Y129.978 E.00583
G3 X130.922 Y130.584 I-3.582 J-2.14 E.02409
G1 X130.753 Y130.516 E.00583
G1 X130.79 Y130.089 E.01378
M204 S10000
G1 X130.154 Y130.799 F42000
G1 F1276
M204 S6000
G1 X130.203 Y130.66 E.00473
G1 X130.686 Y130.588 E.01571
G1 X130.767 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.965 J-2.973 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.135 Y130.856 E.00895
M204 S10000
G1 X129.741 Y131.152 F42000
G1 F1276
M204 S6000
G1 X129.955 Y131.174 E.00693
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.444 J-4.3 E.02419
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00675
M204 S10000
G1 X128.81 Y131.451 F42000
G1 F1276
M204 S6000
G1 X129.104 Y131.559 E.01005
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.101 J-3.786 E.02421
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.0036
M204 S10000
G1 X127.785 Y131.446 F42000
G1 F1276
M204 S6000
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.187 E.02431
G1 X127.352 Y131.671 E.00561
G1 X127.732 Y131.474 E.01378
M204 S10000
G1 X126.935 Y131.284 F42000
G1 F1276
M204 S6000
G1 X127.256 Y131.653 E.01571
G1 X127.159 Y131.806 E.00583
G3 X126.447 Y131.575 I.928 J-4.068 E.02409
G1 X126.459 Y131.394 E.00583
G1 X126.877 Y131.297 E.01379
M204 S10000
G1 X126.152 Y130.915 F42000
G1 F1276
M204 S6000
G1 X126.37 Y131.352 E.0157
G1 X126.248 Y131.476 E.00562
G3 X125.609 Y131.074 I2.533 J-4.727 E.02429
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
M204 S10000
G1 X125.485 Y130.364 F42000
G1 F1276
M204 S6000
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.6 J-2.962 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
M204 S10000
G1 X124.977 Y129.663 F42000
G1 F1276
M204 S6000
G1 X124.958 Y130.147 E.01558
G1 X124.786 Y130.195 E.00572
G3 X124.425 Y129.536 I3.261 J-2.217 E.0242
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
M204 S10000
G1 X124.658 Y128.859 F42000
G1 F1276
M204 S6000
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G3 X124.154 Y128.594 I3.954 J-1.392 E.02431
G1 X124.31 Y128.516 E.00562
G1 X124.615 Y128.817 E.01378
M204 S10000
G1 X124.549 Y128 F42000
G1 F1276
M204 S6000
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
M204 S10000
G1 X124.658 Y127.141 F42000
G1 F1276
M204 S6000
G1 X124.31 Y127.484 E.01571
G1 X124.154 Y127.406 E.00562
G3 X124.339 Y126.674 I4.137 J.659 E.02431
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
M204 S10000
G1 X124.977 Y126.337 F42000
G1 F1276
M204 S6000
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.62 J1.557 E.0242
G1 X124.958 Y125.853 E.00572
M73 P83 R2
G1 X124.974 Y126.277 E.01365
M204 S10000
G1 X125.485 Y125.636 F42000
G1 F1276
M204 S6000
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.114 J2.414 E.0242
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
M204 S10000
G1 X126.152 Y125.085 F42000
G1 F1276
M204 S6000
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.524 I2.54 J3.322 E.02431
G1 X126.37 Y124.648 E.00561
G1 X126.179 Y125.031 E.01377
M204 S10000
G1 X126.935 Y124.716 F42000
G1 F1276
M204 S6000
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
M204 S10000
G1 X123.723 Y128.385 Z3.2 F42000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1276
M204 S5000
G3 X126.677 Y123.92 I4.271 J-.384 E.17222
G3 X128.298 Y123.724 I1.333 J4.215 E.04892
G3 X123.729 Y128.445 I-.305 J4.277 E.57954
; OBJECT_ID: 114
; WIPE_START
G1 F6364.704
M204 S6000
G1 X123.712 Y128 E-.16908
G1 X123.73 Y127.615 E-.14626
G1 X123.781 Y127.234 E-.14628
G1 X123.867 Y126.859 E-.14628
G1 X123.986 Y126.493 E-.14624
G1 X123.992 Y126.479 E-.00586
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S10000
G1 X116.36 Y126.509 Z3.2 F42000
G1 X104.382 Y126.557 Z3.2
G1 Z2.8
G1 E.8 F1800
G1 F1276
M204 S5000
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
M204 S6000
G1 X104.363 Y126.079 E-.19337
G1 X104.823 Y125.95 E-.18163
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.79 Y124.554 Z3.2 F42000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1276
M204 S6000
G1 X106.356 Y124.329 E.01571
G1 X106.383 Y124.156 E.00561
G3 X107.136 Y124.107 I.651 J4.137 E.02431
G1 X107.189 Y124.278 E.00578
G1 X106.839 Y124.52 E.01368
M204 S10000
G1 X107.292 Y124.285 F42000
G1 F1276
M204 S6000
G1 X107.362 Y124.123 E.00567
G1 X107.53 Y124.138 E.00541
G3 X108.101 Y124.263 I-.409 J3.235 E.01882
G1 X108.108 Y124.441 E.00572
G1 X107.654 Y124.608 E.01558
G1 X107.337 Y124.325 E.01368
M204 S10000
G1 X108.244 Y124.527 F42000
G1 F1276
M204 S6000
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
M204 S10000
G1 X109.208 Y125.34 Z3.2 F42000
G1 Z2.8
G1 E.8 F1800
G1 F1276
M204 S6000
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.532 J2.019 E.01456
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
M204 S10000
G1 X109.8 Y125.971 F42000
G1 F1276
M204 S6000
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01378
M204 S10000
G1 X110.217 Y126.729 F42000
G1 F1276
M204 S6000
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00562
G1 X110.518 Y126.309 E.0033
G1 X110.552 Y126.388 E.00277
G3 X110.749 Y126.92 I-2.855 J1.363 E.01826
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
M204 S10000
G1 X110.432 Y127.567 F42000
G1 F1276
M204 S6000
G1 X110.629 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.847 J.869 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
M204 S10000
G1 X110.432 Y128.433 F42000
G1 F1276
M204 S6000
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.941 J-.123 E.0242
G1 X110.629 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
M204 S10000
G1 X110.217 Y129.271 F42000
G1 F1276
M204 S6000
G1 X110.603 Y128.977 E.01561
G1 X110.749 Y129.08 E.00578
G3 X110.469 Y129.781 I-4.024 J-1.201 E.0243
G1 X110.297 Y129.753 E.00562
G1 X110.227 Y129.33 E.01378
M204 S10000
G1 X109.8 Y130.029 F42000
G1 F1276
M204 S6000
G1 X110.25 Y129.839 E.01571
G1 X110.366 Y129.978 E.00583
G3 X109.926 Y130.584 I-3.582 J-2.14 E.02409
G1 X109.758 Y130.516 E.00583
G1 X109.795 Y130.089 E.01378
M204 S10000
G1 X109.159 Y130.799 F42000
G1 F1276
M204 S6000
G1 X109.208 Y130.66 E.00473
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.965 J-2.973 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.139 Y130.856 E.00895
M204 S10000
G1 X108.745 Y131.152 F42000
G1 F1276
M204 S6000
G1 X108.96 Y131.174 E.00693
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.444 J-4.3 E.02419
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.686 Y131.145 E.00675
M204 S10000
G1 X107.815 Y131.451 F42000
G1 F1276
M204 S6000
G1 X108.108 Y131.559 E.01005
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.101 J-3.786 E.02421
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.759 Y131.43 E.0036
M204 S10000
G1 X106.79 Y131.446 F42000
G1 F1276
M204 S6000
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.187 E.02431
G1 X106.356 Y131.671 E.00561
G1 X106.737 Y131.474 E.01378
M204 S10000
G1 X105.94 Y131.284 F42000
G1 F1276
M204 S6000
G1 X106.26 Y131.653 E.01571
G1 X106.163 Y131.806 E.00583
G3 X105.452 Y131.575 I.928 J-4.068 E.02409
G1 X105.464 Y131.394 E.00583
G1 X105.881 Y131.297 E.01379
M204 S10000
G1 X105.157 Y130.915 F42000
G1 F1276
M204 S6000
G1 X105.375 Y131.352 E.0157
G1 X105.252 Y131.476 E.00562
G3 X104.614 Y131.074 I2.533 J-4.727 E.02429
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
M204 S10000
G1 X104.49 Y130.364 F42000
G1 F1276
M204 S6000
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.6 J-2.962 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
M204 S10000
G1 X103.981 Y129.663 F42000
G1 F1276
M204 S6000
G1 X103.962 Y130.147 E.01558
G1 X103.791 Y130.195 E.00572
G3 X103.429 Y129.536 I3.261 J-2.217 E.0242
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
M204 S10000
G1 X103.662 Y128.859 F42000
G1 F1276
M204 S6000
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G3 X103.158 Y128.594 I3.954 J-1.392 E.02431
G1 X103.314 Y128.516 E.00562
G1 X103.62 Y128.817 E.01378
M204 S10000
G1 X103.554 Y128 F42000
G1 F1276
M204 S6000
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
M204 S10000
G1 X103.662 Y127.141 F42000
G1 F1276
M204 S6000
G1 X103.314 Y127.484 E.01571
G1 X103.158 Y127.406 E.00562
G3 X103.344 Y126.674 I4.137 J.659 E.02431
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
M204 S10000
G1 X103.981 Y126.337 F42000
G1 F1276
M204 S6000
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.62 J1.557 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
M204 S10000
G1 X104.49 Y125.636 F42000
G1 F1276
M204 S6000
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.114 J2.414 E.0242
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
M204 S10000
G1 X105.157 Y125.085 F42000
G1 F1276
M204 S6000
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.524 I2.54 J3.322 E.02431
G1 X105.375 Y124.648 E.00561
G1 X105.183 Y125.031 E.01377
M204 S10000
G1 X105.94 Y124.716 F42000
G1 F1276
M204 S6000
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
M204 S10000
G1 X102.727 Y128.385 Z3.2 F42000
G1 Z2.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1276
M204 S5000
G3 X105.681 Y123.92 I4.271 J-.384 E.17222
G3 X107.302 Y123.724 I1.333 J4.215 E.04892
G3 X102.733 Y128.445 I-.305 J4.277 E.57954
; WIPE_START
G1 F6364.704
M204 S6000
G1 X102.717 Y128 E-.16908
G1 X102.734 Y127.615 E-.14626
G1 X102.786 Y127.234 E-.14628
G1 X102.872 Y126.859 E-.14628
G1 X102.99 Y126.493 E-.14624
G1 X102.997 Y126.479 E-.00586
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.2 I1.217 J0 P1  F42000
; stop printing object, unique label id: 114
M625
; object ids of layer 14 start: 78,114
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


; object ids of this layer14 end: 78,114
M625
; CHANGE_LAYER
; Z_HEIGHT: 3
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 15/23
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F42000
G1 Z3
G1 E.8 F1800
G1 F1276
M204 S5000
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
M73 P84 R2
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
M204 S6000
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18164
G1 X125.92 Y125.482 E-.18164
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.785 Y124.554 Z3.4 F42000
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1276
M204 S6000
G1 X127.352 Y124.329 E.01571
G1 X127.378 Y124.156 E.00562
G3 X128.131 Y124.107 I.651 J4.145 E.02431
G1 X128.185 Y124.278 E.00578
G1 X127.835 Y124.52 E.01368
M204 S10000
G1 X128.288 Y124.285 F42000
G1 F1276
M204 S6000
G1 X128.358 Y124.123 E.00567
G1 X128.525 Y124.138 E.00541
G3 X129.096 Y124.263 I-.409 J3.233 E.01882
G1 X129.104 Y124.441 E.00572
G1 X128.649 Y124.608 E.01558
G1 X128.332 Y124.325 E.01368
M204 S10000
G1 X129.257 Y124.554 F42000
G1 F1276
M204 S6000
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
M204 S10000
G1 X130.203 Y125.34 Z3.4 F42000
G1 Z3
G1 E.8 F1800
G1 F1276
M204 S6000
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.532 J2.019 E.01455
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
M204 S10000
G1 X130.796 Y125.971 F42000
G1 F1276
M204 S6000
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01378
M204 S10000
G1 X131.213 Y126.729 F42000
G1 F1276
M204 S6000
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00562
G1 X131.514 Y126.309 E.0033
G1 X131.56 Y126.418 E.00381
G3 X131.745 Y126.92 I-2.696 J1.278 E.01722
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
M204 S10000
G1 X131.428 Y127.567 F42000
G1 F1276
M204 S6000
G1 X131.624 Y127.123 E.01561
G1 X131.8 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.847 J.869 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
M204 S10000
G1 X131.428 Y128.433 F42000
G1 F1276
M204 S6000
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.799 Y128.86 I-3.94 J-.123 E.0242
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
M204 S10000
G1 X131.213 Y129.271 F42000
G1 F1276
M204 S6000
G1 X131.598 Y128.977 E.01561
G1 X131.745 Y129.08 E.00578
G3 X131.465 Y129.781 I-4.028 J-1.202 E.0243
G1 X131.293 Y129.753 E.00562
G1 X131.222 Y129.33 E.01378
M204 S10000
G1 X130.796 Y130.029 F42000
G1 F1276
M204 S6000
G1 X131.246 Y129.839 E.01571
G1 X131.362 Y129.978 E.00583
G3 X130.922 Y130.584 I-3.582 J-2.14 E.02409
G1 X130.753 Y130.516 E.00583
G1 X130.79 Y130.089 E.01378
M204 S10000
G1 X130.166 Y130.767 F42000
G1 F1276
M204 S6000
G1 X130.203 Y130.66 E.00363
G1 X130.686 Y130.588 E.01571
G1 X130.767 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.965 J-2.973 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.146 Y130.824 E.01005
M204 S10000
G1 X129.741 Y131.152 F42000
G1 F1276
M204 S6000
G1 X129.955 Y131.174 E.00694
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.647 J-4.731 E.02418
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00674
M204 S10000
G1 X128.81 Y131.451 F42000
G1 F1276
M204 S6000
G1 X129.104 Y131.559 E.01005
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.1 J-3.784 E.0242
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.0036
M204 S10000
G1 X127.785 Y131.446 F42000
G1 F1276
M204 S6000
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.186 E.02431
G1 X127.352 Y131.671 E.00561
G1 X127.732 Y131.474 E.01378
M204 S10000
G1 X126.935 Y131.284 F42000
G1 F1276
M204 S6000
G1 X127.256 Y131.653 E.01571
G1 X127.159 Y131.806 E.00583
G3 X126.447 Y131.575 I.929 J-4.069 E.02409
G1 X126.459 Y131.394 E.00583
G1 X126.877 Y131.297 E.01379
M204 S10000
G1 X126.152 Y130.915 F42000
G1 F1276
M204 S6000
G1 X126.37 Y131.352 E.0157
G1 X126.248 Y131.476 E.00562
G3 X125.609 Y131.074 I1.906 J-3.731 E.02431
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
M204 S10000
G1 X125.485 Y130.364 F42000
G1 F1276
M204 S6000
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.598 J-2.96 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
M204 S10000
G1 X124.977 Y129.663 F42000
G1 F1276
M204 S6000
G1 X124.958 Y130.147 E.01558
G1 X124.786 Y130.195 E.00572
G3 X124.425 Y129.536 I3.26 J-2.217 E.0242
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
M204 S10000
G1 X124.658 Y128.859 F42000
G1 F1276
M204 S6000
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G3 X124.154 Y128.594 I3.949 J-1.391 E.02431
G1 X124.31 Y128.516 E.00561
G1 X124.615 Y128.817 E.01378
M204 S10000
G1 X124.549 Y128 F42000
G1 F1276
M204 S6000
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
M204 S10000
G1 X124.658 Y127.141 F42000
G1 F1276
M204 S6000
G1 X124.31 Y127.484 E.0157
G1 X124.154 Y127.406 E.00561
G3 X124.339 Y126.674 I5.789 J1.078 E.02429
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
M204 S10000
G1 X124.977 Y126.337 F42000
G1 F1276
M204 S6000
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.62 J1.557 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
M204 S10000
G1 X125.485 Y125.636 F42000
G1 F1276
M204 S6000
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.114 J2.414 E.0242
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
M204 S10000
G1 X126.152 Y125.085 F42000
G1 F1276
M204 S6000
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.524 I2.544 J3.328 E.02431
G1 X126.37 Y124.648 E.00561
G1 X126.179 Y125.031 E.01377
M204 S10000
G1 X126.935 Y124.716 F42000
G1 F1276
M204 S6000
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
M204 S10000
G1 X123.724 Y128.385 Z3.4 F42000
G1 Z3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1276
M204 S5000
G3 X126.316 Y124.055 I4.269 J-.385 E.16071
G3 X128.33 Y123.727 I1.671 J3.905 E.06138
G3 X123.73 Y128.445 I-.336 J4.274 E.57843
; OBJECT_ID: 114
; WIPE_START
G1 F6364.704
M204 S6000
G1 X123.712 Y128 E-.1691
G1 X123.73 Y127.615 E-.14626
G1 X123.781 Y127.234 E-.14628
G1 X123.867 Y126.859 E-.14629
G1 X123.986 Y126.493 E-.14621
G1 X123.992 Y126.479 E-.00586
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S10000
G1 X116.36 Y126.509 Z3.4 F42000
G1 X104.382 Y126.557 Z3.4
G1 Z3
G1 E.8 F1800
G1 F1276
M204 S5000
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
M204 S6000
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18164
G1 X104.924 Y125.482 E-.18164
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.79 Y124.554 Z3.4 F42000
G1 Z3
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1276
M204 S6000
G1 X106.357 Y124.329 E.01571
G1 X106.383 Y124.156 E.00562
G3 X107.136 Y124.107 I.651 J4.145 E.02431
G1 X107.189 Y124.278 E.00578
G1 X106.839 Y124.52 E.01368
M204 S10000
G1 X107.292 Y124.285 F42000
G1 F1276
M204 S6000
G1 X107.362 Y124.123 E.00567
G1 X107.53 Y124.138 E.00541
G3 X108.101 Y124.263 I-.409 J3.233 E.01882
G1 X108.108 Y124.441 E.00572
G1 X107.654 Y124.608 E.01558
G1 X107.337 Y124.325 E.01368
M204 S10000
G1 X108.262 Y124.554 F42000
G1 F1276
M204 S6000
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
M204 S10000
G1 X109.208 Y125.34 Z3.4 F42000
G1 Z3
G1 E.8 F1800
G1 F1276
M204 S6000
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.532 J2.019 E.01455
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
M204 S10000
G1 X109.8 Y125.971 F42000
G1 F1276
M204 S6000
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01378
M204 S10000
G1 X110.217 Y126.729 F42000
G1 F1276
M204 S6000
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00562
G1 X110.518 Y126.309 E.0033
G1 X110.565 Y126.418 E.00381
G3 X110.749 Y126.92 I-2.696 J1.278 E.01722
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
M204 S10000
G1 X110.432 Y127.567 F42000
G1 F1276
M204 S6000
G1 X110.629 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
M73 P85 R2
G3 X110.899 Y127.886 I-3.847 J.869 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
M204 S10000
G1 X110.432 Y128.433 F42000
G1 F1276
M204 S6000
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.94 J-.123 E.0242
G1 X110.628 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
M204 S10000
G1 X110.217 Y129.271 F42000
G1 F1276
M204 S6000
G1 X110.603 Y128.977 E.01561
G1 X110.749 Y129.08 E.00578
G3 X110.47 Y129.781 I-4.028 J-1.202 E.0243
G1 X110.297 Y129.753 E.00562
G1 X110.227 Y129.33 E.01378
M204 S10000
G1 X109.8 Y130.029 F42000
G1 F1276
M204 S6000
G1 X110.25 Y129.839 E.01571
G1 X110.366 Y129.978 E.00583
G3 X109.926 Y130.584 I-3.582 J-2.14 E.02409
G1 X109.758 Y130.516 E.00583
G1 X109.795 Y130.089 E.01378
M204 S10000
G1 X109.17 Y130.767 F42000
G1 F1276
M204 S6000
G1 X109.208 Y130.66 E.00363
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.965 J-2.973 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.15 Y130.824 E.01005
M204 S10000
G1 X108.745 Y131.152 F42000
G1 F1276
M204 S6000
G1 X108.96 Y131.174 E.00694
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.647 J-4.731 E.02418
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.685 Y131.145 E.00674
M204 S10000
G1 X107.815 Y131.451 F42000
G1 F1276
M204 S6000
G1 X108.108 Y131.559 E.01005
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.1 J-3.784 E.0242
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.759 Y131.43 E.0036
M204 S10000
G1 X106.79 Y131.446 F42000
G1 F1276
M204 S6000
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.186 E.02431
G1 X106.357 Y131.671 E.00561
G1 X106.737 Y131.474 E.01378
M204 S10000
G1 X105.94 Y131.284 F42000
G1 F1276
M204 S6000
G1 X106.26 Y131.653 E.01571
G1 X106.163 Y131.806 E.00583
G3 X105.452 Y131.575 I.929 J-4.069 E.02409
G1 X105.464 Y131.394 E.00583
G1 X105.881 Y131.297 E.01379
M204 S10000
G1 X105.157 Y130.915 F42000
G1 F1276
M204 S6000
G1 X105.375 Y131.352 E.0157
G1 X105.252 Y131.476 E.00562
G3 X104.614 Y131.074 I1.906 J-3.731 E.02431
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
M204 S10000
G1 X104.49 Y130.364 F42000
G1 F1276
M204 S6000
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.598 J-2.96 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
M204 S10000
G1 X103.981 Y129.663 F42000
G1 F1276
M204 S6000
G1 X103.962 Y130.147 E.01558
G1 X103.791 Y130.195 E.00572
G3 X103.429 Y129.536 I3.26 J-2.217 E.0242
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
M204 S10000
G1 X103.662 Y128.859 F42000
G1 F1276
M204 S6000
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G3 X103.158 Y128.594 I3.949 J-1.391 E.02431
G1 X103.314 Y128.516 E.00561
G1 X103.62 Y128.817 E.01378
M204 S10000
G1 X103.554 Y128 F42000
G1 F1276
M204 S6000
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
M204 S10000
G1 X103.662 Y127.141 F42000
G1 F1276
M204 S6000
G1 X103.314 Y127.484 E.0157
G1 X103.158 Y127.406 E.00561
G3 X103.344 Y126.674 I5.789 J1.078 E.02429
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
M204 S10000
G1 X103.981 Y126.337 F42000
G1 F1276
M204 S6000
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.62 J1.557 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
M204 S10000
G1 X104.49 Y125.636 F42000
G1 F1276
M204 S6000
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.114 J2.414 E.0242
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
M204 S10000
G1 X105.157 Y125.085 F42000
G1 F1276
M204 S6000
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.524 I2.544 J3.328 E.02431
G1 X105.375 Y124.648 E.00561
G1 X105.183 Y125.031 E.01377
M204 S10000
G1 X105.94 Y124.716 F42000
G1 F1276
M204 S6000
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
M204 S10000
G1 X102.729 Y128.385 Z3.4 F42000
G1 Z3
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1276
M204 S5000
G3 X105.321 Y124.055 I4.269 J-.385 E.16071
G3 X107.335 Y123.727 I1.671 J3.905 E.06138
G3 X102.735 Y128.445 I-.336 J4.274 E.57843
; WIPE_START
G1 F6364.704
M204 S6000
G1 X102.717 Y128 E-.1691
G1 X102.734 Y127.615 E-.14626
G1 X102.786 Y127.234 E-.14628
G1 X102.872 Y126.859 E-.14629
G1 X102.99 Y126.493 E-.14621
G1 X102.997 Y126.479 E-.00586
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.4 I1.217 J0 P1  F42000
; stop printing object, unique label id: 114
M625
; object ids of layer 15 start: 78,114
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


; object ids of this layer15 end: 78,114
M625
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 16/23
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F42000
G1 Z3.2
G1 E.8 F1800
G1 F1276
M204 S5000
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
M204 S6000
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18164
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.785 Y124.554 Z3.6 F42000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1276
M204 S6000
G1 X127.352 Y124.329 E.0157
G1 X127.378 Y124.156 E.00561
G3 X128.131 Y124.107 I.651 J4.134 E.02431
G1 X128.185 Y124.278 E.00578
G1 X127.835 Y124.52 E.01368
M204 S10000
G1 X128.288 Y124.285 F42000
G1 F1276
M204 S6000
G1 X128.358 Y124.123 E.00567
G1 X128.525 Y124.138 E.00541
G3 X129.096 Y124.263 I-.409 J3.235 E.01882
G1 X129.104 Y124.441 E.00572
G1 X128.649 Y124.608 E.01558
G1 X128.332 Y124.325 E.01368
M204 S10000
G1 X129.276 Y124.581 F42000
G1 F1276
M204 S6000
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
M204 S10000
G1 X130.203 Y125.34 Z3.6 F42000
G1 Z3.2
G1 E.8 F1800
G1 F1276
M204 S6000
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.532 J2.019 E.01456
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
M204 S10000
G1 X130.796 Y125.971 F42000
G1 F1276
M204 S6000
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01378
M204 S10000
G1 X131.213 Y126.729 F42000
G1 F1276
M204 S6000
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00562
G1 X131.514 Y126.309 E.0033
G3 X131.745 Y126.92 I-4.01 J1.869 E.02102
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
M204 S10000
G1 X131.428 Y127.567 F42000
G1 F1276
M204 S6000
G1 X131.624 Y127.123 E.01561
G1 X131.8 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.847 J.869 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
M204 S10000
G1 X131.428 Y128.433 F42000
G1 F1276
M204 S6000
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.8 Y128.86 I-3.944 J-.123 E.0242
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
M204 S10000
G1 X131.212 Y129.271 F42000
G1 F1276
M204 S6000
G1 X131.598 Y128.977 E.01561
G1 X131.745 Y129.08 E.00578
G3 X131.465 Y129.781 I-4.03 J-1.203 E.02431
G1 X131.293 Y129.753 E.00562
G1 X131.222 Y129.33 E.01378
M204 S10000
G1 X130.796 Y130.029 F42000
G1 F1276
M204 S6000
G1 X131.246 Y129.839 E.01571
G1 X131.362 Y129.978 E.00583
G3 X130.922 Y130.584 I-3.582 J-2.14 E.02409
G1 X130.753 Y130.516 E.00583
G1 X130.79 Y130.089 E.01378
M204 S10000
G1 X130.177 Y130.736 F42000
G1 F1276
M204 S6000
G1 X130.203 Y130.66 E.00256
G1 X130.686 Y130.588 E.01571
G1 X130.767 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.966 J-2.973 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.157 Y130.792 E.01112
M204 S10000
G1 X129.741 Y131.152 F42000
G1 F1276
M204 S6000
G1 X129.955 Y131.174 E.00693
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.014 J-3.387 E.0242
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00675
M204 S10000
G1 X128.81 Y131.451 F42000
G1 F1276
M204 S6000
G1 X129.104 Y131.559 E.01005
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.101 J-3.786 E.0242
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.0036
M204 S10000
G1 X127.785 Y131.446 F42000
G1 F1276
M204 S6000
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.196 E.02431
G1 X127.352 Y131.671 E.00562
G1 X127.732 Y131.474 E.01378
M204 S10000
G1 X126.935 Y131.284 F42000
G1 F1276
M204 S6000
G1 X127.256 Y131.653 E.01571
G1 X127.159 Y131.806 E.00583
G3 X126.447 Y131.575 I.929 J-4.068 E.02409
G1 X126.459 Y131.394 E.00583
G1 X126.877 Y131.297 E.01379
M204 S10000
G1 X126.152 Y130.915 F42000
G1 F1276
M204 S6000
G1 X126.37 Y131.352 E.0157
G1 X126.248 Y131.476 E.00561
G3 X125.609 Y131.074 I1.901 J-3.724 E.02431
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
M204 S10000
G1 X125.485 Y130.364 F42000
G1 F1276
M204 S6000
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.599 J-2.961 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
M204 S10000
G1 X124.977 Y129.663 F42000
G1 F1276
M204 S6000
G1 X124.958 Y130.147 E.01558
G1 X124.786 Y130.195 E.00572
M73 P86 R2
G3 X124.425 Y129.536 I3.261 J-2.217 E.0242
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
M204 S10000
G1 X124.658 Y128.859 F42000
G1 F1276
M204 S6000
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G1 X124.307 Y129.226 E.00337
G3 X124.154 Y128.594 I3.809 J-1.257 E.02093
G1 X124.31 Y128.516 E.00561
G1 X124.615 Y128.817 E.01378
M204 S10000
G1 X124.549 Y128 F42000
G1 F1276
M204 S6000
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
M204 S10000
G1 X124.658 Y127.141 F42000
G1 F1276
M204 S6000
G1 X124.31 Y127.484 E.01571
G1 X124.154 Y127.406 E.00562
G3 X124.339 Y126.674 I4.143 J.661 E.02431
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
M204 S10000
G1 X124.977 Y126.337 F42000
G1 F1276
M204 S6000
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.619 J1.557 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
M204 S10000
G1 X125.485 Y125.636 F42000
G1 F1276
M204 S6000
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.114 J2.414 E.0242
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
M204 S10000
G1 X126.152 Y125.085 F42000
G1 F1276
M204 S6000
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.523 I2.544 J3.328 E.02431
G1 X126.371 Y124.648 E.00562
G1 X126.179 Y125.031 E.01378
M204 S10000
G1 X126.935 Y124.716 F42000
G1 F1276
M204 S6000
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
M204 S10000
G1 X123.734 Y128.384 Z3.6 F42000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1276
M204 S5000
G3 X128.362 Y123.73 I4.268 J-.384 E.22271
G3 X132.07 Y126.653 I-.344 J4.25 E.14905
G3 X123.74 Y128.444 I-4.068 J1.347 E.42861
; OBJECT_ID: 114
; WIPE_START
G1 F6364.704
M204 S6000
G1 X123.712 Y128 E-.16897
G1 X123.73 Y127.615 E-.14626
G1 X123.781 Y127.234 E-.14628
G1 X123.867 Y126.859 E-.14628
G1 X123.986 Y126.493 E-.14627
G1 X123.992 Y126.478 E-.00595
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S10000
G1 X116.36 Y126.509 Z3.6 F42000
G1 X104.382 Y126.557 Z3.6
G1 Z3.2
G1 E.8 F1800
G1 F1276
M204 S5000
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
M204 S6000
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18164
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.79 Y124.554 Z3.6 F42000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1276
M204 S6000
G1 X106.357 Y124.329 E.0157
G1 X106.383 Y124.156 E.00561
G3 X107.136 Y124.107 I.651 J4.134 E.02431
G1 X107.189 Y124.278 E.00578
G1 X106.839 Y124.52 E.01368
M204 S10000
G1 X107.292 Y124.285 F42000
G1 F1276
M204 S6000
G1 X107.362 Y124.123 E.00567
G1 X107.53 Y124.138 E.00541
G3 X108.101 Y124.263 I-.409 J3.235 E.01882
G1 X108.108 Y124.441 E.00572
G1 X107.654 Y124.608 E.01558
G1 X107.337 Y124.325 E.01368
M204 S10000
G1 X108.28 Y124.581 F42000
G1 F1276
M204 S6000
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
M204 S10000
G1 X109.208 Y125.34 Z3.6 F42000
G1 Z3.2
G1 E.8 F1800
G1 F1276
M204 S6000
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.532 J2.019 E.01456
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
M204 S10000
G1 X109.8 Y125.971 F42000
G1 F1276
M204 S6000
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01378
M204 S10000
G1 X110.217 Y126.729 F42000
G1 F1276
M204 S6000
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00562
G1 X110.518 Y126.309 E.0033
G3 X110.749 Y126.92 I-4.01 J1.869 E.02102
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
M204 S10000
G1 X110.432 Y127.567 F42000
G1 F1276
M204 S6000
G1 X110.629 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.847 J.869 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
M204 S10000
G1 X110.432 Y128.433 F42000
G1 F1276
M204 S6000
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.944 J-.123 E.0242
G1 X110.629 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
M204 S10000
G1 X110.217 Y129.271 F42000
G1 F1276
M204 S6000
G1 X110.603 Y128.977 E.01561
G1 X110.749 Y129.08 E.00578
G3 X110.469 Y129.781 I-4.03 J-1.203 E.02431
G1 X110.297 Y129.753 E.00562
G1 X110.227 Y129.33 E.01378
M204 S10000
G1 X109.8 Y130.029 F42000
G1 F1276
M204 S6000
G1 X110.25 Y129.839 E.01571
G1 X110.366 Y129.978 E.00583
G3 X109.926 Y130.584 I-3.582 J-2.14 E.02409
G1 X109.758 Y130.516 E.00583
G1 X109.795 Y130.089 E.01378
M204 S10000
G1 X109.181 Y130.736 F42000
G1 F1276
M204 S6000
G1 X109.208 Y130.66 E.00256
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.966 J-2.973 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.161 Y130.792 E.01112
M204 S10000
G1 X108.745 Y131.152 F42000
G1 F1276
M204 S6000
G1 X108.96 Y131.174 E.00693
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.014 J-3.387 E.0242
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.686 Y131.145 E.00675
M204 S10000
G1 X107.815 Y131.451 F42000
G1 F1276
M204 S6000
G1 X108.108 Y131.559 E.01005
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.101 J-3.786 E.0242
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.759 Y131.43 E.0036
M204 S10000
G1 X106.79 Y131.446 F42000
G1 F1276
M204 S6000
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.196 E.02431
G1 X106.356 Y131.671 E.00562
G1 X106.737 Y131.474 E.01378
M204 S10000
G1 X105.94 Y131.284 F42000
G1 F1276
M204 S6000
G1 X106.26 Y131.653 E.01571
G1 X106.163 Y131.806 E.00583
G3 X105.452 Y131.575 I.929 J-4.068 E.02409
G1 X105.464 Y131.394 E.00583
G1 X105.881 Y131.297 E.01379
M204 S10000
G1 X105.157 Y130.915 F42000
G1 F1276
M204 S6000
G1 X105.375 Y131.352 E.0157
G1 X105.252 Y131.476 E.00561
G3 X104.614 Y131.074 I1.901 J-3.724 E.02431
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
M204 S10000
G1 X104.49 Y130.364 F42000
G1 F1276
M204 S6000
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.599 J-2.961 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
M204 S10000
G1 X103.981 Y129.663 F42000
G1 F1276
M204 S6000
G1 X103.962 Y130.147 E.01558
G1 X103.791 Y130.195 E.00572
G3 X103.429 Y129.536 I3.261 J-2.217 E.0242
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
M204 S10000
G1 X103.662 Y128.859 F42000
G1 F1276
M204 S6000
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G1 X103.311 Y129.226 E.00337
G3 X103.158 Y128.594 I3.809 J-1.257 E.02093
G1 X103.314 Y128.516 E.00561
G1 X103.62 Y128.817 E.01378
M204 S10000
G1 X103.554 Y128 F42000
G1 F1276
M204 S6000
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
M204 S10000
G1 X103.662 Y127.141 F42000
G1 F1276
M204 S6000
G1 X103.314 Y127.484 E.01571
G1 X103.158 Y127.406 E.00562
G3 X103.344 Y126.674 I4.143 J.661 E.02431
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
M204 S10000
G1 X103.981 Y126.337 F42000
G1 F1276
M204 S6000
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.619 J1.557 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
M204 S10000
G1 X104.49 Y125.636 F42000
G1 F1276
M204 S6000
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.114 J2.414 E.0242
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
M204 S10000
G1 X105.157 Y125.085 F42000
G1 F1276
M204 S6000
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.523 I2.544 J3.328 E.02431
G1 X105.375 Y124.648 E.00562
G1 X105.183 Y125.031 E.01378
M204 S10000
G1 X105.94 Y124.716 F42000
G1 F1276
M204 S6000
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
M204 S10000
G1 X102.738 Y128.384 Z3.6 F42000
G1 Z3.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1276
M204 S5000
G3 X107.367 Y123.73 I4.268 J-.384 E.22271
G3 X111.075 Y126.653 I-.344 J4.25 E.14905
G3 X102.744 Y128.444 I-4.068 J1.347 E.42861
; WIPE_START
G1 F6364.704
M204 S6000
G1 X102.717 Y128 E-.16897
G1 X102.734 Y127.615 E-.14626
G1 X102.786 Y127.234 E-.14628
G1 X102.872 Y126.859 E-.14628
G1 X102.99 Y126.493 E-.14627
G1 X102.997 Y126.478 E-.00595
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.6 I1.217 J0 P1  F42000
; stop printing object, unique label id: 114
M625
; object ids of layer 16 start: 78,114
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


; object ids of this layer16 end: 78,114
M625
; CHANGE_LAYER
; Z_HEIGHT: 3.4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 17/23
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F42000
G1 Z3.4
G1 E.8 F1800
G1 F1298
M204 S5000
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
M73 P87 R2
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
M73 P87 R1
G1 X125.007 Y128 E.01424
G1 X124.761 Y127.59 E.01424
G1 X125.101 Y127.255 E.01424
G1 X124.964 Y126.797 E.01424
G1 X125.326 Y126.587 E.01245
; WIPE_START
G1 F6364.704
M204 S6000
G1 X125.359 Y126.079 E-.19337
G1 X125.819 Y125.95 E-.18163
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.785 Y124.554 Z3.8 F42000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1298
M204 S6000
G1 X127.352 Y124.329 E.01571
G1 X127.378 Y124.156 E.00562
G3 X128.131 Y124.107 I.652 J4.148 E.02431
G1 X128.185 Y124.278 E.00578
G1 X127.835 Y124.52 E.01368
M204 S10000
G1 X128.288 Y124.285 F42000
G1 F1298
M204 S6000
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
M204 S10000
G1 X129.293 Y124.608 Z3.8 F42000
G1 Z3.4
G1 E.8 F1800
G1 F1298
M204 S6000
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
M204 S10000
G1 X130.203 Y125.34 Z3.8 F42000
G1 Z3.4
G1 E.8 F1800
G1 F1298
M204 S6000
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.532 J2.019 E.01456
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
M204 S10000
G1 X130.796 Y125.971 F42000
G1 F1298
M204 S6000
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01378
M204 S10000
G1 X131.213 Y126.729 F42000
G1 F1298
M204 S6000
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00562
G1 X131.514 Y126.309 E.0033
G3 X131.745 Y126.92 I-4.17 J1.929 E.02102
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
M204 S10000
G1 X131.428 Y127.567 F42000
G1 F1298
M204 S6000
G1 X131.624 Y127.123 E.01561
G1 X131.8 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.847 J.869 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
M204 S10000
G1 X131.428 Y128.433 F42000
G1 F1298
M204 S6000
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.799 Y128.86 I-3.941 J-.123 E.0242
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
M204 S10000
G1 X131.213 Y129.271 F42000
G1 F1298
M204 S6000
G1 X131.598 Y128.977 E.01561
G1 X131.745 Y129.08 E.00578
G1 X131.703 Y129.211 E.00441
G3 X131.465 Y129.781 I-3.821 J-1.257 E.01989
G1 X131.293 Y129.753 E.00562
G1 X131.222 Y129.33 E.01378
M204 S10000
G1 X130.796 Y130.029 F42000
G1 F1298
M204 S6000
G1 X131.246 Y129.839 E.01571
G1 X131.362 Y129.978 E.00583
G3 X130.922 Y130.584 I-3.583 J-2.141 E.02409
G1 X130.753 Y130.516 E.00583
G1 X130.79 Y130.089 E.01379
M204 S10000
G1 X130.187 Y130.705 F42000
G1 F1298
M204 S6000
G1 X130.203 Y130.66 E.00151
G1 X130.686 Y130.588 E.01571
G1 X130.767 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.958 J-2.963 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.168 Y130.761 E.01217
M204 S10000
G1 X129.741 Y131.152 F42000
G1 F1298
M204 S6000
G1 X129.955 Y131.174 E.00694
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.014 J-3.389 E.0242
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00674
M204 S10000
G1 X128.81 Y131.451 F42000
G1 F1298
M204 S6000
G1 X129.104 Y131.559 E.01005
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.101 J-3.784 E.0242
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.0036
M204 S10000
G1 X127.785 Y131.446 F42000
G1 F1298
M204 S6000
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.196 E.02431
G1 X127.352 Y131.671 E.00562
G1 X127.732 Y131.474 E.01378
M204 S10000
G1 X126.935 Y131.284 F42000
G1 F1298
M204 S6000
G1 X127.256 Y131.653 E.01572
G1 X127.159 Y131.806 E.00583
G3 X126.447 Y131.575 I.929 J-4.07 E.02409
G1 X126.459 Y131.394 E.00583
G1 X126.877 Y131.297 E.01379
M204 S10000
G1 X126.152 Y130.915 F42000
G1 F1298
M204 S6000
G1 X126.37 Y131.352 E.0157
G1 X126.248 Y131.476 E.00562
G3 X125.609 Y131.074 I1.906 J-3.731 E.02431
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
M204 S10000
G1 X125.485 Y130.364 F42000
G1 F1298
M204 S6000
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.599 J-2.961 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
M204 S10000
G1 X124.977 Y129.663 F42000
G1 F1298
M204 S6000
G1 X124.958 Y130.147 E.01558
G1 X124.786 Y130.195 E.00572
G3 X124.425 Y129.536 I3.26 J-2.216 E.0242
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
M204 S10000
G1 X124.658 Y128.859 F42000
G1 F1298
M204 S6000
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G3 X124.154 Y128.594 I3.954 J-1.392 E.02431
G1 X124.31 Y128.516 E.00562
G1 X124.615 Y128.817 E.01378
M204 S10000
G1 X124.549 Y128 F42000
G1 F1298
M204 S6000
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
M204 S10000
G1 X124.658 Y127.141 F42000
G1 F1298
M204 S6000
G1 X124.31 Y127.484 E.01571
G1 X124.154 Y127.406 E.00562
G3 X124.339 Y126.674 I4.137 J.659 E.02431
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
M204 S10000
G1 X124.977 Y126.337 F42000
G1 F1298
M204 S6000
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.619 J1.557 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
M204 S10000
G1 X125.485 Y125.636 F42000
G1 F1298
M204 S6000
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.114 J2.414 E.0242
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
M204 S10000
G1 X126.152 Y125.085 F42000
G1 F1298
M204 S6000
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.523 I2.548 J3.335 E.02431
G1 X126.371 Y124.648 E.00562
G1 X126.179 Y125.031 E.01378
M204 S10000
G1 X126.935 Y124.716 F42000
G1 F1298
M204 S6000
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
M204 S10000
G1 X123.741 Y128.383 Z3.8 F42000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1298
M204 S5000
G3 X128.394 Y123.732 I4.265 J-.386 E.22348
G3 X132.075 Y129.332 I-.383 J4.261 E.22931
G3 X123.747 Y128.443 I-4.069 J-1.334 E.34705
; OBJECT_ID: 114
; WIPE_START
G1 F6364.704
M204 S6000
G1 X123.712 Y128 E-.16888
G1 X123.73 Y127.615 E-.14626
G1 X123.781 Y127.234 E-.14628
G1 X123.867 Y126.859 E-.14628
G1 X123.986 Y126.493 E-.14626
G1 X123.992 Y126.478 E-.00604
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S10000
G1 X116.36 Y126.509 Z3.8 F42000
G1 X104.382 Y126.557 Z3.8
G1 Z3.4
G1 E.8 F1800
G1 F1298
M204 S5000
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
M204 S6000
G1 X104.363 Y126.079 E-.19337
G1 X104.823 Y125.95 E-.18163
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.79 Y124.554 Z3.8 F42000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1298
M204 S6000
G1 X106.356 Y124.329 E.01571
G1 X106.383 Y124.156 E.00562
G3 X107.136 Y124.107 I.652 J4.148 E.02431
G1 X107.189 Y124.278 E.00578
G1 X106.839 Y124.52 E.01368
M204 S10000
G1 X107.292 Y124.285 F42000
G1 F1298
M204 S6000
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
M204 S10000
G1 X108.298 Y124.608 Z3.8 F42000
G1 Z3.4
G1 E.8 F1800
G1 F1298
M204 S6000
G1 X108.208 Y124.473 E.00521
G1 X108.318 Y124.334 E.00572
G1 X108.539 Y124.416 E.00757
G3 X108.998 Y124.654 I-1.092 J2.67 E.01666
G1 X108.96 Y124.826 E.00567
G1 X108.477 Y124.876 E.01561
M73 P88 R1
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
M204 S10000
G1 X109.208 Y125.34 Z3.8 F42000
G1 Z3.4
G1 E.8 F1800
G1 F1298
M204 S6000
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.532 J2.019 E.01456
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
M204 S10000
G1 X109.8 Y125.971 F42000
G1 F1298
M204 S6000
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01378
M204 S10000
G1 X110.217 Y126.729 F42000
G1 F1298
M204 S6000
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00562
G1 X110.518 Y126.309 E.0033
G3 X110.749 Y126.92 I-4.17 J1.929 E.02102
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
M204 S10000
G1 X110.432 Y127.567 F42000
G1 F1298
M204 S6000
G1 X110.629 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.847 J.869 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
M204 S10000
G1 X110.432 Y128.433 F42000
G1 F1298
M204 S6000
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.941 J-.123 E.0242
G1 X110.628 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
M204 S10000
G1 X110.217 Y129.271 F42000
G1 F1298
M204 S6000
G1 X110.603 Y128.977 E.01561
G1 X110.749 Y129.08 E.00578
G1 X110.707 Y129.211 E.00441
G3 X110.469 Y129.781 I-3.821 J-1.257 E.01989
G1 X110.297 Y129.753 E.00562
G1 X110.227 Y129.33 E.01378
M204 S10000
G1 X109.8 Y130.029 F42000
G1 F1298
M204 S6000
G1 X110.25 Y129.839 E.01571
G1 X110.366 Y129.978 E.00583
G3 X109.926 Y130.584 I-3.583 J-2.141 E.02409
G1 X109.758 Y130.516 E.00583
G1 X109.795 Y130.089 E.01379
M204 S10000
G1 X109.192 Y130.705 F42000
G1 F1298
M204 S6000
G1 X109.208 Y130.66 E.00151
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.958 J-2.963 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.172 Y130.761 E.01217
M204 S10000
G1 X108.745 Y131.152 F42000
G1 F1298
M204 S6000
G1 X108.96 Y131.174 E.00694
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.014 J-3.389 E.0242
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.685 Y131.145 E.00674
M204 S10000
G1 X107.815 Y131.451 F42000
G1 F1298
M204 S6000
G1 X108.108 Y131.559 E.01005
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.101 J-3.784 E.0242
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.759 Y131.43 E.0036
M204 S10000
G1 X106.79 Y131.446 F42000
G1 F1298
M204 S6000
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.196 E.02431
G1 X106.356 Y131.671 E.00562
G1 X106.737 Y131.474 E.01378
M204 S10000
G1 X105.94 Y131.284 F42000
G1 F1298
M204 S6000
G1 X106.26 Y131.653 E.01572
G1 X106.163 Y131.806 E.00583
G3 X105.452 Y131.575 I.929 J-4.07 E.02409
G1 X105.464 Y131.394 E.00583
G1 X105.881 Y131.297 E.01379
M204 S10000
G1 X105.157 Y130.915 F42000
G1 F1298
M204 S6000
G1 X105.375 Y131.352 E.0157
G1 X105.252 Y131.476 E.00562
G3 X104.614 Y131.074 I1.906 J-3.731 E.02431
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
M204 S10000
G1 X104.49 Y130.364 F42000
G1 F1298
M204 S6000
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.599 J-2.961 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
M204 S10000
G1 X103.981 Y129.663 F42000
G1 F1298
M204 S6000
G1 X103.962 Y130.147 E.01558
G1 X103.791 Y130.195 E.00572
G3 X103.429 Y129.536 I3.26 J-2.216 E.0242
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
M204 S10000
G1 X103.662 Y128.859 F42000
G1 F1298
M204 S6000
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G3 X103.158 Y128.594 I3.954 J-1.392 E.02431
G1 X103.314 Y128.516 E.00562
G1 X103.62 Y128.817 E.01378
M204 S10000
G1 X103.554 Y128 F42000
G1 F1298
M204 S6000
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
M204 S10000
G1 X103.662 Y127.141 F42000
G1 F1298
M204 S6000
G1 X103.314 Y127.484 E.01571
G1 X103.158 Y127.406 E.00562
G3 X103.344 Y126.674 I4.137 J.659 E.02431
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
M204 S10000
G1 X103.981 Y126.337 F42000
G1 F1298
M204 S6000
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.619 J1.557 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
M204 S10000
G1 X104.49 Y125.636 F42000
G1 F1298
M204 S6000
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.114 J2.414 E.0242
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
M204 S10000
G1 X105.157 Y125.085 F42000
G1 F1298
M204 S6000
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.523 I2.548 J3.335 E.02431
G1 X105.375 Y124.648 E.00562
G1 X105.183 Y125.031 E.01378
M204 S10000
G1 X105.94 Y124.716 F42000
G1 F1298
M204 S6000
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
M204 S10000
G1 X102.745 Y128.383 Z3.8 F42000
G1 Z3.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1298
M204 S5000
G3 X107.399 Y123.732 I4.265 J-.386 E.22348
G3 X111.08 Y129.332 I-.383 J4.261 E.22931
G3 X102.751 Y128.443 I-4.069 J-1.334 E.34705
; WIPE_START
G1 F6364.704
M204 S6000
G1 X102.717 Y128 E-.16888
G1 X102.734 Y127.615 E-.14626
G1 X102.786 Y127.234 E-.14628
G1 X102.872 Y126.859 E-.14628
G1 X102.99 Y126.493 E-.14626
G1 X102.997 Y126.478 E-.00604
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z3.8 I1.217 J0 P1  F42000
; stop printing object, unique label id: 114
M625
; object ids of layer 17 start: 78,114
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


; object ids of this layer17 end: 78,114
M625
; CHANGE_LAYER
; Z_HEIGHT: 3.6
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 18/23
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F42000
G1 Z3.6
G1 E.8 F1800
G1 F1298
M204 S5000
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
M204 S6000
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18164
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.785 Y124.554 Z4 F42000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1298
M204 S6000
G1 X127.352 Y124.329 E.0157
G1 X127.378 Y124.156 E.00561
G3 X128.131 Y124.107 I.651 J4.134 E.02431
G1 X128.185 Y124.278 E.00578
G1 X127.835 Y124.52 E.01368
M204 S10000
G1 X128.288 Y124.285 F42000
G1 F1298
M204 S6000
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
M204 S10000
G1 X129.31 Y124.633 Z4 F42000
G1 Z3.6
G1 E.8 F1800
G1 F1298
M204 S6000
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
M204 S10000
G1 X130.203 Y125.34 Z4 F42000
G1 Z3.6
G1 E.8 F1800
G1 F1298
M204 S6000
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.532 J2.019 E.01456
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
M204 S10000
G1 X130.796 Y125.971 F42000
G1 F1298
M204 S6000
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01378
M204 S10000
G1 X131.213 Y126.729 F42000
G1 F1298
M204 S6000
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00562
G1 X131.514 Y126.309 E.0033
G1 X131.598 Y126.507 E.00692
G3 X131.745 Y126.92 I-2.221 J1.022 E.0141
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
M204 S10000
G1 X131.428 Y127.567 F42000
G1 F1298
M204 S6000
G1 X131.624 Y127.123 E.01561
G1 X131.8 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.847 J.869 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
M204 S10000
G1 X131.428 Y128.433 F42000
G1 F1298
M204 S6000
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.799 Y128.86 I-3.941 J-.123 E.0242
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
M204 S10000
G1 X131.213 Y129.271 F42000
G1 F1298
M204 S6000
G1 X131.598 Y128.977 E.01561
G1 X131.745 Y129.08 E.00578
G1 X131.693 Y129.241 E.00545
G3 X131.465 Y129.781 I-3.853 J-1.307 E.01886
G1 X131.293 Y129.753 E.00562
G1 X131.222 Y129.33 E.01378
M204 S10000
G1 X130.796 Y130.029 F42000
G1 F1298
M204 S6000
G1 X131.246 Y129.839 E.01571
G1 X131.362 Y129.978 E.00583
G3 X130.922 Y130.584 I-3.582 J-2.14 E.02409
G1 X130.753 Y130.516 E.00583
G1 X130.79 Y130.089 E.01378
M204 S10000
G1 X130.198 Y130.675 F42000
G1 F1298
M204 S6000
G1 X130.203 Y130.66 E.00049
G1 X130.686 Y130.588 E.01571
G1 X130.767 Y130.743 E.00562
M73 P89 R1
G3 X130.186 Y131.226 I-2.957 J-2.963 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.178 Y130.731 E.01319
M204 S10000
G1 X129.741 Y131.152 F42000
G1 F1298
M204 S6000
G1 X129.955 Y131.174 E.00693
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.015 J-3.39 E.0242
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00675
M204 S10000
G1 X128.81 Y131.451 F42000
G1 F1298
M204 S6000
G1 X129.104 Y131.559 E.01005
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.101 J-3.786 E.0242
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.0036
M204 S10000
G1 X127.785 Y131.446 F42000
G1 F1298
M204 S6000
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.186 E.02431
G1 X127.352 Y131.671 E.00561
G1 X127.732 Y131.474 E.01378
M204 S10000
G1 X126.935 Y131.284 F42000
G1 F1298
M204 S6000
G1 X127.256 Y131.653 E.01571
G1 X127.159 Y131.806 E.00583
G3 X126.447 Y131.575 I.929 J-4.069 E.02409
G1 X126.459 Y131.394 E.00583
G1 X126.877 Y131.297 E.01379
M204 S10000
G1 X126.152 Y130.915 F42000
G1 F1298
M204 S6000
G1 X126.37 Y131.352 E.0157
G1 X126.248 Y131.476 E.00562
G3 X125.609 Y131.074 I1.906 J-3.731 E.02431
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
M204 S10000
G1 X125.485 Y130.364 F42000
G1 F1298
M204 S6000
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.598 J-2.961 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
M204 S10000
G1 X124.977 Y129.663 F42000
G1 F1298
M204 S6000
G1 X124.958 Y130.147 E.01558
G1 X124.786 Y130.195 E.00572
G3 X124.425 Y129.536 I3.259 J-2.216 E.0242
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
M204 S10000
G1 X124.658 Y128.859 F42000
G1 F1298
M204 S6000
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G3 X124.154 Y128.594 I3.949 J-1.39 E.02431
G1 X124.31 Y128.516 E.00561
G1 X124.615 Y128.817 E.01378
M204 S10000
G1 X124.549 Y128 F42000
G1 F1298
M204 S6000
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
M204 S10000
G1 X124.658 Y127.141 F42000
G1 F1298
M204 S6000
G1 X124.31 Y127.484 E.01571
G1 X124.154 Y127.406 E.00562
G3 X124.339 Y126.674 I4.144 J.661 E.02431
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
M204 S10000
G1 X124.977 Y126.337 F42000
G1 F1298
M204 S6000
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.62 J1.557 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
M204 S10000
G1 X125.485 Y125.636 F42000
G1 F1298
M204 S6000
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.114 J2.414 E.0242
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
M204 S10000
G1 X126.152 Y125.085 F42000
G1 F1298
M204 S6000
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.523 I2.548 J3.335 E.02431
G1 X126.37 Y124.648 E.00562
G1 X126.179 Y125.031 E.01378
M204 S10000
G1 X126.935 Y124.716 F42000
G1 F1298
M204 S6000
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
M204 S10000
G1 X123.724 Y128.385 Z4 F42000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1298
M204 S5000
G3 X126.316 Y124.055 I4.269 J-.385 E.16071
G3 X128.427 Y123.735 I1.672 J3.907 E.06426
G3 X123.73 Y128.445 I-.433 J4.265 E.57554
; OBJECT_ID: 114
; WIPE_START
G1 F6364.704
M204 S6000
G1 X123.712 Y128 E-.1691
G1 X123.73 Y127.615 E-.14626
G1 X123.781 Y127.234 E-.14628
G1 X123.867 Y126.859 E-.14628
G1 X123.986 Y126.493 E-.14622
G1 X123.992 Y126.479 E-.00586
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S10000
G1 X116.36 Y126.509 Z4 F42000
G1 X104.382 Y126.557 Z4
G1 Z3.6
G1 E.8 F1800
G1 F1298
M204 S5000
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
M204 S6000
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18164
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.79 Y124.554 Z4 F42000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1298
M204 S6000
G1 X106.357 Y124.329 E.0157
G1 X106.383 Y124.156 E.00561
G3 X107.136 Y124.107 I.651 J4.134 E.02431
G1 X107.189 Y124.278 E.00578
G1 X106.839 Y124.52 E.01368
M204 S10000
G1 X107.292 Y124.285 F42000
G1 F1298
M204 S6000
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
M204 S10000
G1 X108.315 Y124.633 Z4 F42000
G1 Z3.6
G1 E.8 F1800
G1 F1298
M204 S6000
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
M204 S10000
G1 X109.208 Y125.34 Z4 F42000
G1 Z3.6
G1 E.8 F1800
G1 F1298
M204 S6000
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.532 J2.019 E.01456
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
M204 S10000
G1 X109.8 Y125.971 F42000
G1 F1298
M204 S6000
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01378
M204 S10000
G1 X110.217 Y126.729 F42000
G1 F1298
M204 S6000
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00562
G1 X110.518 Y126.309 E.0033
G1 X110.603 Y126.507 E.00692
G3 X110.749 Y126.92 I-2.221 J1.022 E.0141
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
M204 S10000
G1 X110.432 Y127.567 F42000
G1 F1298
M204 S6000
G1 X110.629 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.847 J.869 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
M204 S10000
G1 X110.432 Y128.433 F42000
G1 F1298
M204 S6000
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.941 J-.123 E.0242
G1 X110.628 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
M204 S10000
G1 X110.217 Y129.271 F42000
G1 F1298
M204 S6000
G1 X110.603 Y128.977 E.01561
G1 X110.749 Y129.08 E.00578
G1 X110.697 Y129.241 E.00545
G3 X110.469 Y129.781 I-3.853 J-1.307 E.01886
G1 X110.297 Y129.753 E.00562
G1 X110.227 Y129.33 E.01378
M204 S10000
G1 X109.8 Y130.029 F42000
G1 F1298
M204 S6000
G1 X110.25 Y129.839 E.01571
G1 X110.366 Y129.978 E.00583
G3 X109.926 Y130.584 I-3.582 J-2.14 E.02409
G1 X109.758 Y130.516 E.00583
G1 X109.795 Y130.089 E.01378
M204 S10000
G1 X109.203 Y130.675 F42000
G1 F1298
M204 S6000
G1 X109.208 Y130.66 E.00049
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.957 J-2.963 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.183 Y130.731 E.01319
M204 S10000
G1 X108.745 Y131.152 F42000
G1 F1298
M204 S6000
G1 X108.96 Y131.174 E.00693
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.015 J-3.39 E.0242
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.686 Y131.145 E.00675
M204 S10000
G1 X107.815 Y131.451 F42000
G1 F1298
M204 S6000
G1 X108.108 Y131.559 E.01005
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.101 J-3.786 E.0242
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.759 Y131.43 E.0036
M204 S10000
G1 X106.79 Y131.446 F42000
G1 F1298
M204 S6000
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.186 E.02431
G1 X106.357 Y131.671 E.00561
G1 X106.737 Y131.474 E.01378
M204 S10000
G1 X105.94 Y131.284 F42000
G1 F1298
M204 S6000
G1 X106.26 Y131.653 E.01571
G1 X106.163 Y131.806 E.00583
G3 X105.452 Y131.575 I.929 J-4.069 E.02409
G1 X105.464 Y131.394 E.00583
G1 X105.881 Y131.297 E.01379
M204 S10000
G1 X105.157 Y130.915 F42000
G1 F1298
M204 S6000
G1 X105.375 Y131.352 E.0157
G1 X105.252 Y131.476 E.00562
G3 X104.614 Y131.074 I1.906 J-3.731 E.02431
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
M204 S10000
G1 X104.49 Y130.364 F42000
G1 F1298
M204 S6000
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.598 J-2.961 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
M204 S10000
G1 X103.981 Y129.663 F42000
G1 F1298
M204 S6000
G1 X103.962 Y130.147 E.01558
G1 X103.791 Y130.195 E.00572
G3 X103.429 Y129.536 I3.259 J-2.216 E.0242
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
M204 S10000
G1 X103.662 Y128.859 F42000
G1 F1298
M204 S6000
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G3 X103.158 Y128.594 I3.949 J-1.39 E.02431
G1 X103.314 Y128.516 E.00561
G1 X103.62 Y128.817 E.01378
M204 S10000
G1 X103.554 Y128 F42000
G1 F1298
M204 S6000
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
M204 S10000
G1 X103.662 Y127.141 F42000
G1 F1298
M204 S6000
G1 X103.314 Y127.484 E.01571
G1 X103.158 Y127.406 E.00562
G3 X103.344 Y126.674 I4.144 J.661 E.02431
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
M204 S10000
G1 X103.981 Y126.337 F42000
G1 F1298
M204 S6000
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.62 J1.557 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
M204 S10000
G1 X104.49 Y125.636 F42000
G1 F1298
M204 S6000
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.114 J2.414 E.0242
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
M204 S10000
G1 X105.157 Y125.085 F42000
G1 F1298
M204 S6000
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.523 I2.548 J3.335 E.02431
G1 X105.375 Y124.648 E.00562
G1 X105.183 Y125.031 E.01378
M204 S10000
G1 X105.94 Y124.716 F42000
G1 F1298
M204 S6000
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
M204 S10000
G1 X102.729 Y128.385 Z4 F42000
G1 Z3.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1298
M204 S5000
G3 X105.321 Y124.055 I4.269 J-.385 E.16071
G3 X107.431 Y123.735 I1.672 J3.907 E.06426
G3 X102.735 Y128.445 I-.433 J4.265 E.57554
; WIPE_START
G1 F6364.704
M204 S6000
G1 X102.717 Y128 E-.1691
G1 X102.734 Y127.615 E-.14626
G1 X102.786 Y127.234 E-.14628
G1 X102.872 Y126.859 E-.14628
G1 X102.99 Y126.493 E-.14622
G1 X102.997 Y126.479 E-.00586
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4 I1.217 J0 P1  F42000
; stop printing object, unique label id: 114
M625
; object ids of layer 18 start: 78,114
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


; object ids of this layer18 end: 78,114
M625
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 19/23
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F42000
G1 Z3.8
G1 E.8 F1800
G1 F1299
M204 S5000
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
M73 P90 R1
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
M204 S6000
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18164
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.785 Y124.554 Z4.2 F42000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1299
M204 S6000
G1 X127.352 Y124.329 E.01571
G1 X127.378 Y124.156 E.00562
G3 X128.131 Y124.107 I.651 J4.145 E.02431
G1 X128.185 Y124.278 E.00578
G1 X127.835 Y124.52 E.01368
M204 S10000
G1 X128.288 Y124.285 F42000
G1 F1299
M204 S6000
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
G1 X128.869 Y124.2 E-.13293
G1 X129.096 Y124.263 E-.08939
G1 X129.104 Y124.441 E-.06763
G1 X128.649 Y124.608 E-.18408
G1 X128.365 Y124.354 E-.14482
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.327 Y124.658 Z4.2 F42000
G1 Z3.8
G1 E.8 F1800
G1 F1299
M204 S6000
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
M204 S10000
G1 X130.203 Y125.34 Z4.2 F42000
G1 Z3.8
G1 E.8 F1800
G1 F1299
M204 S6000
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.532 J2.019 E.01456
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
M204 S10000
G1 X130.796 Y125.971 F42000
G1 F1299
M204 S6000
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01378
M204 S10000
G1 X131.213 Y126.729 F42000
G1 F1299
M204 S6000
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00562
G1 X131.514 Y126.309 E.0033
G1 X131.611 Y126.537 E.00796
G3 X131.745 Y126.92 I-2.064 J.937 E.01307
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
M204 S10000
G1 X131.428 Y127.567 F42000
G1 F1299
M204 S6000
G1 X131.624 Y127.123 E.01561
G1 X131.799 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.845 J.868 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
M204 S10000
G1 X131.428 Y128.433 F42000
G1 F1299
M204 S6000
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.8 Y128.86 I-3.944 J-.123 E.0242
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
M204 S10000
G1 X131.212 Y129.271 F42000
G1 F1299
M204 S6000
G1 X131.598 Y128.977 E.01561
G1 X131.745 Y129.08 E.00578
G3 X131.465 Y129.781 I-4.014 J-1.197 E.02431
G1 X131.293 Y129.753 E.00561
G1 X131.222 Y129.33 E.01378
M204 S10000
G1 X130.796 Y130.029 F42000
G1 F1299
M204 S6000
G1 X131.246 Y129.839 E.01571
G1 X131.362 Y129.978 E.00583
G3 X130.922 Y130.584 I-3.583 J-2.141 E.02409
G1 X130.753 Y130.516 E.00583
G1 X130.79 Y130.089 E.01379
M204 S10000
G1 X130.203 Y130.66 F42000
G1 F1299
M204 S6000
G1 X130.686 Y130.588 E.01571
G1 X130.767 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.958 J-2.964 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.183 Y130.717 E.01368
M204 S10000
G1 X129.741 Y131.152 F42000
G1 F1299
M204 S6000
G1 X129.955 Y131.174 E.00694
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.015 J-3.39 E.0242
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00675
M204 S10000
G1 X128.81 Y131.451 F42000
G1 F1299
M204 S6000
G1 X129.104 Y131.559 E.01005
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.101 J-3.787 E.0242
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.00359
M204 S10000
G1 X127.785 Y131.446 F42000
G1 F1299
M204 S6000
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.196 E.02431
G1 X127.352 Y131.671 E.00562
G1 X127.732 Y131.474 E.01378
M204 S10000
G1 X126.935 Y131.284 F42000
G1 F1299
M204 S6000
G1 X127.256 Y131.653 E.01571
G1 X127.159 Y131.806 E.00583
G3 X126.447 Y131.575 I.929 J-4.07 E.02409
G1 X126.459 Y131.394 E.00583
G1 X126.877 Y131.297 E.01379
M204 S10000
G1 X126.152 Y130.915 F42000
G1 F1299
M204 S6000
G1 X126.37 Y131.352 E.0157
G1 X126.248 Y131.476 E.00562
G3 X125.609 Y131.074 I1.906 J-3.731 E.02431
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
M204 S10000
G1 X125.485 Y130.364 F42000
G1 F1299
M204 S6000
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.599 J-2.962 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
M204 S10000
G1 X124.977 Y129.663 F42000
G1 F1299
M204 S6000
G1 X124.958 Y130.147 E.01558
G1 X124.786 Y130.195 E.00572
G3 X124.425 Y129.536 I3.262 J-2.218 E.0242
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
M204 S10000
G1 X124.658 Y128.859 F42000
G1 F1299
M204 S6000
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G3 X124.154 Y128.594 I3.955 J-1.392 E.02431
G1 X124.31 Y128.516 E.00562
G1 X124.615 Y128.817 E.01378
M204 S10000
G1 X124.549 Y128 F42000
G1 F1299
M204 S6000
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
M204 S10000
G1 X124.658 Y127.141 F42000
G1 F1299
M204 S6000
G1 X124.31 Y127.484 E.01571
G1 X124.154 Y127.406 E.00562
G3 X124.339 Y126.674 I4.145 J.662 E.02431
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
M204 S10000
G1 X124.977 Y126.337 F42000
G1 F1299
M204 S6000
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.619 J1.556 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
M204 S10000
G1 X125.485 Y125.636 F42000
G1 F1299
M204 S6000
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.114 J2.414 E.0242
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
M204 S10000
G1 X126.152 Y125.085 F42000
G1 F1299
M204 S6000
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.524 I2.544 J3.329 E.02431
G1 X126.37 Y124.648 E.00562
G1 X126.179 Y125.031 E.01378
M204 S10000
G1 X126.935 Y124.716 F42000
G1 F1299
M204 S6000
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
M204 S10000
G1 X123.73 Y128.381 Z4.2 F42000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1299
M204 S5000
G1 X123.706 Y128 E.01138
G3 X126.677 Y123.92 I4.287 J0 E.16072
G3 X128.459 Y123.738 I1.328 J4.189 E.05374
G3 X123.729 Y128.438 I-.465 J4.262 E.57481
; OBJECT_ID: 114
; WIPE_START
G1 F6364.704
M204 S6000
G1 X123.706 Y128 E-.16653
G1 X123.73 Y127.615 E-.14639
G1 X123.781 Y127.234 E-.14628
G1 X123.867 Y126.859 E-.14628
G1 X123.986 Y126.493 E-.14622
G1 X123.995 Y126.473 E-.00831
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S10000
G1 X116.362 Y126.506 Z4.2 F42000
G1 X104.382 Y126.557 Z4.2
G1 Z3.8
G1 E.8 F1800
G1 F1299
M204 S5000
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
M204 S6000
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18164
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.79 Y124.554 Z4.2 F42000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1299
M204 S6000
M73 P91 R1
G1 X106.356 Y124.329 E.01571
G1 X106.383 Y124.156 E.00562
G3 X107.136 Y124.107 I.651 J4.145 E.02431
G1 X107.189 Y124.278 E.00578
G1 X106.839 Y124.52 E.01368
M204 S10000
G1 X107.292 Y124.285 F42000
G1 F1299
M204 S6000
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
M204 S10000
G1 X108.331 Y124.658 Z4.2 F42000
G1 Z3.8
G1 E.8 F1800
G1 F1299
M204 S6000
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
M204 S10000
G1 X109.208 Y125.34 Z4.2 F42000
G1 Z3.8
G1 E.8 F1800
G1 F1299
M204 S6000
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.532 J2.019 E.01456
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
M204 S10000
G1 X109.8 Y125.971 F42000
G1 F1299
M204 S6000
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01378
M204 S10000
G1 X110.217 Y126.729 F42000
G1 F1299
M204 S6000
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00562
G1 X110.518 Y126.309 E.0033
G1 X110.615 Y126.537 E.00796
G3 X110.749 Y126.92 I-2.064 J.937 E.01307
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
M204 S10000
G1 X110.432 Y127.567 F42000
G1 F1299
M204 S6000
G1 X110.628 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.845 J.868 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
M204 S10000
G1 X110.432 Y128.433 F42000
G1 F1299
M204 S6000
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.944 J-.123 E.0242
G1 X110.629 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
M204 S10000
G1 X110.217 Y129.271 F42000
G1 F1299
M204 S6000
G1 X110.603 Y128.977 E.01561
G1 X110.749 Y129.08 E.00578
G3 X110.469 Y129.781 I-4.014 J-1.197 E.02431
G1 X110.297 Y129.753 E.00561
G1 X110.227 Y129.33 E.01378
M204 S10000
G1 X109.8 Y130.029 F42000
G1 F1299
M204 S6000
G1 X110.25 Y129.839 E.01571
G1 X110.366 Y129.978 E.00583
G3 X109.926 Y130.584 I-3.583 J-2.141 E.02409
G1 X109.758 Y130.516 E.00583
G1 X109.795 Y130.089 E.01379
M204 S10000
G1 X109.208 Y130.66 F42000
G1 F1299
M204 S6000
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.958 J-2.964 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.188 Y130.717 E.01368
M204 S10000
G1 X108.745 Y131.152 F42000
G1 F1299
M204 S6000
G1 X108.96 Y131.174 E.00694
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.015 J-3.39 E.0242
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.685 Y131.145 E.00675
M204 S10000
G1 X107.815 Y131.451 F42000
G1 F1299
M204 S6000
G1 X108.108 Y131.559 E.01005
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.101 J-3.787 E.0242
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.759 Y131.43 E.00359
M204 S10000
G1 X106.79 Y131.446 F42000
G1 F1299
M204 S6000
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.196 E.02431
G1 X106.356 Y131.671 E.00562
G1 X106.737 Y131.474 E.01378
M204 S10000
G1 X105.94 Y131.284 F42000
G1 F1299
M204 S6000
G1 X106.26 Y131.653 E.01571
G1 X106.163 Y131.806 E.00583
G3 X105.452 Y131.575 I.929 J-4.07 E.02409
G1 X105.464 Y131.394 E.00583
G1 X105.881 Y131.297 E.01379
M204 S10000
G1 X105.157 Y130.915 F42000
G1 F1299
M204 S6000
G1 X105.375 Y131.352 E.0157
G1 X105.252 Y131.476 E.00562
G3 X104.614 Y131.074 I1.906 J-3.731 E.02431
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
M204 S10000
G1 X104.49 Y130.364 F42000
G1 F1299
M204 S6000
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.599 J-2.962 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
M204 S10000
G1 X103.981 Y129.663 F42000
G1 F1299
M204 S6000
G1 X103.962 Y130.147 E.01558
G1 X103.791 Y130.195 E.00572
G3 X103.429 Y129.536 I3.262 J-2.218 E.0242
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
M204 S10000
G1 X103.662 Y128.859 F42000
G1 F1299
M204 S6000
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G3 X103.158 Y128.594 I3.955 J-1.392 E.02431
G1 X103.314 Y128.516 E.00562
G1 X103.62 Y128.817 E.01378
M204 S10000
G1 X103.554 Y128 F42000
G1 F1299
M204 S6000
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
M204 S10000
G1 X103.662 Y127.141 F42000
G1 F1299
M204 S6000
G1 X103.314 Y127.484 E.01571
G1 X103.158 Y127.406 E.00562
G3 X103.344 Y126.674 I4.145 J.662 E.02431
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
M204 S10000
G1 X103.981 Y126.337 F42000
G1 F1299
M204 S6000
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.619 J1.556 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
M204 S10000
G1 X104.49 Y125.636 F42000
G1 F1299
M204 S6000
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.114 J2.414 E.0242
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
M204 S10000
G1 X105.157 Y125.085 F42000
G1 F1299
M204 S6000
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.524 I2.544 J3.329 E.02431
G1 X105.375 Y124.648 E.00562
G1 X105.183 Y125.031 E.01378
M204 S10000
G1 X105.94 Y124.716 F42000
G1 F1299
M204 S6000
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
M204 S10000
G1 X102.734 Y128.381 Z4.2 F42000
G1 Z3.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1299
M204 S5000
G1 X102.711 Y128 E.01138
G3 X105.681 Y123.92 I4.287 J0 E.16072
G3 X107.463 Y123.738 I1.328 J4.189 E.05374
G3 X102.733 Y128.438 I-.465 J4.262 E.57481
; WIPE_START
G1 F6364.704
M204 S6000
G1 X102.711 Y128 E-.16653
G1 X102.734 Y127.615 E-.14639
G1 X102.786 Y127.234 E-.14628
G1 X102.872 Y126.859 E-.14628
G1 X102.99 Y126.493 E-.14622
G1 X102.999 Y126.473 E-.00831
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.2 I1.217 J0 P1  F42000
; stop printing object, unique label id: 114
M625
; object ids of layer 19 start: 78,114
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


; object ids of this layer19 end: 78,114
M625
; CHANGE_LAYER
; Z_HEIGHT: 4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 20/23
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F42000
G1 Z4
G1 E.8 F1800
G1 F1298
M204 S5000
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
M204 S6000
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18164
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.785 Y124.554 Z4.4 F42000
G1 Z4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1298
M204 S6000
G1 X127.352 Y124.329 E.01571
G1 X127.378 Y124.156 E.00562
G3 X128.131 Y124.107 I.652 J4.148 E.02431
G1 X128.185 Y124.278 E.00578
G1 X127.835 Y124.52 E.01368
M204 S10000
G1 X128.288 Y124.285 F42000
G1 F1298
M204 S6000
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
M204 S10000
G1 X129.343 Y124.682 Z4.4 F42000
G1 Z4
G1 E.8 F1800
G1 F1298
M204 S6000
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
M204 S10000
G1 X130.203 Y125.34 Z4.4 F42000
G1 Z4
G1 E.8 F1800
G1 F1298
M204 S6000
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
M73 P92 R1
G3 X130.767 Y125.257 I-1.531 J2.019 E.01455
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
M204 S10000
G1 X130.796 Y125.971 F42000
G1 F1298
M204 S6000
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01378
M204 S10000
G1 X131.213 Y126.729 F42000
G1 F1298
M204 S6000
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00562
G1 X131.514 Y126.309 E.0033
G1 X131.624 Y126.566 E.00899
G3 X131.745 Y126.92 I-1.908 J.853 E.01203
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
M204 S10000
G1 X131.428 Y127.567 F42000
G1 F1298
M204 S6000
G1 X131.624 Y127.123 E.01561
G1 X131.799 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.845 J.868 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
M204 S10000
G1 X131.428 Y128.433 F42000
G1 F1298
M204 S6000
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.8 Y128.86 I-3.944 J-.123 E.0242
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
M204 S10000
G1 X131.213 Y129.271 F42000
G1 F1298
M204 S6000
G1 X131.598 Y128.977 E.01561
G1 X131.745 Y129.08 E.00578
G3 X131.465 Y129.781 I-4.017 J-1.198 E.02431
G1 X131.293 Y129.753 E.00562
G1 X131.222 Y129.33 E.01378
M204 S10000
G1 X130.796 Y130.029 F42000
G1 F1298
M204 S6000
G1 X131.246 Y129.839 E.01571
G1 X131.362 Y129.978 E.00583
G3 X130.922 Y130.584 I-3.583 J-2.141 E.02409
G1 X130.753 Y130.516 E.00583
G1 X130.79 Y130.089 E.01378
M204 S10000
G1 X130.203 Y130.66 F42000
G1 F1298
M204 S6000
G1 X130.686 Y130.588 E.01571
G1 X130.767 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.958 J-2.964 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.183 Y130.717 E.01368
M204 S10000
G1 X129.741 Y131.152 F42000
G1 F1298
M204 S6000
G1 X129.955 Y131.174 E.00694
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.015 J-3.389 E.0242
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00674
M204 S10000
G1 X128.81 Y131.451 F42000
G1 F1298
M204 S6000
G1 X129.104 Y131.559 E.01006
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.101 J-3.786 E.0242
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.00359
M204 S10000
G1 X127.785 Y131.446 F42000
G1 F1298
M204 S6000
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.196 E.02431
G1 X127.352 Y131.671 E.00562
G1 X127.732 Y131.474 E.01378
M204 S10000
G1 X126.935 Y131.284 F42000
G1 F1298
M204 S6000
G1 X127.256 Y131.653 E.01572
G1 X127.159 Y131.806 E.00583
G3 X126.447 Y131.575 I.929 J-4.07 E.02409
G1 X126.459 Y131.394 E.00583
G1 X126.877 Y131.297 E.01379
M204 S10000
G1 X126.152 Y130.915 F42000
G1 F1298
M204 S6000
G1 X126.37 Y131.352 E.0157
G1 X126.248 Y131.476 E.00562
G3 X125.609 Y131.074 I1.906 J-3.731 E.02431
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
M204 S10000
G1 X125.485 Y130.364 F42000
G1 F1298
M204 S6000
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.599 J-2.961 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
M204 S10000
G1 X124.977 Y129.663 F42000
G1 F1298
M204 S6000
G1 X124.958 Y130.147 E.01558
G1 X124.786 Y130.195 E.00572
G3 X124.425 Y129.536 I3.259 J-2.216 E.0242
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
M204 S10000
G1 X124.658 Y128.859 F42000
G1 F1298
M204 S6000
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G3 X124.154 Y128.594 I3.956 J-1.392 E.02431
G1 X124.31 Y128.516 E.00562
G1 X124.615 Y128.817 E.01378
M204 S10000
G1 X124.549 Y128 F42000
G1 F1298
M204 S6000
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
M204 S10000
G1 X124.658 Y127.141 F42000
G1 F1298
M204 S6000
G1 X124.31 Y127.484 E.01571
G1 X124.154 Y127.406 E.00562
G3 X124.339 Y126.674 I4.143 J.661 E.02431
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
M204 S10000
G1 X124.977 Y126.337 F42000
G1 F1298
M204 S6000
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.619 J1.556 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
M204 S10000
G1 X125.485 Y125.636 F42000
G1 F1298
M204 S6000
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.115 J2.415 E.0242
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
M204 S10000
G1 X126.152 Y125.085 F42000
G1 F1298
M204 S6000
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.524 I2.544 J3.329 E.02431
G1 X126.37 Y124.648 E.00562
G1 X126.179 Y125.031 E.01378
M204 S10000
G1 X126.935 Y124.716 F42000
G1 F1298
M204 S6000
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
M204 S10000
G1 X123.729 Y128.376 Z4.4 F42000
G1 Z4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1298
M204 S5000
G1 X123.715 Y128 E.0112
G3 X123.959 Y126.576 I4.287 J0 E.04324
G3 X128.491 Y123.741 I4.036 J1.412 E.172
G3 X131.984 Y126.412 I-.494 J4.266 E.13751
G3 X123.738 Y128.435 I-3.982 J1.588 E.43662
; OBJECT_ID: 114
; WIPE_START
G1 F6364.704
M204 S6000
G1 X123.715 Y128 E-.16543
G1 X123.73 Y127.615 E-.14622
G1 X123.781 Y127.234 E-.14628
G1 X123.867 Y126.859 E-.14628
G1 X123.959 Y126.576 E-.11303
G1 X123.959 Y126.576 E0
G1 X124.001 Y126.472 E-.04276
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S10000
G1 X116.369 Y126.505 Z4.4 F42000
G1 X104.382 Y126.557 Z4.4
G1 Z4
G1 E.8 F1800
G1 F1298
M204 S5000
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
M204 S6000
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18164
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.79 Y124.554 Z4.4 F42000
G1 Z4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1298
M204 S6000
G1 X106.356 Y124.329 E.01571
G1 X106.383 Y124.156 E.00562
G3 X107.136 Y124.107 I.652 J4.148 E.02431
G1 X107.189 Y124.278 E.00578
G1 X106.839 Y124.52 E.01368
M204 S10000
G1 X107.292 Y124.285 F42000
G1 F1298
M204 S6000
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
M204 S10000
G1 X108.347 Y124.682 Z4.4 F42000
G1 Z4
G1 E.8 F1800
G1 F1298
M204 S6000
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
M204 S10000
G1 X109.208 Y125.34 Z4.4 F42000
G1 Z4
G1 E.8 F1800
G1 F1298
M204 S6000
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.531 J2.019 E.01455
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
M204 S10000
G1 X109.8 Y125.971 F42000
G1 F1298
M204 S6000
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01378
M204 S10000
G1 X110.217 Y126.729 F42000
G1 F1298
M204 S6000
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00562
G1 X110.518 Y126.309 E.0033
G1 X110.628 Y126.566 E.00899
G3 X110.749 Y126.92 I-1.908 J.853 E.01203
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
M204 S10000
G1 X110.432 Y127.567 F42000
G1 F1298
M204 S6000
G1 X110.628 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.845 J.868 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
M204 S10000
G1 X110.432 Y128.433 F42000
G1 F1298
M204 S6000
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.944 J-.123 E.0242
G1 X110.629 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
M204 S10000
G1 X110.217 Y129.271 F42000
G1 F1298
M204 S6000
G1 X110.603 Y128.977 E.01561
G1 X110.749 Y129.08 E.00578
G3 X110.469 Y129.781 I-4.017 J-1.198 E.02431
G1 X110.297 Y129.753 E.00562
G1 X110.227 Y129.33 E.01378
M204 S10000
G1 X109.8 Y130.029 F42000
G1 F1298
M204 S6000
G1 X110.25 Y129.839 E.01571
G1 X110.366 Y129.978 E.00583
G3 X109.926 Y130.584 I-3.583 J-2.141 E.02409
G1 X109.758 Y130.516 E.00583
G1 X109.795 Y130.089 E.01378
M204 S10000
G1 X109.208 Y130.66 F42000
G1 F1298
M204 S6000
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.958 J-2.964 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.188 Y130.717 E.01368
M204 S10000
G1 X108.745 Y131.152 F42000
G1 F1298
M204 S6000
G1 X108.96 Y131.174 E.00694
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.015 J-3.389 E.0242
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.685 Y131.145 E.00674
M204 S10000
G1 X107.815 Y131.451 F42000
G1 F1298
M204 S6000
G1 X108.108 Y131.559 E.01006
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.101 J-3.786 E.0242
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.758 Y131.43 E.00359
M204 S10000
G1 X106.79 Y131.446 F42000
G1 F1298
M204 S6000
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.196 E.02431
G1 X106.356 Y131.671 E.00562
G1 X106.737 Y131.474 E.01378
M204 S10000
G1 X105.94 Y131.284 F42000
G1 F1298
M204 S6000
G1 X106.26 Y131.653 E.01572
G1 X106.163 Y131.806 E.00583
G3 X105.452 Y131.575 I.929 J-4.07 E.02409
G1 X105.464 Y131.394 E.00583
G1 X105.881 Y131.297 E.01379
M204 S10000
G1 X105.157 Y130.915 F42000
G1 F1298
M204 S6000
G1 X105.375 Y131.352 E.0157
G1 X105.252 Y131.476 E.00562
G3 X104.614 Y131.074 I1.906 J-3.731 E.02431
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
M204 S10000
G1 X104.49 Y130.364 F42000
G1 F1298
M204 S6000
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.599 J-2.961 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
M204 S10000
G1 X103.981 Y129.663 F42000
G1 F1298
M204 S6000
G1 X103.962 Y130.147 E.01558
G1 X103.791 Y130.195 E.00572
G3 X103.429 Y129.536 I3.259 J-2.216 E.0242
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
M204 S10000
G1 X103.662 Y128.859 F42000
G1 F1298
M204 S6000
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G3 X103.158 Y128.594 I3.956 J-1.392 E.02431
G1 X103.314 Y128.516 E.00562
G1 X103.62 Y128.817 E.01378
M204 S10000
G1 X103.554 Y128 F42000
G1 F1298
M204 S6000
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
M204 S10000
G1 X103.662 Y127.141 F42000
G1 F1298
M204 S6000
G1 X103.314 Y127.484 E.01571
G1 X103.158 Y127.406 E.00562
G3 X103.344 Y126.674 I4.143 J.661 E.02431
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
M204 S10000
G1 X103.981 Y126.337 F42000
G1 F1298
M204 S6000
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.619 J1.556 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
M204 S10000
G1 X104.49 Y125.636 F42000
G1 F1298
M204 S6000
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.115 J2.415 E.0242
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
M204 S10000
G1 X105.157 Y125.085 F42000
G1 F1298
M204 S6000
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.524 I2.544 J3.329 E.02431
G1 X105.375 Y124.648 E.00562
G1 X105.183 Y125.031 E.01378
M204 S10000
G1 X105.94 Y124.716 F42000
G1 F1298
M204 S6000
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
M204 S10000
G1 X102.734 Y128.376 Z4.4 F42000
G1 Z4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1298
M204 S5000
G1 X102.72 Y128 E.0112
G3 X102.963 Y126.576 I4.287 J0 E.04324
G3 X107.495 Y123.741 I4.036 J1.412 E.172
G3 X110.989 Y126.412 I-.494 J4.266 E.13751
G3 X102.742 Y128.435 I-3.982 J1.588 E.43662
; WIPE_START
G1 F6364.704
M204 S6000
G1 X102.72 Y128 E-.16543
G1 X102.734 Y127.615 E-.14622
G1 X102.786 Y127.234 E-.14628
G1 X102.872 Y126.859 E-.14628
G1 X102.963 Y126.576 E-.11303
G1 X102.963 Y126.576 E0
G1 X103.006 Y126.472 E-.04277
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.4 I1.217 J0 P1  F42000
; stop printing object, unique label id: 114
M625
; object ids of layer 20 start: 78,114
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


; object ids of this layer20 end: 78,114
M625
; CHANGE_LAYER
; Z_HEIGHT: 4.2
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 21/23
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
M73 P93 R1
G1 X125.378 Y126.557 F42000
G1 Z4.2
G1 E.8 F1800
G1 F1299
M204 S5000
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
M204 S6000
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18164
G1 X125.92 Y125.482 E-.18164
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02174
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.785 Y124.554 Z4.6 F42000
G1 Z4.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1299
M204 S6000
G1 X127.352 Y124.329 E.01571
G1 X127.378 Y124.156 E.00562
G3 X128.131 Y124.107 I.652 J4.147 E.02431
G1 X128.185 Y124.278 E.00578
G1 X127.835 Y124.52 E.01368
M204 S10000
G1 X128.288 Y124.285 F42000
G1 F1299
M204 S6000
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
M204 S10000
G1 X129.358 Y124.704 Z4.6 F42000
G1 Z4.2
G1 E.8 F1800
G1 F1299
M204 S6000
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
M204 S10000
G1 X130.203 Y125.34 Z4.6 F42000
G1 Z4.2
G1 E.8 F1800
G1 F1299
M204 S6000
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.533 J2.02 E.01456
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
M204 S10000
G1 X130.796 Y125.971 F42000
G1 F1299
M204 S6000
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01379
M204 S10000
G1 X131.212 Y126.729 F42000
M73 P93 R0
G1 F1299
M204 S6000
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00561
G1 X131.514 Y126.309 E.0033
G3 X131.745 Y126.92 I-3.278 J1.591 E.02103
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
M204 S10000
G1 X131.428 Y127.567 F42000
G1 F1299
M204 S6000
G1 X131.624 Y127.123 E.01561
G1 X131.799 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.845 J.868 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
M204 S10000
G1 X131.428 Y128.433 F42000
G1 F1299
M204 S6000
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.799 Y128.86 I-3.943 J-.123 E.02421
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
M204 S10000
G1 X131.212 Y129.271 F42000
G1 F1299
M204 S6000
G1 X131.598 Y128.976 E.01561
G1 X131.745 Y129.08 E.00578
G3 X131.465 Y129.781 I-4.02 J-1.199 E.02431
G1 X131.293 Y129.753 E.00562
G1 X131.222 Y129.33 E.01378
M204 S10000
G1 X130.796 Y130.029 F42000
G1 F1299
M204 S6000
G1 X131.246 Y129.839 E.01571
G1 X131.362 Y129.978 E.00583
G3 X130.922 Y130.584 I-3.582 J-2.14 E.02409
G1 X130.753 Y130.516 E.00583
G1 X130.79 Y130.089 E.01379
M204 S10000
G1 X130.203 Y130.66 F42000
G1 F1299
M204 S6000
G1 X130.686 Y130.588 E.01571
G1 X130.767 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.958 J-2.963 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.183 Y130.717 E.01368
M204 S10000
G1 X129.741 Y131.152 F42000
G1 F1299
M204 S6000
G1 X129.955 Y131.174 E.00694
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.014 J-3.389 E.02421
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00674
M204 S10000
G1 X128.81 Y131.451 F42000
G1 F1299
M204 S6000
G1 X129.104 Y131.559 E.01006
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.101 J-3.786 E.02421
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.00359
M204 S10000
G1 X127.785 Y131.446 F42000
G1 F1299
M204 S6000
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.196 E.02431
G1 X127.352 Y131.671 E.00562
G1 X127.732 Y131.474 E.01378
M204 S10000
G1 X126.935 Y131.284 F42000
G1 F1299
M204 S6000
G1 X127.256 Y131.653 E.01571
G1 X127.159 Y131.806 E.00583
G3 X126.447 Y131.575 I.929 J-4.069 E.02409
G1 X126.459 Y131.394 E.00583
G1 X126.877 Y131.297 E.01379
M204 S10000
G1 X126.152 Y130.915 F42000
G1 F1299
M204 S6000
G1 X126.37 Y131.352 E.0157
G1 X126.248 Y131.477 E.00562
G3 X125.609 Y131.074 I1.907 J-3.734 E.02431
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
M204 S10000
G1 X125.485 Y130.364 F42000
G1 F1299
M204 S6000
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.6 J-2.962 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
M204 S10000
G1 X124.977 Y129.663 F42000
G1 F1299
M204 S6000
G1 X124.958 Y130.147 E.01558
G1 X124.786 Y130.195 E.00572
G3 X124.425 Y129.536 I3.259 J-2.216 E.0242
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
M204 S10000
G1 X124.658 Y128.859 F42000
G1 F1299
M204 S6000
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G3 X124.154 Y128.594 I3.95 J-1.391 E.02431
G1 X124.31 Y128.516 E.00562
G1 X124.615 Y128.817 E.01378
M204 S10000
G1 X124.549 Y128 F42000
G1 F1299
M204 S6000
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
M204 S10000
G1 X124.658 Y127.141 F42000
G1 F1299
M204 S6000
G1 X124.31 Y127.484 E.01571
G1 X124.154 Y127.406 E.00562
G3 X124.339 Y126.674 I4.14 J.66 E.02431
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
M204 S10000
G1 X124.977 Y126.337 F42000
G1 F1299
M204 S6000
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.621 J1.557 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
M204 S10000
G1 X125.485 Y125.636 F42000
G1 F1299
M204 S6000
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.113 J2.413 E.02421
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
M204 S10000
G1 X126.152 Y125.085 F42000
G1 F1299
M204 S6000
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.523 I2.546 J3.33 E.02431
G1 X126.371 Y124.648 E.00562
G1 X126.179 Y125.031 E.01378
M204 S10000
G1 X126.935 Y124.716 F42000
G1 F1299
M204 S6000
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
M204 S10000
G1 X123.729 Y128.37 Z4.6 F42000
G1 Z4.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1299
M204 S5000
G1 X123.706 Y128 E.01105
G3 X127.426 Y123.749 I4.288 J-.001 E.1837
G3 X128.523 Y123.744 I.569 J4.681 E.03274
G3 X123.728 Y128.429 I-.529 J4.255 E.57325
; OBJECT_ID: 114
; WIPE_START
G1 F6364.704
M204 S6000
G1 X123.706 Y128 E-.16323
G1 X123.73 Y127.616 E-.14635
G1 X123.781 Y127.234 E-.14636
G1 X123.867 Y126.859 E-.14624
G1 X123.986 Y126.493 E-.14627
G1 X123.998 Y126.465 E-.01156
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S10000
G1 X116.366 Y126.501 Z4.6 F42000
G1 X104.382 Y126.557 Z4.6
G1 Z4.2
G1 E.8 F1800
G1 F1299
M204 S5000
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
M73 P94 R0
G1 X103.969 Y126.797 E.01424
G1 X104.33 Y126.587 E.01245
; WIPE_START
G1 F6364.704
M204 S6000
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18164
G1 X104.924 Y125.482 E-.18164
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02174
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.79 Y124.554 Z4.6 F42000
G1 Z4.2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1299
M204 S6000
G1 X106.356 Y124.329 E.01571
G1 X106.383 Y124.156 E.00562
G3 X107.136 Y124.107 I.652 J4.147 E.02431
G1 X107.189 Y124.278 E.00578
G1 X106.839 Y124.52 E.01368
M204 S10000
G1 X107.292 Y124.285 F42000
G1 F1299
M204 S6000
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
M204 S10000
G1 X108.362 Y124.704 Z4.6 F42000
G1 Z4.2
G1 E.8 F1800
G1 F1299
M204 S6000
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
M204 S10000
G1 X109.208 Y125.34 Z4.6 F42000
G1 Z4.2
G1 E.8 F1800
G1 F1299
M204 S6000
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.533 J2.02 E.01456
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
M204 S10000
G1 X109.8 Y125.971 F42000
G1 F1299
M204 S6000
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01379
M204 S10000
G1 X110.217 Y126.729 F42000
G1 F1299
M204 S6000
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00561
G1 X110.518 Y126.309 E.0033
G3 X110.749 Y126.92 I-3.278 J1.591 E.02103
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
M204 S10000
G1 X110.432 Y127.567 F42000
G1 F1299
M204 S6000
G1 X110.628 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.845 J.868 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
M204 S10000
G1 X110.432 Y128.433 F42000
G1 F1299
M204 S6000
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.943 J-.123 E.02421
G1 X110.628 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
M204 S10000
G1 X110.217 Y129.271 F42000
G1 F1299
M204 S6000
G1 X110.603 Y128.976 E.01561
G1 X110.749 Y129.08 E.00578
G3 X110.469 Y129.781 I-4.02 J-1.199 E.02431
G1 X110.297 Y129.753 E.00562
G1 X110.227 Y129.33 E.01378
M204 S10000
G1 X109.8 Y130.029 F42000
G1 F1299
M204 S6000
G1 X110.25 Y129.839 E.01571
G1 X110.366 Y129.978 E.00583
G3 X109.926 Y130.584 I-3.582 J-2.14 E.02409
G1 X109.758 Y130.516 E.00583
G1 X109.795 Y130.089 E.01379
M204 S10000
G1 X109.208 Y130.66 F42000
G1 F1299
M204 S6000
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.958 J-2.963 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.188 Y130.717 E.01368
M204 S10000
G1 X108.745 Y131.152 F42000
G1 F1299
M204 S6000
G1 X108.96 Y131.174 E.00694
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.014 J-3.389 E.02421
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.685 Y131.145 E.00674
M204 S10000
G1 X107.815 Y131.451 F42000
G1 F1299
M204 S6000
G1 X108.108 Y131.559 E.01006
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.101 J-3.786 E.02421
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.758 Y131.43 E.00359
M204 S10000
G1 X106.79 Y131.446 F42000
G1 F1299
M204 S6000
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.196 E.02431
G1 X106.356 Y131.671 E.00562
G1 X106.737 Y131.474 E.01378
M204 S10000
G1 X105.94 Y131.284 F42000
G1 F1299
M204 S6000
G1 X106.26 Y131.653 E.01571
G1 X106.163 Y131.806 E.00583
G3 X105.452 Y131.575 I.929 J-4.069 E.02409
G1 X105.464 Y131.394 E.00583
G1 X105.881 Y131.297 E.01379
M204 S10000
G1 X105.157 Y130.915 F42000
G1 F1299
M204 S6000
G1 X105.375 Y131.352 E.0157
G1 X105.252 Y131.477 E.00562
G3 X104.614 Y131.074 I1.907 J-3.734 E.02431
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
M204 S10000
G1 X104.49 Y130.364 F42000
G1 F1299
M204 S6000
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.6 J-2.962 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
M204 S10000
G1 X103.981 Y129.663 F42000
G1 F1299
M204 S6000
G1 X103.962 Y130.147 E.01558
G1 X103.791 Y130.195 E.00572
G3 X103.429 Y129.536 I3.259 J-2.216 E.0242
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
M204 S10000
G1 X103.662 Y128.859 F42000
G1 F1299
M204 S6000
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G3 X103.158 Y128.594 I3.95 J-1.391 E.02431
G1 X103.314 Y128.516 E.00562
G1 X103.62 Y128.817 E.01378
M204 S10000
G1 X103.554 Y128 F42000
G1 F1299
M204 S6000
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
M204 S10000
G1 X103.662 Y127.141 F42000
G1 F1299
M204 S6000
G1 X103.314 Y127.484 E.01571
G1 X103.158 Y127.406 E.00562
G3 X103.344 Y126.674 I4.14 J.66 E.02431
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
M204 S10000
G1 X103.981 Y126.337 F42000
G1 F1299
M204 S6000
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.621 J1.557 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
M204 S10000
G1 X104.49 Y125.636 F42000
G1 F1299
M204 S6000
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.113 J2.413 E.02421
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
M204 S10000
G1 X105.157 Y125.085 F42000
G1 F1299
M204 S6000
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.523 I2.546 J3.33 E.02431
G1 X105.375 Y124.648 E.00562
G1 X105.183 Y125.031 E.01378
M204 S10000
G1 X105.94 Y124.716 F42000
G1 F1299
M204 S6000
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
M204 S10000
G1 X102.734 Y128.37 Z4.6 F42000
G1 Z4.2
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1299
M204 S5000
G1 X102.71 Y128 E.01105
G3 X106.431 Y123.749 I4.288 J-.001 E.1837
G3 X107.528 Y123.744 I.569 J4.681 E.03274
G3 X102.732 Y128.429 I-.529 J4.255 E.57325
; WIPE_START
G1 F6364.704
M204 S6000
G1 X102.71 Y128 E-.16323
G1 X102.734 Y127.616 E-.14635
G1 X102.786 Y127.234 E-.14636
G1 X102.872 Y126.859 E-.14624
G1 X102.99 Y126.493 E-.14627
G1 X103.002 Y126.465 E-.01156
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.6 I1.217 J0 P1  F42000
; stop printing object, unique label id: 114
M625
; object ids of layer 21 start: 78,114
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


; object ids of this layer21 end: 78,114
M625
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 22/23
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F42000
G1 Z4.4
G1 E.8 F1800
G1 F1276
M204 S5000
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
M204 S6000
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18164
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18163
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.785 Y124.554 Z4.8 F42000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1276
M204 S6000
G1 X127.352 Y124.329 E.0157
G1 X127.378 Y124.156 E.00561
G3 X128.131 Y124.107 I.651 J4.133 E.02431
G1 X128.185 Y124.278 E.00578
G1 X127.835 Y124.52 E.01368
M204 S10000
G1 X128.288 Y124.285 F42000
G1 F1276
M204 S6000
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
M73 P95 R0
G1 X128.649 Y124.608 E-.18409
G1 X128.365 Y124.354 E-.14482
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.372 Y124.725 Z4.8 F42000
G1 Z4.4
G1 E.8 F1800
G1 F1276
M204 S6000
G1 X129.203 Y124.473 E.00976
G1 X129.314 Y124.334 E.00572
G1 X129.534 Y124.416 E.00756
G3 X129.993 Y124.654 I-1.092 J2.671 E.01666
G1 X129.955 Y124.826 E.00567
G1 X129.472 Y124.876 E.01561
G1 X129.405 Y124.775 E.00389
M204 S10000
G1 X130.203 Y125.34 F42000
G1 F1276
M204 S6000
G1 X130.042 Y124.882 E.01561
G1 X130.186 Y124.774 E.00578
G1 X130.432 Y124.953 E.00977
G3 X130.767 Y125.257 I-1.53 J2.017 E.01456
G1 X130.686 Y125.412 E.00562
G1 X130.262 Y125.349 E.01378
M204 S10000
G1 X130.796 Y125.971 F42000
G1 F1276
M204 S6000
G1 X130.753 Y125.484 E.01571
G1 X130.922 Y125.416 E.00583
G1 X131.155 Y125.709 E.01204
G1 X131.362 Y126.022 E.01204
G1 X131.246 Y126.161 E.00583
G1 X130.851 Y125.994 E.01378
M204 S10000
G1 X131.213 Y126.729 F42000
G1 F1276
M204 S6000
G1 X131.293 Y126.247 E.01571
G1 X131.465 Y126.219 E.00562
G1 X131.514 Y126.309 E.0033
G3 X131.745 Y126.92 I-3.276 J1.59 E.02103
G1 X131.598 Y127.023 E.00578
G1 X131.26 Y126.765 E.01368
M204 S10000
G1 X131.428 Y127.567 F42000
G1 F1276
M204 S6000
G1 X131.624 Y127.123 E.01561
G1 X131.8 Y127.14 E.00567
G3 X131.894 Y127.886 I-3.847 J.869 E.0242
G1 X131.728 Y127.948 E.00572
G1 X131.465 Y127.614 E.01365
M204 S10000
G1 X131.428 Y128.433 F42000
G1 F1276
M204 S6000
G1 X131.728 Y128.052 E.01558
G1 X131.894 Y128.114 E.00572
G3 X131.8 Y128.86 I-3.942 J-.123 E.0242
G1 X131.624 Y128.877 E.00567
G1 X131.452 Y128.488 E.01368
M204 S10000
G1 X131.213 Y129.271 F42000
G1 F1276
M204 S6000
G1 X131.598 Y128.977 E.01561
G1 X131.745 Y129.08 E.00578
G3 X131.465 Y129.781 I-4.024 J-1.201 E.0243
G1 X131.293 Y129.753 E.00562
G1 X131.222 Y129.33 E.01378
M204 S10000
G1 X130.796 Y130.029 F42000
G1 F1276
M204 S6000
G1 X131.245 Y129.839 E.01571
G1 X131.361 Y129.978 E.00583
G3 X130.922 Y130.584 I-3.582 J-2.14 E.02409
G1 X130.753 Y130.516 E.00583
G1 X130.79 Y130.089 E.01378
M204 S10000
G1 X130.203 Y130.66 F42000
G1 F1276
M204 S6000
G1 X130.686 Y130.588 E.01571
G1 X130.767 Y130.743 E.00562
G3 X130.186 Y131.226 I-2.958 J-2.963 E.02431
G1 X130.042 Y131.118 E.00578
G1 X130.183 Y130.717 E.01368
M204 S10000
G1 X129.741 Y131.152 F42000
G1 F1276
M204 S6000
G1 X129.955 Y131.174 E.00694
G1 X129.993 Y131.346 E.00567
G3 X129.314 Y131.666 I-2.014 J-3.389 E.0242
G1 X129.203 Y131.527 E.00572
G1 X129.472 Y131.124 E.01558
G1 X129.681 Y131.145 E.00674
M204 S10000
G1 X128.81 Y131.451 F42000
G1 F1276
M204 S6000
G1 X129.104 Y131.559 E.01006
G1 X129.096 Y131.737 E.00572
G3 X128.358 Y131.877 I-1.1 J-3.784 E.0242
G1 X128.288 Y131.715 E.00567
G1 X128.649 Y131.392 E.01561
G1 X128.754 Y131.43 E.00359
M204 S10000
G1 X127.785 Y131.446 F42000
G1 F1276
M204 S6000
G1 X128.185 Y131.722 E.01561
G1 X128.131 Y131.893 E.00578
G3 X127.378 Y131.844 I-.102 J-4.191 E.02431
G1 X127.352 Y131.671 E.00562
G1 X127.732 Y131.474 E.01378
M204 S10000
G1 X126.935 Y131.284 F42000
G1 F1276
M204 S6000
G1 X127.256 Y131.653 E.01571
G1 X127.159 Y131.806 E.00583
G3 X126.447 Y131.575 I.928 J-4.068 E.02409
G1 X126.459 Y131.394 E.00583
G1 X126.877 Y131.297 E.01379
M204 S10000
G1 X126.152 Y130.915 F42000
G1 F1276
M204 S6000
G1 X126.37 Y131.352 E.01571
G1 X126.248 Y131.477 E.00562
G3 X125.609 Y131.074 I1.91 J-3.738 E.0243
G1 X125.667 Y130.904 E.00578
G1 X126.092 Y130.914 E.01368
M204 S10000
G1 X125.485 Y130.364 F42000
G1 F1276
M204 S6000
G1 X125.588 Y130.838 E.01561
G1 X125.436 Y130.928 E.00567
G3 X124.921 Y130.38 I2.599 J-2.961 E.0242
G1 X125.019 Y130.232 E.00572
G1 X125.428 Y130.347 E.01365
M204 S10000
G1 X124.977 Y129.663 F42000
G1 F1276
M204 S6000
G1 X124.958 Y130.147 E.01558
G1 X124.786 Y130.195 E.00572
G3 X124.425 Y129.536 I3.259 J-2.216 E.0242
G1 X124.557 Y129.42 E.00567
G1 X124.925 Y129.633 E.01368
M204 S10000
G1 X124.658 Y128.859 F42000
G1 F1276
M204 S6000
G1 X124.519 Y129.324 E.01561
G1 X124.339 Y129.326 E.00578
G3 X124.154 Y128.594 I3.958 J-1.393 E.02431
G1 X124.31 Y128.516 E.00562
G1 X124.615 Y128.817 E.01378
M204 S10000
G1 X124.549 Y128 F42000
G1 F1276
M204 S6000
G1 X124.297 Y128.419 E.01571
G1 X124.122 Y128.374 E.00583
G3 X124.122 Y127.626 I4.158 J-.374 E.02409
G1 X124.297 Y127.581 E.00583
G1 X124.519 Y127.949 E.01378
M204 S10000
G1 X124.658 Y127.141 F42000
G1 F1276
M204 S6000
G1 X124.31 Y127.484 E.01571
G1 X124.154 Y127.406 E.00562
G3 X124.339 Y126.674 I4.139 J.66 E.02431
G1 X124.519 Y126.676 E.00578
G1 X124.641 Y127.084 E.01368
M204 S10000
G1 X124.977 Y126.337 F42000
G1 F1276
M204 S6000
G1 X124.557 Y126.58 E.01561
G1 X124.425 Y126.464 E.00567
G3 X124.786 Y125.805 I3.619 J1.556 E.0242
G1 X124.958 Y125.853 E.00572
G1 X124.974 Y126.277 E.01365
M204 S10000
G1 X125.485 Y125.636 F42000
G1 F1276
M204 S6000
G1 X125.019 Y125.768 E.01558
G1 X124.921 Y125.62 E.00572
G3 X125.436 Y125.072 I3.114 J2.414 E.0242
G1 X125.588 Y125.162 E.00567
G1 X125.498 Y125.578 E.01368
M204 S10000
G1 X126.152 Y125.085 F42000
G1 F1276
M204 S6000
G1 X125.667 Y125.096 E.01561
G1 X125.609 Y124.926 E.00578
G3 X126.248 Y124.524 I2.544 J3.328 E.02431
G1 X126.37 Y124.648 E.00562
G1 X126.179 Y125.031 E.01378
M204 S10000
G1 X126.935 Y124.716 F42000
G1 F1276
M204 S6000
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
M204 S10000
G1 X123.729 Y128.365 Z4.8 F42000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1276
M204 S5000
G1 X123.709 Y128 E.0109
G3 X127.81 Y123.715 I4.288 J-.002 E.1951
G3 X128.555 Y123.747 I.192 J4.157 E.02226
G3 X123.731 Y128.425 I-.559 J4.251 E.5724
; OBJECT_ID: 114
; WIPE_START
G1 F6364.704
M204 S6000
G1 X123.709 Y128 E-.1617
G1 X123.73 Y127.616 E-.14628
G1 X123.781 Y127.234 E-.14636
G1 X123.867 Y126.859 E-.14624
G1 X123.986 Y126.493 E-.14624
G1 X124 Y126.461 E-.01319
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S10000
G1 X116.367 Y126.498 Z4.8 F42000
G1 X104.382 Y126.557 Z4.8
G1 Z4.4
G1 E.8 F1800
G1 F1276
M204 S5000
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
M204 S6000
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18164
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18163
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.79 Y124.554 Z4.8 F42000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1276
M204 S6000
G1 X106.357 Y124.329 E.0157
G1 X106.383 Y124.156 E.00561
G3 X107.136 Y124.107 I.651 J4.133 E.02431
G1 X107.189 Y124.278 E.00578
G1 X106.839 Y124.52 E.01368
M204 S10000
G1 X107.292 Y124.285 F42000
G1 F1276
M204 S6000
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
M204 S10000
G1 X108.376 Y124.725 Z4.8 F42000
G1 Z4.4
G1 E.8 F1800
G1 F1276
M204 S6000
G1 X108.208 Y124.473 E.00976
G1 X108.318 Y124.334 E.00572
G1 X108.538 Y124.416 E.00756
G3 X108.998 Y124.654 I-1.092 J2.671 E.01666
G1 X108.96 Y124.826 E.00567
G1 X108.477 Y124.876 E.01561
G1 X108.41 Y124.775 E.00389
M204 S10000
G1 X109.208 Y125.34 F42000
G1 F1276
M204 S6000
G1 X109.047 Y124.882 E.01561
G1 X109.191 Y124.774 E.00578
G1 X109.437 Y124.953 E.00977
G3 X109.771 Y125.257 I-1.53 J2.017 E.01456
G1 X109.691 Y125.412 E.00562
G1 X109.267 Y125.349 E.01378
M204 S10000
G1 X109.8 Y125.971 F42000
G1 F1276
M204 S6000
G1 X109.758 Y125.484 E.01571
G1 X109.926 Y125.416 E.00583
G1 X110.16 Y125.709 E.01204
G1 X110.366 Y126.022 E.01204
G1 X110.25 Y126.161 E.00583
G1 X109.855 Y125.994 E.01378
M204 S10000
G1 X110.217 Y126.729 F42000
G1 F1276
M204 S6000
G1 X110.297 Y126.247 E.01571
G1 X110.469 Y126.219 E.00562
G1 X110.518 Y126.309 E.0033
G3 X110.749 Y126.92 I-3.276 J1.59 E.02103
G1 X110.603 Y127.023 E.00578
G1 X110.265 Y126.765 E.01368
M204 S10000
G1 X110.432 Y127.567 F42000
G1 F1276
M204 S6000
G1 X110.629 Y127.123 E.01561
G1 X110.804 Y127.14 E.00567
G3 X110.899 Y127.886 I-3.847 J.869 E.0242
G1 X110.732 Y127.948 E.00572
G1 X110.469 Y127.614 E.01365
M204 S10000
G1 X110.432 Y128.433 F42000
G1 F1276
M204 S6000
G1 X110.732 Y128.052 E.01558
G1 X110.899 Y128.114 E.00572
G3 X110.804 Y128.86 I-3.942 J-.123 E.0242
G1 X110.629 Y128.877 E.00567
G1 X110.456 Y128.488 E.01368
M204 S10000
G1 X110.217 Y129.271 F42000
G1 F1276
M204 S6000
G1 X110.603 Y128.977 E.01561
G1 X110.749 Y129.08 E.00578
G3 X110.47 Y129.781 I-4.024 J-1.201 E.0243
G1 X110.297 Y129.753 E.00562
G1 X110.227 Y129.33 E.01378
M204 S10000
G1 X109.8 Y130.029 F42000
G1 F1276
M204 S6000
G1 X110.25 Y129.839 E.01571
G1 X110.366 Y129.978 E.00583
G3 X109.926 Y130.584 I-3.582 J-2.14 E.02409
G1 X109.758 Y130.516 E.00583
G1 X109.795 Y130.089 E.01378
M204 S10000
G1 X109.208 Y130.66 F42000
G1 F1276
M204 S6000
G1 X109.691 Y130.588 E.01571
G1 X109.771 Y130.743 E.00562
G3 X109.191 Y131.226 I-2.958 J-2.963 E.02431
G1 X109.047 Y131.118 E.00578
G1 X109.188 Y130.717 E.01368
M204 S10000
G1 X108.745 Y131.152 F42000
G1 F1276
M204 S6000
G1 X108.96 Y131.174 E.00694
G1 X108.998 Y131.346 E.00567
G3 X108.318 Y131.666 I-2.014 J-3.389 E.0242
G1 X108.208 Y131.527 E.00572
G1 X108.477 Y131.124 E.01558
G1 X108.685 Y131.145 E.00674
M204 S10000
G1 X107.815 Y131.451 F42000
G1 F1276
M204 S6000
G1 X108.108 Y131.559 E.01006
G1 X108.101 Y131.737 E.00572
G3 X107.362 Y131.877 I-1.1 J-3.784 E.0242
G1 X107.292 Y131.715 E.00567
G1 X107.654 Y131.392 E.01561
G1 X107.758 Y131.43 E.00359
M204 S10000
G1 X106.79 Y131.446 F42000
G1 F1276
M204 S6000
G1 X107.189 Y131.722 E.01561
G1 X107.136 Y131.893 E.00578
G3 X106.383 Y131.844 I-.102 J-4.191 E.02431
G1 X106.356 Y131.671 E.00562
G1 X106.737 Y131.474 E.01378
M204 S10000
G1 X105.94 Y131.284 F42000
G1 F1276
M204 S6000
G1 X106.26 Y131.653 E.01571
G1 X106.163 Y131.806 E.00583
G3 X105.452 Y131.575 I.928 J-4.068 E.02409
G1 X105.464 Y131.394 E.00583
G1 X105.881 Y131.297 E.01379
M204 S10000
G1 X105.157 Y130.915 F42000
G1 F1276
M204 S6000
G1 X105.375 Y131.352 E.01571
G1 X105.252 Y131.477 E.00562
G3 X104.614 Y131.074 I1.91 J-3.738 E.0243
G1 X104.671 Y130.904 E.00578
G1 X105.097 Y130.914 E.01368
M204 S10000
G1 X104.49 Y130.364 F42000
G1 F1276
M204 S6000
G1 X104.592 Y130.838 E.01561
G1 X104.44 Y130.928 E.00567
G3 X103.925 Y130.38 I2.599 J-2.961 E.0242
G1 X104.024 Y130.232 E.00572
G1 X104.432 Y130.347 E.01365
M204 S10000
G1 X103.981 Y129.663 F42000
G1 F1276
M204 S6000
G1 X103.962 Y130.147 E.01558
G1 X103.791 Y130.195 E.00572
G3 X103.429 Y129.536 I3.259 J-2.216 E.0242
G1 X103.561 Y129.42 E.00567
G1 X103.929 Y129.633 E.01368
M204 S10000
G1 X103.662 Y128.859 F42000
G1 F1276
M204 S6000
G1 X103.523 Y129.324 E.01561
G1 X103.344 Y129.326 E.00578
G3 X103.158 Y128.594 I3.958 J-1.393 E.02431
G1 X103.314 Y128.516 E.00562
G1 X103.62 Y128.817 E.01378
M204 S10000
G1 X103.554 Y128 F42000
G1 F1276
M204 S6000
G1 X103.302 Y128.419 E.01571
G1 X103.126 Y128.374 E.00583
G3 X103.126 Y127.626 I4.158 J-.374 E.02409
G1 X103.302 Y127.581 E.00583
G1 X103.523 Y127.949 E.01378
M204 S10000
G1 X103.662 Y127.141 F42000
G1 F1276
M204 S6000
G1 X103.314 Y127.484 E.01571
G1 X103.158 Y127.406 E.00562
G3 X103.344 Y126.674 I4.139 J.66 E.02431
G1 X103.523 Y126.676 E.00578
G1 X103.645 Y127.084 E.01368
M204 S10000
G1 X103.981 Y126.337 F42000
G1 F1276
M204 S6000
G1 X103.561 Y126.58 E.01561
G1 X103.429 Y126.464 E.00567
G3 X103.791 Y125.805 I3.619 J1.556 E.0242
G1 X103.962 Y125.853 E.00572
G1 X103.979 Y126.277 E.01365
M204 S10000
G1 X104.49 Y125.636 F42000
G1 F1276
M204 S6000
G1 X104.024 Y125.768 E.01558
G1 X103.925 Y125.62 E.00572
G3 X104.44 Y125.072 I3.114 J2.414 E.0242
G1 X104.592 Y125.162 E.00567
G1 X104.502 Y125.578 E.01368
M204 S10000
G1 X105.157 Y125.085 F42000
G1 F1276
M204 S6000
G1 X104.671 Y125.096 E.01561
G1 X104.614 Y124.926 E.00578
G3 X105.252 Y124.524 I2.544 J3.328 E.02431
G1 X105.375 Y124.648 E.00562
G1 X105.183 Y125.031 E.01378
M204 S10000
G1 X105.94 Y124.716 F42000
G1 F1276
M204 S6000
G1 X105.464 Y124.606 E.01571
G1 X105.452 Y124.425 E.00583
M73 P96 R0
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
M204 S10000
G1 X102.733 Y128.365 Z4.8 F42000
G1 Z4.4
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1276
M204 S5000
G1 X102.714 Y128 E.0109
G3 X106.814 Y123.715 I4.288 J-.002 E.1951
G3 X107.56 Y123.747 I.192 J4.157 E.02226
G3 X102.735 Y128.425 I-.559 J4.251 E.5724
; WIPE_START
G1 F6364.704
M204 S6000
G1 X102.714 Y128 E-.1617
G1 X102.734 Y127.616 E-.14628
G1 X102.786 Y127.234 E-.14636
G1 X102.872 Y126.859 E-.14624
G1 X102.99 Y126.493 E-.14624
G1 X103.004 Y126.461 E-.01319
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z4.8 I1.217 J0 P1  F42000
; stop printing object, unique label id: 114
M625
; object ids of layer 22 start: 78,114
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


; object ids of this layer22 end: 78,114
M625
; CHANGE_LAYER
; Z_HEIGHT: 4.6
; LAYER_HEIGHT: 0.2
; layer num/total_layer_count: 23/23
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
; OBJECT_ID: 78
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X125.378 Y126.557 F42000
G1 Z4.6
G1 E.8 F1800
G1 F1779
M204 S5000
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
M204 S6000
G1 X125.359 Y126.079 E-.19336
G1 X125.819 Y125.95 E-.18164
G1 X125.92 Y125.482 E-.18163
G1 X126.397 Y125.471 E-.18164
G1 X126.423 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X123.729 Y128.361 Z5 F42000
G1 Z4.6
G1 E.8 F1800
G1 F1779
M204 S5000
G1 X123.717 Y128 E.01075
G3 X128.578 Y123.749 I4.289 J0 E.21778
G3 X128.957 Y132.182 I-.581 J4.251 E.35532
G3 X123.737 Y128.42 I-.951 J-4.182 E.21671
; WIPE_START
G1 F6364.704
M204 S6000
G1 X123.717 Y128 E-.15975
G1 X123.73 Y127.616 E-.14615
G1 X123.781 Y127.234 E-.14637
G1 X123.867 Y126.859 E-.1462
G1 X123.986 Y126.493 E-.14628
G1 X124.002 Y126.456 E-.01525
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z5 I1.217 J0 P1  F42000
; stop printing object, unique label id: 78
M625
; object ids of layer 23 start: 78,114
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


; object ids of this layer23 end: 78,114
M625
; start printing object, unique label id: 78
M624 AQAAAAAAAAA=
G1 X131.917 Y126.851 F42000
G1 Z4.6
G1 E.8 F1800
; FEATURE: Top surface
G1 F1779
M204 S2000
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
M204 S6000
G1 X123.953 Y128.485 E-.41771
G1 X123.923 Y127.923 E-.21402
G1 X124.162 Y128.162 E-.12827
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.059 Y126.526 Z5 F42000
G1 Z4.6
G1 E.8 F1800
G1 F1779
M204 S2000
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
M73 P97 R0
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
M204 S6000
G1 X125.504 Y130.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.949 Y129.046 Z5 F42000
G1 Z4.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0936596
G1 F1779
M204 S6000
G1 X131.865 Y129.198 E.0007
; WIPE_START
G1 F15000
G1 X131.949 Y129.046 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.136 Y126.9 Z5 F42000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.0964822
G1 F1779
M204 S6000
G1 X130.998 Y126.779 E.00078
M204 S10000
G1 X131.055 Y126.281 F42000
; LINE_WIDTH: 0.107633
G1 F1779
M204 S6000
G1 X130.939 Y126.203 E.00071
; LINE_WIDTH: 0.146567
G1 X130.823 Y126.125 E.00114
; LINE_WIDTH: 0.1855
G1 X130.707 Y126.047 E.00157
; LINE_WIDTH: 0.224433
G1 X130.591 Y125.969 E.002
; WIPE_START
G1 F13222.206
G1 X130.707 Y126.047 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X129.801 Y125.002 Z5 F42000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.103368
G1 F1779
M204 S6000
G1 X129.644 Y125.044 E.00078
; WIPE_START
G1 F15000
G1 X129.801 Y125.002 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X131.75 Y126.392 Z5 F42000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.103008
G1 F1779
M204 S6000
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
G1 F15000
G1 X129.705 Y124.317 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.351 Y125.099 Z5 F42000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.105851
G1 F1779
M204 S6000
G1 X126.273 Y125.207 E.00066
; LINE_WIDTH: 0.155352
G3 X126.205 Y125.225 I-.042 J-.018 E.00073
G1 X126.203 Y125.14 E.00076
; WIPE_START
G1 F15000
G1 X126.205 Y125.225 E-.39485
G1 X126.246 Y125.232 E-.19279
G1 X126.273 Y125.207 E-.17237
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.139 Y126.805 Z5 F42000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.0947563
G1 F1779
M204 S6000
G1 X124.055 Y126.957 E.00071
; WIPE_START
G1 F15000
G1 X124.139 Y126.805 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X124.666 Y127.837 Z5 F42000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.102917
G1 F1779
M204 S6000
G1 X124.568 Y127.712 E.00075
; LINE_WIDTH: 0.132401
G1 X124.47 Y127.587 E.00112
; WIPE_START
G1 F15000
G1 X124.568 Y127.712 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X125.177 Y129.739 Z5 F42000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.308191
G1 F1779
M204 S6000
G1 X124.916 Y129.538 E.0069
; LINE_WIDTH: 0.258497
G1 X124.655 Y129.337 E.00561
; WIPE_START
G1 F11132.954
G1 X124.916 Y129.538 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.475 Y131.209 Z5 F42000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.175525
G1 F1779
M204 S6000
G1 X126.355 Y131.043 E.00215
; LINE_WIDTH: 0.218757
G1 X126.236 Y130.877 E.00284
; LINE_WIDTH: 0.261989
G1 X126.116 Y130.711 E.00354
; WIPE_START
G1 F10955.45
G1 X126.236 Y130.877 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X126.391 Y131.75 Z5 F42000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.107069
G1 F1779
M204 S6000
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
G1 F15000
G1 X124.305 Y129.687 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X127.358 Y131.441 Z5 F42000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.0814947
G1 F1779
M204 S6000
G1 X127.349 Y131.468 E.00009
; LINE_WIDTH: 0.111686
G1 X127.311 Y131.475 E.00021
; LINE_WIDTH: 0.147534
G1 X127.292 Y131.474 E.00015
; LINE_WIDTH: 0.177181
G1 X126.922 Y131.078 E.00575
; OBJECT_ID: 114
; WIPE_START
G1 F15000
G1 X127.292 Y131.474 E-.76
; WIPE_END
G1 E-.04 F1800
; stop printing object, unique label id: 78
M625
; start printing object, unique label id: 114
M624 AgAAAAAAAAA=
M204 S10000
G1 X119.83 Y129.873 Z5 F42000
G1 X104.382 Y126.557 Z5
G1 Z4.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1779
M204 S5000
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
M204 S6000
G1 X104.363 Y126.079 E-.19336
G1 X104.823 Y125.95 E-.18164
G1 X104.924 Y125.482 E-.18163
G1 X105.402 Y125.471 E-.18164
G1 X105.427 Y125.42 E-.02173
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X102.733 Y128.361 Z5 F42000
G1 Z4.6
G1 E.8 F1800
G1 F1779
M204 S5000
G1 X102.721 Y128 E.01075
G3 X107.583 Y123.749 I4.289 J0 E.21778
G3 X107.961 Y132.182 I-.581 J4.251 E.35532
G3 X102.742 Y128.42 I-.951 J-4.182 E.21671
; WIPE_START
G1 F6364.704
M204 S6000
G1 X102.721 Y128 E-.15975
G1 X102.734 Y127.616 E-.14615
G1 X102.786 Y127.234 E-.14637
G1 X102.872 Y126.859 E-.1462
G1 X102.99 Y126.493 E-.14628
G1 X103.006 Y126.456 E-.01525
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.629 Y126.836 Z5 F42000
G1 X110.921 Y126.851 Z5
G1 Z4.6
G1 E.8 F1800
; FEATURE: Top surface
G1 F1779
M204 S2000
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
M204 S6000
G1 X102.957 Y128.485 E-.41771
G1 X102.928 Y127.923 E-.21402
G1 X103.167 Y128.162 E-.12827
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.063 Y126.526 Z5 F42000
G1 Z4.6
G1 E.8 F1800
G1 F1779
M204 S2000
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
G1 X105.85 Y131.911
G1 X103.094 Y129.156 E.11607
; WIPE_START
G1 F6364.704
M204 S6000
G1 X104.509 Y130.57 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.953 Y129.046 Z5 F42000
G1 Z4.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0936596
G1 F1779
M204 S6000
G1 X110.869 Y129.198 E.0007
; WIPE_START
G1 F15000
G1 X110.953 Y129.046 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.141 Y126.9 Z5 F42000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.0964822
G1 F1779
M204 S6000
G1 X110.002 Y126.779 E.00078
M204 S10000
G1 X110.059 Y126.281 F42000
; LINE_WIDTH: 0.107633
G1 F1779
M204 S6000
G1 X109.943 Y126.203 E.00071
; LINE_WIDTH: 0.146567
G1 X109.827 Y126.125 E.00114
; LINE_WIDTH: 0.1855
G1 X109.711 Y126.047 E.00157
; LINE_WIDTH: 0.224433
G1 X109.596 Y125.969 E.002
; WIPE_START
G1 F13222.206
G1 X109.711 Y126.047 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X108.805 Y125.002 Z5 F42000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.103368
G1 F1779
M204 S6000
G1 X108.649 Y125.044 E.00078
; WIPE_START
G1 F15000
G1 X108.805 Y125.002 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X110.755 Y126.392 Z5 F42000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.103008
G1 F1779
M204 S6000
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
G1 F15000
G1 X108.71 Y124.317 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.356 Y125.099 Z5 F42000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.105851
G1 F1779
M204 S6000
G1 X105.278 Y125.207 E.00066
; LINE_WIDTH: 0.155352
G3 X105.209 Y125.225 I-.042 J-.018 E.00073
G1 X105.207 Y125.14 E.00076
; WIPE_START
G1 F15000
G1 X105.209 Y125.225 E-.39485
G1 X105.25 Y125.232 E-.19279
G1 X105.278 Y125.207 E-.17237
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.143 Y126.805 Z5 F42000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.0947563
G1 F1779
M204 S6000
G1 X103.059 Y126.957 E.00071
; WIPE_START
G1 F15000
G1 X103.143 Y126.805 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X103.67 Y127.837 Z5 F42000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.102917
G1 F1779
M204 S6000
G1 X103.573 Y127.712 E.00075
; LINE_WIDTH: 0.132401
G1 X103.475 Y127.587 E.00112
; WIPE_START
G1 F15000
G1 X103.573 Y127.712 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X104.182 Y129.739 Z5 F42000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.308191
M73 P98 R0
G1 F1779
M204 S6000
G1 X103.921 Y129.538 E.0069
; LINE_WIDTH: 0.258497
G1 X103.66 Y129.337 E.00561
; WIPE_START
G1 F11132.954
G1 X103.921 Y129.538 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.48 Y131.209 Z5 F42000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.175525
G1 F1779
M204 S6000
G1 X105.36 Y131.043 E.00215
; LINE_WIDTH: 0.218757
G1 X105.24 Y130.877 E.00284
; LINE_WIDTH: 0.261989
G1 X105.12 Y130.711 E.00354
; WIPE_START
G1 F10955.45
G1 X105.24 Y130.877 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X105.395 Y131.75 Z5 F42000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.107069
G1 F1779
M204 S6000
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
G1 F15000
G1 X103.31 Y129.687 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G1 X106.362 Y131.441 Z5 F42000
G1 Z4.6
G1 E.8 F1800
; LINE_WIDTH: 0.0814947
G1 F1779
M204 S6000
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
G1 F15000
G1 X106.297 Y131.474 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S10000
G17
G3 Z5 I1.217 J0 P1  F42000
; stop printing object, unique label id: 114
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

