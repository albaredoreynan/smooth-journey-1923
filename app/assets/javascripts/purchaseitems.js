function updateVatAmount(){
  var purchaseAmount = document.getElementById('purchase_amount');
  var vatAmount = 0;
  var netAmount = 0;

  if(purchaseAmount.value == ""){

  } else {
    function checkVat(){
      if(document.getElementById('VAT-Inclusive').checked){
        vatAmount = purchaseAmount.value / 1.12;
        vatAmount = purchaseAmount.value - vatAmount;
        netAmount = purchaseAmount.value - vatAmount;
        //vatAmount = purchaseAmount.value * (3/28);
      }

      if(document.getElementById('VAT-Exclusive').checked){
        vatAmount = purchaseAmount.value * .12;
        netAmount = purchaseAmount.value;
      }

      if(document.getElementById('VAT-Exempted').checked){
        vatAmount = 0;
        netAmount = purchaseAmount.value;
      }
    } // end of checking vat

    checkVat();
    var totalVat = vatAmount;
    var totalNet = netAmount;
    //document.getElementById('totalVat').innerHTML = "Total vat" + totalVat;
    var totalVatField = document.getElementById('vat_amount');
    totalVatField.value = totalVat;

    var totalNetField = document.getElementById('net_amount');
    totalNetField.value = totalNet;

    document.getElementById("paP").innerHTML = document.getElementById('purchase_amount').value;
    document.getElementById("vaP").innerHTML = document.getElementById('vat_amount').value;
    document.getElementById("naP").innerHTML = document.getElementById('net_amount').value;

  } //end of update total function
  document.getElementById("ucP").innerHTML = document.getElementById('purchase_unitCost').value;
  document.getElementById("pqP").innerHTML = document.getElementById('purchase_quantity').value;
}
