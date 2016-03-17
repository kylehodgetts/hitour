class Audience extends React.Component {
  render () {
    return (
      <div>
        <GenericList getUrl={this.props.getUrl} />
        <SingleInputForm
          postUrl={this.props.postUrl}
          dataType="audience"
          attr="name"
          labelValue="Audience Name"
          />
      </div>
    );
  }
}

Audience.displayName = "Audience";
Audience.propTypes = {
  getUrl: React.PropTypes.string.isRequired,
  postUrl: React.PropTypes.string.isRequired
}
