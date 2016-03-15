class SelectEdit extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      options: this.props.options,
      selected: this.props.selected,
      editing: false
    }
  }

  componentDidMount() {
    $(document).click(function(e) {
      if(this.state.editing) {
        if(!$('select').is(e.target)) {
          this.handlePost();
        }
      }
    }.bind(this));
  }

  componentDidUpdate(prevProps, prevState) {
    var check = JSON.stringify(prevState) === JSON.stringify(this.state);
    if(!check || this.state.options == []){
      $('.materialSelect').material_select();
    }
  }

  handleClick() {
    this.setState({
      editing: !this.state.editing
    });
  }

  handlePost() {
    var postUrl = this.props.postUrl;
    var newKey = this.props.attributeName;
    var elem = document.getElementById(newKey);
    var value = elem.options[elem.selectedIndex].value;
    var newValueId = elem.options[elem.selectedIndex].id;
    var formData = {};
    formData[newKey] = newValueId;
    DataUtil.handleUpdateDataToServer(postUrl,formData,'Updating Record. Please wait...',function(data){
      this.setState({
        selected: value,
        editing: false
      });
    }.bind(this));
  }

  renderEditableSelected() {
    return (
        <select
            className="materialSelect"
            id={this.props.attributeName}>
          {this.state.options.map(function(o) {
            return (
              <option id={o.id} value={o.name} key={o.id}>{o.name}</option>
            );
          })}
        </select>
    );
  }

  renderSetSelected() {
    return (
      <h5 onClick={this.handleClick.bind(this)}>{this.state.selected}</h5>
    );
  }

  render () {
    return (
      <div>
        {this.state.editing &&
          this.renderEditableSelected()
        }
        {!this.state.editing &&
          this.renderSetSelected()
        }
      </div>
    );
  }
}

SelectEdit.displayName = "SelectEdit";
SelectEdit.propTypes = {
  selected: React.PropTypes.string.isRequired,
  options: React.PropTypes.array.isRequired,
  postUrl: React.PropTypes.string.isRequired,
  attributeName: React.PropTypes.string.isRequired
};
