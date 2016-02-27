class GenericEdit extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      editing: false,
      title: this.props.title
    }
  }

  handleClick() {
    this.setState({
      editing: !this.state.editing
    });
  }

  handleOnChange(event) {
    if (event.which == 13 || event.keyCode == 13) {
      event.preventDefault();
      console.log("SAVING");
      var postURL = this.props.postUrl;
      $.ajax({
        url: postURL,
        type: "PATCH",
        data: {
          name: document.getElementById("title[name]").value
        },
        success: function(data){
          Materialize.toast(data, 3000, 'rounded');
          this.setState({
            title: document.getElementById("title[name]").value,
            editing: false,
          });
        }.bind(this),
        error: function(err){
          console.log("Error" + err);
          Materialize.toast('Error updating entry!', 3000, 'rounded');
        }
      });
    }
  }

  renderSetTitle() {
    return (
      <span style={{fontSize: this.props.fontSize || '50px'}}
        onClick={this.handleClick.bind(this)}>
          {this.state.title}
      </span>
    );
  }

  renderEditableTitle() {
    return (
      <textarea name="title[name]" id="title[name]"
                className="materialize-textarea"
                defaultValue={this.state.title}
                onKeyPress={this.handleOnChange.bind(this)}
                style={{fontSize: this.props.fontSize || '50px'}}>
      </textarea>
    );
  }

  render () {
    return (
      <div>
        {this.state.editing &&
          this.renderEditableTitle()
        }
        {!this.state.editing &&
          this.renderSetTitle()
        }
      </div>
    );
  }
}

GenericEdit.displayName = "GenericEdit";
GenericEdit.propTypes = {
  title: React.PropTypes.string.isRequired,
  postUrl: React.PropTypes.string.isRequired,
  fontSize: React.PropTypes.string
}
