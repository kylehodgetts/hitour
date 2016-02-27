class SelectEdit extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      options: this.props.options,
      selected: this.props.selected,
      editing: false
    }
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

  renderEditableSelected() {
    return (
        <select selected={this.state.selected}>
          {this.state.options.map(function(o) {
            return (
              <option value={o.name} key={o.id}>{o.name}</option>
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
