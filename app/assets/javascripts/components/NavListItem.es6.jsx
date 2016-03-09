class NavlistItem extends React.Component {
  render () {
    if(this.props.currentPage != undefined
    && this.props.currentPage == this.props.name){
      return(
        <li className="active">
          <a href={this.props.url}>{this.props.name}</a>
        </li>
      );
    }else{
      return(
        <li>
          <a href={this.props.url}>{this.props.name}</a>
        </li>
      );
    }

  }
}

NavlistItem.displayName = "NavlistItem";
NavlistItem.propTypes = {
  url: React.PropTypes.string.isRequired,
  name: React.PropTypes.string.isRequired,
  currentPage: React.PropTypes.string
}
