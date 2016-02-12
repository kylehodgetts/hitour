class Navbar extends React.Component {

  renderNavList() {
    return (
      <Navlist
        loggedIn = {this.props.loggedIn}
        currentUserPath = {this.props.currentUserPath}
        toursPath = {this.props.toursPath}
        pointsPath = {this.props.pointsPath}
        usersPath = {this.props.usersPath}
        logoutPath = {this.props.logoutPath}
      />
    );
  }

  render () {
    return (
      <nav>
        <div className="nav-wrapper  blue darken-1">
          <ul className="left hide-on-med-and-down">
            <li><a href={this.props.currentUserPath}>
              {this.props.currentUser}
            </a></li>
          </ul>
          <a href={this.props.rootPath} id="logo" className="brand-logo center">hiTour</a>
          <a href="#" data-activates="mobile-nav" className="button-collapse"><i className="material-icons">menu</i></a>
          <ul className="right hide-on-med-and-down">
            {this.renderNavList()}
          </ul>
          <ul className="side-nav" id="mobile-nav">
            {this.renderNavList()}
          </ul>
        </div>
      </nav>
    );
  }
}

Navbar.displayName = "Header";
Navbar.propTypes = {
  loggedIn: React.PropTypes.bool.isRequired,
  currentUser: React.PropTypes.string.isRequired,
  currentUserPath: React.PropTypes.string.isRequired,
  rootPath: React.PropTypes.string.isRequired,
  toursPath: React.PropTypes.string.isRequired,
  pointsPath: React.PropTypes.string.isRequired,
  usersPath: React.PropTypes.string.isRequired,
  logoutPath: React.PropTypes.string.isRequired
}
