class NavlistItem extends React.Component {
  render () {
    var active = "";
    {this.props.currentPage == this.props.name &&
    (active = "active")}
    return(
      <li className={active}>
        <a style={{fontSize:'14px'}} href={this.props.url}><i style={{fontSize:'20px'}} className="material-icons left">{this.props.icon}</i>{this.props.name}</a>
      </li>
    );
  }
}

NavlistItem.displayName = "NavlistItem";
NavlistItem.propTypes = {
  url: React.PropTypes.string.isRequired,
  name: React.PropTypes.string.isRequired,
  currentPage: React.PropTypes.string,
  icon: React.PropTypes.string
}
