function setupMap() {
    console.log("setup Map");
}

function sendLoc(lat, lng) {
    dr_name = $("input#uber_name").val();
    dr_id = $("input#uber_id").val();
    dr_avatar = $("input#uber_avatar").val();
    dr_cost = $("input#uber_cost").val();
    // lat = $("input#uber_lat").val();
    // lng = $("input#uber_lng").val();
    App.drlocs.send_loc({ command: "doctor_move", lat: lat, lng: lng, dr_name: dr_name, dr_id: dr_id, dr_avatar: dr_avatar, dr_cost: dr_cost });
}

function request_uber(dr_id) {
    user_id = $("input#user_request_id").val();
    user_name = $("input#user_request_name").val();
    lat = $("input#user_request_lat").val();
    lng = $("input#user_request_lng").val();
    user_phone = $("input#user_request_phone").val();
    user_address = $("input#user_request_address").val();
    App.drlocs.request_uber({ command: "request_uber", lat: lat, lng: lng, user_id: user_id, dr_id: dr_id, user_name: user_name, user_phone: user_phone, user_address: user_address });
}

function confirmUberBooking(dr_id, dr_name) {
    user_id = $('input[id=user_request_id]').val();
    App.drlocs.confirm_booking({ command: "confirm_booking", dr_id: dr_id, dr_name: dr_name, user_id: user_id });
}

function bookDoctor(dr_id, dr_name) {
    uber_dr_name_txt = $('input[id=selected_uber_doctor]');
    uber_dr_name_txt.val(dr_name);
    uber_dr_id_txt = $('input[id=selected_uber_doctor_id]');
    uber_dr_id_txt.val(dr_id);
    $('input[id=uber_doctor_confirm]').val("Waiting for approval");
    request_uber(dr_id);
}

function showUserRequest(lat, lng, dr_id, user_id, user_name, user_phone, user_address) {
    doctor_txt = $('input[id=uber_id]');
    var my_id = doctor_txt.val();

    if (my_id == dr_id) {
        user_name_txt = $('input[id=user_request_name]');
        user_name_txt.val(user_name);

        user_id_txt = $('input[id=user_request_id]');
        user_id_txt.val(user_id);

        user_lat_txt = $('input[id=user_request_lat]');
        user_lat_txt.val(lat);

        user_lng_txt = $('input[id=user_request_lng]');
        user_lng_txt.val(lng);

        user_phone_txt = $('input[id=user_request_phone]');
        user_phone_txt.val(user_phone);

        user_add_txt = $('input[id=user_request_address]');
        user_add_txt.val(user_address);

        alert("User " + user_name + " . Phone: " + user_phone + " requested your service at address: " + user_address);
    }
}

function confirmBooking(dr_id, user_id, dr_name) {
    uber_dr_id_txt = $('input[id=selected_uber_doctor_id]');
    doctor_id = uber_dr_id_txt.val();

    user_id_txt = $('input[id=user_request_id]');
    my_id = user_id_txt.val();

    if (doctor_id == dr_id && my_id == user_id) {
        $('input[id=uber_doctor_confirm]').val("Confirmed Booking");
        alert("Booking confirmed! "+dr_name+"Is on his way.");
    }
}
$(document).on("turbolinks:load", setupMap)