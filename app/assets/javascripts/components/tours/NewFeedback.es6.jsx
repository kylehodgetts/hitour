class NewFeedback extends React.Component{
  componentDidMount () {
    var postUrl = this.props.postUrl;
    $('#feedbackForm').on('submit',function(e){
      e.preventDefault();
      // Show Progress
      $('.progress-message').text('Submitting Quiz and Feedback data. Please wait...');
      $('.progress-overlay').fadeIn(200);
      $.ajax({
        url: '/feedback',
        type: "POST",
        data: $(this).serialize(),
        success: function(data) {
          $('.progress-overlay').fadeOut();
          $('.star').eq(0).trigger('click');
          $('#feedbackForm').trigger('reset');
          Materialize.toast('Succesfully submitted feedback and quiz', 3000, 'rounded');
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
          <StarRating
            formName="feedback[rating]"
            numberOfStars={5}
          />
          <div className="row">
            <div className="input-field col s12">
              <textarea id="feedback[comment]" placeholder="Leave a comment" className="validate materialize-textarea" name="feedback[comment]"></textarea>
            </div>
          </div>
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
