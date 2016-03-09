class Users extends React.Component {
  componentDidMount() {
    var postURL = this.props.postUrl;
    $('#userForm').on('submit',function(e){
      e.preventDefault();
      $('.progress-message').text('Creating User. Please wait...');
      $('.progress-overlay').fadeIn(200);
      $.ajax({
        url: postURL,
        type: "POST",
        data: $(this).serialize(),
        success: function(data){
          $('.progress-overlay').fadeOut();
          Materialize.toast(data, 3000, 'rounded');
          $('#userForm').trigger("reset");
        },
        error: function(err){
          console.log("Error" + err);
          console.log(err);
          Materialize.toast('ERR: Succesfully added new user!', 3000, 'rounded');
        }
      });
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
