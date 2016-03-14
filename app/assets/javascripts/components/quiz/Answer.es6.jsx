class Answer extends React.Component{
  handleDeleteDataFromServer(deleteUrl, e) {
    e.preventDefault();
    if(confirm("Are you sure you wish to delete this record")) {
      $('.progress-message').text('Deleting Record. Please wait...');
      $('.progress-overlay').fadeIn(200);
      $.ajax({
        url: deleteUrl,
        type: "DELETE",
        success: function(data){
          $('.progress-overlay').fadeOut();
          Materialize.toast(data, 3000, 'rounded');
        }.bind(this),
        error: function(err){
          Materialize.toast('There was an issue deleting. Please contact admin.', 3000, 'rounded');
          console.log(err);
        }.bind(this)
      });
    }
  }

  render () {
    var _this = this;
    return (
      <div className="collection-item">
        {this.props.answer.value}
        <a id={this.props.answer.id} href="" className="secondary-content"
                     onClick={_this.handleDeleteDataFromServer.bind(this, this.props.answer.delete_url)}>
          <i className=" blue-text material-icons">delete_forever</i>
        </a>
        {this.props.answer.show_url &&
          <a id={this.props.answer.id} href={this.props.answer.show_url} className="secondary-content">
            <i className=" blue-text material-icons">launch</i>
          </a>
        }
      </div>
    );
  }
}

Answer.displayName = "Answer";
Answer.propTypes = {
  answer: React.PropTypes.object.isRequired
}
