# Quadruped Robot

MATLAB kinematics, trajectory planning, visualization, and Arduino servo-control scripts for an 8-servo quadruped robot.

## Status

This is an experimental research and hardware-control codebase. The scripts are not a packaged MATLAB project and do not include automated tests. Hardware scripts can move servos as soon as they run. Validate geometry, joint limits, servo directions, and power wiring with the robot lifted or disconnected before applying motion.

## Robot model

The model uses four legs with two joints per leg:

- Body offsets: `d1 = 80`, `d2 = 90`
- Link lengths: `l1 = 70`, `l2 = 60`
- Dimensions are treated as millimetres.
- Joint angles passed to FK and IK functions are in degrees.
- Feet use negative `z`; left-side legs use positive `y` and right-side legs use negative `y`.
- `up` legs use positive `x` body offsets and `down` legs use negative `x` body offsets.

The shared dimensions are returned by `Code/robot_data.m`. Forward kinematics is implemented by the four `FK_*` functions, and inverse kinematics by the four matching `IK_*` functions.

## Algorithms

### Forward kinematics

Each leg is modeled as a planar two-link chain with a mirrored body offset. Given joint angles `theta1` and `theta2` in degrees, the endpoint is calculated from:

```text
x = body_offset_x + l1 cos(theta1) + l2 cos(theta1 + theta2)
z = -l1 sin(theta1) - l2 sin(theta1 + theta2)
```

The four FK functions apply the appropriate signs for the upper/lower and left/right leg positions. `TransMatrix.m` and `countingFK.m` provide the homogeneous-transform and symbolic derivation used to inspect these equations.

### Inverse kinematics

The matching IK functions convert a requested foot position `(x, y, z)` into two joint angles:

1. Transform the target into the selected leg's local plane.
2. Solve the two-link triangle using the law of cosines.
3. Select the configured knee branch with `atan2d`.
4. Convert the result back to the leg's degree-based joint convention.

The target must be reachable by the two links. A future improvement should reject unreachable targets before the square-root step and report the requested leg and position.

### Trajectory generation

- `TrajectoryPlanning.m` solves independent cubic polynomials for `x` and `y`, using position and velocity boundary conditions at the start and end of a segment.
- `TrajectoryPlanning2.m` solves independent quintic polynomials, using position, velocity, and acceleration boundary conditions. The current calls use zero end velocity and acceleration for smooth squat and return motions.
- `Cycloid.m` generates a single swing using a cycloidal phase, producing a horizontal transfer and vertical lift.
- `Cycloid2.m` uses a cycloidal first half for the swing and a quintic interpolation for the second half to return the foot to its starting `x` position.

### Gait sequencing

`walk.m` uses an alternating diagonal gait. The first phase moves the right-up and left-down legs while the other pair supports the body; the second phase moves the left-up and right-down legs. Each sampled foot position is passed through IK, converted to normalized servo values, and written to the Arduino.

`squat.m` applies quintic vertical transitions to all legs and repeats the motion in timed cycles. Plotting and workspace scripts use FK directly to inspect reachable foot regions before hardware motion is attempted.

## Requirements

For simulation and plotting:

- MATLAB with base plotting, trigonometry, and matrix functionality
- Symbolic Math Toolbox for `Code/countingFK.m`

For Arduino control:

- MATLAB Support Package for Arduino Hardware
- Arduino Servo library support
- Arduino Mega 2560 connected to the configured serial port
- Eight servos connected to digital pins `D2` through `D9`

The hardware scripts currently use `COM5`. Change the port at each call to `Arduino_8servo_setup` when the board is connected elsewhere. Run scripts from `Code` or add that directory to the MATLAB path so helper functions resolve.

## Quick start

From MATLAB, either change into `Code` or add it to the path:

```matlab
cd('path/to/QuadrupedRobot/Code')
% or: addpath('path/to/QuadrupedRobot/Code')
```

Safe visualization entry points:

```matlab
plotRobotDog       % static 3D robot pose
workspace          % sampled FK workspace for all four legs
testing            % FK workspace and cycloid trajectory plots
cycloidTest       % cycloid trajectory over a sampled workspace
```

`plotRobotDog.m` calls `plot_dog.m` with a default pose. Individual leg plot helpers are available as `plot_*_leg` functions.

Do not run `walk`, `squat`, `homePoss`, `testServo`, or `testServoCycloid` until the hardware setup and all target poses have been checked. These scripts create an Arduino object and call `writePosition`.

## Hardware mapping

`Arduino_8servo_setup.m` creates eight servo objects in this order:

| Servo object | Leg | Joint | Pin |
| --- | --- | --- | --- |
| `servo_motor1` | right down | 1 | `D2` |
| `servo_motor2` | right down | 2 | `D3` |
| `servo_motor3` | right up | 1 | `D4` |
| `servo_motor4` | right up | 2 | `D5` |
| `servo_motor5` | left up | 1 | `D6` |
| `servo_motor6` | left up | 2 | `D7` |
| `servo_motor7` | left down | 1 | `D8` |
| `servo_motor8` | left down | 2 | `D9` |

`writePosition` expects normalized values in `[0, 1]`, not degrees. The current conversions are:

```matlab
% Right legs
joint1 = (180 - theta1) / 180;
joint2 = (theta2 + 90) / 180;

% Left legs
joint1 = theta1 / 180;
joint2 = (90 - theta2) / 180;
```

The code does not clamp these values or enforce servo limits. Confirm the mapping against the physical assembly before powering the robot.

## Motion and trajectory scripts

- `TrajectoryPlanning.m`: cubic position/velocity interpolation in `x` and `y`.
- `TrajectoryPlanning2.m`: quintic interpolation with zero velocity and acceleration boundary conditions.
- `Cycloid.m`: one cycloidal segment.
- `Cycloid2.m`: cycloidal first half followed by quintic return.
- `walk.m`: alternating diagonal stepping sequence.
- `squat.m`: repeated quintic transitions between raised and lowered poses.
- `homePoss.m`: computes and writes a pose for all eight servos.
- `testServo.m`: direct two-servo smoke test.

`Delay.m` is a busy loop rather than a calibrated time delay. Use measured timing or MATLAB `pause` when repeatable motion timing is required.

## Current constraints

Keep these constraints in mind when running or extending the project:

- The gait scripts contain mismatched IK calls in their second diagonal phase and should be checked before hardware use.
- IK has no reachability or joint-limit guard, so invalid targets can produce complex or unsafe servo commands.
- Hardware settings are hard-coded in scripts (`Mega2560`, `COM5`, and pins `D2`-`D9`), and servo values are not clamped.
- `testServoCycloid.m` is experimental and references an undefined `land` variable.
- There is no automated MATLAB or hardware test suite. Validate FK/IK round trips, trajectory endpoints, normalized servo ranges, and wiring before motion.

## References

The `References` directory contains the wiring diagram, gait flowchart, cycloid equation, planning pipeline, and mechanical design documents. These are useful for checking physical assumptions before changing coordinate conventions or servo mappings.
