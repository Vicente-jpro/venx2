alert("Hello")
$(document).ready(function(){

  // Fist select
  $(".province").click(function(){
    var province_id = $('.province_select').val()

    // Second select
    $.get(
      `http://localhost:3000/cities/${province_id}/province`, 
      function(data, status){
     // console.log(data, status);
      
      $('.city_select')
      .empty()

      for (var index = 0; index < data.length; index++) {

        if(data[index].id === undefined) {return}
          $('.city_select')
            .append(`<option value="${data[index].id}"> ${data[index].city_name} </option>`);
      }

      });
    })

  const price = 14340;

  // Format the price above to USD using the locale, style, and currency.
  let USDollar = new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
  });

  console.log(`The formated version of ${price} is ${USDollar.format(price)}`);
  });
