class Newuserform extends React.Component {
  render () {
    return (
      <div className="row">
        <form className="col s12" method="post" action={this.props.link_path}>
          <div className="row">
            <div className="input-field col s12">
              <input name="user[email]" id="email" type="email" className="validate" value={this.props.email}/>
              <label htmlFor="email">Email</label>
            </div>
          </div>
        <button className="btn waves-effect waves-light right blue" type="submit" name="action"><i className="material-icons right">send</i>
         </button>
        </form>
      </div>
    );
  }
}

Newuserform.displayName = "Newuserform";
Newuserform.propTypes = {
  link_path: React.PropTypes.string.isRequired
};