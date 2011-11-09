// autoSum.js
function startCalc(){
    interval = setInterval("calc()",1);
}

function calc(){
  one = document.autoSumForm.firstBox.value;
  two = document.autoSumForm.secondBox.value;
  document.autoSumForm.thirdBox.value = (one * 1) + (two * 1);
}

function stopCalc(){
  clearInterval(interval);
}
