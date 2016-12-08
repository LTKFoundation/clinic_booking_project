function setupMap() {
    console.log("setup Map");
}

function sendLoc() {
    dr_name = $("input#uber_name").val();
    dr_id = $("input#uber_id").val();
    lat = $("input#uber_lat").val();
    lng = $("input#uber_lng").val();
    App.drlocs.send_loc({ command: "doctor_move", lat: lat, lng: lng, dr_name: dr_name, dr_id: dr_id });
}
$(document).on("turbolinks:load", setupMap)