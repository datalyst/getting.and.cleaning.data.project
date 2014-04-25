Code Book - Smartphone Motion Data of Human Activity
====================================================

DATA
----
The raw data for this analysis comes from the "Human Activity Recognition
Using Smartphones Data Set" available at the UCI Machine Learning Repository.
The raw dataset contains measurements collected from the accelerometers and
gyroscopes of smartphones while 30 subjects were performing six different
types of activities. This data includes both time series and frequency domain
information (filtered Fourier analysis). The details of the dataset are
available at

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

and the raw data can be downloaded at

http://archive.ics.uci.edu/ml/machine-learning-databases/00240/

This processed dataset extracts and transforms a subset of the raw data. First,
the training and test datasets are combined. Next, only fields containing the
means or standard deviations of raw measurements were selected. The field names
were then adjusted to more human-readable versions.  Finally, a second dataset
was generate, containing the means of each field for each subject and each
activity type.


VARIABLES
---------

The dataset contains a total of 68 variables. The first two identify the subject
and activity

* `subject`: an integer identifier ranging from 1 to 30

* `activity`: a string value describing the human activity; this includes
  `walking`, `walking_upstairs`, `walking_downstairs`, `sitting`, `standing`, or
  `laying`

The remaining 66 variables describe physical measurements. We will discuss
related variables collectively.

* `time.body.acceleratio`n (8 variables: `.mean.X`, `.std.X`, `.mean.Y`, `.std.Y`,
  `.mean.Z`, `.std.Z`, `.magnitude.mean`, `.magnitude.std`)

  The accelerometer provides a 3d vector of acceleration; this vector can be
  deconstructed into components representing acceleration of the body and
  acceleration due to gravity.  These vectors describe the means and standard
  deviations of accelerations of the body in the 3 cartesian directions as
  well as the magnitude of the vector as a whole.

* `time.body.gravity` (8 variables: `.mean.X`, `.std.X`, `.mean.Y`, `.std.Y`, `.mean.Z`,
  `.std.Z`, `.magnitude.mean`, `.magnitude.std`)

  Analogous to `time.body.acceleration` but for the gravity component of the
  acceleration vectors.

* `time.body.acceleration.jerk` (8 variables: `.mean.X`, `.std.X`, `.mean.Y`, `.std.Y`,
  `.mean.Z`, `.std.Z`, `.magnitude.mean`, `.magnitude.std`)

  The means and standard deviations of time derivatives of the measurements
  described in `time.body.acceleration`.

* `frequency.body.acceleration` (8 variables: `.mean.X`, `.std.X`, `.mean.Y`, `.std.Y`,
  `.mean.Z`, `.std.Z`, `.magnitude.mean`, `.magnitude.std`)

  Through Fourier analysis, the measurements of the body acceleration time
  series can be represented in the frequency domain.

* `frequency.body.acceleration.jerk` (8 variables: `.mean.X`, `.std.X`, `.mean.Y`,
  `.std.Y`, `.mean.Z`, `.std.Z`, `.magnitude.mean`, `.magnitude.std`)

  The time derivatives of the body acceleration as represented in the
  frequency domain

* `time.gyrosope` (8 variables: `.mean.X`, `.std.X`, `.mean.Y`, `.std.Y`, `.mean.Z`,
  `.std.Z`, `.magnitude.mean`, `.magnitude.std`)

  The gyroscope provides a 3 dimensional vector containing the angular
  acceleration of the device.  These quantities are the means and standard
  deviations of the components along the X, Y, and Z axes as well as the
  magnitude of the vector as a hole.

* `time.gyroscope.jerk` (8 variables: `.mean.X`, `.std.X`, `.mean.Y`, `.std.Y`, `.mean.Z`,
  `.std.Z`, `.magnitude.mean`, `.magnitude.std`)

  The means and standard deviations of the time derivatives of the quantities
  described for time.gyroscope.

* `frequency.gyroscope` (8 variables: `.mean.X`, `.std.X`, `.mean.Y`, `.std.Y`, `.mean.Z`,
  `.std.Z`, `.magnitude.mean`, `.magnitude.std`)

  The means and standard deviations of quantities for `time.gyroscope`
  represented in the frequence domain.

* `frequence.gyroscope.jerk` (2 variables `.magnitude.mean`, `.magnitude.std`)

  The mean and standard deviation of the magnitude of angular acceleration
  vector in the frequency domain.


TRANSFORMATION
--------------
No data values were transformed, filtered or cleaned, but the processed
dataset restructured the raw data to make it more user friendly.

1. The training and test datasets were merged into a single dataset
2. The processed dataset is restricted to variables representing either the
   mean or standard deviation of a measurement contained within the raw data
3. Variable names were cleaned
   - Raw data contained variable names with the substring "BodyBody" for
     gyroscopic measurements; the double word is redundant
   - Raw gyroscopic measurements were labeled with the string "Body"; since
     angular acceleration is not decomposed into gravity and body components
     (as is positional acceleration), the term "body" was dropped from variable
     names
   - All variable names were given full expansions clearly defining the
     contents
