class Users extends React.Component {
  componentDidMount() {
    var postURL = this.props.postUrl;
    $('#userForm').on('submit',function(e){
      console.log($(this).serialize());
      e.preventDefault();
      $.ajax({
        url: postURL,
        type: "POST",
        dataType: "html",
        data: $(this).serialize(),
        success: function(data){
          Materialize.toast(data, 3000, 'rounded');
          $('#userForm').trigger("reset");
        },
        error: function(err){
          console.log("Error" + err);
          Materialize.toast('ERR: Succesfully added new user!', 3000, 'rounded');
        }
      });
    });
  }

  render () {
    return (
      <div>
        <GenericList getUrl={this.props.getUrl} />
        <form id="userForm">
          <label htmlFor="user[name]">User Email</label>
          <input type="text" name="user[name]" />
          <button className="btn right blue waves-effect waves-light"
                  type="submit" name="action">Submit
            <i className="material-icons right">send</i>
          </button>
        </form>
      </div>
    );
  }
}

Users.displayName = "Users";
Users.propTypes = {
  getUrl: React.PropTypes.string.isRequired,
  postUrl: React.PropTypes.string.isRequired
}
