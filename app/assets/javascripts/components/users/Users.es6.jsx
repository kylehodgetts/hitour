class Users extends React.Component {
  render () {
    return (
      <div>
        <GenericList getUrl={this.props.getUrl} users />
        <SingleInputForm
          postUrl={this.props.postUrl}
          dataType="user"
          attr="email"
          labelValue="User Email"
          />
      </div>
    );
  }
}

Users.displayName = "Users";
Users.propTypes = {
  getUrl: React.PropTypes.string.isRequired,
  postUrl: React.PropTypes.string.isRequired
}
