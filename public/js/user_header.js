window.onscroll = function() {myNavFunction()};

var navbar = document.getElementById("accSnav");
var sticky = navbar.offsetTop;

function myNavFunction() {
  if (window.pageYOffset >= sticky) {
    navbar.classList.add("acc-nav-sticky")
  } else {
    navbar.classList.remove("acc-nav-sticky");
  }
}