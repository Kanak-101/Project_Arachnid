"""Small bounded PID controller for attitude stabilization."""


class PID:
    def __init__(self, kp=2.0, ki=0.0, kd=0.0, output_limit=20.0, integral_limit=10.0):
        self.kp = float(kp)
        self.ki = float(ki)
        self.kd = float(kd)
        self.output_limit = abs(float(output_limit))
        self.integral_limit = abs(float(integral_limit))
        self.integral = 0.0
        self.previous_error = None
        self.output = 0.0

    def reset(self):
        self.integral = 0.0
        self.previous_error = None
        self.output = 0.0

    def update(self, error, dt):
        dt = max(float(dt), 1e-4)
        error = float(error)
        derivative = 0.0 if self.previous_error is None else (error - self.previous_error) / dt
        candidate_integral = max(
            -self.integral_limit,
            min(self.integral_limit, self.integral + error * dt),
        )
        unsaturated = self.kp * error + self.ki * candidate_integral + self.kd * derivative
        output = max(-self.output_limit, min(self.output_limit, unsaturated))
        if output == unsaturated or (output >= self.output_limit and error < 0) or (output <= -self.output_limit and error > 0):
            self.integral = candidate_integral
        self.previous_error = error
        self.output = output
        return self.output
