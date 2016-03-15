class SessionEmail extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      tourSessions: [],
      pollInterval: this.props.pollInterval || 2000,
      intervalId: 0
    };
  }

  componentDidMount() {
    this.handleLoadDataFromServer();
    this.interval = setInterval(this.handleLoadDataFromServer.bind(this), this.state.pollInterval);
    $('#sessionEmailForm').on('submit', function(e) {
      e.preventDefault();
      var url = $(this).find('select').val();
      $('.progress-message').text('Sending Tour Invitation Email. Please wait...');
      $('.progress-overlay').fadeIn(200);
      $.ajax({
        url: url,
        type: "POST",
        data: $(this).serialize(),
        dataType: "json",
        success: function(data) {
          $('.progress-overlay').fadeOut();
          Materialize.toast(data, 3000, 'rounded');
        }.bind(this),
        error: function(err) {
          Materialize.toast(err, 3000, 'rounded');
          console.log(err);
        }.bind(this)
      });
    });
  }

  componentDidUpdate(prevProps, prevState) {
    var check = JSON.stringify(prevState) === JSON.stringify(this.state);
    if (!check) {
      $('.sessionSelect').material_select('destroy');
      $('.sessionSelect').material_select();
    }
  }

  componentWillUnmount() {
    this.interval && clearInterval(this.interval);
  }

  handleLoadDataFromServer() {
    $.ajax({
      url: this.props.tourSessionsUrl,
      type: "GET",
      dataType: "json",
      cache: false,
      success: function(data) {
        this.setState({
          tourSessions: data[0]["tour_sessions"]
        });
      }.bind(this)
    });
  }

  render() {
    var _this = this;
    return (
      <div className="col s12">
        <form id="sessionEmailForm" className="row">
          <div className="input-field col s4">
            <select id="sessionUrl" className="sessionSelect">
              {this.state.tourSessions.map(function(session) {
                return (
                  <option key={session.id} value={session.email_url}>
                    {session.name}
                  </option>
                );
              }, this)}
            </select>
            <label>Session:</label>
          </div>
          <div className="input-field col s4">
            <input placeholder="Receipients email" type="email" className="validate" name="email"></input>
            <label className="active">Email:</label>
          </div>
          <div className="col s2">
            <button className="btn blue waves-effect waves-light" type="submit" name="action">Send Email
              <i className="material-icons right">send</i>
            </button>
          </div>

        </form>
      </div>
    );
  }
}

SessionEmail.displayName = "SessionEmail";
SessionEmail.propTypes = {
  tourSessionsUrl: React.PropTypes.string.isRequired,
  pollInterval: React.PropTypes.number
}
