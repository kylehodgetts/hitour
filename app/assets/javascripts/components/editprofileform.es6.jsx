class Editprofileform extends React.Component {
  componentDidMount() {
    var patchUrl = this.props.patchUrl;
    $('#updateForm').on('submit',function(e){
      e.preventDefault();
      $.ajax({
        url: patchUrl,
        type: "POST",
        dataType: "json",
        data: $(this).serialize(),
        success: function(data){
          Materialize.toast(data, 3000, 'rounded');
        },
        error: function(err){
          console.log("Error" + err);
        }
      });
      $('#updateForm').trigger("reset");
      document.getElementById('password').focus();
    });
  }

  render () {
    return (
      <div className="row">
        <form id="updateForm" className="col s12" method="post">
          <div className="row">
            <div className="input-field col s12">
              <input name="user[email]" disabled value={this.props.currentUser.email}
                     id="email" type="email" className="validate" />
              <label htmlFor="email" data-error="wrong" data-success="right">
                Email
              </label>
            </div>
          </div>
          <div className="row">
            <div className="input-field col s6">
              <input name="user[password]" id="password" type="password"
                     className="validate" />
              <label data-error="Password must be at least 6 characters long"
                     htmlFor="password">New Password</label>
            </div>
            <div className="input-field col s6">
              <input name="user[cpassword]" pattern=".{6,}"
                     required id="confirm-password" type="password"
                     className="validate" />
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
  patchUrl: React.PropTypes.string.isRequired
}
