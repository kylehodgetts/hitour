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
    $('.star').on('click',function(e){
      var allStars = $('.star');
      allStars.removeClass('star-selected');
      console.log(this);
      var currentIndex = allStars.index(this);
      for(var i = 0;i <= currentIndex;i++){
        var star = allStars.eq(i);
        star.addClass('star-selected');
      }
      //Set the Hidden input
      $(this).parent().parent().find('input').val(currentIndex+1);
      console.log(allStars.index(this));
    });
  }

  render () {
    return (
      <div>
        <form id="feedbackForm" className="col s12" style={{border:'1px solid black'}}>
          <h3>Add Feedback</h3>
          <div className="row col s12">
            <p className="star-rating"><span className="star material-icons">star_rate</span></p>
            <p className="star-rating"><span className="star material-icons">star_rate</span></p>
            <p className="star-rating"><span className="star material-icons">star_rate</span></p>
            <p className="star-rating"><span className="star material-icons">star_rate</span></p>
            <p className="star-rating"><span className="star material-icons">star_rate</span></p>
            <input type="hidden" name="feedback[rating]"/>
        </div>
          <input type="hidden" name="feedback[tour_id]" value={this.props.tourId}></input>
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
