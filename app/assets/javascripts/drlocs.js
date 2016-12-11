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
    user_address = $("#user_request_address").html();
    App.drlocs.request_uber({ command: "request_uber", lat: lat, lng: lng, user_id: user_id, dr_id: dr_id, user_name: user_name, user_phone: user_phone, user_address: user_address });
}

function confirmUberBooking(dr_id, dr_name) {
    user_id = $('input[id=user_request_id]').val();
    App.drlocs.confirm_booking({ command: "confirm_booking", dr_id: dr_id, dr_name: dr_name, user_id: user_id });
}

function bookDoctor(dr_id, dr_name, lat, lng, cost) {
    $('input[id=selected_uber_doctor_id]').val(dr_id);
    $('input[id=selected_uber_doctor_lat]').val(lat);
    $('input[id=selected_uber_doctor_lng]').val(lng);
    document.getElementById('selected_uber_doctor').innerHTML = "<span class='red-text text-darken-2'>" + dr_name + "</span>";
    document.getElementById('selected_uber_doctor_price').innerHTML = "<span class='red-text text-darken-2'>" + cost + "</span>";
    document.getElementById('uber_doctor_confirm').innerHTML = "<span class='red-text text-darken-2'>Waiting for approval</span>";
    request_uber(dr_id);
}

function serveThisRequest(user_id, lat, lng, user_name, user_phone, user_address, budget) {
    dr_name = $("input#uber_name").val();
    dr_id = $("input#uber_id").val();
    dr_avatar = $("input#uber_avatar").val();
    confirm = confirm("Are you sure you want to serve this request for " + budget + "?");
    if (confirm) {
        document.getElementById('user_request_name').innerHTML = "<span class='red-text text-darken-2'>" + user_name + "</span>";
        document.getElementById('user_request_phone').innerHTML = "<span class='red-text text-darken-2'>" + user_phone + "</span>";
        document.getElementById('user_request_address').innerHTML = "<span class='red-text text-darken-2'>" + user_address + "</span>";
        document.getElementById('transaction_status').innerHTML = "<span class='green-text text-darken-2'>Request taken, waiting for user confirmation!</span>";
        App.drlocs.take_request({ command: "take_request", dr_id: dr_id, dr_name: dr_name, user_id: user_id, dr_lat: $("input#uber_lat").val(), dr_lng: $("input#uber_lng").val() });
    }
}

function showUserRequest(lat, lng, dr_id, user_id, user_name, user_phone, user_address) {
    doctor_txt = $('input[id=uber_id]');
    var my_id = doctor_txt.val();

    if (my_id == dr_id) {
        document.getElementById('user_request_name').innerHTML = "<span class='red-text text-darken-2'>" + user_name + "</span>";
        document.getElementById('user_request_phone').innerHTML = "<span class='red-text text-darken-2'>" + user_phone + "</span>";
        document.getElementById('user_request_address').innerHTML = user_address;

        user_id_txt = $('input[id=user_request_id]');
        user_id_txt.val(user_id);

        user_lat_txt = $('input[id=user_request_lat]');
        user_lat_txt.val(lat);

        user_lng_txt = $('input[id=user_request_lng]');
        user_lng_txt.val(lng);

        displayUserRequest(lat, lng, user_name);
        alert("User " + user_name + " . Phone: " + user_phone + " requested your service at address: " + user_address);
        showRoute($("input#uber_lat").val(), $("input#uber_lng").val(), lat, lng, map);
    }
}

