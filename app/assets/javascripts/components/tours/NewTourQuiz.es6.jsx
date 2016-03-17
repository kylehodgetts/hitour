class NewTourQuiz extends React.Component {
  componentDidMount() {
    var postQuizUrl = this.props.postUrl;
    $('#tourQuizForm').on('submit',function(e){
      DataUtil.handlePostToServer(postQuizUrl,$(this).serialize(),'Adding Quiz to Tour',e);
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
      <div className="col s6">
        <div className="card-panel">
            <div className="row">
              <form id="tourQuizForm" className="col s12">
                <h4>Add a Quiz</h4>
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
        </div>
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
