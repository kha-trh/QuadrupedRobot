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

`Delay.m` is a busy loop rather than a calibrated time delay. Timing should not be assumed to be in milliseconds.

## Known limitations

These issues are present in the current source and should be considered before changing behavior:

- `walk.m` and `squat.m` use mismatched IK functions in their second diagonal phase; verify intended leg names before correcting them.
- `testServoCycloid.m` references `land` without defining it.
- `homePoss.m` has incorrect diagnostic assignments for some down-leg FK pose variables, although those values are not used for the final writes.
- IK functions do not check reachability before taking a square root, so unreachable targets can produce complex values.
- The IK expressions contain operator-precedence-sensitive divisions such as `... / l2*(i+1)`; preserve or verify behavior carefully when refactoring.
- `constant.m` returns a very small ratio used to suppress lateral terms. It is obscure and should not be changed without rechecking the coordinate model.
- `TrajectoryPlanning.m` and `TrajectoryPlanning2.m` use explicit matrix inversion.
- `compact.m` is an incomplete symbolic scratch file and is not an execution entry point.
- No MATLAB or hardware test suite is included. Static inspection alone does not establish safe robot motion.

## References

The `References` directory contains the wiring diagram, gait flowchart, cycloid equation, planning pipeline, and mechanical design documents. These are useful for checking physical assumptions before changing coordinate conventions or servo mappings.
