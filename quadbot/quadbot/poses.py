"""Kinematic body poses and action choreography for 3-DoF quadruped.

Features:
- 6-DoF Body Kinematics: translates (dx, dy, dz) and rotates (roll, pitch, yaw)
  while keeping all 4 feet firmly planted on the ground.
- Multi-directional Dance: smooth transitions across front-back groove, side-to-side sway,
  diagonal shifting (both diagonals), and 360° circular salsa orbit without lifting feet.
- Upgraded Wave: weight shift to 3 supporting legs, tibia lifted completely off the ground
  to its calibrated high position, energetic coxa sweep + paw flex salute, and smooth return.
- Play Bow, Fitness Push-ups, Butt Wiggle, Cat-Cow Stretch, Curious Peek, and Wet-Dog Shake.
"""
import math
from typing import Dict, Tuple, Optional


class BodyPoseEngine:
    """Computes foot targets in each leg frame for arbitrary 6-DoF body translation & rotation."""

    def __init__(self, legs_cfg: dict, reach: float, height: float):
        self.legs = legs_cfg
        self.reach = reach
        self.height = height

    def compute_feet(
        self,
        dx: float = 0.0,
        dy: float = 0.0,
        dz: float = 0.0,
        roll_deg: float = 0.0,
        pitch_deg: float = 0.0,
        yaw_deg: float = 0.0,
    ) -> Dict[str, Tuple[float, float, float]]:
        """Given body shift (dx, dy, dz in mm) and rotation (deg), returns leg-frame (x, y, z) foot targets."""
        cr, sr = math.cos(math.radians(roll_deg)), math.sin(math.radians(roll_deg))
        cp, sp = math.cos(math.radians(pitch_deg)), math.sin(math.radians(pitch_deg))
        cy, sy = math.cos(math.radians(yaw_deg)), math.sin(math.radians(yaw_deg))

        # Rotation matrix R = Rz(yaw) * Ry(pitch) * Rx(roll)
        R = [
            [cy * cp, cy * sp * sr - sy * cr, cy * sp * cr + sy * sr],
            [sy * cp, sy * sp * sr + cy * cr, sy * sp * cr - cy * sr],
            [-sp,     cp * sr,                cp * cr],
        ]
        # Transpose matrix R^T (inverse rotation)
        Rt = [[R[j][i] for j in range(3)] for i in range(3)]

        feet = {}
        for leg, geo in self.legs.items():
            hx, hy = geo["hip_xy"]
            gamma = math.radians(geo.get("gamma", 45 if geo["side"] == 1 else -45))
            side = geo["side"]

            # Fixed foot contact in world coordinates
            fx_w = hx + self.reach * math.cos(gamma)
            fy_w = hy + self.reach * math.sin(gamma)
            fz_w = -self.height

            # Vector from moved body center to foot in world space
            rx = fx_w - dx
            ry = fy_w - dy
            rz = fz_w - dz

            # Express foot in moved body frame: P_body = R^T * r
            px_b = Rt[0][0] * rx + Rt[0][1] * ry + Rt[0][2] * rz
            py_b = Rt[1][0] * rx + Rt[1][1] * ry + Rt[1][2] * rz
            pz_b = Rt[2][0] * rx + Rt[2][1] * ry + Rt[2][2] * rz

            # Relative to hip origin in body frame
            bx = px_b - hx
            by = py_b - hy
            bz = pz_b

            # Project into leg frame (x outward along gamma, y forward perpendicular to gamma)
            perp = gamma - math.radians(90 * side)
            lx = bx * math.cos(gamma) + by * math.sin(gamma)
            ly = bx * math.cos(perp) + by * math.sin(perp)
            feet[leg] = (lx, ly, bz)

        return feet


