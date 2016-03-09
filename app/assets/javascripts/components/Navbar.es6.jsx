class Navbar extends React.Component {
  componentDidMount() {
    $(".button-collapse").sideNav();
  }

  renderNavList() {
    return (
      <Navlist
        loggedIn = {this.props.loggedIn}
        toursPath = {this.props.toursPath}
        pointsPath = {this.props.pointsPath}
        dataPath = {this.props.dataPath}
        audiencesPath = {this.props.audiencesPath}
        usersPath = {this.props.usersPath}
        logoutPath = {this.props.logoutPath}
      />
    );
  }

  render () {
    return (
      <nav>
        <div className="nav-wrapper  blue darken-1">
          <ul className="right hide-on-med-and-down">
            {this.props.currentUser &&
              <li>
                <a href={"/users/"+this.props.currentUser.id}>
                  {this.props.currentUser.email}
                </a>
              </li>
            }
            <NavlistItem
              url={this.props.logoutPath}
              name="Logout"
            />
          </ul>
          <a href={this.props.rootPath} id="logo" className="brand-logo center">hiTour</a>
          <a href="#" data-activates="mobile-nav" className="button-collapse"><i className="material-icons">menu</i></a>
          <ul className="left hide-on-med-and-down">
            <Navlist
              loggedIn = {this.props.loggedIn}
              currentPage = {this.props.currentPage}
              toursPath = {this.props.toursPath}
              pointsPath = {this.props.pointsPath}
              dataPath = {this.props.dataPath}
              audiencesPath = {this.props.audiencesPath}
              usersPath = {this.props.usersPath}
            />
          </ul>
          <ul className="side-nav" id="mobile-nav">
          <Navlist
            loggedIn = {this.props.loggedIn}
            currentPage = {this.props.currentPage}
            currentUser = {this.props.currentUser}
            toursPath = {this.props.toursPath}
            pointsPath = {this.props.pointsPath}
            dataPath = {this.props.dataPath}
            audiencesPath = {this.props.audiencesPath}
            usersPath = {this.props.usersPath}
            logoutPath = {this.props.logoutPath}
          />
          </ul>
        </div>
      </nav>
    );
  }
}

Navbar.displayName = "Navbar";
Navbar.propTypes = {
  loggedIn: React.PropTypes.bool.isRequired,
  currentUser: React.PropTypes.object,
  rootPath: React.PropTypes.string.isRequired,
  toursPath: React.PropTypes.string.isRequired,
  pointsPath: React.PropTypes.string.isRequired,
  dataPath: React.PropTypes.string.isRequired,
  audiencesPath: React.PropTypes.string.isRequired,
  usersPath: React.PropTypes.string.isRequired,
  logoutPath: React.PropTypes.string.isRequired,
  currentPage: React.PropTypes.string
}
