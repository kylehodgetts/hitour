class DataUtil {
  static handleLoadDataFromServer(url) {
    $.ajax({
      url: url,
      type: "GET",
      cache: false,
      success: function(data) {
        if(this.mounted){
          this.setState({data: data, loading: false});
        }
      }.bind(this)
    });
  }

  static handleCustomLoadDataFromServer(url,cb) {
    $.ajax({
      url: url,
      type: "GET",
      cache: false,
      success: function(data) {
        cb(data);
      }
    });
  }

  static handlePostToServer(url,data,message,e) {
    if(e != undefined){
      e.preventDefault();
    }
    // Show Progress
    $('.progress-message').text(message);
    $('.progress-overlay').fadeIn(200);
    $.ajax({
      url: url,
      type: "POST",
      data: data,
      success: function(response){
        $('.progress-overlay').fadeOut();
        Materialize.toast(response, 3000, 'rounded');
      },
      error: function(err){
        console.log(err);
      }
    });
  }

  static handleUpdateDataToServer(url,formData,message,cb) {
    // Show Progress
    $('.progress-message').text(message);
    $('.progress-overlay').fadeIn(200);
    $.ajax({
      url: url,
      type: "PATCH",
      data: formData,
      success: function(data){
        $('.progress-overlay').fadeOut();
        Materialize.toast(data, 3000, 'rounded');
        cb(data);
      },
      error: function(err){
        console.log(err);
        Materialize.toast(err, 3000, 'rounded');
      }
    });
  }

  static handleDeleteDataFromServer(deleteUrl, message, e) {
    e.preventDefault();
    if (confirm(message)) {
      $('.progress-message').text('Deleting Record. Please wait...');
      $('.progress-overlay').fadeIn(200);
      $.ajax({
        url: deleteUrl,
        type: "DELETE",
        success: function(data) {
          $('.progress-overlay').fadeOut();
          Materialize.toast(data, 3000, 'rounded');
        }.bind(this),
        error: function(err) {
          Materialize.toast('There was an issue deleting. Please contact admin.', 3000, 'rounded');
          console.log(err);
        }.bind(this)
      });
    }
  }
}
