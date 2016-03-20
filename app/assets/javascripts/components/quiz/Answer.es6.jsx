class Answer extends React.Component{
  render () {
    var _this = this;
    var message = 'Are you sure you want to make this correct?';
    return (
      <div className="collection-item">
        {this.props.answer.value}
        <a id={this.props.answer.id} href="" className="secondary-content"
                     onClick={DataUtil.handleDeleteDataFromServer.bind(this, this.props.answer.delete_url,
                                                                       'Are you sure you want to delete this answer?')}>
          <i className=" blue-text material-icons">delete_forever</i>
        </a>
        {this.props.answer.is_correct &&
            <i className=" blue-text material-icons secondary-content">thumb_up</i>
        }
        {!this.props.answer.is_correct &&
          <a href="" className="secondary-content"
                       onClick={DataUtil.handlePostToServer.bind(this,
                       this.props.answer.make_correct_url,null, message)}>
            <i className=" blue-text material-icons grey-text text-lighten-1">thumb_up</i>
          </a>
        }
      </div>
    );
  }
}

Answer.displayName = 'Answer';
Answer.propTypes = {
  answer: React.PropTypes.object.isRequired
}
