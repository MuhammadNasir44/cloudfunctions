const functions = require("firebase-functions");
const admin = require('firebase-admin');

admin.initializeApp(functions.config().functions);


let newData;
exports.myTrigger = functions.firestore.document('Messages/{id}').onCreate(async (snapshot, context) => {

    if (snapshot.empty) {
        console.log('No Devices =======================================');
        return;
    }
    else{

    console.log('Snapshot is not empty =======================================',snapshot.get("message"));


    }


    newData = snapshot.data();
    const deviceIdTokens = await admin
        .firestore()
        .collection('DeviceToken').doc("z450ELqcpKt4IqwS4wBp")
        .get();

        console.log("here is th device token=========> ",deviceIdTokens.data().device_token);

//     var tokens = "dvCsC8WEQDaPhEjDmK7YGj:APA91bFwGUwU0CTKnUt_Vo3EcvGPj20K4Qw8RqpLmwlQnOjYzZcqj-CVhLtVpf7nBNF5XnNrqUaq7alpwCSDYzpuXkoEBFR_RqiuLM7fvd1FLC9fK54V5KCskyFuYtidF9KED4hYmv6o";

//    for (var token of deviceIdTokens.docs) {
//        tokens.push(token.data().device_token);

    var payload = {
        notification: {
            title: newData.message,
            body: 'Push Body',
            sound: 'default',
            "android_channel_id": "high_importance_channel",
                "priority": "high",
                "click_action": "FLUTTER_NOTIFICATION_CLICK",
        },
         "data": {
            "post_id": "78887",
            "type": "NEWS",
          },


    };

    try {


     const response = await admin.messaging().sendToDevice(deviceIdTokens.data().device_token, payload);


        console.log('Notification sent successfully');
    } catch (err) {
        console.log("Error sending notfications =============================== ****",err);
    }
});


