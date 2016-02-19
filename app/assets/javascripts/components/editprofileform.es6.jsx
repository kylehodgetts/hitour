class Editprofileform extends React.Component {
  renderFlash() {
    var colorClass = "card-panel red lighten-1";
    if(this.props.saveSucc == "true") {
      colorClass = "card-panel teal lighten-2";
    }
    return(
      <div className={colorClass}>
        <h6 className="white-text center-align flow-text">
          {this.props.saveMessage}
        </h6>
      </div>
    );
  }
  render () {
    return (
      <div className="row">
        {this.props.saveMessage &&
          this.renderFlash()
        }
        <form className="col s12" method="post">
          <input type="hidden" name="_method" value="patch" />
          <div className="row">
            <div className="input-field col s12">
              <input name="email" disabled value={this.props.currentUser.email}
                     id="email" type="email" className="validate" />
              <label htmlFor="email" data-error="wrong" data-success="right">
                Email
              </label>
            </div>
          </div>
          <div className="row">
            <div className="input-field col s6">
              <input name="password" id="password" type="password" className="validate" />
              <label data-error="Password must be at least 6 characters long"
                     htmlFor="password">New Password</label>
            </div>
            <div className="input-field col s6">
              <input name="cpassword" pattern=".{6,}" required id="confirm-password" type="password" className="validate" />
              <label data-error="Password must be at least 6 characters long"
                     htmlFor="confirm-password">Confirm Password</label>
            </div>
          </div>
          <div className="row">
            <button className="btn waves-effect waves-light right blue"
                                type="submit" name="action">
              Save
              <i className="material-icons right">send</i>
            </button>
          </div>
        </form>
      </div>
    );
  }
}

Editprofileform.displayName = "Editprofileform"
Editprofileform.propTypes = {
  currentUser: React.PropTypes.object.isRequired,
  saveSucc: React.PropTypes.string,
  saveMessage: React.PropTypes.string
}
