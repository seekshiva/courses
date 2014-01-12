jQuery ->
  $(document).ready ->

    $(".selectpicker").selectpicker()

    # Uploadify needs csrf tokens & session details
    uploadify_script_data = {};

    csrf_token = $('meta[name=csrf-token]').attr('content');
    csrf_param = $('meta[name=csrf-param]').attr('content');
    uploadify_script_data[csrf_param] = encodeURI(csrf_token);
    uploadify_script_data[app["session_key"]] = app["session_val"];

    if uploadify? 
      for val in uploadify
        console.log(val);
        $("#"+val["id"]).uploadify({
          "swf" : "/swf/uploadify.swf",
          "uploader" : "/upload/"+val["uploader"]+".json",
          "formData" : uploadify_script_data,
          "buttonText" : val["buttonText"] || "Upload",
          "method" : val["method"] || "post",
          "removeCompleted": val["removeCompleted"] || true,
          "multi" : val["multi"] || false,
          "auto" : val["auto"] || true,
          "fileTypeDesc" : val["fileTypeDesc"] || "Image",
          "fileSizeLimit" : val["fileSizeLimit"] || "500kb",
          "onUploadSuccess" : val["onUploadSuccess"]
        });

    $("#departments_").change(() -> 
      value = $("#departments_").val();
      if value.length == 1 && value[0]=="2"
        $("#semester").append("<option value='9' class='sem_update'>9</option><option value='10' class='sem_update'>10</option>");
        $(".selectpicker").selectpicker("refresh");
      else 
        $(".sem_update").remove();
        $(".selectpicker").selectpicker("refresh");
    );