// Import necessary modules from Firebase Functions and Admin SDK
import * as functions from "firebase-functions/v2";
import {initializeApp} from "firebase-admin/app";
import {getAuth} from "firebase-admin/auth";
import {getDatabase} from "firebase-admin/database";

// Initialize the Firebase Admin SDK
initializeApp();

// Function to check if an email exists in Firebase Authentication
export const checkEmailExistence = functions.https.onCall(async (request) => {
  const email = request.data.email;
  console.log("Received email:", email);

  if (!email) {
    throw new functions.HttpsError("invalid-argument",
        "The function must be called with an argument \"email\".");
  }

  try {
    const userRecord = await getAuth().getUserByEmail(email);
    const uid = userRecord.uid;
    const db = getDatabase();
    const userSnapshot = await db.ref(`campusCartUsers/${uid}`).once("value");
    const userData = userSnapshot.val();
    const phoneNumber = userData ? userData.PhoneNumber : null;
    return {exists: true, email: userRecord.email, phoneNumber: phoneNumber,
      user: userRecord};
  } catch (error) {
    console.error("Error fetching user by email:", error);
    return {exists: false, email: email, phoneNumber: null};
  }
}); // Ensure there's a newline at the end of the file
