import { getDatabase, ref, onValue } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-database.js";
import { app } from "./firebaseConfig.js";

const db = getDatabase(app);

const heart = document.getElementById("heart");
const spo2 = document.getElementById("spo2");
const temp = document.getElementById("temp");
const status = document.getElementById("status");

const patientRef = ref(db, "patient");

onValue(patientRef, (snapshot) => {
  const data = snapshot.val();

  if (data) {
    heart.innerText = data.heart;
    spo2.innerText = data.spo2;
    temp.innerText = data.temp;

    if (data.spo2 < 92 || data.heart > 120 || data.temp > 38) {
      status.innerText = "⚠️ EMERGENCY";
    } else {
      status.innerText = "🟢 Normal";
    }
  }
});
