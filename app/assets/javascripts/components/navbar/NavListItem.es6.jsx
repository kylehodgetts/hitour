class NavlistItem extends React.Component {
  render () {
    var active = "";
    {this.props.currentPage == this.props.name &&
    (active = "active")}
    return(
      <li className={active}>
        <a style={{fontSize:'12px'}} href={this.props.url}><i style={{fontSize:'12px'}} className="material-icons nav-icon left">{this.props.icon}</i>{this.props.name}</a>
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
