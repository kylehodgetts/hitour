class Navlist extends React.Component {
  render () {
    return (
      <div>
        <li><a href={this.props.toursPath}>Tours</a></li>
        <li><a href={this.props.pointsPath}>Points</a></li>
        <li><a href={this.props.usersPath}>Users</a></li>
        <li><a href={this.props.logoutPath}>Logout</a></li>
      </div>
    );
  }
}

Navlist.displayName = "Navlist";
Navlist.propTypes = {
  toursPath: React.PropTypes.string.isRequired,
  pointsPath: React.PropTypes.string.isRequired,
  usersPath: React.PropTypes.string.isRequired,
  logoutPath: React.PropTypes.string.isRequired
}
