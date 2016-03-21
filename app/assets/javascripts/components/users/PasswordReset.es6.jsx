class PasswordReset extends React.Component {
  render () {
    return (
      <div className="container" style={{marginTop:'5%'}}>
        <div className="card-panel grey lighten-5">
          <div className="row">
            <form className="col s12" method="post" action={this.props.link_path}>
              <div className="row">
                <div className="input-field col s12">
                  <input name="email" id="email" type="email" placeholder="Email" className="validate" />
                </div>
              </div>
            <button className="btn waves-effect waves-light blue" type="submit" name="action">
              Reset password
              <i className="material-icons right">send</i>
             </button>
            </form>
          </div>
        </div>
      </div>
    );
  }
}

PasswordReset.displayName = 'PasswordReset'
PasswordReset.propTypes = {
  link_path: React.PropTypes.string.isRequired
};
