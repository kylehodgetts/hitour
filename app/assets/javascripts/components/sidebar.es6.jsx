class Sidebar extends React.Component {

  render () {
    return (
      <div className="sideBar">
        <p className="sideBar--appTitle">hiTour</p>
        <div>
          <p>{this.props.username}</p>
          <ul>
            <li>Points</li>
            <li>Tours</li>
            <li>Accounts</li>
          </ul>
        </div>
        <div>

        </div>
        <div>
          <a href={this.props.logoutPath}>Logout</a>
        </div>
      </div>
    );
  }
}

Sidebar.displayName = "Sidebar";
Sidebar.propTypes = {
  username: React.PropTypes.string.isRequired,
  logoutPath: React.PropTypes.string.isRequired
};
