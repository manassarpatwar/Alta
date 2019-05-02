document.getElementById('date').innerHTML = new Date().toDateString();

function addFilter() {
  var index = $("#filterList")[0].selectedIndex;
  var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("filterInput");
  filter = input.value.toUpperCase();
  table1 = document.getElementById("databaseView");
  tr = table1.getElementsByTagName("tr");
  console.log(tr);
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[index-1];
    if (td) {
      txtValue = td.textContent || td.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1 || txtValue == filter) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }       
  }
}

function addHeaderFilter() {
    $('.rideTypeButton').click(function(){
      index = $('.rideTypeButton').index(this);
      var input, filter, table, tr, td, i, txtValue, btn;
      table = document.getElementById("databaseView");
      tr = table.getElementsByTagName("tr");
      filter = "";
      if(index == 1){
        filter = "0";
        index = 2;
      }
      else if(index == 3){
        filter = "1";
      }else if(index == 2){
        filter = "1";
      }
      for (i = 0; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[index+2];
        if (td) {
          txtValue = td.textContent || td.innerText;
          if (txtValue.toUpperCase().indexOf(filter) > -1 || txtValue == filter) {
            tr[i].style.display = "";
          } else {
            tr[i].style.display = "none";
          }
        }       
      }
    });
}


//Filtable Search Bar
//Switching between two views: Table and Database
var x = document.getElementById("view2");
var y = document.getElementById("view1");

function myView1() {
    x.style.display = "none";
    y.style.display = "block";
}
function myView2() {
	x.style.display = "block";
	y.style.display = "none";
}


// //Create Local Storage for table databse
// var bgColor = document.getElementById('viewButton1');
// bgColor.onclick = function() {
//     y.style.display = "block";
//     x.style.display = "none";
//     localStorage.setItem('bgColor', block);
//     localStorage.setItem('bgColor', block);
// };
// bgColor.value = localStorage.getItem('bgColor');
// bgColor.onclick();

// var bgColor2 = document.getElementById('viewButton2');
// bgColor2.onclick = function() {
//       y.style.display = "none";
//       x.style.display = "table";
//       localStorage.setItem('bgColor2', block);
// };
// bgColor2.value = localStorage.getItem('bgColor2');
// bgColor2.onclick();

//User manual ratings
var a = document.getElementById("rate1");
var b = document.getElementById("rate2");
var c = document.getElementById("rate3");
var d = document.getElementById("rate4");
var e = document.getElementById("rate5");
function myRating1(){
  a.style.color = "orange";
  b.style.color = "#333333";
  c.style.color = "#333333";
  d.style.color = "#333333";
  e.style.color = "#333333";
}
function myRating2(){
  a.style.color = "orange";
  b.style.color = "orange";
  c.style.color = "#333333";
  d.style.color = "#333333";
  e.style.color = "#333333";
}
function myRating3(){
  a.style.color = "orange";
  b.style.color = "orange";
  c.style.color = "orange";
  d.style.color = "#333333";
  e.style.color = "#333333";
}
function myRating4(){
  a.style.color = "orange";
  b.style.color = "orange";
  c.style.color = "orange";
  d.style.color = "orange";
  e.style.color = "#333333";
}
function myRating5(){
  a.style.color = "orange";
  b.style.color = "orange";
  c.style.color = "orange";
  d.style.color = "orange";
  e.style.color = "orange";
}

// //DropDownList
// 	$(document).ready(function(){
 
// 		// Initialize select2
// 		$("#selUser").select2();
	
// 		// Read selected option
// 		$('#but_read').click(function(){
// 			var username = $('#selUser option:selected').text();
// 			var userid = $('#selUser').val();
	
// 			$('#result').html("id : " + userid + ", name : " + username);
	
// 		});
// 	});


//Delete account
var modal = document.getElementById('deleteAccBox');

window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}

//Create Local Storage for selection 
var select = document.querySelector(".selectStorage");
var selectOption = select.options[select.selectedIndex];
var lastSelected = localStorage.getItem('select');

if(lastSelected) {
    select.value = lastSelected; 
}

select.onchange = function () {
   lastSelected = select.options[select.selectedIndex].value;
   console.log(lastSelected);
   localStorage.setItem('select', lastSelected);
}

// Stay on table after submitted form
// function goToTable(reload)
//    {
//     window.location.reload(true);
//     window.location.hash = '#tableSection';
//    }
window.location.hash = '#tableSection';


   