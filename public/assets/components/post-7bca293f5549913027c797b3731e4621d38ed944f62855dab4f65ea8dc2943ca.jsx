class Post extends React.Component {
  render() {
    return (
      <div>
        <div>Title: {this.props.title}</div>
        <div>Body: {this.props.body}</div>
        <div>Published: {this.props.published}</div>
        <div>Published By: {this.props.publishedBy}</div>
      </div>
    );
  }
}
Post.displayName = "Post";
Post.propTypes = {
  title: React.PropTypes.string,
  body: React.PropTypes.string,
  published: React.PropTypes.bool,
  publishedBy: React.PropTypes.instanceOf(Person)
};
