
$(document).ready(function() {
  // $('#sign-up-form').submit( userSignUp );
  // $('#login-form').submit( userLogin );
  $('.welcome').on('click', '.product-button', findProducts )
  $('.welcome').on('click', '.items-button', getUsersItems )
  $('.main-area').on('click', '.add-item', addItemToUser )
  $('.main-area').on('click', '.remove-item', deleteItem )
});

// function userSignUp (event) {
// 	event.preventDefault();
// 	var formData = $(this).serialize();
// 	var url = $(this).attr('action');
// 	$('.form-control').val('');
// 	var ajaxResponse = $.ajax({
// 		url: url,
// 		type: 'post',
// 		data: formData,
// 	});

// 	ajaxResponse.done(function (serverData) {
// 		modifyWelcome(serverData.name);
// 		setupMainArea();
// 	});

// 	ajaxResponse.fail(function (serverData) {
// 		alert('Womp, womp. You suck. Try again.');
// 	});
// }


// function userLogin (event) {
// 	event.preventDefault();
// 	var formData = $(this).serialize();
// 	var url = $(this).attr('action');
// 	$('.form-control').val('');
// 	var ajaxResponse = $.ajax({
// 		url: url,
// 		type: 'post',
// 		data: formData,
// 	});

// 	ajaxResponse.done(function (serverData) {
// 		modifyWelcome(serverData.name);
// 		// setupMainArea();
// });

// 	ajaxResponse.fail(function (serverData) {
// 		alert('Womp, womp. You suck. Try again.');
// 	});
// }

function modifyWelcome (name) {
	$('.welcome-name').text(name);
	$('.welcome h2').hide();
}

// function setupMainArea () {
// 	$('.main-area').empty().append("<div class='col-md-6'></div>");
// 	$('.welcome').append("<button class='btn btn-info welcome-button' id='safety-razors'>Safety Razors</button>");
// 	$('.welcome').append("<button class='btn btn-info welcome-button' id='shaving-brushes'>Brushes</button>");
// 	$('.welcome').append("<button class='btn btn-info welcome-button' id='shaving-cream'>Creams</button>");
// 	$('.welcome').append("<button class='btn btn-info welcome-button' id='shaving-kits'>Shaving Kits</button>");
// 	$('.welcome').append("<button class='btn btn-info welcome-button' id='after-shave-balm'>After Shaves</button>");
// 	$('.welcome').append("<button class='btn btn-info items-button' id='usersItems'>Your Saved Items</button>");
// }


function findProducts (event) {
	event.preventDefault();
	var terms = $(this).attr('id');
	var ajaxResponse = $.ajax({
		url: "/etsy_key",
		type: 'get',
		data: {terms: terms},
	});

	ajaxResponse.done(function (serverData) {
		var api_key = serverData;
		etsyURL = "https://openapi.etsy.com/v2/listings/active.js?keywords="+
		                terms+"&limit=12&includes=Images:1&api_key="+api_key;
		$('.main-area-row').empty();
		$.ajax({
            url: etsyURL,
            dataType: 'jsonp',
            success: function(data) {
                if (data.ok) {
                	$.each(data.results, function (productIndex) {
                		$('.main-area-row').append(createItems(data.results[productIndex], productIndex));
                	})
                } else {    
                  alert(data.error);
                }
            }
        });
		  })
}

function createItems (productObject, productIndex) {
	var context = {
		id: productIndex,
		image_source: productObject.Images[0].url_fullxfull,
		description: productObject.description,
		title: productObject.title,
		price: productObject.price,
		url: productObject.url,
	}
	var source   = $("#product-template").html();
	var template = Handlebars.compile(source);
	var html    = template(context);
	return html;
}

function createUserItems (productObject) {
	var context = {
		id: productObject.id,
		image_source: productObject.image_url,
		description: productObject.description,
		title: productObject.title,
		price: productObject.price,
		url: productObject.product_url,
	}
	var source   = $("#users-product-template").html();
	var template = Handlebars.compile(source);
	var html    = template(context);
	return html;
}


function getUsersItems (event) {
	event.preventDefault();
	var ajaxResponse = $.ajax({
		url: '/user/items',
		type: 'get',
	});

	ajaxResponse.done(function (serverData) {
		$('.main-area-row').empty();
		$.each(serverData, function (productIndex) {
			$('.main-area-row').append(createUserItems(serverData[productIndex]));
		});
	});
}

function addItemToUser (event) {
	event.preventDefault();
	var id = $(this).first().parents().eq(3).attr('id');
	var imageURL = $('#'+id+' img').attr('src');
	var title = $('#'+id+' h3').text();
	var description = $('#'+id+' .description').text();
	var price = $('#'+id+' .price').text();
	var productURL = $('#'+id+' .product-url').attr('href');
	var ajaxResponse = $.ajax({
		url: '/user/items/add',
		type: 'post',
		data: {
			image_url: imageURL,
			description: description,
			title: title,
			price: price,
			product_url: productURL,
		},
	});

	ajaxResponse.done(function (serverData) {
		console.log('Successfully added!');
	});

}
function deleteItem (event) {
	event.preventDefault();
	var id = $(this).first().parents().eq(3).attr('id');
	var ajaxResponse = $.ajax({
		url: '/user/items/delete',
		type: 'delete',
		data: {id: id},
	});

	ajaxResponse.done(function (serverData) {
		$('#'+id).remove();
		console.log('Successfully deleted!');
	});

	ajaxResponse.fail(function (serverData) {
		console.log('Something went wrong...');
	});
}









