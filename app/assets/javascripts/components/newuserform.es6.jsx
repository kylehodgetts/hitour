class Newuserform extends React.Component {
  render () {
    return (
      <div className="row">
        <form className="col s12">
          <div className="row">
            <div className="input-field col s12">
              <input name="email" id="email" type="email" className="validate" />
              <label htmlFor="email">Email</label>
            </div>
          </div>
        </form>
      </div>
    );
  }
}

Newuserform.displayName = "Newuserform";
