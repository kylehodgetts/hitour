class NewTourQuiz extends React.Component {
  componentDidMount() {
    var postQuizUrl = this.props.postUrl;
    $('#tourQuizForm').on('submit',function(e){
      DataUtil.handlePostToServer(postQuizUrl,$(this).serialize(),'Adding Quiz to Point',e);
    });
  }

  componentDidUpdate(prevProps, prevState){
    var check = JSON.stringify(prevProps) === JSON.stringify(this.props);
    if(!check || this.props == []){
      $('.quizSelect').material_select('destroy');
      $('.quizSelect').material_select();
    }
  }

  render () {
    return (
      <div>
          <form id="tourQuizForm" className="col s12">
            <p>Add a Quiz</p>
            <input value={this.props.tourId} type="hidden" name="tour[id]" />
            <div className="row">
              <div className="input-field col s12">
                <select name="quiz[id]" className="quizSelect">
                  {this.props.quizzes.map(function(quiz) {
                    return (
                      <option value={quiz.id} key={quiz.id} >{quiz.name}</option>
                    );
                  }, this)}
                </select>
                <label>Quiz</label>
              </div>
            </div>
            <button title="Add Quiz to Tour" className="btn-floating btn-large waves-effect waves-light blue right"
              type="submit" name="action">
              <i className="material-icons">add</i>
            </button>
          </form>
      </div>
    );
  }
}

NewTourQuiz.displayName = "NewTourQuiz";
NewTourQuiz.propTypes = {
  tourId: React.PropTypes.number.isRequired,
  quizzes: React.PropTypes.array.isRequired,
  postUrl: React.PropTypes.string.isRequired
}
