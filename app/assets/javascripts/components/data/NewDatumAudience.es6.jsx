class NewDatumAudience extends React.Component {
  constructor (props) {
    super(props);
    this.state =  {
      loading: true,
      audiences: [],
      pollInterval: this.props.pollInterval || 2000,
      intervalId: 0
    };
  }

  componentDidMount() {
    DataUtil.handleCustomLoadDataFromServer.bind(this,this.props.audiencesUrl+".json",function(data){
      this.setState({
        loading: false,
        audiences: data
      });
    }.bind(this));
    // this.handleLoadDataFromServer();
    this.interval = setInterval(
      DataUtil.handleCustomLoadDataFromServer.bind(this,this.props.audiencesUrl+".json",function(data){
        this.setState({
          loading: false,
          audiences: data
        });
      }.bind(this)),
      this.state.pollInterval
    );
  }

  componentDidUpdate(prevProps, prevState) {
    var check = JSON.stringify(prevState) === JSON.stringify(this.state);
    if(!check || this.state.data == []){
      $('select').material_select();
      var postUrl = this.props.createDatumAudienceUrl;
      $('#datumAudienceForm').unbind('submit').on('submit',function(e){
        e.preventDefault();
        DataUtil.handlePostToServer(postUrl,$(this).serialize(),'Assigning Audience to Media. Please wait...',e);
        $('#datumAudienceForm')[0].reset();
      });
    }
  }

  componentWillUnmount() {
    clearInterval(this.interval);
  }

  render () {
    if(this.state.loading){
      return <BlankLoading />;
    }else
    return (
      <div>
        <div>
          <form id="datumAudienceForm">
            <input value={this.props.datumID} type="hidden" name="data_audience[datum_id]" />
            <div className="row">
              <div className="input-field col s12">
                <select name="data_audience[audience_id]">
                  {this.state.audiences.map(function(audience) {
                    return (
                      <option value={audience.id} key={audience.id} >{audience.data}</option>
                    );
                  }, this)}
                </select>
              </div>
            </div>
            <button title="Add Audience to media" className="btn-floating btn-large waves-effect waves-light blue right"
              type="submit" name="action">
              <i className="material-icons">add</i>
            </button>
          </form>
        </div>
      </div>
    );
  }
}

NewDatumAudience.displayName = "NewDatumAudience";
NewDatumAudience.propTypes = {
  datumID: React.PropTypes.number.isRequired,
  audiencesUrl: React.PropTypes.string.isRequired,
  createDatumAudienceUrl: React.PropTypes.string.isRequired,
  pollInterval: React.PropTypes.number
}
