importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

const firebaseConfig = {
    apiKey: "AIzaSyBaUaNJe050MkvaSfL2LOw24AnXKN2Sl60",
    authDomain: "esmp-4b85e.firebaseapp.com",
    projectId: "esmp-4b85e",
    storageBucket: "esmp-4b85e.appspot.com",
    messagingSenderId: "688134919204",
    appId: "1:688134919204:web:8d4fd7ee3736a5d73974b1",
    measurementId: "G-PKZSYV6D3P"
  };
firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});