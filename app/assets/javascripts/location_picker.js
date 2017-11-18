//= require jquery.geocomplete.min
// function toggleMap(event){
//   if(this.state.lat&&this.state.lng){
//       $('.map_canvas').toggleClass('map-show')

//       let map_center = new google.maps.LatLng(this.state.lat, this.state.lng);
//       let map = new google.maps.Map(document.getElementById("map"), {
//           zoom: 16,
//           center: map_center,
//           mapTypeId: google.maps.MapTypeId.ROADMAP
//       });
//       let marker = new google.maps.Marker({
//           position: map_center,
//           map: map
//       });
//   }
  // this.handleLocationChange({
  //  formatted_address: "Shit, Ass, kurbva",
  //  geometry: {
  //    location:{
  // lat: ()=>{return 32},
  //      lng: ()=>{return 342}
  //    }
  //  }
  // });
// }
function handleLocationChange(e){
  var location = {
      location: e.formatted_address.trim(),
      position: {
          lat: e.geometry.location.lat(),
          lng: e.geometry.location.lng()
      }
  };
  console.log(location)
}

function formatAddress(data){
  var schema = [
        { 
          type: 'route',
          format: 'long_name',
          separator: ' '
        },
        { 
          type: 'street_number',
          format: 'short_name',
          separator: ', '
        },
        { 
          type: 'locality',
          format: 'long_name',
          separator: ', '
        },
        { 
          type: 'country',
          format: 'long_name',
          separator: ''
        }
    ];

  return parseAddressWithSchema(data, schema)
}

function parseAddressWithSchema(data, schema){
  var result = "";
  
  schema.forEach(function(elem){
    var component = getAddressComponent(data, elem.type);

    if(!component || component == '')
      throw "Wrong address format"
    else
      result += component[elem.format] + elem.separator
  })

  return result.trim();
}

function getAddressComponent(data, type){
  for (i in data) {
    var component = data[i];
    if( component.types[0] == type ) return component;
  }
}

$(document).on('ready', function(){
  $(".gmaps-input").geocomplete()
    .bind("geocode:result", function(event, result){
      var address = "";
      try{
        address = formatAddress(result.address_components);
        var details = JSON.stringify(result.address_components);
        $('#adress-details').val(details)
      }catch(e){
        alert(e + " - Try again")
      }
      $(this).val(address);
    })
    .bind("geocode:error", function(event, status){
      $(this).val("")
        console.log("ERROR: " + status);
    })
    .bind("geocode:multiple", function(event, results){
        console.log("Multiple: " + results.length + " results found");
    }); 
})