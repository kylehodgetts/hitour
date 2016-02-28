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
      $('select').material_select();
    }
  }

  handleClick() {
    this.setState({
      editing: !this.state.editing
    });
  }

  handlePost() {
    var postURL = this.props.postUrl;
    var newKey = this.props.attributeName;
    var elem = document.getElementById(newKey);
    var value = elem.options[elem.selectedIndex].value;
    var newValueId = elem.options[elem.selectedIndex].id;
    var formData = {};
    formData[newKey] = newValueId;
    $.ajax({
      url: postURL,
      type: "PATCH",
      data: formData,
      success: function(data){
        Materialize.toast(data, 3000, 'rounded');
        this.setState({
          selected: value,
          editing: false
        });
      }.bind(this),
      error: function(err){
        console.log(err);
        Materialize.toast('Error updating entry!', 3000, 'rounded');
      }
    });
  }

  renderEditableSelected() {
    return (
        <select
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
