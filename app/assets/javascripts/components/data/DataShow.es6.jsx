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
    // this.handleLoadDataFromServer();
    var _this = this;
    DataUtil.handleCustomLoadDataFromServer.bind(this,this.props.getUrl+".json",function(data){
      this.setState({
        datum: data["datum"],
        audiences: data["datum_audiences"]
      });
    }.bind(this));
    this.interval = setInterval(
      DataUtil.handleCustomLoadDataFromServer.bind(this,this.props.getUrl+".json",function(data){
        this.setState({
          datum: data["datum"],
          audiences: data["datum_audiences"]
        });
      }.bind(this)),
      this.state.pollInterval
    );
  }

  componentWillUnmount() {
    this.interval && clearInterval(this.interval);
    this.interval = false;
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
              <span className="card-title activator grey-text text-darken-4">
                {this.state.datum.title &&
                  <GenericEdit value={this.state.datum.title}
                               postUrl={this.props.update_datum_url}
                               attributeName="datum[title]"
                               fontSize="20px"/>
                }
                <i className="material-icons right">more_vert</i>
              </span>
              {this.state.datum.description &&
                <GenericEdit value={this.state.datum.description}
                             postUrl={this.props.update_datum_url}
                             attributeName="datum[description]"
                             fontSize="15px"/>
              }
            </div>
            <div className="card-reveal">
              <span className="card-title grey-text text-darken-4">Audiences<i className="material-icons right">close</i></span>
              <div className="datum-audiences collection">
                {this.state.audiences.map(function(audience) {
                  return (
                    <div key={audience.id} className="collection-item grey lighten-5">
                      <div>
                        {audience.data}
                        <a id={audience.id} href="" className="secondary-content" key={audience.id}
                                     onClick={DataUtil.handleDeleteDataFromServer.bind(this, audience.delete_url,"Are you sure you want to delete this audience?")}>
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
  update_datum_url: React.PropTypes.string.isRequired,
  audiencesUrl: React.PropTypes.string.isRequired,
  createDatumAudienceUrl: React.PropTypes.string.isRequired,
  datumID: React.PropTypes.number.isRequired
};
