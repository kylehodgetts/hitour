class Navlist extends React.Component {

  render () {
    if(this.props.loggedIn) {
      return(
        <div>
        {this.props.currentUser &&
          <li><a href={"/users/"+this.props.currentUser.id}>My Profile</a></li>
        }
        <NavlistItem url={this.props.toursPath}
                     name="Tours"
                     currentPage={this.props.currentPage}/>
        <NavlistItem url={this.props.pointsPath}
                     name="Points"
                     currentPage={this.props.currentPage}/>
        <NavlistItem url={this.props.dataPath}
                     name="Data"
                     currentPage={this.props.currentPage}/>
        <NavlistItem url={this.props.audiencesPath}
                     name="Audiences"
                     currentPage={this.props.currentPage}/>
        <NavlistItem url={this.props.usersPath}
                     name="Users"
                     currentPage={this.props.currentPage}/>
        <NavlistItem url={this.props.logoutPath}
                     name="Logout"
                     currentPage={this.props.currentPage}/>
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
  currentPage: React.PropTypes.string,
  currentUser: React.PropTypes.object,
  toursPath: React.PropTypes.string.isRequired,
  pointsPath: React.PropTypes.string.isRequired,
  dataPath: React.PropTypes.string.isRequired,
  audiencesPath: React.PropTypes.string.isRequired,
  usersPath: React.PropTypes.string.isRequired,
  logoutPath: React.PropTypes.string.isRequired
}
