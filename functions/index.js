const functions = require("firebase-functions");

// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
exports.myfunctions=functions.firestore.document('Chats/Nb9e0vuGxcUFsfZZZjcr/{Massages}').onCreate((change,context)=>{
    console.log(change.data());
});