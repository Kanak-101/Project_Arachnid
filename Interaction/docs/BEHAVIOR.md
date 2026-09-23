# Interaction behavior

## States

`SEARCHING` → no target is locked.

`APPROACHING` → one target is locked and the robot is aligned and moved toward it.

`INTERACTING` → target is within the configured interaction distance. Walking stops and interaction gestures are accepted only from the selected target.

## Target policy

At acquisition time, the target selector chooses the detected person closest to the horizontal center of the camera. After selection, the target ID remains locked until the target has been absent for the configured timeout or the operator explicitly releases it.

This is deliberately simple and deterministic for a local multi-person demonstration. It is not a long-term identity-recognition system.

## Motions

- `FORWARD`: target is farther than the interaction range.
- `BACKWARD`: target is closer than the interaction range.
- `TURN_LEFT` / `TURN_RIGHT`: target is outside the horizontal center tolerance.
- `STOP`: target is centered and inside the interaction range, or a safety condition is active.
- `SHAKE`: alternate the two tripod groups with small lateral offsets.
- `LEG_WAVE`: raise one configured leg and alternate left/right phases.
- `DANCE`: execute a fixed, deterministic sequence of lateral shifts, tripod lifts, short forward/backward movements, and small turns.

Arrival shake is automatic when the target first enters the interaction range. The leg wave is triggered by a wave detected from the locked target.

## Keyboard actions

The camera application supports:

```text
Q  quit
R  release target
D  dance
S  shake
W  leg wave
```
