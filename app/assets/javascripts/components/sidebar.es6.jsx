class Sidebar extends React.Component {
  render () {
    return (
      <div>
        <p>{this.props.username}</p>
      </div>
    );
  }
}

Sidebar.displayName = "Sidebar";
Sidebar.propTypes = {
  username: React.PropTypes.string.isRequired
};
