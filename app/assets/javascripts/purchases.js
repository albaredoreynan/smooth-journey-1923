console.log('purchases loaded');
function updateVatAmount(form){
  var length = form.elements.length;
  //document.getElementById("length").innerHTML = length;

  for(var i=0; i<length; ++i){
    var amount = form.elements[i].value;
    var next = form.elements[i+1].value;

    if(next==form.elements[13].value){
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

function updateUQA(form){
  var length = form.elements.length;

  for(var i=0; i<length; ++i){
    var unitCost = form.elements[i].value;
    var mark = form.element[i+3].value;
    var purchase_amount;
    if(mark==form.elements[12].value){
      purchase_amount = (unitCost)*(form.elements[i+1].value);
      form.elements[i+2].value = purchase_amount;
    }
  }
}
