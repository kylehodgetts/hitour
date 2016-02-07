class Label extends React.Component {
  render () {
    return (
      <div>
        <a href={this.props.link}>Log out</a>
      </div>
    );
  }
}
Label.displayName = "Label";
Label.propTypes = {
  link: React.PropTypes.string.isRequired
};
