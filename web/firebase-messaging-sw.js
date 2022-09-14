importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js');

   /*Update with yours config*/
   const firebaseConfig = {
    apiKey: 'AIzaSyBMwjXzCS9lrhrp7AvgTVvCff3n2MSBVac',
    appId: '1:504286599741:web:eb6c7029f313b61eaa2854',
    messagingSenderId: '504286599741',
    projectId: 'xfit-project',
    authDomain: 'xfit-project.firebaseapp.com',
    storageBucket: 'xfit-project.appspot.com',
    measurementId: 'G-VGGS40W1GY',
  };
  firebase.initializeApp(firebaseConfig);
  const messaging = firebase.messaging();

  /*messaging.onMessage((payload) => {
  console.log('Message received. ', payload);*/
  messaging.onBackgroundMessage(function(payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
      body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
      notificationOptions);
  });
