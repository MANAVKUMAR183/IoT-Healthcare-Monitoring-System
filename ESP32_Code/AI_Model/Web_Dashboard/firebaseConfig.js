import { initializeApp } from "firebase/app";

const firebaseConfig = {
  apiKey: "AIzaSyBtn2u2lH6-0yfGRHIhXMnjFKtlgz7JBvI",
  authDomain: "smart-healthcare-iot-5042b.firebaseapp.com",
  databaseURL: "https://smart-healthcare-iot-5042b-default-rtdb.asia-southeast1.firebasedatabase.app",
  projectId: "smart-healthcare-iot-5042b",
  storageBucket: "smart-healthcare-iot-5042b.firebasestorage.app",
  messagingSenderId: "789020289820",
  appId: "1:789020289820:web:36dd0a30baeda1b73928d9"
};

export const app = initializeApp(firebaseConfig);