function showDoctorTakeMyRequest(dr_id, dr_name, user_id, dr_lat, dr_lng) {
    my_id = $('input[id=user_request_id]').val();
    if (my_id == user_id) {
        my_budget = $('input[id=my_budget]').val();
        document.getElementById('uber_doctor_confirm').innerHTML = "<span class='green-text text-darken-2'>Request accepted. Waiting for your confirmation!</span>";
        document.getElementById('selected_uber_doctor').innerHTML = "<span class='red-text text-darken-2'>" + dr_name + "</span>";
        document.getElementById('selected_uber_doctor_price').innerHTML = "<span class='red-text text-darken-2'>" + my_budget + "</span>";
        $('input[id=selected_uber_doctor_id]').val(dr_id);
        user_lat = $('input[id=user_request_lat]').val();
        user_lng = $('input[id=user_request_lng]').val();
        showRoute(dr_lat, dr_lng, user_lat, user_lng, uber_map);
        alert("Doctor " + dr_name + " accepted your request. Can you confirm that he can come now?");
        // enable confirm button now
        $("#btn_confirm").prop("disabled", false);
        $("#btn_reject").prop("disabled", false);
    }
}

function responseToConfirm(accepted) {
    dr_id = $('input[id=selected_uber_doctor_id]').val();
    my_id = $('input[id=user_request_id]').val();
    App.drlocs.response_dr_confirm({ command: "response_dr_confirm", dr_id: dr_id, user_id: my_id, confirmed: accepted });
    if (accepted) {
        document.getElementById('uber_doctor_confirm').innerHTML = "<span class='red-text green lighten-2'>Confirmed! Doctor is on his way</span>";
    } else {
        document.getElementById('uber_doctor_confirm').innerHTML = "<span class='white-text red lighten-2'>You canceled this request :( </span>";
    }
}

function showUserResponse(dr_id, user_id, confirmed) {
    var my_id = $('input[id=uber_id]').val();
    if (my_id == dr_id) {
        if (confirmed) {
            alert("User confirmed! You can start driving now. Goodluck!");
            document.getElementById('transaction_status').innerHTML = "<span class='red-text green lighten-2'>User confirmed! You can start driving now. Goodluck!</span>";
            showRoute($("input#uber_lat").val(), $("input#uber_lng").val(), $('input[id=user_request_lat]').val(), $('input[id=user_request_lng]').val(), map);
        } else {
            alert("User rejected! We are very sorry for this inconvenience");
            document.getElementById('transaction_status').innerHTML = "<span class='white-text red lighten-2'>User rejected! We are very sorry for this inconvenience</span>";
        }
    }
}

function showBookingConfirm(dr_id, user_id, dr_name) {
    uber_dr_id_txt = $('input[id=selected_uber_doctor_id]');
    doctor_id = uber_dr_id_txt.val();

    user_id_txt = $('input[id=user_request_id]');
    my_id = user_id_txt.val();

    if (doctor_id == dr_id && my_id == user_id) {
        document.getElementById('uber_doctor_confirm').innerHTML = "<span class='red-text text-darken-2'>Confirmed. Doctor is coming!</span>";
        alert("Booking confirmed! Doctor " + dr_name + " is on his way.");
        user_lat = $('input[id=user_request_lat]').val();
        user_lng = $('input[id=user_request_lng]').val();
        doctor_lat = $('input[id=selected_uber_doctor_lat]').val();
        doctor_lng = $('input[id=selected_uber_doctor_lng]').val();
        showRoute(doctor_lat, doctor_lng, user_lat, user_lng, uber_map);
    }
}

function userRaiseRequest() {
    user_id = $("input#user_request_id").val();
    user_name = $("input#user_request_name").val();
    lat = $("input#user_request_lat").val();
    lng = $("input#user_request_lng").val();
    user_phone = $("input#user_request_phone").val();
    user_address = $("#user_request_address").html();
    budget = $('input[id=my_budget]').val();
    document.getElementById('uber_doctor_confirm').innerHTML = "<span class='red-text text-darken-2'>Request raised. Waiting for doctors to accept!</span>";
    App.drlocs.raise_request_uber({ command: "raise_request_uber", lat: lat, lng: lng, user_id: user_id, user_name: user_name, user_phone: user_phone, user_address: user_address, budget: budget });
}
$(document).on("turbolinks:load", setupMap)