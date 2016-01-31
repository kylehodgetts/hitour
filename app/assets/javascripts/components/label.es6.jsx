class Label extends React.Component {
  static displayName = "Label";
  static propTypes = {
    label: React.PropTypes.string
  };
  render () {
    return (
      <div id="label">
        <div>Label: {this.props.label}</div>
      </div>
    );
  }
}
