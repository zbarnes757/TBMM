
$(document).ready(function() {
	var source   = $("#product-template").html();
	var template = Handlebars.compile(source);
  $('#sign-up-form').submit( userSignUp );
  $('#login-form').submit( userLogin );
  $('.welcome').on('click', '.btn', findProducts )
});

function userSignUp (event) {
	event.preventDefault();
	var formData = $(this).serialize();
	var url = $(this).attr('action');
	$('.form-control').val('');
	var ajaxResponse = $.ajax({
		url: url,
		type: 'post',
		data: formData,
	});

	ajaxResponse.done(function (serverData) {
		console.log(serverData.name);
		modifyWelcome(serverData.name);
		setupMainArea();
	});

	ajaxResponse.fail(function (serverData) {
		console.log('Womp, womp. You suck. Try again.');
		console.log(serverData);
	});
}


function userLogin (event) {
	event.preventDefault();
	var formData = $(this).serialize();
	var url = $(this).attr('action');
	$('.form-control').val('');
	var ajaxResponse = $.ajax({
		url: url,
		type: 'post',
		data: formData,
	});

	ajaxResponse.done(function (serverData) {
		console.log(serverData.name);
		modifyWelcome(serverData.name);
		setupMainArea();
});

	ajaxResponse.fail(function (serverData) {
		alert('Womp, womp. You suck. Try again.');
	});
}

function modifyWelcome (name) {
	$('.welcome h1 .name').text(name);
	$('.welcome h2').hide();
}

function setupMainArea () {
	$('.main-area').empty().append("<div class='col-md-6'></div>");
	$('.welcome').append("<button class='btn btn-info welcome-button' id='safety-razors'>Safety Razors</button>");
	$('.welcome').append("<button class='btn btn-info welcome-button' id='shaving-brushes'>Brushes</button>");
	$('.welcome').append("<button class='btn btn-info welcome-button' id='shaving-cream'>Creams</button>");
	$('.welcome').append("<button class='btn btn-info welcome-button' id='shaving-kits'>Shaving Kits</button>");
	$('.welcome').append("<button class='btn btn-info welcome-button' id='after-shave'>After Shaves</button>");
}


function findProducts (event) {
	event.preventDefault();
	var terms = $(this).attr('id');
	var ajaxResponse = $.ajax({
		url: "/etsy_key",
		type: 'get',
	});

	ajaxResponse.done(function (serverData) {
		var api_key = serverData;
		etsyURL = "https://openapi.etsy.com/v2/listings/active.js?keywords="+
		                terms+"&limit=12&includes=Images:1&api_key="+api_key;

		$.ajax({
            url: etsyURL,
            dataType: 'jsonp',
            success: function(data) {
                if (data.ok) {
                  console.log(data);
                } else {    
                  alert(data.error);
                }
            }
        });
		  })
}









