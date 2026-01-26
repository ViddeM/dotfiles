// Home desktop main monitor
output "Samsung Electric Company U28E570 HTPJ801556" {
    mode "3840x2160"
    position x=0 y=0
}

// Home new main monitor
output "ASUSTek COMPUTER INC XG32UCWMG T7LMQS015616" {
    mode "3840x2160@240.016"
    position x=0 y=0
}

// Home secondary monitor
output "PNP(BNQ) BenQ GL2450 3CD00873019" {
    mode "1920x1080"
    position x=2560 y=0
}

// VOLVO Laptop
{% if hostname == "CND207067Z" %}
output "eDP-1" {
    mode "3840x2160"
    scale 2
    transform "normal"
    position x=0 y=0
}

// CYGNI SCREENS:

// Cygni office ultra-wide
output "Philips Consumer Electronics Company PHL 346B1C 1322131231233" {
    mode "3440x1440"

    scale 1

    position x=1920 y=0
}

// Stordalen TV (Cygni office)
output "Philips Consumer Electronics Company 86BDL3550Q 0x01010101" {
    mode "1920x1080"
    position x=1920 y=0
}

// Random cygni screen
output "Samsung Electric Company C34H89x H4ZRC03874" {
    mode "3440x1440@59.973"
    position x=1920 y=0
}

// END CYGNI SCREENS

// VOLVO SCREENS:

// Volvo office meeting room ??
output "PNP(LNO) ThinkSmart 0x00000004" {
    mode "1920x1080"

    scale 1
    
    transform "normal"
    
    position x=1920 y=0
}

// Volvo office curved HP
output "HP Inc. HP P34hc CN4131JLX" {
    mode "3440x1440"

    scale 1
    
    transform "normal"

    position x=3840 y=0
}

// Volvo meeting room screen
output "PNP(LNO) ThinkSmart 0x00000004" {
    mode "1920x1080"
    scale 1
    position x=0 y=1080
}

// Volvo Office Double monitor
output "HP Inc. HP 724pu CN44121YB6" {
    mode "1920x1200"
    position x=1920 y=0
}
output "HP Inc. HP 724pn CN44123QGW" {
    mode "1920x1200"
    position x=3840 y=0
}

// Volvo Office other double monitors
output "HP Inc. HP 724pu CN44121X33" {
    mode "1920x1200"
    position x=1920 y=0
}
output "HP Inc. HP 724pn CN44123QGK" {
    mode "1920x1200"
    position x=3840 y=0
}

// Volvo Office double monitors
output "HP Inc. HP 724pu CN44121Y9X" {
    mode "1920x1200"
    position x=1920 y=0
}
output "HP Inc. HP 724pn CN44123PCQ" {
    mode "1920x1200"
    position x=3840 y=0
}

// Volvo Office double monitors
output "HP Inc. HP 724pu CN44121YB1" {
    mode "1920x1200"
    position x=1920 y=0
}
output "HP Inc. HP 724pn CN44123PD8" {
    mode "1920x1200"
    position x=3840 y=0
}

// Double monitor ecom area
output "HP Inc. HP 724pu CN44121YCT" {
    mode "1920x1200"
    position x=1920 y=0
}
 
output "HP Inc. HP 724pn CN44123Q7Z" {
    mode "1920x1200"
    position x=3840 y=0
}

// Volvo Office double monitors
output "HP Inc. HP 724pu CN44121Y64" {
    mode "1920x1200"
    position x=1920 y=0
}
output "HP Inc. HP 724pn CN44123KXR" {
    mode "1920x1200"
    position x=3840 y=0
}

// Volvo Office double monitors
output "HP Inc. HP 724pu CN44121Y9X" {
    mode "1920x1200"
    position x=1920 y=0
}
output "HP Inc. HP 724pn CN44123PCQ" {
    mode "1920x1200"
    position x=3840 y=0
}

// Volvo Office double monitors
output "HP Inc. HP 724pu CN44121YB1" {
    mode "1920x1200@59.950"
    position x=1920 y=0
}
output "HP Inc. HP 724pn CN44123PD8" {
    mode "1920x1200@59.950"
    position x=3840 y=0
}

// VCRS Office 
output "HP Inc. HP 724pu CN44121X33" {
    mode "1920x1200"
    position x=3840 y=0
}
output "HP Inc. HP 724pn CN44123QGK" {
    mode "1920x1200"
    position x=5760 y=0
}

// VCRS Office.
output "HP Inc. HP 724pu CN44121YCW" {
    mode "1920x1200"
    position x=1920 y=0
}
output "HP Inc. HP 724pn CN44123M5X" {
    mode "1920x1200"
    position x=3840 y=0
}

// VCRS F4 mob room
output "HP Inc. HP P34hc G4 CNC4131K5X" {
    mode "3440x1440"
    position x=0 y=-1080
}
output "LG Electronics LG SIGNAGE 0x01010101" {
    // mode "3840x2160"
    mode "1920x1080"
    position x=0 y=-2540
}

// END VOLVO SCREENS

{% end %}

