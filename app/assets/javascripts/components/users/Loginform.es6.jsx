class Loginform extends React.Component {
  render () {
    var buttonStyle = {
      display: 'block',
      marginLeft: 'auto',
      marginRight: 'auto'
    }
    return (
      <div className="container" style={{marginTop:'5%'}}>
        <div className="card-panel grey lighten-5">
          <div className="row">
            <h3 className="center-align">Welcome</h3>
            <form onSubmit={this.showProgressBar} className="col s12" method="post">
              <div className="row">
                <div className="input-field col s12">
                  <input name="email" id="email" type="email"
                                      placeholder="Email"
                                      className="validate" />
                </div>
              </div>
              <div className="row">
                <div className="input-field col s12">
                  <input name="password" id="password" type="password"
                                              placeholder="Password"
                                              className="validate" />
                </div>
              </div>
              <button style={buttonStyle}
                      className="btn waves-effect waves-light blue darken-1"
                      type="submit" name="action">
                <i className="material-icons left">lock</i>
                Login
              </button>
              <div className="row">
                <div className="col s12">
                  <a href={this.props.link_path} className="right">Forgot your password?</a>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    );
  }
  showProgressBar() {
    $('.progress-message').text('Logging in...');
    $('.progress-overlay').fadeIn(200);
  }
}

Loginform.displayName = 'Loginform';
Loginform.propTypes = {
  link_path: React.PropTypes.string.isRequired
}
