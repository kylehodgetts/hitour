class SessionEmail extends React.Component {
  componentDidMount () {
    $('.sessionSelect').material_select();
    $('#sessionEmailForm').on('submit',function(e){
      e.preventDefault();
      var url = $(this).find('select').val();
      $('.progress-message').text('Sending Tour Invitation Email. Please wait...');
      $('.progress-overlay').fadeIn(200);
      $.ajax({
        url: url,
        type: "POST",
        data: $(this).serialize(),
        dataType: "json",
        success: function(data){
          $('.progress-overlay').fadeOut();
          Materialize.toast(data, 3000, 'rounded');
        }.bind(this),
        error: function(err){
          Materialize.toast(err, 3000, 'rounded');
          console.log(err);
        }.bind(this)
      });
    });
  }
  render () {
    var _this = this;
    return (
      <div className="col s12">
        <form id="sessionEmailForm" className="row">
          <div className="input-field col s4">
            <select id="sessionUrl" className="sessionSelect">
              {this.props.tourSessions.map(function(session){
                return (
                  <option key={session.email_url} value={session.email_url}>
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
            <button className="btn blue waves-effect waves-light"
                    type="submit" name="action">Send Email
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
  tourSessions: React.PropTypes.array.isRequired
}
