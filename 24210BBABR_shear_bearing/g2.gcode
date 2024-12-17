; manually home tool to top of bearing, ready to grind
;spindle speed 40%
;go to 0
G90 G0 Z0
;spindle on
M3
G0Z-0.40 
G4P30
G0Z-0.42 
G4P30
G0Z-0.44 
G4P30
G0Z-0.46 
G4P30
G0Z-0.48 
G4P30
G0Z-0.50 
G4P30
G0Z-0.52 
G4P30
G0Z-0.54 
G4P30
G0Z-0.56 
G4P60
G0Z1
M5 ;spindle off
G0Z30 ; raise tool
