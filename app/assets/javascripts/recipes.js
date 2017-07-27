$(document).ready(function(){
	$(".add-to-menu-btn> a[data-remote]").on("ajax:success", function(e, data, status, xhr){
		// console.log(e, data, status, xhr)
		// console.log("Success", e.detail[0])
	}).on("ajax:error", function(e, data, status, xhr){
		// console.log("Error", e.detail[0])
	})

	$(".remove-recipe-btn> a[data-remote]").on("ajax:success", function(e, data, status, xhr){
		// console.log(e, data, status, xhr)
		// console.log($(this))
		// console.log("Success", e.detail[0])
	}).on("ajax:error", function(e, data, status, xhr){
		// console.log("Error", e.detail[0])
	})
})