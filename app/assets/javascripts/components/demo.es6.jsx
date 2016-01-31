class Demo extends React.Component {
  static displayName = "Demo";
  static propTypes = {
    label: React.PropTypes.string
  };
  render () {
    return (
      <div>
        <div>Label: {this.props.label}</div>
      </div>
    );
  }
}
