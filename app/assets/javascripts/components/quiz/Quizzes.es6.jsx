class Quizzes extends React.Component {
  componentDidMount() {
    var postURL = this.props.postUrl;
    $('#quizForm').on('submit',function(e){
      e.preventDefault();
      $('.progress-message').text('Creating Quiz. Please wait...');
      $('.progress-overlay').fadeIn(200);
      $.ajax({
        url: postURL,
        type: "POST",
        data: $(this).serialize(),
        success: function(data){
          $('.progress-overlay').fadeOut();
          Materialize.toast(data, 3000, 'rounded');
          $('#quizForm').trigger("reset");
        },
        error: function(err){
          console.log("Error" + err);
          console.log(err);
          Materialize.toast('ERR: Succesfully added new quiz!', 3000, 'rounded');
        }
      });
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
