class Userlist extends React.Component {

  render () {
    return (
      <div>
        <div className="collection">
          {this.props.users.map(function(user) {
            return(
              <div key={user.id} className="collection-item">
                <div>
                  {user.email} &nbsp;&nbsp; Activated: {(user.activated?<b>true</b>:<b>false</b>)}
                  //Should add a confirmation box
                  <a href="#!" className="secondary-content">
                    <i className="material-icons">delete_forever</i>
                  </a>
                </div>
              </div>
            );
          })}
        </div>
      <a href={this.props.link_path}>Add a user you trust to the <b>HiTour CMS</b> .</a>
      </div>
    );
  }
}

Userlist.displayName = "Userlist";
Userlist.propTypes = {
  users: React.PropTypes.array.isRequired,
  link_path: React.PropTypes.array.isRequired
}
