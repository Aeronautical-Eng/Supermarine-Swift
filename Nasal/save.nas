# write the Swift state to file and resume
# Addapted from 172p and Shuttle, Thorsten Renk 2016 - 2017
# by Wayne Bragg 2018

var save_state = func {

    var running = getprop("/engines/active-engine/running");
    var moving = getprop("/velocities/groundspeed-kt");
    var pitch = getprop("/orientation/pitch-deg");
    var roll = getprop("/orientation/roll-deg");

    if (running) {
        gui.popupTip("Engine must be turned off to save state!", 5.0);
        return;
    }
    if (moving > 7 or moving < -7) {
        gui.popupTip("Aircraft cannot be moving to save state!", 5.0);
        return;
    }
    if (pitch > 7 or roll > 7) {
        gui.popupTip("Slope too steep to save state!", 5.0);
        return;
    }

    var lat = getprop("/position/latitude-deg");
    setprop("/save/latitude-deg", lat);
    var lon = getprop("/position/longitude-deg");
    setprop("/save/longitude-deg", lon);
    var altitude = getprop("/position/altitude-ft");
    setprop("/save/altitude-ft", altitude);
    var heading = getprop("/orientation/heading-deg");
    setprop("/save/heading-deg", heading);
    var pitch = getprop("/orientation/pitch-deg");
    setprop("/save/pitch-deg", pitch);
    var roll = getprop("/orientation/roll-deg");
    setprop("/save/roll-deg", roll);
    var uBody = getprop("/velocities/uBody-fps");
    setprop("/save/uBody-fps", uBody);
    var vBody = getprop("/velocities/vBody-fps");
    setprop("/save/vBody-fps", vBody);
    var wBody = getprop("/velocities/wBody-fps");
    setprop("/save/wBody-fps", wBody);









    var geardown = getprop("/controls/gear/gear-down");
    setprop("/save/geardown", geardown);
    var gearpos = getprop("/fdm/jsbsim/gear/gear-pos-norm");
    setprop("/save/gearpos", gearpos);
    var parkbrake = getprop("/controls/gear/brake-parking");
    setprop("/save/parkbrake", parkbrake);
    var flaps = getprop("/controls/flight/flaps");
    setprop("/save/flaps", flaps);
    var flapsnorm = getprop("/surface-positions/flap-pos-norm");
    setprop("/save/flapsnorm", flapsnorm);
    var elevtrim = getprop("/controls/flight/elevator-trim");
    setprop("/save/elevtrim", elevtrim);

	var livery = getprop("/sim/model/livery/name");
	setprop("/save/livery", livery);










    # the scenario description
    var timestring = getprop("/sim/time/real/year");
    timestring = timestring~ "-"~getprop("/sim/time/real/month");
    timestring = timestring~ "-"~getprop("/sim/time/real/day");
    timestring = timestring~ "-"~getprop("/sim/time/real/hour");

    var minute = getprop("/sim/time/real/minute");
    if (minute < 10) {minute = "0"~minute;}
    timestring = timestring~ ":"~minute;

    var description = getprop("/sim/gui/dialogs/SwiftFR5/save/description");

    setprop("/save/description", description);
    setprop("/save/timestring", timestring);

    # save state to specified file

    var filename = getprop("/sim/gui/dialogs/SwiftFR5/save/filename");
    var path = getprop("/sim/fg-home") ~ "/aircraft-data/SwiftFR5Save/"~filename;
    var nodeSave = props.globals.getNode("/save", 0);
    io.write_properties(path, nodeSave);

    print("Current state written to ", filename, " !");
}

var read_state_from_file = func (filename) {

    # read state from specified file

    var path = getprop("/sim/fg-home") ~ "/aircraft-data/SwiftFR5Save/"~filename;
    var readNode = props.globals.getNode("/save", 0);

    io.read_properties(path, readNode);

}

var resume_state = func {





    setprop("/sim/presets/airport-id", "");
    var lat = getprop("/save/latitude-deg");
    setprop("/sim/presets/latitude-deg", lat);
    var lon = getprop("/save/longitude-deg");
    setprop("/sim/presets/longitude-deg", lon);
    var pitch = getprop("/save/pitch-deg");
    setprop("/sim/presets/pitch-deg", pitch);
    var roll = getprop("/save/roll-deg");
    setprop("/sim/presets/roll-deg", roll);
    var uBody = getprop("/save/uBody-fps");
    setprop("/sim/presets/uBody-fps", uBody);
    var vBody = getprop("/save/vBody-fps");
    setprop("/sim/presets/vBody-fps", vBody);
    var wBody = getprop("/save/wBody-fps");
    setprop("/sim/presets/wBody-fps", wBody);
    setprop("/sim/presets/altitude-ft", -9999);
    setprop("/sim/presets/airspeed-kt", 0);
    setprop("/sim/presets/offset-distance-nm", 0);
    setprop("/sim/presets/glideslope-deg", 0);
    setprop("/sim/presets/runway", "");
    setprop("/sim/presets/parkpos", "");
    setprop("/sim/presets/runway-requested", 0);

    var heading = getprop("/save/heading-deg");
 

    fgcommand("reposition");

    var load_delay = 2.0;
    settimer(func {


        var tank1 = getprop("/save/tank1-level-lbs");
        var tank2 = getprop("/save/tank2-level-lbs");
        var tank3 = getprop("/save/tank3-level-lbs");
        var tank4 = getprop("/save/tank4-level-lbs");
        setprop("/consumables/fuel/tank[0]/level-lbs", tank1);
        setprop("/consumables/fuel/tank[1]/level-lbs", tank2);
        setprop("/consumables/fuel/tank[2]/level-lbs", tank3);
        setprop("/consumables/fuel/tank[3]/level-lbs", tank4);
		var ftank = getprop("/save/ftank");
		setprop("/fdm/jsbsim/fuel/tank", ftank);









        var variant = getprop("/save/variant");
        setprop("/sim/model/variant", variant);
 
        var geardown = getprop("/save/geardown");
        setprop("/controls/gear/gear-down", geardown);
        var gearpos = getprop("/save/gearpos");
        setprop("/fdm/jsbsim/gear/gear-pos-norm", gearpos);
    
        var parkbrake = getprop("/save/parkbrake");
        setprop("/controls/gear/brake-parking", parkbrake);
        var flaps = getprop("/save/flaps");
        setprop("/controls/flight/flaps", flaps);
        var flapsnorm = getprop("/save/flapsnorm");
        setprop("/surface-positions/flap-pos-norm", flapsnorm);
        var elevtrim = getprop("/save/elevtrim");
        setprop("/controls/flight/elevator-trim", elevtrim);



		var livery = getprop("/save/livery");
		setprop("/sim/model/livery/name", livery);







 

        var heading_delay = 3.0;
  






        print("State resumed!");

    }, load_delay);
}
