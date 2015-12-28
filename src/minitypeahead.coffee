$.fn.extend {
	minitypeahead: (settings) ->
		return if not settings.dataset? or not settings.keys?
		$.each settings, (key, value) =>
			@data key, value

		filter = (event) ->
			dataset = $(event.target).data 'dataset'
			keys = $(event.target).data 'keys'
			target = $(event.target).data 'target'
			notfound = $(event.target).data 'notfound'
			success = $(event.target).data 'success'

			query = $(event.target).val().toLowerCase().latinize()

			if query.length < 2
				if notfound?
					notfound.call event.target 
				return

			supermatch = false
			selected_obj = {}
			lowest_occurance = 20000

			$.each dataset, (i, obj) ->
				$.each keys, (j, key) ->
					occ = obj[key].toLowerCase().latinize().indexOf query
					if occ isnt -1
						if occ < lowest_occurance
							selected_obj = obj
							lowest_occurance = occ
						if obj[key].toLowerCase().latinize() is query
							supermatch = true
							selected_obj = obj
							return false
				return false if supermatch

			if success? and not $.isEmptyObject selected_obj
				success.call event.target, selected_obj
			else if notfound?
				notfound.call event.target

		@keyup filter
		obj = {target: @}
		filter obj
}