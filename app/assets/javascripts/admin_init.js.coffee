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

		# Uploadify needs csrf tokens & session details
		uploadify_script_data = {};

		csrf_token = $('meta[name=csrf-token]').attr('content');
		csrf_param = $('meta[name=csrf-param]').attr('content');
		uploadify_script_data[csrf_token] = encodeURI(csrf_param);
		uploadify_script_data[app["session_key"]] = app["session_val"];

		if uploadify? 
			console.table(uploadify);
			for val in uploadify
				$("#"+val["id"]).uploadify({
					"swf" : "/uploadify.swf",
					"uploader" : "/upload/",
					"formData" : uploadify_script_data,
					"buttonText" : val["buttonText"] || "Upload",
					"method" : val["method"] || "post",
					"removeCompleted": val["removeCompleted"] || "false",
					"multi" : val["multi"] || "false",
					"auto" : val["auto"] || "true",
					"fileTypeDesc" : val["fileTypeDesc"] || "Image",
					"fileSizeLimit" : val["fileSizeLimit"] || "500kb",
					"onComplete" : val["onComplete"],
					"onCancel" : val["onCancel"]
				});