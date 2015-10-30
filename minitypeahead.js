$.fn.extend({
minitypeahead: function(settings) {
	self = this;

	if(settings.dataset == undefined || settings.keys == undefined)
	{
		return;
	}
	$.each(settings, function(key, value) {
		self.data(key,value);
	});
	filter = function (event) {

		dataset = $(event.target).data('dataset');
		keys = $(event.target).data('keys');
		target = $(event.target).data('target');
		success = $(event.target).data('success');
		notfound = $(event.target).data('notfound');

		query = $(event.target).val().toLowerCase();

		if(query == "")
		{
			if(notfound != undefined)
			{
				notfound.call(event.target);
				return;
			}
		}

		supermatch = false;
		selected_obj = {};

		// arbitrair hoog genoeg?
		lowest_occurance = 20000;

		$.each(dataset,function(i,obj)
		{
			$.each(keys, function(j, key)
			{
				// occurance
				occ = obj[key].toLowerCase().indexOf(query);
				if(occ != -1)
				{
					if(occ < lowest_occurance)
					{
						selected_obj = obj;
						lowest_occurance = occ;
					}
					if(obj[key].toLowerCase() == query)
					{
						// supermatch!!!
						supermatch = true;
						selected_obj = obj;
						return false;
					}
				} else {
					occ = obj[key].toLowerCase().latinize().indexOf(query);
					if(occ != -1)
					{
						if(occ < lowest_occurance)
						{
							selected_obj = obj;
							lowest_occurance = occ;
						}
						if(obj[key].toLowerCase() == query)
						{
							// supermatch!!!
							supermatch = true;
							selected_obj = obj;
							return false;
						}
					}
				}
			});
			if(supermatch)
			{
				return false;
			}
		});

		if(success != undefined && !$.isEmptyObject(selected_obj))
		{
			success.call(event.target,selected_obj);
		}
		else if(notfound != undefined)
		{
			notfound.call(event.target);
		}
	};
	this.keyup(filter);
	obj = {target: this};
	filter(obj);
}});
