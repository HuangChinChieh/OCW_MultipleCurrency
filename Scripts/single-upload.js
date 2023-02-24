$(function(){
  /*
   * For the sake keeping the code clean and the examples simple this file
   * contains only the plugin configuration & callbacks.
   * 
   * UI functions ui_* can be located in:
   *   - assets/demo/uploader/js/ui-main.js
   *   - assets/demo/uploader/js/ui-multiple.js
   *   - assets/demo/uploader/js/ui-single.js
   */
  $('#drag-and-drop-zone, #drag-and-drop-zone2, #drag-and-drop-zone3').dmUploader({ //
    url: '/demo/java-script/upload',
    maxFileSize: 3000000, // 3 Megs max
    multiple: false,
    allowedTypes: 'image/*',
    extFilter: ['jpg','jpeg','png','gif'],
    onDragEnter: function(){
      // Happens when dragging something over the DnD area
      this.addClass('active');
    },
    onDragLeave: function(){
      // Happens when dragging something OUT of the DnD area
      this.removeClass('active');
    },
    onInit: function(){
      // Plugin is ready to use
      ui_add_log('Penguin initialized :)', 'info');

      this.find('input[type="text"]').val('');
    },
    onComplete: function(){
      // All files in the queue are processed (success or error)
      ui_add_log('All pending tranfers finished');
    },
    onNewFile: function(id, file){
      // When a new file is added using the file selector or the DnD area
      ui_add_log('New file added #' + id);

      if (typeof FileReader !== "undefined"){
        var reader = new FileReader();
        var img = this.find('img');
        
        reader.onload = function (e) {
          img.attr('src', e.target.result);
        }
        reader.readAsDataURL(file);
      }
    },
    onBeforeUpload: function(id){
      // about tho start uploading a file
      ui_add_log('Starting the upload of #' + id);
      ui_single_update_progress(this, 0, true);      
      ui_single_update_active(this, true);

      ui_single_update_status(this, '上傳中...');
    },
    onUploadProgress: function(id, percent){
      // Updating file progress
      ui_single_update_progress(this, percent);
    },
    onUploadSuccess: function(id, data){
      var response = JSON.stringify(data);

      // A file was successfully uploaded
      ui_add_log('Server Response for file #' + id + ': ' + response);
      ui_add_log('Upload of file #' + id + ' COMPLETED', 'success');

      ui_single_update_active(this, false);

      // You should probably do something with the response data, we just show it
      this.find('input[type="text"]').val(response);

      ui_single_update_status(this, '上傳成功', 'success');
    },
    onUploadError: function(id, xhr, status, message){
      // Happens when an upload error happens
      ui_single_update_active(this, false);
      ui_single_update_status(this, '錯誤： ' + message, 'danger');
    },
    onFallbackMode: function(){
      // When the browser doesn't support this plugin :(
      ui_add_log('Plugin cant be used here, running Fallback callback', 'danger');
    },
    onFileSizeError: function(file){//File excess the size limit
      ui_single_update_status(this, '文件超出大小限制', 'danger');

      ui_add_log('File \'' + file.name + '\' cannot be added: size excess limit', 'danger');
    },
    onFileTypeError: function(file){//File type is not an image
      ui_single_update_status(this, '檔案類型錯誤', 'danger');

      ui_add_log('File \'' + file.name + '\' cannot be added: must be an image (type error)', 'danger');
    },
    onFileExtError: function(file){//File extension not allowed
      ui_single_update_status(this, '附檔名格式錯誤', 'danger');

      ui_add_log('File \'' + file.name + '\' cannot be added: must be an image (extension error)', 'danger');
    }
  });
});