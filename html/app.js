





document.onkeyup = function (data) {
  if (data.key == 'Escape') {
    closeMenu()
  }
};

function closeMenu() {
  $("#openmenu").fadeOut(550);
  $.post('https://ks-carhud/closeMenu');
}


$(document).ready(function () {
  window.addEventListener("message", function (event) {
    switch (event.data.action) {
    case "open":
      Open(event.data);
      break;
    }
  });
});



// MONEY HUD



// PLAYER HUD

const playerHud = {
  data() {
    return {
      
      speed: 0,
      
    };
  },
  
  destroyed() {
    window.removeEventListener("message", this.listener);
  },
  mounted() {
    this.listener = window.addEventListener("message", (event) => {
      if (event.data.action === "hudtick") {
        this.hudTick(event.data);
      } 
      // else if(event.data.update) {
      //   eval(event.data.action + "(" + event.data.show + ')')
      // }
    });
    Config = {};
  },
  methods: {
    hudTick(data) {
      this.speed = data.speed;
      if (data.isPaused === 1) {
        this.show = false;
      }
    },
  },
};
const app2 = Vue.createApp(playerHud);
app2.use(Quasar);
app2.mount("#ui-container");

// VEHICLE HUD

const vehHud = {
  data() {
    return {
      speedometer: 66,
      fuelgauge: 69,
      altitudegauge: 75,
      fuel: 0,
      speed: 0,
      seatbelt: 0,
      show: false,
      showAltitude: true,
      showSeatbelt: true,
      seatbeltColor: "",
    };
  },
  
  destroyed() {
    window.removeEventListener("message", this.listener);
  },
  mounted() {
    this.listener = window.addEventListener("message", (event) => {
      if (event.data.action === "car") {
        this.vehicleHud(event.data);
      }
    });
  },
  methods: {
    vehicleHud(data) {
      this.show = data.show;
      this.speed = data.speed;
      this.altitude = data.altitude;
      this.fuel = (data.fuel * 0.71);
      this.showSeatbelt = data.showSeatbelt;
      this.showAltitude = data.showAltitude;
      if (data.seatbelt === true) {
        this.seatbelt = 1;
        this.seatbeltColor = "transparent";
      } else {
        this.seatbelt = 0;
        this.seatbeltColor = "#FF5100";
      }
      if (data.showSeatbelt === true) {
        this.showSeatbelt = true;
      } else {
        this.showSeatbelt = false;
      }
      if (data.showAltitude === true) {
        this.showAltitude = true;
      } else {
        this.showAltitude = false;
      }
      if (data.fuel <= 20) {
        this.fuelColor = "#ff0000";
      } else if (data.fuel <= 30) {
        this.fuelColor = "#dd6e14";
      } else {
        this.fuelColor = "#FFFFFF";
      }
      if (data.isPaused === 1) {
        this.show = false;
      }
    },
  },
};
const app3 = Vue.createApp(vehHud);
app3.use(Quasar);
app3.mount("#veh-container");

// COMPASS HUD

