# gnss-principles
Self-study educational project with the goal of applying unscented Kalman filtering to determine receiver position from GNSS pseudo-range observations.

- Currently in a working state, but more realistic scenarios would have much more uncertainty and result in worse position estimates

![alt text](https://github.com/astroquest/gnss-principles/blob/main/figures/results.png?raw=true)

- Range and satellite position data generated with 2D orbit simulation of four satellites
  -  Satellites are in identical 20000 km 2D circular obits (it's easier to simulate 2D orbits)
  -  Satellites start their orbit at different mean anomalies
  -  Satellite clock drift is assumed to be zero
  -  Atmospheric delay effects on pseudo-range are neglected

- Use range and satellite position data in UKF algorithm to fuse data into x and y coordinates of the receiver position
  - Initial x and y at Earth's center (0,0), ECEF reference frame
  - Satellite position is assumed to be known without error and used as inputs for the UKF framework
  - Computed range observations are the outputs
  - Estimated states are x, y, and receiver clock bias (c*dt_r)
  - Receiver position is constant
 
- Future improvements
  - Simulate 3D satellite orbits and add z component to receiver position
  - Add satellite clock drift to pseudo-range equation
  - Add realistic atmospheric delay errors
  - Add some chance of outlier/failed range observations
  - Add Gaussian noise to satellite positions (requires adding them to the state vector instead of using them as inputs?)
  - Simulate dynamic receiver position
