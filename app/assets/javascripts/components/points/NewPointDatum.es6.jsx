class NewPointDatum extends React.Component {
  constructor (props) {
    super(props);
    this.state =  {
      loading: true,
      data: [],
      pollInterval: this.props.pollInterval || 2000,
      intervalId: 0
    };
  }

  componentDidMount() {
    this.mounted = true;
    DataUtil.handleLoadDataFromServer.bind(this,this.props.data_url + '.json');
    this.interval = setInterval(
      DataUtil.handleLoadDataFromServer.bind(this,this.props.data_url + '.json'),
      this.state.pollInterval
    );
  }

  componentDidUpdate(prevProps, prevState) {
    var check = JSON.stringify(prevState) === JSON.stringify(this.state);
    if(!check || this.state.data == []){
      $('.pointDatumSelect').material_select();
      var postUrl = this.props.new_point_datum_url;
      $('#pointDatumForm').unbind('submit').on('submit',function(e){
        DataUtil.handlePostToServer(postUrl, $(this).serialize(),
                                    'Adding media to point. Please wait.', e);
      });
    }
  }

  componentWillUnmount() {
    this.mounted = false;
    clearInterval(this.interval);
  }

  render () {
    if(this.state.loading){
      return <BlankLoading />
    }
    return (
      <div>
        <div>
          <form id="pointDatumForm" className="card-content">
            <input value={this.props.point_id} type="hidden" name="point_datum[point_id]" />
            <div className="row">
              <div className="input-field col s12">
                <select name="point_datum[datum_id]" className="pointDatumSelect">
                  {this.state.data.map(function(datum) {
                    return (
                      <option value={datum.id} key={datum.id} >{datum.data}</option>
                    );
                  }, this)}
                </select>
                <label>Data Name</label>
              </div>
            </div>
            <div className="row">
              <button className="btn-floating btn-large waves-effect waves-light blue right"
                type="submit" name="action">
                <i className="material-icons">add</i>
              </button>
            </div>
          </form>
        </div>
      </div>
    );
  }
}

NewPointDatum.displayName = 'NewPointDatum';
NewPointDatum.propTypes = {
  new_point_datum_url:React.PropTypes.string.isRequired,
  data_url: React.PropTypes.string.isRequired,
  pollInterval: React.PropTypes.number,
  point_id: React.PropTypes.number.isRequired
}
