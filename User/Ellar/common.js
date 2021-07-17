var numWords = $("#mw-content-text > div").text().split(" ").length;
var headerWords = $("h1").text().split(" ").length;
var totalWords = numWords + headerWords;
var timeInMinutes = totalWords / 200;
var header = $("h1").text();
$("h1").text(header + " (it will take you " + timeInMinutes + " minutes to read this page)");