class Loginform extends React.Component {
  render () {
    return (
      <div className="row">
        <form onSubmit={this.showProgressBar} className="col s12" method="post">
          <div className="row">
            <div className="input-field col s12">
              <input name="email" id="email" type="email"
                                  className="validate" />
              <label htmlFor="email">Email</label>
            </div>
          </div>
          <div className="row">
            <div className="input-field col s12">
              <input name="password" id="password" type="password"
                                          className="validate" />
              <label htmlFor="password">Password</label>
            </div>
          </div>
          <button className="btn waves-effect waves-light blue darken-1"
                                            type="submit" name="action">
            Login
          </button>
          <div className="row">
            <div className="input-field col s12">
              <a href={this.props.link_path}>Forgot your password?</a>
            </div>
          </div>
        </form>
      </div>
    );
  }
  showProgressBar() {
    $('.progress-message').text('Logging in...');
    $('.progress-overlay').fadeIn(200);
  }
}

Loginform.displayName = "Loginform";
Loginform.propTypes = {
  link_path: React.PropTypes.string.isRequired
}
