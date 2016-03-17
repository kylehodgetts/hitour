class Users extends React.Component {
  componentDidMount() {
    var postUrl = this.props.postUrl;
    $('#userForm').on('submit',function(e){
      e.preventDefault();
      DataUtil.handlePostToServer(postUrl,$(this).serialize(),'Creating User. Please wait...',e);
      $('#userForm').trigger("reset");
    });
  }

  render () {
    return (
      <div>
        <GenericList getUrl={this.props.getUrl} users />
        <form id="userForm">
          <label htmlFor="user[email]">User Email</label>
          <input type="text" name="user[email]" id="user[email]" />
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
