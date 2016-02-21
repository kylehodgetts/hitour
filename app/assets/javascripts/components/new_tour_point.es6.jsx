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
      console.log($(this).serialize());
      $.ajax({
        url: postUrl,
        type: "POST",
        data: $(this).serialize(),
        dataType: "json",
        success: function(data){
          Materialize.toast(data, 3000, 'rounded');
          console.log("Successfully added point " + data);
        }.bind(this),
        error: function(err){
          Materialize.toast('There was an issue adding the point. Please contact admin.', 3000, 'rounded');
          console.log(err);
        }.bind(this)
      });
    });
  }

  componentWillUnmount() {
    clearInterval(this.interval);
  }

  handleLoadDataFromServer() {
    $.ajax({
      url: this.props.points_url,
      type: "GET",
      dataType: "json",
      cache: false,
      success: function(data){
        $('select').material_select();
        console.log("POINTS DATA");
        console.log(data);
        this.setState({
          points: data
        });
      }.bind(this)
    });
  }

  render () {
    return (
      <div>
        <div className="card">
          <span className="card-title">Add Points</span>
          <form id="tourPointForm" className="card-content">
            <input value={this.props.tour_id} className="active" type="hidden" name="tour_point[tour_id]" />
            <div className="row">
              <div className="input-field col s12">
                <select name="tour_point[point_id]">
                  {this.state.points.map(function(point) {
                    return (
                      <option value={point.id} key={point.id}>{point.data}</option>
                    );
                  }, this)}
                </select>
                <label>Point Name</label>
              </div>
            </div>
            <div className="row">
              <div className="input-field col s12">
                <p className="range-field">
                  Rank<input type="range" name="tour_point[rank]" min="0" max="50"/>
                </p>
              </div>
            </div>
            <button className="btn right blue waves-effect waves-light"
                    type="submit" name="action">Submit
              <i className="material-icons right">send</i>
            </button>
          </form>
        </div>
      </div>
    );
  }
}

NewTourPoint.displayName = "NewTourPoint";
NewTourPoint.propTypes = {
  new_tour_point_url:React.PropTypes.string.isRequired,
  points_url: React.PropTypes.string.isRequired
}
