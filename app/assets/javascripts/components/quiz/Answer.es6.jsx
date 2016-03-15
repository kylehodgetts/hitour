class Answer extends React.Component{
  render () {
    var _this = this;
    return (
      <div className="collection-item">
        {this.props.answer.value}
        <a id={this.props.answer.id} href="" className="secondary-content"
                     onClick={DataUtil.handleDeleteDataFromServer.bind(this, this.props.answer.delete_url,"Are you sure you want to delete this answer?")}>
          <i className=" blue-text material-icons">delete_forever</i>
        </a>
      </div>
    );
  }
}

Answer.displayName = "Answer";
Answer.propTypes = {
  answer: React.PropTypes.object.isRequired
}
