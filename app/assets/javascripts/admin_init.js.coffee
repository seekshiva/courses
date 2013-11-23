jQuery ->
	$(document).ready ->
		$("#addMoreBooks").click (event)->
			event.preventDefault();
			list = ($('[name="books[]"]').last().parent().parent());
			list.parent().append("<tr>"+list.html()+"</tr>");
			console.log(list);
		$("#addMoreAuthors").click (event)->
			event.preventDefault();
			list = ($('[name="authors[]"]').last().parent().parent());
			list.parent().append("<tr>"+list.html()+"</tr>");
			console.log(list);