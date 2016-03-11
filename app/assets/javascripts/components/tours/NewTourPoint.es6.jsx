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
    this.handleLoadDataFromServer();
    this.interval = setInterval(
      this.handleLoadDataFromServer.bind(this),
      this.state.pollInterval
    );
    var postUrl = this.props.new_tour_point_url;
    $('#tourPointForm').on('submit',function(e){
      e.preventDefault();
      // Show Progress
      $('.progress-message').text('Adding Point to Tour. Please wait...');
      $('.progress-overlay').fadeIn(200);
      $.ajax({
        url: postUrl,
        type: "POST",
        data: $(this).serialize(),
        dataType: "json",
        success: function(data){
          $('.progress-overlay').fadeOut();
          Materialize.toast(data, 3000, 'rounded');
        }.bind(this),
        error: function(err){
          Materialize.toast(err, 3000, 'rounded');
          console.log(err);
        }.bind(this)
      });
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

  handleLoadDataFromServer() {
    //Get All Points
    $.ajax({
      url: this.props.points_url,
      type: "GET",
      dataType: "json",
      cache: false,
      success: function(data){
        this.setState({
          points: data
        });
      }.bind(this)
    });
  }

  render () {
    return (
      <div>
          <form id="tourPointForm" className="col s12">
            <p>Add a Point</p>
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
