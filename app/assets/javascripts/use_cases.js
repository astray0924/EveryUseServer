$(function() {
	$('.comment_btn').button();
	
	$('#favorite').change(function(e) {
		$target = $(e.target);
		
		if ($target.attr('checked')) {
			alert("checked")
		} else {
			alert("unchecked")
		}
	});
	
	$('#fun').change(function(e) {
		$target = $(e.target);
		
		if ($target.attr('checked')) {
			alert("checked")
		} else {
			alert("unchecked")
		}
	});
	
	$('#metoo').change(function(e) {
		$target = $(e.target);
		
		if ($target.attr('checked')) {
			alert("checked")
		} else {
			alert("unchecked")
		}
	});
})
