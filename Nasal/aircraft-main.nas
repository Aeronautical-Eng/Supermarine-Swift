#
# Supermarine Swift Main Nasal Module 
# ---------------------------
# Declares globals; provides update loop 
# ---------------------------
# Taeke van den Bosch 09/04/2024. Based on Richard Harrison F-15
#

var quickstart = func() {

    #if(total_lbs < 200)
        #set_fuel(2000);

        #settimer(func { 

                        
            setprop("controls/engines/engine[0]/cutoff",0);
            setprop("engines/engine[0]/out-of-fuel",0);
            setprop("engines/engine[0]/cutoff",0);

            setprop("fdm/jsbsim/propulsion/starter_cmd",1);
            setprop("fdm/jsbsim/propulsion/cutoff_cmd",1);
            setprop("fdm/jsbsim/propulsion/set-running",0);
                    
 #}, 0.2);
}