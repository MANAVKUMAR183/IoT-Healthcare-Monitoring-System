console.log("Dashboard JS loaded");
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

const heart = document.getElementById("heart");
const spo2 = document.getElementById("spo2");
const temp = document.getElementById("temp");
const status = document.getElementById("status");

const patientRef = ref(db, "patient");

onValue(patientRef, (snapshot) => {
  const data = snapshot.val();
  console.log("Firebase patient data:", data);

  if (!data) {
    console.log("No data found in Firebase!");
    return;
  }

  // Values show karo
  heart.innerText = data.heart ?? "--";
  spo2.innerText = data.spo2 ?? "--";
  temp.innerText = data.temp ?? "--";

  // Status logic
  if (data.heart < 50 || data.heart > 120) {
    status.innerText = "Emergency";
  } else if (data.heart > 100) {
    status.innerText = "Warning";
  } else {
    status.innerText = "Normal";
  }
});

