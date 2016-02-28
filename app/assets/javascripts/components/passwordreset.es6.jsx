class PasswordReset extends React.Component {
  render () {
    return (
      <div className="row">
        <form className="col s12" method="post" action={this.props.link_path}>
          <div className="row">
            <div className="input-field col s12">
              <input name="email" id="email" type="email" className="validate" />
              <label htmlFor="email">Email</label>
            </div>
          </div>
        <button className="btn waves-effect waves-light blue" type="submit" name="action">
          Reset password
          <i className="material-icons right">send</i>
         </button>
        </form>
      </div>
    );
  }
}

PasswordReset.displayName = "PasswordReset"
PasswordReset.propTypes = {
  link_path: React.PropTypes.string.isRequired
};
