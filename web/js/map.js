let token = "pk.eyJ1IjoiYW5vaXJtYXAiLCJhIjoiY2s4NTF5ZzV4MDIzdDNrbDI2OWpqc283NyJ9.2DzTfSxKjGpXYaL8gusDWQ";
let mymap = L.map('mapid').setView([35.829112432244465, 10.643330155593604], 13);
L.tileLayer(`https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=${token}`, {
    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 20,
    id: 'mapbox/streets-v11',
    tileSize: 512,
    zoomOffset: -1,
    accessToken: token
}).addTo(mymap);
var popup = L.popup();

function onMapClick(e) {
    popup
        .setLatLng(e.latlng)
        .setContent("You clicked the map at " + e.latlng.toString())
        .openOn(mymap);
    L.marker.setLatLng(e.latlng).addTo(mymap);
}
var theMarker = {};

mymap.on('click', function (e) {
    lat = e.latlng.lat;
    lon = e.latlng.lng;

    console.log("You clicked the mymap at LAT: " + lat + " and LONG: " + lon);
    //Clear existing marker, 

    if (theMarker != undefined) {
        mymap.removeLayer(theMarker);
    };

    //Add a marker to show where you clicked.
    theMarker = L.marker([lat, lon]).addTo(mymap);
    console.log(theMarker);
});

function toLatLng(x, y, map) {
    var projected = L.point(y, x).divideBy(6378137);
    return map.options.crs.projection.unproject(projected);
}


var latLng = toLatLng(6693172.2381477, -264291.81938326, mymap);

window.onload = () => {
    let save = document.getElementById('save');
    save.addEventListener('click', async (e) => {
        event.preventDefault();
        save.innerHTML = "<div class='loader'></div> Loading..."
        if (document.getElementById('checkbox').checked) {
            let name = document.getElementById('sname').value;
            let description = document.getElementById('sdesc').value;
            let price = document.getElementById('sprice').value;
            let file = document.getElementById("spics").files[0];
            let uid = JSON.parse(localStorage.getItem('userInfo'));
            console.log(uid)
            let formData = new FormData();
            formData.append('photo', file);
            formData.append('name', name);
            formData.append('description', description);
            formData.append('price', price);
            formData.append('lat', theMarker._latlng.lat);
            formData.append('lng', theMarker._latlng.lng);
            formData.append('uid', uid.userID)
            if (name.length > 6 && description.length > 10 && price != "") {
                await fetch('http://localhost:3000/api/stadium/save', {
                    method: 'POST',
                    body: formData
                })
                    .then(res => res.json())
                    .then((res) => {
                        console.log(res);
                        save.innerHTML = "<i class='fa fa-check'></i> Save"

                        toastr.options = {
                            "closeButton": true,
                            "debug": false,
                            "newestOnTop": false,
                            "progressBar": false,
                            "positionClass": "toast-top-right",
                            "preventDuplicates": false,
                            "onclick": null,
                            "showDuration": "300",
                            "hideDuration": "1000",
                            "timeOut": "5000",
                            "extendedTimeOut": "1000",
                            "showEasing": "swing",
                            "hideEasing": "linear",
                            "showMethod": "fadeIn",
                            "hideMethod": "fadeOut"
                        }
                        toastr.success("Success", "Stadiuum has been added successfuly")
                    })
                    .catch(err => {
                        console.log(err)

                        toastr.error("Error", "Please fill the form")
                        save.innerHTML = "<i class='fa fa-check'></i> Save"
                    })
            }
        }
    });
}