


//Filtable Search filter dropdown


//Filtable Search Bar
function myFunction() {
  var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.getElementById("myTable");
  tr = table.getElementsByTagName("tr");
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[0];
    if (td) {
      txtValue = td.textContent || td.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }       
  }
}

//sorting dropdown
//dropdown list
function myFunction() {
  document.getElementById("myDropdown").classList.toggle("show");
}
window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}

//Search bar: choose from dropdown list then hide and show relative one



function displayMode(){
	var select = document.getElementById("searchList").value;
	var a0 = document.getElementById("selectDisplay");
	var a = document.getElementById("allDisplay");
	var b = document.getElementById("refNoDisplay");
	var c = document.getElementById("dateDisplay");
	var d = document.getElementById("sLocDisplay");
	var e = document.getElementById("eLocDisplay");
	var f = document.getElementById("freeDisplay");
	var g = document.getElementById("canlDisplay");
	var h = document.getElementById("rateDisplay");
	var aa = document.getElementById("allDis");
	var bb = document.getElementById("refDis");
	var cc = document.getElementById("dateDis");
	var dd = document.getElementById("aLocDis");
	var ee = document.getElementById("eLocDis");
	var ff = document.getElementById("freeDis");
	var gg = document.getElementById("canlDis");
	var hh = document.getElementById("rateDis");
	// document.getElementById("demo").innerHTML = "You selected: " + aa;
	if(select === "all"){
		a0.style.display = "none";
		a.style.display = "inline";
		b.style.display = "none";
		c.style.display = "none";
		d.style.display = "none";
		e.style.display = "none";
		f.style.display = "none";
		g.style.display = "none";		
		h.style.display = "none";	
		aa.removeAttribute("disabled");
	}
	else if (select === "id"){
		a0.style.display = "none";
		a.style.display = "none";
		b.style.display = "inline";
		c.style.display = "none";
		d.style.display = "none";
		e.style.display = "none";
		f.style.display = "none";
		g.style.display = "none";	
		h.style.display = "none";	
		bb.removeAttribute("disabled");
	}
	else if (select === "date_time"){
		a0.style.display = "none";
		a.style.display = "none";
		b.style.display = "none";
		c.style.display = "inline";
		d.style.display = "none";
		e.style.display = "none";
		f.style.display = "none";
		g.style.display = "none";
		h.style.display = "none";		
		cc.removeAttribute("disabled");		
	}
	else if (select === "start_location"){
		a0.style.display = "none";
		a.style.display = "none";
		b.style.display = "none";
		c.style.display = "none";
		d.style.display = "inline";
		e.style.display = "none";
		f.style.display = "none";
		g.style.display = "none";		
		h.style.display = "none";	
		dd.removeAttribute("disabled");	
	}
	else if (select === "end_location"){
		a0.style.display = "none";
		a.style.display = "none";
		b.style.display = "none";
		c.style.display = "none";
		d.style.display = "none";
		e.style.display = "inline";
		f.style.display = "none";
		g.style.display = "none";	
		h.style.display = "none";
		ee.removeAttribute("disabled");				
	}
	else if (select === "free_ride"){
		a0.style.display = "none";
		a.style.display = "none";
		b.style.display = "none";
		c.style.display = "none";
		d.style.display = "none";
		e.style.display = "none";
		f.style.display = "inline";
		g.style.display = "none";		
		h.style.display = "none";		
		ff.removeAttribute("disabled");	
	}
	else if (select === "cancelled"){
		a0.style.display = "none";
		a.style.display = "none";
		b.style.display = "none";
		c.style.display = "none";
		d.style.display = "none";
		e.style.display = "none";
		f.style.display = "none";
		g.style.display = "inline";	
		h.style.display = "none";	
		gg.removeAttribute("disabled");			
	}
	else if (select === "rating"){
		a0.style.display = "none";
		a.style.display = "none";
		b.style.display = "none";
		c.style.display = "none";
		d.style.display = "none";
		e.style.display = "none";
		f.style.display = "none";
		g.style.display = "none";
		h.style.display = "inline";	
		hh.removeAttribute("disabled");				
	}
}


//Switching between two views: Table and Database
var x = document.getElementById("view2");
var y = document.getElementById("view1");
var z = document.getElementById("sorting");

function myView2() {
    x.style.display = "table";
    y.style.display = "none";
    z.style.display = "none";
}
function myView1() {
  // var a = $("view2");
    x.style.display = "none";
    y.style.display = "block";
    z.style.display = "block";
}


//rating starts
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


