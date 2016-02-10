class Header extends React.Component {
  render () {
    return (
      <nav>
        <div className="nav-wrapper  blue darken-1">
          <a href={this.props.rootPath} id="logo" className="brand-logo center">hiTour</a>
          <a href="#" data-activates="mobile-nav" className="button-collapse"><i className="material-icons">menu</i></a>
          <ul className="right hide-on-med-and-down">
            <Navlist
              toursPath = {this.props.toursPath}
              pointsPath = {this.props.pointsPath}
              usersPath = {this.props.usersPath}
              logoutPath = {this.props.logoutPath}
            />
          </ul>
          <ul className="side-nav" id="mobile-nav">
          <Navlist
            toursPath = {this.props.toursPath}
            pointsPath = {this.props.pointsPath}
            usersPath = {this.props.usersPath}
            logoutPath = {this.props.logoutPath}
          />
          </ul>
        </div>
      </nav>

    );
  }
}

Header.displayName = "Header";
Header.propTypes = {
  rootPath: React.PropTypes.string.isRequired,
  toursPath: React.PropTypes.string.isRequired,
  pointsPath: React.PropTypes.string.isRequired,
  usersPath: React.PropTypes.string.isRequired,
  logoutPath: React.PropTypes.string.isRequired
}
