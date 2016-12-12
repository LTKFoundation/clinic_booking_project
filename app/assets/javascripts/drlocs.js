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
    $("#user-description").html('Waiting for approval...');
    swal("Request sent!", "Waiting for doctor response...", "success");
    // $("#user-description").addClass("hidden");
    // document.getElementById('uber_doctor_confirm').innerHTML = "Request sent! Waiting for approval..";

}

function confirmUberBooking(dr_id, dr_name) {
    user_id = $('input[id=user_request_id]').val();
    App.drlocs.confirm_booking({ command: "confirm_booking", dr_id: dr_id, dr_name: dr_name, user_id: user_id });
    $("#card_action_uber_confirm").addClass("hidden");
    // $("#user_request_uber_card").addClass("hidden");
    $("#confirm-description").addClass('hidden');
    swal("Confirmed!", "Your patient is awaits, drive safe!", "success")
}

function bookDoctor(dr_id, dr_name, lat, lng, cost) {
    $('input[id=selected_uber_doctor_id]').val(dr_id);
    $('input[id=selected_uber_doctor_lat]').val(lat);
    $('input[id=selected_uber_doctor_lng]').val(lng);
    document.getElementById('selected_uber_doctor').innerHTML = dr_name;
    document.getElementById('selected_uber_doctor_price').innerHTML = cost;
    document.getElementById('uber_doctor_confirm').innerHTML = "Waiting for approval";
    request_uber(dr_id);
    $("#uber_take_request_card").removeClass("hidden");
}

function serveThisRequest(user_id, lat, lng, user_name, user_phone, user_address, budget) {
    $("#user_request_uber_card").removeClass("hidden");
    $('#description').addClass("hidden");
    $("#card_action_uber_confirm").addClass("hidden");

    dr_name = $("input#uber_name").val();
    dr_id = $("input#uber_id").val();
    dr_avatar = $("input#uber_avatar").val();
    // confirm = confirm("Are you sure you want to serve this request for " + budget + "?");
    // if (confirm) {
    document.getElementById('user_request_name').innerHTML = user_name;
    document.getElementById('user_request_phone').innerHTML = user_phone;
    document.getElementById('user_request_address').innerHTML = user_address;
    document.getElementById('transaction_status').innerHTML = "Request taken, waiting for user confirmation!";
    App.drlocs.take_request({ command: "take_request", dr_id: dr_id, dr_name: dr_name, user_id: user_id, dr_lat: $("input#uber_lat").val(), dr_lng: $("input#uber_lng").val() });
    $("#confirm-description").html("Informed the user and waiting for response...");
    sweetAlert("Request accepted!", "Informing user and waiting for his response...", "success");

    // }
}

function showUserRequest(lat, lng, dr_id, user_id, user_name, user_phone, user_address) {
    doctor_txt = $('input[id=uber_id]');
    var my_id = doctor_txt.val();
    $("#card_action_uber_confirm").removeClass("hidden");
    $("#user_request_uber_card").removeClass("hidden");
    $('#description').addClass("hidden");
    if (my_id == dr_id) {
        document.getElementById('user_request_name').innerHTML = user_name;
        document.getElementById('user_request_phone').innerHTML = user_phone;
        document.getElementById('user_request_address').innerHTML = user_address;

        user_id_txt = $('input[id=user_request_id]');
        user_id_txt.val(user_id);

        user_lat_txt = $('input[id=user_request_lat]');
        user_lat_txt.val(lat);

        user_lng_txt = $('input[id=user_request_lng]');
        user_lng_txt.val(lng);

        displayUserRequest(lat, lng, user_name);
        document.getElementById('transaction_status').innerHTML = "User " + user_name + " . Phone: " + user_phone + " requested your service at address: " + user_address;
        sweetAlert({
            title: "New request",
            text: "<p><i class='material-icons'>person_pin</i>" + user_name +
                " </p><p> <i class='material-icons'>call</i> " + user_phone + " </p> <p><i class='material-icons'>person_pin_circle</i> " + user_address + "</p>",
            html: true
        });
        $("#btn_uber_confirm").removeClass("hidden");
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
        sweetAlert("Request accepted!", "Can you confirm that he can come now?", "success");
        swal({
                title: "Request accepted!",
                text: "Can you confirm that he can come now?",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "OK, confirm!",
                cancelButtonText: "No, I'm busy!",
                closeOnConfirm: false,
                closeOnCancel: false
            },
            function(isConfirm) {
                if (isConfirm) {
                    responseToConfirm(isConfirm)
                    swal("Confirmed!", "Your doctor is coming.", "success");
                    document.getElementById('user_raise_request_status').innerHTML = "Confirmed! Your doctor is coming.";
                    $("#user-description").html('The doctor is coming! See the position on the map.')
                } else {
                    responseToConfirm(isConfirm)
                    swal("Cancelled", "We are sorry for this inconvienance", "error");
                    $("#user-description").html('Canceled, sorry... Maybe you want to try another request!')
                    document.getElementById('user_raise_request_status').innerHTML = "You cancelled this request. We are sorry for this inconvienance.";
                }
            });
        // enable confirm button now
        // $("#btn_confirm").prop("hidden", false);
        // $("#btn_reject").prop("hidden", false);
    }
}

