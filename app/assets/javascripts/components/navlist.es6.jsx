class Navlist extends React.Component {

  render () {
    if(this.props.loggedIn) {
      return(
        <div>
          <li><a href={this.props.currentUserPath}>My Profile</a></li>
          <li><a href={this.props.toursPath}>Tours</a></li>
          <li><a href={this.props.pointsPath}>Points</a></li>
          <li><a href={this.props.usersPath}>Users</a></li>
          <li><a href={this.props.logoutPath}>Logout</a></li>
        </div>
      );
    }
    else {
      return(
        <div></div>
      );
    }
  }
}

Navlist.displayName = "Navlist";
Navlist.propTypes = {
  loggedIn: React.PropTypes.bool.isRequired,
  currentUserPath: React.PropTypes.string.isRequired,
  toursPath: React.PropTypes.string.isRequired,
  pointsPath: React.PropTypes.string.isRequired,
  usersPath: React.PropTypes.string.isRequired,
  logoutPath: React.PropTypes.string.isRequired
}
