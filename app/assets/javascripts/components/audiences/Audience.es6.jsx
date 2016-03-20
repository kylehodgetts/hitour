class Audience extends React.Component {
  render () {
    return (
      <div>
        <h2>Audiences</h2>
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

Audience.displayName = 'Audience';
Audience.propTypes = {
  getUrl: React.PropTypes.string.isRequired,
  postUrl: React.PropTypes.string.isRequired
}