function responseToConfirm(accepted) {
    dr_id = $('input[id=selected_uber_doctor_id]').val();
    my_id = $('input[id=user_request_id]').val();
    App.drlocs.response_dr_confirm({ command: "response_dr_confirm", dr_id: dr_id, user_id: my_id, confirmed: accepted });
    if (accepted) {
        document.getElementById('uber_doctor_confirm').innerHTML = "Confirmed! Doctor is on his way";
    } else {
        document.getElementById('uber_doctor_confirm').innerHTML = "You canceled this request :( ";
    }
}

function showUserResponse(dr_id, user_id, confirmed) {
    var my_id = $('input[id=uber_id]').val();
    if (my_id == dr_id) {
        if (confirmed) {
            // alert("User confirmed! You can start driving now. Goodluck!");
            // document.getElementById('transaction_status').innerHTML = "User confirmed! You can start driving now. Goodluck!";
            $("#confirm-description").html('User confirmed. You can start driving now!');
            sweetAlert("User confirmed!", "You can start driving now. Goodluck!", "success");
            showRoute($("input#uber_lat").val(), $("input#uber_lng").val(), $('input[id=user_request_lat]').val(), $('input[id=user_request_lng]').val(), map);
        } else {
            // alert("User rejected! We are very sorry for this inconvenience");
            // document.getElementById('transaction_status').innerHTML = "User rejected! We are very sorry for this inconvenience";
            $("#confirm-description").html('Sorry, the user has rejected! Please wait for another request...');
            sweetAlert("User rejected!", "We are very sorry for this inconvenience!", "error");
        }
    }
}

function showBookingConfirm(dr_id, user_id, dr_name) {
    uber_dr_id_txt = $('input[id=selected_uber_doctor_id]');
    doctor_id = uber_dr_id_txt.val();

    user_id_txt = $('input[id=user_request_id]');
    my_id = user_id_txt.val();

    if (doctor_id == dr_id && my_id == user_id) {
        // document.getElementById('uber_doctor_confirm').innerHTML = "<span class='red-text text-darken-2'>Confirmed. Doctor is coming!</span>";
        sweetAlert("Booking confirmed!", "Doctor " + dr_name + " is on his way.", "success");
        $("#user-description").addClass("card-panel teal lighten-2 white-text");
        document.getElementById('user-description').innerHTML = "Booking confirmed! Doctor " + dr_name + " is on his way.";
        document.getElementById('uber_doctor_confirm').addClass('hidden');

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
    symthom = $('input[id=my_symthom]').val();
    document.getElementById('uber_doctor_confirm').innerHTML = "<span class='red-text text-darken-2'>Request raised. Waiting for doctors to accept!</span>";
    // disable confirm button now
    $("#btn_confirm").prop("hidden", true);
    $("#btn_reject").prop("hidden", true);
    App.drlocs.raise_request_uber({ command: "raise_request_uber", lat: lat, lng: lng, user_id: user_id, user_name: user_name, user_phone: user_phone, user_address: user_address, budget: budget, symthom: symthom });
    document.getElementById('user_raise_request_status').innerHTML = "Request created! We will let you know when a doctor accept your request";
    $("#user-description").html('Raised a request! Wait for a doctor accept your request');
    sweetAlert("Request created!", "We will let you know when a doctor accept your request", "success");
}
$(document).on("turbolinks:load", setupMap)
