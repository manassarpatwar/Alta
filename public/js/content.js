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

// // Clicked button for taxitype (Section2)
var a = document.getElementById("taxiTypeS");
var b = document.getElementById("taxiTypeM");
var c = document.getElementById("taxiTypeL");
var e = document.getElementById("taxiButtonS");
var f = document.getElementById("taxiButtonM");
var g = document.getElementById("taxiButtonL");

function typeSfunction(){
  a.style.display = "block";
  b.style.display = "none";
  c.style.display = "none";
  e.style.color = "orange";
  f.style.color = "black";
  g.style.color = "black";
}
function typeMfunction(){
  a.style.display = "none";
  b.style.display = "block";
  c.style.display = "none";
  e.style.color = "black";
  f.style.color = "orange";
  g.style.color = "black";
}
function typeLfunction(){
  a.style.display = "none";
  b.style.display = "none";
  c.style.display = "block";
  e.style.color = "black";
  f.style.color = "black";
  g.style.color = "orange";
}