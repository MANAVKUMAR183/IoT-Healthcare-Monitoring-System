console.log("🔥 DIAGNOSTIC MODE");

import { initializeApp } from "https://www.gstatic.com/firebasejs/9.23.0/firebase-app.js";
import { getDatabase, ref, onValue } from "https://www.gstatic.com/firebasejs/9.23.0/firebase-database.js";

const firebaseConfig = {
  apiKey: "AIzaSyBtn2u2lH6-0yfGRHIhXMnjFKtlgz7JBvI",
  authDomain: "smart-healthcare-iot-5042b.firebaseapp.com",
  databaseURL: "https://smart-healthcare-iot-5042b-default-rtdb.asia-southeast1.firebasedatabase.app",
  projectId: "smart-healthcare-iot-5042b",
  storageBucket: "smart-healthcare-iot-5042b.appspot.com",
  messagingSenderId: "789020289820",
  appId: "1:789020289820:web:36dd0a30baeda1b73928d9"
};

const app = initializeApp(firebaseConfig);
const db = getDatabase(app);
const patientRef = ref(db, "patient");

onValue(patientRef, (snapshot) => {
  const data = snapshot.val();
  console.log("RAW DATA FROM FIREBASE:", data);

  // Page par JSON print kar do
  document.body.innerHTML += `<pre>${JSON.stringify(data, null, 2)}</pre>`;
});
