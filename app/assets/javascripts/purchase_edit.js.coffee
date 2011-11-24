function updateVatAmount(form){
  var length = form.elements.length;
  //document.getElementById("length").innerHTML = form.elements[43].value;
  //12,23,33,43

  for(var i=0; i<length; ++i){
    var amount = form.elements[i].value;
    var next = form.elements[i+1].value;

      if(next==form.elements[14].value){ //if next = vat-inclusive
      var unitCost = form.elements[i-2].value;
      var quantity = form.elements[i-1].value;
      var product = unitCost*quantity;
      form.elements[i].value = product;


      if(form.elements[i+1].checked){
        vatAmount = amount / 1.12;
        vatAmount = amount - vatAmount;
        netAmount = amount - vatAmount;
        //vatAmount = amount * (3/28); //alternate computation
      }
      if(form.elements[i+2].checked){
        vatAmount = amount * .12;
        netAmount = amount;
      }
      if(form.elements[i+3].checked){
        vatAmount = 0;
        netAmount = amount;
      }
      form.elements[i+4].value = vatAmount;
      form.elements[i+5].value = netAmount;
    }
  }
}
