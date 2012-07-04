(function($) {
	$(document).ready(function() {
		$('input[name="q"]').search('#names li', function(on) {
			on.all(function(results) {
				var size = results ? results.size() : 0
				$('#count').text(size + ' results');
			});

			on.reset(function() {
				$('#none').hide();
				$('#names li').show();
			});

			on.empty(function() {
				$('#none').show();
				$('#names li').hide();
			});

			on.results(function(results) {
				$('#none').hide();
				$('#names li').hide();
				results.show();
			});
		});
	});
})(jQuery);


