class GenericEdit extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      editing: false,
      value: this.props.value
    }
  }

  componentDidMount() {
    $(document).click(function(e) {
      if(this.state.editing) {
        if(!$('textarea').is(e.target)) {
          this.handlePost();
        }
      }
    }.bind(this));
  }

  handleClick() {
    this.setState({
      editing: !this.state.editing
    });
  }

  handleOnChange(e) {
    if (e.which == 13 || e.keyCode == 13) {
      e.preventDefault();
      this.handlePost();
    }
  }

  handlePost() {
    var postURL = this.props.postUrl;
    var newKey = this.props.attributeName;
    var newValue = document.getElementById(newKey).value;
    var formData = {};
    formData[newKey] = newValue;
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
