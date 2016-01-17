$.fn.extend {
	minitypeahead: (settings) ->
		return if not settings.dataset? or not settings.keys?
		$.each settings, (key, value) =>
			if key isnt 'dataset'
				@data key, value
			return

		master_array = {}
		$.each settings.keys, (i, keyname) ->
			master_array[keyname] = {}
			$.each settings.dataset, (j, object) ->
				pre_key = object[keyname]
					.toLowerCase()
					.latinize()
					.split " "
				$.each pre_key, (k, str) ->
					for index in [1..str.length]
						key = str.substring 0, index
						if not master_array[keyname][key]?
							master_array[keyname][key] = []
						master_array[keyname][key].push object
					return
				str = pre_key.join(" ");
				for index in [pre_key[0].length..str.length]
					key = str.substring 0, index
					if not master_array[keyname][key]?
						master_array[keyname][key] = []
					master_array[keyname][key].push object
				return
			return

		# console.log 'Keys:', settings.keys
		# console.log 'Original Dataset', settings.dataset
		# console.log 'New Dataset', master_array
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

			returnset = []

			$.each keys, (i, key) ->
				if dataset[key][query]?
					returnset = returnset.concat dataset[key][query]
				return

			if success? and returnset.length isnt 0
				success.call event.target, returnset
			else if notfound?
				notfound.call event.target

		@keyup filter
		obj = {target: @}
		filter obj
}
