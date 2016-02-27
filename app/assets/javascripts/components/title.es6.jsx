class Title extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      editing: false,
      title: this.props.mTitle
    }
  }

  handleClick() {
    this.setState({
      editing: !this.state.editing,
      title: this.props.mTitle
    });
    console.log("New State: " + this.state.editing);
  }

  handleOnChange(event) {
    if (event.which == 13 || event.keyCode == 13) {
      console.log("SAVING");
      this.setState({
        title: document.getElementById("title[name]").value,
        editing: false,
      });
    }
  }

  renderSetTitle() {
    return (
      <h2 onClick={this.handleClick.bind(this)}>{this.state.title}</h2>
    );
  }

  renderEditableTitle() {
    return (
      <input type="text" name="title[name]" id="title[name]"
             defaultValue={this.state.title}
             onKeyPress={this.handleOnChange.bind(this)}/>
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

Title.displayName = "Title";
Title.propTypes = {
  mTitle: React.PropTypes.string.isRequired
}