//Sorting database table
function sortTable(n) {
  var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
  table = document.getElementById("userTable");
  switching = true;
  dir = "asc"; 

  while (switching) {

    switching = false;
    rows = table.rows;

    for (i = 1; i < (rows.length - 1); i++) {
     
      shouldSwitch = false;
      x = rows[i].getElementsByTagName("TD")[n];
      y = rows[i + 1].getElementsByTagName("TD")[n];

      if (dir == "asc") {
        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
          shouldSwitch= true;
          break;
        }
      } else if (dir == "desc") {
        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
          shouldSwitch = true;
          break;
        }
      }
    }
    if (shouldSwitch) {
      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
      switching = true;
      switchcount ++;      
    } else {
      if (switchcount == 0 && dir == "asc") {
        dir = "desc";
        switching = true;
      }
    }
  }
}

//Sorting View 1: Database 
function sortTable(Table, col, dir) {
	var sortClass, i;

	// get previous sort column
	sortTable.sortCol = -1;
	sortClass = Table.className.match(/js-sort-\d+/);
	if (null != sortClass) {
		sortTable.sortCol = sortClass[0].replace(/js-sort-/, '');
		Table.className = Table.className.replace(new RegExp(' ?' + sortClass[0] + '\\b'), '');
	}
	// If sort column was not passed, use previous
	if ('undefined' === typeof col) {
		col = sortTable.sortCol;
	}

	if ('undefined' !== typeof dir) {
		// Accept -1 or 'desc' for descending.  All else is ascending
		sortTable.sortDir = dir == -1 || dir == 'desc' ? -1 : 1;
	} else {
		// sort direction was not passed, use opposite of previous
		sortClass = Table.className.match(/js-sort-(a|de)sc/);
		if (null != sortClass && sortTable.sortCol == col) {
			sortTable.sortDir = 'js-sort-asc' == sortClass[0] ? -1 : 1;
		} else {
			sortTable.sortDir = 1;
		}
	}
	Table.className = Table.className.replace(/ ?js-sort-(a|de)sc/g, '');

	// update sort column
	Table.className += ' js-sort-' + col;
	sortTable.sortCol = col;

	// update sort direction
	Table.className += ' js-sort-' + (sortTable.sortDir == -1 ? 'desc' : 'asc');

	// get sort type
	if (col < Table.tHead.rows[Table.tHead.rows.length - 1].cells.length) {
		sortClass = Table.tHead.rows[Table.tHead.rows.length - 1].cells[col].className.match(/js-sort-[-\w]+/);
	}
	// Improved support for colspan'd headers
	for (i = 0; i < Table.tHead.rows[Table.tHead.rows.length - 1].cells.length; i++) {
		if (col == Table.tHead.rows[Table.tHead.rows.length - 1].cells[i].getAttribute('data-js-sort-colNum')) {
			sortClass = Table.tHead.rows[Table.tHead.rows.length - 1].cells[i].className.match(/js-sort-[-\w]+/);
		}
	}
	if (null != sortClass) {
		sortTable.sortFunc = sortClass[0].replace(/js-sort-/, '');
	} else {
		sortTable.sortFunc = 'string';
	}
	// Set the headers for the active column to have the decorative class
	Table.querySelectorAll('.js-sort-active').forEach(function (Node) {
		Node.className = Node.className.replace(/ ?js-sort-active\b/, '');
	});
	Table.querySelectorAll('[data-js-sort-colNum="' + col + '"]:not(:empty)').forEach(function (Node) {
		Node.className += ' js-sort-active';
	});

	// sort
	var rows = [],
		TBody = Table.tBodies[0];

	for (i = 0; i < TBody.rows.length; i++) {
		rows[i] = TBody.rows[i];
	}
	rows.sort(sortTable.compareRow);

	while (TBody.firstChild) {
		TBody.removeChild(TBody.firstChild);
	}
	for (i = 0; i < rows.length; i++) {
		TBody.appendChild(rows[i]);
	}
}

/**
 * Compare two table rows based on current settings
 *
 * @param RowA A TR DOM object
 * @param RowB A TR DOM object
 * @returns {number} 1 if RowA is greater, -1 if RowB, 0 if equal
 */
sortTable.compareRow = function (RowA, RowB) {
	var valA, valB;
	if ('function' != typeof sortTable[sortTable.sortFunc]) {
		sortTable.sortFunc = 'string';
	}
	valA = sortTable[sortTable.sortFunc](RowA.cells[sortTable.sortCol]);
	valB = sortTable[sortTable.sortFunc](RowB.cells[sortTable.sortCol]);

	return valA == valB ? 0 : sortTable.sortDir * (valA > valB ? 1 : -1);
};

/**
 * Strip all HTML, no exceptions
 * @param html
 * @returns {string}
 */
sortTable.stripTags = function (html) {
	return html.replace(/<\/?[a-z][a-z0-9]*\b[^>]*>/gi, '');
};

/**
 * Helper function that converts a table cell (TD) to a comparable value
 * Converts innerHTML to a JS Date object
 *
 * @param Cell A TD DOM object
 * @returns {Date}
 */
