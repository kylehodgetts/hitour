class Users extends React.Component {
  componentDidMount() {
    var postURL = this.props.postUrl;
    $('#userForm').on('submit',function(e){
      e.preventDefault();
      $.ajax({
        url: postURL,
        type: "POST",
        data: $(this).serialize(),
        success: function(data){
          $('#userForm').trigger("reset");
        },
        error: function(err){
          console.log(err);
        }
      });
    });
  }

  render () {
    return (
      <div>
        <GenericList getUrl={this.props.getUrl}
                     deleteUrl={this.props.deleteUrl} />
        <form id="userForm">
          <label htmlFor="user[name]">User Email</label>
          <input type="text" name="user[name]" />
          <input disabled type="password" value="password" name="user[password]" />
          <input disabled type="password" value="password" name="user[cpassword]" />
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
  postUrl: React.PropTypes.string.isRequired,
  deleteUrl: React.PropTypes.string.isRequired
}
