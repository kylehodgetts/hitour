class PublicQuestion extends React.Component{
  constructor (props) {
    super(props);
    this.state =  {
      response: [],
      correctAnswer: []
    };
  }
  componentDidMount () {
    var postUrl = this.props.questionData.submit_url;
    var _this = this;
    var id = '#'+this.props.questionData.id + 'question-form';
    $(id).on('submit',function(e){
      e.preventDefault();
      $.ajax({
        url:postUrl,
        type: "POST",
        async: false,
        data:$(this).serialize(),
        success: function(data){
          if(data != 'No Answer'){
            this.setState({
              response: data.correct,
              correctAnswer: data.answer
            });
            //Disable all inputs
            $(id).find('input').prop('disabled',true);
            //Increment if correct
            if(data.correct){
              var current = parseInt($('.total-score').text());
              $('.total-score').text(current+1);
            }
          }
        }.bind(_this),
        error: function(data){
          console.log(data);
        }
      });
    });
  }

  render () {
    var _this = this;
    return (
      <div className="row">
        <div className="card-panel">
          <form className="question-form" id={this.props.questionData.id+"question-form"}>
            <p>{this.props.index + 1}. <b>{this.props.questionData.description}</b></p>
            <input type="hidden" name="question[id]" value={this.props.questionData.id} />
            {this.props.questionData.answers.map(function(answer, index) {
              return (
                <p key={answer.id}>
                  <input name="answer[id]"
                         type="radio"
                         id={"answer-"+answer.id}
                         value={answer.id}
                         defaultChecked = {index == 0}
                         required/>
                  <label htmlFor={"answer-"+answer.id}>{answer.value}</label>
                </p>
              );
            })}
            {this.state.response === true &&
              <p className="correct-answer">Correct!</p>
            }
            {this.state.response === false &&
              <p className="wrong-answer">Wrong. The correct answer was {"'"+this.state.correctAnswer.value+"'"}</p>
            }
          </form>
        </div>
      </div>
    );
  }
}

PublicQuestion.displayName = 'Public Question';
PublicQuestion.propTypes = {
  questionData: React.PropTypes.object.isRequired,
  index: React.PropTypes.number.isRequired
}
