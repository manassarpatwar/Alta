// document.getElementById('date').innerHTML = new Date().toDateString();

function myFunction() {
    var element = document.getElementById("myDIV");
    element.classList.toggle("bg");
  } 


//slide show//
var slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  var a;
  var slides = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("dot");
  if (n > slides.length) {slideIndex = 1}    
  if (n < 1) {slideIndex = slides.length}
  for (a = 0; a < slides.length; a++) {
      slides[a].style.display = "none";  
  }
  for (a = 0; a < dots.length; a++) {
      dots[a].className = dots[a].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";  
  dots[slideIndex-1].className += " active";
}
  
  
