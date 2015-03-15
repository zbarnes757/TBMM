
$(document).ready(function() {
  $('.welcome').on('click', '.product-button', findProducts )
  $('.welcome').on('click', '.items-button', getUsersItems )
  $('.main-area').on('click', '.add-item', addItemToUser )
  $('.main-area').on('click', '.remove-item', deleteItem )
});

// Returns Items from Etsy and adds them to the main area
function findProducts (event) {
	event.preventDefault();
	var terms = $(this).attr('data-search');
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

// Creates the templates for each product
function createItems (productObject, productIndex) {
	var context = {
		id: productIndex,
		image_source: productObject.Images[0].url_fullxfull,
		description: decodeHtml(productObject.description),
		title: decodeHtml(productObject.title),
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

// Gets the User's items from the database
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

// Saves the item to the current user
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

// Deletes the item from the user and the database
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
		alert('Successfully deleted!');
	});

	ajaxResponse.fail(function (serverData) {
		console.log('Something went wrong...');
	});
}

// Fixes the html encoding from strings
function decodeHtml(html) {
    var txt = document.createElement("textarea");
    txt.innerHTML = html;
    return txt.value;
}
