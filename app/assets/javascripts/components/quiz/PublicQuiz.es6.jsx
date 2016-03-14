class PublicQuiz extends React.Component{
  render () {
    var _this = this;
    return (
      <div>
        <h2 className="quiz-title">{this.props.quizData.quiz.name}</h2>
        <h2 className="quiz-result" style={{display:'none'}}>Thank You! You Scored <span className="total-score">0</span>/{this.props.quizData.questions.length}</h2>
        <p className="quiz-subtitle">Thanks for coming the <b>{this.props.tour.name}</b>. Please fill in the quiz below. All responses will be kept anonymous</p>
        {this.props.quizData.questions.map(function(question, index) {
          return <PublicQuestion key={question.id} questionData={question} index={index} />
        })}
        <div className="row">
          <div>
            <NewFeedback
              tourId={this.props.tourId}
              postUrl={this.props.feedbackPostUrl}
            />
          </div>
        </div>
        <button className="submitAllButton waves-effect waves-light btn blue center-block"
          onClick={_this.submitAllForms.bind(this)}>
          <i className="material-icons left">cloud</i>Submit Answers
        </button>
      </div>
    );
  }
  submitAllForms () {
    //Scroll to top
    $("html, body").animate({ scrollTop: 0 }, "slow");
    //Hide Button
    $('.submitAllButton').hide();
    //Hide Feedback form
    $('#feedbackForm').hide();
    //Hide Quiz Title
    $('.quiz-title').hide();
    //Show Quiz Result Title
    $('.quiz-result').show();
    var totalForms = $('.question-form').trigger('submit');
    $('.quiz-subtitle').text('You answers and feedback have been submitted! Please review your answers below.')
  }
}

PublicQuiz.displayName = "Public Quiz";
PublicQuiz.propTypes = {
  tour: React.PropTypes.object.isRequired,
  quizData: React.PropTypes.object.isRequired,
  tourId: React.PropTypes.number.isRequired,
  feedbackPostUrl: React.PropTypes.string.isRequired
}
