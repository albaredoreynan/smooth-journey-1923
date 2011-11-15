$(document).ready(function() {
  $('#sale_gross_total_ss').keyup(function(){
    $('#sale_vat').val($('#sale_gross_total_ss').val() * .12);
  });
});

function checkTotal() {
  var totalGross1 = document.getElementById('gross_total');
  var totalGross2 = document.getElementById('sale_gross_total_ss');
  var saveButton = document.getElementById('sale_submit');
  saveButton.disabled = false;
  if(totalGross1.value != totalGross2.value){
    saveButton.disabled = true;
  }
}

function computeVat() {
  $('#sale_vat').val($('#sale_gross_total_ss').val() * .12);
}

function calculateCategoryTotal() {
  var total = 0;

  $(".category").each(function() {
    if (!isNaN(this.value) && this.value.length != 0) {
      total += parseFloat(this.value);
    }
  });

  $("#sale_total_amount_cs").val(total);
  updateVatAmount2();
}

function calculateSettlementtypeTotal() {
  var total = 0;

  $(".settlementtype").each(function() {
    if (!isNaN(this.value) && this.value.length != 0) {
      total += parseFloat(this.value);
    }
  });

  $("#sale_gross_total_ss").val(total);
  updateVatAmount();
}

function updateVatAmount(){
  var totalAmount = document.getElementById('sale_gross_total_ss');
  var vatAmount = 0;
  if(totalAmount.value == "") {

  } else {
    vatAmount = totalAmount.value * 0.12;

    var totalVat = vatAmount;
    var netTotal = totalAmount.value - totalVat;

    var totalVatField = document.getElementById('sale_vat');
    totalVatField.value = totalVat;
    var netField = document.getElementById('sale_net_total_ss');
    netField.value = netTotal;
  }
  checkTotal();
}

function updateVatAmount2() {
  var totalAmount = document.getElementById('sale_total_amount_cs');
  var vatAmount = 0;
  var totalGross = 0;
  if(totalAmount.value == "") {

  }else{
    vatAmount = totalAmount.value * 0.12;

    var totalVat = vatAmount;

    var totalVatField = document.getElementById('vat');
    totalVatField.value = totalVat;

    var totalGrossField = document.getElementById('gross_total');
    totalGross = totalAmount.value * 0.12 + totalAmount.value * 1;
    totalGrossField.value = totalGross;
  }
  checkTotal();
}

function computeTotal() {
  var serviceCharge = document.getElementById('sale_service_charge');
  var totalGross = 0;
  if(serviceCharge.value == "") {

  } else {
    var totalAmount = document.getElementById('sale_total_amount_cs');

    var totalGrossField = document.getElementById('gross_total');
    totalGross = totalAmount.value * 0.12 + totalAmount.value * 1 + serviceCharge.value * 1;
    totalGrossField.value = totalGross;
    checkTotal();
  }
}
