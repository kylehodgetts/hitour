class NewPointDatum extends React.Component {
  constructor (props) {
    super(props);
    this.state =  {
      data: [],
      pollInterval: this.props.pollInterval || 2000,
      intervalId: 0
    };
  }

  componentDidMount() {
    DataUtil.handleLoadDataFromServer.bind(this,this.props.data_url+".json");
    this.interval = setInterval(
      DataUtil.handleLoadDataFromServer.bind(this,this.props.data_url+".json"),
      this.state.pollInterval
    );
    var postUrl = this.props.new_point_datum_url;
    $('#pointDatumForm').on('submit',function(e){
      DataUtil.handlePostToServer(postUrl,$(this).serialize(),'Adding media to point. Please wait.',e);
    });
  }

  componentDidUpdate(prevProps, prevState) {
    var check = JSON.stringify(prevState) === JSON.stringify(this.state);
    if(!check || this.state.data == []){
      $('select').material_select();
    }
  }

  componentWillUnmount() {
    clearInterval(this.interval);
  }

  render () {
    return (
      <div>
        <div>
          <form id="pointDatumForm" className="card-content">
            <input value={this.props.point_id} type="hidden" name="point_datum[point_id]" />
            <div className="row">
              <div className="input-field col s12">
                <select name="point_datum[datum_id]">
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

NewPointDatum.displayName = "NewPointDatum";
NewPointDatum.propTypes = {
  new_point_datum_url:React.PropTypes.string.isRequired,
  data_url: React.PropTypes.string.isRequired,
  pollInterval: React.PropTypes.number,
  point_id: React.PropTypes.number.isRequired
}
