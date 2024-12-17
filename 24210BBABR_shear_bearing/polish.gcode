; grid to correct depth first
; manually home tool to top of bearing, ready to polish
;go to 0
G90 G0 Z0
;spindle on
M3
G0Z-0.01
G4P30
G0Z-0.02
G4P30
G0Z-0.03 
G4P30
G0Z-0.04 
G4P30
G0Z-0.05
G4P30
G0Z-0.06 
G4P60
G0Z1
M5 ;spindle off
G0Z35 ; raise tool
