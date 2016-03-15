class Quizzes extends React.Component {
  componentDidMount() {
    var postUrl = this.props.postUrl;
    $('#quizForm').on('submit',function(e){
      e.preventDefault();
      DataUtil.handlePostToServer(postUrl,$(this).serialize(),'Creating Quiz. Please wait...',e);
      $('#quizForm').trigger("reset");
    });
  }

  render () {
    return (
      <div>
        <GenericList getUrl={this.props.getUrl} />
        <form id="quizForm">
          <label htmlFor="quiz[name]">Quiz Name</label>
          <input type="text" name="quiz[name]" id="quiz[name]" />
          <button className="btn right blue waves-effect waves-light"
                  type="submit" name="action">Submit
            <i className="material-icons right">send</i>
          </button>
        </form>
      </div>
    );
  }
}

Quizzes.displayName = "Quizzes";
Quizzes.propTypes = {
  getUrl: React.PropTypes.string.isRequired,
  postUrl: React.PropTypes.string.isRequired
}
