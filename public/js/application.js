$(document).ready(function() {
  $('#sign-up-form').submit( userSignUp );
  $('#login-form').submit( userLogin );
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
	$('.main-area').empty().append('<div class="col-md-6"></div>');
}