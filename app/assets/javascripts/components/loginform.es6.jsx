class Loginform extends React.Component {
  render () {
    return (
      <div className="row">
        <form className="col s12" method="post">
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
        </form>
      </div>
    );
  }
}

Loginform.displayName = "Loginform";
