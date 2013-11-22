jQuery ->
	$(document).ready ->
		$("#addMoreBooks").click (event)->
			event.preventDefault();
			list = ($('[name="books[]"]').last().parent().parent());
			list.parent().append("<tr>"+list.html()+"</tr>");
			console.log(list);
