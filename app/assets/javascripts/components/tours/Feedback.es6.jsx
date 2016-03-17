class Feedback extends React.Component{
  render () {
    var _this = this;
    return (
        <ul className="collection">
          {this.props.feedbacks.map(function(feedback) {
            return (
              <li key={feedback.id} className="collection-item avatar">
                <i className="material-icons circle blue">chat_bubble_outline</i>
                <span className="title">Rating: {feedback.rating} - <b>{feedback.created_at}</b> </span>
                <p style={{padding:'0'}}>{feedback.comment}</p>
                <a href={feedback.delete_url} className="secondary-content"
                           onClick={DataUtil.handleDeleteDataFromServer.bind(this, feedback.delete_url,"Are you sure you want to delete this feedback?")}>
                <i className=" blue-text material-icons">delete_forever</i>
                </a>
              </li>
            );
          }, this)}
        </ul>
    );
  }
}

Feedback.displayName = "Feedback";
Feedback.propTypes = {
  feedbacks: React.PropTypes.array.isRequired
}
