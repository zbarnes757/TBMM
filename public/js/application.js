$(document).ready(function() {
  $('#sign-up-form').submit( userSignUp )

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
		console.log(serverData);
	});

	ajaxResponse.fail(function (serverData) {
		console.log('Womp, womp. You suck. Try again.');
		console.log(serverData);
	});
}
