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
    var postUrl = this.props.postUrl;
    var newKey = this.props.attributeName;
    var newValue = document.getElementById(newKey).value;
    var formData = {};
    formData[newKey] = newValue;
    DataUtil.handleUpdateDataToServer(postUrl, formData, 'Updating Record...', function(data) {
      //If Contains Error - Set NewValue to old value
      if(data[0].indexOf('Error') >= 0) {
        newValue = this.state.value;
      }
      this.setState({ editing: false, value: newValue });
    }.bind(this));
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

GenericEdit.displayName = 'GenericEdit';
GenericEdit.propTypes = {
  value: React.PropTypes.string.isRequired,
  postUrl: React.PropTypes.string.isRequired,
  fontSize: React.PropTypes.string,
  attributeName: React.PropTypes.string.isRequired
}
