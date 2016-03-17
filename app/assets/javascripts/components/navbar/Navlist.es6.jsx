class Navlist extends React.Component {

  render () {
    if(this.props.loggedIn) {
      var iconClass = "nav-icon";
      console.log(this.props.forMobile);
      if(this.props.forMobile){
        iconClass = "";
      }
      return(
        <div>
        {this.props.currentUser &&
          <li><a href={"/users/"+this.props.currentUser.id}>My Profile</a></li>
        }
        <NavlistItem url={this.props.toursPath}
                     name="Tours"
                     icon="navigation"
                     iconClass={iconClass}
                     currentPage={this.props.currentPage}/>
        <NavlistItem url={this.props.pointsPath}
                     name="Points"
                     icon="room"
                     iconClass={iconClass}
                     currentPage={this.props.currentPage}/>
        <NavlistItem url={this.props.dataPath}
                     name="Data"
                     icon="movie"
                     iconClass={iconClass}
                     currentPage={this.props.currentPage}/>
        <NavlistItem url={this.props.audiencesPath}
                     name="Audiences"
                     icon="person_pin"
                     iconClass={iconClass}
                     currentPage={this.props.currentPage}/>
        <NavlistItem url={this.props.quizzesPath}
                     name="Quizzes"
                     icon="receipt"
                     iconClass={iconClass}
                     currentPage={this.props.currentPage}/>
        <NavlistItem url={this.props.usersPath}
                     name="Users"
                     icon="recent_actors"
                     iconClass={iconClass}
                     currentPage={this.props.currentPage}/>
        {this.props.logoutPath &&
          <NavlistItem url={this.props.logoutPath}
                       name="Logout"
                       iconClass={iconClass}
                       currentPage={this.props.currentPage}/>
        }
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
  quizzesPath: React.PropTypes.string.isRequired,
  dataPath: React.PropTypes.string.isRequired,
  audiencesPath: React.PropTypes.string.isRequired,
  usersPath: React.PropTypes.string.isRequired,
  logoutPath: React.PropTypes.string,
  forMobile: React.PropTypes.string
}
