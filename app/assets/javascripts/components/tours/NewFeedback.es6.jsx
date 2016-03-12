class NewFeedback extends React.Component{
  componentDidMount () {
    var postUrl = this.props.postUrl;
    $('#feedbackForm').on('submit',function(e){
      e.preventDefault();
      // Show Progress
      $('.progress-message').text('Uploading Feedback. Please wait...');
      $('.progress-overlay').fadeIn(200);
      $.ajax({
        url: '/feedback',
        type: "POST",
        data: $(this).serialize(),
        success: function(data) {
          $('.progress-overlay').fadeOut();
          Materialize.toast(data, 3000, 'rounded');
        },
        error: function(data) {
          console.log(data);
          $('.progress-overlay').fadeOut();
          Materialize.toast(data, 3000, 'rounded');
        }
      });
    });
  }

  render () {
    return (
      <div>
        <form id="feedbackForm" className="col s12">
          <input type="hidden" name="feedback[tour_id]" value={this.props.tourId}></input>
          <div className="row">
            <p className="range-field">
              <input type="range" id="feedback[rating]" name="feedback[rating]" min="0" max="5"/>
              <label>Rating (Out of 5)</label>
            </p>
          </div>
          <div className="row">
            <div className="input-field col s12">
              <textarea id="feedback[comment]" className="materialize-textarea" name="feedback[comment]"></textarea>
              <label htmlFor="feedback[comment]">Comment</label>
            </div>
          </div>
          <button type="submit" className="waves-effect waves-light btn blue right">
            <i className="material-icons left">cloud</i>Save Feedback
          </button>
        </form>
      </div>
    );
  }
}

NewFeedback.displayName = "NewFeedback";
NewFeedback.propTypes = {
  tourId: React.PropTypes.number.isRequired,
  postUrl: React.PropTypes.string.isRequired
}
