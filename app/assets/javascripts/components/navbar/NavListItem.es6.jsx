class NavlistItem extends React.Component {
  render () {
    var active = "";
    {this.props.currentPage == this.props.name &&
    (active = "active")}
    return(
      <li className={active}>
        <a href={this.props.url}>{this.props.name}</a>
      </li>
    );
  }
}

NavlistItem.displayName = "NavlistItem";
NavlistItem.propTypes = {
  url: React.PropTypes.string.isRequired,
  name: React.PropTypes.string.isRequired,
  currentPage: React.PropTypes.string
}
