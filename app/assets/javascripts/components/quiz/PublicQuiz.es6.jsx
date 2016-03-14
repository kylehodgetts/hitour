class PublicQuiz extends React.Component{
  render () {
    var _this = this;
    return (
      <div>
        <h2>{this.props.quizData.quiz.name}</h2>
        <p>Thanks for coming to today's tour. Please fill in the quiz below. All responses will be kept anonymous</p>
        {this.props.quizData.questions.map(function(question, index) {
          return <PublicQuestion key={question.id} questionData={question} />
        })}
        <div className="row">
          <div>
            <NewFeedback
              tourId={this.props.tourId}
              postUrl={this.props.feedbackPostUrl}
            />
          </div>
        </div>
        <button className="waves-effect waves-light btn blue center-block"
          onClick={_this.submitAllForms.bind(this)}>
          <i className="material-icons left">cloud</i>Submit Answers
        </button>
      </div>
    );
  }
  submitAllForms () {
    var totalForms = $('.question-form').trigger('submit');
  }
}

PublicQuiz.displayName = "Public Quiz";
PublicQuiz.propTypes = {
  quizData: React.PropTypes.object.isRequired,
  tourId: React.PropTypes.number.isRequired,
  feedbackPostUrl: React.PropTypes.string.isRequired
}
