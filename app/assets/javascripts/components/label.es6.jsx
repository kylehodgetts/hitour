class Label extends React.Component {
  render () {
    return (
      <div id="label">
        <div>Label: {this.props.label}</div>
      </div>
    );
  }
}

Label.propTypes = {
  label: React.PropTypes.string
};
