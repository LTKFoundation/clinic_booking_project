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
        console.log("Data details: " + data.drloc.command + ":" + data.drloc.lat + "-" + data.drloc.lng);
        des_box = $('input[id=uber_doctor_loc]');
        des_box.val(data.drloc.lat + "-" + data.drloc.lng + "-" + data.drloc.dr_name + "-" + data.drloc.dr_id);
        showUberDoctor(parseFloat(data.drloc.lat), parseFloat(data.drloc.lng), data.drloc.dr_name, "", data.drloc.dr_name, "", data.drloc.dr_id, "", data.drloc.dr_id, "");
    },

    send_loc: function(data) {
        console.log("passing: " + data);
        this.perform("pass_loc", { drloc: data });
    }
});