class Demo extends React.Component {
  render () {
    return (
      <div>
        <div>Label: {this.props.label}</div>
      </div>
    );
  }
}

Demo.propTypes = {
  label: React.PropTypes.string
};