class PoseActionEngine:
    """Generates continuous joint angle targets for actions and expressive poses."""

    def __init__(self, cfg: dict, kin, neutral_deg: dict, servos: dict):
        self.cfg = cfg
        self.kin = kin
        self.neutral_deg = neutral_deg
        self.servos = servos
        self.legs = cfg["legs"]
        self.reach = float(cfg["gait"].get("stance_reach", 123.0))
        self.height = float(cfg["gait"].get("height_stand", 87.0))
        self.body_engine = BodyPoseEngine(self.legs, self.reach, self.height)

    def _ik_relative(self, feet: Dict[str, Tuple[float, float, float]]) -> Tuple[Dict[str, float], bool]:
        """Runs IK on foot positions and subtracts neutral_deg to get servo offsets."""
        targets = {}
        all_ok = True
        for leg, (x, y, z) in feet.items():
            th1, a, b, ok = self.kin.ik_deg(x, y, z)
            if not ok:
                all_ok = False
            targets[f"{leg}_coxa"] = th1 - self.neutral_deg[f"{leg}_coxa"]
            targets[f"{leg}_femur"] = a - self.neutral_deg[f"{leg}_femur"]
            targets[f"{leg}_tibia"] = b - self.neutral_deg[f"{leg}_tibia"]
        return targets, all_ok

    # -------------------------------------------------------------------------
    # 1. DANCE: Multi-directional groove without lifting feet
    # -------------------------------------------------------------------------
    def dance_targets(self, t: float, cycle_sec: float = 12.0) -> Tuple[Dict[str, float], Dict[str, float]]:
        """Multi-directional continuous dance shifting stance in all directions."""
        phase = t % cycle_sec

        # 4 distinct choreographed dance figures:
        # 0.0 - 3.0s: Front-Back Groove
        # 3.0 - 6.0s: Side-to-Side Sway
        # 6.0 - 9.0s: Diagonal Shifts (Alternating FL-RR and FR-RL)
        # 9.0 - 12.0s: 360° Circular Salsa Orbit + Height Bounce + Yaw Groove
        if phase < 3.0:
            # Front-Back Groove (2 full cycles in 3.0s)
            u = phase / 3.0
            omega = 2.0 * math.pi * (u * 2.0)
            dx = 22.0 * math.sin(omega)
            dy = 0.0
            dz = 2.0 * (1.0 - math.cos(2.0 * omega))
            pitch = 6.0 * math.sin(omega)
            roll = 0.0
            yaw = 0.0
            desc = "Front-Back Groove"
        elif phase < 6.0:
            # Side-to-Side Sway (2 full cycles in 3.0s)
            u = (phase - 3.0) / 3.0
            omega = 2.0 * math.pi * (u * 2.0)
            dx = 0.0
            dy = 22.0 * math.sin(omega)
            dz = 2.0 * (1.0 - math.cos(2.0 * omega))
            pitch = 0.0
            roll = 6.5 * math.sin(omega)
            yaw = 0.0
            desc = "Side-to-Side Sway"
        elif phase < 9.0:
            # Diagonal Shifting
            u = (phase - 6.0) / 3.0
            diag_sign = 1.0 if u < 0.5 else -1.0
            sub_u = (u % 0.5) / 0.5
            omega = 2.0 * math.pi * sub_u
            d = 18.0 * math.sin(omega)
            dx = d
            dy = d * diag_sign
            dz = 2.0 * (1.0 - math.cos(omega))
            pitch = 4.5 * math.sin(omega)
            roll = 4.5 * math.sin(omega) * diag_sign
            yaw = 2.0 * math.sin(omega) * diag_sign
            desc = "Diagonal Sway" if diag_sign > 0 else "Reverse Diagonal"
        else:
            # 360° Circular Salsa Orbit
            u = (phase - 9.0) / 3.0
            angle = 2.0 * math.pi * (u * 2.0)
            dx = 18.0 * math.cos(angle)
            dy = 18.0 * math.sin(angle)
            dz = 6.0 * math.sin(2.0 * angle)
            pitch = 5.0 * math.cos(angle)
            roll = 5.0 * math.sin(angle)
            yaw = 4.5 * math.sin(angle)
            desc = "360° Salsa Orbit"

        feet = self.body_engine.compute_feet(dx, dy, dz, roll_deg=roll, pitch_deg=pitch, yaw_deg=yaw)
        targets, ok = self._ik_relative(feet)
        info = {"dx": dx, "dy": dy, "dz": dz, "roll": roll, "pitch": pitch, "yaw": yaw, "figure": desc}
        return targets, info

    # -------------------------------------------------------------------------
    # 2. WAVE: High tibia lift, weight shift, salute, and paw flex
    # -------------------------------------------------------------------------
    def wave_targets(self, t: float, duration: float = 4.2, wave_leg: str = "FL") -> Tuple[Dict[str, float], bool]:
        """Fixed & enhanced wave: lifts tibia off the ground to calibrated high position."""
        done = t >= duration
        t_clamped = min(t, duration)

        # Smooth S-curve weight shift:
        # 0.0 -> 0.7s: lean away from wave_leg
        # 0.7 -> 3.5s: hold lean & wave leg in air
        # 3.5 -> 4.2s: smoothly lower leg back to stand
        if t_clamped < 0.7:
            blend = 0.5 * (1.0 - math.cos(math.pi * (t_clamped / 0.7)))
        elif t_clamped < 3.5:
            blend = 1.0
        else:
            blend = 0.5 * (1.0 + math.cos(math.pi * ((t_clamped - 3.5) / 0.7)))

        # Lean body away from the waving leg for 3-leg stability
        sign_y = -1.0 if "L" in wave_leg else 1.0
        sign_x = -1.0 if "F" in wave_leg else 1.0
        shift_dx = 16.0 * sign_x * blend
        shift_dy = 16.0 * sign_y * blend
        shift_dz = -4.0 * blend
        shift_roll = 3.0 * sign_y * blend

        feet = self.body_engine.compute_feet(
            dx=shift_dx, dy=shift_dy, dz=shift_dz, roll_deg=shift_roll
        )
        targets, _ = self._ik_relative(feet)

        # Calibrated limits for waving leg
        tibia_sid = f"{wave_leg}_tibia"
        femur_sid = f"{wave_leg}_femur"
        coxa_sid = f"{wave_leg}_coxa"

        s_tibia = self.servos.get(tibia_sid)
        s_femur = self.servos.get(femur_sid)

        # Tibia lifts to upper calibrated range so the foot is high in the air
        tibia_hi = min(s_tibia.deg_range()[1] * 0.85, 72.0) if s_tibia else 65.0
        femur_hi = min(s_femur.deg_range()[1] * 0.85, 50.0) if s_femur else 45.0

        # Coxa back-and-forth waving cycles (3 full waves between 0.7s and 3.5s)
        wave_time = max(0.0, min(2.8, t_clamped - 0.7))
        wave_freq = 1.5  # Hz
        wave_osc = math.sin(2.0 * math.pi * wave_freq * wave_time) if 0.7 <= t_clamped <= 3.5 else 0.0

        # Waving leg targets (relative to neutral stand)
        targets[femur_sid] = femur_hi * blend
        targets[tibia_sid] = tibia_hi * blend + (10.0 * wave_osc * blend)
        targets[coxa_sid] = 28.0 * wave_osc * blend

        return targets, done

    # -------------------------------------------------------------------------
    # 3. PUSHUP: Athletic chest dips / squats
    # -------------------------------------------------------------------------
    def pushup_targets(self, t: float, reps: int = 3, rep_time: float = 1.3) -> Tuple[Dict[str, float], bool]:
        """Chest dips / pushups lowering front and pushing explosively back up."""
        total_time = reps * rep_time
        done = t >= total_time
        t_clamped = min(t, total_time)

        # Cosine dip
        cycle_phase = (t_clamped / rep_time) % 1.0
        dip = 0.5 * (1.0 - math.cos(2.0 * math.pi * cycle_phase))
        if done:
            dip = 0.0

        dz = -25.0 * dip
        pitch = 11.0 * dip
        feet = self.body_engine.compute_feet(dx=0.0, dy=0.0, dz=dz, pitch_deg=pitch)
        targets, _ = self._ik_relative(feet)
        return targets, done

    # -------------------------------------------------------------------------
    # 4. BOW: Classic dog play bow / Japanese greeting
    # -------------------------------------------------------------------------
    def bow_targets(self, t: float, hold_sec: float = 3.2) -> Tuple[Dict[str, float], bool]:
        """Play bow: front elbows drop low to ground, rear legs elevated tall."""
        done = t >= hold_sec
        t_clamped = min(t, hold_sec)

        # Smooth ease in (0 -> 1.0s), hold (1.0 -> 2.4s), ease out (2.4 -> 3.2s)
        if t_clamped < 1.0:
            blend = 0.5 * (1.0 - math.cos(math.pi * (t_clamped / 1.0)))
        elif t_clamped < 2.4:
            blend = 1.0
        else:
            blend = 0.5 * (1.0 + math.cos(math.pi * ((t_clamped - 2.4) / 0.8)))

        dz = -18.0 * blend
        pitch = 14.0 * blend
        dx = -12.0 * blend  # push back slightly to stretch shoulders

        feet = self.body_engine.compute_feet(dx=dx, dy=0.0, dz=dz, pitch_deg=pitch)
        targets, _ = self._ik_relative(feet)
        return targets, done

    # -------------------------------------------------------------------------
    # 5. WIGGLE: Butt / Hip waggle (playful pounce prep)
    # -------------------------------------------------------------------------
    def wiggle_targets(self, t: float, duration: float = 3.0) -> Tuple[Dict[str, float], bool]:
        """Front stays anchored while rear hips playfully wiggle side-to-side."""
        done = t >= duration
        t_clamped = min(t, duration)

        envelope = 1.0
        if t_clamped < 0.5:
            envelope = t_clamped / 0.5
        elif t_clamped > duration - 0.5:
            envelope = (duration - t_clamped) / 0.5

        freq = 3.2  # rapid waggle
        osc = math.sin(2.0 * math.pi * freq * t_clamped) * envelope
        dy = 16.0 * osc
        yaw = 8.5 * osc
        roll = 4.0 * osc

        feet = self.body_engine.compute_feet(dx=0.0, dy=dy, dz=0.0, roll_deg=roll, yaw_deg=yaw)
        targets, _ = self._ik_relative(feet)

        # Dampen front leg motion so only the rear hips wiggle prominently
        for joint in ["FL_coxa", "FL_femur", "FL_tibia", "FR_coxa", "FR_femur", "FR_tibia"]:
            targets[joint] *= 0.15

        return targets, done

    # -------------------------------------------------------------------------
    # 6. STRETCH: Morning Cat-Cow Yoga Stretch
    # -------------------------------------------------------------------------
    def stretch_targets(self, t: float, duration: float = 5.0) -> Tuple[Dict[str, float], bool]:
        """Cat-cow stretch: downward shoulder stretch followed by upward chest arch."""
        done = t >= duration
        t_clamped = min(t, duration)

        if t_clamped < 2.5:
            # Stage 1: Downward Dog (chest low, rear high, reaching forward)
            u = t_clamped / 2.5
            blend = math.sin(math.pi * u)
            dx = -15.0 * blend
            dz = -16.0 * blend
            pitch = 13.0 * blend
        else:
            # Stage 2: Upward Arch (body shifts forward, front extends tall, rear low)
            u = (t_clamped - 2.5) / 2.5
            blend = math.sin(math.pi * u)
            dx = 22.0 * blend
            dz = 8.0 * blend
            pitch = -10.0 * blend

        feet = self.body_engine.compute_feet(dx=dx, dy=0.0, dz=dz, pitch_deg=pitch)
        targets, _ = self._ik_relative(feet)
        return targets, done

    # -------------------------------------------------------------------------
    # 7. PEEK: Curious Meerkat Room Inspection
    # -------------------------------------------------------------------------
    def peek_targets(self, t: float, duration: float = 5.0) -> Tuple[Dict[str, float], bool]:
        """Rises tall on tiptoes, peeks left, peeks right, tilts chin up."""
        done = t >= duration
        t_clamped = min(t, duration)

        # Tall stance
        dz = 16.0 * math.sin(math.pi * min(1.0, t_clamped / duration))

        if t_clamped < 1.8:
            # Peek Left
            u = t_clamped / 1.8
            blend = math.sin(math.pi * u)
            yaw = 16.0 * blend
            roll = 7.0 * blend
            pitch = 3.0 * blend
        elif t_clamped < 3.6:
            # Peek Right
            u = (t_clamped - 1.8) / 1.8
            blend = math.sin(math.pi * u)
            yaw = -16.0 * blend
            roll = -7.0 * blend
            pitch = 3.0 * blend
        else:
            # Look up to sky/user
            u = (t_clamped - 3.6) / 1.4
            blend = math.sin(math.pi * u)
            yaw = 0.0
            roll = 0.0
            pitch = -11.0 * blend

        feet = self.body_engine.compute_feet(dx=0.0, dy=0.0, dz=dz, roll_deg=roll, pitch_deg=pitch, yaw_deg=yaw)
        targets, _ = self._ik_relative(feet)
        return targets, done

    # -------------------------------------------------------------------------
    # 8. SHAKE: Wet-dog high frequency body vibration
    # -------------------------------------------------------------------------
    def shake_targets(self, t: float, duration: float = 1.8) -> Tuple[Dict[str, float], bool]:
        """High-frequency body shimmy shaking off dust or water."""
        done = t >= duration
        t_clamped = min(t, duration)

        envelope = math.sin(math.pi * (t_clamped / duration))
        freq = 3.6
        roll = 7.0 * envelope * math.sin(2.0 * math.pi * freq * t_clamped)
        yaw = 6.0 * envelope * math.cos(2.0 * math.pi * freq * t_clamped)

        feet = self.body_engine.compute_feet(dx=0.0, dy=0.0, dz=0.0, roll_deg=roll, yaw_deg=yaw)
        targets, _ = self._ik_relative(feet)
        return targets, done
