
//Slide Show//
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

//smooth scrolling
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();

        document.querySelector(this.getAttribute('href')).scrollIntoView({
            behavior: 'smooth'
        });
    });
});


//Responsive navigation bar
function myResponsiveHeader() {
  var x = document.getElementById("RespHeader");
  if (x.className === "nav-column2") {
    x.className += " responsive";
  } else {
    x.className = "nav-column2";
  }
}