# Using the Myo Armband with Bela

Here's a little [Bela](http://bela.io) project that uses the [Myo](https://www.myo.com) armband as a control interface. The Myo armband contains 8 EMG (muscle) sensors, and an IMU (movement) sensor. [Here's a demo](https://youtu.be/8GA1HF-xr4c).

This idea for this project is to connect the Bela to one particular Myo, and pass data from these sensors to a Pd patch so that we can have fun using them to drive synthesis processes.

To use this project, you have to install an extra library on your Bela (instructions below).

## How to use:

0. Plug in a Myo bluetooth adapter to your Beaglebone black. Does this work with built-in BLE on the new beaglebones? not sure.
1. Install [MyoLinux](https://github.com/brokenpylons/MyoLinux) on your Bela. This involves copying over the source code and building according to the instructions given on the [MyoLinux](https://github.com/brokenpylons/MyoLinux) readme. At this point you can test the connectivity using the `myolinux_example` program that is built when installing MyoLinux.
2. Copy the MyoLinux shared object file to where it will be seen by the build environment: `cp /usr/local/lib/libmyolinux.so /usr/lib/`
3. Move the project files from this repo to your bela.
4. To connect to a specific Myo you have to specify the address in line 16 of `render.cpp`, e.g., `#define MYO_ADDRESS "c8:2f:84:e5:88:af"`. You can find this address when running `myolinux_example` in step 1.
5. Alternatively, you can replace `client.connect(MYO_ADDRESS);` with `client.connect());` from line 465 and the Bela will connect to the first Myo it sees. In a multi-myo situation this could be very bad (or... very good?).
6. Make some cool sounds in the `_main.pd` file. I've put in an example that uses the EMGs to control the volume of eight oscillators while the pitch (angle) of your arm changes the base pitch (frequency). Fun!

## Data you get:

All the sensor data is scaled to `[-1,1]` and packed in lists that are sent to outlets Pd. The scaling can be adjusted in `render.cpp`.

- EMGs: 8 values in a list, goes to outlet `emg`.
- Quaternions (x,y,z,w) -- probably not very useful in Pd -- goes to outlet `ori`.
- Euler angles (roll, pitch, yaw) -- much more useful -- goes to outlet `euler`.
- Acceleration (x,y,z) goes to outlet `acc`.
- Gyroscope (x,y,z) goes to outlet `gyr`.
- Bonus: magnitude of acceleration (`sqrt(x*x + y*y + z*z)`) goes to outlet `accmag` as a float (not a list).

I think the Myo can do some on-board gesture classification, but I don't think the MyoLinux library can extract this data which is a shame. Maybe somebody can update it?

## Todo:

- make some cool music
- figure out why the shared object file isn't seen when it's in `/usr/local/lib`
- see if we can get the classifier data

## PS:

Try typing with my example Pd patch running. Fun times with EMGs!

## Stillness Under Tension

The `_main.pd` file is for our work at NIME2018: "Stillness Under Tension" - try it out!