sortTable.date = function (Cell) {
	return new Date(sortTable.stripTags(Cell.innerHTML));
};

/**
 * Helper function that converts a table cell (TD) to a comparable value
 * Converts innerHTML to a JS Number object
 *
 * @param Cell A TD DOM object
 * @returns {Number}
 */
sortTable.number = function (Cell) {
	return Number(sortTable.stripTags(Cell.innerHTML).replace(/[^-\d.]/g, ''));
};

/**
 * Helper function that converts a table cell (TD) to a comparable value
 * Converts innerHTML to a lower case string for insensitive compare
 *
 * @param Cell A TD DOM object
 * @returns {String}
 */
sortTable.string = function (Cell) {
	return sortTable.stripTags(Cell.innerHTML).toLowerCase();
};

/**
 * Helper function that converts a table cell (TD) to a comparable value
 * Captures the last space-delimited token from innerHTML
 *
 * @param Cell A TD DOM object
 * @returns {String}
 */
sortTable.last = function (Cell) {
	return sortTable.stripTags(Cell.innerHTML).split(' ').pop().toLowerCase();
};

/**
 * Helper function that converts a table cell (TD) to a comparable value
 * Captures the value of the first childNode
 *
 * @param Cell A TD DOM object
 * @returns {String}
 */
sortTable.input = function (Cell) {
	for (var i = 0; i < Cell.children.length; i++) {
		if ('object' == typeof Cell.children[i] &&
			'undefined' != typeof Cell.children[i].value
		) {
			return Cell.children[i].value.toLowerCase();
		}
	}

	return sortTable.string(Cell);
};

/**
 * Return the click handler appropriate to the specified Table and column
 *
 * @param Table Table to sort
 * @param col   Column to sort by
 * @returns {Function} Click Handler
 */
sortTable.getClickHandler = function (Table, col) {
	return function () {
		sortTable(Table, col);
	};
};

/**
 * Attach sortTable() calls to table header cells' onclick events
 * If the table(s) do not have a THead node, one will be created around the
 *  first row
 */
sortTable.init = function () {
	var THead, Tables, Handler;
	if (document.querySelectorAll) {
		Tables = document.querySelectorAll('table.js-sort-table');
	} else {
		Tables = document.getElementsByTagName('table');
	}

	for (var i = 0; i < Tables.length; i++) {
		// Because IE<8 doesn't support querySelectorAll, skip unclassed tables
		if (!document.querySelectorAll && null === Tables[i].className.match(/\bjs-sort-table\b/)) {
			continue;
		}

		// Prevent repeat processing
		if (Tables[i].attributes['data-js-sort-table']) {
			continue;
		}

		// Ensure table has a tHead element
		if (!Tables[i].tHead) {
			THead = document.createElement('thead');
			THead.appendChild(Tables[i].rows[0]);
			Tables[i].insertBefore(THead, Tables[i].children[0]);
		} else {
			THead = Tables[i].tHead;
		}

		// Attach click events to table header
		for (var rowNum = 0; rowNum < THead.rows.length; rowNum++) {
			for (var cellNum = 0, colNum = 0; cellNum < THead.rows[rowNum].cells.length; cellNum++) {
				// Define which column the header should invoke sorting for
				THead.rows[rowNum].cells[cellNum].setAttribute('data-js-sort-colNum', colNum);
				Handler = sortTable.getClickHandler(Tables[i], colNum);
				window.addEventListener ?
					THead.rows[rowNum].cells[cellNum].addEventListener('click', Handler) :
					window.attachEvent && THead.rows[rowNum].cells[cellNum].attachEvent('onclick', Handler);
				colNum += THead.rows[rowNum].cells[cellNum].colSpan;
			}
		}

		// Mark table as processed
		Tables[i].setAttribute('data-js-sort-table', 'true')
	}

	// Add default styles as the first style in head so they can be easily overwritten by user styles
	var element = document.createElement('style');
	document.head.insertBefore(element, document.head.childNodes[0]);
	var sheet = element.sheet;
	sheet.insertRule('table.js-sort-asc thead tr > .js-sort-active:after{content:"\\25b2";font-size:0.7em;padding-left:3px;line-height:0.7em;}');
	sheet.insertRule('table.js-sort-desc thead tr > .js-sort-active:after{content:"\\25bc";font-size:0.7em;padding-left:3px;line-height:0.7em;}');
};

// Run sortTable.init() when the page loads
window.addEventListener ?
	window.addEventListener('load', sortTable.init, false) :
	window.attachEvent && window.attachEvent('onload', sortTable.init);



//DropDownList
	$(document).ready(function(){
 
		// Initialize select2
		$("#selUser").select2();
	
		// Read selected option
		$('#but_read').click(function(){
			var username = $('#selUser option:selected').text();
			var userid = $('#selUser').val();
	
			$('#result').html("id : " + userid + ", name : " + username);
	
		});
	});


