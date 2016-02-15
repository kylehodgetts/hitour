class Userlist extends React.Component {

  render () {
    return (
      <div>
        <div className="collection">
          {this.props.users.map(function(user) {
            return(
              <div key={user.id} className="collection-item">
                <div>
                  {user.email}
                  <a href="#!" className="secondary-content">
                    <i className="material-icons">delete_forever</i>
                  </a>
                </div>
              </div>
            );
          })}
        </div>
      </div>
    );
  }
}

Userlist.displayName = "Userlist";
Userlist.propTypes = {
  users: React.PropTypes.array.isRequired
}
