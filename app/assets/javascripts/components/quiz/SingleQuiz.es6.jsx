class SingleQuiz extends React.Component{
  constructor (props) {
    super(props);
    this.state =  {
      quiz: [],
      questions: [],
      pollInterval: this.props.pollInterval || 2000
    };
  }

  componentDidMount() {
    this.handleLoadDataFromServer();
    this.interval = setInterval(
      this.handleLoadDataFromServer.bind(this),
      this.state.pollInterval
    );
  }

  componentDidUpdate(prevProps, prevState) {
    var check = JSON.stringify(prevState) === JSON.stringify(this.state);
    if(!check || this.state.question == []){
      $('.collapsible').collapsible();
    }
  }

  componentWillUnmount() {
    this.interval && clearInterval(this.interval);
    this.interval = false;
  }

  handleLoadDataFromServer() {
    $.ajax({
      url: this.props.getUrl,
      type: "GET",
      dataType: "json",
      cache: false,
      success: function(data){
        this.setState({
          quiz: data,
          questions: data["questions"]
        });
      }.bind(this)
    });
  }

  handleDeleteDataFromServer(deleteUrl, e) {
    e.preventDefault();
    if(confirm("Are you sure you wish to delete this record")) {
      $('.progress-message').text('Deleting Record. Please wait...');
      $('.progress-overlay').fadeIn(200);
      $.ajax({
        url: deleteUrl,
        type: "DELETE",
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
        <h2>{this.state.quiz.name}</h2>
        <ul className="collapsible" data-collapsible="accordion">
          {this.state.questions.map(function(question, i) {
            if(question.description.length > 25 && $(document).width() <= 350){
              question.description = question.description.substring(0,25)+"...";
            }
            return (
              <li key={question.id} >
                <div className="collapsible-header">
                  {question.description}
                  <a href="" className="secondary-content"
                               onClick={_this.handleDeleteDataFromServer.bind(this, question.delete_url)}>
                    <i className=" blue-text material-icons">delete_forever</i>
                  </a>
                  {question.show_url &&
                    <a id={item.id} href={question.show_url} className="secondary-content">
                      <i className=" blue-text material-icons">launch</i>
                    </a>
                  }
                </div>
                <div className="collapsible-body collection">
                  <div className="collection-item">
                    <table className="centered striped">
                      <thead>
                        <tr>
                          <th data-field="id">Correctly Answered</th>
                          <th data-field="name">Incorrectly Answered</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>{question.correctly_answered}</td>
                          <td>{question.wrongly_answered}</td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                  {question.answers.map(function(answer, index) {
                    return <Answer key={answer.id} answer={answer} />
                  })}
                </div>
              </li>
            );
          }, this)}
        </ul>
      </div>
    )
  }
}

SingleQuiz.displayName = "Single Quiz";
SingleQuiz.propTypes = {
  getUrl: React.PropTypes.string.isRequired,
  postQuestionUrl: React.PropTypes.string.isRequired,
  pollInterval: React.PropTypes.number
};
