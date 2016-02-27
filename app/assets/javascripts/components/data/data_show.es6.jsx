class DataShow extends React.Component {
  constructor (props) {
    super(props);
    this.state =  {
      datum: [],
      audiences: [],
      pollInterval: this.props.pollInterval || 2000,
      intervalId: 0
    };
  }

  componentDidMount() {
    this.handleLoadDataFromServer();
    this.interval = setInterval(
      this.handleLoadDataFromServer.bind(this),
      this.state.pollInterval
    );
  }

  componentWillUnmount() {
    this.interval && clearInterval(this.interval);
    this.interval = false;
  }

  handleLoadDataFromServer() {
    //Get All Information about datum
    $.ajax({
      url: this.props.getUrl,
      type: "GET",
      dataType: "json",
      cache: false,
      success: function(data){
        this.setState({
          datum: data["datum"],
          audiences: data["datum_audiences"]
        });
      }.bind(this)
    });
  }

  handleDeleteDataFromServer(deleteUrl, e) {
    e.preventDefault();
    $.ajax({
      url: deleteUrl,
      type: "DELETE",
      success: function(data){
        Materialize.toast(data, 3000, 'rounded');
      }.bind(this),
      error: function(err){
        Materialize.toast('There was an issue deleting. Please contact admin.', 3000, 'rounded');
        console.log(err);
      }.bind(this)
    });
  }

  render () {
    var _this = this;
    return (
      <div className="row">
        <div className="col s10 m8 offset-s1 offset-m2">
          <div className="card hoverable">
            <div className="card-image">
                {this.state.datum.url && <DataViewer url={this.state.datum.url} data_id={this.props.datumID} /> }
            </div>
            <div className="card-content">
              <span className="card-title activator grey-text text-darken-4">{this.state.datum.title}<i className="material-icons right">more_vert</i></span>
              <p>{this.state.datum.description}</p>
            </div>
            <div className="card-reveal">
              <span className="card-title grey-text text-darken-4">Audiences<i className="material-icons right">close</i></span>
              <div className="datum-audiences collection">
                {this.state.audiences.map(function(audience) {
                  return (
                    <div key={audience.id} className="collection-item">
                      <div>
                        {audience.data}
                        <a id={audience.id} href="" className="secondary-content" key={audience.id}
                                     onClick={_this.handleDeleteDataFromServer.bind(this, audience.delete_url)}>
                          <i className=" blue-text material-icons">delete_forever</i>
                        </a>
                      </div>
                    </div>
                  );
                }, this)}
              </div>
              <NewDatumAudience datumID={this.props.datumID} createDatumAudienceUrl={this.props.createDatumAudienceUrl} audiencesUrl={this.props.audiencesUrl} />
            </div>
          </div>
        </div>
      </div>

	);
  }
}

DataShow.displayName = "DataShow";
DataShow.propTypes = {
  pollInterval: React.PropTypes.number,
  getUrl: React.PropTypes.string.isRequired,
  audiencesUrl: React.PropTypes.string.isRequired,
  createDatumAudienceUrl: React.PropTypes.string.isRequired,
  datumID: React.PropTypes.number.isRequired
};
