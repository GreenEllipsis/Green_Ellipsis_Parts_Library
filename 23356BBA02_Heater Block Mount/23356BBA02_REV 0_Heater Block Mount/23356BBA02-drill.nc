(23356BBA02-drill)
(Heather Block Mount)
(Machine)
(  vendor: Nikodem Bartnik)
(  model: Generic 3-axis Router)
(  description: This machine has XYZ axis on the Head)
(T1 D=3.175 CR=0 - ZMIN=-20.3 - flat end mill)
G90 G94
G17
G21
(-Attention- Property Safe Retracts is set to Clearance Height.)
(Ensure the clearance height will clear the part and or fixtures.)
(Raise the Z-axis to a safe height before starting the program.)

(Drill5)
T1
S5000 M3
G17 G90 G94
G54
G0 X-4.994 Y-27.488
Z15
G0 Z5
Z-6.52
G1 Z-20.3 F16.7
G0 Z5
X-14.494
Z-6.52
G1 Z-20.3 F16.7
G0 Z5
Z15

M5
M30
