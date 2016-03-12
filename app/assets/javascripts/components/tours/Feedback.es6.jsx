class Feedback extends React.Component{
  handleDeleteDataFromServer(deleteUrl, e) {
    e.preventDefault();
    if(confirm("Are you sure you wish to delete this feedback?")) {
      // Show Progress
      $('.progress-message').text('Deleting feedback. Please wait.');
      $('.progress-overlay').fadeIn(200);
      $.ajax({
        url: deleteUrl,
        type: "DELETE",
        dataType: "json",
        success: function(data){
          $('.progress-overlay').fadeOut();
          Materialize.toast(data, 3000, 'rounded');
        }.bind(this),
        error: function(err){
          Materialize.toast('There was an issue deleting. Please contact admin.', 3000, 'rounded');
          console.log(err);
        }.bind(this)
      });
    }
  }

  render () {
    var _this = this;
    return (
      <div>
        <div className="collection">
          {this.props.feedbacks.map(function(feedback) {
            return (
              <div key={feedback.id} className="collection-item">
                <div>
                  <span>{feedback.comment}</span>
                  <a href={feedback.delete_url} className="secondary-content"
                             onClick={_this.handleDeleteDataFromServer.bind(this, feedback.delete_url)}>
                  <i className=" blue-text material-icons">delete_forever</i>
                  </a>
                </div>
              </div>
            );
          }, this)}
        </div>
      </div>
    );
  }
}

Feedback.displayName = "Feedback";
Feedback.propTypes = {
  feedbacks: React.PropTypes.array.isRequired
}
