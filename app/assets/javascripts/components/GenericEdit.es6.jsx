class GenericEdit extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      editing: false,
      value: this.props.value
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
      var newKey = this.props.attributeName;
      var newValue = document.getElementById(newKey).value;
      var formData = new FormData();
      formData.append(newKey, newValue);
      $.ajax({
        url: postURL,
        type: "PATCH",
        data: formData,
        success: function(data){
          Materialize.toast(data, 3000, 'rounded');
          this.setState({
            value: newValue,
            editing: false
          });
        }.bind(this),
        error: function(err){
          console.log(err);
          Materialize.toast('Error updating entry!', 3000, 'rounded');
        }
      });
    }
  }

  renderSetTitle() {
    return (
      <span style={{fontSize: this.props.fontSize || '50px'}}
        onClick={this.handleClick.bind(this)}>
          {this.state.value}
      </span>
    );
  }

  renderEditableTitle() {
    return (
      <textarea name={this.props.attributeName}
                id={this.props.attributeName}
                className="materialize-textarea"
                defaultValue={this.state.value}
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
  value: React.PropTypes.string.isRequired,
  postUrl: React.PropTypes.string.isRequired,
  fontSize: React.PropTypes.string,
  attributeName: React.PropTypes.string.isRequired
}
