class Audience extends React.Component {

  componentDidMount() {
    var postURL = this.props.postUrl;
    var _this = this;
    $('#audienceForm').on('submit',function(e){
      e.preventDefault();
      console.log("WICKED!!!");
      DataUtil.handlePostToServer(postURL,$(this).serialize(),'Creating Audience',e);
    });
  }

  render () {
    return (
      <div>
        <GenericList getUrl={this.props.getUrl} />
        <form id="audienceForm">
          <label htmlFor="audience[name]">Audience Name</label>
          <input type="text" name="audience[name]" />
          <button className="btn right blue waves-effect waves-light"
                  type="submit" name="action">Submit
            <i className="material-icons right">send</i>
          </button>
        </form>
      </div>
    );
  }
}

Audience.displayName = "Audience";
Audience.propTypes = {
  getUrl: React.PropTypes.string.isRequired,
  postUrl: React.PropTypes.string.isRequired
}
