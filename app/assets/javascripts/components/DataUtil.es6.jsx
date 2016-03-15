class DataUtil {
  static handleLoadDataFromServer(url) {
    console.log(url);
    $.ajax({
      url: url,
      type: "GET",
      cache: false,
      success: function(data) {
        console.log(data);
        this.setState({data: data});
      }.bind(this)
    });
  }

  static handleCustomLoadDataFromServer(url,cb) {
    console.log(url);
    $.ajax({
      url: url,
      type: "GET",
      cache: false,
      success: function(data) {
        console.log(data);
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
