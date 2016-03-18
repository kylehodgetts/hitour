class NewTourPoint extends React.Component {
  constructor (props) {
    super(props);
    this.state =  {
      points: [],
      pollInterval: this.props.pollInterval || 2000,
      intervalId: 0
    };
  }

  componentDidMount() {
    DataUtil.handleCustomLoadDataFromServer.bind(this,this.props.points_url,function(data){
      this.setState({
        points: data
      });
    }.bind(this));
    this.interval = setInterval(
      DataUtil.handleCustomLoadDataFromServer.bind(this,this.props.points_url,function(data){
        this.setState({
          points: data
        });
      }.bind(this)),
      this.state.pollInterval
    );
    var postUrl = this.props.new_tour_point_url;
    $('#tourPointForm').on('submit',function(e){
      DataUtil.handlePostToServer(postUrl,$(this).serialize(),'Adding Point to Tour. Please wait...',e);
    });
  }

  componentDidUpdate(prevProps, prevState) {
    var check = JSON.stringify(prevState) === JSON.stringify(this.state);
    if(!check || this.state.data == []){
      $('.materialSelect').material_select();
    }
  }

  componentWillUnmount() {
    clearInterval(this.interval);
  }

  render () {
    return (
      <div className="col s6">
        <div className="card-panel">
            <div className="row">
              <form id="tourPointForm" className="col s12">
                <h4>Add a Point</h4>
                <input value={this.props.tour_id} type="hidden" name="tour_point[tour_id]" />
                <div className="row">
                  <div className="input-field col s12">
                    <select name="tour_point[point_id]" className="materialSelect">
                      {this.state.points.map(function(point) {
                        return (
                          <option value={point.id} key={point.id} >{point.data}</option>
                        );
                      }, this)}
                    </select>
                    <label>Point Name</label>
                  </div>
                </div>
                <button title="Add Point to tour" className="btn-floating btn-large waves-effect waves-light blue right"
                  type="submit" name="action">
                  <i className="material-icons">add</i>
                </button>
              </form>
            </div>
        </div>
      </div>
    );
  }
}

NewTourPoint.displayName = "NewTourPoint";
NewTourPoint.propTypes = {
  new_tour_point_url:React.PropTypes.string.isRequired,
  points_url: React.PropTypes.string.isRequired,
  pollInterval: React.PropTypes.number,
  tour_id: React.PropTypes.number.isRequired
}
