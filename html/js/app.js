$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: 
            break;
    }
});
var moneyTimeout = null;
var CurrentProx = 0;
(() => {
    QBHud = {};
    
    QBHud.CarHud = function(data) {
        if (data.show) {
            $(".ui-car-container").fadeIn();
            $(".hnitrous").fadeIn(3000);
            $(".circle-engine").fadeIn(3000);
        } else {
            $(".ui-car-container").fadeOut();
            $('.hnitrous').fadeOut(3000);
            $(".circle-engine").fadeOut(3000);
        }
    };
    QBHud.UpdateHud = function(data) {
   
        setProgressSpeed(data.speed, ".progress-speed");
        setProgressFuel(data.fuel, ".progress-fuel");
        if (data.seatbelt) {
            $(".circle-seat").fadeIn(750);
        } else {
            $(".circle-seat").fadeOut(750);
        }   
    };

    function setProgressSpeed(value, element){
        var circle = document.querySelector(element);
        var radius = circle.r.baseVal.value;
        var circumference = radius * 2 * Math.PI;
        var html = $(element).parent().parent().find('span');
        var percent = value*100/450;
        circle.style.strokeDasharray = `${circumference} ${circumference}`;
        circle.style.strokeDashoffset = `${circumference}`;
        const offset = circumference - ((-percent*73)/100) / 100 * circumference;
        circle.style.strokeDashoffset = -offset;
        html.text(value);
      }
      function setProgressFuel(percent, element) {
        var circle = document.querySelector(element);
        var radius = circle.r.baseVal.value;
        var circumference = radius * 2 * Math.PI;
        var html = $(element).parent().parent().find("span");
        circle.style.strokeDasharray = `${circumference} ${circumference}`;
        circle.style.strokeDashoffset = `${circumference}`;
        const offset = circumference - ((-percent * 73) / 100 / 100) * circumference;
        circle.style.strokeDashoffset = -offset;
        html.text(Math.round(percent));
      }
    window.onload = function(e) {
        window.addEventListener('message', function(event) {
            switch(event.data.action) {
                case "open":
                    QBHud.Open(event.data);
                    break;
                case "close":
                    QBHud.Close();
                    break;
                case "update":
                    QBHud.Update(event.data);
                    break;
                case "show":
                    QBHud.Show(event.data);
                    break;
                case "hudtick":
                    QBHud.UpdateHud(event.data);
                    break;
                case "car":
                    QBHud.CarHud(event.data);
                    break;
               
                
                
                
            }
        })
    }
})();
