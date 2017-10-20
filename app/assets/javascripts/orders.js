$(document).on('turbolinks:load', function(){
   $('select.cs-select').each(function(){
		new SelectFx($(this)[0]);	
	})
	
	// Javascript
	$(".overflowing").hoverForMore({
		speed: 80.0,		// Measured in pixels-per-second
		loop: false,		// Scroll to the end and stop, or loop continuously?
		gap: 20,		// When looping, insert this many pixels of blank space
		target: false,		// Hover on this CSS selector instead of the text line itself
		removeTitle: false,	// By default, remove the title attribute, as a tooltip is redundant
		snapback: true,		// Animate when de-activating, as opposed to instantly reverting
		alwaysOn: false,	// If you're insane, you can turn this into a <marquee> tag. (Please don't.)

		// In case you want to alter the events which activate and de-activate the effect:
		startEvent: "mouseenter",
		stopEvent: "mouseleave"
	});
	let slot_selectors = [];
	let slot_selector_bar_matches = {};
	
	$('.slot-selector').each(function(elem){
		slot_selectors.push($(this))
		if(elem != 0) $(this).hide()
	})

	let slot_selector_links_counter = 0;
	$('.slot-selector .slot-selector--week-tabheader-link').each(function(){
		slot_selector_bar_matches[$(this).data('reactid')] = slot_selector_links_counter
		slot_selector_links_counter += 1
		if(slot_selector_links_counter > 2) slot_selector_links_counter = 0
	})
	// console.log(slot_selector_bar_matches)

	$('.slot-selector--week-tabheader-link').on('click', function(){
		const current_slot_selector = slot_selector_bar_matches[$(this).data('reactid')];

		$('.slot-selector').each(function(elem){
			$(this).hide()
		})
		console.log(current_slot_selector, slot_selectors[current_slot_selector])
		slot_selectors[current_slot_selector].show();
	})
	
	$('.available-slot--button').on('click', function(){
		let dateTimeString = $(this).find('.visually-hidden').text();
		let deliveryCostValue = $(this).find('.value').text()
		let deliveryCostCurrency = $(this).find('.currency').text()
		
		$('[name="delivery[deliver_on]"]').val(dateTimeString)
		$('[name="delivery[cost_value]"]').val(deliveryCostValue)
		$('[name="delivery[cost_currency]"]').val(deliveryCostCurrency)
		// console.log($('[name="delivery[deliver_on]"]'))
		// console.log(dateTimeString, deliveryCostValue, deliveryCostCurrency)
		$('.order-form').submit()
	})
})

$(document).on('click', '.remove-order-item-btn', function(){
	$(this).parent().remove()
})
