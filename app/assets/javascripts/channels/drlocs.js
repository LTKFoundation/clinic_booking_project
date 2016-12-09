App.drlocs = App.cable.subscriptions.create("DrlocsChannel", {
    connected: function() {
        console.log("connected");
        // Called when the subscription is ready for use on the server

    },

    disconnected: function() {
        console.log("disconnected");
        // Called when the subscription has been terminated by the server
    },

    received: function(data) {
        console.log("received: " + data.drloc);
        if (data.drloc.command == "doctor_move") {
            console.log("Data details: " + data.drloc.command + ":" + data.drloc.lat + "-" + data.drloc.lng);
            des_box = $('input[id=uber_doctor_loc]');
            des_box.val(data.drloc.lat + "-" + data.drloc.lng + "-" + data.drloc.dr_name + "-" + data.drloc.dr_id);
            showUberDoctor(parseFloat(data.drloc.lat), parseFloat(data.drloc.lng), data.drloc.dr_name, data.drloc.dr_id, data.drloc.dr_avatar, data.drloc.dr_cost);
        } else if (data.drloc.command == "confirm_booking") {
            showBookingConfirm(data.drloc.dr_id, data.drloc.user_id, data.drloc.dr_name);
        } else {
            console.log("Data details: " + data.drloc.command + ", dr_id:" + data.drloc.dr_id + ", user_id: " + data.drloc.user_id);
            showUserRequest(parseFloat(data.drloc.lat), parseFloat(data.drloc.lng), data.drloc.dr_id, data.drloc.user_id, data.drloc.user_name, data.drloc.user_phone, data.drloc.user_address);
        }
    },

    send_loc: function(data) {
        console.log("passing: " + data);
        this.perform("pass_loc", { drloc: data });
    },

    request_uber: function(data) {
        console.log("requesting uber: " + data);
        this.perform("request_uber", { drloc: data });
    },

    confirm_booking: function(data) {
        console.log("confirming booking: " + data);
        this.perform("confirm_booking", { drloc: data });
    }
});