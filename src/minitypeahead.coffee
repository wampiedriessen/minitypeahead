$.fn.extend {
	minitypeahead: (settings) ->
		return if not settings.dataset? or not settings.keys?
		$.each settings, (key, value) =>
			if key isnt 'dataset'
				@data key, value

		master_array = []
		$.each settings.keys, (i, keyname) =>
			master_array[keyname] = []
			$.each settings.dataset, (j, object) =>
				pre_key = object[keyname]
					.toLowerCase()
					.latinize()
					.split " "
				$.each pre_key, (k, str) =>
					for index in [1..str.length] by 1
						do (index) ->
							key = str.substring 0, index
							if not master_array[keyname][key]?
								master_array[keyname][key] = []
							master_array[keyname][key].push object
				str = pre_key.join(" ");
				for index in [pre_key[0].length..str.length] by 1
					do (index) ->
						key = str.substring 0, index
						if not master_array[keyname][key]?
							master_array[keyname][key] = []
						master_array[keyname][key].push object

		@data 'dataset', master_array

		filter = (event) ->
			keys = $(event.target).data 'keys'
			dataset = $(event.target).data 'dataset'
			target = $(event.target).data 'target'
			notfound = $(event.target).data 'notfound'
			success = $(event.target).data 'success'

			query = $(event.target).val().toLowerCase().latinize()

			if query.length < 2
				if notfound?
					notfound.call event.target
				return

			supermatch = false
			returnset = []
			lowest_occurance = 20000

			$.each keys, (i, key) ->
				if master_array[key][query]?
					returnset.concat master_array[key][query]

			if success? and returnset isnt []
				success.call event.target, returnset
			else if notfound?
				notfound.call event.target

		@keyup filter
		obj = {target: @}
		filter obj
}
