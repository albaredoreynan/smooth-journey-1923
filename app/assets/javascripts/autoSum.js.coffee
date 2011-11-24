// autoSum.js
startCalc = ->
    interval = setInterval("calc()",1)

calc = ->
  one = document.autoSumForm.firstBox.val()
  two = document.autoSumForm.secondBox.value()
  document.autoSumForm.thirdBox.val((one * 1) + (two * 1))

stopCalc = ->
  clearInterval(interval)

