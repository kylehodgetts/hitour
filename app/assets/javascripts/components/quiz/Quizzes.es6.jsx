class Quizzes extends React.Component {
  render () {
    return (
      <div>
        <GenericList getUrl={this.props.getUrl} />
          <SingleInputForm
            postUrl={this.props.postUrl}
            dataType="quiz"
            attr="name"
            labelValue="Quiz Name"
            />
      </div>
    );
  }
}

Quizzes.displayName = 'Quizzes';
Quizzes.propTypes = {
  getUrl: React.PropTypes.string.isRequired,
  postUrl: React.PropTypes.string.isRequired
}
